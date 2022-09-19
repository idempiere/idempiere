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
import static org.junit.jupiter.api.Assertions.assertFalse;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.compiere.model.MRequisition;
import org.compiere.model.MRequisitionLine;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class RequisitionTest extends AbstractTestCase {

	/**
	 * 
	 */
	public RequisitionTest() {
	}

	@Test
	public void testComplete() {
		int purchaseRequisition = DictionaryIDs.C_DocType.PURCHASE_REQUISITION.id;
		int standardPriceList = DictionaryIDs.M_PriceList.STANDARD.id;
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		MRequisition requisition = new MRequisition(Env.getCtx(), 0, getTrxName());
		requisition.setC_DocType_ID(purchaseRequisition);
		requisition.setDateDoc(today);
		requisition.setDateRequired(today);
		requisition.setDocAction(DocAction.ACTION_Complete);
		requisition.setDocStatus(DocAction.STATUS_Drafted);
		requisition.setM_Warehouse_ID(getM_Warehouse_ID());
		requisition.setAD_User_ID(getAD_User_ID());
		requisition.setAD_Org_ID(getAD_Org_ID());
		requisition.setM_PriceList_ID(standardPriceList);
		requisition.setPriorityRule(MRequisition.PRIORITYRULE_Medium);
		requisition.saveEx();
		
		int seeder = DictionaryIDs.M_Product.SEEDER.id;
		int each = DictionaryIDs.C_UOM.EACH.id;
		MRequisitionLine line = new MRequisitionLine(requisition);
		line.setM_Product_ID(seeder);
		line.setC_UOM_ID(each);
		line.setQty(new BigDecimal("1"));
		line.setPrice();
		line.saveEx();
		
		ProcessInfo pi = MWorkflow.runDocumentActionWorkflow(requisition, DocAction.ACTION_Complete);
		assertFalse(pi.isError(), pi.getSummary());
		
		requisition.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, requisition.getDocStatus());
	}
}
