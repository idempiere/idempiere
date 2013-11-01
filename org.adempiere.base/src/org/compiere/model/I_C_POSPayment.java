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

/** Generated Interface for C_POSPayment
 *  @author iDempiere (generated) 
 *  @version Release 2.0
 */
public interface I_C_POSPayment 
{

    /** TableName=C_POSPayment */
    public static final String Table_Name = "C_POSPayment";

    /** AD_Table_ID=200016 */
    public static final int Table_ID = 200016;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 3 - Client - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(3);

    /** Load Meta Data */

    /** Column name AccountNo */
    public static final String COLUMNNAME_AccountNo = "AccountNo";

	/** Set Account No.
	  * Account Number
	  */
	public void setAccountNo (String AccountNo);

	/** Get Account No.
	  * Account Number
	  */
	public String getAccountNo();

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

    /** Column name A_Name */
    public static final String COLUMNNAME_A_Name = "A_Name";

	/** Set Account Name.
	  * Name on Credit Card or Account holder
	  */
	public void setA_Name (String A_Name);

	/** Get Account Name.
	  * Name on Credit Card or Account holder
	  */
	public String getA_Name();

    /** Column name CheckNo */
    public static final String COLUMNNAME_CheckNo = "CheckNo";

	/** Set Check No.
	  * Check Number
	  */
	public void setCheckNo (String CheckNo);

	/** Get Check No.
	  * Check Number
	  */
	public String getCheckNo();

    /** Column name CheckStatus */
    public static final String COLUMNNAME_CheckStatus = "CheckStatus";

	/** Set Check Status	  */
	public void setCheckStatus (String CheckStatus);

	/** Get Check Status	  */
	public String getCheckStatus();

    /** Column name C_Order_ID */
    public static final String COLUMNNAME_C_Order_ID = "C_Order_ID";

	/** Set Order.
	  * Order
	  */
	public void setC_Order_ID (int C_Order_ID);

	/** Get Order.
	  * Order
	  */
	public int getC_Order_ID();

	public org.compiere.model.I_C_Order getC_Order() throws RuntimeException;

    /** Column name C_Payment_ID */
    public static final String COLUMNNAME_C_Payment_ID = "C_Payment_ID";

	/** Set Payment.
	  * Payment identifier
	  */
	public void setC_Payment_ID (int C_Payment_ID);

	/** Get Payment.
	  * Payment identifier
	  */
	public int getC_Payment_ID();

	public org.compiere.model.I_C_Payment getC_Payment() throws RuntimeException;

    /** Column name C_POSPayment_ID */
    public static final String COLUMNNAME_C_POSPayment_ID = "C_POSPayment_ID";

	/** Set POS Payment	  */
	public void setC_POSPayment_ID (int C_POSPayment_ID);

	/** Get POS Payment	  */
	public int getC_POSPayment_ID();

    /** Column name C_POSPayment_UU */
    public static final String COLUMNNAME_C_POSPayment_UU = "C_POSPayment_UU";

	/** Set C_POSPayment_UU	  */
	public void setC_POSPayment_UU (String C_POSPayment_UU);

	/** Get C_POSPayment_UU	  */
	public String getC_POSPayment_UU();

    /** Column name C_POSTenderType_ID */
    public static final String COLUMNNAME_C_POSTenderType_ID = "C_POSTenderType_ID";

	/** Set POS Tender Type	  */
	public void setC_POSTenderType_ID (int C_POSTenderType_ID);

	/** Get POS Tender Type	  */
	public int getC_POSTenderType_ID();

	public org.compiere.model.I_C_POSTenderType getC_POSTenderType() throws RuntimeException;

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

    /** Column name CreditCardNumber */
    public static final String COLUMNNAME_CreditCardNumber = "CreditCardNumber";

	/** Set Number.
	  * Credit Card Number 
	  */
	public void setCreditCardNumber (String CreditCardNumber);

	/** Get Number.
	  * Credit Card Number 
	  */
	public String getCreditCardNumber();

    /** Column name CreditCardType */
    public static final String COLUMNNAME_CreditCardType = "CreditCardType";

	/** Set Credit Card.
	  * Credit Card (Visa, MC, AmEx)
	  */
	public void setCreditCardType (String CreditCardType);

	/** Get Credit Card.
	  * Credit Card (Visa, MC, AmEx)
	  */
	public String getCreditCardType();

    /** Column name DatePromised */
    public static final String COLUMNNAME_DatePromised = "DatePromised";

	/** Set Date Promised.
	  * Date Order was promised
	  */
	public void setDatePromised (Timestamp DatePromised);

	/** Get Date Promised.
	  * Date Order was promised
	  */
	public Timestamp getDatePromised();

    /** Column name DepositGroup */
    public static final String COLUMNNAME_DepositGroup = "DepositGroup";

	/** Set Deposit Group	  */
	public void setDepositGroup (String DepositGroup);

	/** Get Deposit Group	  */
	public String getDepositGroup();

    /** Column name Help */
    public static final String COLUMNNAME_Help = "Help";

	/** Set Comment/Help.
	  * Comment or Hint
	  */
	public void setHelp (String Help);

	/** Get Comment/Help.
	  * Comment or Hint
	  */
	public String getHelp();

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

    /** Column name IsPostDated */
    public static final String COLUMNNAME_IsPostDated = "IsPostDated";

	/** Set Post Dated	  */
	public void setIsPostDated (boolean IsPostDated);

	/** Get Post Dated	  */
	public boolean isPostDated();

    /** Column name Micr */
    public static final String COLUMNNAME_Micr = "Micr";

	/** Set Micr.
	  * Combination of routing no, account and check no
	  */
	public void setMicr (String Micr);

	/** Get Micr.
	  * Combination of routing no, account and check no
	  */
	public String getMicr();

    /** Column name PayAmt */
    public static final String COLUMNNAME_PayAmt = "PayAmt";

	/** Set Payment amount.
	  * Amount being paid
	  */
	public void setPayAmt (BigDecimal PayAmt);

	/** Get Payment amount.
	  * Amount being paid
	  */
	public BigDecimal getPayAmt();

    /** Column name Processed */
    public static final String COLUMNNAME_Processed = "Processed";

	/** Set Processed.
	  * The document has been processed
	  */
	public void setProcessed (boolean Processed);

	/** Get Processed.
	  * The document has been processed
	  */
	public boolean isProcessed();

    /** Column name RoutingNo */
    public static final String COLUMNNAME_RoutingNo = "RoutingNo";

	/** Set Routing No.
	  * Bank Routing Number
	  */
	public void setRoutingNo (String RoutingNo);

	/** Get Routing No.
	  * Bank Routing Number
	  */
	public String getRoutingNo();

    /** Column name TenderType */
    public static final String COLUMNNAME_TenderType = "TenderType";

	/** Set Tender type.
	  * Method of Payment
	  */
	public void setTenderType (String TenderType);

	/** Get Tender type.
	  * Method of Payment
	  */
	public String getTenderType();

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

    /** Column name VoiceAuthCode */
    public static final String COLUMNNAME_VoiceAuthCode = "VoiceAuthCode";

	/** Set Voice authorization code.
	  * Voice Authorization Code from credit card company
	  */
	public void setVoiceAuthCode (String VoiceAuthCode);

	/** Get Voice authorization code.
	  * Voice Authorization Code from credit card company
	  */
	public String getVoiceAuthCode();
}
