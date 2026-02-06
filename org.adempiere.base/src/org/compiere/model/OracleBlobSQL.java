/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.compiere.model;

import java.util.HashMap;
import java.util.Map;

class OracleBlobSQL {
	private Map<String, String> oracleBlobSQL = new HashMap<String, String>();
	private PO po;
	
	OracleBlobSQL(PO po) {
		this.po = po;
	}
	
	/**
	 * Add column and blob sql
	 * @param column column name
	 * @param blobSQL blob data encoded with DB.getDatabase().TO_Blob(byte[])
	 */
	void put(String column, String blobSQL) {
		oracleBlobSQL.put(column, blobSQL);
	}

	boolean isEmpty() {
		return oracleBlobSQL.isEmpty();
	}

	/**
	 * Use pl/sql block for Oracle blob insert that's > 2048 bytes
	 * @param sqlInsert string builder to append the pl/sql block
	 */
	void appendPLSQLBlock(StringBuilder sqlInsert) {
		sqlInsert.append("\n;");
		for(String column : oracleBlobSQL.keySet())
		{
			sqlInsert.append("\n\n");				
			String blobSQL = oracleBlobSQL.get(column);
			int hexDataStart = blobSQL.indexOf("'");
			int hexDataEnd = blobSQL.indexOf("'", hexDataStart+1);
			String functionStart = blobSQL.substring(0, hexDataStart);
			String hexData = blobSQL.substring(hexDataStart+1, hexDataEnd);
			String functionEnd = blobSQL.substring(hexDataEnd+1);
			int remaining = hexData.length();
			int lineSize = 2048;
			sqlInsert.append("DECLARE\n")
				.append("   lob_out blob;\n")
				.append("BEGIN\n")
				.append("   UPDATE ").append(po.get_TableName())
				.append(" SET ").append(column).append("=EMPTY_BLOB()\n")
				.append("   WHERE ").append(po.getUUIDColumnName()).append("=")
				.append("'").append(po.get_UUID()).append("';\n")
				.append("   SELECT ").append(column).append(" INTO lob_out\n")
				.append("   FROM ").append(po.get_TableName()).append("\n")
				.append("   WHERE ").append(po.getUUIDColumnName()).append("=")
				.append("'").append(po.get_UUID()).append("'\n")
				.append("   FOR UPDATE;\n");
			// Split hex encoded text into 2048 bytes block
			int index = 0;				
			while (remaining > 0) 
			{
				sqlInsert.append("   dbms_lob.append(lob_out, ").append(functionStart).append("'");
				String data = remaining > lineSize ? hexData.substring(index, index+lineSize) : hexData.substring(index);
				sqlInsert.append(data).append("'").append(functionEnd).append(");\n");
				remaining = remaining > lineSize ? remaining - lineSize : 0;
				index = index + lineSize;
			}
			sqlInsert.append("END;\n/");
		}
	}
}
