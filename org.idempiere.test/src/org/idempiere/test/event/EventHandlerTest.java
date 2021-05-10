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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.event;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.adempiere.base.Core;
import org.adempiere.base.event.FactsEventData;
import org.adempiere.base.event.annotations.AfterLogin;
import org.adempiere.base.event.annotations.EventDelegate;
import org.adempiere.base.event.annotations.ModelEventDelegate;
import org.adempiere.base.event.annotations.ModelEventHandler;
import org.adempiere.base.event.annotations.SimpleEventHandler;
import org.adempiere.base.event.annotations.doc.BeforeComplete;
import org.adempiere.base.event.annotations.doc.FactsValidateDelegate;
import org.adempiere.base.event.annotations.imp.AfterImport;
import org.adempiere.base.event.annotations.imp.ImportEventDelegate;
import org.adempiere.base.event.annotations.imp.ImportEventHandler;
import org.adempiere.base.event.annotations.po.BeforeNew;
import org.adempiere.base.event.annotations.process.AfterProcess;
import org.adempiere.base.event.annotations.process.ProcessEventDelegate;
import org.adempiere.base.event.annotations.process.ProcessEventHandler;
import org.adempiere.model.ImportValidator;
import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MOrg;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.X_I_BPartner;
import org.compiere.model.X_I_Product;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ImportBPartner;
import org.compiere.process.ImportProduct;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Login;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.osgi.service.event.Event;

@TestMethodOrder(OrderAnnotation.class)
/**
 * 
 * @author hengsin
 *
 */
public class EventHandlerTest extends AbstractTestCase {

	private final static int BP_JOE_BLOCK = 118;
	private static final int PRODUCT_PLANTING_SERVICE = 126;
	
	public EventHandlerTest() {
	}


	@Test
	@Order(1)
	public void testModelEventHandler() {
		//test1 - activator approach 
		ModelEventHandler<MBPartner> handler = new ModelEventHandler<MBPartner>(MBPartner.class, MyBPBeforeNewDelegate.class, (bp, event) -> new MyBPBeforeNewDelegate(bp, event));
		Core.getEventManager().register(handler);
		
		MBPartner bpartner = new MBPartner(Env.getCtx(), 0, getTrxName());
		String name  = "BP_"+System.currentTimeMillis();
		bpartner.setName(name);
		bpartner.setC_BP_Group_ID(103);
		bpartner.saveEx();
		
		String test = Env.getContext(Env.getCtx(), MyBPBeforeNewDelegate.class.getName());
		assertTrue(bpartner.getName().equals(test), "MyBPBeforeNewDelegate not called");
		
		//test2 - MyComponent.MyBpBeforeChangeDelegate using osgi component mechanism
		bpartner.setDescription("");
		bpartner.saveEx();
		
		test = Env.getContext(Env.getCtx(), MyComponent.MyBpBeforeChangeDelegate.class.getName());
		assertTrue(bpartner.toString().equals(test), "MyComponent.MyBpBeforeChangeDelegate not called");
	}
	
