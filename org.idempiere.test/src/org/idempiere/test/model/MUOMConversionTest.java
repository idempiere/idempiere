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
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mockStatic;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Properties;

import org.compiere.model.MProduct;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUOM;
import org.compiere.model.MUOMConversion;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
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
	 * Verifies intermediate Unit of Measure (UOM) conversions using both the default
	 * derived conversion rates and custom conversion records.
	 * <p>
	 * This test validates the following scenarios:
	 * <ul>
	 * <li>Default derived conversions:
	 * <ul>
	 * <li>1 Day = 24 Hours</li>
	 * <li>1 Hour = 60 Minutes</li>
	 * <li>1 Day = 1440 Minutes (via Hour)</li>
	 * </ul>
	 * </li>
	 * <li>Custom conversion records overriding the derived rates:
	 * <ul>
	 * <li>1 Day = 10 Hours</li>
	 * <li>1 Hour = 55 Minutes</li>
	 * <li>1 Day = 550 Minutes (via Hour)</li>
	 * </ul>
	 * </li>
	 * </ul>
	 * <p>
	 * For each scenario, the test verifies:
	 * <ul>
	 * <li>Direct conversion rates.</li>
	 * <li>Intermediate conversion rate (Day → Minute).</li>
	 * <li>Quantity conversion using
	 * {@link MUOMConversion#convert(Properties, int, int, BigDecimal)}.</li>
	 * <li>Reverse intermediate conversion (Minute → Day).</li>
	 * <li>Product-based conversions using
	 * {@link MUOMConversion#convertProductTo(Properties, int, int, BigDecimal)} and
	 * {@link MUOMConversion#convertProductFrom(Properties, int, int, BigDecimal)}.</li>
	 * </ul>
	 * <p>
	 * Custom {@link MUOMConversion} records are committed outside the test
	 * transaction and are explicitly removed during cleanup.
	 */
	@Test
	public void testIntermediateConversionWithDerivedAndCustomRates_DayHourMinutes()
	{
		int UOM_DAY_ID = DictionaryIDs.C_UOM.DAY.id;
		int UOM_HOUR_ID = DictionaryIDs.C_UOM.HOUR.id;
		int UOM_MINUTE_ID = DictionaryIDs.C_UOM.MINUTES.id;

		MUOMConversion convDayToHour = null;
		MUOMConversion convHourToMin = null;
		try (MockedStatic<MProduct> mockedProduct = mockStatic(MProduct.class))
		{
			// Product is saved in the test transaction and rolled back automatically.
			MProduct product = createProduct("TestProduct_DayUOM", UOM_DAY_ID, getTrxName());

			// Wire all real MProduct.get() overloads through, then intercept our product's ID.
			mockedProduct.when(() -> MProduct.getCopy(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(anyInt())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(any(Properties.class), anyInt(), any())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(any(Properties.class), anyInt())).thenCallRealMethod();
			mockedProduct.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()))).thenReturn(product);
			mockedProduct.when(() -> MProduct.get(any(Properties.class), eq(product.get_ID()), any())).thenReturn(product);

			// Verify that the default derived rates are correct:
			// 1 Day = 24 Hours, 1 Hour = 60 Minutes, so 1 Day = 1440 Minutes.
			assertIntermediateConversion("Default Derived Rates", product, UOM_DAY_ID, UOM_HOUR_ID, UOM_MINUTE_ID, 24, 60, 1440);

			// ---------------------------------------------------------------------------------------------------------
			// Create custom conversion rates for this test, which will be committed outside the
			// transaction and must be deleted explicitly in the finally block.
			//
			// Day → Hour = 10, Hour → Minute = 55, so Day → Minute = 550.
			// ---------------------------------------------------------------------------------------------------------
			convDayToHour = createUOMConversion(0, UOM_DAY_ID, UOM_HOUR_ID, BigDecimal.valueOf(10), BigDecimal.ZERO);
			convHourToMin = createUOMConversion(0, UOM_HOUR_ID, UOM_MINUTE_ID, BigDecimal.valueOf(55), BigDecimal.ZERO);

			// Verify that the intermediate conversion now reflects the custom rates, overriding the
			// default derived rates.
			// 1 Day = 10 Hours, 1 Hour = 55 Minutes, so 1 Day = 550 Minutes.
			assertIntermediateConversion("Custom Conversion Rates", product, UOM_DAY_ID, UOM_HOUR_ID, UOM_MINUTE_ID, 10, 55, 550);
		}
		finally
		{
			rollback();
			// UOM conversions were committed outside the transaction — delete explicitly.
			deleteUOMConversion(convDayToHour);
			deleteUOMConversion(convHourToMin);
		}
	} // testIntermediateConversionWithDerivedAndCustomRates_DayHourMinutes

	/**
	 * Verifies an intermediate UOM conversion path for a product using the expected
	 * conversion rates.
	 * <p>
	 * The following conversions are validated:
	 * <ul>
	 * <li>Direct conversion (Day → Hour).</li>
	 * <li>Direct conversion (Hour → Minute).</li>
	 * <li>Intermediate conversion (Day → Minute).</li>
	 * <li>Quantity conversion for 10 Days.</li>
	 * <li>Reverse intermediate conversion (Minute → Day).</li>
	 * <li>Product-based conversions using
	 * {@link MUOMConversion#convertProductTo(Properties, int, int, BigDecimal)}
	 * and
	 * {@link MUOMConversion#convertProductFrom(Properties, int, int, BigDecimal)}.</li>
	 * </ul>
	 *
	 * @param scenario               descriptive name used in assertion failure messages
	 * @param product                test product whose UOM is Day
	 * @param dayUomID               Day UOM ID
	 * @param hourUomID              Hour UOM ID
	 * @param minuteUomID            Minute UOM ID
	 * @param expectedHoursPerDay    expected Day → Hour conversion rate
	 * @param expectedMinutesPerHour expected Hour → Minute conversion rate
	 * @param expectedMinutesPerDay  expected intermediate Day → Minute conversion rate
	 */
	private void assertIntermediateConversion(	String scenario, MProduct product, int dayUomID, int hourUomID, int minuteUomID,
												int expectedHoursPerDay, int expectedMinutesPerHour, int expectedMinutesPerDay)
	{
		// -----------------------------------------------------------------
		// Step 1 : Verify direct conversion rates
		// -----------------------------------------------------------------

		BigDecimal dayToHour = MUOMConversion.getRate(Env.getCtx(), dayUomID, hourUomID);
		assertNotNull(dayToHour, scenario + ": Day → Hour conversion rate should not be null");
		assertEquals(	0, BigDecimal.valueOf(expectedHoursPerDay).compareTo(dayToHour),
						scenario + ": Expected Day → Hour conversion rate to be " + expectedHoursPerDay);

		BigDecimal hourToMinute = MUOMConversion.getRate(Env.getCtx(), hourUomID, minuteUomID);
		assertNotNull(hourToMinute, scenario + ": Hour → Minute conversion rate should not be null");
		assertEquals(	0, BigDecimal.valueOf(expectedMinutesPerHour).compareTo(hourToMinute),
						scenario + ": Expected Hour → Minute conversion rate to be " + expectedMinutesPerHour);

		// -----------------------------------------------------------------
		// Step 2 : Verify intermediate conversion
		// -----------------------------------------------------------------

		BigDecimal dayToMinute = MUOMConversion.getRate(Env.getCtx(), dayUomID, minuteUomID);
		assertNotNull(dayToMinute, scenario + ": Day → Minute intermediate conversion rate should not be null");
		assertEquals(	0, BigDecimal.valueOf(expectedMinutesPerDay).compareTo(dayToMinute.setScale(0, RoundingMode.HALF_UP)),
						scenario + ": Expected Day → Minute intermediate conversion rate to be " + expectedMinutesPerDay);

		// -----------------------------------------------------------------
		// Step 3 : Verify quantity conversion
		// -----------------------------------------------------------------

		MUOM minuteUOM = MUOM.get(Env.getCtx(), minuteUomID);
		BigDecimal converted = MUOMConversion.convert(Env.getCtx(), dayUomID, minuteUomID, BigDecimal.TEN);
		assertNotNull(converted, scenario + ": Converted quantity should not be null");
		assertEquals(	0, minuteUOM.round(BigDecimal.valueOf(expectedMinutesPerDay * 10L), true).compareTo(converted),
						scenario + ": Converting 10 Days should produce " + (expectedMinutesPerDay * 10L) + " Minutes");

		// -----------------------------------------------------------------
		// Step 4 : Verify reverse intermediate conversion
		// -----------------------------------------------------------------

		BigDecimal minuteToDay = MUOMConversion.getRate(Env.getCtx(), minuteUomID, dayUomID);
		assertNotNull(minuteToDay, scenario + ": Minute → Day reverse conversion rate should not be null");
		BigDecimal roundTrip = BigDecimal.valueOf(expectedMinutesPerDay).multiply(minuteToDay);
		assertEquals(	0, BigDecimal.ONE.compareTo(roundTrip.setScale(0, RoundingMode.HALF_UP)),
						scenario + ": Reverse intermediate conversion should round-trip back to exactly 1 Day");

		// -----------------------------------------------------------------
		// Step 5 : Verify product conversions
		// -----------------------------------------------------------------

		BigDecimal productTo = MUOMConversion.convertProductTo(Env.getCtx(), product.getM_Product_ID(), minuteUomID, BigDecimal.ONE);
		assertNotNull(productTo, scenario + ": convertProductTo() result should not be null");
		assertEquals(	0, minuteUOM.round(BigDecimal.valueOf(expectedMinutesPerDay), true).compareTo(productTo),
						scenario + ": convertProductTo() should convert 1 Day to " + expectedMinutesPerDay + " Minutes");

		BigDecimal productFrom = MUOMConversion.convertProductFrom(	Env.getCtx(), product.getM_Product_ID(), minuteUomID,
																	BigDecimal.valueOf(expectedMinutesPerDay * 5L));
		assertNotNull(productFrom, scenario + ": convertProductFrom() result should not be null");
		assertEquals(	0, BigDecimal.valueOf(5).compareTo(productFrom),
						scenario + ": convertProductFrom() should convert " + (expectedMinutesPerDay * 5L) + " Minutes back to 5 Days");
	} // assertIntermediateConversion

	/**
	 * Verifies UOM conversion resolution across three layers: generic rates,
	 * product-specific rates, and {@code getRateUsingCommonUOM()}'s bridging
	 * behavior when a product's own conversions imply a different ratio than
	 * the generic direct conversion for the same UOM pair.
	 * <p>
	 * Conversion setup:
	 * 
	 * <pre>
	 *   Product Pen (product-specific, overrides generic where defined)
	 *     1 Box    = 12 Pens
	 *     1 Carton = 240 Pens
	 *     1 Carton = 20 Box     (implied: 240 / 12)
	 *
	 *   Generic (applies to any product with no override, e.g. Product Screw)
	 *     1 Box    = 100 Screws
	 *     1 Carton = 1000 Screws
	 *     1 Carton = 10 Box     (direct generic conversion record)
	 * </pre>
	 * 
	 * Note the deliberate mismatch: Pen's own EA-based data implies
	 * {@code 1 Carton = 20 Box}, while the generic direct conversion for the
	 * same pair says {@code 1 Carton = 10 Box}. This is used in Step 6 to
	 * verify that {@code getRateUsingCommonUOM()} prefers a rate derived from
	 * a product's own conversions over a generic direct match.
	 */
	@Test
	public void testProductPenUOMConversionSteps()
	{
		MUOM uomBox = null;
		MUOM uomCarton = null;

		MProduct pen = null;
		MProduct screw = null;

		MUOMConversion convEaToBox = null;
		MUOMConversion convBoxToCarton = null;
		MUOMConversion convEaToBoxPen = null;
		MUOMConversion convEaToCartonPen = null;

		MSysConfig sysConfig = null;
		boolean isSysConfigUpdated = false;

		try
		{
			String sysValue = MSysConfig.getValue(MSysConfig.ProductUOMConversionRateValidate, GARDEN_WORLD_CLIENT);
			if (Util.isEmpty(sysValue, true))
			{
				sysConfig = new MSysConfig(Env.getCtx(), 0, null);
				sysConfig.setConfigurationLevel(MSysConfig.CONFIGURATIONLEVEL_Client);
				sysConfig.setName(MSysConfig.ProductUOMConversionRateValidate);
				sysConfig.setEntityType(MSysConfig.ENTITYTYPE_UserMaintained);
				sysConfig.setAD_Org_ID(0);
				sysConfig.setValue("N");
				sysConfig.saveEx();
			}
			else if (sysValue.equals("Y"))
			{
				isSysConfigUpdated = true;
				DB.executeUpdateEx(	"UPDATE AD_SysConfig SET Value = 'N' WHERE Name=? AND AD_Client_ID=?",
									new Object[] { MSysConfig.ProductUOMConversionRateValidate, GARDEN_WORLD_CLIENT }, null);
			}

			// Create UOMs
			uomBox = createUOM("TestBox", "TstB", 6);
			uomCarton = createUOM("TestCarton", "TstC", 6);
			int uomEachID = DictionaryIDs.C_UOM.EACH.id;
			int uomBoxID = uomBox.getC_UOM_ID();
			int uomCartonID = uomCarton.getC_UOM_ID();

			// Create Products
			pen = createProduct("Product_Pen", uomEachID, null);
			screw = createProduct("Product_Screw", uomEachID, null);
			int productPenID = pen.getM_Product_ID();
			int productScrewID = screw.getM_Product_ID();

			// Define Conversions

			// Generic Conversions (applies to all products)
			// EA = Box ( 100 EA = 1 Box )
			convEaToBox = createUOMConversion(0, uomBoxID, uomEachID, BigDecimal.valueOf(100), BigDecimal.ZERO);

			// Box = Carton ( 10 Box = 1 Carton )
			convBoxToCarton = createUOMConversion(0, uomCartonID, uomBoxID, BigDecimal.valueOf(10), BigDecimal.ZERO);

			// Product-Specific Conversions
			// PEN (12 EA = 1 Box )
			convEaToBoxPen = createUOMConversion(productPenID, uomEachID, uomBoxID, BigDecimal.ZERO, BigDecimal.valueOf(12));

			// PEN ( 240 EA -> 1 Carton )
			convEaToCartonPen = createUOMConversion(productPenID, uomEachID, uomCartonID, BigDecimal.ZERO, BigDecimal.valueOf(240));

			//
			CacheMgt.get().reset();

			// ----------------------------------------------------------------------
			// Step 1 : Verify Generic Conversion Rates
			// ----------------------------------------------------------------------

			BigDecimal rateEaToBox = MUOMConversion.getRate(Env.getCtx(), uomEachID, uomBoxID);
			assertNotNull(rateEaToBox, "Generic EA -> Box conversion rate should exist.");
			assertEquals(	0, BigDecimal.valueOf(0.01).compareTo(rateEaToBox.setScale(2, RoundingMode.HALF_UP)),
							"Generic EA -> Box conversion is incorrect. Expected 100 EA = 1 Box.");

			BigDecimal rateBoxToCarton = MUOMConversion.getRate(Env.getCtx(), uomBoxID, uomCartonID);
			assertNotNull(rateBoxToCarton, "Generic Box -> Carton conversion rate should exist.");
			assertEquals(	0, BigDecimal.valueOf(0.1).compareTo(rateBoxToCarton.setScale(2, RoundingMode.HALF_UP)),
							"Generic Box -> Carton conversion is incorrect. Expected 10 Boxes = 1 Carton.");

			// ----------------------------------------------------------------------
			// Step 2 : Verify Intermediate EA -> Carton Rate
			// ----------------------------------------------------------------------

			BigDecimal rateEaToCarton = MUOMConversion.getRate(Env.getCtx(), uomEachID, uomCartonID);
			assertNotNull(rateEaToCarton, "Intermediate EA -> Carton conversion rate should be derived through Box.");

			BigDecimal expectedRate = BigDecimal.ONE.divide(BigDecimal.valueOf(1000), 12, RoundingMode.HALF_UP);
			assertEquals(	0, expectedRate.compareTo(rateEaToCarton.setScale(12, RoundingMode.HALF_UP)),
							"Intermediate EA -> Carton conversion is incorrect. Expected 1000 EA = 1 Carton.");

			// ----------------------------------------------------------------------
			// Step 3 : Generic Conversion
			// ----------------------------------------------------------------------

			BigDecimal convertedCartons = MUOMConversion.convert(Env.getCtx(), uomEachID, uomCartonID, BigDecimal.valueOf(4000));
			assertNotNull(convertedCartons);
			assertEquals(0, BigDecimal.valueOf(4).compareTo(convertedCartons), "Generic conversion from EA to Carton failed. Expected 4000 EA = 4 Cartons.");

			// ----------------------------------------------------------------------
			// Step 4 : Generic Reverse Conversion
			// ----------------------------------------------------------------------

			BigDecimal convertedEA = MUOMConversion.convert(Env.getCtx(), uomCartonID, uomEachID, BigDecimal.valueOf(6));
			assertNotNull(convertedEA);
			assertEquals(	0, BigDecimal.valueOf(6000).compareTo(convertedEA),
							"Generic reverse conversion from Carton to EA failed. Expected 6 Cartons = 6000 EA.");

			// ----------------------------------------------------------------------
			// Step 5 : Product Conversion API
			// ----------------------------------------------------------------------

			// ----------------------------------------------------------------------
			// Step 5.1 : Product => PEN [ Product-Specific Conversion Through convertProductTo ]
			// ----------------------------------------------------------------------
			// 24 EA -> 2 Box
			BigDecimal resTo1 = MUOMConversion.convertProductTo(Env.getCtx(), productPenID, uomBoxID, BigDecimal.valueOf(24));
			assertNotNull(resTo1);
			assertEquals(0, BigDecimal.valueOf(2).compareTo(resTo1), "Product conversion from EA to Box failed. Expected 24 EA = 2 Boxes.");

			// 480 EA -> 2 Carton
			BigDecimal resTo2 = MUOMConversion.convertProductTo(Env.getCtx(), productPenID, uomCartonID, BigDecimal.valueOf(480));
			assertNotNull(resTo2);
			assertEquals(0, BigDecimal.valueOf(2).compareTo(resTo2), "Product intermediate conversion from EA to Carton failed. Expected 480 EA = 2 Cartons.");

			// ----------------------------------------------------------------------
			// Step 5.2 : Product => PEN [ Product Reverse Conversion Through convertProductFrom ]
			// ----------------------------------------------------------------------

			// 2 Box -> 24 EA
			BigDecimal resFrom1 = MUOMConversion.convertProductFrom(Env.getCtx(), productPenID, uomBoxID, BigDecimal.valueOf(2));
			assertNotNull(resFrom1);
			assertEquals(0, BigDecimal.valueOf(24).compareTo(resFrom1), "Product reverse conversion from Box to EA failed. Expected 2 Boxes = 24 EA.");

			// 2 Carton -> 480 EA
			BigDecimal resFrom2 = MUOMConversion.convertProductFrom(Env.getCtx(), productPenID, uomCartonID, BigDecimal.valueOf(2));
			assertNotNull(resFrom2);
			assertEquals(0, BigDecimal.valueOf(480).compareTo(resFrom2), "Product reverse conversion from Carton to EA failed. Expected 2 Cartons = 480 EA.");

			// ----------------------------------------------------------------------
			// Step 5.3 : Product => PEN [ Round Trip ]
			// ----------------------------------------------------------------------

			BigDecimal roundTripCarton = MUOMConversion.convertProductTo(Env.getCtx(), productPenID, uomCartonID, BigDecimal.valueOf(480));
			assertNotNull(roundTripCarton);

			BigDecimal roundTripEA = MUOMConversion.convertProductFrom(Env.getCtx(), productPenID, uomCartonID, roundTripCarton);
			assertNotNull(roundTripEA);
			assertEquals(	0, BigDecimal.valueOf(480).compareTo(roundTripEA),
							"Product round-trip conversion (EA -> Carton -> EA) should preserve the original quantity.");

			// ----------------------------------------------------------------------
			// Step 5.4 : Product => SCREW [Generic Conversion Through convertProductTo ]
			// ----------------------------------------------------------------------
			// Screw has no product-specific conversion, so it falls back to the
			// generic rates: 100 EA = 1 Box, 1000 EA = 1 Carton.

			// 200 EA -> 2 Box (generic: 100 EA = 1 Box)
			resTo1 = MUOMConversion.convertProductTo(Env.getCtx(), productScrewID, uomBoxID, BigDecimal.valueOf(200));
			assertNotNull(resTo1);
			assertEquals(	0, BigDecimal.valueOf(2).compareTo(resTo1.setScale(2, RoundingMode.HALF_UP)),
							"Product conversion from EA to Box failed. Expected 200 EA = 2 Box (generic rate 100 EA = 1 Box).");

			// 4000 EA -> 4 Carton (generic: 1000 EA = 1 Carton)
			resTo2 = MUOMConversion.convertProductTo(Env.getCtx(), productScrewID, uomCartonID, BigDecimal.valueOf(4000));
			assertNotNull(resTo2);
			assertEquals(	0, BigDecimal.valueOf(4).compareTo(resTo2.setScale(2, RoundingMode.HALF_UP)),
							"Product intermediate conversion from EA to Carton failed. Expected 4000 EA = 4 Carton (generic rate 1000 EA = 1 Carton).");

			// ----------------------------------------------------------------------
			// Step 5.5 : Product => SCREW [ Product Reverse Conversion Through convertProductFrom ]
			// ----------------------------------------------------------------------

			// 2 Box -> 200 EA (generic: 1 Box = 100 EA)
			resFrom1 = MUOMConversion.convertProductFrom(Env.getCtx(), productScrewID, uomBoxID, BigDecimal.valueOf(2));
			assertNotNull(resFrom1);
			assertEquals(0, BigDecimal.valueOf(200).compareTo(resFrom1), "Product reverse conversion from Box to EA failed. Expected 2 Boxes = 200 EA.");

			// 3 Carton -> 3000 EA (generic: 1 Carton = 1000 EA)
			resFrom2 = MUOMConversion.convertProductFrom(Env.getCtx(), productScrewID, uomCartonID, BigDecimal.valueOf(3));
			assertNotNull(resFrom2);
			assertEquals(0, BigDecimal.valueOf(3000).compareTo(resFrom2), "Product reverse conversion from Carton to EA failed. Expected 3 Cartons = 3000 EA.");

			// ----------------------------------------------------------------------
			// Step 5.6 : Product => SCREW [ Round Trip ]
			// ----------------------------------------------------------------------

			roundTripCarton = MUOMConversion.convertProductTo(Env.getCtx(), productScrewID, uomCartonID, BigDecimal.valueOf(5500));
			assertNotNull(roundTripCarton);

			roundTripEA = MUOMConversion.convertProductFrom(Env.getCtx(), productScrewID, uomCartonID, roundTripCarton);
			assertNotNull(roundTripEA);
			assertEquals(	0, BigDecimal.valueOf(5500).compareTo(roundTripEA),
							"Product round-trip conversion (EA -> Carton -> EA) should preserve the original quantity.");

			// ----------------------------------------------------------------------
			// Step 6 : getRateUsingCommonUOM() - Box <-> Carton
			// ----------------------------------------------------------------------
			// A GENERIC direct Box<->Carton conversion exists (10 Box = 1 Carton), but
			// Pen also has its own EA-based conversions (12 EA = 1 Box, 240 EA = 1 Carton),
			// which imply a DIFFERENT ratio for Pen specifically: 20 Box = 1 Carton.
			//
			// getRateUsingCommonUOM() now prefers a rate derived purely from a product's
			// own conversion records over a generic direct match, even when that means
			// bridging through a common UOM (EA) to get there. So:
			// - PEN (has its own EA-Box / EA-Carton data) -> uses its own 20:1 ratio,
			// ignoring the generic 10:1 direct conversion entirely.
			// - SCREW (has no product-specific data at all) -> falls back to the
			// generic direct conversion, 10:1.
			//
			// Pen and Screw are therefore EXPECTED to disagree here (20 vs 10) -- that
			// divergence is exactly what this fix is meant to produce.

			// ---- Step 6.1 : PEN - Box -> Carton (derived from Pen's own EA-based data) ----
			BigDecimal ratePenBoxToCarton = MUOMConversion.getRateUsingCommonUOM(Env.getCtx(), uomBoxID, uomCartonID, productPenID);
			assertNotNull(ratePenBoxToCarton, "Pen Box -> Carton rate via common UOM should be derivable.");
			assertEquals(	0, BigDecimal.valueOf(0.05).compareTo(ratePenBoxToCarton.setScale(2, RoundingMode.HALF_UP)),
							"Pen Box -> Carton is incorrect. Expected Pen's own ratio: 20 Box = 1 Carton (0.05 Carton per Box), derived from Pen's 12 EA = 1 Box and 240 EA = 1 Carton -- NOT the generic 10 Box = 1 Carton.");

			// ---- Step 6.2 : PEN - Carton -> Box (derived from Pen's own EA-based data) ----
			BigDecimal ratePenCartonToBox = MUOMConversion.getRateUsingCommonUOM(Env.getCtx(), uomCartonID, uomBoxID, productPenID);
			assertNotNull(ratePenCartonToBox, "Pen Carton -> Box rate via common UOM should be derivable.");
			assertEquals(	0, BigDecimal.valueOf(20).compareTo(ratePenCartonToBox.setScale(0, RoundingMode.HALF_UP)),
							"Pen Carton -> Box is incorrect. Expected Pen's own ratio: 1 Carton = 20 Box, derived from Pen's 12 EA = 1 Box and 240 EA = 1 Carton -- NOT the generic 1 Carton = 10 Box.");

			// ---- Step 6.3 : SCREW - Box -> Carton (no product-specific data -> generic direct
			// match) ----
			BigDecimal rateScrewBoxToCarton = MUOMConversion.getRateUsingCommonUOM(Env.getCtx(), uomBoxID, uomCartonID, productScrewID);
			assertNotNull(rateScrewBoxToCarton, "Screw Box -> Carton rate via common UOM should be derivable.");
			assertEquals(	0, BigDecimal.valueOf(0.1).compareTo(rateScrewBoxToCarton.setScale(2, RoundingMode.HALF_UP)),
							"Screw Box -> Carton is incorrect. Screw has no product-specific conversions, so it should fall back to the generic direct conversion: 10 Box = 1 Carton (0.10 Carton per Box).");

			// ---- Step 6.4 : SCREW - Carton -> Box (no product-specific data -> generic direct
			// match) ----
			BigDecimal rateScrewCartonToBox = MUOMConversion.getRateUsingCommonUOM(Env.getCtx(), uomCartonID, uomBoxID, productScrewID);
			assertNotNull(rateScrewCartonToBox, "Screw Carton -> Box rate via common UOM should be derivable.");
			assertEquals(	0, BigDecimal.valueOf(10).compareTo(rateScrewCartonToBox.setScale(0, RoundingMode.HALF_UP)),
							"Screw Carton -> Box is incorrect. Screw has no product-specific conversions, so it should fall back to the generic direct conversion: 1 Carton = 10 Box.");

			// ---- Step 6.5 : Cross-check - Pen and Screw MUST now disagree, proving
			// product-specific data takes priority over a generic direct match instead of being
			// silently ignored.
			assertEquals(	0, ratePenBoxToCarton.setScale(6, RoundingMode.HALF_UP).compareTo(BigDecimal.valueOf(0.05).setScale(6, RoundingMode.HALF_UP)),
							"Pen's derived rate should not match the generic rate.");
			assertEquals(	0, rateScrewBoxToCarton.setScale(6, RoundingMode.HALF_UP).compareTo(BigDecimal.valueOf(0.1).setScale(6, RoundingMode.HALF_UP)),
							"Screw's rate should match the generic rate, since it has no product-specific override.");
			assertNotEquals(0, ratePenBoxToCarton.setScale(6, RoundingMode.HALF_UP).compareTo(rateScrewBoxToCarton.setScale(6, RoundingMode.HALF_UP)),
							"Pen and Screw should now resolve to DIFFERENT Box -> Carton rates: Pen uses its own product-specific data (20:1) while Screw falls back to the generic direct conversion (10:1).");
		}
		finally
		{
			deleteUOMConversion(convEaToBox);
			deleteUOMConversion(convBoxToCarton);
			deleteUOMConversion(convEaToBoxPen);
			deleteUOMConversion(convEaToCartonPen);

			if (pen != null)
				pen.deleteEx(true);
			if (screw != null)
				screw.deleteEx(true);

			if (uomBox != null)
				uomBox.deleteEx(true);
			if (uomCarton != null)
				uomCarton.deleteEx(true);

			if (sysConfig != null)
				sysConfig.deleteEx(true);
			if (isSysConfigUpdated)
			{
				DB.executeUpdateEx(	"UPDATE AD_SysConfig SET Value = 'Y' WHERE Name=? AND AD_Client_ID=?",
									new Object[] { MSysConfig.ProductUOMConversionRateValidate, GARDEN_WORLD_CLIENT }, null);
			}
			//
			CacheMgt.get().reset();
		}
	} // testProductPenUOMConversionSteps

	/**
	 * Create Product with given name and UOM, and save it to the database.
	 * 
	 * @param  name
	 * @param  uomID
	 * @param  trxName
	 * @return         the saved MProduct
	 */
	private MProduct createProduct(String name, int uomID, String trxName)
	{
		MProduct p = new MProduct(Env.getCtx(), 0, trxName);
		p.setName(name);
		p.setC_UOM_ID(uomID);
		p.setIsStocked(true);
		p.setProductType(MProduct.PRODUCTTYPE_Item);
		p.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
		p.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.STANDARD.id);
		p.saveEx();
		return p;
	} // createProduct

	/**
	 * Helper method to create UOM
	 */
	private MUOM createUOM(String name, String symbol, int stdPrecision)
	{
		MUOM uom = new MUOM(Env.getCtx(), 0, null);
		uom.setName(name);
		uom.setUOMSymbol(symbol);
		uom.setX12DE355(symbol);
		uom.setStdPrecision(stdPrecision);
		uom.setCostingPrecision(stdPrecision);
		uom.setIsDefault(false);
		uom.saveEx();
		return uom;
	} // createUOM

	/**
	 * Helper method to create a UOM conversion record (generic or product-specific) with the given
	 * rates.
	 *
	 * @param  M_Product_ID product to scope the conversion to; pass 0 (or negative) for a generic
	 *                      conversion that applies to all products
	 * @param  C_UOM_ID     from UOM
	 * @param  C_UOM_To_ID  to UOM
	 * @param  multiplyRate multiply rate; pass {@link BigDecimal#ZERO} if this conversion is
	 *                      defined via divideRate instead
	 * @param  divideRate   divide rate; pass {@link BigDecimal#ZERO} if this conversion is defined
	 *                      via multiplyRate instead
	 * @return              the saved MUOMConversion record
	 */
	private MUOMConversion createUOMConversion(int M_Product_ID, int C_UOM_ID, int C_UOM_To_ID, BigDecimal multiplyRate, BigDecimal divideRate)
	{
		MUOMConversion conversion = new MUOMConversion(Env.getCtx(), 0, null);
		if (M_Product_ID > 0)
			conversion.setM_Product_ID(M_Product_ID);
		conversion.setC_UOM_ID(C_UOM_ID);
		conversion.setC_UOM_To_ID(C_UOM_To_ID);
		conversion.setMultiplyRate(multiplyRate != null ? multiplyRate : BigDecimal.ZERO);
		conversion.setDivideRate(divideRate != null ? divideRate : BigDecimal.ZERO);
		conversion.saveEx();
		return conversion;
	} // createUOMConversion

	/**
	 * Deletes the given UOM conversion record if it is not null.
	 * 
	 * @param conversion
	 */
	private void deleteUOMConversion(MUOMConversion conversion)
	{
		if (conversion != null)
		{
			conversion.deleteEx(true);
		}
	} // deleteUOMConversion

}
