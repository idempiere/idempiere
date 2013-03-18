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
		Integer M_ShipperCfg_ID = (Integer)value;
		if (M_ShipperCfg_ID == null || M_ShipperCfg_ID.intValue() == 0)
			return "";
		
		X_M_ShipperCfg s = new X_M_ShipperCfg(ctx, M_ShipperCfg_ID, null);
		mTab.setValue(MShipper.COLUMNNAME_Name, s.getName());
		
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT sp.M_ShippingProcessor_ID ");
		sb.append("FROM M_ShippingProcessor sp, M_ShippingProcessorCfg xsp, M_ShipperCfg xs ");
		sb.append("WHERE sp.M_ShippingProcessorCfg_ID = xsp.M_ShippingProcessorCfg_ID ");
		sb.append("AND xsp.M_ShippingProcessorCfg_ID = xs.M_ShippingProcessorCfg_ID ");
		sb.append("AND sp.IsActive = 'Y' ");
		sb.append("AND sp.AD_Client_ID = ? ");
		sb.append("AND sp.AD_Org_ID IN (0, ?) ");
		sb.append("AND xs.M_ShipperCfg_ID = ? ");
		sb.append("ORDER BY sp.AD_Org_ID DESC");

		int M_ShippingProcessor_ID = DB.getSQLValue(null, sb.toString(), Env.getAD_Client_ID(ctx), Env.getAD_Org_ID(ctx), M_ShipperCfg_ID);
		if (M_ShippingProcessor_ID > 0)
			mTab.setValue(MShipper.COLUMNNAME_M_ShippingProcessor_ID, M_ShippingProcessor_ID);
		
		return null;
	}
	
	public String shipperLabels(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer M_ShipperLabelsCfg_ID = (Integer)value;
		if (M_ShipperLabelsCfg_ID == null || M_ShipperLabelsCfg_ID.intValue() == 0)
			return "";
		
		X_M_ShipperLabelsCfg sl = new X_M_ShipperLabelsCfg(ctx, M_ShipperLabelsCfg_ID, null);
		mTab.setValue(MShipperLabels.COLUMNNAME_Name, sl.getName());
		mTab.setValue(MShipperLabels.COLUMNNAME_LabelPrintMethod, sl.getLabelPrintMethod());
		mTab.setValue(MShipperLabels.COLUMNNAME_IsDefault, sl.isDefault());
		
		return null;		
	}
	
	public String shipperPackaging(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer M_ShipperPackagingCfg_ID = (Integer)value;
		if (M_ShipperPackagingCfg_ID == null || M_ShipperPackagingCfg_ID.intValue() == 0)
			return "";
		
		X_M_ShipperPackagingCfg sp = new X_M_ShipperPackagingCfg(ctx, M_ShipperPackagingCfg_ID, null);
		mTab.setValue(MShipperPackaging.COLUMNNAME_Name, sp.getName());
		mTab.setValue(MShipperPackaging.COLUMNNAME_IsDefault, sp.isDefault());
		mTab.setValue(MShipperPackaging.COLUMNNAME_Weight, sp.getWeight());
		
		return null;
	}
	
	public String shipperPickupTypes(Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		Integer M_ShipperPickupTypesCfg_ID = (Integer)value;
		if (M_ShipperPickupTypesCfg_ID == null || M_ShipperPickupTypesCfg_ID.intValue() == 0)
			return "";
		
		X_M_ShipperPickupTypesCfg spt = new X_M_ShipperPickupTypesCfg(ctx, M_ShipperPickupTypesCfg_ID, null);
		mTab.setValue(MShipperLabels.COLUMNNAME_Name, spt.getName());
		mTab.setValue(MShipperLabels.COLUMNNAME_IsDefault, spt.isDefault());
		
		return null;
	}
}