	@Test
	@Order(2)
	public void testDocumentEventHandler() {
		ModelEventHandler<MOrder> handler = new ModelEventHandler<MOrder>(MOrder.class, MyOrderBeforeCompleteDelegate.class, 
				(po, event) -> new MyOrderBeforeCompleteDelegate(po, event));
		Core.getEventManager().register(handler);
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), BP_JOE_BLOCK));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.setDescription(null);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), PRODUCT_PLANTING_SERVICE));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		
		Core.getEventManager().unregister(handler);
		
		String test = Env.getContext(Env.getCtx(), MyOrderBeforeCompleteDelegate.class.getName());
		assertEquals(order.toString(), test, "MyOrderBeforeCompleteDelegate not called");
	}
	
	@Test
	@Order(3)
	public void testDocumentEventHandlerException() {
		ModelEventHandler<MOrder> handler = new ModelEventHandler<MOrder>(MOrder.class, MyOrderBeforeCompleteDelegate.class, 
				(po, event) -> new MyOrderBeforeCompleteDelegate(po, event));
		Core.getEventManager().register(handler);
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), BP_JOE_BLOCK));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.setDescription(MyOrderBeforeCompleteDelegate.class.getName());
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), PRODUCT_PLANTING_SERVICE));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertTrue(info.isError(), "DocAction Complete doesn't fail as expected");
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Invalid, order.getDocStatus(), "DocStatus Expected=Invalid. DocStatus Actual="+order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		assertTrue(info.getSummary() != null && info.getSummary().contains("Test Runtime Exception"), "Error message not as expected=" + info.getSummary());
	}
	
	@Test
	@Order(4)
	public void testAfterLogin() {
		SimpleEventHandler handler = new SimpleEventHandler(MyAfterLoginDelegate.class, (event) -> new MyAfterLoginDelegate(event));
		Core.getEventManager().register(handler);
		
		KeyNamePair org = new KeyNamePair(getAD_Org_ID(), MOrg.get(getAD_Org_ID()).getName());
		Login login = new Login(Env.getCtx());
		login.validateLogin(org);
		
		assertTrue("y".equalsIgnoreCase(Env.getContext(Env.getCtx(), MyAfterLoginDelegate.class.getName())), 
				"MyAfterLoginDelegate not call. context="+Env.getContext(Env.getCtx(), MyAfterLoginDelegate.class.getName()));
	}
	
	@Test
	@Order(5)
	public void testAfterProcess() {
		int Verify_BOM=136;
		int Patio_Chair=133;
				
		ProcessEventHandler handler = new ProcessEventHandler(MyAfterProcessDelegate.class, MProcess.get(Verify_BOM).getAD_Process_UU(), (event) -> new MyAfterProcessDelegate(event));
		Core.getEventManager().register(handler);
		
		MProcess process = MProcess.get(Env.getCtx(), Verify_BOM);
		ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
		pi.setAD_Client_ID(getAD_Client_ID());
		pi.setAD_User_ID(getAD_User_ID());
		pi.setRecord_ID(Patio_Chair);
		pi.setTransactionName(getTrxName());
		
		ServerProcessCtl.process(pi, getTrx());
		if (pi.isError()) {
			fail("Error running Verify BOM process" + (Util.isEmpty(pi.getSummary()) ? "" : " : "+pi.getSummary()));
			return;
		}
		
		assertTrue(pi.getTitle() != null && pi.getTitle().contains(MyAfterProcessDelegate.class.getName()), "MyAfterProcessDelegate not call. Title="+pi.getTitle());
	}
	
	@Test
	@Order(6)
	public void testFactValidate()
	{
		ModelEventHandler<MInOut> handler = new ModelEventHandler<MInOut>(MInOut.class, MyFactValidateDelegate.class, 
				(po, event) -> new MyFactValidateDelegate(po, event));
		Core.getEventManager().register(handler);
		
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), BP_JOE_BLOCK));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		//Azalea Bush
		line1.setProduct(MProduct.get(Env.getCtx(), PRODUCT_PLANTING_SERVICE));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();		
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());		
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		line1.load(getTrxName());
		assertEquals(1, line1.getQtyReserved().intValue());
		
		MInOut shipment = new MInOut(order, 120, order.getDateOrdered());
		shipment.setDocStatus(DocAction.STATUS_Drafted);
		shipment.setDocAction(DocAction.ACTION_Complete);
		shipment.saveEx();
		
		MInOutLine shipmentLine = new MInOutLine(shipment);
		shipmentLine.setOrderLine(line1, 0, new BigDecimal("1"));
		shipmentLine.setQty(new BigDecimal("1"));
		shipmentLine.saveEx();
		
		info = MWorkflow.runDocumentActionWorkflow(shipment, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		shipment.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, shipment.getDocStatus());
						
		line1.load(getTrxName());
		assertEquals(0, line1.getQtyReserved().intValue());
		
		if (!shipment.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), shipment.getAD_Client_ID(), MInOut.Table_ID, shipment.get_ID(), false, getTrxName());
			assertTrue(error == null, error);
		}
		
		assertTrue("y".equalsIgnoreCase(Env.getContext(Env.getCtx(), MyFactValidateDelegate.class.getName())), 
				"MyFactValidateDelegate not call. context="+Env.getContext(Env.getCtx(), MyFactValidateDelegate.class.getName()));
	}
	
	@Test
	@Order(7)
	public void testAfterImport() {
		ImportEventHandler handler = new ImportEventHandler(MyAfterImportDelegate.class, X_I_BPartner.Table_Name, (event) -> new MyAfterImportDelegate(event));
		Core.getEventManager().register(handler);
		
		ImportProduct ip = new ImportProduct();
		ModelValidationEngine.get().fireImportValidate(ip, new X_I_Product(Env.getCtx(), 0, getTrxName()), new MProduct(Env.getCtx(), 0, getTrxName()), ImportValidator.TIMING_AFTER_IMPORT);
		assertTrue(Util.isEmpty(Env.getContext(Env.getCtx(), MyAfterImportDelegate.class.getName())), 
				"MyAfterImportDelegate call for different import table name. context="+Env.getContext(Env.getCtx(), MyAfterImportDelegate.class.getName()));
		
		ImportBPartner ibp = new ImportBPartner();
		ModelValidationEngine.get().fireImportValidate(ibp, new X_I_BPartner(Env.getCtx(), 0, getTrxName()), new MBPartner(Env.getCtx(), 0, getTrxName()), ImportValidator.TIMING_AFTER_IMPORT);
		
		assertTrue("y".equalsIgnoreCase(Env.getContext(Env.getCtx(), MyAfterImportDelegate.class.getName())), 
				"MyAfterImportDelegate not call. context="+Env.getContext(Env.getCtx(), MyAfterImportDelegate.class.getName()));		
	}
	
	private final static class MyBPBeforeNewDelegate extends ModelEventDelegate<MBPartner> {

		public MyBPBeforeNewDelegate(MBPartner bp, Event event) {
			super(bp, event);
		}

		@BeforeNew
		public void beforeNew() {
			Env.setContext(Env.getCtx(), getClass().getName(), getModel().getName());
		}
	}
	
	private final static class MyOrderBeforeCompleteDelegate extends ModelEventDelegate<MOrder>  {

		public MyOrderBeforeCompleteDelegate(MOrder po, Event event) {
			super(po, event);
		}

		@BeforeComplete
		public void beforeComplete() {
			if (getClass().getName().equals(getModel().getDescription())) {
				throw new RuntimeException("Test Runtime Exception");
			} else {
				Env.setContext(Env.getCtx(), getClass().getName(), getModel().toString());
			}
		}
	}
	
	private final static class MyAfterLoginDelegate extends EventDelegate {

		public MyAfterLoginDelegate(Event event) {
			super(event);
		}

		@AfterLogin
		public void afterLogin() {
			Env.setContext(Env.getCtx(), getClass().getName(), true);
		}
	}
	
	private final static class MyAfterProcessDelegate extends ProcessEventDelegate {

		public MyAfterProcessDelegate(Event event) {
			super(event);
		}

		@AfterProcess
		public void afterProcess() {
			ProcessInfo pi = getProcessInfo();
			pi.setTitle(getClass().getName());
		}
	}
	
	private final static class MyFactValidateDelegate extends FactsValidateDelegate<MInOut> {

		public MyFactValidateDelegate(MInOut po, Event event) {
			super(po, event);
		}

		@Override
		protected void onFactsValidate(FactsEventData data) {
			Env.setContext(Env.getCtx(), this.getClass().getName(), true);
		}
		
	}
	
	private final static class MyAfterImportDelegate extends ImportEventDelegate {

		public MyAfterImportDelegate(Event event) {
			super(event);
		}
		
		@AfterImport
		public void afterImport() {
			Env.setContext(Env.getCtx(), getClass().getName(), true);
		}
	}
}
