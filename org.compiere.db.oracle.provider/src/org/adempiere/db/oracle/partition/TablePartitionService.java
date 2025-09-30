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
import java.util.List;
import java.util.logging.Level;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.db.partition.ITablePartitionService;
import org.compiere.db.partition.RangePartitionColumn;
import org.compiere.db.partition.RangePartitionInterval;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Column;
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
		List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(false);
		MColumn partitionKeyColumn = partitionKeyColumns.get(0);
		MColumn subPartitionColumn = null;
		if (partitionKeyColumns.size() > 1)
			subPartitionColumn = partitionKeyColumns.get(1);
		String partitioningMethod = partitionKeyColumn.getPartitioningMethod();
		if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_List))
			alterStmt.append("List");
		else if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_Range))
			alterStmt.append("Range");
		else
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{partitioningMethod}));
		
		alterStmt.append(" (").append(partitionKeyColumn.getColumnName()).append(")");
		
		if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_List) && useAutomaticListPartition) {
			//with automatic, we still need to create at least one partition and we will create a null partition to fulfill the requirement 
			alterStmt.append(" AUTOMATIC ");
		} else if (useIntervalPartition) {
			alterStmt.append(" INTERVAL(");
			alterStmt.append(getIntervalExpression(partitionKeyColumn));
			alterStmt.append(") ");			
		}
		//oracle will auto create default partition for sub-partition
		if (subPartitionColumn != null) {
			alterStmt.append("SUBPARTITION BY ");
			if (subPartitionColumn.getPartitioningMethod().equals(MColumn.PARTITIONINGMETHOD_List))
				alterStmt.append("List");
			else if (subPartitionColumn.getPartitioningMethod().equals(MColumn.PARTITIONINGMETHOD_Range))
				alterStmt.append("Range");
			else
				throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{subPartitionColumn.getPartitioningMethod()}));
			alterStmt.append(" (").append(subPartitionColumn.getColumnName()).append(")");
		}
		alterStmt.append(" (PARTITION default_partition ");
		StringBuilder defaultExpression = new StringBuilder();		
		if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_List)) {
			defaultExpression.append("VALUES (");
			if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_List) && useAutomaticListPartition) 
				defaultExpression.append("NULL");
			else
				defaultExpression.append("DEFAULT");
			defaultExpression.append(")");
		} else {
			if (useIntervalPartition) {
				if (alterStmt.indexOf("NUMTOYMINTERVAL(") > 0)
					defaultExpression.append("VALUES LESS THAN (TO_DATE('1970-01-01','YYYY-MM-DD')");
				else
					defaultExpression.append("VALUES LESS THAN (").append("0");
			} else {
				defaultExpression.append("VALUES LESS THAN (");
				defaultExpression.append("MAXVALUE");
			}
			defaultExpression.append(")");
		}
		alterStmt.append(defaultExpression.toString());
		alterStmt.append(" ) ");
		
		int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
		if (processInfo != null)
			processInfo.addLog(0, null, null, no + " " + alterStmt.toString());
		
		if (!(partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_List) && useAutomaticListPartition))
			table.createTablePartition("default_partition", defaultExpression.toString(), trxName, partitionKeyColumn);
		
		return true;
	}

	/**
	 * @param partitionKeyColumn
	 * @return Oracle year/month interval expression (using NUMTOYMINTERVAL) for column range interval 
	 */
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
		
		List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(false);
		if (partitionKeyColumns.size() == 0)
			return false;
		MColumn partitionKeyColumn = partitionKeyColumns.get(0);		
		String sql = "SELECT Column_Name FROM User_Part_Key_Columns WHERE Name=? ORDER BY Column_Position";
		String partKeyColumn = DB.getSQLValueString(trxName, sql, table.getTableName().toUpperCase());
		if (!partitionKeyColumn.getColumnName().equalsIgnoreCase(partKeyColumn))
			return false;
		MColumn subPartitionColumn = null;
		if (partitionKeyColumns.size() > 1)
			subPartitionColumn = partitionKeyColumns.get(1);
		String partitioningMethod = partitionKeyColumn.getPartitioningMethod();		
		if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_List))
		{
			if (isAutoList(table, trxName))
			{
				syncAutoList(table, partitionKeyColumn, trxName, processInfo);
				syncPartition(table, trxName, processInfo, false);
			}
			else
			{
				isUpdated = addListPartition(table, partitionKeyColumn, trxName, processInfo, "default_partition", null, null);
			}
		}
		else if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_Range))
		{
			if (!isRangePartitionedTable(table, trxName)) 
			{
				fromListToRange(table, trxName, processInfo, partitionKeyColumn);				
				syncPartition(table, trxName, processInfo, true);
			}
			else
			{
				String interval = getInterval(table, trxName);
				if (!Util.isEmpty(interval, true))
				{
					syncInterval(table, partitionKeyColumn, trxName, interval, processInfo);
					syncPartition(table, trxName, processInfo, true);
				}
				else
				{
					syncRange(table, partitionKeyColumn, trxName, interval, processInfo);
					isUpdated = addRangePartition(table, partitionKeyColumn, trxName, processInfo, "default_partition", null, null);
				}
			}
		}
		else
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{partitioningMethod}));
		
		if (subPartitionColumn != null) {
			List<X_AD_TablePartition> primaryPartitions = getPrimaryPartitions(table, partitionKeyColumn, trxName);
			if (subPartitionColumn.getPartitioningMethod().equals(MColumn.PARTITIONINGMETHOD_List))
			{
				for(X_AD_TablePartition primaryPartition : primaryPartitions)
				{
					String defaultSubPartition = getDefaultSubPartitionName(table, primaryPartition, false, trxName);
					if (defaultSubPartition == null)
						continue;
					isUpdated = addListPartition(table, subPartitionColumn, trxName, processInfo, defaultSubPartition, primaryPartition.getName(), primaryPartition);
				}
			}
			else if (subPartitionColumn.getPartitioningMethod().equals(MColumn.PARTITIONINGMETHOD_Range))
			{
				for(X_AD_TablePartition primaryPartition : primaryPartitions)
				{
					String defaultSubPartition = getDefaultSubPartitionName(table, primaryPartition, true, trxName);
					if (defaultSubPartition == null)
						continue;
					isUpdated = addRangePartition(table, subPartitionColumn, trxName, processInfo, defaultSubPartition, primaryPartition.getName(), primaryPartition);
				}
			}
			else
				throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{subPartitionColumn.getPartitioningMethod()}));
		}
		return isUpdated;
	}

	/**
	 * Find name of default sub-partition auto created by Oracle 
	 * @param table
	 * @param primaryPartition
	 * @param range true if sub-partition is range, false for list
	 * @param trxName
	 * @return name of default sub-partition
	 */
	private String getDefaultSubPartitionName(MTable table, X_AD_TablePartition primaryPartition, boolean range, String trxName) {
		String sql = 
				"""
					SELECT High_Value, SubPartition_Name
					FROM User_Tab_SubPartitions
					WHERE Table_Name=? AND Partition_Name=?
				""";
		try(PreparedStatement stmt = DB.prepareStatement(sql, trxName)) {
			stmt.setString(1, table.getTableName().toUpperCase());
			stmt.setString(2, primaryPartition.getName().toUpperCase());
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String expression = rs.getString(1);
				if (range) {
					if ("MAXVALUE".equals(expression))
						return rs.getString(2);	
				} else {
					if ("DEFAULT".equals(expression)) {
						return rs.getString(2);
					}
				}
			}
		} catch (SQLException e) {
			throw new DBException(e);
		}
		return null;
	}

	/**
	 * Find the list of partition for partitionKeyColumn
	 * @param table
	 * @param partitionKeyColumn
	 * @param trxName
	 * @return list of partition for column
	 */
	private List<X_AD_TablePartition> getPrimaryPartitions(MTable table, MColumn partitionKeyColumn, String trxName) {
		String whereClause = "AD_Table_ID=? AND AD_Column_ID=? And Name != 'DEFAULT_PARTITION' AND IsPartitionAttached='Y' AND IsActive='Y'";
		Query query = new Query(Env.getCtx(), MTable.get(Env.getCtx(), X_AD_TablePartition.Table_ID), whereClause, trxName);		
		return query.setParameters(table.getAD_Table_ID(), partitionKeyColumn.getAD_Column_ID()).list();
	}

	/**
	 * Change partition method from list to range
	 * @param table
	 * @param trxName
	 * @param processInfo
	 * @param partitionKeyColumn
	 */
	private void fromListToRange(MTable table, String trxName, ProcessInfo processInfo, MColumn partitionKeyColumn) {
		DB.executeUpdateEx("DELETE FROM AD_TablePartition WHERE AD_Table_ID=? AND Name=?", new Object[] {table.getAD_Table_ID(), "DEFAULT_PARTITION"}, trxName);
		StringBuilder alterStmt = new StringBuilder("ALTER TABLE ")
				.append(table.getTableName())
				.append(" MODIFY PARTITION BY RANGE ")
				.append(" (").append(partitionKeyColumn.getColumnName()).append(")");
		if (useIntervalPartition) {
			alterStmt.append(" INTERVAL(");
			alterStmt.append(getIntervalExpression(partitionKeyColumn));
			alterStmt.append(") (PARTITION default_partition ");
		} else {
			alterStmt.append(" (PARTITION default_partition ");
		}
		StringBuilder defaultExpression = new StringBuilder();		
		if (useIntervalPartition) {
			if (alterStmt.indexOf("NUMTOYMINTERVAL(") > 0)
				defaultExpression.append("VALUES LESS THAN (TO_DATE('1970-01-01','YYYY-MM-DD')");
			else
				defaultExpression.append("VALUES LESS THAN (").append("0");
		} else {
			defaultExpression.append("VALUES LESS THAN (");
			defaultExpression.append("MAXVALUE");
		}
		defaultExpression.append(")");				
		alterStmt.append(defaultExpression.toString());
		alterStmt.append(" ) ");
		
		int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
		if (processInfo != null)
			processInfo.addLog(0, null, null, no + " " + alterStmt.toString());
	}

	/**
	 * Update automatic list partitioning of table if the DB column list is different from current AD_Column values 
	 * @param table
	 * @param partitionKeyColumn 
	 * @param trxName
	 * @param pi
	 */
	private void syncAutoList(MTable table, MColumn partitionKeyColumn, String trxName, ProcessInfo pi) {
		String keyColumn = partitionKeyColumn.getColumnName();
		String sql = "SELECT Column_Name FROM User_Part_Key_Columns WHERE Name=? ORDER BY Column_Position";
		List<List<Object>> columnNames = DB.getSQLArrayObjectsEx(trxName, sql, table.getTableName().toUpperCase());
		boolean notSync = false;
		if (columnNames.size() != 1) {
			notSync = true;
		} else {
			if (!keyColumn.equalsIgnoreCase(columnNames.get(0).get(0).toString()))
				notSync = true;
		}
		if (notSync) {
			StringBuilder alterStmt = new StringBuilder("ALTER TABLE ")
					.append(table.getTableName())
					.append(" MODIFY PARTITION BY List ");
			alterStmt.append(" (").append(keyColumn).append(")");
			alterStmt.append(" AUTOMATIC (PARTITION default_partition VALUES (");
			alterStmt.append("NULL");
			alterStmt.append("))");
			int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
			if (pi != null)
				pi.addLog(0, null, null, no + " " + alterStmt.toString());
		}
	}

	/**
	 * Update partition interval of table if it is not in sync with current AD_Column.RangePartitionInterval value
	 * @param table
	 * @param partitionKeyColumn
	 * @param trxName
	 * @param interval
	 * @param pi
	 */
	private void syncInterval(MTable table, MColumn partitionKeyColumn, String trxName, String interval, ProcessInfo pi) {
		String sql = "SELECT Column_Name FROM User_Part_Key_Columns WHERE Name=? ORDER BY Column_Position";
		String intervalColumn = DB.getSQLValueString(trxName, sql, table.getTableName().toUpperCase());
		String expression = getIntervalExpression(partitionKeyColumn);
		if (partitionKeyColumn.getColumnName().toUpperCase().equals(intervalColumn)) {
			if (!interval.toUpperCase().equals(expression)) {
				//note that this only effect new data inserted into table and will not change existing partition
				sql = "ALTER TABLE " + table.getTableName() + " SET INTERVAL (" + expression + ")";
				int no = DB.executeUpdateEx(sql, trxName);
				if (pi != null)
					pi.addLog(0, null, null, no + " " + sql);
			}
		} else {
			throw new AdempiereException("PartitionConfigurationChanged");
		}
	}

	/**
	 * Update partition range of table if it is not in sync with current AD_Column.RangePartitionInterval value
	 * @param table
	 * @param partitionKeyColumn 
	 * @param trxName
	 * @param interval
	 * @param pi
	 */
	private void syncRange(MTable table, MColumn partitionKeyColumn, String trxName, String interval, ProcessInfo pi) {
		String sql = "SELECT Column_Name FROM User_Part_Key_Columns WHERE Name=? ORDER BY Column_Position";
		List<List<Object>> columnNames = DB.getSQLArrayObjectsEx(trxName, sql, table.getTableName().toUpperCase());
		boolean notSync = false;
		if (columnNames.size() != 1) {
			notSync = true;
		} else {
			if (!partitionKeyColumn.getColumnName().equalsIgnoreCase(columnNames.get(0).get(0).toString())) 
				notSync = true;
		}
		if (notSync) {
			StringBuilder alterStmt = new StringBuilder("ALTER TABLE ")
					.append(table.getTableName())
					.append(" MODIFY PARTITION BY Range ");
			alterStmt.append(" (").append(partitionKeyColumn.getColumnName()).append(")");
			alterStmt.append(" (PARTITION default_partition VALUES LESS THAN (");
			alterStmt.append("MAXVALUE");
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
		Query query = new Query(Env.getCtx(), X_AD_TablePartition.Table_Name, "AD_Table_ID=? AND Parent_TablePartition_ID IS NULL", trxName);
		List<X_AD_TablePartition> existingList = query.setParameters(table.getAD_Table_ID()).list();
		List<Integer> matchedIds = new ArrayList<Integer>();
		List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(false);
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
					table.createTablePartition(partitionName, expression, trxName, partitionKeyColumns.get(0));
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
	 * @param table
	 * @param trxName
	 * @return true if table is partition by range in DB
	 */
	private boolean isRangePartitionedTable(MTable table, String trxName) {
		String sql =
				"""
					SELECT Partitioning_Type
					FROM User_Part_Tables
					WHERE Table_Name = ?
				""";
		String type = DB.getSQLValueStringEx(trxName, sql, table.getTableName().toUpperCase());
		return "RANGE".equals(type);
	}
	/**
	 * Add new list partition
	 * @param table
	 * @param partitionKeyColumn 
	 * @param trxName
	 * @param pi
	 * @param fromPartition name of default partition to select from
	 * @param partitionNamePrefix
	 * @param parentPartition
	 * @return true if new list partition added
	 */
	private boolean addListPartition(MTable table, MColumn partitionKeyColumn, String trxName, ProcessInfo pi, String fromPartition, String partitionNamePrefix, X_AD_TablePartition parentPartition) {
		boolean isUpdated = false;
		List<X_AD_TablePartition> partitions = new ArrayList<>();
		boolean subPartition = parentPartition != null;
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT DISTINCT ").append(partitionKeyColumn.getColumnName());
		sql.append(" FROM ").append(table.getTableName()).append(" ").append(subPartition ? "SubPartition(" : "Partition(").append(fromPartition).append(") ");
		sql.append("ORDER BY ").append(partitionKeyColumn.getColumnName());

		try (PreparedStatement pstmt = DB.prepareStatement(sql.toString(), trxName))
		{				
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				StringBuilder name = new StringBuilder();
				StringBuilder expression = new StringBuilder("VALUES (");
				if (!Util.isEmpty(partitionNamePrefix, true))
					name.append(partitionNamePrefix).append("_");
				String s = rs.getString(partitionKeyColumn.getColumnName());
				name.append(s);
				if (DisplayType.isText(partitionKeyColumn.getAD_Reference_ID()) || partitionKeyColumn.getAD_Reference_ID() == DisplayType.YesNo
					|| DisplayType.isList(partitionKeyColumn.getAD_Reference_ID())
					|| "EntityType".equals(partitionKeyColumn.getColumnName())
					|| "AD_Language".equals(partitionKeyColumn.getColumnName()))
					expression.append(DB.TO_STRING(s));
				else if (partitionKeyColumn.getAD_Reference_ID() == DisplayType.Date)
					expression.append(DB.TO_DATE(rs.getTimestamp(partitionKeyColumn.getColumnName())));
				else if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()))
					expression.append(DB.TO_DATE(rs.getTimestamp(partitionKeyColumn.getColumnName()), false));
				else if (DisplayType.isID(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.Integer == partitionKeyColumn.getAD_Reference_ID())
					expression.append(rs.getInt(partitionKeyColumn.getColumnName()));
				else if (DisplayType.isNumeric(partitionKeyColumn.getAD_Reference_ID()))
					expression.append(rs.getBigDecimal(partitionKeyColumn.getColumnName()).toPlainString());
										
				expression.append(")");
				if (Character.isDigit(name.charAt(0))) {
					name.insert(0, "p");
				}
				X_AD_TablePartition partition = table.createTablePartition(name.toString(), expression.toString(), trxName, partitionKeyColumn, parentPartition);
				partitions.add(partition);
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		
		for(X_AD_TablePartition partition : partitions)
		{
			StringBuilder alterStmt = new StringBuilder();
			alterStmt.append("ALTER TABLE ").append(table.getTableName()).append(" SPLIT ").append(subPartition ? "SubPartition " : "Partition ").append(fromPartition).append(" ");
			alterStmt.append(partition.getExpressionPartition());
			alterStmt.append(" INTO ( ").append(subPartition ? "SUBPARTITION " : "PARTITION ").append(partition.getName()).append(", ");
			alterStmt.append(subPartition ? "SubPartition " : "Partition ").append(fromPartition).append(" )");
			int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
			if (pi != null)
				pi.addLog(0, null, null, no + " " + alterStmt.toString());
			
			isUpdated = true;
		}
		return isUpdated;
	}
	
	/**
	 * Add new range partition
	 * @param table
	 * @param partitionKeyColumn 
	 * @param trxName
	 * @param pi
	 * @param fromPartition name of default partition to select from
	 * @param partitionNamePrefix
	 * @param parentPartition
	 * @return true if new range partition added
	 */
	private boolean addRangePartition(MTable table, MColumn partitionKeyColumn, String trxName, ProcessInfo pi, String fromPartition, String partitionNamePrefix, X_AD_TablePartition parentPartition) {
		boolean isUpdated = false;
		X_AD_TablePartition partition = null;
		RangePartitionColumn rangePartitionColumn = null;
		boolean subPartition = parentPartition != null;

		String partitionKeyColumnName = partitionKeyColumn.getColumnName();
		String partitionKeyColumnRangeIntervalPattern = partitionKeyColumn.getRangePartitionInterval();
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT MIN(").append(partitionKeyColumnName).append(") AS min_value, ");
		sql.append("MAX(").append(partitionKeyColumnName).append(") AS max_value ");
		sql.append("FROM ").append(table.getTableName()).append(" ").append(subPartition ? "SubPartition(" : "Partition(").append(fromPartition).append(")");
		
		List<Object> values = DB.getSQLValueObjectsEx(trxName, sql.toString());
		if (values.get(0) != null && values.get(1) != null)
		{
			rangePartitionColumn = new RangePartitionColumn(
					partitionKeyColumnName, partitionKeyColumnRangeIntervalPattern, 
					values.get(0), values.get(1)
			);
		}
		
		if (rangePartitionColumn == null)
			return false;
		
		List<RangePartitionInterval> rangePartitionIntervals = RangePartitionInterval.createInterval(table, rangePartitionColumn, trxName);
		List<String> tablePartitionNames = table.getTablePartitionNames(trxName);
		
		for(RangePartitionInterval rangePartitionInterval : rangePartitionIntervals)
		{
			StringBuilder name = new StringBuilder();
			if (!Util.isEmpty(partitionNamePrefix, true))
				name.append(partitionNamePrefix).append("_");
			name.append(rangePartitionInterval.getName());
			
			StringBuilder countStmt = new StringBuilder("SELECT Count(*) FROM ")
					.append(table.getTableName()).append(" ").append(subPartition ? "SubPartition(" : "Partition(").append(fromPartition).append(") ")
					.append("WHERE ").append(" ")
					.append(partitionKeyColumn.getColumnName()).append(" >= ");
			if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
				countStmt.append("TO_DATE(").append(rangePartitionInterval.getFrom()).append(",'YYYY-MM-DD') ");
			else
				countStmt.append(rangePartitionInterval.getFrom()).append(" ");
			countStmt.append("AND ").append(partitionKeyColumn.getColumnName()).append(" < ");
			if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
				countStmt.append("TO_DATE(").append(rangePartitionInterval.getTo()).append(",'YYYY-MM-DD') ");
			else
				countStmt.append(rangePartitionInterval.getTo()).append(" ");
			int recordCount = DB.getSQLValueEx(trxName, countStmt.toString());
			
			if (recordCount == 0) {
				if (tablePartitionNames.contains(name.toString())) {
					Query query = new Query(Env.getCtx(), X_AD_TablePartition.Table_Name, "AD_Table_ID=? AND Name=?", trxName);
					X_AD_TablePartition toDelete = query.setParameters(table.getAD_Table_ID(), name.toString()).first();
					if (toDelete != null)
						toDelete.deleteEx(true);
				}
				continue;
			}
			
			StringBuilder expression = new StringBuilder();
			expression.append("VALUES LESS THAN (");
			Object toValue = rangePartitionInterval.getTo();
			if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID())) {
				expression.append("TO_Date(").append(toValue.toString()).append(",'YYYY-MM-DD')");
			} else if (DisplayType.isNumeric(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isID(partitionKeyColumn.getAD_Reference_ID())) {
				BigDecimal bd = new BigDecimal(toValue.toString());
				if (DisplayType.isID(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.Integer == partitionKeyColumn.getAD_Reference_ID())
					expression.append(bd.intValue());
				else
					expression.append(bd.toPlainString());
			}
			expression.append(")");
				
			if (Character.isDigit(name.charAt(0))) {
				name.insert(0, "p");
			}			
			if (!tablePartitionNames.contains(name.toString()))
				partition = table.createTablePartition(name.toString(), expression.toString(), trxName, partitionKeyColumn, parentPartition);
			
			if (partition != null)
			{				
				StringBuilder alterStmt = new StringBuilder();
				alterStmt.append("ALTER TABLE ").append(table.getTableName()).append(" SPLIT ").append(subPartition ? "SubPartition " : "Partition ").append(fromPartition);
				alterStmt.append(" INTO ( ").append(subPartition ? "SUBPARTITION " : "PARTITION ").append(partition.getName()).append(" ").append(partition.getExpressionPartition()).append(", ");
				alterStmt.append(subPartition ? "SubPartition " : "Partition ").append(fromPartition).append(" )");
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
		String sql =
			"""
				 select index_name, partition_name, 'partition' ddl_type
			     from user_ind_partitions
			     where (index_name) in 
			           ( select index_name
			             from   user_indexes
			             where table_name  = ?
			           )
			     and status = 'UNUSABLE'
			     union all
			     select index_name, subpartition_name, 'subpartition' ddl_type
			     from user_ind_subpartitions
			     where (index_name) in 
			           ( select index_name
			             from   user_indexes
			             where table_name  = ?
			           )
			     and status = 'UNUSABLE'
			     union all
			     select index_name, null, null
			     from user_indexes
			     where table_name  = ?
			     and status = 'UNUSABLE'
			""";
		
		try (PreparedStatement stmt = DB.prepareStatement(sql, trxName)) {
			stmt.setString(1, table.getTableName().toUpperCase());
			stmt.setString(2, table.getTableName().toUpperCase());
			stmt.setString(3, table.getTableName().toUpperCase());
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				StringBuilder alter = new StringBuilder("ALTER INDEX ")
						.append(rs.getString(1))
						.append(" REBUILD ");
				String ddlType = rs.getString(3);
				if (!Util.isEmpty(ddlType, true) ) {
					alter.append(ddlType).append(" ").append(rs.getString(2));
				}
				int no = DB.executeUpdateEx(alter.toString(), trxName);
				if (processInfo != null)
					processInfo.addLog(0, null, null, no + " " + alter.toString());
			}
		} catch (SQLException e) {
			CLogger.getCLogger(getClass()).log(Level.SEVERE, e.getMessage(), e);
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
		
		List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(true);	// re-query the partition key columns
		if (column.isActive() && column.isPartitionKey()) {
			if (!partitionKeyColumns.contains(column))
				partitionKeyColumns.add(column);
		} else {
			if (partitionKeyColumns.contains(column))
				partitionKeyColumns.remove(column);
		}
		
		if (partitionKeyColumns.size() > 2)
			return Msg.getMsg(Env.getCtx(), "OnlyTwoPartitionKeyAllowed");

		if (column.isActive() && column.isPartitionKey() && column.getPartitioningMethod().equals(MColumn.PARTITIONINGMETHOD_Range)) {
			String error = RangePartitionInterval.validateIntervalPattern(column);
			if (!Util.isEmpty(error))
				return error;
		}
		
		if (!isPartitionedTable(table, trxName))
			return null;
		
		//can't change partition key column for range partition
		if ((!column.isPartitionKey() || !column.isActive()) && Boolean.TRUE.equals(column.get_ValueOld("IsPartitionKey"))) {
			if (partitionKeyColumns.size() == 2
					|| (partitionKeyColumns.size() == 1 && !column.isPartitionKey())
					|| isRangePartitionedTable(table, trxName))
				return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged");
		}
		
		if (column.isActive() && column.isPartitionKey() && partitionKeyColumns.size() == 2) {
			if (column.is_ValueChanged(MColumn.COLUMNNAME_PartitioningMethod)) {
				return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged");
			} else if (column.is_ValueChanged(MColumn.COLUMNNAME_SeqNoPartition)) {
				int oldSeq = column.get_ValueOldAsInt(MColumn.COLUMNNAME_SeqNoPartition);
				int newSeq = column.getSeqNoPartition();
				int otherSeq = partitionKeyColumns.get(0).getAD_Column_ID() == column.getAD_Column_ID() 
									? partitionKeyColumns.get(1).getSeqNoPartition()
									: partitionKeyColumns.get(0).getSeqNoPartition();
				if (!(((newSeq < otherSeq) && (oldSeq < otherSeq)) || ((oldSeq > otherSeq) && (newSeq > otherSeq))))
					return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged");
			}		
		}
		
		//can't change partition type to list for range partition
		if (column.isActive() && column.isPartitionKey() && column.getPartitioningMethod().equals(MColumn.PARTITIONINGMETHOD_List)) {
			if (isRangePartitionedTable(table, trxName))
				return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged");
		}
		
		return null;
	}

	@Override
	public void detachPartition(MTable table, X_AD_TablePartition partition, String trxName,
			ProcessInfo processInfo) {
		if (partition.isPartitionAttached()) {
			String defaultPartitionName = "default_partition";
			if (partition.getParent_TablePartition_ID() > 0) {
				X_AD_TablePartition parentPartition = new X_AD_TablePartition(Env.getCtx(), partition.getParent_TablePartition_ID(), trxName);
				MColumn partitionKeyColumn = MColumn.get(partition.getAD_Column_ID());
				defaultPartitionName = getDefaultSubPartitionName(table, parentPartition, X_AD_Column.PARTITIONINGMETHOD_Range.equals(partitionKeyColumn.getPartitioningMethod()), trxName);
			}
			if (!defaultPartitionName.equalsIgnoreCase(partition.getName())) {
				StringBuilder exchangeTableName = new StringBuilder(table.getTableName())
						.append("_")
						.append(partition.getName());
				StringBuilder alter = null;				
				Query query = new Query(Env.getCtx(), X_AD_TablePartition.Table_Name, "Parent_TablePartition_ID=? And IsActive='Y' AND IsPartitionAttached='Y'", trxName);
				List<X_AD_TablePartition> subPartitions  = query.setParameters(partition.getAD_TablePartition_ID())
						.setOrderBy("Name")
						.list();
				if (subPartitions.size() > 0) {
					alter = new StringBuilder("CREATE TABLE ")
							.append(exchangeTableName)
							.append(" AS SELECT * FROM ")
							.append(table.getTableName())
							.append(" WHERE ROWNUM=-1 ");
					
					int no = DB.executeUpdateEx(alter.toString(), trxName);
					if (processInfo != null)
						processInfo.addLog(0, null, null, no + " " + alter.toString());
					
					alter = new StringBuilder("ALTER TABLE ")
							.append(exchangeTableName)
							.append(" MODIFY PARTITION BY ");
					MColumn subKeyColumn = MColumn.get(subPartitions.get(0).getAD_Column_ID());
					if (MColumn.PARTITIONINGMETHOD_Range.equals(subKeyColumn.getPartitioningMethod()))
						alter.append("RANGE (").append(subKeyColumn.getColumnName()).append(") ");
					else
						alter.append("LIST (").append(subKeyColumn.getColumnName()).append(") ");
					alter.append("(");
					for(X_AD_TablePartition subPartition : subPartitions) {
						alter.append("PARTITION ").append(subPartition.getExpressionPartition()).append(",");
					}
					if (MColumn.PARTITIONINGMETHOD_Range.equals(subKeyColumn.getPartitioningMethod()))
						alter.append("PARTITION VALUES LESS THAN (MAXVALUE))");
					else
						alter.append("PARTITION VALUES (DEFAULT))");
					no = DB.executeUpdateEx(alter.toString(), trxName);
					if (processInfo != null)
						processInfo.addLog(0, null, null, no + " " + alter.toString());
				} else {
					alter = new StringBuilder("CREATE TABLE ")
							.append(exchangeTableName)
							.append(" FOR EXCHANGE WITH TABLE ")
							.append(table.getTableName());
					
					int no = DB.executeUpdateEx(alter.toString(), trxName);
					if (processInfo != null)
						processInfo.addLog(0, null, null, no + " " + alter.toString());
				}
												
				alter = new StringBuilder("ALTER TABLE ")
						.append(table.getTableName());
				if (partition.getParent_TablePartition_ID() > 0) 
					alter.append(" EXCHANGE SUBPARTITION ");
				else
					alter.append(" EXCHANGE PARTITION ");
				alter.append(partition.getName())
					 .append(" WITH TABLE ")
					 .append(exchangeTableName);
				int no = DB.executeUpdateEx(alter.toString(), trxName);
				if (processInfo != null)
					processInfo.addLog(0, null, null, no + " " + alter.toString());
				partition.setIsPartitionAttached(false);
				partition.saveEx();
			} else {
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "CantDetachReattachDefaultPartition"));
			}
		}
	}

	@Override
	public void reattachPartition(MTable table, X_AD_TablePartition partition, String trxName,
			ProcessInfo processInfo) {
		if (!partition.isPartitionAttached()) {
			String defaultPartitionName = "default_partition";
			if (partition.getParent_TablePartition_ID() > 0) {
				X_AD_TablePartition parentPartition = new X_AD_TablePartition(Env.getCtx(), partition.getParent_TablePartition_ID(), trxName);
				MColumn partitionKeyColumn = MColumn.get(partition.getAD_Column_ID());
				defaultPartitionName = getDefaultSubPartitionName(table, parentPartition, X_AD_Column.PARTITIONINGMETHOD_Range.equals(partitionKeyColumn.getPartitioningMethod()), trxName);
			}
			if (!defaultPartitionName.equalsIgnoreCase(partition.getName())) {
				StringBuilder exchangeTableName = new StringBuilder(table.getTableName())
						.append("_")
						.append(partition.getName());
				StringBuilder updateStmt = new StringBuilder();
				updateStmt.append("INSERT INTO ").append(table.getTableName()).append(" ");
				updateStmt.append("SELECT * FROM ").append(exchangeTableName);				
				int no = DB.executeUpdateEx(updateStmt.toString(), trxName);
				if (processInfo != null)
					processInfo.addLog(0, null, null, no + " " + updateStmt.toString());
				
				updateStmt = new StringBuilder("DELETE FROM ").append(exchangeTableName);
				no = DB.executeUpdateEx(updateStmt.toString(), trxName);
				if (processInfo != null)
					processInfo.addLog(0, null, null, no + " " + updateStmt.toString());
				
				Query query = new Query(Env.getCtx(), X_AD_TablePartition.Table_Name, "Parent_TablePartition_ID=?", trxName);
				List<X_AD_TablePartition> subPartitions  = query.setParameters(partition.getAD_TablePartition_ID()).list();
				for(X_AD_TablePartition subPartition : subPartitions) {
					subPartition.deleteEx(true);
				}
				
				partition.deleteEx(true);
				table.getTablePartitions(true, trxName);				
				addPartitionAndMigrateData(table, trxName, processInfo);
				
				updateStmt = new StringBuilder("DROP TABLE ")
						.append(exchangeTableName);
				no = DB.executeUpdateEx(updateStmt.toString(), trxName);
				if (processInfo != null)
					processInfo.addLog(0, null, null, no + " " + updateStmt.toString());
			} else {
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "CantDetachReattachDefaultPartition"));
			}
		}
	}

}
