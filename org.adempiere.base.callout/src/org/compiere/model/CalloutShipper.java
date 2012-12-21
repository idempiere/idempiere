/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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

import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * 
 * @author Elaine
 *
 */
public class CalloutShipper extends CalloutEngine
{
	public String shipper(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer X_Shipper_ID = (Integer)value;
		if (X_Shipper_ID == null || X_Shipper_ID.intValue() == 0)
			return "";
		
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT sp.M_ShippingProcessor_ID ");
		sb.append("FROM M_ShippingProcessor sp, X_ShippingProcessor xsp, X_Shipper xs ");
		sb.append("WHERE sp.X_ShippingProcessor_ID = xsp.X_ShippingProcessor_ID ");
		sb.append("AND xsp.X_ShippingProcessor_ID = xs.X_ShippingProcessor_ID ");
		sb.append("AND sp.IsActive = 'Y' ");
		sb.append("AND sp.AD_Client_ID = ? ");
		sb.append("AND sp.AD_Org_ID IN (0, ?) ");
		sb.append("AND xs.X_Shipper_ID = ? ");
		sb.append("ORDER BY sp.AD_Org_ID DESC");

		int M_ShippingProcessor_ID = DB.getSQLValue(null, sb.toString(), Env.getAD_Client_ID(ctx), Env.getAD_Org_ID(ctx), X_Shipper_ID);
		if (M_ShippingProcessor_ID > 0)
			mTab.setValue(MShipper.COLUMNNAME_M_ShippingProcessor_ID, M_ShippingProcessor_ID);
		
		return null;
	}
	
	public String shipperLabels(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer X_ShipperLabels_ID = (Integer)value;
		if (X_ShipperLabels_ID == null || X_ShipperLabels_ID.intValue() == 0)
			return "";
		
		X_X_ShipperLabels sl = new X_X_ShipperLabels(ctx, X_ShipperLabels_ID, null);
		mTab.setValue(MShipperLabels.COLUMNNAME_LabelPrintMethod, sl.getLabelPrintMethod());
		mTab.setValue(MShipperLabels.COLUMNNAME_IsDefault, sl.isDefault());
		
		return null;		
	}
	
	public String shipperPackaging(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer X_ShipperPackaging_ID = (Integer)value;
		if (X_ShipperPackaging_ID == null || X_ShipperPackaging_ID.intValue() == 0)
			return "";
		
		X_X_ShipperPackaging sp = new X_X_ShipperPackaging(ctx, X_ShipperPackaging_ID, null);
		mTab.setValue(MShipperPackaging.COLUMNNAME_IsDefault, sp.isDefault());
		mTab.setValue(MShipperPackaging.COLUMNNAME_Weight, sp.getWeight());
		
		return null;
	}
	
	public String shipperPickupTypes(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer X_ShipperPickupTypes_ID = (Integer)value;
		if (X_ShipperPickupTypes_ID == null || X_ShipperPickupTypes_ID.intValue() == 0)
			return "";
		
		X_X_ShipperPickupTypes spt = new X_X_ShipperPickupTypes(ctx, X_ShipperPickupTypes_ID, null);
		mTab.setValue(MShipperLabels.COLUMNNAME_IsDefault, spt.isDefault());
		
		return null;
	}
}
