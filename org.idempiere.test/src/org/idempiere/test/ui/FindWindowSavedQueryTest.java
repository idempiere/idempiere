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

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.withSettings;

import java.util.UUID;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ComboItem;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.Dialog;
import org.adempiere.webui.window.FindWindow;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.GridWindowVO;
import org.compiere.model.MUserQuery;
import org.compiere.model.SystemIDs;
import org.compiere.util.Env;
import org.compiere.util.ValueNamePair;
import org.idempiere.db.util.SQLFragment;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.WebApp;
import org.zkoss.zk.ui.WebApps;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.sys.IdGenerator;
import org.zkoss.zk.ui.sys.WebAppCtrl;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zk.ui.util.Configuration;

/**
 * Tests applying saved user queries (AD_UserQuery) in {@link FindWindow} on the Sales Order window.
 * <p>
 * Covers queries whose table segment matches none of the tabs of the FindWindow, for example a number saved by
 * older versions instead of an AD_Tab_UU, and a FindWindow that was left pointing at a child tab.
 */
@Isolated
public class FindWindowSavedQueryTest extends AbstractTestCase {

	private static final int WINDOW_NO = 1;
	private static final int AD_TAB_ID_ORDER = 186;
	private static final int AD_TAB_ID_ORDER_LINE = 187;
	/** C_DocType_ID is not read while parsing, any value will do */
	private static final String DOCTYPE_VALUE = "135";

	private MockedStatic<SessionManager> sessionManagerMock;
	private MockedStatic<Events> eventsMock;
	private MockedStatic<ClientInfo> clientInfoMock;
	private MockedStatic<WebApps> webAppsMock;
	private MockedStatic<Executions> executionsMock;
	private MockedStatic<Clients> clientsMock;
	private MockedStatic<Dialog> dialogMock;

	private GridTab orderTab;
	private GridTab orderLineTab;
	private TestFindWindow findWindow;

	/** Exposes the protected members needed by the tests */
	static class TestFindWindow extends FindWindow {
		/**
		 * @param tab tab the FindWindow is created for
		 * @param panel window content returning the grid window of the tab
		 */
		TestFindWindow(GridTab tab, AbstractADWindowContent panel) {
			super(WINDOW_NO, 0, tab.getName(), tab.getAD_Table_ID(), tab.getTableName(), (SQLFragment) null,
					tab.getFields(), 1, tab.getAD_Tab_ID(), panel);
		}

		/** Events is mocked, so the model of the column combobox is never rendered: add the items directly */
		@Override
		protected void updateColumnListModel(Combobox listColumn, ValueNamePair[] cols) {
			listColumn.getItems().clear();
			for (ValueNamePair col : cols)
				listColumn.appendItem(col.getName(), col);
		}

		/**
		 * Apply a saved query to the advanced search.
		 * @param query saved query
		 */
		void parse(MUserQuery query) {
			parseUserQuery(query);
		}

		/**
		 * Leave the FindWindow pointing at a tab, as an earlier query or table selection would.
		 * @param tab tab to set as current grid tab
		 */
		void setStaleTab(GridTab tab) {
			m_gridTab = tab;
		}

		/**
		 * @return tab the FindWindow currently reads columns from
		 */
		GridTab currentTab() {
			return m_gridTab;
		}

		/**
		 * Populate the operators of a column.
		 * @param column column item with a {@link ValueNamePair} value
		 * @param listOperator operator combobox to fill
		 */
		void operators(ComboItem column, Combobox listOperator) {
			addOperators(column, listOperator);
		}
	}

