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
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Sales Pipeline Stage Model
 *  @author Nicolas Micoud
 *  @version $Id: MSalesPipelineStage.java
 */
public class MSalesPipelineStage extends X_C_SalesPipeline_Stage implements ImmutablePOSupport
{
	private static final long serialVersionUID = -1434268649136407257L;
	private static CLogger s_log = CLogger.getCLogger(MSalesPipelineStage.class);
	private static ImmutablePOCache<String, MSalesPipelineStage> s_cache = new ImmutablePOCache<String, MSalesPipelineStage>(Table_Name, 50);

	public MSalesPipelineStage (Properties ctx, int C_SalesPipelineStage_ID, String trxName) {
		super (ctx, C_SalesPipelineStage_ID, trxName);
	}	//	MSalesPipelineStage

	public MSalesPipelineStage (Properties ctx, ResultSet rs, String trxName) {
		super (ctx, rs, trxName);
	}	//	MSalesPipelineStage

	public static MSalesPipelineStage get (Properties ctx, int salesPipelineID, int salesStageID, String trxName) {

		String key = new StringBuilder().append(salesPipelineID).append("_").append(salesStageID).toString();

		MSalesPipelineStage retValue = null;
		if (s_cache.containsKey(key) ) {
			retValue = s_cache.get(ctx, key, e -> new MSalesPipelineStage(ctx, e));
			return retValue;
		}

		Query query = new Query(ctx, Table_Name, "C_SalesPipeline_ID = ? AND C_SalesStage_ID = ?", trxName)
				.setOnlyActiveRecords(true);
		retValue = query.setParameters(salesPipelineID, salesStageID).first();

		if (retValue == null) {
			s_cache.put (key, null);
			s_log.log(Level.SEVERE, "MSalesPipelineStage_get NOT FOUND : " + salesPipelineID + " / " + salesStageID);
		} else {
			final MSalesPipelineStage sps = retValue;
			s_cache.put (key, retValue, e -> new MSalesPipelineStage(ctx, sps));
		}

		return retValue;
	}

	@Override
	public MSalesPipelineStage markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	public MSalesPipelineStage(Properties ctx, MSalesPipelineStage copy) {
		this(ctx, copy, (String) null);
	}

	public MSalesPipelineStage(Properties ctx, MSalesPipelineStage copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}

}	//	MSalesPipelineStage
