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

import java.io.Serializable;
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
import org.compiere.util.Util;

/**
 * 	Maintain AD_Table_ID/Record_ID constraint
 *	
 *  @author Jorg Janke
 *  @version $Id: PO_Record.java,v 1.4 2006/07/30 00:58:04 jjanke Exp $
 */
public class PO_Record
{
	/** Cache for arrays of KeyNamePair<AD_Table_ID, TableName> for types of deletion: Cascade, Set Null, No Action */
	private static final CCache<String, KeyNamePair[]> s_po_record_tables_cache = new CCache<>(null, "PORecordTables", 100, 120, false);

	/**	Logger	*/
	private static CLogger log = CLogger.getCLogger (PO_Record.class);
	
	/**
	 * 	Delete Cascade including (selected)parent relationships
	 *	@param AD_Table_ID table
	 *	@param Record_IDorUU record ID (int) or UUID (String)
	 *  @param whereTables filter for the Tables
	 *	@param trxName transaction
	 *	@return false if could not be deleted
	 */
	protected static boolean deleteRecordCascade (int AD_Table_ID, Serializable Record_IDorUU, String whereTables, String trxName)
	{
		int refId;
		String columnName;
		if (Record_IDorUU instanceof Integer) {
			refId = DisplayType.RecordID;
			columnName = "Record_ID";
		} else if (Record_IDorUU instanceof String) {
			refId = DisplayType.RecordUU;
			columnName = "Record_UU";
		} else {
			throw new IllegalArgumentException(Record_IDorUU.getClass().getName() + " not supported for ID/UUID");
		}
		KeyNamePair[] cascades = getTablesWithConstraintType(refId, MColumn.FKCONSTRAINTTYPE_ModelCascade, whereTables, trxName);
		//	Table Loop
		StringBuilder whereClause = new StringBuilder("AD_Table_ID=? AND ").append(columnName).append("=?");
		for (KeyNamePair table : cascades)
		{
			//	DELETE FROM table WHERE AD_Table_ID=#1 AND Record_ID=#2
			List<PO> poList = new Query(Env.getCtx(), table.getName(), whereClause.toString(), trxName)
					.setParameters(AD_Table_ID, Record_IDorUU)
					.list();

			int count = 0;
			for(PO po : poList)
			{
				if (   po.get_Table_ID() == AD_Table_ID
					&& (   (Record_IDorUU instanceof Integer && po.get_ID() == (Integer)Record_IDorUU)
						|| (Record_IDorUU instanceof String && Record_IDorUU.equals(po.get_UUID()))
					   )
					)
					continue;
				po.deleteEx(true);
				count++;
			}
			if (count > 0)
				if (log.isLoggable(Level.CONFIG)) log.config(table.getName() + " (" + AD_Table_ID + "/" + Record_IDorUU + ") #" + count);
		}
		return true;
	}	//	deleteRecordIdCascade

	//IDEMPIERE-2060
	/**
	 * Delete dependent records.<br/>
	 * This is model class implementation of the delete cascade option of foreign key constraint.
	 * @param tableName
	 * @param Record_IDorUU record ID (int) or UUID (String)
	 * @param trxName
	 */
	public static void deleteModelCascade(String tableName, Serializable Record_IDorUU, String trxName) {
		int refId;
		if (Record_IDorUU instanceof Integer) {
			refId = DisplayType.RecordID;
		} else if (Record_IDorUU instanceof String) {
			refId = DisplayType.RecordUU;
		} else {
			throw new IllegalArgumentException(Record_IDorUU.getClass().getName() + " not supported for ID/UUID");
		}
		KeyNamePair[] tables = getTablesWithModelCascade(refId, tableName, trxName);
		for (KeyNamePair table : tables) {
			int dependentTableId = table.getKey();
			String dependentColumnName = table.getName();
			String dependentWhere = dependentColumnName + "=?";
			List<PO> poList = new Query(Env.getCtx(), 
					MTable.get(dependentTableId).getTableName(),
					dependentWhere,
					trxName).setParameters(Record_IDorUU).list();
			for (PO po : poList) {
				po.deleteEx(true, trxName);
			}
		}
	}

