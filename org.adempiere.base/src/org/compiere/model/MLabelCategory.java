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
 * - Nicolas Micoud (TGI)                                              *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.compiere.util.CCache;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * Label Category
 */
public class MLabelCategory extends X_C_LabelCategory implements ImmutablePOSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1413261690113516220L;

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer, MLabelCategory> s_cache	= new ImmutableIntPOCache<Integer,MLabelCategory>(Table_Name, 5);
	/**	Cache of Client						*/
	private static CCache<Integer,MLabelCategory[]>	s_cacheAll = new CCache<Integer,MLabelCategory[]>(Table_Name, Table_Name+"_Of_Client", 5);

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_LabelCategory_ID id
	 *	@param trxName transaction
	 */
	public MLabelCategory(Properties ctx, int C_LabelCategory_ID, String trxName) {
		super(ctx, C_LabelCategory_ID, trxName);
	} // MLabelCategory

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MLabelCategory(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MLabelCategory

	/** Returns the first default category */
	public static int getDefaultID(Properties ctx) {

		for (MLabelCategory lc : getAll(ctx)) {
			if (lc.isDefault())
				return lc.getC_LabelCategory_ID();
		}

		return -1;
	}

	/**
	 * 	Get All Label Categories (for AD_Client)
	 *	@param ctx context
	 *	@return MLabelCategory
	 */
	public static MLabelCategory[] getAll(Properties ctx)
	{
		int clientID = Env.getAD_Client_ID(ctx);
		MLabelCategory[] retValue = (MLabelCategory[])s_cacheAll.get(clientID);

		if (retValue != null)
		{
			if (ctx == Env.getCtx())
				return retValue;
			else
				return Arrays.stream(retValue).map(e -> {return new MLabelCategory(ctx, e).markImmutable();}).toArray(MLabelCategory[]::new);
		}

		List<MLabelCategory> list = new Query(ctx, Table_Name, null, null)
				.setClient_ID()
				.setOrderBy("IsDefault DESC, C_LabelCategory_ID")
				.setOnlyActiveRecords(true)
				.list();

		for (MLabelCategory cat : list)
			s_cache.put(cat.get_ID(), cat, e -> new MLabelCategory(Env.getCtx(), e));

		retValue = list.toArray(new MLabelCategory[list.size()]);
		if (ctx == Env.getCtx())
			s_cacheAll.put(clientID, retValue);
		else
			s_cacheAll.put(clientID, Arrays.stream(retValue).map(e -> {return new MLabelCategory(Env.getCtx(), e);}).toArray(MLabelCategory[]::new));
		return retValue;
	}	//	getAll


	/**
	 * 
	 * @param copy
	 */
	public MLabelCategory(MLabelCategory copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MLabelCategory(Properties ctx, MLabelCategory copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MLabelCategory(Properties ctx, MLabelCategory copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}

	@Override
	public MLabelCategory markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

} // MLabelCategory
