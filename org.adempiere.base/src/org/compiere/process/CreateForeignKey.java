/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.compiere.process;

import java.math.BigDecimal;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.logging.Level;

import org.compiere.model.DatabaseKey;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

/**
 * Create foreign key process
 * @author Elaine
 *
 */
public class CreateForeignKey extends SvrProcess {

	/** Table 			*/
	private int 		p_AD_Table_ID = 0;
	/** Column 			*/
	private int 		p_AD_Column_ID = 0;
	
	private int			countTable = 0;
	private int			countForeignKey = 0;
	private int			countError = 0;
	
	@Override
	protected void prepare() 
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_Table_ID"))
				p_AD_Table_ID = para[i].getParameterAsInt();
			else if (name.equals("AD_Column_ID"))
				p_AD_Column_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception 
	{
		if (log.isLoggable(Level.INFO)) log.info("AD_Table_ID=" + p_AD_Table_ID + ", AD_Column_ID=" + p_AD_Column_ID);
				
		Trx trx = Trx.get(get_TrxName(), true);
		DatabaseMetaData md = trx.getConnection().getMetaData();
		
		if (p_AD_Column_ID > 0)
		{
			MColumn column = new MColumn(getCtx(), p_AD_Column_ID, get_TrxName());
			if (column != null)
			{
				MTable table = new MTable(getCtx(), column.getAD_Table_ID(), get_TrxName());
				if (table != null)
				{
					if (!column.isKey() && !column.getColumnName().equals(PO.getUUIDColumnName(table.getTableName())))
						processDatabaseTableColumn(md, table, column);
				}
			}
		}
		else if (p_AD_Table_ID > 0)
		{
			MTable table = new MTable(getCtx(), p_AD_Table_ID, get_TrxName());
			if (table != null)
				processDatabaseTableColumn(md, table, null);
		}
		else
			processDatabase(md);
		
		trx.close();
		
		return Msg.getMsg(getCtx(), "CreateForeignKeyProcessResult", new Object[] {countTable, countForeignKey, countError});
	}
	
	private void processDatabase(DatabaseMetaData md) throws Exception 
	{
		String tableName = null;		
		String catalog = DB.getDatabase().getCatalog();
		String schema = DB.getDatabase().getSchema();		
		String[] types = {"TABLE"};
		
		ResultSet rs = md.getTables(catalog, schema, tableName, types);
		while (rs.next())
		{
			String dbTableName = rs.getString("TABLE_NAME");			
			if (dbTableName == null)
				continue;
			MTable table = MTable.get(getCtx(), dbTableName);
			if (table != null)	// exists in AD_Table
				processDatabaseTableColumn(md, table, null);
		}

		rs.close();
	}
	
