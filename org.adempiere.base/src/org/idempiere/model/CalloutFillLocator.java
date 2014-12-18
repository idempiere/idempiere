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
* - Carlos Ruiz - globalqss                                           *
**********************************************************************/
package org.idempiere.model;

import java.util.Properties;

import org.compiere.model.CalloutEngine;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MLocator;
import org.compiere.model.MWarehouse;
import org.compiere.util.Env;

public class CalloutFillLocator extends CalloutEngine {

	/**
	 * fillLocator - fill default Locator based on actual warehouse
	 * 
	 * @param ctx
	 * @param WindowNo
	 * @param mTab
	 * @param mField
	 * @param value
	 * @return error message or ""
	 */
	public String fillLocator(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value) 
	{
		Integer locatorID = (Integer) value;
		if (locatorID == null || locatorID.intValue() == 0) {
			int warehouseID = Env.getContextAsInt(ctx, WindowNo, "M_Warehouse_ID", true);
			if (warehouseID > 0) {
				MWarehouse wh = MWarehouse.get(ctx, warehouseID);
				MLocator defaultLocator = wh.getDefaultLocator();
				if (defaultLocator != null) {
					mTab.setValue(mField, defaultLocator.getM_Locator_ID());
				}
			}
		}

		return "";
	}

}
