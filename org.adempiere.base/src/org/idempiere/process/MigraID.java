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
 * - Carlos Ruiz - globalqss                                           *
 * Sponsored by FH                                                     *
 **********************************************************************/

package org.idempiere.process;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.compiere.model.MProcessPara;
import org.compiere.model.MSequence;
import org.compiere.model.MTable;
import org.compiere.model.MTree;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Trx;
import org.compiere.util.Util;

/**
 * Process to replace a specific ID or UUID
 */
@org.adempiere.base.annotation.Process
public class MigraID extends SvrProcess {

	private int p_AD_Table_ID = -1;
	private int p_ID_From = -1;
	private int p_ID_To = -1;
	private String p_UUID_From = null;
	private String p_UUID_To = null;
	private MTable l_table = null;
	private String l_tableName = null;

	@Override
	protected void prepare() {
		//
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			if ("AD_Table_ID".equals(name)) {
				p_AD_Table_ID  = para.getParameterAsInt();
			} else if ("Record_ID".equals(name)) {
				p_ID_From = para.getParameterAsInt();
			} else if ("To_Record_ID".equals(name)) {
				p_ID_To = para.getParameterAsInt();
			} else if ("Source_UUID".equals(name)) {
				p_UUID_From = para.getParameterAsString();
			} else if ("Target_UUID".equals(name)) {
				p_UUID_To = para.getParameterAsString();
			} else {
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para);
			}
		}
	}

	@Override
	protected String doIt() throws Exception {
		if (p_ID_From <= 0 && Util.isEmpty(p_UUID_From)) {
			throw new AdempiereUserError("Fill Record ID or UUID to convert");
		}
		if (p_ID_From > 0 && ! Util.isEmpty(p_UUID_From)) {
			throw new AdempiereUserError("Record ID and UUID are excluyent, just one can be converted at the same time");
		}
		if (p_ID_From > 0 && p_ID_From == p_ID_To) {
			throw new AdempiereUserError("Same ID");
		}
		if (! Util.isEmpty(p_UUID_From) && p_UUID_From.equals(p_UUID_To)) {
			throw new AdempiereUserError("Same UUID");
		}
		l_table = MTable.get(getCtx(), p_AD_Table_ID, get_TrxName());
		l_tableName = l_table.getTableName();
		String msg = "";

		if (! Util.isEmpty(p_UUID_From)) {
			String uuidCol = PO.getUUIDColumnName(l_tableName);
			if (Util.isEmpty(p_UUID_To)) {
				p_UUID_To = UUID.randomUUID().toString();
			}
			// convert UUID
			StringBuilder updUUIDSB = new StringBuilder()
					.append("UPDATE ").append(l_tableName)
					.append(" SET ").append(uuidCol).append("=?")
					.append(" WHERE ").append(uuidCol).append("=?");
			int cnt = DB.executeUpdateEx(updUUIDSB.toString(), new Object[] {p_UUID_To, p_UUID_From}, get_TrxName());
			if (cnt <= 0) {
				msg = "@Error@ UUID " + p_UUID_From + " not found on table " + l_tableName;
			} else {
				int id = -1;
				msg = "UUID changed on table " + l_tableName + " from " + p_UUID_From + " to " + p_UUID_To;
				if (l_table.isIDKeyTable()) {
					StringBuilder sqlSB = new StringBuilder()
							.append("SELECT  ").append(l_tableName).append("_ID")
							.append(" FROM ").append(l_tableName)
							.append(" WHERE ").append(uuidCol).append("=?");
					id = DB.getSQLValueEx(get_TrxName(), sqlSB.toString(), p_UUID_To);
				}
				addBufferLog(0, null, null, msg, p_AD_Table_ID, id);
				msg = "@OK@";
				migrateChildren(false);
				migrateRecordUU();
				migrateMultiIDs();
				migratePackageUUIDMap();
			}
		} else {
			boolean seqCheck = false;
			String idCol = l_tableName + "_ID";
			if (p_ID_To <= 0) {
				p_ID_To = DB.getNextID(getAD_Client_ID(), l_tableName, get_TrxName());
			} else {
				StringBuilder sqlMaxSB = new StringBuilder()
						.append("SELECT  MAX(").append(l_tableName).append("_ID)")
						.append(" FROM ").append(l_tableName);
				int maxID = DB.getSQLValueEx(get_TrxName(), sqlMaxSB.toString());
				if (p_ID_To > maxID) {
					seqCheck = true;
				}
			}
			// convert ID
			int cnt = updID(l_tableName, idCol, true);
			if (cnt <= 0) {
				msg = "@Error@ ID " + p_ID_From + " not found on table " + l_tableName;
			} else {
				msg = "ID changed on table " + l_tableName + " from " + p_ID_From + " to " + p_ID_To;
				addBufferLog(0, null, null, msg, p_AD_Table_ID, p_ID_To);
				msg = "@OK@";
				migrateDirectReference();
				migrateChildren(true);
				migrateRecordID();
				migrateAD_Preference(idCol);
				migrateTrees();
				if ("C_DocType_ID".equals(idCol)) {
					// special preference C_DocTypeTarget_ID
					migrateAD_Preference("C_DocTypeTarget_ID");
				}
				migrateMultiIDs();

				if (seqCheck) {
					MSequence seq = MSequence.get(getCtx(), l_tableName, get_TrxName());
					if (seq != null) {
						seq.validateTableIDValue(get_TrxName()); // ignore output messages
					}
				}
			}
		}

		/* Force showing error in commit - for example when violating foreign keys */
		Trx.get(get_TrxName(), false).commit(true);

		return msg;
	}

	/**
	 * Update key on table
	 * @param tableName - table
	 * @param idCol - id column
	 * @param idKey - true when migrating ID keys, false when migrating UUID keys
	 * @return count of records updated
	 */
	private int updID(String tableName, String idCol, boolean idKey) {
		StringBuilder updIDSB = new StringBuilder()
				.append("UPDATE ").append(tableName)
				.append(" SET ").append(idCol).append("=?")
				.append(" WHERE ").append(idCol).append("=?");
		int cnt;
		if (idKey)
			cnt = DB.executeUpdateEx(updIDSB.toString(), new Object[] {p_ID_To, p_ID_From}, get_TrxName());
		else
			cnt = DB.executeUpdateEx(updIDSB.toString(), new Object[] {p_UUID_To, p_UUID_From}, get_TrxName());
		return cnt;
	}

	/**
	 * Migrate all foreign IDs for tables with direct reference (AD_Column.AD_Reference_ID in Location, Account, Locator ... etc)
	 */
	private void migrateDirectReference() {
		// Special cases with direct reference
		int refID = -1;
		switch (l_tableName) {
		case "C_Location"             : refID = DisplayType.Location;   break;
		case "C_ValidCombination"     : refID = DisplayType.Account;    break;
		case "M_Locator"              : refID = DisplayType.Locator;    break;
		case "M_AttributeSetInstance" : refID = DisplayType.PAttribute; break;
		case "S_ResourceAssignment"   : refID = DisplayType.Assignment; break;
		case "AD_Image"               : refID = DisplayType.Image;      break;
		case "AD_Color"               : refID = DisplayType.Color;      break;
		case "AD_Chart"               : refID = DisplayType.Chart;      break;
		}
		if (refID > 0) {
			// get all columns with the direct reference
			final String selRef = ""
					+ "SELECT t.TableName, c.ColumnName "
					+ "FROM AD_Table t "
					+ "JOIN AD_Column c ON (t.AD_Table_ID=c.AD_Table_ID) "
					+ "WHERE t.IsView='N' AND t.IsActive='Y' AND c.IsActive='Y' AND c.ColumnSQL IS NULL AND c.AD_Reference_ID=? "
					+ "ORDER BY t.TableName, c.ColumnName";
			List<List<Object>> rows = DB.getSQLArrayObjectsEx(get_TrxName(), selRef, refID);
			if (rows != null && rows.size() > 0) {
				for (List<Object> row : rows) {
					String tableRef = (String) row.get(0);
					String columnRef = (String) row.get(1);
					int cnt = updID(tableRef, columnRef, true);
					if (cnt > 0) {
						String msg = cnt + " reference records updated in " + tableRef + "." + columnRef;
						addBufferLog(0, null, null, msg, 0, 0);
					}
				}
			}
		}

	}

	/**
	 * Migrate foreign keys for tableName
	 * @param idKey - true when migrating ID keys, false when migrating UUID keys
	 */
	private void migrateChildren(boolean idKey) {
		// get all columns with the reference defined as Table*/Search*/TableDir*
		final String sqlFK = ""
				+ "SELECT t.TableName, c.ColumnName "
				+ "FROM   AD_Table t, AD_Column c " 
				+ "WHERE  t.AD_Table_ID = c.AD_Table_ID "
				+ "       AND t.IsActive = 'Y' AND t.IsView = 'N' " 
				+ "       AND c.IsActive = 'Y' AND c.ColumnSql IS NULL "
				+ "       AND ( c.AD_Reference_ID=? "
				+ "              OR ( c.AD_Reference_ID=? "
				+ "                   AND c.AD_Reference_Value_ID IS NULL ) ) "
				+ "       AND UPPER(c.ColumnName) = UPPER(?) "
				+ "UNION "
				+ "SELECT t.TableName, c.ColumnName "
				+ "FROM   AD_Table t, AD_Column c, AD_Ref_Table rt, AD_Table tr "
				+ "WHERE  t.AD_Table_ID = c.AD_Table_ID "
				+ "       AND t.IsActive = 'Y' AND t.IsView = 'N' " 
				+ "       AND c.IsActive = 'Y' AND c.ColumnSql IS NULL "
				+ "       AND ( c.AD_Reference_ID=? "
				+ "              OR ( c.AD_Reference_ID=? "
				+ "                   AND c.AD_Reference_Value_ID IS NOT NULL ) ) "
				+ "       AND c.AD_Reference_Value_ID = rt.AD_Reference_ID "
				+ "       AND rt.AD_Table_ID = tr.AD_Table_ID "
				+ "       AND UPPER(tr.TableName) = UPPER(?) "
				+ "ORDER  BY 1, 2";
		int tableDirRefId;
		int searchRefId;
		int tableRefId;
		String foreignColName;
		if (idKey) {
			tableDirRefId = DisplayType.TableDir;
			searchRefId = DisplayType.Search;
			tableRefId = DisplayType.Table;
			foreignColName = l_tableName + "_ID";
		} else {
			tableDirRefId = DisplayType.TableDirUU;
			searchRefId = DisplayType.SearchUU;
			tableRefId = DisplayType.TableUU;
			foreignColName = PO.getUUIDColumnName(l_tableName);
		}
		List<List<Object>> rows = DB.getSQLArrayObjectsEx(get_TrxName(), sqlFK, tableDirRefId, searchRefId, foreignColName, tableRefId, searchRefId, l_tableName);
		if (rows != null && rows.size() > 0) {
			for (List<Object> row : rows) {
				String tableRef = (String) row.get(0);
				String columnRef = (String) row.get(1);
				// Special cases EntityType and AD_Language
				if ("EntityType".equals(columnRef) || "AD_Language".equals(columnRef)) {
					continue;
				}
				int cnt = updID(tableRef, columnRef, idKey);
				if (cnt > 0) {
					String msg = cnt + " children records updated in " + tableRef + "." + columnRef;
					addBufferLog(0, null, null, msg, 0, 0);
				}
			}
		}
		// Special case for C_BPartner.AD_OrgBP_ID defined as Button in dictionary
		if (idKey && "AD_Org".equalsIgnoreCase(l_tableName)) {
			String tableRef = "C_BPartner";
			String columnRef = "AD_OrgBP_ID";
			int cnt = updID(tableRef, columnRef, idKey);
			if (cnt > 0) {
				String msg = cnt + " children records updated in " + tableRef + "." + columnRef;
				addBufferLog(0, null, null, msg, 0, 0);
			}
		}
	}

	/**
	 * Migrate all Record_ID columns where AD_Table_ID is related to the table being processed
	 */
	private void migrateRecordID() {
		final String whereClause = "IsView='N' AND IsActive='Y'" + 
				" AND EXISTS (SELECT 1 FROM AD_Column ct WHERE ct.AD_Table_ID=AD_Table.AD_Table_ID AND ct.ColumnName='AD_Table_ID' AND ct.ColumnSQL IS NULL AND ct.IsActive='Y')" + 
				" AND EXISTS (SELECT 1 FROM AD_Column cr WHERE cr.AD_Table_ID=AD_Table.AD_Table_ID AND cr.ColumnName='Record_ID'   AND cr.ColumnSQL IS NULL AND cr.IsActive='Y')";
		List<MTable> tablesWithRecordID = new Query(getCtx(), "AD_Table", whereClause, get_TrxName())
				.setOrderBy("TableName")
				.list();
		for (MTable table : tablesWithRecordID) {
			String tableName = table.getTableName();
			StringBuilder updRISB = new StringBuilder()
					.append("UPDATE ").append(tableName)
					.append(" SET Record_ID=?")
					.append(" WHERE Record_ID=? AND AD_Table_ID=?");
			int cnt = DB.executeUpdateEx(updRISB.toString(), new Object[] {p_ID_To, p_ID_From, p_AD_Table_ID}, get_TrxName());
			if (cnt > 0) {
				String msg = cnt + " weak reference records updated in " + tableName;
				addBufferLog(0, null, null, msg, 0, 0);
			}
		}
	}

	/**
	 * Migrate all Record_UU columns where AD_Table_ID is related to the table being processed
	 */
	private void migrateRecordUU() {
		final String whereClause = "IsView='N' AND IsActive='Y'" + 
				" AND EXISTS (SELECT 1 FROM AD_Column ct WHERE ct.AD_Table_ID=AD_Table.AD_Table_ID AND ct.ColumnName='AD_Table_ID' AND ct.ColumnSQL IS NULL AND ct.IsActive='Y')" + 
				" AND EXISTS (SELECT 1 FROM AD_Column cr WHERE cr.AD_Table_ID=AD_Table.AD_Table_ID AND cr.ColumnName='Record_UU'   AND cr.ColumnSQL IS NULL AND cr.IsActive='Y')";
		List<MTable> tablesWithRecordID = new Query(getCtx(), "AD_Table", whereClause, get_TrxName())
				.setOrderBy("TableName")
				.list();
		for (MTable table : tablesWithRecordID) {
			String tableName = table.getTableName();
			StringBuilder updRISB = new StringBuilder()
					.append("UPDATE ").append(tableName)
					.append(" SET Record_UU=?")
					.append(" WHERE Record_UU=? AND AD_Table_ID=?");
			int cnt = DB.executeUpdateEx(updRISB.toString(), new Object[] {p_UUID_To, p_UUID_From, p_AD_Table_ID}, get_TrxName());
			if (cnt > 0) {
				String msg = cnt + " weak reference records updated in " + tableName;
				addBufferLog(0, null, null, msg, 0, 0);
			}
		}
	}

	/**
	 * Migrate AD_Preference where the Attribute is same as the columnName
	 * WARNING: there are cases where the preference doesn't match the columnName, these are not migrated
	 * @param columnName
	 */
	private void migrateAD_Preference(String columnName) {
		final String updPref = "UPDATE AD_Preference SET Value=? WHERE Value=? AND Attribute=?";
		int cnt = DB.executeUpdateEx(updPref, new Object[] {String.valueOf(p_ID_To), String.valueOf(p_ID_From), columnName}, get_TrxName());
		if (cnt > 0) {
			String msg = cnt + " preference records updated in AD_Preference for " + columnName;
			addBufferLog(0, null, null, msg, 0, 0);
		}
	}

	/**
	 * Migrate the IDs on the tree tables
	 * @param tableName
	 */
	private void migrateTrees() {
		switch (l_tableName) {
		case "AD_Menu":
			migraTree("AD_TreeBar", MTree.TREETYPE_Menu);
			migraTree("AD_TreeNodeMM", MTree.TREETYPE_Menu);
			break;
		case "C_BPartner":
			migraTree("AD_TreeNodeBP", MTree.TREETYPE_BPartner);
			break;
		case "CM_Container":
			migraTree("AD_TreeNodeCMC", MTree.TREETYPE_CMContainer);
			break;
		case "CM_Media":
			migraTree("AD_TreeNodeCMM", MTree.TREETYPE_CMMedia);
			break;
		case "CM_CStage":
			migraTree("AD_TreeNodeCMS", MTree.TREETYPE_CMContainerStage);
			break;
		case "CM_Template":
			migraTree("AD_TreeNodeCMT", MTree.TREETYPE_CMTemplate);
			break;
		case "M_Product":
			migraTree("AD_TreeNodePR", MTree.TREETYPE_Product);
			break;
		case "C_ElementValue":
			migraTree("AD_TreeNodeU1", MTree.TREETYPE_User1);
			migraTree("AD_TreeNodeU2", MTree.TREETYPE_User2);
			migraTree("AD_TreeNodeU3", MTree.TREETYPE_User3);
			migraTree("AD_TreeNodeU4", MTree.TREETYPE_User4);
			break;
		case "AD_Org":
			migraTree("AD_TreeNode", MTree.TREETYPE_Organization);
			break;
		case "M_Product_Category":
			migraTree("AD_TreeNode", MTree.TREETYPE_ProductCategory);
			break;
		case "M_BOM":
			migraTree("AD_TreeNode", MTree.TREETYPE_BoM);
			break;
		case "C_Campaign":
			migraTree("AD_TreeNode", MTree.TREETYPE_Campaign);
			break;
		case "C_Project":
			migraTree("AD_TreeNode", MTree.TREETYPE_Project);
			break;
		case "C_Activity":
			migraTree("AD_TreeNode", MTree.TREETYPE_Activity);
			break;
		case "C_SalesRegion":
			migraTree("AD_TreeNode", MTree.TREETYPE_SalesRegion);
			break;
		case "AD_Tree_Favorite_Node":
			migraFavTree();
			break;
		}
		migraTree("AD_TreeNode", MTree.TREETYPE_CustomTable);
	}

	/**
	 * Migrate IDs for the tree tables
	 * @param menuTable
	 * @param treeType
	 */
	private void migraTree(String menuTable, String treeType) {
		List<String> columns = new ArrayList<String>();
		columns.add("Node_ID");
		if (! "AD_TreeBar".equalsIgnoreCase(menuTable)) {
			columns.add("Parent_ID");
		}
		for (String col : columns) {
			StringBuilder sqlUpdTreeSB = new StringBuilder()
					.append("UPDATE ").append(menuTable)
					.append(" SET ").append(col).append("=? WHERE ").append(col).append("=? AND AD_Tree_ID IN (SELECT AD_Tree_ID FROM AD_Tree WHERE TreeType=?");
			if (MTree.TREETYPE_CustomTable.equals(treeType)) {
				sqlUpdTreeSB.append(" AND AD_Table_ID=").append(p_AD_Table_ID);
			}
			sqlUpdTreeSB.append(")");
			int cnt = DB.executeUpdateEx(sqlUpdTreeSB.toString(), new Object[] {p_ID_To, p_ID_From, treeType}, get_TrxName());
			if (cnt > 0) {
				String msg = cnt + " tree records updated in " + menuTable + "." + col;
				addBufferLog(0, null, null, msg, 0, 0);
			}
		}
	}

	/**
	 * Migrate ID for the AD_Tree_Favorite_Node.Parent_ID column
	 */
	private void migraFavTree() {
		final String sqlUpdFavTreeSB = "UPDATE AD_Tree_Favorite_Node SET Parent_ID=? WHERE Parent_ID=?";
		int cnt = DB.executeUpdateEx(sqlUpdFavTreeSB.toString(), new Object[] {p_ID_To, p_ID_From}, get_TrxName());
		if (cnt > 0) {
			String msg = cnt + " tree favourite records updated in AD_Tree_Favorite_Node.Parent_ID";
			addBufferLog(0, null, null, msg, 0, 0);
		}
	}

	/**
	 * Migrate columns with multiIDs (SingleSelectionGrid, MultipleSelectionGrid, ChosenMultipleSelectionTable, ChosenMultipleSelectionSearch)
	 */
	private void migrateMultiIDs() {
		final String sqlMulti = ""
				// get columns with ChosenMultiple*
				+ "SELECT t.TableName, c.ColumnName "
				+ "FROM   AD_Table t, AD_Column c, AD_Ref_Table rt, AD_Table tr "
				+ "WHERE  t.AD_Table_ID = c.AD_Table_ID "
				+ "       AND t.IsActive = 'Y' AND t.IsView = 'N' "
				+ "       AND c.IsActive = 'Y' AND c.ColumnSql IS NULL "
				+ "       AND c.AD_Reference_ID IN (?, ?) "
				+ "       AND c.AD_Reference_Value_ID = rt.AD_Reference_ID "
				+ "       AND rt.AD_Table_ID = tr.AD_Table_ID "
				+ "       AND UPPER(tr.TableName) = UPPER(?)"
				+ "UNION " // NOTE union removes the duplicates
				// get columns with *SelectionGrid
				+ "SELECT t.TableName, c.ColumnName "
				+ "FROM   AD_Table t, AD_Column c, AD_Field f, AD_Tab tb, AD_Table tr "
				+ "WHERE  t.AD_Table_ID = c.AD_Table_ID "
				+ "       AND t.IsActive = 'Y' AND t.IsView = 'N' "
				+ "       AND f.AD_Column_ID = c.AD_Column_ID "
				+ "       AND f.Included_Tab_ID = tb.AD_Tab_ID "
				+ "       AND tb.AD_Table_ID = tr.AD_Table_ID "
				+ "       AND c.IsActive = 'Y' AND c.ColumnSql IS NULL "
				+ "       AND c.AD_Reference_ID IN (?, ?) "
				+ "       AND UPPER(tr.TableName) = UPPER(?)"
				+ "ORDER  BY 1, 2";
		List<List<Object>> rows = DB.getSQLArrayObjectsEx(get_TrxName(), sqlMulti,
				DisplayType.ChosenMultipleSelectionTable, DisplayType.ChosenMultipleSelectionSearch, l_tableName,
				DisplayType.SingleSelectionGrid, DisplayType.MultipleSelectionGrid, l_tableName);
		if (rows != null && rows.size() > 0) {
			boolean idKey = ! l_table.isUUIDKeyTable();
			for (List<Object> row : rows) {
				String tableRef = (String) row.get(0);
				String columnRef = (String) row.get(1);
				int cnt = updMultiID(tableRef, columnRef, idKey);
				if (cnt > 0) {
					String msg = cnt + " children records updated in multi-ID " + tableRef + "." + columnRef;
					addBufferLog(0, null, null, msg, 0, 0);
				}
			}
		}
	}

	/**
	 * Update the ID or UUID in a multi-ID column (comma separated string with IDs or UUIDs)
	 * @param tableRef
	 * @param columnRef
	 * @param idKey
	 * @return
	 */
	private int updMultiID(String tableRef, String columnRef, boolean idKey) {
		StringBuilder toReplace = new StringBuilder("(^|,)");
		StringBuilder replacement = new StringBuilder("\\1");
		String idFrom;
		if (idKey) {
			toReplace.append(p_ID_From);
			replacement.append(p_ID_To);
			idFrom = String.valueOf(p_ID_From);
		} else {
			toReplace.append(p_UUID_From);
			replacement.append(p_UUID_To); 
			idFrom = p_UUID_From;
		}
		String matchIni = idFrom + ",%";
		String matchMid = "%," + idFrom + ",%";
		String matchEnd = "%," + idFrom;
		toReplace.append("($|,)");
		replacement.append("\\2");

		// Construct a SQL UPDATE like this example:
		//   change M_Product_ID from 127 to 1000022
		// UPDATE Test
		//   SET M_Product_IDs=REGEXP_REPLACE(M_Product_IDs,'(^|,)127($|,)','\11000022\2')  /* see below */
		//   WHERE M_Product_IDs='127'          /* the old ID as a single value */
		//     OR M_Product_IDs LIKE '127,%'      /* the old ID at the start of the comma separated field */
		//     OR M_Product_IDs LIKE '%,127,%'    /* the old ID at the middle of the comma separated field */
		//     OR M_Product_IDs LIKE '%,127'      /* the old ID at the end of the comma separated field */
		// toReplace is (^|,)127($|,) meaning:
		//     (^|,)     -> start of the string or a comma - this is captured in first buffer of the regexp
		//     127       -> the old ID
		//     ($|,)     -> end of the string or a comma - this is captured in second buffer of the regexp
		// replacement is \11000022\2 meaning
		//     \1        -> replace with the first buffer captured on the regexp
		//     1000022   -> then the new ID
		//     \2        -> and then the second buffer captured on the regexp
		StringBuilder updMultiIDSB = new StringBuilder("UPDATE ").append(tableRef)
				.append(" SET ").append(columnRef)
				.append("=REGEXP_REPLACE(").append(columnRef).append(",?,?) WHERE ")
				.append(columnRef).append("=?")
				.append(" OR ").append(columnRef).append(" LIKE ?")
				.append(" OR ").append(columnRef).append(" LIKE ?")
				.append(" OR ").append(columnRef).append(" LIKE ?");
		int cnt = DB.executeUpdateEx(updMultiIDSB.toString(), new Object[] {toReplace.toString(), replacement.toString(), idFrom, matchIni, matchMid, matchEnd}, get_TrxName());
		return cnt;
	}

	/**
	 * Migrate the UUID for records in table AD_Package_UUID_Map
	 */
	private void migratePackageUUIDMap() {
		final String sqlUpdSource = "UPDATE AD_Package_UUID_Map SET Source_UUID=? WHERE Source_UUID=?";
		int cntSource = DB.executeUpdateEx(sqlUpdSource, new Object[] {p_UUID_To, p_UUID_From}, get_TrxName());
		if (cntSource > 0) {
			String msg = cntSource + " records updated in AD_Package_UUID_Map.Source_UUID";
			addBufferLog(0, null, null, msg, 0, 0);
		}

		final String sqlUpdTarget = "UPDATE AD_Package_UUID_Map SET Target_UUID=? WHERE Target_UUID=?";
		int cntTarget = DB.executeUpdateEx(sqlUpdTarget, new Object[] {p_UUID_To, p_UUID_From}, get_TrxName());
		if (cntTarget > 0) {
			String msg = cntTarget + " records updated in AD_Package_UUID_Map.Target_UUID";
			addBufferLog(0, null, null, msg, 0, 0);
		}
	}

}
