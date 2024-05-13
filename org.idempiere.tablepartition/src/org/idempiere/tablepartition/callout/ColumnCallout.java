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
 **********************************************************************/
package org.idempiere.tablepartition.callout;

import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.adempiere.base.annotation.Callout;
import org.compiere.db.partition.RangePartitionInterval;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MColumn;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

@Callout(tableName = "AD_Column", columnName = {"IsPartitionKey", "RangePartitionInterval"})
public class ColumnCallout implements IColumnCallout {

	public ColumnCallout() {
	}

	@Override
	public String start(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
		if ("IsPartitionKey".equals(mField.getColumnName())) {
			if (Boolean.TRUE.equals(value)) {
				Object seqNo = mTab.getValue("SeqNoPartition");
				if (seqNo == null || ((Number)seqNo).intValue() == 0) {
					String sql = "SELECT COALESCE(MAX(SeqNoPartition),0)+10 AS DefaultValue FROM AD_Column WHERE AD_Table_ID=? AND IsActive='Y' AND IsPartitionKey='Y'";
					int ii = DB.getSQLValue(null, sql, mTab.getValue("AD_Table_ID"));
					mTab.setValue("SeqNoPartition", ii);
				}
			} else {
				Object seqNo = mTab.getValue("SeqNoPartition");
				if (seqNo != null)
					mTab.setValue("SeqNoPartition", null);
			}
		} else if ("RangePartitionInterval".equals(mField.getColumnName()) && value != null) {
			MColumn column = MColumn.getCopy(Env.getCtx(), mTab.getRecord_ID(), null);
			column.setRangePartitionInterval(value.toString());
			String error = RangePartitionInterval.validateIntervalPattern(column);
			if (!Util.isEmpty(error, true))
				return error;
		}
		return null;
	}

}
