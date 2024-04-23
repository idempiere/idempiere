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
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Properties;
import java.util.stream.Collectors;

import org.compiere.util.DB;

public class MTablePartition extends X_AD_TablePartition {

	/** Serial Version ID */
	private static final long serialVersionUID = 1L;

	/**
	 * @param ctx
	 * @param AD_TablePartition_ID
	 * @param trxName
	 */
	public MTablePartition(Properties ctx, int AD_TablePartition_ID, String trxName) {
		super(ctx, AD_TablePartition_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param AD_TablePartition_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MTablePartition(Properties ctx, int AD_TablePartition_ID, String trxName, String[] virtualColumns) {
		super(ctx, AD_TablePartition_ID, trxName, virtualColumns);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MTablePartition(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * UUID based Constructor
	 * @param ctx
	 * @param AD_TablePartition_UU
	 * @param trxName
	 */
	public MTablePartition(Properties ctx, String AD_TablePartition_UU, String trxName) {
		super(ctx, AD_TablePartition_UU, trxName);
	}

	/**
	 * UUID based Constructor
	 * @param ctx
	 * @param AD_TablePartition_UU
	 * @param trxName
	 * @param virtualColumns
	 */
	public MTablePartition(Properties ctx, String AD_TablePartition_UU, String trxName, String[] virtualColumns) {
		super(ctx, AD_TablePartition_UU, trxName, virtualColumns);
	}
	
	/**
	 * Check if the given table partition exists for the table
	 * @param tableName
	 * @param partitionName
	 * @return true if partition already exists
	 */
	public static boolean partitionExists(Properties ctx, String tableName, String partitionName, String trxName) {
		 return partitionExists(ctx, MTable.getTable_ID(tableName), partitionName, trxName);
	}
	
	/**
	 * Check if the given table partition exists for the table
	 * @param tableId
	 * @param partitionName
	 * @return true if partition already exists
	 */
	public static boolean partitionExists(Properties ctx, int tableId, String partitionName, String trxName) {
		boolean returnVal = false;
		StringBuilder sqlSelect = new StringBuilder();
		sqlSelect.append("SELECT 1 FROM ")
		    .append(X_AD_TablePartition.Table_Name)
		    .append(" WHERE AD_Table_ID = ? AND UPPER(Name) LIKE UPPER(?) ");
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
		    ps = DB.prepareStatement(sqlSelect.toString(), trxName);
		    ps.setInt(1,tableId);
		    ps.setString(2, partitionName);
		    rs = ps.executeQuery();
		    if (rs.next()) {
		        returnVal = true;
		    }
		} catch (SQLException e) {
		    e.printStackTrace();
		} finally {
		    DB.close(rs, ps);
		    rs = null; ps = null;
		}
		
		return returnVal;
	}
	
	/**
	 * Get list of partition key columns for the given table
	 * @param ctx
	 * @param tableName
	 * @param trxName
	 * @return array of column names 
	 */
	public static String[] getPartitionKeyColumns(Properties ctx, String tableName, String trxName) {
		return getPartitionKeyColumns(ctx, MTable.getTable_ID(tableName), trxName);
	}
	
	/**
	 * Get list of partition key columns for the given table
	 * @param ctx
	 * @param tableId
	 * @param trxName
	 * @return array of column names
	 */
	public static String[] getPartitionKeyColumns(Properties ctx, int tableId, String trxName) {
	    String whereClause = "AD_Table_ID=? AND IsPartitionKey='Y'";
	    List<MColumn> keyCols = new Query(ctx, MColumn.Table_Name, whereClause, trxName)
	    		.setParameters(tableId)
	    		.setOnlyActiveRecords(true)
	            .setOrderBy("SeqNoPartition ASC")
	            .list();

	    List<String> keyColNames = keyCols.stream()
	            .map(MColumn::getColumnName)
	            .collect(Collectors.toList());

	    return keyColNames.toArray(new String[0]);
	}
}
