/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
/** Generated Model - DO NOT CHANGE */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/** Generated Model for C_DocRoundingRule
 *  @author iDempiere (generated) 
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="C_DocRoundingRule")
public class X_C_DocRoundingRule extends PO implements I_C_DocRoundingRule, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220623L;

    /** Standard Constructor */
    public X_C_DocRoundingRule (Properties ctx, int C_DocRoundingRule_ID, String trxName)
    {
      super (ctx, C_DocRoundingRule_ID, trxName);
      /** if (C_DocRoundingRule_ID == 0)
        {
			setC_Currency_ID (0);
			setC_DocRoundingRule_ID (0);
			setC_DocType_ID (0);
			setName (null);
			setRoundingRule (null);
        } */
    }

    /** Standard Constructor */
    public X_C_DocRoundingRule (Properties ctx, int C_DocRoundingRule_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_DocRoundingRule_ID, trxName, virtualColumns);
      /** if (C_DocRoundingRule_ID == 0)
        {
			setC_Currency_ID (0);
			setC_DocRoundingRule_ID (0);
			setC_DocType_ID (0);
			setName (null);
			setRoundingRule (null);
        } */
    }

    /** Load Constructor */
    public X_C_DocRoundingRule (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 3 - Client - Org 
      */
    protected int get_AccessLevel()
    {
      return accessLevel.intValue();
    }

    /** Load Meta Data */
    protected POInfo initPO (Properties ctx)
    {
      POInfo poi = POInfo.getPOInfo (ctx, Table_ID, get_TrxName());
      return poi;
    }

    public String toString()
    {
      StringBuilder sb = new StringBuilder ("X_C_DocRoundingRule[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_C_Currency getC_Currency() throws RuntimeException
	{
		return (org.compiere.model.I_C_Currency)MTable.get(getCtx(), org.compiere.model.I_C_Currency.Table_ID)
			.getPO(getC_Currency_ID(), get_TrxName());
	}

	/** Set Currency.
		@param C_Currency_ID The Currency for this record
	*/
	public void setC_Currency_ID (int C_Currency_ID)
	{
		if (C_Currency_ID < 1)
			set_Value (COLUMNNAME_C_Currency_ID, null);
		else
			set_Value (COLUMNNAME_C_Currency_ID, Integer.valueOf(C_Currency_ID));
	}

	/** Get Currency.
		@return The Currency for this record
	  */
	public int getC_Currency_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Currency_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Document Rounding Rule.
		@param C_DocRoundingRule_ID Document Rounding Rule
	*/
	public void setC_DocRoundingRule_ID (int C_DocRoundingRule_ID)
	{
		if (C_DocRoundingRule_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_DocRoundingRule_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_DocRoundingRule_ID, Integer.valueOf(C_DocRoundingRule_ID));
	}

	/** Get Document Rounding Rule.
		@return Document Rounding Rule	  */
	public int getC_DocRoundingRule_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_DocRoundingRule_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_DocRoundingRule_UU.
		@param C_DocRoundingRule_UU C_DocRoundingRule_UU
	*/
	public void setC_DocRoundingRule_UU (String C_DocRoundingRule_UU)
	{
		set_Value (COLUMNNAME_C_DocRoundingRule_UU, C_DocRoundingRule_UU);
	}

	/** Get C_DocRoundingRule_UU.
		@return C_DocRoundingRule_UU	  */
	public String getC_DocRoundingRule_UU()
	{
		return (String)get_Value(COLUMNNAME_C_DocRoundingRule_UU);
	}

	public org.compiere.model.I_C_DocType getC_DocType() throws RuntimeException
	{
		return (org.compiere.model.I_C_DocType)MTable.get(getCtx(), org.compiere.model.I_C_DocType.Table_ID)
			.getPO(getC_DocType_ID(), get_TrxName());
	}

	/** Set Document Type.
		@param C_DocType_ID Document type or rules
	*/
	public void setC_DocType_ID (int C_DocType_ID)
	{
		if (C_DocType_ID < 0)
			set_ValueNoCheck (COLUMNNAME_C_DocType_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_DocType_ID, Integer.valueOf(C_DocType_ID));
	}

	/** Get Document Type.
		@return Document type or rules
	  */
	public int getC_DocType_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_DocType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Description.
		@param Description Optional short description of the record
	*/
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription()
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Name.
		@param Name Alphanumeric identifier of the entity
	*/
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName()
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** PaymentRule AD_Reference_ID=195 */
	public static final int PAYMENTRULE_AD_Reference_ID=195;
	/** Cash = B */
	public static final String PAYMENTRULE_Cash = "B";
	/** Direct Debit = D */
	public static final String PAYMENTRULE_DirectDebit = "D";
	/** Credit Card = K */
	public static final String PAYMENTRULE_CreditCard = "K";
	/** Mixed POS Payment = M */
	public static final String PAYMENTRULE_MixedPOSPayment = "M";
	/** On Credit = P */
	public static final String PAYMENTRULE_OnCredit = "P";
	/** Check = S */
	public static final String PAYMENTRULE_Check = "S";
	/** Direct Deposit = T */
	public static final String PAYMENTRULE_DirectDeposit = "T";
	/** Set Payment Rule.
		@param PaymentRule How you pay the invoice
	*/
	public void setPaymentRule (String PaymentRule)
	{

		set_Value (COLUMNNAME_PaymentRule, PaymentRule);
	}

	/** Get Payment Rule.
		@return How you pay the invoice
	  */
	public String getPaymentRule()
	{
		return (String)get_Value(COLUMNNAME_PaymentRule);
	}

	/** RoundingRule AD_Reference_ID=155 */
	public static final int ROUNDINGRULE_AD_Reference_ID=155;
	/** Whole Number .00 = 0 */
	public static final String ROUNDINGRULE_WholeNumber00 = "0";
	/** Nickel .05, .10, .15, ... = 5 */
	public static final String ROUNDINGRULE_Nickel051015 = "5";
	/** Ending in 9/5 = 9 */
	public static final String ROUNDINGRULE_EndingIn95 = "9";
	/** Currency Precision = C */
	public static final String ROUNDINGRULE_CurrencyPrecision = "C";
	/** Dime .10, .20, .30, ... = D */
	public static final String ROUNDINGRULE_Dime102030 = "D";
	/** No Rounding = N */
	public static final String ROUNDINGRULE_NoRounding = "N";
	/** Quarter .25 .50 .75 = Q */
	public static final String ROUNDINGRULE_Quarter255075 = "Q";
	/** Ten 10.00, 20.00, .. = T */
	public static final String ROUNDINGRULE_Ten10002000 = "T";
	/** Hundred = h */
	public static final String ROUNDINGRULE_Hundred = "h";
	/** Thousand = t */
	public static final String ROUNDINGRULE_Thousand = "t";
	/** Set Rounding Rule.
		@param RoundingRule Rounding Rule
	*/
	public void setRoundingRule (String RoundingRule)
	{

		set_Value (COLUMNNAME_RoundingRule, RoundingRule);
	}

	/** Get Rounding Rule.
		@return Rounding Rule	  */
	public String getRoundingRule()
	{
		return (String)get_Value(COLUMNNAME_RoundingRule);
	}
}