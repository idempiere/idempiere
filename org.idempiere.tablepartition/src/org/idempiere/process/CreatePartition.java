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
package org.idempiere.process;

import java.util.List;

import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.idempiere.tablepartition.ITablePartition;
import org.idempiere.tablepartition.impl.TablePartition_Oracle;
import org.idempiere.tablepartition.impl.TablePartition_PostgreSQL;

@org.adempiere.base.annotation.Process
public class CreatePartition extends SvrProcess {

	private int p_record_ID = 0;
	
	@Override
	protected void prepare() {
		p_record_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception {
		int successCount = 0;
		int errorCount = 0;
		if (p_record_ID > 0)
		{
			MTable table = MTable.get(p_record_ID);
			ITablePartition tp = getTablePartition(table);
			boolean success = tp.runProcess();
			if (success)
				++successCount;
			else
				++errorCount;
		}
		else
		{
			List<MTable> tables = new Query(getCtx(), MTable.Table_Name, MTable.COLUMNNAME_IsPartition + "='Y'", get_TrxName())
					.setOnlyActiveRecords(true)
					.setOrderBy(MTable.COLUMNNAME_TableName)
					.list();
			for (MTable table : tables) 
			{
				ITablePartition tp = getTablePartition(table);
				boolean success = tp.runProcess();
				if (success)
					++successCount;
				else
					++errorCount;
			}
		}
		
		return "Updated: " + successCount + ", Error: " + errorCount;
	}
	
	private ITablePartition getTablePartition(MTable table) {
		if (DB.isPostgreSQL())
			return new TablePartition_PostgreSQL(table, getProcessInfo());
		return new TablePartition_Oracle(table, getProcessInfo());
	}
}