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
 * - Elaine Tan                         							   *
 **********************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.DBException;
import org.compiere.util.DB;

/**
 * Cost History Model
 */
public class MCostHistory extends X_M_CostHistory implements ICostInfo {
	
	private static final long serialVersionUID = -5916746920051232413L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_CostHistory_UU  UUID key
     * @param trxName Transaction
     */
    public MCostHistory(Properties ctx, String M_CostHistory_UU, String trxName) {
        super(ctx, M_CostHistory_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_CostDetail_ID id
	 *	@param trxName trx
	 */
	public MCostHistory (Properties ctx, int M_CostHistory_ID, String trxName)
	{
		super (ctx, M_CostHistory_ID, trxName);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MCostHistory (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MCostHistory
	
	public MCostHistory (MCostDetail cd, MCost cost, MCostElement ce)
	{
		this(cd.getCtx(), 0, cd.get_TrxName());
		setM_AttributeSetInstance_ID(cost.getM_AttributeSetInstance_ID());
		setM_CostDetail_ID(cd.getM_CostDetail_ID());
		setDateAcct(cd.getDateAcct());
		setIsBackDate(cd.isBackDate());
		setBackDateProcessedOn(cd.getBackDateProcessedOn());
		setM_CostElement_ID(ce.getM_CostElement_ID());
		setM_CostType_ID(cost.getM_CostType_ID());
		setM_Product_ID(cost.getM_Product_ID());
		setClientOrg(cost.getAD_Client_ID(), cost.getAD_Org_ID());
		setOldQty(cost.getCurrentQty());
		setOldCostPrice(cost.getCurrentCostPrice());
		setOldCAmt(cost.getCumulatedAmt());
		setOldCQty(cost.getCumulatedQty());
	}
	
	/**
	 * Get Cost History Record by Cost Detail
	 * @param ctx context
	 * @param AD_Org_ID org
	 * @param M_CostType_ID cost type
	 * @param C_AcctSchema_ID accounting schema
	 * @param costingMethod cost method
	 * @param M_CostElement_ID optional cost element
	 * @param M_AttributeSetInstance_ID asi
	 * @param cd cost detail
	 * @param trxName transaction name
	 * @return MCostHistory or null
	 */
	protected static MCostHistory get(Properties ctx, int AD_Org_ID,
			int M_CostType_ID, int C_AcctSchema_ID, String costingMethod, int M_CostElement_ID,
			int M_AttributeSetInstance_ID, MCostDetail cd, 
			String trxName)
	{
		if (cd == null)
			return null;
		
		if (MCostElement.COSTINGMETHOD_StandardCosting.equals(costingMethod))
			return null;
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT c.* ");
		sql.append("FROM M_CostHistory c ");
		sql.append("JOIN M_CostDetail cd ON (cd.M_CostDetail_ID = c.M_CostDetail_ID AND cd.Processed=?) ");
		sql.append("LEFT JOIN M_CostDetail refcd ON (refcd.M_CostDetail_ID=cd.Ref_CostDetail_ID) ");
		sql.append("LEFT OUTER JOIN M_CostElement ce ON (c.M_CostElement_ID=ce.M_CostElement_ID) ");
		sql.append("WHERE c.AD_Client_ID=? AND c.AD_Org_ID=? ");
		sql.append(" AND c.M_Product_ID=? ");
		sql.append(" AND (c.M_AttributeSetInstance_ID=? OR c.M_AttributeSetInstance_ID=0) ");
		sql.append(" AND c.M_CostType_ID=? AND cd.C_AcctSchema_ID=? ");
		sql.append(" AND (ce.CostingMethod IS NULL OR ce.CostingMethod=?) ");
		if (M_CostElement_ID > 0)
			sql.append(" AND c.M_CostElement_ID=? ");
		sql.append(" AND c.M_CostDetail_ID IN (?,?) ");
		sql.append(" AND c.DateAcct=? ");
		sql.append("ORDER BY c.DateAcct DESC, ");
		sql.append("CASE WHEN COALESCE(refcd.DateAcct,cd.DateAcct) = cd.DateAcct THEN COALESCE(cd.Ref_CostDetail_ID, c.M_CostDetail_ID) ELSE c.M_CostDetail_ID END DESC, ");
		sql.append("c.M_CostHistory_ID DESC ");
		String sqlStr = DB.getDatabase().addPagingSQL(sql.toString(), 1, 1);
		 
		List<Object> params = new ArrayList<Object>();
		params.add(cd.isDelta() ? "N" : "Y"); // cost detail is set to processed=N when it is a delta record
		params.add(cd.getAD_Client_ID());
		params.add(AD_Org_ID);
		params.add(cd.getM_Product_ID());
		params.add(M_AttributeSetInstance_ID);
		params.add(M_CostType_ID);
		params.add(C_AcctSchema_ID);
		params.add(costingMethod);
		if (M_CostElement_ID > 0)
			params.add(M_CostElement_ID);
		params.add(cd.getM_CostDetail_ID());
 		params.add(cd.getRef_CostDetail_ID());
 		params.add(cd.getDateAcct());
		
		MCostHistory costHistory = null;
		PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	try
    	{
    		pstmt = DB.prepareStatement(sqlStr, trxName);
    		DB.setParameters(pstmt, params);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			costHistory = new MCostHistory(ctx, rs, trxName);
    			costHistory.makeImmutable();
    		}
    	}
    	catch (SQLException e)
		{
			throw new DBException(e, sql.toString());
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}		
		return costHistory;
	}
	
	/**
	 * Get Cost History Record by Account Date
	 * If no cost history record <= account date, simulate using the first cost history record after account date
	 * @param ctx context
	 * @param AD_Client_ID client
	 * @param AD_Org_ID org
	 * @param M_Product_ID product
	 * @param M_CostType_ID cost type
	 * @param C_AcctSchema_ID as
	 * @param costingMethod costing method
	 * @param M_CostElement_ID optional costing element
	 * @param M_AttributeSetInstance_ID asi
	 * @param dateAcct account date
	 * @param trxName transaction name
	 * @return MCostHistory or null
	 */
	protected static MCostHistory get(Properties ctx, int AD_Client_ID, int AD_Org_ID, int M_Product_ID,
			int M_CostType_ID, int C_AcctSchema_ID, String costingMethod, int M_CostElement_ID,
			int M_AttributeSetInstance_ID, Timestamp dateAcct, 
			String trxName)
	{
		if (dateAcct == null)
			return null;
		
		if (MCostElement.COSTINGMETHOD_StandardCosting.equals(costingMethod))
			return null;
		
		StringBuilder sql = new StringBuilder();
		sql.append("(");
		
		sql.append("SELECT c.* ");
		sql.append("FROM M_CostHistory c ");
		sql.append("JOIN M_CostDetail cd ON (cd.M_CostDetail_ID = c.M_CostDetail_ID AND cd.Processed='Y') ");
		sql.append("LEFT JOIN M_CostDetail refcd ON (refcd.M_CostDetail_ID=cd.Ref_CostDetail_ID) ");
		sql.append("LEFT OUTER JOIN M_CostElement ce ON (c.M_CostElement_ID=ce.M_CostElement_ID) ");
		sql.append("WHERE c.AD_Client_ID=? AND c.AD_Org_ID=? ");
		sql.append(" AND c.M_Product_ID=? ");
		sql.append(" AND (c.M_AttributeSetInstance_ID=? OR c.M_AttributeSetInstance_ID=0) ");
		sql.append(" AND c.M_CostType_ID=? AND cd.C_AcctSchema_ID=? ");
		sql.append(" AND (ce.CostingMethod IS NULL OR ce.CostingMethod=?) ");
		if (M_CostElement_ID > 0)
			sql.append(" AND c.M_CostElement_ID=? ");
		sql.append(" AND c.DateAcct<=? ");
		sql.append("ORDER BY c.DateAcct DESC, ");
		sql.append("CASE WHEN COALESCE(refcd.DateAcct,cd.DateAcct) = cd.DateAcct THEN COALESCE(cd.Ref_CostDetail_ID, c.M_CostDetail_ID) ELSE c.M_CostDetail_ID END DESC, ");
		sql.append("c.M_CostHistory_ID DESC ");
		sql = new StringBuilder(DB.getDatabase().addPagingSQL(sql.toString(), 1, 1));
		
		sql.append(") UNION ALL (");
		
		sql.append("SELECT c.* "); // get the first cost history record
		sql.append("FROM M_CostHistory c ");
		sql.append("JOIN M_CostDetail cd ON (cd.M_CostDetail_ID = c.M_CostDetail_ID AND cd.Processed='Y') ");
		sql.append("LEFT JOIN M_CostDetail refcd ON (refcd.M_CostDetail_ID=cd.Ref_CostDetail_ID) ");
		sql.append("LEFT OUTER JOIN M_CostElement ce ON (c.M_CostElement_ID=ce.M_CostElement_ID) ");
		sql.append("WHERE c.AD_Client_ID=? AND c.AD_Org_ID=? ");
		sql.append(" AND c.M_Product_ID=? ");
		sql.append(" AND (c.M_AttributeSetInstance_ID=? OR c.M_AttributeSetInstance_ID=0) ");
		sql.append(" AND c.M_CostType_ID=? AND cd.C_AcctSchema_ID=? ");
		sql.append(" AND (ce.CostingMethod IS NULL OR ce.CostingMethod=?) ");
		if (M_CostElement_ID > 0)
			sql.append(" AND c.M_CostElement_ID=? ");
		sql.append("ORDER BY c.DateAcct ASC, ");
		sql.append("CASE WHEN COALESCE(refcd.DateAcct,cd.DateAcct) = cd.DateAcct THEN COALESCE(cd.Ref_CostDetail_ID, c.M_CostDetail_ID) ELSE c.M_CostDetail_ID END ASC, ");
		sql.append("c.M_CostHistory_ID DESC ");
		sql = new StringBuilder(DB.getDatabase().addPagingSQL(sql.toString(), 1, 1));
		
		sql.append(")");
		
		List<Object> params = new ArrayList<Object>();
		params.add(AD_Client_ID);
		params.add(AD_Org_ID);
		params.add(M_Product_ID);
		params.add(M_AttributeSetInstance_ID);
		params.add(M_CostType_ID);
		params.add(C_AcctSchema_ID);
		params.add(costingMethod);
		if (M_CostElement_ID > 0)
			params.add(M_CostElement_ID);
		params.add(dateAcct);
		params.add(AD_Client_ID);
		params.add(AD_Org_ID);
		params.add(M_Product_ID);
		params.add(M_AttributeSetInstance_ID);
		params.add(M_CostType_ID);
		params.add(C_AcctSchema_ID);
		params.add(costingMethod);
		if (M_CostElement_ID > 0)
			params.add(M_CostElement_ID);
		
		MCostHistory costHistory = null;
		PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	try
    	{
    		pstmt = DB.prepareStatement(sql.toString(), trxName);
    		DB.setParameters(pstmt, params);
    		rs = pstmt.executeQuery();
    		if (rs.next())
    		{
    			costHistory = new MCostHistory(ctx, rs, trxName);
    			
    			// it is the first cost history record 
    			// if the account date of the cost history record is after the account date parameter
    			if (costHistory.getDateAcct().after(dateAcct)) {
    				costHistory.setNewCAmt(costHistory.getOldCAmt());
    				costHistory.setNewCQty(costHistory.getOldCQty());
    				costHistory.setNewCostPrice(costHistory.getOldCostPrice());
    				costHistory.setNewQty(costHistory.getOldQty());
    			}
    			
    			costHistory.makeImmutable();
    		}
    	}
    	catch (SQLException e)
		{
			throw new DBException(e, sql.toString());
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return costHistory;
	}

	@Override
	public BigDecimal getCumulatedAmt() {
		return getNewCAmt();
	}

	@Override
	public BigDecimal getCumulatedQty() {
		return getNewCQty();
	}

	@Override
	public BigDecimal getCurrentCostPrice() {
		return getNewCostPrice();
	}

	@Override
	public BigDecimal getCurrentQty() {
		return getNewQty();
	}

}
