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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import org.adempiere.webui.Extensions;
import org.compiere.model.MRole;
import org.compiere.print.MPrintFormat;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.TestActivator;
import org.idempiere.ui.zk.report.ComboboxReportFormatSelector;
import org.idempiere.ui.zk.report.IReportFormatSelector;
import org.idempiere.ui.zk.report.IReportFormatSelectorFactory;
import org.idempiere.ui.zk.report.ReportFormatEntry;
import org.idempiere.ui.zk.report.ReportFormatLoader;
import org.idempiere.ui.zk.report.ReportFormatRequest;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.zkoss.zk.ui.WebApps;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceRegistration;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Combobox;

/**
 * Test cases for the report viewer format selector: role checks in {@link ReportFormatLoader},
 * the default {@link ComboboxReportFormatSelector} and selection of a factory by service ranking.
 */
@Isolated
public class ReportFormatSelectorTest extends AbstractTestCase {

	private MockedStatic<WebApps> webApps;

	@BeforeEach
	public void setUpWebApp() {
		webApps = ZkWebAppMock.install();
	}

	@AfterEach
	public void tearDownWebApp() {
		webApps.close();
	}

	/** Role that sees every print format and may create new ones */
	private MRole allowAllRole() {
		MRole role = mock(MRole.class);
		when(role.addAccessSQL(anyString(), anyString(), anyBoolean(), anyBoolean()))
				.thenAnswer(invocation -> invocation.getArgument(0));
		when(role.isTableAccess(anyInt(), anyBoolean())).thenReturn(true);
		when(role.getWindowAccess(anyInt())).thenReturn(Boolean.TRUE);
		return role;
	}

	private MPrintFormat currentFormat() {
		int id = DB.getSQLValue(null, "SELECT MIN(AD_PrintFormat_ID) FROM AD_PrintFormat WHERE IsActive='Y' AND AD_Client_ID IN (0,?)",
				getAD_Client_ID());
		assertTrue(id > 0, "needs an active print format");
		return MPrintFormat.get(Env.getCtx(), id, false);
	}

	@Test
	public void testRoleWithAllAccessGetsFormatsAndCreateActions() {
		MPrintFormat current = currentFormat();
		List<ReportFormatEntry> entries = ReportFormatLoader.load(allowAllRole(), current, 0, current.get_ID(), true);

		assertTrue(entries.stream().anyMatch(e -> e.key() == current.get_ID() && e.isFormat()));
		int size = entries.size();
		assertEquals(ReportFormatEntry.KEY_NEW, entries.get(size - 2).key());
		assertEquals(ReportFormatEntry.Kind.NEW, entries.get(size - 2).kind());
		assertEquals(ReportFormatEntry.KEY_COPY, entries.get(size - 1).key());
		assertEquals(ReportFormatEntry.Kind.COPY, entries.get(size - 1).kind());
		assertTrue(entries.stream().limit(size - 2).allMatch(ReportFormatEntry::isFormat));
	}

	@Test
	public void testRoleWithoutTableAccessGetsNoCreateActions() {
		MRole role = allowAllRole();
		when(role.isTableAccess(anyInt(), anyBoolean())).thenReturn(false);
		MPrintFormat current = currentFormat();

		List<ReportFormatEntry> entries = ReportFormatLoader.load(role, current, 0, current.get_ID(), true);

		assertFalse(entries.isEmpty());
		assertTrue(entries.stream().allMatch(ReportFormatEntry::isFormat));
	}

	@Test
	public void testRoleWithoutWindowAccessGetsNoCreateActions() {
		MRole role = allowAllRole();
		when(role.getWindowAccess(anyInt())).thenReturn(null);
		MPrintFormat current = currentFormat();
		assertTrue(ReportFormatLoader.load(role, current, 0, current.get_ID(), true).stream().allMatch(ReportFormatEntry::isFormat));

		when(role.getWindowAccess(anyInt())).thenReturn(Boolean.FALSE);
		assertTrue(ReportFormatLoader.load(role, current, 0, current.get_ID(), true).stream().allMatch(ReportFormatEntry::isFormat));
	}

	@Test
	public void testFormatsComeFromRoleAccessSql() {
		MRole role = allowAllRole();
		when(role.addAccessSQL(anyString(), anyString(), anyBoolean(), anyBoolean()))
				.thenAnswer(invocation -> ((String) invocation.getArgument(0)).replace(" ORDER BY", " AND 1=0 ORDER BY"));
		MPrintFormat current = currentFormat();

		List<ReportFormatEntry> entries = ReportFormatLoader.load(role, current, 0, current.get_ID(), true);

		// the role sees no print format but may still create one
		assertEquals(List.of(ReportFormatEntry.KEY_NEW, ReportFormatEntry.KEY_COPY),
				entries.stream().map(ReportFormatEntry::key).toList());
	}

