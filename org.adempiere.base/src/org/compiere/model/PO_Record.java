/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;

/**
 * 	Maintain AD_Table_ID/Record_ID constraint
 *	
 *  @author Jorg Janke
 *  @version $Id: PO_Record.java,v 1.4 2006/07/30 00:58:04 jjanke Exp $
 */
public class PO_Record
{
	/**	Parent Tables		*/
	private static int[]	s_parents =	new int[]{
		X_C_Order.Table_ID
	};
	private static String[]	s_parentNames = new String[]{
		X_C_Order.Table_Name
	};
	private static int[]	s_parentChilds = new int[]{
		X_C_OrderLine.Table_ID
	};
	private static String[]	s_parentChildNames = new String[]{
		X_C_OrderLine.Table_Name
	};
	
	
	
	/**	Cascade Table ID			*/
	private static int[]	s_cascades =	new int[]{
		X_AD_Attachment.Table_ID,
		X_AD_Archive.Table_ID,
		X_AD_Note.Table_ID,
		X_AD_RecentItem.Table_ID,
		X_AD_PostIt.Table_ID,
		X_AD_LabelAssignment.Table_ID	
	};
	/**	Cascade Table Names			*/
	private static String[]	s_cascadeNames = new String[]{
		X_AD_Attachment.Table_Name,
		X_AD_Archive.Table_Name,
		X_AD_Note.Table_Name,
		X_AD_RecentItem.Table_Name,
		X_AD_PostIt.Table_Name,
		X_AD_LabelAssignment.Table_Name
	};

	/**	Restrict Table ID			*/
	private static int[]	s_restricts =	new int[]{
		X_R_Request.Table_ID,
		X_CM_Chat.Table_ID
	//	X_Fact_Acct.Table_ID
	};
	/**	Restrict Table Names			*/
	private static String[]	s_restrictNames = new String[]{
		X_R_Request.Table_Name,
		X_CM_Chat.Table_Name
	//	X_Fact_Acct.Table_Name
	};

	/**	Logger	*/
	private static CLogger log = CLogger.getCLogger (PO_Record.class);
	
	/**
	 * 	Delete Cascade including (selected)parent relationships
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param trxName transaction
	 *	@return false if could not be deleted
	 */
	static boolean deleteCascade (int AD_Table_ID, int Record_ID, String trxName)
	{
		return deleteCascadeIDorUU (AD_Table_ID, Record_ID, null, trxName);
	}	//	deleteCascade

	/**
	 * 	Delete Cascade including (selected)parent relationships
	 *	@param AD_Table_ID table
	 *	@param Record_UU record UUID
	 *	@param trxName transaction
	 *	@return false if could not be deleted
	 */
	static boolean deleteCascadeUU (int AD_Table_ID, String Record_UU, String trxName)
	{
		return deleteCascadeIDorUU (AD_Table_ID, -1, Record_UU, trxName);
	}	//	deleteCascade

	/**
	 * 	Delete Cascade including (selected)parent relationships
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param Record_UU record UUID
	 *	@param trxName transaction
	 *	@return false if could not be deleted
	 */
	private static boolean deleteCascadeIDorUU (int AD_Table_ID, int Record_ID, String Record_UU, String trxName)
	{
		//	Table Loop
		for (int i = 0; i < s_cascades.length; i++)
		{
			MTable table = MTable.get(s_cascades[i]);
			if (Record_ID > 0 && s_cascades[i] != AD_Table_ID && table.columnExistsInDictionary("Record_ID")) {
				deleteCascadeSQL(s_cascadeNames[i], "Record_ID=?", AD_Table_ID, Record_ID, null, trxName);
			}
			if (Record_UU != null && s_cascades[i] != AD_Table_ID && table.columnExistsInDictionary("Record_UU")) {
				deleteCascadeSQL(s_cascadeNames[i], "Record_UU=?", AD_Table_ID, -1, Record_UU, trxName);
			}
		}
		//	Parent Loop
		for (int j = 0; j < s_parents.length; j++)
		{
			if (s_parents[j] == AD_Table_ID)
			{
				int AD_Table_IDchild = s_parentChilds[j];
				for (int i = 0; i < s_cascades.length; i++)
				{
					MTable table = MTable.get(s_cascades[i]);
					StringBuilder whereIn = new StringBuilder ("Record_ID IN (SELECT ")
							.append(s_parentChildNames[j]).append("_ID FROM ")
							.append(s_parentChildNames[j]).append(" WHERE ")
							.append(s_parentNames[j]).append("_ID=?)");
					if (Record_ID > 0 && s_cascades[i] != AD_Table_IDchild && table.columnExistsInDictionary("Record_ID")) {
						deleteCascadeSQL(s_cascadeNames[i], whereIn.toString(), AD_Table_IDchild, Record_ID, null, trxName);
					}
					if (Record_UU != null && s_cascades[i] != AD_Table_IDchild && table.columnExistsInDictionary("Record_UU")) {
						deleteCascadeSQL(s_cascadeNames[i], whereIn.toString(), AD_Table_IDchild, -1, Record_UU, trxName);
					}
				}
			}
		}
		return true;
	}	//	deleteCascadeIDorUU

