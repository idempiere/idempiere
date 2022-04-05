/******************************************************************************
 * Project: Trek Global ERP                                                   *                       
 * Copyright (C) 2009-2018 Trek Global Corporation                            *
 *                                                                            *
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * 
 * @author hengsin
 *
 */
public class CalloutBankTransfer extends CalloutEngine {

	/**
	 * 
	 * @param ctx
	 * @param WindowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @return error message (if any)
	 */
	public String fromBankAccount(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
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
			mTab.fireDataStatusEEvent("NotExistsBPLinkedforOrgError", 
					(AD_Org_ID > 0 ? MOrg.get(AD_Org_ID).getName() : "*"), false);
		}
		
		return "";
	}
	
	/**
	 * 
	 * @param ctx
	 * @param WindowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @return error message (if any)
	 */
	public String toBankAccount(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
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
			C_BPartner_ID = DB.getSQLValue(null, sql, To_C_BankAccount_ID);
		}
		if (C_BPartner_ID > 0)
		{
			mTab.setValue(MBankTransfer.COLUMNNAME_To_C_BPartner_ID, C_BPartner_ID);
		}
		else
		{
			mTab.setValue(MBankTransfer.COLUMNNAME_To_C_BPartner_ID, null);
			mTab.fireDataStatusEEvent("NotExistsBPLinkedforOrgError", 
					(AD_Org_ID > 0 ? MOrg.get(AD_Org_ID).getName() : "*"), false);
		}
		
		Integer From_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_From_C_Currency_ID);
		Integer To_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_To_C_Currency_ID);
		Timestamp PayDate = (Timestamp) mTab.getValue(MBankTransfer.COLUMNNAME_PayDate);
		Integer AD_Client_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_AD_Client_ID);
		if (From_C_Currency_ID != null && From_C_Currency_ID > 0 && To_C_Currency_ID != null && To_C_Currency_ID > 0) {
			if (From_C_Currency_ID == To_C_Currency_ID) {
				mTab.setValue(MBankTransfer.COLUMNNAME_Rate, BigDecimal.ONE);
				return amount(ctx, WindowNo, mTab, mField, value);				
			} else {
				if (PayDate != null && AD_Client_ID != null) {
					BigDecimal rate = MConversionRate.getRate(From_C_Currency_ID, To_C_Currency_ID, PayDate, MConversionType.TYPE_SPOT, AD_Client_ID, AD_Org_ID);
					if (rate != null)
						mTab.setValue(MBankTransfer.COLUMNNAME_Rate, rate);
				}				
			}
		}
		
		return "";
	}
	
	/**
	 * @param ctx
	 * @param WindowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @return error message (if any)
	 */
	public String rate(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		BigDecimal fromAmt = (BigDecimal) mTab.getValue(MBankTransfer.COLUMNNAME_From_Amt);
		BigDecimal toAmt = (BigDecimal) mTab.getValue(MBankTransfer.COLUMNNAME_To_Amt);
		
		if (fromAmt == null || toAmt == null)
			return "";
		
		Integer From_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_From_C_Currency_ID);
		Integer To_C_Currency_ID = (Integer) mTab.getValue(MBankTransfer.COLUMNNAME_To_C_Currency_ID);
		if (From_C_Currency_ID != null && From_C_Currency_ID > 0 && To_C_Currency_ID != null && To_C_Currency_ID > 0) {
			if (From_C_Currency_ID == To_C_Currency_ID) {
				mTab.setValue(MBankTransfer.COLUMNNAME_Rate, BigDecimal.ONE);
				return amount(ctx, WindowNo, mTab, mField, value);				
			} else {
				if (fromAmt.compareTo(BigDecimal.ZERO) != 0) {
					BigDecimal rate = toAmt.divide(fromAmt, 12, RoundingMode.HALF_UP);
					mTab.setValue(MBankTransfer.COLUMNNAME_Rate, rate);
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
	 * @param value
	 * @return error message (if any)
	 */
	public String amount(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
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
