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
 * - Peter Takacs, Cloudempiere                                       *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;

/**
 * Model class of AD_DateRangeGroup, a group of date ranges.
 * @author Peter Takacs, Cloudempiere
 */
public class MDateRangeGroup extends X_AD_DateRangeGroup {

	private static final long serialVersionUID = -193148209034818251L;

	/**
	 * @param ctx
	 * @param AD_DateRangeGroup_ID
	 * @param trxName
	 */
	public MDateRangeGroup(Properties ctx, int AD_DateRangeGroup_ID, String trxName) {
		super(ctx, AD_DateRangeGroup_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param AD_DateRangeGroup_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MDateRangeGroup(Properties ctx, int AD_DateRangeGroup_ID, String trxName, String... virtualColumns) {
		super(ctx, AD_DateRangeGroup_ID, trxName, virtualColumns);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MDateRangeGroup(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * Get active Date Range Groups of Client
	 * @param ctx
	 * @param trxName
	 * @return
	 */
	public static MDateRangeGroup[] getOfClient(Properties ctx, String trxName) {
		List<MDateRangeGroup> list = new Query(ctx, I_AD_DateRangeGroup.Table_Name, "AD_Client_ID IN (?,0)", trxName)
				.setParameters(Env.getAD_Client_ID(ctx))
				.setOnlyActiveRecords(true)
				.list();
		return list.toArray(new MDateRangeGroup[list.size()]);
	}

	/**
	 * Get active Date Ranges of Date Range Group
	 * @param comparisonType
	 * @return
	 */
	public MDateRange[] getDateRanges(String comparisonType) {
		List<MDateRange> list = new Query(getCtx(), I_AD_DateRange.Table_Name, "AD_DateRangeGroup_ID=? AND RangeComparisonType IN (?,'"+MDateRange.RANGECOMPARISONTYPE_StandardAndComparisonRange+"') AND AD_Client_ID IN (?,0)", get_TrxName())
				.setParameters(getAD_DateRangeGroup_ID(), comparisonType, Env.getAD_Client_ID(getCtx()))
				.setOnlyActiveRecords(true)
				.setOrderBy(MDateRange.COLUMNNAME_SeqNo)
				.list();
		return list.toArray(new MDateRange[list.size()]);
	}

}
