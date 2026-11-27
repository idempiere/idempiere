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
import org.compiere.model.MCost;
import org.compiere.model.MCost.ManualCost;
import org.compiere.model.MCostDetail;
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
		String sqlPL = null;
		if (prod.isUseProductionPlan()){
			//	Production Plan
			//	-- ProductionLine	- the real level
			sqlPL = "SELECT pro_line.* FROM "
							+ " M_ProductionLine pro_line INNER JOIN M_ProductionPlan plan ON pro_line.M_ProductionPlan_id = plan.M_ProductionPlan_id "
							+ " INNER JOIN M_Production pro ON pro.M_Production_id = plan.M_Production_id "
							+ " WHERE pro.M_Production_ID=? "
							+ " ORDER BY plan.Line, plan.M_ProductionPlan_id, pro_line.Line, pro_line.M_ProductionLine_ID";
		}else{
			//	Production
			//	-- ProductionLine	- the real level
			sqlPL = "SELECT * FROM M_ProductionLine pl "
					+ "WHERE pl.M_Production_ID=? "
					+ "ORDER BY pl.Line, pl.M_ProductionLine_ID";
		}
		
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
		resolveLegacyReversalLines(prod, list);
			
		DocLine[] dl = new DocLine[list.size()];
		list.toArray(dl);
		return dl;
	}	//	loadLines

	private List<X_M_ProductionLine> loadProductionLines(int productionId, boolean isUseProductionPlan)
	{
		List<X_M_ProductionLine> lines = new ArrayList<>();
		String sqlPL = isUseProductionPlan
				? "SELECT pro_line.* FROM M_ProductionLine pro_line "
					+ "INNER JOIN M_ProductionPlan plan ON pro_line.M_ProductionPlan_id = plan.M_ProductionPlan_id "
					+ "INNER JOIN M_Production pro ON pro.M_Production_id = plan.M_Production_id "
					+ "WHERE pro.M_Production_ID=? "
					+ "ORDER BY plan.Line, plan.M_ProductionPlan_id, pro_line.Line, pro_line.M_ProductionLine_ID"
				: "SELECT * FROM M_ProductionLine pl WHERE pl.M_Production_ID=? ORDER BY pl.Line, pl.M_ProductionLine_ID";
		PreparedStatement pstmtPL = null;
		ResultSet rsPL = null;
		try
		{
			pstmtPL = DB.prepareStatement(sqlPL, getTrxName());
			pstmtPL.setInt(1, productionId);
			rsPL = pstmtPL.executeQuery();
			while (rsPL.next())
			{
				X_M_ProductionLine line = new X_M_ProductionLine(getCtx(), rsPL, getTrxName());
				if (line.getMovementQty().signum() != 0)
					lines.add(line);
			}
		}
		catch (SQLException ee)
		{
			throw new DBException(ee, sqlPL);
		}
		finally
		{
			DB.close(rsPL, pstmtPL);
		}
		return lines;
	}

	/**
	 * Match pre-migration production reversal lines whose {@code ReversalLine_ID} is null
	 * against the original production lines when their structure aligns 1-to-1.
	 */
	private void resolveLegacyReversalLines(X_M_Production prod, List<DocLine> revDocLines)
	{
		if (prod.getReversal_ID() <= 0 || prod.getM_Production_ID() <= prod.getReversal_ID())
			return;
		boolean hasUnlinked = false;
		for (DocLine docLine : revDocLines)
		{
			if (docLine.getReversalLine_ID() <= 0)
			{
				hasUnlinked = true;
				break;
			}
		}
		if (!hasUnlinked)
			return;

		MProduction origProd = new MProduction(getCtx(), prod.getReversal_ID(), getTrxName());
		if (origProd.get_ID() <= 0 || origProd.isUseProductionPlan() != prod.isUseProductionPlan())
			return;
		List<X_M_ProductionLine> origLines = loadProductionLines(origProd.getM_Production_ID(), origProd.isUseProductionPlan());
		if (origLines.size() != revDocLines.size())
			return;

		Map<Integer, MProductionPlan> planCache = prod.isUseProductionPlan() ? new HashMap<>() : null;
		int prevOrigPlanId = 0;
		int prevRevPlanId = 0;
		for (int i = 0; i < revDocLines.size(); i++)
		{
			DocLine revDocLine = revDocLines.get(i);
			X_M_ProductionLine revLine = (X_M_ProductionLine) revDocLine.getPO();
			X_M_ProductionLine origLine = origLines.get(i);
			if (revDocLine.getReversalLine_ID() > 0 && revDocLine.getReversalLine_ID() != origLine.getM_ProductionLine_ID())
				return;
			if (origLine.getLine() != revLine.getLine()
					|| origLine.getM_Product_ID() != revLine.getM_Product_ID()
					|| origLine.isEndProduct() != revLine.isEndProduct()
					|| origLine.getM_Locator_ID() != revLine.getM_Locator_ID()
					|| origLine.getM_AttributeSetInstance_ID() != revLine.getM_AttributeSetInstance_ID()
					|| origLine.getMovementQty().add(revLine.getMovementQty()).signum() != 0)
				return;
			if (planCache != null)
			{
				int origPlanId = origLine.getM_ProductionPlan_ID();
				int revPlanId = revLine.getM_ProductionPlan_ID();
				if (i > 0 && (origPlanId == prevOrigPlanId) != (revPlanId == prevRevPlanId))
					return;
				MProductionPlan origPlan = planCache.computeIfAbsent(origPlanId, id -> new MProductionPlan(getCtx(), id, getTrxName()));
				MProductionPlan revPlan = planCache.computeIfAbsent(revPlanId, id -> new MProductionPlan(getCtx(), id, getTrxName()));
				if (origPlan.getLine() != revPlan.getLine() || origPlan.getM_Product_ID() != revPlan.getM_Product_ID())
					return;
				prevOrigPlanId = origPlanId;
				prevRevPlanId = revPlanId;
			}
		}

		for (int i = 0; i < revDocLines.size(); i++)
		{
			DocLine revDocLine = revDocLines.get(i);
			if (revDocLine.getReversalLine_ID() <= 0)
				revDocLine.setReversalLine_ID(origLines.get(i).getM_ProductionLine_ID());
		}
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
		if (isReversal)
		{
			MProduction origProd = new MProduction(getCtx(), prod.getReversal_ID(), getTrxName());
			if (!origProd.isPosted() || origProd.isProcessing())
			{
				p_Error = Msg.getMsg(getCtx(), "Original Production not posted yet");
				log.log(Level.WARNING, p_Error);
				return null;
			}
		}
		boolean useManualReversal = isReversal
				&& MManualCostDetail.hasForRecord(as.getC_AcctSchema_ID(), MProduction.Table_ID, prod.getReversal_ID(), getTrxName());
		if (useManualReversal)
		{
			for (DocLine line : p_lines)
			{
				if (line.getReversalLine_ID() <= 0)
				{
					p_Error = "Original production line not found for manual cost reversal: " + line.getLine();
					log.log(Level.WARNING, p_Error);
					return null;
				}
			}
		}
		Map<Integer, List<MManualCostDetail>> origManualDetailMap = useManualReversal ? new HashMap<>() : null;
		int stdPrecision = as.getStdPrecision();
		Map<Integer, List<Integer>> compLineIndicesByParent = new LinkedHashMap<>();
		Map<Integer, List<Integer>> fgLineIndicesByParent = new LinkedHashMap<>();
		Map<Integer, Map<Integer, BigDecimal>> groupFgBomAllocationMap = new HashMap<>();
		Map<Integer, BigDecimal> componentCostMap = new HashMap<>();
		for (int i = 0; i < p_lines.length; i++)
		{
			X_M_ProductionLine pl = (X_M_ProductionLine) p_lines[i].getPO();
			int parentKey = prod.isUseProductionPlan() ? pl.getM_ProductionPlan_ID() : pl.getM_Production_ID();
			compLineIndicesByParent.computeIfAbsent(parentKey, k -> new ArrayList<>());
			fgLineIndicesByParent.computeIfAbsent(parentKey, k -> new ArrayList<>());
			if (p_lines[i].isProductionBOM())
				fgLineIndicesByParent.get(parentKey).add(i);
			else
				compLineIndicesByParent.get(parentKey).add(i);
		}
		List<Integer> lineOrder = new ArrayList<>(p_lines.length);
		for (Integer parentKey : compLineIndicesByParent.keySet())
		{
			lineOrder.addAll(compLineIndicesByParent.get(parentKey));
			lineOrder.addAll(fgLineIndicesByParent.get(parentKey));
		}
		for (Map.Entry<Integer, List<Integer>> entry : fgLineIndicesByParent.entrySet())
		{
			if (!entry.getValue().isEmpty())
			{
				BigDecimal groupQty = mQtyProduced.get(entry.getKey());
				if (groupQty == null || groupQty.signum() == 0)
				{
					p_Error = "Zero net quantity produced for production BOM group";
					log.log(Level.WARNING, p_Error);
					return null;
				}
			}
		}

		for (int i : lineOrder)
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
					for (int j = 0; j < mas.length; j++)
					{
						MProductionLineMA ma = mas[j];													
						BigDecimal maCost = useManualReversal
								? getOriginalProductionMaCost(as, line, ma.getM_AttributeSetInstance_ID()) : null;
						if (maCost == null)
						{
							MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),
									line.get_ID(), getTrxName());	
							if (cd != null)
								maCost = cd.getAmt();	
							else 
							{
								ProductCost pc = line.getProductCost();
								pc.setQty(ma.getMovementQty());
								pc.setM_M_AttributeSetInstance_ID(ma.getM_AttributeSetInstance_ID());
								maCost = line.getProductCosts(as, line.getAD_Org_ID(), false);
							}
						}
						if (maManualCostMap != null)
						{
							DocManualCostHelper.accumulateManualCosts(maManualCostMap, MCost.getManualCosts(product, ma.getM_AttributeSetInstance_ID(),
									as, line.getAD_Org_ID(), maCost, ma.getMovementQty(), getTrxName()));
						}
						maCost = maCost.setScale(stdPrecision, RoundingMode.HALF_UP);
						costs = costs.add(maCost);
						costMap.put(line.get_ID()+ "_"+ ma.getM_AttributeSetInstance_ID(), maCost);
					}
					if (maManualCostMap != null)
						manualCostMap.put(line.get_ID(), DocManualCostHelper.roundManualCosts(maManualCostMap.values(), stdPrecision));
				} 
				else
				{
					MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							line.get_ID(), getTrxName());
					BigDecimal origCost = useManualReversal
							? getOriginalProductionLineCost(as, line, line.getM_AttributeSetInstance_ID()) : null;
					if (origCost != null)
					{
						costs = origCost;
					}
					else if (cd != null) 
					{
						costs = cd.getAmt();
					} 
					else 
					{
						costs = line.getProductCosts(as, line.getAD_Org_ID(), false);
					}
					if (!isReversal && !line.isProductionBOM() && !manualCostMap.containsKey(line.get_ID()))
					{
						manualCostMap.put(line.get_ID(), DocManualCostHelper.roundManualCosts(
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
			
				// MZ Goodwill
				// if Production CostDetail exist then get Cost from Cost Detail
				MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
						line.get_ID(), getTrxName());
				BigDecimal origCost = useManualReversal
						? getOriginalProductionLineCost(as, line, line.getM_AttributeSetInstance_ID()) : null;
				if (origCost != null)
				{
					costs = origCost;
				}
				else if (cd != null) 
				{
					costs = cd.getAmt();
				} 
				else 
				{
					costs = line.getProductCosts(as, line.getAD_Org_ID(), false);
				}
				if (!isReversal && !line.isProductionBOM() && !manualCostMap.containsKey(line.get_ID()))
				{
					manualCostMap.put(line.get_ID(), DocManualCostHelper.roundManualCosts(
							MCost.getManualCosts(product, line.getM_AttributeSetInstance_ID(),
									as, line.getAD_Org_ID(), costs, line.getQty(), getTrxName()),
							stdPrecision));
				}
				costs = costs.setScale(stdPrecision, RoundingMode.HALF_UP);
				costMap.put(line.get_ID()+ "_"+ line.getM_AttributeSetInstance_ID(), costs);

			}
			
			if (!line.isProductionBOM())
				componentCostMap.put(line.get_ID(), costs);
			
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
						BigDecimal costs0 = componentCostMap.get(line0.get_ID());
						if (costs0 != null)
							bomCost = bomCost.add(costs0);
						if (useManualReversal)
						{
							for (MManualCostDetail origDetail : getOriginalLineManualDetails(as, prod.getReversal_ID(), line0, origManualDetailMap))
								bomCost = bomCost.add(origDetail.getAmt());
						}
						else
						{
							List<ManualCost> line0ManualCosts = !isReversal ? manualCostMap.get(line0.get_ID()) : null;
							if (line0ManualCosts != null)
							{
								for (ManualCost manualCost : line0ManualCosts)
									bomCost = bomCost.add(manualCost.getAmount());
							}
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
					fl.setQty(line.getQty());				
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
						if (!postProductionChargeLine(fact, as, line, origDetail.getM_CostElement_ID(),
								origDetail.getC_Charge_ID(), DocManualCostHelper.getManualCostChargeAccount(this, as, origDetail), origDetail.getAmt()))
							return null;
					}
				}
				else if (!isReversal)
				{
					List<ManualCost> lineManualCosts = manualCostMap.get(line.get_ID());
					if (lineManualCosts != null)
					{
						for (ManualCost manualCost : lineManualCosts)
						{
							if (!postProductionChargeLine(fact, as, line, manualCost.getCostElement().getM_CostElement_ID(),
									manualCost.getCostElement().getC_Charge_ID(), null, manualCost.getAmount()))
								return null;
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
			if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel)) 
			{
				if (line.isProductionBOM())
				{
					int Ref_CostDetail_ID = 0;
					if (line.getReversalLine_ID() > 0 && line.get_ID() > line.getReversalLine_ID())
					{
						MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
								line.getReversalLine_ID(), 0, getTrxName());
						if (cd != null)
							Ref_CostDetail_ID = cd.getM_CostDetail_ID();
					}
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
				else if (line.getM_AttributeSetInstance_ID() == 0 && (mas!=null && mas.length> 0 ))
				{
					 for (int j = 0; j < mas.length; j++)
					 {
						MProductionLineMA ma = mas[j];
						BigDecimal maCost = costMap.get(line.get_ID()+ "_"+ ma.getM_AttributeSetInstance_ID());		
						int Ref_CostDetail_ID = 0;
						if (line.getReversalLine_ID() > 0 && line.get_ID() > line.getReversalLine_ID())
						{
							MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),
									line.getReversalLine_ID(), 0, getTrxName());
							if (cd != null)
								Ref_CostDetail_ID = cd.getM_CostDetail_ID();
						}
						if (!MCostDetail.createProduction(as, line.getAD_Org_ID(),
								line.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),
								line.get_ID(), 0,
								maCost, ma.getMovementQty(),
								description, line.getDateAcct(), Ref_CostDetail_ID, getTrxName()))
						{
							p_Error = "Failed to create cost detail record";
							return null;
						}
					 }
				 } 
				 else
				 {
					 List<MCostDetail> origLotCds = (!line.isProductionBOM() && useManualReversal && line.getReversalLine_ID() > 0)
							 ? getOriginalProductionCostDetails(as, line.getM_Product_ID(), line.getReversalLine_ID())
							 : Collections.emptyList();
					 if (origLotCds.size() > 1
							 || (origLotCds.size() == 1 && origLotCds.get(0).getM_AttributeSetInstance_ID() != line.getM_AttributeSetInstance_ID()))
					 {
						 for (MCostDetail origCd : origLotCds)
						 {
							 int refId = line.get_ID() > line.getReversalLine_ID() ? origCd.getM_CostDetail_ID() : 0;
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
						 continue;
					 }
					 int Ref_CostDetail_ID = 0;
					 if (line.getReversalLine_ID() > 0 && line.get_ID() > line.getReversalLine_ID())
					 {
						 MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
								 line.getReversalLine_ID(), 0, getTrxName());
						 if (cd != null)
							 Ref_CostDetail_ID = cd.getM_CostDetail_ID();
					 }
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
			else
			{		
				if (line.isProductionBOM() && !(MAcctSchema.COSTINGMETHOD_StandardCosting.equals(costingMethod)))
				{
					int Ref_CostDetail_ID = 0;
					if (line.getReversalLine_ID() > 0 && line.get_ID() > line.getReversalLine_ID())
					{
						MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
								line.getReversalLine_ID(), 0, getTrxName());
						if (cd != null)
							Ref_CostDetail_ID = cd.getM_CostDetail_ID();
					}
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
					int Ref_CostDetail_ID = 0;
					if (line.getReversalLine_ID() > 0 && line.get_ID() > line.getReversalLine_ID())
					{
						MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
								line.getReversalLine_ID(), 0, getTrxName());
						if (cd != null)
							Ref_CostDetail_ID = cd.getM_CostDetail_ID();
					}
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

	private boolean postProductionChargeLine(Fact fact, MAcctSchema as, DocLine line,
			int M_CostElement_ID, int C_Charge_ID, MAccount chargeAcct, BigDecimal signedAmt)
	{
		BigDecimal drAmt = signedAmt.signum() < 0 ? null : signedAmt;
		BigDecimal crAmt = signedAmt.signum() < 0 ? signedAmt.abs() : null;
		FactLine fl = DocManualCostHelper.createManualCostChargeLine(this, fact, as, line, M_CostElement_ID, C_Charge_ID, chargeAcct,
				drAmt, crAmt, signedAmt.negate());
		if (fl == null)
			return false;
		fl.setM_Locator_ID(line.getM_Locator_ID());
		fl.setQty(line.getQty());
		return true;
	}

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
		List<MCostDetail> origCds = getOriginalProductionCostDetails(as, line.getM_Product_ID(), origLineId);
		if (origCds.isEmpty())
			return null;
		BigDecimal sumAmt = BigDecimal.ZERO;
		for (MCostDetail cd : origCds)
		{
			if (cd.getM_AttributeSetInstance_ID() == asiId && cd.getQty().negate().compareTo(line.getQty()) == 0)
				return cd.getAmt().negate();
			sumAmt = sumAmt.add(cd.getAmt());
		}
		return sumAmt.negate();
	}

	private BigDecimal getOriginalProductionMaCost(MAcctSchema as, DocLine line, int maAsiId)
	{
		int origLineId = line.getReversalLine_ID();
		if (origLineId <= 0)
			return null;
		MCostDetail origCd = MCostDetail.getProduction(as, line.getM_Product_ID(), maAsiId, origLineId, 0, getTrxName());
		return origCd != null ? origCd.getAmt().negate() : null;
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
