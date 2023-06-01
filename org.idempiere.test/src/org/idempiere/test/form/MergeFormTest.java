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
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;

import org.compiere.apps.form.Merge;
import org.compiere.model.MBPartner;
import org.compiere.model.MBPartnerLocation;
import org.compiere.model.MLocation;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.model.MUser;
import org.compiere.model.MUserDefWin;
import org.compiere.model.PO;
import org.compiere.model.SystemIDs;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MergeFormTest extends AbstractTestCase {

	public MergeFormTest() {
	}

	@Test
	public void testMergeProduct() {

		MProduct p1 = null;
		MProduct p2 = null;
		MProductPrice pp1 = null;
		MProductPrice pp2 = null;
		MOrder order1 = null;
		MOrderLine ol1 = null;
		MOrder order2 = null;
		MOrderLine ol2 = null;
		
		try {

			p1 = new MProduct(Env.getCtx(), 0, null);
			p1.setName("testMergeProduct1");
			p1.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p1.setProductType(MProduct.PRODUCTTYPE_Item);
			p1.setIsStocked(false);
			p1.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p1.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p1.saveEx();

			p2 = new MProduct(Env.getCtx(), 0, null);
			p2.setName("testMergeProduct2");
			p2.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			p2.setProductType(MProduct.PRODUCTTYPE_Item);
			p2.setIsStocked(false);
			p2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			p2.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			p2.saveEx();

			MPriceList pl = MPriceList.get(DictionaryIDs.M_PriceList.STANDARD.id);
			MPriceListVersion plv = pl.getPriceListVersion(null);
			pp1 = new MProductPrice(Env.getCtx(), 0, null);
			pp1.setM_PriceList_Version_ID(plv.get_ID());
			pp1.setM_Product_ID(p1.getM_Product_ID());
			pp1.setPrices(new BigDecimal("1"), new BigDecimal("1"), new BigDecimal("1"));
			pp1.saveEx();

			pp2 = new MProductPrice(Env.getCtx(), 0, null);
			pp2.setM_PriceList_Version_ID(plv.get_ID());
			pp2.setM_Product_ID(p2.getM_Product_ID());
			pp2.setPrices(new BigDecimal("1"), new BigDecimal("1"), new BigDecimal("1"));
			pp2.saveEx();

			order1 = new MOrder(Env.getCtx(), 0, null);
			order1.setIsSOTrx(true);
			order1.setC_DocTypeTarget_ID();
			order1.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			order1.saveEx();

			ol1 = new MOrderLine(order1);
			ol1.setM_Product_ID(p1.get_ID());
			ol1.setQty(new BigDecimal("1"));
			ol1.saveEx();

			order2 = new MOrder(Env.getCtx(), 0, null);
			order2.setIsSOTrx(true);
			order2.setC_DocTypeTarget_ID();
			order2.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			order2.saveEx();

			ol2 = new MOrderLine(order1);
			ol2.setM_Product_ID(p2.get_ID());
			ol2.setQty(new BigDecimal("1"));
			ol2.saveEx();

			Merge merge = new Merge();
			boolean ok = merge.merge(Merge.M_PRODUCT_ID, p1.get_ID(), p2.get_ID());
			assertTrue(ok, "Merge fail");
			ol1.load(null);
			assertEquals(p2.get_ID(), ol1.getM_Product_ID(), "Unexpected order line M_Product_ID after merge");
			ol2.load(null);
			assertEquals(p2.get_ID(), ol2.getM_Product_ID(), "Unexpected order line M_Product_ID after merge");
			pp1.load(null);
			assertEquals(0, pp1.get_ID(), "Product Price not deleted after merge");
			p1.load(null);
			assertEquals(0, p1.get_ID(), "Product not deleted after merge");
		} finally {
			if (pp1 != null && pp1.get_ID() > 0)
				pp1.deleteEx(true);
			if (pp2 != null && pp2.get_ID() > 0)
				pp2.deleteEx(true);
			if (ol1 != null && ol1.get_ID() > 0)
				ol1.deleteEx(true);
			if (ol2 != null && ol2.get_ID() > 0)
				ol2.deleteEx(true);
			if (order1 != null && order1.get_ID() > 0)
				order1.deleteEx(true);
			if (order2 != null && order2.get_ID() > 0)
				order2.deleteEx(true);
			if (p1 != null && p1.get_ID() > 0)
				p1.deleteEx(true);
			if (p2 != null && p2.get_ID() > 0)
				p2.deleteEx(true);
		}
	}
	
	@Test
	public void testMergeBPartner() {
		MBPartner bp1 = null;
		MBPartner bp2 = null;
		MOrder o1 = null;
		MOrder o2 = null;
		try {
			MBPartner jb = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id);
			MBPartnerLocation bpl = jb.getPrimaryC_BPartner_Location();
			MLocation loc = new MLocation(Env.getCtx(), bpl.getC_Location_ID(), null);
			
			bp1 = new MBPartner(Env.getCtx(), 0, null);
			bp1.setName("testMergeBPartner1");
			bp1.setIsCustomer(true);
			bp1.setC_BP_Group_ID(jb.getC_BP_Group_ID());
			bp1.saveEx();
			MLocation loc1 = new MLocation(Env.getCtx(), 0, null);
			PO.copyValues(loc, loc1);
			loc1.saveEx();
			MBPartnerLocation bpl1 = new MBPartnerLocation(bp1);
			bpl1.setC_Location_ID(loc1.get_ID());
			bpl1.setIsShipTo(true);
			bpl1.setIsBillTo(true);
			bpl1.saveEx();
			
			bp2 = new MBPartner(Env.getCtx(), 0, null);
			bp2.setName("testMergeBPartner2");
			bp2.setIsCustomer(true);
			bp2.setC_BP_Group_ID(bp1.getC_BP_Group_ID());
			bp2.saveEx();
			MLocation loc2 = new MLocation(Env.getCtx(), 0, null);
			PO.copyValues(loc, loc2);
			loc2.saveEx();
			MBPartnerLocation bpl2 = new MBPartnerLocation(bp2);
			bpl2.setC_Location_ID(loc2.get_ID());
			bpl2.setIsShipTo(true);
			bpl2.setIsBillTo(true);
			bpl2.saveEx();
			
			o1 = new MOrder(Env.getCtx(), 0, null);
			o1.setIsSOTrx(true);
			o1.setC_DocTypeTarget_ID();
			o1.setBPartner(bp1);
			o1.saveEx();
			
			o2 = new MOrder(Env.getCtx(), 0, null);
			o2.setIsSOTrx(true);
			o2.setC_DocTypeTarget_ID();
			o2.setBPartner(bp2);
			o2.saveEx();
			
			Merge merge = new Merge();
			boolean ok = merge.merge(Merge.C_BPARTNER_ID, bp1.get_ID(), bp2.get_ID());
			assertTrue(ok, "Merge fail");
			o1.load(null);
			assertEquals(bp2.get_ID(), o1.getC_BPartner_ID(), "Unexpected order line C_BPartner_ID after merge");
			o2.load(null);
			assertEquals(bp2.get_ID(), o2.getC_BPartner_ID(), "Unexpected order line C_BPartner_ID after merge");
			bp1.load(null);
			assertEquals(0, bp1.get_ID(), "BPartner not deleted after merge");
		} finally {
			if (o1 != null && o1.get_ID() > 0)
				o1.deleteEx(true);
			if (o2 != null && o2.get_ID() > 0)
				o2.deleteEx(true);
			if (bp1 != null && bp1.get_ID() > 0)
				bp1.deleteEx(true);
			if (bp2 != null && bp2.get_ID() > 0)
				bp2.deleteEx(true);			
		}
	}
	
	@Test
	public void testMergeUser() {
		MUser u1 = null;
		MUser u2 = null;
		MUserDefWin udw = null;
		
		try {
			u1 = new MUser(Env.getCtx(), 0, null);
			u1.setName("testMergeUser1");
			u1.saveEx();
			
			u2 = new MUser(Env.getCtx(), 0, null);
			u2.setName("testMergeUser2");
			u2.saveEx();
			
			udw = new MUserDefWin(Env.getCtx(), 0, null);
			udw.setAD_User_ID(u1.get_ID());
			udw.setAD_Window_ID(SystemIDs.WINDOW_SALES_ORDER);
			udw.saveEx();
			
			Merge merge = new Merge();
			boolean ok = merge.merge(Merge.AD_USER_ID, u1.get_ID(), u2.get_ID());
			assertTrue(ok, "Merge fail");
			
			u1.load(null);
			assertEquals(0, u1.get_ID(), "User not deleted after merge");
			udw.load(null);
			assertEquals(u2.get_ID(), udw.getAD_User_ID(), "Unexpected MUserDefWin.AD_User_ID after merge");
		} finally {
			if (udw != null && udw.get_ID() > 0)
				udw.deleteEx(true);
			if (u1 != null && u1.get_ID() > 0)
				u1.deleteEx(true);
			if (u2 != null && u2.get_ID() > 0)
				u2.deleteEx(true);
		}
	}
}
