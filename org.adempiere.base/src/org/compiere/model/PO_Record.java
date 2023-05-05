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

import java.math.BigDecimal;
import java.util.List;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;

/**
 * 	Maintain AD_Table_ID/Record_ID constraint
 *	
 *  @author Jorg Janke
 *  @version $Id: PO_Record.java,v 1.4 2006/07/30 00:58:04 jjanke Exp $
 */
public class PO_Record
{
	/* Cache for arrays of KeyNamePair<AD_Table_ID, TableName> for types of deletion: Cascade, Set Null, No Action */
	private static final CCache<String, KeyNamePair[]> s_po_record_tables_cache = new CCache<>(null, "PORecordTables", 100, 120, false);

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
	static boolean deleteRecordIdCascade (int AD_Table_ID, int Record_ID, String trxName)
	{
		KeyNamePair[] cascades = getTablesWithRecordIDColumn(MColumn.FKCONSTRAINTTYPE_ModelCascade, trxName);
		//	Table Loop
		for (KeyNamePair table : cascades)
		{
			//	DELETE FROM table WHERE AD_Table_ID=#1 AND Record_ID=#2
			List<PO> poList = new Query(Env.getCtx(), table.getName(), "AD_Table_ID=? AND Record_ID=?", trxName)
					.setParameters(AD_Table_ID, Record_ID)
					.list();

			int count = 0;
			for(PO po : poList)
			{
				if (po.get_Table_ID() == AD_Table_ID && po.get_ID() == Record_ID)
					continue;
				po.deleteEx(true);
				count++;
			}
			if (count > 0)
				if (log.isLoggable(Level.CONFIG)) log.config(table.getName() + " (" + AD_Table_ID + "/" + Record_ID + ") #" + count);
		}
		//	Parent Loop
		for (int i = 0; i < s_parents.length; i++)
		{
			if (s_parents[i] == AD_Table_ID)
			{
				int AD_Table_IDchild = s_parentChilds[i];
				for (KeyNamePair table : cascades)
				{
					String whereClause = " AD_Table_ID=? AND Record_ID IN (SELECT "
							+ s_parentChildNames[i] + "_ID FROM "
							+ s_parentChildNames[i] + " WHERE "
							+ s_parentNames[i] + "_ID=?) ";
					List<PO> poList = new Query(Env.getCtx(), table.getName(), whereClause, trxName)
							.setParameters(AD_Table_IDchild, Record_ID)
							.list();
					
					int count = 0;
					for(PO po : poList)
					{
						po.deleteEx(true);
						count++;
					}
					if(count > 0) {
						if (log.isLoggable(Level.CONFIG)) log.config(table.getName() + " " + s_parentNames[i]  
								+ " (" + AD_Table_ID + "/" + Record_ID + ") #" + count);
					}
				}
			}
		}
		return true;
	}	//	deleteCascade

	//IDEMPIERE-2060
	/**
	 * @param tableName
	 * @param Record_ID
	 * @param trxName
	 */
	public static void deleteModelCascade(String tableName, int Record_ID, String trxName) {
		KeyNamePair[] tables = getTablesWithModelCascade(tableName, trxName);
		for (KeyNamePair table : tables) {
			int dependentTableId = table.getKey();
			String dependentColumnName = table.getName();
			String dependentWhere = dependentColumnName + "=?";
			List<PO> poList = new Query(Env.getCtx(), 
					MTable.get(dependentTableId).getTableName(),
					dependentWhere,
					trxName).setParameters(Record_ID).list();
			for (PO po : poList) {
				po.deleteEx(true, trxName);
			}
		}
	}

