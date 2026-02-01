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
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         							       *
 **********************************************************************/
package org.idempiere.test.ui;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.panel.InfoGeneralPanel;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.MTable;
import org.compiere.model.MUser;

import org.compiere.util.Env;
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
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zk.ui.util.Configuration;

/**
 * Integration tests for InfoGeneralPanel using AD_User table (ID=114)
 * @author hengsin
 */
@Isolated
public class InfoGeneralPanelTest extends AbstractTestCase {

	private static final int AD_USER_TABLE_ID = MUser.Table_ID;
	private static final String AD_USER_TABLE_NAME = MUser.Table_Name;
	private static final String AD_USER_KEY_COLUMN = MUser.COLUMNNAME_AD_User_ID;

	private MockedStatic<SessionManager> sessionManagerMock;
	private MockedStatic<Events> eventsMock;
	private MockedStatic<ClientInfo> clientInfoMock;
	private MockedStatic<WebApps> webAppsMock;
    private MockedStatic<Executions> executionsMock;
    private MockedStatic<Clients> clientsMock;

	public InfoGeneralPanelTest() {
	}

	@BeforeEach
	public void setUp() {
		sessionManagerMock = mockStatic(SessionManager.class);
		eventsMock = mockStatic(Events.class);
		clientInfoMock = mockStatic(ClientInfo.class);
		webAppsMock = mockStatic(WebApps.class);
        executionsMock = mockStatic(Executions.class);
        clientsMock = mockStatic(Clients.class);

		IDesktop desktop = mock(IDesktop.class);
		Component component = mock(Component.class);
		when(desktop.getComponent()).thenReturn(component);
		sessionManagerMock.when(() -> SessionManager.getAppDesktop()).thenReturn(desktop);
		
		eventsMock.when(() -> Events.isValid(anyString())).thenReturn(true);
		
		clientInfoMock.when(() -> ClientInfo.get()).thenReturn(mock(ClientInfo.class));
		
		WebApp webApp = mock(WebApp.class);
		when(webApp.getConfiguration()).thenReturn(mock(Configuration.class));
		webAppsMock.when(() -> WebApps.getCurrent()).thenReturn(webApp);

        executionsMock.when(() -> Executions.schedule(any(Desktop.class), any(), any())).thenAnswer(invocation -> {
			return null;
		});

        clientsMock.when(() -> Clients.clearBusy()).thenAnswer(invocation -> {
			return null;
		});
	}

	@AfterEach
	public void tearDownMocks() {
		sessionManagerMock.close();
		eventsMock.close();
		clientInfoMock.close();
		webAppsMock.close();
        executionsMock.close();
        clientsMock.close();
	}

	/**
	 * Test creation of InfoGeneralPanel for AD_User table
	 */
	@Test
	public void testInfoGeneralPanelCreation() {
		// Verify AD_User table exists with expected ID
		MTable table = MTable.get(Env.getCtx(), AD_USER_TABLE_NAME);
		assertNotNull(table, "AD_User table should exist");
		assertEquals(AD_USER_TABLE_ID, table.getAD_Table_ID(), "AD_User table ID should be 114");

		// Create InfoGeneralPanel without query
		InfoGeneralPanel infoPanel = new InfoGeneralPanel(
				null,						// queryValue
				0,							// windowNo
				AD_USER_TABLE_NAME,			// tableName
				AD_USER_KEY_COLUMN,			// keyColumn
				false,						// multipleSelection
				null						// whereClause
		) {
			@Override
			protected void autoHideEmptyColumns() {		
			}
			
		};
		
		assertNotNull(infoPanel, "InfoGeneralPanel should be created successfully");
		assertTrue(infoPanel.loadedOK(), "Panel should load successfully");

        infoPanel.onQueryCallback(mock(Event.class));		
		assertTrue(infoPanel.getRowCount() >= 1, "Query should return one or more rows");
	}

	/**
	 * Test InfoGeneralPanel with WHERE clause filter
	 */
	@Test
	public void testInfoGeneralPanelWithWhereClause() {
		// Filter to only active users in current client
		String whereClause = "AD_User.AD_Client_ID=" + getAD_Client_ID();
		
		InfoGeneralPanel infoPanel = new InfoGeneralPanel(
				null,						// queryValue
				0,							// windowNo
				AD_USER_TABLE_NAME,			// tableName
				AD_USER_KEY_COLUMN,			// keyColumn
				false,						// multipleSelection
				whereClause					// whereClause
		){
			@Override
			protected void autoHideEmptyColumns() {		
			}
			
		};
		
		assertNotNull(infoPanel, "InfoGeneralPanel should be created successfully");
		assertTrue(infoPanel.loadedOK(), "Panel should load successfully");

        infoPanel.onQueryCallback(mock(Event.class));		
		assertTrue(infoPanel.getRowCount() >= 1, "Query should return one or more rows");
	}

	/**
	 * Test InfoGeneralPanel in multiple selection mode
	 */
	@Test
	public void testInfoGeneralPanelMultipleSelection() {
		InfoGeneralPanel infoPanel = new InfoGeneralPanel(
				null,						// queryValue
				0,							// windowNo
				AD_USER_TABLE_NAME,			// tableName
				AD_USER_KEY_COLUMN,			// keyColumn
				true,						// multipleSelection = true
				null						// whereClause
		){
			@Override
			protected void autoHideEmptyColumns() {		
			}
			
		};
		
		assertNotNull(infoPanel, "InfoGeneralPanel should be created successfully");
		assertTrue(infoPanel.loadedOK(), "Panel should load successfully");

        infoPanel.onQueryCallback(mock(Event.class));		
		assertTrue(infoPanel.getRowCount() >= 1, "Query should return one or more rows");
	}

	/**
	 * Test that the Garden Admin user can be found via InfoGeneralPanel
	 */
	@Test
	public void testFindGardenAdminUser() {
		// Get the GardenAdmin user to verify expected data
		MUser gardenAdmin = MUser.get(Env.getCtx(), GARDEN_WORLD_ADMIN_USER);
		assertNotNull(gardenAdmin, "GardenAdmin user should exist");
		
		// Search using Name value
		String searchValue = gardenAdmin.getName();
		
		InfoGeneralPanel infoPanel = new InfoGeneralPanel(
				searchValue,				// queryValue
				0,							// windowNo
				AD_USER_TABLE_NAME,			// tableName
				AD_USER_KEY_COLUMN,			// keyColumn
				false,						// multipleSelection
				null						// whereClause
		){
			@Override
			protected void autoHideEmptyColumns() {		
			}
			
		};
		
		assertNotNull(infoPanel, "InfoGeneralPanel should be created successfully");
		assertTrue(infoPanel.loadedOK(), "Panel should load successfully");

        // Execute query should find at least one result
		int rowCount = infoPanel.getRowCount();
		assertTrue(rowCount > 0, "Query should return more than zero rows");

	}
}
