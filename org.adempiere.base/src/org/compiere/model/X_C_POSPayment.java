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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;
import org.compiere.util.Env;

/** Generated Model for C_POSPayment
 *  @author iDempiere (generated) 
 *  @version Release 1.0b - $Id$ */
public class X_C_POSPayment extends PO implements I_C_POSPayment, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130425L;

    /** Standard Constructor */
    public X_C_POSPayment (Properties ctx, int C_POSPayment_ID, String trxName)
    {
      super (ctx, C_POSPayment_ID, trxName);
      /** if (C_POSPayment_ID == 0)
        {
			setC_Order_ID (0);
			setC_POSPayment_ID (0);
			setC_POSTenderType_ID (0);
			setIsPostDated (false);
// N
			setPayAmt (Env.ZERO);
			setProcessed (false);
        } */
    }

    /** Load Constructor */
    public X_C_POSPayment (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_C_POSPayment[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Account No.
		@param AccountNo 
		Account Number
	  */
	public void setAccountNo (String AccountNo)
	{
		set_Value (COLUMNNAME_AccountNo, AccountNo);
	}

	/** Get Account No.
		@return Account Number
	  */
	public String getAccountNo () 
	{
		return (String)get_Value(COLUMNNAME_AccountNo);
	}

	/** Set Account Name.
		@param A_Name 
		Name on Credit Card or Account holder
	  */
	public void setA_Name (String A_Name)
	{
		set_Value (COLUMNNAME_A_Name, A_Name);
	}

	/** Get Account Name.
		@return Name on Credit Card or Account holder
	  */
	public String getA_Name () 
	{
		return (String)get_Value(COLUMNNAME_A_Name);
	}

	/** Set Check No.
		@param CheckNo 
		Check Number
	  */
	public void setCheckNo (String CheckNo)
	{
		set_Value (COLUMNNAME_CheckNo, CheckNo);
	}

	/** Get Check No.
		@return Check Number
	  */
	public String getCheckNo () 
	{
		return (String)get_Value(COLUMNNAME_CheckNo);
	}

	/** CheckStatus AD_Reference_ID=200007 */
	public static final int CHECKSTATUS_AD_Reference_ID=200007;
	/** Charged = C */
	public static final String CHECKSTATUS_Charged = "C";
	/** Delayed = D */
	public static final String CHECKSTATUS_Delayed = "D";
	/** Replaced = P */
	public static final String CHECKSTATUS_Replaced = "P";
	/** Received = R */
	public static final String CHECKSTATUS_Received = "R";
	/** Returned = T */
	public static final String CHECKSTATUS_Returned = "T";
	/** Set Check Status.
		@param CheckStatus Check Status	  */
	public void setCheckStatus (String CheckStatus)
	{

		set_Value (COLUMNNAME_CheckStatus, CheckStatus);
	}

	/** Get Check Status.
		@return Check Status	  */
	public String getCheckStatus () 
	{
		return (String)get_Value(COLUMNNAME_CheckStatus);
	}

	public org.compiere.model.I_C_Order getC_Order() throws RuntimeException
    {
		return (org.compiere.model.I_C_Order)MTable.get(getCtx(), org.compiere.model.I_C_Order.Table_Name)
			.getPO(getC_Order_ID(), get_TrxName());	}

	/** Set Order.
		@param C_Order_ID 
		Order
	  */
	public void setC_Order_ID (int C_Order_ID)
	{
		if (C_Order_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_Order_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_Order_ID, Integer.valueOf(C_Order_ID));
	}

	/** Get Order.
		@return Order
	  */
	public int getC_Order_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Order_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Payment getC_Payment() throws RuntimeException
    {
		return (org.compiere.model.I_C_Payment)MTable.get(getCtx(), org.compiere.model.I_C_Payment.Table_Name)
			.getPO(getC_Payment_ID(), get_TrxName());	}

	/** Set Payment.
		@param C_Payment_ID 
		Payment identifier
	  */
	public void setC_Payment_ID (int C_Payment_ID)
	{
		if (C_Payment_ID < 1) 
			set_Value (COLUMNNAME_C_Payment_ID, null);
		else 
			set_Value (COLUMNNAME_C_Payment_ID, Integer.valueOf(C_Payment_ID));
	}

	/** Get Payment.
		@return Payment identifier
	  */
	public int getC_Payment_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Payment_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set POS Payment.
		@param C_POSPayment_ID POS Payment	  */
	public void setC_POSPayment_ID (int C_POSPayment_ID)
	{
		if (C_POSPayment_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_POSPayment_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_POSPayment_ID, Integer.valueOf(C_POSPayment_ID));
	}

	/** Get POS Payment.
		@return POS Payment	  */
	public int getC_POSPayment_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_POSPayment_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_POSPayment_UU.
		@param C_POSPayment_UU C_POSPayment_UU	  */
	public void setC_POSPayment_UU (String C_POSPayment_UU)
	{
		set_Value (COLUMNNAME_C_POSPayment_UU, C_POSPayment_UU);
	}

	/** Get C_POSPayment_UU.
		@return C_POSPayment_UU	  */
	public String getC_POSPayment_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_POSPayment_UU);
	}

	public org.compiere.model.I_C_POSTenderType getC_POSTenderType() throws RuntimeException
    {
		return (org.compiere.model.I_C_POSTenderType)MTable.get(getCtx(), org.compiere.model.I_C_POSTenderType.Table_Name)
			.getPO(getC_POSTenderType_ID(), get_TrxName());	}

	/** Set POS Tender Type.
		@param C_POSTenderType_ID POS Tender Type	  */
	public void setC_POSTenderType_ID (int C_POSTenderType_ID)
	{
		if (C_POSTenderType_ID < 1) 
			set_Value (COLUMNNAME_C_POSTenderType_ID, null);
		else 
			set_Value (COLUMNNAME_C_POSTenderType_ID, Integer.valueOf(C_POSTenderType_ID));
	}

	/** Get POS Tender Type.
		@return POS Tender Type	  */
	public int getC_POSTenderType_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_POSTenderType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Number.
		@param CreditCardNumber 
		Credit Card Number 
	  */
	public void setCreditCardNumber (String CreditCardNumber)
	{
		set_Value (COLUMNNAME_CreditCardNumber, CreditCardNumber);
	}

	/** Get Number.
		@return Credit Card Number 
	  */
	public String getCreditCardNumber () 
	{
		return (String)get_Value(COLUMNNAME_CreditCardNumber);
	}

	/** CreditCardType AD_Reference_ID=149 */
	public static final int CREDITCARDTYPE_AD_Reference_ID=149;
	/** Amex = A */
	public static final String CREDITCARDTYPE_Amex = "A";
	/** MasterCard = M */
	public static final String CREDITCARDTYPE_MasterCard = "M";
	/** Visa = V */
	public static final String CREDITCARDTYPE_Visa = "V";
	/** ATM = C */
	public static final String CREDITCARDTYPE_ATM = "C";
	/** Diners = D */
	public static final String CREDITCARDTYPE_Diners = "D";
	/** Discover = N */
	public static final String CREDITCARDTYPE_Discover = "N";
	/** Purchase Card = P */
	public static final String CREDITCARDTYPE_PurchaseCard = "P";
	/** Set Credit Card.
		@param CreditCardType 
		Credit Card (Visa, MC, AmEx)
	  */
	public void setCreditCardType (String CreditCardType)
	{

		set_Value (COLUMNNAME_CreditCardType, CreditCardType);
	}

	/** Get Credit Card.
		@return Credit Card (Visa, MC, AmEx)
	  */
	public String getCreditCardType () 
	{
		return (String)get_Value(COLUMNNAME_CreditCardType);
	}

	/** Set Date Promised.
		@param DatePromised 
		Date Order was promised
	  */
	public void setDatePromised (Timestamp DatePromised)
	{
		set_Value (COLUMNNAME_DatePromised, DatePromised);
	}

	/** Get Date Promised.
		@return Date Order was promised
	  */
	public Timestamp getDatePromised () 
	{
		return (Timestamp)get_Value(COLUMNNAME_DatePromised);
	}

	/** Set Deposit Group.
		@param DepositGroup Deposit Group	  */
	public void setDepositGroup (String DepositGroup)
	{
		set_Value (COLUMNNAME_DepositGroup, DepositGroup);
	}

	/** Get Deposit Group.
		@return Deposit Group	  */
	public String getDepositGroup () 
	{
		return (String)get_Value(COLUMNNAME_DepositGroup);
	}

	/** Set Comment/Help.
		@param Help 
		Comment or Hint
	  */
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp () 
	{
		return (String)get_Value(COLUMNNAME_Help);
	}

	/** Set Post Dated.
		@param IsPostDated Post Dated	  */
	public void setIsPostDated (boolean IsPostDated)
	{
		set_Value (COLUMNNAME_IsPostDated, Boolean.valueOf(IsPostDated));
	}

	/** Get Post Dated.
		@return Post Dated	  */
	public boolean isPostDated () 
	{
		Object oo = get_Value(COLUMNNAME_IsPostDated);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Micr.
		@param Micr 
		Combination of routing no, account and check no
	  */
	public void setMicr (String Micr)
	{
		set_Value (COLUMNNAME_Micr, Micr);
	}

	/** Get Micr.
		@return Combination of routing no, account and check no
	  */
	public String getMicr () 
	{
		return (String)get_Value(COLUMNNAME_Micr);
	}

	/** Set Payment amount.
		@param PayAmt 
		Amount being paid
	  */
	public void setPayAmt (BigDecimal PayAmt)
	{
		set_Value (COLUMNNAME_PayAmt, PayAmt);
	}

	/** Get Payment amount.
		@return Amount being paid
	  */
	public BigDecimal getPayAmt () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_PayAmt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Processed.
		@param Processed 
		The document has been processed
	  */
	public void setProcessed (boolean Processed)
	{
		set_Value (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/** Get Processed.
		@return The document has been processed
	  */
	public boolean isProcessed () 
	{
		Object oo = get_Value(COLUMNNAME_Processed);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Routing No.
		@param RoutingNo 
		Bank Routing Number
	  */
	public void setRoutingNo (String RoutingNo)
	{
		set_Value (COLUMNNAME_RoutingNo, RoutingNo);
	}

	/** Get Routing No.
		@return Bank Routing Number
	  */
	public String getRoutingNo () 
	{
		return (String)get_Value(COLUMNNAME_RoutingNo);
	}

	/** TenderType AD_Reference_ID=214 */
	public static final int TENDERTYPE_AD_Reference_ID=214;
	/** Credit Card = C */
	public static final String TENDERTYPE_CreditCard = "C";
	/** Check = K */
	public static final String TENDERTYPE_Check = "K";
	/** Direct Deposit = A */
	public static final String TENDERTYPE_DirectDeposit = "A";
	/** Direct Debit = D */
	public static final String TENDERTYPE_DirectDebit = "D";
	/** Account = T */
	public static final String TENDERTYPE_Account = "T";
	/** Cash = X */
	public static final String TENDERTYPE_Cash = "X";
	/** Set Tender type.
		@param TenderType 
		Method of Payment
	  */
	public void setTenderType (String TenderType)
	{

		set_Value (COLUMNNAME_TenderType, TenderType);
	}

	/** Get Tender type.
		@return Method of Payment
	  */
	public String getTenderType () 
	{
		return (String)get_Value(COLUMNNAME_TenderType);
	}

	/** Set Voice authorization code.
		@param VoiceAuthCode 
		Voice Authorization Code from credit card company
	  */
	public void setVoiceAuthCode (String VoiceAuthCode)
	{
		set_Value (COLUMNNAME_VoiceAuthCode, VoiceAuthCode);
	}

	/** Get Voice authorization code.
		@return Voice Authorization Code from credit card company
	  */
	public String getVoiceAuthCode () 
	{
		return (String)get_Value(COLUMNNAME_VoiceAuthCode);
	}
}