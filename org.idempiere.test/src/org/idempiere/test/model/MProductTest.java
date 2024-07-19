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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAttributeInstance;
import org.compiere.model.MAttributeSet;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageOnHand;
import org.compiere.model.MStorageReservation;
import org.compiere.model.MUOM;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.wf.MWorkflow;
import org.eevolution.model.MPPProductBOM;
import org.eevolution.model.MPPProductBOMLine;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MProductTest extends AbstractTestCase {

	public MProductTest() {
	}

	private void createPOAndMRForProduct(int productId) {
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

		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), productId));
		line1.setQty(new BigDecimal("1"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		order.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, order.getDocStatus());		
		
		MInOut receipt1 = new MInOut(order, DictionaryIDs.C_DocType.MM_RECEIPT.id, order.getDateOrdered());
		receipt1.setDocStatus(DocAction.STATUS_Drafted);
		receipt1.setDocAction(DocAction.ACTION_Complete);
		receipt1.saveEx();

		MInOutLine receiptLine1 = new MInOutLine(receipt1);
		receiptLine1.setOrderLine(line1, 0, new BigDecimal("1"));
		receiptLine1.setQty(new BigDecimal("1"));
		receiptLine1.saveEx();

		info = MWorkflow.runDocumentActionWorkflow(receipt1, DocAction.ACTION_Complete);
		assertFalse(info.isError(), info.getSummary());
		receipt1.load(getTrxName());
		assertEquals(DocAction.STATUS_Completed, receipt1.getDocStatus());
		if (!receipt1.isPosted()) {
			String error = DocumentEngine.postImmediate(Env.getCtx(), receipt1.getAD_Client_ID(), receipt1.get_Table_ID(), receipt1.get_ID(), false, getTrxName());
			assertNull(error, error);
		}
	}
	
	@Test
	public void testIsAndGetMethods() {
		MProduct product = MProduct.get(DictionaryIDs.M_Product.TSHIRT_GL.id);
		MAttributeInstance attributeInstance = product.getAttributeInstance("Color (R-G-B)", getTrxName());
		assertNotNull(attributeInstance);
		assertEquals(DictionaryIDs.M_Attribute.COLOR.id, attributeInstance.getM_Attribute_ID());
		assertEquals("Green", attributeInstance.getValue());
		
		MAcctSchema as = MClient.get(Env.getCtx()).getAcctSchema();
		String costingLevel = product.getCostingLevel(as);
		assertEquals(as.getCostingLevel(), costingLevel);
		String costingMethod = product.getCostingMethod(as);
		assertEquals(as.getCostingMethod(), costingMethod);
		
		createPOAndMRForProduct(DictionaryIDs.M_Product.MULCH.id);
		product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		MCost mcost = product.getCostingRecord(as, getAD_Org_ID(), 0);
		assertNotNull(mcost);
		assertEquals(product.get_ID(), mcost.getM_Product_ID());
		assertEquals(mcost.getCostingMethod(), product.getCostingMethod(as));
		MCost mcost1 = product.getCostingRecord(as, getAD_Org_ID(), 0, product.getCostingMethod(as));
		assertEquals(mcost.getM_Cost_UU(), mcost1.getM_Cost_UU());
		
		product = new MProduct(Env.getCtx(), 0, getTrxName());
		product.setC_UOM_ID(DictionaryIDs.C_UOM.HOUR.id);
		product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id);
		assertEquals(MUOM.get(DictionaryIDs.C_UOM.HOUR.id).getStdPrecision(), product.getUOMPrecision());
		assertEquals(MUOM.get(DictionaryIDs.C_UOM.HOUR.id).getUOMSymbol(), product.getUOMSymbol());
		assertFalse(product.isInstanceAttribute());
		product.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
		assertTrue(product.isInstanceAttribute());
		assertFalse(product.isSerial());
		product.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.PATIO_CHAIR.id);
		assertTrue(product.isSerial());
		product.setIsStocked(true);
		product.setProductType(MProduct.PRODUCTTYPE_Item);
		assertTrue(product.isItem());
		assertFalse(product.isService());
		assertTrue(product.isStocked());
		product.setProductType(MProduct.PRODUCTTYPE_Service);
		assertFalse(product.isItem());
		assertTrue(product.isService());
		assertFalse(product.isStocked());
		product.setProductType(MProduct.PRODUCTTYPE_Resource);
		assertFalse(product.isItem());
		assertTrue(product.isService());
		assertFalse(product.isStocked());
		
		MAttributeSet attributeSet = new MAttributeSet(Env.getCtx(), DictionaryIDs.M_AttributeSet.PATIO_CHAIR.id, null);
		String mandatoryType = attributeSet.getMandatoryType();
		try {
			attributeSet.setMandatoryType(MAttributeSet.MANDATORYTYPE_NotMandatory);
			attributeSet.saveEx();
			assertFalse(product.isASIMandatoryFor(null, false));
			assertFalse(product.isASIMandatoryFor(null, true));
			assertFalse(product.isASIMandatoryFor(MAttributeSet.MANDATORYTYPE_WhenShipping, true));
			
			attributeSet.setMandatoryType(MAttributeSet.MANDATORYTYPE_AlwaysMandatory);
			attributeSet.saveEx();
			CacheMgt.get().reset(MAttributeSet.Table_Name, attributeSet.getM_AttributeSet_ID());
			assertTrue(product.isASIMandatoryFor(null, false));
			assertTrue(product.isASIMandatoryFor(null, true));
			assertTrue(product.isASIMandatoryFor(MAttributeSet.MANDATORYTYPE_WhenShipping, true));
			
			attributeSet.setMandatoryType(MAttributeSet.MANDATORYTYPE_WhenShipping);
			attributeSet.saveEx();
			CacheMgt.get().reset(MAttributeSet.Table_Name, attributeSet.getM_AttributeSet_ID());
			assertFalse(product.isASIMandatoryFor(null, false));
			assertFalse(product.isASIMandatoryFor(null, true));
			assertTrue(product.isASIMandatoryFor(MAttributeSet.MANDATORYTYPE_WhenShipping, true));
			
			assertFalse(product.isUseGuaranteeDateForMPolicy());
			attributeSet.setUseGuaranteeDateForMPolicy(true);
			attributeSet.saveEx();
			CacheMgt.get().reset(MAttributeSet.Table_Name, attributeSet.getM_AttributeSet_ID());
			assertTrue(product.isUseGuaranteeDateForMPolicy());
		} finally {
			attributeSet.setMandatoryType(mandatoryType);
			attributeSet.setUseGuaranteeDateForMPolicy(false);
			attributeSet.saveEx();
		}
	}
	
	@Test
	public void testRemoveStorageRecords() {
		int count = 0;
		
		//make sure there's on hand and reservation records
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id, getTrxName());
		createPOAndMRForProduct(product.get_ID());		
		Query query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
		count = query.setParameters(product.get_ID()).count();
		assertTrue(count > 0, "No Storage On Hand Record");
		query = new Query(Env.getCtx(), MStorageReservation.Table_Name, "M_Product_ID=?", getTrxName());
		count = query.setParameters(product.get_ID()).count();
		assertTrue(count > 0, "No Storage Reservation Record");
		
		//this should fail due to on hand > 0
		product.setIsActive(false);
		assertThrows(AdempiereException.class, () -> product.saveEx());
		
		//clear on hand and reservation so that we can deactivate product
		DB.executeUpdateEx("UPDATE M_StorageOnHand SET QtyOnHand=0 WHERE M_Product_ID=?", new Object[] {product.get_ID()}, getTrxName());
		DB.executeUpdateEx("UPDATE M_StorageReservation SET Qty=0 WHERE M_Product_ID=?", new Object[] {product.get_ID()}, getTrxName());
		product.setIsActive(false);
		product.saveEx();
		
		query = new Query(Env.getCtx(), MStorageOnHand.Table_Name, "M_Product_ID=?", getTrxName());
		count = query.setParameters(product.get_ID()).count();
		assertEquals(0, count, "Storage On Hand Record > 0");
		query = new Query(Env.getCtx(), MStorageReservation.Table_Name, "M_Product_ID=?", getTrxName());
		count = query.setParameters(product.get_ID()).count();
		assertEquals(0, count, "Storage Reservation Record > 0");
	}
	
	@Test
	public void testDeactivateProductBOMValidation() {
		Query query = new Query(Env.getCtx(), MPPProductBOM.Table_Name, MPPProductBOM.COLUMNNAME_PP_Product_BOM_ID+"<1000000"
				+ " AND M_Product_ID NOT IN (SELECT M_Product_ID FROM PP_Product_BOMLine)", getTrxName());
		MPPProductBOM bom = query.setClient_ID().setOnlyActiveRecords(true).first();
		MPPProductBOMLine[] lines = bom.getLines();
		final MProduct product = new MProduct(Env.getCtx(), lines[0].getM_Product_ID(), getTrxName());
		//clear on hand so that exception is not due to QtyOnHand
		DB.executeUpdateEx("UPDATE M_StorageOnHand SET QtyOnHand=0 WHERE M_Product_ID=?", new Object[] {product.get_ID()}, getTrxName());
		product.setIsActive(false);
		assertThrows(AdempiereException.class, () -> product.saveEx(), "No exception throw for deactivation of product in active BOM");
		
		MProduct parent = new MProduct(Env.getCtx(), bom.getM_Product_ID(), getTrxName());
		//clear on hand so that we can deactivate product
		DB.executeUpdateEx("UPDATE M_StorageOnHand SET QtyOnHand=0 WHERE M_Product_ID=?", new Object[] {parent.get_ID()}, getTrxName());
		parent.setIsActive(false);
		parent.saveEx();
		bom.load(getTrxName());
		assertFalse(bom.isActive(), "BOM not auto deactivated after deactivation of parent product");
	}
}
