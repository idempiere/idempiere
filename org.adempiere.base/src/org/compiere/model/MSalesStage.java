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

import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Sales Stage Model
 *  @author Nicolas Micoud
 *  @version $Id: MSalesStage.java
 */
public class MSalesStage extends X_C_SalesStage implements ImmutablePOSupport
{
	private static final long serialVersionUID = -5198670154115226808L;
	private static ImmutablePOCache<Integer, MSalesStage> s_cache = new ImmutablePOCache<Integer, MSalesStage>(Table_Name, 50);

	public MSalesStage (Properties ctx, int C_SalesStage_ID, String trxName) {
		super (ctx, C_SalesStage_ID, trxName);
	}	//	MSalesStage

	public MSalesStage (Properties ctx, ResultSet rs, String trxName) {
		super (ctx, rs, trxName);
	}	//	MSalesStage

	public static MSalesStage get (Properties ctx, int salesStageID) {

		MSalesStage retValue = s_cache.get (ctx, salesStageID, e -> new MSalesStage(ctx, e));
		if (retValue != null)
			return retValue;
		retValue = new MSalesStage (ctx, salesStageID, null);
		if (retValue.get_ID () == salesStageID) {
			s_cache.put (salesStageID, retValue, e -> new MSalesStage(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	@Override
	public MSalesStage markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	public MSalesStage(Properties ctx, MSalesStage copy) {
		this(ctx, copy, (String) null);
	}

	public MSalesStage(Properties ctx, MSalesStage copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}

}	//	MSalesStage
