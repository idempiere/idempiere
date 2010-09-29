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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
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
	public static int findIdByColumn (String tableName, String columnName, Object value, int AD_Client_ID, String trxName) {
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
		 	.append(columnName)
		 	.append(" = ?")
			.append(" AND AD_Client_ID IN (0, ?)")
			.append(" Order By AD_Client_ID Desc, ")
			.append(tableName)
			.append("_ID");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sqlB.toString(), trxName);
			if (value instanceof String)
				pstmt.setString(1, (String)value);
			else if (value instanceof Integer)
				pstmt.setInt(1, ((Integer)value).intValue());
			else
				pstmt.setObject(1, value);
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
	
	/**
	 * Get ID from Name for a table with a parent name reference.
	 *
	 * @param tableName
	 * @param name
	 * @param tableNameMaster
	 * @param nameMaster
	 * @param trxName
	 */
	public static int findIdByNameAndParentName (String tableName, String name, String tableNameMaster, String nameMaster, String trxName) {
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
		int parentId = DB.getSQLValue(trxName, parentSql.toString(), Env.getAD_Client_ID(Env.getCtx()));
		
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
     * @param trxName
     */    
    
	public static int findIdByColumnAndParentId (String tableName, String columnName, String name, String tableNameMaster, int masterID, String trxName) {
		int id = 0;
		
		//check cache
		String key = tableName + "." + columnName + "=" + name + tableNameMaster + "=" + masterID;
		
		if (idCache.containsKey(key))
			return idCache.get(key);
		
		StringBuffer sqlB = new StringBuffer ("SELECT ")
			.append(tableName)
			.append("_ID FROM ")
			.append(tableName)
			.append(" WHERE ")
			.append(columnName)
			.append(" = ? and ")
			.append(tableNameMaster+"_ID = ? AND AD_Client_ID IN (0, ?) ")
			.append("ORDER BY AD_Client_ID Desc ");
		
		log.info(sqlB.toString());
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			
			pstmt = DB.prepareStatement(sqlB.toString(), trxName);
			pstmt.setString(1, name);
			pstmt.setInt(2, masterID);
			pstmt.setInt(3, Env.getAD_Client_ID(Env.getCtx()));
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
	public static int findIdByNameAndParentId (String tableName, String name, String tableNameMaster, int masterID, String trxName) {
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
			pstmt.setInt(3, Env.getAD_Client_ID(Env.getCtx()));
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