	/**
	 * @param tableName
	 * @param trxName
	 * @return
	 */
	private static KeyNamePair[] getTablesWithModelCascade(String tableName, String trxName) {
		StringBuilder key = new StringBuilder(MColumn.FKCONSTRAINTTYPE_ModelCascade).append("|").append(tableName);
		KeyNamePair[] tables = s_po_record_tables_cache.get(key.toString());
		if (tables != null)
			return tables;
		final String sql = ""
				+ "SELECT t.AD_Table_ID, "
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
			tables = new KeyNamePair[dependents.size()];
			for (int i=0; i<dependents.size(); i++) {
				List<Object> row = dependents.get(i);
				int dependentTableId = ((BigDecimal)row.get(0)).intValue();
				String dependentColumnName = (String) row.get(1);
				KeyNamePair vnp = new KeyNamePair(dependentTableId, dependentColumnName);
				tables[i] = vnp;
			}
		} else {
			tables = new KeyNamePair[0];
		}
		s_po_record_tables_cache.put(key.toString(), tables);
		return tables;
	}
	
	/**
	 * If a referencing Record ID or Record UU exists to the deleted record, set it to NULL 
	 * @param AD_Table_ID
	 * @param Record_ID
	 * @param trxName
	 */
	public static void setRecordIdNull(int AD_Table_ID, int Record_ID, String trxName){
		KeyNamePair[] tables = getTablesWithRecordIDColumn(MColumn.FKCONSTRAINTTYPE_ModelSetNull, trxName);
		// Table loop
		for (KeyNamePair table : tables) {
			List<PO> poList = new Query(Env.getCtx(), table.getName(), " AD_Table_ID = ? AND Record_ID = ? ", trxName)
					.setParameters(AD_Table_ID, Record_ID)
					.list();
			
			int count = 0;
			for(PO po : poList) {
				if (po.get_Table_ID() == AD_Table_ID && po.get_ID() == Record_ID)
					continue;
				if (po.isColumnMandatory(po.get_ColumnIndex("Record_ID")))
					po.set_Value("Record_ID", 0);
				else
					po.set_Value("Record_ID", null);
				po.saveEx(trxName);
				count++;
			}
			if (count > 0) {
				if (log.isLoggable(Level.CONFIG)) log.config(table.getName() + " (" + AD_Table_ID + "/" + Record_ID + ") #" + count);
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
		KeyNamePair[] restricts = getTablesWithRecordIDColumn(MColumn.FKCONSTRAINTTYPE_ModelNoAction_ForbidDeletion, trxName);
		//	Table Loop only
		for (int i = 0; i < restricts.length; i++)
		{
			//	SELECT 1 FROM table WHERE AD_Table_ID=#1 AND Record_ID=#2 FETCH FIRST 1 ROWS ONLY
			StringBuilder sqlb = new StringBuilder ("SELECT 1 FROM ")
				.append(restricts[i].getName())
				.append(" WHERE AD_Table_ID=? AND Record_ID=?");
			String sql = DB.getDatabase().addPagingSQL(sqlb.toString(), 1, 1);
			int no = DB.getSQLValueEx(trxName, sql.toString(), AD_Table_ID, Record_ID);
			if (no == 1)
				return Msg.getMsg(Env.getCtx(), "DeleteErrorDependent") + " -> " + restricts[i].getName();
		}
		return null;
	}	//	exists

	/**
	 * Get array of tables which has a Record_ID column with the defined Constraint Type
	 * @param constraintType - FKConstraintType of AD_Column
	 * @param trxName
	 * @return array of KeyNamePair<AD_Table_ID, TableName> 
	 */
	private static KeyNamePair[] getTablesWithRecordIDColumn(String constraintType, String trxName) {
		KeyNamePair[] tables = s_po_record_tables_cache.get(constraintType);
		if (tables != null)
			return tables;
		List<MTable> listTables = new Query(Env.getCtx(), MTable.Table_Name, "c.AD_Reference_ID=? AND c.FKConstraintType=?", trxName)
				.addJoinClause("JOIN AD_Column c ON (c.AD_Table_ID=AD_Table.AD_Table_ID)")
				.setOnlyActiveRecords(true)
				.setParameters(DisplayType.RecordID, constraintType)
				.list();
		tables = new KeyNamePair[listTables.size()];
		for (int i=0; i<listTables.size(); i++) {
			MTable table = listTables.get(i);
			tables[i] = new KeyNamePair(table.getAD_Table_ID(), table.getTableName());
		}
		s_po_record_tables_cache.put(constraintType, tables);
		return tables;
	}

}	//	PO_Record
