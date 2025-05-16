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
import java.util.Map;
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
import org.compiere.util.Trx;
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
	
	/**
	 * Get default partition name for table
	 * @param table
	 * @return String default partition name for table
	 */
	public String getDefaultPartitionName(MTable table)
	{
		return getDefaultPartitionName(table.getTableName());
	}
	
	/**
	 * Get default partition name for table
	 * @param tableName
	 * @return String default partition name for table
	 */
	public String getDefaultPartitionName(String tableName) {
		return tableName + "_default_partition";
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
		sql.append("ALTER TABLE ").append(table.getTableName()).append(" RENAME TO ").append(getDefaultPartitionName(table));
		DB.executeUpdateEx(sql.toString(), trxName);
		if (processInfo != null)
			processInfo.addLog(0, null, null, sql.toString());
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
					alterStmt.append("ALTER TABLE ").append(getDefaultPartitionName(table)).append(" ");
					alterStmt.append("DROP CONSTRAINT ").append(constraint_name).append(" CASCADE");
					DB.executeUpdateEx(alterStmt.toString(), trxName);
					if (pi != null)
						pi.addLog(0, null, null, alterStmt.toString());

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
					alterStmt.append("ALTER TABLE ").append(table.getTableName()).append(" ");
					alterStmt.append("ADD CONSTRAINT ").append(constraint_name).append(" ");
					alterStmt.append(constraint_definition.substring(0, constraint_definition.length()-1));
					for (int x = 0; x < lowerCasePartitionKeyColumnNames.size(); x++)
						alterStmt.append(", ").append(lowerCasePartitionKeyColumnNames.get(x));
					alterStmt.append(")");
					DB.executeUpdateEx(alterStmt.toString(), trxName);
					if (pi != null)
						pi.addLog(0, null, null, alterStmt.toString());					
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
					alterStmt.append("ALTER TABLE ").append(table.getTableName()).append(" ");
					alterStmt.append("ADD CONSTRAINT ").append(constraint_name).append(" ");
					alterStmt.append(constraint_definition);
					DB.executeUpdateEx(alterStmt.toString(), trxName);
					if (pi != null)
						pi.addLog(0, null, null, alterStmt.toString());
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
	 * Re-create indexes from the renamed table
	 * @param table
	 * @param trxName
	 * @param pi
	 * @return true if success
	 */
	private boolean migrateDBIndexes(MTable table, String trxName, ProcessInfo pi) {
		String indexs =
			"""
				select indexname, indexdef
				from pg_indexes
				where schemaname='adempiere'
				and tablename=?;
			""";
		
		Map<String, String> indexMap = new HashMap<String, String>();
		Map<String, String> uniqueMap = new HashMap<String, String>();
		try (PreparedStatement stmt = DB.prepareStatement(indexs, trxName)) {
			stmt.setString(1, getDefaultPartitionName(table).toLowerCase());
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String indexName = rs.getString(1);
				String indexdef = rs.getString(2);
				boolean unique = indexdef.contains("UNIQUE INDEX");
				if (unique)
					uniqueMap.put(indexName, indexdef);
				else
					indexMap.put(indexName, indexdef);
			}
		} catch (SQLException e) {
			throw new DBException(e);
		}
		
		List<String> partitionKeyColumnNames = table.getPartitionKeyColumnNames();
		for(String indexName : uniqueMap.keySet()) {
			String consql = "select conindid::regclass from pg_constraint where conrelid = ?::regclass and conindid = ?::regclass";
			String conindid = DB.getSQLValueString(trxName, consql, table.getTableName().toLowerCase(), indexName.toLowerCase());
			if (conindid != null && conindid.equalsIgnoreCase(indexName))
				continue;
			
			//unique index must include partition key column
			String indexdef = uniqueMap.get(indexName);
			for(String partitionKey : partitionKeyColumnNames) {
				if (!indexdef.contains(partitionKey.toLowerCase()+",") && !indexdef.contains(partitionKey.toLowerCase()+")")) {
					int whereIndex = indexdef.toLowerCase().indexOf(" where ");
					if (whereIndex > 0) {
						String whereClause = indexdef.substring(whereIndex);
						indexdef = indexdef.substring(0, whereIndex);
						indexdef = indexdef.substring(0, indexdef.length()-1)+", "+partitionKey.toLowerCase()+")";
						indexdef = indexdef + whereClause;
					} else {
						indexdef = indexdef.substring(0, indexdef.length()-1)+", "+partitionKey.toLowerCase()+")";
					}
				}
			}			
			StringBuilder alter = new StringBuilder("DROP INDEX ").append(indexName);
			DB.executeUpdateEx(alter.toString(), trxName);
			if (pi != null)
				pi.addLog(0, null, null, alter.toString());
			indexdef = indexdef.replace(" ON adempiere."+getDefaultPartitionName(table).toLowerCase()+" ", " ON adempiere."+table.getTableName().toLowerCase()+" ");
			DB.executeUpdateEx(indexdef, trxName);
			if (pi != null)
				pi.addLog(0, null, null, indexdef);
		}
		
		for(String indexName : indexMap.keySet()) {
			String consql = "select conindid::regclass from pg_constraint where conrelid = ?::regclass and conindid = ?::regclass";
			String conindid = DB.getSQLValueString(trxName, consql, table.getTableName().toLowerCase(), indexName.toLowerCase());
			if (conindid != null && conindid.equalsIgnoreCase(indexName))
				continue;
			
			String indexdef = indexMap.get(indexName);
			StringBuilder alter = new StringBuilder("DROP INDEX ").append(indexName);
			DB.executeUpdateEx(alter.toString(), trxName);
			if (pi != null)
				pi.addLog(0, null, null, alter.toString());
			indexdef = indexdef.replace(" ON adempiere."+getDefaultPartitionName(table).toLowerCase()+" ", " ON adempiere."+table.getTableName().toLowerCase()+" ");
			DB.executeUpdateEx(indexdef, trxName);
			if (pi != null)
				pi.addLog(0, null, null, indexdef);
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
		alterStmt.append("ALTER TABLE ").append(table.getTableName()).append(" ");
		alterStmt.append("ATTACH PARTITION ").append(getDefaultPartitionName(table)).append(" DEFAULT");
		DB.executeUpdateEx(alterStmt.toString(), trxName);
		if (pi != null)
			pi.addLog(0, null, null, alterStmt.toString());
		
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
					createStmt.append("CREATE TABLE ").append(table_schema).append(".").append(table.getTableName()).append(" (");
				}
				else
				{
					createStmt.append(", ");
				}
				
				createStmt.append(column_name).append(" ").append(data_type);
				if (data_type.equals("numeric") && numeric_precision > 0)
					createStmt.append("(").append(numeric_precision).append(",").append(numeric_scale).append(")");
				else if (data_type.startsWith("character") && character_maximum_length > 0)
					createStmt.append("(").append(character_maximum_length).append(")");
				
				if ("NO".equals(is_nullable))
					createStmt.append(" NOT NULL");
				
				if (!Util.isEmpty(column_default))
					createStmt.append(" DEFAULT ").append(column_default);				
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
				
				createStmt.append(" (").append(partitionKeyColumn.getColumnName()).append(")");
				
				DB.executeUpdateEx(createStmt.toString(), trxName);
				if (processInfo != null)
					processInfo.addLog(0, null, null, createStmt.toString());
				
				if (!migrateDBContrainsts(table, trxName, processInfo))
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FailedMigrateDatabaseConstraints"));
				
				if (!migrateDBIndexes(table, trxName, processInfo))
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FailedMigrateDatabaseConstraints"));
				
				if (!attachDefaultPartition(table, trxName, processInfo))
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FailedAttachDefaultPartition"));
				
				fixView(table, trxName, processInfo);
				
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
	 * Re-create view after rename table
	 * @param table
	 * @param trxName
	 * @param pi
	 */
	private void fixView(MTable table, String trxName, ProcessInfo pi) {
		String views =
			"""
			with recursive depv(relname, viewoid, depth) as (
			select distinct a.relname, a.oid, 1
				from pg_class a, pg_depend b, pg_depend c, pg_class d, pg_namespace
				where a.oid = b.refobjid
				and b.objid = c.objid
				and b.refobjid <> c.refobjid
				and c.refobjid = d.oid
				and d.relname = ?
				and d.relkind = 'r'
				and a.relkind = 'v'
				and a.relnamespace = pg_namespace.oid
				and pg_namespace.nspname = lower('adempiere')
			  union all
			select distinct dependee.relname, dependee.oid, depv.depth+1
				from pg_depend 
				join pg_rewrite on pg_depend.objid = pg_rewrite.oid 
				join pg_class as dependee on pg_rewrite.ev_class = dependee.oid 
				join pg_class as dependent on pg_depend.refobjid = dependent.oid 
				join pg_attribute ON pg_depend.refobjid = pg_attribute.attrelid and pg_depend.refobjsubid = pg_attribute.attnum and pg_attribute.attnum > 0
				join depv on dependent.relname = depv.relname
				join pg_namespace on dependee.relnamespace = pg_namespace.oid
			where pg_namespace.nspname = lower('adempiere')
			)
			select relname, viewoid, max(depth) from depv group by relname, viewoid order by 3 desc
			""";
		String defaultPartitionName = getDefaultPartitionName(table).toLowerCase();
		String tableName = table.getTableName().toLowerCase();
		List<String> viewTexts = new ArrayList<String>();
		List<String> viewNames = new ArrayList<String>();
		List<String> grants = new ArrayList<String>();
		try(PreparedStatement stmt = DB.prepareStatement(views, trxName)) {
			stmt.setString(1, defaultPartitionName);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				String viewName = rs.getString(1);
				viewNames.add(viewName);
				int oid = rs.getInt(2);
				String viewText = DB.getSQLValueString(trxName, "SELECT pg_get_viewdef(?)", oid);
				viewTexts.add(viewText);
			}
			
			String grantSQL = 
				"""
				SELECT String_agg('grant ' || privilege_type || ' on ' || table_name || ' to "' || grantee || '"', '; ')
				FROM information_schema.role_table_grants 
				WHERE table_name=?	and table_schema='adempiere'
				""";
			for(int i = 0; i < viewNames.size(); i++) {
				String viewName = viewNames.get(i);
				try(PreparedStatement stmt1 = DB.prepareStatement(grantSQL, trxName)) {
					stmt1.setString(1, viewName.toLowerCase());
					ResultSet rs1 = stmt1.executeQuery();
					while(rs1.next()) {
						grants.add(rs1.getString(1));
					}
				}
				StringBuilder dropStmt = new StringBuilder("DROP VIEW ").append(viewName);
				DB.executeUpdateEx(dropStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, dropStmt.toString());
			}
			
			for(int i = viewNames.size()-1; i >=0; i--) {
				String viewName = viewNames.get(i);
				String viewText = viewTexts.get(i);
				String grant = grants.get(i);
				StringBuilder createStmt = new StringBuilder("CREATE OR REPLACE VIEW ").append(viewName).append(" AS ");
				if (viewText.contains(" "+defaultPartitionName + " ")) {
					viewText = viewText.replace(" "+defaultPartitionName+" ", " "+tableName+" ");
				}
				if (viewText.contains(" "+defaultPartitionName + "\n")) {
					viewText = viewText.replace(" "+defaultPartitionName+"\n", " "+tableName+"\n");
				}
				if (viewText.contains(" "+defaultPartitionName + ".")) {
					viewText = viewText.replace(" "+defaultPartitionName+".", " "+tableName+".");
				}
				if (viewText.contains("("+defaultPartitionName + " ")) {
					viewText = viewText.replace("("+defaultPartitionName+" ", "("+tableName+" ");
				}
				if (viewText.contains("("+defaultPartitionName + "\n")) {
					viewText = viewText.replace("("+defaultPartitionName+"\n", "("+tableName+"\n");
				}
				if (viewText.contains("("+defaultPartitionName + ".")) {
					viewText = viewText.replace("("+defaultPartitionName+".", "("+tableName+".");
				}
				String operators = "=><+-*/|%^&#~!";
				for (int j = 0; j < operators.length(); j++) {
				    String find = operators.charAt(j)+defaultPartitionName + ".";
				    String replace = operators.charAt(j)+tableName+".";
					if (viewText.contains(find)) {
						viewText = viewText.replace(find, replace);
					}
				}
				
				createStmt.append(viewText);
				DB.executeUpdateEx(createStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, "CREATE OR REPLACE VIEW "+viewName);
				DB.executeUpdateEx(grant, trxName);
			}
		} catch (SQLException e) {
			throw new DBException(e);
		}
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
		currentPartitionKey = currentPartitionKey.replace(",", ", ");				
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
		MColumn subPartitionColumn = null;
		if (partitionKeyColumns.size() > 1)
			subPartitionColumn = partitionKeyColumns.get(1);
		String partitioningMethod = partitionKeyColumn.getPartitioningMethod();		
		if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_List))
		{
			isUpdated = addListPartition(table, partitionKeyColumn, trxName, pi, subPartitionColumn);
		}
		else if (partitioningMethod.equals(MColumn.PARTITIONINGMETHOD_Range))
		{
			isUpdated = addRangePartition(table, partitionKeyColumn, trxName, pi, subPartitionColumn);
		}
		else
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{partitioningMethod}));
		
		return isUpdated;
	}

	/**
	 * Create new {@link RangePartitionColumn} instance
	 * @param fromTableName table name for FROM clause
	 * @param partitionKeyColumn
	 * @param trxName
	 * @return new RangePartitionColumn instance
	 */
	private RangePartitionColumn buildRangePartitionColumn(String fromTableName, MColumn partitionKeyColumn, String trxName) {
		String partitionKeyColumnName = partitionKeyColumn.getColumnName();
		String partitionKeyColumnRangeIntervalPattern = partitionKeyColumn.getRangePartitionInterval();
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT MIN(").append(partitionKeyColumnName).append(") AS min_value, ");
		sql.append("MAX(").append(partitionKeyColumnName).append(") AS max_value ");
		sql.append("FROM ").append(fromTableName);
		
		List<Object> values = DB.getSQLValueObjectsEx(trxName, sql.toString());
		if (values.get(0) != null && values.get(1) != null)
		{
			return new RangePartitionColumn(
					partitionKeyColumnName, partitionKeyColumnRangeIntervalPattern, 
					values.get(0), values.get(1));
		}
		return null;
	}
	
	/**
	 * Create new X_AD_TablePartition record for a range partition interval
	 * @param rangePartitionInterval
	 * @param tablePartitionNames existing partition names
	 * @param table
	 * @param partitionKeyColumn
	 * @param partitionNamePrefix Prefix for the new range partition name
	 * @param defaultPartitionName default partition name to select from
	 * @param parentPartition
	 * @param trxName
	 * @return new X_AD_TablePartition record or null (if 0 record in defaultPartitionName for rangePartitionInterval)
	 */
	private X_AD_TablePartition createNewRangePartition(RangePartitionInterval rangePartitionInterval, List<String> tablePartitionNames, MTable table, MColumn partitionKeyColumn, 
			String partitionNamePrefix, String defaultPartitionName, X_AD_TablePartition parentPartition, String trxName) {
		X_AD_TablePartition partition = null;
		StringBuilder name = new StringBuilder();
		name.append(partitionNamePrefix);
		name.append("_");
		name.append(rangePartitionInterval.getName());
			
		StringBuilder expression = new StringBuilder();
		expression.append("FOR VALUES FROM (");
		expression.append(rangePartitionInterval.getFrom());
		expression.append(") TO (");
		expression.append(rangePartitionInterval.getTo());
		expression.append(")");

		StringBuilder countStmt = new StringBuilder("SELECT Count(*) FROM ")
				.append(defaultPartitionName).append(" ")
				.append("WHERE ").append(" ")
				.append(partitionKeyColumn.getColumnName()).append(" >= ");
		if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
			countStmt.append("TO_DATE(").append(rangePartitionInterval.getFrom()).append(",'yyyy-MM-dd') ");
		else
			countStmt.append(rangePartitionInterval.getFrom()).append(" ");
		countStmt.append("AND ").append(partitionKeyColumn.getColumnName()).append(" < ");
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
			return null;
		}
		
		if (!tablePartitionNames.contains(name.toString())) {
			partition = table.createTablePartition(name.toString(), expression.toString(), trxName, partitionKeyColumn, parentPartition);
			tablePartitionNames.add(name.toString());
		}
		return partition;
	}
	
	/**
	 * Move data from default partition to a range partition 
	 * @param partition range partition
	 * @param partitionKeyColumn
	 * @param tableName table name to attached partition
	 * @param defaultPartitionName name of default partition
	 * @param rangePartitionInterval
	 * @param pi
	 * @param trxName
	 */
	private void moveDefaultPartitionDataForRange(X_AD_TablePartition partition, MColumn partitionKeyColumn, String tableName, 
			String defaultPartitionName, RangePartitionInterval rangePartitionInterval, ProcessInfo pi, String trxName) {
		StringBuilder updateStmt = new StringBuilder();
		updateStmt.append("WITH x AS ( ");
		updateStmt.append("DELETE FROM ").append(defaultPartitionName).append(" ");
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
		int no = DB.executeUpdateEx(updateStmt.toString(), trxName);
		if (pi != null)
			pi.addLog(0, null, null, no + " " + updateStmt.toString());
		
		StringBuilder alterStmt = new StringBuilder();
		alterStmt.append("ALTER TABLE ").append(tableName).append(" ");
		alterStmt.append("ATTACH PARTITION ").append(partition.getName()).append(" ").append(partition.getExpressionPartition());
		DB.executeUpdateEx(alterStmt.toString(), trxName);
		if (pi != null)
			pi.addLog(0, null, null, alterStmt.toString());
	}
	
	/**
	 * Add new range partition
	 * @param table
	 * @param partitionKeyColumn 
	 * @param trxName
	 * @param pi
	 * @param subPartitionColumn 
	 * @return true if new range partition added
	 */
	private boolean addRangePartition(MTable table, MColumn partitionKeyColumn, String trxName, ProcessInfo pi, MColumn subPartitionColumn) {
		boolean isUpdated = false;
		RangePartitionColumn rangePartitionColumn = buildRangePartitionColumn(getDefaultPartitionName(table), partitionKeyColumn, trxName);		
		if (rangePartitionColumn == null)
			return false;
		
		List<RangePartitionInterval> rangePartitionIntervals = RangePartitionInterval.createInterval(table, rangePartitionColumn, trxName);
		List<String> tablePartitionNames = table.getTablePartitionNames(trxName);
		
		for (RangePartitionInterval rangePartitionInterval : rangePartitionIntervals)
		{
			X_AD_TablePartition partition = createNewRangePartition(rangePartitionInterval, tablePartitionNames, table, partitionKeyColumn, table.getTableName().toLowerCase(), 
					getDefaultPartitionName(table), null, trxName);			
			if (partition != null)
			{
				StringBuilder createStmt = new StringBuilder();
				createStmt.append("CREATE TABLE ").append(partition.getName()).append(" (").append(DB_PostgreSQL.NATIVE_MARKER).append("LIKE ");
				createStmt.append(getDefaultPartitionName(table)).append(" INCLUDING ALL)");
				if (subPartitionColumn != null) {
					createStmt.append(" PARTITION BY ");
					if (MColumn.PARTITIONINGMETHOD_List.equals(subPartitionColumn.getPartitioningMethod()))
						createStmt.append(" LIST(");
					else if (MColumn.PARTITIONINGMETHOD_Range.equals(subPartitionColumn.getPartitioningMethod()))
						createStmt.append(" RANGE(");
					else
						throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{subPartitionColumn.getPartitioningMethod()}));
					createStmt.append(subPartitionColumn.getColumnName());
					createStmt.append(")");				
				}
				DB.executeUpdateEx(createStmt.toString(), trxName);
				if (pi != null)
					pi.addLog(0, null, null, createStmt.toString().replace(DB_PostgreSQL.NATIVE_MARKER, ""));				
				if (subPartitionColumn != null) {
					createSubDefaultPartition(table, subPartitionColumn, partition, pi, trxName);
				}
				
				moveDefaultPartitionDataForRange(partition, partitionKeyColumn, table.getTableName(), getDefaultPartitionName(table), rangePartitionInterval, pi, trxName);
				isUpdated = true;
			}
		}
		
		if (subPartitionColumn != null) {
			List<X_AD_TablePartition> partitions = new ArrayList<>();
			tablePartitionNames = new ArrayList<>();
			try (PreparedStatement stmt = DB.prepareStatement("SELECT * FROM AD_TablePartition WHERE IsActive='Y' AND AD_Table_ID=? AND AD_Column_ID=? AND IsPartitionAttached='Y'", trxName)) {
				stmt.setInt(1, table.getAD_Table_ID());
				stmt.setInt(2, partitionKeyColumn.getAD_Column_ID());
				ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
					X_AD_TablePartition partition = new X_AD_TablePartition(Env.getCtx(), rs, trxName);
					if (partition.getName().toLowerCase().endsWith("_default_partition"))
						continue;
					partitions.add(partition);
					tablePartitionNames.add(partition.getName());
				}
			} catch (SQLException e) {
				throw new DBException(e);
			}
			for(X_AD_TablePartition partition : partitions) {
				String subDefaultPartition = partition.getName() + "_default_partition";
				String sql = 
						"""
							SELECT COUNT(*)
							FROM information_schema.columns
							WHERE table_name = LOWER(?)
						""";
				int count = DB.getSQLValueEx(trxName, sql, subDefaultPartition);
				if (count <= 0)
					continue;
				if (MColumn.PARTITIONINGMETHOD_List.equals(subPartitionColumn.getPartitioningMethod())) {
					HashMap<String, Object> subValues = new HashMap<>();
					List<X_AD_TablePartition> subPartitions = generateListPartition(table, partition.getName(), subDefaultPartition, subPartitionColumn, subValues, partition, trxName);
					for(X_AD_TablePartition subPartition : subPartitions) {
						StringBuilder createStmt = new StringBuilder();
						createStmt.append("CREATE TABLE ").append(subPartition.getName()).append(" (").append(DB_PostgreSQL.NATIVE_MARKER).append("LIKE ");
						createStmt.append(subDefaultPartition).append(" INCLUDING ALL)");
						DB.executeUpdateEx(createStmt.toString(), trxName);
						if (pi != null)
							pi.addLog(0, null, null, createStmt.toString().replace(DB_PostgreSQL.NATIVE_MARKER, ""));	
						Object subValue = subValues.get(subPartition.getName());
						moveDefaultPartitionDataForList(subPartition, subPartitionColumn, partition.getName(), subDefaultPartition, subValue, pi, trxName);
					}
				} else if (MColumn.PARTITIONINGMETHOD_Range.equals(subPartitionColumn.getPartitioningMethod())) {
					rangePartitionColumn = buildRangePartitionColumn(partition.getName(), subPartitionColumn, trxName);		
					if (rangePartitionColumn != null)
					{
						rangePartitionIntervals = RangePartitionInterval.createInterval(table, rangePartitionColumn, trxName);
						for (RangePartitionInterval rangePartitionInterval : rangePartitionIntervals)
						{							
							X_AD_TablePartition subPartition = createNewRangePartition(rangePartitionInterval, tablePartitionNames, table, subPartitionColumn, partition.getName(), 
									subDefaultPartition, partition, trxName);			
							if (subPartition != null)
							{
								StringBuilder createStmt = new StringBuilder();
								createStmt.append("CREATE TABLE ").append(subPartition.getName()).append(" (").append(DB_PostgreSQL.NATIVE_MARKER).append("LIKE ");
								createStmt.append(subDefaultPartition).append(" INCLUDING ALL)");
								DB.executeUpdateEx(createStmt.toString(), trxName);
								if (pi != null)
									pi.addLog(0, null, null, createStmt.toString().replace(DB_PostgreSQL.NATIVE_MARKER, ""));
								moveDefaultPartitionDataForRange(subPartition, subPartitionColumn, partition.getName(), subDefaultPartition, rangePartitionInterval, pi, trxName);
							}
						}
					}
				}
			}
		}
		
		return isUpdated;
	}

	/**
	 * Generate new X_AD_TablePartition records
	 * @param table
	 * @param partitionNamePrefix name prefix for new list partition
	 * @param fromPartitionTable table name for FROM clause
	 * @param partitionKeyColumn
	 * @param columnValues List Partition Name:List Value map
	 * @param parentPartition
	 * @param trxName
	 * @return list of generated X_AD_TablePartition records
	 */
	private List<X_AD_TablePartition> generateListPartition(MTable table, String partitionNamePrefix, String fromPartitionTable, MColumn partitionKeyColumn, HashMap<String, Object> columnValues, 
			X_AD_TablePartition parentPartition, String trxName) {
		List<X_AD_TablePartition> partitions = new ArrayList<X_AD_TablePartition>();
		String nameColumn = "'" + partitionNamePrefix + "_' || " + partitionKeyColumn.getColumnName();
		String expressionColumn = "'FOR VALUES IN (''' || " + partitionKeyColumn.getColumnName() + " || ''')'";
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT DISTINCT ").append(nameColumn).append(" AS name, ");
		sql.append(expressionColumn).append(" AS expression, ");
		sql.append(partitionKeyColumn.getColumnName()).append(" ");
		sql.append("FROM ").append(fromPartitionTable).append(" ");
		
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
				
				X_AD_TablePartition partition = table.createTablePartition(name, expression, trxName, partitionKeyColumn, parentPartition);
				partitions.add(partition);
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		return partitions;
	}
	
	/**
	 * Move records from default partition to a list partition
	 * @param partition list partition
	 * @param partitionKeyColumn
	 * @param tableName table name to attached list partition
	 * @param defaultPartitionName name of default partition
	 * @param listValue key value of list partition
	 * @param pi
	 * @param trxName
	 */
	private void moveDefaultPartitionDataForList(X_AD_TablePartition partition, MColumn partitionKeyColumn, String tableName, 
			String defaultPartitionName, Object listValue, ProcessInfo pi, String trxName) {
		StringBuilder updateStmt = new StringBuilder();
		updateStmt.append("WITH x AS ( ");
		updateStmt.append("DELETE FROM ").append(defaultPartitionName).append(" ");
		updateStmt.append("WHERE ").append(" ");
			
		updateStmt.append(partitionKeyColumn.getColumnName()).append("=");						
				
		if (DisplayType.isText(partitionKeyColumn.getAD_Reference_ID()) || partitionKeyColumn.getAD_Reference_ID() == DisplayType.YesNo 
			|| DisplayType.isList(partitionKeyColumn.getAD_Reference_ID())
			|| "EntityType".equals(partitionKeyColumn.getColumnName())
			|| "AD_Language".equals(partitionKeyColumn.getColumnName()))
			updateStmt.append("'").append(listValue).append("' ");
		else
			updateStmt.append(listValue).append(" ");
		
		updateStmt.append("RETURNING *) ");
		updateStmt.append("INSERT INTO ").append(partition.getName()).append(" ");
		updateStmt.append("SELECT * FROM x");
		int no = DB.executeUpdateEx(updateStmt.toString(), trxName);
		if (pi != null)
			pi.addLog(0, null, null, no + " " + updateStmt.toString());
		
		StringBuilder alterStmt = new StringBuilder();
		alterStmt.append("ALTER TABLE ").append(tableName).append(" ");
		alterStmt.append("ATTACH PARTITION ").append(partition.getName()).append(" ").append(partition.getExpressionPartition());
		DB.executeUpdateEx(alterStmt.toString(), trxName);
		if (pi != null)
			pi.addLog(0, null, null, alterStmt.toString());
	}
	
	/**
	 * Add new list partition
	 * @param table
	 * @param partitionKeyColumn 
	 * @param trxName
	 * @param pi
	 * @param subPartitionColumn 
	 * @return true if new list partition added
	 */
	private boolean addListPartition(MTable table, MColumn partitionKeyColumn, String trxName, ProcessInfo pi, MColumn subPartitionColumn) {
		boolean isUpdated = false;
		HashMap<String, Object> columnValues = new HashMap<>();
		List<X_AD_TablePartition> partitions = generateListPartition(table, table.getTableName().toLowerCase(), getDefaultPartitionName(table), partitionKeyColumn, columnValues, null, trxName);
		for (X_AD_TablePartition partition : partitions)
		{
			Object value = columnValues.get(partition.getName());
				
			StringBuilder createStmt = new StringBuilder();
			createStmt.append("CREATE TABLE ").append(partition.getName()).append(" (").append(DB_PostgreSQL.NATIVE_MARKER).append("LIKE ");
			createStmt.append(getDefaultPartitionName(table)).append(" INCLUDING ALL)");
			if (subPartitionColumn != null) {
				createStmt.append(" PARTITION BY ");
				if (MColumn.PARTITIONINGMETHOD_List.equals(subPartitionColumn.getPartitioningMethod()))
					createStmt.append(" LIST(");
				else if (MColumn.PARTITIONINGMETHOD_Range.equals(subPartitionColumn.getPartitioningMethod()))
					createStmt.append(" RANGE(");
				else
					throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "PartitioningMethodNotSupported", new Object[]{subPartitionColumn.getPartitioningMethod()}));
				createStmt.append(subPartitionColumn.getColumnName());
				createStmt.append(")");				
			}
			DB.executeUpdateEx(createStmt.toString(), trxName);
			if (pi != null)
				pi.addLog(0, null, null, createStmt.toString().replace(DB_PostgreSQL.NATIVE_MARKER, ""));
			
			if (subPartitionColumn != null) {
				createSubDefaultPartition(table, subPartitionColumn, partition, pi, trxName);
			}
			
			moveDefaultPartitionDataForList(partition, partitionKeyColumn, table.getTableName(), getDefaultPartitionName(table), value, pi, trxName);
			
			isUpdated = true;
		}
		
		if (subPartitionColumn != null) {
			List<String> tablePartitionNames = new ArrayList<>();
			partitions = new ArrayList<>();
			try (PreparedStatement stmt = DB.prepareStatement("SELECT * FROM AD_TablePartition WHERE IsActive='Y' AND AD_Table_ID=? AND AD_Column_ID=? AND IsPartitionAttached='Y'", trxName)) {
				stmt.setInt(1, table.getAD_Table_ID());
				stmt.setInt(2, partitionKeyColumn.getAD_Column_ID());
				ResultSet rs = stmt.executeQuery();
				while(rs.next()) {
					X_AD_TablePartition partition = new X_AD_TablePartition(Env.getCtx(), rs, trxName);
					if (partition.getName().toLowerCase().endsWith("_default_partition"))
						continue;
					partitions.add(partition);
					tablePartitionNames.add(partition.getName());
				}
			} catch (SQLException e) {
				throw new DBException(e);
			}
			for(X_AD_TablePartition partition : partitions) {
				String subDefaultPartition = partition.getName() + "_default_partition";
				String sql = 
						"""
							SELECT COUNT(*)
							FROM information_schema.columns
							WHERE table_name = LOWER(?)
						""";
				int count = DB.getSQLValueEx(trxName, sql, subDefaultPartition);
				if (count <= 0)
					continue;
				if (MColumn.PARTITIONINGMETHOD_List.equals(subPartitionColumn.getPartitioningMethod())) {
					HashMap<String, Object> subValues = new HashMap<>();
					List<X_AD_TablePartition> subPartitions = generateListPartition(table, partition.getName(), subDefaultPartition, subPartitionColumn, subValues, partition, trxName);
					for(X_AD_TablePartition subPartition : subPartitions) {
						StringBuilder createStmt = new StringBuilder();
						createStmt.append("CREATE TABLE ").append(subPartition.getName()).append(" (").append(DB_PostgreSQL.NATIVE_MARKER).append("LIKE ");
						createStmt.append(subDefaultPartition).append(" INCLUDING ALL)");
						DB.executeUpdateEx(createStmt.toString(), trxName);
						if (pi != null)
							pi.addLog(0, null, null, createStmt.toString().replace(DB_PostgreSQL.NATIVE_MARKER, ""));
						Object subValue = subValues.get(subPartition.getName());
						moveDefaultPartitionDataForList(subPartition, subPartitionColumn, partition.getName(), subDefaultPartition, subValue, pi, trxName);
					}
				} else if (MColumn.PARTITIONINGMETHOD_Range.equals(subPartitionColumn.getPartitioningMethod())) {
					RangePartitionColumn rangePartitionColumn = buildRangePartitionColumn(partition.getName(), subPartitionColumn, trxName);		
					if (rangePartitionColumn != null)
					{
						List<RangePartitionInterval> rangePartitionIntervals = RangePartitionInterval.createInterval(table, rangePartitionColumn, trxName);
						for (RangePartitionInterval rangePartitionInterval : rangePartitionIntervals)
						{							
							X_AD_TablePartition subPartition = createNewRangePartition(rangePartitionInterval, tablePartitionNames, table, subPartitionColumn, partition.getName(), 
									subDefaultPartition, partition, trxName);			
							if (subPartition != null)
							{
								StringBuilder createStmt = new StringBuilder();
								createStmt.append("CREATE TABLE ").append(subPartition.getName()).append(" (").append(DB_PostgreSQL.NATIVE_MARKER).append("LIKE ");
								createStmt.append(subDefaultPartition).append(" INCLUDING ALL)");
								DB.executeUpdateEx(createStmt.toString(), trxName);
								if (pi != null)
									pi.addLog(0, null, null, createStmt.toString().replace(DB_PostgreSQL.NATIVE_MARKER, ""));
								moveDefaultPartitionDataForRange(subPartition, subPartitionColumn, partition.getName(), subDefaultPartition, rangePartitionInterval, pi, trxName);
							}
						}
					}
				}
			}
		}
		return isUpdated;
	}

	/**
	 * Create default partition table for sub-partition
	 * @param table
	 * @param subPartitionColumn sub-partition column
	 * @param partition parent partition
	 * @param pi
	 * @param trxName
	 */
	private void createSubDefaultPartition(MTable table, MColumn subPartitionColumn, X_AD_TablePartition partition, ProcessInfo pi, String trxName) {
		StringBuilder subStmt = new StringBuilder("CREATE TABLE ")
				.append(partition.getName()).append("_default_partition (").append(DB_PostgreSQL.NATIVE_MARKER).append("LIKE ")
				.append(partition.getName())
				.append(" INCLUDING ALL)");
		DB.executeUpdateEx(subStmt.toString(), trxName);
		if (pi != null)
			pi.addLog(0, null, null, subStmt.toString());
		subStmt = new StringBuilder("ALTER TABLE ")
				.append(partition.getName())
				.append(" ATTACH PARTITION ")
				.append(partition.getName()).append("_default_partition DEFAULT ");
		DB.executeUpdateEx(subStmt.toString(), trxName);
		if (pi != null)
			pi.addLog(0, null, null, subStmt.toString().replace(DB_PostgreSQL.NATIVE_MARKER, ""));
		table.createTablePartition(partition.getName()+"_default_partition", "DEFAULT", trxName, subPartitionColumn, partition);
	}

	@Override
	public boolean runPostPartitionProcess(MTable table, String trxName, ProcessInfo processInfo) {
		StringBuilder stmt = new StringBuilder();
		stmt.append("VACUUM ANALYZE ").append(table.getTableName());
		DB.executeUpdateEx(stmt.toString(), trxName);
		if (processInfo != null)
			processInfo.addLog(0, null, null, stmt.toString());
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
		if (partitionKeyColumns.size() > 2)
			return Msg.getMsg(Env.getCtx(), "OnlyTwoPartitionKeyAllowed");
		
		if (column.isActive() && column.isPartitionKey() && column.getPartitioningMethod().equals(MColumn.PARTITIONINGMETHOD_Range)) {
			String error = RangePartitionInterval.validateIntervalPattern(column);
			if (!Util.isEmpty(error))
				return error;
		}
		
		if (!isPartitionedTable(table, trxName))
			return null;
		
		if (column.is_ValueChanged(MColumn.COLUMNNAME_IsPartitionKey)
				|| (column.isPartitionKey() && column.is_ValueChanged(MColumn.COLUMNNAME_IsActive))
				|| (column.isPartitionKey() && column.is_ValueChanged(MColumn.COLUMNNAME_PartitioningMethod))) {
			if (partitionKeyColumns.size() == 2 || (partitionKeyColumns.size()==1 && !column.isPartitionKey() && column.is_ValueChanged(MColumn.COLUMNNAME_IsPartitionKey)))
				return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged");
			else
				return validateConfiguration(table, trxName);
		}
		
		if (column.isPartitionKey() && column.is_ValueChanged(MColumn.COLUMNNAME_SeqNoPartition) && partitionKeyColumns.size() == 2) {
			int oldSeq = column.get_ValueOldAsInt(MColumn.COLUMNNAME_SeqNoPartition);
			int newSeq = column.getSeqNoPartition();
			int otherSeq = partitionKeyColumns.get(0).getAD_Column_ID() == column.getAD_Column_ID() 
								? partitionKeyColumns.get(1).getSeqNoPartition()
								: partitionKeyColumns.get(0).getSeqNoPartition();
			if (!(((newSeq < otherSeq) && (oldSeq < otherSeq)) || ((oldSeq > otherSeq) && (newSeq > otherSeq))))
				return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged");
		}
		
		if (column.isPartitionKey() && column.is_ValueChanged(MColumn.COLUMNNAME_RangePartitionInterval))
			return Msg.getMsg(Env.getCtx(), "PartitionConfigurationChanged") + " [" + MColumn.COLUMNNAME_RangePartitionInterval + "]";
		return null;
	}

	@Override
	public void detachPartition(MTable table, X_AD_TablePartition partition, String trxName,
			ProcessInfo processInfo) {
		if (partition.isPartitionAttached()) {
			if (!"default".equalsIgnoreCase(partition.getExpressionPartition())) {
				StringBuilder alter = new StringBuilder("ALTER TABLE ");
				if (partition.getParent_TablePartition_ID() > 0) {
					X_AD_TablePartition parentPartition = new X_AD_TablePartition(Env.getCtx(), partition.getParent_TablePartition_ID(), trxName);
					alter.append(parentPartition.getName()).append(" ");
				} else {
					alter.append(table.getTableName()).append(" ");
				}
				alter.append("DETACH PARTITION ").append(partition.getName());
				DB.executeUpdateEx(alter.toString(), trxName);
				if (processInfo != null)
					processInfo.addLog(0, null, null, alter.toString());
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
			if (!"default".equalsIgnoreCase(partition.getExpressionPartition())) {
				StringBuilder alter = new StringBuilder("ALTER TABLE ");
				if (partition.getParent_TablePartition_ID() > 0) {
					X_AD_TablePartition parentPartition = new X_AD_TablePartition(Env.getCtx(), partition.getParent_TablePartition_ID(), trxName);
					alter.append(parentPartition.getName()).append(" ");
				} else {
					alter.append(table.getTableName()).append(" ");
				}
				alter.append("ATTACH PARTITION ")
					 .append(partition.getName())
					 .append(" ")
					 .append(partition.getExpressionPartition());
				boolean success = true;
				try {
					DB.executeUpdateEx(alter.toString(), trxName);
					if (processInfo != null)
						processInfo.addLog(0, null, null, alter.toString());
				} catch (RuntimeException e) {
					success = false;
					Trx.get(trxName, false).rollback();
				}
				
				if (success) {
					partition.setIsPartitionAttached(true);
					partition.saveEx();
				} else {
					//fallback to insert and delete
					StringBuilder updateStmt = new StringBuilder();
					updateStmt.append("WITH x AS ( ");
					updateStmt.append("DELETE FROM ").append(partition.getName()).append(" ");
					updateStmt.append("RETURNING *) ");
					updateStmt.append("INSERT INTO ").append(table.getTableName()).append(" ");
					updateStmt.append("SELECT * FROM x");
					int no = DB.executeUpdateEx(updateStmt.toString(), trxName);
					if (processInfo != null)
						processInfo.addLog(0, null, null, no + " " + updateStmt.toString());
					alter = new StringBuilder("DROP TABLE ").append(partition.getName());
					DB.executeUpdateEx(alter.toString(), trxName);
					if (processInfo != null)
						processInfo.addLog(0, null, null, alter.toString());
					try {
						Trx.get(trxName, false).commit(true);
					} catch (SQLException e) {
						throw new DBException(e);
					}

					partition.deleteEx(true);
					table.getTablePartitions(true, trxName);
					addPartitionAndMigrateData(table, trxName, processInfo);
				}
			} else {
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "CantDetachReattachDefaultPartition"));
			}
		}
	}

}