	@Test
	public void testReportViewFilterIsAppliedOnlyWhenRequested() {
		int reportViewId = DB.getSQLValue(null, "SELECT MIN(AD_PrintFormat_ID) FROM AD_PrintFormat WHERE AD_ReportView_ID>0 AND IsActive='Y' AND AD_Client_ID IN (0,?)",
				getAD_Client_ID());
		assertTrue(reportViewId > 0, "Garden World needs a print format of a report view");
		MPrintFormat current = MPrintFormat.get(Env.getCtx(), reportViewId, false);
		List<String> sql = new ArrayList<>();
		MRole role = allowAllRole();
		when(role.addAccessSQL(anyString(), anyString(), anyBoolean(), anyBoolean())).thenAnswer(invocation -> {
			sql.add(invocation.getArgument(0));
			return invocation.getArgument(0);
		});

		ReportFormatLoader.load(role, current, 0, current.get_ID(), true);
		ReportFormatLoader.load(role, current, 0, current.get_ID(), false);

		assertTrue(sql.get(0).contains("AD_ReportView_ID"));
		assertFalse(sql.get(1).contains("AD_ReportView_ID"));
	}

	@Test
	public void testSelectorIsLimitedToReportViewByDefault() {
		assertTrue(new ComboboxReportFormatSelector().isLimitedToReportView());
	}

	@Test
	public void testEntryListIsImmutable() {
		MPrintFormat current = currentFormat();
		List<ReportFormatEntry> entries = ReportFormatLoader.load(allowAllRole(), current, 0, current.get_ID(), true);
		assertThrows(UnsupportedOperationException.class,
				() -> entries.add(new ReportFormatEntry(1, "x", 0, ReportFormatEntry.Kind.FORMAT)));
	}

	@Test
	public void testDefaultSelectorSelectsByKey() {
		ComboboxReportFormatSelector selector = new ComboboxReportFormatSelector();
		assertFalse(((Combobox) selector.getComponent()).isReadonly());
		selector.setFormats(List.of(entry(10, "A"), entry(20, "B"), entry(ReportFormatEntry.KEY_NEW, "New")), 20);

		assertEquals(20, selector.getSelectedKey());
		selector.setSelectedKey(10);
		assertEquals(10, selector.getSelectedKey());
		selector.setSelectedKey(ReportFormatEntry.KEY_NEW);
		assertEquals(ReportFormatEntry.KEY_NEW, selector.getSelectedKey());
		selector.setSelectedKey(999);
		assertEquals(ReportFormatEntry.KEY_NONE, selector.getSelectedKey());
	}

	@Test
	public void testDefaultSelectorHandlesEmptyList() {
		ComboboxReportFormatSelector selector = new ComboboxReportFormatSelector();
		selector.setFormats(List.of(entry(10, "A")), 10);
		selector.setFormats(List.of(), 10);

		assertEquals(0, ((Combobox) selector.getComponent()).getItemCount());
		assertEquals(ReportFormatEntry.KEY_NONE, selector.getSelectedKey());
	}

	@Test
	public void testDefaultSelectorNotifiesOnlyOnUserPick() throws Exception {
		ComboboxReportFormatSelector selector = new ComboboxReportFormatSelector();
		AtomicInteger picks = new AtomicInteger();
		selector.setSelectionListener(picks::incrementAndGet);
		selector.setFormats(List.of(entry(10, "A"), entry(20, "B")), 10);
		selector.setSelectedKey(20);
		assertEquals(0, picks.get());

		fireSelect(selector);
		assertEquals(1, picks.get());

		selector.setSelectionListener(null);
		fireSelect(selector);
		assertEquals(1, picks.get());
	}

	@Test
	public void testHigherRankingFactoryWins() {
		IReportFormatSelector high = new ComboboxReportFormatSelector();
		IReportFormatSelector low = new ComboboxReportFormatSelector();
		ServiceRegistration<IReportFormatSelectorFactory> lowRegistration = register(request -> low, 1000);
		ServiceRegistration<IReportFormatSelectorFactory> highRegistration = register(request -> high, 2000);
		try {
			assertSame(high, Extensions.getReportFormatSelector(request()));
		} finally {
			highRegistration.unregister();
			lowRegistration.unregister();
		}
	}

	@Test
	public void testDecliningFactoryFallsThrough() {
		IReportFormatSelector fallback = new ComboboxReportFormatSelector();
		ServiceRegistration<IReportFormatSelectorFactory> decline = register(request -> null, 2000);
		ServiceRegistration<IReportFormatSelectorFactory> accept = register(request -> fallback, 1000);
		try {
			IReportFormatSelector selector = Extensions.getReportFormatSelector(request());
			assertNotNull(selector);
			assertSame(fallback, selector);
		} finally {
			accept.unregister();
			decline.unregister();
		}
	}

	@SuppressWarnings("unchecked")
	private void fireSelect(IReportFormatSelector selector) throws Exception {
		Event event = new Event(Events.ON_SELECT, selector.getComponent());
		for (EventListener<? extends Event> listener : selector.getComponent().getEventListeners(Events.ON_SELECT))
			((EventListener<Event>) listener).onEvent(event);
	}

	private ReportFormatRequest request() {
		return new ReportFormatRequest(null, 0, false);
	}

	private ReportFormatEntry entry(int key, String name) {
		return new ReportFormatEntry(key, name, 0, key > 0 ? ReportFormatEntry.Kind.FORMAT : ReportFormatEntry.Kind.NEW);
	}

	private ServiceRegistration<IReportFormatSelectorFactory> register(IReportFormatSelectorFactory factory, int ranking) {
		Dictionary<String, Object> properties = new Hashtable<>();
		properties.put(Constants.SERVICE_RANKING, ranking);
		return TestActivator.context.registerService(IReportFormatSelectorFactory.class, factory, properties);
	}
}
