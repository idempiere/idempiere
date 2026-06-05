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
package org.idempiere.acct.doc;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCurrency;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInOutLineMA;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MMatchPO;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLandedCost;
import org.compiere.model.MOrderLandedCostAllocation;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MTax;
import org.compiere.model.MatchPOAutoMatch;
import org.compiere.model.ProductCost;
import org.compiere.model.X_M_InOut;
import org.compiere.process.DocAction;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;

/**
 *  Post MatchPO Documents.
 *  <pre>
 *  Table:              C_MatchPO (473)
 *  Document Types:     MXP
 *  </pre>
 *  @author Jorg Janke
 *  @version  $Id: Doc_MatchPO.java,v 1.3 2006/07/30 00:53:33 jjanke Exp $
 */
public class Doc_MatchPO extends Doc
{
	/**
	 *  Constructor
	 * 	@param as accounting schemata
	 * 	@param rs record
	 * 	@param trxName trx
	 */	
	public Doc_MatchPO (MAcctSchema as, ResultSet rs, String trxName)
	{
		super(as, MMatchPO.class, rs, DOCTYPE_MatMatchPO, trxName);
	}   //  Doc_MatchPO

	private int         m_C_OrderLine_ID = 0;
	private MOrderLine	m_oLine = null;
	//
	private int         m_M_InOutLine_ID = 0;
	private MInOutLine		m_ioLine = null;
	@SuppressWarnings("unused")
	private int         m_C_InvoiceLine_ID = 0;

	private ProductCost m_pc;
	private int			m_M_AttributeSetInstance_ID = 0;
	private MMatchPO m_matchPO;
	private boolean 			m_deferPosting = false;

	/**
	 *  Load Specific Document Details
	 *  @return error message or null
	 */
	protected String loadDocumentDetails ()
	{
		setC_Currency_ID (Doc.NO_CURRENCY);
		m_matchPO = (MMatchPO)getPO();
		setDateDoc(m_matchPO.getDateTrx());
		//
		m_M_AttributeSetInstance_ID = m_matchPO.getM_AttributeSetInstance_ID();
		setQty (m_matchPO.getQty());
		//
		m_C_OrderLine_ID = m_matchPO.getC_OrderLine_ID();
		m_oLine = new MOrderLine (getCtx(), m_C_OrderLine_ID, getTrxName());
		//
		m_M_InOutLine_ID = m_matchPO.getM_InOutLine_ID();
		m_ioLine = new MInOutLine (getCtx(), m_M_InOutLine_ID, getTrxName());

		m_C_InvoiceLine_ID = m_matchPO.getC_InvoiceLine_ID();

		//
		m_pc = new ProductCost (Env.getCtx(),
			getM_Product_ID(), m_M_AttributeSetInstance_ID, getTrxName());
		m_pc.setQty(getQty());		
		
		if (m_M_InOutLine_ID == 0)
		{
			List<MMatchPO> noInvoiceLines = new ArrayList<MMatchPO>();
			Map<Integer, BigDecimal[]> noShipmentLines = new HashMap<>();
			Map<Integer, BigDecimal[]> postedNoShipmentLines = new HashMap<>();
			List<MMatchPO> matchPOs = MatchPOAutoMatch.getNotMatchedMatchPOList(getCtx(), m_oLine.getC_OrderLine_ID(), getTrxName());
			for (MMatchPO matchPO : matchPOs)
			{
				if (matchPO.getM_InOutLine_ID() > 0 && matchPO.getC_InvoiceLine_ID() == 0 && matchPO.getReversal_ID()==0)
				{
					MInOutLine iol = new MInOutLine(getCtx(), matchPO.getM_InOutLine_ID(), getTrxName());
					String docStatus = iol.getParent().getDocStatus();
					if (docStatus.equals(DocAction.STATUS_Completed) || docStatus.equals(DocAction.STATUS_Closed)) {
						noInvoiceLines.add(matchPO);
					}
				} 
				else if (matchPO.getM_InOutLine_ID() == 0 && matchPO.getReversal_ID()==0)
				{
					MInvoiceLine invoiceLine = new MInvoiceLine(getCtx(), matchPO.getC_InvoiceLine_ID(), getTrxName());
					String docStatus = invoiceLine.getParent().getDocStatus();
					if (docStatus.equals(DocAction.STATUS_Completed) || docStatus.equals(DocAction.STATUS_Closed)) {
						if (matchPO.isPosted())
							postedNoShipmentLines.put(matchPO.getM_MatchPO_ID(), new BigDecimal[]{matchPO.getQty()});
						else
							noShipmentLines.put(matchPO.getM_MatchPO_ID(), new BigDecimal[]{matchPO.getQty()});
					}
				}
			}
			
			for (MMatchPO matchPO : noInvoiceLines)
			{
				BigDecimal qty = matchPO.getQty();
				for (Integer matchPOId : postedNoShipmentLines.keySet())
				{
					BigDecimal[] qtyHolder = postedNoShipmentLines.get(matchPOId);
					if (qtyHolder[0].compareTo(qty) >= 0)
					{
						qtyHolder[0] = qtyHolder[0].subtract(qty);
						qty = BigDecimal.ZERO;
					} 
					else if (qtyHolder[0].signum() > 0)
					{
						qty = qty.subtract(qtyHolder[0]);
						qtyHolder[0] = BigDecimal.ZERO;
					}
					if (qty.signum() == 0)
						break;
				}
				if (qty.signum() == 0)
					continue;
				for (Integer matchPOId : noShipmentLines.keySet())
				{
					BigDecimal[] qtyHolder = noShipmentLines.get(matchPOId);
					if (qtyHolder[0].compareTo(qty) >= 0)
					{
						qtyHolder[0] = qtyHolder[0].subtract(qty);
						qty = BigDecimal.ZERO;
					} 
					else if (qtyHolder[0].signum() > 0)
					{
						qty = qty.subtract(qtyHolder[0]);
						qtyHolder[0] = BigDecimal.ZERO;
					}
					if (qtyHolder[0].signum() == 0)
					{
						if (matchPOId == m_matchPO.getM_MatchPO_ID())
						{
							m_M_InOutLine_ID = matchPO.getM_InOutLine_ID();
							break;
						}
					}
					if (qty.signum() == 0)
						break;
				}
				if (m_M_InOutLine_ID > 0)
					break;
			}
		}

		if (m_M_InOutLine_ID == 0)	//  Defer posting if not matched to Shipment
		{
			if (m_matchPO.getRef_MatchPO_ID() == 0)
				m_deferPosting = true;
		}
		else
		{
			String posted = DB.getSQLValueStringEx(getTrxName(), "SELECT Posted FROM M_MatchPO WHERE M_MatchPO_ID=?", m_matchPO.getM_MatchPO_ID());
			if (STATUS_Deferred.equals(posted))
			{
				int M_InOut_ID = DB.getSQLValueEx(getTrxName(), "SELECT M_InOut_ID FROM M_InOutLine WHERE M_InOutLine_ID=?", m_M_InOutLine_ID);
				MInOut inout = new MInOut(getCtx(), M_InOut_ID, getTrxName());
				if (inout.getDateAcct().after(m_matchPO.getDateAcct()))
				{
					m_matchPO.setDateAcct(inout.getDateAcct());
					m_matchPO.setDateTrx(inout.getDateAcct());
					setDateAcct(inout.getDateAcct());
					setDateDoc(inout.getDateAcct());
					m_matchPO.saveEx();
				}
			}
		}
		
		return null;
	}   //  loadDocumentDetails


