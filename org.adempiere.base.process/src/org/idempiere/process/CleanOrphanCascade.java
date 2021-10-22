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
import org.compiere.model.MTree_Base;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_UUID_Map;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;

/**
 *	IDEMPIERE-2395
 * 	@author 	Carlos Ruiz - globalqss
 */
@org.adempiere.base.annotation.Process
public class CleanOrphanCascade extends SvrProcess
{

	private boolean p_IsCleanChangeLog;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		for (ProcessInfoParameter para : getParameter())
		{
			String name = para.getParameterName();
			if ("IsCleanChangeLog".equals(name)) {
				p_IsCleanChangeLog  = para.getParameterAsBoolean();
			} else {
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
			}
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

		ValueNamePair[] treeTables = new ValueNamePair[] {
				new ValueNamePair("AD_TreeBar", "AD_Menu"),
				new ValueNamePair("AD_TreeNodeBP", "C_BPartner"),
				new ValueNamePair("AD_TreeNodeCMC", "CM_Container"),
				new ValueNamePair("AD_TreeNodeCMM", "CM_Media"),
				new ValueNamePair("AD_TreeNodeCMS", "CM_CStage"),
				new ValueNamePair("AD_TreeNodeCMT", "CM_Template"),
				new ValueNamePair("AD_TreeNodeMM", "AD_Menu"),
				new ValueNamePair("AD_TreeNodePR", "M_Product"),
				new ValueNamePair("AD_TreeNodeU1", "C_ElementValue"),
				new ValueNamePair("AD_TreeNodeU2", "C_ElementValue"),
				new ValueNamePair("AD_TreeNodeU3", "C_ElementValue"),
				new ValueNamePair("AD_TreeNodeU4", "C_ElementValue")
		};
		for (ValueNamePair vnp : treeTables) {
			String treeTable = vnp.getValue();
			String foreignTable = vnp.getName();
			delTree(treeTable,foreignTable, "Node_ID", 0);
			if (! "AD_TreeBar".equalsIgnoreCase(treeTable)) {
				delTree(treeTable,foreignTable, "Parent_ID", 0);
			}
		}

		List<MTree_Base> trees = new Query(getCtx(), MTree_Base.Table_Name, null, get_TrxName()).list();
		String treeTable = "AD_TreeNode";
		for (MTree_Base tree : trees) {
			String foreignTable = tree.getSourceTableName(true);
			delTree(treeTable,foreignTable, "Parent_ID", tree.getAD_Tree_ID());
		}

		String whereTables = ""
				+ "    IsView = 'N' "
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
		if (! p_IsCleanChangeLog) {
			whereTables += " AND TableName != 'AD_ChangeLog'";
		}

		List<MTable> tables = new Query(getCtx(), "AD_Table", whereTables, get_TrxName())
				.setOnlyActiveRecords(true)
				.setOrderBy("TableName")
				.list();
		tables.add(MTable.get(getCtx(), X_AD_Package_UUID_Map.Table_Name));
		for (MTable table : tables) {
			String tableName = table.getTableName();
			boolean isUUIDMap = X_AD_Package_UUID_Map.Table_Name.equals(tableName);

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
					StringBuilder whereClause = new StringBuilder();
					whereClause.append("AD_Table_ID = ").append(refTableID);
					if (refTable.getKeyColumns().length != 1 && !isUUIDMap) {
						log.warning("Wrong reference for table " + tableName + " -> " + refTableName);
						whereClause.append(" AND Record_ID>0");
					} else {
						String colRef = refTable.getKeyColumns()[0];
						if (isUUIDMap) {
							colRef = MTable.getUUIDColumnName(refTable.getTableName());
						}
						
						whereClause.append(" AND NOT EXISTS (SELECT ").append(colRef);
						whereClause.append("                FROM   ").append(refTableName).append(" ");
						whereClause.append("                WHERE  ").append(refTableName).append(".").append(colRef).append(" = ").append(tableName);
						if (isUUIDMap) {
							whereClause.append(".Target_UUID)");
						} else {
							whereClause.append(".Record_ID)");
						}
					}

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

	private void delTree(String treeTable, String foreignTable, String columnName, int treeId) {
		StringBuilder sqlDelete = new StringBuilder()
				.append("DELETE FROM ").append(treeTable)
				.append(" WHERE ").append(columnName).append(">0 AND ")
				.append(columnName).append(" NOT IN (SELECT ").append(foreignTable).append("_ID FROM ").append(foreignTable).append(")");
		if (treeId > 0) {
			sqlDelete.append(" AND AD_Tree_ID=").append(treeId);
		}
		int noDel = DB.executeUpdateEx(sqlDelete.toString(), get_TrxName());
		if (noDel > 0) {
			addLog(Msg.parseTranslation(getCtx(), noDel + " " + treeTable + " " + "@Deleted@ -> " + foreignTable
					+ (treeId > 0 ? " Tree=" + treeId: "" )));
		}
	}	//	delTree

}	//	CleanOrphanCascade
