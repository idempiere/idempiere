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
package org.idempiere.tablepartition.process;

import org.compiere.db.partition.ITablePartitionService;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_TablePartition;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;

@org.adempiere.base.annotation.Process
public class ChangePartitionStatus extends SvrProcess {

	private int p_record_ID = 0;
	private MTable table = null;
	
	@Override
	protected void prepare() {
		p_record_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception {
		ITablePartitionService service = DB.getDatabase().getTablePartitionService();
		if (service == null) {
			return "@Error@ " + Msg.getMsg(getCtx(), "DBAdapterNoTablePartitionSupport");
		}
		
		if (p_record_ID <= 0)
			return "@Error@ " + Msg.getMsg(getCtx(), "FillMandatory", new Object[]{"Record ID"});
			
		X_AD_TablePartition partition = new X_AD_TablePartition(Env.getCtx(), p_record_ID, get_TrxName());
		if (partition.get_ID() != p_record_ID)
			return "@Error@ " + Msg.getMsg(getCtx(), "FillMandatory", new Object[]{"Record ID"});
		
		table = new MTable(Env.getCtx(), partition.getAD_Table_ID(), get_TrxName());
		if (partition.isPartitionAttached())
			return detachPartition(partition, service);
		else			
			return reattachPartition(partition, service);
	}

	private String reattachPartition(X_AD_TablePartition partition, ITablePartitionService service) {
		String partitionName = partition.getName();
		service.reattachPartition(table, partition, get_TrxName(), getProcessInfo());
		return Msg.getMsg(getCtx(), "PartitionReAttachToTable", new Object[] {partitionName, table.getTableName()});
	}

	private String detachPartition(X_AD_TablePartition partition, ITablePartitionService service) {
		String partitionName = partition.getName();
		service.detachPartition(table, partition, get_TrxName(), getProcessInfo());		
		return Msg.getMsg(getCtx(), "PartitionDetachFromTable", new Object[] {partitionName, table.getTableName()});
	}

	@Override
	protected void postProcess(boolean success) {
		if (success) {
			ITablePartitionService service = DB.getDatabase().getTablePartitionService();
			if (service != null) {
				service.runPostPartitionProcess(table, null, getProcessInfo());				
			}
		}
	}

	
}
