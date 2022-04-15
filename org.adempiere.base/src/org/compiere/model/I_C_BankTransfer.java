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

/** Generated Interface for C_BankTransfer
 *  @author iDempiere (generated) 
 *  @version Release 10
 */
public interface I_C_BankTransfer 
{

    /** TableName=C_BankTransfer */
    public static final String Table_Name = "C_BankTransfer";

    /** AD_Table_ID=200246 */
    public static final int Table_ID = 200246;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 1 - Org 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(1);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Tenant.
	  * Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Org_ID */
    public static final String COLUMNNAME_AD_Org_ID = "AD_Org_ID";

	/** Set Organization.
	  * Organizational entity within tenant
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within tenant
	  */
	public int getAD_Org_ID();

    /** Column name C_BankTransfer_ID */
    public static final String COLUMNNAME_C_BankTransfer_ID = "C_BankTransfer_ID";

	/** Set Bank Transfer.
	  * Bank Transfer
	  */
	public void setC_BankTransfer_ID (int C_BankTransfer_ID);

	/** Get Bank Transfer.
	  * Bank Transfer
	  */
	public int getC_BankTransfer_ID();

    /** Column name C_BankTransfer_UU */
    public static final String COLUMNNAME_C_BankTransfer_UU = "C_BankTransfer_UU";

	/** Set C_BankTransfer_UU	  */
	public void setC_BankTransfer_UU (String C_BankTransfer_UU);

	/** Get C_BankTransfer_UU	  */
	public String getC_BankTransfer_UU();

    /** Column name C_ConversionType_ID */
    public static final String COLUMNNAME_C_ConversionType_ID = "C_ConversionType_ID";

	/** Set Currency Type.
	  * Currency Conversion Rate Type
	  */
	public void setC_ConversionType_ID (int C_ConversionType_ID);

	/** Get Currency Type.
	  * Currency Conversion Rate Type
	  */
	public int getC_ConversionType_ID();

	public org.compiere.model.I_C_ConversionType getC_ConversionType() throws RuntimeException;

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

    /** Column name DateAcct */
    public static final String COLUMNNAME_DateAcct = "DateAcct";

	/** Set Account Date.
	  * Accounting Date
	  */
	public void setDateAcct (Timestamp DateAcct);

	/** Get Account Date.
	  * Accounting Date
	  */
	public Timestamp getDateAcct();

    /** Column name Description */
    public static final String COLUMNNAME_Description = "Description";

	/** Set Description.
	  * Optional short description of the record
	  */
	public void setDescription (String Description);

	/** Get Description.
	  * Optional short description of the record
	  */
	public String getDescription();

    /** Column name DocAction */
    public static final String COLUMNNAME_DocAction = "DocAction";

	/** Set Document Action.
	  * The targeted status of the document
	  */
	public void setDocAction (String DocAction);

	/** Get Document Action.
	  * The targeted status of the document
	  */
	public String getDocAction();

    /** Column name DocStatus */
    public static final String COLUMNNAME_DocStatus = "DocStatus";

	/** Set Document Status.
	  * The current status of the document
	  */
	public void setDocStatus (String DocStatus);

	/** Get Document Status.
	  * The current status of the document
	  */
	public String getDocStatus();

    /** Column name DocumentNo */
    public static final String COLUMNNAME_DocumentNo = "DocumentNo";

	/** Set Document No.
	  * Document sequence number of the document
	  */
	public void setDocumentNo (String DocumentNo);

	/** Get Document No.
	  * Document sequence number of the document
	  */
	public String getDocumentNo();

    /** Column name From_AD_Org_ID */
    public static final String COLUMNNAME_From_AD_Org_ID = "From_AD_Org_ID";

	/** Set From Organization	  */
	public void setFrom_AD_Org_ID (int From_AD_Org_ID);

	/** Get From Organization	  */
	public int getFrom_AD_Org_ID();

    /** Column name From_Amt */
    public static final String COLUMNNAME_From_Amt = "From_Amt";

	/** Set From Amount	  */
	public void setFrom_Amt (BigDecimal From_Amt);

	/** Get From Amount	  */
	public BigDecimal getFrom_Amt();

    /** Column name From_C_BankAccount_ID */
    public static final String COLUMNNAME_From_C_BankAccount_ID = "From_C_BankAccount_ID";

	/** Set From Bank Account	  */
	public void setFrom_C_BankAccount_ID (int From_C_BankAccount_ID);

	/** Get From Bank Account	  */
	public int getFrom_C_BankAccount_ID();

	public org.compiere.model.I_C_BankAccount getFrom_C_BankAccount() throws RuntimeException;

    /** Column name From_C_BPartner_ID */
    public static final String COLUMNNAME_From_C_BPartner_ID = "From_C_BPartner_ID";

	/** Set From Business Partner .
	  * Identifies a Business Partner
	  */
	public void setFrom_C_BPartner_ID (int From_C_BPartner_ID);

	/** Get From Business Partner .
	  * Identifies a Business Partner
	  */
	public int getFrom_C_BPartner_ID();

	public org.compiere.model.I_C_BPartner getFrom_C_BPartner() throws RuntimeException;

