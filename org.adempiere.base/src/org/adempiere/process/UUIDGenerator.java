/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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
package org.adempiere.process;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.M_Element;
import org.compiere.model.PO;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;

/**
 * Add UUID column (tableName_UU) to table and update existing records with new UUID.
 * Warning: this process is only safe to run if it have exclusive access to database.
 * @author hengsin
 *
 */
public class UUIDGenerator extends SvrProcess {

	private String tableName;

	/**	Logger							*/
	private static CLogger log = CLogger.getCLogger(UUIDGenerator.class);

	/**
	 * @see org.compiere.process.SvrProcess#prepare()
	 */
	@Override
	protected void prepare() {
		ProcessInfoParameter[] parameters = getProcessInfo().getParameter();
		if (parameters == null || parameters.length == 0)
			return;
		for(ProcessInfoParameter param : parameters) {
			if (param.getParameterName().equals("TableName")) {
				tableName = param.getParameter().toString();
				break;
			}
		}

	}

	/**
	 * @see org.compiere.process.SvrProcess#doIt()
	 */
	@Override
	protected String doIt() throws Exception {
		if (tableName == null || tableName.trim().length() == 0)
			tableName = "%";
		else
			tableName = tableName.trim();
		if (!tableName.endsWith("%"))
			tableName = tableName + "%";
		StringBuilder sql = new StringBuilder("SELECT AD_Table_ID, TableName FROM AD_Table WHERE TableName like ? AND IsView = 'N' AND IsActive='Y'");
		if (DB.isOracle()) {
			sql.append(" ESCAPE '\' ");
		}
		PreparedStatement stmt = null;
		ResultSet rs = null;
		int count = 0;
		try  {
			stmt = DB.prepareStatement(sql.toString(), null);
			stmt.setString(1, tableName);
			rs = stmt.executeQuery();
			while(rs.next()) {
				int AD_Table_ID = rs.getInt(1);
				String cTableName = rs.getString(2);

				String columnName = PO.getUUIDColumnName(cTableName);
				int AD_Column_ID = DB.getSQLValue(null, "SELECT AD_Column_ID FROM AD_Column Where AD_Table_ID = ? AND ColumnName = ?", AD_Table_ID, columnName);
				if (AD_Column_ID <= 0) {
					if (log.isLoggable(Level.INFO)) log.info("Adding UUID to " + cTableName);
					count++;
					//create column
					MColumn mColumn = new MColumn(getCtx(), 0, null);
					mColumn.setAD_Table_ID(AD_Table_ID);
					int AD_Element_ID = DB.getSQLValue(null, "SELECT AD_Element_ID FROM AD_Element WHERE ColumnName=?",columnName);
					if (AD_Element_ID <= 0) {
						M_Element adElement = new M_Element(getCtx(), 0, null);
						adElement.setColumnName(columnName);
						adElement.setName(columnName);
						adElement.setPrintName(columnName);
						adElement.setEntityType("U");
						adElement.saveEx();
						AD_Element_ID = adElement.getAD_Element_ID();
					}
					mColumn.setAD_Element_ID(AD_Element_ID);
					mColumn.setColumnName(columnName);
					mColumn.setAD_Reference_ID(DisplayType.String);
					mColumn.setEntityType("U");
					mColumn.setFieldLength(36);
					mColumn.setName(columnName);
					mColumn.setVersion(Env.ONE);
					mColumn.saveEx();

					syncColumn(mColumn);

					//update db
					updateUUID(mColumn, null);
				}
			}
		} finally {
			DB.close(rs,stmt);
		}
		StringBuilder msgreturn = new StringBuilder().append(count).append(" table altered");
		return msgreturn.toString();
	}

