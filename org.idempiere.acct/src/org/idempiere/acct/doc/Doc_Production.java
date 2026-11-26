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
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MAccount;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MCharge;
import org.compiere.model.MCost;
import org.compiere.model.MCost.ManualCost;
import org.compiere.model.MCostDetail;
import org.compiere.model.MFactAcct;
import org.compiere.model.MProduct;
import org.compiere.model.MProduction;
import org.compiere.model.MProductionLineMA;
import org.compiere.model.MProductionPlan;
import org.compiere.model.ProductCost;
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
	private Map<Integer, Integer> m_reversalLineMap;
	
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
		m_reversalLineMap = null;
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
		catch (Exception ee)
		{
			log.log(Level.SEVERE, sqlPL, ee);
		}
		finally
		{
			DB.close(rsPL, pstmtPL);
			rsPL = null;
			pstmtPL = null;
		}

		if (prod.getReversal_ID() > 0 && prod.getM_Production_ID() > prod.getReversal_ID())
			m_reversalLineMap = loadReversalLineMap(prod, list);
			
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

	private Map<Integer, Integer> loadReversalLineMap(X_M_Production prod, List<DocLine> revLines)
	{
		List<X_M_ProductionLine> origLines = new ArrayList<>();
		String sql = getProductionLinesSQL(prod.isUseProductionPlan());
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, getTrxName());
			pstmt.setInt(1, prod.getReversal_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				X_M_ProductionLine origLine = new X_M_ProductionLine(getCtx(), rs, getTrxName());
				if (origLine.getMovementQty().signum() != 0)
					origLines.add(origLine);
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e, sql);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		Map<Integer, Integer> map = new HashMap<>();
		Set<Integer> usedOrigIds = new HashSet<>();
		for (int i = 0; i < revLines.size(); i++)
		{
			X_M_ProductionLine revLine = (X_M_ProductionLine) revLines.get(i).getPO();
			X_M_ProductionLine matched = null;
			if (i < origLines.size())
			{
				X_M_ProductionLine candidate = origLines.get(i);
				if (!usedOrigIds.contains(candidate.getM_ProductionLine_ID())
						&& isMatchingReversalLine(candidate, revLine, true))
				{
					matched = candidate;
				}
			}
			if (matched == null)
			{
				for (X_M_ProductionLine candidate : origLines)
				{
					if (!usedOrigIds.contains(candidate.getM_ProductionLine_ID())
							&& isMatchingReversalLine(candidate, revLine, true))
					{
						matched = candidate;
						break;
					}
				}
			}
			if (matched == null)
			{
				for (X_M_ProductionLine candidate : origLines)
				{
					if (!usedOrigIds.contains(candidate.getM_ProductionLine_ID())
							&& isMatchingReversalLine(candidate, revLine, false))
					{
						matched = candidate;
						break;
					}
				}
			}
			if (matched != null)
			{
				usedOrigIds.add(matched.getM_ProductionLine_ID());
				map.put(revLine.getM_ProductionLine_ID(), matched.getM_ProductionLine_ID());
			}
		}
		return map;
	}

	private boolean isMatchingReversalLine(X_M_ProductionLine orig, X_M_ProductionLine rev, boolean matchLineNo)
	{
		if (matchLineNo && orig.getLine() != rev.getLine())
			return false;
		return orig.getM_Product_ID() == rev.getM_Product_ID()
				&& orig.getM_Locator_ID() == rev.getM_Locator_ID()
				&& orig.getM_AttributeSetInstance_ID() == rev.getM_AttributeSetInstance_ID()
				&& orig.getMovementQty().negate().compareTo(rev.getMovementQty()) == 0;
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
		if (isReversal && !hasPostedFacts(as, MProduction.Table_ID, prod.getReversal_ID()))
		{
			p_Error = Msg.getMsg(getCtx(), "Original Production not posted yet");
			log.log(Level.WARNING, p_Error);
			return null;
		}
		boolean isPostedReversal = isReversal;
		Map<Integer, List<MFactAcct>> reversedLineFactsMap = isPostedReversal ? new HashMap<>() : null;
		int stdPrecision = as.getStdPrecision();

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
					Map<Integer, ManualCost> maManualCostMap = !isPostedReversal && !line.isProductionBOM() && !manualCostMap.containsKey(line.get_ID())
							? new LinkedHashMap<>() : null;
					for (int j = 0; j < mas.length; j++)
					{
						MProductionLineMA ma = mas[j];													
						MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),
								line.get_ID(), getTrxName());	
						BigDecimal maCost;
						if (cd != null)
							maCost = cd.getAmt();	
						else 
						{
							ProductCost pc = line.getProductCost();
							pc.setQty(ma.getMovementQty());
							pc.setM_M_AttributeSetInstance_ID(ma.getM_AttributeSetInstance_ID());
							maCost = line.getProductCosts(as, line.getAD_Org_ID(), false);
						}
						if (maManualCostMap != null)
						{
							accumulateManualCosts(maManualCostMap, MCost.getManualCosts(product, ma.getM_AttributeSetInstance_ID(),
									as, line.getAD_Org_ID(), maCost, ma.getMovementQty(), getTrxName()));
						}
						costs = costs.add(maCost);
						costs = costs.setScale(stdPrecision, RoundingMode.HALF_UP);
						costMap.put(line.get_ID()+ "_"+ ma.getM_AttributeSetInstance_ID(), costs);
					}
					if (maManualCostMap != null)
						manualCostMap.put(line.get_ID(), roundManualCosts(maManualCostMap.values(), stdPrecision));
				} 
				else
				{
					MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							line.get_ID(), getTrxName());
					if (cd != null) 
					{
						costs = cd.getAmt();
					} 
					else 
					{
						costs = line.getProductCosts(as, line.getAD_Org_ID(), false);
					}
					if (!isPostedReversal && !line.isProductionBOM() && !manualCostMap.containsKey(line.get_ID()))
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
			
				// MZ Goodwill
				// if Production CostDetail exist then get Cost from Cost Detail
				MCostDetail cd = MCostDetail.getProduction(as, line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
						line.get_ID(), getTrxName());
				if (cd != null) 
				{
					costs = cd.getAmt();
				} 
				else 
				{
					costs = line.getProductCosts(as, line.getAD_Org_ID(), false);
				}
				if (!isPostedReversal && !line.isProductionBOM() && !manualCostMap.containsKey(line.get_ID()))
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
						List<ManualCost> line0ManualCosts = !isPostedReversal ? manualCostMap.get(line0.get_ID()) : null;
						List<MFactAcct> line0OrigFacts = isPostedReversal
								? getReversedProductionLineFacts(as, prod.getReversal_ID(), line0.get_ID(), reversedLineFactsMap)
								: Collections.emptyList();
						if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel0) )
						{
							if (bomProLine.getM_AttributeSetInstance_ID() == 0 ) 
							{
								MProductionLineMA bomLineMA[] = MProductionLineMA.get(getCtx(), line0.get_ID(), getTrxName());
								if (bomLineMA!=null && bomLineMA.length> 0 )
								{
								 // get cost of children for batch costing level (auto generate)									
									BigDecimal costs0 = BigDecimal.ZERO ;
									Map<Integer, ManualCost> maManualCostMap = !isPostedReversal && line0ManualCosts == null ? new LinkedHashMap<>() : null;
									for (int j = 0; j < bomLineMA.length; j++)
									{
										BigDecimal maCost = BigDecimal.ZERO ;
										MProductionLineMA ma = bomLineMA[j];								
										// get cost of children
										MCostDetail cd0 = MCostDetail.getProduction(as, line0.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),
												line0.get_ID(), getTrxName());
										if (cd0 != null) 
											maCost = cd0.getAmt();
										else 
										{
											ProductCost pc = line0.getProductCost();
											pc.setQty(ma.getMovementQty());
											pc.setM_M_AttributeSetInstance_ID(ma.getM_AttributeSetInstance_ID());
											maCost = line0.getProductCosts(as, line0.getAD_Org_ID(), false);
										}
										if (maManualCostMap != null)
										{
											accumulateManualCosts(maManualCostMap, MCost.getManualCosts(product0, ma.getM_AttributeSetInstance_ID(),
													as, line0.getAD_Org_ID(), maCost, ma.getMovementQty(), getTrxName()));
										}
										maCost = maCost.setScale(stdPrecision, RoundingMode.HALF_UP);
										costMap.put(line0.get_ID()+ "_"+ ma.getM_AttributeSetInstance_ID(),maCost);
										costs0 = costs0.add(maCost);
									}						
									if (line0OrigFacts.isEmpty())
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
								MCostDetail cd0 = MCostDetail.getProduction(as, line0.getM_Product_ID(), line0.getM_AttributeSetInstance_ID(),
										line0.get_ID(), getTrxName());
								BigDecimal costs0;
								if (cd0 != null) 
								{
									costs0 = cd0.getAmt();
								} 
								else 
								{
									costs0 = line0.getProductCosts(as, line0.getAD_Org_ID(), false);
								}
								if (!isPostedReversal && line0ManualCosts == null)
								{
									line0ManualCosts = roundManualCosts(
											MCost.getManualCosts(product0, line0.getM_AttributeSetInstance_ID(),
													as, line0.getAD_Org_ID(), costs0, line0.getQty(), getTrxName()),
											stdPrecision);
									manualCostMap.put(line0.get_ID(), line0ManualCosts);
								}
								costs0 = costs0.setScale(stdPrecision, RoundingMode.HALF_UP);
								costMap.put(line0.get_ID()+ "_"+ line0.getM_AttributeSetInstance_ID(),costs0);
								if (line0OrigFacts.isEmpty())
									bomCost = bomCost.add(costs0);
							}
							
						}  
						else
						{
						// get cost of children
							MCostDetail cd0 = MCostDetail.getProduction(as, line0.getM_Product_ID(), line0.getM_AttributeSetInstance_ID(),
									line0.get_ID(), getTrxName());
							BigDecimal costs0;
							if (cd0 != null) 
							{
								costs0 = cd0.getAmt();
							} 
							else 
							{
								costs0 = line0.getProductCosts(as, line0.getAD_Org_ID(), false);
							}
							if (!isPostedReversal && line0ManualCosts == null)
							{
								line0ManualCosts = roundManualCosts(
										MCost.getManualCosts(product0, line0.getM_AttributeSetInstance_ID(),
												as, line0.getAD_Org_ID(), costs0, line0.getQty(), getTrxName()),
										stdPrecision);
								manualCostMap.put(line0.get_ID(), line0ManualCosts);
							}
							costs0 = costs0.setScale(stdPrecision, RoundingMode.HALF_UP);
							costMap.put(line0.get_ID()+ "_"+ line0.getM_AttributeSetInstance_ID(),costs0);
							if (line0OrigFacts.isEmpty())
								bomCost = bomCost.add(costs0);
						}
						if (!line0OrigFacts.isEmpty())
						{
							for (MFactAcct origFact : line0OrigFacts)
								bomCost = bomCost.add(origFact.getAmtAcctCr().subtract(origFact.getAmtAcctDr()));
						}
						else if (line0ManualCosts != null)
						{
							for (ManualCost manualCost : line0ManualCosts)
								bomCost = bomCost.add(manualCost.getAmount());
						}
					}
				}
				
				qtyProduced = manipulateQtyProduced (mQtyProduced, endProLine, prod.isUseProductionPlan(), null);
				if (line.getQty().compareTo(qtyProduced) != 0) 
				{
					BigDecimal factor = line.getQty().divide(qtyProduced, 12, RoundingMode.HALF_UP);
					bomCost = bomCost.multiply(factor).setScale(stdPrecision, RoundingMode.HALF_UP);
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

			List<MFactAcct> origCompFacts = isPostedReversal && !line.isProductionBOM()
					? getReversedProductionLineFacts(as, prod.getReversal_ID(), line.get_ID(), reversedLineFactsMap)
					: Collections.emptyList();

			//  Inventory       DR      CR
			if (!(line.isProductionBOM() && MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel))
					&& origCompFacts.isEmpty())
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
				if (!origCompFacts.isEmpty())
				{
					for (MFactAcct origFact : origCompFacts)
					{
						fl = createReversedChargeFactLine(fact, as, line, origFact);
						if (fl == null)
						{
							p_Error = "No Costs for Line " + line.getLine() + " - " + line;
							return null;
						}
					}
				}
				else if (!isPostedReversal)
				{
					List<ManualCost> lineManualCosts = manualCostMap.get(line.get_ID());
					if (lineManualCosts != null)
					{
						for (ManualCost manualCost : lineManualCosts)
						{
							MAccount chargeAcct = MCharge.getAccount(manualCost.getCostElement().getC_Charge_ID(), as, getTrxName());
							fl = fact.createLine(line, chargeAcct,
									as.getC_Currency_ID(), manualCost.getAmount());
							if (fl == null)
							{
								p_Error = "No Costs for Line " + line.getLine() + " - " + line;
								return null;
							}
							fl.setC_Charge_ID(manualCost.getCostElement().getC_Charge_ID());
							fl.setM_Locator_ID(line.getM_Locator_ID());
							fl.setQty(line.getQty());
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
							bomCost.negate(), qtyProduced,
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

	private List<MFactAcct> getReversedProductionLineFacts(MAcctSchema as, int origProductionId, int revLineId,
			Map<Integer, List<MFactAcct>> cache)
	{
		if (cache.containsKey(revLineId))
			return cache.get(revLineId);
		Integer origLineId = m_reversalLineMap != null ? m_reversalLineMap.get(revLineId) : null;
		List<MFactAcct> lineFacts = origLineId != null
				? getPostedLineFacts(as, MProduction.Table_ID, origProductionId, origLineId)
				: Collections.emptyList();
		cache.put(revLineId, lineFacts);
		return lineFacts;
	}

}   //  Doc_Production
