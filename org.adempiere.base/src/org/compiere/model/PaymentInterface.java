/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.compiere.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * 
 * @author Elaine
 *
 */
public interface PaymentInterface {

	/** Set Account City.
	  * City or the Credit Card or Account Holder
	  */
	public void setA_City (String A_City);

	/** Get Account City.
	  * City or the Credit Card or Account Holder
	  */
	public String getA_City();

	/** Set Account Country.
	  * Country
	  */
	public void setA_Country (String A_Country);

	/** Get Account Country.
	  * Country
	  */
	public String getA_Country();

	/** Set Account EMail.
	  * Email Address
	  */
	public void setA_EMail (String A_EMail);

	/** Get Account EMail.
	  * Email Address
	  */
	public String getA_EMail();

	/** Set Driver License.
	  * Payment Identification - Driver License
	  */
	public void setA_Ident_DL (String A_Ident_DL);

	/** Get Driver License.
	  * Payment Identification - Driver License
	  */
	public String getA_Ident_DL();

	/** Set Social Security No.
	  * Payment Identification - Social Security No
	  */
	public void setA_Ident_SSN (String A_Ident_SSN);

	/** Get Social Security No.
	  * Payment Identification - Social Security No
	  */
	public String getA_Ident_SSN();

	/** Set Account Name.
	  * Name on Credit Card or Account holder
	  */
	public void setA_Name (String A_Name);

	/** Get Account Name.
	  * Name on Credit Card or Account holder
	  */
	public String getA_Name();

	/** Set Account State.
	  * State of the Credit Card or Account holder
	  */
	public void setA_State (String A_State);

	/** Get Account State.
	  * State of the Credit Card or Account holder
	  */
	public String getA_State();

	/** Set Account Street.
	  * Street address of the Credit Card or Account holder
	  */
	public void setA_Street (String A_Street);

	/** Get Account Street.
	  * Street address of the Credit Card or Account holder
	  */
	public String getA_Street();

	/** Set Account Zip/Postal.
	  * Zip Code of the Credit Card or Account Holder
	  */
	public void setA_Zip (String A_Zip);

	/** Get Account Zip/Postal.
	  * Zip Code of the Credit Card or Account Holder
	  */
	public String getA_Zip();

	/** Set Account No.
	  * Account Number
	  */
	public void setAccountNo (String AccountNo);

	/** Get Account No.
	  * Account Number
	  */
	public String getAccountNo();

	/** Set Bank Account.
	  * Account at the Bank
	  */
	public void setC_BankAccount_ID (int C_BankAccount_ID);

	/** Get Bank Account.
	  * Account at the Bank
	  */
	public int getC_BankAccount_ID();

	public org.compiere.model.I_C_BankAccount getC_BankAccount() throws RuntimeException;

	/** Set Partner Bank Account.
	  * Bank Account of the Business Partner
	  */
	public void setC_BP_BankAccount_ID (int C_BP_BankAccount_ID);

	/** Get Partner Bank Account.
	  * Bank Account of the Business Partner
	  */
	public int getC_BP_BankAccount_ID();

	public org.compiere.model.I_C_BP_BankAccount getC_BP_BankAccount() throws RuntimeException;

	/** Set Business Partner .
	  * Identifies a Business Partner
	  */
	public void setC_BPartner_ID (int C_BPartner_ID);

	/** Get Business Partner .
	  * Identifies a Business Partner
	  */
	public int getC_BPartner_ID();

	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException;

	/** Set Currency Type.
	  * Currency Conversion Rate Type
	  */
	public void setC_ConversionType_ID (int C_ConversionType_ID);

	/** Get Currency Type.
	  * Currency Conversion Rate Type
	  */
	public int getC_ConversionType_ID();

	public org.compiere.model.I_C_ConversionType getC_ConversionType() throws RuntimeException;

	/** Set Currency.
	  * The Currency for this record
	  */
	public void setC_Currency_ID (int C_Currency_ID);

	/** Get Currency.
	  * The Currency for this record
	  */
	public int getC_Currency_ID();

	public org.compiere.model.I_C_Currency getC_Currency() throws RuntimeException;

	/** Set Invoice.
	  * Invoice Identifier
	  */
	public void setC_Invoice_ID (int C_Invoice_ID);

	/** Get Invoice.
	  * Invoice Identifier
	  */
	public int getC_Invoice_ID();

	public org.compiere.model.I_C_Invoice getC_Invoice() throws RuntimeException;