	private void processDatabaseTableColumn(DatabaseMetaData md, MTable table, MColumn column) throws Exception 
	{		
		Hashtable<String, DatabaseKey> htForeignKeys = new Hashtable<String, DatabaseKey>();
		
		String catalog = DB.getDatabase().getCatalog();
		String schema = DB.getDatabase().getSchema();
		
		String tableName = table.getTableName();		
		if (md.storesUpperCaseIdentifiers())
			tableName = tableName.toUpperCase();
		else if (md.storesLowerCaseIdentifiers())
			tableName = tableName.toLowerCase();
		
		addLog(Msg.getMsg(getCtx(), "CreateForeignKeyProcessTable") + tableName);
		addLog(table.getAD_Table_ID(), null, null, table.toString(), table.get_Table_ID(), table.getAD_Table_ID());
		++countTable;
		
		if (column == null)
		{
			ResultSet rs = md.getImportedKeys(catalog, schema, tableName);
			while (rs.next())
			{
				String dbFKName = rs.getString("FK_NAME");			
				if (dbFKName == null)
					continue;
				
				String dbFKTable = rs.getString("FKTABLE_NAME");
				short deleteRule = rs.getShort("DELETE_RULE");
	
				String key = dbFKName.toLowerCase();
				DatabaseKey dbForeignKey = htForeignKeys.get(key);
				if (dbForeignKey == null)
					dbForeignKey = new DatabaseKey(dbFKName, dbFKTable, new String[30], deleteRule);
							
				String columnName = rs.getString("FKCOLUMN_NAME");
				int pos = (rs.getShort("KEY_SEQ"));				
				if (pos > 0)
					dbForeignKey.getKeyColumns()[pos-1] = columnName;
				
				htForeignKeys.put(key, dbForeignKey);
			}
			rs.close();
			
			Enumeration<String> en = htForeignKeys.keys();
			while (en.hasMoreElements())
			{
				String key = en.nextElement();
				DatabaseKey dbForeignKey = htForeignKeys.get(key);
				if (dbForeignKey.getKeyColumns()[1] != null)
					htForeignKeys.remove(key);
			}
			
			String getColumnIDSql = "SELECT AD_Column_ID FROM AD_Column WHERE AD_Table_ID = ? AND LOWER(ColumnName) = ?";
			rs = md.getColumns(catalog, schema, tableName, null);
			while (rs.next())
			{
				String columnName = rs.getString("COLUMN_NAME");
				if (columnName == null)
					continue;
				
				int AD_Column_ID = DB.getSQLValue(null, getColumnIDSql, table.getAD_Table_ID(), columnName.toLowerCase());
				if (AD_Column_ID > 0)
				{
					column = MColumn.get(getCtx(), AD_Column_ID);
					if (column == null)
						continue;
					
					boolean modified = false;
					en = htForeignKeys.keys();
					while (en.hasMoreElements())
					{
						String key = en.nextElement();
						DatabaseKey dbForeignKey = htForeignKeys.get(key);
						
						String dbDeleteRule = MColumn.FKCONSTRAINTTYPE_NoAction;
						if (dbForeignKey.getDeleteRule() == DatabaseMetaData.importedKeyCascade)
							dbDeleteRule = MColumn.FKCONSTRAINTTYPE_Cascade;
						else if (dbForeignKey.getDeleteRule() == DatabaseMetaData.importedKeySetNull)
							dbDeleteRule = MColumn.FKCONSTRAINTTYPE_SetNull;
						
						String fkConstraintType = column.getFKConstraintType();
						if (fkConstraintType == null)
							fkConstraintType = MColumn.FKCONSTRAINTTYPE_NoAction;
						
						if (dbForeignKey.getKeyColumns()[0].equalsIgnoreCase(column.getColumnName()))
						{
							if (dbDeleteRule.equals(fkConstraintType))
							{
								addLog(Msg.getMsg(getCtx(), "CreateForeignKeyProcessColumn") + column.getColumnName());
								addLog(column.getAD_Column_ID(), null, null, column.toString(), column.get_Table_ID(), column.getAD_Column_ID());
								addLog(0, null, null, Msg.getMsg(getCtx(), "CreateForeignKeyProcessExists") + dbForeignKey.getKeyName());
								modified = true;
								column.setFKConstraintName(dbForeignKey.getKeyName());
								column.setFKConstraintType(fkConstraintType);
								column.saveEx();
								break;
							}
							else if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_DoNotCreate))
							{
								addLog(Msg.getMsg(getCtx(), "CreateForeignKeyProcessColumn") + column.getColumnName());
								addLog(column.getAD_Column_ID(), null, null, column.toString(), column.get_Table_ID(), column.getAD_Column_ID());
								addLog(0, null, null, Msg.getMsg(getCtx(), "CreateForeignKeyProcessExists") + dbForeignKey.getKeyName());
								
								StringBuilder sql = new StringBuilder();
								sql.append("ALTER TABLE ").append(table.getTableName());
								sql.append(" DROP CONSTRAINT ").append(dbForeignKey.getKeyName());

								Trx trx = Trx.get(Trx.createTrxName("CreateForeignKey"), true);
								try {
									int rvalue = DB.executeUpdate(sql.toString(), (Object[]) null, true, trx.getTrxName());
									addLog(0, null, new BigDecimal(rvalue), sql.toString());
								} catch (Exception e) {
									addLog(Msg.getMsg(getCtx(), "Error") + e.getLocalizedMessage());
									if (trx != null)
										trx.rollback();
								} finally {
									if (trx != null)
										trx.close();
								}
								
								modified = true;
								column.setFKConstraintName(dbForeignKey.getKeyName());
								column.setFKConstraintType(fkConstraintType);
								column.saveEx();
								break;
							}
						}
					}
					
					if (modified)
						continue;
										
					if (!column.isKey() && !column.getColumnName().equals(PO.getUUIDColumnName(table.getTableName())))
					{
						String fkConstraint = getForeignKeyConstraint(md, table, column);
						if (fkConstraint != null && fkConstraint.length() > 0) 
						{
							addLog(Msg.getMsg(getCtx(), "CreateForeignKeyProcessColumn") + column.getColumnName());
							addLog(column.getAD_Column_ID(), null, null, column.toString(), column.get_Table_ID(), column.getAD_Column_ID());

							StringBuilder sql = new StringBuilder();
							sql.append("ALTER TABLE ").append(table.getTableName());
							sql.append(" ADD ");
							sql.append(fkConstraint);

							Trx trx = Trx.get(Trx.createTrxName("CreateForeignKey"), true);
							try {
								int rvalue = DB.executeUpdate(sql.toString(), (Object[]) null, true, trx.getTrxName());
								addLog(0, null, new BigDecimal(rvalue), sql.toString());
								if (rvalue == -1)
									++countError;
								else
									++countForeignKey;
							} catch (Exception e) {
								addLog(Msg.getMsg(getCtx(), "Error") + e.getLocalizedMessage());
								if (trx != null)
									trx.rollback();
								++countError;
							} finally {
								if (trx != null)
									trx.close();
							}
						}
					}
				}
			}
			rs.close();
		}
		else
		{
			int refid = column.getAD_Reference_ID();
			if (refid != DisplayType.List && refid != DisplayType.Payment)
			{
				String referenceTableName = column.getReferenceTableName();
				
				if (referenceTableName != null)
				{
					if (md.storesUpperCaseIdentifiers())
						referenceTableName = referenceTableName.toUpperCase();
					else if (md.storesLowerCaseIdentifiers())
						referenceTableName = referenceTableName.toLowerCase();
					
					ResultSet rs = md.getCrossReference(catalog, schema, referenceTableName, catalog, schema, tableName);
					while (rs.next())
					{
						String dbFKName = rs.getString("FK_NAME");			
						if (dbFKName == null)
							continue;
						
						String dbFKTable = rs.getString("FKTABLE_NAME");
						short deleteRule = rs.getShort("DELETE_RULE");
			
						String key = dbFKName.toLowerCase();
						DatabaseKey dbForeignKey = htForeignKeys.get(key);
						if (dbForeignKey == null)
							dbForeignKey = new DatabaseKey(dbFKName, dbFKTable, new String[30], deleteRule);
									
						String columnName = rs.getString("FKCOLUMN_NAME");
						int pos = (rs.getShort("KEY_SEQ"));				
						if (pos > 0)
							dbForeignKey.getKeyColumns()[pos-1] = columnName;
						
						htForeignKeys.put(key, dbForeignKey);
					}
					rs.close();
					
					Enumeration<String> en = htForeignKeys.keys();
					while (en.hasMoreElements())
					{
						String key = en.nextElement();
						DatabaseKey dbForeignKey = htForeignKeys.get(key);
						if (dbForeignKey.getKeyColumns()[1] != null)
							htForeignKeys.remove(key);
					}
					
					en = htForeignKeys.keys();
					while (en.hasMoreElements())
					{
						String key = en.nextElement();
						DatabaseKey dbForeignKey = htForeignKeys.get(key);
						if (dbForeignKey.getKeyColumns()[0].equalsIgnoreCase(column.getColumnName()))
						{
							addLog(Msg.getMsg(getCtx(), "CreateForeignKeyProcessColumn") + column.getColumnName());
							addLog(column.getAD_Column_ID(), null, null, column.toString(), column.get_Table_ID(), column.getAD_Column_ID());
							addLog(0, null, null, Msg.getMsg(getCtx(), "CreateForeignKeyProcessExists") + dbForeignKey.getKeyName());
							column.setFKConstraintName(dbForeignKey.getKeyName());
							column.saveEx();
							return;
						}
					}
					
					if (!column.isKey() && !column.getColumnName().equals(PO.getUUIDColumnName(table.getTableName())))
					{
						String fkConstraint = getForeignKeyConstraint(md, table, column);
						if (fkConstraint != null && fkConstraint.length() > 0) 
						{
							addLog(Msg.getMsg(getCtx(), "CreateForeignKeyProcessColumn") + column.getColumnName());
							addLog(column.getAD_Column_ID(), null, null, column.toString(), column.get_Table_ID(), column.getAD_Column_ID());

							StringBuilder sql = new StringBuilder();
							sql.append("ALTER TABLE ").append(table.getTableName());
							sql.append(" ADD ");
							sql.append(fkConstraint);
							
							Trx trx = Trx.get(Trx.createTrxName("CreateForeignKey"), true);
							try {
								int rvalue = DB.executeUpdate(sql.toString(), (Object[]) null, true, trx.getTrxName());
								addLog(0, null, new BigDecimal(rvalue), sql.toString());
								if (rvalue == -1)
									++countError;
								else
									++countForeignKey;
							} catch (Exception e) {
								addLog(Msg.getMsg(getCtx(), "Error") + e.getLocalizedMessage());
								if (trx != null)
									trx.rollback();
								++countError;
							} finally {
								if (trx != null)
									trx.close();
							}
						}
					}
				}
			}
		}
	}
	
	public static String getForeignKeyConstraint(DatabaseMetaData md, MTable table, MColumn column) throws Exception 
	{		
		if (!column.isKey() && !column.getColumnName().equals(PO.getUUIDColumnName(table.getTableName())))
		{
			String fkConstraintType = column.getFKConstraintType();
			if (fkConstraintType == null)
				fkConstraintType = MColumn.FKCONSTRAINTTYPE_NoAction;
			
			if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_DoNotCreate))
				return "";

			int refid = column.getAD_Reference_ID();
			if (refid != DisplayType.List && refid != DisplayType.Payment)
			{
				String referenceTableName = column.getReferenceTableName();
				if (referenceTableName != null)
				{
					DatabaseKey primaryKey = getPrimaryKey(md, referenceTableName);
					
					if (primaryKey != null)
					{
						String fkConstraintName = column.getFKConstraintName();						
						if (fkConstraintName == null || fkConstraintName.trim().length() == 0)
						{
							String columnName = column.getColumnName();
							if (columnName.toUpperCase().endsWith("_ID"))
								columnName = columnName.substring(0, columnName.length() - 3);
							
							StringBuilder constraintName = new StringBuilder();
							constraintName.append(columnName.replace("_", ""));
							constraintName.append("_");
							constraintName.append(table.getTableName().replace("_", ""));
							if (constraintName.length() > 30)
								constraintName = new StringBuilder(constraintName.substring(0, 30));
							fkConstraintName = constraintName.toString();
						}
						
						StringBuilder fkConstraint = new StringBuilder();
						fkConstraint.append("CONSTRAINT ").append(fkConstraintName);
						fkConstraint.append(" FOREIGN KEY (").append(column.getColumnName()).append(") REFERENCES ");
						fkConstraint.append(primaryKey.getKeyTable()).append("(").append(primaryKey.getKeyColumns()[0]);
						for (int i = 1; i < primaryKey.getKeyColumns().length; i++)
						{
							if (primaryKey.getKeyColumns()[i] == null)
								break;
							fkConstraint.append(", ").append(primaryKey.getKeyColumns()[i]);
						}
						fkConstraint.append(")");
						
						if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_NoAction))
							;
						else if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_Cascade))
							fkConstraint.append(" ON DELETE CASCADE");
						else if (fkConstraintType.equals(MColumn.FKCONSTRAINTTYPE_SetNull))
							fkConstraint.append(" ON DELETE SET NULL");
						
						fkConstraint.append(" DEFERRABLE INITIALLY DEFERRED");
						
						column.setFKConstraintName(fkConstraintName);
						column.setFKConstraintType(fkConstraintType);
						column.saveEx();
						
						return fkConstraint.toString();
					}
				}
			}
		}
		
		return "";
	}
	
	public static DatabaseKey getPrimaryKey(DatabaseMetaData md, String primaryTableName) throws Exception 
	{
		DatabaseKey primaryKey = null;
		
		String catalog = DB.getDatabase().getCatalog();
		String schema = DB.getDatabase().getSchema();
		
		String tableName = primaryTableName;		
		if (md.storesUpperCaseIdentifiers())
			tableName = tableName.toUpperCase();
		else if (md.storesLowerCaseIdentifiers())
			tableName = tableName.toLowerCase();
		
		ResultSet rs = md.getPrimaryKeys(catalog, schema, tableName);
		while (rs.next())
		{
			String primaryKeyName = rs.getString("PK_NAME");			
			if (primaryKeyName == null)
				continue;
			
			String primaryKeyTableName = rs.getString("TABLE_NAME");
			short deleteRule = -1;
			
			if (primaryKey == null)
				primaryKey = new DatabaseKey(primaryKeyName, primaryKeyTableName, new String[30], deleteRule);
			
			String primaryKeyColumn = rs.getString("COLUMN_NAME");
			int pos = (rs.getShort("KEY_SEQ"));				
			if (pos > 0)
				primaryKey.getKeyColumns()[pos-1] = primaryKeyColumn;
		}
		rs.close();
		return primaryKey;
	}
}