	/**
	 * @param deleteTableName
	 * @param where
	 * @param AD_Table_ID
	 * @param Record_ID the ID of the record to be checked
	 * @param Record_UU the UUID of the record to be checked (not checked if Record_ID > 0)
	 * @param trxName
	 */
	private static void deleteCascadeSQL(String deleteTableName, String where, int AD_Table_ID, int Record_ID, String Record_UU, String trxName) {
		//	DELETE FROM table WHERE AD_Table_ID=#1 AND Record_??=#2
		Object[] params = new Object[]{Integer.valueOf(AD_Table_ID), Record_ID > 0 ? Integer.valueOf(Record_ID) : Record_UU};
		if (deleteTableName.equals(X_AD_Attachment.Table_Name) || deleteTableName.equals(X_AD_Archive.Table_Name))
		{
			Query query = new Query(Env.getCtx(), deleteTableName, "AD_Table_ID=? AND " + where, trxName);
			List<PO> list = query.setParameters(params).list();
			for(PO po : list)
			{
				po.deleteEx(true);
			}
		}
		else 
		{
			StringBuilder sql = new StringBuilder ("DELETE FROM ")
					.append(deleteTableName)
					.append(" WHERE AD_Table_ID=? AND ")
					.append(where);
			int no = DB.executeUpdate(sql.toString(), params, false, trxName);
			if (no > 0) {
				if (log.isLoggable(Level.CONFIG)) log.config(deleteTableName + " (" + AD_Table_ID + "/" + Record_ID + ") #" + no);
			} else if (no < 0) {
				log.severe(deleteTableName + " (" + AD_Table_ID + "/" + Record_ID + ") #" + no);
			}
		}
	}

	/**
	 * IDEMPIERE-2060
	 * @param tableName
	 * @param Record_ID
	 * @param trxName
	 */
	public static void deleteModelCascade(String tableName, int Record_ID, String trxName) {
		deleteModelCascadeByIDorUU(tableName, Record_ID, null, trxName);
	}

	/**
	 * @param tableName
	 * @param Record_UU
	 * @param trxName
	 */
	public static void deleteModelCascadeUU(String tableName, String Record_UU, String trxName) {
		deleteModelCascadeByIDorUU(tableName, -1, Record_UU, trxName);
	}

	/**
	 * @param tableName
	 * @param Record_ID the ID of the record to be checked
	 * @param Record_UU the UUID of the record to be checked (not checked if Record_ID > 0)
	 * @param trxName
	 */
	private static void deleteModelCascadeByIDorUU(String tableName, int Record_ID, String Record_UU, String trxName) {
		int refIdTable;
		int refIdSearch;
		if (Record_ID > 0) {
			refIdTable = DisplayType.TableDir;
			refIdSearch = DisplayType.Search;
		} else {
			refIdTable = DisplayType.TableDirUU;
			refIdSearch = DisplayType.SearchUU;
		}

		//find dependent tables to delete cascade
		StringBuilder sql = new StringBuilder()
			.append("SELECT t.TableName, "
				+ "       c.ColumnName "
				+ "FROM   AD_Column c "
				+ "       JOIN AD_Table t ON c.AD_Table_ID = t.AD_Table_ID "
				+ "       LEFT JOIN AD_Ref_Table r ON c.AD_Reference_Value_ID = r.AD_Reference_ID "
				+ "       LEFT JOIN AD_Table tr ON r.AD_Table_ID = tr.AD_Table_ID "
				+ "WHERE  t.IsView = 'N' "
				+ "       AND t.IsActive = 'Y' "
				+ "       AND c.IsActive = 'Y' "
				+ "       AND ( ( c.AD_Reference_ID = ").append(refIdTable)
			.append("               AND c.ColumnName = ? || '_ID' ) "
				+ "              OR ( c.AD_Reference_ID IN ( ").append(refIdTable).append(", ").append(refIdSearch).append(" ) "
				+ "                   AND ( tr.TableName = ? OR ( tr.TableName IS NULL AND c.ColumnName = ? || '_ID' ) ) ) ) "
				+ "       AND c.FKConstraintType=").append(DB.TO_STRING(MColumn.FKCONSTRAINTTYPE_ModelCascade));

		List<List<Object>> dependents = DB.getSQLArrayObjectsEx(trxName, sql.toString(), tableName, tableName, tableName);
		if (dependents != null) {
			for (List<Object> row : dependents) {
				String dependentTableName = (String) row.get(0);
				String dependentColumnName = (String) row.get(1);
				String dependentWhere = dependentColumnName + "=?";
				List<PO> poList = new Query(Env.getCtx(), 
						dependentTableName,
						dependentWhere,
						trxName).setParameters(Record_ID > 0 ? Record_ID : Record_UU).list();
				for (PO po : poList) {
					po.deleteEx(true, trxName);
				}
			}
		}
	}