	/** Set Order.
	  * Order
	  */
	public void setC_Order_ID (int C_Order_ID);

	/** Get Order.
	  * Order
	  */
	public int getC_Order_ID();

	public org.compiere.model.I_C_Order getC_Order() throws RuntimeException;


	/** Set Payment Processor.
	  * Payment processor for electronic payments
	  */
	public void setC_PaymentProcessor_ID (int C_PaymentProcessor_ID);

	/** Get Payment Processor.
	  * Payment processor for electronic payments
	  */
	public int getC_PaymentProcessor_ID();

	public org.compiere.model.I_C_PaymentProcessor getC_PaymentProcessor() throws RuntimeException;

	/** Set POS Tender Type	  */
	public void setC_POSTenderType_ID (int C_POSTenderType_ID);

	/** Get POS Tender Type	  */
	public int getC_POSTenderType_ID();

	public org.compiere.model.I_C_POSTenderType getC_POSTenderType() throws RuntimeException;

	/** Set Check No.
	  * Check Number
	  */
	public void setCheckNo (String CheckNo);

	/** Get Check No.
	  * Check Number
	  */
	public String getCheckNo();

	/** Set Exp. Month.
	  * Expiry Month
	  */
	public void setCreditCardExpMM (int CreditCardExpMM);

	/** Get Exp. Month.
	  * Expiry Month
	  */
	public int getCreditCardExpMM();

	/** Set Exp. Year.
	  * Expiry Year
	  */
	public void setCreditCardExpYY (int CreditCardExpYY);

	/** Get Exp. Year.
	  * Expiry Year
	  */
	public int getCreditCardExpYY();

	/** Set Number.
	  * Credit Card Number 
	  */
	public void setCreditCardNumber (String CreditCardNumber);

	/** Get Number.
	  * Credit Card Number 
	  */
	public String getCreditCardNumber();

	/** Set Credit Card.
	  * Credit Card (Visa, MC, AmEx)
	  */
	public void setCreditCardType (String CreditCardType);

	/** Get Credit Card.
	  * Credit Card (Visa, MC, AmEx)
	  */
	public String getCreditCardType();

	/** Set Verification Code.
	  * Credit Card Verification code on credit card
	  */
	public void setCreditCardVV (String CreditCardVV);

	/** Get Verification Code.
	  * Credit Card Verification code on credit card
	  */
	public String getCreditCardVV();

	/** Set Customer Address ID	  */
	public void setCustomerAddressID (String CustomerAddressID);

	/** Get Customer Address ID	  */
	public String getCustomerAddressID();

	/** Set Customer Payment Profile ID	  */
	public void setCustomerPaymentProfileID (String CustomerPaymentProfileID);

	/** Get Customer Payment Profile ID	  */
	public String getCustomerPaymentProfileID();

	/** Set Customer Profile ID	  */
	public void setCustomerProfileID (String CustomerProfileID);

	/** Get Customer Profile ID	  */
	public String getCustomerProfileID();

	/** Set Transaction Date.
	  * Transaction Date
	  */
	public void setDateTrx (Timestamp DateTrx);

	/** Get Transaction Date.
	  * Transaction Date
	  */
	public Timestamp getDateTrx();

	/** Set Description.
	  * Optional short description of the record
	  */
	public void setDescription (String Description);

	/** Get Description.
	  * Optional short description of the record
	  */
	public String getDescription();

	/** Set Approved.
	  * Indicates if this document requires approval
	  */
	public void setIsApproved (boolean IsApproved);

	/** Get Approved.
	  * Indicates if this document requires approval
	  */
	public boolean isApproved();

	/** Set Delayed Capture.
	  * Charge after Shipment
	  */
	public void setIsDelayedCapture (boolean IsDelayedCapture);

	/** Get Delayed Capture.
	  * Charge after Shipment
	  */
	public boolean isDelayedCapture();

	/** Set Online Access.
	  * Can be accessed online 
	  */
	public void setIsOnline (boolean IsOnline);

	/** Get Online Access.
	  * Can be accessed online 
	  */
	public boolean isOnline();

	/** Set Receipt.
	  * This is a sales transaction (receipt)
	  */
	public void setIsReceipt (boolean IsReceipt);

	/** Get Receipt.
	  * This is a sales transaction (receipt)
	  */
	public boolean isReceipt();

	/** Set Self-Service.
	  * This is a Self-Service entry or this entry can be changed via Self-Service
	  */
	public void setIsSelfService (boolean IsSelfService);

