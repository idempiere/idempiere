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

/** Generated Model for C_BankTransfer
 *  @author iDempiere (generated) 
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="C_BankTransfer")
public class X_C_BankTransfer extends PO implements I_C_BankTransfer, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220414L;

    /** Standard Constructor */
    public X_C_BankTransfer (Properties ctx, int C_BankTransfer_ID, String trxName)
    {
      super (ctx, C_BankTransfer_ID, trxName);
      /** if (C_BankTransfer_ID == 0)
        {
			setC_BankTransfer_ID (0);
			setDateAcct (new Timestamp( System.currentTimeMillis() ));
// @#Date@
			setDocAction (null);
// CO
			setDocStatus (null);
// DR
			setDocumentNo (null);
			setFrom_AD_Org_ID (0);
			setFrom_Amt (Env.ZERO);
			setFrom_C_BankAccount_ID (0);
			setFrom_C_BPartner_ID (0);
			setFrom_C_Charge_ID (0);
			setFrom_C_Currency_ID (0);
			setFrom_TenderType (null);
// A
			setIsOverrideCurrencyRate (false);
// N
			setPayDate (new Timestamp( System.currentTimeMillis() ));
// @#Date@
			setProcessed (false);
			setRate (Env.ZERO);
			setTo_AD_Org_ID (0);
			setTo_Amt (Env.ZERO);
			setTo_C_BankAccount_ID (0);
			setTo_C_BPartner_ID (0);
			setTo_C_Charge_ID (0);
			setTo_C_Currency_ID (0);
			setTo_TenderType (null);
// D
        } */
    }

    /** Standard Constructor */
    public X_C_BankTransfer (Properties ctx, int C_BankTransfer_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_BankTransfer_ID, trxName, virtualColumns);
      /** if (C_BankTransfer_ID == 0)
        {
			setC_BankTransfer_ID (0);
			setDateAcct (new Timestamp( System.currentTimeMillis() ));
// @#Date@
			setDocAction (null);
// CO
			setDocStatus (null);
// DR
			setDocumentNo (null);
			setFrom_AD_Org_ID (0);
			setFrom_Amt (Env.ZERO);
			setFrom_C_BankAccount_ID (0);
			setFrom_C_BPartner_ID (0);
			setFrom_C_Charge_ID (0);
			setFrom_C_Currency_ID (0);
			setFrom_TenderType (null);
// A
			setIsOverrideCurrencyRate (false);
// N
			setPayDate (new Timestamp( System.currentTimeMillis() ));
// @#Date@
			setProcessed (false);
			setRate (Env.ZERO);
			setTo_AD_Org_ID (0);
			setTo_Amt (Env.ZERO);
			setTo_C_BankAccount_ID (0);
			setTo_C_BPartner_ID (0);
			setTo_C_Charge_ID (0);
			setTo_C_Currency_ID (0);
			setTo_TenderType (null);
// D
        } */
    }

    /** Load Constructor */
    public X_C_BankTransfer (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_C_BankTransfer[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Bank Transfer.
		@param C_BankTransfer_ID Bank Transfer
	*/
	public void setC_BankTransfer_ID (int C_BankTransfer_ID)
	{
		if (C_BankTransfer_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_BankTransfer_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_BankTransfer_ID, Integer.valueOf(C_BankTransfer_ID));
	}

	/** Get Bank Transfer.
		@return Bank Transfer
	  */
	public int getC_BankTransfer_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BankTransfer_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_BankTransfer_UU.
		@param C_BankTransfer_UU C_BankTransfer_UU
	*/
	public void setC_BankTransfer_UU (String C_BankTransfer_UU)
	{
		set_Value (COLUMNNAME_C_BankTransfer_UU, C_BankTransfer_UU);
	}

	/** Get C_BankTransfer_UU.
		@return C_BankTransfer_UU	  */
	public String getC_BankTransfer_UU()
	{
		return (String)get_Value(COLUMNNAME_C_BankTransfer_UU);
	}

	public org.compiere.model.I_C_ConversionType getC_ConversionType() throws RuntimeException
	{
		return (org.compiere.model.I_C_ConversionType)MTable.get(getCtx(), org.compiere.model.I_C_ConversionType.Table_ID)
			.getPO(getC_ConversionType_ID(), get_TrxName());
	}

	/** Set Currency Type.
		@param C_ConversionType_ID Currency Conversion Rate Type
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
	public int getC_ConversionType_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_ConversionType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Account Date.
		@param DateAcct Accounting Date
	*/
	public void setDateAcct (Timestamp DateAcct)
	{
		set_Value (COLUMNNAME_DateAcct, DateAcct);
	}

	/** Get Account Date.
		@return Accounting Date
	  */
	public Timestamp getDateAcct()
	{
		return (Timestamp)get_Value(COLUMNNAME_DateAcct);
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

	/** DocAction AD_Reference_ID=135 */
	public static final int DOCACTION_AD_Reference_ID=135;
	/** &lt;None&gt; = -- */
	public static final String DOCACTION_None = "--";
	/** Approve = AP */
	public static final String DOCACTION_Approve = "AP";
	/** Close = CL */
	public static final String DOCACTION_Close = "CL";
	/** Complete = CO */
	public static final String DOCACTION_Complete = "CO";
	/** Invalidate = IN */
	public static final String DOCACTION_Invalidate = "IN";
	/** Post = PO */
	public static final String DOCACTION_Post = "PO";
	/** Prepare = PR */
	public static final String DOCACTION_Prepare = "PR";
	/** Reverse - Accrual = RA */
	public static final String DOCACTION_Reverse_Accrual = "RA";
	/** Reverse - Correct = RC */
	public static final String DOCACTION_Reverse_Correct = "RC";
	/** Re-activate = RE */
	public static final String DOCACTION_Re_Activate = "RE";
	/** Reject = RJ */
	public static final String DOCACTION_Reject = "RJ";
	/** Void = VO */
	public static final String DOCACTION_Void = "VO";
	/** Wait Complete = WC */
	public static final String DOCACTION_WaitComplete = "WC";
	/** Unlock = XL */
	public static final String DOCACTION_Unlock = "XL";
	/** Set Document Action.
		@param DocAction The targeted status of the document
	*/
	public void setDocAction (String DocAction)
	{

		set_Value (COLUMNNAME_DocAction, DocAction);
	}

	/** Get Document Action.
		@return The targeted status of the document
	  */
	public String getDocAction()
	{
		return (String)get_Value(COLUMNNAME_DocAction);
	}

	/** DocStatus AD_Reference_ID=131 */
	public static final int DOCSTATUS_AD_Reference_ID=131;
	/** Unknown = ?? */
	public static final String DOCSTATUS_Unknown = "??";
	/** Approved = AP */
	public static final String DOCSTATUS_Approved = "AP";
	/** Closed = CL */
	public static final String DOCSTATUS_Closed = "CL";
	/** Completed = CO */
	public static final String DOCSTATUS_Completed = "CO";
	/** Drafted = DR */
	public static final String DOCSTATUS_Drafted = "DR";
	/** Invalid = IN */
	public static final String DOCSTATUS_Invalid = "IN";
	/** In Progress = IP */
	public static final String DOCSTATUS_InProgress = "IP";
	/** Not Approved = NA */
	public static final String DOCSTATUS_NotApproved = "NA";
	/** Reversed = RE */
	public static final String DOCSTATUS_Reversed = "RE";
	/** Voided = VO */
	public static final String DOCSTATUS_Voided = "VO";
	/** Waiting Confirmation = WC */
	public static final String DOCSTATUS_WaitingConfirmation = "WC";
	/** Waiting Payment = WP */
	public static final String DOCSTATUS_WaitingPayment = "WP";
	/** Set Document Status.
		@param DocStatus The current status of the document
	*/
	public void setDocStatus (String DocStatus)
	{

		set_Value (COLUMNNAME_DocStatus, DocStatus);
	}

	/** Get Document Status.
		@return The current status of the document
	  */
	public String getDocStatus()
	{
		return (String)get_Value(COLUMNNAME_DocStatus);
	}

	/** Set Document No.
		@param DocumentNo Document sequence number of the document
	*/
	public void setDocumentNo (String DocumentNo)
	{
		set_Value (COLUMNNAME_DocumentNo, DocumentNo);
	}

	/** Get Document No.
		@return Document sequence number of the document
	  */
	public String getDocumentNo()
	{
		return (String)get_Value(COLUMNNAME_DocumentNo);
	}

	/** Set From Organization.
		@param From_AD_Org_ID From Organization
	*/
	public void setFrom_AD_Org_ID (int From_AD_Org_ID)
	{
		if (From_AD_Org_ID < 1)
			set_Value (COLUMNNAME_From_AD_Org_ID, null);
		else
			set_Value (COLUMNNAME_From_AD_Org_ID, Integer.valueOf(From_AD_Org_ID));
	}

	/** Get From Organization.
		@return From Organization	  */
	public int getFrom_AD_Org_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_From_AD_Org_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set From Amount.
		@param From_Amt From Amount
	*/
	public void setFrom_Amt (BigDecimal From_Amt)
	{
		set_Value (COLUMNNAME_From_Amt, From_Amt);
	}

	/** Get From Amount.
		@return From Amount	  */
	public BigDecimal getFrom_Amt()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_From_Amt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_C_BankAccount getFrom_C_BankAccount() throws RuntimeException
	{
		return (org.compiere.model.I_C_BankAccount)MTable.get(getCtx(), org.compiere.model.I_C_BankAccount.Table_ID)
			.getPO(getFrom_C_BankAccount_ID(), get_TrxName());
	}

	/** Set From Bank Account.
		@param From_C_BankAccount_ID From Bank Account
	*/
	public void setFrom_C_BankAccount_ID (int From_C_BankAccount_ID)
	{
		if (From_C_BankAccount_ID < 1)
			set_Value (COLUMNNAME_From_C_BankAccount_ID, null);
		else
			set_Value (COLUMNNAME_From_C_BankAccount_ID, Integer.valueOf(From_C_BankAccount_ID));
	}

	/** Get From Bank Account.
		@return From Bank Account	  */
	public int getFrom_C_BankAccount_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_From_C_BankAccount_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BPartner getFrom_C_BPartner() throws RuntimeException
	{
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_ID)
			.getPO(getFrom_C_BPartner_ID(), get_TrxName());
	}

	/** Set From Business Partner .
		@param From_C_BPartner_ID Identifies a Business Partner
	*/
	public void setFrom_C_BPartner_ID (int From_C_BPartner_ID)
	{
		if (From_C_BPartner_ID < 1)
			set_Value (COLUMNNAME_From_C_BPartner_ID, null);
		else
			set_Value (COLUMNNAME_From_C_BPartner_ID, Integer.valueOf(From_C_BPartner_ID));
	}

	/** Get From Business Partner .
		@return Identifies a Business Partner
	  */
	public int getFrom_C_BPartner_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_From_C_BPartner_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Charge getFrom_C_Charge() throws RuntimeException
	{
		return (org.compiere.model.I_C_Charge)MTable.get(getCtx(), org.compiere.model.I_C_Charge.Table_ID)
			.getPO(getFrom_C_Charge_ID(), get_TrxName());
	}

	/** Set From Charge.
		@param From_C_Charge_ID From Charge
	*/
	public void setFrom_C_Charge_ID (int From_C_Charge_ID)
	{
		if (From_C_Charge_ID < 1)
			set_Value (COLUMNNAME_From_C_Charge_ID, null);
		else
			set_Value (COLUMNNAME_From_C_Charge_ID, Integer.valueOf(From_C_Charge_ID));
	}

	/** Get From Charge.
		@return From Charge	  */
	public int getFrom_C_Charge_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_From_C_Charge_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Currency getFrom_C_Currency() throws RuntimeException
	{
		return (org.compiere.model.I_C_Currency)MTable.get(getCtx(), org.compiere.model.I_C_Currency.Table_ID)
			.getPO(getFrom_C_Currency_ID(), get_TrxName());
	}

	/** Set From Bank Currency.
		@param From_C_Currency_ID From Bank Currency
	*/
	public void setFrom_C_Currency_ID (int From_C_Currency_ID)
	{
		if (From_C_Currency_ID < 1)
			set_Value (COLUMNNAME_From_C_Currency_ID, null);
		else
			set_Value (COLUMNNAME_From_C_Currency_ID, Integer.valueOf(From_C_Currency_ID));
	}

	/** Get From Bank Currency.
		@return From Bank Currency	  */
	public int getFrom_C_Currency_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_From_C_Currency_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** From_TenderType AD_Reference_ID=214 */
	public static final int FROM_TENDERTYPE_AD_Reference_ID=214;
	/** Direct Deposit = A */
	public static final String FROM_TENDERTYPE_DirectDeposit = "A";
	/** Credit Card = C */
	public static final String FROM_TENDERTYPE_CreditCard = "C";
	/** Direct Debit = D */
	public static final String FROM_TENDERTYPE_DirectDebit = "D";
	/** Check = K */
	public static final String FROM_TENDERTYPE_Check = "K";
	/** Account = T */
	public static final String FROM_TENDERTYPE_Account = "T";
	/** Cash = X */
	public static final String FROM_TENDERTYPE_Cash = "X";
	/** Set From Tender Type.
		@param From_TenderType From Tender Type
	*/
	public void setFrom_TenderType (String From_TenderType)
	{

		set_Value (COLUMNNAME_From_TenderType, From_TenderType);
	}

	/** Get From Tender Type.
		@return From Tender Type	  */
	public String getFrom_TenderType()
	{
		return (String)get_Value(COLUMNNAME_From_TenderType);
	}

	/** Set Override Currency Conversion Rate.
		@param IsOverrideCurrencyRate Override Currency Conversion Rate
	*/
	public void setIsOverrideCurrencyRate (boolean IsOverrideCurrencyRate)
	{
		set_Value (COLUMNNAME_IsOverrideCurrencyRate, Boolean.valueOf(IsOverrideCurrencyRate));
	}

	/** Get Override Currency Conversion Rate.
		@return Override Currency Conversion Rate
	  */
	public boolean isOverrideCurrencyRate()
	{
		Object oo = get_Value(COLUMNNAME_IsOverrideCurrencyRate);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Payment date.
		@param PayDate Date Payment made
	*/
	public void setPayDate (Timestamp PayDate)
	{
		set_Value (COLUMNNAME_PayDate, PayDate);
	}

	/** Get Payment date.
		@return Date Payment made
	  */
	public Timestamp getPayDate()
	{
		return (Timestamp)get_Value(COLUMNNAME_PayDate);
	}

	/** Set Processed.
		@param Processed The document has been processed
	*/
	public void setProcessed (boolean Processed)
	{
		set_Value (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/** Get Processed.
		@return The document has been processed
	  */
	public boolean isProcessed()
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

	/** Set Process Now.
		@param Processing Process Now
	*/
	public void setProcessing (boolean Processing)
	{
		set_Value (COLUMNNAME_Processing, Boolean.valueOf(Processing));
	}

	/** Get Process Now.
		@return Process Now	  */
	public boolean isProcessing()
	{
		Object oo = get_Value(COLUMNNAME_Processing);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Rate.
		@param Rate Rate or Tax or Exchange
	*/
	public void setRate (BigDecimal Rate)
	{
		set_Value (COLUMNNAME_Rate, Rate);
	}

	/** Get Rate.
		@return Rate or Tax or Exchange
	  */
	public BigDecimal getRate()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Rate);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set To Organization.
		@param To_AD_Org_ID To Organization
	*/
	public void setTo_AD_Org_ID (int To_AD_Org_ID)
	{
		if (To_AD_Org_ID < 1)
			set_Value (COLUMNNAME_To_AD_Org_ID, null);
		else
			set_Value (COLUMNNAME_To_AD_Org_ID, Integer.valueOf(To_AD_Org_ID));
	}

	/** Get To Organization.
		@return To Organization	  */
	public int getTo_AD_Org_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_To_AD_Org_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set To Amount.
		@param To_Amt To Amount
	*/
	public void setTo_Amt (BigDecimal To_Amt)
	{
		set_Value (COLUMNNAME_To_Amt, To_Amt);
	}

	/** Get To Amount.
		@return To Amount	  */
	public BigDecimal getTo_Amt()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_To_Amt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_C_BankAccount getTo_C_BankAccount() throws RuntimeException
	{
		return (org.compiere.model.I_C_BankAccount)MTable.get(getCtx(), org.compiere.model.I_C_BankAccount.Table_ID)
			.getPO(getTo_C_BankAccount_ID(), get_TrxName());
	}

	/** Set To Bank Account.
		@param To_C_BankAccount_ID To Bank Account
	*/
	public void setTo_C_BankAccount_ID (int To_C_BankAccount_ID)
	{
		if (To_C_BankAccount_ID < 1)
			set_Value (COLUMNNAME_To_C_BankAccount_ID, null);
		else
			set_Value (COLUMNNAME_To_C_BankAccount_ID, Integer.valueOf(To_C_BankAccount_ID));
	}

	/** Get To Bank Account.
		@return To Bank Account	  */
	public int getTo_C_BankAccount_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_To_C_BankAccount_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BPartner getTo_C_BPartner() throws RuntimeException
	{
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_ID)
			.getPO(getTo_C_BPartner_ID(), get_TrxName());
	}

	/** Set To Business Partner .
		@param To_C_BPartner_ID Identifies a Business Partner
	*/
	public void setTo_C_BPartner_ID (int To_C_BPartner_ID)
	{
		if (To_C_BPartner_ID < 1)
			set_Value (COLUMNNAME_To_C_BPartner_ID, null);
		else
			set_Value (COLUMNNAME_To_C_BPartner_ID, Integer.valueOf(To_C_BPartner_ID));
	}

	/** Get To Business Partner .
		@return Identifies a Business Partner
	  */
	public int getTo_C_BPartner_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_To_C_BPartner_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Charge getTo_C_Charge() throws RuntimeException
	{
		return (org.compiere.model.I_C_Charge)MTable.get(getCtx(), org.compiere.model.I_C_Charge.Table_ID)
			.getPO(getTo_C_Charge_ID(), get_TrxName());
	}

	/** Set To Charge.
		@param To_C_Charge_ID To Charge
	*/
	public void setTo_C_Charge_ID (int To_C_Charge_ID)
	{
		if (To_C_Charge_ID < 1)
			set_Value (COLUMNNAME_To_C_Charge_ID, null);
		else
			set_Value (COLUMNNAME_To_C_Charge_ID, Integer.valueOf(To_C_Charge_ID));
	}

	/** Get To Charge.
		@return To Charge	  */
	public int getTo_C_Charge_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_To_C_Charge_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Currency getTo_C_Currency() throws RuntimeException
	{
		return (org.compiere.model.I_C_Currency)MTable.get(getCtx(), org.compiere.model.I_C_Currency.Table_ID)
			.getPO(getTo_C_Currency_ID(), get_TrxName());
	}

	/** Set To Bank Currency.
		@param To_C_Currency_ID To Bank Currency
	*/
	public void setTo_C_Currency_ID (int To_C_Currency_ID)
	{
		if (To_C_Currency_ID < 1)
			set_Value (COLUMNNAME_To_C_Currency_ID, null);
		else
			set_Value (COLUMNNAME_To_C_Currency_ID, Integer.valueOf(To_C_Currency_ID));
	}

	/** Get To Bank Currency.
		@return To Bank Currency	  */
	public int getTo_C_Currency_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_To_C_Currency_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** To_TenderType AD_Reference_ID=214 */
	public static final int TO_TENDERTYPE_AD_Reference_ID=214;
	/** Direct Deposit = A */
	public static final String TO_TENDERTYPE_DirectDeposit = "A";
	/** Credit Card = C */
	public static final String TO_TENDERTYPE_CreditCard = "C";
	/** Direct Debit = D */
	public static final String TO_TENDERTYPE_DirectDebit = "D";
	/** Check = K */
	public static final String TO_TENDERTYPE_Check = "K";
	/** Account = T */
	public static final String TO_TENDERTYPE_Account = "T";
	/** Cash = X */
	public static final String TO_TENDERTYPE_Cash = "X";
	/** Set To Tender Type.
		@param To_TenderType To Tender Type
	*/
	public void setTo_TenderType (String To_TenderType)
	{

		set_Value (COLUMNNAME_To_TenderType, To_TenderType);
	}

	/** Get To Tender Type.
		@return To Tender Type	  */
	public String getTo_TenderType()
	{
		return (String)get_Value(COLUMNNAME_To_TenderType);
	}
}