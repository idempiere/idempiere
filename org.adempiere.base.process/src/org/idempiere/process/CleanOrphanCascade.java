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

import org.compiere.model.MColumn;
import org.compiere.model.MProcessPara;
import org.compiere.model.MTable;
import org.compiere.model.MTree_Base;
import org.compiere.model.PO;
import org.compiere.model.Query;
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

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		for (ProcessInfoParameter para : getParameter())
		{
			MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para);
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
		delTree("AD_Tree_Favorite_Node", "AD_Tree_Favorite_Node", "Parent_ID", 0);

		List<MTree_Base> trees = new Query(getCtx(), MTree_Base.Table_Name, null, get_TrxName()).list();
		String treeTable = "AD_TreeNode";
		for (MTree_Base tree : trees) {
			String foreignTable = tree.getSourceTableName(true);
			delTree(treeTable,foreignTable, "Parent_ID", tree.getAD_Tree_ID());
		}

		// get tables with column Record_ID and/or Record_UU
		String whereTables = ""
				+ "    IsView = 'N' "
				+ "AND EXISTS (SELECT 1 "
				+ "            FROM   AD_Column ct "
				+ "            WHERE  ct.IsActive='Y' AND ct.AD_Table_ID = AD_Table.AD_Table_ID "
				+ "                   AND ct.ColumnName = 'AD_Table_ID') "
				+ "AND EXISTS (SELECT 1 "
				+ "            FROM   AD_Column cr "
				+ "            WHERE  cr.IsActive='Y' AND cr.AD_Table_ID = AD_Table.AD_Table_ID "
				+ "                   AND (cr.ColumnName = 'Record_ID' OR cr.ColumnName = 'Record_UU'))";

		List<MTable> tables = new Query(getCtx(), "AD_Table", whereTables, get_TrxName())
				.setOnlyActiveRecords(true)
				.setOrderBy("TableName")
				.list();
		for (MTable table : tables) {
			String tableName = table.getTableName();
			if (tableName.startsWith("T_")) // ignore T_ temporary tables
				continue;

			MColumn colRecordID = MColumn.get(getCtx(), tableName, "Record_ID", get_TrxName());
			MColumn colRecordUU = MColumn.get(getCtx(), tableName, "Record_UU", get_TrxName());

			// get the tables referenced within the Record_ID/UU table
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
					String colRef = refTable.getKeyColumns()[0];
					String colRefUU = PO.getUUIDColumnName(refTableName);

					if (colRecordID != null && refTable.isIDKeyTable()) {
						StringBuilder whereClause = new StringBuilder("AD_Table_ID=").append(refTableID)
								.append(" AND Record_ID>0")
								.append(" AND NOT EXISTS (SELECT ").append(colRef)
								.append("                FROM   ").append(refTableName).append(" ")
								.append("                WHERE  ").append(refTableName).append(".").append(colRef).append(" = ").append(tableName).append(".Record_ID)");
						int noDeleted = 0;
						int noSetNull = 0;
						int noIgnored = 0;
						List<PO> poList = new Query(getCtx(), tableName, whereClause.toString(), get_TrxName()).list();
						for (PO po : poList) {
							if (MColumn.FKCONSTRAINTTYPE_ModelCascade.equals(colRecordID.getFKConstraintType())) {
								po.deleteEx(true, get_TrxName());
								noDeleted++;
							} else if (MColumn.FKCONSTRAINTTYPE_ModelSetNull.equals(colRecordID.getFKConstraintType())) {
								if (colRecordID.isMandatory())
									po.set_ValueOfColumn("Record_ID", 0);
								else
									po.set_ValueOfColumn("Record_ID", null);
								po.saveEx(get_TrxName());
								noSetNull++;
							} else {
								noIgnored++;
							}
						}
						if (noDeleted > 0 || noSetNull > 0 || noIgnored > 0) {
							addLog(Msg.parseTranslation(getCtx(), tableName + ".Record_ID: " + noIgnored + " @Ignored@ / " + noDeleted + " @Deleted@ / " + noSetNull + " @Reset@ -> " + refTableName));
						}
					}

					if (colRecordUU != null) {
						StringBuilder whereClause = new StringBuilder("AD_Table_ID=").append(refTableID)
								.append(" AND Record_UU IS NOT NULL")
								.append(" AND NOT EXISTS (SELECT ").append(colRefUU)
								.append("                FROM   ").append(refTableName).append(" ")
								.append("                WHERE  ").append(refTableName).append(".").append(colRefUU).append(" = ").append(tableName).append(".Record_UU)");
						int noDeleted = 0;
						int noSetNull = 0;
						int noIgnored = 0;
						List<PO> poList = new Query(getCtx(), tableName, whereClause.toString(), get_TrxName()).list();
						for (PO po : poList) {
							if (MColumn.FKCONSTRAINTTYPE_ModelCascade.equals(colRecordUU.getFKConstraintType())) {
								po.deleteEx(true, get_TrxName());
								noDeleted++;
							} else if (MColumn.FKCONSTRAINTTYPE_ModelSetNull.equals(colRecordUU.getFKConstraintType())) {
								if (colRecordUU.isMandatory())
									po.set_ValueOfColumn("Record_UU", "");
								else
									po.set_ValueOfColumn("Record_UU", null);
								po.saveEx(get_TrxName());
								noSetNull++;
							} else {
								noIgnored++;
							}
						}
						if (noDeleted > 0 || noSetNull > 0 || noIgnored > 0) {
							addLog(Msg.parseTranslation(getCtx(), tableName + ".Record_UU: " + noIgnored + " @Ignored@ / " + noDeleted + " @Deleted@ / " + noSetNull + " @Reset@ -> " + refTableName));
						}
					}

				}

			}
		}

		return "@OK@";
	}	//	doIt

	private void delTree(String treeTable, String foreignTable, String columnName, int treeId) {
		String whereClause = columnName + ">0 AND  " + columnName + " NOT IN (SELECT " + foreignTable + "_ID FROM " + foreignTable + ")";
		if(treeId > 0)
			whereClause += " AND AD_Tree_ID=" + treeId;
		List<PO> poList = new Query(getCtx(), treeTable, whereClause, get_TrxName()).list();
		
		int noDel = 0;
		for(PO po : poList) {
			po.deleteEx(true, get_TrxName());
			noDel++;
		}
		if (noDel > 0) {
			addLog(Msg.parseTranslation(getCtx(), treeTable + ": " + noDel + " @Deleted@ -> " + foreignTable + (treeId > 0 ? " Tree=" + treeId: "" )));
		}
	}	//	delTree

}	//	CleanOrphanCascade
