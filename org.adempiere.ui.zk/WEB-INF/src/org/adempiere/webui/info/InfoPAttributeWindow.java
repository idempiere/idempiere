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
package org.adempiere.webui.info;

/**
 * @author hengsin
 * @deprecated not use
 */
@Deprecated
public class InfoPAttributeWindow extends InfoWindow {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4554543873526769338L;

	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 */
	public InfoPAttributeWindow(int WindowNo, String tableName,
			String keyColumn, String queryValue, boolean multipleSelection,
			String whereClause, int AD_InfoWindow_ID) {
		super(WindowNo, tableName, keyColumn, queryValue, multipleSelection,
				whereClause, AD_InfoWindow_ID);

	}

	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 * @param lookup
	 */
	public InfoPAttributeWindow(int WindowNo, String tableName,
			String keyColumn, String queryValue, boolean multipleSelection,
			String whereClause, int AD_InfoWindow_ID, boolean lookup) {
		super(WindowNo, tableName, keyColumn, queryValue, multipleSelection,
				whereClause, AD_InfoWindow_ID, lookup);

	}

}
