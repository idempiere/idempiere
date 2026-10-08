/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.idempiere.test.ui;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.concurrent.atomic.AtomicInteger;

import org.idempiere.test.AbstractTestCase;
import org.idempiere.ui.zk.report.ReportFormatEntry;
import org.idempiere.ui.zk.report.sample.RoleGroupedReportFormatSelector;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.zkoss.zk.ui.WebApps;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Label;

/**
 * Test cases for the sample {@link RoleGroupedReportFormatSelector}
 */
@Isolated
public class RoleGroupedReportFormatSelectorTest extends AbstractTestCase {

	private MockedStatic<WebApps> webApps;

	@BeforeEach
	public void setUpWebApp() {
		webApps = ZkWebAppMock.install();
	}

	@AfterEach
	public void tearDownWebApp() {
		webApps.close();
	}

	private final List<ReportFormatEntry> entries = List.of(
			new ReportFormatEntry(10, "Detail", 0, ReportFormatEntry.Kind.FORMAT),
			new ReportFormatEntry(20, "Standard", 0, ReportFormatEntry.Kind.FORMAT),
			new ReportFormatEntry(30, "Margin", 11, ReportFormatEntry.Kind.FORMAT),
			new ReportFormatEntry(ReportFormatEntry.KEY_NEW, "New", 0, ReportFormatEntry.Kind.NEW),
			new ReportFormatEntry(ReportFormatEntry.KEY_COPY, "Copy", 0, ReportFormatEntry.Kind.COPY));

	private RoleGroupedReportFormatSelector selector() {
		RoleGroupedReportFormatSelector selector = new RoleGroupedReportFormatSelector("Sales Manager", Set.of(20, 30),
				key -> key == 20 ? "Compact order with totals" : null);
		selector.setFormats(entries, 20);
		return selector;
	}

	private List<Component> collect(Component parent, String sclass) {
		List<Component> found = new ArrayList<>();
		for (Component child : parent.getChildren()) {
			if (child instanceof org.zkoss.zk.ui.HtmlBasedComponent html && html.getSclass() != null
					&& Arrays.asList(html.getSclass().split(" ")).contains(sclass))
				found.add(child);
			found.addAll(collect(child, sclass));
		}
		return found;
	}

	private List<String> labels(List<Component> components) {
		return components.stream().map(c -> c instanceof Label l ? l.getValue() : ((Label) firstLabel(c)).getValue()).toList();
	}

	private Component firstLabel(Component parent) {
		for (Component child : parent.getChildren()) {
			if (child instanceof Label && !"##".equals(((Label) child).getValue()))
				return child;
			Component found = firstLabel(child);
			if (found != null)
				return found;
		}
		return null;
	}

	@Test
	public void testGroupsRoleFormatsFirstAndActionsInFooter() {
		RoleGroupedReportFormatSelector selector = selector();

		assertEquals("Sales Manager", labels(collect(selector.getComponent(), "report-format-group")).get(0));
		assertEquals(2, collect(selector.getComponent(), "report-format-group").size());
		assertEquals(List.of("Margin", "Standard", "Detail"), labels(collect(selector.getComponent(), "report-format-row")));
		assertEquals(List.of("New", "Copy"), labels(collect(selector.getComponent(), "report-format-action")));
	}

	@Test
	public void testDescriptionIsShownUnderTheName() {
		RoleGroupedReportFormatSelector selector = selector();
		Component standard = collect(selector.getComponent(), "report-format-row").get(1);

		assertTrue(containsLabel(standard, "Compact order with totals"));
	}

	private boolean containsLabel(Component parent, String text) {
		for (Component child : parent.getChildren()) {
			if (child instanceof Label l && text.equals(l.getValue()))
				return true;
			if (containsLabel(child, text))
				return true;
		}
		return false;
	}

	@Test
	public void testClickSelectsAndNotifies() throws Exception {
		RoleGroupedReportFormatSelector selector = selector();
		AtomicInteger picks = new AtomicInteger();
		selector.setSelectionListener(picks::incrementAndGet);
		selector.setSelectedKey(10);
		assertEquals(0, picks.get());

		click(collect(selector.getComponent(), "report-format-row").get(0));
		assertEquals(30, selector.getSelectedKey());
		assertEquals(1, picks.get());

		click(collect(selector.getComponent(), "report-format-action").get(0));
		assertEquals(ReportFormatEntry.KEY_NEW, selector.getSelectedKey());
		assertEquals(2, picks.get());
	}

	@Test
	public void testUnknownKeyAndReportViewScope() {
		RoleGroupedReportFormatSelector selector = selector();
		selector.setSelectedKey(999);
		assertEquals(ReportFormatEntry.KEY_NONE, selector.getSelectedKey());
		assertFalse(selector.isLimitedToReportView());
	}

	@SuppressWarnings("unchecked")
	private void click(Component component) throws Exception {
		Event event = new Event(Events.ON_CLICK, component);
		for (EventListener<? extends Event> listener : component.getEventListeners(Events.ON_CLICK))
			((EventListener<Event>) listener).onEvent(event);
	}
}
