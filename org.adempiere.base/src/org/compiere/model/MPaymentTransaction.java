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
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.util.IProcessUI;
import org.adempiere.util.PaymentUtil;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessCall;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

/**
 * 
 * @author Elaine
 *
 */
public class MPaymentTransaction extends X_C_PaymentTransaction implements ProcessCall, PaymentInterface {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3136835982476528825L;

	public MPaymentTransaction(Properties ctx, int C_PaymentTransaction_ID, String trxName) {
		super(ctx, C_PaymentTransaction_ID, trxName);
		
		//  New
		if (C_PaymentTransaction_ID == 0)
		{
			setTrxType(TRXTYPE_Sales);
			//
			setR_AvsAddr (R_AVSZIP_Unavailable);
			setR_AvsZip (R_AVSZIP_Unavailable);
			//
			setIsReceipt (true);
			setIsApproved (false);
			setIsOnline (false);
			setIsSelfService(false);
			setIsDelayedCapture (false);
			setProcessed(false);
			//
			setPayAmt(Env.ZERO);
			setTaxAmt(Env.ZERO);
			//
			setDateTrx (new Timestamp(System.currentTimeMillis()));
			setTenderType(TENDERTYPE_Check);
		}
	}
	
	public MPaymentTransaction(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	@Override
	protected boolean beforeSave(boolean newRecord) 
	{
		if (getCreditCardVV() != null)
		{
			String encrpytedCvv = PaymentUtil.encrpytCvv(getCreditCardVV());
			if (!encrpytedCvv.equals(getCreditCardVV()))
				setCreditCardVV(encrpytedCvv);
		}
		
		return true;
	}
	
	public void setAmount (int C_Currency_ID, BigDecimal payAmt)
	{
		if (C_Currency_ID == 0)
			C_Currency_ID = MClient.get(getCtx()).getC_Currency_ID();
		setC_Currency_ID(C_Currency_ID);
		setPayAmt(payAmt);
	}
	
	public boolean setCreditCard (String TrxType, String creditCardType, String creditCardNumber,
			String creditCardVV, int creditCardExpMM, int creditCardExpYY)
	{
		setTenderType(TENDERTYPE_CreditCard);
		setTrxType(TrxType);
		//
		setCreditCardType (creditCardType);
		setCreditCardNumber (creditCardNumber);
		setCreditCardVV (creditCardVV);
		setCreditCardExpMM (creditCardExpMM);
		setCreditCardExpYY (creditCardExpYY);
		//
		int check = MPaymentValidate.validateCreditCardNumber(creditCardNumber, creditCardType).length()
			+ MPaymentValidate.validateCreditCardExp(creditCardExpMM, creditCardExpYY).length();
		if (creditCardVV.length() > 0)
			check += MPaymentValidate.validateCreditCardVV(creditCardVV, creditCardType).length();
		return check == 0;
	}
	
	public boolean setCreditCard (String TrxType, String creditCardType, String creditCardNumber,
			String creditCardVV, String creditCardExp)
	{
		return setCreditCard(TrxType, creditCardType, creditCardNumber,
			creditCardVV, MPaymentValidate.getCreditCardExpMM(creditCardExp), 
			MPaymentValidate.getCreditCardExpYY(creditCardExp));
	}
	
	public boolean setPaymentProcessor ()
	{
		return setPaymentProcessor (getTenderType(), getCreditCardType(), getC_PaymentProcessor_ID());
	}
	
	/**	Temporary	Bank Account Processors		*/
	private MBankAccountProcessor[]	m_mBankAccountProcessors = null;
	/**	Temporary	Bank Account Processor		*/
	private MBankAccountProcessor	m_mBankAccountProcessor = null;
	
	public boolean setPaymentProcessor (String tender, String CCType, int C_PaymentProcessor_ID)
	{
		m_mBankAccountProcessor = null;
		//	Get Processor List
		if (m_mBankAccountProcessors == null || m_mBankAccountProcessors.length == 0)
			m_mBankAccountProcessors = MBankAccountProcessor.find(getCtx(), tender, CCType, getAD_Client_ID(),
				getC_Currency_ID(), getPayAmt(), get_TrxName());
		//	Relax Amount
		if (m_mBankAccountProcessors == null || m_mBankAccountProcessors.length == 0)
			m_mBankAccountProcessors = MBankAccountProcessor.find(getCtx(), tender, CCType, getAD_Client_ID(),
				getC_Currency_ID(), Env.ZERO, get_TrxName());
		if (m_mBankAccountProcessors == null || m_mBankAccountProcessors.length == 0)
			return false;

		//	Find the first right one
		for (int i = 0; i < m_mBankAccountProcessors.length; i++)
		{
			MBankAccountProcessor bankAccountProcessor = m_mBankAccountProcessors[i];
			if (bankAccountProcessor.accepts(tender, CCType))
			{
				if (C_PaymentProcessor_ID == 0 || bankAccountProcessor.getC_PaymentProcessor_ID() == C_PaymentProcessor_ID)
				{
					m_mBankAccountProcessor = m_mBankAccountProcessors[i];
					break;
				}
			}
		}
		if (m_mBankAccountProcessor != null)
		{
			setC_BankAccount_ID (m_mBankAccountProcessor.getC_BankAccount_ID());
			setC_PaymentProcessor_ID (m_mBankAccountProcessor.getC_PaymentProcessor_ID());
		}
		//
		return m_mBankAccountProcessor != null;
	}
	
	/**************************************************************************
	 *  Process Payment
	 *  @return true if approved
	 */
	public boolean processOnline()
	{
		if (log.isLoggable(Level.INFO)) log.info ("Amt=" + getPayAmt());
		//
		setIsOnline(true);
		setErrorMessage(null);
		//	prevent charging twice
		if(getTrxType().equals(TRXTYPE_Void) || getTrxType().equals(TRXTYPE_CreditPayment))
		{
			if (isVoided())
			{
				if (log.isLoggable(Level.INFO)) log.info("Already voided - " + getR_Result() + " - " + getR_RespMsg());
				setErrorMessage(Msg.getMsg(Env.getCtx(), "PaymentTransactionAlreadyVoided"));
				return true;
			}
		}
		else if(getTrxType().equals(TRXTYPE_DelayedCapture))
		{
			if (isDelayedCapture())
			{
				if (log.isLoggable(Level.INFO)) log.info("Already delayed capture - " + getR_Result() + " - " + getR_RespMsg());
				setErrorMessage(Msg.getMsg(Env.getCtx(), "PaymentTransactionAlreadyDelayedCapture"));
				return true;
			}
		}
		else
		{
			if (isApproved())
			{
				if (log.isLoggable(Level.INFO)) log.info("Already processed - " + getR_Result() + " - " + getR_RespMsg());
				setErrorMessage(Msg.getMsg(Env.getCtx(), "PaymentTransactionAlreadyProcessed"));
				return true;
			}
		}

		if (m_mBankAccountProcessor == null)
			setPaymentProcessor();
		if (m_mBankAccountProcessor == null)
		{
			if (getC_PaymentProcessor_ID() > 0)
			{
				MPaymentProcessor pp = new MPaymentProcessor(getCtx(), getC_PaymentProcessor_ID(), get_TrxName());
				log.log(Level.WARNING, "No Payment Processor Model " + pp.toString());
				setErrorMessage(Msg.getMsg(Env.getCtx(), "PaymentNoProcessorModel") + ": " + pp.toString());
			}
			else
			{
				log.log(Level.WARNING, "No Payment Processor Model");
				setErrorMessage(Msg.getMsg(Env.getCtx(), "PaymentNoProcessorModel"));
			}
			return false;
		}

		boolean approved = false;
		boolean processed = false;

		try
		{
			PaymentProcessor pp = PaymentProcessor.create(m_mBankAccountProcessor, this);
			if (pp == null)
				setErrorMessage(Msg.getMsg(Env.getCtx(), "PaymentNoProcessor"));
			else
			{
				// Validate before trying to process
//				String msg = pp.validate();
//				if (msg!=null && msg.trim().length()>0) {
//					setErrorMessage(Msg.getMsg(getCtx(), msg));
//				} else {
					// Process if validation succeeds
					approved = pp.processCC();
					setCreditCardNumber(PaymentUtil.encrpytCreditCard(getCreditCardNumber()));
					setCreditCardVV(PaymentUtil.encrpytCvv(getCreditCardVV()));
					setIsApproved(approved);
					
					if(getTrxType().equals(TRXTYPE_Void) || getTrxType().equals(TRXTYPE_CreditPayment))
						setIsVoided(approved);
					else if(getTrxType().equals(TRXTYPE_DelayedCapture))
						setIsDelayedCapture(approved);
					
					if (approved)
					{
						setErrorMessage(null);
						
						if (!getTrxType().equals(MPaymentTransaction.TRXTYPE_Authorization) 
								&& !getTrxType().equals(MPaymentTransaction.TRXTYPE_VoiceAuthorization)
								&& !getTrxType().equals(MPaymentTransaction.TRXTYPE_Void))
						{
							MPayment m_mPayment = createPayment(get_TrxName());
							m_mPayment.saveEx();
							setC_Payment_ID(m_mPayment.getC_Payment_ID());
							processed = m_mPayment.processIt(DocAction.ACTION_Complete);
							if (!processed)
								setErrorMessage(Msg.getMsg(Env.getCtx(), "PaymentNotProcessed"));
							else
								m_mPayment.saveEx();
						}
						else
							processed = true;
					}
					else
					{
						if(getTrxType().equals(TRXTYPE_Void) || getTrxType().equals(TRXTYPE_CreditPayment))
							setErrorMessage("From " +  getCreditCardName() + ": " + getR_VoidMsg());
						else
							setErrorMessage("From " +  getCreditCardName() + ": " + getR_RespMsg());
					}
//				}
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "processOnline", e);
			setErrorMessage(Msg.getMsg(Env.getCtx(), "PaymentNotProcessed") + ": " + e.getMessage());
		}
		
		setIsApproved(approved);
		setProcessed(processed);
		
		if(getTrxType().equals(TRXTYPE_Void) || getTrxType().equals(TRXTYPE_CreditPayment))
			setIsVoided(approved);
		else if(getTrxType().equals(TRXTYPE_DelayedCapture))
			setIsDelayedCapture(approved);
				
		MOnlineTrxHistory history = new MOnlineTrxHistory(getCtx(), 0, get_TrxName());
		history.setAD_Table_ID(MPaymentTransaction.Table_ID);
		history.setRecord_ID(getC_PaymentTransaction_ID());
		history.setIsError(!(approved && processed));
		history.setProcessed(approved && processed);
		
		StringBuilder msg = new StringBuilder();
		if (approved)
		{
			if(getTrxType().equals(TRXTYPE_Void) || getTrxType().equals(TRXTYPE_CreditPayment))
				msg.append(getR_VoidMsg() + "\n");
			else
			{
				msg.append("Result: " + getR_Result() + "\n");
				msg.append("Response Message: " + getR_RespMsg() + "\n");
				msg.append("Reference: " + getR_PnRef() + "\n");
				msg.append("Authorization Code: " + getR_AuthCode() + "\n");
			}
		}
		else
			msg.append("ERROR: " + getErrorMessage() + "\n");
		msg.append("Transaction Type: " + getTrxType());
		history.setTextMsg(msg.toString());
		
		history.saveEx();
		
		return approved && processed;
	}
	
	public boolean voidOnlineAuthorizationPaymentTransaction() 
	{
		if (getTenderType().equals(TENDERTYPE_CreditCard) && isOnline() && getTrxType().equals(TRXTYPE_Authorization) && !isVoided() && !isDelayedCapture())
		{
			boolean ok = false;
			try
			{
				MPaymentTransaction m_mPaymentTransaction = copyFrom(this, new Timestamp(System.currentTimeMillis()), TRXTYPE_Void, getR_PnRef(), get_TrxName());
				m_mPaymentTransaction.setIsApproved(false);
				m_mPaymentTransaction.setIsVoided(false);
				m_mPaymentTransaction.setIsDelayedCapture(false);
				ok = m_mPaymentTransaction.processOnline();
				m_mPaymentTransaction.setRef_PaymentTransaction_ID(getC_PaymentTransaction_ID());
				m_mPaymentTransaction.saveEx();
				
				if (ok)
				{
					setIsVoided(true);
					setR_VoidMsg(m_mPaymentTransaction.getR_VoidMsg());
					setRef_PaymentTransaction_ID(m_mPaymentTransaction.getC_PaymentTransaction_ID());
				}
				else
					setErrorMessage(m_mPaymentTransaction.getErrorMessage());
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "voidOnlineAuthorizationPaymentTransaction", e);
				setErrorMessage(Msg.getMsg(Env.getCtx(), "PaymentNotProcessed") + ": " + e.getMessage());
			}
			
			return ok;
		}
		
		return true;
	}
	
