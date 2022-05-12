/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.compiere.model;

import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.process.DocAction;
import org.compiere.process.DocumentEngine;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * 
 * @author hengsin
 *
 */
public class MBankTransfer extends X_C_BankTransfer implements DocAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6091468617167291836L;

	/**
	 * 
	 * @param ctx
	 * @param C_BankTransfer_ID
	 * @param trxName
	 */
	public MBankTransfer(Properties ctx, int C_BankTransfer_ID, String trxName) {
		super(ctx, C_BankTransfer_ID, trxName);
		if (C_BankTransfer_ID == 0)
        {
			setDocAction(DOCACTION_Complete);
			setDocStatus(DOCSTATUS_Drafted);
			setPayDate(new Timestamp(System.currentTimeMillis()));
			setProcessed(false);
        }
	}
	
	/**
	 * 
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MBankTransfer(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (!super.beforeSave(newRecord))
			return false;
		
		if (getTo_C_BankAccount_ID() == getFrom_C_BankAccount_ID()) {
			log.saveError("From Bank Account and To Bank Account must be different", toString());
			return false;
		}
		
		if (getFrom_C_BankAccount().getAD_Org_ID() != 0 && getFrom_C_BankAccount().getAD_Org_ID() != getFrom_AD_Org_ID()) {
			log.saveError("From Organization does not matches the organization of the From Bank Account", toString());
			return false;
		}
		
		if (getFrom_C_Currency_ID() == 0) {
			int From_C_Currency_ID = getFrom_C_BankAccount().getC_Currency_ID();
			if (From_C_Currency_ID > 0)
				setFrom_C_Currency_ID(From_C_Currency_ID);
		}
		
		if (getTo_AD_Org_ID() == 0) {
			int To_AD_Org_ID = getTo_C_BankAccount().getAD_Org_ID();
			if (To_AD_Org_ID > 0)
				setTo_AD_Org_ID(To_AD_Org_ID);
		}
		
		if (getTo_C_Currency_ID() == 0) {
			int To_C_Currency_ID = getTo_C_BankAccount().getC_Currency_ID();
			if (To_C_Currency_ID > 0)
				setTo_C_Currency_ID(To_C_Currency_ID);
		}
		
		if (getFrom_C_BPartner_ID() == 0) {
			String sql = "SELECT bp.C_BPartner_ID FROM C_BPartner bp "
					+ "WHERE bp.AD_OrgBP_ID IN (SELECT ba.AD_Org_ID FROM C_BankAccount ba WHERE ba.C_BankAccount_ID = ?)) "
					+ "AND bp.IsActive = 'Y'";
			int C_BPartner_ID = DB.getSQLValue(get_TrxName(), sql, getFrom_C_BankAccount_ID());
			if (C_BPartner_ID > 0)
				setFrom_C_BPartner_ID(C_BPartner_ID);
		}
		
		if (getTo_C_BPartner_ID() == 0) {
			String sql = "SELECT bp.C_BPartner_ID FROM C_BPartner bp "
					+ "WHERE bp.AD_OrgBP_ID IN (SELECT ba.AD_Org_ID FROM C_BankAccount ba WHERE ba.C_BankAccount_ID = ?)) "
					+ "AND bp.IsActive = 'Y'";
			int C_BPartner_ID = DB.getSQLValue(get_TrxName(), sql, getTo_C_BankAccount_ID());
			if (C_BPartner_ID > 0) {
				setTo_C_BPartner_ID(C_BPartner_ID);
			} else if (getFrom_AD_Org_ID() == getTo_AD_Org_ID() && getFrom_C_BPartner_ID() > 0) {
				setTo_C_BPartner_ID(getFrom_C_BPartner_ID());
			}
		}
		
		if (getRate().doubleValue() == 0) {
			if (getFrom_Amt().compareTo(BigDecimal.ZERO) != 0) {
				BigDecimal rate = getTo_Amt().divide(getFrom_Amt(), 12, RoundingMode.HALF_UP);
				setRate(rate);
			}			
		} else {
			BigDecimal toAmt = getRate().multiply(getFrom_Amt());
			Integer To_C_Currency_ID = getTo_C_Currency_ID();
			if (To_C_Currency_ID != null && To_C_Currency_ID > 0) {
				MCurrency cur = MCurrency.get(p_ctx, To_C_Currency_ID);
				if (cur != null)
					toAmt = toAmt.setScale(cur.getStdPrecision(), RoundingMode.HALF_UP);
			}
			setTo_Amt(toAmt);
		}
		
		if (getTo_C_Charge_ID() == 0 && getFrom_C_Charge_ID() > 0) {
			setTo_C_Charge_ID(getFrom_C_Charge_ID());
		}
		
		return true;
	}
	
	/**	Process Message 			*/
	private String		m_processMsg = null;
	/**	Just Prepared Flag			*/
	private boolean		m_justPrepared = false;

	@Override
	public boolean processIt(String action) throws Exception {
		m_processMsg = null;
		DocumentEngine engine = new DocumentEngine(this, getDocStatus());
		return engine.processIt(action, getDocAction());
	}

	@Override
	public boolean unlockIt() {
		if (log.isLoggable(Level.INFO)) log.info("unlockIt - " + toString());
		setProcessing(false);
		return true;
	}

	@Override
	public boolean invalidateIt() {
		if (log.isLoggable(Level.INFO)) log.info("invalidateIt - " + toString());
		return true;
	}

	@Override
	public String prepareIt() {
		if (log.isLoggable(Level.INFO)) log.info(toString());
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_AFTER_PREPARE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;

		m_justPrepared = true;
		return DocAction.STATUS_InProgress;
	}

	@Override
	public boolean approveIt() {
		if (log.isLoggable(Level.INFO)) log.info("approveIt - " + toString());
		return true;
	}

	@Override
	public boolean rejectIt() {
		if (log.isLoggable(Level.INFO)) log.info("rejectIt - " + toString());
		return true;
	}

	@Override
	public String completeIt() {
		//	Re-Check
		if (!m_justPrepared)
		{
			String status = prepareIt();
			m_justPrepared = false;
			if (!DocAction.STATUS_InProgress.equals(status))
				return status;
		}

		m_processMsg = ModelValidationEngine.get().fireDocValidate(this, ModelValidator.TIMING_BEFORE_COMPLETE);
		if (m_processMsg != null)
			return DocAction.STATUS_Invalid;
		
		MClientInfo info = MClientInfo.get(getCtx(), getAD_Client_ID(), get_TrxName()); 
		MAcctSchema as = MAcctSchema.get (getCtx(), info.getC_AcctSchema1_ID(), get_TrxName());
		
		MPayment paymentBankFrom = new MPayment(getCtx(), 0, get_TrxName());
		paymentBankFrom.setC_BankTransfer_ID(getC_BankTransfer_ID());
		paymentBankFrom.setC_BankAccount_ID(getFrom_C_BankAccount_ID());
		paymentBankFrom.setAD_Org_ID(getFrom_AD_Org_ID());
		paymentBankFrom.setDocumentNo(getDocumentNo());
		paymentBankFrom.setDateAcct(getDateAcct());
		paymentBankFrom.setDateTrx(getPayDate());
		paymentBankFrom.setTenderType(getFrom_TenderType());
		paymentBankFrom.setDescription(getDescription());
		paymentBankFrom.setC_BPartner_ID(getTo_C_BPartner_ID());
		paymentBankFrom.setC_Currency_ID(getFrom_C_Currency_ID());
		paymentBankFrom.setPayAmt(getFrom_Amt());
		paymentBankFrom.setOverUnderAmt(Env.ZERO);
		paymentBankFrom.setC_DocType_ID(false);
		paymentBankFrom.setC_Charge_ID(getFrom_C_Charge_ID());
		if (as.getC_Currency_ID() != getFrom_C_Currency_ID()) {
			paymentBankFrom.setC_ConversionType_ID(getC_ConversionType_ID());
			paymentBankFrom.setIsOverrideCurrencyRate(isOverrideCurrencyRate());
			if (isOverrideCurrencyRate()) {
				paymentBankFrom.setCurrencyRate(getRate());
				paymentBankFrom.setConvertedAmt(getTo_Amt());
			}
		}
		paymentBankFrom.saveEx();
		if (!paymentBankFrom.processIt(MPayment.DOCACTION_Complete)) {
			log.warning("Payment Process Failed: " + paymentBankFrom + " - " + paymentBankFrom.getProcessMsg());
			throw new IllegalStateException("Payment Process Failed: " + paymentBankFrom + " - " + paymentBankFrom.getProcessMsg());
		}
		paymentBankFrom.saveEx();
		
		MPayment paymentBankTo = new MPayment(getCtx(), 0, get_TrxName());
		paymentBankTo.setC_BankTransfer_ID(getC_BankTransfer_ID());
		paymentBankTo.setC_BankAccount_ID(getTo_C_BankAccount_ID());
		paymentBankTo.setAD_Org_ID(getTo_AD_Org_ID());
		paymentBankTo.setDocumentNo(getDocumentNo());
		paymentBankTo.setDateAcct(getDateAcct());
		paymentBankTo.setDateTrx(getPayDate());
		paymentBankTo.setTenderType(getTo_TenderType());
		paymentBankTo.setDescription(getDescription());
		paymentBankTo.setC_BPartner_ID(getFrom_C_BPartner_ID());
		paymentBankTo.setC_Currency_ID(getTo_C_Currency_ID());
		paymentBankTo.setPayAmt(getTo_Amt());
		paymentBankTo.setOverUnderAmt(Env.ZERO);
		paymentBankTo.setC_DocType_ID(true);
		paymentBankTo.setC_Charge_ID(getTo_C_Charge_ID());
		if (as.getC_Currency_ID() != getTo_C_Currency_ID()) {
			paymentBankTo.setC_ConversionType_ID(getC_ConversionType_ID());
			paymentBankTo.setIsOverrideCurrencyRate(isOverrideCurrencyRate());
			if (isOverrideCurrencyRate()) {
				double dd = 1 / getRate().doubleValue();
				paymentBankTo.setCurrencyRate(BigDecimal.valueOf(dd));
				paymentBankTo.setConvertedAmt(getFrom_Amt());
			}
		}
		paymentBankTo.saveEx();
		if (!paymentBankTo.processIt(MPayment.DOCACTION_Complete)) {
			log.warning("Payment Process Failed: " + paymentBankTo + " - " + paymentBankTo.getProcessMsg());
			throw new IllegalStateException("Payment Process Failed: " + paymentBankTo + " - " + paymentBankTo.getProcessMsg());
		}
		paymentBankTo.saveEx();
		
		//
		setProcessed(true);
		setDocAction(DOCACTION_Close);
		return DocAction.STATUS_Completed;
	}

	@Override
	public boolean voidIt() {
		if (log.isLoggable(Level.INFO)) log.info("voidIt - " + toString());
		// Before Void
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_VOID);
		if (m_processMsg != null)
			return false;

		int[] ids = MPayment.getAllIDs(MPayment.Table_Name, COLUMNNAME_C_BankTransfer_ID + "=" + getC_BankTransfer_ID(), get_TrxName());
		for (int id : ids) {
			MPayment payment = new MPayment(getCtx(), id, get_TrxName());
			if (!payment.voidIt())
				throw new IllegalStateException("Void Payment Failed: " + payment.getProcessMsg());
			payment.saveEx();
		}
		
		// After Void
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_VOID);
		if (m_processMsg != null)
			return false;

		setProcessed(true);
        setDocAction(DOCACTION_None);
		return true;
	}

	@Override
	public boolean closeIt() {
		if (log.isLoggable(Level.INFO)) log.info("closeIt - " + toString());
		// Before Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_CLOSE);
		if (m_processMsg != null)
			return false;
		// After Close
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_CLOSE);
		if (m_processMsg != null)
			return false;

		return true;
	}

	@Override
	public boolean reverseCorrectIt() {
		if (log.isLoggable(Level.INFO)) log.info("reverseCorrectIt - " + toString());
		// Before reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REVERSECORRECT);
		if (m_processMsg != null)
			return false;
		
		int[] ids = MPayment.getAllIDs(MPayment.Table_Name, COLUMNNAME_C_BankTransfer_ID + "=" + getC_BankTransfer_ID(), get_TrxName());
		for (int id : ids) {
			MPayment payment = new MPayment(getCtx(), id, get_TrxName());
			if (!payment.reverseCorrectIt())
				throw new IllegalStateException("Reverse Payment Failed: " + payment.getProcessMsg());
		}

		// After reverseCorrect
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSECORRECT);
		if (m_processMsg != null)
			return false;

		return false;
	}

	@Override
	public boolean reverseAccrualIt() {
		if (log.isLoggable(Level.INFO)) log.info("reverseAccrualIt - " + toString());
		// Before reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;
		
		int[] ids = MPayment.getAllIDs(MPayment.Table_Name, COLUMNNAME_C_BankTransfer_ID + "=" + getC_BankTransfer_ID(), get_TrxName());
		for (int id : ids) {
			MPayment payment = new MPayment(getCtx(), id, get_TrxName());
			if (!payment.reverseAccrualIt())
				throw new IllegalStateException("Reverse Payment Failed: " + payment.getProcessMsg());
		}
		
		// After reverseAccrual
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REVERSEACCRUAL);
		if (m_processMsg != null)
			return false;

		return false;
	}

	@Override
	public boolean reActivateIt() {
		if (log.isLoggable(Level.INFO)) log.info("reActivateIt - " + toString());
		// Before reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_BEFORE_REACTIVATE);
		if (m_processMsg != null)
			return false;

		// After reActivate
		m_processMsg = ModelValidationEngine.get().fireDocValidate(this,ModelValidator.TIMING_AFTER_REACTIVATE);
		if (m_processMsg != null)
			return false;

		return false;
	}

	@Override
	public String getSummary() {
		StringBuilder sb = new StringBuilder();
		sb.append(getDocumentNo());
		//	 - Description
		if (getDescription() != null && getDescription().length() > 0)
			sb.append(" - ").append(getDescription());
		return sb.toString();
	}

	@Override
	public String getDocumentInfo() {
		return Msg.getElement(getCtx(), COLUMNNAME_C_BankTransfer_ID) + " " + getDocumentNo();
	}

	@Override
	public File createPDF() {
		return null;
	}

	@Override
	public String getProcessMsg() {
		return m_processMsg;
	}

	@Override
	public int getDoc_User_ID() {
		return getCreatedBy();
	}

	@Override
	public int getC_Currency_ID() {
		return getFrom_C_Currency_ID();
	}

	@Override
	public BigDecimal getApprovalAmt() {
		return getFrom_Amt();
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString() {
		StringBuilder sb = new StringBuilder ("MBankTransfer[");
		sb.append(get_ID()).append("-").append(getDocumentNo());
		return sb.toString ();
	}	//	toString

}
