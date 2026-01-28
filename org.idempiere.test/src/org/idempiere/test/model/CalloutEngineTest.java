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
 * - hengsin                                                           *
 *                                                                     *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.concurrent.atomic.AtomicReference;

import org.adempiere.base.Core;
import org.adempiere.exceptions.PeriodClosedException;
import org.compiere.model.Callout;
import org.compiere.model.CalloutEngine;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * Integration test for {@link CalloutEngine}
 * @author hengsin
 */
public class CalloutEngineTest extends AbstractTestCase {

	private TestCalloutEngine engine;
	private GridTab mTab;
	private GridField mField;
	private Properties ctx;

	@BeforeEach
	public void setUp() {
		engine = new TestCalloutEngine();
		mTab = mock(GridTab.class);
		mField = mock(GridField.class);
		ctx = Env.getCtx();
		
		when(mTab.getActiveCallouts()).thenReturn(new String[] {"testMethod"});
	}

	@Test
	public void testICalloutFactory() {
		// Test retrieval via Core facade which uses ColumnCalloutManager/ICalloutFactory
		Callout callout = Core.getCallout(CalloutEngine.class.getName(), "dateAcct");
		assertNotNull(callout);
		assertTrue(callout instanceof CalloutEngine);
	}

	@Test
	public void testStartSuccessful() {
		when(mField.getColumnName()).thenReturn("TestColumn");
		String result = engine.start(ctx, "testCallout", 0, mTab, mField, "newValue", "oldValue");
		assertEquals("ok", result);
		assertEquals(mTab, engine.getCapturedTab()); // Captured during execution
	}

	@Test
	public void testStartWithException() {
		when(mField.getColumnName()).thenReturn("TestColumn");
		String result = engine.start(ctx, "testCalloutException", 0, mTab, mField, "val", "oldVal");
		// CalloutEngine.start returns e.getCause().getMessage() for InvocationTargetException
		assertEquals("simulated failure", result);
	}

	@Test
	public void testStartMethodNotFound() {
		assertThrows(IllegalArgumentException.class, () -> {
			engine.start(ctx, "nonExistentMethod", 0, mTab, mField, "value", "oldValue");
		});
	}

	@Test
	public void testStartNoMethodName() {
		assertThrows(IllegalArgumentException.class, () -> {
			engine.start(ctx, "", 0, mTab, mField, "value", "oldValue");
		});
	}

	@Test
	public void testConvert() {
		String result = engine.convert("testConvert", "inputValue");
		assertEquals("converted-inputValue", result);
	}

	@Test
	public void testConvertWithArgs() {
		String result = engine.convert("testConvertWithArgs(arg1,arg2)", "val");
		assertEquals("converted-val", result);
		assertNotNull(engine.getAdditionalArgs());
		assertEquals(2, engine.getAdditionalArgs().length);
		assertEquals("arg1", engine.getAdditionalArgs()[0]);
		assertEquals("arg2", engine.getAdditionalArgs()[1]);
	}

	@Test
	public void testIsCalloutActive() {
		// Mock GridTab.getActiveCallouts().length > 1
		when(mTab.getActiveCallouts()).thenReturn(new String[] {"callout1", "callout2"});
		engine.start(ctx, "testActiveCallout", 0, mTab, mField, null, null);
		assertTrue(engine.wasCalloutActive());

		// Mock GridTab.getActiveCallouts().length <= 1
		when(mTab.getActiveCallouts()).thenReturn(new String[] {"callout1"});
		engine.start(ctx, "testActiveCallout", 0, mTab, mField, null, null);
		assertFalse(engine.wasCalloutActive());
	}

	@Test
	public void testRate() {
		AtomicReference<BigDecimal> divideRate = new AtomicReference<>();
		when(mField.getColumnName()).thenReturn("MultiplyRate");
		when(mTab.setValue(eq("DivideRate"), any())).then(invocation -> {
			divideRate.set(invocation.getArgument(1));
			
			return null;
		});
		BigDecimal rate = new BigDecimal("2.0");
		String result = engine.rate(ctx, 0, mTab, mField, rate);
		assertEquals(CalloutEngine.NO_ERROR, result);

		assertNotNull(divideRate.get());
		assertEquals(new BigDecimal("0.5").setScale(2, RoundingMode.HALF_EVEN), 
				divideRate.get().setScale(2, RoundingMode.HALF_EVEN));
	}

	@Test
	public void testDateAcct() {
		Timestamp now = new Timestamp(System.currentTimeMillis());
		when(mTab.getValue("AD_Org_ID")).thenReturn(0);
		when(mTab.getValue("C_DocTypeTarget_ID")).thenReturn(0);
		when(mTab.getValue("C_DocType_ID")).thenReturn(0);
		when(mTab.getTableName()).thenReturn("C_Invoice");
		
		//this should be either no error or period closed exception
		try {
			String result = engine.dateAcct(ctx, 0, mTab, mField, now);
			assertEquals(CalloutEngine.NO_ERROR, result);
		} catch (Exception e) {
			assertTrue(e instanceof PeriodClosedException, "Expected PeriodClosedException");
		}
	}

	/**
	 * Test subclass to access protected members/methods
	 */
	public static class TestCalloutEngine extends CalloutEngine {
		private GridTab capturedTab;
		private boolean wasActive;

		public String testCallout(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
			capturedTab = getGridTab();
			return "ok";
		}

		public String testActiveCallout(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
			wasActive = isCalloutActive();
			return "";
		}

		public String testCalloutException(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
			throw new RuntimeException("simulated failure");
		}

		public String testConvert(String value) {
			return "converted-" + value;
		}

		public String testConvertWithArgs(String value) {
			return "converted-" + value;
		}

		public GridTab getCapturedTab() {
			return capturedTab;
		}

		public boolean wasCalloutActive() {
			return wasActive;
		}

		public String[] getAdditionalArgs() {
			return super.additionalArgs;
		}
	}
}
