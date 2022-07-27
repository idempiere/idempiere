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
package org.compiere.acct;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.exceptions.AverageCostingZeroQtyException;
import org.compiere.model.I_C_Order;
import org.compiere.model.I_C_OrderLine;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCurrency;
import org.compiere.model.MFactAcct;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MOrderLandedCostAllocation;
import org.compiere.model.MTax;
import org.compiere.model.MUOM;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.model.X_M_Cost;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;

/**
 *  Post MatchInv Documents.
 *  <pre>
 *  Table:              M_MatchInv (472)
 *  Document Types:     MXI
 *  </pre>
 *  Update Costing Records
 *  @author Jorg Janke
 *  @version  $Id: Doc_MatchInv.java,v 1.3 2006/07/30 00:53:33 jjanke Exp $
 *
 *  FR [ 1840016 ] Avoid usage of clearing accounts - subject to C_AcctSchema.IsPostIfClearingEqual
 *  Avoid posting if both accounts Not Invoiced Receipts and Inventory Clearing are equal
 *  BF [ 2789949 ] Multicurrency in matching posting
 */
public class Doc_MatchInv extends Doc
{
	/**
	 *  Constructor
	 * 	@param as accounting schema
	 * 	@param rs record
	 * 	@param trxName trx
	 */
	public Doc_MatchInv (MAcctSchema as, ResultSet rs, String trxName)
	{
		super(as, MMatchInv.class, rs, DOCTYPE_MatMatchInv, trxName);
	}   //  Doc_MatchInv

	/**	Tolerance G&L				*/
	private static final BigDecimal	TOLERANCE = BigDecimal.valueOf(0.02);
	
	/** Invoice Line			*/
	private MInvoiceLine	m_invoiceLine = null;
	/** Material Receipt		*/
	private MInOutLine		m_receiptLine = null;

	private ProductCost		m_pc = null;
	private MMatchInv m_matchInv;

	/**
	 *  Load Specific Document Details
	 *  @return error message or null
	 */
	protected String loadDocumentDetails ()
	{
		setC_Currency_ID (Doc.NO_CURRENCY);
		m_matchInv = (MMatchInv)getPO();
		setDateDoc(m_matchInv.getDateTrx());
		setQty (m_matchInv.getQty());
		//	Invoice Info
		int C_InvoiceLine_ID = m_matchInv.getC_InvoiceLine_ID();
		m_invoiceLine = new MInvoiceLine (getCtx(), C_InvoiceLine_ID, getTrxName());
		//		BP for NotInvoicedReceipts
		int C_BPartner_ID = m_invoiceLine.getParent().getC_BPartner_ID();
		setC_BPartner_ID(C_BPartner_ID);
		//
		int M_InOutLine_ID = m_matchInv.getM_InOutLine_ID();
		m_receiptLine = new MInOutLine (getCtx(), M_InOutLine_ID, getTrxName());
		//
		m_pc = new ProductCost (Env.getCtx(),
			getM_Product_ID(), m_matchInv.getM_AttributeSetInstance_ID(), getTrxName());
		m_pc.setQty(getQty());

		return null;
	}   //  loadDocumentDetails


	/**************************************************************************
	 *  Get Source Currency Balance - subtracts line and tax amounts from total - no rounding
	 *  @return Zero (always balanced)
	 */
	public BigDecimal getBalance()
	{
		return Env.ZERO;
	}   //  getBalance


	/**
	 *  Create Facts (the accounting logic) for
	 *  MXI.
	 * 	(single line)
	 *  <pre>
	 *      NotInvoicedReceipts     DR			(Receipt Org)
	 *      InventoryClearing               CR
	 *      InvoicePV               DR      CR  (difference)
	 *  Commitment
	 * 		Expense							CR
	 * 		Offset					DR
	 *  </pre>
	 *  @param as accounting schema
	 *  @return Fact
	 */
	public ArrayList<Fact> createFacts (MAcctSchema as)
	{
		ArrayList<Fact> facts = new ArrayList<Fact>();
		// invoice gain/loss accounting fact line list
		ArrayList<FactLine> invGainLossFactLines = new ArrayList<FactLine>();
		// invoice list
		ArrayList<MInvoice> invList = new ArrayList<MInvoice>();
		// invoice line list
		ArrayList<MInvoiceLine> invLineList = new ArrayList<MInvoiceLine>();
		// C_Invoice_ID and the current M_MatchInv inventory clearing/expense accounting fact lines
		HashMap<Integer, ArrayList<FactLine>> htFactLineInv = new HashMap<Integer, ArrayList<FactLine>>();
		// receipt gain/loss accounting fact line list
		ArrayList<FactLine> mrGainLossFactLines = new ArrayList<FactLine>();
		// NIR accounting fact line list
		ArrayList<FactLine> mrFactLines = new ArrayList<FactLine>();
		
		//  Nothing to do
		if (getM_Product_ID() == 0								//	no Product
			|| getQty().signum() == 0
			|| (m_receiptLine.get_ID() > 0 && m_receiptLine.getMovementQty().signum() == 0))	//	Qty = 0
		{
			if (log.isLoggable(Level.FINE)) log.fine("No Product/Qty - M_Product_ID=" + getM_Product_ID()
				+ ",Qty=" + getQty() + ",InOutQty=" + m_receiptLine.getMovementQty());
			return facts;
		}
		
		if (m_receiptLine.getM_InOutLine_ID() == 0)
		{
			MInvoice m_invoice = new MInvoice(getCtx(),  m_invoiceLine.getC_Invoice_ID(), getTrxName());
			boolean isCreditMemo = m_invoice.isCreditMemo();
			if (!isCreditMemo)
				return facts;
			else
				return createCreditMemoFacts(as);
		}
		
		if (m_receiptLine.getParent().getC_DocType().getDocBaseType().equals(DOCTYPE_MatShipment))
			return createMatShipmentFacts(as);
					
		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID (as.getC_Currency_ID());
		boolean isInterOrg = isInterOrg(as);

		//  NotInvoicedReceipt      DR
		//  From Receipt
		BigDecimal multiplier = getQty()
			.divide(m_receiptLine.getMovementQty(), 12, RoundingMode.HALF_UP);
		FactLine dr = fact.createLine (null,
			getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as),
			as.getC_Currency_ID(), Env.ONE, null);			// updated below
		if (dr == null)
		{
			p_Error = "No Product Costs";
			return null;
		}
		dr.setQty(getQty());
		BigDecimal temp = dr.getAcctBalance();
		//	Set AmtAcctCr/Dr from Receipt (sets also Project)
		if (m_matchInv.isReversal())
		{
			if (!dr.updateReverseLine (MMatchInv.Table_ID, 		//	Amt updated
					m_matchInv.getReversal_ID(), 0, BigDecimal.ONE))
			{
				p_Error = "Failed to create reversal entry";
				return null;
			}
		}
		else
		{
			if (!dr.updateReverseLine (MInOut.Table_ID, 		//	Amt updated
				m_receiptLine.getM_InOut_ID(), m_receiptLine.getM_InOutLine_ID(),
				multiplier))
			{
				p_Error = "Mat.Receipt not posted yet";
				return null;
			}
		}
		if (log.isLoggable(Level.FINE)) log.fine("CR - Amt(" + temp + "->" + dr.getAcctBalance()
			+ ") - " + dr.toString());

		//  InventoryClearing               CR
		//  From Invoice
		MAccount expense = m_pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
		if (m_pc.isService())
			expense = m_pc.getAccount(ProductCost.ACCTTYPE_P_Expense, as);
		BigDecimal LineNetAmt = m_invoiceLine.getLineNetAmt();
		multiplier = getQty()
			.divide(m_invoiceLine.getQtyInvoiced(), 12, RoundingMode.HALF_UP);
		if (multiplier.compareTo(Env.ONE) != 0)
			LineNetAmt = LineNetAmt.multiply(multiplier);
		if (m_pc.isService())
			LineNetAmt = dr.getAcctBalance();	//	book out exact receipt amt
		FactLine cr = null;
		if (as.isAccrual())
		{
			cr = fact.createLine (null, expense,
				as.getC_Currency_ID(), null, LineNetAmt);		//	updated below
			if (cr == null)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Line Net Amt=0 - M_Product_ID=" + getM_Product_ID()
					+ ",Qty=" + getQty() + ",InOutQty=" + m_receiptLine.getMovementQty());

