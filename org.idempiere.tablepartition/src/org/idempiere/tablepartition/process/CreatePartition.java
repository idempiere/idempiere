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
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.tablepartition.TablePartitionTask;

@org.adempiere.base.annotation.Process
public class CreatePartition extends SvrProcess {

	private int p_record_ID = 0;
	
	@Override
	protected void prepare() {
		p_record_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception {
		ITablePartitionService service = DB.getDatabase().getTablePartitionService();
		if (service == null) {
			return "@Error@ Database adapter doesn't has table partition support";
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
			List<MTable> tables = new Query(getCtx(), MTable.Table_Name, MTable.COLUMNNAME_IsPartition + "='Y'", null)
					.setOnlyActiveRecords(true)
					.setOrderBy(MTable.COLUMNNAME_TableName)
					.list();
			for (MTable table : tables) 
			{
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