	public boolean delayCaptureOnlineAuthorizationPaymentTransaction(int C_Invoice_ID)
	{
		if (getTenderType().equals(TENDERTYPE_CreditCard) && isOnline() && getTrxType().equals(TRXTYPE_Authorization) && !isVoided() && !isDelayedCapture())
		{
			boolean ok = false;
			try
			{
				MPaymentTransaction m_mPaymentTransaction = copyFrom(this, new Timestamp(System.currentTimeMillis()), TRXTYPE_DelayedCapture, getR_PnRef(), get_TrxName());
				m_mPaymentTransaction.setIsApproved(false);
				m_mPaymentTransaction.setIsVoided(false);
				m_mPaymentTransaction.setIsDelayedCapture(false);
				
				if (C_Invoice_ID != 0)
					m_mPaymentTransaction.setC_Invoice_ID(C_Invoice_ID);
	
				ok = m_mPaymentTransaction.processOnline();
				m_mPaymentTransaction.setRef_PaymentTransaction_ID(getC_PaymentTransaction_ID());
				m_mPaymentTransaction.saveEx();
				
				if (ok)
				{
					if (C_Invoice_ID != 0)
						setC_Invoice_ID(C_Invoice_ID);
					setIsDelayedCapture(true);
					setRef_PaymentTransaction_ID(m_mPaymentTransaction.getC_PaymentTransaction_ID());
				}
				else
					setErrorMessage(m_mPaymentTransaction.getErrorMessage());
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "delayCaptureOnlineAuthorizationPaymentTransaction", e);
				setErrorMessage(Msg.getMsg(Env.getCtx(), "PaymentNotProcessed") + ": " + e.getMessage());
			}
			
			return ok;
		}
		
