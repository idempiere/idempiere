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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;

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
		KeyNamePair[] cascades = getTablesWithRecordColumn(MColumn.FKCONSTRAINTTYPE_Cascade);
		//	Table Loop
		for (int i = 0; i < cascades.length; i++)
		{
			//	DELETE FROM table WHERE AD_Table_ID=#1 AND Record_ID=#2
			if (cascades[i].getKey() != AD_Table_ID)
			{
				Object[] params = new Object[]{Integer.valueOf(AD_Table_ID), Integer.valueOf(Record_ID)};
				if (cascades[i].getName().equals(X_AD_Attachment.Table_Name) || cascades[i].getName().equals(X_AD_Archive.Table_Name))
				{
					Query query = new Query(Env.getCtx(), cascades[i].getName(), "AD_Table_ID=? AND Record_ID=?", trxName);
					List<PO> list = query.setParameters(params).list();
					for(PO po : list)
					{
						po.deleteEx(true);
					}
				}
				else 
				{
					StringBuilder sql = new StringBuilder ("DELETE FROM ")
							.append(cascades[i].getName())
							.append(" WHERE AD_Table_ID=? AND Record_ID=?");
					int no = DB.executeUpdate(sql.toString(), params, false, trxName);
					if (no > 0) {
						if (log.isLoggable(Level.CONFIG)) log.config(cascades[i].getName() + " (" + AD_Table_ID + "/" + Record_ID + ") #" + no);
					} else if (no < 0) {
						log.severe(cascades[i].getName() + " (" + AD_Table_ID + "/" + Record_ID + ") #" + no);
						return false;
					}
				}
			}
		}
		//	Parent Loop
		for (int j = 0; j < s_parents.length; j++)
		{
			if (s_parents[j] == AD_Table_ID)
			{
				int AD_Table_IDchild = s_parentChilds[j];
				Object[] params = new Object[]{Integer.valueOf(AD_Table_IDchild), Integer.valueOf(Record_ID)};
				for (int i = 0; i < cascades.length; i++)
				{
					StringBuilder sql = new StringBuilder ("DELETE FROM ")
						.append(cascades[i].getName())
						.append(" WHERE AD_Table_ID=? AND Record_ID IN (SELECT ")
						.append(s_parentChildNames[j]).append("_ID FROM ")
						.append(s_parentChildNames[j]).append(" WHERE ")
						.append(s_parentNames[j]).append("_ID=?)");
					int no = DB.executeUpdate(sql.toString(), params, false, trxName);
					if (no > 0) {
						if (log.isLoggable(Level.CONFIG)) log.config(cascades[i].getName() + " " + s_parentNames[j]  
								+ " (" + AD_Table_ID + "/" + Record_ID + ") #" + no);
					} else if (no < 0) {
						log.severe(cascades[i].getName() + " " + s_parentNames[j]
								+ " (" + AD_Table_ID + "/" + Record_ID + ") #" + no);
						return false;
					}
				}
			}
		}
		return true;
	}	//	deleteCascade

	//IDEMPIERE-2060
	public static void deleteModelCascade(String tableName, int Record_ID, String trxName) {
		//find dependent tables to delete cascade	
		final String sql = ""
				+ "SELECT t.TableName, "
				+ "       c.ColumnName "
				+ "FROM   AD_Column c "
				+ "       JOIN AD_Table t ON c.AD_Table_ID = t.AD_Table_ID "
				+ "       LEFT JOIN AD_Ref_Table r ON c.AD_Reference_Value_ID = r.AD_Reference_ID "
				+ "       LEFT JOIN AD_Table tr ON r.AD_Table_ID = tr.AD_Table_ID "
				+ "WHERE  t.IsView = 'N' "
				+ "       AND t.IsActive = 'Y' "
				+ "       AND c.IsActive = 'Y' "
				+ "       AND ( ( c.AD_Reference_ID = " + DisplayType.TableDir
				+ "               AND c.ColumnName = ? || '_ID' ) "
				+ "              OR ( c.AD_Reference_ID IN ( " + DisplayType.Table + ", " + DisplayType.Search + " ) "
				+ "                   AND ( tr.TableName = ? OR ( tr.TableName IS NULL AND c.ColumnName = ? || '_ID' ) ) ) ) "
				+ "       AND c.FKConstraintType = '" + MColumn.FKCONSTRAINTTYPE_ModelCascade + "' ";

		List<List<Object>> dependents = DB.getSQLArrayObjectsEx(trxName, sql, tableName, tableName, tableName);
		if (dependents != null) {
			for (List<Object> row : dependents) {
				String dependentTableName = (String) row.get(0);
				String dependentColumnName = (String) row.get(1);
				String dependentWhere = dependentColumnName + "=?";
				List<PO> poList = new Query(Env.getCtx(), 
						dependentTableName,
						dependentWhere,
						trxName).setParameters(Record_ID).list();
				for (PO po : poList) {
					po.deleteEx(true, trxName);
				}
			}
		}
	}

	/**
	 * If a referencing Record ID or Record UU exists to the deleted record, set it to NULL 
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param trxName
	 */
	public static void deleteSetNull(int AD_Table_ID, int Record_ID, String trxName){
		KeyNamePair[] toClear = getTablesWithRecordColumn(MColumn.FKCONSTRAINTTYPE_SetNull);
		Object[] params = new Object[]{Integer.valueOf(AD_Table_ID), Integer.valueOf(Record_ID)};
		// Table loop
		for (KeyNamePair table : toClear) {
			if(table.getKey() == AD_Table_ID)
				continue;
			
			String sql = " UPDATE " + table.getName()
				+ " SET Record_ID = NULL "
				+ "	WHERE AD_Table_ID = ? AND Record_ID = ? ";
			int no = DB.executeUpdate(sql, params, false, trxName);
			
			if (no > 0) {
				if (log.isLoggable(Level.CONFIG)) log.config(table.getName() + " (" + AD_Table_ID + "/" + Record_ID + ") #" + no);
			} else if (no < 0) {
				log.severe(table.getName() + " (" + AD_Table_ID + "/" + Record_ID + ") #" + no);
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
		KeyNamePair[] restricts = getTablesWithRecordColumn(MColumn.FKCONSTRAINTTYPE_NoAction);
		//	Table Loop only
		for (int i = 0; i < restricts.length; i++)
		{
			//	SELECT COUNT(*) FROM table WHERE AD_Table_ID=#1 AND Record_ID=#2
			StringBuilder sql = new StringBuilder ("SELECT COUNT(*) FROM ")
				.append(restricts[i].getName())
				.append(" WHERE AD_Table_ID=? AND Record_ID=?");
			int no = DB.getSQLValue(trxName, sql.toString(), AD_Table_ID, Record_ID);
			if (no > 0)
				return restricts[i].getName();
		}
		return null;
	}	//	exists

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
		KeyNamePair[] cascades = getTablesWithRecordColumn(MColumn.FKCONSTRAINTTYPE_Cascade);
		for (int i = 0; i < cascades.length; i++)
		{
			StringBuilder sql = new StringBuilder ("DELETE FROM ")
				.append(cascades[i].getName())
				.append(" WHERE AD_Table_ID=").append(AD_Table_ID)
				.append(" AND Record_ID NOT IN (SELECT ")
				.append(TableName).append("_ID FROM ").append(TableName).append(")");
			int no = DB.executeUpdate(sql.toString(), null);
			if (no > 0)
				if (log.isLoggable(Level.CONFIG)) log.config(cascades[i].getName() + " (" + AD_Table_ID + "/" + TableName 
						+ ") Invalid #" + no);
		}
	}	//	validate
	
	/**
	 * Get array of tables which has a Record_ID or Record_UU column with the defined Constraint Type
	 * @param constraintType - FKConstraintType of AD_Column
	 * @return int array of KeyNamePair<AD_Table_ID, TableName> 
	 */
	static private KeyNamePair[] getTablesWithRecordColumn(String constraintType) {
		ArrayList<KeyNamePair> tables = new ArrayList<KeyNamePair>();
		
		String sql = " SELECT t.AD_Table_ID, TableName "
				+ "	FROM AD_Column c "
				+ "	JOIN AD_Table t ON (c.AD_Table_ID = t.AD_Table_ID) "
				+ "	WHERE c.AD_Reference_ID IN (?,?) AND FKConstraintType = ? ";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			int idx = 1;
			pstmt.setInt(idx++, DisplayType.RecordID);
			pstmt.setInt(idx++, DisplayType.RecordUU);
			pstmt.setString(idx++, constraintType);
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				tables.add(new KeyNamePair(rs.getInt(1), rs.getString(2)));
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
		
		KeyNamePair[] tablesArray = new KeyNamePair[tables.size()];
		for(int i=0; i<tables.size(); i++) {
			tablesArray[i] = tables.get(i);
		}
		
		return tablesArray;
	}
	
}	//	PO_Record
