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
package org.idempiere.tablepartition.process;

import java.util.List;

import org.compiere.db.partition.ITablePartitionService;
import org.compiere.model.MColumn;
import org.compiere.model.MProcessPara;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.tablepartition.TablePartitionTask;

@org.adempiere.base.annotation.Process
public class CreatePartition extends SvrProcess {

	private int p_record_ID = 0;
	private String p_partitioningMethod = null;
	private String p_tableName = null;
	
	@Override
	protected void prepare() {
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("PartitioningMethod"))
				p_partitioningMethod = para[i].getParameterAsString();
			else if (name.equals("TableName"))
				p_tableName = para[i].getParameterAsString();
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
		}
		p_record_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception {
		ITablePartitionService service = DB.getDatabase().getTablePartitionService();
		if (service == null) {
			return "@Error@ " + Msg.getMsg(getCtx(), "DBAdapterNoTablePartitionSupport");
		}
		
		int successCount = 0;
		int errorCount = 0;
		if (p_record_ID > 0)
		{
			MTable table = new MTable(Env.getCtx(), p_record_ID, null);
			TablePartitionTask tp = new TablePartitionTask(table, getProcessInfo(), service);
			boolean success = tp.executeTask();
			if (success)
				++successCount;
			else
				++errorCount;
		}
		else
		{
			String whereClause = MTable.COLUMNNAME_IsPartition + "='Y' AND " + MTable.COLUMNNAME_IsView + "='N'";
			if (p_tableName != null)
				whereClause += " AND " + MTable.COLUMNNAME_TableName + " LIKE '" + p_tableName + "'";
			List<MTable> tables = new Query(getCtx(), MTable.Table_Name, whereClause, null)
					.setOnlyActiveRecords(true)
					.setOrderBy(MTable.COLUMNNAME_TableName)
					.list();
			for (MTable table : tables) 
			{
				List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns(true);
				if (partitionKeyColumns.isEmpty())
					continue;
				if (p_partitioningMethod != null)
				{
					if (!p_partitioningMethod.equals(partitionKeyColumns.get(0).getPartitioningMethod()))
						continue;
				}
				TablePartitionTask tp = new TablePartitionTask(table, getProcessInfo(), service);
				boolean success = tp.executeTask();
				if (success)
					++successCount;
				else
					++errorCount;
			}
		}
		
		return Msg.getMsg(Env.getCtx(), "Updated") + ": " + successCount + ", " + Msg.getMsg(Env.getCtx(), "Error") + errorCount;
	}	
}