	public static void updateUUID(MColumn column, String trxName) {
		MTable table = (MTable) column.getAD_Table();
		int AD_Column_ID = DB.getSQLValue(null, "SELECT AD_Column_ID FROM AD_Column WHERE AD_Table_ID=? AND ColumnName=?", table.getAD_Table_ID(), table.getTableName()+"_ID");
		StringBuilder sql = new StringBuilder("SELECT ");
		String keyColumn = null;
		List<String> compositeKeys = null;
		if (AD_Column_ID > 0) {
			keyColumn = table.getTableName()+"_ID";
		} else {
			compositeKeys = Arrays.asList(table.getKeyColumns());
		}
		if ((compositeKeys == null || compositeKeys.size() == 0) && keyColumn == null) {
			log.warning("Cannot update orphan table " + table.getTableName() + " (not ID neither parents)");
			return;
		}
		if (compositeKeys == null) {
			sql.append(keyColumn);
		} else {
			for(String s : compositeKeys) {
				sql.append(s).append(",");
			}
			sql.deleteCharAt(sql.length()-1);
		}
		sql.append(" FROM ").append(table.getTableName());
		sql.append(" WHERE ").append(column.getColumnName()).append(" IS NULL ");
		StringBuilder updateSQL = new StringBuilder("UPDATE ");
		updateSQL.append(table.getTableName());
		updateSQL.append(" SET ");
		updateSQL.append(column.getColumnName());
		updateSQL.append("=? WHERE ");
		if (AD_Column_ID > 0) {
			updateSQL.append(keyColumn).append("=?");
		} else {
			for(String s : compositeKeys) {
				updateSQL.append(s).append("=? AND "); 
			}
			int length = updateSQL.length();
			updateSQL.delete(length-5, length); // delete last AND
		}
		
		boolean localTrx = false;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Trx trx = trxName != null ? Trx.get(trxName, false) : null;
		if (trx == null) {
			trx = Trx.get(Trx.createTrxName(), true);
			localTrx = true;
		}
		try {				
			if (localTrx)
				trx.start();
			stmt = DB.prepareStatement(sql.toString(), trx.getTrxName());
			stmt.setFetchSize(100);
			rs = stmt.executeQuery();
			while (rs.next()) {
				if (AD_Column_ID > 0) {
					int recordId = rs.getInt(1);
					if (recordId > MTable.MAX_OFFICIAL_ID) {
						UUID uuid = UUID.randomUUID();
						DB.executeUpdateEx(updateSQL.toString(),new Object[]{uuid.toString(), recordId}, trx.getTrxName());
					}
				} else {
					UUID uuid = UUID.randomUUID();
					List<Object> params = new ArrayList<Object>();
					params.add(uuid.toString());
					for (String s : compositeKeys) {
						params.add(rs.getObject(s));
					}
					DB.executeUpdateEx(updateSQL.toString(),params.toArray(),trx.getTrxName());
				}
			}
			if (localTrx) {
				trx.commit(true);
			}
		} catch (SQLException e) {
			if (localTrx) {
				trx.rollback();
			}
			throw new DBException(e);
		} finally {
			DB.close(rs, stmt);
			if (localTrx) {
				trx.close();
			}
		}
	}

	private void syncColumn(MColumn column) {
		//	Find Column in Database
		Connection conn = null;
		try {
			conn = DB.getConnectionRO();
			DatabaseMetaData md = conn.getMetaData();
			String catalog = DB.getDatabase().getCatalog();
			String schema = DB.getDatabase().getSchema();
			MTable table = (MTable) column.getAD_Table();
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
			StringBuilder sql = null;
			//
			ResultSet rs = null;
			try
			{
				rs = md.getColumns(catalog, schema, tableName, null);
				while (rs.next())
				{
					noColumns++;
					StringBuilder columnName = new StringBuilder().append(rs.getString ("COLUMN_NAME"));
					if (!columnName.toString().equalsIgnoreCase(column.getColumnName()))
						continue;

					//	update existing column
					boolean notNull = DatabaseMetaData.columnNoNulls == rs.getInt("NULLABLE");
					sql = new StringBuilder().append(column.getSQLModify(table, column.isMandatory() != notNull));
					break;
				}
			}
			finally
			{
				DB.close(rs);
			}

			//	No Table
			if (noColumns == 0)
				sql = new StringBuilder(table.getSQLCreate ());
			//	No existing column
			else if (sql == null)
				sql = new StringBuilder(column.getSQLAdd(table));

			int no = 0;			
			if (sql.indexOf(DB.SQLSTATEMENT_SEPARATOR) == -1)
			{
				no = DB.executeUpdate(sql.toString(), false, null);
				addLog (0, null, new BigDecimal(no), sql.toString());
			}
			else
			{
				String statements[] = sql.toString().split(DB.SQLSTATEMENT_SEPARATOR);
				for (int i = 0; i < statements.length; i++)
				{
					int count = DB.executeUpdate(statements[i], false, null);
					addLog (0, null, new BigDecimal(count), statements[i]);
					no += count;
				}
			}

			if (no != -1)
			{
				StringBuilder indexName = new StringBuilder().append(column.getColumnName()).append("_idx");
				if (indexName.length() > 30) {
					int i = indexName.length() - 31;
					indexName = new StringBuilder().append(column.getColumnName().substring(0, column.getColumnName().length() - i));
					indexName.append("_uu_idx");
				}
				StringBuilder indexSql = new StringBuilder("CREATE UNIQUE INDEX ").append(indexName).append(" ON ").append(tableName)
					.append("(").append(column.getColumnName()).append(")");
				DB.executeUpdateEx(indexSql.toString(), null);
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
		} catch (SQLException e) {
			throw new DBException(e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {}
			}
		}
	}
}
