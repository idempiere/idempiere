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

import java.math.BigDecimal;
import java.math.RoundingMode;

import org.compiere.model.MUOM;
import org.compiere.model.MUOMConversion;
import org.compiere.model.PO;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class MUOMConversionTest extends AbstractTestCase {

	private final static int EACH_ID = 100;
	private final static int HOUR_ID = 101;
	private static final int PRODUCT_OAK_TREE = 123;
	
	public MUOMConversionTest() {
	}

	@Test	
	public void testConversion() {
	
		MUOM each = new MUOM(Env.getCtx(), EACH_ID, getTrxName());
		MUOM hour = new MUOM(Env.getCtx(), HOUR_ID, getTrxName());
		
		//conversion1 at system level
		MUOMConversion conv1 = new MUOMConversion(each);
		conv1.set_TrxName(null);
		conv1.setC_UOM_To_ID(HOUR_ID);
		conv1.setMultiplyRate(new BigDecimal("1.15"));
		conv1.setDivideRate(BigDecimal.ZERO);
		try {
			PO.setCrossTenantSafe();
			conv1.saveEx();
		} finally {
			PO.clearCrossTenantSafe();
		}
		
		MUOMConversion conv2 = null;
		MUOMConversion conv3 = null;
		try {
			BigDecimal converted = MUOMConversion.convertProductTo(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"));
			assertEquals(new BigDecimal("1.15"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"), -1);
			assertEquals(new BigDecimal("1.15"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"), 1);
			assertEquals(new BigDecimal("1.2"), converted);
			
			//conversion2 at tenant level
			conv2 = new MUOMConversion(Env.getCtx(), 0, null);
			conv2.setC_UOM_ID(EACH_ID);
			conv2.setC_UOM_To_ID(HOUR_ID);
			conv2.setMultiplyRate(new BigDecimal("1.35"));
			conv2.saveEx();
			
			converted = MUOMConversion.convertProductTo(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"));
			assertEquals(new BigDecimal("1.35"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"), -1);
			assertEquals(new BigDecimal("1.35"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"), 1);
			assertEquals(new BigDecimal("1.4"), converted);
			
			//conversion3 at tenant and product level
			conv3 = new MUOMConversion(Env.getCtx(), 0, null);
			conv3.setM_Product_ID(PRODUCT_OAK_TREE);
			conv3.setC_UOM_ID(EACH_ID);
			conv3.setC_UOM_To_ID(HOUR_ID);
			conv3.setMultiplyRate(new BigDecimal("0.75"));
			conv3.saveEx();
			CacheMgt.get().reset();
			
			converted = MUOMConversion.convertProductTo(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"));
			assertEquals(new BigDecimal("0.75"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"), -1);
			assertEquals(new BigDecimal("0.75"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"), 1);
			assertEquals(new BigDecimal("0.8"), converted);
			
			converted = MUOMConversion.convertProductFrom(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"));
			assertEquals(hour.round(conv3.getDivideRate(),true), converted);
			
			conv3.deleteEx(true);
			conv3 = null;
			CacheMgt.get().reset();
			converted = MUOMConversion.convertProductFrom(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"));
			assertEquals(hour.round(conv2.getDivideRate(),true), converted);
			converted = MUOMConversion.convertProductFrom(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"), 1);
			assertEquals(conv2.getDivideRate().setScale(1, RoundingMode.HALF_UP), converted);
			
			conv2.deleteEx(true);
			conv2 = null;
			converted = MUOMConversion.convertProductFrom(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"));
			assertEquals(hour.round(conv1.getDivideRate(),true), converted);
			converted = MUOMConversion.convertProductFrom(Env.getCtx(), PRODUCT_OAK_TREE, HOUR_ID, new BigDecimal("1"), 1);
			assertEquals(conv1.getDivideRate().setScale(1, RoundingMode.HALF_UP), converted);
		} finally {
			DB.executeUpdateEx("DELETE FROM C_UOM_Conversion WHERE C_UOM_Conversion_ID=?", new Object[] {conv1.get_ID()}, null);
			if (conv2 != null)
				conv2.deleteEx(true);
			if (conv3 != null)
				conv3.deleteEx(true);
		}
	}
}
