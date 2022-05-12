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
package org.adempiere.base.callout;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.adempiere.base.annotation.Callout;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MBankAccount;
import org.compiere.model.MBankTransfer;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCurrency;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * 
 * @author hengsin
 *
 */
@Callout(tableName = MBankTransfer.Table_Name, 
	columnName = {MBankTransfer.COLUMNNAME_PayDate, MBankTransfer.COLUMNNAME_From_Amt, MBankTransfer.COLUMNNAME_From_C_BankAccount_ID,
			MBankTransfer.COLUMNNAME_From_C_Charge_ID, MBankTransfer.COLUMNNAME_From_TenderType, MBankTransfer.COLUMNNAME_From_C_Currency_ID,
			MBankTransfer.COLUMNNAME_Rate, MBankTransfer.COLUMNNAME_To_C_BankAccount_ID, MBankTransfer.COLUMNNAME_To_C_Currency_ID,
			MBankTransfer.COLUMNNAME_C_ConversionType_ID, MBankTransfer.COLUMNNAME_To_Amt})
public class CalloutBankTransfer implements IColumnCallout {

	private static final Map<String, IColumnCallout> calloutMap = new HashMap<String, IColumnCallout>();
	
	static {
		calloutMap.put(MBankTransfer.COLUMNNAME_From_C_BankAccount_ID, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> fromBankAccount(ctx, windowNo, mTab, mField, value));
		calloutMap.put(MBankTransfer.COLUMNNAME_To_C_BankAccount_ID, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> toBankAccount(ctx, windowNo, mTab, mField, value));
		calloutMap.put(MBankTransfer.COLUMNNAME_From_Amt, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> fromAmt(ctx, windowNo, mTab, mField));
		calloutMap.put(MBankTransfer.COLUMNNAME_PayDate, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> payDate(ctx, windowNo, mTab, mField));
		calloutMap.put(MBankTransfer.COLUMNNAME_From_C_Charge_ID, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> fromCharge(ctx, windowNo, mTab, mField));
		calloutMap.put(MBankTransfer.COLUMNNAME_From_TenderType, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> fromTenderType(ctx, windowNo, mTab, mField));
		calloutMap.put(MBankTransfer.COLUMNNAME_From_C_Currency_ID, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> fromCurrency(ctx, windowNo, mTab, mField));
		calloutMap.put(MBankTransfer.COLUMNNAME_To_C_Currency_ID, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> toCurrency(ctx, windowNo, mTab, mField));
		calloutMap.put(MBankTransfer.COLUMNNAME_Rate, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> rate(ctx, windowNo, mTab, mField, value));
		calloutMap.put(MBankTransfer.COLUMNNAME_C_ConversionType_ID, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> conversionType(ctx, windowNo, mTab, mField));
		calloutMap.put(MBankTransfer.COLUMNNAME_To_Amt, 
				(ctx, windowNo, mTab, mField, value, oldValue) -> toAmt(ctx, windowNo, mTab, mField));
	}
	
	@Override
	public String start(Properties ctx, int windowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
		IColumnCallout callout = calloutMap.get(mField.getColumnName());
		return callout != null ? callout.start(ctx, windowNo, mTab, mField, value, oldValue) : "";
	}
		
