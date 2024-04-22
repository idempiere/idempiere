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
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/
package org.compiere.db.partition;

import java.util.ArrayList;
import java.util.Objects;
import java.util.Properties;

import org.compiere.model.MTablePartition;
import org.compiere.util.Util;

public class TablePartitionUtils {
	
	/**
	 * Parse table partition name
	 * @param tableName
	 * @param partitionCols
	 * @return table partition name
	 */
	public static String parsePartitionName(String tableName, Object[] partitionCols) {
		StringBuilder partitionName = new StringBuilder();
		if(Util.isEmpty(tableName))
			return "";
		
		partitionName.append(tableName);
		for(Object partitionCol : partitionCols) {
			String sPartitionCol = Objects.toString(partitionCol);
			if(!Util.isEmpty(sPartitionCol)) {
				partitionName.append("_").append(sPartitionCol);
			}
		}
		
		return partitionName.toString();
	}
	
	/**
	 * Get Partition Name of the table of the given level
	 * @param tableName
	 * @param primaryLevelOnly - if true, ignore the sub-partition, if exists
	 * @return table partition name, or empty
	 */
	public static String getPartitionName(Properties ctx, String tableName, boolean primaryLevelOnly, String trxName) {
		String[] partitionColsAll = MTablePartition.getPartitionKeyColumns(ctx, tableName, trxName);
		int level = primaryLevelOnly ? 1 : partitionColsAll.length;			
		ArrayList<Object> partitionCols = new ArrayList<>();
		for(int i = 0; i < level; i++) {
			partitionCols.add(partitionColsAll[i]);
		}
		return parsePartitionName(tableName, partitionCols.toArray());
	}
}
