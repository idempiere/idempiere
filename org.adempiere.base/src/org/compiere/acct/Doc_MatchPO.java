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
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAcctSchemaElement;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCurrency;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MMatchPO;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MProduct;
import org.compiere.model.MTax;
import org.compiere.model.ProductCost;
import org.compiere.model.X_M_InOut;
import org.compiere.util.Env;

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
		return null;
	}   //  loadDocumentDetails


	/**************************************************************************
	 *  Get Source Currency Balance - subtracts line and tax amounts from total - no rounding
	 *  @return Zero - always balanced
	 */
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

		if (m_M_InOutLine_ID == 0)	//  No posting if not matched to Shipment
		{
			p_Error = "No posting if not matched to Shipment";
			return null;
		}

		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID(as.getC_Currency_ID());
		boolean isInterOrg = isInterOrg(as);

		//	Purchase Order Line
		BigDecimal poCost = m_oLine.getPriceCost();
		if (poCost == null || poCost.signum() == 0)
			poCost = m_oLine.getPriceActual();

		MInOutLine receiptLine = new MInOutLine (getCtx(), m_M_InOutLine_ID, getTrxName());
		MInOut inOut = receiptLine.getParent();
		boolean isReturnTrx = inOut.getMovementType().equals(X_M_InOut.MOVEMENTTYPE_VendorReturns);

		// calculate po cost
		poCost = poCost.multiply(getQty());			//	Delivered so far

		//	Different currency
		if (m_oLine.getC_Currency_ID() != as.getC_Currency_ID())
		{
			MOrder order = m_oLine.getParent();
			Timestamp dateAcct = order.getDateAcct();
			BigDecimal rate = MConversionRate.getRate(
				order.getC_Currency_ID(), as.getC_Currency_ID(),
				dateAcct, order.getC_ConversionType_ID(),
				m_oLine.getAD_Client_ID(), m_oLine.getAD_Org_ID());
			if (rate == null)
			{
				p_Error = "Purchase Order not convertible - " + as.getName();
				return null;
			}
			poCost = poCost.multiply(rate);
			if (poCost.scale() > as.getCostingPrecision())
				poCost = poCost.setScale(as.getCostingPrecision(), BigDecimal.ROUND_HALF_UP);
		}

		String costingError = createMatchPOCostDetail(as);
		if (costingError != null && costingError.trim().length() > 0) 
		{
			p_Error = costingError;
			return null;
		}
		
		//	Calculate PPV for standard costing
		MProduct product = MProduct.get(getCtx(), getM_Product_ID());
		String costingMethod = product.getCostingMethod(as);
		//get standard cost and also make sure cost for other costing method is updated
		BigDecimal costs = m_pc.getProductCosts(as, getAD_Org_ID(),
			MAcctSchema.COSTINGMETHOD_StandardCosting, m_C_OrderLine_ID, false);	//	non-zero costs

		if (MAcctSchema.COSTINGMETHOD_StandardCosting.equals(costingMethod))
		{
			if (m_matchPO.getReversal_ID() > 0)
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
					if (!dr.updateReverseLine(MMatchPO.Table_ID, m_matchPO.getM_MatchPO_ID(), 0, Env.ONE)) 
					{
						p_Error = "Failed to create reversal entry for ACCTTYPE_PPVOffset";
						return null;
					}
				}
			}
			else
			{
				//	No Costs yet - no PPV
				if (costs == null || costs.signum() == 0)
				{
					p_Error = "Resubmit - No Costs for " + product.getName();
					log.log(Level.SEVERE, p_Error);
					return null;
				}
	
				//	Difference
				BigDecimal difference = poCost.subtract(costs);
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

	/** Verify if the posting involves two or more organizations
	@return true if there are more than one org involved on the posting
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

	// Elaine 2008/6/20	
	private String createMatchPOCostDetail(MAcctSchema as)
	{
		if (m_ioLine != null && m_ioLine.getM_InOutLine_ID() > 0 &&
			m_oLine != null && m_oLine.getC_OrderLine_ID() > 0)
		{
			MMatchPO mMatchPO = (MMatchPO) getPO(); 
			
			// Purchase Order Line
			BigDecimal poCost = m_oLine.getPriceCost();
			if (poCost == null || poCost.signum() == 0)
			{
				poCost = m_oLine.getPriceActual();
				//	Goodwill: Correct included Tax
		    	int C_Tax_ID = m_oLine.getC_Tax_ID();
				if (m_oLine.isTaxIncluded() && C_Tax_ID != 0)
				{
					MTax tax = MTax.get(getCtx(), C_Tax_ID);
					if (!tax.isZeroTax())
					{
						int stdPrecision = MCurrency.getStdPrecision(getCtx(), m_oLine.getC_Currency_ID());
						BigDecimal costTax = tax.calculateTax(poCost, true, stdPrecision);
						if (log.isLoggable(Level.FINE)) log.fine("Costs=" + poCost + " - Tax=" + costTax);
						poCost = poCost.subtract(costTax);
					}
				}	//	correct included Tax
			}
									
			// Source from Doc_MatchPO.createFacts(MAcctSchema)
			MInOut inOut = m_ioLine.getParent(); 
			boolean isReturnTrx = inOut.getMovementType().equals(X_M_InOut.MOVEMENTTYPE_VendorReturns);

			//	Create PO Cost Detail Record first
			// MZ Goodwill
			// Create Cost Detail Matched PO using Total Amount and Total Qty based on OrderLine
			MMatchPO[] mPO = MMatchPO.getOrderLine(getCtx(), m_oLine.getC_OrderLine_ID(), getTrxName());
			BigDecimal tQty = Env.ZERO;
			BigDecimal tAmt = Env.ZERO;
			for (int i = 0 ; i < mPO.length ; i++)
			{
				if (mPO[i].getM_AttributeSetInstance_ID() == mMatchPO.getM_AttributeSetInstance_ID()
					&& mPO[i].getM_MatchPO_ID() != mMatchPO.getM_MatchPO_ID())
				{
					BigDecimal qty = (isReturnTrx ? mPO[i].getQty().negate() : mPO[i].getQty()); 
					tQty = tQty.add(qty);
					tAmt = tAmt.add(poCost.multiply(qty));
				}
			}
			
			poCost = poCost.multiply(getQty());			//	Delivered so far
			tAmt = tAmt.add(isReturnTrx ? poCost.negate() : poCost);
			tQty = tQty.add(isReturnTrx ? getQty().negate() : getQty());
					
			//	Different currency
			if (m_oLine.getC_Currency_ID() != as.getC_Currency_ID())
			{
				MOrder order = m_oLine.getParent();
				Timestamp dateAcct = order.getDateAcct();
				//get costing method for product
				MProduct product = MProduct.get(getCtx(), getM_Product_ID());
				String costingMethod = product.getCostingMethod(as);					
				if (MAcctSchema.COSTINGMETHOD_AveragePO.equals(costingMethod) ||
						MAcctSchema.COSTINGMETHOD_LastPOPrice.equals(costingMethod) )
					dateAcct = inOut.getDateAcct(); 	//Movement Date
				//
				BigDecimal rate = MConversionRate.getRate(
					order.getC_Currency_ID(), as.getC_Currency_ID(),
					dateAcct, order.getC_ConversionType_ID(),
					m_oLine.getAD_Client_ID(), m_oLine.getAD_Org_ID());
				if (rate == null)
				{
					return "Purchase Order not convertible - " + as.getName();
				}
				poCost = poCost.multiply(rate);
				if (poCost.scale() > as.getCostingPrecision())
					poCost = poCost.setScale(as.getCostingPrecision(), BigDecimal.ROUND_HALF_UP);
				tAmt = tAmt.multiply(rate);
				if (tAmt.scale() > as.getCostingPrecision())
					tAmt = tAmt.setScale(as.getCostingPrecision(), BigDecimal.ROUND_HALF_UP);			
			}
			
			// Set Total Amount and Total Quantity from Matched PO 
			if (!MCostDetail.createOrder(as, m_oLine.getAD_Org_ID(), 
					getM_Product_ID(), mMatchPO.getM_AttributeSetInstance_ID(),
					m_oLine.getC_OrderLine_ID(), 0,		//	no cost element
					tAmt, tQty,			//	Delivered
					m_oLine.getDescription(), getTrxName()))
			{
				return "SaveError";
			}
			// end MZ
		}
		return "";
	}

}   //  Doc_MatchPO
