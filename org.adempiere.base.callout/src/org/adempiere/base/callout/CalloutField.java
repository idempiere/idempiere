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
 * - Diego Ruiz  	                								   *
 **********************************************************************/
package org.adempiere.base.callout;

import java.util.Properties;

import org.adempiere.base.IColumnCallout;
import org.adempiere.base.annotation.Callout;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MColumn;
import org.compiere.model.MField;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

@Callout(tableName = MField.Table_Name, 
columnName = {MField.COLUMNNAME_ReadOnlyLogic, MField.COLUMNNAME_IsAlwaysUpdateable})
public class CalloutField implements IColumnCallout {

	@Override
	public String start(Properties ctx, int windowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
		return isAlwaysUpdatableFieldColumn(ctx, windowNo, mTab, mField, value);
	}

	private static String isAlwaysUpdatableFieldColumn(Properties ctx, int windowNo, GridTab mTab, GridField mField, Object value) {
		
		if (mTab.getValue(MField.COLUMNNAME_AD_Column_ID) == null) {
			return "";
		}
		
		String readOnlyLogic = (String) mTab.getValue(MField.COLUMNNAME_ReadOnlyLogic);
		MColumn column = MColumn.get(ctx, (Integer) mTab.getValue(MField.COLUMNNAME_AD_Column_ID));
		String isFieldAlwaysUpdateable = (String) mTab.getValue(MField.COLUMNNAME_IsAlwaysUpdateable);
		
		if (!Util.isEmpty(readOnlyLogic, true)) {
			if (column.isAlwaysUpdateable() && !MField.ISALWAYSUPDATEABLE_No.equals(isFieldAlwaysUpdateable)) {
				return Msg.getMsg(Env.getCtx(), "UpdateReadOnlyConflict");
			}
		}
		return "";
	}
}