		return true;
	}
	
	public String getCreditCardName()
	{
		return getCreditCardName(getCreditCardType());
	}
	
	public String getCreditCardName(String CreditCardType)
	{
		if (CreditCardType == null)
			return "--";
		else if (CREDITCARDTYPE_MasterCard.equals(CreditCardType))
			return "MasterCard";
		else if (CREDITCARDTYPE_Visa.equals(CreditCardType))
			return "Visa";
		else if (CREDITCARDTYPE_Amex.equals(CreditCardType))
			return "Amex";
		else if (CREDITCARDTYPE_ATM.equals(CreditCardType))
			return "ATM";
		else if (CREDITCARDTYPE_Diners.equals(CreditCardType))
			return "Diners";
		else if (CREDITCARDTYPE_Discover.equals(CreditCardType))
			return "Discover";
		else if (CREDITCARDTYPE_PurchaseCard.equals(CreditCardType))
			return "PurchaseCard";
		return "?" + CreditCardType + "?";
	}
	
	/** Error Message						*/
	private String				m_errorMessage = null;
	
	public void setErrorMessage(String errorMessage)
	{
		m_errorMessage = errorMessage;
	}
	
	public String getErrorMessage()
	{
		return m_errorMessage;
	}
	
	public MPayment createPayment(String trxName)
	{
		MPayment payment = new MPayment(getCtx(), 0, trxName);
		payment.setA_City(getA_City());
		payment.setA_Country(getA_Country());
		payment.setA_EMail(getA_EMail());
		payment.setA_Ident_DL(getA_Ident_DL());
		payment.setA_Ident_SSN(getA_Ident_SSN());
		payment.setA_Name(getA_Name());
		payment.setA_State(getA_State());
		payment.setA_Street(getA_Street());
		payment.setA_Zip(getA_Zip());
		payment.setAccountNo(getAccountNo());
		payment.setAD_Org_ID(getAD_Org_ID());
		payment.setC_BankAccount_ID(getC_BankAccount_ID());
		payment.setC_BP_BankAccount_ID(getC_BP_BankAccount_ID());
		payment.setC_BPartner_ID(getC_BPartner_ID());
		payment.setC_ConversionType_ID(getC_ConversionType_ID());
		payment.setC_Currency_ID(getC_Currency_ID());
		payment.setC_Invoice_ID(getC_Invoice_ID());
		payment.setC_Order_ID(getC_Order_ID());
		payment.setC_PaymentProcessor_ID(getC_PaymentProcessor_ID());
		payment.setC_POSTenderType_ID(getC_POSTenderType_ID());
		payment.setCheckNo(getCheckNo());
		payment.setCreditCardExpMM(getCreditCardExpMM());
		payment.setCreditCardExpYY(getCreditCardExpYY());
		payment.setCreditCardNumber(getCreditCardNumber());
		payment.setCreditCardType(getCreditCardType());
		payment.setCreditCardVV(getCreditCardVV());
		payment.setCustomerAddressID(getCustomerAddressID());
		payment.setCustomerPaymentProfileID(getCustomerPaymentProfileID());
		payment.setCustomerProfileID(getCustomerProfileID());
		payment.setDateTrx(getDateTrx());
		payment.setDescription(getDescription());
		payment.setIsActive(isActive());
		payment.setIsApproved(isApproved());
		payment.setIsDelayedCapture(isDelayedCapture());
		payment.setIsOnline(isOnline());
		payment.setIsReceipt(isReceipt());
		payment.setIsSelfService(isSelfService());
		payment.setIsVoided(isVoided());
		payment.setMicr(getMicr());
		payment.setOrig_TrxID(getOrig_TrxID());
		payment.setPayAmt(getPayAmt());
		payment.setPONum(getPONum());
		payment.setProcessed(isProcessed());
		payment.setR_AuthCode(getR_AuthCode());
		payment.setR_AvsAddr(getR_AvsAddr());
		payment.setR_AvsZip(getR_AvsZip());
		payment.setR_CVV2Match(isR_CVV2Match());
		payment.setR_Info(getR_Info());
		payment.setR_PnRef(getR_PnRef());
		payment.setR_RespMsg(getR_RespMsg());
		payment.setR_Result(getR_Result());
		payment.setR_VoidMsg(getR_VoidMsg());
		payment.setRoutingNo(getRoutingNo());
		payment.setTaxAmt(getTaxAmt());
		payment.setTenderType(getTenderType());
		payment.setTrxType(getTrxType());
		payment.setVoiceAuthCode(getVoiceAuthCode());
		
		payment.setDateAcct(payment.getDateTrx());
		
		return payment;
	}

	/**
	 *  Process Online Payment.
	 *  implements ProcessCall after standard constructor
	 *  Called when pressing the Process_Online button in C_Payment
	 *
	 *  @param ctx Context
	 *  @param pi Process Info
	 *  @param trx transaction
	 *  @return true if the next process should be performed
	 */
	@Override
	public boolean startProcess(Properties ctx, ProcessInfo pi, Trx trx) {
		if (log.isLoggable(Level.INFO)) log.info("startProcess - " + pi.getRecord_ID());
		boolean retValue = false;
		//
		if (pi.getRecord_ID() != get_ID())
		{
			log.log(Level.SEVERE, "startProcess - Not same Payment - " + pi.getRecord_ID());
			return false;
		}
		//  Process it
		retValue = processOnline();
		saveEx();
		return retValue;
	}

	@SuppressWarnings("unused")
	private IProcessUI m_processUI;
	
	@Override
	public void setProcessUI(IProcessUI processUI) {
		m_processUI = processUI;
	}

	@Override
	public PO getPO() {
		return this;
	}
	
	public static MPaymentTransaction copyFrom(MPaymentTransaction from, Timestamp dateTrx, String trxType, String orig_TrxID, String trxName) {
		MPaymentTransaction to = new MPaymentTransaction(from.getCtx(), 0, trxName);
		to.set_TrxName(trxName);
		PO.copyValues(from, to, from.getAD_Client_ID(), from.getAD_Org_ID());
		to.set_ValueNoCheck(COLUMNNAME_C_PaymentTransaction_ID, I_ZERO);
		//
		to.setA_City(from.getA_City());
		to.setA_Country(from.getA_Country());
		to.setA_EMail(from.getA_EMail());
		to.setA_Ident_DL(from.getA_Ident_DL());
		to.setA_Ident_SSN(from.getA_Ident_SSN());
		to.setA_Name(from.getA_Name());
		to.setA_State(from.getA_State());
		to.setA_Street(from.getA_Street());
		to.setA_Zip(from.getA_Zip());
		to.setAccountNo(from.getAccountNo());
		to.setAD_Org_ID(from.getAD_Org_ID());
		to.setC_BankAccount_ID(from.getC_BankAccount_ID());
		to.setC_BP_BankAccount_ID(from.getC_BP_BankAccount_ID());
		to.setC_BPartner_ID(from.getC_BPartner_ID());
		to.setC_ConversionType_ID(from.getC_ConversionType_ID());
		to.setC_Currency_ID(from.getC_Currency_ID());
		to.setC_Invoice_ID(from.getC_Invoice_ID());
		to.setC_Order_ID(from.getC_Order_ID());
		to.setC_PaymentProcessor_ID(from.getC_PaymentProcessor_ID());
		to.setC_POSTenderType_ID(from.getC_POSTenderType_ID());
		to.setCheckNo(from.getCheckNo());
		to.setCreditCardExpMM(from.getCreditCardExpMM());
		to.setCreditCardExpYY(from.getCreditCardExpYY());
		to.setCreditCardNumber(from.getCreditCardNumber());
		to.setCreditCardType(from.getCreditCardType());
		to.setCreditCardVV(from.getCreditCardVV());
		to.setCustomerAddressID(from.getCustomerAddressID());
		to.setCustomerPaymentProfileID(from.getCustomerPaymentProfileID());
		to.setCustomerProfileID(from.getCustomerProfileID());
		to.setDateTrx(dateTrx);
		to.setDescription(from.getDescription());
		to.setIsActive(from.isActive());
		to.setIsApproved(false);
		to.setIsDelayedCapture(false);
		to.setIsOnline(from.isOnline());
		to.setIsReceipt(from.isReceipt());
		to.setIsSelfService(from.isSelfService());
		to.setIsVoided(false);
		to.setMicr(from.getMicr());
		to.setOrig_TrxID(orig_TrxID);
		to.setPayAmt(from.getPayAmt());
		to.setPONum(from.getPONum());
		to.setProcessed(false);
		to.setR_AuthCode(null);
		to.setR_AvsAddr(null);
		to.setR_AvsZip(null);
		to.setR_CVV2Match(false);
		to.setR_Info(null);
		to.setR_PnRef(null);
		to.setR_RespMsg(null);
		to.setR_Result(null);
		to.setR_VoidMsg(null);
		to.setRoutingNo(from.getRoutingNo());
		to.setTaxAmt(from.getTaxAmt());
		to.setTenderType(from.getTenderType());
		to.setTrxType(trxType);
		to.setVoiceAuthCode(from.getVoiceAuthCode());
		//
		if (!to.save(trxName))
			throw new IllegalStateException("Could not create Payment Transaction");

		return to;
	}
	
	public static int[] getAuthorizationPaymentTransactionIDs(int C_Order_ID, int C_Invoice_ID, String trxName)
	{
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("TenderType='").append(MPaymentTransaction.TENDERTYPE_CreditCard).append("' ");
		whereClause.append("AND TrxType='").append(MPaymentTransaction.TRXTYPE_Authorization).append("' ");
		if (C_Order_ID > 0 && C_Invoice_ID > 0)
			whereClause.append(" AND (C_Order_ID=").append(C_Order_ID).append(" OR C_Invoice_ID=").append(C_Invoice_ID).append(")");
		else if (C_Order_ID > 0)
			whereClause.append(" AND C_Order_ID=").append(C_Order_ID);
		else if (C_Invoice_ID > 0)
			whereClause.append(" AND C_Invoice_ID=").append(C_Invoice_ID);
		whereClause.append(" AND IsApproved='Y' AND IsVoided='N' AND IsDelayedCapture='N' ");
		whereClause.append("ORDER BY DateTrx DESC");

		return MPaymentTransaction.getAllIDs(Table_Name, whereClause.toString(), trxName);
	}
	
	public static int[] getAuthorizationPaymentTransactionIDs(int[] orderIDList, int C_Invoice_ID, String trxName)
	{
		StringBuilder sb = new StringBuilder();
		if (orderIDList != null)
		{
			for (int orderID : orderIDList)
				sb.append(orderID).append(",");
		}
		
		String orderIDs = sb.toString();
		if (orderIDs.length() > 0)
			orderIDs = orderIDs.substring(0, orderIDs.length() - 1);
		
		StringBuilder whereClause = new StringBuilder();
		whereClause.append("TenderType='").append(MPaymentTransaction.TENDERTYPE_CreditCard).append("' ");
		whereClause.append("AND TrxType='").append(MPaymentTransaction.TRXTYPE_Authorization).append("' ");
		if (orderIDs.length() > 0 && C_Invoice_ID > 0)
			whereClause.append(" AND (C_Order_ID IN (").append(orderIDs).append(") OR C_Invoice_ID=").append(C_Invoice_ID).append(")");
		else if (orderIDs.length() > 0)
			whereClause.append(" AND C_Order_ID IN ('").append(orderIDs).append(")");
		else if (C_Invoice_ID > 0)
			whereClause.append(" AND C_Invoice_ID=").append(C_Invoice_ID);
		whereClause.append(" AND IsApproved='Y' AND IsVoided='N' AND IsDelayedCapture='N' ");
		whereClause.append("ORDER BY DateTrx DESC");

		return MPaymentTransaction.getAllIDs(Table_Name, whereClause.toString(), trxName);
	}
	
	/**
	 * 	String Representation
	*	@return info
	*/
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MPaymentTransaction[");
		sb.append(get_ID()).append("-")
			.append(",Receipt=").append(isReceipt())
			.append(",PayAmt=").append(getPayAmt());
		return sb.toString ();
	}	//	toString
}
