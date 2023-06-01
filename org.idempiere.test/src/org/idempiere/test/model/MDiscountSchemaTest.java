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
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;

import org.compiere.model.MBPartner;
import org.compiere.model.MDiscountSchema;
import org.compiere.model.MDiscountSchemaBreak;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPriceList;
import org.compiere.model.MPriceListVersion;
import org.compiere.model.MProduct;
import org.compiere.model.MProductPrice;
import org.compiere.process.DocAction;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MDiscountSchemaTest extends AbstractTestCase {

	public MDiscountSchemaTest() {
	}

	@Test
	@Order(1)
	public void testPercentageDiscount() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		//Joe Block
		order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
		order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
		order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
		order.setDocStatus(DocAction.STATUS_Drafted);
		order.setDocAction(DocAction.ACTION_Complete);
		Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
		order.setDatePromised(today);
		order.saveEx();
		
		MOrderLine line1 = new MOrderLine(order);
		line1.setLine(10);
		line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id));
		line1.setQty(new BigDecimal("100"));
		line1.setDatePromised(today);
		line1.saveEx();
		
		MDiscountSchema schema = new MDiscountSchema(Env.getCtx(), DictionaryIDs.M_DiscountSchema.FIVE_PERCENT_DISCOUNT.id, getTrxName());
		MDiscountSchemaBreak[] breaks = schema.getBreaks(false);
		assertTrue(breaks.length > 0, "No discount schema breaks");
		
		MPriceList priceList = MPriceList.get(order.getM_PriceList_ID());
		MPriceListVersion priceListVersion = priceList.getPriceListVersion(order.getDateOrdered());
		MProductPrice[] productPrice = priceListVersion.getProductPrice(" AND M_Product_ID="+DictionaryIDs.M_Product.MULCH.id);
		assertEquals(1, productPrice.length, "Unexpected number of ProductPrice record");
		BigDecimal discounted = MDiscountSchema.calculateDiscountedPrice(productPrice[0].getPriceStd(), breaks[0].getBreakDiscount());
		assertEquals(discounted.setScale(2, RoundingMode.HALF_UP), line1.getPriceActual().setScale(2, RoundingMode.HALF_UP), "Unexpected Order Line price");
	}
	
	@Test
	@Order(2)
	public void testFixedPriceDiscount() {
		BigDecimal fixedPrice = new BigDecimal("1.00");
		MDiscountSchema schema = new MDiscountSchema(Env.getCtx(), DictionaryIDs.M_DiscountSchema.FIVE_PERCENT_DISCOUNT.id, getTrxName());
		MDiscountSchemaBreak discountBreak = null;
		
		try {
			discountBreak = new MDiscountSchemaBreak(Env.getCtx(), 0, null);
			discountBreak.setM_DiscountSchema_ID(schema.getM_DiscountSchema_ID());
			discountBreak.setBreakDiscount(new BigDecimal("0.00"));
			discountBreak.setBreakValue(new BigDecimal("10"));
			discountBreak.setFixedPrice(fixedPrice);
			discountBreak.setM_Product_ID(DictionaryIDs.M_Product.MULCH.id);
			discountBreak.setIsBPartnerFlatDiscount(false);
			discountBreak.setIsActive(true);
			discountBreak.setSeqNo(20);
			discountBreak.saveEx();
			
			CacheMgt.get().reset(MDiscountSchema.Table_Name, schema.get_ID());
			
			MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
			//Joe Block
			order.setBPartner(MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id));
			order.setC_DocTypeTarget_ID(MOrder.DocSubTypeSO_Standard);
			order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
			order.setDocStatus(DocAction.STATUS_Drafted);
			order.setDocAction(DocAction.ACTION_Complete);
			Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
			order.setDatePromised(today);
			order.saveEx();
			
			MOrderLine line1 = new MOrderLine(order);
			line1.setLine(10);
			//Azalea Bush
			line1.setProduct(MProduct.get(Env.getCtx(), DictionaryIDs.M_Product.MULCH.id));
			line1.setQty(new BigDecimal("10"));
			line1.setDatePromised(today);
			line1.saveEx();
				
			assertEquals(fixedPrice, line1.getPriceActual().setScale(2, RoundingMode.HALF_UP), "Unexpected Order Line price");
		} finally {
			rollback();
			if (discountBreak != null && discountBreak.get_ID() > 0)
				discountBreak.deleteEx(true);
		}
	}
}
