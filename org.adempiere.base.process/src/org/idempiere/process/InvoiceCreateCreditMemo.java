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
 * - Carlos Ruiz                                                       *
 **********************************************************************/
package org.idempiere.process;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MAllocationHdr;
import org.compiere.model.MAllocationLine;
import org.compiere.model.MDocType;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MPeriod;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 *	IDEMPIERE-918 Generate credit memo from invoice
 * 	@author 	Carlos Ruiz - globalqss
 */
@org.adempiere.base.annotation.Process
public class InvoiceCreateCreditMemo extends SvrProcess {
	/* The document type for the credit memo */
	private int p_C_DocType_ID = 0;
	/* Invoice Date */
	private Timestamp p_DateInvoiced = null;
	/* Accounting Date */
	private Timestamp p_DateAcct = null;
	/* Document Action */
	private String p_DocAction = null;
	/* Create allocation between the invoice and the credit memo */
	private boolean p_IsCreateAllocation = false;
	/* The invoice being credited */
	private MInvoice  invoice = null;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "C_DocType_ID":
				p_C_DocType_ID = para.getParameterAsInt();
				break;
			case "DateInvoiced":
				p_DateInvoiced = para.getParameterAsTimestamp();
				break;
			case "DateAcct":
				p_DateAcct = para.getParameterAsTimestamp();
				break;
			case "DocAction":
				p_DocAction = para.getParameterAsString();
				break;
			case "IsCreateAllocation":
				p_IsCreateAllocation = para.getParameterAsBoolean();
				break;
			default:
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
			}
		}
		invoice = new MInvoice(getCtx(), getRecord_ID(), get_TrxName());
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws Exception {
		if (log.isLoggable(Level.INFO)) log.info("C_Invoice_ID" + invoice.getC_Invoice_ID() + ", C_DocType_ID=" + p_C_DocType_ID + ", DateInvoiced=" + p_DateInvoiced
				+ ", DateAcct=" + p_DateAcct + ", DocAction=" + p_DocAction);

		if (p_IsCreateAllocation) {
			// validate - cannot create allocation if the invoice is already paid or partially paid
			MAllocationHdr[] allocs = MAllocationHdr.getOfInvoice(getCtx(), invoice.getC_Invoice_ID(), get_TrxName());
			if (allocs.length > 0) {
				throw new AdempiereException(Msg.getMsg(getCtx(), "InvoiceHasAllocations"));
			}
		}
		// validate just for invoices, not for credit memos
		if (invoice.isCreditMemo()) {
			throw new AdempiereException(Msg.getMsg(getCtx(), "CannotCreateCreditMemoFromCreditMemo"));
		}
		// Validate if there is already another credit memo for this invoice
		int id = DB.getSQLValueEx(get_TrxName(), "SELECT C_Invoice_ID FROM C_Invoice WHERE RelatedInvoice_ID = ?", invoice.getC_Invoice_ID());

		if (id > 0) {
			MInvoice actualCreditMemo = MInvoice.get(getCtx(), id);
			MDocType dtc = MDocType.get(getCtx(), actualCreditMemo.getC_DocTypeTarget_ID());
			addLog(0, null, null, dtc.getName() + " " + actualCreditMemo.getDocumentNo(), MInvoice.Table_ID, actualCreditMemo.getC_Invoice_ID());
			throw new AdempiereException(Msg.getMsg(getCtx(), "CreditMemoAlreadyExists"));
		}

		MInvoice creditMemo = credit();
		if (creditMemo != null) {
			MDocType dtc = MDocType.get(getCtx(), creditMemo.getC_DocTypeTarget_ID());
			addLog(0, null, null, dtc.getName() + " " + creditMemo.getDocumentNo(), MInvoice.Table_ID, creditMemo.getC_Invoice_ID());
		}

		return "@OK@";
	}	//	doIt

	private MInvoice credit() {
		Timestamp creditDate = p_DateAcct;
		Timestamp creditDateInvoiced = p_DateInvoiced;
		MPeriod.testPeriodOpen(getCtx(), creditDate, p_C_DocType_ID, invoice.getAD_Org_ID());

		//	Deep Copy
		MInvoice creditMemo = null;
		creditMemo = MInvoice.copyFrom(invoice, creditDateInvoiced, creditDate, p_C_DocType_ID, invoice.isSOTrx(), false, get_TrxName(), true);
		if (creditMemo == null) {
			throw new AdempiereException("Could not create Credit Memo");
		}

		//	Reverse Line Qty
		MInvoiceLine[] oLines = invoice.getLines(false);
		MInvoiceLine[] rLines = creditMemo.getLines(true);
		if (oLines.length != rLines.length) {
			throw new AdempiereException("Credit Memo created with different number of lines than invoice");
		}
		for (int i = 0; i < rLines.length; i++) {
			MInvoiceLine rLine = rLines[i];
			MInvoiceLine oLine = oLines[i];
			rLine.setQtyEntered(oLine.getQtyEntered());
			rLine.setQtyInvoiced(oLine.getQtyInvoiced());
			rLine.setLineNetAmt(oLine.getLineNetAmt());
			rLine.setTaxAmt(oLine.getTaxAmt());
			rLine.setLineTotalAmt(oLine.getLineTotalAmt());
			rLine.setPriceActual(oLine.getPriceActual());
			rLine.setPriceList(oLine.getPriceList());
			rLine.setPriceLimit(oLine.getPriceLimit());
			rLine.setPriceEntered(oLine.getPriceEntered());
			rLine.setC_UOM_ID(oLine.getC_UOM_ID());
			if (!rLine.save(get_TrxName())) {
				throw new AdempiereException("Could not create credit memo line");
			}
		}
		if (MInvoice.PAYMENTRULE_Cash.equals(creditMemo.getPaymentRule())) {
			creditMemo.setPaymentRule(MInvoice.PAYMENTRULE_OnCredit); // avoid creation of automatic payment
		}
		creditMemo.setC_Order_ID(invoice.getC_Order_ID());
		StringBuilder msgadd = new StringBuilder("{->").append(invoice.getDocumentNo()).append(")");
		creditMemo.addDescription(msgadd.toString());
		creditMemo.setPOReference(invoice.getDocumentNo());
		creditMemo.setRelatedInvoice_ID(invoice.getC_Invoice_ID());
		creditMemo.saveEx(get_TrxName());
		//
		if (p_DocAction != null) {
			if (!creditMemo.processIt(p_DocAction)) {
				throw new AdempiereException(Msg.getMsg(getCtx(), "FailedProcessingDocument") + " - " + creditMemo.getProcessMsg());
			}
			if (p_IsCreateAllocation && DocAction.ACTION_Complete.equals(p_DocAction)) {
				//	Create Allocation
				StringBuilder msgall = new StringBuilder().append(Msg.translate(getCtx(), "C_Invoice_ID")).append(": ").append(invoice.getDocumentNo()).append("/").append(creditMemo.getDocumentNo());
				MAllocationHdr alloc = new MAllocationHdr(getCtx(), false, creditDate,
						invoice.getC_Currency_ID(),
						msgall.toString(),
						get_TrxName());
				alloc.setAD_Org_ID(invoice.getAD_Org_ID());
				alloc.saveEx();
				//	Amount
				BigDecimal gt = invoice.getGrandTotal(true);
				if (!invoice.isSOTrx())
					gt = gt.negate();
				//	Invoice Line
				MAllocationLine aLine = new MAllocationLine (alloc, gt, Env.ZERO, Env.ZERO, Env.ZERO);
				aLine.setC_Invoice_ID(invoice.getC_Invoice_ID());
				aLine.saveEx();
				//	Credit Line
				MAllocationLine cLine = new MAllocationLine (alloc, gt.negate(), Env.ZERO, Env.ZERO, Env.ZERO);
				cLine.setC_Invoice_ID(creditMemo.getC_Invoice_ID());
				cLine.saveEx();
				if (!alloc.processIt(DocAction.ACTION_Complete))
					throw new AdempiereException(Msg.getMsg(getCtx(), "FailedProcessingDocument") + " - " + alloc.getProcessMsg());
				// end added
				alloc.saveEx();
			}
		}

		return creditMemo;
	}

}	//	InvoiceCreateCreditMemo