	/** Get Self-Service.
	  * This is a Self-Service entry or this entry can be changed via Self-Service
	  */
	public boolean isSelfService();

	/** Set Voided	  */
	public void setIsVoided (boolean IsVoided);

	/** Get Voided	  */
	public boolean isVoided();

	/** Set Micr.
	  * Combination of routing no, account and check no
	  */
	public void setMicr (String Micr);

	/** Get Micr.
	  * Combination of routing no, account and check no
	  */
	public String getMicr();

	/** Set Original Transaction ID.
	  * Original Transaction ID
	  */
	public void setOrig_TrxID (String Orig_TrxID);

	/** Get Original Transaction ID.
	  * Original Transaction ID
	  */
	public String getOrig_TrxID();

	/** Set Payment amount.
	  * Amount being paid
	  */
	public void setPayAmt (BigDecimal PayAmt);

	/** Get Payment amount.
	  * Amount being paid
	  */
	public BigDecimal getPayAmt();

	/** Set PO Number.
	  * Purchase Order Number
	  */
	public void setPONum (String PONum);

	/** Get PO Number.
	  * Purchase Order Number
	  */
	public String getPONum();

	/** Set Processed.
	  * The document has been processed
	  */
	public void setProcessed (boolean Processed);

	/** Get Processed.
	  * The document has been processed
	  */
	public boolean isProcessed();

	/** Set Authorization Code.
	  * Authorization Code returned
	  */
	public void setR_AuthCode (String R_AuthCode);

	/** Get Authorization Code.
	  * Authorization Code returned
	  */
	public String getR_AuthCode();

	/** Set Address verified.
	  * This address has been verified
	  */
	public void setR_AvsAddr (String R_AvsAddr);

	/** Get Address verified.
	  * This address has been verified
	  */
	public String getR_AvsAddr();

	/** Set Zip verified.
	  * The Zip Code has been verified
	  */
	public void setR_AvsZip (String R_AvsZip);

	/** Get Zip verified.
	  * The Zip Code has been verified
	  */
	public String getR_AvsZip();

	/** Set CVV Match.
	  * Credit Card Verification Code Match
	  */
	public void setR_CVV2Match (boolean R_CVV2Match);

	/** Get CVV Match.
	  * Credit Card Verification Code Match
	  */
	public boolean isR_CVV2Match();

	/** Set Info.
	  * Response info
	  */
	public void setR_Info (String R_Info);

	/** Get Info.
	  * Response info
	  */
	public String getR_Info();

	/** Set Reference.
	  * Payment reference
	  */
	public void setR_PnRef (String R_PnRef);

	/** Get Reference.
	  * Payment reference
	  */
	public String getR_PnRef();

	/** Set Response Message.
	  * Response message
	  */
	public void setR_RespMsg (String R_RespMsg);

	/** Get Response Message.
	  * Response message
	  */
	public String getR_RespMsg();

	/** Set Result.
	  * Result of transmission
	  */
	public void setR_Result (String R_Result);

	/** Get Result.
	  * Result of transmission
	  */
	public String getR_Result();

	/** Set Void Message	  */
	public void setR_VoidMsg (String R_VoidMsg);

	/** Get Void Message	  */
	public String getR_VoidMsg();

	/** Set Routing No.
	  * Bank Routing Number
	  */
	public void setRoutingNo (String RoutingNo);

	/** Get Routing No.
	  * Bank Routing Number
	  */
	public String getRoutingNo();

	/** Set Tax Amount.
	  * Tax Amount for a document
	  */
	public void setTaxAmt (BigDecimal TaxAmt);

	/** Get Tax Amount.
	  * Tax Amount for a document
	  */
	public BigDecimal getTaxAmt();

	/** Set Tender type.
	  * Method of Payment
	  */
	public void setTenderType (String TenderType);

	/** Get Tender type.
	  * Method of Payment
	  */
	public String getTenderType();

	/** Set Transaction Type.
	  * Type of credit card transaction
	  */
	public void setTrxType (String TrxType);

	/** Get Transaction Type.
	  * Type of credit card transaction
	  */
	public String getTrxType();

	/** Set Voice authorization code.
	  * Voice Authorization Code from credit card company
	  */
	public void setVoiceAuthCode (String VoiceAuthCode);

	/** Get Voice authorization code.
	  * Voice Authorization Code from credit card company
	  */
	public String getVoiceAuthCode();

	/**
	 * Get Persistent Object
	 * @return PO
	 */
	public PO getPO();
}