    /** Column name From_C_Charge_ID */
    public static final String COLUMNNAME_From_C_Charge_ID = "From_C_Charge_ID";

	/** Set From Charge	  */
	public void setFrom_C_Charge_ID (int From_C_Charge_ID);

	/** Get From Charge	  */
	public int getFrom_C_Charge_ID();

	public org.compiere.model.I_C_Charge getFrom_C_Charge() throws RuntimeException;

    /** Column name From_C_Currency_ID */
    public static final String COLUMNNAME_From_C_Currency_ID = "From_C_Currency_ID";

	/** Set From Bank Currency	  */
	public void setFrom_C_Currency_ID (int From_C_Currency_ID);

	/** Get From Bank Currency	  */
	public int getFrom_C_Currency_ID();

	public org.compiere.model.I_C_Currency getFrom_C_Currency() throws RuntimeException;

    /** Column name From_TenderType */
    public static final String COLUMNNAME_From_TenderType = "From_TenderType";

	/** Set From Tender Type	  */
	public void setFrom_TenderType (String From_TenderType);

	/** Get From Tender Type	  */
	public String getFrom_TenderType();

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

    /** Column name IsOverrideCurrencyRate */
    public static final String COLUMNNAME_IsOverrideCurrencyRate = "IsOverrideCurrencyRate";

	/** Set Override Currency Conversion Rate.
	  * Override Currency Conversion Rate
	  */
	public void setIsOverrideCurrencyRate (boolean IsOverrideCurrencyRate);

	/** Get Override Currency Conversion Rate.
	  * Override Currency Conversion Rate
	  */
	public boolean isOverrideCurrencyRate();

    /** Column name PayDate */
    public static final String COLUMNNAME_PayDate = "PayDate";

	/** Set Payment date.
	  * Date Payment made
	  */
	public void setPayDate (Timestamp PayDate);

	/** Get Payment date.
	  * Date Payment made
	  */
	public Timestamp getPayDate();

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

    /** Column name Processing */
    public static final String COLUMNNAME_Processing = "Processing";

	/** Set Process Now	  */
	public void setProcessing (boolean Processing);

	/** Get Process Now	  */
	public boolean isProcessing();

    /** Column name Rate */
    public static final String COLUMNNAME_Rate = "Rate";

	/** Set Rate.
	  * Rate or Tax or Exchange
	  */
	public void setRate (BigDecimal Rate);

	/** Get Rate.
	  * Rate or Tax or Exchange
	  */
	public BigDecimal getRate();

    /** Column name To_AD_Org_ID */
    public static final String COLUMNNAME_To_AD_Org_ID = "To_AD_Org_ID";

	/** Set To Organization	  */
	public void setTo_AD_Org_ID (int To_AD_Org_ID);

	/** Get To Organization	  */
	public int getTo_AD_Org_ID();

    /** Column name To_Amt */
    public static final String COLUMNNAME_To_Amt = "To_Amt";

	/** Set To Amount	  */
	public void setTo_Amt (BigDecimal To_Amt);

	/** Get To Amount	  */
	public BigDecimal getTo_Amt();

    /** Column name To_C_BankAccount_ID */
    public static final String COLUMNNAME_To_C_BankAccount_ID = "To_C_BankAccount_ID";

	/** Set To Bank Account	  */
	public void setTo_C_BankAccount_ID (int To_C_BankAccount_ID);

	/** Get To Bank Account	  */
	public int getTo_C_BankAccount_ID();

	public org.compiere.model.I_C_BankAccount getTo_C_BankAccount() throws RuntimeException;

    /** Column name To_C_BPartner_ID */
    public static final String COLUMNNAME_To_C_BPartner_ID = "To_C_BPartner_ID";

	/** Set To Business Partner .
	  * Identifies a Business Partner
	  */
	public void setTo_C_BPartner_ID (int To_C_BPartner_ID);

	/** Get To Business Partner .
	  * Identifies a Business Partner
	  */
	public int getTo_C_BPartner_ID();

	public org.compiere.model.I_C_BPartner getTo_C_BPartner() throws RuntimeException;

    /** Column name To_C_Charge_ID */
    public static final String COLUMNNAME_To_C_Charge_ID = "To_C_Charge_ID";

	/** Set To Charge	  */
	public void setTo_C_Charge_ID (int To_C_Charge_ID);

	/** Get To Charge	  */
	public int getTo_C_Charge_ID();

	public org.compiere.model.I_C_Charge getTo_C_Charge() throws RuntimeException;

    /** Column name To_C_Currency_ID */
    public static final String COLUMNNAME_To_C_Currency_ID = "To_C_Currency_ID";

	/** Set To Bank Currency	  */
	public void setTo_C_Currency_ID (int To_C_Currency_ID);

	/** Get To Bank Currency	  */
	public int getTo_C_Currency_ID();

	public org.compiere.model.I_C_Currency getTo_C_Currency() throws RuntimeException;

    /** Column name To_TenderType */
    public static final String COLUMNNAME_To_TenderType = "To_TenderType";

	/** Set To Tender Type	  */
	public void setTo_TenderType (String To_TenderType);

	/** Get To Tender Type	  */
	public String getTo_TenderType();

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
}