	/**
	 * 	An entry Exists for restrict table/record combination
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param trxName transaction
	 *	@return error message (Table Name) or null
	 */
	static String exists (int AD_Table_ID, int Record_ID, String trxName)
	{
		return existsIDorUU(AD_Table_ID, Record_ID, null, trxName);
	}	//	exists

	/**
	 * 	An entry Exists for restrict table/record combination
	 *	@param AD_Table_ID table
	 *	@param Record_UU record UUID
	 *	@param trxName transaction
	 *	@return error message (Table Name) or null
	 */
	static String existsUU (int AD_Table_ID, String Record_UU, String trxName)
	{
		return existsIDorUU(AD_Table_ID, -1, Record_UU, trxName);
	}	//	existsUU

	/**
	 * 	An entry Exists for restrict table/record combination
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@param Record_UU record UUID
	 *	@param trxName transaction
	 *	@return error message (Table Name) or null
	 */
	private static String existsIDorUU (int AD_Table_ID, int Record_ID, String Record_UU, String trxName)
	{
		//	Table Loop only
		for (int i = 0; i < s_restricts.length; i++)
		{
			MTable checkTable = MTable.get(Env.getCtx(), s_restrictNames[i]);
			if (Record_ID > 0 && checkTable.columnExistsInDictionary("Record_ID")) {
				int no = existsCountSQL(s_restrictNames[i], AD_Table_ID, Record_ID, null, trxName);
				if (no > 0)
					return s_restrictNames[i];
			}
			if (Record_UU != null && checkTable.columnExistsInDictionary("Record_UU")) {
				int no = existsCountSQL(s_restrictNames[i], AD_Table_ID, -1, Record_UU, trxName);
				if (no > 0)
					return s_restrictNames[i];
			}
		}
		return null;
	}	//	existsIDorUU

	/**
	 * @param checkTableName
	 * @param columnName
	 * @param AD_Table_ID
	 * @param Record_ID the ID of the record to be checked
	 * @param Record_UU the UUID of the record to be checked (not checked if Record_ID > 0)
	 * @param trxName
	 * @return
	 */
	private static int existsCountSQL(String checkTableName, int AD_Table_ID, int Record_ID, String Record_UU, String trxName) {
		String columnName;
		if (Record_ID > 0)
			columnName = "Record_ID";
		else
			columnName = "Record_UU";
		//	SELECT COUNT(*) FROM table WHERE AD_Table_ID=#1 AND Record_??=#2
		StringBuilder sql = new StringBuilder ("SELECT COUNT(*) FROM ")
			.append(checkTableName)
			.append(" WHERE AD_Table_ID=? AND ").append(columnName).append("=?");
		return DB.getSQLValue(trxName, sql.toString(), AD_Table_ID, Record_ID > 0 ? Record_ID : Record_UU);
	}

	/**
	 * 	Validate all tables for AD_Table/Record_ID relationships
	 */
	static void validate ()
	{
		String sql = "SELECT AD_Table_ID, TableName FROM AD_Table WHERE IsView='N' ORDER BY TableName";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				validate (rs.getInt(1), rs.getString(2));
			}
		}
		catch (Exception e)
		{
			log.log (Level.SEVERE, sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	}	//	validate
	
	/**
	 * 	Validate all tables for AD_Table/Record_ID relationships
	 *	@param AD_Table_ID table
	 */
	static void validate (int AD_Table_ID)
	{
		MTable table = new MTable(Env.getCtx(), AD_Table_ID, null);
		if (table.isView())
			log.warning("Ignored - View " + table.getTableName());
		else
			validate (table.getAD_Table_ID(), table.getTableName());
	}	//	validate

	/**
	 * 	Validate Table for Table/Record
	 *	@param AD_Table_ID table
	 *	@param TableName Name
	 */
	static private void validate (int AD_Table_ID, String TableName)
	{
		for (int i = 0; i < s_cascades.length; i++)
		{
			StringBuilder sql = new StringBuilder ("DELETE FROM ")
				.append(s_cascadeNames[i])
				.append(" WHERE AD_Table_ID=").append(AD_Table_ID)
				.append(" AND Record_ID NOT IN (SELECT ")
				.append(TableName).append("_ID FROM ").append(TableName).append(")");
			int no = DB.executeUpdate(sql.toString(), null);
			if (no > 0)
				if (log.isLoggable(Level.CONFIG)) log.config(s_cascadeNames[i] + " (" + AD_Table_ID + "/" + TableName 
						+ ") Invalid #" + no);
		}
	}	//	validate
	
	
}	//	PO_Record
