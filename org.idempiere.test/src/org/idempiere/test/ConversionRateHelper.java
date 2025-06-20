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
package org.idempiere.test;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.eq;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MConversionRate;
import org.compiere.model.MCurrency;
import org.compiere.model.Query;
import org.compiere.util.Env;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * 
 * @author hengsin
 *
 */
public final class ConversionRateHelper {

	private ConversionRateHelper() {
	}

	/**
	 * 
	 * @param C_Currency_ID
	 * @param C_Currency_ID_To
	 * @param C_ConversionType_ID
	 * @param date
	 * @param rate
	 * @param isMultiplyRate
	 * @return {@link MConversionRate}
	 */
	public static MConversionRate createConversionRate(int C_Currency_ID, int C_Currency_ID_To, int C_ConversionType_ID, 
			Timestamp date, BigDecimal rate, boolean isMultiplyRate) {
		return createConversionRate(C_Currency_ID, C_Currency_ID_To, C_ConversionType_ID, date, rate, isMultiplyRate, null);
	}
	
	/**
	 * 
	 * @param C_Currency_ID
	 * @param C_Currency_ID_To
	 * @param C_ConversionType_ID
	 * @param date
	 * @param rate
	 * @param isMultiplyRate
	 * @return {@link MConversionRate}
	 */
	public static MConversionRate createConversionRate(int C_Currency_ID, int C_Currency_ID_To, int C_ConversionType_ID, 
			Timestamp date, BigDecimal rate, boolean isMultiplyRate, String trxName) {
		MConversionRate cr = new MConversionRate(Env.getCtx(), 0, trxName);
		cr.setC_Currency_ID(C_Currency_ID);
		cr.setC_Currency_ID_To(C_Currency_ID_To);
		cr.setC_ConversionType_ID(C_ConversionType_ID);
		cr.setValidFrom(date);
		cr.setValidTo(date);
		if (isMultiplyRate)
			cr.setMultiplyRate(rate);
		else
			cr.setDivideRate(rate);
		cr.saveEx();
		return cr;
	}
	
	/**
	 * 
	 * @param cr
	 */
	public static void deleteConversionRate(MConversionRate cr) {
		String whereClause = "ValidFrom=? AND ValidTo=? "
				+ "AND C_Currency_ID=? AND C_Currency_ID_To=? "
				+ "AND C_ConversionType_ID=? "
				+ "AND AD_Client_ID=? AND AD_Org_ID=?";
		MConversionRate reciprocal = new Query(Env.getCtx(), MConversionRate.Table_Name, whereClause, null)
				.setParameters(cr.getValidFrom(), cr.getValidTo(), 
						cr.getC_Currency_ID_To(), cr.getC_Currency_ID(),
						cr.getC_ConversionType_ID(),
						cr.getAD_Client_ID(), cr.getAD_Org_ID())
				.firstOnly();
		if (reciprocal != null)
			reciprocal.deleteEx(true);
		cr.deleteEx(true);
	}
	
	/**
	 * Create new static mock of MConversionRate
	 * @return static mock of MConversionRate
	 */
	public static MockedStatic<MConversionRate> mockStatic() {
		MockedStatic<MConversionRate> conversionRateMock = Mockito.mockStatic(MConversionRate.class);
		conversionRateMock.when(() -> MConversionRate.convert(any(Properties.class), any(BigDecimal.class), anyInt(), anyInt(), 
		    any(Timestamp.class), anyInt(), anyInt(), anyInt())).thenCallRealMethod();
		conversionRateMock.when(() -> MConversionRate.convert(any(Properties.class), any(BigDecimal.class), anyInt(), anyInt(), 
		    any(Timestamp.class), anyInt(), anyInt(), anyInt(), anyBoolean())).thenCallRealMethod();
		conversionRateMock.when(() -> MConversionRate.convertBase(any(Properties.class), any(BigDecimal.class), anyInt(),  
		    any(Timestamp.class), anyInt(), anyInt(), anyInt())).thenCallRealMethod();
		return conversionRateMock;
	}
	
	/**
	 * Use static mocking of getRate to return the desire conversion rate
	 * @param conversionRateMock
	 * @param fromCurrency
	 * @param toCurrency
	 * @param C_ConversionType_ID
	 * @param conversionDate
	 * @param multiplyRate
	 * @param AD_Client_ID
	 * @param AD_Org_ID
	 */
	public static void mockGetRate(MockedStatic<MConversionRate> conversionRateMock, MCurrency fromCurrency,
			MCurrency toCurrency, int C_ConversionType_ID, Timestamp conversionDate, BigDecimal multiplyRate,
			int AD_Client_ID, int AD_Org_ID) {
		if (C_ConversionType_ID > 0)
			if (conversionDate != null)
				conversionRateMock.when(() -> MConversionRate.getRate(eq(fromCurrency.getC_Currency_ID()), eq(toCurrency.getC_Currency_ID()), 
						eq(conversionDate), eq(C_ConversionType_ID), eq(AD_Client_ID), eq(AD_Org_ID)))
						.thenReturn(multiplyRate);
			else
				conversionRateMock.when(() -> MConversionRate.getRate(eq(fromCurrency.getC_Currency_ID()), eq(toCurrency.getC_Currency_ID()), 
						any(Timestamp.class), eq(C_ConversionType_ID), eq(AD_Client_ID), eq(AD_Org_ID)))
						.thenReturn(multiplyRate);
		else
			if (conversionDate != null)
				conversionRateMock.when(() -> MConversionRate.getRate(eq(fromCurrency.getC_Currency_ID()), eq(toCurrency.getC_Currency_ID()), 
						eq(conversionDate), anyInt(), eq(AD_Client_ID), eq(AD_Org_ID)))
						.thenReturn(multiplyRate);
			else
				conversionRateMock.when(() -> MConversionRate.getRate(eq(fromCurrency.getC_Currency_ID()), eq(toCurrency.getC_Currency_ID()), 
						any(Timestamp.class), anyInt(), eq(AD_Client_ID), eq(AD_Org_ID)))
						.thenReturn(multiplyRate);
	}
}
