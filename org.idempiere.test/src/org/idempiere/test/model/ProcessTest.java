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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;

import org.adempiere.base.Core;
import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutConfirm;
import org.compiere.model.MInOutLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProcess;
import org.compiere.model.MProduct;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessCall;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.wf.MWFNode;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWFNodePara;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class ProcessTest extends AbstractTestCase {

	/**
	 * 
	 */
	public ProcessTest() {
	}

	@Test
	public void testWorkflowProcess() {
		//first test, using MProcess.processIt
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
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
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		int Process_Order=SystemIDs.PROCESS_C_ORDER_PROCESS;
		MProcess process = MProcess.get(Env.getCtx(), Process_Order);
		ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
		pi.setAD_Client_ID(getAD_Client_ID());
		pi.setAD_User_ID(getAD_User_ID());
		pi.setRecord_ID(order.get_ID());
		pi.setTransactionName(getTrxName());
		
		boolean ok = process.processIt(pi, getTrx(), false);
		if (!ok || pi.isError()) {
			fail("Error running Process_Order workflow process" + (Util.isEmpty(pi.getSummary()) ? "" : " : "+pi.getSummary()));
			return;
		}
		
		order.load(getTrxName());
		assertTrue(order.getDocStatus().equals(DocAction.STATUS_Completed), "Order not completed");
		
		//second test, using MWorkflow.runDocumentActionWorkflow
		pi = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_ReActivate);
		if (pi.isError()) {
			fail("Failed to reactivate order" + (Util.isEmpty(pi.getSummary()) ? "" : " : "+pi.getSummary()));
			return;
		}
		
		order.load(getTrxName());
		assertTrue(order.getDocStatus().equals(DocAction.STATUS_InProgress), "Order not reactivated");
	}
	
	@Test
	public void testJavaProcess() {
		int Verify_BOM=SystemIDs.PROCESS_PP_PRODUCT_BOM;
		int Patio_Chair=DictionaryIDs.M_Product.P_CHAIR.id;
		
		//first, test MProcess.processIt
		MProcess process = MProcess.get(Env.getCtx(), Verify_BOM);
		ProcessInfo pi = new ProcessInfo(process.getName(), process.get_ID());
		pi.setAD_Client_ID(getAD_Client_ID());
		pi.setAD_User_ID(getAD_User_ID());
		pi.setRecord_ID(Patio_Chair);
		pi.setTransactionName(getTrxName());
		
		boolean ok = process.processIt(pi, getTrx(), false);
		if (!ok || pi.isError()) {
			fail("Error running Verify BOM process" + (Util.isEmpty(pi.getSummary()) ? "" : " : "+pi.getSummary()));
			return;
		}
		
		//second, test ServerProcessCtl.process
		pi = new ProcessInfo(process.getName(), process.get_ID());
		pi.setAD_Client_ID(getAD_Client_ID());
		pi.setAD_User_ID(getAD_User_ID());
		pi.setRecord_ID(Patio_Chair);
		pi.setTransactionName(getTrxName());
		ServerProcessCtl.process(pi, getTrx());
		if (pi.isError()) {
			fail("Error running Verify BOM process" + (Util.isEmpty(pi.getSummary()) ? "" : " : "+pi.getSummary()));
			return;
		}
	}
	
	@Test
	public void testChainWorkflow() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), 118));
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
		line1.setProduct(MProduct.get(Env.getCtx(), 128));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		if (pi.isError()) {
			fail("Failed to complete order" + (Util.isEmpty(pi.getSummary()) ? "" : " : "+pi.getSummary()));
			return;
		}
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus(), "Expected Completed Status for Order");
		
		//dummy order for dummy shipment below
		MOrder order1 = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order1.setBPartner(MBPartner.get(Env.getCtx(), 118));
		order1.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order1.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order1.setDocStatus(DocAction.STATUS_Drafted);
		order1.setDocAction(DocAction.ACTION_Complete);
		order1.setDateOrdered(today);
		order1.setDatePromised(today);
		order1.saveEx();
		
		MOrderLine line2 = new MOrderLine(order1);
		line2.setLine(10);
		//Azalea Bush
		line2.setProduct(MProduct.get(Env.getCtx(), 128));
		line2.setQty(new BigDecimal("1"));
		line2.setDatePromised(today);
		line2.saveEx();
		
		pi = MWorkflow.runDocumentActionWorkflow(order1, DocAction.ACTION_Complete);
		if (pi.isError()) {
			fail("Failed to complete order" + (Util.isEmpty(pi.getSummary()) ? "" : " : "+pi.getSummary()));
			return;
		}
		order1.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order1.getDocStatus(), "Expected Completed Status for Order");
		
		int Process_InOutConfirmation = 124;
		MWorkflow wf = new MWorkflow(Env.getCtx(), Process_InOutConfirmation, null);
		MWFNode processNode = new MWFNode(wf, "Process_InOut", "Process_InOut");
		processNode.set_ValueNoCheck("AD_Client_ID", getAD_Client_ID());
		processNode.setAction(MWFNode.ACTION_AppsProcess);
		processNode.setAD_Process_ID(109); //M_InOut Process
		processNode.setEntityType(MWFNode.ENTITYTYPE_UserMaintained);
		processNode.saveEx();
		MWFNodePara processNodePara = new MWFNodePara(Env.getCtx(), 0, null);
		processNodePara.set_ValueNoCheck("AD_Org_ID", 0);
		processNodePara.setAD_WF_Node_ID(processNode.getAD_WF_Node_ID());
		processNodePara.setAttributeName("Record_ID");
		processNodePara.setAttributeValue("@M_InOut_ID@");
		processNodePara.setEntityType(MWFNodePara.ENTITYTYPE_UserMaintained);
		processNodePara.saveEx();
		MWFNode docCompleteNode = new MWFNode(Env.getCtx(), 219, null);
		MWFNodeNext docCompleteNodeNext = new MWFNodeNext(docCompleteNode, processNode.getAD_WF_Node_ID());		
		docCompleteNodeNext.set_ValueNoCheck("AD_Client_ID", getAD_Client_ID());
		docCompleteNodeNext.setEntityType(MWFNodeNext.ENTITYTYPE_UserMaintained);
		docCompleteNodeNext.saveEx();
		
		try {
			//dummy shipment to make sure next m_inout_id != m_inoutconfirm_id
			int MM_Shipment=120;
			MInOut inout1 = new MInOut(order1, MM_Shipment, order1.getDateOrdered());
			inout1.setDocStatus(DocAction.STATUS_Drafted);
			inout1.setDocAction(DocAction.STATUS_Completed);
			inout1.saveEx();
			
			int MM_Shipment_With_Pick=148;
			MInOut inout = new MInOut(order, MM_Shipment_With_Pick, order.getDateOrdered());
			inout.setDocStatus(DocAction.STATUS_Drafted);
			inout.setDocAction(DocAction.STATUS_Completed);
			inout.saveEx();
			
			MInOutLine il = new MInOutLine(inout);
			il.setOrderLine(line1, 0, new BigDecimal("1"));
			il.saveEx();
			pi = MWorkflow.runDocumentActionWorkflow(inout, DocAction.ACTION_Complete);
			if (pi.isError()) {
				fail("Failed to complete shipment" + (Util.isEmpty(pi.getSummary()) ? "" : " : "+pi.getSummary()));
				return;
			}
			inout.load(getTrxName());
			assertEquals(DocAction.STATUS_InProgress, inout.getDocStatus(), "Expected In Progress Status for Shipment");
			
			MInOutConfirm[] confirmations = inout.getConfirmations(true);
			assertEquals(1, confirmations.length, "Expected 1 Shipment Confirmation Document");
			
			assertTrue(confirmations[0].getM_InOutConfirm_ID() != inout.getM_InOut_ID(), "Test should run with M_InOut_ID != M_InOutConfirm_ID");
			
			pi = MWorkflow.runDocumentActionWorkflow(confirmations[0], DocAction.ACTION_Complete);
			if (pi.isError()) {
				fail("Failed to complete shipment confirmation" + (Util.isEmpty(pi.getSummary()) ? "" : " : "+pi.getSummary()));
				return;
			}
			confirmations[0].load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, confirmations[0].getDocStatus(), "Expected Completed Status for Shipment Confirmation");
			
			inout.load(getTrxName());
			assertEquals(DocAction.STATUS_Completed, inout.getDocStatus(), "Expected Completed Status for Shipment");
		} finally {		
			rollback();
			docCompleteNodeNext.deleteEx(true);
			processNodePara.deleteEx(true);
			processNode.deleteEx(true);
		}
	}

	@Test
	public void testCoreJavaProcessMapping() {
		Query query = new Query(Env.getCtx(), MProcess.Table_Name, "AD_Process_ID < 1000000 AND ClassName IS NOT NULL "
				+ " AND EXISTS (select 1 from ad_menu where isactive='Y' and ad_process_id=ad_process.ad_process_id)", getTrxName());
		List<MProcess> processes = query.setOnlyActiveRecords(true).list();
		for (MProcess process : processes) {
			ProcessCall pc = Core.getProcess(process.getClassname());
			assertNotNull(pc, "Failed to load ProcessCall instance for " + process.toString() + ", " + process.getClassname());
		}
	}	
}
