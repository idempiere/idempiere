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
package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.cache.ImmutablePOCache;

/**
 * 	Product Category Account Model
 *  @author Jorg Janke
 *  @version $Id: MProductCategoryAcct.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MProductCategoryAcct extends X_M_Product_Category_Acct implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7990259665379770596L;
	/** Static cache */
	private static ImmutablePOCache<String, MProductCategoryAcct>
	s_cache = new ImmutablePOCache<String, MProductCategoryAcct>(Table_Name, 40, 5);
	
	/**
	 * 	Get Category Acct
	 *	@param M_Product_Category_ID category
	 *	@param C_AcctSchema_ID acct schema
	 *	@return category acct
	 */
	public static MProductCategoryAcct get (int M_Product_Category_ID, int C_AcctSchema_ID)
	{
		return get(M_Product_Category_ID, C_AcctSchema_ID, (String)null);
	}
	
	/**
	 * 	Get Category Acct
	 *	@param M_Product_Category_ID category
	 *	@param C_AcctSchema_ID acct schema
	 *	@param trxName trx
	 *	@return category acct
	 */
	public static MProductCategoryAcct get (int M_Product_Category_ID, int C_AcctSchema_ID, String trxName)
	{
		return get(Env.getCtx(), M_Product_Category_ID, C_AcctSchema_ID, trxName);
	}
	
	/**
	 * 	Get Category Acct from cache (immutable)
	 *	@param ctx context
	 *	@param M_Product_Category_ID category
	 *	@param C_AcctSchema_ID acct schema
	 *	@param trxName trx
	 *	@return category acct
	 */
	public static MProductCategoryAcct get (Properties ctx, 
							int M_Product_Category_ID, int C_AcctSchema_ID, String trxName)
	{
		String key = M_Product_Category_ID+"#"+C_AcctSchema_ID;
		MProductCategoryAcct acct = s_cache.get(ctx, key, e -> new MProductCategoryAcct(ctx, e));
		if (acct != null)
			return acct;
		
		final String whereClause = "M_Product_Category_ID=? AND C_AcctSchema_ID=?";
		acct = new Query(ctx, Table_Name, whereClause, trxName)
					.setParameters(M_Product_Category_ID, C_AcctSchema_ID)
					.firstOnly();
		if (acct != null)
		{
			s_cache.put(key, acct, e -> new MProductCategoryAcct(Env.getCtx(), e));
		}
		return acct;
	}	//	get
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param ignored ignored 
	 *	@param trxName
	 */
	public MProductCategoryAcct (Properties ctx, int ignored, String trxName)
	{
		super (ctx, ignored, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	}	//	MProductCategoryAcct

	/**
	 * 	Load Cosntructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MProductCategoryAcct (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MProductCategoryAcct

	/**
	 * 
	 * @param copy
	 */
	public MProductCategoryAcct(MProductCategoryAcct copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MProductCategoryAcct(Properties ctx, MProductCategoryAcct copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MProductCategoryAcct(Properties ctx, MProductCategoryAcct copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * 	Check Costing Setup
	 */
	public void checkCosting()
	{
		//	Create Cost Elements
		if (getCostingMethod() != null && getCostingMethod().length() > 0)
			MCostElement.getMaterialCostElement(this, getCostingMethod());
	}	//	checkCosting

	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		checkCosting();
		return success;
	}	//	afterSave

	@Override
	public MProductCategoryAcct markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("MProductCategoryAcct[");
		sb.append (get_ID())
			.append (",M_Product_Category_ID=").append (getM_Product_Category_ID())
			.append (",C_AcctSchema_ID=").append(getC_AcctSchema_ID())
			.append (",CostingLevel=").append(getCostingLevel())
			.append (",CostingMethod=").append(getCostingMethod())
			.append ("]");
		return sb.toString ();
	}	//	toString

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (!newRecord && is_ValueChanged(COLUMNNAME_CostingLevel)) {
			String newCostingLevel = getCostingLevel();
			String oldCostingLevel = (String) get_ValueOld(COLUMNNAME_CostingLevel);
			I_C_AcctSchema schema = getC_AcctSchema();
			if (newCostingLevel == null)
				newCostingLevel = schema.getCostingLevel();
			if (oldCostingLevel == null)
				oldCostingLevel = schema.getCostingLevel();
			if (!newCostingLevel.equals(oldCostingLevel)) {
				String products = getProductsWithCost();
				if (!Util.isEmpty(products)) {
					log.saveError("Error", Msg.getMsg(getCtx(), "ChangeCostingLevelError") + ". Products: " + products);
					return false; 
				}
			}
		}
		return true;
	}
	
	private String getProductsWithCost() {
		StringBuilder products = new StringBuilder();
		StringBuilder sql = new StringBuilder("SELECT DISTINCT p.Value FROM M_Product p JOIN M_CostDetail d ON p.M_Product_ID=d.M_Product_ID");
		sql.append(" WHERE p.IsActive='Y' AND p.M_Product_Category_ID=? AND d.C_AcctSchema_ID=?");
		String query = DB.getDatabase().addPagingSQL(sql.toString(), 0, 50);
		List<List<Object>> list = DB.getSQLArrayObjectsEx(get_TrxName(), query, getM_Product_Category_ID(), getC_AcctSchema_ID());
		if (list != null) {
			for(List<Object> entry : list) {
				String value = (String) entry.get(0);
				if (products.length() > 0)
					products.append(",");
				products.append(value);
			}
		}
		return products.toString();
	}
}	//	MProductCategoryAcct
