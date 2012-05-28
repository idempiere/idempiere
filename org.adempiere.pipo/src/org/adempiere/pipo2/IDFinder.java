/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2005 Robert Klein. robeklein@hotmail.com
 * Contributor(s): Low Heng Sin hengsin@avantz.com
 *****************************************************************************/
package org.adempiere.pipo2;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Hex;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;

/**
 * Utility class for the looking up of record id.
 * @author Low Heng Sin
 *
 */
public class IDFinder {

	private static CLogger log = CLogger.getCLogger(IDFinder.class);

	private static Map<String, Integer>idCache = new HashMap<String, Integer>();

	/**
	 * Get ID from column value for a table.
	 *
	 * @param tableName
	 * @param columName
	 * @param value
	 * @param AD_Client_ID
	 * @param trxName
	 */
	public static int findIdByColumn (String tableName, String columnName, Object value, int AD_Client_ID, boolean ignorecase, String trxName) {
		int id = 0;

		if (value == null)
			return id;

		//construct cache key
		StringBuffer key = new StringBuffer();
		key.append(tableName)
			.append(".")
			.append(columnName)
			.append("=")
			.append(value.toString())
			.append(" AND AD_Client_ID=").append(AD_Client_ID);

		//check cache
		if (idCache.containsKey(key.toString()))
			return idCache.get(key.toString());

		StringBuffer sqlB = new StringBuffer ("SELECT ")
		 	.append(tableName)
		 	.append("_ID FROM ")
		 	.append(tableName)
		 	.append(" WHERE ")
		 	.append(" AD_Client_ID IN (0, ?) AND ");

		Object[] params = null;
		String[] columns = null;
		if (columnName.indexOf(",") > 0 && value instanceof String) {
			columns = columnName.split("[,]");
			String[] values = ((String)value).split("[,]");
			List<Object> paramList = new ArrayList<Object>();
			for (int i = 0; i < columns.length; i++) {
				if (i > 0)
					sqlB.append(" AND ");
				if (ignorecase) {
					sqlB.append("UPPER(").append(columns[i]).append(")=? ");
				} else {
					sqlB.append(columns[i]).append("=? ");
				}
				try {
					byte[] bytes = Hex.decodeHex(values[i].toCharArray());
					String s = new String(bytes, "UTF-8");
					if (ignorecase) {
						paramList.add(s.toUpperCase());
					} else {
						paramList.add(s);
					}
				} catch (DecoderException e) {
					throw new RuntimeException(e);
				} catch (UnsupportedEncodingException e) {
					throw new RuntimeException(e);
				}
			}
			params = paramList.toArray();
		} else {
			if (ignorecase && value != null && value instanceof String) {
				sqlB.append("UPPER(").append(columnName).append(") =? ");
				params = new Object[]{ ((String)value).toUpperCase()};
			} else {
				sqlB.append(columnName).append(" =? ");
				params = new Object[]{value};
			}
			columns = new String[]{columnName};
		}

		sqlB.append(" Order By AD_Client_ID Desc, ")
			.append(tableName)
			.append("_ID");

		MTable table = MTable.get(Env.getCtx(), tableName);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sqlB.toString(), trxName);
			pstmt.setInt(1, AD_Client_ID);
			for (int i = 0; i < params.length; i++) {
				Object param = params[i];
				if (param instanceof String) {
					String s = (String)param;
					MColumn column = table.getColumn(columns[i]);
					if (column.getAD_Reference_ID() == DisplayType.Amount
							|| column.getAD_Reference_ID() == DisplayType.Number
							|| column.getAD_Reference_ID() == DisplayType.CostPrice
							|| column.getAD_Reference_ID() == DisplayType.Quantity)
						pstmt.setBigDecimal(i+2, new BigDecimal(s));
					else if (column.getAD_Reference_ID() == DisplayType.Date
							|| column.getAD_Reference_ID() == DisplayType.DateTime)
						pstmt.setTimestamp(i+2, Timestamp.valueOf(s));
					else if (column.getAD_Reference_ID() == DisplayType.Integer)
						pstmt.setInt(i+2, Integer.parseInt(s));
					else
						pstmt.setString(i+2, s);
				} else if (param instanceof Integer) {
					pstmt.setInt(i+2, ((Integer)param).intValue());
				} else {
					pstmt.setObject(i+2, param);
				}
			}

