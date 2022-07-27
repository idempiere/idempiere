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
import org.adempiere.util.ShippingUtil;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.I_M_InOut;
import org.compiere.model.MInOut;
import org.compiere.util.Env;

/**
 * @author hengsin
 *
 */
@Callout(tableName = I_M_InOut.Table_Name, columnName = I_M_InOut.COLUMNNAME_FreightCostRule)
public class InOutFreightCostRule implements IColumnCallout {

	/**
	 * default constructor 
	 */
	public InOutFreightCostRule() {
	}

	@Override
	public String start(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value, Object oldValue) {
		String FreightCostRule = (String) mTab.getValue(MInOut.COLUMNNAME_FreightCostRule);
		
		if (FreightCostRule == null)
		{
			mTab.setValue(MInOut.COLUMNNAME_ShipperAccount, null);
			return "";
		}
		
		if (FreightCostRule.equals(MInOut.FREIGHTCOSTRULE_CustomerAccount))
		{
			int M_Shipper_ID =  Env.getContextAsInt(ctx, WindowNo, MInOut.COLUMNNAME_M_Shipper_ID);
			int C_BPartner_ID = Env.getContextAsInt(ctx, WindowNo, MInOut.COLUMNNAME_C_BPartner_ID);
			int C_BPartner_Location_ID = Env.getContextAsInt(ctx, WindowNo, MInOut.COLUMNNAME_C_BPartner_Location_ID);
			int AD_Org_ID = Env.getContextAsInt(ctx, WindowNo, MInOut.COLUMNNAME_AD_Org_ID);
			String shipperAccount = ShippingUtil.getBPShipperAccount(M_Shipper_ID, C_BPartner_ID, C_BPartner_Location_ID, AD_Org_ID, null);
			mTab.setValue(MInOut.COLUMNNAME_ShipperAccount, shipperAccount);
			mTab.setValue(MInOut.COLUMNNAME_FreightCharges, MInOut.FREIGHTCHARGES_Collect);
		}
		
		return "";
	}
}
