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
 * - hengsin                         								   *
 **********************************************************************/
package org.compiere.process;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Savepoint;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.logging.Level;

import javax.sql.RowSet;

import org.compiere.model.MClient;
import org.compiere.model.MCost;
import org.compiere.model.MCostElement;
import org.compiere.model.MDocType;
import org.compiere.model.MInventory;
import org.compiere.model.MInventoryLine;
import org.compiere.model.MProduct;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.wf.MWorkflow;

/**
 * 
 * @author hengsin
 *
 */
@org.adempiere.base.annotation.Process
public class RollUpCosts extends SvrProcess {
	private int category = 0;
	private int product_id = 0;
	private int costelement_id = 0;
	private int charge_id = 0;
	private HashSet<Integer> processed;
	
	private Map<Integer, MInventory> inventoryDocs = new HashMap<>();
	private Map<String, MInventoryLine> inventoryLines = new HashMap<>();
	private MDocType adjustmentDocType = null;
	
	@Override
	protected void prepare() 
	{
	
		int chosen_id = 0;
				
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("M_Product_Category_ID"))
				category = para[i].getParameterAsInt();
			else if (name.equals("M_Product_ID"))
				chosen_id = para[i].getParameterAsInt();
			else if (name.equals("M_CostElement_ID"))
				costelement_id = para[i].getParameterAsInt();
			else if (name.equals("C_Charge_ID"))
				charge_id = para[i].getParameterAsInt();
			else
				log.log(Level.WARNING, "Unknown Parameter: " + name);		
		}
		
		if (getTable_ID() == MProduct.Table_ID)
		{
			product_id = getRecord_ID();
			if (product_id == 0)
			{
				product_id = chosen_id;
			}
		}
		else
		{
			product_id = chosen_id;
		}
	}
	
	@Override
	protected String doIt() throws Exception
	{
		processed = new HashSet<Integer>();
		
		MDocType[] doctypes = MDocType.getOfDocBaseType(getCtx(), MDocType.DOCBASETYPE_MaterialPhysicalInventory);
		for(MDocType dt : doctypes)
		{
			if (MDocType.DOCSUBTYPEINV_CostAdjustment.equals(dt.getDocSubTypeInv()))
			{
				adjustmentDocType = dt;
				break;
			}
		}
		
		if (adjustmentDocType == null)
			throw new IllegalStateException("Failed to find cost adjustment document type");
		
		String result = rollUp();
		
		if (inventoryDocs.size() > 0) {
			for(MInventory costingDoc : inventoryDocs.values())
			{
				ProcessInfo info = MWorkflow.runDocumentActionWorkflow(costingDoc, DocAction.ACTION_Complete);
				if (info.isError()) 
				{
					StringBuilder msg = new StringBuilder();
					msg.append(Msg.getMsg(getCtx(), "ProcessFailed")).append(": ");
					msg.append(info.getSummary());
					addLog(getAD_PInstance_ID(), null, null, msg.toString());
				}
				else
				{
					costingDoc.saveEx();
					addBufferLog(getAD_PInstance_ID(), null, null, costingDoc.toString(), MInventory.Table_ID, costingDoc.get_ID());
				}
			}
		}
		
		return result;
	}
	

	/**
	 * do rollup
	 * @return number of records updated
	 * @throws Exception
	 */
	protected String rollUp() throws Exception {		
		int count = 0;
		if (product_id != 0) //only for the product
		{
			String error = rollUpCosts(product_id);
			if (!Util.isEmpty(error))
			{
				addLog(getAD_PInstance_ID(), null, null, "Rollup BOM Cost is not applicable for the product " + MProduct.get(getCtx(), product_id).getName() 
						+ ". Details: " + error, MProduct.Table_ID, product_id);
			}
			else
			{
				count++;
			}
		}
		else if (category != 0) //roll up for all categories
		{
			String sql = "SELECT M_PRODUCT_ID FROM M_PRODUCT WHERE M_PRODUCT_CATEGORY_ID = " + 
			    category + " AND AD_CLIENT_ID = " + getAD_Client_ID() + 
			    " AND M_PRODUCT_ID IN (SELECT b.M_PRODUCT_ID FROM PP_PRODUCT_BOM b " +
			    " JOIN PP_PRODUCT_BOMLINE bl ON b.PP_PRODUCT_BOM_ID = bl.PP_PRODUCT_BOM_ID" +
			    " WHERE b.AD_Client_ID=" + getAD_Client_ID() +" AND b.IsActive='Y' AND bl.IsActive='Y' AND b.BOMType='A' AND b.BOMUse='A')";
			Trx trx = Trx.get(get_TrxName(), false);
		    RowSet results = DB.getRowSet(sql);
			while (results.next())
			{
				Savepoint savepoint = trx.setSavepoint(null);
				int id= results.getInt(1);
				String error = rollUpCosts(id);
				if (!Util.isEmpty(error))
				{
					addLog(getAD_PInstance_ID(), null, null, "Rollup BOM Cost is not applicable for the product " + MProduct.get(getCtx(), id).getName() 
							+ ". Details: " + error, MProduct.Table_ID, product_id);
					trx.rollback(savepoint);
				}
				else
				{
					trx.releaseSavepoint(savepoint);
					count++;
				}
			}
		}
		else //do it for all products 
		{
			String sql = "SELECT M_PRODUCT_ID FROM M_PRODUCT WHERE AD_CLIENT_ID = " + getAD_Client_ID() + 
			   " AND M_PRODUCT_ID IN (SELECT b.M_PRODUCT_ID FROM PP_PRODUCT_BOM b " +
			   " JOIN PP_PRODUCT_BOMLINE bl ON b.PP_PRODUCT_BOM_ID = bl.PP_PRODUCT_BOM_ID" +
			   " WHERE b.AD_Client_ID=" + getAD_Client_ID() +" AND b.IsActive='Y' AND bl.IsActive='Y' AND b.BOMType='A' AND b.BOMUse='A')";
			Trx trx = Trx.get(get_TrxName(), false);
	        RowSet results = DB.getRowSet(sql);
		    while (results.next())
		    {
		    	Savepoint savepoint = trx.setSavepoint(null);
		    	int id= results.getInt(1);		    	
				String error = rollUpCosts(id);
				if (!Util.isEmpty(error))
				{
					addLog(getAD_PInstance_ID(), null, null, "Rollup BOM Cost is not applicable for the product " + MProduct.get(getCtx(), id).getName() 
							+ ". Details: " + error, MProduct.Table_ID, product_id);
					trx.rollback(savepoint);
				}
				else
				{
					trx.releaseSavepoint(savepoint);
					count++;
				}
		    }
	    }
		
		return count + " Product Cost Updated.";
	}
    
	/**
	 * 
	 * @param productId
	 * @return error message (if any)
	 * @throws Exception
	 */
	protected String rollUpCosts(int productId) throws Exception 
	{
		String sql = "SELECT bl.M_Product_ID FROM PP_Product_BOMLine bl " 
			+ " JOIN PP_PRODUCT_BOM b " 
			+ " ON ( b.PP_PRODUCT_BOM_ID = bl.PP_PRODUCT_BOM_ID ) WHERE b.M_Product_ID = ?"
			+ " AND b.AD_Client_ID = " + getAD_Client_ID()
			+ " AND b.BOMUse='A' AND b.BOMType='A' AND b.IsActive='Y' AND bl.IsActive='Y' ";
		int[] prodbomids = DB.getIDsEx(get_TrxName(), sql.toString(), productId);
		
		for (int prodbomid : prodbomids) {
			if ( !processed.contains(prodbomid)) {
				String error = rollUpCosts(prodbomid);
				if (!Util.isEmpty(error))
					return error;
			}
		}
		
		MProduct product = new MProduct(getCtx(), productId, get_TrxName());
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//once the subproducts costs are accurate, calculate the costs for this product
			StringBuilder productCostSql = new StringBuilder("SELECT * FROM M_Cost ")
					.append(" WHERE M_Product_ID = ").append(productId).append(" AND AD_Client_ID = ").append(getAD_Client_ID())
					.append(" AND M_CostElement_ID = ").append(costelement_id)
					.append(" AND C_AcctSchema_ID = ").append(MClient.get(getAD_Client_ID()).getAcctSchema().getC_AcctSchema_ID())
					.append(" AND M_PRODUCT_ID IN (SELECT b.M_PRODUCT_ID FROM PP_PRODUCT_BOM b ")
					.append(" JOIN PP_PRODUCT_BOMLINE bl ON b.PP_PRODUCT_BOM_ID = bl.PP_PRODUCT_BOM_ID")
					.append(" WHERE b.BOMType='A' AND b.BOMUse='A' AND b.IsActive='Y' ") 
					.append(" AND b.AD_Client_ID=").append(getAD_Client_ID()).append(")");
	
			pstmt = DB.prepareStatement(productCostSql.toString(), get_TrxName());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MCost cost = new MCost(getCtx(), rs, get_TrxName());
				
				StringBuilder newCurrentCostPriceSql = new StringBuilder("SELECT SUM(b.QtyBOM * c.CurrentCostPrice)")
						.append(" FROM PP_Product_BOMLine b ")
						.append(" INNER JOIN M_Cost c ON (b.M_PRODUCT_ID = c.M_Product_ID) ") 
						.append(" JOIN PP_Product_BOM bom ON (bom.PP_PRODUCT_BOM_ID = b.PP_PRODUCT_BOM_ID AND bom.IsActive='Y') ")
						.append(" WHERE bom.M_Product_ID = ").append(productId).append(" AND bom.BOMType='A' AND bom.BOMUse='A' AND M_CostElement_ID = ").append(costelement_id)
						.append(" AND c.C_AcctSchema_ID = ").append(cost.getC_AcctSchema_ID());
				BigDecimal newCurrentCostPrice = DB.getSQLValueBD(get_TrxName(), newCurrentCostPriceSql.toString());
				if (newCurrentCostPrice == null)
					newCurrentCostPrice = BigDecimal.ZERO;
				
				StringBuilder newFutureCostPriceSql = new StringBuilder("SELECT SUM(b.QtyBOM * c.FutureCostPrice)")
						.append(" FROM PP_Product_BOMLine b ") 
						.append(" INNER JOIN M_Cost c ON (b.M_PRODUCT_ID = c.M_Product_ID) ") 
						.append(" JOIN PP_Product_BOM bom ON (bom.PP_PRODUCT_BOM_ID = b.PP_PRODUCT_BOM_ID AND bom.IsActive='Y') ")
						.append(" WHERE bom.M_Product_ID = ").append(productId).append(" AND M_CostElement_ID = ").append(costelement_id)
						.append(" AND c.C_AcctSchema_ID = ").append(cost.getC_AcctSchema_ID());
				BigDecimal newFutureCostPrice = DB.getSQLValueBD(get_TrxName(), newFutureCostPriceSql.toString());
				if (newFutureCostPrice == null)
					newFutureCostPrice = BigDecimal.ZERO;
				
				StringBuilder qtyOnHandSql = new StringBuilder("SELECT SUM(QtyOnHand)")
						.append(" FROM M_StorageOnHand oh ")
						.append(" JOIN M_Locator loc ON (oh.M_Locator_ID=loc.M_Locator_ID)")
						.append(" JOIN M_Warehouse w ON (w.M_Warehouse_ID=loc.M_Warehouse_ID)")
						.append(" WHERE oh.M_Product_ID=").append(productId)
						.append(" AND w.IsActive='Y'")
						.append(" AND w.AD_Client_ID=").append(getAD_Client_ID());				
				if (cost.getM_AttributeSetInstance_ID() != 0)
					qtyOnHandSql.append(" AND oh.M_AttributeSetInstance_ID=").append(cost.getM_AttributeSetInstance_ID());

				BigDecimal qtyOnHand = DB.getSQLValueBD(get_TrxName(), qtyOnHandSql.toString());
				if (qtyOnHand == null)
					qtyOnHand = BigDecimal.ZERO;
				
				if (cost.getCurrentCostPrice().compareTo(newCurrentCostPrice) != 0) 
				{
					MInventory costingDoc = createCostingDoc(product);
					
					String key = costingDoc.getM_Inventory_ID() + "_" + cost.getM_Product_ID() + "_" + cost.getM_AttributeSetInstance_ID();
					MInventoryLine costingLine = inventoryLines.get(key);
					if (costingLine == null) {
						costingLine = new MInventoryLine(getCtx(), 0, get_TrxName());
						costingLine.setAD_Org_ID(costingDoc.getAD_Org_ID());
						costingLine.setM_Inventory_ID(costingDoc.getM_Inventory_ID());
						costingLine.setM_Product_ID(cost.getM_Product_ID());
						costingLine.setM_AttributeSetInstance_ID(cost.getM_AttributeSetInstance_ID());
						costingLine.setC_Charge_ID(charge_id);
						costingLine.setCurrentCostPrice(cost.getCurrentCostPrice());
						costingLine.setM_Locator_ID(0);
					}
					
					costingLine.setNewCostPrice(newCurrentCostPrice);
					costingLine.saveEx();
					
					inventoryLines.put(key, costingLine);					
				}
				
				if (cost.getFutureCostPrice().compareTo(newFutureCostPrice) != 0) {
					cost.setFutureCostPrice(newFutureCostPrice);
				}
				
				if (cost.is_Changed())
					cost.saveEx();
			}
		}
		finally {
			DB.close(rs, pstmt);
		}
		
		processed.add(productId);
		
		return null;
	}
	
	private MInventory createCostingDoc(MProduct product) {
		int AD_Org_ID = product.getAD_Org_ID() > 0 ? product.getAD_Org_ID() : Env.getAD_Org_ID(getCtx());
		MInventory costingDoc = inventoryDocs.get(AD_Org_ID);
		if (costingDoc == null)
		{
			costingDoc = new MInventory(getCtx(), 0, get_TrxName());
			costingDoc.setAD_Org_ID(AD_Org_ID);
			costingDoc.setDescription("Created due to rollup BOM cost process ID " + getAD_PInstance_ID());
			costingDoc.setC_DocType_ID(adjustmentDocType.getC_DocType_ID());
			costingDoc.setCostingMethod(MCostElement.get(getCtx(), costelement_id).getCostingMethod());
			costingDoc.setDocAction(DocAction.ACTION_Complete);
			costingDoc.saveEx();
			inventoryDocs.put(AD_Org_ID, costingDoc);
		}		
		return costingDoc;
	}	
}
