/**********************************************************************
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
 * - Nicolas Micoud - TGI                                              *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.compiere.util.CCache;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Sales Pipeline Model
 *  @author Nicolas Micoud
 *  @version $Id: MSalesPipeline.java
 */
public class MSalesPipeline extends X_C_SalesPipeline implements ImmutablePOSupport
{
	private static final long serialVersionUID = 5972622552430578603L;
	private static ImmutablePOCache<Integer, MSalesPipeline> s_cache = new ImmutablePOCache<Integer, MSalesPipeline>(Table_Name, 50);
	private static CCache<Integer, MSalesPipeline[]> s_cacheAll = new CCache<Integer, MSalesPipeline[]>(Table_Name + "_Of_Client", 50);

	public MSalesPipeline (Properties ctx, int C_SalesPipeline_ID, String trxName) {
		super (ctx, C_SalesPipeline_ID, trxName);
	}	//	MSalesPipeline

	public MSalesPipeline (Properties ctx, ResultSet rs, String trxName) {
		super (ctx, rs, trxName);
	}	//	MSalesPipeline

	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		if (success)
			s_cacheAll.remove(getAD_Client_ID());
		return success;
	}

	@Override
	protected boolean afterDelete(boolean success) {
		if (success)
			s_cacheAll.remove(getAD_Client_ID());
		return success;
	}

	public static MSalesPipeline get (Properties ctx, int salesPipelineID) {

		if (salesPipelineID <= 0)
			return null;

		MSalesPipeline retValue = s_cache.get (ctx, salesPipelineID, e -> new MSalesPipeline(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MSalesPipeline (ctx, salesPipelineID, null);
		if (retValue.get_ID () == salesPipelineID) {
			s_cache.put (salesPipelineID, retValue, e -> new MSalesPipeline(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	@Override
	public MSalesPipeline markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	public MSalesPipeline(Properties ctx, MSalesPipeline copy) {
		this(ctx, copy, (String) null);
	}

	public MSalesPipeline(Properties ctx, MSalesPipeline copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}

	public static MSalesPipeline[] getAll (Properties ctx, int clientID) {
		MSalesPipeline[] retValue = (MSalesPipeline[]) s_cacheAll.get(clientID);

		if (retValue != null) {
			if (ctx == Env.getCtx())
				return retValue;
			else
				return Arrays.stream(retValue).map(e -> {return new MSalesPipeline(ctx, e).markImmutable();}).toArray(MSalesPipeline[]::new);
		}

		List<MSalesPipeline> list = new Query(ctx, Table_Name, "AD_Client_ID = ?", null)
				.setParameters(clientID)
				.setOnlyActiveRecords(true)
				.setOrderBy("C_SalesPipeline_ID")
				.list();

		for (MSalesPipeline cc : list)
			s_cache.put(cc.get_ID(), cc, e -> new MSalesPipeline(Env.getCtx(), e));

		retValue = list.toArray(new MSalesPipeline[list.size()]);
		if (ctx == Env.getCtx())
			s_cacheAll.put(clientID, retValue);
		else
			s_cacheAll.put(clientID, Arrays.stream(retValue).map(e -> {return new MSalesPipeline(Env.getCtx(), e);}).toArray(MSalesPipeline[]::new));
		return retValue;
	}	//	getAll

	public static MSalesPipeline getDefault(Properties ctx, int clientID) {

		for (MSalesPipeline sp : getAll(ctx, clientID)) {
			if (sp.isDefault())
				return sp;
		}

		return null;
	}

}	//	MSalesPipeline
