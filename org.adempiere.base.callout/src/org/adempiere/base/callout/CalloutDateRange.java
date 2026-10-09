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
package org.adempiere.base.callout;

import java.util.Objects;
import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.adempiere.base.annotation.Callout;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.I_AD_DateRange;

/**
 * Callout of {@link I_AD_DateRange}, fired by {@link I_AD_DateRange#COLUMNNAME_RangeType}.
 * Range types "Previous Period" (P) and "Previous Period with Offset" (O) are always comparison ranges (C).
 * @author Peter Takacs, Cloudempiere
 */
@Callout(tableName = I_AD_DateRange.Table_Name, columnName = I_AD_DateRange.COLUMNNAME_RangeType)
public class CalloutDateRange implements IColumnCallout {

	@Override
	public String start(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
		String rangeType = Objects.toString(value, "");
		if ("P".equals(rangeType) || "O".equals(rangeType))
			mTab.setValue(I_AD_DateRange.COLUMNNAME_RangeComparisonType, "C");
		return null;
	}
}
