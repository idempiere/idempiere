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
package org.compiere.process;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.logging.Level;

import org.compiere.model.DatabaseKey;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.ValueNamePair;

/**
 *	Synchronize Column with Database
 *	
 *  @author Victor Perez, Jorg Janke
 *  @version $Id: ColumnSync.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 *  
 *  @author Teo Sarca
 *  	<li>BF [ 2854358 ] SyncColumn should load table in transaction
 *  		https://sourceforge.net/tracker/?func=detail&aid=2854358&group_id=176962&atid=879332
 */
public class ColumnSync extends SvrProcess
{
	/** The Column				*/
	private int			p_AD_Column_ID = 0;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;			
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_AD_Column_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	Process
	 *	@return message
	 *	@throws Exception
	 */
	protected String doIt() throws Exception
	{
		if (log.isLoggable(Level.INFO)) log.info("C_Column_ID=" + p_AD_Column_ID);
		if (p_AD_Column_ID == 0)
			throw new AdempiereUserError("@No@ @AD_Column_ID@");
		MColumn column = new MColumn (getCtx(), p_AD_Column_ID, get_TrxName());
		if (column.get_ID() == 0)
			throw new AdempiereUserError("@NotFound@ @AD_Column_ID@ " + p_AD_Column_ID);
		
		MTable table = new MTable(getCtx(), column.getAD_Table_ID(), get_TrxName());
		if (table.get_ID() == 0)
			throw new AdempiereUserError("@NotFound@ @AD_Table_ID@ " + column.getAD_Table_ID());
		
		//	Find Column in Database
		Connection conn = null;
		ResultSet rs = null;
		try {
			conn = DB.getConnectionRO();
			DatabaseMetaData md = conn.getMetaData();
			String catalog = DB.getDatabase().getCatalog();
			String schema = DB.getDatabase().getSchema();
			String tableName = table.getTableName();
			if (md.storesUpperCaseIdentifiers())
			{
				tableName = tableName.toUpperCase();
			}
			else if (md.storesLowerCaseIdentifiers())
			{
				tableName = tableName.toLowerCase();
			}
			int noColumns = 0;
			String sql = null;
			//
			rs = md.getColumns(catalog, schema, tableName, null);
			while (rs.next())
			{
				noColumns++;
				String columnName = rs.getString ("COLUMN_NAME");
				if (!columnName.equalsIgnoreCase(column.getColumnName()))
					continue;
				
				//	update existing column
				boolean notNull = DatabaseMetaData.columnNoNulls == rs.getInt("NULLABLE");
				sql = column.getSQLModify(table, column.isMandatory() != notNull);
				break;
			}
			DB.close(rs);
			rs = null;
		
			boolean isNoTable = noColumns == 0;
			//	No Table
			if (isNoTable)
				sql = table.getSQLCreate ();
			//	No existing column
			else if (sql == null)
				sql = column.getSQLAdd(table);
			
			if (isNoTable)
			{
				MColumn[] cols = table.getColumns(false);
				for (MColumn col : cols)
				{
					String fkConstraintSql = getForeignKeyConstraintSql(md, catalog, schema, tableName, table, col);
					if (fkConstraintSql != null && fkConstraintSql.length() > 0)
						sql += fkConstraintSql;
				}
			}
			else
			{
				String fkConstraintSql = getForeignKeyConstraintSql(md, catalog, schema, tableName, table, column);
				if (fkConstraintSql != null && fkConstraintSql.length() > 0)
					sql += fkConstraintSql;
			}
			
			int no = 0;
			if (sql.indexOf(DB.SQLSTATEMENT_SEPARATOR) == -1)
			{
				no = DB.executeUpdate(sql, false, get_TrxName());
				addLog (0, null, new BigDecimal(no), sql);
			}
			else
			{
				String statements[] = sql.split(DB.SQLSTATEMENT_SEPARATOR);
				for (int i = 0; i < statements.length; i++)
				{
					int count = DB.executeUpdateEx(statements[i], get_TrxName());
					addLog (0, null, new BigDecimal(count), statements[i]);
					no += count;
				}
			}
	
			if (no == -1)
			{
				StringBuilder msg = new StringBuilder("@Error@ ");
				ValueNamePair pp = CLogger.retrieveError();
				if (pp != null)
					msg = new StringBuilder(pp.getName()).append(" - ");
				msg.append(sql);
				throw new AdempiereUserError (msg.toString());
			}
			return sql;
		} finally {
			DB.close(rs);
			rs = null;
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {}
			}
		}
	}	//	doIt
	
	private String getForeignKeyConstraintSql(DatabaseMetaData md, String catalog, String schema, String tableName, MTable table, MColumn column) throws Exception
	{
		StringBuilder fkConstraintSql = new StringBuilder();
		
		if (!column.isKey() && !column.getColumnName().equals(PO.getUUIDColumnName(table.getTableName())))
		{
			int refid = column.getAD_Reference_ID();
			if (refid != DisplayType.List && refid != DisplayType.Payment)
			{
				String referenceTableName = column.getReferenceTableName();
				if (referenceTableName != null)
				{
					Hashtable<String, DatabaseKey> htForeignKeys = new Hashtable<String, DatabaseKey>();
					
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
			
						String key = dbFKName.toLowerCase();
						DatabaseKey dbForeignKey = htForeignKeys.get(key);
						if (dbForeignKey == null)
							dbForeignKey = new DatabaseKey(dbFKName, dbFKTable, new String[30]);
									
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
					
					boolean modified = false;
					en = htForeignKeys.keys();
					while (en.hasMoreElements())
					{
						String key = en.nextElement();
						DatabaseKey dbForeignKey = htForeignKeys.get(key);
						if (dbForeignKey.getKeyColumns()[0].equalsIgnoreCase(column.getColumnName()))
						{
							DatabaseKey primaryKey = CreateForeignKey.getPrimaryKey(md, referenceTableName);
							if (primaryKey != null)
							{
								fkConstraintSql.append(DB.SQLSTATEMENT_SEPARATOR);
								fkConstraintSql.append("ALTER TABLE ").append(table.getTableName());
								fkConstraintSql.append(" DROP CONSTRAINT ").append(dbForeignKey.getKeyName());

								StringBuilder fkConstraint = new StringBuilder();
								fkConstraint.append("CONSTRAINT ").append(dbForeignKey.getKeyName());
								fkConstraint.append(" FOREIGN KEY (").append(column.getColumnName()).append(") REFERENCES ");
								fkConstraint.append(primaryKey.getKeyTable()).append("(").append(primaryKey.getKeyColumns()[0]);
								for (int i = 1; i < primaryKey.getKeyColumns().length; i++)
								{
									if (primaryKey.getKeyColumns()[i] == null)
										break;
									fkConstraint.append(", ").append(primaryKey.getKeyColumns()[i]);
								}
								fkConstraint.append(")");
																
								fkConstraintSql.append(DB.SQLSTATEMENT_SEPARATOR);
								fkConstraintSql.append("ALTER TABLE ").append(table.getTableName());
								fkConstraintSql.append(" ADD ");
								fkConstraintSql.append(fkConstraint);
							}
							modified = true;
							break;
						}
					}
					
					if (!modified)
					{
						String fkConstraint = CreateForeignKey.getForeignKeyConstraint(md, table, column);
						if (fkConstraint != null && fkConstraint.length() > 0)
						{
							fkConstraintSql.append(DB.SQLSTATEMENT_SEPARATOR);
							fkConstraintSql.append("ALTER TABLE ").append(table.getTableName());
							fkConstraintSql.append(" ADD ");
							fkConstraintSql.append(fkConstraint);
						}
					}
				}
			}
		}
		return fkConstraintSql.toString();
	}

}	//	ColumnSync
