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
import java.util.Properties;
import org.compiere.util.Env;

/** Generated Model for C_BankAccount_Processor
 *  @author iDempiere (generated) 
 *  @version Release 2.0 - $Id$ */
public class X_C_BankAccount_Processor extends PO implements I_C_BankAccount_Processor, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131031L;

    /** Standard Constructor */
    public X_C_BankAccount_Processor (Properties ctx, int C_BankAccount_Processor_ID, String trxName)
    {
      super (ctx, C_BankAccount_Processor_ID, trxName);
      /** if (C_BankAccount_Processor_ID == 0)
        {
			setAcceptAMEX (false);
// N
			setAcceptATM (false);
// N
			setAcceptCheck (false);
// N
			setAcceptCorporate (false);
// N
			setAcceptDiners (false);
// N
			setAcceptDirectDebit (false);
// N
			setAcceptDirectDeposit (false);
// N
			setAcceptDiscover (false);
// N
			setAcceptMC (false);
// N
			setAcceptVisa (false);
// N
			setC_BankAccount_ID (0);
			setC_PaymentProcessor_ID (0);
			setPassword (null);
			setRequireVV (false);
// N
			setUserID (null);
        } */
    }

    /** Load Constructor */
    public X_C_BankAccount_Processor (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_C_BankAccount_Processor[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Accept AMEX.
		@param AcceptAMEX 
		Accept American Express Card
	  */
	public void setAcceptAMEX (boolean AcceptAMEX)
	{
		set_Value (COLUMNNAME_AcceptAMEX, Boolean.valueOf(AcceptAMEX));
	}

	/** Get Accept AMEX.
		@return Accept American Express Card
	  */
	public boolean isAcceptAMEX () 
	{
		Object oo = get_Value(COLUMNNAME_AcceptAMEX);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept ATM.
		@param AcceptATM 
		Accept Bank ATM Card
	  */
	public void setAcceptATM (boolean AcceptATM)
	{
		set_Value (COLUMNNAME_AcceptATM, Boolean.valueOf(AcceptATM));
	}

	/** Get Accept ATM.
		@return Accept Bank ATM Card
	  */
	public boolean isAcceptATM () 
	{
		Object oo = get_Value(COLUMNNAME_AcceptATM);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Electronic Check.
		@param AcceptCheck 
		Accept ECheck (Electronic Checks)
	  */
	public void setAcceptCheck (boolean AcceptCheck)
	{
		set_Value (COLUMNNAME_AcceptCheck, Boolean.valueOf(AcceptCheck));
	}

	/** Get Accept Electronic Check.
		@return Accept ECheck (Electronic Checks)
	  */
	public boolean isAcceptCheck () 
	{
		Object oo = get_Value(COLUMNNAME_AcceptCheck);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Corporate.
		@param AcceptCorporate 
		Accept Corporate Purchase Cards
	  */
	public void setAcceptCorporate (boolean AcceptCorporate)
	{
		set_Value (COLUMNNAME_AcceptCorporate, Boolean.valueOf(AcceptCorporate));
	}

	/** Get Accept Corporate.
		@return Accept Corporate Purchase Cards
	  */
	public boolean isAcceptCorporate () 
	{
		Object oo = get_Value(COLUMNNAME_AcceptCorporate);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Diners.
		@param AcceptDiners 
		Accept Diner's Club
	  */
	public void setAcceptDiners (boolean AcceptDiners)
	{
		set_Value (COLUMNNAME_AcceptDiners, Boolean.valueOf(AcceptDiners));
	}

	/** Get Accept Diners.
		@return Accept Diner's Club
	  */
	public boolean isAcceptDiners () 
	{
		Object oo = get_Value(COLUMNNAME_AcceptDiners);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Direct Debit.
		@param AcceptDirectDebit 
		Accept Direct Debits (vendor initiated)
	  */
	public void setAcceptDirectDebit (boolean AcceptDirectDebit)
	{
		set_Value (COLUMNNAME_AcceptDirectDebit, Boolean.valueOf(AcceptDirectDebit));
	}

	/** Get Accept Direct Debit.
		@return Accept Direct Debits (vendor initiated)
	  */
	public boolean isAcceptDirectDebit () 
	{
		Object oo = get_Value(COLUMNNAME_AcceptDirectDebit);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Direct Deposit.
		@param AcceptDirectDeposit 
		Accept Direct Deposit (payee initiated)
	  */
	public void setAcceptDirectDeposit (boolean AcceptDirectDeposit)
	{
		set_Value (COLUMNNAME_AcceptDirectDeposit, Boolean.valueOf(AcceptDirectDeposit));
	}

	/** Get Accept Direct Deposit.
		@return Accept Direct Deposit (payee initiated)
	  */
	public boolean isAcceptDirectDeposit () 
	{
		Object oo = get_Value(COLUMNNAME_AcceptDirectDeposit);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Discover.
		@param AcceptDiscover 
		Accept Discover Card
	  */
	public void setAcceptDiscover (boolean AcceptDiscover)
	{
		set_Value (COLUMNNAME_AcceptDiscover, Boolean.valueOf(AcceptDiscover));
	}

	/** Get Accept Discover.
		@return Accept Discover Card
	  */
	public boolean isAcceptDiscover () 
	{
		Object oo = get_Value(COLUMNNAME_AcceptDiscover);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept MasterCard.
		@param AcceptMC 
		Accept Master Card
	  */
	public void setAcceptMC (boolean AcceptMC)
	{
		set_Value (COLUMNNAME_AcceptMC, Boolean.valueOf(AcceptMC));
	}

	/** Get Accept MasterCard.
		@return Accept Master Card
	  */
	public boolean isAcceptMC () 
	{
		Object oo = get_Value(COLUMNNAME_AcceptMC);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Visa.
		@param AcceptVisa 
		Accept Visa Cards
	  */
	public void setAcceptVisa (boolean AcceptVisa)
	{
		set_Value (COLUMNNAME_AcceptVisa, Boolean.valueOf(AcceptVisa));
	}

	/** Get Accept Visa.
		@return Accept Visa Cards
	  */
	public boolean isAcceptVisa () 
	{
		Object oo = get_Value(COLUMNNAME_AcceptVisa);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
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
			set_ValueNoCheck (COLUMNNAME_C_BankAccount_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_BankAccount_ID, Integer.valueOf(C_BankAccount_ID));
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

	/** Set C_BankAccount_Processor_UU.
		@param C_BankAccount_Processor_UU C_BankAccount_Processor_UU	  */
	public void setC_BankAccount_Processor_UU (String C_BankAccount_Processor_UU)
	{
		set_Value (COLUMNNAME_C_BankAccount_Processor_UU, C_BankAccount_Processor_UU);
	}

	/** Get C_BankAccount_Processor_UU.
		@return C_BankAccount_Processor_UU	  */
	public String getC_BankAccount_Processor_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_BankAccount_Processor_UU);
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
			set_ValueNoCheck (COLUMNNAME_C_PaymentProcessor_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_PaymentProcessor_ID, Integer.valueOf(C_PaymentProcessor_ID));
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

	/** Set Accept AMEX.
		@param IsPPAcceptAMEX Accept AMEX	  */
	public void setIsPPAcceptAMEX (boolean IsPPAcceptAMEX)
	{
		throw new IllegalArgumentException ("IsPPAcceptAMEX is virtual column");	}

	/** Get Accept AMEX.
		@return Accept AMEX	  */
	public boolean isPPAcceptAMEX () 
	{
		Object oo = get_Value(COLUMNNAME_IsPPAcceptAMEX);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept ATM.
		@param IsPPAcceptATM Accept ATM	  */
	public void setIsPPAcceptATM (boolean IsPPAcceptATM)
	{
		throw new IllegalArgumentException ("IsPPAcceptATM is virtual column");	}

	/** Get Accept ATM.
		@return Accept ATM	  */
	public boolean isPPAcceptATM () 
	{
		Object oo = get_Value(COLUMNNAME_IsPPAcceptATM);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Check.
		@param IsPPAcceptCheck Accept Check	  */
	public void setIsPPAcceptCheck (boolean IsPPAcceptCheck)
	{
		throw new IllegalArgumentException ("IsPPAcceptCheck is virtual column");	}

	/** Get Accept Check.
		@return Accept Check	  */
	public boolean isPPAcceptCheck () 
	{
		Object oo = get_Value(COLUMNNAME_IsPPAcceptCheck);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Corporate.
		@param IsPPAcceptCorporate Accept Corporate	  */
	public void setIsPPAcceptCorporate (boolean IsPPAcceptCorporate)
	{
		throw new IllegalArgumentException ("IsPPAcceptCorporate is virtual column");	}

	/** Get Accept Corporate.
		@return Accept Corporate	  */
	public boolean isPPAcceptCorporate () 
	{
		Object oo = get_Value(COLUMNNAME_IsPPAcceptCorporate);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Diners.
		@param IsPPAcceptDiners Accept Diners	  */
	public void setIsPPAcceptDiners (boolean IsPPAcceptDiners)
	{
		throw new IllegalArgumentException ("IsPPAcceptDiners is virtual column");	}

	/** Get Accept Diners.
		@return Accept Diners	  */
	public boolean isPPAcceptDiners () 
	{
		Object oo = get_Value(COLUMNNAME_IsPPAcceptDiners);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Direct Debit.
		@param IsPPAcceptDirectDebit Accept Direct Debit	  */
	public void setIsPPAcceptDirectDebit (boolean IsPPAcceptDirectDebit)
	{
		throw new IllegalArgumentException ("IsPPAcceptDirectDebit is virtual column");	}

	/** Get Accept Direct Debit.
		@return Accept Direct Debit	  */
	public boolean isPPAcceptDirectDebit () 
	{
		Object oo = get_Value(COLUMNNAME_IsPPAcceptDirectDebit);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Direct Deposit.
		@param IsPPAcceptDirectDeposit Accept Direct Deposit	  */
	public void setIsPPAcceptDirectDeposit (boolean IsPPAcceptDirectDeposit)
	{
		throw new IllegalArgumentException ("IsPPAcceptDirectDeposit is virtual column");	}

	/** Get Accept Direct Deposit.
		@return Accept Direct Deposit	  */
	public boolean isPPAcceptDirectDeposit () 
	{
		Object oo = get_Value(COLUMNNAME_IsPPAcceptDirectDeposit);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Discover.
		@param IsPPAcceptDiscover Accept Discover	  */
	public void setIsPPAcceptDiscover (boolean IsPPAcceptDiscover)
	{
		throw new IllegalArgumentException ("IsPPAcceptDiscover is virtual column");	}

	/** Get Accept Discover.
		@return Accept Discover	  */
	public boolean isPPAcceptDiscover () 
	{
		Object oo = get_Value(COLUMNNAME_IsPPAcceptDiscover);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept MasterCard.
		@param IsPPAcceptMC Accept MasterCard	  */
	public void setIsPPAcceptMC (boolean IsPPAcceptMC)
	{
		throw new IllegalArgumentException ("IsPPAcceptMC is virtual column");	}

	/** Get Accept MasterCard.
		@return Accept MasterCard	  */
	public boolean isPPAcceptMC () 
	{
		Object oo = get_Value(COLUMNNAME_IsPPAcceptMC);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Accept Visa.
		@param IsPPAcceptVisa Accept Visa	  */
	public void setIsPPAcceptVisa (boolean IsPPAcceptVisa)
	{
		throw new IllegalArgumentException ("IsPPAcceptVisa is virtual column");	}

	/** Get Accept Visa.
		@return Accept Visa	  */
	public boolean isPPAcceptVisa () 
	{
		Object oo = get_Value(COLUMNNAME_IsPPAcceptVisa);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Minimum Amt.
		@param MinimumAmt 
		Minimum Amount in Document Currency
	  */
	public void setMinimumAmt (BigDecimal MinimumAmt)
	{
		set_Value (COLUMNNAME_MinimumAmt, MinimumAmt);
	}

	/** Get Minimum Amt.
		@return Minimum Amount in Document Currency
	  */
	public BigDecimal getMinimumAmt () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_MinimumAmt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Partner ID.
		@param PartnerID 
		Partner ID or Account for the Payment Processor
	  */
	public void setPartnerID (String PartnerID)
	{
		set_Value (COLUMNNAME_PartnerID, PartnerID);
	}

	/** Get Partner ID.
		@return Partner ID or Account for the Payment Processor
	  */
	public String getPartnerID () 
	{
		return (String)get_Value(COLUMNNAME_PartnerID);
	}

	/** Set Password.
		@param Password 
		Password of any length (case sensitive)
	  */
	public void setPassword (String Password)
	{
		set_Value (COLUMNNAME_Password, Password);
	}

	/** Get Password.
		@return Password of any length (case sensitive)
	  */
	public String getPassword () 
	{
		return (String)get_Value(COLUMNNAME_Password);
	}

	/** Set Require CreditCard Verification Code.
		@param RequireVV 
		Require 3/4 digit Credit Verification Code
	  */
	public void setRequireVV (boolean RequireVV)
	{
		set_Value (COLUMNNAME_RequireVV, Boolean.valueOf(RequireVV));
	}

	/** Get Require CreditCard Verification Code.
		@return Require 3/4 digit Credit Verification Code
	  */
	public boolean isRequireVV () 
	{
		Object oo = get_Value(COLUMNNAME_RequireVV);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set User ID.
		@param UserID 
		User ID or account number
	  */
	public void setUserID (String UserID)
	{
		set_Value (COLUMNNAME_UserID, UserID);
	}

	/** Get User ID.
		@return User ID or account number
	  */
	public String getUserID () 
	{
		return (String)get_Value(COLUMNNAME_UserID);
	}

	/** Set Vendor ID.
		@param VendorID 
		Vendor ID for the Payment Processor
	  */
	public void setVendorID (String VendorID)
	{
		set_Value (COLUMNNAME_VendorID, VendorID);
	}

	/** Get Vendor ID.
		@return Vendor ID for the Payment Processor
	  */
	public String getVendorID () 
	{
		return (String)get_Value(COLUMNNAME_VendorID);
	}
}