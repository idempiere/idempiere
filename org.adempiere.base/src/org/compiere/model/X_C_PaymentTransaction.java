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

/** Generated Model for C_PaymentTransaction
 *  @author iDempiere (generated) 
 *  @version Release 2.0 - $Id$ */
public class X_C_PaymentTransaction extends PO implements I_C_PaymentTransaction, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131031L;

    /** Standard Constructor */
    public X_C_PaymentTransaction (Properties ctx, int C_PaymentTransaction_ID, String trxName)
    {
      super (ctx, C_PaymentTransaction_ID, trxName);
      /** if (C_PaymentTransaction_ID == 0)
        {
			setC_BPartner_ID (0);
			setC_Currency_ID (0);
			setC_PaymentTransaction_ID (0);
			setDateTrx (new Timestamp( System.currentTimeMillis() ));
// @#Date@
			setIsApproved (false);
// N
			setIsDelayedCapture (false);
			setIsOnline (false);
			setIsReceipt (false);
			setIsSelfService (false);
			setIsVoided (false);
// N
			setPayAmt (Env.ZERO);
// 0
			setProcessed (false);
// N
			setTenderType (null);
// K
			setTrxType (null);
// S
        } */
    }

    /** Load Constructor */
    public X_C_PaymentTransaction (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 1 - Org 
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
      StringBuffer sb = new StringBuffer ("X_C_PaymentTransaction[")
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

	/** Set Account City.
		@param A_City 
		City or the Credit Card or Account Holder
	  */
	public void setA_City (String A_City)
	{
		set_Value (COLUMNNAME_A_City, A_City);
	}

	/** Get Account City.
		@return City or the Credit Card or Account Holder
	  */
	public String getA_City () 
	{
		return (String)get_Value(COLUMNNAME_A_City);
	}

	/** Set Account Country.
		@param A_Country 
		Country
	  */
	public void setA_Country (String A_Country)
	{
		set_Value (COLUMNNAME_A_Country, A_Country);
	}

	/** Get Account Country.
		@return Country
	  */
	public String getA_Country () 
	{
		return (String)get_Value(COLUMNNAME_A_Country);
	}

	/** Set Trx Organization.
		@param AD_OrgTrx_ID 
		Performing or initiating organization
	  */
	public void setAD_OrgTrx_ID (int AD_OrgTrx_ID)
	{
		if (AD_OrgTrx_ID < 1) 
			set_Value (COLUMNNAME_AD_OrgTrx_ID, null);
		else 
			set_Value (COLUMNNAME_AD_OrgTrx_ID, Integer.valueOf(AD_OrgTrx_ID));
	}

	/** Get Trx Organization.
		@return Performing or initiating organization
	  */
	public int getAD_OrgTrx_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_OrgTrx_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Account EMail.
		@param A_EMail 
		Email Address
	  */
	public void setA_EMail (String A_EMail)
	{
		set_Value (COLUMNNAME_A_EMail, A_EMail);
	}

	/** Get Account EMail.
		@return Email Address
	  */
	public String getA_EMail () 
	{
		return (String)get_Value(COLUMNNAME_A_EMail);
	}

	/** Set Driver License.
		@param A_Ident_DL 
		Payment Identification - Driver License
	  */
	public void setA_Ident_DL (String A_Ident_DL)
	{
		set_Value (COLUMNNAME_A_Ident_DL, A_Ident_DL);
	}

	/** Get Driver License.
		@return Payment Identification - Driver License
	  */
	public String getA_Ident_DL () 
	{
		return (String)get_Value(COLUMNNAME_A_Ident_DL);
	}

	/** Set Social Security No.
		@param A_Ident_SSN 
		Payment Identification - Social Security No
	  */
	public void setA_Ident_SSN (String A_Ident_SSN)
	{
		set_Value (COLUMNNAME_A_Ident_SSN, A_Ident_SSN);
	}

	/** Get Social Security No.
		@return Payment Identification - Social Security No
	  */
	public String getA_Ident_SSN () 
	{
		return (String)get_Value(COLUMNNAME_A_Ident_SSN);
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

	/** Set Account State.
		@param A_State 
		State of the Credit Card or Account holder
	  */
	public void setA_State (String A_State)
	{
		set_Value (COLUMNNAME_A_State, A_State);
	}

	/** Get Account State.
		@return State of the Credit Card or Account holder
	  */
	public String getA_State () 
	{
		return (String)get_Value(COLUMNNAME_A_State);
	}

	/** Set Account Street.
		@param A_Street 
		Street address of the Credit Card or Account holder
	  */
	public void setA_Street (String A_Street)
	{
		set_Value (COLUMNNAME_A_Street, A_Street);
	}

	/** Get Account Street.
		@return Street address of the Credit Card or Account holder
	  */
	public String getA_Street () 
	{
		return (String)get_Value(COLUMNNAME_A_Street);
	}

	/** Set Account Zip/Postal.
		@param A_Zip 
		Zip Code of the Credit Card or Account Holder
	  */
	public void setA_Zip (String A_Zip)
	{
		set_Value (COLUMNNAME_A_Zip, A_Zip);
	}

	/** Get Account Zip/Postal.
		@return Zip Code of the Credit Card or Account Holder
	  */
	public String getA_Zip () 
	{
		return (String)get_Value(COLUMNNAME_A_Zip);
	}

	public org.compiere.model.I_C_Activity getC_Activity() throws RuntimeException
    {
		return (org.compiere.model.I_C_Activity)MTable.get(getCtx(), org.compiere.model.I_C_Activity.Table_Name)
			.getPO(getC_Activity_ID(), get_TrxName());	}

	/** Set Activity.
		@param C_Activity_ID 
		Business Activity
	  */
	public void setC_Activity_ID (int C_Activity_ID)
	{
		if (C_Activity_ID < 1) 
			set_Value (COLUMNNAME_C_Activity_ID, null);
		else 
			set_Value (COLUMNNAME_C_Activity_ID, Integer.valueOf(C_Activity_ID));
	}

	/** Get Activity.
		@return Business Activity
	  */
	public int getC_Activity_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Activity_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BankAccount getC_BankAccount() throws RuntimeException
    {
		return (org.compiere.model.I_C_BankAccount)MTable.get(getCtx(), org.compiere.model.I_C_BankAccount.Table_Name)
			.getPO(getC_BankAccount_ID(), get_TrxName());	}

	/** Set Bank Account.
		@param C_BankAccount_ID 
		Account at the Bank
	  */
	public void setC_BankAccount_ID (int C_BankAccount_ID)
	{
		if (C_BankAccount_ID < 1) 
			set_Value (COLUMNNAME_C_BankAccount_ID, null);
		else 
			set_Value (COLUMNNAME_C_BankAccount_ID, Integer.valueOf(C_BankAccount_ID));
	}

	/** Get Bank Account.
		@return Account at the Bank
	  */
	public int getC_BankAccount_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BankAccount_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_Name)
			.getPO(getC_BPartner_ID(), get_TrxName());	}

	/** Set Business Partner .
		@param C_BPartner_ID 
		Identifies a Business Partner
	  */
	public void setC_BPartner_ID (int C_BPartner_ID)
	{
		if (C_BPartner_ID < 1) 
			set_Value (COLUMNNAME_C_BPartner_ID, null);
		else 
			set_Value (COLUMNNAME_C_BPartner_ID, Integer.valueOf(C_BPartner_ID));
	}

	/** Get Business Partner .
		@return Identifies a Business Partner
	  */
	public int getC_BPartner_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BPartner_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BP_BankAccount getC_BP_BankAccount() throws RuntimeException
    {
		return (org.compiere.model.I_C_BP_BankAccount)MTable.get(getCtx(), org.compiere.model.I_C_BP_BankAccount.Table_Name)
			.getPO(getC_BP_BankAccount_ID(), get_TrxName());	}

	/** Set Partner Bank Account.
		@param C_BP_BankAccount_ID 
		Bank Account of the Business Partner
	  */
	public void setC_BP_BankAccount_ID (int C_BP_BankAccount_ID)
	{
		if (C_BP_BankAccount_ID < 1) 
			set_Value (COLUMNNAME_C_BP_BankAccount_ID, null);
		else 
			set_Value (COLUMNNAME_C_BP_BankAccount_ID, Integer.valueOf(C_BP_BankAccount_ID));
	}

	/** Get Partner Bank Account.
		@return Bank Account of the Business Partner
	  */
	public int getC_BP_BankAccount_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BP_BankAccount_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Campaign getC_Campaign() throws RuntimeException
    {
		return (org.compiere.model.I_C_Campaign)MTable.get(getCtx(), org.compiere.model.I_C_Campaign.Table_Name)
			.getPO(getC_Campaign_ID(), get_TrxName());	}

	/** Set Campaign.
		@param C_Campaign_ID 
		Marketing Campaign
	  */
	public void setC_Campaign_ID (int C_Campaign_ID)
	{
		if (C_Campaign_ID < 1) 
			set_Value (COLUMNNAME_C_Campaign_ID, null);
		else 
			set_Value (COLUMNNAME_C_Campaign_ID, Integer.valueOf(C_Campaign_ID));
	}

	/** Get Campaign.
		@return Marketing Campaign
	  */
	public int getC_Campaign_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Campaign_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_CashBook getC_CashBook() throws RuntimeException
    {
		return (org.compiere.model.I_C_CashBook)MTable.get(getCtx(), org.compiere.model.I_C_CashBook.Table_Name)
			.getPO(getC_CashBook_ID(), get_TrxName());	}

	/** Set Cash Book.
		@param C_CashBook_ID 
		Cash Book for recording petty cash transactions
	  */
	public void setC_CashBook_ID (int C_CashBook_ID)
	{
		if (C_CashBook_ID < 1) 
			set_Value (COLUMNNAME_C_CashBook_ID, null);
		else 
			set_Value (COLUMNNAME_C_CashBook_ID, Integer.valueOf(C_CashBook_ID));
	}

	/** Get Cash Book.
		@return Cash Book for recording petty cash transactions
	  */
	public int getC_CashBook_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_CashBook_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Charge getC_Charge() throws RuntimeException
    {
		return (org.compiere.model.I_C_Charge)MTable.get(getCtx(), org.compiere.model.I_C_Charge.Table_Name)
			.getPO(getC_Charge_ID(), get_TrxName());	}

	/** Set Charge.
		@param C_Charge_ID 
		Additional document charges
	  */
	public void setC_Charge_ID (int C_Charge_ID)
	{
		if (C_Charge_ID < 1) 
			set_Value (COLUMNNAME_C_Charge_ID, null);
		else 
			set_Value (COLUMNNAME_C_Charge_ID, Integer.valueOf(C_Charge_ID));
	}

	/** Get Charge.
		@return Additional document charges
	  */
	public int getC_Charge_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Charge_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_ConversionType getC_ConversionType() throws RuntimeException
    {
		return (org.compiere.model.I_C_ConversionType)MTable.get(getCtx(), org.compiere.model.I_C_ConversionType.Table_Name)
			.getPO(getC_ConversionType_ID(), get_TrxName());	}

	/** Set Currency Type.
		@param C_ConversionType_ID 
		Currency Conversion Rate Type
	  */
	public void setC_ConversionType_ID (int C_ConversionType_ID)
	{
		if (C_ConversionType_ID < 1) 
			set_Value (COLUMNNAME_C_ConversionType_ID, null);
		else 
			set_Value (COLUMNNAME_C_ConversionType_ID, Integer.valueOf(C_ConversionType_ID));
	}

	/** Get Currency Type.
		@return Currency Conversion Rate Type
	  */
	public int getC_ConversionType_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ConversionType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Currency getC_Currency() throws RuntimeException
    {
		return (org.compiere.model.I_C_Currency)MTable.get(getCtx(), org.compiere.model.I_C_Currency.Table_Name)
			.getPO(getC_Currency_ID(), get_TrxName());	}

	/** Set Currency.
		@param C_Currency_ID 
		The Currency for this record
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
	public int getC_Currency_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Currency_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	public org.compiere.model.I_C_Invoice getC_Invoice() throws RuntimeException
    {
		return (org.compiere.model.I_C_Invoice)MTable.get(getCtx(), org.compiere.model.I_C_Invoice.Table_Name)
			.getPO(getC_Invoice_ID(), get_TrxName());	}

	/** Set Invoice.
		@param C_Invoice_ID 
		Invoice Identifier
	  */
	public void setC_Invoice_ID (int C_Invoice_ID)
	{
		if (C_Invoice_ID < 1) 
			set_Value (COLUMNNAME_C_Invoice_ID, null);
		else 
			set_Value (COLUMNNAME_C_Invoice_ID, Integer.valueOf(C_Invoice_ID));
	}

	/** Get Invoice.
		@return Invoice Identifier
	  */
	public int getC_Invoice_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Invoice_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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
			set_Value (COLUMNNAME_C_Order_ID, null);
		else 
			set_Value (COLUMNNAME_C_Order_ID, Integer.valueOf(C_Order_ID));
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

	public org.compiere.model.I_C_PaymentBatch getC_PaymentBatch() throws RuntimeException
    {
		return (org.compiere.model.I_C_PaymentBatch)MTable.get(getCtx(), org.compiere.model.I_C_PaymentBatch.Table_Name)
			.getPO(getC_PaymentBatch_ID(), get_TrxName());	}

	/** Set Payment Batch.
		@param C_PaymentBatch_ID 
		Payment batch for EFT
	  */
	public void setC_PaymentBatch_ID (int C_PaymentBatch_ID)
	{
		if (C_PaymentBatch_ID < 1) 
			set_Value (COLUMNNAME_C_PaymentBatch_ID, null);
		else 
			set_Value (COLUMNNAME_C_PaymentBatch_ID, Integer.valueOf(C_PaymentBatch_ID));
	}

	/** Get Payment Batch.
		@return Payment batch for EFT
	  */
	public int getC_PaymentBatch_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_PaymentBatch_ID);
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

	public org.compiere.model.I_C_PaymentProcessor getC_PaymentProcessor() throws RuntimeException
    {
		return (org.compiere.model.I_C_PaymentProcessor)MTable.get(getCtx(), org.compiere.model.I_C_PaymentProcessor.Table_Name)
			.getPO(getC_PaymentProcessor_ID(), get_TrxName());	}

	/** Set Payment Processor.
		@param C_PaymentProcessor_ID 
		Payment processor for electronic payments
	  */
	public void setC_PaymentProcessor_ID (int C_PaymentProcessor_ID)
	{
		if (C_PaymentProcessor_ID < 1) 
			set_Value (COLUMNNAME_C_PaymentProcessor_ID, null);
		else 
			set_Value (COLUMNNAME_C_PaymentProcessor_ID, Integer.valueOf(C_PaymentProcessor_ID));
	}

	/** Get Payment Processor.
		@return Payment processor for electronic payments
	  */
	public int getC_PaymentProcessor_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_PaymentProcessor_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Payment Transaction.
		@param C_PaymentTransaction_ID Payment Transaction	  */
	public void setC_PaymentTransaction_ID (int C_PaymentTransaction_ID)
	{
		if (C_PaymentTransaction_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_PaymentTransaction_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_PaymentTransaction_ID, Integer.valueOf(C_PaymentTransaction_ID));
	}

	/** Get Payment Transaction.
		@return Payment Transaction	  */
	public int getC_PaymentTransaction_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_PaymentTransaction_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_PaymentTransaction_UU.
		@param C_PaymentTransaction_UU C_PaymentTransaction_UU	  */
	public void setC_PaymentTransaction_UU (String C_PaymentTransaction_UU)
	{
		set_Value (COLUMNNAME_C_PaymentTransaction_UU, C_PaymentTransaction_UU);
	}

	/** Get C_PaymentTransaction_UU.
		@return C_PaymentTransaction_UU	  */
	public String getC_PaymentTransaction_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_PaymentTransaction_UU);
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

	public org.compiere.model.I_C_Project getC_Project() throws RuntimeException
    {
		return (org.compiere.model.I_C_Project)MTable.get(getCtx(), org.compiere.model.I_C_Project.Table_Name)
			.getPO(getC_Project_ID(), get_TrxName());	}

	/** Set Project.
		@param C_Project_ID 
		Financial Project
	  */
	public void setC_Project_ID (int C_Project_ID)
	{
		if (C_Project_ID < 1) 
			set_Value (COLUMNNAME_C_Project_ID, null);
		else 
			set_Value (COLUMNNAME_C_Project_ID, Integer.valueOf(C_Project_ID));
	}

	/** Get Project.
		@return Financial Project
	  */
	public int getC_Project_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Project_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Exp. Month.
		@param CreditCardExpMM 
		Expiry Month
	  */
	public void setCreditCardExpMM (int CreditCardExpMM)
	{
		set_Value (COLUMNNAME_CreditCardExpMM, Integer.valueOf(CreditCardExpMM));
	}

	/** Get Exp. Month.
		@return Expiry Month
	  */
	public int getCreditCardExpMM () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_CreditCardExpMM);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Exp. Year.
		@param CreditCardExpYY 
		Expiry Year
	  */
	public void setCreditCardExpYY (int CreditCardExpYY)
	{
		set_Value (COLUMNNAME_CreditCardExpYY, Integer.valueOf(CreditCardExpYY));
	}

	/** Get Exp. Year.
		@return Expiry Year
	  */
	public int getCreditCardExpYY () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_CreditCardExpYY);
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

	/** Set Verification Code.
		@param CreditCardVV 
		Credit Card Verification code on credit card
	  */
	public void setCreditCardVV (String CreditCardVV)
	{
		set_Value (COLUMNNAME_CreditCardVV, CreditCardVV);
	}

	/** Get Verification Code.
		@return Credit Card Verification code on credit card
	  */
	public String getCreditCardVV () 
	{
		return (String)get_Value(COLUMNNAME_CreditCardVV);
	}

	/** Set Customer Address ID.
		@param CustomerAddressID Customer Address ID	  */
	public void setCustomerAddressID (String CustomerAddressID)
	{
		set_Value (COLUMNNAME_CustomerAddressID, CustomerAddressID);
	}

	/** Get Customer Address ID.
		@return Customer Address ID	  */
	public String getCustomerAddressID () 
	{
		return (String)get_Value(COLUMNNAME_CustomerAddressID);
	}

	/** Set Customer Payment Profile ID.
		@param CustomerPaymentProfileID Customer Payment Profile ID	  */
	public void setCustomerPaymentProfileID (String CustomerPaymentProfileID)
	{
		set_Value (COLUMNNAME_CustomerPaymentProfileID, CustomerPaymentProfileID);
	}

	/** Get Customer Payment Profile ID.
		@return Customer Payment Profile ID	  */
	public String getCustomerPaymentProfileID () 
	{
		return (String)get_Value(COLUMNNAME_CustomerPaymentProfileID);
	}

	/** Set Customer Profile ID.
		@param CustomerProfileID Customer Profile ID	  */
	public void setCustomerProfileID (String CustomerProfileID)
	{
		set_Value (COLUMNNAME_CustomerProfileID, CustomerProfileID);
	}

	/** Get Customer Profile ID.
		@return Customer Profile ID	  */
	public String getCustomerProfileID () 
	{
		return (String)get_Value(COLUMNNAME_CustomerProfileID);
	}

	/** Set Transaction Date.
		@param DateTrx 
		Transaction Date
	  */
	public void setDateTrx (Timestamp DateTrx)
	{
		set_Value (COLUMNNAME_DateTrx, DateTrx);
	}

	/** Get Transaction Date.
		@return Transaction Date
	  */
	public Timestamp getDateTrx () 
	{
		return (Timestamp)get_Value(COLUMNNAME_DateTrx);
	}

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Approved.
		@param IsApproved 
		Indicates if this document requires approval
	  */
	public void setIsApproved (boolean IsApproved)
	{
		set_ValueNoCheck (COLUMNNAME_IsApproved, Boolean.valueOf(IsApproved));
	}

	/** Get Approved.
		@return Indicates if this document requires approval
	  */
	public boolean isApproved () 
	{
		Object oo = get_Value(COLUMNNAME_IsApproved);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Delayed Capture.
		@param IsDelayedCapture 
		Charge after Shipment
	  */
	public void setIsDelayedCapture (boolean IsDelayedCapture)
	{
		set_Value (COLUMNNAME_IsDelayedCapture, Boolean.valueOf(IsDelayedCapture));
	}

	/** Get Delayed Capture.
		@return Charge after Shipment
	  */
	public boolean isDelayedCapture () 
	{
		Object oo = get_Value(COLUMNNAME_IsDelayedCapture);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Online Access.
		@param IsOnline 
		Can be accessed online 
	  */
	public void setIsOnline (boolean IsOnline)
	{
		set_Value (COLUMNNAME_IsOnline, Boolean.valueOf(IsOnline));
	}

	/** Get Online Access.
		@return Can be accessed online 
	  */
	public boolean isOnline () 
	{
		Object oo = get_Value(COLUMNNAME_IsOnline);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Receipt.
		@param IsReceipt 
		This is a sales transaction (receipt)
	  */
	public void setIsReceipt (boolean IsReceipt)
	{
		set_Value (COLUMNNAME_IsReceipt, Boolean.valueOf(IsReceipt));
	}

	/** Get Receipt.
		@return This is a sales transaction (receipt)
	  */
	public boolean isReceipt () 
	{
		Object oo = get_Value(COLUMNNAME_IsReceipt);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Self-Service.
		@param IsSelfService 
		This is a Self-Service entry or this entry can be changed via Self-Service
	  */
	public void setIsSelfService (boolean IsSelfService)
	{
		set_Value (COLUMNNAME_IsSelfService, Boolean.valueOf(IsSelfService));
	}

	/** Get Self-Service.
		@return This is a Self-Service entry or this entry can be changed via Self-Service
	  */
	public boolean isSelfService () 
	{
		Object oo = get_Value(COLUMNNAME_IsSelfService);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Voided.
		@param IsVoided Voided	  */
	public void setIsVoided (boolean IsVoided)
	{
		set_Value (COLUMNNAME_IsVoided, Boolean.valueOf(IsVoided));
	}

	/** Get Voided.
		@return Voided	  */
	public boolean isVoided () 
	{
		Object oo = get_Value(COLUMNNAME_IsVoided);
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

	/** Set Original Transaction ID.
		@param Orig_TrxID 
		Original Transaction ID
	  */
	public void setOrig_TrxID (String Orig_TrxID)
	{
		set_Value (COLUMNNAME_Orig_TrxID, Orig_TrxID);
	}

	/** Get Original Transaction ID.
		@return Original Transaction ID
	  */
	public String getOrig_TrxID () 
	{
		return (String)get_Value(COLUMNNAME_Orig_TrxID);
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

	/** Set PO Number.
		@param PONum 
		Purchase Order Number
	  */
	public void setPONum (String PONum)
	{
		set_Value (COLUMNNAME_PONum, PONum);
	}

	/** Get PO Number.
		@return Purchase Order Number
	  */
	public String getPONum () 
	{
		return (String)get_Value(COLUMNNAME_PONum);
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

	/** Set Authorization Code.
		@param R_AuthCode 
		Authorization Code returned
	  */
	public void setR_AuthCode (String R_AuthCode)
	{
		set_ValueNoCheck (COLUMNNAME_R_AuthCode, R_AuthCode);
	}

	/** Get Authorization Code.
		@return Authorization Code returned
	  */
	public String getR_AuthCode () 
	{
		return (String)get_Value(COLUMNNAME_R_AuthCode);
	}

	/** R_AvsAddr AD_Reference_ID=213 */
	public static final int R_AVSADDR_AD_Reference_ID=213;
	/** Match = Y */
	public static final String R_AVSADDR_Match = "Y";
	/** No Match = N */
	public static final String R_AVSADDR_NoMatch = "N";
	/** Unavailable = X */
	public static final String R_AVSADDR_Unavailable = "X";
	/** Set Address verified.
		@param R_AvsAddr 
		This address has been verified
	  */
	public void setR_AvsAddr (String R_AvsAddr)
	{

		set_ValueNoCheck (COLUMNNAME_R_AvsAddr, R_AvsAddr);
	}

	/** Get Address verified.
		@return This address has been verified
	  */
	public String getR_AvsAddr () 
	{
		return (String)get_Value(COLUMNNAME_R_AvsAddr);
	}

	/** R_AvsZip AD_Reference_ID=213 */
	public static final int R_AVSZIP_AD_Reference_ID=213;
	/** Match = Y */
	public static final String R_AVSZIP_Match = "Y";
	/** No Match = N */
	public static final String R_AVSZIP_NoMatch = "N";
	/** Unavailable = X */
	public static final String R_AVSZIP_Unavailable = "X";
	/** Set Zip verified.
		@param R_AvsZip 
		The Zip Code has been verified
	  */
	public void setR_AvsZip (String R_AvsZip)
	{

		set_ValueNoCheck (COLUMNNAME_R_AvsZip, R_AvsZip);
	}

	/** Get Zip verified.
		@return The Zip Code has been verified
	  */
	public String getR_AvsZip () 
	{
		return (String)get_Value(COLUMNNAME_R_AvsZip);
	}

	/** Set CVV Match.
		@param R_CVV2Match 
		Credit Card Verification Code Match
	  */
	public void setR_CVV2Match (boolean R_CVV2Match)
	{
		set_ValueNoCheck (COLUMNNAME_R_CVV2Match, Boolean.valueOf(R_CVV2Match));
	}

	/** Get CVV Match.
		@return Credit Card Verification Code Match
	  */
	public boolean isR_CVV2Match () 
	{
		Object oo = get_Value(COLUMNNAME_R_CVV2Match);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	public org.compiere.model.I_C_PaymentTransaction getRef_PaymentTransaction() throws RuntimeException
    {
		return (org.compiere.model.I_C_PaymentTransaction)MTable.get(getCtx(), org.compiere.model.I_C_PaymentTransaction.Table_Name)
			.getPO(getRef_PaymentTransaction_ID(), get_TrxName());	}

	/** Set Referenced Payment Transaction.
		@param Ref_PaymentTransaction_ID Referenced Payment Transaction	  */
	public void setRef_PaymentTransaction_ID (int Ref_PaymentTransaction_ID)
	{
		if (Ref_PaymentTransaction_ID < 1) 
			set_Value (COLUMNNAME_Ref_PaymentTransaction_ID, null);
		else 
			set_Value (COLUMNNAME_Ref_PaymentTransaction_ID, Integer.valueOf(Ref_PaymentTransaction_ID));
	}

	/** Get Referenced Payment Transaction.
		@return Referenced Payment Transaction	  */
	public int getRef_PaymentTransaction_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_Ref_PaymentTransaction_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Info.
		@param R_Info 
		Response info
	  */
	public void setR_Info (String R_Info)
	{
		set_ValueNoCheck (COLUMNNAME_R_Info, R_Info);
	}

	/** Get Info.
		@return Response info
	  */
	public String getR_Info () 
	{
		return (String)get_Value(COLUMNNAME_R_Info);
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

	/** Set Reference.
		@param R_PnRef 
		Payment reference
	  */
	public void setR_PnRef (String R_PnRef)
	{
		set_ValueNoCheck (COLUMNNAME_R_PnRef, R_PnRef);
	}

	/** Get Reference.
		@return Payment reference
	  */
	public String getR_PnRef () 
	{
		return (String)get_Value(COLUMNNAME_R_PnRef);
	}

	/** Set Response Message.
		@param R_RespMsg 
		Response message
	  */
	public void setR_RespMsg (String R_RespMsg)
	{
		set_ValueNoCheck (COLUMNNAME_R_RespMsg, R_RespMsg);
	}

	/** Get Response Message.
		@return Response message
	  */
	public String getR_RespMsg () 
	{
		return (String)get_Value(COLUMNNAME_R_RespMsg);
	}

	/** Set Result.
		@param R_Result 
		Result of transmission
	  */
	public void setR_Result (String R_Result)
	{
		set_ValueNoCheck (COLUMNNAME_R_Result, R_Result);
	}

	/** Get Result.
		@return Result of transmission
	  */
	public String getR_Result () 
	{
		return (String)get_Value(COLUMNNAME_R_Result);
	}

	/** Set Void Message.
		@param R_VoidMsg Void Message	  */
	public void setR_VoidMsg (String R_VoidMsg)
	{
		set_Value (COLUMNNAME_R_VoidMsg, R_VoidMsg);
	}

	/** Get Void Message.
		@return Void Message	  */
	public String getR_VoidMsg () 
	{
		return (String)get_Value(COLUMNNAME_R_VoidMsg);
	}

	/** Set Tax Amount.
		@param TaxAmt 
		Tax Amount for a document
	  */
	public void setTaxAmt (BigDecimal TaxAmt)
	{
		set_Value (COLUMNNAME_TaxAmt, TaxAmt);
	}

	/** Get Tax Amount.
		@return Tax Amount for a document
	  */
	public BigDecimal getTaxAmt () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_TaxAmt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
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

	/** TrxType AD_Reference_ID=215 */
	public static final int TRXTYPE_AD_Reference_ID=215;
	/** Sales = S */
	public static final String TRXTYPE_Sales = "S";
	/** Delayed Capture = D */
	public static final String TRXTYPE_DelayedCapture = "D";
	/** Credit (Payment) = C */
	public static final String TRXTYPE_CreditPayment = "C";
	/** Voice Authorization = F */
	public static final String TRXTYPE_VoiceAuthorization = "F";
	/** Authorization = A */
	public static final String TRXTYPE_Authorization = "A";
	/** Void = V */
	public static final String TRXTYPE_Void = "V";
	/** Set Transaction Type.
		@param TrxType 
		Type of credit card transaction
	  */
	public void setTrxType (String TrxType)
	{

		set_Value (COLUMNNAME_TrxType, TrxType);
	}

	/** Get Transaction Type.
		@return Type of credit card transaction
	  */
	public String getTrxType () 
	{
		return (String)get_Value(COLUMNNAME_TrxType);
	}

	public org.compiere.model.I_C_ElementValue getUser1() throws RuntimeException
    {
		return (org.compiere.model.I_C_ElementValue)MTable.get(getCtx(), org.compiere.model.I_C_ElementValue.Table_Name)
			.getPO(getUser1_ID(), get_TrxName());	}

	/** Set User List 1.
		@param User1_ID 
		User defined list element #1
	  */
	public void setUser1_ID (int User1_ID)
	{
		if (User1_ID < 1) 
			set_Value (COLUMNNAME_User1_ID, null);
		else 
			set_Value (COLUMNNAME_User1_ID, Integer.valueOf(User1_ID));
	}

	/** Get User List 1.
		@return User defined list element #1
	  */
	public int getUser1_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_User1_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_ElementValue getUser2() throws RuntimeException
    {
		return (org.compiere.model.I_C_ElementValue)MTable.get(getCtx(), org.compiere.model.I_C_ElementValue.Table_Name)
			.getPO(getUser2_ID(), get_TrxName());	}

	/** Set User List 2.
		@param User2_ID 
		User defined list element #2
	  */
	public void setUser2_ID (int User2_ID)
	{
		if (User2_ID < 1) 
			set_Value (COLUMNNAME_User2_ID, null);
		else 
			set_Value (COLUMNNAME_User2_ID, Integer.valueOf(User2_ID));
	}

	/** Get User List 2.
		@return User defined list element #2
	  */
	public int getUser2_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_User2_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	/** Set Void It.
		@param VoidIt Void It	  */
	public void setVoidIt (String VoidIt)
	{
		set_Value (COLUMNNAME_VoidIt, VoidIt);
	}

	/** Get Void It.
		@return Void It	  */
	public String getVoidIt () 
	{
		return (String)get_Value(COLUMNNAME_VoidIt);
	}
}