	/**
	 *  Get Source Currency Balance - subtracts line and tax amounts from total - no rounding
	 *  @return Zero - always balanced
	 */
	@Override
	public BigDecimal getBalance()
	{
		return Env.ZERO;
	}   //  getBalance


	/**
	 *  Create Facts (the accounting logic) for
	 *  MXP.
	 *  <pre>
	 *      Product PPV     <difference>
	 *      PPV_Offset                  <difference>
	 *  </pre>
	 *  @param as accounting schema
	 *  @return Fact
	 */
	@Override
	public ArrayList<Fact> createFacts (MAcctSchema as)
	{
		ArrayList<Fact> facts = new ArrayList<Fact>();
		//
		if (getM_Product_ID() == 0		//  Nothing to do if no Product
			|| getQty().signum() == 0)
		{
			if (log.isLoggable(Level.FINE)) log.fine("No Product/Qty - M_Product_ID=" + getM_Product_ID()
				+ ",Qty=" + getQty());
			return facts;
		}

		if (m_M_InOutLine_ID == 0)
		{
			MMatchPO[] matchPOs = MMatchPO.getOrderLine(getCtx(), m_oLine.getC_OrderLine_ID(), getTrxName());
			for (MMatchPO matchPO : matchPOs)
			{
				if (matchPO.getM_InOutLine_ID() > 0 && matchPO.getC_InvoiceLine_ID() == 0)
				{
					MInOutLine iol = new MInOutLine(getCtx(), matchPO.getM_InOutLine_ID(), getTrxName());
					String docStatus = iol.getParent().getDocStatus();
					if (docStatus.equals(DocAction.STATUS_Completed) || docStatus.equals(DocAction.STATUS_Closed)) {
						if (matchPO.getQty().compareTo(getQty()) <= 0) {
							m_M_InOutLine_ID = matchPO.getM_InOutLine_ID();
							break;
						}
					}
				}
			}
		}

		if (m_M_InOutLine_ID == 0)	//  No posting if not matched to Shipment
		{
			if (m_matchPO.getRef_MatchPO_ID() > 0)
				return facts;
			
			p_Error = Msg.getMsg(Env.getCtx(), "NoPostingIfNotMatchedToShipment");
			return null;
		}

		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID(as.getC_Currency_ID());
		boolean isInterOrg = isInterOrg(as);

		//	Purchase Order Line
		BigDecimal poCost = m_oLine.getPriceCost();
		if (poCost == null || poCost.signum() == 0)
		{
			poCost = m_oLine.getPriceActual();
			//	Goodwill: Correct included Tax
	    	int C_Tax_ID = m_oLine.getC_Tax_ID();
	    	MTax tax = MTax.get(getCtx(), C_Tax_ID);
	    	int stdPrecision = MCurrency.getStdPrecision(getCtx(), m_oLine.getC_Currency_ID());
			if (m_oLine.isTaxIncluded() && C_Tax_ID != 0)
			{				
				if (!tax.isZeroTax())
				{					
					BigDecimal costTax = tax.calculateTax(poCost, true, stdPrecision);
					if (log.isLoggable(Level.FINE)) log.fine("Costs=" + poCost + " - Tax=" + costTax);
					if (tax.isSummary())
					{
						poCost = poCost.subtract(costTax);
						BigDecimal base = poCost;
						for (MTax childTax : tax.getChildTaxes(false))
						{
							if (!childTax.isZeroTax() && childTax.isDistributeTaxWithLineItem())
							{
								BigDecimal taxAmt = childTax.calculateTax(base, false, stdPrecision);
								poCost = poCost.add(taxAmt);
							}
						}
					}
					else if (!tax.isDistributeTaxWithLineItem())
					{
						poCost = poCost.subtract(costTax);
					}
				}
			}	//	correct included Tax
			else 
			{
				if (tax.isSummary())
				{
					BigDecimal base = poCost;
					for (MTax childTax : tax.getChildTaxes(false)) 
					{
						if (childTax.isDistributeTaxWithLineItem())
						{
							BigDecimal taxAmt = childTax.calculateTax(base, false, stdPrecision);
							poCost = poCost.add(taxAmt);
						}
					}
				}
				else if (tax.isDistributeTaxWithLineItem())
				{
					BigDecimal taxAmt = tax.calculateTax(poCost, false, stdPrecision);
					poCost = poCost.add(taxAmt);
				}
			}
		}

		MInOutLine receiptLine = new MInOutLine (getCtx(), m_M_InOutLine_ID, getTrxName());
		MInOut inOut = receiptLine.getParent();
		boolean isReturnTrx = inOut.getMovementType().equals(X_M_InOut.MOVEMENTTYPE_VendorReturns);

		Map<Integer, BigDecimal> landedCostMap = new LinkedHashMap<Integer, BigDecimal>();
		BigDecimal landedCost = BigDecimal.ZERO;
		int C_OrderLine_ID = m_oLine.getC_OrderLine_ID();
		MOrderLandedCostAllocation[] allocations = MOrderLandedCostAllocation.getOfOrderLine(C_OrderLine_ID, getTrxName());
		for(MOrderLandedCostAllocation allocation : allocations) 
		{
			BigDecimal totalAmt = allocation.getAmt();
			BigDecimal totalQty = allocation.getQty();
			BigDecimal amt = totalAmt.multiply(m_ioLine.getMovementQty()).divide(totalQty, 12, RoundingMode.HALF_UP);			
			if (m_oLine.getC_Currency_ID() != as.getC_Currency_ID())
			{
				MOrder order = m_oLine.getParent();
				Timestamp dateAcct = inOut.getDateAcct();
				BigDecimal rate = MConversionRate.getRate(
					order.getC_Currency_ID(), as.getC_Currency_ID(),
					dateAcct, order.getC_ConversionType_ID(),
					m_oLine.getAD_Client_ID(), m_oLine.getAD_Org_ID());
				if (rate == null)
				{
					p_Error = Msg.getMsg(Env.getCtx(), "PurchaseOrderNotConvertible", new String[] {as.getName()}); 							
					return null;
				}
				amt = amt.multiply(rate);
			}
			// Use absolute qty so landedCostMap always stores a positive per-unit amount.
			// For reversals getQty() is negative; the sign is applied later in createLandedCostAdjustments.
			amt = amt.divide(getQty().abs(), 12, RoundingMode.HALF_UP);
			landedCost = landedCost.add(amt);
			if (landedCost.scale() > as.getCostingPrecision())
				landedCost = landedCost.setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);
			MOrderLandedCost olc = new MOrderLandedCost(getCtx(), allocation.getC_OrderLandedCost_ID(), getTrxName());
			int elementId = olc.getM_CostElement_ID();
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
			
		//	Different currency
		if (m_oLine.getC_Currency_ID() != as.getC_Currency_ID())
		{
			MOrder order = m_oLine.getParent();
			Timestamp dateAcct = inOut.getDateAcct();
			BigDecimal rate = MConversionRate.getRate(
				order.getC_Currency_ID(), as.getC_Currency_ID(),
				dateAcct, order.getC_ConversionType_ID(),
				m_oLine.getAD_Client_ID(), m_oLine.getAD_Org_ID());
			if (rate == null)
			{
				p_Error = Msg.getMsg(Env.getCtx(), "PurchaseOrderNotConvertible", new String[] {as.getName()});
				return null;
			}
			poCost = poCost.multiply(rate);
			if (poCost.scale() > as.getCostingPrecision())
				poCost = poCost.setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);
		}

