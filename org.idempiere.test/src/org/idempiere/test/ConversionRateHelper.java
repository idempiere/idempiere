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

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.compiere.model.MConversionRate;
import org.compiere.model.Query;
import org.compiere.util.Env;

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
		MConversionRate cr = new MConversionRate(Env.getCtx(), 0, null);
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
}
