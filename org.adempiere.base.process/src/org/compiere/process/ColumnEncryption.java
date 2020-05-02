/********************************************************************** 
 * This file is part of Adempiere ERP Bazaar                          * 
 * http://www.adempiere.org                                           * 
 *                                                                    * 
 * Copyright (C) 1999 - 2006 Compiere Inc.                            * 
 * Copyright (C) Contributors                                         * 
 *                                                                    * 
 * This program is free software; you can redistribute it and/or      * 
 * modify it under the terms of the GNU General Public License        * 
 * as published by the Free Software Foundation; either version 2     * 
 * of the License, or (at your option) any later version.             * 
 *                                                                    * 
 * This program is distributed in the hope that it will be useful,    * 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of     * 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the       * 
 * GNU General Public License for more details.                       * 
 *                                                                    * 
 * You should have received a copy of the GNU General Public License  * 
 * along with this program; if not, write to the Free Software        * 
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,         * 
 * MA 02110-1301, USA.                                                * 
 *                                                                    * 
 * Contributors:                                                      * 
 *  - Bahman Movaqar (bmovaqar AT users.sf.net)                       * 
 **********************************************************************/
package org.compiere.process;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;

import org.compiere.db.AdempiereDatabase;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.SecureEngine;
import org.compiere.util.Trx;

