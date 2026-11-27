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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MCharge;
import org.compiere.model.MCost;
import org.compiere.model.MCost.ManualCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MCostElement;
import org.compiere.model.MManualCostDetail;
import org.compiere.model.MProduct;
import org.compiere.model.MProduction;
import org.compiere.model.MProductionLineMA;
import org.compiere.model.MProductionPlan;
import org.compiere.model.ProductCost;
import org.compiere.model.Query;
import org.compiere.model.X_M_Production;
import org.compiere.model.X_M_ProductionLine;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 *  Post {@link MProduction} Documents.
 *  <pre>
 *  Table:              M_Production (325)
 *  Document Types:     MMP
 *  </pre>
 *  @author Jorg Janke
 *  @version  $Id: Doc_Production.java,v 1.3 2006/07/30 00:53:33 jjanke Exp $
 */
public class Doc_Production extends Doc
{
	/**
	 *  Constructor
	 * 	@param as accounting schema
	 * 	@param rs record
	 * 	@param trxName trx
	 */
	public Doc_Production (MAcctSchema as, ResultSet rs, String trxName)
	{
		super (as, X_M_Production.class, rs, null, trxName);
	}   //  Doc_Production

	/**
	 *  Load Document Details
	 *  @return error message or null
	 */
	@Override
	protected String loadDocumentDetails()
	{
		setC_Currency_ID (NO_CURRENCY);
		X_M_Production prod = (X_M_Production)getPO();
		setDateDoc (prod.getMovementDate());
		setDateAcct(prod.getMovementDate());
		//	Contained Objects
		p_lines = loadLines(prod);
		if (log.isLoggable(Level.FINE)) log.fine("Lines=" + p_lines.length);
		return null;
	}   //  loadDocumentDetails

	private Map<Integer, BigDecimal> mQtyProduced;
	
	/**
	 * IDEMPIERE-3082
	 * @param mQtyProduced
	 * @param line
	 * @param isUsePlan
	 * @param addMoreQty when you want get value, just pass null
	 * @return qty produce for line (include addMoreQty if addMoreQty is not null)
	 */
	private BigDecimal manipulateQtyProduced (Map<Integer, BigDecimal> mQtyProduced, X_M_ProductionLine line, Boolean isUsePlan, BigDecimal addMoreQty){
		BigDecimal qtyProduced = null;
		Integer key = isUsePlan?line.getM_ProductionPlan_ID():line.getM_Production_ID();
		
		if (mQtyProduced.containsKey(key)){
			qtyProduced = mQtyProduced.get(key);
		}else{
			qtyProduced = BigDecimal.ZERO;
			mQtyProduced.put(key, qtyProduced);
		}
		
		if (addMoreQty != null){
			qtyProduced = qtyProduced.add(addMoreQty);
			mQtyProduced.put(key, qtyProduced);
		}
			
		return qtyProduced;
	}
	/**
	 *	Load production lines
	 *	@param prod production
	 *  @return DoaLine Array
	 */
	private DocLine[] loadLines(X_M_Production prod)
	{
		ArrayList<DocLine> list = new ArrayList<DocLine>();
		mQtyProduced = new HashMap<>(); 
		String sqlPL = getProductionLinesSQL(prod.isUseProductionPlan());
		
		PreparedStatement pstmtPL = null;
		ResultSet rsPL = null;
		try
		{			
			pstmtPL = DB.prepareStatement(sqlPL, getTrxName());
			pstmtPL.setInt(1,get_ID());
			rsPL = pstmtPL.executeQuery();
			while (rsPL.next())
			{
				X_M_ProductionLine line = new X_M_ProductionLine(getCtx(), rsPL, getTrxName());
				if (line.getMovementQty().signum() == 0)
				{
					if (log.isLoggable(Level.INFO)) log.info("LineQty=0 - " + line);
					continue;
				}
				DocLine docLine = new DocLine (line, this);
				docLine.setQty (line.getMovementQty(), false);
				docLine.setReversalLine_ID(line.getReversalLine_ID());
				//	Identify finished BOM Product
				if (prod.isUseProductionPlan()) {
					MProductionPlan plan = new MProductionPlan(getCtx(), line.getM_ProductionPlan_ID(), getTrxName());
					docLine.setProductionBOM(line.getM_Product_ID() == plan.getM_Product_ID());
				} else {
					docLine.setProductionBOM(line.getM_Product_ID() == prod.getM_Product_ID());
				}
				
				if (docLine.isProductionBOM()){
					manipulateQtyProduced (mQtyProduced, line, prod.isUseProductionPlan(), line.getMovementQty());
				}
				//
				if (log.isLoggable(Level.FINE)) log.fine(docLine.toString());
				list.add (docLine);
			}
		}
		catch (SQLException ee)
		{
			throw new DBException(ee, sqlPL);
		}
		finally
		{
			DB.close(rsPL, pstmtPL);
			rsPL = null;
			pstmtPL = null;
		}
			
		DocLine[] dl = new DocLine[list.size()];
		list.toArray(dl);
		return dl;
	}	//	loadLines