			rs = pstmt.executeQuery();
			if (rs.next())
				id = rs.getInt(1);
		}
		catch (Exception e) {
			throw new DatabaseAccessException(e);
		} finally {
			DB.close(rs, pstmt);
		}

		//update cache
		if (id > 0)
			idCache.put(key.toString(), id);

		return id;
	}

	public static int findIdByColumn(String tableName, String columnName, Object value, int clientId, String trxName) {
		return findIdByColumn(tableName, columnName, value, clientId, false, trxName);
	}
	
	/**
	 * Get ID from Name for a table with a parent name reference.
	 *
	 * @param tableName
	 * @param name
	 * @param tableNameMaster
	 * @param nameMaster
	 * @param trxName
	 */
	public static int findIdByNameAndParentName (String tableName, String name, String tableNameMaster, String nameMaster, int AD_Client_ID, String trxName) {
		int id = 0;
		//construct cache key
		StringBuffer key = new StringBuffer();
		key.append(tableName)
			.append(".Name=")
			.append(name)
			.append(" and ")
			.append(tableNameMaster)
			.append(".Name=")
			.append(nameMaster);

		//check cache
		if (idCache.containsKey(key.toString()))
			return idCache.get(key.toString());

		StringBuffer parentSql = new StringBuffer("SELECT ")
				.append(tableNameMaster)
				.append("_ID FROM ")
				.append(tableNameMaster)
				.append(" WHERE Name = ? AND AD_Client_ID IN (0, ?) ")
				.append("ORDER BY AD_Client_ID  Desc");
		int parentId = DB.getSQLValue(trxName, parentSql.toString(), name, Env.getAD_Client_ID(Env.getCtx()));

		if (parentId > 0) {
			StringBuffer sqlB = new StringBuffer ("SELECT ")
				.append(tableName)
				.append("_ID FROM ")
				.append(tableName)
				.append(" WHERE Name = ? AND ")
				.append(tableNameMaster)
				.append("_ID = ?");

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = DB.prepareStatement(sqlB.toString(), trxName);
				pstmt.setString(1, name);
				pstmt.setString(2, nameMaster);
				pstmt.setInt(3, parentId);
				rs = pstmt.executeQuery();
				if (rs.next())
					id = rs.getInt(1);
			} catch (Exception e) {
				throw new DatabaseAccessException(e);
			} finally {
				DB.close(rs, pstmt);
			}
		}

		//update cache
		if (id > 0)
			idCache.put(key.toString(), id);

		return id;
	}

	/**
     * Get ID from column value for a table with a parent id reference.
     *
     * @param tableName
     * @param name
     * @param tableNameMaster
     * @param masterID
     * @param trx
     */

	public static int findIdByColumnAndParentId (String tableName, String columnName, String name, String tableNameMaster, int masterID, int AD_Client_ID, String trxName) {
		return findIdByColumnAndParentId(tableName, columnName, name, tableNameMaster, masterID, AD_Client_ID, false, trxName);
	}
	
	/**
     * Get ID from column value for a table with a parent id reference.
     *
     * @param tableName
     * @param name
     * @param tableNameMaster
     * @param masterID
     * @param trxName
     */

	public static int findIdByColumnAndParentId (String tableName, String columnName, String name, String tableNameMaster, int masterID, int AD_Client_ID, boolean ignoreCase, String trxName) {
		int id = 0;

		//check cache
		String key = tableName + "." + columnName + "=" + name + tableNameMaster + "=" + masterID;

		if (idCache.containsKey(key))
			return idCache.get(key);

		StringBuffer sqlB = new StringBuffer ("SELECT ")
			.append(tableName)
			.append("_ID FROM ")
			.append(tableName)
			.append(" WHERE ");
		if (ignoreCase) {
			sqlB.append("Upper(")
				.append(columnName)
				.append(") = ? and ");
		} else {
			sqlB.append(columnName)
				.append(" = ? and ");
		}
		sqlB.append(tableNameMaster+"_ID = ? AND AD_Client_ID IN (0, ?) ")
			.append("ORDER BY AD_Client_ID Desc ");

		log.info(sqlB.toString());

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			pstmt = DB.prepareStatement(sqlB.toString(), trxName);
			if (ignoreCase) {
				pstmt.setString(1, name.toUpperCase());
			} else {
				pstmt.setString(1, name);
			}
			pstmt.setInt(2, masterID);
			pstmt.setInt(3, AD_Client_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				id = rs.getInt(1);
			}
		}
		catch (Exception e) {
			throw new DatabaseAccessException(e);
		} finally {
			DB.close(rs, pstmt);
		}

		//update cache
		if (id > 0)
			idCache.put(key, id);

		return id;
	}

	/**
	 * Get ID from Name for a table with a parent reference ID.
	 *
	 * @param tableName
	 * @param name
	 * @param tableNameMaster
	 * @param masterID
	 * @param trxName
	 */
	public static int findIdByNameAndParentId (String tableName, String name, String tableNameMaster, int masterID, int AD_Client_ID, String trxName) {
		int id = 0;

		//construct cache key
		StringBuffer key = new StringBuffer();
		key.append(tableName)
			.append(".Name=")
			.append(name)
			.append(" AND ")
			.append(tableNameMaster)
			.append(".")
			.append(tableNameMaster)
			.append("_ID=")
			.append(masterID);

		//check cache
		if (idCache.containsKey(key.toString()))
			return idCache.get(key.toString());

		StringBuffer sqlB = new StringBuffer ("SELECT ")
			.append(tableName)
			.append("_ID FROM ")
			.append(tableName)
			.append(" WHERE Name=? AND ")
			.append(tableNameMaster)
			.append("_ID=? AND AD_Client_ID IN (0, ?) ")
			.append("ORDER BY AD_Client_ID Desc");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sqlB.toString(), trxName);
			pstmt.setString(1, name);
			pstmt.setInt(2, masterID);
			pstmt.setInt(3, AD_Client_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
				id = rs.getInt(1);
		}
		catch (Exception e) {
			throw new DatabaseAccessException(e);
		} finally {
			DB.close(rs, pstmt);
		}

		//update cache
		if (id > 0)
			idCache.put(key.toString(), id);

		return id;
	}

	/**
	 * Get ID from Name for a table.
	 *
	 * @param tableName
	 * @param name
	 * @param AD_Client_ID
	 * @param trxName
	 */
	public static int findIdByName (String tableName, String name, int AD_Client_ID, String trxName) {
		int id = 0;

		//construct cache key
		StringBuffer key = new StringBuffer();
		key.append(tableName)
			.append(".Name=")
			.append(name);
		if (!tableName.startsWith("AD_"))
			key.append(" AND AD_Client_ID=").append(AD_Client_ID);

		//check cache
		if (idCache.containsKey(key.toString()))
			return idCache.get(key.toString());

		StringBuffer sql = new StringBuffer("SELECT ")
			.append(tableName)
			.append("_ID ")
			.append("FROM ")
			.append(tableName)
			.append(" ")
			.append("WHERE Name=? ")
			.append(" AND AD_Client_ID IN (0, ?) ")
			.append(" ORDER BY AD_Client_ID Desc");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql.toString(), trxName);
			pstmt.setString(1, name);
			pstmt.setInt(2, AD_Client_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
				id = rs.getInt(1);
		}
		catch (Exception e) {
			throw new DatabaseAccessException(e);
		} finally {
			DB.close(rs, pstmt);
		}

		//update cache
		if (id > 0)
			idCache.put(key.toString(), id);

		return id;
	}

	public static void clearIDCache() {
		idCache.clear();
	}
}
