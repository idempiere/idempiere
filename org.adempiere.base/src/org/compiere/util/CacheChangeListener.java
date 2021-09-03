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
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.compiere.util;

/**
 * Listener for cache reset event.
 * Note that this is ignore by CacheMgt if CCache implementation that implement this interface
 * doesn't return null for getTableName().
 * @author hengsin
 *
 */
public interface CacheChangeListener {
	/**
	 *	Reset Cache
	 *  @param tableName
	 */
	public void reset(String tableName);
	
	/**
	 *	Reset Cache by record id
	 *  @param tableName
	 *  @param recordId
	 */
	public void reset(String tableName, int recordId);
}
