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
package org.adempiere.db.postgresql.partition;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.adempiere.exceptions.AdempiereException;
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
import org.compiere.util.Util;

public class TablePartitionService implements ITablePartitionService {

	public TablePartitionService() {
	}

	@Override
	public boolean isPartitionedTable(MTable table, String trxName) {
		String sql = 
			"""
				SELECT 1 FROM pg_partitioned_table
				JOIN pg_class parent ON pg_partitioned_table.partrelid = parent.oid
				WHERE LOWER(relname) = LOWER(?)		
			""";
		return DB.getSQLValueEx(trxName, sql, table.getTableName()) == 1;
	}

	private String getDefaultPartitionName(MTable table)
	{
		return table.getTableName() + "_default_partition";
	}
	
	/**
	 * Rename existing table to default partition
	 * @param table
	 * @param trxName
	 * @param processInfo
	 * @return true if success
	 */
	private boolean renameOriginalTable(MTable table, String trxName, ProcessInfo processInfo) {
		StringBuilder sql = new StringBuilder();
		sql.append("ALTER TABLE " + table.getTableName() + " RENAME TO " + getDefaultPartitionName(table));
		int no = DB.executeUpdateEx(sql.toString(), trxName);
		if (processInfo != null)
			processInfo.addLog(0, null, null, no + " " + sql.toString());
		return true;
	}
	
