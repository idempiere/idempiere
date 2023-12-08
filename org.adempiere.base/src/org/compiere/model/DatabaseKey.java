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

package org.compiere.model;

/**
 * Database foreign or primary key
 * @author Elaine
 */
public class DatabaseKey
{
	private String keyName;
	private String keyTable;
	private String[] keyColumns;
	private short deleteRule;
	
	/**
	 * @param keyName
	 * @param keyTable
	 * @param keyColumns
	 * @param deleteRule
	 */
	public DatabaseKey(String keyName, String keyTable, String[] keyColumns, short deleteRule)
	{
		this.keyName = keyName;
		this.keyTable = keyTable;
		this.keyColumns = keyColumns;
		this.deleteRule = deleteRule;
	}

	/**
	 * @return constraint name
	 */
	public String getKeyName() {
		return keyName;
	}

	/**
	 * @param keyName
	 */
	public void setKeyName(String keyName) {
		this.keyName = keyName;
	}

	/**
	 * @return table name
	 */
	public String getKeyTable() {
		return keyTable;
	}

	/**
	 * @param keyTable table name
	 */
	public void setKeyTable(String keyTable) {
		this.keyTable = keyTable;
	}

	/**
	 * @return columns
	 */
	public String[] getKeyColumns() {
		return keyColumns;
	}

	/**
	 * @param keyColumns
	 */
	public void setKeyColumns(String[] keyColumns) {
		this.keyColumns = keyColumns;
	}

	/**
	 * @return delete rule (no action, cascade, set null or prevent)
	 */
	public short getDeleteRule() {
		return deleteRule;
	}

	/**
	 * @param deleteRule
	 */
	public void setDeleteRule(short deleteRule) {
		this.deleteRule = deleteRule;
	}

}
