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
package org.idempiere.test.form;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Vector;

import org.compiere.grid.CreateFromRMA;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.MBPartner;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MQuery;
import org.compiere.model.MRMA;
import org.compiere.model.MRMALine;
import org.compiere.model.SystemIDs;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.ui.MiniTableImpl;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class CreateFromRMAFormTest extends AbstractTestCase {

	/**
	 * default constructor
	 */
	public CreateFromRMAFormTest() {
	}

	@Test
	public void testCreateFromShipmentLine() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id));
		order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.PURCHASE_ORDER.id);
		order.setIsSOTrx(false);
		order.setSalesRep_ID(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDateOrdered(today);
		order.setDatePromised(today);
		order.saveEx();

		MOrderLine orderLine = new MOrderLine(order);
		orderLine.setLine(10);
		orderLine.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.HOLLY_BUSH.id));
		orderLine.setQty(new BigDecimal("1"));
		orderLine.setDatePromised(today);
		orderLine.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
		
		MInOut receipt = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt.setDocStatus(DocAction.STATUS_Drafted);
		receipt.setDocAction(DocAction.ACTION_Complete);
		receipt.saveEx();

		MInOutLine receiptLine = new MInOutLine(receipt);
		receiptLine.setOrderLine(orderLine, 0, new BigDecimal("1"));
		receiptLine.setQty(new BigDecimal("1"));
		receiptLine.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
		
		MRMA rma = new MRMA(Env.getCtx(), 0, getTrxName());
		rma.setM_InOut_ID(receipt.getM_InOut_ID());
		rma.setC_BPartner_ID(receipt.getC_BPartner_ID());
		rma.setC_Currency_ID(order.getC_Currency_ID());
		rma.setIsSOTrx(false);
		rma.setName("testVendorRMA");
		rma.setC_DocType_ID(DictionaryIDs.C_DocType.VENDOR_RETURN_MATERIAL.id);
		rma.setSalesRep_ID(order.getSalesRep_ID());
		rma.setM_RMAType_ID(DictionaryIDs.M_RMAType.DAMAGE_ON_ARRIVAL.id);
		rma.saveEx();
		
		GridWindow gridWindow = GridWindow.get(Env.getCtx(), 1, SystemIDs.WINDOW_VENDOR_RMA);
		assertNotNull(gridWindow, "Failed to load grid window of Vendor RMA");
		gridWindow.initTab(0);
		GridTab gridTab = gridWindow.getTab(0);
		MQuery query = new MQuery(MRMA.Table_Name);
		query.addRestriction(MRMA.COLUMNNAME_M_RMA_ID, "=", rma.get_ID());
		gridTab.setQuery(query);
		gridTab.getTableModel().setImportingMode(false, getTrxName());
		gridTab.query(false);
		
		assertEquals(1, gridTab.getRowCount(), "Unexpected number of row retrieve from DB");
		assertEquals(rma.get_ID(), gridTab.getRecord_ID(), "Wrong RMA record id");
		
		CreateFromRMAImpl form = new CreateFromRMAImpl(gridTab);
		form.setTrxName(getTrxName());
		form.loadShipmentLines();
		assertTrue(form.minitable.getRowCount() > 0, "Failed to load data from DB");
		
		form.minitable.setSelectedRow(-1);
		for (int i = 0; i < form.minitable.getRowCount(); i++) {
			KeyNamePair pp = (KeyNamePair) form.minitable.getValueAt(i, 1);
			if (pp.getKey() == receiptLine.get_ID()) {
				form.minitable.setValueAt(Boolean.TRUE, i, 0);
				form.minitable.setSelectedRow(i);
				break;
			}
		}
		
		assertTrue(form.minitable.getSelectedRow() >= 0, "Failed to find receipt line record");
		assertTrue(form.save(form.minitable, getTrxName()), "Failed to save changes");
		
		rma.load(getTrxName());
		MRMALine[] rmaLines = rma.getLines(true);
		assertEquals(1, rmaLines.length, "Unexpected number of RMA Line records");
		assertEquals(receiptLine.get_ID(), rmaLines[0].getM_InOutLine_ID(), "Materia receipt line not match to RMA line");
	}
	
	private static class CreateFromRMAImpl extends CreateFromRMA {

		private MiniTableImpl minitable = null;
		
		public CreateFromRMAImpl(GridTab mTab) {
			super(mTab);
			
			try {
				dynInit();
			} catch (Exception e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}

		@Override
		public Object getWindow() {
			return null;
		}
		
		@Override
		protected boolean dynInit() throws Exception {
			super.dynInit();
			minitable = new MiniTableImpl();
			for(String column : getOISColumnNames()) {
				minitable.addColumn(column);
			}
			configureMiniTable(minitable);
			return true;
		}
		
		public void loadShipmentLines() {
			Vector<Vector<Object>> datas = super.getRMAData();
			for(int i = 0; i < datas.size(); i++) {
				minitable.setRowCount(i+1);
				Vector<Object> data = datas.get(i);
				for(int j = 0; j < data.size(); j++) {
					minitable.setValueAt(data.get(j), i, j);
				}
			}
		}
	}
}
