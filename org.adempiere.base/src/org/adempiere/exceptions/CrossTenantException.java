/**********************************************************************
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
*                                                                     *
* Contributors:                                                       *
* - Diego Ruiz, BX Service GmbH                                       *
**********************************************************************/
package org.adempiere.exceptions;

import org.compiere.util.Env;

/**
 * Exception thrown when a cross-tenant access violation occurs during a read or write operation.
 */
public class CrossTenantException extends AdempiereException {

	private static final long serialVersionUID = 2869354491846765492L;
	private String fkColumn = null;
	private Object fkValue = null;

	/**
     * Constructs a new CrossTenantException indicating a cross-tenant access violation
     * during either a read or write operation.
     *
     * @param isWriting {@code true} if the violation occurred during a write operation, {@code false} for a read operation.
     * @param tableName The name of the database table involved in the violation.
     * @param recordID  The record ID that was attempted to be accessed.
     */
	public CrossTenantException(boolean isWriting, String tableName, int recordID) {
		super("Cross tenant PO " + (isWriting ? "writing" : "reading") + 
				" request detected from session "
				+ Env.getContext(Env.getCtx(), Env.AD_SESSION_ID) + " for table " + tableName
				+ " Record_ID=" + recordID);
	}
	
    /**
     * Constructs a new CrossTenantException indicating that a record ID from another tenant cannot be used.
     *
     * @param tableName The name of the database table involved in the violation.
     * @param recordID  The record ID that was attempted to be accessed.
     */
	public CrossTenantException(String tableName, int recordID) {
		super("Cross tenant ID " + recordID + " not allowed in " + tableName);
	}
	
    /**
     * Constructs a new CrossTenantException indicating that a UUID from another tenant cannot be used.
     *
     * @param tableName The name of the database table involved in the violation.
     * @param recordUU  The UUID of the record that was attempted to be accessed.
     */
	public CrossTenantException(String tableName, String recordUU) {
		super("Cross tenant UUID " + recordUU + " not allowed in " + tableName);
	}
	
	/**
	 * Exception thrown when a foreign key references an entity from a different tenant.
	 *
	 * @param fkValue  The foreign key value that caused the exception.
	 * @param fkColumn The column name where the cross-tenant reference was detected.
	 */
	public CrossTenantException(Object fkValue, String fkColumn) {
		super("Cross tenant ID " + fkValue + " not allowed in " + fkColumn);
		this.fkColumn = fkColumn;
		this.fkValue = fkValue;
	}

	public String getFKColumn() {
		return fkColumn;
	}

	public Object getFKValue() {
		return fkValue;
	}

}
