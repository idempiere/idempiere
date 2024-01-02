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
import java.util.StringTokenizer;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.db.DB_PostgreSQL;
import org.compiere.db.partition.ITablePartitionService;
import org.compiere.db.partition.RangePartitionColumn;
import org.compiere.db.partition.RangePartitionInterval;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.Query;
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
		
		List<String> partitionKeyColumnNames = table.getPartitionKeyColumnNames();
		
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

					List<String> lowerCasePartitionKeyColumnNames = new ArrayList<String>();
					for (String partitionKeyColumnName : partitionKeyColumnNames)
						lowerCasePartitionKeyColumnNames.add(partitionKeyColumnName.toLowerCase());
					String constraintColumnsStr = constraint_definition.substring(constraint_definition.indexOf("(")+1, constraint_definition.length()-1);
					StringTokenizer st = new StringTokenizer(constraintColumnsStr, ",");
					while (st.hasMoreTokens()) {
						String token = st.nextToken().trim();
						if (lowerCasePartitionKeyColumnNames.contains(token))
							lowerCasePartitionKeyColumnNames.remove(token);
					}

					alterStmt = new StringBuilder();
					alterStmt.append("ALTER TABLE " + table.getTableName() + " ");
					alterStmt.append("ADD CONSTRAINT " + constraint_name + " ");
					alterStmt.append(constraint_definition.substring(0, constraint_definition.length()-1));
					for (int x = 0; x < lowerCasePartitionKeyColumnNames.size(); x++)
						alterStmt.append(", " + lowerCasePartitionKeyColumnNames.get(x));
					alterStmt.append(")");
					no = DB.executeUpdateEx(alterStmt.toString(), trxName);
					if (pi != null)
						pi.addLog(0, null, null, no + " " + alterStmt.toString());
				}
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		
		try (PreparedStatement pstmt = DB.prepareStatement(sql, trxName))
		{			
			pstmt.setString(1, getDefaultPartitionName(table));
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				String constraint_name = rs.getString("constraint_name");
				String constraint_definition = rs.getString("constraint_definition");
				
				if (constraint_definition.startsWith("CHECK ") || constraint_definition.startsWith("FOREIGN KEY "))
				{
					if (constraint_definition.indexOf(getDefaultPartitionName(table).toLowerCase()) >= 0) {
						constraint_definition = constraint_definition.replace(getDefaultPartitionName(table).toLowerCase(), table.getTableName().toLowerCase());
					}
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
		
		table.createTablePartition(getDefaultPartitionName(table), "DEFAULT", trxName, table.getPartitionKeyColumns(false).get(0));
		
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
				List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(false);
				MColumn partitionKeyColumn = partitionKeyColumns.get(0);
				String partitioningMethod = partitionKeyColumn.getPartitioningMethod();
				if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_List))
					createStmt.append("List"); 
				else if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_Range))
					createStmt.append("Range");
				else
					throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{partitioningMethod}));
				
				createStmt.append(" (" + partitionKeyColumn.getColumnName() + ")");
				
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
	 * Get DB partition key definition
	 * @param table
	 * @param trxName
	 * @return String
	 */
	private String getPartitionKeyDefinition(MTable table, String trxName) {
		String sql =
				"""
					SELECT pg_get_partkeydef(oid) AS partition_key
					FROM pg_class
					WHERE relkind = 'p'
					AND relname = LOWER(?)	
				""";
		return DB.getSQLValueStringEx(trxName, sql.toString(), table.getTableName());
	}

	/**
	 * Validate partition configuration
	 * @param table
	 * @param trxName
	 * @return String error-code - null if not error
	 */
	private String validateConfiguration(MTable table, String trxName) {		
		String currentPartitionKey = null;
		String partitionKey = getPartitionKeyDefinition(table, trxName);
		List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(false);
		if (partitionKeyColumns.size() == 0)
			return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged") + ": " + partitionKey;
		MColumn partitionKeyColumn = partitionKeyColumns.get(0);
		String partitioningMethod = partitionKeyColumn.getPartitioningMethod();		
		if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_List))
			currentPartitionKey = "LIST";
		else if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_Range))
			currentPartitionKey = "RANGE";
		currentPartitionKey += " (" + partitionKeyColumn.getColumnName().toLowerCase() + ")";
		currentPartitionKey = currentPartitionKey.replaceAll(",", ", ");				
		if (!currentPartitionKey.equalsIgnoreCase(partitionKey))
			return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged") + ": " + partitionKey;
		return null;
	}
	
	@Override
	public boolean addPartitionAndMigrateData(MTable table, String trxName, ProcessInfo pi) {
		boolean isUpdated = false;
		
		String error = validateConfiguration(table, trxName);
		if (!Util.isEmpty(error))
			throw new AdempiereException(error);
				
		List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(false);
		MColumn partitionKeyColumn = partitionKeyColumns.get(0);
		String partitioningMethod = partitionKeyColumn.getPartitioningMethod();		
		if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_List))
		{
			isUpdated = addListPartition(table, partitionKeyColumn, trxName, pi);
		}
		else if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_Range))
		{
			isUpdated = addRangePartition(table, partitionKeyColumn, trxName, pi);
		}
		else
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{partitioningMethod}));
		
		return isUpdated;
	}

	/**
	 * Add new range partition
	 * @param table
	 * @param partitionKeyColumn 
	 * @param trxName
	 * @param pi
	 * @return true if new range partition added
	 */
	private boolean addRangePartition(MTable table, MColumn partitionKeyColumn, String trxName, ProcessInfo pi) {
		boolean isUpdated = false;
		X_AD_TablePartition partition = null;
		RangePartitionColumn rangePartitionColumn = null;		

		String partitionKeyColumnName = partitionKeyColumn.getColumnName();
		String partitionKeyColumnRangeIntervalPattern = partitionKeyColumn.getRangePartitionInterval();
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT MIN(").append(partitionKeyColumnName).append(") AS min_value, ");
		sql.append("MAX(").append(partitionKeyColumnName).append(") AS max_value ");
		sql.append("FROM ").append(getDefaultPartitionName(table));
		
		List<Object> values = DB.getSQLValueObjectsEx(trxName, sql.toString());
		if (values.get(0) != null && values.get(1) != null)
		{
			rangePartitionColumn = new RangePartitionColumn(
					partitionKeyColumnName, partitionKeyColumnRangeIntervalPattern, 
					values.get(0), values.get(1));
		}
		
		if (rangePartitionColumn == null)
			return false;
		
		List<RangePartitionInterval> rangePartitionIntervals = RangePartitionInterval.createInterval(table, rangePartitionColumn, trxName);
		List<String> tablePartitionNames = table.getTablePartitionNames(trxName);
		
		for (RangePartitionInterval rangePartitionInterval : rangePartitionIntervals)
		{
			StringBuilder name = new StringBuilder();
			name.append(table.getTableName().toLowerCase());
			name.append("_");
			name.append(rangePartitionInterval.getName());
				
			StringBuilder expression = new StringBuilder();
			expression.append("FOR VALUES FROM (");
			expression.append(rangePartitionInterval.getFrom());
			expression.append(") TO (");
			expression.append(rangePartitionInterval.getTo());
			expression.append(")");

			StringBuilder countStmt = new StringBuilder("SELECT Count(*) FROM ")
					.append(getDefaultPartitionName(table)).append(" ")
					.append("WHERE ").append(" ")
					.append(partitionKeyColumn.getColumnName()).append(" >= ");
			if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
				countStmt.append("TO_DATE(").append(rangePartitionInterval.getFrom()).append(",'yyyy-MM-dd') ");
			else
				countStmt.append(rangePartitionInterval.getFrom()).append(" ");
			countStmt.append("AND " + partitionKeyColumn.getColumnName()).append(" < ");
			if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
				countStmt.append("TO_DATE(").append(rangePartitionInterval.getTo()).append(",'yyyy-MM-dd') ");
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
			
			if (!tablePartitionNames.contains(name.toString()))
				partition = table.createTablePartition(name.toString(), expression.toString(), trxName, partitionKeyColumn);
			
			if (partition != null)
			{
				StringBuilder createStmt = new StringBuilder();
				createStmt.append("CREATE TABLE ").append(partition.getName()).append(" (").append(DB_PostgreSQL.NATIVE_MARKER).append("LIKE ");
				createStmt.append(getDefaultPartitionName(table)).append(" INCLUDING ALL)");
				int no = DB.executeUpdateEx(createStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, no + " " + createStmt.toString());
					
				StringBuilder updateStmt = new StringBuilder();
				updateStmt.append("WITH x AS ( ");
				updateStmt.append("DELETE FROM ").append(getDefaultPartitionName(table)).append(" ");
				updateStmt.append("WHERE ").append(" ");				
				updateStmt.append(partitionKeyColumn.getColumnName()).append(" >= ");
				if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
					updateStmt.append("TO_DATE(").append(rangePartitionInterval.getFrom()).append(",'yyyy-MM-dd') ");
				else
					updateStmt.append(rangePartitionInterval.getFrom()).append(" ");
				updateStmt.append("AND ").append(partitionKeyColumn.getColumnName()).append(" < ");
				if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
					updateStmt.append("TO_DATE(").append(rangePartitionInterval.getTo()).append(",'yyyy-MM-dd') ");
				else
					updateStmt.append(rangePartitionInterval.getTo()).append(" ");
					
				updateStmt.append("RETURNING *) ");
				updateStmt.append("INSERT INTO ").append(partition.getName()).append(" ");
				updateStmt.append("SELECT * FROM x");
				no = DB.executeUpdateEx(updateStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, no + " " + updateStmt.toString());
				
				StringBuilder alterStmt = new StringBuilder();
				alterStmt.append("ALTER TABLE ").append(table.getTableName()).append(" ");
				alterStmt.append("ATTACH PARTITION ").append(partition.getName()).append(" ").append(partition.getExpressionPartition());
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
	 * @param partitionKeyColumn 
	 * @param trxName
	 * @param pi
	 * @return true if new list partition added
	 */
	private boolean addListPartition(MTable table, MColumn partitionKeyColumn, String trxName, ProcessInfo pi) {
		boolean isUpdated = false;
		List<X_AD_TablePartition> partitions = new ArrayList<X_AD_TablePartition>();
		String nameColumn = "'" + table.getTableName().toLowerCase() + "_' || " + partitionKeyColumn.getColumnName();
		String expressionColumn = "'FOR VALUES IN (''' || " + partitionKeyColumn.getColumnName() + " || ''')'";
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT DISTINCT ").append(nameColumn).append(" AS name, ");
		sql.append(expressionColumn).append(" AS expression, ");
		sql.append(partitionKeyColumn.getColumnName()).append(" ");
		sql.append("FROM ").append(getDefaultPartitionName(table)).append(" ");
		
		HashMap<String, Object> columnValues = new HashMap<>();
		try (PreparedStatement pstmt = DB.prepareStatement(sql.toString(), trxName))
		{				
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				String name = rs.getString("name");
				String expression = rs.getString("expression");
				
				Object value = new ArrayList<Object>();					
				value = rs.getObject(partitionKeyColumn.getColumnName());
				columnValues.put(name, value);
				
				X_AD_TablePartition partition = table.createTablePartition(name, expression, trxName, partitionKeyColumn);
				partitions.add(partition);
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		
		for (X_AD_TablePartition partition : partitions)
		{
			Object value = columnValues.get(partition.getName());
				
			StringBuilder createStmt = new StringBuilder();
			createStmt.append("CREATE TABLE ").append(partition.getName()).append(" (").append(DB_PostgreSQL.NATIVE_MARKER).append("LIKE ");
			createStmt.append(getDefaultPartitionName(table)).append(" INCLUDING ALL)");
			int no = DB.executeUpdateEx(createStmt.toString(), trxName);
			if (pi != null)
				pi.addLog(0, null, null, no + " " + createStmt.toString());
				
			StringBuilder updateStmt = new StringBuilder();
			updateStmt.append("WITH x AS ( ");
			updateStmt.append("DELETE FROM ").append(getDefaultPartitionName(table)).append(" ");
			updateStmt.append("WHERE ").append(" ");
				
			updateStmt.append(partitionKeyColumn.getColumnName()).append("=");						
					
			if (DisplayType.isText(partitionKeyColumn.getAD_Reference_ID()))
				updateStmt.append("'").append(value).append("' ");
			else
				updateStmt.append(value).append(" ");
			
			updateStmt.append("RETURNING *) ");
			updateStmt.append("INSERT INTO ").append(partition.getName()).append(" ");
			updateStmt.append("SELECT * FROM x");
			no = DB.executeUpdateEx(updateStmt.toString(), trxName);
			if (pi != null)
				pi.addLog(0, null, null, no + " " + updateStmt.toString());
			
			StringBuilder alterStmt = new StringBuilder();
			alterStmt.append("ALTER TABLE ").append(table.getTableName()).append(" ");
			alterStmt.append("ATTACH PARTITION ").append(partition.getName()).append(" ").append(partition.getExpressionPartition());
			no = DB.executeUpdateEx(alterStmt.toString(), trxName);
			if (pi != null)
				pi.addLog(0, null, null, no + " " + alterStmt.toString());
			
			isUpdated = true;
		}
		return isUpdated;
	}

	@Override
	public boolean runPostPartitionProcess(MTable table, String trxName, ProcessInfo processInfo) {
		StringBuilder stmt = new StringBuilder();
		stmt.append("VACUUM ANALYZE ").append(table.getTableName());
		int no = DB.executeUpdateEx(stmt.toString(), trxName);
		if (processInfo != null)
			processInfo.addLog(0, null, null, no + " " + stmt.toString());
		return true;
	}

	@Override
	public String isValidConfiguration(MTable table) {
		String trxName = table.get_TrxName();
		if (!isPartitionedTable(table, trxName))
			return null;
		if (!table.isPartition())
			return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged") + " [" + MTable.COLUMNNAME_IsPartition + "]";
		List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(false);
		MColumn partitionKeyColumn = partitionKeyColumns.get(0);
		String currentPartitionKey = null;
		String partitioningMethod = partitionKeyColumn.getPartitioningMethod();		
		if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_List))
			currentPartitionKey = "LIST";
		else if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_Range))
			currentPartitionKey = "RANGE";
		String partitionKey = getPartitionKeyDefinition(table, trxName);
		if (!partitionKey.toLowerCase().startsWith(currentPartitionKey.toLowerCase()))
			return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged") + " [" + MColumn.COLUMNNAME_PartitioningMethod + "]";
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
		if (partitionKeyColumns.size() > 1)
			return Msg.getMsg(Env.getCtx(), "OnlyOnePartitionKeyAllowed");
		
		if (column.isActive() && column.isPartitionKey() && column.getPartitioningMethod().equals(MColumn.PARTITIONINGMETHOD_Range)) {
			String error = RangePartitionInterval.validateIntervalPattern(column);
			if (!Util.isEmpty(error))
				return error;
		}
		
		if (!isPartitionedTable(table, trxName))
			return null;
		if (column.is_ValueChanged(MColumn.COLUMNNAME_IsPartitionKey)
				|| (column.isPartitionKey() && column.is_ValueChanged(MColumn.COLUMNNAME_IsActive))
				|| (column.isPartitionKey() && column.is_ValueChanged(MColumn.COLUMNNAME_SeqNoPartition))) {
			return validateConfiguration(table, trxName);
		}
		if (column.isPartitionKey() && column.is_ValueChanged(MColumn.COLUMNNAME_RangePartitionInterval))
			return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged") + " [" + MColumn.COLUMNNAME_RangePartitionInterval + "]";
		return null;
	}

}
