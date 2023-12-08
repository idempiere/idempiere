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
 *                                                                     *
 * Contributors:                                                       *
 * - Elaine Tan - etantg       								   		   *
 **********************************************************************/
package org.idempiere.tablepartition.impl;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_TablePartition;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Util;
import org.idempiere.tablepartition.AbstractTablePartition;

public class TablePartition_PostgreSQL extends AbstractTablePartition {

	public TablePartition_PostgreSQL(MTable table, ProcessInfo pi) {
		super(table, pi);
	}
	
	@Override
	public boolean isPartitionedTable() {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT 1 FROM pg_partitioned_table ");
		sql.append("JOIN pg_class parent ON pg_partitioned_table.partrelid = parent.oid ");
		sql.append("WHERE LOWER(relname) = LOWER(?)");
		return DB.getSQLValueEx(getTrxName(), sql.toString(), getTableName()) == 1;
	}

	@Override
	public boolean renameOriginalTable() {
		StringBuilder sql = new StringBuilder();
		sql.append("ALTER TABLE " + getTableName() + " RENAME TO " + getDefaultPartitionName());
		int no = DB.executeUpdateEx(sql.toString(), getTrxName());
		addLog(no + " " + sql.toString());
		return true;
	}

	@Override
	public boolean createPartitionedTable() {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT table_schema, column_name, data_type, ");
		sql.append("character_maximum_length, numeric_precision, numeric_scale, ");
		sql.append("is_nullable, column_default ");
		sql.append("FROM information_schema.columns ");
		sql.append("WHERE table_name = LOWER(?) ");
		sql.append("ORDER BY ordinal_position ");
				
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuilder createStmt = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), getTrxName());
			pstmt.setString(1, getDefaultPartitionName());
			rs = pstmt.executeQuery();
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
					createStmt.append("CREATE TABLE " + table_schema + "." + getTableName() + " (");
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
				String partitioningMethod = getPartitioningMethod();
				if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List))
					createStmt.append("List");
				else if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_Range))
					createStmt.append("Range");
				else
					throw new IllegalArgumentException("Partitioning Method not supported: " + partitioningMethod);
				
				String partitionKeyColumnsString = getPartitionKeyColumnNamesAsString();
				if (!Util.isEmpty(partitionKeyColumnsString))
					createStmt.append(" (" + partitionKeyColumnsString + ")");
				
				int no = DB.executeUpdateEx(createStmt.toString(), getTrxName());
				addLog(no + " " + createStmt.toString());
				return true;
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		return false;
	}

	@Override
	public boolean migrateDBContrainsts() {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT COUNT(*) ");
		sql.append("FROM pg_constraint c ");
		sql.append("WHERE conrelid = LOWER(?)::regclass ");
		int count = DB.getSQLValueEx(getTrxName(), sql.toString(), getTableName());
		if (count > 0)
			return true;		
		
		String partitionKeyColumnsString = getPartitionKeyColumnNamesAsString();
		
		sql = new StringBuilder();
		sql.append("SELECT conname AS constraint_name, ");
		sql.append("pg_get_constraintdef(c.oid) AS constraint_definition ");
		sql.append("FROM pg_constraint c ");
		sql.append("WHERE conrelid = LOWER(?)::regclass ");
		sql.append("ORDER BY conname ");
				
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), getTrxName());
			pstmt.setString(1, getDefaultPartitionName());
			rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				String constraint_name = rs.getString("constraint_name");
				String constraint_definition = rs.getString("constraint_definition");
				
				if (constraint_definition.startsWith("PRIMARY KEY ") || constraint_definition.startsWith("UNIQUE "))
				{
					StringBuilder alterStmt = new StringBuilder();
					alterStmt.append("ALTER TABLE " + getDefaultPartitionName() + " ");
					alterStmt.append("DROP CONSTRAINT " + constraint_name + " CASCADE");
					int no = DB.executeUpdateEx(alterStmt.toString(), getTrxName());
					addLog(no + " " + alterStmt.toString());
					
					alterStmt = new StringBuilder();
					alterStmt.append("ALTER TABLE " + getTableName() + " ");
					alterStmt.append("ADD CONSTRAINT " + constraint_name + " ");
					alterStmt.append(constraint_definition.substring(0, constraint_definition.length()-1) + ", " + partitionKeyColumnsString + ")");
					no = DB.executeUpdateEx(alterStmt.toString(), getTrxName());
					addLog(no + " " + alterStmt.toString());
				}
				else if (constraint_definition.startsWith("CHECK ") || constraint_definition.startsWith("FOREIGN KEY "))
				{
					StringBuilder alterStmt = new StringBuilder();
					alterStmt.append("ALTER TABLE " + getTableName() + " ");
					alterStmt.append("ADD CONSTRAINT " + constraint_name + " ");
					alterStmt.append(constraint_definition);
					int no = DB.executeUpdateEx(alterStmt.toString(), getTrxName());
					addLog(no + " " + alterStmt.toString());
				}
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
			
		return true;
	}

	@Override
	public boolean migrateDBIndexes() {
/*		String partitionKeyColumnsString = getPartitionKeyColumnsString();
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT indexname, indexdef ");
		sql.append("FROM pg_indexes ");
		sql.append("WHERE tablename = LOWER(?) ");
		sql.append("ORDER BY indexname ");
				
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), getTrxName());
			pstmt.setString(1, getDefaultPartitionName());
			rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				String indexname = rs.getString("indexname");
				String indexdef = rs.getString("indexdef");
				
				String createStmt = indexdef;
				createStmt = createStmt.replaceFirst(getDefaultPartitionName().toLowerCase(), getTableName().toLowerCase());
				createStmt = createStmt.substring(0, createStmt.length()-1) + ", " + partitionKeyColumnsString + ")";
				DB.executeUpdateEx(createStmt.toString(), getTrxName());
			}
		}
		catch (SQLException e)
		{
			throw new DBException(e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
*/			
		return true;
	}

	@Override
	public boolean attachToDefaultPartition() {
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT COUNT(*) ");
		sql.append("FROM pg_class base_tb ");
		sql.append("JOIN pg_inherits i ON i.inhparent = base_tb.oid ");
		sql.append("JOIN pg_class pt ON pt.oid = i.inhrelid ");
		sql.append("WHERE base_tb.oid = LOWER(?)::regclass ");
		sql.append("AND pt.relname = LOWER(?)");
		int count = DB.getSQLValue(getTrxName(), sql.toString(), getTableName(), getDefaultPartitionName());
		if (count > 0)
			return true;
		
		StringBuilder alterStmt = new StringBuilder();
		alterStmt.append("ALTER TABLE " + getTableName() + " ");
		alterStmt.append("ATTACH PARTITION " + getDefaultPartitionName() + " DEFAULT");
		int no = DB.executeUpdateEx(alterStmt.toString(), getTrxName());
		addLog(no + " " + alterStmt.toString());
		return true;
	}

	private boolean isUpdated = false;
	@Override
	public boolean migrateData() {
		if (!validateConfiguration())
			throw new AdempiereException("Changed in the partitioning method or partition key column(s)");
		
		List<X_AD_TablePartition> partitions = new ArrayList<X_AD_TablePartition>();
		String partitioningMethod = getPartitioningMethod();		
		if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List))
		{
			List<String> partitionKeyColumnNames = getPartitionKeyColumnNames();
			String partitionKeyColumnsString = getPartitionKeyColumnNamesAsString();
			String nameColumn = "'" + getTableName().toLowerCase() + "_' || " + partitionKeyColumnsString.replaceAll(",", " || '_' || ");
			String expressionColumn = "'FOR VALUES IN (''' || " + partitionKeyColumnsString.replaceAll(",", " || ''',''' || ") + " || ''')'";
			
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT DISTINCT ").append(nameColumn).append(" AS name, ");
			sql.append(expressionColumn).append(" AS expression, ");
			sql.append(partitionKeyColumnsString).append(" ");
			sql.append("FROM ").append(getDefaultPartitionName()).append(" ");
			sql.append("ORDER BY ").append(partitionKeyColumnsString);
			
			HashMap<String, List<Object>> columnValues = new HashMap<String, List<Object>>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql.toString(), getTrxName());
				rs = pstmt.executeQuery();
				while (rs.next()) 
				{
					String name = rs.getString("name");
					String expression = rs.getString("expression");
					
					List<Object> values = new ArrayList<Object>();					
					for (String partitionKeyColumnName : partitionKeyColumnNames)
						values.add(rs.getObject(partitionKeyColumnName));
					columnValues.put(name, values);
					
					partitions.add(createTablePartition(name, expression));
				}
			}
			catch (SQLException e)
			{
				throw new DBException(e);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
			
			if (!partitions.isEmpty())
			{
				List<MColumn> partitionKeyColumns = getPartitionKeyColumns();
				for (X_AD_TablePartition partition : partitions)
				{
					List<Object> values = columnValues.get(partition.getName());
					
					StringBuilder createStmt = new StringBuilder();
					createStmt.append("CREATE TABLE " + partition.getName() + " (LIKE ");
					createStmt.append(getDefaultPartitionName() + " INCLUDING ALL)");
					int no = DB.executeUpdateEx(createStmt.toString(), getTrxName());
					addLog(no + " " + createStmt.toString());
					
					StringBuilder updateStmt = new StringBuilder();
					updateStmt.append("WITH x AS ( ");
					updateStmt.append("DELETE FROM ").append(getDefaultPartitionName()).append(" ");
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
					no = DB.executeUpdateEx(updateStmt.toString(), getTrxName());
					addLog(no + " " + updateStmt.toString());
					
					StringBuilder alterStmt = new StringBuilder();
					alterStmt.append("ALTER TABLE " + getTableName() + " ");
					alterStmt.append("ATTACH PARTITION " + partition.getName() + " " + partition.getExpressionPartition());
					no = DB.executeUpdateEx(alterStmt.toString(), getTrxName());
					addLog(no + " " + alterStmt.toString());
					
					isUpdated = true;
				}
			}
		}
		else if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_Range))
		{
			List<RangeTablePartition> rangeTablePartitions = new ArrayList<RangeTablePartition>();
			List<String> partitionKeyColumnNames = getPartitionKeyColumnNames();
			List<String> partitionKeyColumnRangeIntervalPatterns = getPartitionKeyColumnRangeIntervalPatterns();
			if (partitionKeyColumnNames.size() != partitionKeyColumnRangeIntervalPatterns.size())
				throw new AdempiereException("Number of partition key columns and number of range partition interval must be matched");

			for (int x = 0; x < partitionKeyColumnNames.size(); x++)
			{
				String partitionKeyColumnName = partitionKeyColumnNames.get(x);
				String partitionKeyColumnRangeIntervalPattern = partitionKeyColumnRangeIntervalPatterns.get(x);
				
				StringBuilder sql = new StringBuilder();
				sql.append("SELECT MIN(").append(partitionKeyColumnName).append(") AS min_value, ");
				sql.append("MAX(").append(partitionKeyColumnName).append(") AS max_value ");
				sql.append("FROM ").append(getDefaultPartitionName());
				
				List<Object> values = DB.getSQLValueObjectsEx(getTrxName(), sql.toString());
				if (values.get(0) != null && values.get(1) != null)
				{
					rangeTablePartitions.add(new RangeTablePartition(
							partitionKeyColumnName, partitionKeyColumnRangeIntervalPattern, 
							values.get(0), values.get(1)
					));
				}
			}
			
			if (rangeTablePartitions.isEmpty())
				return true;
			
			List<List<RangeTablePartitionVariable>> columnRangeTablePartitionVariables = new ArrayList<List<RangeTablePartitionVariable>>();
			Pattern pattern1 = Pattern.compile("(\\d+)\\s+year(?:s)?\\s+(\\d+)\\s+month(?:s)?");
			Pattern pattern2 = Pattern.compile("(\\d+)\\s+year(?:s)?");
			Pattern pattern3 = Pattern.compile("(\\d+)\\s+month(?:s)?");
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			List<MColumn> partitionKeyColumns = getPartitionKeyColumns();
			List<String> tablePartitionNames = getTablePartitionNames();
			for (int x = 0; x < partitionKeyColumnNames.size(); x++)
			{
				List<RangeTablePartitionVariable> rangeTablePartitionVariables = new ArrayList<RangeTablePartitionVariable>();

				MColumn partitionKeyColumn = partitionKeyColumns.get(x);
				RangeTablePartition rangeTablePartition = rangeTablePartitions.get(x);
				if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
				{
					int years = 0;
					int months = 0;
					Matcher matcher = pattern1.matcher(rangeTablePartition.getIntervalPattern());
					if (matcher.matches())
					{
						years = Integer.parseInt(matcher.group(1));
						months = Integer.parseInt(matcher.group(2));
					}
					else
					{
						matcher = pattern2.matcher(rangeTablePartition.getIntervalPattern());
						if (matcher.matches())
							years = Integer.parseInt(matcher.group(1));
						else
						{
							matcher = pattern3.matcher(rangeTablePartition.getIntervalPattern());
							if (matcher.matches())
								months = Integer.parseInt(matcher.group(1));
						}
					}
					
					if (years < 0 || months < 0 || (years == 0 && months == 0))
						throw new IllegalArgumentException("Invalid range interval: " + years + " year(s) " + months + " month(s)");
					
					Timestamp minValue = (Timestamp) rangeTablePartition.getMinValue();
					Timestamp maxValue = (Timestamp) rangeTablePartition.getMaxValue();					
					
					Calendar cal = Calendar.getInstance();
					cal.setTimeInMillis(minValue.getTime());
					cal.set(cal.get(Calendar.YEAR), (months > 0) ? cal.get(Calendar.MONTH) : 0, 1);

					Calendar cal2 = Calendar.getInstance();
					cal2.setTimeInMillis(maxValue.getTime());

					while (cal.before(cal2))
					{
						String name = cal.get(Calendar.YEAR) + 
								(months > 0 ? (cal.get(Calendar.MONTH)+1) >=10 ? "_" + (cal.get(Calendar.MONTH)+1) 
										: "_0" + (cal.get(Calendar.MONTH)+1) : "");
						
						String from = dateFormat.format(cal.getTime());	
						cal.add(Calendar.YEAR, years);
						cal.add(Calendar.MONTH, months);			
						String to = dateFormat.format(cal.getTime());
						
						rangeTablePartitionVariables.add(new RangeTablePartitionVariable(name, "'" + from + "'", "'" + to + "'"));
					}
				}
				else if (DisplayType.isNumeric(partitionKeyColumn.getAD_Reference_ID()))
				{
					BigDecimal interval = new BigDecimal(rangeTablePartition.getIntervalPattern());
					if (interval.signum() <= 0)
						throw new IllegalArgumentException("Invalid range interval: " + interval);
					
					BigDecimal minValue = (BigDecimal) rangeTablePartition.getMinValue();
					BigDecimal maxValue = (BigDecimal) rangeTablePartition.getMaxValue();

					BigDecimal value = minValue.divide(interval);
					value.setScale(interval.scale(), RoundingMode.DOWN);
					
					while (value.compareTo(maxValue) <= 0)
					{
						String name = value.toString().replaceAll(".", "-");
						BigDecimal from = value;
						value = value.add(interval);
						BigDecimal to = value;
						
						rangeTablePartitionVariables.add(new RangeTablePartitionVariable(name, from, to));
					}
				}
				else
					throw new IllegalArgumentException("Range key column type not supported: " + partitionKeyColumn);
				
				columnRangeTablePartitionVariables.add(rangeTablePartitionVariables);
			}
			
			RangeTablePartitionCombinations allCombinations = generateCombinations(columnRangeTablePartitionVariables, 0);
			for (int x = 0; x < allCombinations.getNameCombinations().size(); x++) {
				List<Object> nameCombination = allCombinations.getNameCombinations().get(x);
				List<Object> fromCombination = allCombinations.getFromCombinations().get(x);
				List<Object> toCombination = allCombinations.getToCombinations().get(x);
				
				StringBuilder name = new StringBuilder();
				name.append(getTableName().toLowerCase() + "_");
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
					partitions.add(createTablePartition(name.toString(), expression.toString()));
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
					
					List<Object> fromCombination = allCombinations.getFromCombinations().get(i);
					List<Object> toCombination = allCombinations.getToCombinations().get(i);
					
					StringBuilder createStmt = new StringBuilder();
					createStmt.append("CREATE TABLE " + partition.getName() + " (LIKE ");
					createStmt.append(getDefaultPartitionName() + " INCLUDING ALL)");
					int no = DB.executeUpdateEx(createStmt.toString(), getTrxName());
					addLog(no + " " + createStmt.toString());
					
					StringBuilder updateStmt = new StringBuilder();
					updateStmt.append("WITH x AS ( ");
					updateStmt.append("DELETE FROM ").append(getDefaultPartitionName()).append(" ");
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
					no = DB.executeUpdateEx(updateStmt.toString(), getTrxName());
					addLog(no + " " + updateStmt.toString());
					
					StringBuilder alterStmt = new StringBuilder();
					alterStmt.append("ALTER TABLE " + getTableName() + " ");
					alterStmt.append("ATTACH PARTITION " + partition.getName() + " " + partition.getExpressionPartition());
					no = DB.executeUpdateEx(alterStmt.toString(), getTrxName());
					addLog(no + " " + alterStmt.toString());
					
					isUpdated = true;
				}
			}
		}
		else
			throw new IllegalArgumentException("Partitioning Method not supported: " + partitioningMethod);
		
		return true;
	}
	
	private RangeTablePartitionCombinations generateCombinations(List<List<RangeTablePartitionVariable>> variables, int currentIndex) {
		List<List<Object>> nameCombinations = new ArrayList<>();
		List<List<Object>> fromCombinations = new ArrayList<>();
		List<List<Object>> toCombinations = new ArrayList<>();
		RangeTablePartitionCombinations result = new RangeTablePartitionCombinations(nameCombinations, fromCombinations, toCombinations);

        if (currentIndex == variables.size()) {
        	result.getNameCombinations().add(new ArrayList<>());
        	result.getFromCombinations().add(new ArrayList<>());
        	result.getToCombinations().add(new ArrayList<>());
        } else {
            for (RangeTablePartitionVariable value : variables.get(currentIndex)) {
            	RangeTablePartitionCombinations subCombinations = generateCombinations(variables, currentIndex + 1);

                for (List<Object> subCombination : subCombinations.getNameCombinations()) {
                    List<Object> combination = new ArrayList<>();
                    combination.add(value.getName());
                    combination.addAll(subCombination);
                    result.getNameCombinations().add(combination);
                }
                
                for (List<Object> subCombination : subCombinations.getFromCombinations()) {
                    List<Object> combination = new ArrayList<>();
                    combination.add(value.getFrom());
                    combination.addAll(subCombination);
                    result.getFromCombinations().add(combination);
                }
                
                for (List<Object> subCombination : subCombinations.getToCombinations()) {
                    List<Object> combination = new ArrayList<>();
                    combination.add(value.getTo());
                    combination.addAll(subCombination);
                    result.getToCombinations().add(combination);
                }
            }
        }

        return result;
    }

	@Override
	public boolean runPostMigrationData() {
		if (isUpdated)
		{
			StringBuilder stmt = new StringBuilder();
			stmt.append("VACUUM ANALYZE " + getTableName());
			int no = DB.executeUpdateEx(stmt.toString(), getTrxName());
			addLog(no + " " + stmt.toString());
		}
		return true;
	}
	
	private boolean validateConfiguration() {		
		String currentPartitionKey = null;
		String partitioningMethod = getPartitioningMethod();		
		if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_List))
			currentPartitionKey = "LIST";
		else if (partitioningMethod.equals(MTable.PARTITIONINGMETHOD_Range))
			currentPartitionKey = "RANGE";
		currentPartitionKey += " (" + getPartitionKeyColumnNamesAsString().toLowerCase() + ")";
		currentPartitionKey = currentPartitionKey.replaceAll(",", ", ");
		
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT pg_get_partkeydef(oid) AS partition_key ");
		sql.append("FROM pg_class ");
		sql.append("WHERE relkind = 'p' ");
		sql.append("AND relname = LOWER(?)");
		String partitionKey = DB.getSQLValueStringEx(getTrxName(), sql.toString(), getTableName());
		
		return currentPartitionKey.equalsIgnoreCase(partitionKey);
	}
	
	class RangeTablePartition {
		private String columnName;
		private String intervalPattern;
		private Object minValue;
		private Object maxValue;
		
		public RangeTablePartition(String columnName, String intervalPattern, Object minValue, Object maxValue)
		{
			this.columnName = columnName;
			this.intervalPattern = intervalPattern;
			this.minValue = minValue;
			this.maxValue = maxValue;
		}

		public String getColumnName() {
			return columnName;
		}

		public String getIntervalPattern() {
			return intervalPattern;
		}

		public Object getMinValue() {
			return minValue;
		}

		public Object getMaxValue() {
			return maxValue;
		}
	}
	
	class RangeTablePartitionVariable {
		private String name;
		private Object from;
		private Object to;
		
		public RangeTablePartitionVariable(String name, Object from, Object to)
		{
			this.name = name;
			this.from = from;
			this.to = to;
		}

		public String getName() {
			return name;
		}

		public Object getFrom() {
			return from;
		}

		public Object getTo() {
			return to;
		}
	}
	
	class RangeTablePartitionCombinations {
		private List<List<Object>> nameCombinations;
		private List<List<Object>> fromCombinations;
		private List<List<Object>> toCombinations;
		
		public RangeTablePartitionCombinations(List<List<Object>> nameCombinations, List<List<Object>> fromCombinations, List<List<Object>> toCombinations)
		{
			this.nameCombinations = nameCombinations;
			this.fromCombinations = fromCombinations;
			this.toCombinations = toCombinations;
		}

		public List<List<Object>> getNameCombinations() {
			return nameCombinations;
		}

		public List<List<Object>> getFromCombinations() {
			return fromCombinations;
		}

		public List<List<Object>> getToCombinations() {
			return toCombinations;
		}
	}

}
