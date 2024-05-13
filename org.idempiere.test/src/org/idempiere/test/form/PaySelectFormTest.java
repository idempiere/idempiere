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
package org.idempiere.test.form;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;

import org.compiere.apps.form.PayPrint;
import org.compiere.apps.form.PaySelect;
import org.compiere.apps.form.PaySelect.BankInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.minigrid.MiniTableImpl;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MAllocationLine;
import org.compiere.model.MBPartner;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MPaySelection;
import org.compiere.model.MPaySelectionCheck;
import org.compiere.model.MPaySelectionLine;
import org.compiere.model.MPayment;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

public class PaySelectFormTest extends AbstractTestCase {

	public PaySelectFormTest() {
	}

	@Test
	public void testPaySelect() {
		MInvoice invoice = null;
		MInvoiceLine line  = null;
		MPaySelection paySelection = null;
		Optional<ValueNamePair> optionalPR = null;
		try {
			//create vendor invoice
			invoice = new MInvoice(Env.getCtx(), 0, null);
			MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.PATIO.id);
			invoice.setBPartner(bp);
			invoice.setIsSOTrx(false);
			invoice.setC_DocTypeTarget_ID();
			invoice.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
			invoice.setPaymentRule(MInvoice.PAYMENTRULE_Check);
			invoice.setC_PaymentTerm_ID(DictionaryIDs.C_PaymentTerm.IMMEDIATE.id);
			invoice.setDateAcct(TimeUtil.getDay(System.currentTimeMillis()));
			invoice.setDateOrdered(invoice.getDateAcct());
			invoice.saveEx();
			
			line  = new MInvoiceLine(invoice);
			line.setC_Charge_ID(DictionaryIDs.C_Charge.COMMISSIONS.id);
			line.setQty(new BigDecimal("1"));
			line.setPrice(new BigDecimal("10"));
			line.saveEx();
			
			ProcessInfo info = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
			assertFalse(info.isError(), info.getSummary());
			invoice.load(null);
			assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
			
			PaySelectImpl form = new PaySelectImpl();
			
			MInvoice finalInvoice = invoice;
			ArrayList<BankInfo> bis = form.getBankAccountData();
			assertTrue(bis.size() > 0, "Failed to retrieve bank account info");
			Optional<BankInfo> optionalBI = bis.stream().filter(e -> e.C_Currency_ID == finalInvoice.getC_Currency_ID()).findFirst();
			assertTrue(optionalBI.isPresent(), "Failed to locate bank account record for currency " + invoice.getC_Currency_ID());
			
			ArrayList<KeyNamePair> bps = form.getBPartnerData();
			assertTrue(bps.size() > 0, "Failed to retrieve business partner records with open invoice");
			Optional<KeyNamePair> optionalBP = bps.stream().filter(e -> e.getKey() == finalInvoice.getC_BPartner_ID()).findFirst();
			assertTrue(optionalBP.isPresent(), "Failed to find business partner for invoice");
			
			ArrayList<KeyNamePair> docTypes = form.getDocTypeData();
			assertTrue(docTypes.size() > 0, "Failed to retrieve document type records");
			Optional<KeyNamePair> optionalDocType = docTypes.stream().filter(e -> e.getKey() == finalInvoice.getC_DocType_ID()).findFirst();
			assertTrue(optionalDocType.isPresent(), "Failed to retrieve document type for invoice");
			
			ArrayList<ValueNamePair> paymentRules = form.getPaymentRuleData(optionalBI.get());
			assertTrue(paymentRules.size() > 0, "Failed to retrieve payment rule records");
			optionalPR = paymentRules.stream().filter(e -> e.getValue().equals(finalInvoice.getPaymentRule())).findFirst();	
			assertTrue(optionalPR.isPresent(), "Failed to retrieve payment rule for invoice");
			assertEquals(optionalBI.get().Balance.setScale(2, RoundingMode.HALF_EVEN), form.getBankBalance().setScale(2, RoundingMode.HALF_EVEN), "Unexpected bank balance");
			
			form.loadTableInfo(optionalBI.get(), invoice.getDateInvoiced(), optionalPR.get(), true, true, optionalBP.get(), optionalDocType.get(), form.miniTable);
			assertTrue(form.miniTable.getRowCount() > 0, "Failed to load open invoice documents");
			
			BigDecimal balance = optionalBI.get().Balance;
			for(int i = 0; i < form.miniTable.getRowCount(); i++) {
				IDColumn id = (IDColumn) form.miniTable.getValueAt(i, 0);
				if (id.getRecord_ID().intValue() == invoice.get_ID()) {
					id.setSelected(true);
					form.miniTable.setSelectedRow(i);
					BigDecimal amt = (BigDecimal)form.miniTable.getValueAt(i, 9);
					balance = balance.subtract(amt);
					break;
				}
			}
			
			assertEquals(0, form.miniTable.getSelectedRow(), "Invoice not in loaded open list");
			
			DecimalFormat format = DisplayType.getNumberFormat(DisplayType.Amount);
			String status = form.calculateSelection(form.miniTable);
			BigDecimal expected = optionalBI.get().Balance.subtract(invoice.getGrandTotal());
			String remaining = format.format(expected);
			assertTrue(status.contains(remaining), "Unexpected status text");
			assertEquals(expected.setScale(2, RoundingMode.HALF_EVEN), balance.setScale(2, RoundingMode.HALF_EVEN), "Unexpected balance after selection and calculation");
			
			//create pay selection
			String error = form.generatePaySelect(form.miniTable, optionalPR.get(), invoice.getDateInvoiced(), optionalBI.get());
			assertTrue(Util.isEmpty(error, true), error);
			assertNotNull(form.getPaySelection(), "Pay Selection Not Generated");
			paySelection = form.getPaySelection();
			
			//create pay selection check
			int AD_Process_ID = SystemIDs.PROCESS_C_PAYSELECTION_CREATEPAYMENT;
			MPInstance mpi = new MPInstance(Env.getCtx(), AD_Process_ID, MPaySelection.Table_ID, paySelection.get_ID(), paySelection.getC_PaySelection_UU());
			mpi.saveEx();
			MPInstancePara para = new MPInstancePara(mpi, 10);
			para.setParameter(MPaySelection.COLUMNNAME_IsOnePaymentPerInvoice, false);
			para.saveEx();
			
			ProcessInfo pi = new ProcessInfo("PROCESS_C_PAYSELECTION_CREATEPAYMENT", AD_Process_ID);
			pi.setAD_PInstance_ID(mpi.get_ID());
			pi.setAD_Client_ID(getAD_Client_ID());
			pi.setAD_User_ID(getAD_User_ID());
			pi.setTable_ID(MPaySelection.Table_ID);
			pi.setRecord_ID(paySelection.get_ID());
			ServerProcessCtl.process(pi, null);
			assertFalse(pi.isError(), pi.getSummary());
			
			MPaySelectionCheck[] pscs = MPaySelectionCheck.get(paySelection.get_ID(), optionalPR.get().getValue(), null);
			assertTrue(pscs.length > 0, "MPaySelectionCheck not created");
			
			//create payment
			PayPrintImpl payPrint = new PayPrintImpl();
			payPrint.loadPaySelectInfo(paySelection.getC_PaySelection_ID());
			paymentRules = payPrint.loadPaymentRule(paySelection.getC_PaySelection_ID());
			assertTrue(paymentRules.size() > 0, "Failed to load applicable payment rules for payment selection");
			payPrint.loadPaymentRuleInfo(paySelection.get_ID(), optionalPR.get().getValue());
			assertTrue(payPrint.getNextDocumentNo() > 0, "Unexpected next check/document number");
			assertTrue(payPrint.getNumberOfPreparePayment() > 0, "Unexpected number of C_PaySelectionCheck record: " + payPrint.getNumberOfPreparePayment());
			assertTrue(payPrint.getPayAmtSum() > 0, "Unexpected sum of pay amount: " + payPrint.getPayAmtSum());
			assertTrue(payPrint.getPrintFormatId() > 0, "No print format");
			
			try {
				AtomicReference<ValueNamePair> errorRef = new AtomicReference<>();
				errorRef.set(new ValueNamePair(null, null));
				boolean loaded = payPrint.getChecks(optionalPR.get().getValue(), new BigDecimal(payPrint.getNextDocumentNo()), errorRef, null);
				assertTrue(loaded, "Failed to load check selection records");
				assertTrue(Util.isEmpty(errorRef.get().getValue()), errorRef.get().getValue() + " " + errorRef.get().getName() != null ? errorRef.get().getName() : "");
				MPaySelectionCheck[] checks = payPrint.getSelectionChecks();
				assertTrue(checks.length > 0, "Unexpected number of C_PaySelectionCheck records : " + checks.length);
				
				//create payments
				List<File> pdfs = payPrint.createCheckDocuments(payPrint.getNextDocumentNo(), optionalPR.get().getValue());
				assertTrue(pdfs.size() > 0, "Failed to create check document");
				for(MPaySelectionCheck psc : checks) {
					psc.load(null);
					assertTrue(psc.getC_Payment_ID() > 0, "Payment not created");
				}
				
				pdfs = payPrint.createRemittanceDocuments();
				assertTrue(pdfs.size() > 0, "Failed to create remittance documents");
			} catch (Exception e1) {
				fail(e1);
			}
		} finally {
			if (paySelection != null && paySelection.get_ID() > 0) {
				MPaySelectionLine[] lines = paySelection.getLines(true);
				for(MPaySelectionLine l : lines)
					l.deleteEx(true);
				if (optionalPR.get() != null) {
					MPaySelectionCheck[] pscs = MPaySelectionCheck.get(paySelection.get_ID(), optionalPR.get().getValue(), null);
					for(MPaySelectionCheck psc : pscs) {
						int C_Payment_ID = psc.getC_Payment_ID();
						psc.deleteEx(true);
						if (C_Payment_ID > 0) {
							MPayment payment = new MPayment(Env.getCtx(), C_Payment_ID, null);
							if (payment.get_ID() != C_Payment_ID) continue;
							Query query = new Query(Env.getCtx(), MAllocationLine.Table_Name, "C_Payment_ID=?", null);
							List<MAllocationLine> list = query.setParameters(payment.get_ID()).list();
							List<Integer> headers = new ArrayList<>();
							for(MAllocationLine al : list) {
								if (!headers.contains(al.getC_AllocationHdr_ID()))
									headers.add(al.getC_AllocationHdr_ID());
								al.deleteEx(true);
							}
							for(Integer i : headers) {
								MAllocationHdr hdr = new MAllocationHdr(Env.getCtx(), i, null);
								hdr.deleteEx(true);
							}
							DB.executeUpdateEx("UPDATE C_Invoice SET C_Payment_ID=NULL WHERE C_Payment_ID=?", new Object[] {payment.get_ID()}, null);
							DB.executeUpdateEx("DELETE FROM Fact_Acct WHERE AD_Table_ID=? AND Record_ID=?", new Object[] {MPayment.Table_ID, payment.get_ID()}, null);
							payment.deleteEx(true);
						}						
					}
				}
				paySelection.deleteEx(true);
			}
			if (line != null && line.get_ID() > 0) {
				line.deleteEx(true);
			}
			if (invoice != null && invoice.get_ID() > 0) {
				Query query = new Query(Env.getCtx(), MAllocationLine.Table_Name, "C_Invoice_ID=?", null);
				List<MAllocationLine> list = query.setParameters(invoice.get_ID()).list();
				List<Integer> headers = new ArrayList<>();
				for(MAllocationLine al : list) {
					if (!headers.contains(al.getC_AllocationHdr_ID()))
						headers.add(al.getC_AllocationHdr_ID());
					al.deleteEx(true);
				}
				for(Integer i : headers) {
					MAllocationHdr hdr = new MAllocationHdr(Env.getCtx(), i, null);
					hdr.deleteEx(true);
				}
				DB.executeUpdateEx("DELETE FROM Fact_Acct WHERE AD_Table_ID=? AND Record_ID=?", new Object[] {MInvoice.Table_ID, invoice.get_ID()}, null);
				invoice.deleteEx(true);
			}
		}
		
	}
	
	private class PaySelectImpl extends PaySelect {
		MiniTableImpl miniTable = null;
		
		protected PaySelectImpl() {
			miniTable = new MiniTableImpl();
			prepareTable(miniTable);
		}
		
		protected BigDecimal getBankBalance() {
			return super.getBankBalance();
		}
		
		protected MPaySelection getPaySelection() {
			return m_ps;
		}
	}
	
	private class PayPrintImpl extends PayPrint {
		protected int getNextDocumentNo() {
			return documentNo != null ? documentNo.intValue() : 0;
		}
		
		protected int getNumberOfPreparePayment() {
			return !Util.isEmpty(noPayments, true) ? Integer.parseInt(noPayments) : 0;
		}
		
		protected Double getPayAmtSum() {
			return sumPayments;
		}
		
		protected int getPrintFormatId() {
			return printFormatId;
		}

		
		@Override
		protected List<File> createCheckDocuments(int startDocumentNo, String paymentRule) throws Exception {
			return super.createCheckDocuments(startDocumentNo, paymentRule);
		}

		@Override
		protected List<File> createRemittanceDocuments() {
			return super.createRemittanceDocuments();
		}

		@Override
		protected boolean getChecks(String PaymentRule, BigDecimal startDocumentNo,
				AtomicReference<ValueNamePair> error, String trxName) {
			return super.getChecks(PaymentRule, startDocumentNo, error, trxName);
		}
		
		protected MPaySelectionCheck[] getSelectionChecks() {
			return m_checks;
		}

		@Override
		public void loadPaySelectInfo(int C_PaySelection_ID) {
			m_C_PaySelection_ID = C_PaySelection_ID;
			super.loadPaySelectInfo(C_PaySelection_ID);
		}
	}
}
