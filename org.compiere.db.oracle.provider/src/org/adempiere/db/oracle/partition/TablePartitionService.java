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
package org.adempiere.db.oracle.partition;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.adempiere.exceptions.DBException;
import org.compiere.db.partition.ITablePartitionService;
import org.compiere.db.partition.RangePartitionColumn;
import org.compiere.db.partition.RangePartitionInterval;
import org.compiere.db.partition.RangePartitionIntervalCombination;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_TablePartition;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.TimeUtil;
import org.compiere.util.Util;

public class TablePartitionService implements ITablePartitionService {

	public TablePartitionService() {
	}

	@Override
	public boolean isPartitionedTable(MTable table, String trxName) {
		String sql =
			"""
				SELECT 1 FROM USER_TAB_PARTITIONS
				WHERE TABLE_NAME = ?
			""";
		return DB.getSQLValueEx(trxName, sql, table.getTableName().toUpperCase()) == 1;
	}

	@Override
	public boolean createPartitionedTable(MTable table, String trxName, ProcessInfo processInfo) {
		StringBuilder alterStmt = new StringBuilder("ALTER TABLE ")
				.append(table.getTableName())
				.append(" MODIFY PARTITION BY ");
		String partitioningMethod = table.getPartitioningMethod();
		if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List))
			alterStmt.append("List");
		else if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_Range))
			alterStmt.append("Range");
		else
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{partitioningMethod}));
		
		String partitionKeyColumnsString = table.getPartitionKeyColumnNamesAsString();
		if (!Util.isEmpty(partitionKeyColumnsString))
			alterStmt.append(" (" + partitionKeyColumnsString + ")");
		
		alterStmt.append(" (PARTITION default_partition ");
		StringBuilder defaultExpression = new StringBuilder();
		List<String> keyColumnNames = table.getPartitionKeyColumnNames();
		if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List)) {
			defaultExpression.append("VALUES (");
			for(int i = 0; i< keyColumnNames.size(); i++) {
				if (i > 0)
					defaultExpression.append(", ");
				defaultExpression.append("DEFAULT");
			}
			defaultExpression.append(")");
		} else {
			defaultExpression.append("VALUES LESS THAN (");
			for(int i = 0; i< keyColumnNames.size(); i++) {
				if (i > 0)
					defaultExpression.append(", ");
				defaultExpression.append("MAXVALUE");
			}
			defaultExpression.append(")");
		}
		alterStmt.append(defaultExpression.toString());
		alterStmt.append(" ) ");
		
		int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
		if (processInfo != null)
			processInfo.addLog(0, null, null, no + " " + alterStmt.toString());
		
		table.createTablePartition("default_partition", defaultExpression.toString(), trxName);
		
		return true;
	}

	@Override
	public boolean addPartitionAndMigrateData(MTable table, String trxName, ProcessInfo processInfo) {
		boolean isUpdated = false;
		
		String partitioningMethod = table.getPartitioningMethod();		
		if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List))
		{
			isUpdated = addListPartition(table, trxName, processInfo);
		}
		else if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_Range))
		{
			isUpdated = addRangePartition(table, trxName, processInfo);
		}
		else
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{partitioningMethod}));
		
		return isUpdated;
	}

	/**
	 * Add new list partition
	 * @param table
	 * @param trxName
	 * @param pi
	 * @return true if new list partition added
	 */
	private boolean addListPartition(MTable table, String trxName, ProcessInfo pi) {
		boolean isUpdated = false;
		List<X_AD_TablePartition> partitions = new ArrayList<X_AD_TablePartition>();
		List<String> partitionKeyColumnNames = table.getPartitionKeyColumnNames();
		String partitionKeyColumnsString = table.getPartitionKeyColumnNamesAsString();
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT DISTINCT ").append(partitionKeyColumnsString);
		sql.append(" FROM ").append(table.getTableName()).append(" PARTITION (default_partition) ");
		sql.append("ORDER BY ").append(partitionKeyColumnsString);

		try (PreparedStatement pstmt = DB.prepareStatement(sql.toString(), trxName))
		{				
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				StringBuilder name = new StringBuilder();
				StringBuilder expression = new StringBuilder("VALUES (");
				for (String partitionKeyColumnName : partitionKeyColumnNames)
				{
					MColumn column = table.getColumn(partitionKeyColumnName);
					String s = rs.getString(partitionKeyColumnName);
					if (name.length() > 0)
					{
						name.append("_");
						expression.append(", ");
					}
					name.append(s);
					if (DisplayType.isText(column.getAD_Reference_ID()))
						expression.append(DB.TO_STRING(s));
					else if (column.getAD_Reference_ID() == DisplayType.Date)
						expression.append(DB.TO_DATE(rs.getTimestamp(partitionKeyColumnName)));
					else if (DisplayType.isDate(column.getAD_Reference_ID()))
						expression.append(DB.TO_DATE(rs.getTimestamp(partitionKeyColumnName), false));
					else if (DisplayType.isID(column.getAD_Reference_ID()) || DisplayType.Integer == column.getAD_Reference_ID())
						expression.append(rs.getInt(partitionKeyColumnName));
					else if (DisplayType.isNumeric(column.getAD_Reference_ID()))
						expression.append(rs.getBigDecimal(partitionKeyColumnName).toPlainString());
						
				}
				expression.append(")");
				if (Character.isDigit(name.charAt(0))) {
					name.insert(0, "p");
				}
				partitions.add(table.createTablePartition(name.toString(), expression.toString(), trxName));
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		
		if (!partitions.isEmpty())
		{
			for (X_AD_TablePartition partition : partitions)
			{
				StringBuilder alterStmt = new StringBuilder();
				alterStmt.append("ALTER TABLE " + table.getTableName() + " SPLIT PARTITION default_partition ");
				alterStmt.append(partition.getExpressionPartition());
				alterStmt.append(" INTO ( PARTITION ").append(partition.getName()).append(", ");
				alterStmt.append("PARTITION default_partition )");
				int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, no + " " + alterStmt.toString());
				
				isUpdated = true;
			}
		}
		return isUpdated;
	}
	
	/**
	 * Add new range partition
	 * @param table
	 * @param trxName
	 * @param pi
	 * @return true if new range partition added
	 */
	private boolean addRangePartition(MTable table, String trxName, ProcessInfo pi) {
		boolean isUpdated = false;
		List<X_AD_TablePartition> partitions = new ArrayList<X_AD_TablePartition>();
		List<RangePartitionColumn> rangePartitionColumns = new ArrayList<RangePartitionColumn>();
		List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns();

		for (int x = 0; x < partitionKeyColumns.size(); x++)
		{
			MColumn partitionKeyColumn = partitionKeyColumns.get(x);
			String partitionKeyColumnName = partitionKeyColumn.getColumnName();
			String partitionKeyColumnRangeIntervalPattern = partitionKeyColumn.getRangePartitionInterval();
			
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT MIN(").append(partitionKeyColumnName).append(") AS min_value, ");
			sql.append("MAX(").append(partitionKeyColumnName).append(") AS max_value ");
			sql.append("FROM ").append(table.getTableName()).append(" PARTITION (default_partition) ");
			
			List<Object> values = DB.getSQLValueObjectsEx(trxName, sql.toString());
			if (values.get(0) != null && values.get(1) != null)
			{
				rangePartitionColumns.add(new RangePartitionColumn(
						partitionKeyColumnName, partitionKeyColumnRangeIntervalPattern, 
						values.get(0), values.get(1)
				));
			}
		}
		
		if (rangePartitionColumns.isEmpty())
			return false;
		
		List<List<RangePartitionInterval>> columnRangePartitionIntervals = RangePartitionInterval.createIntervals(table, rangePartitionColumns, trxName);
		List<String> tablePartitionNames = table.getTablePartitionNames(trxName);
		RangePartitionIntervalCombination combination = RangePartitionIntervalCombination.generateCombinations(columnRangePartitionIntervals, 0);
		for (int x = 0; x < combination.getNameCombinations().size(); x++) {
			List<String> columnCombination = combination.getColumnNameCombinations().get(x);
			List<String> nameCombination = combination.getNameCombinations().get(x);
			List<Object> toCombination = combination.getToCombinations().get(x);
			
			StringBuilder name = new StringBuilder();
			for (int y = 0; y < nameCombination.size(); y++) {
				if (y > 0)
					name.append("_");
				name.append(nameCombination.get(y));
			}
			
			StringBuilder expression = new StringBuilder();
			expression.append("VALUES LESS THAN (");
			for (int y = 0; y < toCombination.size(); y++) {
				if (y > 0)
					expression.append(",");
				Object toValue = toCombination.get(y);
				if (toValue instanceof String strValue)
					expression.append(DB.TO_STRING(strValue));
				else if (toValue instanceof Timestamp tsValue) {
					tsValue = TimeUtil.addDays(tsValue, 1);
					expression.append(DB.TO_DATE(tsValue, false));
				} else if (toValue instanceof Number numberValue) {
					MColumn column = table.getColumn(columnCombination.get(y));
					if (DisplayType.isID(column.getAD_Reference_ID()) || DisplayType.Integer == column.getAD_Reference_ID())
						expression.append(numberValue.intValue()+1);
					else if (toValue instanceof BigDecimal bdValue)
						expression.append(bdValue.add(new BigDecimal("1")).toPlainString());
					else {
						BigDecimal bdValue = new BigDecimal(numberValue.toString());
						expression.append(bdValue.add(new BigDecimal("1")).toPlainString());
					}
				}
			}
			expression.append(")");
			
			if (Character.isDigit(name.charAt(0))) {
				name.insert(0, "p");
			}			
			if (!tablePartitionNames.contains(name.toString()))
				partitions.add(table.createTablePartition(name.toString(), expression.toString(), trxName));
			else
				partitions.add(null);
		}
		
		if (!partitions.isEmpty())
		{
			for (int i = 0; i < partitions.size(); i++)
			{
				X_AD_TablePartition partition = partitions.get(i);
				if (partition == null)
					continue;
				
				StringBuilder alterStmt = new StringBuilder();
				alterStmt.append("ALTER TABLE " + table.getTableName() + " SPLIT PARTITION default_partition ");
				alterStmt.append(partition.getExpressionPartition());
				alterStmt.append(" INTO ( PARTITION ").append(partition.getName()).append(", ");
				alterStmt.append("PARTITION default_partition )");
				int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, no + " " + alterStmt.toString());
				
				isUpdated = true;
			}
		}
		return isUpdated;
	}
	
	@Override
	public boolean runPostPartitionProcess(MTable table, String trxName, ProcessInfo processInfo) {
		return true;
	}

}