	/**
	 * Get dependent tables
	 * @param refId AD_Reference_ID - Record_ID or Record_UU
	 * @param tableName
	 * @param trxName
	 * @return array of dependent tables (dependentTableId, dependentColumnName)
	 */
	private static KeyNamePair[] getTablesWithModelCascade(int refId, String tableName, String trxName) {
		int refTableDirId;
		int refTableId;
		int refTableSearchId;
		if (refId == DisplayType.RecordID) {
			refTableDirId = DisplayType.TableDir;
			refTableId = DisplayType.Table;
			refTableSearchId = DisplayType.Search;
		} else if (refId == DisplayType.RecordUU) {
			refTableDirId = DisplayType.TableDirUU;
			refTableId = DisplayType.TableUU;
			refTableSearchId = DisplayType.SearchUU;
		} else {
			throw new IllegalArgumentException(refId + " not supported for ID/UUID");
		}
		StringBuilder key = new StringBuilder(MColumn.FKCONSTRAINTTYPE_ModelCascade).append("|").append(refId).append("|").append(tableName);
		KeyNamePair[] tables = s_po_record_tables_cache.get(key.toString());
		if (tables != null)
			return tables;
		final String sql = """
			SELECT t.AD_Table_ID, 
			       c.ColumnName 
			FROM   AD_Column c 
			       JOIN AD_Table t ON c.AD_Table_ID = t.AD_Table_ID 
			       LEFT JOIN AD_Ref_Table r ON c.AD_Reference_Value_ID = r.AD_Reference_ID 
			       LEFT JOIN AD_Table tr ON r.AD_Table_ID = tr.AD_Table_ID 
			WHERE  t.IsView = 'N' 
			       AND t.IsActive = 'Y' 
			       AND c.IsActive = 'Y' 
			       AND ( ( c.AD_Reference_ID = ? 
			               AND c.ColumnName = ? || '_ID' ) 
			              OR ( c.AD_Reference_ID IN (? , ?) 
			                   AND ( tr.TableName = ? OR ( tr.TableName IS NULL AND c.ColumnName = ? || '_ID' ) ) ) ) 
			       AND c.FKConstraintType = ?""";
		List<List<Object>> dependents = DB.getSQLArrayObjectsEx(trxName, sql, 
				refTableDirId, tableName, refTableId, refTableSearchId, tableName, tableName, MColumn.FKCONSTRAINTTYPE_ModelCascade);
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
	 * If a referencing Record ID or Record UU exists to the deleted record, set it to NULL.<br/>
	 * This is model class implementation of the set null option of foreign key constraint. 
	 * @param AD_Table_ID
	 * @param Record_IDorUU record ID (int) or UUID (String)
	 * @param trxName
	 */
	public static void setRecordNull(int AD_Table_ID, Serializable Record_IDorUU, String trxName){
		int refId;
		String columnName;
		if (Record_IDorUU instanceof Integer) {
			refId = DisplayType.RecordID;
			columnName = "Record_ID";
		} else if (Record_IDorUU instanceof String) {
			refId = DisplayType.RecordUU;
			columnName = "Record_UU";
		} else {
			throw new IllegalArgumentException(Record_IDorUU.getClass().getName() + " not supported for ID/UUID");
		}
		KeyNamePair[] tables = getTablesWithConstraintType(refId, MColumn.FKCONSTRAINTTYPE_ModelSetNull, trxName);
		// Table loop
		StringBuilder whereClause = new StringBuilder("AD_Table_ID=? AND ").append(columnName).append("=?");
		for (KeyNamePair table : tables) {
			List<PO> poList = new Query(Env.getCtx(), table.getName(), whereClause.toString(), trxName)
					.setParameters(AD_Table_ID, Record_IDorUU)
					.list();
			
			int count = 0;
			for(PO po : poList) {
				if (   po.get_Table_ID() == AD_Table_ID
					&& (   (Record_IDorUU instanceof Integer && po.get_ID() == (Integer) Record_IDorUU)
						|| (Record_IDorUU instanceof String && Record_IDorUU.equals(po.get_UUID()))
					   )
				   )
					continue;
				if (po.isColumnMandatory(po.get_ColumnIndex(columnName))) {
					if (Record_IDorUU instanceof Integer)
						po.set_Value(columnName, 0);
					else
						po.set_Value(columnName, "");
				} else {
					po.set_Value(columnName, null);
				}
				po.saveEx(trxName);
				count++;
			}
			if (count > 0) {
				if (log.isLoggable(Level.CONFIG)) log.config(table.getName() + " (" + AD_Table_ID + "/" + Record_IDorUU + ") #" + count);
			}
		}
	}
	
	/**
	 * 	Check if dependent records with delete restrict condition exists for a table/record combination.
	 *	@param AD_Table_ID table
	 *	@param Record_IDorUU record ID (int) or UUID (String)
	 *	@param trxName transaction
	 *	@return error message (Table Name) or null
	 */
	protected static String exists (int AD_Table_ID, Serializable Record_IDorUU, String trxName)
	{
		int refId;
		String columnName;
		if (Record_IDorUU instanceof Integer) {
			refId = DisplayType.RecordID;
			columnName = "Record_ID";
		} else if (Record_IDorUU instanceof String) {
			refId = DisplayType.RecordUU;
			columnName = "Record_UU";
		} else {
			log.warning(Record_IDorUU.getClass().getName() + " not supported for ID/UUID");
			return null;
		}
		KeyNamePair[] restricts = getTablesWithConstraintType(refId, MColumn.FKCONSTRAINTTYPE_ModelNoAction_ForbidDeletion, trxName);
		//	Table Loop only
		for (int i = 0; i < restricts.length; i++)
		{
			//	SELECT 1 FROM table WHERE AD_Table_ID=#1 AND Record_ID=#2 FETCH FIRST 1 ROWS ONLY
			StringBuilder sqlb = new StringBuilder ("SELECT 1 FROM ")
				.append(restricts[i].getName())
				.append(" WHERE AD_Table_ID=? AND ").append(columnName).append("=?");
			String sql = DB.getDatabase().addPagingSQL(sqlb.toString(), 1, 1);
			int no = DB.getSQLValueEx(trxName, sql.toString(), AD_Table_ID, Record_IDorUU);
			if (no == 1)
				return Msg.getMsg(Env.getCtx(), "DeleteErrorDependent") + " -> " + restricts[i].getName();
		}
		return null;
	}	//	exists

	/**
	 * Get array of tables which has a refId column with the defined Constraint Type
	 * @param refId AD_Reference_ID - Record_ID or Record_UU
	 * @param constraintType - FKConstraintType of AD_Column
	 * @param trxName
	 * @return array of KeyNamePair<AD_Table_ID, TableName> 
	 */
	private static KeyNamePair[] getTablesWithConstraintType(int refId, String constraintType, String trxName) {
		return getTablesWithConstraintType(refId, constraintType, null, trxName);
	}

	/**
	 * Get array of tables which has a refId column with the defined Constraint Type
	 * @param refId AD_Reference_ID - Record_ID or Record_UU
	 * @param constraintType - FKConstraintType of AD_Column
	 * @param whereTables - optional filter
	 * @param trxName
	 * @return array of KeyNamePair<AD_Table_ID, TableName> 
	 */
	private static KeyNamePair[] getTablesWithConstraintType(int refId, String constraintType, String whereTables, String trxName) {
		String columnName;
		if (refId == DisplayType.RecordID) {
			columnName = "Record_ID";
		} else if (refId == DisplayType.RecordUU) {
			columnName = "Record_UU";
		} else {
			log.warning(refId + " not supported for ID/UUID");
			return null;
		}
		StringBuilder key = new StringBuilder(constraintType).append("|").append(refId).append("|").append(whereTables);
		KeyNamePair[] tables = s_po_record_tables_cache.get(key.toString());
		if (tables != null)
			return tables;
		String whereClause = "c.AD_Reference_ID=? AND c.FKConstraintType=? AND AD_Table.IsView='N' AND c.ColumnName=?";
		if (! Util.isEmpty(whereTables))
			whereClause = whereClause + " AND (" + whereTables + ")";
		List<MTable> listTables = new Query(Env.getCtx(), MTable.Table_Name, whereClause, trxName)
				.addJoinClause("JOIN AD_Column c ON (c.AD_Table_ID=AD_Table.AD_Table_ID)")
				.setOnlyActiveRecords(true)
				.setParameters(refId, constraintType, columnName)
				.list();
		tables = new KeyNamePair[listTables.size()];
		for (int i=0; i<listTables.size(); i++) {
			MTable table = listTables.get(i);
			tables[i] = new KeyNamePair(table.getAD_Table_ID(), table.getTableName());
		}
		s_po_record_tables_cache.put(key.toString(), tables);
		return tables;
	}

}	//	PO_Record
