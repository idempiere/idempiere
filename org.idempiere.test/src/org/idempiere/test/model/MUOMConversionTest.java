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
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Properties;

import org.compiere.model.MUOM;
import org.compiere.model.MProduct;
import org.compiere.model.MUOMConversion;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;

/**
 * 
 * @author hengsin
 *
 */
public class MUOMConversionTest extends AbstractTestCase {

	public MUOMConversionTest() {
	}

	@Test	
	public void testConversion() {
	
		MUOM each = new MUOM(Env.getCtx(), DictionaryIDs.C_UOM.EACH.id, getTrxName());
		MUOM hour = new MUOM(Env.getCtx(), DictionaryIDs.C_UOM.HOUR.id, getTrxName());
		
		//conversion1 at system level
		MUOMConversion conv1 = new MUOMConversion(each);
		conv1.set_TrxName(null);
		conv1.setC_UOM_To_ID(DictionaryIDs.C_UOM.HOUR.id);
		conv1.setMultiplyRate(new BigDecimal("1.15"));
		conv1.setDivideRate(BigDecimal.ZERO);
		conv1.saveCrossTenantSafeEx();
		
		MUOMConversion conv2 = null;
		MUOMConversion conv3 = null;
		try {
			BigDecimal converted = MUOMConversion.convertProductTo(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"));
			assertEquals(new BigDecimal("1.15"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"), -1);
			assertEquals(new BigDecimal("1.15"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"), 1);
			assertEquals(new BigDecimal("1.2"), converted);
			
			//conversion2 at tenant level
			conv2 = new MUOMConversion(Env.getCtx(), 0, null);
			conv2.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			conv2.setC_UOM_To_ID(DictionaryIDs.C_UOM.HOUR.id);
			conv2.setMultiplyRate(new BigDecimal("1.35"));
			conv2.saveEx();
			
			converted = MUOMConversion.convertProductTo(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"));
			assertEquals(new BigDecimal("1.35"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"), -1);
			assertEquals(new BigDecimal("1.35"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"), 1);
			assertEquals(new BigDecimal("1.4"), converted);
			
			//conversion3 at tenant and product level
			conv3 = new MUOMConversion(Env.getCtx(), 0, null);
			conv3.setM_Product_ID(DictionaryIDs.M_Product.OAK.id);
			conv3.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			conv3.setC_UOM_To_ID(DictionaryIDs.C_UOM.HOUR.id);
			conv3.setMultiplyRate(new BigDecimal("0.75"));
			conv3.saveEx();
			CacheMgt.get().reset();
			
			converted = MUOMConversion.convertProductTo(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"));
			assertEquals(new BigDecimal("0.75"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"), -1);
			assertEquals(new BigDecimal("0.75"), converted);
			converted = MUOMConversion.convertProductTo(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"), 1);
			assertEquals(new BigDecimal("0.8"), converted);
			
			converted = MUOMConversion.convertProductFrom(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"));
			assertEquals(hour.round(conv3.getDivideRate(),true), converted);
			
			conv3.deleteEx(true);
			conv3 = null;
			CacheMgt.get().reset();
			converted = MUOMConversion.convertProductFrom(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"));
			assertEquals(hour.round(conv2.getDivideRate(),true), converted);
			converted = MUOMConversion.convertProductFrom(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"), 1);
			assertEquals(conv2.getDivideRate().setScale(1, RoundingMode.HALF_UP), converted);
			
			conv2.deleteEx(true);
			conv2 = null;
			converted = MUOMConversion.convertProductFrom(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"));
			assertEquals(hour.round(conv1.getDivideRate(),true), converted);
			converted = MUOMConversion.convertProductFrom(Env.getCtx(), DictionaryIDs.M_Product.OAK.id, DictionaryIDs.C_UOM.HOUR.id, new BigDecimal("1"), 1);
			assertEquals(conv1.getDivideRate().setScale(1, RoundingMode.HALF_UP), converted);
		} finally {
			rollback();
			DB.executeUpdateEx("DELETE FROM C_UOM_Conversion WHERE C_UOM_Conversion_ID=?", new Object[] {conv1.get_ID()}, null);
			if (conv2 != null)
				conv2.deleteEx(true);
			if (conv3 != null)
				conv3.deleteEx(true);
		}
	}

	/**
	 * Test intermediate (2-hop) UOM conversion: Day to Minutes via Hours.
	 *
	 * Setup:
	 *   - New product with Day as the default UOM (saved in test transaction, mocked via mockStatic)
	 *   - Generic conversion: Day → Hour, MultiplyRate = 24  (1 Day = 24 Hours)
	 *   - Generic conversion: Hour → Minute, MultiplyRate = 60 (1 Hour = 60 Minutes)
	 *   - No direct Day → Minute record exists
	 *
	 * Expected: getRateUsingCommonUOM derives 1 Day = 24 * 60 = 1440 Minutes via intermediate Hour.
	 * Also verifies the reverse: 1440 Minutes → 1 Day.
	 *
	 * Pattern: mockStatic(MProduct.class) is used so the product is saved inside the test
	 * transaction (rolls back automatically) while MProduct.get() calls still return it.
	 * UOM conversion records are committed (trxName=null) because getRateUsingCommonUOM
	 * queries outside any transaction; they are deleted explicitly in finally.
	 */
	@Test
	public void testIntermediateConversionDayToMinutes()
	{
		int UOM_DAY_ID = DictionaryIDs.C_UOM.DAY.id;
		int UOM_HOUR_ID = DictionaryIDs.C_UOM.HOUR.id;
		int UOM_MINUTE_ID = DictionaryIDs.C_UOM.MINUTES.id;

		// Conversion 1: Day → Hour, MultiplyRate=24
		MUOMConversion convDayToHour = new MUOMConversion(Env.getCtx(), 0, null);
		convDayToHour.setC_UOM_ID(UOM_DAY_ID);
		convDayToHour.setC_UOM_To_ID(UOM_HOUR_ID);
		convDayToHour.setMultiplyRate(new BigDecimal("24"));
		convDayToHour.setDivideRate(BigDecimal.ZERO);
		convDayToHour.saveEx();

		// Conversion 2: Hour → Minute, MultiplyRate=60
		MUOMConversion convHourToMin = new MUOMConversion(Env.getCtx(), 0, null);
		convHourToMin.setC_UOM_ID(UOM_HOUR_ID);
		convHourToMin.setC_UOM_To_ID(UOM_MINUTE_ID);
		convHourToMin.setMultiplyRate(new BigDecimal("60"));
		convHourToMin.setDivideRate(BigDecimal.ZERO);
		convHourToMin.saveEx();

		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class))
		{
			// Product saved IN the test transaction — rolled back automatically.
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setName("TestProduct_DayUOM");
			product.setC_UOM_ID(UOM_DAY_ID);
			product.setIsStocked(false);
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
			product.saveEx();

			// Wire all real MProduct.get() overloads through, then intercept our product's ID.
			mockedProduct.when(() -> MProduct.getCopy(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(anyInt())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(any(Properties.class), anyInt())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()))).thenReturn(product);
			mockedProduct.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);

			CacheMgt.get().reset();

			// --- Step 1: verify the two direct conversions ---

			// Day → Hour = 24
			BigDecimal dayToHour = MUOMConversion.getRate(Env.getCtx(), UOM_DAY_ID, UOM_HOUR_ID);
			assertNotNull(dayToHour, "Day → Hour rate should not be null");
			assertEquals(0, new BigDecimal("24").compareTo(dayToHour), "1 Day should equal 24 Hours");

			// Hour → Minute = 60
			BigDecimal hourToMin = MUOMConversion.getRate(Env.getCtx(), UOM_HOUR_ID, UOM_MINUTE_ID);
			assertNotNull(hourToMin, "Hour → Minute rate should not be null");
			assertEquals(0, new BigDecimal("60").compareTo(hourToMin), "1 Hour should equal 60 Minutes");

			// --- Step 2: intermediate conversion Day → Minute (no direct record) ---

			// Day → Minute = 1440
			BigDecimal dayToMin = MUOMConversion.getRate(Env.getCtx(), UOM_DAY_ID, UOM_MINUTE_ID);
			assertNotNull(dayToMin, "Day → Minute intermediate rate should not be null");
			assertEquals(	0, new BigDecimal("1440").compareTo(dayToMin.setScale(0, RoundingMode.HALF_UP)),
							"1 Day should equal 1440 Minutes via intermediate Hour conversion (24 * 60)");

			// --- Step 3: convert 10 Day → Minutes ---

			// 10 Day → Minute = 14400
			MUOM minuteUOM = MUOM.get(Env.getCtx(), UOM_MINUTE_ID);
			BigDecimal converted = MUOMConversion.convert(Env.getCtx(), UOM_DAY_ID, UOM_MINUTE_ID, BigDecimal.TEN);
			assertNotNull(converted, "Converted 10 Day → Minutes should not be null");
			assertEquals(0, minuteUOM.round(new BigDecimal("14400"), true).compareTo(converted), "Converting 10 Day to Minutes should yield 14400");

			// --- Step 4: reverse intermediate — Minute → Day (no direct record) ---

			// 1440 Minutes × (1/1440) = 1 Day
			BigDecimal minToDay = MUOMConversion.getRate(Env.getCtx(), UOM_MINUTE_ID, UOM_DAY_ID);
			assertNotNull(minToDay, "Minute → Day reverse intermediate rate should not be null");
			BigDecimal roundTrip = new BigDecimal("1440").multiply(minToDay);
			assertEquals(0, BigDecimal.ONE.compareTo(roundTrip.setScale(0, RoundingMode.HALF_UP)), "1440 Minutes × (1/1440) should round-trip to 1 Day");

			// --- Step 5: product-level intermediate conversion ---

			// convertProductTo ( product[Day], Minutes ) : 1 Day → 1440 Minutes
			BigDecimal prodToRate = MUOMConversion.convertProductTo(Env.getCtx(), product.getM_Product_ID(), UOM_MINUTE_ID, BigDecimal.ONE);
			assertNotNull(prodToRate, "convertProductTo Day product with Minutes should not be null");
			assertEquals(0, minuteUOM.round(new BigDecimal("1440"), true).compareTo(prodToRate), "convertProductTo 1 Day → Minutes should yield 1440");

			// convertProductFrom ( product[Day], Minutes ) : rate from 7200 Minutes → Day, via Hour
			BigDecimal prodFromRate = MUOMConversion.convertProductFrom(Env.getCtx(), product.getM_Product_ID(), UOM_MINUTE_ID, new BigDecimal("7200"));
			assertNotNull(prodFromRate, "convertProductFrom Day product with Minutes should not be null");
			assertEquals(0, minuteUOM.round(new BigDecimal("5"), true).compareTo(prodFromRate), "convertProductFrom 7200 Minutes → Day should yield 5");
		}
		finally
		{
			// Product is in the test transaction — rolled back automatically by rollback().
			// UOM conversions were committed outside the transaction — delete explicitly.
			rollback();
			convDayToHour.deleteEx(true);
			convHourToMin.deleteEx(true);
		}
	} // testIntermediateConversionDayToMinutes
}