/**
 * Column Encryption Test
 * 
 * @author Jorg Janke
 * @version $Id: ColumnEncryption.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class ColumnEncryption extends SvrProcess {
	/** Enable/Disable Encryption */
	private boolean p_IsEncrypted = false;

	/** Change Encryption Settings */
	private boolean p_ChangeSetting = false;

	/** Maximum Length */
	private int p_MaxLength = 0;

	/** Test Value */
	private String p_TestValue = null;

	/** The Column */
	private int p_AD_Column_ID = 0;

	/**
	 * All the resizing and encrypting database are managed by this
	 * transaction.
	 */
	private Trx m_trx;
	
	/**
	 * All the resizing and encrypting database work goes through this
	 * connection.
	 */
	private Connection m_conn;

	private int count;
	
	/**
	 * Prepare - e.g., get Parameters.
	 */
	protected void prepare() {
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++) {
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("IsEncrypted"))
				p_IsEncrypted = "Y".equals(para[i].getParameter());
			else if (name.equals("ChangeSetting"))
				p_ChangeSetting = "Y".equals(para[i].getParameter());
			else if (name.equals("MaxLength"))
				p_MaxLength = para[i].getParameterAsInt();
			else if (name.equals("TestValue"))
				p_TestValue = (String) para[i].getParameter();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
		p_AD_Column_ID = getRecord_ID();
	} // prepare

	/**
	 * Process
	 * 
	 * @return info
	 * @throws Exception
	 */
	protected String doIt() throws Exception {
		if (log.isLoggable(Level.INFO)) {
			log.info("AD_Column_ID=" + p_AD_Column_ID + ", IsEncrypted="
					+ p_IsEncrypted + ", ChangeSetting=" + p_ChangeSetting
					+ ", MaxLength=" + p_MaxLength);
		}
		MColumn column = new MColumn(getCtx(), p_AD_Column_ID, get_TrxName());
		if (column.get_ID() == 0 || column.get_ID() != p_AD_Column_ID)
			throw new AdempiereUserError("@NotFound@ @AD_Column_ID@ - "
					+ p_AD_Column_ID);
		//
		String columnName = column.getColumnName();
		int dt = column.getAD_Reference_ID();

		// Can it be enabled?
		if (column.isKey() || column.isParent() || column.isStandardColumn() || column.isUUIDColumn()
				|| column.isVirtualColumn() || column.isIdentifier()
				|| column.isTranslated() || DisplayType.isLookup(dt)
				|| DisplayType.isLOB(dt) || DisplayType.isDate(dt) || DisplayType.isNumeric(dt)				
				|| "DocumentNo".equalsIgnoreCase(column.getColumnName())
				|| "Value".equalsIgnoreCase(column.getColumnName())
				|| "Name".equalsIgnoreCase(column.getColumnName())) {
			if (column.isEncrypted()) {
				column.setIsEncrypted(false);
				column.saveEx();
			}
			StringBuilder msgreturn = new StringBuilder().append(columnName).append(": cannot be encrypted");
			throw new Exception(msgreturn.toString());
		}

		// Start
		StringBuilder msglog = new StringBuilder("Encryption Class = ")
				.append(SecureEngine.getClassName());
		addLog(0, null, null, msglog.toString());
		boolean error = false;

		// Test Value
		if (p_IsEncrypted && p_TestValue != null && p_TestValue.length() > 0) {
			String encString = SecureEngine.encrypt(p_TestValue, 0);
			msglog = new StringBuilder("Encrypted Test Value=").append(encString);
			addLog(0, null, null, msglog.toString());
			String clearString = SecureEngine.decrypt(encString, 0);
			if (p_TestValue.equals(clearString)){
				msglog = new StringBuilder("Decrypted=").append(clearString)
						.append(" (same as test value)");
				addLog(0, null, null, msglog.toString());
			}	
			else {
				msglog = new StringBuilder("Decrypted=").append(clearString)
						.append(" (NOT the same as test value - check algorithm)");
				addLog(0, null, null, msglog.toString());
				error = true;
			}
			int encLength = encString.length();
			msglog = new StringBuilder("Test Length=").append(p_TestValue.length())
					.append(" -> ").append(encLength);
			addLog(0, null, null, msglog.toString());
			if (encLength <= column.getFieldLength()){
				msglog = new StringBuilder("Encrypted Length (").append(encLength)
						.append(") fits into field (").append(column.getFieldLength()).append(")");
				addLog(0, null, null, msglog.toString());
			}
			else {
				msglog = new StringBuilder("Encrypted Length (").append(encLength)
						.append(") does NOT fit into field (")
						.append(column.getFieldLength()).append(") - resize field");
				addLog(0, null, null, msglog.toString());
				error = true;
			}
		}

		// Length Test
		if (p_IsEncrypted && p_MaxLength != 0) {
			StringBuilder testClear = new StringBuilder(); 
			testClear.append("1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
			while (testClear.length() < p_MaxLength)
				testClear.append(testClear);
			testClear.delete(p_MaxLength,testClear.length());
			msglog = new StringBuilder()
				.append("Test=").append(testClear.toString()).append(" (").append(p_MaxLength).append(")");
			if (log.isLoggable(Level.CONFIG)) log.config(msglog.toString());
			//
			String encString = SecureEngine.encrypt(testClear.toString(), 0);
			int encLength = encString.length();
			msglog = new StringBuilder("Test Max Length=").append(testClear.length())
					.append(" -> ").append(encLength);
			addLog(0, null, null, msglog.toString());
			if (encLength <= column.getFieldLength()){
				msglog = new StringBuilder("Encrypted Max Length (").append(encLength)
						.append(") fits into field (").append(column.getFieldLength()).append(")");
				addLog(0, null, null, msglog.toString());
			}	
			else {
				msglog = new StringBuilder("Encrypted Max Length (").append(encLength)
						.append(") does NOT fit into field (")
						.append(column.getFieldLength()).append(") - resize field");
				addLog(0, null, null, msglog.toString());
				error = true;
			}
		}

		count = 0;
		// If only user chooses both encrypt the contents and override current
		// settings resize the physical column and encrypt all its contents.
		if (p_ChangeSetting && column.isEncrypted() != p_IsEncrypted) {
			// Init the transaction and setup the connection.
			m_trx = Trx.get(get_TrxName(), true);
			if ((m_conn = m_trx.getConnection()) == null) {
				log.warning("No connections available");
				throw new Exception();
			}
			m_conn.setAutoCommit(false);

			int columnID = column.get_ID();
			MTable table = MTable.get(getCtx(), column.getAD_Table_ID());
			String tableName = table.getTableName();

			if (p_IsEncrypted) {
				// Check if the encryption exceeds the current length.
				int oldLength = column.getFieldLength();
				int newLength = encryptedColumnLength(oldLength);
				if (newLength > oldLength) {
					if (changeFieldLength(columnID, columnName, newLength,
							tableName) == -1) {
						log.warning("EncryptError [ChangeFieldLength]: "
								+ "ColumnID=" + columnID + ", NewLength="
								+ newLength);
						throw new Exception();
					}
				}

				// Encrypt column contents.
				count = encryptColumnContents(columnName, column.getAD_Table_ID()); 
				if (count == -1) {
					log.warning("EncryptError: No records encrypted.");
					throw new Exception();
				}
			} else {
				// Decrypt column contents.
				count = decryptColumnContents(columnName, column.getAD_Table_ID()); 
				if (count == -1) {
					log.warning("DecryptError: No records decrypted.");
					throw new Exception();
				}
			}
			
			if (error || !p_ChangeSetting){
				msglog = new StringBuilder("Encryption NOT changed - Encryption=")
						.append(column.isEncrypted());
				addLog(0, null, null, msglog.toString());
			} else {
				column.setIsEncrypted(p_IsEncrypted);
				if (column.save()){
					addLog(0, null, null, "#" + (p_IsEncrypted ? "Encrypted=" : "Decrypted=") +count);
					msglog = new StringBuilder("Encryption CHANGED - Encryption=")
							.append(column.isEncrypted());
					addLog(0, null, null, msglog.toString());
				} else
					addLog(0, null, null, "Save Error");
			}
		} else {
			addLog(0, null, null, "Can't perform " + (p_IsEncrypted ? "encryption. " : "decryption. ") + "Column is " + (p_IsEncrypted ? "already Encrypted." : " not Encrypted."));
		}
		
		StringBuilder msgreturn = new StringBuilder("Encryption=").append(column.isEncrypted());
		return msgreturn.toString();
	} // doIt

	
	/**
	 * Encrypt all the contents of a database column.
	 * 
	 * @param columnName
	 *            The ID of the column to be encrypted.
	 * @param tableID
	 *            The ID of the table which owns the column.
	 * @return The number of rows effected or -1 in case of errors.
	 * @throws Exception
	 */
	private int encryptColumnContents(String columnName, int tableID)
			throws Exception {
		// Find the table name
		String tableName = MTable.getTableName(getCtx(), tableID);

		return encryptColumnContents(columnName, tableName);
	} // encryptColumnContents

	/**
	 * Encrypt all the contents of a database column.
	 * 
	 * @param columnName
	 *            The ID of the column to be encrypted.
	 * @param tableName
	 *            The name of the table which owns the column.
	 * @return The number of rows effected or -1 in case of errors.
	 */
	private int encryptColumnContents(String columnName, String tableName)
			throws Exception {
		int recordsEncrypted = 0;
		StringBuilder idColumnName = new StringBuilder(tableName).append("_ID");

		StringBuilder selectSql = new StringBuilder();
		selectSql.append("SELECT ").append(idColumnName).append(",").append(columnName).append(",AD_Client_ID");
		selectSql.append(" FROM ").append(tableName);
		selectSql.append(" ORDER BY 1");

		StringBuilder updateSql = new StringBuilder();
		updateSql.append("UPDATE ").append(tableName);
		updateSql.append(" SET ").append(columnName).append("=?");
		updateSql.append(" WHERE ").append(idColumnName).append("=?");

		PreparedStatement selectStmt = null;
		PreparedStatement updateStmt = null;
		ResultSet rs = null;
		
		try {
			String selectSqlStr = DB.getDatabase().convertStatement(selectSql.toString());
			selectStmt = m_conn.prepareStatement(selectSqlStr,
					ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
			updateStmt = m_conn.prepareStatement(updateSql.toString());
	
			rs = selectStmt.executeQuery();
	
			for (recordsEncrypted = 0; rs.next(); ++recordsEncrypted) {
				// Get the row id and column value
				int id = rs.getInt(1);
				String value = rs.getString(2);
				int AD_Client_ID = rs.getInt(3);
				// Encrypt the value
				value = SecureEngine.encrypt(value, AD_Client_ID);
				// Update the row
				updateStmt.setString(1, value);
				updateStmt.setInt(2, id);
				if (updateStmt.executeUpdate() != 1) {
					log.severe("EncryptError: Table=" + tableName + ", ID=" + id);
					throw new Exception();
				}
			}
		} finally {
			DB.close(rs);
			DB.close(selectStmt);
			DB.close(updateStmt);
		}

		return recordsEncrypted;
	} // encryptColumnContents

	/**
	 * Decrypt all the contents of a database column.
	 * 
	 * @param columnName
	 *            The ID of the column to be encrypted.
	 * @param tableID
	 *            The ID of the table which owns the column.
	 * @return The number of rows effected or -1 in case of errors.
	 * @throws Exception
	 */
	private int decryptColumnContents(String columnName, int tableID)
			throws Exception {
		// Find the table name
		String tableName = MTable.getTableName(getCtx(), tableID);

		return decryptColumnContents(columnName, tableName);
	} // decryptColumnContents

	/**
	 * Decrypt all the contents of a database column.
	 * 
	 * @param columnName
	 *            The ID of the column to be encrypted.
	 * @param tableName
	 *            The name of the table which owns the column.
	 * @return The number of rows effected or -1 in case of errors.
	 */
	private int decryptColumnContents(String columnName, String tableName)
			throws Exception {
		int recordsDecrypted = 0;
		StringBuilder idColumnName = new StringBuilder(tableName).append("_ID");

		StringBuilder selectSql = new StringBuilder();
		selectSql.append("SELECT ").append(idColumnName).append(",").append(columnName).append(",AD_Client_ID");
		selectSql.append(" FROM ").append(tableName);
		selectSql.append(" ORDER BY ").append(idColumnName);

		StringBuilder updateSql = new StringBuilder();
		updateSql.append("UPDATE ").append(tableName);
		updateSql.append(" SET ").append(columnName).append("=?");
		updateSql.append(" WHERE ").append(idColumnName).append("=?");

		PreparedStatement selectStmt = null;
		PreparedStatement updateStmt = null;
		ResultSet rs = null;
		
		try {
			String selectSqlStr = DB.getDatabase().convertStatement(selectSql.toString());
			selectStmt = m_conn.prepareStatement(selectSqlStr,
					ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
			updateStmt = m_conn.prepareStatement(updateSql.toString());
	
			rs = selectStmt.executeQuery();
	
			for (recordsDecrypted = 0; rs.next(); ++recordsDecrypted) {
				// Get the row id and column value
				int id = rs.getInt(1);
				String value = rs.getString(2);
				int AD_Client_ID = rs.getInt(3);
				// Encrypt the value
				value = SecureEngine.decrypt(value, AD_Client_ID);
				// Update the row
				updateStmt.setString(1, value);
				updateStmt.setInt(2, id);
				if (updateStmt.executeUpdate() != 1) {
					log.severe("DecryptError: Table=" + tableName + ", ID=" + id);
					throw new Exception();
				}
			}
		} finally {
			DB.close(rs);
			DB.close(selectStmt);
			DB.close(updateStmt);
		}

		return recordsDecrypted;
	} // decryptColumnContents
	
	/**
	 * Determines the length of the encrypted column.
	 * 
	 * @param currentColSize
	 *            Current column size
	 * @return The length of the encrypted column.
	 */
	private int encryptedColumnLength(int colLength) {
		StringBuilder str = new StringBuilder();

		for (int i = 0; i < colLength; i++) {
			str.append("1");
		}		
		str = new StringBuilder().append(SecureEngine.encrypt(str.toString(), 0));
		return str.length();
	} // encryptedColumnLength

	/**
	 * Change the column length.
	 * 
	 * @param columnID
	 *            ID of the column
	 * @param tableName
	 *            The name of the table which owns the column
	 * @param length
	 *            New length of the column
	 * @return The number of rows effected, 1 upon success and -1 for failure.
	 */
	private int changeFieldLength(int columnID, String columnName, int length,
			String tableName) throws Exception {
		int rowsEffected = -1;

		// Select SQL
		String selectSql = "SELECT FieldLength FROM AD_Column WHERE AD_Column_ID=?";

		String dataType = "NVARCHAR2";
		if (DB.isOracle()) {
			Connection conn = Trx.get(get_TrxName(), false).getConnection();
			AdempiereDatabase db = DB.getDatabase();
			DatabaseMetaData md = conn.getMetaData();
			String catalog = db.getCatalog();
			String schema = db.getSchema();
			ResultSet rs = null;
			try {
				rs = md.getColumns(catalog, schema, tableName.toUpperCase(), columnName.toUpperCase());
				if (rs.next()) {
					dataType = rs.getString ("TYPE_NAME");
				}
			} finally {
				DB.close(rs);
			}
		}
		
		// Alter SQL
		StringBuilder alterSql = new StringBuilder();
		alterSql.append("ALTER TABLE ").append(tableName);
		alterSql.append(" MODIFY ").append(columnName);
		alterSql.append(" ").append(dataType).append("(");
		alterSql.append(length).append(") ");

		// Update SQL
		StringBuilder updateSql = new StringBuilder();
		updateSql.append("UPDATE AD_Column");
		updateSql.append(" SET FieldLength=").append(length);
		updateSql.append(" WHERE AD_Column_ID=").append(columnID);

		PreparedStatement selectStmt = null;
		ResultSet rs = null;
		
		try {
			selectSql = DB.getDatabase().convertStatement(selectSql);
			selectStmt = m_conn.prepareStatement(selectSql,
					ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
	
			selectStmt.setInt(1, columnID);
			rs = selectStmt.executeQuery();
	
			if (rs.next()) {
				// Change the column size physically.
				alterSql = new StringBuilder(DB.getDatabase().convertStatement(alterSql.toString()));
				if (DB.executeUpdate(alterSql.toString(), false, m_trx
								.getTrxName()) == -1) {
					log.severe("EncryptError [ChangeFieldLength]: ColumnID="
							+ columnID + ", NewLength=" + length);
					throw new Exception();
				}
	
				// Change the column size in AD.
				updateSql = new StringBuilder(DB.getDatabase().convertStatement(updateSql.toString()));
				if (DB.executeUpdate(updateSql.toString(), false, m_trx
						.getTrxName()) == -1) {
					log.severe("EncryptError [ChangeFieldLength]: ColumnID="
							+ columnID + ", NewLength=" + length);
					throw new Exception();
				}
			}
		} finally {
			DB.close(rs, selectStmt);
		}

		// Update number of rows effected.
		rowsEffected++;

		return rowsEffected;
	} // changeFieldLength

	@Override
	protected void postProcess(boolean success) {
		//must reset cache after encryption or decryption
		if (count > 0 && success) {
			CacheMgt.get().reset();
		}
	}

} // EncryptionTest