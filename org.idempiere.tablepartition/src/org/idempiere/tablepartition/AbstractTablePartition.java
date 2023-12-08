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
package org.idempiere.tablepartition;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.model.X_AD_TablePartition;
import org.compiere.process.ProcessInfo;
import org.compiere.util.Env;
import org.compiere.util.Trx;

public abstract class AbstractTablePartition implements ITablePartition {

	private MTable table;
	private ProcessInfo pi;
	private Trx trx;
	
	public AbstractTablePartition(MTable table, ProcessInfo pi)
	{
		this.table = table;
		this.pi = pi;
	}
	
	public boolean runProcess()
	{
		boolean isError = false;
		String trxName = Trx.createTrxName("TablePartition-");
		trx = Trx.get(trxName, true);
		trx.setDisplayName(getClass().getName()+"_runProcess");
		
		try 
		{
			addLog("DB Table Name: " + table.getTableName());
			
			List<MColumn> partitionKeyColumns = getPartitionKeyColumns();
			if (partitionKeyColumns.isEmpty())
				throw new AdempiereException("At least one partition key column is required");
			
			if (!isPartitionedTable())
			{
				if (!renameOriginalTable())
					throw new AdempiereException("Failed to rename original table");
				
				if (!createPartitionedTable())
					throw new AdempiereException("Failed to create partitioned table");
				trx.commit();
			}
				
			if (!migrateDBContrainsts())
				throw new AdempiereException("Failed to migrate database contrainsts");
			trx.commit();
			
			if (!migrateDBIndexes())
				throw new AdempiereException("Failed to migrate database indexes");
			trx.commit();
				
			if (!attachToDefaultPartition())
				throw new AdempiereException("Failed to attach to default partition");
			trx.commit();
			
			if (!migrateData())
				throw new AdempiereException("Failed to migrate data");
			
		}
		catch (Exception e)
		{
			isError = true;
			addLog("ERROR: " + e.getLocalizedMessage());
			trx.rollback();
		}
		finally
		{
			trx.commit();
			trx.close();
			trx = null;
		}
		
		if (!isError && !runPostMigrationData())
		{
			isError = true;
			addLog("ERROR: Failed to run post migration data");
		}
		
		return !isError;
	}
	
	protected void addLog(String msg)
	{
		if (pi != null && msg != null)
			pi.addLog(0, null, null, msg);
	}
	
	protected String getTableName()
	{
		if (table != null)
			return table.getTableName();
		return null;
	}
	
	protected String getPartitioningMethod()
	{
		if (table != null)
			return table.getPartitioningMethod();
		return null;
	}
	
	protected Properties getCtx()
	{
		if (table != null)
			return table.getCtx();
		return Env.getCtx();
	}
	
	protected String getTrxName()
	{
		if (trx != null)
			return trx.getTrxName();
		if (table != null)
			return table.get_TrxName();
		return null;
	}
	
	protected String getDefaultPartitionName()
	{
		if (table != null)
			return table.getTableName() + "_default_partition";
		return null;
	}
	
	private List<MColumn> partitionKeyColumns;
	protected List<MColumn> getPartitionKeyColumns()
	{
		if (partitionKeyColumns == null) {
			String whereClause = MColumn.COLUMNNAME_AD_Table_ID + "=? AND " + MColumn.COLUMNNAME_IsPartitionKey + "='Y'";
			partitionKeyColumns = new Query(getCtx(), MColumn.Table_Name, whereClause, getTrxName())
					.setParameters(table.getAD_Table_ID())
					.setOnlyActiveRecords(true)
					.setOrderBy(MColumn.COLUMNNAME_SeqNoPartition)
					.list();
		}
		return partitionKeyColumns;
	}
	
	private List<String> partitionKeyColumnNames;
	private String partitionKeyColumnNamesAsString;
	protected String getPartitionKeyColumnNamesAsString()
	{
		if (partitionKeyColumnNamesAsString == null) {
			partitionKeyColumnNames = new ArrayList<String>();
			
			List<MColumn> keyColumns = getPartitionKeyColumns();
			StringBuilder keyColumnsString = new StringBuilder();
			int columnCount = 0;
			for (MColumn keyColumn : keyColumns) 
			{
				if (columnCount > 0)
					keyColumnsString.append(",");
				keyColumnsString.append(keyColumn.getColumnName());			
				partitionKeyColumnNames.add(keyColumn.getColumnName());
				++columnCount;
			}
			partitionKeyColumnNamesAsString = keyColumnsString.toString();
		}
		return partitionKeyColumnNamesAsString;
	}
	
	protected List<String> getPartitionKeyColumnNames()
	{
		if (partitionKeyColumnNames == null) {
			partitionKeyColumnNames = new ArrayList<String>();
			
			List<MColumn> keyColumns = getPartitionKeyColumns();
			StringBuilder keyColumnsString = new StringBuilder();
			int columnCount = 0;
			for (MColumn keyColumn : keyColumns) 
			{
				if (columnCount > 0)
					keyColumnsString.append(",");
				keyColumnsString.append(keyColumn.getColumnName());			
				partitionKeyColumnNames.add(keyColumn.getColumnName());
				++columnCount;
			}
			partitionKeyColumnNamesAsString = keyColumnsString.toString();
		}
		return partitionKeyColumnNames;
	}
	
	private List<String> partitionKeyColumnRangeIntervalPatterns;
	protected List<String> getPartitionKeyColumnRangeIntervalPatterns()
	{
		if (partitionKeyColumnRangeIntervalPatterns == null) {
			partitionKeyColumnRangeIntervalPatterns = new ArrayList<String>();
			if (table != null) {
				StringTokenizer st = new StringTokenizer(table.getRangePartitionInterval(), ",");
				while (st.hasMoreTokens()) 
					partitionKeyColumnRangeIntervalPatterns.add(st.nextToken().trim());					
			}
		}
		return partitionKeyColumnRangeIntervalPatterns;
	}
	
	private List<X_AD_TablePartition> tablePartitions;
	protected List<X_AD_TablePartition> getTablePartitions()
	{
		if (tablePartitions == null)
			tablePartitions = new Query(getCtx(), X_AD_TablePartition.Table_Name, X_AD_TablePartition.COLUMNNAME_AD_Table_ID + "=?", getTrxName())
					.setParameters(table.getAD_Table_ID())
					.setOnlyActiveRecords(true)
					.setOrderBy(X_AD_TablePartition.COLUMNNAME_Name)
					.list();
		return tablePartitions;
	}
	
	private List<String> tablePartitionNames;
	protected List<String> getTablePartitionNames()
	{
		if (tablePartitionNames == null) {
			tablePartitionNames = new ArrayList<String>();
			
			List<X_AD_TablePartition> partitions = getTablePartitions();
			for (X_AD_TablePartition partition : partitions)
				tablePartitionNames.add(partition.getName());
		}
		return tablePartitionNames;
	}
	
	protected X_AD_TablePartition createTablePartition(String name, String expression)
	{
		X_AD_TablePartition partition = new X_AD_TablePartition(getCtx(), 0, getTrxName());
		partition.setAD_Table_ID(table.getAD_Table_ID());
		partition.setName(name);
		partition.setExpressionPartition(expression);
		partition.saveEx();
		return partition;
	}
}
