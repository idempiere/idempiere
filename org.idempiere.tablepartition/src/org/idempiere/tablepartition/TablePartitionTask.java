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

import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.db.partition.ITablePartitionService;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

/**
 * Create/update table partition task
 */
public class TablePartitionTask {

	private MTable table;
	private ProcessInfo pi;
	private Trx trx;
	private ITablePartitionService partitionService;
	private CLogger log = CLogger.getCLogger (getClass());
	
	/**
	 * @param table
	 * @param pi
	 * @param partitionService
	 */
	public TablePartitionTask(MTable table, ProcessInfo pi, ITablePartitionService partitionService)
	{
		this.table = table;
		this.pi = pi;
		this.partitionService = partitionService; 
	}
	
	/**
	 * Execute create/update table partition task
	 * @return true if success
	 */
	public boolean executeTask()
	{
		boolean isError = false;
		boolean isUpdated = false;
		String trxName = Trx.createTrxName("TablePartition-");
		trx = Trx.get(trxName, true);
		trx.setDisplayName(getClass().getName()+"_runProcess");
		
		try 
		{
			table.set_TrxName(trxName);
			addLog(Msg.getElement(Env.getCtx(), "TableName") + ": " + table.getTableName());
			
			List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(true);
			if (partitionKeyColumns.isEmpty())
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PartitionKeyRequired"));
			
			if (!isPartitionedTable())
			{
				if (!createPartitionedTable())
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FailedCreatePartitionedTable"));
			}
				
			isUpdated = addPartitionAndMigrateData();
		
			trx.commit();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, e.getMessage(), e);
			isError = true;
			addLog(Msg.getMsg(Env.getCtx(), "Error") + e.getLocalizedMessage());
			trx.rollback();			
		}
		finally
		{			
			trx.close();
			trx = null;
		}
		
		if (!isError && isUpdated && !runPostPartitionProcess())
		{
			isError = true;
			addLog(Msg.getMsg(Env.getCtx(), "FailedRunPostMigrationData"));
		}
		
		if (isUpdated)
			table.getTablePartitions(true, trxName);
		
		return !isError;
	}
	
	/**
	 * Add process log
	 * @param msg
	 */
	private void addLog(String msg)
	{
		if (pi != null && msg != null)
			pi.addLog(0, null, null, msg);
	}

	/**
	 * @return transaction name
	 */
	private String getTrxName()
	{
		if (trx != null)
			return trx.getTrxName();
		return null;
	}
	
	private boolean isPartitionedTable() {
		return partitionService.isPartitionedTable(table, getTrxName());
	}

	private boolean createPartitionedTable() {
		return partitionService.createPartitionedTable(table, getTrxName(), pi);
	}

	private boolean addPartitionAndMigrateData() {
		return partitionService.addPartitionAndMigrateData(table, getTrxName(), pi);
	}

	private boolean runPostPartitionProcess() {
		return partitionService.runPostPartitionProcess(table, getTrxName(), pi);
	}	
}
