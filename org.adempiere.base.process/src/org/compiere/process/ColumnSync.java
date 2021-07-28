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
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
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

	/* Date From */
	private Timestamp p_DateFrom = null;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			switch (name) {
			case "DateFrom": p_DateFrom = para.getParameterAsTimestamp(); break;
			default:
				if (log.isLoggable(Level.INFO))
					log.log(Level.INFO, "Custom Parameter: " + name + "=" + para.getInfo());
				break;
			}
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

		MColumn columnCalled = new MColumn (getCtx(), p_AD_Column_ID, get_TrxName());
		if (columnCalled.get_ID() == 0)
			throw new AdempiereUserError("@NotFound@ @AD_Column_ID@ " + p_AD_Column_ID);

		MTable table = new MTable(getCtx(), columnCalled.getAD_Table_ID(), get_TrxName());
		if (table.get_ID() == 0)
			throw new AdempiereUserError("@NotFound@ @AD_Table_ID@ " + columnCalled.getAD_Table_ID());

		String whereClause;
		List<Object> params = new ArrayList<Object>();
		if (p_DateFrom == null) {
			whereClause = "AD_Column_ID=?";
			params.add(p_AD_Column_ID);
		} else {
			whereClause = "(AD_Column_ID=? OR (AD_Table_ID=? AND Updated>?))";
			params.add(p_AD_Column_ID);
			params.add(table.getAD_Table_ID());
			params.add(p_DateFrom);
		}

		StringBuilder allSql = new StringBuilder();
		List<MColumn> columns = new Query(getCtx(), MColumn.Table_Name, whereClause, get_TrxName())
				.setParameters(params)
				.list();

	  for (MColumn column : columns) {
		
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
				if (DB.isOracle()) {
					// IDEMPIERE-3842 problem with oracle alter CLOB or BLOB
					int actualType = rs.getInt("DATA_TYPE");
					if (actualType == Types.CLOB) {
						if (sql.contains(" MODIFY " + column.getColumnName() + " CLOB")) {
							// trying to make CLOB a column that is already a CLOB
							sql = sql.replaceFirst(" MODIFY " + column.getColumnName() + " CLOB", " MODIFY " + column.getColumnName());
						}
					} else if (actualType == Types.BLOB) {
						if (sql.contains(" MODIFY " + column.getColumnName() + " BLOB")) {
							// trying to make BLOB a column that is already a BLOB
							sql = sql.replaceFirst(" MODIFY " + column.getColumnName() + " BLOB", " MODIFY " + column.getColumnName());
						}
					}
				}
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
					String fkConstraintSql = MColumn.getForeignKeyConstraintSql(md, catalog, schema, tableName, table, col, false);
					if (fkConstraintSql != null && fkConstraintSql.length() > 0)
						sql += fkConstraintSql;
				}
			}
			else
			{
				String fkConstraintSql = MColumn.getForeignKeyConstraintSql(md, catalog, schema, tableName, table, column, false);
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
			allSql.append(sql);
			if (isNoTable)
				break;
			commitEx();
		} finally {
			DB.close(rs);
			rs = null;
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {}
			}
		}
	  }
	  return allSql.toString();
	}	//	doIt
	
}	//	ColumnSync
