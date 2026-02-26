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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.withSettings;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.UUID;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.info.InfoWindow;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.window.Dialog;
import org.compiere.model.GridField;
import org.compiere.model.MBPartner;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.PO;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.wf.MWorkflow;
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
import org.zkoss.zk.ui.sys.IdGenerator;
import org.zkoss.zk.ui.sys.WebAppCtrl;
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
	private MockedStatic<Dialog> dialogMock;

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
		when(idGenerator.nextAnonymousComponentUuid(any(), any())).thenReturn(UUID.randomUUID().toString());
		when(((WebAppCtrl) webApp).getIdGenerator()).thenReturn(idGenerator);
		webAppsMock.when(() -> WebApps.getCurrent()).thenReturn(webApp);

		executionsMock.when(() -> Executions.schedule(any(Desktop.class), any(), any())).thenAnswer(invocation -> {
			return null;
		});

		clientsMock.when(() -> Clients.clearBusy()).thenAnswer(invocation -> {
			return null;
		});
		
		dialogMock.when(() -> Dialog.error(anyInt(), anyString(), anyString())).thenAnswer(invocation -> {
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
		dialogMock.close();
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
	
	@Test
	public void testCreateLinesFrom() {
		List<PO> createdRecords = new ArrayList<>();
		try {
			// create order and line without transaction so that info window can read it		
			MOrder order = new MOrder(Env.getCtx(), 0, null);
			order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
			order.setM_Warehouse_ID(DictionaryIDs.M_Warehouse.HQ.id);
			order.saveEx();
			createdRecords.add(order);
			
			MOrderLine line1 = new MOrderLine(order);
			line1.setM_Product_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
			line1.setQty(Env.ONE);
			line1.saveEx();
			createdRecords.add(line1);
			ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
			assertTrue(pi.isError() == false, "Order should be completed");
			
			Env.setContext(Env.getCtx(), 1, "M_Locator_ID", DictionaryIDs.M_Locator.HQ.id);
			Env.setContext(Env.getCtx(), 1, "IsSOTrx", "N");
			Env.setContext(Env.getCtx(), 1, "C_BPartner_ID", order.getC_BPartner_ID());
			Env.setContext(Env.getCtx(), 1, "M_Warehouse_ID", order.getM_Warehouse_ID());
			
			int windowNo=1;
			String tableName= "M_InOut_CreateFrom_v";
			String keyColumn="M_InOut_CreateFrom_v_ID";
			String queryValue=null;
			boolean multipleSelection=false;
			int AD_InfoWindow_ID=200022;
			boolean lookup=false;
			GridField field=null;
			String predefinedContextVariables=null;
			SQLFragment sqlFilter=null;
			
			InfoWindow infoWindow = new InfoWindow(
					windowNo,
					tableName,
					keyColumn,
					queryValue,
					multipleSelection,
					AD_InfoWindow_ID,
					lookup,
					field,
					predefinedContextVariables,
					sqlFilter
			) {
				@Override
				protected void autoHideEmptyColumns() {		
				}
	
				@Override
				public void onQueryCallback(Event event) {
					isQueryByUser = true;
					super.onQueryCallback(event);
				}	
				
				
			};
			
			assertTrue(infoWindow.loadedOK(), "InfoWindow should load correctly");
			
			var editor = infoWindow.getEditor("C_Order_ID");		
			assertNotNull(editor, "Failed to get editor for C_Order_ID");
			editor.setReadWrite(false); //to trigger getDirect of lookup
			editor.setValue(order.getC_Order_ID());
			assertEquals(order.getC_Order_ID(), editor.getValue(), "Failed to set C_Order_ID in InfoWindow");
			
			editor = infoWindow.getEditor("M_Warehouse_ID");
			assertNotNull(editor, "Failed to get editor for M_Warehouse_ID");
			editor.setReadWrite(false); //to trigger getDirect of lookup
			editor.setVisible(true);		
			editor.setValue(order.getM_Warehouse_ID());
			assertEquals(order.getM_Warehouse_ID(), editor.getValue(), "Failed to set M_Warehouse_ID in InfoWindow");
			
			infoWindow.onQueryCallback(mock(Event.class));		
			assertTrue(infoWindow.getRowCount() >= 1, "Query should return one or more rows");
			
			order.load(null);
			pi = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_ReActivate);
			assertTrue(pi.isError() == false, "Order should be re-activated");
			order.load(null);
			pi = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Void);
			assertTrue(pi.isError() == false, "Order should be voided");
			order.load(null);
		} finally {
			rollback();
			if (!createdRecords.isEmpty()) {
				Collections.reverse(createdRecords);
				for (PO po : createdRecords) {
					DB.executeUpdateEx("UPDATE " + po.get_TableName() + " SET Processed='N' WHERE " + po.get_TableName() + "_ID=" + po.get_ID(), null);
					po.load(null);
					po.deleteEx(true);
				}
			}
		}
	}
}