				cr = fact.createLine (null, expense, as.getC_Currency_ID(), null, Env.ONE);
				cr.setAmtAcctCr(BigDecimal.ZERO);
				cr.setAmtSourceCr(BigDecimal.ZERO);
			}
			temp = cr.getAcctBalance();
			if (m_matchInv.isReversal())
			{
				if (!cr.updateReverseLine (MMatchInv.Table_ID, 		//	Amt updated
						m_matchInv.getReversal_ID(), 0, BigDecimal.ONE))
				{
					p_Error = "Failed to create reversal entry";
					return null;
				}
			}
			else
			{
				cr.setQty(getQty().negate());

				//	Set AmtAcctCr/Dr from Invoice (sets also Project)
				if (!cr.updateReverseLine (MInvoice.Table_ID, 		//	Amt updated
					m_invoiceLine.getC_Invoice_ID(), m_invoiceLine.getC_InvoiceLine_ID(), multiplier))
				{
					p_Error = "Invoice not posted yet";
					return null;
				}
			}
			if (log.isLoggable(Level.FINE)) log.fine("DR - Amt(" + temp + "->" + cr.getAcctBalance()
				+ ") - " + cr.toString());
		}
		else	//	Cash Acct
		{
			MInvoice invoice = m_invoiceLine.getParent();
			if (as.getC_Currency_ID() != invoice.getC_Currency_ID())
				LineNetAmt = MConversionRate.convert(getCtx(), LineNetAmt,
					invoice.getC_Currency_ID(), as.getC_Currency_ID(),
					invoice.getDateAcct(), invoice.getC_ConversionType_ID(),
					invoice.getAD_Client_ID(), invoice.getAD_Org_ID());
			cr = fact.createLine (null, expense,
				as.getC_Currency_ID(), null, LineNetAmt);
			if (m_matchInv.isReversal())
			{
				if (!cr.updateReverseLine (MMatchInv.Table_ID, 		//	Amt updated
						m_matchInv.getReversal_ID(), 0, BigDecimal.ONE))
				{
					p_Error = "Failed to create reversal entry";
					return null;
				}
			}
			else
			{
				int precision = MUOM.getPrecision(getCtx(), m_invoiceLine.getC_UOM_ID());
				cr.setQty(getQty().multiply(multiplier).negate().setScale(precision, RoundingMode.HALF_UP));
			}
		}
		
		// gain/loss + rounding adjustment
		if (m_receiptLine != null && m_invoiceLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())	//	in foreign currency
		{
			mrFactLines.add(dr);
			p_Error = createReceiptGainLoss(as, fact, getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as), m_receiptLine.getParent(), dr.getAmtSourceDr(), dr.getAmtAcctDr(), mrGainLossFactLines, mrFactLines);
			if (p_Error != null)
				return null;
		}
		// rounding adjustment
		if (!mrFactLines.isEmpty())
		{
			p_Error = createReceiptRoundingCorrection(as, fact, getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as), mrGainLossFactLines, mrFactLines);
			if (p_Error != null)
				return null;
		}
		// gain/loss
		if (m_invoiceLine != null && m_invoiceLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())	//	in foreign currency
		{
			MInvoice invoice = m_invoiceLine.getParent();
			if (!invList.contains(invoice))
				invList.add(invoice);
			if (!invLineList.contains(m_invoiceLine))
				invLineList.add(m_invoiceLine);
			ArrayList<FactLine> factLineList = htFactLineInv.get(invoice.get_ID());
			if (factLineList == null)
				factLineList = new ArrayList<FactLine>();
			factLineList.add(cr);
			htFactLineInv.put(invoice.get_ID(), factLineList);
			p_Error = createInvoiceGainLoss(as, fact, expense, invoice, cr.getAmtSourceCr(), cr.getAmtAcctCr(), invGainLossFactLines, htFactLineInv);
			if (p_Error != null)
				return null;
		}
		// rounding adjustment
		if (!htFactLineInv.isEmpty())
		{
			p_Error = createInvoiceRoundingCorrection(as, fact, expense, invGainLossFactLines, invList, invLineList, htFactLineInv);
			if (p_Error != null)
				return null;
		}
		
		cr.setC_Activity_ID(m_invoiceLine.getC_Activity_ID());
		cr.setC_Campaign_ID(m_invoiceLine.getC_Campaign_ID());
		cr.setC_Project_ID(m_invoiceLine.getC_Project_ID());
		cr.setC_ProjectPhase_ID(m_invoiceLine.getC_ProjectPhase_ID());
		cr.setC_ProjectTask_ID(m_invoiceLine.getC_ProjectTask_ID());
		cr.setC_UOM_ID(m_invoiceLine.getC_UOM_ID());
		cr.setUser1_ID(m_invoiceLine.getUser1_ID());
		cr.setUser2_ID(m_invoiceLine.getUser2_ID());
		if (m_matchInv.isReversal())
		{
			cr.setQty(getQty().negate());
		}

		//AZ Goodwill
		//Desc: Source Not Balanced problem because Currency is Difference - PO=CNY but AP=USD
		//see also Fact.java: checking for isMultiCurrency()
		if (dr.getC_Currency_ID() != cr.getC_Currency_ID())
			setIsMultiCurrency(true);
		//end AZ

		// Avoid usage of clearing accounts
		// If both accounts Not Invoiced Receipts and Inventory Clearing are equal
		// then remove the posting

		MAccount acct_db =  dr.getAccount(); // not_invoiced_receipts
		MAccount acct_cr = cr.getAccount(); // inventory_clearing

		if ((!as.isPostIfClearingEqual()) && acct_db.equals(acct_cr) && (!isInterOrg)) {

			BigDecimal debit = dr.getAmtSourceDr();
			BigDecimal credit = cr.getAmtSourceCr();

			if (debit.compareTo(credit) == 0) {
				fact.remove(dr);
				fact.remove(cr);
			}

		}
		// End Avoid usage of clearing accounts


		//  Invoice Price Variance 	difference
		BigDecimal ipv = cr.getAcctBalance().add(dr.getAcctBalance()).negate();
		processInvoicePriceVariance(as, fact, ipv);
		if (log.isLoggable(Level.FINE)) log.fine("IPV=" + ipv + "; Balance=" + fact.getSourceBalance());

		String error = createMatchInvCostDetail(as);
		if (error != null && error.trim().length() > 0)
		{
			p_Error = error;
			return null;
		}
		//
		facts.add(fact);

		/** Commitment release										****/
		if (as.isAccrual() && as.isCreatePOCommitment())
		{
			fact = Doc_Order.getCommitmentRelease(as, this,
				getQty(), m_invoiceLine.getC_InvoiceLine_ID(), Env.ONE);
			if (fact == null)
				return null;
			facts.add(fact);
		}	//	Commitment

		return facts;
	}   //  createFact


	/**
	 * @param as
	 * @param fact
	 * @param ipv
	 */
	protected void processInvoicePriceVariance(MAcctSchema as, Fact fact,
			BigDecimal ipv) {
		if (ipv.signum() == 0) return;
		
		FactLine pv = fact.createLine(null,
			m_pc.getAccount(ProductCost.ACCTTYPE_P_IPV, as),
			as.getC_Currency_ID(), ipv);
		updateFactLine(pv);
		
		MMatchInv matchInv = (MMatchInv)getPO();
		Trx trx = Trx.get(getTrxName(), false);
		Savepoint savepoint = null;
		boolean zeroQty = false;
		try {
			savepoint = trx.setSavepoint(null);
			
			if (!MCostDetail.createMatchInvoice(as, m_invoiceLine.getAD_Org_ID(),
					m_invoiceLine.getM_Product_ID(), m_invoiceLine.getM_AttributeSetInstance_ID(),
					matchInv.getM_MatchInv_ID(), 0,
					ipv, BigDecimal.ZERO, "Invoice Price Variance", getTrxName())) {
				throw new RuntimeException("Failed to create cost detail record.");
			}				
		} catch (SQLException e) {
			throw new RuntimeException(e.getLocalizedMessage(), e);
		} catch (AverageCostingZeroQtyException e) {
			zeroQty = true;
			try {
				trx.rollback(savepoint);
				savepoint = null;
			} catch (SQLException e1) {
				throw new RuntimeException(e1.getLocalizedMessage(), e1);
			}
		} finally {
			if (savepoint != null) {
				try {
					trx.releaseSavepoint(savepoint);
				} catch (SQLException e) {}
			}
		}
		
		String costingMethod = m_pc.getProduct().getCostingMethod(as);
		MAccount account = m_pc.getAccount(ProductCost.ACCTTYPE_P_Asset, as);
		if (m_pc.isService())
			account = m_pc.getAccount(ProductCost.ACCTTYPE_P_Expense, as);
		if (X_M_Cost.COSTINGMETHOD_AveragePO.equals(costingMethod)) {
			if (zeroQty)
				account = m_pc.getAccount(ProductCost.ACCTTYPE_P_AverageCostVariance, as);
			FactLine line = fact.createLine(null,
					m_pc.getAccount(ProductCost.ACCTTYPE_P_IPV, as),
					as.getC_Currency_ID(), ipv.negate());
			updateFactLine(line);
			line.setQty(getQty().negate());
			
			line = fact.createLine(null, account, as.getC_Currency_ID(), ipv);
			updateFactLine(line);
		} else if (X_M_Cost.COSTINGMETHOD_AverageInvoice.equals(costingMethod) && !zeroQty) {
			FactLine line = fact.createLine(null,
					m_pc.getAccount(ProductCost.ACCTTYPE_P_IPV, as),
					as.getC_Currency_ID(), ipv.negate());
			updateFactLine(line);
			line.setQty(getQty().negate());
			
			line = fact.createLine(null, account, as.getC_Currency_ID(), ipv);
			updateFactLine(line);
		}
	}

	/** Verify if the posting involves two or more organizations
	@return true if there are more than one org involved on the posting
	 */
	private boolean isInterOrg(MAcctSchema as) {
		MAcctSchemaElement elementorg = as.getAcctSchemaElement(MAcctSchemaElement.ELEMENTTYPE_Organization);
		if (elementorg == null || !elementorg.isBalanced()) {
			// no org element or not need to be balanced
			return false;
		}

		// verify if org of receipt line is different from org of invoice line
		if (m_receiptLine != null && m_invoiceLine != null && m_receiptLine.getAD_Org_ID() != m_invoiceLine.getAD_Org_ID())
			return true;

		return false;
	}

	/**
	 * Create cost detail for match invoice
	 * @param as accounting schema
	 * @return error message or null
	 */
	private String createMatchInvCostDetail(MAcctSchema as)
	{
		if (m_invoiceLine != null && m_invoiceLine.get_ID() > 0 
			&& m_receiptLine != null && m_receiptLine.get_ID() > 0)
		{
			MMatchInv matchInv = (MMatchInv)getPO();
			
			BigDecimal LineNetAmt = m_invoiceLine.getLineNetAmt();
			BigDecimal multiplier = getQty()
				.divide(m_invoiceLine.getQtyInvoiced(), 12, RoundingMode.HALF_UP);
			if (multiplier.compareTo(Env.ONE) != 0)
				LineNetAmt = LineNetAmt.multiply(multiplier);
	
			// MZ Goodwill
			// Create Cost Detail Matched Invoice using Total Amount and Total Qty based on InvoiceLine
			MMatchInv[] mInv = MMatchInv.getInvoiceLine(getCtx(), m_invoiceLine.getC_InvoiceLine_ID(), getTrxName());
			BigDecimal tQty = Env.ZERO;
			BigDecimal tAmt = Env.ZERO;
			for (int i = 0 ; i < mInv.length ; i++)
			{
				if (mInv[i].isPosted() && mInv[i].getM_MatchInv_ID() != get_ID() && mInv[i].getM_AttributeSetInstance_ID() == matchInv.getM_AttributeSetInstance_ID())
				{
					tQty = tQty.add(mInv[i].getQty());
					multiplier = mInv[i].getQty()
						.divide(m_invoiceLine.getQtyInvoiced(), 12, RoundingMode.HALF_UP);
					tAmt = tAmt.add(m_invoiceLine.getLineNetAmt().multiply(multiplier));
				}
			}
			tAmt = tAmt.add(LineNetAmt); //Invoice Price
			// adjust for tax
			MTax tax = MTax.get(getCtx(), m_invoiceLine.getC_Tax_ID());
			int stdPrecision = MCurrency.getStdPrecision(getCtx(), m_invoiceLine.getParent().getC_Currency_ID());
			if (m_invoiceLine.isTaxIncluded())
			{
				BigDecimal tAmtTax = tax.calculateTax(tAmt, true, stdPrecision);
				if (tax.isSummary())
				{
					tAmt = tAmt.subtract(tAmtTax);
					BigDecimal base = tAmt;
					for (MTax childTax : tax.getChildTaxes(false)) 
					{
						if (!childTax.isZeroTax())
						{
							if (childTax.isDistributeTaxWithLineItem())
							{
								BigDecimal taxAmt = childTax.calculateTax(base, false, stdPrecision);
								tAmt = tAmt.add(taxAmt);
							}
						}
					}
				}
				else if (!tax.isDistributeTaxWithLineItem())
				{
					tAmt = tAmt.subtract(tAmtTax);
				}
			}
			else
			{
				if (tax.isSummary())
				{
					BigDecimal base = tAmt;
					for (MTax childTax : tax.getChildTaxes(false)) 
					{
						if (!childTax.isZeroTax())
						{
							if (childTax.isDistributeTaxWithLineItem())
							{
								BigDecimal taxAmt = childTax.calculateTax(base, false, stdPrecision);
								tAmt = tAmt.add(taxAmt);
							}
						}
					}
				}
				else if (tax.isDistributeTaxWithLineItem())
				{					
					BigDecimal taxAmt = tax.calculateTax(tAmt, false, stdPrecision);
					tAmt = tAmt.add(taxAmt);
				}
			}
			
			// 	Different currency
			MInvoice invoice = m_invoiceLine.getParent();
			if (as.getC_Currency_ID() != invoice.getC_Currency_ID())
			{
				tAmt = MConversionRate.convert(getCtx(), tAmt, 
					invoice.getC_Currency_ID(), as.getC_Currency_ID(),
					invoice.getDateAcct(), invoice.getC_ConversionType_ID(),
					invoice.getAD_Client_ID(), invoice.getAD_Org_ID());
				if (tAmt == null)
				{
					return "AP Invoice not convertible - " + as.getName();
				}
			}			
			
			// set Qty to negative value when MovementType is Vendor Returns
			MInOut receipt = m_receiptLine.getParent();
			if (receipt.getMovementType().equals(MInOut.MOVEMENTTYPE_VendorReturns))
				tQty = tQty.add(getQty().negate()); //	Qty is set to negative value
			else
				tQty = tQty.add(getQty());
						
			// Set Total Amount and Total Quantity from Matched Invoice 
			if (!MCostDetail.createInvoice(as, getAD_Org_ID(), 
					getM_Product_ID(), matchInv.getM_AttributeSetInstance_ID(),
					m_invoiceLine.getC_InvoiceLine_ID(), 0,		//	No cost element
					tAmt, tQty,	getDescription(), getTrxName()))
			{
				return "Failed to create cost detail record";
			}
			
			Map<Integer, BigDecimal> landedCostMap = new LinkedHashMap<Integer, BigDecimal>();
			I_C_OrderLine orderLine = m_receiptLine.getC_OrderLine();
			if (orderLine == null)
				return "";
			
			int C_OrderLine_ID = orderLine.getC_OrderLine_ID();
			MOrderLandedCostAllocation[] allocations = MOrderLandedCostAllocation.getOfOrderLine(C_OrderLine_ID, getTrxName());
			for(MOrderLandedCostAllocation allocation : allocations) 
			{
				BigDecimal totalAmt = allocation.getAmt();
				BigDecimal totalQty = allocation.getQty();
				BigDecimal amt = totalAmt.multiply(tQty).divide(totalQty, 12, RoundingMode.HALF_UP);			
				if (orderLine.getC_Currency_ID() != as.getC_Currency_ID())
				{
					I_C_Order order = orderLine.getC_Order();
					Timestamp dateAcct = order.getDateAcct();
					BigDecimal rate = MConversionRate.getRate(
						order.getC_Currency_ID(), as.getC_Currency_ID(),
						dateAcct, order.getC_ConversionType_ID(),
						order.getAD_Client_ID(), order.getAD_Org_ID());
					if (rate == null)
					{
						p_Error = "Purchase Order not convertible - " + as.getName();
						return null;
					}
					amt = amt.multiply(rate);
					if (amt.scale() > as.getCostingPrecision())
						amt = amt.setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);
				}
				int elementId = allocation.getC_OrderLandedCost().getM_CostElement_ID();
				BigDecimal elementAmt = landedCostMap.get(elementId);
				if (elementAmt == null) 
				{
					elementAmt = amt;								
				}
				else
				{
					elementAmt = elementAmt.add(amt);
				}
				landedCostMap.put(elementId, elementAmt);
			}
			
			for(Integer elementId : landedCostMap.keySet())
			{
				BigDecimal amt = landedCostMap.get(elementId);
				if (!MCostDetail.createShipment(as, getAD_Org_ID(), 
					getM_Product_ID(), matchInv.getM_AttributeSetInstance_ID(),
					m_receiptLine.getM_InOutLine_ID(), elementId,
					amt, tQty,	getDescription(), false, getTrxName()))
				{
					return "Failed to create cost detail record";
				}
			}
			// end MZ
		}
		
		return "";
	}
	
	/**
	 * Create Facts for material shipment
	 * @param as accounting schema
	 * @return Fact
	 */
	private ArrayList<Fact> createMatShipmentFacts(MAcctSchema as) {
		ArrayList<Fact> facts = new ArrayList<Fact>();
		// invoice gain/loss accounting fact line list
		ArrayList<FactLine> invGainLossFactLines = new ArrayList<FactLine>();
		// invoice list
		ArrayList<MInvoice> invList = new ArrayList<MInvoice>();
		// invoice line list
		ArrayList<MInvoiceLine> invLineList = new ArrayList<MInvoiceLine>();
		// C_Invoice_ID and the current M_MatchInv inventory clearing/expense accounting fact lines
		HashMap<Integer, ArrayList<FactLine>> htFactLineInv = new HashMap<Integer, ArrayList<FactLine>>();
		// receipt gain/loss accounting fact line list
		ArrayList<FactLine> mrGainLossFactLines = new ArrayList<FactLine>();
		// NIR accounting fact line list
		ArrayList<FactLine> mrFactLines = new ArrayList<FactLine>();
		
		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID (as.getC_Currency_ID());
		boolean isInterOrg = isInterOrg(as);

		//  NotInvoicedReceipt      DR
		//  From Receipt
		BigDecimal multiplier = getQty()
			.divide(m_receiptLine.getMovementQty(), 12, RoundingMode.HALF_UP);
		multiplier = multiplier.negate();
		FactLine dr = fact.createLine (null,
			getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as),
			as.getC_Currency_ID(), null, Env.ONE);			// updated below
		if (dr == null)
		{
			p_Error = "No Product Costs";
			return null;
		}
		dr.setQty(getQty());
		BigDecimal temp = dr.getAcctBalance();
		//	Set AmtAcctCr/Dr from Receipt (sets also Project)
		if (m_matchInv.isReversal())
		{
			if (!dr.updateReverseLine (MMatchInv.Table_ID, 		//	Amt updated
					m_matchInv.getReversal_ID(), 0, BigDecimal.ONE))
			{
				p_Error = "Failed to create reversal entry";
				return null;
			}
		}
		else
		{
			if (!dr.updateReverseLine (MInOut.Table_ID, 		//	Amt updated
				m_receiptLine.getM_InOut_ID(), m_receiptLine.getM_InOutLine_ID(),
				multiplier))
			{
				p_Error = "Mat.Shipment not posted yet";
				return null;
			}
		}
		if (log.isLoggable(Level.FINE)) log.fine("CR - Amt(" + temp + "->" + dr.getAcctBalance()
			+ ") - " + dr.toString());

		//  InventoryClearing               CR
		//  From Invoice
		MAccount expense = m_pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
		if (m_pc.isService())
			expense = m_pc.getAccount(ProductCost.ACCTTYPE_P_Expense, as);
		BigDecimal LineNetAmt = m_invoiceLine.getLineNetAmt();
		multiplier = getQty()
			.divide(m_invoiceLine.getQtyInvoiced(), 12, RoundingMode.HALF_UP);
		multiplier = multiplier.negate();
		if (multiplier.compareTo(Env.ONE) != 0)
			LineNetAmt = LineNetAmt.multiply(multiplier);
		if (m_pc.isService())
			LineNetAmt = dr.getAcctBalance();	//	book out exact receipt amt
		FactLine cr = null;
		if (as.isAccrual())
		{
			cr = fact.createLine (null, expense,
				as.getC_Currency_ID(), LineNetAmt, null);		//	updated below
			if (cr == null)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Line Net Amt=0 - M_Product_ID=" + getM_Product_ID()
					+ ",Qty=" + getQty() + ",InOutQty=" + m_receiptLine.getMovementQty());

				cr = fact.createLine (null, expense, as.getC_Currency_ID(), Env.ONE, null);
				cr.setAmtAcctCr(BigDecimal.ZERO);
				cr.setAmtSourceCr(BigDecimal.ZERO);
			}
			temp = cr.getAcctBalance();
			if (m_matchInv.isReversal())
			{
				if (!cr.updateReverseLine (MMatchInv.Table_ID, 		//	Amt updated
						m_matchInv.getReversal_ID(), 0, BigDecimal.ONE))
				{
					p_Error = "Failed to create reversal entry";
					return null;
				}
			}
			else
			{
				cr.setQty(getQty().negate());

				//	Set AmtAcctCr/Dr from Invoice (sets also Project)
				if (!cr.updateReverseLine (MInvoice.Table_ID, 		//	Amt updated
					m_invoiceLine.getC_Invoice_ID(), m_invoiceLine.getC_InvoiceLine_ID(), multiplier))
				{
					p_Error = "Invoice not posted yet";
					return null;
				}
			}
			if (log.isLoggable(Level.FINE)) log.fine("DR - Amt(" + temp + "->" + cr.getAcctBalance()
				+ ") - " + cr.toString());
		}
		else	//	Cash Acct
		{
			MInvoice invoice = m_invoiceLine.getParent();
			if (as.getC_Currency_ID() != invoice.getC_Currency_ID())
				LineNetAmt = MConversionRate.convert(getCtx(), LineNetAmt,
					invoice.getC_Currency_ID(), as.getC_Currency_ID(),
					invoice.getDateAcct(), invoice.getC_ConversionType_ID(),
					invoice.getAD_Client_ID(), invoice.getAD_Org_ID());
			cr = fact.createLine (null, expense,
				as.getC_Currency_ID(), LineNetAmt, null);
			if (m_matchInv.isReversal())
			{
				if (!cr.updateReverseLine (MMatchInv.Table_ID, 		//	Amt updated
						m_matchInv.getReversal_ID(), 0, BigDecimal.ONE))
				{
					p_Error = "Failed to create reversal entry";
					return null;
				}
			}
			else
			{
				int precision = MUOM.getPrecision(getCtx(), m_invoiceLine.getC_UOM_ID());
				cr.setQty(getQty().multiply(multiplier).negate().setScale(precision, RoundingMode.HALF_UP));
			}
		}
		
		// gain/loss + rounding adjustment
		if (m_receiptLine != null && m_invoiceLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())	//	in foreign currency
		{
			mrFactLines.add(dr);
			p_Error = createReceiptGainLoss(as, fact, getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as), m_receiptLine.getParent(), dr.getAmtSourceCr(), dr.getAmtAcctCr(), mrGainLossFactLines, mrFactLines);
			if (p_Error != null)
				return null;
		}
		// rounding adjustment
		if (!mrFactLines.isEmpty())
		{
			p_Error = createReceiptRoundingCorrection(as, fact, getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as), mrGainLossFactLines, mrFactLines);
			if (p_Error != null)
				return null;
		}
		
		// gain/loss
		if (m_invoiceLine != null && m_invoiceLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())	//	in foreign currency
		{
			MInvoice invoice = m_invoiceLine.getParent();
			if (!invList.contains(invoice))
				invList.add(invoice);
			if (!invLineList.contains(m_invoiceLine))
				invLineList.add(m_invoiceLine);
			ArrayList<FactLine> factLineList = htFactLineInv.get(invoice.get_ID());
			if (factLineList == null)
				factLineList = new ArrayList<FactLine>();
			factLineList.add(cr);
			htFactLineInv.put(invoice.get_ID(), factLineList);
			p_Error = createInvoiceGainLoss(as, fact, expense, invoice, cr.getAmtSourceDr(), cr.getAmtAcctDr(), invGainLossFactLines, htFactLineInv);
			if (p_Error != null)
				return null;
		}
		// rounding adjustment
		if (!htFactLineInv.isEmpty())
		{
			p_Error = createInvoiceRoundingCorrection(as, fact, expense, invGainLossFactLines, invList, invLineList, htFactLineInv);
			if (p_Error != null)
				return null;
		}
		
		if (!m_matchInv.isReversal())
		{
			cr.setC_Activity_ID(m_invoiceLine.getC_Activity_ID());
			cr.setC_Campaign_ID(m_invoiceLine.getC_Campaign_ID());
			cr.setC_Project_ID(m_invoiceLine.getC_Project_ID());
			cr.setC_ProjectPhase_ID(m_invoiceLine.getC_ProjectPhase_ID());
			cr.setC_ProjectTask_ID(m_invoiceLine.getC_ProjectTask_ID());
			cr.setC_UOM_ID(m_invoiceLine.getC_UOM_ID());
			cr.setUser1_ID(m_invoiceLine.getUser1_ID());
			cr.setUser2_ID(m_invoiceLine.getUser2_ID());
		}
		else
		{
			updateFactLine(cr);
		}

		//AZ Goodwill
		//Desc: Source Not Balanced problem because Currency is Difference - PO=CNY but AP=USD
		//see also Fact.java: checking for isMultiCurrency()
		if (dr.getC_Currency_ID() != cr.getC_Currency_ID())
			setIsMultiCurrency(true);
		//end AZ

		// Avoid usage of clearing accounts
		// If both accounts Not Invoiced Receipts and Inventory Clearing are equal
		// then remove the posting

		MAccount acct_db =  dr.getAccount(); // not_invoiced_receipts
		MAccount acct_cr = cr.getAccount(); // inventory_clearing

		if ((!as.isPostIfClearingEqual()) && acct_db.equals(acct_cr) && (!isInterOrg)) {

			BigDecimal debit = dr.getAmtSourceDr();
			BigDecimal credit = cr.getAmtSourceCr();

			if (debit.compareTo(credit) == 0) {
				fact.remove(dr);
				fact.remove(cr);
			}

		}
		// End Avoid usage of clearing accounts


		//  Invoice Price Variance 	difference
		BigDecimal ipv = cr.getAcctBalance().add(dr.getAcctBalance()).negate();
		processInvoicePriceVariance(as, fact, ipv);
		if (log.isLoggable(Level.FINE)) log.fine("IPV=" + ipv + "; Balance=" + fact.getSourceBalance());

		String error = createMatchInvCostDetail(as);
		if (error != null && error.trim().length() > 0)
		{
			p_Error = error;
			return null;
		}
		//
		facts.add(fact);

		/** Commitment release										****/
		if (as.isAccrual() && as.isCreatePOCommitment())
		{
			fact = Doc_Order.getCommitmentRelease(as, this,
				getQty(), m_invoiceLine.getC_InvoiceLine_ID(), Env.ONE);
			if (fact == null)
				return null;
			facts.add(fact);
		}	//	Commitment
			
		return facts;
	}
	
	/**
	 * Create Facts for credit memo
	 * @param as accounting schema
	 * @return Fact
	 */
	public ArrayList<Fact> createCreditMemoFacts(MAcctSchema as) {
		ArrayList<Fact> facts = new ArrayList<Fact>();
		// invoice gain/loss accounting fact line list
		ArrayList<FactLine> invGainLossFactLines = new ArrayList<FactLine>();
		// invoice list
		ArrayList<MInvoice> invList = new ArrayList<MInvoice>();
		// invoice line list
		ArrayList<MInvoiceLine> invLineList = new ArrayList<MInvoiceLine>();
		// C_Invoice_ID and the current M_MatchInv inventory clearing/expense accounting fact lines
		HashMap<Integer, ArrayList<FactLine>> htFactLineInv = new HashMap<Integer, ArrayList<FactLine>>();
		
		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID (as.getC_Currency_ID());
		
		MMatchInv refMatchInv = new MMatchInv(getCtx(), m_matchInv.getRef_MatchInv_ID(), getTrxName());
		MInvoiceLine refInvLine = new MInvoiceLine(getCtx(), refMatchInv.getC_InvoiceLine_ID(), getTrxName());

		boolean isInterOrg = false;		
		MAcctSchemaElement elementorg = as.getAcctSchemaElement(MAcctSchemaElement.ELEMENTTYPE_Organization);
		if (elementorg == null || !elementorg.isBalanced()) {
			// no org element or not need to be balanced
			isInterOrg = false;
		}
		// verify if org of receipt line is different from org of invoice line
		if (refInvLine != null && m_invoiceLine != null && refInvLine.getAD_Org_ID() != m_invoiceLine.getAD_Org_ID())
			isInterOrg = true;			
		
		MAccount expense = m_pc.getAccount(ProductCost.ACCTTYPE_P_InventoryClearing, as);
		if (m_pc.isService())
			expense = m_pc.getAccount(ProductCost.ACCTTYPE_P_Expense, as);
		BigDecimal LineNetAmt = refInvLine.getLineNetAmt();
		BigDecimal multiplier = getQty()
			.divide(refInvLine.getQtyInvoiced(), 12, RoundingMode.HALF_UP);
		multiplier = multiplier.negate();
		if (multiplier.compareTo(Env.ONE) != 0)
			LineNetAmt = LineNetAmt.multiply(multiplier);
		FactLine dr = null;
		if (as.isAccrual())
		{
			dr = fact.createLine (null, expense,
				as.getC_Currency_ID(), LineNetAmt, null);		//	updated below
			if (dr == null)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Line Net Amt=0 - M_Product_ID=" + getM_Product_ID()
					+ ",Qty=" + getQty() + ",InOutQty=" + m_receiptLine.getMovementQty());

				dr = fact.createLine (null, expense, as.getC_Currency_ID(), Env.ONE, null);
				dr.setAmtAcctCr(BigDecimal.ZERO);
				dr.setAmtSourceCr(BigDecimal.ZERO);
			}
			BigDecimal temp = dr.getAcctBalance();
			if (m_matchInv.isReversal())
			{
				if (!dr.updateReverseLine (MMatchInv.Table_ID, 		//	Amt updated
						m_matchInv.getReversal_ID(), 0, BigDecimal.ONE))
				{
					p_Error = "Failed to create reversal entry";
					return null;
				}
			}
			else
			{
				dr.setQty(getQty().negate());

				//	Set AmtAcctCr/Dr from Invoice (sets also Project)
				if (!dr.updateReverseLine (MInvoice.Table_ID, 		//	Amt updated
						refInvLine.getC_Invoice_ID(), refInvLine.getC_InvoiceLine_ID(), multiplier))
				{
					p_Error = "Invoice not posted yet";
					return null;
				}
			}
			if (log.isLoggable(Level.FINE)) log.fine("DR - Amt(" + temp + "->" + dr.getAcctBalance()
				+ ") - " + dr.toString());
		}
		else	//	Cash Acct
		{
			MInvoice invoice = refInvLine.getParent();
			if (as.getC_Currency_ID() != invoice.getC_Currency_ID())
				LineNetAmt = MConversionRate.convert(getCtx(), LineNetAmt,
					invoice.getC_Currency_ID(), as.getC_Currency_ID(),
					invoice.getDateAcct(), invoice.getC_ConversionType_ID(),
					invoice.getAD_Client_ID(), invoice.getAD_Org_ID());
			dr = fact.createLine (null, expense,
				as.getC_Currency_ID(), LineNetAmt, null);
			if (m_matchInv.isReversal())
			{
				if (!dr.updateReverseLine (MMatchInv.Table_ID, 		//	Amt updated
						m_matchInv.getReversal_ID(), 0, BigDecimal.ONE))
				{
					p_Error = "Failed to create reversal entry";
					return null;
				}
			}
			else
			{
				int precision = MUOM.getPrecision(getCtx(), m_invoiceLine.getC_UOM_ID());
				dr.setQty(getQty().multiply(multiplier).negate().setScale(precision, RoundingMode.HALF_UP));
			}
		}
		if (!m_matchInv.isReversal())
		{
			dr.setC_Activity_ID(refInvLine.getC_Activity_ID());
			dr.setC_Campaign_ID(refInvLine.getC_Campaign_ID());
			dr.setC_Project_ID(refInvLine.getC_Project_ID());
			dr.setC_ProjectPhase_ID(refInvLine.getC_ProjectPhase_ID());
			dr.setC_ProjectTask_ID(refInvLine.getC_ProjectTask_ID());
			dr.setC_UOM_ID(refInvLine.getC_UOM_ID());
			dr.setUser1_ID(refInvLine.getUser1_ID());
			dr.setUser2_ID(refInvLine.getUser2_ID());
		}
		else
		{
			updateFactLine(dr);
		}
		
		//  InventoryClearing               CR
		//  From Invoice
		LineNetAmt = m_invoiceLine.getLineNetAmt();
		multiplier = getQty()
			.divide(m_invoiceLine.getQtyInvoiced(), 12, RoundingMode.HALF_UP);
		multiplier = multiplier.negate();
		if (multiplier.compareTo(Env.ONE) != 0)
			LineNetAmt = LineNetAmt.multiply(multiplier);
		if (m_pc.isService())
			LineNetAmt = dr.getAcctBalance();	//	book out exact receipt amt
		FactLine cr = null;
		if (as.isAccrual())
		{
			cr = fact.createLine (null, expense,
				as.getC_Currency_ID(), LineNetAmt, null);		//	updated below
			if (cr == null)
			{
				if (log.isLoggable(Level.FINE)) log.fine("Line Net Amt=0 - M_Product_ID=" + getM_Product_ID()
					+ ",Qty=" + getQty() + ",InOutQty=" + m_receiptLine.getMovementQty());

				cr = fact.createLine (null, expense, as.getC_Currency_ID(), Env.ONE, null);
				cr.setAmtAcctCr(BigDecimal.ZERO);
				cr.setAmtSourceCr(BigDecimal.ZERO);
			}
			BigDecimal temp = cr.getAcctBalance();
			if (m_matchInv.isReversal())
			{
				if (!cr.updateReverseLine (MMatchInv.Table_ID, 		//	Amt updated
						m_matchInv.getReversal_ID(), 0, BigDecimal.ONE))
				{
					p_Error = "Failed to create reversal entry";
					return null;
				}
			}
			else
			{
				cr.setQty(getQty().negate());

				//	Set AmtAcctCr/Dr from Invoice (sets also Project)
				if (!cr.updateReverseLine (MInvoice.Table_ID, 		//	Amt updated
					m_invoiceLine.getC_Invoice_ID(), m_invoiceLine.getC_InvoiceLine_ID(), multiplier))
				{
					p_Error = "Invoice not posted yet";
					return null;
				}
			}
			if (log.isLoggable(Level.FINE)) log.fine("DR - Amt(" + temp + "->" + cr.getAcctBalance()
				+ ") - " + cr.toString());
		}
		else	//	Cash Acct
		{
			MInvoice invoice = m_invoiceLine.getParent();
			if (as.getC_Currency_ID() != invoice.getC_Currency_ID())
				LineNetAmt = MConversionRate.convert(getCtx(), LineNetAmt,
					invoice.getC_Currency_ID(), as.getC_Currency_ID(),
					invoice.getDateAcct(), invoice.getC_ConversionType_ID(),
					invoice.getAD_Client_ID(), invoice.getAD_Org_ID());
			cr = fact.createLine (null, expense,
				as.getC_Currency_ID(), LineNetAmt, null);
			if (m_matchInv.isReversal())
			{
				if (!cr.updateReverseLine (MMatchInv.Table_ID, 		//	Amt updated
						m_matchInv.getReversal_ID(), 0, BigDecimal.ONE))
				{
					p_Error = "Failed to create reversal entry";
					return null;
				}
			}
			else
			{
				int precision = MUOM.getPrecision(getCtx(), m_invoiceLine.getC_UOM_ID());
				cr.setQty(getQty().multiply(multiplier).negate().setScale(precision, RoundingMode.HALF_UP));
			}
		}
		
		// gain / loss
		if (refInvLine != null && refInvLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())	//	in foreign currency
		{
			MInvoice invoice = refInvLine.getParent();
			if (!invList.contains(invoice))
				invList.add(invoice);
			if (!invLineList.contains(refInvLine))
				invLineList.add(refInvLine);
			ArrayList<FactLine> factLineList = htFactLineInv.get(invoice.get_ID());
			if (factLineList == null)
				factLineList = new ArrayList<FactLine>();
			factLineList.add(dr);
			htFactLineInv.put(invoice.get_ID(), factLineList);
			p_Error = createInvoiceGainLoss(as, fact, expense, invoice, dr.getAmtSourceCr(), dr.getAmtAcctCr(), invGainLossFactLines, htFactLineInv);
			if (p_Error != null)
				return null;
		}
		if (m_invoiceLine != null && m_invoiceLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())	//	in foreign currency
		{
			MInvoice invoice = m_invoiceLine.getParent();
			if (!invList.contains(invoice))
				invList.add(invoice);
			if (!invLineList.contains(m_invoiceLine))
				invLineList.add(m_invoiceLine);
			ArrayList<FactLine> factLineList = htFactLineInv.get(invoice.get_ID());
			if (factLineList == null)
				factLineList = new ArrayList<FactLine>();
			factLineList.add(cr);
			htFactLineInv.put(invoice.get_ID(), factLineList);
			p_Error = createInvoiceGainLoss(as, fact, expense, invoice, cr.getAmtSourceDr(), cr.getAmtAcctDr(), invGainLossFactLines, htFactLineInv);
			if (p_Error != null)
				return null;
		}
		
		// rounding adjustment
		if (!htFactLineInv.isEmpty())
		{
			p_Error = createInvoiceRoundingCorrection(as, fact, expense, invGainLossFactLines, invList, invLineList, htFactLineInv);
			if (p_Error != null)
				return null;
		}
		
		if (!m_matchInv.isReversal())
		{
			cr.setC_Activity_ID(m_invoiceLine.getC_Activity_ID());
			cr.setC_Campaign_ID(m_invoiceLine.getC_Campaign_ID());
			cr.setC_Project_ID(m_invoiceLine.getC_Project_ID());
			cr.setC_ProjectPhase_ID(m_invoiceLine.getC_ProjectPhase_ID());
			cr.setC_ProjectTask_ID(m_invoiceLine.getC_ProjectTask_ID());
			cr.setC_UOM_ID(m_invoiceLine.getC_UOM_ID());
			cr.setUser1_ID(m_invoiceLine.getUser1_ID());
			cr.setUser2_ID(m_invoiceLine.getUser2_ID());
		}
		else
		{
			updateFactLine(cr);
		}

		//AZ Goodwill
		//Desc: Source Not Balanced problem because Currency is Difference - PO=CNY but AP=USD
		//see also Fact.java: checking for isMultiCurrency()
		if (dr.getC_Currency_ID() != cr.getC_Currency_ID())
			setIsMultiCurrency(true);
		//end AZ

		// Avoid usage of clearing accounts
		// If both accounts are equal
		// then remove the posting

		MAccount acct_db =  dr.getAccount(); // inventory_clearing
		MAccount acct_cr = cr.getAccount(); // inventory_clearing

		if ((!as.isPostIfClearingEqual()) && acct_db.equals(acct_cr) && (!isInterOrg)) {

			BigDecimal debit = dr.getAmtSourceDr();
			BigDecimal credit = cr.getAmtSourceCr();

			if (debit.compareTo(credit) == 0 && (cr.getAcctBalance().add(dr.getAcctBalance())).compareTo(Env.ZERO) == 0) {
				fact.remove(dr);
				fact.remove(cr);
			}

		}
		// End Avoid usage of clearing accounts

		MAccount gain = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedGain_Acct());
		MAccount loss = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
		BigDecimal ipv = cr.getAcctBalance().add(dr.getAcctBalance()).negate();
		if (ipv.compareTo(Env.ZERO) != 0)
		{
			FactLine pv = fact.createLine(null,
				cr.getAcctBalance().abs().compareTo(dr.getAcctBalance().abs()) < 0 ? loss : gain,
				as.getC_Currency_ID(), ipv);
			updateFactLine(pv);
		}

		//
		facts.add(fact);

		/** Commitment release										****/
		if (as.isAccrual() && as.isCreatePOCommitment())
		{
			fact = Doc_Order.getCommitmentRelease(as, this,
				getQty(), m_invoiceLine.getC_InvoiceLine_ID(), Env.ONE);
			if (fact == null)
				return null;
			facts.add(fact);
		}	//	Commitment
		
		return facts;
	}
	
	/**
	 * @param factLine
	 */
	protected void updateFactLine(FactLine factLine) {
		factLine.setC_Activity_ID(m_invoiceLine.getC_Activity_ID());
		factLine.setC_Campaign_ID(m_invoiceLine.getC_Campaign_ID());
		factLine.setC_Project_ID(m_invoiceLine.getC_Project_ID());
		factLine.setC_ProjectPhase_ID(m_invoiceLine.getC_ProjectPhase_ID());
		factLine.setC_ProjectTask_ID(m_invoiceLine.getC_ProjectTask_ID());
		factLine.setC_UOM_ID(m_invoiceLine.getC_UOM_ID());
		factLine.setUser1_ID(m_invoiceLine.getUser1_ID());
		factLine.setUser2_ID(m_invoiceLine.getUser2_ID());
		factLine.setM_Product_ID(m_invoiceLine.getM_Product_ID());
		factLine.setQty(getQty());
	}
	
	/**
	 * Create Gain/Loss for invoice
	 * @param as accounting schema
	 * @param fact
	 * @param acct
	 * @param invoice
	 * @param matchInvSource
	 * @param matchInvAccounted
	 * @param invGainLossFactLines gain/loss fact lines for invoice
	 * @param htFactLineInv C_Invoice_ID and the fact lines
	 * @return error message or null
	 */
	private String createInvoiceGainLoss(MAcctSchema as, Fact fact, MAccount acct, 
			MInvoice invoice, BigDecimal matchInvSource, BigDecimal matchInvAccounted, 
			ArrayList<FactLine> invGainLossFactLines, HashMap<Integer, ArrayList<FactLine>> htFactLineInv)
	{
		if (m_matchInv.isReversal())
			return createReversalInvoiceGainLossRoundingCorrection(as, fact, acct);
		
		BigDecimal invoiceSource = null;
		BigDecimal invoiceAccounted = null;
		//
		StringBuilder sql = new StringBuilder()
			.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
			.append(" FROM Fact_Acct ")
			.append("WHERE AD_Table_ID=? AND Record_ID=?")
			.append(" AND C_AcctSchema_ID=?")
			.append(" AND Account_ID=?")
			.append(" AND PostingType='A'");

		// For Invoice
		List<Object> valuesInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
				MInvoice.Table_ID, invoice.getC_Invoice_ID(), as.getC_AcctSchema_ID(), acct.getAccount_ID());
		if (valuesInv != null) {
			invoiceSource = (BigDecimal) valuesInv.get(0); // AmtSourceDr
			invoiceAccounted = (BigDecimal) valuesInv.get(1); // AmtAcctDr
			if (invoiceSource.signum() == 0 && invoiceAccounted.signum() == 0) {
				invoiceSource = (BigDecimal) valuesInv.get(2); // AmtSourceCr
				invoiceAccounted = (BigDecimal) valuesInv.get(3); // AmtAcctCr
			}
		}
		
		// 	Requires that Invoice is Posted
		if (invoiceSource == null || invoiceAccounted == null)
			return null;
		//
				
		StringBuilder description = new StringBuilder("Invoice=(").append(invoice.getC_Currency_ID()).append(")").append(invoiceSource).append("/").append(invoiceAccounted)
				.append(" - MatchInv=(").append(getC_Currency_ID()).append(")").append(matchInvSource).append("/").append(matchInvAccounted);
			if (log.isLoggable(Level.FINE)) log.fine(description.toString());
		//

		BigDecimal acctDifference = null;
		//	Full MR in currency
		if (matchInvSource.compareTo(invoiceSource) == 0)
		{
			acctDifference = matchInvAccounted.abs().subtract(invoiceAccounted.abs());	//	gain is negative
			StringBuilder d2 = new StringBuilder("(full) = ").append(acctDifference);
			if (log.isLoggable(Level.FINE)) log.fine(d2.toString());
			description.append(" - ").append(d2);
		}

		if (acctDifference == null || acctDifference.signum() == 0)
		{
			log.fine("No Difference");
			return null;
		}
		
		MAccount gain = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedGain_Acct());
		MAccount loss = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
		//
		{
			FactLine fl = fact.createLine (null, acct, as.getC_Currency_ID(), acctDifference);
			fl.setDescription(description.toString());
			updateFactLine(fl);
			ArrayList<FactLine> factLineList = htFactLineInv.get(invoice.get_ID());
			if (factLineList == null)
				factLineList = new ArrayList<FactLine>();
			factLineList.add(fl);
			
			fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), acctDifference.negate());
			fl.setDescription(description.toString());
			updateFactLine(fl);
			invGainLossFactLines.add(fl);
			factLineList.add(fl);
			htFactLineInv.put(invoice.get_ID(), factLineList);
		}
		return null;
	}	//	createInvoiceGainLoss
	
	/**
	 * Create Gain/Loss and Rounding Correction for reverse invoice 
	 * @param as accounting schema
	 * @param fact
	 * @param acct
	 * @return error message or null
	 */
	private String createReversalInvoiceGainLossRoundingCorrection(MAcctSchema as, Fact fact, MAccount acct)
	{
		if (!m_matchInv.isReversal())
			return null;
		
		MAccount gain = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedGain_Acct());
		MAccount loss = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
		
		StringBuilder whereClause = new StringBuilder()
				.append("AD_Table_ID=?")
				.append(" AND Record_ID=?")
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND PostingType='A'")
				.append(" AND (Account_ID=? OR Account_ID=? OR Account_ID=? OR Account_ID=?)")
				.append(" AND Description LIKE 'Invoice%'");
		
		List<MFactAcct> list = new Query(getCtx(), MFactAcct.Table_Name, whereClause.toString(), getTrxName())
				.setParameters(MMatchInv.Table_ID, m_matchInv.getReversal_ID(), as.getC_AcctSchema_ID(), 
						acct.getAccount_ID(), gain.getAccount_ID(), loss.getAccount_ID(), as.getCurrencyBalancing_Acct().getAccount_ID())
				.setOrderBy(MFactAcct.COLUMNNAME_Fact_Acct_ID)
				.list();
		for (MFactAcct fa : list) {
			FactLine fl = fact.createLine(null, fa.getMAccount(), fa.getC_Currency_ID(), fa.getAmtAcctCr(), fa.getAmtAcctDr());
			fl.setDescription(fa.getDescription());
			updateFactLine(fl);
		}
		
		return null;
	}
	
	/**
	 * Create Rounding Correction for invoice
	 * @param as accounting schema
	 * @param fact
	 * @param acct
	 * @param invGainLossFactLines gain/loss fact lines for invoice
	 * @param invList invoice list
	 * @param invLineList invoice line list
	 * @param htFactLineInv C_Invoice_ID and the fact lines
	 * @return error message or null
	 */
	private String createInvoiceRoundingCorrection(MAcctSchema as, Fact fact, MAccount acct, 
			ArrayList<FactLine> invGainLossFactLines, ArrayList<MInvoice> invList, ArrayList<MInvoiceLine> invLineList,
			HashMap<Integer, ArrayList<FactLine>> htFactLineInv) 
	{
		if (m_matchInv.isReversal())
			return null;
		
		HashMap<Integer, ArrayList<FactLine>> htRoundingLineInvLine = new HashMap<Integer, ArrayList<FactLine>>();
		ArrayList<FactLine> invLineRoundingLines = new ArrayList<FactLine>();
		boolean isLineFullyMatched = createInvoiceLineRoundingCorrection(as, fact, acct, invGainLossFactLines, invList, invLineList, htFactLineInv, invLineRoundingLines, htRoundingLineInvLine);
		
		if (!isLineFullyMatched)
			return null;
		
		BigDecimal totalInvClrAccounted = Env.ZERO;
		for (FactLine invLineRoundingLine : invLineRoundingLines)
		{
			if (invLineRoundingLine.getAccount() == acct)
				totalInvClrAccounted = totalInvClrAccounted.add(invLineRoundingLine.getAmtAcctDr()).subtract(invLineRoundingLine.getAmtAcctCr());
		}
		
		StringBuilder sqlInv = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr)-SUM(AmtSourceCr), SUM(AmtAcctDr)-SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID=?")
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND Account_ID=?")
				.append(" AND PostingType='A'");
		
		// C_Invoice_ID and the total source amount from C_Invoice accounting fact lines
		HashMap<Integer, BigDecimal> htInvSource = new HashMap<Integer, BigDecimal>();
		// C_Invoice_ID and the total accounted amount from C_Invoice accounting fact lines
		HashMap<Integer, BigDecimal> htInvAccounted = new HashMap<Integer, BigDecimal>();
		for (MInvoice invoice : invList)
		{
			BigDecimal invoiceSource = Env.ZERO;
			BigDecimal invoiceAccounted = Env.ZERO;
			
			// For Invoice
			List<Object> valuesInv = DB.getSQLValueObjectsEx(getTrxName(), sqlInv.toString(),
					MInvoice.Table_ID, invoice.getC_Invoice_ID(), as.getC_AcctSchema_ID(), acct.getAccount_ID());
			if (valuesInv != null) {
				BigDecimal invoiceSourceDrCr = (BigDecimal) valuesInv.get(0); // AmtSource
				BigDecimal invoiceAccountedDrCr = (BigDecimal) valuesInv.get(1); // AmtAcct
				
				invoiceSource = invoiceSource.add(invoiceSourceDrCr);
				invoiceAccounted = invoiceAccounted.add(invoiceAccountedDrCr);
				
				totalInvClrAccounted = totalInvClrAccounted.add(invoiceAccountedDrCr);
			}
			
			// Currency Balancing
			valuesInv = DB.getSQLValueObjectsEx(getTrxName(), sqlInv.toString(),
					MInvoice.Table_ID, invoice.getC_Invoice_ID(), as.getC_AcctSchema_ID(), as.getCurrencyBalancing_Acct().getAccount_ID());
			if (valuesInv != null) {
				BigDecimal invoiceSourceDrCr = (BigDecimal) valuesInv.get(0); // AmtSource
				BigDecimal invoiceAccountedDrCr = (BigDecimal) valuesInv.get(1); // AmtAcct
				
				if (invoiceSourceDrCr == null)
					invoiceSourceDrCr = Env.ZERO;
				if (invoiceAccountedDrCr == null)
					invoiceAccountedDrCr = Env.ZERO;
				
				invoiceSource = invoiceSource.add(invoiceSourceDrCr);
				invoiceAccounted = invoiceAccounted.add(invoiceAccountedDrCr);
			}
			
			htInvSource.put(invoice.getC_Invoice_ID(), invoiceSource.abs());
			htInvAccounted.put(invoice.getC_Invoice_ID(), invoiceAccounted.abs());
		}
		
		MAccount gain = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedGain_Acct());
		MAccount loss = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
		
		// C_Invoice_ID and the total source DR amount from the current M_MatchInv accounting fact lines
		HashMap<Integer, BigDecimal> htTotalAmtSourceDr = new HashMap<Integer, BigDecimal>();
		// C_Invoice_ID and the total accounted DR amount from the current M_MatchInv accounting fact lines
		HashMap<Integer, BigDecimal> htTotalAmtAcctDr = new HashMap<Integer, BigDecimal>();
		// C_Invoice_ID and the total source CR amount from the current M_MatchInv accounting fact lines
		HashMap<Integer, BigDecimal> htTotalAmtSourceCr = new HashMap<Integer, BigDecimal>();
		// C_Invoice_ID and the total accounted CR amount from the current M_MatchInv accounting fact lines
		HashMap<Integer, BigDecimal> htTotalAmtAcctCr = new HashMap<Integer, BigDecimal>();
		for (Integer C_Invoice_ID : htFactLineInv.keySet())
		{
			ArrayList<FactLine> factLineList = htFactLineInv.get(C_Invoice_ID);
			for (FactLine factLine : factLineList)
			{
				if (factLine.getAccount_ID() == acct.getAccount_ID())
				{
					BigDecimal totalAmtSourceDr = htTotalAmtSourceDr.get(C_Invoice_ID);
					if (totalAmtSourceDr == null)
						totalAmtSourceDr = Env.ZERO;
					BigDecimal totalAmtAcctDr = htTotalAmtAcctDr.get(C_Invoice_ID);
					if (totalAmtAcctDr == null)
						totalAmtAcctDr = Env.ZERO;
					BigDecimal totalAmtSourceCr = htTotalAmtSourceCr.get(C_Invoice_ID);
					if (totalAmtSourceCr == null)
						totalAmtSourceCr = Env.ZERO;
					BigDecimal totalAmtAcctCr = htTotalAmtAcctCr.get(C_Invoice_ID);
					if (totalAmtAcctCr == null)
						totalAmtAcctCr = Env.ZERO;
					
					totalAmtSourceDr = totalAmtSourceDr.add(factLine.getAmtSourceDr());
					totalAmtAcctDr = totalAmtAcctDr.add(factLine.getAmtAcctDr());
					totalAmtSourceCr = totalAmtSourceCr.add(factLine.getAmtSourceCr());
					totalAmtAcctCr = totalAmtAcctCr.add(factLine.getAmtAcctCr());
					
					htTotalAmtSourceDr.put(C_Invoice_ID, totalAmtSourceDr);
					htTotalAmtAcctDr.put(C_Invoice_ID, totalAmtAcctDr);
					htTotalAmtSourceCr.put(C_Invoice_ID, totalAmtSourceCr);
					htTotalAmtAcctCr.put(C_Invoice_ID, totalAmtAcctCr);
					
					totalInvClrAccounted = totalInvClrAccounted.add(factLine.getAmtAcctDr()).subtract(factLine.getAmtAcctCr());
				}
				else if (factLine.getAccount_ID() == gain.getAccount_ID() || factLine.getAccount_ID() == loss.getAccount_ID())
				{
					if (!invGainLossFactLines.contains(factLine))
						continue;
					
					BigDecimal totalAmtSourceDr = htTotalAmtSourceDr.get(C_Invoice_ID);
					if (totalAmtSourceDr == null)
						totalAmtSourceDr = Env.ZERO;
					BigDecimal totalAmtAcctDr = htTotalAmtAcctDr.get(C_Invoice_ID);
					if (totalAmtAcctDr == null)
						totalAmtAcctDr = Env.ZERO;
					BigDecimal totalAmtSourceCr = htTotalAmtSourceCr.get(C_Invoice_ID);
					if (totalAmtSourceCr == null)
						totalAmtSourceCr = Env.ZERO;
					BigDecimal totalAmtAcctCr = htTotalAmtAcctCr.get(C_Invoice_ID);
					if (totalAmtAcctCr == null)
						totalAmtAcctCr = Env.ZERO;

					totalAmtSourceDr = totalAmtSourceDr.add(factLine.getAmtSourceDr());
					totalAmtSourceCr = totalAmtSourceCr.add(factLine.getAmtSourceCr());
					
					htTotalAmtSourceDr.put(C_Invoice_ID, totalAmtSourceDr);
					htTotalAmtAcctDr.put(C_Invoice_ID, totalAmtAcctDr);
					htTotalAmtSourceCr.put(C_Invoice_ID, totalAmtSourceCr);
					htTotalAmtAcctCr.put(C_Invoice_ID, totalAmtAcctCr);
				}
			}
		}
		
		// C_Invoice_ID and the total source amount from M_MatchInv accounting fact lines
		HashMap<Integer, BigDecimal> htMatchInvSource = new HashMap<Integer, BigDecimal>();
		// C_Invoice_ID and the total accounted amount from M_MatchInv accounting fact lines
		HashMap<Integer, BigDecimal> htMatchInvAccounted = new HashMap<Integer, BigDecimal>();
		// C_Invoice_ID and the total source amount from M_MatchInv accounting fact lines
		HashMap<Integer, BigDecimal> htMatchInvAcctDiff = new HashMap<Integer, BigDecimal>();
		for (MInvoice invoice : invList)
		{
			BigDecimal matchInvSource = Env.ZERO;
			BigDecimal matchInvAccounted = Env.ZERO;

			BigDecimal totalAmtSourceDr = htTotalAmtSourceDr.get(invoice.getC_Invoice_ID());
			if (totalAmtSourceDr == null)
				totalAmtSourceDr = Env.ZERO;
			BigDecimal totalAmtAcctDr = htTotalAmtAcctDr.get(invoice.getC_Invoice_ID());
			if (totalAmtAcctDr == null)
				totalAmtAcctDr = Env.ZERO;
			BigDecimal totalAmtSourceCr = htTotalAmtSourceCr.get(invoice.getC_Invoice_ID());
			if (totalAmtSourceCr == null)
				totalAmtSourceCr = Env.ZERO;
			BigDecimal totalAmtAcctCr = htTotalAmtAcctCr.get(invoice.getC_Invoice_ID());
			if (totalAmtAcctCr == null)
				totalAmtAcctCr = Env.ZERO;
		
			matchInvSource = matchInvSource.add(totalAmtSourceDr).subtract(totalAmtSourceCr);
			matchInvAccounted = matchInvAccounted.add(totalAmtAcctDr).subtract(totalAmtAcctCr);
			
			for (FactLine invLineRoundingLine : invLineRoundingLines)
			{
				if (invLineRoundingLine.getAccount() == acct)
				{
					ArrayList<FactLine> roundingLineList = htRoundingLineInvLine.get(invoice.get_ID());
					if (roundingLineList == null || !roundingLineList.contains(invLineRoundingLine))
						continue;
					matchInvAccounted = matchInvAccounted.add(invLineRoundingLine.getAmtAcctDr()).subtract(invLineRoundingLine.getAmtAcctCr());
				}
			}
			
			{
				MMatchInv[] matchInvs = MMatchInv.getInvoice(getCtx(), invoice.get_ID(), getTrxName());
				
				ArrayList<Integer> skipMatchInvIdList = new ArrayList<Integer>();
				skipMatchInvIdList.add(m_matchInv.get_ID());
				for (MMatchInv matchInv : matchInvs)
				{
					if (matchInv.isReversal())
						skipMatchInvIdList.add(matchInv.get_ID());
				}
				
				for (MMatchInv matchInv : matchInvs)
				{
					if (matchInv.get_ID() == m_matchInv.get_ID())
						continue;
					
					if (skipMatchInvIdList.contains(matchInv.get_ID()))
						continue;
					
					StringBuilder sql = new StringBuilder()
						.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
						.append(" FROM Fact_Acct ")
						.append("WHERE AD_Table_ID=? AND (Record_ID=? OR Record_ID=?)")	//	match inv
						.append(" AND C_AcctSchema_ID=?")
						.append(" AND PostingType='A'")
						.append(" AND Account_ID=?");
					
					if (m_matchInv.isReversal())
					{
						if (matchInv.isReversal())
							sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
						sql.append(" AND Record_ID < ").append(m_matchInv.getReversal_ID());
					}
					else
					{
						if (matchInv.getReversal_ID() > 0)
							sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
					}
					
					if (matchInv.getRef_MatchInv_ID() > 0)
					{
						if (invoice.isCreditMemo() && matchInv.getQty().compareTo(BigDecimal.ZERO) < 0)
							sql.append(" AND Qty > 0");
						else
							sql.append(" AND Qty < 0");
					}
					
					// For Match Inv
					List<Object> valuesMatchInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
							MMatchInv.Table_ID, matchInv.get_ID(), matchInv.getRef_MatchInv_ID() > 0 ? matchInv.getRef_MatchInv_ID() : -1, as.getC_AcctSchema_ID(), acct.getAccount_ID());
					if (valuesMatchInv != null) {
						totalAmtSourceDr = (BigDecimal) valuesMatchInv.get(0);
						if (totalAmtSourceDr == null)
							totalAmtSourceDr = Env.ZERO;
						totalAmtAcctDr = (BigDecimal) valuesMatchInv.get(1);
						if (totalAmtAcctDr == null)
							totalAmtAcctDr = Env.ZERO;
						totalAmtSourceCr = (BigDecimal) valuesMatchInv.get(2);
						if (totalAmtSourceCr == null)
							totalAmtSourceCr = Env.ZERO;
						totalAmtAcctCr = (BigDecimal) valuesMatchInv.get(3);
						if (totalAmtAcctCr == null)
							totalAmtAcctCr = Env.ZERO;
						
						matchInvSource = matchInvSource.add(totalAmtSourceDr).subtract(totalAmtSourceCr);
						matchInvAccounted = matchInvAccounted.add(totalAmtAcctDr).subtract(totalAmtAcctCr);
						
						totalInvClrAccounted = totalInvClrAccounted.add(totalAmtAcctDr).subtract(totalAmtAcctCr);
					}
					
					sql = new StringBuilder()
						.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
						.append(" FROM Fact_Acct ")
						.append("WHERE AD_Table_ID=? AND (Record_ID=? OR Record_ID=?)")	//	match inv
						.append(" AND C_AcctSchema_ID=?")
						.append(" AND PostingType='A'")
						.append(" AND (Account_ID=? OR Account_ID=? OR Account_ID=?)")
						.append(" AND Description LIKE 'Invoice%'");
					
					if (m_matchInv.isReversal())
					{
						if (matchInv.isReversal())
							sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
						sql.append(" AND Record_ID < ").append(m_matchInv.getReversal_ID());
					}
					else
					{
						if (matchInv.getReversal_ID() > 0)
							sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
					}
					
					if (matchInv.getRef_MatchInv_ID() > 0)
					{
						if (invoice.isCreditMemo() && matchInv.getQty().compareTo(BigDecimal.ZERO) < 0)
							sql.append(" AND Qty > 0");
						else
							sql.append(" AND Qty < 0");
					}
					
					// For Match Inv
					valuesMatchInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
							MMatchInv.Table_ID, matchInv.get_ID(), matchInv.getRef_MatchInv_ID() > 0 ? matchInv.getRef_MatchInv_ID() : -1, as.getC_AcctSchema_ID(), 
							gain.getAccount_ID(), loss.getAccount_ID(), as.getCurrencyBalancing_Acct().getAccount_ID());
					if (valuesMatchInv != null) {
						totalAmtSourceDr = (BigDecimal) valuesMatchInv.get(0);
						if (totalAmtSourceDr == null)
							totalAmtSourceDr = Env.ZERO;
						totalAmtAcctDr = (BigDecimal) valuesMatchInv.get(1);
						if (totalAmtAcctDr == null)
							totalAmtAcctDr = Env.ZERO;
						totalAmtSourceCr = (BigDecimal) valuesMatchInv.get(2);
						if (totalAmtSourceCr == null)
							totalAmtSourceCr = Env.ZERO;
						totalAmtAcctCr = (BigDecimal) valuesMatchInv.get(3);
						if (totalAmtAcctCr == null)
							totalAmtAcctCr = Env.ZERO;

						matchInvSource = matchInvSource.add(totalAmtSourceDr).subtract(totalAmtSourceCr);
					}
				}
				
				htMatchInvSource.put(invoice.getC_Invoice_ID(), matchInvSource);
				htMatchInvAccounted.put(invoice.getC_Invoice_ID(), matchInvAccounted);
			}
		}
		
		ArrayList<FactLine> invRoundingLines = new ArrayList<FactLine>();
		for (MInvoice invoice : invList)
		{
			BigDecimal invSource = htInvSource.get(invoice.getC_Invoice_ID());
			if (invSource == null)
				invSource = Env.ZERO;
			BigDecimal invAccounted = htInvAccounted.get(invoice.getC_Invoice_ID());
			if (invAccounted == null)
				invAccounted = Env.ZERO;
			BigDecimal matchInvSource = htMatchInvSource.get(invoice.getC_Invoice_ID());
			if (matchInvSource == null)
				matchInvSource = Env.ZERO;
			BigDecimal matchInvAccounted = htMatchInvAccounted.get(invoice.getC_Invoice_ID());
			if (matchInvAccounted == null)
				matchInvAccounted = Env.ZERO;
			BigDecimal acctDifference = htMatchInvAcctDiff.get(invoice.getC_Invoice_ID());
			
			StringBuilder description = new StringBuilder("Invoice=(").append(getC_Currency_ID()).append(")").append(invSource).append("/").append(invAccounted)
					.append(" - Match Invoice=(").append(getC_Currency_ID()).append(")").append(matchInvSource).append("/").append(matchInvAccounted);
			if (log.isLoggable(Level.FINE)) log.fine(description.toString());
			if (acctDifference == null && matchInvSource.abs().compareTo(invSource.abs()) == 0)
			{
				acctDifference = invAccounted.abs().subtract(matchInvAccounted.abs());	//	gain is negative
				StringBuilder d2 = new StringBuilder("(full) = ").append(acctDifference);
				if (log.isLoggable(Level.FINE)) log.fine(d2.toString());
				description.append(" - ").append(d2);
			}
			else
				isLineFullyMatched = false;
			
			if (acctDifference == null || acctDifference.signum() == 0)
			{
				log.fine("No Difference");
				continue;
			}
			
			if (acctDifference.abs().compareTo(TOLERANCE) >= 0)
			{
				log.fine("acctDifference="+acctDifference);
				continue;
			}
			
			//
			{
				FactLine fl = fact.createLine (null, acct, as.getC_Currency_ID(), acctDifference.negate());
				fl.setDescription(description.toString());
				updateFactLine(fl);
				invRoundingLines.add(fl);
				
				totalInvClrAccounted = totalInvClrAccounted.add(fl.getAmtAcctDr()).subtract(fl.getAmtAcctCr());
				
				if (as.isCurrencyBalancing() && as.getC_Currency_ID() != invoice.getC_Currency_ID())
					fl = fact.createLine (null, as.getCurrencyBalancing_Acct(), as.getC_Currency_ID(), acctDifference);
				else
					fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), acctDifference);
				fl.setDescription(description.toString());
				updateFactLine(fl);
				invRoundingLines.add(fl);
			}
		}
		
		if (isLineFullyMatched) {
			if (totalInvClrAccounted != null && totalInvClrAccounted.signum() != 0 && totalInvClrAccounted.abs().compareTo(TOLERANCE) < 0)
			{
				BigDecimal totalRounding = Env.ZERO;
				for (FactLine invRoundingLine : invRoundingLines)
				{
					if (invRoundingLine.getAccount() == acct)
						totalRounding = totalRounding.add(invRoundingLine.getAmtAcctDr()).subtract(invRoundingLine.getAmtAcctCr());
				}
				
				if (totalRounding.compareTo(totalInvClrAccounted) == 0)
				{
					for (FactLine invRoundingLine : invRoundingLines)
					{
						fact.remove(invRoundingLine);
					}
					totalInvClrAccounted = Env.ZERO;
				}
			}

			if (totalInvClrAccounted != null && totalInvClrAccounted.signum() != 0 && totalInvClrAccounted.abs().compareTo(TOLERANCE) < 0)
			{
				StringBuilder description = new StringBuilder("Invoice - MatchInv - (full) = ").append(totalInvClrAccounted);
				if (log.isLoggable(Level.FINE)) log.fine(description.toString());
				
				FactLine fl = fact.createLine (null, acct, as.getC_Currency_ID(), totalInvClrAccounted.negate());
				fl.setDescription(description.toString());
				updateFactLine(fl);
				
				if (as.isCurrencyBalancing())
					fl = fact.createLine (null, as.getCurrencyBalancing_Acct(), as.getC_Currency_ID(), totalInvClrAccounted);
				else
					fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), totalInvClrAccounted);
				fl.setDescription(description.toString());
				updateFactLine(fl);
			}
		}
		
		return null;
	}
	
	/**
	 * Create Rounding Correction for invoice line
	 * @param as accounting schema
	 * @param fact
	 * @param acct
	 * @param invGainLossFactLines gain/loss fact lines for invoice
	 * @param invList invoice list
	 * @param invLineList invoice line list
	 * @param htFactLineInv C_Invoice_ID and the fact lines
	 * @param invRoundingLines rounding correction fact lines for invoice
	 * @param htRoundingLineInv C_Invoice_ID and the correction fact lines
	 * @return error message or null
	 */
	private boolean createInvoiceLineRoundingCorrection(MAcctSchema as, Fact fact, MAccount acct, 
			ArrayList<FactLine> invGainLossFactLines, ArrayList<MInvoice> invList, ArrayList<MInvoiceLine> invLineList,
			HashMap<Integer, ArrayList<FactLine>> htFactLineInv, ArrayList<FactLine> invRoundingLines, HashMap<Integer, ArrayList<FactLine>> htRoundingLineInv) 
	{
		StringBuilder sqlInvLine = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr)-SUM(AmtSourceCr), SUM(AmtAcctDr)-SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID=? AND Line_ID=?")
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND Account_ID=?")
				.append(" AND PostingType='A'");
		
		// C_InvoiceLine_ID and the total source amount from C_Invoice accounting fact lines
		HashMap<Integer, BigDecimal> htInvLineSource = new HashMap<Integer, BigDecimal>();
		// C_InvoiceLine_ID and the total accounted amount from C_Invoice accounting fact lines
		HashMap<Integer, BigDecimal> htInvLineAccounted = new HashMap<Integer, BigDecimal>();
		for (MInvoiceLine invoiceLine : invLineList)
		{
			// For Invoice Line
			List<Object> valuesInv = DB.getSQLValueObjectsEx(getTrxName(), sqlInvLine.toString(),
					MInvoice.Table_ID, invoiceLine.getC_Invoice_ID(), invoiceLine.getC_InvoiceLine_ID(), as.getC_AcctSchema_ID(), acct.getAccount_ID());
			if (valuesInv != null) {
				BigDecimal invoiceSourceDrCr = (BigDecimal) valuesInv.get(0); // AmtSource
				BigDecimal invoiceAccountedDrCr = (BigDecimal) valuesInv.get(1); // AmtAcct
				
				htInvLineSource.put(invoiceLine.getC_InvoiceLine_ID(), invoiceSourceDrCr.abs());
				htInvLineAccounted.put(invoiceLine.getC_InvoiceLine_ID(), invoiceAccountedDrCr.abs());
			}
		}
		
		MAccount gain = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedGain_Acct());
		MAccount loss = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
		
		// C_Invoice_ID and the total source amount from M_MatchInv accounting fact lines
		HashMap<Integer, BigDecimal> htInvClrSource = new HashMap<Integer, BigDecimal>();
		// C_Invoice_ID and the total accounted amount from M_MatchInv accounting fact lines
		HashMap<Integer, BigDecimal> htInvClrAccounted = new HashMap<Integer, BigDecimal>();
		for (Integer C_Invoice_ID : htFactLineInv.keySet())
		{
			ArrayList<FactLine> factLineList = htFactLineInv.get(C_Invoice_ID);
			for (FactLine factLine : factLineList)
			{
				if (factLine.getAccount_ID() == acct.getAccount_ID())
				{
					BigDecimal invClrSource = htInvClrSource.get(C_Invoice_ID);
					if (invClrSource == null)
						invClrSource = Env.ZERO;
					invClrSource = invClrSource.add(factLine.getAmtSourceDr()).subtract(factLine.getAmtSourceCr());
					htInvClrSource.put(C_Invoice_ID, invClrSource);
					
					BigDecimal invClrAccounted = htInvClrAccounted.get(C_Invoice_ID);
					if (invClrAccounted == null)
						invClrAccounted = Env.ZERO;
					invClrAccounted = invClrAccounted.add(factLine.getAmtAcctDr()).subtract(factLine.getAmtAcctCr());
					htInvClrAccounted.put(C_Invoice_ID, invClrAccounted);
				}
			}
		}
		
		for (MInvoiceLine invoiceLine : invLineList)
		{
			{
				MMatchInv[] matchInvs = MMatchInv.getInvoiceLine(getCtx(), invoiceLine.get_ID(), getTrxName());
				
				ArrayList<Integer> skipMatchInvIdList = new ArrayList<Integer>();
				skipMatchInvIdList.add(m_matchInv.get_ID());
				for (MMatchInv matchInv : matchInvs)
				{
					if (matchInv.isReversal())
						skipMatchInvIdList.add(matchInv.get_ID());
				}
				
				for (MMatchInv matchInv : matchInvs)
				{
					if (matchInv.get_ID() == m_matchInv.get_ID())
						continue;
					
					if (skipMatchInvIdList.contains(matchInv.get_ID()))
						continue;
					
					StringBuilder sql = new StringBuilder()
						.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
						.append(" FROM Fact_Acct ")
						.append("WHERE AD_Table_ID=? AND (Record_ID=? OR Record_ID=?)")	//	match inv
						.append(" AND C_AcctSchema_ID=?")
						.append(" AND PostingType='A'")
						.append(" AND Account_ID=?");
					
					if (m_matchInv.isReversal())
					{
						if (matchInv.isReversal())
							sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
						sql.append(" AND Record_ID < ").append(m_matchInv.getReversal_ID());
					}
					else
					{
						if (matchInv.getReversal_ID() > 0)
							sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
					}
					
					if (matchInv.getRef_MatchInv_ID() > 0)
					{
						if (invoiceLine.getParent().isCreditMemo() && matchInv.getQty().compareTo(BigDecimal.ZERO) < 0)
							sql.append(" AND Qty > 0");
						else
							sql.append(" AND Qty < 0");
					}
					
					// For Match Inv
					List<Object> valuesMatchInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
							MMatchInv.Table_ID, matchInv.get_ID(), matchInv.getRef_MatchInv_ID() > 0 ? matchInv.getRef_MatchInv_ID() : -1, as.getC_AcctSchema_ID(), acct.getAccount_ID());
					if (valuesMatchInv != null) {
						BigDecimal totalAmtSourceDr = (BigDecimal) valuesMatchInv.get(0);
						if (totalAmtSourceDr == null)
							totalAmtSourceDr = Env.ZERO;
						BigDecimal totalAmtAcctDr = (BigDecimal) valuesMatchInv.get(1);
						if (totalAmtAcctDr == null)
							totalAmtAcctDr = Env.ZERO;
						BigDecimal totalAmtSourceCr = (BigDecimal) valuesMatchInv.get(2);
						if (totalAmtSourceCr == null)
							totalAmtSourceCr = Env.ZERO;
						BigDecimal totalAmtAcctCr = (BigDecimal) valuesMatchInv.get(3);
						if (totalAmtAcctCr == null)
							totalAmtAcctCr = Env.ZERO;
						
						BigDecimal invClrSource = htInvClrSource.get(invoiceLine.getC_Invoice_ID());
						if (invClrSource == null)
							invClrSource = Env.ZERO;
						invClrSource = invClrSource.add(totalAmtSourceDr).subtract(totalAmtSourceCr);
						htInvClrSource.put(invoiceLine.getC_Invoice_ID(), invClrSource);
						
						BigDecimal invClrAccounted = htInvClrAccounted.get(invoiceLine.getC_Invoice_ID());
						if (invClrAccounted == null)
							invClrAccounted = Env.ZERO;
						invClrAccounted = invClrAccounted.add(totalAmtAcctDr).subtract(totalAmtAcctCr);
						htInvClrAccounted.put(invoiceLine.getC_Invoice_ID(), invClrAccounted);
					}
					
					sql = new StringBuilder()
						.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
						.append(" FROM Fact_Acct ")
						.append("WHERE AD_Table_ID=? AND (Record_ID=? OR Record_ID=?)")	//	match inv
						.append(" AND C_AcctSchema_ID=?")
						.append(" AND PostingType='A'")
						.append(" AND (Account_ID=? OR Account_ID=? OR Account_ID=?)")
						.append(" AND Description LIKE 'Invoice Line%'");
					
					if (m_matchInv.isReversal())
					{
						if (matchInv.isReversal())
							sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
						sql.append(" AND Record_ID < ").append(m_matchInv.getReversal_ID());
					}
					else
					{
						if (matchInv.getReversal_ID() > 0)
							sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
					}
					
					if (matchInv.getRef_MatchInv_ID() > 0)
					{
						if (invoiceLine.getParent().isCreditMemo() && matchInv.getQty().compareTo(BigDecimal.ZERO) < 0)
							sql.append(" AND Qty > 0");
						else
							sql.append(" AND Qty < 0");
					}
					
					// For Match Inv
					valuesMatchInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
							MMatchInv.Table_ID, matchInv.get_ID(), matchInv.getRef_MatchInv_ID() > 0 ? matchInv.getRef_MatchInv_ID() : -1, as.getC_AcctSchema_ID(), 
							gain.getAccount_ID(), loss.getAccount_ID(), as.getCurrencyBalancing_Acct().getAccount_ID());
					if (valuesMatchInv != null) {
						BigDecimal totalAmtSourceDr = (BigDecimal) valuesMatchInv.get(0);
						if (totalAmtSourceDr == null)
							totalAmtSourceDr = Env.ZERO;
						BigDecimal totalAmtAcctDr = (BigDecimal) valuesMatchInv.get(1);
						if (totalAmtAcctDr == null)
							totalAmtAcctDr = Env.ZERO;
						BigDecimal totalAmtSourceCr = (BigDecimal) valuesMatchInv.get(2);
						if (totalAmtSourceCr == null)
							totalAmtSourceCr = Env.ZERO;
						BigDecimal totalAmtAcctCr = (BigDecimal) valuesMatchInv.get(3);
						if (totalAmtAcctCr == null)
							totalAmtAcctCr = Env.ZERO;
						
						BigDecimal invClrSource = htInvClrSource.get(invoiceLine.getC_Invoice_ID());
						if (invClrSource == null)
							invClrSource = Env.ZERO;
						invClrSource = invClrSource.add(totalAmtSourceDr).subtract(totalAmtSourceCr);
						htInvClrSource.put(invoiceLine.getC_Invoice_ID(), invClrSource);
						
						// ignore totalAmtAcctDr and totalAmtAccrCr
					}
				}
			}
		}
		
		boolean isLineFullyMatched = true;
		for (MInvoiceLine invoiceLine : invLineList)
		{
			BigDecimal invLineSource = htInvLineSource.get(invoiceLine.get_ID());
			if (invLineSource == null)
				invLineSource = Env.ZERO;
			BigDecimal invLineAccounted = htInvLineAccounted.get(invoiceLine.get_ID());
			if (invLineAccounted == null)
				invLineAccounted = Env.ZERO;			
			BigDecimal invClrSource = htInvClrSource.get(invoiceLine.getC_Invoice_ID());
			if (invClrSource == null)
				invClrSource = Env.ZERO;
			BigDecimal invClrAccounted = htInvClrAccounted.get(invoiceLine.getC_Invoice_ID());
			if (invClrAccounted == null)
				invClrAccounted = Env.ZERO;
			StringBuilder description = new StringBuilder("Invoice Line=(").append(getC_Currency_ID()).append(")").append(invLineSource).append("/").append(invLineAccounted)
					.append(" - Match Invoice=(").append(getC_Currency_ID()).append(")").append(invClrSource).append("/").append(invClrAccounted);
			if (log.isLoggable(Level.FINE)) log.fine(description.toString());
			BigDecimal acctDifference = invLineAccounted.abs().subtract(invClrAccounted.abs());	//	gain is negative
			if (invClrSource.abs().compareTo(invLineSource.abs()) == 0)
			{
				if (acctDifference != null && acctDifference.signum() != 0 && acctDifference.abs().compareTo(TOLERANCE) < 0)
				{
					StringBuilder d2 = new StringBuilder("(full) = ").append(acctDifference);
					if (log.isLoggable(Level.FINE)) log.fine(d2.toString());
					description.append(" - ").append(d2);
					
					FactLine fl = fact.createLine (null, acct, as.getC_Currency_ID(), acctDifference.negate());
					fl.setDescription(description.toString());
					updateFactLine(fl);
					invRoundingLines.add(fl);
					ArrayList<FactLine> roundingLineList = htRoundingLineInv.get(invoiceLine.getC_Invoice_ID());
					if (roundingLineList == null)
						roundingLineList = new ArrayList<FactLine>();
					roundingLineList.add(fl);
					
					if (as.isCurrencyBalancing())
						fl = fact.createLine (null, as.getCurrencyBalancing_Acct(), as.getC_Currency_ID(), acctDifference);
					else
						fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), acctDifference);
					fl.setDescription(description.toString());
					updateFactLine(fl);
					invRoundingLines.add(fl);
					roundingLineList.add(fl);
					htRoundingLineInv.put(invoiceLine.getC_Invoice_ID(), roundingLineList);
				}
			}
			else
			{
				if (acctDifference != null && acctDifference.signum() != 0 && acctDifference.abs().compareTo(TOLERANCE) < 0)
					;
				else
					isLineFullyMatched = false;
			}
		}
		
		return isLineFullyMatched;
	}
	
	/**
	 * Create Gain/Loss for receipt
	 * @param as accounting schema
	 * @param fact
	 * @param acct
	 * @param receipt
	 * @param matchInvSource
	 * @param matchInvAccounted
	 * @param mrGainLossFactLines gain/loss fact lines for receipt
	 * @param mrFactLines fact lines for receipt
	 * @return error message or null
	 */
	private String createReceiptGainLoss(MAcctSchema as, Fact fact, MAccount acct, 
			MInOut receipt, BigDecimal matchInvSource, BigDecimal matchInvAccounted,
			ArrayList<FactLine> mrGainLossFactLines, ArrayList<FactLine> mrFactLines)
	{
		if (m_matchInv.isReversal())
			return createReversalReceiptGainLossRoundingCorrection(as, fact, acct);
		
		BigDecimal receiptSource = null;
		BigDecimal receiptAccounted = null;
		//
		StringBuilder sql = new StringBuilder()
			.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
			.append(" FROM Fact_Acct ")
			.append("WHERE AD_Table_ID=? AND Record_ID=?")
			.append(" AND C_AcctSchema_ID=?")
			.append(" AND Account_ID=?")
			.append(" AND PostingType='A'");

		// For Receipt
		List<Object> valuesInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
				MInOut.Table_ID, receipt.getM_InOut_ID(), as.getC_AcctSchema_ID(), acct.getAccount_ID());
		if (valuesInv != null) {
			receiptSource = (BigDecimal) valuesInv.get(0); // AmtSourceDr
			receiptAccounted = (BigDecimal) valuesInv.get(1); // AmtAcctDr
			if (receiptSource.signum() == 0 && receiptAccounted.signum() == 0) {
				receiptSource = (BigDecimal) valuesInv.get(2); // AmtSourceCr
				receiptAccounted = (BigDecimal) valuesInv.get(3); // AmtAcctCr
			}
		}
		
		// 	Requires that Receipt is Posted
		if (receiptSource == null || receiptAccounted == null)
			return null;
		//
		StringBuilder description = new StringBuilder("InOut=(")
				.append(receipt.getC_Currency_ID()).append(")").append(receiptSource).append("/").append(receiptAccounted)
				.append(" - MatchInv=(").append(getC_Currency_ID()).append(")").append(matchInvSource).append("/").append(matchInvAccounted);
		if (log.isLoggable(Level.FINE)) log.fine(description.toString());
		BigDecimal acctDifference = null;
		//	Full INV in currency
		if (matchInvSource.compareTo(receiptSource) == 0)
		{
			acctDifference = matchInvAccounted.abs().subtract(receiptAccounted.abs());	//	gain is negative
			StringBuilder d2 = new StringBuilder("(full) = ").append(acctDifference);
			if (log.isLoggable(Level.FINE)) log.fine(d2.toString());
			description.append(" - ").append(d2);
		}

		if (acctDifference == null || acctDifference.signum() == 0)
		{
			log.fine("No Difference");
			return null;
		}

		MAccount gain = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedGain_Acct());
		MAccount loss = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
		//
		FactLine fl = fact.createLine (null, acct, as.getC_Currency_ID(), acctDifference.negate());
		fl.setDescription(description.toString());
		updateFactLine(fl);
		mrFactLines.add(fl);
		
		fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), acctDifference);
		fl.setDescription(description.toString());
		updateFactLine(fl);
		mrGainLossFactLines.add(fl);
		mrFactLines.add(fl);
		return null;
	}	//	createReceiptGainLoss
	
	/**
	 * Create Gain/Loss and Rounding Correction for reverse receipt
	 * @param as accounting schema
	 * @param fact
	 * @param acct
	 * @return error message or null
	 */
	private String createReversalReceiptGainLossRoundingCorrection(MAcctSchema as, Fact fact, MAccount acct)
	{
		if (!m_matchInv.isReversal())
			return null;
		
		MAccount gain = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedGain_Acct());
		MAccount loss = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
		
		StringBuilder whereClause = new StringBuilder()
				.append("AD_Table_ID=?")
				.append(" AND Record_ID=?")
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND PostingType='A'")
				.append(" AND (Account_ID=? OR Account_ID=? OR Account_ID=? OR Account_ID=?)")
				.append(" AND Description LIKE 'InOut%'");
		
		List<MFactAcct> list = new Query(getCtx(), MFactAcct.Table_Name, whereClause.toString(), getTrxName())
				.setParameters(MMatchInv.Table_ID, m_matchInv.getReversal_ID(), as.getC_AcctSchema_ID(), 
						acct.getAccount_ID(), gain.getAccount_ID(), loss.getAccount_ID(), as.getCurrencyBalancing_Acct().getAccount_ID())
				.setOrderBy(MFactAcct.COLUMNNAME_Fact_Acct_ID)
				.list();
		for (MFactAcct fa : list) {
			FactLine fl = fact.createLine(null, fa.getMAccount(), fa.getC_Currency_ID(), fa.getAmtAcctCr(), fa.getAmtAcctDr());
			fl.setDescription(fa.getDescription());
			updateFactLine(fl);
		}
		
		return null;
	}
	
	/**
	 * Create Rounding Correction for receipt
	 * @param as accounting schema
	 * @param fact
	 * @param acct
	 * @param mrGainLossFactLines gain/loss fact lines for receipt
	 * @param mrFactLines fact lines for receipt
	 * @return error message or null
	 */
	private String createReceiptRoundingCorrection(MAcctSchema as, Fact fact, MAccount acct, 
			ArrayList<FactLine> mrGainLossFactLines, ArrayList<FactLine> mrFactLines) 
	{
		if (m_matchInv.isReversal())
			return null;
		
		ArrayList<FactLine> mrLineRoundingLines = new ArrayList<FactLine>();
		boolean isLineFullyMatched = createReceiptLineRoundingCorrection(as, fact, acct, mrGainLossFactLines, mrFactLines, mrLineRoundingLines);
		
		if (!isLineFullyMatched)
			return null;
		
		int M_InOut_ID = m_receiptLine.getM_InOut_ID();
		
		BigDecimal totalNIRAccounted = Env.ZERO;
		for (FactLine mrLineRoundingLine : mrLineRoundingLines)
		{
			if (mrLineRoundingLine.getAccount() == acct)
				totalNIRAccounted = totalNIRAccounted.add(mrLineRoundingLine.getAmtAcctDr()).subtract(mrLineRoundingLine.getAmtAcctCr());
		}
		
		StringBuilder sqlMR = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr)-SUM(AmtSourceCr), SUM(AmtAcctDr)-SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID=?")
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND Account_ID=?")
				.append(" AND PostingType='A'");
		
		BigDecimal mrSource = Env.ZERO;
		BigDecimal mrAccounted = Env.ZERO;
		
		// For MR
		List<Object> valuesInv = DB.getSQLValueObjectsEx(getTrxName(), sqlMR.toString(),
				MInOut.Table_ID, M_InOut_ID, as.getC_AcctSchema_ID(), acct.getAccount_ID());
		if (valuesInv != null) {
			BigDecimal receiptSourceDrCr = (BigDecimal) valuesInv.get(0); // AmtSource
			BigDecimal receiptAccountedDrCr = (BigDecimal) valuesInv.get(1); // AmtAcct
			
			mrSource = mrSource.add(receiptSourceDrCr);
			mrAccounted = mrAccounted.add(receiptAccountedDrCr);
			
			totalNIRAccounted = totalNIRAccounted.add(receiptAccountedDrCr);
		}
		
		// Currency Balancing
		valuesInv = DB.getSQLValueObjectsEx(getTrxName(), sqlMR.toString(),
				MInOut.Table_ID, M_InOut_ID, as.getC_AcctSchema_ID(), as.getCurrencyBalancing_Acct().getAccount_ID());
		if (valuesInv != null) {
			BigDecimal receiptSourceDrCr = (BigDecimal) valuesInv.get(0); // AmtSource
			BigDecimal receiptAccountedDrCr = (BigDecimal) valuesInv.get(1); // AmtAcct
			
			if (receiptSourceDrCr == null)
				receiptSourceDrCr = Env.ZERO;
			if (receiptAccountedDrCr == null)
				receiptAccountedDrCr = Env.ZERO;
			
			mrSource = mrSource.add(receiptSourceDrCr);
			mrAccounted = mrAccounted.add(receiptAccountedDrCr);
		}
		
		MAccount gain = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedGain_Acct());
		MAccount loss = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
		
		BigDecimal totalAmtSourceDr = Env.ZERO;
		BigDecimal totalAmtAcctDr = Env.ZERO;
		BigDecimal totalAmtSourceCr = Env.ZERO;
		BigDecimal totalAmtAcctCr = Env.ZERO;

		ArrayList<FactLine> factLineList = mrFactLines;
		for (FactLine factLine : factLineList)
		{
			if (factLine.getAccount_ID() == acct.getAccount_ID())
			{
				totalAmtSourceDr = totalAmtSourceDr.add(factLine.getAmtSourceDr());
				totalAmtAcctDr = totalAmtAcctDr.add(factLine.getAmtAcctDr());
				totalAmtSourceCr = totalAmtSourceCr.add(factLine.getAmtSourceCr());
				totalAmtAcctCr = totalAmtAcctCr.add(factLine.getAmtAcctCr());
				
				totalNIRAccounted = totalNIRAccounted.add(factLine.getAmtAcctDr()).subtract(factLine.getAmtAcctCr());
			}
			else if (factLine.getAccount_ID() == gain.getAccount_ID() || factLine.getAccount_ID() == loss.getAccount_ID())
			{
				if (!mrGainLossFactLines.contains(factLine))
					continue;
				
				totalAmtSourceDr = totalAmtSourceDr.add(factLine.getAmtSourceDr());
				totalAmtSourceCr = totalAmtSourceCr.add(factLine.getAmtSourceCr());
			}
		}
		
		BigDecimal matchInvSource = Env.ZERO;
		BigDecimal matchInvAccounted = Env.ZERO;
		
		matchInvSource = matchInvSource.add(totalAmtSourceDr).subtract(totalAmtSourceCr);
		matchInvAccounted = matchInvAccounted.add(totalAmtAcctDr).subtract(totalAmtAcctCr);
		
		for (FactLine mrLineRoundingLine : mrLineRoundingLines)
		{
			if (mrLineRoundingLine.getAccount() == acct)
				matchInvAccounted = matchInvAccounted.add(mrLineRoundingLine.getAmtAcctDr()).subtract(mrLineRoundingLine.getAmtAcctCr());
		}
		
		MMatchInv[] matchInvs = MMatchInv.getInOut(getCtx(), M_InOut_ID, getTrxName());
		ArrayList<Integer> skipMatchInvIdList = new ArrayList<Integer>();
		skipMatchInvIdList.add(m_matchInv.get_ID());
		for (MMatchInv matchInv : matchInvs)
		{
			if (matchInv.isReversal())
				skipMatchInvIdList.add(matchInv.get_ID());
		}
		
		for (MMatchInv matchInv : matchInvs)
		{
			if (matchInv.get_ID() == m_matchInv.get_ID())
				continue;
			
			if (skipMatchInvIdList.contains(matchInv.get_ID()))
				continue;
			
			StringBuilder sql = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID=?")	//	match inv
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND PostingType='A'")
				.append(" AND Account_ID=?");
			
			if (m_matchInv.isReversal())
			{
				if (matchInv.isReversal())
					sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
				sql.append(" AND Record_ID < ").append(m_matchInv.getReversal_ID());
			}
			else
			{
				if (matchInv.getReversal_ID() > 0)
					sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
			}
			
			// For Match Inv
			List<Object> valuesMatchInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
					MMatchInv.Table_ID, matchInv.get_ID(), as.getC_AcctSchema_ID(), acct.getAccount_ID());
			if (valuesMatchInv != null) {
				totalAmtSourceDr = (BigDecimal) valuesMatchInv.get(0);
				if (totalAmtSourceDr == null)
					totalAmtSourceDr = Env.ZERO;
				totalAmtAcctDr = (BigDecimal) valuesMatchInv.get(1);
				if (totalAmtAcctDr == null)
					totalAmtAcctDr = Env.ZERO;
				totalAmtSourceCr = (BigDecimal) valuesMatchInv.get(2);
				if (totalAmtSourceCr == null)
					totalAmtSourceCr = Env.ZERO;
				totalAmtAcctCr = (BigDecimal) valuesMatchInv.get(3);
				if (totalAmtAcctCr == null)
					totalAmtAcctCr = Env.ZERO;
				
				matchInvSource = matchInvSource.add(totalAmtSourceDr).subtract(totalAmtSourceCr);
				matchInvAccounted = matchInvAccounted.add(totalAmtAcctDr).subtract(totalAmtAcctCr);
				
				totalNIRAccounted = totalNIRAccounted.add(totalAmtAcctDr).subtract(totalAmtAcctCr);
			}
			
			sql = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID=?")	//	match inv
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND PostingType='A'")
				.append(" AND (Account_ID=? OR Account_ID=? OR Account_ID=?)")
				.append(" AND Description LIKE 'InOut%'");
			
			if (m_matchInv.isReversal())
			{
				if (matchInv.isReversal())
					sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
				sql.append(" AND Record_ID < ").append(m_matchInv.getReversal_ID());
			}
			else
			{
				if (matchInv.getReversal_ID() > 0)
					sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
			}
			
			// For Match Inv
			valuesMatchInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
					MMatchInv.Table_ID, matchInv.get_ID(), 
					as.getC_AcctSchema_ID(), gain.getAccount_ID(), loss.getAccount_ID(), as.getCurrencyBalancing_Acct().getAccount_ID());
			if (valuesMatchInv != null) {
				totalAmtSourceDr = (BigDecimal) valuesMatchInv.get(0);
				if (totalAmtSourceDr == null)
					totalAmtSourceDr = Env.ZERO;
				totalAmtAcctDr = (BigDecimal) valuesMatchInv.get(1);
				if (totalAmtAcctDr == null)
					totalAmtAcctDr = Env.ZERO;
				totalAmtSourceCr = (BigDecimal) valuesMatchInv.get(2);
				if (totalAmtSourceCr == null)
					totalAmtSourceCr = Env.ZERO;
				totalAmtAcctCr = (BigDecimal) valuesMatchInv.get(3);
				if (totalAmtAcctCr == null)
					totalAmtAcctCr = Env.ZERO;
				
				matchInvSource = matchInvSource.add(totalAmtSourceDr).subtract(totalAmtSourceCr);
			}
		}
		
		StringBuilder description = new StringBuilder("InOut=(")
				.append(getC_Currency_ID()).append(")").append(mrSource).append("/").append(mrAccounted)
				.append(" - Match Invoice=(").append(getC_Currency_ID()).append(")").append(matchInvSource).append("/").append(matchInvAccounted);
		if (log.isLoggable(Level.FINE)) log.fine(description.toString());
		BigDecimal acctDifference = Env.ZERO;
		if (matchInvSource.abs().compareTo(mrSource.abs()) == 0)
		{
			acctDifference = mrAccounted.abs().subtract(matchInvAccounted.abs());	//	gain is negative
			StringBuilder d2 = new StringBuilder("(full) = ").append(acctDifference);
			if (log.isLoggable(Level.FINE)) log.fine(d2.toString());
			description.append(" - ").append(d2);
		}
		else
			isLineFullyMatched = false;
		
		if (acctDifference == null || acctDifference.signum() == 0)
		{
			log.fine("No Difference");
			return null;
		}
		
		if (acctDifference.abs().compareTo(TOLERANCE) >= 0)
		{
			log.fine("acctDifference="+acctDifference);
			return null;
		}
		
		ArrayList<FactLine> mrRoundingLines = new ArrayList<FactLine>();
		//
		FactLine fl = fact.createLine (null, acct, as.getC_Currency_ID(), acctDifference);
		fl.setDescription(description.toString());
		updateFactLine(fl);
		mrRoundingLines.add(fl);
		
		totalNIRAccounted = totalNIRAccounted.add(fl.getAmtAcctDr()).subtract(fl.getAmtAcctCr());
		
		if (as.isCurrencyBalancing() && as.getC_Currency_ID() != m_invoiceLine.getParent().getC_Currency_ID())
			fl = fact.createLine (null, as.getCurrencyBalancing_Acct(), as.getC_Currency_ID(), acctDifference.negate());
		else 
			fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), acctDifference.negate());	
		fl.setDescription(description.toString());
		updateFactLine(fl);
		mrRoundingLines.add(fl);
		
		if (isLineFullyMatched) {
			if (totalNIRAccounted != null && totalNIRAccounted.signum() != 0 && totalNIRAccounted.abs().compareTo(TOLERANCE) < 0)
			{
				BigDecimal totalRounding = Env.ZERO;
				for (FactLine mrRoundingLine : mrRoundingLines)
				{
					if (mrRoundingLine.getAccount() == acct)
						totalRounding = totalRounding.add(mrRoundingLine.getAmtAcctDr()).subtract(mrRoundingLine.getAmtAcctCr());
				}
				
				if (totalRounding.compareTo(totalNIRAccounted) == 0)
				{
					for (FactLine invRoundingLine : mrRoundingLines)
					{
						fact.remove(invRoundingLine);
					}
					totalNIRAccounted = Env.ZERO;
				}
			}

			if (totalNIRAccounted != null && totalNIRAccounted.signum() != 0 && totalNIRAccounted.abs().compareTo(TOLERANCE) < 0)
			{
				description = new StringBuilder("InOut - MatchInv - (full) = ").append(totalNIRAccounted);
				if (log.isLoggable(Level.FINE)) log.fine(description.toString());
				
				fl = fact.createLine (null, acct, as.getC_Currency_ID(), totalNIRAccounted);
				fl.setDescription(description.toString());
				updateFactLine(fl);
				
				if (as.isCurrencyBalancing())
					fl = fact.createLine (null, as.getCurrencyBalancing_Acct(), as.getC_Currency_ID(), totalNIRAccounted.negate());
				else
					fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), totalNIRAccounted.negate());
				fl.setDescription(description.toString());
				updateFactLine(fl);
			}
		}
		
		return null;
	}
	
	/**
	 * Create Rounding Correction for receipt line
	 * @param as accounting schema
	 * @param fact
	 * @param acct
	 * @param mrGainLossFactLines gain/loss fact lines for receipt
	 * @param mrFactLines fact lines for receipt
	 * @param mrRoundingLines rounding correction fact lines for receipt
	 * @return error message or null
	 */
	private boolean createReceiptLineRoundingCorrection(MAcctSchema as, Fact fact, MAccount acct, 
			ArrayList<FactLine> mrGainLossFactLines, ArrayList<FactLine> mrFactLines, ArrayList<FactLine> mrRoundingLines) 
	{
		BigDecimal mrLineSource = null;
		BigDecimal mrLineAccounted = null;
			
		StringBuilder sqlMRLine = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr)-SUM(AmtSourceCr), SUM(AmtAcctDr)-SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID=? AND Line_ID=?")
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND Account_ID=?")
				.append(" AND PostingType='A'");		
		// For MR Line
		List<Object> valuesMR = DB.getSQLValueObjectsEx(getTrxName(), sqlMRLine.toString(),
				MInOut.Table_ID, m_receiptLine.getM_InOut_ID(), m_receiptLine.getM_InOutLine_ID(), as.getC_AcctSchema_ID(), acct.getAccount_ID());
		if (valuesMR != null) {
			mrLineSource = (BigDecimal) valuesMR.get(0); // AmtSource
			mrLineAccounted = (BigDecimal) valuesMR.get(1); // AmtAcct
		}
		
		MAccount gain = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedGain_Acct());
		MAccount loss = MAccount.get (as.getCtx(), as.getAcctSchemaDefault().getRealizedLoss_Acct());
		
		BigDecimal nirSource = Env.ZERO;
		BigDecimal nirAccounted = Env.ZERO;
		
		ArrayList<FactLine> factLineList = mrFactLines;
		for (FactLine factLine : factLineList)
		{
			if (factLine.getAccount_ID() == acct.getAccount_ID())
			{
				nirSource = nirSource.add(factLine.getAmtSourceDr()).subtract(factLine.getAmtSourceCr());
				nirAccounted = nirAccounted.add(factLine.getAmtAcctDr()).subtract(factLine.getAmtAcctCr());
			}
		}
		
		MMatchInv[] matchInvs = MMatchInv.getInOutLine(getCtx(), m_receiptLine.get_ID(), getTrxName());
		ArrayList<Integer> skipMatchInvIdList = new ArrayList<Integer>();
		skipMatchInvIdList.add(m_matchInv.get_ID());
		for (MMatchInv matchInv : matchInvs)
		{
			if (matchInv.isReversal())
				skipMatchInvIdList.add(matchInv.get_ID());
		}
		
		for (MMatchInv matchInv : matchInvs)
		{
			if (matchInv.get_ID() == m_matchInv.get_ID())
				continue;
			
			if (skipMatchInvIdList.contains(matchInv.get_ID()))
				continue;
			
			StringBuilder sql = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID=?")	//	match inv
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND PostingType='A'")
				.append(" AND Account_ID=?");
			
			if (m_matchInv.isReversal())
			{
				if (matchInv.isReversal())
					sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
				sql.append(" AND Record_ID < ").append(m_matchInv.getReversal_ID());
			}
			else
			{
				if (matchInv.getReversal_ID() > 0)
					sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
			}
			
			// For Match Inv
			List<Object> valuesMatchInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
					MMatchInv.Table_ID, matchInv.get_ID(), as.getC_AcctSchema_ID(), acct.getAccount_ID());
			if (valuesMatchInv != null) {
				BigDecimal totalAmtSourceDr = (BigDecimal) valuesMatchInv.get(0);
				if (totalAmtSourceDr == null)
					totalAmtSourceDr = Env.ZERO;
				BigDecimal totalAmtAcctDr = (BigDecimal) valuesMatchInv.get(1);
				if (totalAmtAcctDr == null)
					totalAmtAcctDr = Env.ZERO;
				BigDecimal totalAmtSourceCr = (BigDecimal) valuesMatchInv.get(2);
				if (totalAmtSourceCr == null)
					totalAmtSourceCr = Env.ZERO;
				BigDecimal totalAmtAcctCr = (BigDecimal) valuesMatchInv.get(3);
				if (totalAmtAcctCr == null)
					totalAmtAcctCr = Env.ZERO;
				
				nirSource = nirSource.add(totalAmtSourceDr).subtract(totalAmtSourceCr);
				nirAccounted = nirAccounted.add(totalAmtAcctDr).subtract(totalAmtAcctCr);
			}
			
			sql = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID=?")	//	match inv
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND PostingType='A'")
				.append(" AND (Account_ID=? OR Account_ID=? OR Account_ID=?)")
				.append(" AND Description LIKE 'InOut Line%'");
			
			if (m_matchInv.isReversal())
			{
				if (matchInv.isReversal())
					sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
				sql.append(" AND Record_ID < ").append(m_matchInv.getReversal_ID());
			}
			else
			{
				if (matchInv.getReversal_ID() > 0)
					sql.append(" AND Record_ID <> ").append(matchInv.get_ID());
			}
			
			// For Match Inv
			valuesMatchInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
					MMatchInv.Table_ID, matchInv.get_ID(), as.getC_AcctSchema_ID(), 
					gain.getAccount_ID(), loss.getAccount_ID(), as.getCurrencyBalancing_Acct().getAccount_ID());
			if (valuesMatchInv != null) {
				BigDecimal totalAmtSourceDr = (BigDecimal) valuesMatchInv.get(0);
				if (totalAmtSourceDr == null)
					totalAmtSourceDr = Env.ZERO;
				BigDecimal totalAmtAcctDr = (BigDecimal) valuesMatchInv.get(1);
				if (totalAmtAcctDr == null)
					totalAmtAcctDr = Env.ZERO;
				BigDecimal totalAmtSourceCr = (BigDecimal) valuesMatchInv.get(2);
				if (totalAmtSourceCr == null)
					totalAmtSourceCr = Env.ZERO;
				BigDecimal totalAmtAcctCr = (BigDecimal) valuesMatchInv.get(3);
				if (totalAmtAcctCr == null)
					totalAmtAcctCr = Env.ZERO;
				
				nirSource = nirSource.add(totalAmtSourceDr).subtract(totalAmtSourceCr);
				// ignore totalAmtAcctDr and totalAmtAccrCr
			}
		}
		
		boolean isLineFullyMatched = true;
		
		StringBuilder description = new StringBuilder("InOut Line=(")
				.append(getC_Currency_ID()).append(")").append(mrLineSource).append("/").append(mrLineAccounted)
				.append(" - Match Invoice=(").append(getC_Currency_ID()).append(")").append(nirSource).append("/").append(nirAccounted);
		if (log.isLoggable(Level.FINE)) log.fine(description.toString());
		BigDecimal acctDifference = mrLineAccounted.abs().subtract(nirAccounted.abs());	//	gain is negative
		
		if (nirSource.abs().compareTo(mrLineSource.abs()) == 0)
		{
			if (acctDifference != null && acctDifference.signum() != 0 && acctDifference.abs().compareTo(TOLERANCE) < 0)
			{
				StringBuilder d2 = new StringBuilder("(full) = ").append(acctDifference);
				if (log.isLoggable(Level.FINE)) log.fine(d2.toString());
				description.append(" - ").append(d2);
				
				FactLine fl = fact.createLine (null, acct, as.getC_Currency_ID(), acctDifference);
				fl.setDescription(description.toString());
				updateFactLine(fl);
				mrRoundingLines.add(fl);
				
				if (as.isCurrencyBalancing() && as.getC_Currency_ID() != m_invoiceLine.getParent().getC_Currency_ID())
					fl = fact.createLine (null, as.getCurrencyBalancing_Acct(), as.getC_Currency_ID(), acctDifference.negate());
				else 
					fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), acctDifference.negate());	
				fl.setDescription(description.toString());
				updateFactLine(fl);
				mrRoundingLines.add(fl);
			}
		}
		else
		{
			if (acctDifference != null && acctDifference.signum() != 0 && acctDifference.abs().compareTo(TOLERANCE) < 0)
				;
			else
				isLineFullyMatched = false;
		}
		
		return isLineFullyMatched;
	}
}   //  Doc_MatchInv
