/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2026 iDempiere Community                                     *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 *****************************************************************************/
package org.compiere.process;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.model.MBankAccount;
import org.compiere.model.MPaySelection;
import org.compiere.model.MPaySelectionCheck;
import org.compiere.model.MPaySelectionLine;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.model.MRefList;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.model.X_C_BankAccountDoc;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;

/**
 * IDEMPIERE-7188 Create Payment Selection and Lines from Info Window selection.
 * 
 * @author Logilite Technologies
 */
@org.adempiere.base.annotation.Process
public class PaySelectionCreateFromInfoWindow extends SvrProcess
{
	/** Bank Account Parameter */
	private int p_C_BankAccount_ID = 0;
	/** Pay Date Parameter */
	private Timestamp p_PayDate = null;
	/** Payment Rule Parameter */
	private String p_PaymentRule = null;
	/** One payment per invoice */
	private boolean p_IsOnePaymentPerInvoice = false;
	/** Create payments immediately */
	private boolean p_CreatePayments = false;

	@Override
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
			{
				continue;
			}
			else if (name.equals("C_BankAccount_ID"))
			{
				p_C_BankAccount_ID = para[i].getParameterAsInt();
			}
			else if (name.equals("PayDate"))
			{
				p_PayDate = (Timestamp) para[i].getParameter();
			}
			else if (name.equals("PaymentRule"))
			{
				p_PaymentRule = (String) para[i].getParameter();
			}
			else if (name.equalsIgnoreCase(MPaySelection.COLUMNNAME_IsOnePaymentPerInvoice))
			{
				p_IsOnePaymentPerInvoice = para[i].getParameterAsBoolean();
			}
			else if (name.equalsIgnoreCase("IsCreatePayments"))
			{
				p_CreatePayments = para[i].getParameterAsBoolean();
			}
			else
			{
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
			}
		}

		if (p_PayDate == null)
		{
			p_PayDate = Env.getContextAsDate(getCtx(), Env.DATE);
			if (p_PayDate == null)
			{
				p_PayDate = new Timestamp(System.currentTimeMillis());
			}
		}
	}

	@Override
	protected String doIt() throws Exception
	{
		if (p_C_BankAccount_ID <= 0)
		{
			throw new AdempiereException("@FillMandatory@ @C_BankAccount_ID@");
		}
		if (Util.isEmpty(p_PaymentRule, true))
		{
			throw new AdempiereException("@FillMandatory@ @PaymentRule@");
		}

		MBankAccount ba = new MBankAccount(getCtx(), p_C_BankAccount_ID, get_TrxName());
		if (ba.get_ID() == 0)
		{
			throw new AdempiereException("@NotFound@ @C_BankAccount_ID@: " + p_C_BankAccount_ID);
		}

		int bankCurrencyID = ba.getC_Currency_ID();

		// Create Header
		MPaySelection ps = new MPaySelection(getCtx(), 0, get_TrxName());
		String ruleName = MRefList.getListName(getCtx(), SystemIDs.REFERENCE_PAYMENTRULE, p_PaymentRule);
		if (Util.isEmpty(ruleName, true))
		{
			ruleName = p_PaymentRule;
		}
		String name = Msg.getMsg(getCtx(), "VPaySelect") + " - " + ruleName + " - " + DisplayType.getDateFormat().format(p_PayDate);
		ps.setName(name);
		ps.setPayDate(p_PayDate);
		ps.setC_BankAccount_ID(p_C_BankAccount_ID);
		ps.setIsApproved(true);
		ps.setIsOnePaymentPerInvoice(p_IsOnePaymentPerInvoice);
		ps.saveEx();

		// Query selected invoices from T_Selection
		StringBuilder sql = new StringBuilder("SELECT i.C_Invoice_ID, i.IsSOTrx, i.C_Currency_ID, ")
				.append("currencyConvertInvoice(i.C_Invoice_ID, ?, invoiceOpen(i.C_Invoice_ID, i.C_InvoicePaySchedule_ID), ?), ") // 1, 2: OpenAmt in Bank Currency
				.append("currencyConvert(invoiceDiscount(i.C_Invoice_ID, ?, i.C_InvoicePaySchedule_ID), i.C_Currency_ID, ?, ?, i.C_ConversionType_ID, i.AD_Client_ID, i.AD_Org_ID), ") // 3, 4, 5: DiscountAmt
				.append("currencyConvert(invoiceWriteOff(i.C_Invoice_ID), i.C_Currency_ID, ?, ?, i.C_ConversionType_ID, i.AD_Client_ID, i.AD_Org_ID), ") // 6, 7: WriteOffAmt
				.append("currencyConvertInvoice(i.C_Invoice_ID, ?, invoiceOpen(i.C_Invoice_ID, i.C_InvoicePaySchedule_ID) - invoiceDiscount(i.C_Invoice_ID, ?, i.C_InvoicePaySchedule_ID), ?), ") // 8, 9, 10: PayAmt
				.append("i.PaymentRule, i.DocumentNo ")
				.append("FROM C_Invoice_v i ")
				// Info Window key: C_InvoicePaySchedule_ID, or -C_Invoice_ID for invoices without pay schedule
				.append("INNER JOIN T_Selection s ON (COALESCE(i.C_InvoicePaySchedule_ID, -i.C_Invoice_ID) = s.T_Selection_ID) ")
				.append("WHERE s.AD_PInstance_ID = ? ")
				.append("ORDER BY i.DueDate, i.C_BPartner_ID, i.C_Invoice_ID");

		int linesCount = 0;
		try (PreparedStatement pstmt = DB.prepareStatement(sql.toString(), get_TrxName()))
		{
			int idx = 1;
			pstmt.setInt(idx++, bankCurrencyID);
			pstmt.setTimestamp(idx++, p_PayDate);

			pstmt.setTimestamp(idx++, p_PayDate);
			pstmt.setInt(idx++, bankCurrencyID);
			pstmt.setTimestamp(idx++, p_PayDate);

			pstmt.setInt(idx++, bankCurrencyID);
			pstmt.setTimestamp(idx++, p_PayDate);

			pstmt.setInt(idx++, bankCurrencyID);
			pstmt.setTimestamp(idx++, p_PayDate);
			pstmt.setTimestamp(idx++, p_PayDate);

			pstmt.setInt(idx++, getAD_PInstance_ID());

			try (ResultSet rs = pstmt.executeQuery())
			{
				while (rs.next())
				{
					int cInvoiceID = rs.getInt(1);
					boolean isSOTrx = "Y".equals(rs.getString(2));
					String invoicePaymentRule = rs.getString(8);
					String documentNo = rs.getString(9);
					// Same rule as the Payment Selection (manual) form: Direct Debit collects
					// customer invoices with payment rule Direct Debit, other rules pay vendor documents
					boolean isDirectDebit = MPaySelectionCheck.PAYMENTRULE_DirectDebit.equals(p_PaymentRule);
					if (isDirectDebit != isSOTrx
							|| (isDirectDebit && !MPaySelectionCheck.PAYMENTRULE_DirectDebit.equals(invoicePaymentRule)))
					{
						throw new AdempiereException("@Invalid@ @PaymentRule@ / @IsSOTrx@ - @C_Invoice_ID@: " + documentNo);
					}

					BigDecimal openAmt = rs.getBigDecimal(4);
					BigDecimal discountAmt = rs.getBigDecimal(5);
					if (discountAmt == null)
					{
						discountAmt = BigDecimal.ZERO;
					}
					BigDecimal writeOffAmt = rs.getBigDecimal(6);
					if (writeOffAmt == null)
					{
						writeOffAmt = BigDecimal.ZERO;
					}
					BigDecimal payAmt = rs.getBigDecimal(7);

					if (openAmt == null || payAmt == null)
					{
						throw new AdempiereException(Msg.getMsg(getCtx(), "PaymentSelectAmtNull"));
					}

					linesCount++;
					MPaySelectionLine psl = new MPaySelectionLine(ps, linesCount * 10, p_PaymentRule);
					psl.setInvoice(cInvoiceID, isSOTrx, openAmt, payAmt, discountAmt, writeOffAmt);
					psl.saveEx();

					if (log.isLoggable(Level.FINE))
					{
						log.fine("Created Line " + linesCount + " for C_Invoice_ID=" + cInvoiceID + ", PayAmt=" + payAmt);
					}
				}
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e, sql.toString());
		}

		if (linesCount == 0)
		{
			throw new AdempiereException("@NoSelection@");
		}

		// Optionally create checks/payments immediately
		int checksCreated = 0;
		int paymentsCreated = 0;
		if (p_CreatePayments)
		{
			MProcess proc = MProcess.get(getCtx(), SystemIDs.PROCESS_C_PAYSELECTION_CREATEPAYMENT);
			if (proc == null || proc.get_ID() == 0)
			{
				throw new AdempiereException("@NotFound@ @AD_Process_ID@=" + SystemIDs.PROCESS_C_PAYSELECTION_CREATEPAYMENT);
			}

			ProcessInfo pi = new ProcessInfo("PaySelectionCreateCheck", proc.getAD_Process_ID(), MPaySelection.Table_ID, ps.getC_PaySelection_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			ProcessInfoParameter piParam = new ProcessInfoParameter(MPaySelection.COLUMNNAME_IsOnePaymentPerInvoice, p_IsOnePaymentPerInvoice, "", "", "");
			pi.setParameter(new ProcessInfoParameter[] { piParam });

			boolean ok = proc.processIt(pi, Trx.get(get_TrxName(), false));
			if (!ok || pi.isError())
			{
				throw new AdempiereException(pi.getSummary());
			}

			List<MPaySelectionCheck> checks = new Query(getCtx(), MPaySelectionCheck.Table_Name, "C_PaySelection_ID = ?", get_TrxName())
					.setParameters(ps.getC_PaySelection_ID())
					.list();

			checksCreated = checks.size();

			// Check numbers come from the bank account document, as in the Payment Print/Export form
			X_C_BankAccountDoc bankAccountDoc = null;
			if (MPaySelectionCheck.PAYMENTRULE_Check.equals(p_PaymentRule))
			{
				bankAccountDoc = new Query(getCtx(), X_C_BankAccountDoc.Table_Name,
						"C_BankAccount_ID=? AND PaymentRule=?", get_TrxName())
						.setParameters(ps.getC_BankAccount_ID(), p_PaymentRule)
						.setOnlyActiveRecords(true)
						.setOrderBy(X_C_BankAccountDoc.COLUMNNAME_C_BankAccountDoc_ID)
						.first();
				if (bankAccountDoc == null || bankAccountDoc.getCurrentNext() <= 0)
				{
					throw new AdempiereException("@NotFound@ @C_BankAccountDoc_ID@ - @C_BankAccount_ID@: " + ba.getName()
							+ ", @PaymentRule@: " + ruleName);
				}
			}
			int nextDocNo = bankAccountDoc != null ? bankAccountDoc.getCurrentNext() : 0;

			for (MPaySelectionCheck check : checks)
			{
				if (bankAccountDoc != null && Util.isEmpty(check.getDocumentNo(), true))
				{
					check.setDocumentNo(String.valueOf(nextDocNo++));
					check.saveEx();
				}
				MPaySelectionCheck.confirmPrint(check, null);
				if (check.getC_Payment_ID() > 0)
				{
					paymentsCreated++;
				}
			}

			if (bankAccountDoc != null && nextDocNo != bankAccountDoc.getCurrentNext())
			{
				bankAccountDoc.setCurrentNext(nextDocNo);
				bankAccountDoc.saveEx();
			}
		}

		addLog(ps.getC_PaySelection_ID(), p_PayDate, ps.getTotalAmt(), ps.getName(), MPaySelection.Table_ID, ps.getC_PaySelection_ID());

		StringBuilder resultMsg = new StringBuilder("@C_PaySelection_ID@: ")
				.append(ps.toString())
				.append(" (@C_PaySelectionLine_ID@: ").append(linesCount).append(")");

		if (p_CreatePayments)
		{
			resultMsg.append(" - @C_PaySelectionCheck_ID@: ").append(checksCreated);
			if (paymentsCreated > 0)
			{
				resultMsg.append(" - @C_Payment_ID@: ").append(paymentsCreated);
			}
		}

		return resultMsg.toString();
	}
}
