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
import java.util.ArrayList;
import java.util.logging.Level;

import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MClient;
import org.compiere.model.MConversionRate;
import org.compiere.model.MCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MDocType;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MProduct;
import org.compiere.model.ProductCost;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 *  Post Inventory Documents.
 *  <pre>
 *  Table:              M_Inventory (321)
 *  Document Types:     MMI
 *  </pre>
 *  @author Jorg Janke
 *  @author Armen Rizal, Goodwill Consulting
 * 			<li>BF [ 1745154 ] Cost in Reversing Material Related Docs
 * 	@author red1
 * 			<li>BF [ 2982994 ]  Internal Use Inventory does not reverse Accts
 *  @version  $Id: Doc_Inventory.java,v 1.3 2006/07/30 00:53:33 jjanke Exp $
 */
public class Doc_Inventory extends Doc
{
	private int				m_Reversal_ID = 0;
	@SuppressWarnings("unused")
	private String			m_DocStatus = "";
	private String parentDocSubTypeInv;

	/**
	 *  Constructor
	 * 	@param as accounting schema
	 * 	@param rs record
	 * 	@param trxName trx
	 */
	public Doc_Inventory (MAcctSchema as, ResultSet rs, String trxName)
	{
		super (as, MInventory.class, rs, DOCTYPE_MatInventory, trxName);
	}   //  Doc_Inventory

	/**
	 *  Load Document Details
	 *  @return error message or null
	 */
	protected String loadDocumentDetails()
	{		
		MInventory inventory = (MInventory)getPO();
		setDateDoc (inventory.getMovementDate());
		setDateAcct(inventory.getMovementDate());
		m_Reversal_ID = inventory.getReversal_ID();//store original (voided/reversed) document
		m_DocStatus = inventory.getDocStatus();
		MDocType dt = MDocType.get(getCtx(), getC_DocType_ID());
		parentDocSubTypeInv = dt.getDocSubTypeInv();
		if (MDocType.DOCSUBTYPEINV_CostAdjustment.equals(parentDocSubTypeInv))
		{
			MClient client = MClient.get(getCtx(), inventory.getAD_Client_ID());
			int C_Currency_ID = client.getAcctSchema().getC_Currency_ID();
			setC_Currency_ID(C_Currency_ID);
		}
		else
		{
			setC_Currency_ID (NO_CURRENCY);
		}
		//	Contained Objects
		p_lines = loadLines(inventory);
		if (log.isLoggable(Level.FINE)) log.fine("Lines=" + p_lines.length);
		return null;
	}   //  loadDocumentDetails

	/**
	 *	Load Invoice Line
	 *	@param inventory inventory
	 *  @return DocLine Array
	 */
	private DocLine[] loadLines(MInventory inventory)
	{		
		ArrayList<DocLine> list = new ArrayList<DocLine>();
		MInventoryLine[] lines = inventory.getLines(false);
		for (int i = 0; i < lines.length; i++)
		{
			MInventoryLine line = lines[i];
			String docSubTypeInv;
			if (Util.isEmpty(parentDocSubTypeInv)) {
				// IDEMPIERE-675: for backward compatibility - to post old documents that could have subtypeinv empty
				if (line.getQtyInternalUse().signum() != 0) {
					docSubTypeInv = MDocType.DOCSUBTYPEINV_InternalUseInventory;
				} else {
					docSubTypeInv = MDocType.DOCSUBTYPEINV_PhysicalInventory;
				}
			} else {
				docSubTypeInv = parentDocSubTypeInv;
			}

			BigDecimal qtyDiff = Env.ZERO;
			BigDecimal amtDiff = Env.ZERO;
			if (MDocType.DOCSUBTYPEINV_InternalUseInventory.equals(docSubTypeInv))
				qtyDiff = line.getQtyInternalUse().negate();
			else if (MDocType.DOCSUBTYPEINV_PhysicalInventory.equals(docSubTypeInv))
				qtyDiff = line.getQtyCount().subtract(line.getQtyBook());
			else if (MDocType.DOCSUBTYPEINV_CostAdjustment.equals(docSubTypeInv))
				amtDiff = line.getNewCostPrice().subtract(line.getCurrentCostPrice());
			//	nothing to post
			if (qtyDiff.signum() == 0 && amtDiff.signum() == 0)
				continue;
			//
			DocLine docLine = new DocLine (line, this);
			docLine.setQty (qtyDiff, false);		// -5 => -5
			if (amtDiff.signum() != 0)
			{				
				docLine.setAmount(amtDiff);
			}
			docLine.setReversalLine_ID(line.getReversalLine_ID());
			if (log.isLoggable(Level.FINE)) log.fine(docLine.toString());
			list.add (docLine);
		}

		//	Return Array
		DocLine[] dls = new DocLine[list.size()];
		list.toArray(dls);
		return dls;
	}	//	loadLines

	/**
	 *  Get Balance
	 *  @return Zero (always balanced)
	 */
	public BigDecimal getBalance()
	{
		BigDecimal retValue = Env.ZERO;
		return retValue;
	}   //  getBalance

