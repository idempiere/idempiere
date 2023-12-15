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
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.logging.Level;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.adempiere.exceptions.DBException;
import org.compiere.db.partition.ITablePartitionService;
import org.compiere.db.partition.RangePartitionColumn;
import org.compiere.db.partition.RangePartitionInterval;
import org.compiere.db.partition.RangePartitionIntervalCombination;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.model.X_AD_TablePartition;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

public class TablePartitionService implements ITablePartitionService {
	//make the following 2 potentially configurable in future (just in case this is needed)
	private boolean useAutomaticListPartition = true;
	private boolean useIntervalPartition = true;
	
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
		
		List<String> keyColumnNames = table.getPartitionKeyColumnNames();
		String partitionKeyColumnsString = table.getPartitionKeyColumnNamesAsString();
		if (!Util.isEmpty(partitionKeyColumnsString))
			alterStmt.append(" (" + partitionKeyColumnsString + ")");
		
		if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List) && useAutomaticListPartition) {
			//with automatic, we still need to create at least one partition and we will create a null partition to fulfill the requirement 
			alterStmt.append(" AUTOMATIC (PARTITION ");
		} else if (keyColumnNames.size() == 1 && useIntervalPartition) {
			MColumn partitionKeyColumn = table.getPartitionKeyColumns(false).get(0);
			alterStmt.append(" INTERVAL(");
			alterStmt.append(getIntervalExpression(partitionKeyColumn));
			alterStmt.append(") (PARTITION ");
		} else {
			alterStmt.append(" (PARTITION default_partition ");
		}
		StringBuilder defaultExpression = new StringBuilder();		
		if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List)) {
			defaultExpression.append("VALUES (");
			for(int i = 0; i< keyColumnNames.size(); i++) {
				if (i > 0)
					defaultExpression.append(", ");
				if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List) && useAutomaticListPartition) 
					defaultExpression.append("NULL");
				else
					defaultExpression.append("DEFAULT");
			}
			defaultExpression.append(")");
		} else {
			if (keyColumnNames.size() == 1 && useIntervalPartition) {
				if (alterStmt.indexOf("NUMTOYMINTERVAL(") > 0)
					defaultExpression.append("VALUES LESS THAN (TO_DATE('1970-01-01','YYYY-MM-DD')");
				else
					defaultExpression.append("VALUES LESS THAN (").append("0");
			} else {
				defaultExpression.append("VALUES LESS THAN (");
				for(int i = 0; i< keyColumnNames.size(); i++) {
					if (i > 0)
						defaultExpression.append(", ");
					defaultExpression.append("MAXVALUE");
				}
			}
			defaultExpression.append(")");
		}
		alterStmt.append(defaultExpression.toString());
		alterStmt.append(" ) ");
		
		int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
		if (processInfo != null)
			processInfo.addLog(0, null, null, no + " " + alterStmt.toString());
		
		if (!(partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List) && useAutomaticListPartition))
			table.createTablePartition("default_partition", defaultExpression.toString(), trxName);
		
		return true;
	}

	private String getIntervalExpression(MColumn partitionKeyColumn) {
		if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID())) {
			RangePartitionInterval.Interval interval = RangePartitionInterval.getInterval(partitionKeyColumn);
			if (interval.years() > 0) {
				if (interval.months() == 0) {
					return "NUMTOYMINTERVAL("+interval.years()+",'YEAR')";
				} else {
					int months = interval.months() + (interval.years() * 12);
					return "NUMTOYMINTERVAL("+months+",'MONTH')";
				}
			} else {
				return "NUMTOYMINTERVAL("+interval.months()+",'MONTH')";
			}
		} else if (DisplayType.isNumeric(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isID(partitionKeyColumn.getAD_Reference_ID())) {
			Pattern pattern = Pattern.compile("^[1-9]\\d*$");
			Matcher matcher = pattern.matcher(partitionKeyColumn.getRangePartitionInterval());
			if (!matcher.matches())
				throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "InvalidRangePartitionInterval") + " [" + partitionKeyColumn + "]");
			
			BigDecimal interval = new BigDecimal(partitionKeyColumn.getRangePartitionInterval());
			return interval.toPlainString();
		} else {
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "RangePartitionKeyTypeNotSupported") + " [" + partitionKeyColumn + "]");
		}
	}
	
	@Override
	public boolean addPartitionAndMigrateData(MTable table, String trxName, ProcessInfo processInfo) {
		boolean isUpdated = false;
		
		String partitioningMethod = table.getPartitioningMethod();		
		if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List))
		{
			if (isAutoList(table, trxName))
			{
				syncAutoList(table, trxName, processInfo);
				syncPartition(table, trxName, processInfo, false);
			}
			else
			{
				isUpdated = addListPartition(table, trxName, processInfo);
			}
		}
		else if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_Range))
		{
			String interval = getInterval(table, trxName);
			if (!Util.isEmpty(interval, true))
			{
				syncInterval(table, trxName, interval, processInfo);
				syncPartition(table, trxName, processInfo, true);
			}
			else
			{
				syncRange(table, trxName, interval, processInfo);
				isUpdated = addRangePartition(table, trxName, processInfo);
			}
		}
		else
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{partitioningMethod}));
		
		return isUpdated;
	}

	/**
	 * Update automatic list partitioning of table if the DB column list is different from current AD_Column values 
	 * @param table
	 * @param trxName
	 * @param pi
	 */
	private void syncAutoList(MTable table, String trxName, ProcessInfo pi) {
		List<String> keyColumns = table.getPartitionKeyColumnNames();
		String sql = "SELECT Column_Name FROM User_Part_Key_Columns WHERE Name=? ORDER BY Column_Position";
		List<List<Object>> columnNames = DB.getSQLArrayObjectsEx(trxName, sql, table.getTableName().toUpperCase());
		boolean notSync = false;
		if (keyColumns.size() != columnNames.size()) {
			notSync = true;
		} else {
			for(int i = 0; i < keyColumns.size(); i++) {
				if (!keyColumns.get(i).equalsIgnoreCase(columnNames.get(i).get(0).toString())) {
					notSync = true;
					break;
				}
			}
		}
		if (notSync) {
			StringBuilder alterStmt = new StringBuilder("ALTER TABLE ")
					.append(table.getTableName())
					.append(" MODIFY PARTITION BY List ");
			String partitionKeyColumnsString = table.getPartitionKeyColumnNamesAsString();
			alterStmt.append(" (" + partitionKeyColumnsString + ")");
			alterStmt.append(" AUTOMATIC (PARTITION VALUES (");
			for(int i = 0; i< keyColumns.size(); i++) {
				if (i > 0)
					alterStmt.append(", ");
				alterStmt.append("NULL");
			}
			alterStmt.append("))");
			int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
			if (pi != null)
				pi.addLog(0, null, null, no + " " + alterStmt.toString());
		}
	}

	/**
	 * Update partition interval of table if it is not in sync with current AD_Column.RangePartitionInterval value
	 * @param table
	 * @param trxName
	 * @param interval
	 * @param pi
	 */
	private void syncInterval(MTable table, String trxName, String interval, ProcessInfo pi) {
		MColumn partitionKeyColumn = table.getPartitionKeyColumns(false).get(0);
		String expression = getIntervalExpression(partitionKeyColumn);
		if (!interval.toUpperCase().equals(expression)) 
		{
			//note that this only effect new data inserted into table and will not change existing partition
			String sql = "ALTER TABLE " + table.getTableName() + " SET INTERVAL (" + expression + ")";
			int no = DB.executeUpdateEx(sql, trxName);
			if (pi != null)
				pi.addLog(0, null, null, no + " " + sql);
		}
	}

	/**
	 * Update partition range of table if it is not in sync with current AD_Column.RangePartitionInterval value
	 * @param table
	 * @param trxName
	 * @param interval
	 * @param pi
	 */
	private void syncRange(MTable table, String trxName, String interval, ProcessInfo pi) {
		List<String> keyColumns = table.getPartitionKeyColumnNames();
		String sql = "SELECT Column_Name FROM User_Part_Key_Columns WHERE Name=? ORDER BY Column_Position";
		List<List<Object>> columnNames = DB.getSQLArrayObjectsEx(trxName, sql, table.getTableName().toUpperCase());
		boolean notSync = false;
		if (keyColumns.size() != columnNames.size()) {
			notSync = true;
		} else {
			for(int i = 0; i < keyColumns.size(); i++) {
				if (!keyColumns.get(i).equalsIgnoreCase(columnNames.get(i).get(0).toString())) {
					notSync = true;
					break;
				}
			}
		}
		if (notSync) {
			StringBuilder alterStmt = new StringBuilder("ALTER TABLE ")
					.append(table.getTableName())
					.append(" MODIFY PARTITION BY Range ");
			String partitionKeyColumnsString = table.getPartitionKeyColumnNamesAsString();
			alterStmt.append(" (" + partitionKeyColumnsString + ")");
			alterStmt.append(" (PARTITION default_partition VALUES LESS THAN (");
			for(int i = 0; i< keyColumns.size(); i++) {
				if (i > 0)
					alterStmt.append(", ");
				alterStmt.append("MAXVALUE");
			}
			alterStmt.append("))");
			int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
			if (pi != null)
				pi.addLog(0, null, null, no + " " + alterStmt.toString());
		}
	}
	
	/**
	 * Read list or interval partition details from DB and update X_AD_TablePartition
	 * @param table
	 * @param trxName
	 * @param processInfo
	 * @param interval
	 */
	private void syncPartition(MTable table, String trxName, ProcessInfo processInfo, boolean interval) {
		String sql = 
			"""
				SELECT Partition_Name, High_Value
				FROM User_Tab_Partitions
				WHERE Table_Name=?
			""";
		Query query = new Query(Env.getCtx(), X_AD_TablePartition.Table_Name, "AD_Table_ID=?", trxName);
		List<X_AD_TablePartition> existingList = query.setParameters(table.getAD_Table_ID()).list();
		List<Integer> matchedIds = new ArrayList<Integer>();
		try(PreparedStatement stmt = DB.prepareStatement(sql, trxName)) {
			stmt.setString(1, table.getTableName().toUpperCase());
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				String partitionName = rs.getString(1);
				String values = rs.getString(2);
				int id = DB.getSQLValueEx(trxName, "SELECT AD_TablePartition_ID FROM AD_TablePartition WHERE AD_Table_ID=? AND Name=?", table.getAD_Table_ID(), partitionName);
				if (id > 0) {
					matchedIds.add(id);
				} else {
					String expression = interval ? "VALUES LESS THAN " + values  : "VALUES " + values;
					table.createTablePartition(partitionName, expression, trxName);
				}
			}
		} catch (SQLException e) {
			throw new DBException(e);
		}
		
		//remove X_AD_TablePartition that doesn't exists in DB
		if (existingList.size() > 0) {
			for (X_AD_TablePartition tablePartition : existingList) {
				if (!matchedIds.contains(tablePartition.getAD_TablePartition_ID()))
					tablePartition.deleteEx(true);
			}
		}
	}

	/**
	 * @param table
	 * @param trxName 
	 * @return true if table is using automatic list partitioning
	 */
	private boolean isAutoList(MTable table, String trxName) {
		String sql =
			"""
				SELECT AutoList
				FROM User_Part_Tables
				WHERE Table_Name = ?
			""";
		String autoList = DB.getSQLValueStringEx(trxName, sql, table.getTableName().toUpperCase());
		return "YES".equals(autoList);
	}

	/**
	 * @param table
	 * @param trxName 
	 * @return interval for partitioning
	 */
	private String getInterval(MTable table, String trxName) {
		String sql =
			"""
				SELECT Interval
				FROM User_Part_Tables
				WHERE Table_Name = ?
			""";
		String interval = DB.getSQLValueStringEx(trxName, sql, table.getTableName().toUpperCase());
		return interval;
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
		List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(false);

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
				MColumn column = table.getColumn(columnCombination.get(y));
				if (y > 0)
					expression.append(",");
				Object toValue = toCombination.get(y);
				if (DisplayType.isDate(column.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(column.getAD_Reference_ID())) {
					expression.append("TO_Date(").append(toValue.toString()).append(",'YYYY-MM-DD')");
				} else if (DisplayType.isNumeric(column.getAD_Reference_ID()) || DisplayType.isID(column.getAD_Reference_ID())) {
					BigDecimal bd = new BigDecimal(toValue.toString());
					if (DisplayType.isID(column.getAD_Reference_ID()) || DisplayType.Integer == column.getAD_Reference_ID())
						expression.append(bd.intValue());
					else
						expression.append(bd.toPlainString());
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
				alterStmt.append(" INTO ( PARTITION ").append(partition.getName()).append(" ").append(partition.getExpressionPartition()).append(", ");
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
		if (MTable.PARTITIONINGMETHOD_Range.equals(table.getPartitioningMethod()) && table.getPartitionKeyColumnNames().size() > 1) {
			String sql =
				"""
					SELECT Index_Name 
					FROM User_Indexes 
					WHERE Table_Name=?
				""";
			try (PreparedStatement stmt = DB.prepareStatement(sql, null)) {
				stmt.setString(1, table.getTableName().toUpperCase());
				ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
					String indexName = rs.getString(1);
					String alterStmt = "ALTER INDEX " + indexName + " REBUILD";
					DB.executeUpdateEx(alterStmt, null);
				}
			} catch (SQLException e) {
				CLogger.getCLogger(getClass()).log(Level.WARNING, e.getMessage(), e);
			}
		}
		return true;
	}

	@Override
	public String isValidConfiguration(MTable table) {
		String trxName = table.get_TrxName();
		if (!isPartitionedTable(table, trxName))
			return null;
		if (!table.isPartition())
			return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged") + " [" + MTable.COLUMNNAME_IsPartition + "]";
		return null;
	}

	@Override
	public String isValidConfiguration(MColumn column) {
		String trxName = column.get_TrxName();
		MTable table = MTable.get(Env.getCtx(), column.getAD_Table_ID(), trxName);
		if (column.isActive() && column.isPartitionKey() && table.getPartitioningMethod().equals(MTable.PARTITIONINGMETHOD_Range)) {
			List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(true);	// re-query the partition key columns
			if (column.isActive() && column.isPartitionKey()) {
				if (!partitionKeyColumns.contains(column))
					partitionKeyColumns.add(column);
				partitionKeyColumns.sort(new Comparator<MColumn>() {
					@Override
					public int compare(MColumn o1, MColumn o2) {
						Integer o1SeqNo = Integer.valueOf(o1.getSeqNoPartition());
						Integer o2SeqNo = Integer.valueOf(o2.getSeqNoPartition());
						return o1SeqNo.compareTo(o2SeqNo);
					}
				});
			} else {
				if (partitionKeyColumns.contains(column))
					partitionKeyColumns.remove(column);
			}
			if (partitionKeyColumns.size() > 1)
				return Msg.getMsg(Env.getCtx(), "OnlyOnePartitionKeyAllowed");
			
			String error = RangePartitionInterval.validateIntervalPattern(column);
			if (!Util.isEmpty(error))
				return error;
		}
		
		if (!isPartitionedTable(table, trxName))
			return null;
		return null;
	}

}
