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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;

import org.compiere.model.MAcctSchema;
import org.compiere.model.MCostDetail;
import org.compiere.model.MProduct;
import org.compiere.model.MProductionLineMA;
import org.compiere.model.ProductCost;
import org.compiere.model.X_M_Production;
import org.compiere.model.X_M_ProductionLine;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *  Post Invoice Documents.
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
		super (as, X_M_Production.class, rs, DOCTYPE_MatProduction, trxName);
	}   //  Doc_Production

	/**
	 *  Load Document Details
	 *  @return error message or null
	 */
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
	 * @return
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
	 *	Load Invoice Line
	 *	@param prod production
	 *  @return DoaLine Array
	 */
	private DocLine[] loadLines(X_M_Production prod)
	{
		ArrayList<DocLine> list = new ArrayList<DocLine>();
		mQtyProduced = new HashMap<>(); 
		String sqlPL = null;
		if (prod.isUseProductionPlan()){
//			Production
			//	-- ProductionLine	- the real level
			sqlPL = "SELECT * FROM "
							+ " M_ProductionLine pro_line INNER JOIN M_ProductionPlan plan ON pro_line.M_ProductionPlan_id = plan.M_ProductionPlan_id "
							+ " INNER JOIN M_Production pro ON pro.M_Production_id = plan.M_Production_id "
							+ " WHERE pro.M_Production_ID=? "
							+ " ORDER BY plan.M_ProductionPlan_id, pro_line.Line";
		}else{
//			Production
			//	-- ProductionLine	- the real level
			sqlPL = "SELECT * FROM M_ProductionLine pl "
					+ "WHERE pl.M_Production_ID=? "
					+ "ORDER BY pl.Line";
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
				//	Identify finished BOM Product
				if (prod.isUseProductionPlan())
					docLine.setProductionBOM(line.getM_Product_ID() == line.getM_ProductionPlan().getM_Product_ID());
				else
					docLine.setProductionBOM(line.getM_Product_ID() == prod.getM_Product_ID());
				
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
			
		DocLine[] dl = new DocLine[list.size()];
		list.toArray(dl);
		return dl;
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
	 *  MMP.
	 *  <pre>
	 *  Production
	 *      Inventory       DR      CR
	 *  </pre>
	 *  @param as account schema
	 *  @return Fact
	 */
	public ArrayList<Fact> createFacts (MAcctSchema as)
	{
		//  create Fact Header
		Fact fact = new Fact(this, as, Fact.POST_Actual);
		setC_Currency_ID (as.getC_Currency_ID());

		//  Line pointer
		FactLine fl = null;
		X_M_Production prod = (X_M_Production)getPO();
		HashMap<String, BigDecimal> costMap =  new HashMap<String, BigDecimal>();

		for (int i = 0; i < p_lines.length; i++)
		{
			DocLine line = p_lines[i];
			//	Calculate Costs
			BigDecimal costs = BigDecimal.ZERO;
			
			X_M_ProductionLine prodline = (X_M_ProductionLine)line.getPO();
			MProductionLineMA mas[] = MProductionLineMA.get(getCtx(), prodline.get_ID(), getTrxName());
			MProduct product = (MProduct) prodline.getM_Product();
			String CostingLevel = product.getCostingLevel(as);
			String costingMethod = product.getCostingMethod(as);

			if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel) ) 
			{
				if (line.getM_AttributeSetInstance_ID() == 0 && (mas!=null && mas.length> 0 )) 
				{
					for (int j = 0; j < mas.length; j++)
					{
						MProductionLineMA ma = mas[j];													
						MCostDetail cd = MCostDetail.get (as.getCtx(), "M_ProductionLine_ID=?",
								line.get_ID(), ma.getM_AttributeSetInstance_ID(), as.getC_AcctSchema_ID(), getTrxName());	
						if (cd != null)
							costs = costs.add(cd.getAmt());	
						else 
						{
							ProductCost pc = line.getProductCost();
							pc.setQty(ma.getMovementQty());
							pc.setM_M_AttributeSetInstance_ID(ma.getM_AttributeSetInstance_ID());
							costs = costs.add(line.getProductCosts(as, line.getAD_Org_ID(), false));
						}
						costMap.put(line.get_ID()+ "_"+ ma.getM_AttributeSetInstance_ID(), costs);
					}
				} 
				else
				{
					MCostDetail cd = MCostDetail.get (as.getCtx(), "M_ProductionLine_ID=?",
							line.get_ID(), line.getM_AttributeSetInstance_ID(), as.getC_AcctSchema_ID(), getTrxName());
					if (cd != null) 
					{
						costs = cd.getAmt();
					} 
					else 
					{
						costs = line.getProductCosts(as, line.getAD_Org_ID(), false);
					}
					costMap.put(line.get_ID()+ "_"+ line.getM_AttributeSetInstance_ID(), costs);
				}
			
			} 
			else 
			{
			
				// MZ Goodwill
				// if Production CostDetail exist then get Cost from Cost Detail
				MCostDetail cd = MCostDetail.get (as.getCtx(), "M_ProductionLine_ID=?",
						line.get_ID(), line.getM_AttributeSetInstance_ID(), as.getC_AcctSchema_ID(), getTrxName());
				if (cd != null) 
				{
					costs = cd.getAmt();
				} 
				else 
				{
					costs = line.getProductCosts(as, line.getAD_Org_ID(), false);
				}
				costMap.put(line.get_ID()+ "_"+ line.getM_AttributeSetInstance_ID(), costs);

			}
			
			int stdPrecision = as.getStdPrecision();
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
						MProduct product0 = (MProduct) bomProLine.getM_Product();
						String CostingLevel0 = product0.getCostingLevel(as);
						if (MAcctSchema.COSTINGLEVEL_BatchLot.equals(CostingLevel0) )
						{
							if (bomProLine.getM_AttributeSetInstance_ID() == 0 ) 
							{
								MProductionLineMA bomLineMA[] = MProductionLineMA.get(getCtx(), line0.get_ID(), getTrxName());
								if (bomLineMA!=null && bomLineMA.length> 0 )
								{
								 // get cost of children for batch costing level (auto generate)									
									BigDecimal costs0 = BigDecimal.ZERO ;
									for (int j = 0; j < bomLineMA.length; j++)
									{
										BigDecimal maCost = BigDecimal.ZERO ;
										MProductionLineMA ma = bomLineMA[j];								
										// get cost of children
										MCostDetail cd0 = MCostDetail.get (as.getCtx(), "M_ProductionLine_ID=?",									
												line0.get_ID(), ma.getM_AttributeSetInstance_ID(), as.getC_AcctSchema_ID(), getTrxName());
										if (cd0 != null) 
											maCost = cd0.getAmt();
										else 
										{
											ProductCost pc = line0.getProductCost();
											pc.setQty(ma.getMovementQty());
											pc.setM_M_AttributeSetInstance_ID(ma.getM_AttributeSetInstance_ID());
											maCost = line0.getProductCosts(as, line0.getAD_Org_ID(), false);
										}
										costMap.put(line0.get_ID()+ "_"+ ma.getM_AttributeSetInstance_ID(),maCost);
										costs0 = costs0.add(maCost);
									}						
									bomCost = bomCost.add(costs0);
								} 
								else
									p_Error = "Failed to post - No Attribute Set for line";
								
							} 
							else
							{
								// get cost of children  for batch costing level 
								MCostDetail cd0 = MCostDetail.get (as.getCtx(), "M_ProductionLine_ID=?",
										line0.get_ID(), line0.getM_AttributeSetInstance_ID(), as.getC_AcctSchema_ID(), getTrxName());
								BigDecimal costs0;
								if (cd0 != null) 
								{
									costs0 = cd0.getAmt();
								} 
								else 
								{
									costs0 = line0.getProductCosts(as, line0.getAD_Org_ID(), false);
								}
								costMap.put(line0.get_ID()+ "_"+ line0.getM_AttributeSetInstance_ID(),costs0);
								bomCost = bomCost.add(costs0);
							}
							
						}  
						else
						{
						// get cost of children
							MCostDetail cd0 = MCostDetail.get (as.getCtx(), "M_ProductionLine_ID=?",
									line0.get_ID(), line0.getM_AttributeSetInstance_ID(), as.getC_AcctSchema_ID(), getTrxName());
							BigDecimal costs0;
							if (cd0 != null) 
							{
								costs0 = cd0.getAmt();
							} 
							else 
							{
								costs0 = line0.getProductCosts(as, line0.getAD_Org_ID(), false);
							}
							costMap.put(line0.get_ID()+ "_"+ line0.getM_AttributeSetInstance_ID(),costs0);
							bomCost = bomCost.add(costs0);
						}
					}
				}
				
				qtyProduced = manipulateQtyProduced (mQtyProduced, endProLine, prod.isUseProductionPlan(), null);
				if (line.getQty().compareTo(qtyProduced) != 0) 
				{
					BigDecimal factor = line.getQty().divide(qtyProduced, 12, RoundingMode.HALF_UP);
					bomCost = bomCost.multiply(factor);
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
					if (!MCostDetail.createProduction(as, line.getAD_Org_ID(),
							line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							line.get_ID(), 0,
							bomCost.negate(), qtyProduced,
							description, getTrxName()))
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
						if (!MCostDetail.createProduction(as, line.getAD_Org_ID(),
								line.getM_Product_ID(), ma.getM_AttributeSetInstance_ID(),
								line.get_ID(), 0,
								maCost, ma.getMovementQty(),
								description, getTrxName()))
						{
							p_Error = "Failed to create cost detail record";
							return null;
						}
					 }
				 } 
				 else
				 {
					 
					 if (!MCostDetail.createProduction(as, line.getAD_Org_ID(),
							line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							line.get_ID(), 0,
							costs, line.getQty(),
							description, getTrxName()))
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
					if (!MCostDetail.createProduction(as, line.getAD_Org_ID(),
							line.getM_Product_ID(), line.getM_AttributeSetInstance_ID(),
							line.get_ID(), 0,
							bomCost.negate(), line.getQty(),
							description, getTrxName()))
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
						description, getTrxName()))
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

}   //  Doc_Production
