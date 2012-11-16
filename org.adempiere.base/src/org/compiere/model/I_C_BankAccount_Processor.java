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
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import org.compiere.util.KeyNamePair;

/** Generated Interface for C_BankAccount_Processor
 *  @author iDempiere (generated) 
 *  @version Release 1.0a
 */
public interface I_C_BankAccount_Processor 
{

    /** TableName=C_BankAccount_Processor */
    public static final String Table_Name = "C_BankAccount_Processor";

    /** AD_Table_ID=200030 */
    public static final int Table_ID = 200030;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 3 - Client - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(3);

    /** Load Meta Data */

    /** Column name AcceptAMEX */
    public static final String COLUMNNAME_AcceptAMEX = "AcceptAMEX";

	/** Set Accept AMEX.
	  * Accept American Express Card
	  */
	public void setAcceptAMEX (boolean AcceptAMEX);

	/** Get Accept AMEX.
	  * Accept American Express Card
	  */
	public boolean isAcceptAMEX();

    /** Column name AcceptATM */
    public static final String COLUMNNAME_AcceptATM = "AcceptATM";

	/** Set Accept ATM.
	  * Accept Bank ATM Card
	  */
	public void setAcceptATM (boolean AcceptATM);

	/** Get Accept ATM.
	  * Accept Bank ATM Card
	  */
	public boolean isAcceptATM();

    /** Column name AcceptCheck */
    public static final String COLUMNNAME_AcceptCheck = "AcceptCheck";

	/** Set Accept Electronic Check.
	  * Accept ECheck (Electronic Checks)
	  */
	public void setAcceptCheck (boolean AcceptCheck);

	/** Get Accept Electronic Check.
	  * Accept ECheck (Electronic Checks)
	  */
	public boolean isAcceptCheck();

    /** Column name AcceptCorporate */
    public static final String COLUMNNAME_AcceptCorporate = "AcceptCorporate";

	/** Set Accept Corporate.
	  * Accept Corporate Purchase Cards
	  */
	public void setAcceptCorporate (boolean AcceptCorporate);

	/** Get Accept Corporate.
	  * Accept Corporate Purchase Cards
	  */
	public boolean isAcceptCorporate();

    /** Column name AcceptDiners */
    public static final String COLUMNNAME_AcceptDiners = "AcceptDiners";

	/** Set Accept Diners.
	  * Accept Diner's Club
	  */
	public void setAcceptDiners (boolean AcceptDiners);

	/** Get Accept Diners.
	  * Accept Diner's Club
	  */
	public boolean isAcceptDiners();

    /** Column name AcceptDirectDebit */
    public static final String COLUMNNAME_AcceptDirectDebit = "AcceptDirectDebit";

	/** Set Accept Direct Debit.
	  * Accept Direct Debits (vendor initiated)
	  */
	public void setAcceptDirectDebit (boolean AcceptDirectDebit);

	/** Get Accept Direct Debit.
	  * Accept Direct Debits (vendor initiated)
	  */
	public boolean isAcceptDirectDebit();

    /** Column name AcceptDirectDeposit */
    public static final String COLUMNNAME_AcceptDirectDeposit = "AcceptDirectDeposit";

	/** Set Accept Direct Deposit.
	  * Accept Direct Deposit (payee initiated)
	  */
	public void setAcceptDirectDeposit (boolean AcceptDirectDeposit);

	/** Get Accept Direct Deposit.
	  * Accept Direct Deposit (payee initiated)
	  */
	public boolean isAcceptDirectDeposit();

    /** Column name AcceptDiscover */
    public static final String COLUMNNAME_AcceptDiscover = "AcceptDiscover";

	/** Set Accept Discover.
	  * Accept Discover Card
	  */
	public void setAcceptDiscover (boolean AcceptDiscover);

	/** Get Accept Discover.
	  * Accept Discover Card
	  */
	public boolean isAcceptDiscover();

    /** Column name AcceptMC */
    public static final String COLUMNNAME_AcceptMC = "AcceptMC";

	/** Set Accept MasterCard.
	  * Accept Master Card
	  */
	public void setAcceptMC (boolean AcceptMC);

	/** Get Accept MasterCard.
	  * Accept Master Card
	  */
	public boolean isAcceptMC();

    /** Column name AcceptVisa */
    public static final String COLUMNNAME_AcceptVisa = "AcceptVisa";

	/** Set Accept Visa.
	  * Accept Visa Cards
	  */
	public void setAcceptVisa (boolean AcceptVisa);