	private String getProductionLinesSQL(boolean isUseProductionPlan)
	{
		if (isUseProductionPlan)
		{
			return "SELECT pro_line.* FROM "
					+ " M_ProductionLine pro_line INNER JOIN M_ProductionPlan plan ON pro_line.M_ProductionPlan_id = plan.M_ProductionPlan_id "
					+ " INNER JOIN M_Production pro ON pro.M_Production_id = plan.M_Production_id "
					+ " WHERE pro.M_Production_ID=? "
					+ " ORDER BY plan.M_ProductionPlan_id, pro_line.Line, pro_line.M_ProductionLine_ID";
		}
		return "SELECT * FROM M_ProductionLine pl "
				+ "WHERE pl.M_Production_ID=? "
				+ "ORDER BY pl.Line, pl.M_ProductionLine_ID";
	}

	/**
	 *  Get Balance
	 *  @return Zero (always balanced)
	 */
	@Override
	public BigDecimal getBalance()
	{
		BigDecimal retValue = Env.ZERO;
		return retValue;
	}   //  getBalance

	/**
	 *  Create Facts (the accounting logic) for
	 *  MMP.
	 *  <pre>
	 *  Production
	 *      Inventory       DR      CR
	 *  </pre>
	 *  @param as account schema
	 *  @return Fact
	 */
	@Override
	public ArrayList<Fact> createFacts (MAcctSchema as)
	{
		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID (as.getC_Currency_ID());

		//  Line pointer
		FactLine fl = null;
		X_M_Production prod = (X_M_Production)getPO();
		HashMap<String, BigDecimal> costMap =  new HashMap<String, BigDecimal>();
		Map<Integer, List<ManualCost>> manualCostMap = new HashMap<>();
		boolean isReversal = prod.getReversal_ID() > 0 && prod.getM_Production_ID() > prod.getReversal_ID();
		if (isReversal && hasEligibleComponentManualCosts(as))
		{
			MProduction origProd = new MProduction(getCtx(), prod.getReversal_ID(), getTrxName());
			if (!origProd.isPosted())
			{
				p_Error = Msg.getMsg(getCtx(), "Original Production not posted yet");
				log.log(Level.WARNING, p_Error);
				return null;
			}
		}
		boolean useManualReversal = isReversal
				&& MManualCostDetail.hasForRecord(as.getC_AcctSchema_ID(), MProduction.Table_ID, prod.getReversal_ID(), getTrxName());
		Map<Integer, List<MManualCostDetail>> origManualDetailMap = useManualReversal ? new HashMap<>() : null;
		int stdPrecision = as.getStdPrecision();
		Map<Integer, List<Integer>> fgLineIndicesByParent = new HashMap<>();
		Map<Integer, Map<Integer, BigDecimal>> groupFgBomAllocationMap = new HashMap<>();
		for (int i = 0; i < p_lines.length; i++)
		{
			if (p_lines[i].isProductionBOM())
			{
				X_M_ProductionLine fgLine = (X_M_ProductionLine) p_lines[i].getPO();
				int parentKey = prod.isUseProductionPlan() ? fgLine.getM_ProductionPlan_ID() : fgLine.getM_Production_ID();
				fgLineIndicesByParent.computeIfAbsent(parentKey, k -> new ArrayList<>()).add(i);
			}
		}

		for (int i = 0; i < p_lines.length; i++)
		{
			DocLine line = p_lines[i];
			//	Calculate Costs
			BigDecimal costs = BigDecimal.ZERO;
			
			X_M_ProductionLine prodline = (X_M_ProductionLine)line.getPO();
			MProductionLineMA mas[] = MProductionLineMA.get(getCtx(), prodline.get_ID(), getTrxName());
			MProduct product = new MProduct(getCtx(), prodline.getM_Product_ID(), getTrxName());
			String CostingLevel = product.getCostingLevel(as);
			String costingMethod = product.getCostingMethod(as);

			if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel) ) 
			{
				if (line.getM_AttributeSetInstance_ID() == 0 && (mas!=null && mas.length> 0 )) 
				{
					Map<Integer, ManualCost> maManualCostMap = !isReversal && !line.isProductionBOM() && !manualCostMap.containsKey(line.get_ID())
							? new LinkedHashMap<>() : null;
					for (Map.Entry<Integer, BigDecimal> maEntry : aggregateProductionLineMAs(mas).entrySet())
					{
						int maAsiId = maEntry.getKey();
						BigDecimal maQty = maEntry.getValue();
						BigDecimal maCost = useManualReversal
								? getOriginalProductionMaCost(as, line, maAsiId) : null;
						if (maCost == null)
						{
							MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), maAsiId,
									line.get_ID(), getTrxName());
							if (cd != null)
								maCost = cd.getAmt();
							else
							{
								ProductCost pc = line.getProductCost();
								pc.setQty(maQty);
								pc.setM_M_AttributeSetInstance_ID(maAsiId);
								maCost = line.getProductCosts(as, line.getAD_Org_ID(), false);
							}
						}
						if (maManualCostMap != null)
						{
							accumulateManualCosts(maManualCostMap, MCost.getManualCosts(product, maAsiId,
									as, line.getAD_Org_ID(), maCost, maQty, getTrxName()));
						}
						costs = costs.add(maCost);
						costs = costs.setScale(stdPrecision, RoundingMode.HALF_UP);
						costMap.put(line.get_ID()+ "_"+ maAsiId, maCost.setScale(stdPrecision, RoundingMode.HALF_UP));
					}
					if (maManualCostMap != null)
						manualCostMap.put(line.get_ID(), roundManualCosts(maManualCostMap.values(), stdPrecision));
				} 
				else
				{
					costs = useManualReversal
							? getOriginalProductionLineCost(as, line, line.getM_AttributeSetInstance_ID()) : null;
					if (costs == null)
					{
						MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
								line.get_ID(), getTrxName());
						if (cd != null)
							costs = cd.getAmt();
						else
							costs = line.getProductCosts(as, line.getAD_Org_ID(), false);
					}
					if (!isReversal && !line.isProductionBOM() && !manualCostMap.containsKey(line.get_ID()))
					{
						manualCostMap.put(line.get_ID(), roundManualCosts(
								MCost.getManualCosts(product, line.getM_AttributeSetInstance_ID(),
										as, line.getAD_Org_ID(), costs, line.getQty(), getTrxName()),
								stdPrecision));
					}
					costs = costs.setScale(stdPrecision, RoundingMode.HALF_UP);
					costMap.put(line.get_ID()+ "_"+ line.getM_AttributeSetInstance_ID(), costs);
				}
			
			} 
			else 
			{
				costs = useManualReversal
						? getOriginalProductionLineCost(as, line, line.getM_AttributeSetInstance_ID()) : null;
				if (costs == null)
				{
					// MZ Goodwill
					// if Production CostDetail exist then get Cost from Cost Detail
					MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							line.get_ID(), getTrxName());
					if (cd != null)
						costs = cd.getAmt();
					else
						costs = line.getProductCosts(as, line.getAD_Org_ID(), false);
				}
				if (!isReversal && !line.isProductionBOM() && !manualCostMap.containsKey(line.get_ID()))
				{
					manualCostMap.put(line.get_ID(), roundManualCosts(
							MCost.getManualCosts(product, line.getM_AttributeSetInstance_ID(),
									as, line.getAD_Org_ID(), costs, line.getQty(), getTrxName()),
							stdPrecision));
				}
				costs = costs.setScale(stdPrecision, RoundingMode.HALF_UP);
				costMap.put(line.get_ID()+ "_"+ line.getM_AttributeSetInstance_ID(), costs);
			}
			
			BigDecimal bomCost = Env.ZERO;	
			BigDecimal qtyProduced = null;
			if (line.isProductionBOM())
			{
				X_M_ProductionLine endProLine = (X_M_ProductionLine)line.getPO();
				int parentEndPro = prod.isUseProductionPlan()?endProLine.getM_ProductionPlan_ID():endProLine.getM_Production_ID();
				
				//	Get BOM Cost - Sum of individual lines				
				for (int ii = 0; ii < p_lines.length; ii++)
				{
					DocLine line0 = p_lines[ii];
					X_M_ProductionLine bomProLine = (X_M_ProductionLine)line0.getPO();
					int parentBomPro = prod.isUseProductionPlan()?bomProLine.getM_ProductionPlan_ID():bomProLine.getM_Production_ID();
					
					if (parentBomPro != parentEndPro)
						continue;
					if (!line0.isProductionBOM()) {
						MProduct product0 = new MProduct(getCtx(), bomProLine.getM_Product_ID(), getTrxName());
						String CostingLevel0 = product0.getCostingLevel(as);
						List<ManualCost> line0ManualCosts = !isReversal ? manualCostMap.get(line0.get_ID()) : null;
						if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel0) )
						{
							if (bomProLine.getM_AttributeSetInstance_ID() == 0 ) 
							{
								MProductionLineMA bomLineMA[] = MProductionLineMA.get(getCtx(), line0.get_ID(), getTrxName());
								if (bomLineMA!=null && bomLineMA.length> 0 )
								{
								 // get cost of children for batch costing level (auto generate)									
									BigDecimal costs0 = BigDecimal.ZERO ;
									Map<Integer, ManualCost> maManualCostMap = !isReversal && line0ManualCosts == null ? new LinkedHashMap<>() : null;
									for (Map.Entry<Integer, BigDecimal> maEntry : aggregateProductionLineMAs(bomLineMA).entrySet())
									{
										int maAsiId = maEntry.getKey();
										BigDecimal maQty = maEntry.getValue();
										BigDecimal maCost = useManualReversal
												? getOriginalProductionMaCost(as, line0, maAsiId) : null;
										if (maCost == null)
										{
											// get cost of children
											MCostDetail cd0 = MCostDetail.getProduction(as, line0.getM_Product_ID(), maAsiId,
													line0.get_ID(), getTrxName());
											if (cd0 != null)
												maCost = cd0.getAmt();
											else
											{
												ProductCost pc = line0.getProductCost();
												pc.setQty(maQty);
												pc.setM_M_AttributeSetInstance_ID(maAsiId);
												maCost = line0.getProductCosts(as, line0.getAD_Org_ID(), false);
											}
										}
										if (maManualCostMap != null)
										{
											accumulateManualCosts(maManualCostMap, MCost.getManualCosts(product0, maAsiId,
													as, line0.getAD_Org_ID(), maCost, maQty, getTrxName()));
										}
										maCost = maCost.setScale(stdPrecision, RoundingMode.HALF_UP);
										costMap.put(line0.get_ID()+ "_"+ maAsiId, maCost);
										costs0 = costs0.add(maCost);
									}						
									bomCost = bomCost.add(costs0);
									if (maManualCostMap != null)
									{
										line0ManualCosts = roundManualCosts(maManualCostMap.values(), stdPrecision);
										manualCostMap.put(line0.get_ID(), line0ManualCosts);
									}
								} 
								else
									p_Error = "Failed to post - No Attribute Set for line";
								
							} 
							else
							{
								// get cost of children  for batch costing level 
								BigDecimal costs0 = useManualReversal
										? getOriginalProductionLineCost(as, line0, line0.getM_AttributeSetInstance_ID()) : null;
								if (costs0 == null)
								{
									MCostDetail cd0 = MCostDetail.getProduction(as, line0.getM_Product_ID(), line0.getM_AttributeSetInstance_ID(),
											line0.get_ID(), getTrxName());
									if (cd0 != null)
										costs0 = cd0.getAmt();
									else
										costs0 = line0.getProductCosts(as, line0.getAD_Org_ID(), false);
								}
								if (!isReversal && line0ManualCosts == null)
								{
									line0ManualCosts = roundManualCosts(
											MCost.getManualCosts(product0, line0.getM_AttributeSetInstance_ID(),
													as, line0.getAD_Org_ID(), costs0, line0.getQty(), getTrxName()),
											stdPrecision);
									manualCostMap.put(line0.get_ID(), line0ManualCosts);
								}
								costs0 = costs0.setScale(stdPrecision, RoundingMode.HALF_UP);
								costMap.put(line0.get_ID()+ "_"+ line0.getM_AttributeSetInstance_ID(),costs0);
								bomCost = bomCost.add(costs0);
							}
							
						}  
						else
						{
							// get cost of children
							BigDecimal costs0 = useManualReversal
									? getOriginalProductionLineCost(as, line0, line0.getM_AttributeSetInstance_ID()) : null;
							if (costs0 == null)
							{
								MCostDetail cd0 = MCostDetail.getProduction(as, line0.getM_Product_ID(), line0.getM_AttributeSetInstance_ID(),
										line0.get_ID(), getTrxName());
								if (cd0 != null)
									costs0 = cd0.getAmt();
								else
									costs0 = line0.getProductCosts(as, line0.getAD_Org_ID(), false);
							}
							if (!isReversal && line0ManualCosts == null)
							{
								line0ManualCosts = roundManualCosts(
										MCost.getManualCosts(product0, line0.getM_AttributeSetInstance_ID(),
												as, line0.getAD_Org_ID(), costs0, line0.getQty(), getTrxName()),
										stdPrecision);
								manualCostMap.put(line0.get_ID(), line0ManualCosts);
							}
							costs0 = costs0.setScale(stdPrecision, RoundingMode.HALF_UP);
							costMap.put(line0.get_ID()+ "_"+ line0.getM_AttributeSetInstance_ID(),costs0);
							bomCost = bomCost.add(costs0);
						}
						if (useManualReversal)
						{
							for (MManualCostDetail origDetail : getOriginalLineManualDetails(as, prod.getReversal_ID(), line0, origManualDetailMap))
								bomCost = bomCost.add(origDetail.getAmt());
						}
						else if (line0ManualCosts != null)
						{
							for (ManualCost manualCost : line0ManualCosts)
								bomCost = bomCost.add(manualCost.getAmount());
						}
					}
				}
				
				qtyProduced = manipulateQtyProduced (mQtyProduced, endProLine, prod.isUseProductionPlan(), null);
				List<Integer> groupFgIndices = fgLineIndicesByParent.get(parentEndPro);
				if (groupFgIndices != null && groupFgIndices.size() > 1)
				{
					BigDecimal totalGroupBomCost = bomCost.setScale(stdPrecision, RoundingMode.HALF_UP);
					BigDecimal groupQtyProduced = qtyProduced;
					Map<Integer, BigDecimal> allocation = groupFgBomAllocationMap.computeIfAbsent(parentEndPro,
							k -> allocateGroupBomCost(totalGroupBomCost, groupQtyProduced, groupFgIndices, stdPrecision));
					bomCost = allocation.getOrDefault(i, BigDecimal.ZERO);
				}
				else if (line.getQty().compareTo(qtyProduced) != 0 && qtyProduced.signum() != 0)
				{
					BigDecimal factor = line.getQty().divide(qtyProduced, 12, RoundingMode.HALF_UP);
					bomCost = bomCost.setScale(stdPrecision, RoundingMode.HALF_UP).multiply(factor).setScale(stdPrecision, RoundingMode.HALF_UP);
				}
			}

			if (line.isProductionBOM())
			{
				if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel))
				{
					//post roll-up  
					fl = fact.createLine(line, 
							line.getAccount(ProductCost.ACCTTYPE_P_Asset, as),
							as.getC_Currency_ID(), bomCost.negate().setScale(stdPrecision, RoundingMode.HALF_UP));
					if (fl == null) 
					{ 
						p_Error = "Couldn't post roll-up " + line.getLine() + " - " + line; 
						return null; 
					}
					fl.setQty(qtyProduced);				
				} 
				else if (MAcctSchema.COSTINGMETHOD_StandardCosting.equals(costingMethod))
				{					
					BigDecimal variance = costs.subtract(bomCost.negate()).setScale(stdPrecision, RoundingMode.HALF_UP);
					// only post variance if it's not zero 
					if (variance.signum() != 0) 
					{
						//post variance 
						fl = fact.createLine(line, 
								line.getAccount(ProductCost.ACCTTYPE_P_RateVariance, as),
								as.getC_Currency_ID(), variance.negate()); 
						if (fl == null) 
						{ 
							p_Error = "Couldn't post variance " + line.getLine() + " - " + line; 
							return null; 
						}
						fl.setQty(Env.ZERO);
					}
				}
			}
			// end MZ

			//  Inventory       DR      CR
			if (!(line.isProductionBOM() && MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel)))
			{
				BigDecimal factLineAmt = costs;
				if (line.isProductionBOM() && !(MAcctSchema.COSTINGMETHOD_StandardCosting.equals(costingMethod)))
				{
					factLineAmt = bomCost.negate();
				}
				fl = fact.createLine(line,
					line.getAccount(ProductCost.ACCTTYPE_P_Asset, as),
					as.getC_Currency_ID(), factLineAmt.setScale(stdPrecision, RoundingMode.HALF_UP));
				if (fl == null)
				{
					p_Error = "No Costs for Line " + line.getLine() + " - " + line;
					return null;
				}
				fl.setM_Locator_ID(line.getM_Locator_ID());
				fl.setQty(line.getQty());
			}

			if (!line.isProductionBOM())
			{
				if (useManualReversal)
				{
					for (MManualCostDetail origDetail : getOriginalLineManualDetails(as, prod.getReversal_ID(), line, origManualDetailMap))
					{
						int C_Charge_ID = origDetail.getC_Charge_ID();
						BigDecimal chargeFactAmt = origDetail.getAmt();
						String msgKey = chargeFactAmt.signum() < 0 ? "FactLine CR not created" : "FactLine DR not created";
						MAccount chargeAcct = getManualCostChargeAccount(as, origDetail);
						if (chargeAcct == null)
						{
							p_Error = formatMissingChargeAccountError(as, C_Charge_ID, line, msgKey);
							log.log(Level.WARNING, p_Error);
							return null;
						}
						fl = fact.createLine(line, chargeAcct,
								as.getC_Currency_ID(), chargeFactAmt);
						if (fl == null)
						{
							p_Error = Msg.getMsg(getCtx(), msgKey) + ": " + line;
							log.log(Level.WARNING, p_Error);
							return null;
						}
						fl.setC_Charge_ID(C_Charge_ID);
						fl.setM_Locator_ID(line.getM_Locator_ID());
						fl.setQty(line.getQty());
						saveManualCostDetail(as, line, origDetail.getM_CostElement_ID(), C_Charge_ID,
								chargeAcct, chargeFactAmt.negate());
					}
				}
				else if (!isReversal)
				{
					List<ManualCost> lineManualCosts = manualCostMap.get(line.get_ID());
					if (lineManualCosts != null)
					{
						for (ManualCost manualCost : lineManualCosts)
						{
							int C_Charge_ID = manualCost.getCostElement().getC_Charge_ID();
							String msgKey = manualCost.getAmount().signum() < 0 ? "FactLine CR not created" : "FactLine DR not created";
							MAccount chargeAcct = MCharge.getAccount(C_Charge_ID, as, getTrxName());
							if (chargeAcct == null)
							{
								p_Error = formatMissingChargeAccountError(as, C_Charge_ID, line, msgKey);
								log.log(Level.WARNING, p_Error);
								return null;
							}
							fl = fact.createLine(line, chargeAcct,
									as.getC_Currency_ID(), manualCost.getAmount());
							if (fl == null)
							{
								p_Error = Msg.getMsg(getCtx(), msgKey) + ": " + line;
								log.log(Level.WARNING, p_Error);
								return null;
							}
							fl.setC_Charge_ID(C_Charge_ID);
							fl.setM_Locator_ID(line.getM_Locator_ID());
							fl.setQty(line.getQty());
							saveManualCostDetail(as, line, manualCost.getCostElement().getM_CostElement_ID(), C_Charge_ID,
									chargeAcct, manualCost.getAmount().negate());
						}
					}
				}
			}

			//	Cost Detail
			String description = line.getDescription();
			if (description == null)
				description = "";
			if (line.isProductionBOM())
				description += "(*)";
			int origLineId = line.getReversalLine_ID();
			if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel)) 
			{
				if (line.isProductionBOM())
				{
					int Ref_CostDetail_ID = getRefCostDetailId(as, line, line.getM_AttributeSetInstance_ID(), origLineId);
					if (!MCostDetail.createProduction(as, line.getAD_Org_ID(),
							line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							line.get_ID(), 0,
							bomCost.negate(), qtyProduced,
							description, line.getDateAcct(), Ref_CostDetail_ID, getTrxName()))
					{
						p_Error = "Failed to create cost detail record";
						return null;
					}
				}
				else if (line.getM_AttributeSetInstance_ID() == 0 && (mas!=null && mas.length> 0 ))
				{
					for (Map.Entry<Integer, BigDecimal> maEntry : aggregateProductionLineMAs(mas).entrySet())
					{
						int maAsiId = maEntry.getKey();
						BigDecimal maQty = maEntry.getValue();
						BigDecimal maCost = costMap.get(line.get_ID()+ "_"+ maAsiId);
						int Ref_CostDetail_ID = getRefCostDetailId(as, line, maAsiId, origLineId);
						if (!MCostDetail.createProduction(as, line.getAD_Org_ID(),
								line.getM_Product_ID(), maAsiId,
								line.get_ID(), 0,
								maCost, maQty,
								description, line.getDateAcct(), Ref_CostDetail_ID, getTrxName()))
						{
							p_Error = "Failed to create cost detail record";
							return null;
						}
					}
				} 
				else
				{
					List<MCostDetail> origLotCds = useManualReversal && origLineId > 0
							? getOriginalProductionCostDetails(as, line.getM_Product_ID(), origLineId)
							: Collections.emptyList();
					if (origLotCds.size() > 1
							|| (origLotCds.size() == 1 && origLotCds.get(0).getM_AttributeSetInstance_ID() != line.getM_AttributeSetInstance_ID()))
					{
						for (MCostDetail origCd : origLotCds)
						{
							int refId = line.get_ID() > origLineId ? origCd.getM_CostDetail_ID() : 0;
							if (!MCostDetail.createProduction(as, line.getAD_Org_ID(),
									line.getM_Product_ID(), origCd.getM_AttributeSetInstance_ID(),
									line.get_ID(), 0,
									origCd.getAmt().negate(), origCd.getQty().negate(),
									description, line.getDateAcct(), refId, getTrxName()))
							{
								p_Error = "Failed to create cost detail record";
								return null;
							}
						}
					}
					else
					{
						int Ref_CostDetail_ID = getRefCostDetailId(as, line, line.getM_AttributeSetInstance_ID(), origLineId);
						if (!MCostDetail.createProduction(as, line.getAD_Org_ID(),
								line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
								line.get_ID(), 0,
								costs, line.getQty(),
								description, line.getDateAcct(), Ref_CostDetail_ID, getTrxName()))
						{
							p_Error = "Failed to create cost detail record";
							return null;
						}
					}
				}
			} 
			else
			{		
				int Ref_CostDetail_ID = getRefCostDetailId(as, line, line.getM_AttributeSetInstance_ID(), origLineId);
				if (line.isProductionBOM() && !(MAcctSchema.COSTINGMETHOD_StandardCosting.equals(costingMethod)))
				{
					if (!MCostDetail.createProduction(as, line.getAD_Org_ID(),
							line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							line.get_ID(), 0,
							bomCost.negate(), line.getQty(),
							description, line.getDateAcct(), Ref_CostDetail_ID, getTrxName()))
					{
						p_Error = "Failed to create cost detail record";
						return null;
					}
				}
				else
				{
					if (!MCostDetail.createProduction(as, line.getAD_Org_ID(),
							line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							line.get_ID(), 0,
							costs, line.getQty(),
							description, line.getDateAcct(), Ref_CostDetail_ID, getTrxName()))
					{
						p_Error = "Failed to create cost detail record";
						return null;
					}
				}
			}
		}
		//
		ArrayList<Fact> facts = new ArrayList<Fact>();
		facts.add(fact);
		return facts;
	}   //  createFact

	private List<MManualCostDetail> getOriginalLineManualDetails(MAcctSchema as, int origProductionId,
			DocLine line, Map<Integer, List<MManualCostDetail>> cache)
	{
		if (cache.containsKey(line.get_ID()))
			return cache.get(line.get_ID());
		int origLineId = line.getReversalLine_ID();
		List<MManualCostDetail> details = origLineId > 0
				? MManualCostDetail.getByLine(getCtx(), as.getC_AcctSchema_ID(),
						MProduction.Table_ID, origProductionId, origLineId, getTrxName())
				: Collections.emptyList();
		cache.put(line.get_ID(), details);
		return details;
	}

	private BigDecimal getOriginalProductionLineCost(MAcctSchema as, DocLine line, int asiId)
	{
		int origLineId = line.getReversalLine_ID();
		if (origLineId <= 0)
			return null;
		MCostDetail origCd = MCostDetail.getProduction(as, line.getM_Product_ID(), asiId, origLineId, 0, getTrxName());
		if (origCd != null && origCd.getQty().negate().compareTo(line.getQty()) == 0)
			return origCd.getAmt().negate();
		BigDecimal sumAmt = DB.getSQLValueBDEx(getTrxName(),
				"SELECT SUM(Amt) FROM M_CostDetail "
				+ "WHERE C_AcctSchema_ID=? AND M_Product_ID=? AND M_ProductionLine_ID=? AND COALESCE(M_CostElement_ID,0)=0",
				as.getC_AcctSchema_ID(), line.getM_Product_ID(), origLineId);
		if (sumAmt != null)
			return sumAmt.negate();
		return origCd != null ? origCd.getAmt().negate() : null;
	}

	private BigDecimal getOriginalProductionMaCost(MAcctSchema as, DocLine line, int maAsiId)
	{
		int origLineId = line.getReversalLine_ID();
		if (origLineId <= 0)
			return null;
		MCostDetail origCd = MCostDetail.getProduction(as, line.getM_Product_ID(), maAsiId, origLineId, 0, getTrxName());
		return origCd != null ? origCd.getAmt().negate() : null;
	}

	private int getRefCostDetailId(MAcctSchema as, DocLine line, int asiId, int origLineId)
	{
		if (origLineId > 0 && line.get_ID() > origLineId)
		{
			MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), asiId, origLineId, 0, getTrxName());
			if (cd != null)
				return cd.getM_CostDetail_ID();
		}
		return 0;
	}

	private boolean hasEligibleComponentManualCosts(MAcctSchema as)
	{
		if (!MCost.hasChargeManualCostElements(getAD_Client_ID(), getTrxName()))
			return false;
		final String sql = "SELECT 1 FROM M_Cost c "
				+ "JOIN M_CostElement ce ON (c.M_CostElement_ID=ce.M_CostElement_ID) "
				+ "WHERE c.AD_Client_ID=? AND c.AD_Org_ID=? AND c.M_Product_ID=? "
				+ "AND c.M_CostType_ID=? AND c.C_AcctSchema_ID=? "
				+ "AND c.IsActive='Y' AND ce.IsActive='Y' "
				+ "AND ce.CostingMethod IS NULL AND ce.CostElementType <> 'M' AND ce.C_Charge_ID > 0 "
				+ "AND (COALESCE(c.CurrentCostPrice,0) <> 0 OR COALESCE(c.Percent,0) <> 0)";
		for (DocLine line : p_lines)
		{
			if (line.isProductionBOM())
				continue;
			MProduct product = MProduct.get(getCtx(), line.getM_Product_ID());
			if (product == null || product.get_ID() <= 0)
				continue;
			if (MCostElement.COSTINGMETHOD_StandardCosting.equals(product.getCostingMethod(as)))
				continue;
			int resolvedOrgId = MCost.CostingKey.resolve(line.getAD_Org_ID(), 0, product.getCostingLevel(as)).AD_Org_ID();
			if (DB.getSQLValueEx(getTrxName(), sql, getAD_Client_ID(), resolvedOrgId,
					product.getM_Product_ID(), as.getM_CostType_ID(), as.getC_AcctSchema_ID()) > 0)
				return true;
		}
		return false;
	}

	private Map<Integer, BigDecimal> aggregateProductionLineMAs(MProductionLineMA[] mas)
	{
		Map<Integer, BigDecimal> asiQtyMap = new LinkedHashMap<>();
		for (MProductionLineMA ma : mas)
			asiQtyMap.merge(ma.getM_AttributeSetInstance_ID(), ma.getMovementQty(), BigDecimal::add);
		return asiQtyMap;
	}

	private List<MCostDetail> getOriginalProductionCostDetails(MAcctSchema as, int productId, int origLineId)
	{
		return new Query(getCtx(), MCostDetail.Table_Name,
				"C_AcctSchema_ID=? AND M_Product_ID=? AND M_ProductionLine_ID=? AND COALESCE(M_CostElement_ID,0)=0",
				getTrxName())
				.setParameters(as.getC_AcctSchema_ID(), productId, origLineId)
				.setOrderBy(MCostDetail.COLUMNNAME_M_CostDetail_ID)
				.list();
	}

	/**
	 * Allocate a production group's rounded BOM cost across multiple finished-goods lines using
	 * largest-remainder apportionment so the shares sum exactly to {@code totalGroupBomCost} and
	 * no same-sign output line flips sign due to cumulative rounding.
	 */
	private Map<Integer, BigDecimal> allocateGroupBomCost(BigDecimal totalGroupBomCost,
			BigDecimal qtyProduced, List<Integer> groupFgIndices, int stdPrecision)
	{
		Map<Integer, BigDecimal> result = new HashMap<>();
		if (qtyProduced == null || qtyProduced.signum() == 0)
		{
			for (Integer idx : groupFgIndices)
				result.put(idx, BigDecimal.ZERO);
			return result;
		}
		Map<Integer, BigDecimal> exactMap = new HashMap<>();
		BigDecimal sumBase = BigDecimal.ZERO;
		for (Integer idx : groupFgIndices)
		{
			BigDecimal exact = totalGroupBomCost.multiply(p_lines[idx].getQty())
					.divide(qtyProduced, stdPrecision + 12, RoundingMode.HALF_UP);
			BigDecimal base = exact.setScale(stdPrecision, RoundingMode.DOWN);
			exactMap.put(idx, exact);
			result.put(idx, base);
			sumBase = sumBase.add(base);
		}
		BigDecimal diff = totalGroupBomCost.subtract(sumBase);
		if (diff.signum() != 0)
		{
			BigDecimal unit = BigDecimal.ONE.movePointLeft(stdPrecision);
			BigDecimal step = diff.signum() > 0 ? unit : unit.negate();
			int steps = diff.movePointRight(stdPrecision).abs().intValueExact();
			List<Integer> ordered = new ArrayList<>(groupFgIndices);
			boolean positiveDiff = diff.signum() > 0;
			ordered.sort((a, b) -> {
				BigDecimal remA = positiveDiff
						? exactMap.get(a).subtract(result.get(a))
						: result.get(a).subtract(exactMap.get(a));
				BigDecimal remB = positiveDiff
						? exactMap.get(b).subtract(result.get(b))
						: result.get(b).subtract(exactMap.get(b));
				int cmp = remB.compareTo(remA);
				return cmp != 0 ? cmp : Integer.compare(a, b);
			});
			for (int k = 0; k < steps; k++)
			{
				Integer idx = ordered.get(k % ordered.size());
				result.put(idx, result.get(idx).add(step));
			}
		}
		return result;
	}

}   //  Doc_Production