		String costingError = createMatchPOCostDetail(as, poCost, landedCostMap);
		if (costingError != null && costingError.trim().length() > 0) 
		{
			p_Error = costingError;
			return null;
		}
		
		// calculate po cost
		BigDecimal deliveredCost = poCost.multiply(getQty());			//	Delivered so far
		BigDecimal totalCost = deliveredCost.add(landedCost);
		
		//	Calculate PPV for standard costing
		MProduct product = MProduct.get(getCtx(), getM_Product_ID());
		String costingMethod = product.getCostingMethod(as);
		//get standard cost and also make sure cost for other costing method is updated
		BigDecimal costs = m_pc.getProductCosts(as, getAD_Org_ID(),
			MAcctSchema.COSTINGMETHOD_StandardCosting, m_C_OrderLine_ID, false, 
			getDateAcct(), (MCostDetail) null, isInBackDatePostingProcess());	//	non-zero costs

		if (MAcctSchema.COSTINGMETHOD_StandardCosting.equals(costingMethod))
		{
			if (m_matchPO.isReversal())
			{
				//  Product PPV
				FactLine cr = fact.createLine(null,
					m_pc.getAccount(ProductCost.ACCTTYPE_P_PPV, as),
					as.getC_Currency_ID(), Env.ONE);
				if (!cr.updateReverseLine(MMatchPO.Table_ID, m_matchPO.getM_MatchPO_ID(), 0, Env.ONE)) 
				{
					fact.remove(cr);
					cr = null;
				}
				if (cr != null)
				{
					//  PPV Offset
					FactLine dr = fact.createLine(null,
						getAccount(Doc.ACCTTYPE_PPVOffset, as), as.getC_Currency_ID(), Env.ONE);
					if (!dr.updateReverseLine(MMatchPO.Table_ID, m_matchPO.getM_MatchPO_ID(), 0, Env.ONE, cr)) 
					{						
						p_Error = Msg.getMsg(Env.getCtx(), "FailedToCreateReversalEntryForACCTTYPE_PPVOffset");
						return null;
					}
				}
			}
			else
			{
				//	No Costs yet - no PPV
				if (costs == null || costs.signum() == 0)
				{
					//ok if purchase price is zero too
					if (m_oLine.getPriceActual().signum() == 0) 
					{
						costs = BigDecimal.ZERO;
					}
					else
					{						
						p_Error = Msg.getMsg(Env.getCtx(), "Resubmit - No Costs for") + product.getName();
						log.log(Level.SEVERE, p_Error);
						return null;
					}
				}
	
				//	Difference
				BigDecimal difference = totalCost.subtract(costs);
				//	Nothing to post
				if (difference.signum() == 0)
				{
					if (log.isLoggable(Level.FINE))log.log(Level.FINE, "No Cost Difference for M_Product_ID=" + getM_Product_ID());
					return facts;
				}
	
				//  Product PPV
				FactLine cr = fact.createLine(null,
					m_pc.getAccount(ProductCost.ACCTTYPE_P_PPV, as),
					as.getC_Currency_ID(), isReturnTrx ? difference.negate() : difference);
				MAccount acct_cr = null;
				if (cr != null)
				{
					cr.setQty(isReturnTrx ? getQty().negate() : getQty());
					cr.setC_BPartner_ID(m_oLine.getC_BPartner_ID());
					cr.setC_Activity_ID(m_oLine.getC_Activity_ID());
					cr.setC_Campaign_ID(m_oLine.getC_Campaign_ID());
					cr.setC_Project_ID(m_oLine.getC_Project_ID());
					cr.setC_ProjectPhase_ID(m_oLine.getC_ProjectPhase_ID());
					cr.setC_ProjectTask_ID(m_oLine.getC_ProjectTask_ID());
					cr.setC_UOM_ID(m_oLine.getC_UOM_ID());
					cr.setUser1_ID(m_oLine.getUser1_ID());
					cr.setUser2_ID(m_oLine.getUser2_ID());
					cr.setC_Charge_ID(m_oLine.getC_Charge_ID());
					cr.setC_CostCenter_ID(m_oLine.getC_CostCenter_ID());
					cr.setC_Department_ID(m_oLine.getC_Department_ID());
					cr.setM_AttributeSetInstance_ID(m_oLine.getM_AttributeSetInstance_ID());
					acct_cr = cr.getAccount(); // PPV Offset
				}
	
				//  PPV Offset
				FactLine dr = fact.createLine(null,
					getAccount(Doc.ACCTTYPE_PPVOffset, as),
					as.getC_Currency_ID(), isReturnTrx ? difference : difference.negate());
				MAccount acct_db = null;
				if (dr != null)
				{
					dr.setQty(isReturnTrx ? getQty() : getQty().negate());
					dr.setC_BPartner_ID(m_oLine.getC_BPartner_ID());
					dr.setC_Activity_ID(m_oLine.getC_Activity_ID());
					dr.setC_Campaign_ID(m_oLine.getC_Campaign_ID());
					dr.setC_Project_ID(m_oLine.getC_Project_ID());
					dr.setC_ProjectPhase_ID(m_oLine.getC_ProjectPhase_ID());
					dr.setC_ProjectTask_ID(m_oLine.getC_ProjectTask_ID());
					dr.setC_UOM_ID(m_oLine.getC_UOM_ID());
					dr.setUser1_ID(m_oLine.getUser1_ID());
					dr.setUser2_ID(m_oLine.getUser2_ID());
					dr.setC_Charge_ID(m_oLine.getC_Charge_ID());
					dr.setC_CostCenter_ID(m_oLine.getC_CostCenter_ID());
					dr.setC_Department_ID(m_oLine.getC_Department_ID());
					dr.setM_AttributeSetInstance_ID(m_oLine.getM_AttributeSetInstance_ID());
					acct_db =  dr.getAccount(); // PPV
				}
				
				// Avoid usage of clearing accounts
				// If both accounts Purchase Price Variance and Purchase Price Variance Offset are equal
				// then remove the posting
	
				if ((!as.isPostIfClearingEqual()) && acct_db!=null && acct_db.equals(acct_cr) && (!isInterOrg)) {
	
					BigDecimal debit = dr.getAmtSourceDr();
					BigDecimal credit = cr.getAmtSourceCr();
	
					if (debit.compareTo(credit) == 0) {
						fact.remove(dr);
						fact.remove(cr);
					}
	
				}
				// End Avoid usage of clearing accounts
			}

			//
			facts.add(fact);
			return facts;
		}
		else
		{
			return facts;
		}
	}   //  createFact

	/** 
	 * Verify if the posting involves two or more organizations
	 * @return true if there are more than one org involved on the posting
	 */
	private boolean isInterOrg(MAcctSchema as) {
		MAcctSchemaElement elementorg = as.getAcctSchemaElement(MAcctSchemaElement.ELEMENTTYPE_Organization);
		if (elementorg == null || !elementorg.isBalanced()) {
			// no org element or not need to be balanced
			return false;
		}

		// verify if org of receipt line is different from org of order line
		// ignoring invoice line org as not used in posting
		if (m_ioLine != null && m_oLine != null
				&& m_ioLine.getAD_Org_ID() != m_oLine.getAD_Org_ID())
			return true;

		return false;
	}

	/**
	 * Creates MCostDetail records for a MatchPO document (product cost and any PO estimated
	 * landed costs such as freight, duty, insurance, etc.).
	 * <p>
	 * For each receipt the method maintains a single cumulative MCostDetail record per
	 * order line / ASI / cost element / accounting date, updating it via the delta mechanism
	 * when subsequent receipts arrive on the same date.
	 * <p>
	 * <b>Landed cost handling:</b> PO estimated landed costs (M_OrderLandedCost) are stored
	 * as separate MCostDetail records keyed by their cost element (M_CostElement_ID &gt; 0).
	 * The amount passed is the cumulative total (unitAmt &times; cumulativeQty) so that
	 * MCostDetail.process() can derive the correct per-unit cost via setWeightedAverage.
	 * <p>
	 * <b>Reversal handling:</b> The product cost detail is created first so that MCost
	 * reflects the post-reversal state before the landed cost details are processed.
	 * For Batch/Lot costing the per-ASI cumulative totals (asiTotals) are passed to
	 * createLandedCostAdjustments so each lot's landed cost is proportional to its own
	 * cumulative quantity rather than a ratio of the current receipt's MA split.
	 *
	 * @param as           accounting schema
	 * @param poCost       PO unit cost (product only, already currency-converted)
	 * @param landedCostMap map of M_CostElement_ID to per-unit landed cost amount
	 * @return error message, or empty string on success
	 */
	private String createMatchPOCostDetail(MAcctSchema as, BigDecimal poCost, Map<Integer, BigDecimal> landedCostMap)
	{
		if (m_ioLine != null && m_ioLine.getM_InOutLine_ID() > 0 &&
			m_oLine != null && m_oLine.getC_OrderLine_ID() > 0)
		{
			MMatchPO mMatchPO = (MMatchPO) getPO(); 
			
			// Fetch all MatchPO records for same OrderLine
			MMatchPO[] mPO = MMatchPO.getOrderLine(getCtx(), m_oLine.getC_OrderLine_ID(), getTrxName());

			// Preserve original unit cost
			BigDecimal unitCost = poCost;

			// tQty/tAmt represent cumulative totals BEFORE current MatchPO
			BigDecimal tQty = Env.ZERO;
			BigDecimal tAmt = Env.ZERO;
			
			// Build cumulative totals from previous MatchPOs
			// During reversal exclude the original reversed MatchPO
			for (int i = 0 ; i < mPO.length ; i++)
			{
				// Keep aggregation window aligned with MCostDetail DateAcct key. Only accumulate
				// MatchPO records posted on the same accounting date.
				// During reversal exclude the original reversed MatchPO itself, otherwise reversal
				// recalculates from an already-to-be-reversed state.
				if (mPO[i].getM_AttributeSetInstance_ID() == mMatchPO.getM_AttributeSetInstance_ID()
					&& mPO[i].getM_MatchPO_ID() != mMatchPO.getM_MatchPO_ID()
					&& TimeUtil.isSameDay(mPO[i].getDateAcct(), mMatchPO.getDateAcct())
					&& !(mMatchPO.isReversal() && mMatchPO.getReversal_ID() > 0 && mPO[i].getM_MatchPO_ID() == mMatchPO.getReversal_ID()))
				{
					BigDecimal qty = mPO[i].getQty();
					BigDecimal orderCost = BigDecimal.ZERO;
					if (mPO[i].getM_InOutLine_ID() > 0)
					{
						tQty = tQty.add(qty);
						//IDEMPIERE-3742  Wrong product cost for partial MR
						if (m_oLine.getC_Currency_ID() != as.getC_Currency_ID())
						{
							MOrder order = m_oLine.getParent();
							MProduct product = new MProduct(getCtx(), m_oLine.getM_Product_ID(), getTrxName());
							if(MAcctSchema.COSTINGMETHOD_AveragePO.equals(product.getCostingMethod(as))) 
							{
								MInOutLine iol = new MInOutLine(getCtx(), mPO[i].getM_InOutLine_ID(), getTrxName());
								MOrderLine ol = new MOrderLine(getCtx(), iol.getC_OrderLine_ID(), getTrxName());
								orderCost = ol.getPriceActual();
								Timestamp dateAcct = iol.getParent().getDateAcct();
								BigDecimal rate = MConversionRate.getRate(
									order.getC_Currency_ID(), as.getC_Currency_ID(),
									dateAcct, order.getC_ConversionType_ID(),
									m_oLine.getAD_Client_ID(), m_oLine.getAD_Org_ID());
								if (rate == null)
								{
									p_Error = "Purchase Order not convertible - " + as.getName();
									return null;
								}
								orderCost = orderCost.multiply(rate);
								tAmt = tAmt.add(orderCost.multiply(qty));
							} else {
								tAmt = tAmt.add(poCost.multiply(qty));
							}
						} else {
							tAmt = tAmt.add(poCost.multiply(qty));
						}
					}
				}
			}

			// currentQty/currentAmt represent ONLY current document delta
			BigDecimal currentQty = mMatchPO.isReversal() ? tQty : getQty();
			BigDecimal currentAmt = Env.ZERO;

			if (mMatchPO.isReversal()) {

				// For reversals:
				// tQty/tAmt already exclude reversed MatchPO,
				// therefore they represent final cumulative state
				poCost = poCost.multiply(tQty);

				// Replace cumulative amount instead of adding.
				// tAmt carries product cost only — landed costs are handled
				// separately by createLandedCostAdjustments below.
				tAmt = poCost;

				// Current reversal delta used for MA redistribution
				currentAmt = getQty().multiply(unitCost);

			} else {

				// Normal receipt accumulation
				poCost = poCost.multiply(getQty());

				tAmt = tAmt.add(poCost);
				tQty = tQty.add(getQty());

				currentAmt = poCost;
			}

			// Enforce costing precision
			if (tAmt.scale() > as.getCostingPrecision())
				tAmt = tAmt.setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);

			MProduct product = MProduct.get(getCtx(), getM_Product_ID());

			MInOutLineMA mas[] = null;

			// Batch/Lot costing requires ASI redistribution
			if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(product.getCostingLevel(as))
				&& mMatchPO.getM_AttributeSetInstance_ID() == 0)
			{
				mas = MInOutLineMA.get(getCtx(), m_ioLine.get_ID(), getTrxName());
			}

			// asiTotals: per-ASI cumulative [qty, productAmt] map built in the Batch/Lot path.
			// Passed to createLandedCostAdjustments so each lot's landed cost amount is
			// computed from its own cumulative qty rather than a proportional share of tQty.
			Map<Integer, BigDecimal[]> asiTotals = null;

			if (mas != null && mas.length > 0)
			{
				// key = ASI, value = [qty, amt]
				asiTotals = new LinkedHashMap<Integer, BigDecimal[]>();

				// Rebuild cumulative ASI totals from previous same-day receipts
				// using EACH receipt's own MA distribution
				for (int i = 0 ; i < mPO.length ; i++)
				{
					if (mPO[i].getM_MatchPO_ID() == mMatchPO.getM_MatchPO_ID()
						|| mPO[i].getM_InOutLine_ID() == 0
						|| mPO[i].getDateAcct().compareTo(mMatchPO.getDateAcct()) != 0
						|| (mMatchPO.isReversal() && mMatchPO.getReversal_ID() > 0 && mPO[i].getM_MatchPO_ID() == mMatchPO.getReversal_ID()))
						continue;

					BigDecimal qty = mPO[i].getQty();
					BigDecimal orderAmt = Env.ZERO;

					// Rebuild historical receipt amount
					if (m_oLine.getC_Currency_ID() != as.getC_Currency_ID())
					{
						MOrder order = m_oLine.getParent();
						MProduct productPrev = new MProduct(getCtx(), m_oLine.getM_Product_ID(), getTrxName());
						if(MAcctSchema.COSTINGMETHOD_AveragePO.equals(productPrev.getCostingMethod(as))) 
						{
							MInOutLine iol = new MInOutLine(getCtx(), mPO[i].getM_InOutLine_ID(), getTrxName());
							MOrderLine ol = new MOrderLine(getCtx(), iol.getC_OrderLine_ID(), getTrxName());

							BigDecimal orderCost = ol.getPriceActual();
							Timestamp dateAcct = iol.getParent().getDateAcct();
							BigDecimal rate = MConversionRate.getRate(
								order.getC_Currency_ID(), as.getC_Currency_ID(),
								dateAcct, order.getC_ConversionType_ID(),
								m_oLine.getAD_Client_ID(), m_oLine.getAD_Org_ID());
							if (rate == null)
							{
								p_Error = "Purchase Order not convertible - " + as.getName();
								return null;
							}

							orderCost = orderCost.multiply(rate);
							orderAmt = orderCost.multiply(qty);
						} else {
							orderAmt = unitCost.multiply(qty);
						}
					} else {
						orderAmt = unitCost.multiply(qty);
					}

					// Reconstruct ORIGINAL receipt ASI distribution
					MInOutLine prevLine = new MInOutLine(getCtx(), mPO[i].getM_InOutLine_ID(), getTrxName());

					MInOutLineMA[] prevMas = MInOutLineMA.get(getCtx(), prevLine.get_ID(), getTrxName());

					BigDecimal totalPrevQty = prevLine.getMovementQty();
					BigDecimal sumPrevQty = Env.ZERO;
					BigDecimal sumPrevAmt = Env.ZERO;
					for (int k = 0; k < prevMas.length; k++)
					{
						MInOutLineMA prevMA = prevMas[k];
						BigDecimal prevMaQty = prevMA.getMovementQty();
						BigDecimal qtyByASI = Env.ZERO;
						BigDecimal amtByASI = Env.ZERO;

						// Allocate using ORIGINAL MA ratio
						if (totalPrevQty.signum() != 0)
						{
							qtyByASI = qty.multiply(prevMaQty).divide(totalPrevQty, 12, RoundingMode.HALF_UP);
							amtByASI = orderAmt.multiply(prevMaQty).divide(totalPrevQty, as.getCostingPrecision(), RoundingMode.HALF_UP);
						}

						// Last-line remainder protection
						if (k == prevMas.length - 1)
						{
							qtyByASI = qty.subtract(sumPrevQty);
							amtByASI = orderAmt.subtract(sumPrevAmt);
						}
						else
						{
							sumPrevQty = sumPrevQty.add(qtyByASI);
							sumPrevAmt = sumPrevAmt.add(amtByASI);
						}

						BigDecimal[] totals = asiTotals.get(prevMA.getM_AttributeSetInstance_ID());
						if (totals == null)
							totals = new BigDecimal[] { Env.ZERO, Env.ZERO };
						totals[0] = totals[0].add(qtyByASI);
						totals[1] = totals[1].add(amtByASI);
						asiTotals.put(prevMA.getM_AttributeSetInstance_ID(), totals);
					}
				}

				// For normal receipts: add the current receipt's MA-distributed qty/amt to asiTotals.
				// For reversals: asiTotals already holds the final target state (cumulative from all
				// remaining non-reversed receipts). Do not add the reversal delta. Instead, ensure
				// every ASI from the reversed receipt line appears in asiTotals (defaulting to zero)
				// so its MCostDetail is updated even when no prior receipts remain.
				if (mMatchPO.isReversal())
				{
					for (int j = 0; j < mas.length; j++)
					{
						MInOutLineMA ma = mas[j];
						if (!asiTotals.containsKey(ma.getM_AttributeSetInstance_ID()))
							asiTotals.put(ma.getM_AttributeSetInstance_ID(), new BigDecimal[] { Env.ZERO, Env.ZERO });
					}
				}
				else
				{
					BigDecimal sumAmt = Env.ZERO;
					BigDecimal sumQty = Env.ZERO;
					BigDecimal totalIOLineQty = m_ioLine.getMovementQty();
	
					for (int j = 0; j < mas.length; j++)
					{
						MInOutLineMA ma = mas[j];
						BigDecimal maQty = ma.getMovementQty();
						BigDecimal qty = Env.ZERO;
						BigDecimal amt = Env.ZERO;
	
						// IMPORTANT:
						// Only current receipt delta is distributed here
						if (totalIOLineQty.signum() != 0)
						{
							qty = currentQty.multiply(maQty).divide(totalIOLineQty, 12, RoundingMode.HALF_UP);
							amt = currentAmt.multiply(maQty).divide(totalIOLineQty, as.getCostingPrecision(), RoundingMode.HALF_UP);
						}
	
						// Last-line remainder protection
						if (j == mas.length - 1)
						{
							qty = currentQty.subtract(sumQty);
							amt = currentAmt.subtract(sumAmt);
						}
						else
						{
							sumQty = sumQty.add(qty);
							sumAmt = sumAmt.add(amt);
						}
	
						BigDecimal[] totals = asiTotals.get(ma.getM_AttributeSetInstance_ID());
						if (totals == null)
							totals = new BigDecimal[] { Env.ZERO, Env.ZERO };
	
						// Merge current receipt into cumulative ASI totals
						totals[0] = totals[0].add(qty);
						totals[1] = totals[1].add(amt);
						asiTotals.put(ma.getM_AttributeSetInstance_ID(), totals);
					}
				} // !isReversal

				// Persist final ASI cumulative totals
				for (Map.Entry<Integer, BigDecimal[]> entry : asiTotals.entrySet())
				{
					int asiId = entry.getKey();
					BigDecimal[] totals = entry.getValue();
					int Ref_CostDetail_ID = getReversalRefCostDetailID(as, mMatchPO, asiId, 0);
					if (!MCostDetail.createOrder(as, m_oLine.getAD_Org_ID(), 
							getM_Product_ID(), asiId,
							m_oLine.getC_OrderLine_ID(), 0, 		//	no cost element
							totals[1], totals[0], 		//	Delivered
							m_oLine.getDescription(), getDateAcct(), Ref_CostDetail_ID, getTrxName()))
					{
						return "SaveError";
					}
				}
			}
			else
			{
				// Non-ASI costing
				int Ref_CostDetail_ID = getReversalRefCostDetailID(as, mMatchPO, mMatchPO.getM_AttributeSetInstance_ID(), 0);
				// Set Total Amount and Total Quantity from Matched PO
				if (!MCostDetail.createOrder(as, m_oLine.getAD_Org_ID(), 
						getM_Product_ID(), mMatchPO.getM_AttributeSetInstance_ID(),
						m_oLine.getC_OrderLine_ID(), 0,		//	no cost element
						tAmt, tQty,			//	Delivered
						m_oLine.getDescription(), getDateAcct(), Ref_CostDetail_ID, getTrxName()))
				{
					return "SaveError";
				}
			}
			
			// Landed cost adjustment executes AFTER product cost detail creation for
			// both normal receipts and reversals. This ensures MCost already reflects
			// the correct post-receipt/post-reversal qty and price when the freight
			// CD's setWeightedAverage runs.
			{
				String error = createLandedCostAdjustments(as, landedCostMap, mMatchPO, tQty,
						mas != null && mas.length > 0 ? asiTotals : null);
				if (!Util.isEmpty(error))
					return error;
			}
		}

		return "";
	}

	/**
	 * Create cost detail for landed cost adjustment.
	 * <p>
	 * The amount passed to MCostDetail.createOrder must be the CUMULATIVE total
	 * (unitAmt × tQty) so that MCostDetail.process() — which uses setWeightedAverage
	 * with qty=0 (costAdjustment mode) and divides by currentQty — arrives at the
	 * correct per-unit landed cost price.
	 * <p>
	 * For normal receipts:  tQty = cumulative qty including this receipt.
	 * For reversals:        tQty = cumulative qty AFTER reversal (excluding reversed MR).
	 * <p>
	 * For Batch/Lot costing, asiTotals provides the per-ASI cumulative qty so that
	 * each ASI's freight amount = unitAmt × asiCumulativeQty (not a ratio of tQty).
	 *
	 * @param as
	 * @param landedCostMap  map of costElementID → per-unit landed cost amount
	 * @param mMatchPO
	 * @param tQty           cumulative quantity (used for non-ASI path)
	 * @param asiTotals      per-ASI cumulative [qty, amt] map (null for non-ASI path)
	 * @return error message or empty string
	 */
	private String createLandedCostAdjustments(MAcctSchema as,
			Map<Integer, BigDecimal> landedCostMap, MMatchPO mMatchPO,
			BigDecimal tQty, Map<Integer, BigDecimal[]> asiTotals) {

		MProduct product = MProduct.get(getCtx(), getM_Product_ID());
		MInOutLineMA[] mas = null;
		if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(product.getCostingLevel(as))
			&& mMatchPO.getM_AttributeSetInstance_ID() == 0
			&& m_ioLine != null && m_ioLine.get_ID() > 0)
		{
			mas = MInOutLineMA.get(getCtx(), m_ioLine.get_ID(), getTrxName());
		}

		for(Integer elementID : landedCostMap.keySet())
		{
			BigDecimal unitAmt = landedCostMap.get(elementID);

			// amt = unitAmt × tQty (cumulative total), mirroring how the product CD
			// passes tAmt/tQty. MCostDetail.process() uses setWeightedAverage(amt, qty=0)
			// in costAdjustment mode and divides amt by currentQty, so passing the
			// cumulative total ensures the correct per-unit landed cost price.
			//
			// For reversals tQty is the remaining qty after reversal (e.g. 2 after
			// reversing one of two receipts), so amt correctly reflects the new
			// cumulative landed cost total.
			BigDecimal amt = unitAmt.multiply(tQty);

			if (amt.scale() > as.getCostingPrecision())
				amt = amt.setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);

			// qty for the CD record must also be cumulative (tQty) so that the
			// existing CD is updated consistently with the product CD pattern.
			// For both normal receipts and reversals, pass the positive remaining
			// cumulative qty — the delta mechanism in createOrder computes the
			// correct signed difference against the previously stored value.
			BigDecimal baseQty = tQty;

			if (mas != null && mas.length > 0 && asiTotals != null)
			{
				// Batch/Lot path: each ASI gets its own cumulative freight amount
				// = unitAmt × asiCumulativeQty (from asiTotals built by the product CD path).
				// This ensures each lot's freight is proportional to its own cumulative qty,
				// not a ratio of the current receipt's MA split applied to the total.
				for (Map.Entry<Integer, BigDecimal[]> entry : asiTotals.entrySet())
				{
					int asiId = entry.getKey();
					BigDecimal[] totals = entry.getValue();
					BigDecimal asiCumulativeQty = totals[0];

					// Freight cumulative total for this ASI = unitAmt × asiCumulativeQty
					BigDecimal lineAmt = unitAmt.multiply(asiCumulativeQty);
					if (lineAmt.scale() > as.getCostingPrecision())
						lineAmt = lineAmt.setScale(as.getCostingPrecision(), RoundingMode.HALF_UP);

					int Ref_CostDetail_ID = getReversalRefCostDetailID(as, mMatchPO, asiId, elementID);
					if (!MCostDetail.createOrder(as, m_oLine.getAD_Org_ID(),
							getM_Product_ID(), asiId,
							m_oLine.getC_OrderLine_ID(), elementID,
							lineAmt, asiCumulativeQty,
							m_oLine.getDescription(), getDateAcct(), Ref_CostDetail_ID, getTrxName()))
					{
						return "SaveError";
					}
				}
			}
			else if (mas != null && mas.length > 0)
			{
				BigDecimal totalAmt = amt;
				BigDecimal sumAmt = Env.ZERO;
				BigDecimal sumQty = Env.ZERO;
				BigDecimal totalIOLineQty = m_ioLine.getMovementQty();
				// Use current receipt qty for MA proportional distribution (not cumulative tQty)
				BigDecimal currentQty = getQty();

				for (int j = 0; j < mas.length; j++)
				{
					MInOutLineMA ma = mas[j];
					BigDecimal maQty = ma.getMovementQty();
					BigDecimal qty = Env.ZERO;
					BigDecimal lineAmt = Env.ZERO;
					if (totalIOLineQty.signum() != 0)
					{
						qty = currentQty.multiply(maQty).divide(totalIOLineQty, 12, RoundingMode.HALF_UP);
						lineAmt = totalAmt.multiply(maQty).divide(totalIOLineQty, as.getCostingPrecision(), RoundingMode.HALF_UP);
					}
					if (j == mas.length - 1)
					{
						qty = currentQty.subtract(sumQty);
						lineAmt = totalAmt.subtract(sumAmt);
					}
					else
					{
						sumQty = sumQty.add(qty);
						sumAmt = sumAmt.add(lineAmt);
					}

					int Ref_CostDetail_ID = getReversalRefCostDetailID(as, mMatchPO, ma.getM_AttributeSetInstance_ID(), elementID);
					if (!MCostDetail.createOrder(as, m_oLine.getAD_Org_ID(), 
							getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),
							m_oLine.getC_OrderLine_ID(), elementID,
							lineAmt, qty,			//	Delivered
							m_oLine.getDescription(), getDateAcct(), Ref_CostDetail_ID, getTrxName()))
					{
						return "SaveError";
					}
				}
			}
			else
			{
				int Ref_CostDetail_ID = getReversalRefCostDetailID(as, mMatchPO, mMatchPO.getM_AttributeSetInstance_ID(), elementID);
				if (!MCostDetail.createOrder(as, m_oLine.getAD_Org_ID(), 
						getM_Product_ID(), mMatchPO.getM_AttributeSetInstance_ID(),
						m_oLine.getC_OrderLine_ID(), elementID,
						amt, baseQty,			//	Delivered
						m_oLine.getDescription(), getDateAcct(), Ref_CostDetail_ID, getTrxName()))
				{
					return "SaveError";
				}
			}
		}
		return null;
	}

	/**
	* Resolve Ref_CostDetail_ID from the reversal MMatchPO for the given ASI and cost element, if any.
	*/
	private int getReversalRefCostDetailID(MAcctSchema as, MMatchPO mMatchPO, int M_AttributeSetInstance_ID, int costElementID)
	{
		if (mMatchPO.getReversal_ID() > 0 && mMatchPO.get_ID() > mMatchPO.getReversal_ID())
		{
			MMatchPO reversal = new MMatchPO(getCtx(), mMatchPO.getReversal_ID(), getTrxName());
			MCostDetail cd = MCostDetail.getOrder(as, getM_Product_ID(), M_AttributeSetInstance_ID,
					reversal.getC_OrderLine_ID(), costElementID, reversal.getDateAcct(), getTrxName());
			if (cd != null)
				return cd.getM_CostDetail_ID();
		}
		
		return 0;
	} // getReversalRefCostDetailID

	@Override
	public boolean isDeferPosting() {
		return m_deferPosting;
	}
	
}   //  Doc_MatchPO