	/** Get Accept Visa.
	  * Accept Visa Cards
	  */
	public boolean isAcceptVisa();

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Client.
	  * Client/Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Org_ID */
    public static final String COLUMNNAME_AD_Org_ID = "AD_Org_ID";

	/** Set Organization.
	  * Organizational entity within client
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within client
	  */
	public int getAD_Org_ID();

    /** Column name C_BankAccount_ID */
    public static final String COLUMNNAME_C_BankAccount_ID = "C_BankAccount_ID";

	/** Set Bank Account.
	  * Account at the Bank
	  */
	public void setC_BankAccount_ID (int C_BankAccount_ID);

	/** Get Bank Account.
	  * Account at the Bank
	  */
	public int getC_BankAccount_ID();

	public org.compiere.model.I_C_BankAccount getC_BankAccount() throws RuntimeException;

    /** Column name C_BankAccount_Processor_UU */
    public static final String COLUMNNAME_C_BankAccount_Processor_UU = "C_BankAccount_Processor_UU";

	/** Set C_BankAccount_Processor_UU	  */
	public void setC_BankAccount_Processor_UU (String C_BankAccount_Processor_UU);

	/** Get C_BankAccount_Processor_UU	  */
	public String getC_BankAccount_Processor_UU();

    /** Column name C_Currency_ID */
    public static final String COLUMNNAME_C_Currency_ID = "C_Currency_ID";

	/** Set Currency.
	  * The Currency for this record
	  */
	public void setC_Currency_ID (int C_Currency_ID);

	/** Get Currency.
	  * The Currency for this record
	  */
	public int getC_Currency_ID();

	public org.compiere.model.I_C_Currency getC_Currency() throws RuntimeException;

    /** Column name C_PaymentProcessor_ID */
    public static final String COLUMNNAME_C_PaymentProcessor_ID = "C_PaymentProcessor_ID";

	/** Set Payment Processor.
	  * Payment processor for electronic payments
	  */
	public void setC_PaymentProcessor_ID (int C_PaymentProcessor_ID);

	/** Get Payment Processor.
	  * Payment processor for electronic payments
	  */
	public int getC_PaymentProcessor_ID();

	public org.compiere.model.I_C_PaymentProcessor getC_PaymentProcessor() throws RuntimeException;

    /** Column name Created */
    public static final String COLUMNNAME_Created = "Created";

	/** Get Created.
	  * Date this record was created
	  */
	public Timestamp getCreated();

    /** Column name CreatedBy */
    public static final String COLUMNNAME_CreatedBy = "CreatedBy";

	/** Get Created By.
	  * User who created this records
	  */
	public int getCreatedBy();

    /** Column name IsActive */
    public static final String COLUMNNAME_IsActive = "IsActive";

	/** Set Active.
	  * The record is active in the system
	  */
	public void setIsActive (boolean IsActive);

	/** Get Active.
	  * The record is active in the system
	  */
	public boolean isActive();

    /** Column name IsPPAcceptAMEX */
    public static final String COLUMNNAME_IsPPAcceptAMEX = "IsPPAcceptAMEX";

	/** Set Accept AMEX	  */
	public void setIsPPAcceptAMEX (boolean IsPPAcceptAMEX);

	/** Get Accept AMEX	  */
	public boolean isPPAcceptAMEX();

    /** Column name IsPPAcceptATM */
    public static final String COLUMNNAME_IsPPAcceptATM = "IsPPAcceptATM";

	/** Set Accept ATM	  */
	public void setIsPPAcceptATM (boolean IsPPAcceptATM);

	/** Get Accept ATM	  */
	public boolean isPPAcceptATM();

    /** Column name IsPPAcceptCheck */
    public static final String COLUMNNAME_IsPPAcceptCheck = "IsPPAcceptCheck";

	/** Set Accept Check	  */
	public void setIsPPAcceptCheck (boolean IsPPAcceptCheck);

	/** Get Accept Check	  */
	public boolean isPPAcceptCheck();

    /** Column name IsPPAcceptCorporate */
    public static final String COLUMNNAME_IsPPAcceptCorporate = "IsPPAcceptCorporate";

	/** Set Accept Corporate	  */
	public void setIsPPAcceptCorporate (boolean IsPPAcceptCorporate);

	/** Get Accept Corporate	  */
	public boolean isPPAcceptCorporate();

    /** Column name IsPPAcceptDiners */
    public static final String COLUMNNAME_IsPPAcceptDiners = "IsPPAcceptDiners";

