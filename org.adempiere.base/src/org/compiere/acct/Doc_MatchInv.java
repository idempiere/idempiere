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
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchInv;
import org.compiere.model.MOrderLandedCostAllocation;
import org.compiere.model.ProductCost;
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
	 * 	@param ass accounting schema
	 * 	@param rs record
	 * 	@param trxName trx
	 */
	public Doc_MatchInv (MAcctSchema as, ResultSet rs, String trxName)
	{
		super(as, MMatchInv.class, rs, DOCTYPE_MatMatchInv, trxName);
	}   //  Doc_MatchInv

	/** Invoice Line			*/
	private MInvoiceLine	m_invoiceLine = null;
	/** Material Receipt		*/
	private MInOutLine		m_receiptLine = null;

	private ProductCost		m_pc = null;
	private MMatchInv m_matchInv;

	/** Commitments			*/
//	private DocLine[]		m_commitments = null;

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

		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID (as.getC_Currency_ID());
		boolean isInterOrg = isInterOrg(as);

		/**	Needs to be handled in PO Matching as no Receipt info
		if (m_pc.isService())
		{
			log.fine("Service - skipped");
			return fact;
		}
		**/


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
		if (m_matchInv.getReversal_ID() > 0) 
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
			if (m_matchInv.getReversal_ID() > 0)
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
			if (m_matchInv.getReversal_ID() > 0)
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
				cr.setQty(getQty().multiply(multiplier).negate());
			}
		}
		
		// Rounding correction
		if (m_receiptLine != null && m_invoiceLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())	//	in foreign currency
		{
			p_Error = createReceiptGainLoss(as, fact, getAccount(Doc.ACCTTYPE_NotInvoicedReceipts, as), m_receiptLine.getParent(), dr.getAmtSourceDr(), dr.getAmtAcctDr());
			if (p_Error != null)
				return null;
		}
		if (m_invoiceLine != null && m_invoiceLine.getParent().getC_Currency_ID() != as.getC_Currency_ID())	//	in foreign currency
		{
			p_Error = createInvoiceGainLoss(as, fact, expense, m_invoiceLine.getParent(), cr.getAmtSourceCr(), cr.getAmtAcctCr());
			if (p_Error != null)
				return null;
		}
		
		if (m_matchInv.getReversal_ID() == 0) 
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
			
			line = fact.createLine(null, account, as.getC_Currency_ID(), ipv);
			updateFactLine(line);
		} else if (X_M_Cost.COSTINGMETHOD_AverageInvoice.equals(costingMethod) && !zeroQty) {
			FactLine line = fact.createLine(null,
					m_pc.getAccount(ProductCost.ACCTTYPE_P_IPV, as),
					as.getC_Currency_ID(), ipv.negate());
			updateFactLine(line);
			
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

	// Elaine 2008/6/20	
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
	
	public ArrayList<Fact> createCreditMemoFacts(MAcctSchema as) {
		ArrayList<Fact> facts = new ArrayList<Fact>();
		
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
			if (m_matchInv.getReversal_ID() > 0)
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
			if (m_matchInv.getReversal_ID() > 0)
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
				dr.setQty(getQty().multiply(multiplier).negate());
			}
		}
		if (m_matchInv.getReversal_ID() == 0) 
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
			if (m_matchInv.getReversal_ID() > 0)
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
			if (m_matchInv.getReversal_ID() > 0)
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
				cr.setQty(getQty().multiply(multiplier).negate());
			}
		}
		if (m_matchInv.getReversal_ID() == 0) 
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

			if (debit.compareTo(credit) == 0) {
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
	
	private String createInvoiceGainLoss(MAcctSchema as, Fact fact, MAccount acct, 
			MInvoice invoice, BigDecimal matchInvSource, BigDecimal matchInvAccounted)
	{
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
		
		if (m_matchInv.getReversal_ID() == 0 || m_matchInv.get_ID() < m_matchInv.getReversal_ID())
		{
			String matchInvLineSql = "SELECT M_MatchInv_ID FROM M_MatchInv "
					+ "WHERE C_InvoiceLine_ID IN (SELECT C_InvoiceLine_ID FROM C_InvoiceLine WHERE C_Invoice_ID=?) "
					+ "AND COALESCE(Reversal_ID,0)=0";
			List<List<Object>> list  = DB.getSQLArrayObjectsEx(getTrxName(), matchInvLineSql, invoice.get_ID());
			StringBuffer s = new StringBuffer();
			
			if (list == null)
				return null;
			
			for (int index=0; index < list.size(); index++)
			{
				List<Object> l = list.get(index);
				s.append(l.get(0));
				if (index != list.size()-1)
					s.append(",");
			}
			
			sql = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID IN (").append(s).append(")")
				.append(" AND Record_ID <> ?")
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND Account_ID=?")
				.append(" AND PostingType='A'");
		}
		else
		{
			sql = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID IN (").append(m_matchInv.getReversal_ID()).append(")")
				.append(" AND Record_ID <> ?")
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND Account_ID=?")
				.append(" AND PostingType='A'");
		}
		
		BigDecimal acctDifference = null;	//	gain is negative
		// For Match Invoice
		valuesInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
				MMatchInv.Table_ID, get_ID(), as.getC_AcctSchema_ID(), acct.getAccount_ID());
		if (valuesInv != null)
		{
			BigDecimal totalAmtSourceDr = (BigDecimal) valuesInv.get(0);
			if (totalAmtSourceDr == null)
				totalAmtSourceDr = Env.ZERO;
			BigDecimal totalAmtAcctDr = (BigDecimal) valuesInv.get(1);
			if (totalAmtAcctDr == null)
				totalAmtAcctDr = Env.ZERO;
			BigDecimal totalAmtSourceCr = (BigDecimal) valuesInv.get(2);
			if (totalAmtSourceCr == null)
				totalAmtSourceCr = Env.ZERO;
			BigDecimal totalAmtAcctCr = (BigDecimal) valuesInv.get(3);
			if (totalAmtAcctCr == null)
				totalAmtAcctCr = Env.ZERO;
			
			if (totalAmtSourceDr.signum() == 0 && totalAmtAcctDr.signum() == 0)
			{
				matchInvSource = matchInvSource.add(totalAmtSourceCr);
				matchInvAccounted = matchInvAccounted.add(totalAmtAcctCr);
			}
			else if (totalAmtSourceCr.signum() == 0 && totalAmtAcctCr.signum() == 0)
			{
				matchInvSource = matchInvSource.add(totalAmtSourceDr);
				matchInvAccounted = matchInvAccounted.add(totalAmtAcctDr);
			}
			else
			{
				if (totalAmtAcctDr.compareTo(totalAmtAcctCr) > 0)
				{
					matchInvSource = matchInvSource.add(totalAmtSourceDr);
					matchInvAccounted = matchInvAccounted.add(totalAmtAcctDr);
					acctDifference = totalAmtAcctCr.negate();
				}
				else
				{
					matchInvSource = matchInvSource.add(totalAmtSourceCr);
					matchInvAccounted = matchInvAccounted.add(totalAmtAcctCr);
					acctDifference = totalAmtSourceDr.negate();
				}
			}
		}
		
		StringBuilder description = new StringBuilder("Invoice=(").append(invoice.getC_Currency_ID()).append(")").append(invoiceSource).append("/").append(invoiceAccounted)
				.append(" - MatchInv=(").append(getC_Currency_ID()).append(")").append(matchInvSource).append("/").append(matchInvAccounted);
			if (log.isLoggable(Level.FINE)) log.fine(description.toString());
		//

		//	Full Payment in currency
		if (acctDifference == null && matchInvSource.compareTo(invoiceSource) == 0)
		{
			acctDifference = matchInvAccounted.subtract(invoiceAccounted.abs());	//	gain is negative
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
		if (invoice.isSOTrx())
		{
			FactLine fl = fact.createLine (null, acct, as.getC_Currency_ID(), acctDifference.negate());
			fl.setDescription(description.toString());
			updateFactLine(fl);

			if (as.isCurrencyBalancing() && as.getC_Currency_ID() != invoice.getC_Currency_ID()) {
				fl = fact.createLine (null, as.getCurrencyBalancing_Acct(), as.getC_Currency_ID(), acctDifference);
			} else {
				fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), acctDifference);
			}
			fl.setDescription(description.toString());
			updateFactLine(fl);
		}
		else
		{
			FactLine fl = fact.createLine (null, acct, as.getC_Currency_ID(), acctDifference);
			fl.setDescription(description.toString());
			updateFactLine(fl);
			
			if (as.isCurrencyBalancing() && as.getC_Currency_ID() != invoice.getC_Currency_ID()) {
				fl = fact.createLine (null, as.getCurrencyBalancing_Acct(), as.getC_Currency_ID(), acctDifference.negate());
			} else {
				fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), acctDifference.negate());
			}
			fl.setDescription(description.toString());
			updateFactLine(fl);
		}
		return null;
	}	//	createInvoiceGainLoss
	
	private String createReceiptGainLoss(MAcctSchema as, Fact fact, MAccount acct, 
			MInOut receipt, BigDecimal matchInvSource, BigDecimal matchInvAccounted)
	{
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
		if (m_matchInv.getReversal_ID() == 0 || m_matchInv.get_ID() < m_matchInv.getReversal_ID())
		{
			String matchInvLineSql = "SELECT M_MatchInv_ID FROM M_MatchInv "
					+ "WHERE M_InOutLine_ID IN (SELECT M_InOutLine_ID FROM M_InOutLine WHERE M_InOut_ID=?) "
					+ "AND COALESCE(Reversal_ID,0)=0";
			List<List<Object>> list  = DB.getSQLArrayObjectsEx(getTrxName(), matchInvLineSql, receipt.get_ID());
			StringBuffer s = new StringBuffer();
			
			if (list == null)
				return null;
			
			for (int index=0; index < list.size(); index++)
			{
				List<Object> l = list.get(index);
				s.append(l.get(0));
				if (index != list.size()-1)
					s.append(",");
			}
	
			
			sql = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID IN (").append(s).append(")")
				.append(" AND Record_ID <> ?")
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND Account_ID=?")
				.append(" AND PostingType='A'");
		}
		else
		{
			sql = new StringBuilder()
				.append("SELECT SUM(AmtSourceDr), SUM(AmtAcctDr), SUM(AmtSourceCr), SUM(AmtAcctCr)")
				.append(" FROM Fact_Acct ")
				.append("WHERE AD_Table_ID=? AND Record_ID IN (").append(m_matchInv.getReversal_ID()).append(")")
				.append(" AND Record_ID <> ?")
				.append(" AND C_AcctSchema_ID=?")
				.append(" AND Account_ID=?")
				.append(" AND PostingType='A'");
		}
		
		BigDecimal acctDifference = null;	//	gain is negative
		// For Match Invoice
		valuesInv = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(),
				MMatchInv.Table_ID, get_ID(), as.getC_AcctSchema_ID(), acct.getAccount_ID());
		if (valuesInv != null)
		{
			BigDecimal totalAmtSourceDr = (BigDecimal) valuesInv.get(0);
			if (totalAmtSourceDr == null)
				totalAmtSourceDr = Env.ZERO;
			BigDecimal totalAmtAcctDr = (BigDecimal) valuesInv.get(1);
			if (totalAmtAcctDr == null)
				totalAmtAcctDr = Env.ZERO;
			BigDecimal totalAmtSourceCr = (BigDecimal) valuesInv.get(2);
			if (totalAmtSourceCr == null)
				totalAmtSourceCr = Env.ZERO;
			BigDecimal totalAmtAcctCr = (BigDecimal) valuesInv.get(3);
			if (totalAmtAcctCr == null)
				totalAmtAcctCr = Env.ZERO;
			
			if (totalAmtSourceDr.signum() == 0 && totalAmtAcctDr.signum() == 0)
			{
				matchInvSource = matchInvSource.add(totalAmtSourceCr);
				matchInvAccounted = matchInvAccounted.add(totalAmtAcctCr);
			}
			else if (totalAmtSourceCr.signum() == 0 && totalAmtAcctCr.signum() == 0)
			{
				matchInvSource = matchInvSource.add(totalAmtSourceDr);
				matchInvAccounted = matchInvAccounted.add(totalAmtAcctDr);
			}
			else
			{
				if (m_matchInv.getReversal_ID() == 0 || m_matchInv.get_ID() < m_matchInv.getReversal_ID())
				{
					if (totalAmtAcctDr.compareTo(totalAmtAcctCr) > 0)
					{
						matchInvSource = matchInvSource.add(totalAmtSourceDr);
						matchInvAccounted = matchInvAccounted.add(totalAmtAcctDr).subtract(totalAmtAcctCr);
					}
					else
					{
						matchInvSource = matchInvSource.add(totalAmtSourceCr);
						matchInvAccounted = matchInvAccounted.add(totalAmtAcctCr).subtract(totalAmtAcctDr);
					}
				}
				else
				{
					if (totalAmtAcctDr.compareTo(totalAmtAcctCr) > 0)
					{
						matchInvSource = matchInvSource.add(totalAmtSourceDr);
						matchInvAccounted = matchInvAccounted.add(totalAmtAcctDr);
						acctDifference = totalAmtAcctCr.negate();
					}
					else
					{
						matchInvSource = matchInvSource.add(totalAmtSourceCr);
						matchInvAccounted = matchInvAccounted.add(totalAmtAcctCr);
						acctDifference = totalAmtAcctDr.negate();
					}					
				}
			}
		}
				
		StringBuilder description = new StringBuilder("InOut=(").append(m_invoiceLine.getParent().getC_Currency_ID()).append(")").append(receiptSource).append("/").append(receiptAccounted)
			.append(" - MatchInv=(").append(getC_Currency_ID()).append(")").append(matchInvSource).append("/").append(matchInvAccounted);
		if (log.isLoggable(Level.FINE)) log.fine(description.toString());

		//	Full Payment in currency
		if (acctDifference == null && matchInvSource.compareTo(receiptSource) == 0)
		{
			acctDifference = matchInvAccounted.subtract(receiptAccounted.abs());	//	gain is negative
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
		if (!receipt.isSOTrx())
		{
			FactLine fl = fact.createLine (null, acct, as.getC_Currency_ID(), acctDifference.negate());
			fl.setDescription(description.toString());
			updateFactLine(fl);

			if (as.isCurrencyBalancing() && as.getC_Currency_ID() != m_invoiceLine.getParent().getC_Currency_ID()) {
				fl = fact.createLine (null, as.getCurrencyBalancing_Acct(), as.getC_Currency_ID(), acctDifference);
			} else {
				fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), acctDifference);
			}
			fl.setDescription(description.toString());
			updateFactLine(fl);
		}
		else
		{
			FactLine fl = fact.createLine (null, acct, as.getC_Currency_ID(), acctDifference);
			fl.setDescription(description.toString());
			updateFactLine(fl);
			
			if (as.isCurrencyBalancing() && as.getC_Currency_ID() != m_invoiceLine.getParent().getC_Currency_ID()) {
				fl = fact.createLine (null, as.getCurrencyBalancing_Acct(), as.getC_Currency_ID(), acctDifference.negate());
			} else {
				fl = fact.createLine (null, loss, gain, as.getC_Currency_ID(), acctDifference.negate());
			}
			fl.setDescription(description.toString());
			updateFactLine(fl);
		}
		return null;
	}	//	createReceiptGainLoss
}   //  Doc_MatchInv
