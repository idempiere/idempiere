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

import java.util.Properties;

/**
 * Set Get interface for model
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
public interface SetGetModel
{
	/**
	 * Get session context
	 * @return session context
	 */
	public Properties getCtx();
	
	/**
	 * Get transaction name
	 * @return transaction name
	 */
	public String get_TrxName();
	
	/**
	 * Get table id
	 * @return AD_Table_ID
	 */
	public int get_Table_ID();
	
	/**
	 * Get table name
	 * @return table name
	 */
	public String get_TableName();
	
	/**
	 * Set column value
	 * @param name column name
	 * @param value
	 * @return true if successfully set
	 */
	public boolean set_AttrValue(String name, Object value);
	
	/**
	 * Get column value
	 * @param name column name
	 * @return column value
	 */
	public Object get_AttrValue(String name);
	
	/**
	 * Is column change
	 * @param ColumnName
	 * @return true if column has change
	 */
	public boolean is_AttrValueChanged(String ColumnName);
}
