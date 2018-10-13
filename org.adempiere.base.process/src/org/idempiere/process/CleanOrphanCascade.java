/**********************************************************************
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
* - Carlos Ruiz                                                       *
**********************************************************************/
package org.idempiere.process;

import java.math.BigDecimal;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MArchive;
import org.compiere.model.MAttachment;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Msg;

/**
 *	IDEMPIERE-2395
 * 	@author 	Carlos Ruiz - globalqss
 */
public class CleanOrphanCascade extends SvrProcess
{

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		for (ProcessInfoParameter para : getParameter())
		{
			String name = para.getParameterName();
			log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("");

		String whereTables = ""
				+ "    IsView = 'N' "
				+ "AND TableName != 'AD_ChangeLog' "
				+ "AND EXISTS (SELECT 1 "
				+ "            FROM   AD_Column ct "
				+ "            WHERE  ct.IsActive='Y' AND ct.AD_Table_ID = AD_Table.AD_Table_ID "
				+ "                   AND ct.ColumnName = 'AD_Table_ID') "
				+ "AND EXISTS (SELECT 1 "
				+ "            FROM   AD_Column cr "
				+ "            WHERE  cr.IsActive='Y' AND cr.AD_Table_ID = AD_Table.AD_Table_ID "
				+ "                   AND cr.ColumnName = 'Record_ID') "
				+ "AND EXISTS (SELECT 1 "
				+ "            FROM   AD_Column ck "
				+ "            WHERE  ck.IsActive='Y' AND ck.AD_Table_ID = AD_Table.AD_Table_ID "
				+ "                   AND ck.ColumnName = AD_Table.TableName || '_ID')";

		List<MTable> tables = new Query(getCtx(), "AD_Table", whereTables, get_TrxName())
				.setOnlyActiveRecords(true)
				.setOrderBy("TableName")
				.list();
		for (MTable table : tables) {
			String tableName = table.getTableName();

			StringBuilder sqlRef = new StringBuilder();
			sqlRef.append("SELECT DISTINCT t.AD_Table_ID, ");
			sqlRef.append("                t.TableName ");
			sqlRef.append("FROM   ").append(tableName).append(" r ");
			sqlRef.append("       JOIN AD_Table t ON ( r.AD_Table_ID = t.AD_Table_ID ) ");
			sqlRef.append("ORDER  BY t.Tablename");
			List<List<Object>> rowTables = DB.getSQLArrayObjectsEx(get_TrxName(), sqlRef.toString());
			if (rowTables != null) {
				for (List<Object> row : rowTables) {
					int refTableID = ((BigDecimal) row.get(0)).intValue();
					String refTableName = row.get(1).toString();

					MTable refTable = MTable.get(getCtx(), refTableID);
					if (refTable.getKeyColumns().length != 1) {
						log.warning("Wrong reference for table " + tableName + " -> " + refTableName);
						continue;
					}
					String colRef = refTable.getKeyColumns()[0];
					
					StringBuilder whereClause = new StringBuilder();
					whereClause.append("AD_Table_ID = ").append(refTableID);
					whereClause.append(" AND NOT EXISTS (SELECT ").append(colRef);
					whereClause.append("                FROM   ").append(refTableName).append(" ");
					whereClause.append("                WHERE  ").append(refTableName).append(".").append(colRef).append(" = ").append(tableName).append(".Record_ID)");

					int noDel = 0;
					if (MAttachment.Table_Name.equals(tableName)) {
						// special case for attachment because of store
						List<MAttachment> attachments = new Query(getCtx(), tableName, whereClause.toString(), get_TrxName()).list();
						for (MAttachment attachment : attachments) {
							attachment.deleteEx(true, get_TrxName());
							noDel++;
						}
					} else if (MArchive.Table_Name.equals(tableName)) {
						// special case for archive because of store
						List<MArchive> archives = new Query(getCtx(), tableName, whereClause.toString(), get_TrxName()).list();
						for (MArchive archive : archives) {
							archive.deleteEx(true, get_TrxName());
							noDel++;
						}
					} else {
						StringBuilder sqlDelete = new StringBuilder();
						sqlDelete.append("DELETE FROM ").append(tableName).append(" WHERE ").append(whereClause);
						noDel = DB.executeUpdateEx(sqlDelete.toString(), get_TrxName());
					}
					if (noDel > 0) {
						addLog(Msg.parseTranslation(getCtx(), noDel + " " + tableName + " " + "@Deleted@ -> " + refTableName));
					}
				}

			}
		}

		return "@OK@";
	}	//	doIt

}	//	CleanOrphanCascade
