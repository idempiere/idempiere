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
package org.adempiere.base.callout;

import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.adempiere.base.annotation.Callout;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;

/**
 * Callout to clear Record_ID value after changes to AD_Table_ID.
 * @author hengsin
 *
 */
@Callout(tableName = "*",columnName = "AD_Table_ID")
public class TableIDCallout implements IColumnCallout {

	/**
	 * Default constructor
	 */
	public TableIDCallout() {
	}
	
	@Override	
	public String start(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
		GridField recordId = mTab.getField("Record_ID"); 
		if (recordId != null) {
			mTab.setValue(recordId, null);
		}
		return null;
	}
}
