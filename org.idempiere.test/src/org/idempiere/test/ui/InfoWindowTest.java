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

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;

import java.util.List;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.info.InfoWindow;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.MBPartner;
import org.compiere.util.Env;
import org.idempiere.db.util.SQLFragment;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
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
 * Integration tests for InfoWindow with AD_InfoWindow_ID = 200001 (Business Partner Info)
 * @author hengsin
 */
@Isolated
public class InfoWindowTest extends AbstractTestCase {

	private static final int AD_INFOWINDOW_ID = 200001;

	private MockedStatic<SessionManager> sessionManagerMock;
	private MockedStatic<Events> eventsMock;
	private MockedStatic<ClientInfo> clientInfoMock;
	private MockedStatic<WebApps> webAppsMock;
	private MockedStatic<Executions> executionsMock;
	private MockedStatic<Clients> clientsMock;

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
		when(desktop.getClientInfo()).thenReturn(mock(ClientInfo.class));
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
	 * Test creation of InfoWindow for record 200001
	 */
	@Test
	public void testInfoWindowCreation() {
		// Business Partner Info is usually on C_BPartner table
		String tableName = MBPartner.Table_Name;
		String keyColumn = MBPartner.COLUMNNAME_C_BPartner_ID;
		
		InfoWindow infoWindow = new InfoWindow(
				0,							// windowNo
				tableName,					// tableName
				keyColumn,					// keyColumn
				null,						// queryValue
				false,						// multipleSelection
				AD_INFOWINDOW_ID,			// AD_InfoWindow_ID
				true,						// lookup
				null						// sqlFilter
		) {
			@Override
			protected void autoHideEmptyColumns() {		
			}
			
		};
		
		assertNotNull(infoWindow, "InfoWindow should be created successfully");
		assertTrue(infoWindow.loadedOK(), "InfoWindow should load correctly from AD_InfoWindow_ID=" + AD_INFOWINDOW_ID);

		infoWindow.onQueryCallback(mock(Event.class));		
		assertTrue(infoWindow.getRowCount() >= 1, "Query should return one or more rows");
	}

	/**
	 * Test InfoWindow with queryValue
	 */
	@Test
	public void testInfoWindowWithQueryValue() {
		String tableName = MBPartner.Table_Name;
		String keyColumn = MBPartner.COLUMNNAME_C_BPartner_ID;
		String queryValue = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id).getName();
		
		InfoWindow infoWindow = new InfoWindow(
				0,							// windowNo
				tableName,					// tableName
				keyColumn,					// keyColumn
				queryValue,					// queryValue
				false,						// multipleSelection
				AD_INFOWINDOW_ID,			// AD_InfoWindow_ID
				true,						// lookup
				null						// sqlFilter
		) {
			@Override
			protected void autoHideEmptyColumns() {		
			}
			
		};
		
		assertNotNull(infoWindow, "InfoWindow should be created successfully");
		assertTrue(infoWindow.loadedOK(), "InfoWindow should load correctly");
		assertTrue(infoWindow.getRowCount() >= 1, "Query should return one or more rows");
	}

	/**
	 * Test InfoWindow with sqlFilter
	 */
	@Test
	public void testInfoWindowWithSqlFilter() {
		String tableName = MBPartner.Table_Name;
		String keyColumn = MBPartner.COLUMNNAME_C_BPartner_ID;
		SQLFragment sqlFilter = new SQLFragment("C_BPartner.AD_Client_ID=?", List.of(getAD_Client_ID()));
		
		InfoWindow infoWindow = new InfoWindow(
				0,							// windowNo
				tableName,					// tableName
				keyColumn,					// keyColumn
				null,						// queryValue
				false,						// multipleSelection
				AD_INFOWINDOW_ID,			// AD_InfoWindow_ID
				true,						// lookup
				sqlFilter					// sqlFilter
		) {
			@Override
			protected void autoHideEmptyColumns() {		
			}
			
		};
		
		assertNotNull(infoWindow, "InfoWindow should be created successfully");
		assertTrue(infoWindow.loadedOK(), "InfoWindow should load correctly");

		infoWindow.onQueryCallback(mock(Event.class));		
		assertTrue(infoWindow.getRowCount() >= 1, "Query should return one or more rows");
	}
}
