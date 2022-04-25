/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.acct.Doc;
import org.compiere.process.DocAction;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

/**
 *  Payment Print/Export model.
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: MPaySelectionCheck.java,v 1.3 2006/07/30 00:51:02 jjanke Exp $
 */
public class MPaySelectionCheck extends X_C_PaySelectionCheck
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2130445794890189020L;

	/**
	 * 	Get Check for Payment
	 *	@param ctx context
	 *	@param C_Payment_ID id
	 *	@param trxName transaction
	 *	@return pay selection check for payment or null
	 */
	public static MPaySelectionCheck getOfPayment (Properties ctx, int C_Payment_ID, String trxName)
	{
		MPaySelectionCheck retValue = null;
		String sql = "SELECT * FROM C_PaySelectionCheck WHERE C_Payment_ID=?";
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, C_Payment_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				MPaySelectionCheck psc = new MPaySelectionCheck (ctx, rs, trxName);
				if (retValue == null)
					retValue = psc;
				else if (!retValue.isProcessed() && psc.isProcessed())
					retValue = psc;
				count++;
			}
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, sql, e); 
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		if (count > 1)
			s_log.warning ("More then one for C_Payment_ID=" + C_Payment_ID);
		return retValue;
	}	//	getOfPayment

	/**
	 * 	Create Check for Payment
	 *	@param ctx context
	 *	@param C_Payment_ID id
	 *	@param trxName transaction
	 *	@return pay selection check for payment or null
	 */
	public static MPaySelectionCheck createForPayment (Properties ctx, int C_Payment_ID, String trxName)
	{
		if (C_Payment_ID == 0)
			return null;
		MPayment payment = new MPayment (ctx, C_Payment_ID, null);
		//	Map Payment Rule <- Tender Type
		String PaymentRule = PAYMENTRULE_Check;
		if (payment.getTenderType().equals(X_C_Payment.TENDERTYPE_CreditCard))
			PaymentRule = PAYMENTRULE_CreditCard;
		else if (payment.getTenderType().equals(X_C_Payment.TENDERTYPE_DirectDebit))
			PaymentRule = PAYMENTRULE_DirectDebit;
		else if (payment.getTenderType().equals(X_C_Payment.TENDERTYPE_DirectDeposit))
			PaymentRule = PAYMENTRULE_DirectDeposit;
		else if (payment.getTenderType().equals(X_C_Payment.TENDERTYPE_Cash))
			PaymentRule = PAYMENTRULE_Cash;

		//	Create new PaySelection
		MPaySelection ps = new MPaySelection(ctx, 0, trxName);
		ps.setAD_Org_ID(payment.getAD_Org_ID());
		ps.setC_BankAccount_ID (payment.getC_BankAccount_ID());
		ps.setName (Msg.translate(ctx, "C_Payment_ID") + ": " + payment.getDocumentNo());
		ps.setDescription(payment.getDescription());
		ps.setPayDate (payment.getDateTrx());
		ps.setTotalAmt (payment.getPayAmt());
		ps.setIsApproved (true);
		ps.saveEx();
		
		//	Create new PaySelection Check
		MPaySelectionCheck psc = new MPaySelectionCheck(ps, PaymentRule);
		psc.setC_BPartner_ID (payment.getC_BPartner_ID());
		psc.setC_Payment_ID(payment.getC_Payment_ID());
		psc.setIsReceipt(payment.isReceipt());
		psc.setPayAmt (payment.getPayAmt());
		psc.setDiscountAmt(payment.getDiscountAmt());
		psc.setWriteOffAmt(payment.getWriteOffAmt());
		psc.setQty (1);
		psc.setDocumentNo(payment.getDocumentNo());
		psc.setProcessed(true);
		// afalcone - [ 1871567 ] Wrong value in Payment document
		psc.setIsGeneratedDraft( ! payment.isProcessed() );
		//
		psc.saveEx();
		
		//	Create new PaySelection Line
		MPaySelectionLine psl = null;
		if (payment.getC_Invoice_ID() != 0)
		{
			psl = new MPaySelectionLine (ps, 10, PaymentRule);
			psl.setC_Invoice_ID(payment.getC_Invoice_ID());
			psl.setIsSOTrx (payment.isReceipt());
			psl.setOpenAmt(payment.getPayAmt().add(payment.getDiscountAmt()));
			psl.setPayAmt (payment.getPayAmt());
			psl.setDiscountAmt(payment.getDiscountAmt());
			psl.setWriteOffAmt(payment.getWriteOffAmt());
			psl.setDifferenceAmt (Env.ZERO);
			psl.setC_PaySelectionCheck_ID(psc.getC_PaySelectionCheck_ID());
			psl.setProcessed(true);
			psl.saveEx();
		} else {
			// globalqss - CarlosRuiz - fix bug [ 1803054 ] Empty Remittance lines on payments
			// look for existance of C_PaymentAllocate records
			//	Allocate to multiple Payments based on entry
			MPaymentAllocate[] pAllocs = MPaymentAllocate.get(payment);
			if (pAllocs.length != 0) {
				int numInv = 0;
				for (int i = 0; i < pAllocs.length; i++) {
					MPaymentAllocate pAlloc = pAllocs[i];
					if (pAlloc.getC_Invoice_ID() != 0)
					{
						MPaySelectionLine psla = null;
						psla = new MPaySelectionLine (ps, 10 * (i+1), PaymentRule);
						psla.setC_Invoice_ID(pAlloc.getC_Invoice_ID());
						psla.setIsSOTrx (payment.isReceipt());
						psla.setOpenAmt(pAlloc.getAmount().add(pAlloc.getDiscountAmt()));
						psla.setPayAmt (pAlloc.getAmount());
						psla.setDiscountAmt(pAlloc.getDiscountAmt());
						psla.setWriteOffAmt(pAlloc.getWriteOffAmt());
						psla.setDifferenceAmt (Env.ZERO);
						psla.setC_PaySelectionCheck_ID(psc.getC_PaySelectionCheck_ID());
						psla.setProcessed(true);
						psla.saveEx();
						numInv++;
					}
				}
				if (numInv > 0) {
					psc.setQty (numInv);
					psc.saveEx();
				}
			}
		}
		
		//	Indicate Done
		ps.setProcessed(true);
		ps.saveEx();
		return psc;
	}	//	createForPayment
	
	/**************************************************************************
	 *  Get Checks of Payment Selection without check no assignment
	 *
	 *  @param C_PaySelection_ID Payment Selection
	 *  @param PaymentRule Payment Rule
	 *	@param trxName transaction
	 *  @return array of checks
	 */
	public static MPaySelectionCheck[] get (int C_PaySelection_ID, String PaymentRule, String trxName)
	{
		if (s_log.isLoggable(Level.FINE)) s_log.fine("C_PaySelection_ID=" + C_PaySelection_ID
			+ ", PaymentRule=" +  PaymentRule);
		ArrayList<MPaySelectionCheck> list = new ArrayList<MPaySelectionCheck>();

		String sql = "SELECT * FROM C_PaySelectionCheck "
			+ "WHERE C_PaySelection_ID=? AND PaymentRule=? "
			+ "ORDER BY C_PaySelectionCheck_ID"; // order by the C_PaySelectionCheck_ID
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, trxName);
			pstmt.setInt(1, C_PaySelection_ID);
			pstmt.setString(2, PaymentRule);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MPaySelectionCheck check = new MPaySelectionCheck (Env.getCtx(), rs, trxName);
				list.add(check);
			}
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//  convert to Array
		MPaySelectionCheck[] retValue = new MPaySelectionCheck[list.size()];
		list.toArray(retValue);
		return retValue;
	}   //  get

	
	/**************************************************************************
	 *  Get Checks of Payment Selection
	 *
	 *  @param C_PaySelection_ID Payment Selection
	 *  @param PaymentRule Payment Rule
	 *  @param startDocumentNo start document no
	 *	@param trxName transaction
	 *  @return array of checks
	 */
	static public MPaySelectionCheck[] get (int C_PaySelection_ID,
		String PaymentRule, int startDocumentNo, String trxName)
	{
		MPaySelectionCheck[] checks = get(C_PaySelection_ID, PaymentRule, trxName);
		int docNo = startDocumentNo;
		for (MPaySelectionCheck check : checks)
		{
			//	Set new Check Document No
			check.setDocumentNo(String.valueOf(docNo++));
			check.saveEx(); 
		}
		return checks;
	}   //  get

	/**************************************************************************
	 * 	Confirm Print for a payment selection check
	 * 	Create Payment the first time 
	 * 	@param check check
	 * 	@param batch batch
	 */
	public static void confirmPrint (MPaySelectionCheck check, MPaymentBatch batch)
	{
		boolean localTrx = false;
		String trxName = check.get_TrxName();
		Trx trx = null;
		if (trxName == null) {
			localTrx = true;
			trxName = Trx.createTrxName("ConfirmPrintSingle");
			trx = Trx.get(trxName, true);
			trx.setDisplayName(MPaySelectionCheck.class.getName()+"_confirmPrint");
			check.set_TrxName(trxName);
		}
		try {
			MPayment payment = new MPayment(check.getCtx(), check.getC_Payment_ID(), trxName);
			//	Existing Payment
			if (check.getC_Payment_ID() != 0)
			{
				//	Update check number
				if (check.getPaymentRule().equals(PAYMENTRULE_Check))
				{
					payment.setCheckNo(check.getDocumentNo());
					payment.saveEx();
				}
			}
			else	//	New Payment
			{
				payment = new MPayment(check.getCtx(), 0, trxName);
				payment.setAD_Org_ID(check.getAD_Org_ID());
				//
				if (check.getPaymentRule().equals(PAYMENTRULE_Check))
					payment.setBankCheck (check.getParent().getC_BankAccount_ID(), false, check.getDocumentNo());
				else if (check.getPaymentRule().equals(PAYMENTRULE_CreditCard))
					payment.setTenderType(X_C_Payment.TENDERTYPE_CreditCard);
				else if (check.getPaymentRule().equals(PAYMENTRULE_DirectDeposit)
					|| check.getPaymentRule().equals(PAYMENTRULE_DirectDebit))
					payment.setBankACH(check);
				else
				{
					s_log.log(Level.SEVERE, "Unsupported Payment Rule=" + check.getPaymentRule());
					return;
				}
				payment.setTrxType(X_C_Payment.TRXTYPE_CreditPayment);
				payment.setAmount(check.getParent().getC_Currency_ID(), check.getPayAmt());
				payment.setDiscountAmt(check.getDiscountAmt());
				payment.setWriteOffAmt(check.getWriteOffAmt());
				payment.setDateTrx(check.getParent().getPayDate());
				payment.setDateAcct(payment.getDateTrx()); // globalqss [ 2030685 ]
				payment.setC_BPartner_ID(check.getC_BPartner_ID());
				//	Link to Batch
				if (batch != null)
				{
					if (batch.getC_PaymentBatch_ID() == 0)
						batch.saveEx(trxName);	//	new
					payment.setC_PaymentBatch_ID(batch.getC_PaymentBatch_ID());
				}
				//	Link to Invoice
				MPaySelectionLine[] psls = check.getPaySelectionLines(true);
				if (s_log.isLoggable(Level.FINE)) s_log.fine("confirmPrint - " + check + " (#SelectionLines=" + psls.length + ")");
				if (check.getQty() == 1 && psls != null && psls.length == 1)
				{
					MPaySelectionLine psl = psls[0];
					if (s_log.isLoggable(Level.FINE)) s_log.fine("Map to Invoice " + psl);
					//
					payment.setC_Invoice_ID (psl.getC_Invoice_ID());
					payment.setDiscountAmt (psl.getDiscountAmt());
					payment.setWriteOffAmt (psl.getWriteOffAmt());
					BigDecimal overUnder = psl.getOpenAmt().subtract(psl.getPayAmt())
						.subtract(psl.getDiscountAmt()).subtract(psl.getWriteOffAmt()).subtract(psl.getDifferenceAmt());
					payment.setOverUnderAmt(overUnder);
				}
				else
				{
					payment.setWriteOffAmt(Env.ZERO);
					payment.setDiscountAmt(Env.ZERO);
				}
				payment.saveEx();
				//
				int C_Payment_ID = payment.get_ID();
				if (C_Payment_ID < 1)
					s_log.log(Level.SEVERE, "Payment not created=" + check);
				else
				{
					check.setC_Payment_ID (C_Payment_ID);
					check.saveEx();	//	Payment process needs it
					// added AdempiereException by zuhri
					if (!payment.processIt(DocAction.ACTION_Complete))
						throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FailedProcessingDocument") + " - " + payment.getProcessMsg());
					// end added
					payment.saveEx();
				}
			}	//	new Payment

			check.setIsPrinted(true);
			check.setProcessed(true);
			check.saveEx();
		} catch (Exception e) {
			if (localTrx && trx != null) {
				trx.rollback();
				trx.close();
				trx = null;
			}
			throw new AdempiereException(e);
		} finally {
			if (localTrx && trx != null) {
				trx.commit();
				trx.close();
			}
		}
	}	//	confirmPrint
	
	/**************************************************************************
	 * 	Confirm Print.
	 * 	Create Payments the first time 
	 * 	@param checks checks
	 * 	@param batch batch
	 * 	@param createDepositBatch create deposit batch
	 * 	@return last Document number or 0 if nothing printed
	 */
	public static int confirmPrint (MPaySelectionCheck[] checks, MPaymentBatch batch, boolean createDepositBatch)
	{
		boolean localTrx = false;
		String trxName = null;
		int lastDocumentNo = 0;

		if (checks.length > 0)
		{
			trxName = checks[0].get_TrxName();
			Properties ctx = checks[0].getCtx();
			int c_BankAccount_ID = checks[0].getC_PaySelection().getC_BankAccount_ID() ;
			String paymentRule = checks[0].getPaymentRule() ;
			Boolean isDebit ;
			if (MInvoice.PAYMENTRULE_DirectDeposit.compareTo(paymentRule) == 0
					|| MInvoice.PAYMENTRULE_Check.compareTo(paymentRule) == 0
					|| MInvoice.PAYMENTRULE_OnCredit.compareTo(paymentRule) == 0)
			{
				isDebit = false ;
			}
			else if (MInvoice.PAYMENTRULE_DirectDebit.compareTo(paymentRule) == 0)
			{
				isDebit = true ;
			}
			else
			{
				isDebit = false ;
				createDepositBatch = false ;
			}
			Trx trx = null;
			if (trxName == null) {
				localTrx = true;
				trxName = Trx.createTrxName("ConfirmPrintMulti");
				trx = Trx.get(trxName, true);
			}

			try {
				MDepositBatch depositBatch = null;
				if (createDepositBatch)
				{
					depositBatch = new MDepositBatch(ctx, 0, trxName) ;
					depositBatch.setC_BankAccount_ID(c_BankAccount_ID);
					if (isDebit)
					{
						depositBatch.setC_DocType_ID(MDocType.getDocType(Doc.DOCTYPE_ARReceipt));
					}
					else
					{
						depositBatch.setC_DocType_ID(MDocType.getDocType(Doc.DOCTYPE_APPayment));
					}
					depositBatch.setDateDeposit(new Timestamp((new Date()).getTime()));
					depositBatch.setDateDoc(new Timestamp((new Date()).getTime()));
					depositBatch.saveEx();
				}

				for (int i = 0; i < checks.length; i++)
				{
					MPaySelectionCheck check = checks[i];
					if (localTrx)
						check.set_TrxName(trxName);
					confirmPrint(check, batch);
					if (createDepositBatch)
					{
						MDepositBatchLine depositBatchLine = new MDepositBatchLine(depositBatch) ;
						depositBatchLine.setC_Payment_ID(check.getC_Payment_ID());
						depositBatchLine.setProcessed(true);
						depositBatchLine.saveEx();
					}
					//	Get Check Document No
					try
					{
						int no = Integer.parseInt(check.getDocumentNo());
						if (lastDocumentNo < no)
							lastDocumentNo = no;
					}
					catch (NumberFormatException ex)
					{
						s_log.log(Level.SEVERE, "DocumentNo=" + check.getDocumentNo(), ex);
					}
				}	//	all checks

				if (createDepositBatch)
				{

					depositBatch.setProcessed(true);
					depositBatch.saveEx();
				}

			} catch (Exception e) {
				if (localTrx && trx != null) {
					trx.rollback();
					trx.close();
					trx = null;
				}
				throw new AdempiereException(e);
			} finally {
				if (localTrx && trx != null) {
					trx.commit();
					trx.close();
				}
			}
		}
		if (s_log.isLoggable(Level.FINE)) s_log.fine("Last Document No = " + lastDocumentNo);
		return lastDocumentNo;
	}	//	confirmPrint

	/**************************************************************************
	 * 	Confirm Print.
	 * 	Create Payments the first time 
	 * 	@param checks checks
	 * 	@param batch batch
	 * 	@return last Document number or 0 if nothing printed
	 */

	public static int confirmPrint (MPaySelectionCheck[] checks, MPaymentBatch batch)
	{
		return confirmPrint (checks,batch,false) ;
	} // confirmPrint

	/** Logger								*/
	static private CLogger	s_log = CLogger.getCLogger (MPaySelectionCheck.class);

	/**************************************************************************
	 *	Constructor
	 *  @param ctx context
	 *  @param C_PaySelectionCheck_ID C_PaySelectionCheck_ID
	 *	@param trxName transaction
	 */
	public MPaySelectionCheck (Properties ctx, int C_PaySelectionCheck_ID, String trxName)
	{
		super(ctx, C_PaySelectionCheck_ID, trxName);
		if (C_PaySelectionCheck_ID == 0)
		{
			setPayAmt (Env.ZERO);
			setDiscountAmt(Env.ZERO);
			setWriteOffAmt(Env.ZERO);
			setIsPrinted (false);
			setIsReceipt (false);
			setQty (0);
		}
	}   //  MPaySelectionCheck

	/**
	 *	Load Constructor
	 *  @param ctx context
	 *  @param rs result set
	 *	@param trxName transaction
	 */
	public MPaySelectionCheck(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}   //  MPaySelectionCheck

	/**
	 * 	Create from Line
	 *	@param line payment selection
	 *	@param PaymentRule payment rule
	 */
	public MPaySelectionCheck (MPaySelectionLine line, String PaymentRule)
	{
		this (line.getCtx(), 0, line.get_TrxName());
		setClientOrg(line);
		setC_PaySelection_ID (line.getC_PaySelection_ID());
		int C_BPartner_ID = line.getInvoice().getC_BPartner_ID();
		setC_BPartner_ID (C_BPartner_ID);
		//
		if (X_C_Order.PAYMENTRULE_DirectDebit.equals(PaymentRule))
		{
			MBPBankAccount[] bas = MBPBankAccount.getOfBPartner (line.getCtx(), C_BPartner_ID); 
			for (int i = 0; i < bas.length; i++) 
			{
				MBPBankAccount account = bas[i];
				if (account.isDirectDebit())
				{
					setC_BP_BankAccount_ID(account.getC_BP_BankAccount_ID());
					break;
				}
			}
		}
		else if (X_C_Order.PAYMENTRULE_DirectDeposit.equals(PaymentRule))
		{
			MBPBankAccount[] bas = MBPBankAccount.getOfBPartner (line.getCtx(), C_BPartner_ID); 
			for (int i = 0; i < bas.length; i++) 
			{
				MBPBankAccount account = bas[i];
				if (account.isDirectDeposit())
				{
					setC_BP_BankAccount_ID(account.getC_BP_BankAccount_ID());
					break;
				}
			}
		}
		setPaymentRule (PaymentRule);
		//
		setIsReceipt(line.isSOTrx());
		setPayAmt (line.getPayAmt());
		setDiscountAmt(line.getDiscountAmt());
		setWriteOffAmt(line.getWriteOffAmt());
		setQty (1);
	}	//	MPaySelectionCheck

	/**
	 * 	Create from Pay Selection
	 *	@param ps payment selection
	 *	@param PaymentRule payment rule
	 */
	public MPaySelectionCheck (MPaySelection ps, String PaymentRule)
	{
		this (ps.getCtx(), 0, ps.get_TrxName());
		setClientOrg(ps);
		setC_PaySelection_ID (ps.getC_PaySelection_ID());
		setPaymentRule (PaymentRule);
	}	//	MPaySelectionCheck
	
	
	/**	Parent					*/
	private MPaySelection			m_parent = null;
	/**	Payment Selection lines of this check	*/
	private MPaySelectionLine[]		m_lines = null;

	
	/**
	 * 	Add Payment Selection Line
	 *	@param line line
	 */
	public void addLine (MPaySelectionLine line)
	{
		if (getC_BPartner_ID() != line.getInvoice().getC_BPartner_ID())
			throw new IllegalArgumentException("Line for different BPartner");
		//
		if (isReceipt() == line.isSOTrx())
		{
			setPayAmt (getPayAmt().add(line.getPayAmt()));
			setDiscountAmt(getDiscountAmt().add(line.getDiscountAmt()));
			setWriteOffAmt(getWriteOffAmt().add(line.getWriteOffAmt()));
		}
		else
		{
			setPayAmt (getPayAmt().subtract(line.getPayAmt()));
			setDiscountAmt(getDiscountAmt().subtract(line.getDiscountAmt()));
			setWriteOffAmt(getWriteOffAmt().subtract(line.getWriteOffAmt()));
		}
		setQty (getQty()+1);
	}	//	addLine
	
	/**
	 * 	Get Parent
	 *	@return parent
	 */
	public MPaySelection getParent()
	{
		if (m_parent == null)
			m_parent = new MPaySelection (getCtx(), getC_PaySelection_ID(), get_TrxName());
		return m_parent;
	}	//	getParent

	/**
	 * 	Is this a valid Prepared Payment
	 *	@return true if valid
	 */
	public boolean isValid()
	{
		if (getC_BP_BankAccount_ID() != 0)
			return true;
		return !isDirect();
	}	//	isValid
	
	/**
	 * 	Is this a direct Debit or Deposit
	 *	@return true if direct
	 */
	public boolean isDirect()
	{
		return (X_C_Order.PAYMENTRULE_DirectDeposit.equals(getPaymentRule())
			|| X_C_Order.PAYMENTRULE_DirectDebit.equals(getPaymentRule()));
	}	//	isDirect
	
	/**
	 * 	String Representation
	 * 	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MPaymentCheck[");
		sb.append(get_ID()).append("-").append(getDocumentNo())
			.append("-").append(getPayAmt())
			.append(",PaymetRule=").append(getPaymentRule())
			.append(",Qty=").append(getQty())
			.append("]");
		return sb.toString();
	}	//	toString
	
	/**
	 * 	Get Payment Selection Lines of this check
	 *	@param requery requery
	 * 	@return array of payment selection lines
	 */
	public MPaySelectionLine[] getPaySelectionLines (boolean requery)
	{
		if (m_lines != null && !requery) {
			set_TrxName(m_lines, get_TrxName());
			return m_lines;
		}
		ArrayList<MPaySelectionLine> list = new ArrayList<MPaySelectionLine>();
		String sql = "SELECT * FROM C_PaySelectionLine WHERE C_PaySelectionCheck_ID=? ORDER BY Line";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, get_TrxName());
			pstmt.setInt (1, getC_PaySelectionCheck_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MPaySelectionLine(getCtx(), rs, get_TrxName()));
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//
		m_lines = new MPaySelectionLine[list.size ()];
		list.toArray (m_lines);
		return m_lines;
	}	//	getPaySelectionLines

	
	/**
	 *	Delete Payment Selection when generated as Draft (Print Preview) 
	 *	@param ctx context
	 *	@param C_Payment_ID id
	 *	@param trxName transaction
	 * @return
	 */
	public static boolean deleteGeneratedDraft(Properties ctx, int C_Payment_ID, String trxName)
	{
		
		MPaySelectionCheck mpsc = MPaySelectionCheck.getOfPayment (ctx, C_Payment_ID, trxName);
		
		if (mpsc != null && mpsc.isGeneratedDraft())  
		{
			MPaySelection mps = new MPaySelection(ctx, mpsc.getC_PaySelection_ID(),trxName);
			MPaySelectionLine[] mpsl = mps.getLines(true);
			
			// Delete Pay Selection lines 
			for (int i = 0; i < mpsl.length; i++) 
			{
				if (!mpsl[i].delete(true, trxName))
					return false;
			}
			// Delete Pay Selection Check
			if (!mpsc.delete(true, trxName))
				return false;
			
			// Delete Pay Selection
			if (!mps.delete(true, trxName))
				return false;
		}
	return true;	
	}
	
}   //  MPaySelectionCheck
