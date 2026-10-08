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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import org.compiere.model.MClient;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.ui.zk.report.ReportFormatEntry;
import org.idempiere.ui.zk.report.sample.GroupedReportFormatSelector;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.zkoss.zk.ui.WebApps;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Combobox;
import org.zkoss.zul.Comboitem;

/**
 * Test cases for the sample {@link GroupedReportFormatSelector}
 */
@Isolated
public class GroupedReportFormatSelectorTest extends AbstractTestCase {

	private MockedStatic<WebApps> webApps;

	@BeforeEach
	public void setUpWebApp() {
		webApps = ZkWebAppMock.install();
	}

	@AfterEach
	public void tearDownWebApp() {
		webApps.close();
	}

	private static ReportFormatEntry format(int key, String name, int clientId) {
		return new ReportFormatEntry(key, name, clientId, ReportFormatEntry.Kind.FORMAT);
	}

	private final List<ReportFormatEntry> entries = List.of(
			format(20, "Order", 0),
			format(30, "Client layout", 11),
			format(10, "Detail", 0),
			new ReportFormatEntry(ReportFormatEntry.KEY_NEW, "New", 0, ReportFormatEntry.Kind.NEW));

	private Combobox combobox(GroupedReportFormatSelector selector) {
		return (Combobox) selector.getComponent();
	}

	@Test
	public void testClientGroupComesBeforeSystemGroupAndCreateActionsLast() {
		GroupedReportFormatSelector selector = new GroupedReportFormatSelector(key -> key == 20 ? "Totals only" : null);
		selector.setFormats(entries, 20);

		List<String> labels = combobox(selector).getItems().stream().map(Comboitem::getLabel).toList();
		String clientName = MClient.get(Env.getCtx(), 11).getName();
		String systemName = MClient.get(Env.getCtx(), 0).getName();
		assertEquals(List.of(clientName, "Client layout", systemName, "Detail", "Order", "New"), labels);
		assertEquals("Totals only", combobox(selector).getItems().get(4).getDescription());
	}

	@Test
	public void testGroupHeadersAreDisabled() {
		GroupedReportFormatSelector selector = new GroupedReportFormatSelector(key -> null);
		selector.setFormats(entries, 20);

		List<Comboitem> items = combobox(selector).getItems();
		assertTrue(items.get(0).isDisabled());
		assertTrue(items.get(2).isDisabled());
		assertFalse(items.get(1).isDisabled());
		assertNull(items.get(0).getValue());
	}

	@Test
	public void testSelectionByKeyAndUnknownKey() {
		GroupedReportFormatSelector selector = new GroupedReportFormatSelector(key -> null);
		selector.setFormats(entries, 20);
		assertEquals(20, selector.getSelectedKey());
		selector.setSelectedKey(30);
		assertEquals(30, selector.getSelectedKey());
		selector.setSelectedKey(999);
		assertEquals(ReportFormatEntry.KEY_NONE, selector.getSelectedKey());
	}

	@Test
	public void testPickSelectsAndNotifies() throws Exception {
		GroupedReportFormatSelector selector = new GroupedReportFormatSelector(key -> null);
		AtomicInteger picks = new AtomicInteger();
		selector.setSelectionListener(picks::incrementAndGet);
		selector.setFormats(entries, 20);
		selector.setSelectedKey(10);
		assertEquals(0, picks.get());

		combobox(selector).setSelectedItem(combobox(selector).getItems().get(1));
		fireSelect(combobox(selector));

		assertEquals(30, selector.getSelectedKey());
		assertEquals(1, picks.get());
	}

	@Test
	public void testEmptyListAndReportViewScope() {
		GroupedReportFormatSelector selector = new GroupedReportFormatSelector(key -> null);
		selector.setFormats(List.of(), 20);
		assertEquals(ReportFormatEntry.KEY_NONE, selector.getSelectedKey());
		assertEquals(0, combobox(selector).getItemCount());
		assertFalse(selector.isLimitedToReportView());
	}

	@SuppressWarnings("unchecked")
	private void fireSelect(Combobox combobox) throws Exception {
		Event event = new Event(Events.ON_SELECT, combobox);
		for (EventListener<? extends Event> listener : combobox.getEventListeners(Events.ON_SELECT))
			((EventListener<Event>) listener).onEvent(event);
	}
}