	@BeforeEach
	public void setUp() {
		sessionManagerMock = mockStatic(SessionManager.class);
		eventsMock = mockStatic(Events.class);
		clientInfoMock = mockStatic(ClientInfo.class);
		webAppsMock = mockStatic(WebApps.class);
		executionsMock = mockStatic(Executions.class);
		clientsMock = mockStatic(Clients.class);
		dialogMock = mockStatic(Dialog.class);

		IDesktop desktop = mock(IDesktop.class);
		Component component = mock(Component.class);
		when(desktop.getComponent()).thenReturn(component);
		when(desktop.getClientInfo()).thenReturn(mock(ClientInfo.class));
		sessionManagerMock.when(() -> SessionManager.getAppDesktop()).thenReturn(desktop);

		eventsMock.when(() -> Events.isValid(anyString())).thenReturn(true);

		clientInfoMock.when(() -> ClientInfo.get()).thenReturn(mock(ClientInfo.class));

		WebApp webApp = mock(WebApp.class, withSettings().extraInterfaces(WebAppCtrl.class));
		when(webApp.getConfiguration()).thenReturn(mock(Configuration.class));
		IdGenerator idGenerator = mock(IdGenerator.class);
		when(idGenerator.nextAnonymousComponentUuid(any(), any())).thenAnswer(invocation -> UUID.randomUUID().toString());
		when(((WebAppCtrl) webApp).getIdGenerator()).thenReturn(idGenerator);
		webAppsMock.when(() -> WebApps.getCurrent()).thenReturn(webApp);

		executionsMock.when(() -> Executions.schedule(any(Desktop.class), any(), any())).thenAnswer(invocation -> null);
		clientsMock.when(() -> Clients.clearBusy()).thenAnswer(invocation -> null);
		dialogMock.when(() -> Dialog.error(anyInt(), anyString(), anyString())).thenAnswer(invocation -> null);

		GridWindowVO vo = GridWindowVO.create(Env.getCtx(), WINDOW_NO, SystemIDs.WINDOW_SALES_ORDER);
		assertNotNull(vo, "Sales Order window not available for the test role");
		GridWindow gridWindow = new GridWindow(vo);
		for (int i = 0; i < gridWindow.getTabCount(); i++)
			gridWindow.initTab(i);
		orderTab = gridWindow.getGridTab(AD_TAB_ID_ORDER);
		orderLineTab = gridWindow.getGridTab(AD_TAB_ID_ORDER_LINE);
		assertNotNull(orderTab);
		assertNotNull(orderLineTab);

		AbstractADWindowContent panel = mock(AbstractADWindowContent.class);
		when(panel.getGridWindow()).thenReturn(gridWindow);

		findWindow = new TestFindWindow(orderTab, panel);
		assertTrue(findWindow.initialize(), "FindWindow failed to initialize");
	}

	@AfterEach
	public void tearDownMocks() {
		sessionManagerMock.close();
		eventsMock.close();
		clientInfoMock.close();
		webAppsMock.close();
		executionsMock.close();
		clientsMock.close();
		dialogMock.close();
	}

	private MUserQuery createQuery(String column, String tableSegment) {
		MUserQuery query = new MUserQuery(Env.getCtx(), 0, getTrxName());
		query.setAD_Table_ID(orderTab.getAD_Table_ID());
		query.setAD_Tab_ID(orderTab.getAD_Tab_ID());
		query.setName("FindWindowSavedQueryTest-" + System.nanoTime());
		query.setCode(column + "<^>=<^>" + DOCTYPE_VALUE + "<^><^>AND<^><^><^>" + tableSegment);
		query.saveEx();
		return query;
	}

	/**
	 * Query with a table segment that matches no tab (AD_Tab_ID saved by older versions) applied while the
	 * FindWindow was left on a child tab. The Order column is looked up in C_OrderLine and addOperators fails
	 * with a NullPointerException.
	 */
	@Test
	public void unmatchedTableSegmentWithStaleGridTab() {
		MUserQuery query = createQuery("C_DocTypeTarget_ID", String.valueOf(AD_TAB_ID_ORDER));
		findWindow.setStaleTab(orderLineTab);

		assertDoesNotThrow(() -> findWindow.parse(query));
		assertEquals(orderTab, findWindow.currentTab(), "Grid tab not restored to the FindWindow tab");
	}

	/**
	 * Query with the AD_Tab_UU as table segment keeps working.
	 */
	@Test
	public void uuQueryWithStaleGridTab() {
		MUserQuery query = createQuery("C_DocTypeTarget_ID", orderTab.getAD_Tab_UU());
		findWindow.setStaleTab(orderLineTab);

		assertDoesNotThrow(() -> findWindow.parse(query));
		assertEquals(orderTab, findWindow.currentTab());
	}

	/**
	 * Query of a child tab switches the FindWindow to that tab.
	 */
	@Test
	public void childTabQuerySwitchesTab() {
		MUserQuery query = createQuery("M_Product_ID", orderLineTab.getAD_Tab_UU());

		assertDoesNotThrow(() -> findWindow.parse(query));
		assertEquals(orderLineTab, findWindow.currentTab());
	}

	/**
	 * Column that does not exist in the table is tolerated.
	 */
	@Test
	public void unknownColumnOperators() {
		ComboItem unknown = new ComboItem("unknown", new ValueNamePair("NoSuchColumn", "unknown"));

		assertDoesNotThrow(() -> findWindow.operators(unknown, new Combobox()));
	}
}