	/** Set Accept Diners	  */
	public void setIsPPAcceptDiners (boolean IsPPAcceptDiners);

	/** Get Accept Diners	  */
	public boolean isPPAcceptDiners();

    /** Column name IsPPAcceptDirectDebit */
    public static final String COLUMNNAME_IsPPAcceptDirectDebit = "IsPPAcceptDirectDebit";

	/** Set Accept Direct Debit	  */
	public void setIsPPAcceptDirectDebit (boolean IsPPAcceptDirectDebit);

	/** Get Accept Direct Debit	  */
	public boolean isPPAcceptDirectDebit();

    /** Column name IsPPAcceptDirectDeposit */
    public static final String COLUMNNAME_IsPPAcceptDirectDeposit = "IsPPAcceptDirectDeposit";

	/** Set Accept Direct Deposit	  */
	public void setIsPPAcceptDirectDeposit (boolean IsPPAcceptDirectDeposit);

	/** Get Accept Direct Deposit	  */
	public boolean isPPAcceptDirectDeposit();

    /** Column name IsPPAcceptDiscover */
    public static final String COLUMNNAME_IsPPAcceptDiscover = "IsPPAcceptDiscover";

	/** Set Accept Discover	  */
	public void setIsPPAcceptDiscover (boolean IsPPAcceptDiscover);

	/** Get Accept Discover	  */
	public boolean isPPAcceptDiscover();

    /** Column name IsPPAcceptMC */
    public static final String COLUMNNAME_IsPPAcceptMC = "IsPPAcceptMC";

	/** Set Accept MasterCard	  */
	public void setIsPPAcceptMC (boolean IsPPAcceptMC);

	/** Get Accept MasterCard	  */
	public boolean isPPAcceptMC();

    /** Column name IsPPAcceptVisa */
    public static final String COLUMNNAME_IsPPAcceptVisa = "IsPPAcceptVisa";

	/** Set Accept Visa	  */
	public void setIsPPAcceptVisa (boolean IsPPAcceptVisa);

	/** Get Accept Visa	  */
	public boolean isPPAcceptVisa();

    /** Column name MinimumAmt */
    public static final String COLUMNNAME_MinimumAmt = "MinimumAmt";

	/** Set Minimum Amt.
	  * Minimum Amount in Document Currency
	  */
	public void setMinimumAmt (BigDecimal MinimumAmt);

	/** Get Minimum Amt.
	  * Minimum Amount in Document Currency
	  */
	public BigDecimal getMinimumAmt();

    /** Column name PartnerID */
    public static final String COLUMNNAME_PartnerID = "PartnerID";

	/** Set Partner ID.
	  * Partner ID or Account for the Payment Processor
	  */
	public void setPartnerID (String PartnerID);

	/** Get Partner ID.
	  * Partner ID or Account for the Payment Processor
	  */
	public String getPartnerID();

    /** Column name Password */
    public static final String COLUMNNAME_Password = "Password";

	/** Set Password.
	  * Password of any length (case sensitive)
	  */
	public void setPassword (String Password);

	/** Get Password.
	  * Password of any length (case sensitive)
	  */
	public String getPassword();

    /** Column name RequireVV */
    public static final String COLUMNNAME_RequireVV = "RequireVV";

	/** Set Require CreditCard Verification Code.
	  * Require 3/4 digit Credit Verification Code
	  */
	public void setRequireVV (boolean RequireVV);

	/** Get Require CreditCard Verification Code.
	  * Require 3/4 digit Credit Verification Code
	  */
	public boolean isRequireVV();

    /** Column name Updated */
    public static final String COLUMNNAME_Updated = "Updated";

	/** Get Updated.
	  * Date this record was updated
	  */
	public Timestamp getUpdated();

    /** Column name UpdatedBy */
    public static final String COLUMNNAME_UpdatedBy = "UpdatedBy";

	/** Get Updated By.
	  * User who updated this records
	  */
	public int getUpdatedBy();

    /** Column name UserID */
    public static final String COLUMNNAME_UserID = "UserID";

	/** Set User ID.
	  * User ID or account number
	  */
	public void setUserID (String UserID);

	/** Get User ID.
	  * User ID or account number
	  */
	public String getUserID();

    /** Column name VendorID */
    public static final String COLUMNNAME_VendorID = "VendorID";

	/** Set Vendor ID.
	  * Vendor ID for the Payment Processor
	  */
	public void setVendorID (String VendorID);

	/** Get Vendor ID.
	  * Vendor ID for the Payment Processor
	  */
	public String getVendorID();
}