	/**
	 * Change primary key and unique constraint to include partition columns 
	 * @param table
	 * @param trxName
	 * @param pi
	 * @return true if success
	 */
	private boolean migrateDBContrainsts(MTable table, String trxName, ProcessInfo pi) {
		String sql = 
			"""
				SELECT COUNT(*)
				FROM pg_constraint c
				WHERE conrelid = LOWER(?)::regclass		
			""";
		int count = DB.getSQLValueEx(trxName, sql, table.getTableName());
		if (count > 0)
			return true;		
		
		String partitionKeyColumnsString = table.getPartitionKeyColumnNamesAsString();		
		sql = 
			"""
				SELECT conname AS constraint_name, 
				pg_get_constraintdef(c.oid) AS constraint_definition 
				FROM pg_constraint c 
				WHERE conrelid = LOWER(?)::regclass 
				ORDER BY conname 
			""";
		try (PreparedStatement pstmt = DB.prepareStatement(sql, trxName))
		{			
			pstmt.setString(1, getDefaultPartitionName(table));
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				String constraint_name = rs.getString("constraint_name");
				String constraint_definition = rs.getString("constraint_definition");
				
				if (constraint_definition.startsWith("PRIMARY KEY ") || constraint_definition.startsWith("UNIQUE "))
				{
					StringBuilder alterStmt = new StringBuilder();
					alterStmt.append("ALTER TABLE " + getDefaultPartitionName(table) + " ");
					alterStmt.append("DROP CONSTRAINT " + constraint_name + " CASCADE");
					int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
					if (pi != null)
						pi.addLog(0, null, null, no + " " + alterStmt.toString());
					
					alterStmt = new StringBuilder();
					alterStmt.append("ALTER TABLE " + table.getTableName() + " ");
					alterStmt.append("ADD CONSTRAINT " + constraint_name + " ");
					alterStmt.append(constraint_definition.substring(0, constraint_definition.length()-1) + ", " + partitionKeyColumnsString + ")");
					no = DB.executeUpdateEx(alterStmt.toString(), trxName);
					if (pi != null)
						pi.addLog(0, null, null, no + " " + alterStmt.toString());
				}
				else if (constraint_definition.startsWith("CHECK ") || constraint_definition.startsWith("FOREIGN KEY "))
				{
					StringBuilder alterStmt = new StringBuilder();
					alterStmt.append("ALTER TABLE " + table.getTableName() + " ");
					alterStmt.append("ADD CONSTRAINT " + constraint_name + " ");
					alterStmt.append(constraint_definition);
					int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
					if (pi != null)
						pi.addLog(0, null, null, no + " " + alterStmt.toString());
				}
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
			
		return true;
	}

	/**
	 * Attach renamed original table as default partition
	 * @param table
	 * @param trxName
	 * @param pi
	 * @return true if success
	 */
	private boolean attachDefaultPartition(MTable table, String trxName, ProcessInfo pi) {
		String sql = 
			"""
				SELECT COUNT(*) 
				FROM pg_class base_tb 
				JOIN pg_inherits i ON i.inhparent = base_tb.oid 
				JOIN pg_class pt ON pt.oid = i.inhrelid 
				WHERE base_tb.oid = LOWER(?)::regclass 
				AND pt.relname = LOWER(?)
			""";
		int count = DB.getSQLValueEx(trxName, sql, table.getTableName(), getDefaultPartitionName(table));
		if (count > 0)
			return true;
		
		StringBuilder alterStmt = new StringBuilder();
		alterStmt.append("ALTER TABLE " + table.getTableName() + " ");
		alterStmt.append("ATTACH PARTITION " + getDefaultPartitionName(table) + " DEFAULT");
		int no = DB.executeUpdateEx(alterStmt.toString(), trxName);
		if (pi != null)
			pi.addLog(0, null, null, no + " " + alterStmt.toString());
		
		table.createTablePartition(getDefaultPartitionName(table), "DEFAULT", trxName);
		
		return true;
	}
	
	@Override
	public boolean createPartitionedTable(MTable table, String trxName, ProcessInfo processInfo) {
		if (!renameOriginalTable(table, trxName, processInfo))
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FailedRenameOriginalTable"));
		
		String sql = 
			"""
				SELECT table_schema, column_name, data_type, 
				character_maximum_length, numeric_precision, numeric_scale,
				is_nullable, column_default
				FROM information_schema.columns
				WHERE table_name = LOWER(?)
				ORDER BY ordinal_position
			""";
		StringBuilder createStmt = null;
		try (PreparedStatement pstmt = DB.prepareStatement(sql, trxName))
		{			
			pstmt.setString(1, getDefaultPartitionName(table));
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				String table_schema = rs.getString("table_schema");
				String column_name = rs.getString("column_name");
				String data_type = rs.getString("data_type");
				int character_maximum_length = rs.getInt("character_maximum_length");
				int numeric_precision = rs.getInt("numeric_precision");
				int numeric_scale = rs.getInt("numeric_scale");
				String is_nullable = rs.getString("is_nullable");
				String column_default = rs.getString("column_default");
				
				if (createStmt == null)
				{
					createStmt = new StringBuilder();
					createStmt.append("CREATE TABLE " + table_schema + "." + table.getTableName() + " (");
				}
				else
				{
					createStmt.append(", ");
				}
				
				createStmt.append(column_name + " " + data_type);
				if (data_type.equals("numeric") && numeric_precision > 0)
					createStmt.append("(" + numeric_precision + "," + numeric_scale + ")");
				else if (data_type.startsWith("character") && character_maximum_length > 0)
					createStmt.append("(" + character_maximum_length + ")");
				
				if ("NO".equals(is_nullable))
					createStmt.append(" NOT NULL");
				
				if (!Util.isEmpty(column_default))
					createStmt.append(" DEFAULT " + column_default);				
			}
			
			if (createStmt != null)
			{
				createStmt.append(") PARTITION BY ");
				String partitioningMethod = table.getPartitioningMethod();
				if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List))
					createStmt.append("List"); 
				else if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_Range))
					createStmt.append("Range");
				else
					throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{partitioningMethod}));
				
				String partitionKeyColumnsString = table.getPartitionKeyColumnNamesAsString();
				if (!Util.isEmpty(partitionKeyColumnsString))
					createStmt.append(" (" + partitionKeyColumnsString + ")");
				
				int no = DB.executeUpdateEx(createStmt.toString(), trxName);
				if (processInfo != null)
					processInfo.addLog(0, null, null, no + " " + createStmt.toString());
				
				if (!migrateDBContrainsts(table, trxName, processInfo))
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FailedMigrateDatabaseConstraints"));
				
				if (!attachDefaultPartition(table, trxName, processInfo))
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FailedAttachDefaultPartition"));
				
				return true;
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		
		return false;
	}

	/**
	 * Validate partition configuration
	 * @param table
	 * @param trxName
	 * @return true if valid
	 */
	private boolean validateConfiguration(MTable table, String trxName) {		
		String currentPartitionKey = null;
		String partitioningMethod = table.getPartitioningMethod();		
		if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List))
			currentPartitionKey = "LIST";
		else if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_Range))
			currentPartitionKey = "RANGE";
		currentPartitionKey += " (" + table.getPartitionKeyColumnNamesAsString().toLowerCase() + ")";
		currentPartitionKey = currentPartitionKey.replaceAll(",", ", ");
		
		String sql =
			"""
				SELECT pg_get_partkeydef(oid) AS partition_key
				FROM pg_class
				WHERE relkind = 'p'
				AND relname = LOWER(?)	
			""";
		String partitionKey = DB.getSQLValueStringEx(trxName, sql.toString(), table.getTableName());
		
		return currentPartitionKey.equalsIgnoreCase(partitionKey);
	}
	
	@Override
	public boolean addPartitionAndMigrateData(MTable table, String trxName, ProcessInfo pi) {
		boolean isUpdated = false;
		
		if (!validateConfiguration(table, trxName))
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged"));
				
		String partitioningMethod = table.getPartitioningMethod();		
		if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List))
		{
			isUpdated = addListPartition(table, trxName, pi);
		}
		else if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_Range))
		{
			isUpdated = addRangePartition(table, trxName, pi);
		}
		else
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{partitioningMethod}));
		
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
			sql.append("FROM ").append(getDefaultPartitionName(table));
			
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
			List<String> nameCombination = combination.getNameCombinations().get(x);
			List<Object> fromCombination = combination.getFromCombinations().get(x);
			List<Object> toCombination = combination.getToCombinations().get(x);
			
			StringBuilder name = new StringBuilder();
			name.append(table.getTableName().toLowerCase() + "_");
			for (int y = 0; y < nameCombination.size(); y++) {
				if (y > 0)
					name.append("_");
				name.append(nameCombination.get(y));
			}
			
			StringBuilder expression = new StringBuilder();
			expression.append("FOR VALUES FROM (");
			for (int y = 0; y < fromCombination.size(); y++) {
				if (y > 0)
					expression.append(",");
				expression.append(fromCombination.get(y));
			}
			expression.append(") TO (");
			for (int y = 0; y < toCombination.size(); y++) {
				if (y > 0)
					expression.append(",");
				expression.append(toCombination.get(y));
			}
			expression.append(")");
			
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
				
				List<Object> fromCombination = combination.getFromCombinations().get(i);
				List<Object> toCombination = combination.getToCombinations().get(i);
				
				StringBuilder createStmt = new StringBuilder();
				createStmt.append("CREATE TABLE " + partition.getName() + " (LIKE ");
				createStmt.append(getDefaultPartitionName(table) + " INCLUDING ALL)");
				int no = DB.executeUpdateEx(createStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, no + " " + createStmt.toString());
				
				StringBuilder updateStmt = new StringBuilder();
				updateStmt.append("WITH x AS ( ");
				updateStmt.append("DELETE FROM ").append(getDefaultPartitionName(table)).append(" ");
				updateStmt.append("WHERE ").append(" ");
				
				for (int x = 0; x < partitionKeyColumns.size(); x++)
				{
					if (x > 0)
						updateStmt.append("AND ");
					
					MColumn partitionKeyColumn = partitionKeyColumns.get(x);
					updateStmt.append(partitionKeyColumn.getColumnName()).append(" >= ");
					if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
						updateStmt.append("TO_DATE(").append(fromCombination.get(x)).append(",'yyyy-MM-dd') ");
					else
						updateStmt.append(fromCombination.get(x)).append(" ");
					updateStmt.append("AND " + partitionKeyColumn.getColumnName()).append(" < ");
					if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
						updateStmt.append("TO_DATE(").append(toCombination.get(x)).append(",'yyyy-MM-dd') ");
					else
						updateStmt.append(toCombination.get(x)).append(" ");
				}
				
				updateStmt.append("RETURNING *) ");
				updateStmt.append("INSERT INTO ").append(partition.getName()).append(" ");
				updateStmt.append("SELECT * FROM x");
				no = DB.executeUpdateEx(updateStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, no + " " + updateStmt.toString());
				
				StringBuilder alterStmt = new StringBuilder();
				alterStmt.append("ALTER TABLE " + table.getTableName() + " ");
				alterStmt.append("ATTACH PARTITION " + partition.getName() + " " + partition.getExpressionPartition());
				no = DB.executeUpdateEx(alterStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, no + " " + alterStmt.toString());
				
				isUpdated = true;
			}
		}
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
		String nameColumn = "'" + table.getTableName().toLowerCase() + "_' || " + partitionKeyColumnsString.replaceAll(",", " || '_' || ");
		String expressionColumn = "'FOR VALUES IN (''' || " + partitionKeyColumnsString.replaceAll(",", " || ''',''' || ") + " || ''')'";
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT DISTINCT ").append(nameColumn).append(" AS name, ");
		sql.append(expressionColumn).append(" AS expression, ");
		sql.append(partitionKeyColumnsString).append(" ");
		sql.append("FROM ").append(getDefaultPartitionName(table)).append(" ");
		sql.append("ORDER BY ").append(partitionKeyColumnsString);
		
		HashMap<String, List<Object>> columnValues = new HashMap<String, List<Object>>();
		try (PreparedStatement pstmt = DB.prepareStatement(sql.toString(), trxName))
		{				
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				String name = rs.getString("name");
				String expression = rs.getString("expression");
				
				List<Object> values = new ArrayList<Object>();					
				for (String partitionKeyColumnName : partitionKeyColumnNames)
					values.add(rs.getObject(partitionKeyColumnName));
				columnValues.put(name, values);
				
				partitions.add(table.createTablePartition(name, expression, trxName));
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		
		if (!partitions.isEmpty())
		{
			List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns();
			for (X_AD_TablePartition partition : partitions)
			{
				List<Object> values = columnValues.get(partition.getName());
				
				StringBuilder createStmt = new StringBuilder();
				createStmt.append("CREATE TABLE " + partition.getName() + " (LIKE ");
				createStmt.append(getDefaultPartitionName(table) + " INCLUDING ALL)");
				int no = DB.executeUpdateEx(createStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, no + " " + createStmt.toString());
				
				StringBuilder updateStmt = new StringBuilder();
				updateStmt.append("WITH x AS ( ");
				updateStmt.append("DELETE FROM ").append(getDefaultPartitionName(table)).append(" ");
				updateStmt.append("WHERE ").append(" ");
				
				for (int x = 0; x < partitionKeyColumns.size(); x++)
				{
					if (x > 0)
						updateStmt.append("AND ");
					
					MColumn partitionKeyColumn = partitionKeyColumns.get(x);
					updateStmt.append(partitionKeyColumn.getColumnName()).append("=");						
					
					if (DisplayType.isText(partitionKeyColumn.getAD_Reference_ID()))
						updateStmt.append("'").append(values.get(x)).append("' ");
					else
						updateStmt.append(values.get(x)).append(" ");
				}
				
				updateStmt.append("RETURNING *) ");
				updateStmt.append("INSERT INTO ").append(partition.getName()).append(" ");
				updateStmt.append("SELECT * FROM x");
				no = DB.executeUpdateEx(updateStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, no + " " + updateStmt.toString());
				
				StringBuilder alterStmt = new StringBuilder();
				alterStmt.append("ALTER TABLE " + table.getTableName() + " ");
				alterStmt.append("ATTACH PARTITION " + partition.getName() + " " + partition.getExpressionPartition());
				no = DB.executeUpdateEx(alterStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, no + " " + alterStmt.toString());
				
				isUpdated = true;
			}
		}
		return isUpdated;
	}

	@Override
	public boolean runPostPartitionProcess(MTable table, String trxName, ProcessInfo processInfo) {
		StringBuilder stmt = new StringBuilder();
		stmt.append("VACUUM ANALYZE " + table.getTableName());
		int no = DB.executeUpdateEx(stmt.toString(), trxName);
		if (processInfo != null)
			processInfo.addLog(0, null, null, no + " " + stmt.toString());
		return true;
	}

}