	private static String toAmt(Properties ctx, int windowNo, GridTab mTab, GridField mField) {
		BigDecimal fromAmt = (BigDecimal) mTab.getValue(MBankTransfer.COLUMNNAME_From_Amt);
		BigDecimal toAmt = (BigDecimal) mTab.getValue(MBankTransfer.COLUMNNAME_To_Amt);
		
		if (fromAmt == null || toAmt == null)
			return "";
		
		Integer From_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_From_C_Currency_ID);
		Integer To_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_To_C_Currency_ID);
		if (From_C_Currency_ID != null && From_C_Currency_ID > 0 && To_C_Currency_ID != null && To_C_Currency_ID > 0) {
			if (From_C_Currency_ID != To_C_Currency_ID) {
				if ((Boolean)mTab.getValue(MBankTransfer.COLUMNNAME_IsOverrideCurrencyRate)) {
					if (fromAmt.compareTo(BigDecimal.ZERO) != 0) {
						BigDecimal rate = toAmt.divide(fromAmt, 12, RoundingMode.HALF_UP);
						mTab.setValue(MBankTransfer.COLUMNNAME_Rate, rate);
					}
				}
			}
		}
		
		return "";
	}
	
	private static String conversionType(Properties ctx, int windowNo, GridTab mTab, GridField mField) {
		if (mField.getValue() != null && mTab.getValue(MBankTransfer.COLUMNNAME_To_AD_Org_ID) != null
			&& mTab.getValue(MBankTransfer.COLUMNNAME_From_C_Currency_ID) != null) {
			Integer AD_Client_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_AD_Client_ID);
			Integer AD_Org_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_To_AD_Org_ID);			
			Integer From_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_From_C_Currency_ID);
			BigDecimal amt = (BigDecimal)mTab.getValue(MBankTransfer.COLUMNNAME_From_Amt);
			if (amt.signum() != 0 && mTab.getValue(MBankTransfer.COLUMNNAME_To_C_Currency_ID) != null 
				&& mTab.getValue(MBankTransfer.COLUMNNAME_C_ConversionType_ID) != null
				&& mTab.getValue(MBankTransfer.COLUMNNAME_PayDate) != null) {
				if (!((Boolean)mTab.getValue(MBankTransfer.COLUMNNAME_IsOverrideCurrencyRate))) {
					Timestamp payDate = (Timestamp) mTab.getValue(MBankTransfer.COLUMNNAME_PayDate);
					Integer To_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_To_C_Currency_ID);
					Integer C_ConversionType_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_C_ConversionType_ID);
					BigDecimal rate = MConversionRate.getRate(From_C_Currency_ID, To_C_Currency_ID, payDate, C_ConversionType_ID, AD_Client_ID, AD_Org_ID);
					if (rate != null) {
						mTab.setValue(MBankTransfer.COLUMNNAME_Rate, rate);
						return fromAmt(ctx, windowNo, mTab, mField);
					}
				}
			}
		}
		return "";
	}

	private static String fromCurrency(Properties ctx, int windowNo, GridTab mTab, GridField mField) {
		if (mField.getValue() != null && mTab.getValue(MBankTransfer.COLUMNNAME_To_AD_Org_ID) != null) {
			Integer AD_Client_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_AD_Client_ID);
			Integer AD_Org_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_To_AD_Org_ID);			
			Integer From_C_Currency_ID = (Integer) mField.getValue();
			BigDecimal amt = (BigDecimal)mTab.getValue(MBankTransfer.COLUMNNAME_From_Amt);
			if (amt.signum() != 0 && mTab.getValue(MBankTransfer.COLUMNNAME_To_C_Currency_ID) != null 
				&& mTab.getValue(MBankTransfer.COLUMNNAME_C_ConversionType_ID) != null
				&& mTab.getValue(MBankTransfer.COLUMNNAME_PayDate) != null) {
				if (!((Boolean)mTab.getValue(MBankTransfer.COLUMNNAME_IsOverrideCurrencyRate))) {
					Timestamp payDate = (Timestamp) mTab.getValue(MBankTransfer.COLUMNNAME_PayDate);
					Integer To_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_To_C_Currency_ID);
					Integer C_ConversionType_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_C_ConversionType_ID);
					BigDecimal rate = MConversionRate.getRate(From_C_Currency_ID, To_C_Currency_ID, payDate, C_ConversionType_ID, AD_Client_ID, AD_Org_ID);
					if (rate != null) {
						mTab.setValue(MBankTransfer.COLUMNNAME_Rate, rate);
						return fromAmt(ctx, windowNo, mTab, mField);
					}
				}
			}
		}
		return "";
	}

	private static String toCurrency(Properties ctx, int windowNo, GridTab mTab, GridField mField) {
		if (mField.getValue() != null && mTab.getValue(MBankTransfer.COLUMNNAME_To_AD_Org_ID) != null) {
			Integer AD_Client_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_AD_Client_ID);
			Integer AD_Org_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_To_AD_Org_ID);			
			Integer To_C_Currency_ID = (Integer) mField.getValue();
			BigDecimal amt = (BigDecimal)mTab.getValue(MBankTransfer.COLUMNNAME_From_Amt);
			if (amt.signum() != 0 && mTab.getValue(MBankTransfer.COLUMNNAME_From_C_Currency_ID) != null 
				&& mTab.getValue(MBankTransfer.COLUMNNAME_C_ConversionType_ID) != null
				&& mTab.getValue(MBankTransfer.COLUMNNAME_PayDate) != null) {
				if (!((Boolean)mTab.getValue(MBankTransfer.COLUMNNAME_IsOverrideCurrencyRate))) {
					Timestamp payDate = (Timestamp) mTab.getValue(MBankTransfer.COLUMNNAME_PayDate);
					Integer From_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_From_C_Currency_ID);
					Integer C_ConversionType_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_C_ConversionType_ID);
					BigDecimal rate = MConversionRate.getRate(From_C_Currency_ID, To_C_Currency_ID, payDate, C_ConversionType_ID, AD_Client_ID, AD_Org_ID);
					if (rate != null) {
						mTab.setValue(MBankTransfer.COLUMNNAME_Rate, rate);
						return fromAmt(ctx, windowNo, mTab, mField);
					}
				}
			}
		}
		return "";
	}

	private static String fromTenderType(Properties ctx, int windowNo, GridTab mTab, GridField mField) {
		mTab.setValue(MBankTransfer.COLUMNNAME_To_TenderType, mField.getValue());
		return "";
	}

	private static String fromCharge(Properties ctx, int windowNo, GridTab mTab, GridField mField) {
		mTab.setValue(MBankTransfer.COLUMNNAME_To_C_Charge_ID, mField.getValue());
		return "";
	}

	private static String payDate(Properties ctx, int windowNo, GridTab mTab, GridField mField) {
		mTab.setValue(MBankTransfer.COLUMNNAME_DateAcct, mField.getValue());
		return "";
	}

	private static String fromBankAccount(Properties ctx, int windowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer From_C_BankAccount_ID = (Integer) value;		//	Actually From_C_BankAccount_ID
		if (From_C_BankAccount_ID == null || From_C_BankAccount_ID.intValue() == 0)
			return "";
		
		MBankAccount ba = MBankAccount.get(ctx, From_C_BankAccount_ID);
		int AD_Org_ID = ba.getAD_Org_ID(); 
		if (AD_Org_ID > 0)
		{
			mTab.setValue(MBankTransfer.COLUMNNAME_From_AD_Org_ID, AD_Org_ID);
		}
		else
		{
			AD_Org_ID = Env.getAD_Org_ID(Env.getCtx());
			if (AD_Org_ID > 0)
				mTab.setValue(MBankTransfer.COLUMNNAME_From_AD_Org_ID, AD_Org_ID);
		}
		if (ba.getC_Currency_ID() > 0)
			mTab.setValue(MBankTransfer.COLUMNNAME_From_C_Currency_ID, ba.getC_Currency_ID());
		
		int C_BPartner_ID = 0;
		if (AD_Org_ID > 0)
		{
			String sql = "SELECT bp.C_BPartner_ID FROM C_BPartner bp " 
					+ "WHERE bp.AD_OrgBP_ID = ? "
					+ "AND bp.IsActive = 'Y' ";
			C_BPartner_ID = DB.getSQLValue(null, sql, AD_Org_ID);
		}
		if (C_BPartner_ID > 0)
		{
			mTab.setValue(MBankTransfer.COLUMNNAME_From_C_BPartner_ID, C_BPartner_ID);
		}
		else
		{
			mTab.setValue(MBankTransfer.COLUMNNAME_From_C_BPartner_ID, null);
		}
		
		return "";
	}
	
	private static String toBankAccount(Properties ctx, int windowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer To_C_BankAccount_ID = (Integer) value;		//	Actually To_C_BankAccount_ID
		if (To_C_BankAccount_ID == null || To_C_BankAccount_ID.intValue() == 0)
			return "";
		
		MBankAccount ba = MBankAccount.get(ctx, To_C_BankAccount_ID);
		int AD_Org_ID = ba.getAD_Org_ID();
		if (AD_Org_ID > 0)
		{
			mTab.setValue(MBankTransfer.COLUMNNAME_To_AD_Org_ID, ba.getAD_Org_ID());
		}
		else
		{
			AD_Org_ID = Env.getAD_Org_ID(Env.getCtx());
			if (AD_Org_ID > 0)
				mTab.setValue(MBankTransfer.COLUMNNAME_To_AD_Org_ID, AD_Org_ID);
		}
		if (ba.getC_Currency_ID() > 0)
			mTab.setValue(MBankTransfer.COLUMNNAME_To_C_Currency_ID, ba.getC_Currency_ID());
		
		int C_BPartner_ID = 0;
		if (AD_Org_ID > 0)
		{
			String sql = "SELECT bp.C_BPartner_ID FROM C_BPartner bp " 
					+ "WHERE bp.AD_OrgBP_ID = ? "
					+ "AND bp.IsActive = 'Y' ";
			C_BPartner_ID = DB.getSQLValue(null, sql, AD_Org_ID);
		}
		if (C_BPartner_ID > 0)
		{
			mTab.setValue(MBankTransfer.COLUMNNAME_To_C_BPartner_ID, C_BPartner_ID);
		}
		else
		{
			if (mTab.getValue(MBankTransfer.COLUMNNAME_From_AD_Org_ID) != null &&
				AD_Org_ID == (Integer)mTab.getValue(MBankTransfer.COLUMNNAME_From_AD_Org_ID) &&
				mTab.getValue(MBankTransfer.COLUMNNAME_From_C_BPartner_ID) != null &&
				((Integer)mTab.getValue(MBankTransfer.COLUMNNAME_From_C_BPartner_ID)) > 0) 
			{
				mTab.setValue(MBankTransfer.COLUMNNAME_To_C_BPartner_ID, mTab.getValue(MBankTransfer.COLUMNNAME_From_C_BPartner_ID));
			}
			else
			{
				mTab.setValue(MBankTransfer.COLUMNNAME_To_C_BPartner_ID, null);
			}
		}
		
		Integer From_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_From_C_Currency_ID);
		Integer To_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_To_C_Currency_ID);
		Timestamp PayDate = (Timestamp) mTab.getValue(MBankTransfer.COLUMNNAME_PayDate);
		Integer AD_Client_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_AD_Client_ID);
		if (From_C_Currency_ID != null && From_C_Currency_ID > 0 && To_C_Currency_ID != null && To_C_Currency_ID > 0) {
			if (From_C_Currency_ID == To_C_Currency_ID) {
				mTab.setValue(MBankTransfer.COLUMNNAME_Rate, BigDecimal.ONE);
				return fromAmt(ctx, windowNo, mTab, mField);				
			} else {
				if (PayDate != null && AD_Client_ID != null
					&& mTab.getValue(MBankTransfer.COLUMNNAME_C_ConversionType_ID) != null) {
					Integer C_ConversionType_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_C_ConversionType_ID);
					BigDecimal rate = MConversionRate.getRate(From_C_Currency_ID, To_C_Currency_ID, PayDate, C_ConversionType_ID, AD_Client_ID, AD_Org_ID);
					if (rate != null) {
						mTab.setValue(MBankTransfer.COLUMNNAME_Rate, rate);
						return fromAmt(ctx, windowNo, mTab, mField);
					}
				}				
			}
		}
		
		return "";
	}
	
	private static String rate(Properties ctx, int windowNo, GridTab mTab, GridField mField, Object value)
	{
		BigDecimal fromAmt = (BigDecimal) mTab.getValue(MBankTransfer.COLUMNNAME_From_Amt);
		
		if (fromAmt == null)
			return "";
		
		Integer From_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_From_C_Currency_ID);
		Integer To_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_To_C_Currency_ID);
		if (From_C_Currency_ID != null && From_C_Currency_ID > 0 && To_C_Currency_ID != null && To_C_Currency_ID > 0) {
			if (From_C_Currency_ID == To_C_Currency_ID) {
				mTab.setValue(MBankTransfer.COLUMNNAME_Rate, BigDecimal.ONE);
				return fromAmt(ctx, windowNo, mTab, mField);				
			} else {
				if (fromAmt.signum() != 0) {
					return fromAmt(ctx, windowNo, mTab, mField);
				}				
			}
		}
		
		return "";
	}
	
	/**
	 * 
	 * @param ctx
	 * @param WindowNo
	 * @param mTab
	 * @param mField
	 * @return error message (if any)
	 */
	private static String fromAmt(Properties ctx, int WindowNo, GridTab mTab, GridField mField)
	{
		BigDecimal rate = (BigDecimal) mTab.getValue(MBankTransfer.COLUMNNAME_Rate);
		BigDecimal fromAmt = (BigDecimal) mTab.getValue(MBankTransfer.COLUMNNAME_From_Amt);
		
		if (fromAmt == null || rate == null)
			return "";
		
		BigDecimal toAmt = rate.multiply(fromAmt);
		Integer To_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_To_C_Currency_ID);
		if (To_C_Currency_ID != null && To_C_Currency_ID > 0) {
			MCurrency cur = MCurrency.get(ctx, To_C_Currency_ID);
			if (cur != null)
				toAmt = toAmt.setScale(cur.getStdPrecision(), RoundingMode.HALF_UP);
		}
		mTab.setValue(MBankTransfer.COLUMNNAME_To_Amt, toAmt);
		
		return "";
	}	
}