	/**
	 *  Create Facts (the accounting logic) for
	 *  MMI.
	 *  <pre>
	 *  Inventory
	 *      Inventory       DR      CR
	 *      InventoryDiff   DR      CR   (or Charge)
	 *  </pre>
	 *  @param as account schema
	 *  @return Fact
	 */
	public ArrayList<Fact> createFacts (MAcctSchema as)
	{
		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID(as.getC_Currency_ID());

		//  Line pointers
		FactLine dr = null;
		FactLine cr = null;

		MInventory inventory = (MInventory) getPO();
		boolean costAdjustment = MDocType.DOCSUBTYPEINV_CostAdjustment.equals(parentDocSubTypeInv);
		String docCostingMethod = inventory.getCostingMethod();
		
		for (int i = 0; i < p_lines.length; i++)
		{
			DocLine line = p_lines[i];
			
			boolean doPosting = true;
			String costingLevel = null;
			MProduct product = null;
			if (costAdjustment)
			{				
				product = line.getProduct();
				String productCostingMethod = product.getCostingMethod(as);
				costingLevel = product.getCostingLevel(as);
				if (!docCostingMethod.equals(productCostingMethod))
				{
					doPosting = false;
				}
			}
			
			BigDecimal costs = null;
			BigDecimal adjustmentDiff = null;
			if (costAdjustment)
			{
				costs = line.getAmtSource();
				int orgId = line.getAD_Org_ID();
				int asiId = line.getM_AttributeSetInstance_ID();
				if (MAcctSchema.COSTINGLEVEL_Client.equals(costingLevel))
				{
					orgId = 0;
					asiId = 0;
				}
				else if (MAcctSchema.COSTINGLEVEL_Organization.equals(costingLevel))
					asiId = 0;
				else if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(costingLevel))
					orgId = 0;
				MCostElement ce = MCostElement.getMaterialCostElement(getCtx(), docCostingMethod, orgId);
				MCost cost = MCost.get(product, asiId, as, 
						orgId, ce.getM_CostElement_ID(), getTrxName());					
				DB.getDatabase().forUpdate(cost, 120);
				BigDecimal currentQty = cost.getCurrentQty();
				adjustmentDiff = costs;
				costs = costs.multiply(currentQty);
			}
			else 
			{
				if (!isReversal(line))
				{
					// MZ Goodwill
					// if Physical Inventory CostDetail is exist then get Cost from Cost Detail
					costs = line.getProductCosts(as, line.getAD_Org_ID(), true, "M_InventoryLine_ID=?");
					// end MZ
					if (costs == null || costs.signum() == 0)
					{
						p_Error = "No Costs for " + line.getProduct().getName();
						return null;
					}
				}
				else
				{
					//updated below
					costs = Env.ONE;
				}
			}
			
			if (doPosting)
			{		
				int C_Currency_ID = getC_Currency_ID() > 0 ? getC_Currency_ID() : as.getC_Currency_ID();
				//  Inventory       DR      CR
				dr = fact.createLine(line,
					line.getAccount(ProductCost.ACCTTYPE_P_Asset, as),
					C_Currency_ID, costs);
				//  may be zero difference - no line created.
				if (dr != null)
				{
					dr.setM_Locator_ID(line.getM_Locator_ID());
					if (isReversal(line))
					{
						//	Set AmtAcctDr from Original Phys.Inventory
						if (!dr.updateReverseLine (MInventory.Table_ID,
								m_Reversal_ID, line.getReversalLine_ID(),Env.ONE))
						{
							p_Error = "Original Physical Inventory not posted yet";
							return null;
						}
					}
		
					//  InventoryDiff   DR      CR
					//	or Charge
					MAccount invDiff = null;
					if (isReversal(line)
							&& line.getC_Charge_ID() != 0) {
						invDiff = line.getChargeAccount(as, costs);
					} else {
						invDiff = line.getChargeAccount(as, costs.negate());
					}
		
					if (invDiff == null)
					{
						if (costAdjustment)
						{
							invDiff = line.getProductCost().getAccount(ProductCost.ACCTTYPE_P_CostAdjustment, as);
						}
						else
						{
							invDiff = getAccount(Doc.ACCTTYPE_InvDifferences, as);
						}
					}
					cr = fact.createLine(line, invDiff,
							C_Currency_ID, costs.negate());
					if (cr != null)
					{
						cr.setM_Locator_ID(line.getM_Locator_ID());
						cr.setQty(line.getQty().negate());
						if (line.getC_Charge_ID() != 0)	//	explicit overwrite for charge
							cr.setAD_Org_ID(line.getAD_Org_ID());
			
						if (isReversal(line))
						{
							//	Set AmtAcctCr from Original Phys.Inventory
							if (!cr.updateReverseLine (MInventory.Table_ID,
									m_Reversal_ID, line.getReversalLine_ID(),Env.ONE))
							{
								p_Error = "Original Physical Inventory not posted yet";
								return null;
							}
							costs = cr.getAcctBalance(); //get original cost
						}
					}
				}
			}

			if (doPosting || costAdjustment)
			{
				BigDecimal costDetailAmt = costAdjustment ? adjustmentDiff : costs;
				if (costAdjustment && getC_Currency_ID() > 0 && getC_Currency_ID() != as.getC_Currency_ID()) 
				{
					costDetailAmt = MConversionRate.convert (getCtx(),
							costDetailAmt, getC_Currency_ID(), as.getC_Currency_ID(),
							getDateAcct(), 0, getAD_Client_ID(), getAD_Org_ID());
				}
				//	Cost Detail
				if (!MCostDetail.createInventory(as, line.getAD_Org_ID(),
					line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
					line.get_ID(), 0,
					costDetailAmt, line.getQty(),
					line.getDescription(), getTrxName()))
				{
					p_Error = "Failed to create cost detail record";
					return null;
				}
			}
		}
		//
		ArrayList<Fact> facts = new ArrayList<Fact>();
		facts.add(fact);
		return facts;
	}   //  createFact

	private boolean isReversal(DocLine line) {
		return m_Reversal_ID !=0 && line.getReversalLine_ID() != 0;
	}

}   //  Doc_Inventory
