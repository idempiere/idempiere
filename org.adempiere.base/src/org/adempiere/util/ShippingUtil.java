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
package org.adempiere.util;

import org.compiere.util.DB;

/**
 * Helper methods for shipping
 */
public class ShippingUtil 
{
	/**
	 * Get shipper account from C_BP_ShippingAcct
	 * @param shipper_id M_Shipper_ID
	 * @param org_id AD_Org_ID
	 * @return Shipper Account
	 */
	public static String getSenderShipperAccount(int shipper_id, int org_id)
	{
		StringBuilder sb = new StringBuilder();
    	sb.append("SELECT sa.ShipperAccount ");
    	sb.append("FROM C_BP_ShippingAcct sa, M_Shipper s ");
    	sb.append("WHERE s.M_Shipper_ID= ? ");
    	sb.append("AND sa.IsActive = 'Y' ");
    	sb.append("AND sa.C_BPartner_ID = s.C_BPartner_ID ");
    	sb.append("AND sa.AD_Org_ID= ? ");
    	return DB.getSQLValueStringEx(null, sb.toString(), shipper_id, org_id);
	}
	
	/**
	 * Get duties shipper account from C_BP_ShippingAcct
	 * @param shipper_id M_Shipper_ID
	 * @param org_id AD_Org_ID
	 * @return DutiesShipperAccount (if any)
	 */
	public static String getSenderDutiesShipperAccount(int shipper_id, int org_id)
	{
		StringBuilder sb = new StringBuilder();
    	sb.append("SELECT sa.DutiesShipperAccount ");
    	sb.append("FROM C_BP_ShippingAcct sa, M_Shipper s ");
    	sb.append("WHERE s.M_Shipper_ID= ? ");
    	sb.append("AND sa.IsActive = 'Y' ");
    	sb.append("AND sa.C_BPartner_ID = s.C_BPartner_ID ");
    	sb.append("AND sa.AD_Org_ID= ? ");
    	return DB.getSQLValueStringEx(null, sb.toString(), shipper_id, org_id);
	}
	
	/**
	 * Find recipient C_BPartner_Location_ID from C_BP_ShippingAcct, M_InOut or C_Order (in the listed order).
	 * @param shipper_id M_Shipper_ID
	 * @param c_bpartner_id C_BPartner_ID
	 * @param ad_org_id AD_Org_ID
	 * @param inout_id M_InOut_ID
	 * @param order_id C_Order_ID
	 * @return C_BPartner_Location_ID
	 */
	public static int findRecipientAccountLocationId(int shipper_id, int c_bpartner_id, int ad_org_id, int inout_id, int order_id) 
	{
		int accountLocationId= DB.getSQLValueEx(null, 
				"SELECT C_BPartner_Location_ID "
			 + "  FROM C_BP_ShippingAcct "
			 + " WHERE C_BPartner_ID = ? "
			 + "   AND AD_Org_ID = " + ad_org_id
			 + " AND M_ShippingProcessor_ID IN (SELECT DISTINCT M_ShippingProcessor_ID FROM M_Shipper WHERE M_Shipper_ID = " + shipper_id + ")"
			 + "   AND C_BPartner_Location_ID Is Not Null", c_bpartner_id);
		if (accountLocationId <= 0) 
		{
			// Try without organization
		    accountLocationId = DB.getSQLValueEx(null, 
		   			"SELECT bps.C_BPartner_Location_ID"
		   		 + "  FROM C_BP_ShippingAcct bps, C_BPartner_Location bpl, C_Location l "
		   		 + " WHERE bps.C_BPartner_ID = ? "
				 + " AND bps.M_ShippingProcessor_ID IN (SELECT DISTINCT M_ShippingProcessor_ID FROM M_Shipper WHERE M_Shipper_ID = " + shipper_id + ")"
		   		 + "   AND bps.C_BPartner_Location_ID = bpl.C_BPartner_Location_ID "
		   		 + "   AND bpl.C_Location_ID = l.C_Location_ID "
		   		 + "   AND l.Postal IS NOT NULL ", c_bpartner_id);
		}
		// if not found then try to get it from the order invoice location, or from the invoice location
		if (accountLocationId <= 0) 
		{
			if (inout_id > 0) 
			{
			    accountLocationId = DB.getSQLValueEx(null, 
			    		"SELECT bpl.C_BPartner_Location_ID"
			    		 + "  FROM M_InOut io, C_Order o, C_BPartner_Location bpl, C_Location l "
			    		 + " WHERE io.M_InOut_ID = ? "
			    		 + "   AND io.C_Order_ID = o.C_Order_ID "
			    		 + "   AND o.Bill_Location_ID = bpl.C_BPartner_Location_ID "
			    		 + "   AND bpl.C_Location_ID = l.C_Location_ID "
			    		 + "   AND l.Postal IS NOT NULL ", inout_id);
			    if (accountLocationId <= 0) {
			        accountLocationId = DB.getSQLValueEx(null, 
			        		"SELECT bpl.C_BPartner_Location_ID"
			        		 + "  FROM M_InOut io, C_Invoice i, C_BPartner_Location bpl, C_Location l "
			        		 + " WHERE io.M_InOut_ID = ? "
			        		 + "   AND io.C_Invoice_ID = i.C_Invoice_ID "
			        		 + "   AND i.C_BPartner_Location_ID = bpl.C_BPartner_Location_ID "
			        		 + "   AND bpl.C_Location_ID = l.C_Location_ID "
			        		 + "   AND l.Postal IS NOT NULL ", inout_id);
			    }
			} 
			else 
			{
				accountLocationId = DB.getSQLValueEx(null, 
			    		"SELECT bpl.C_BPartner_Location_ID"
			    		 + "  FROM C_Order o, C_BPartner_Location bpl, C_Location l "
			    		 + "   WHERE o.C_Order_ID = ?"
			    		 + "   AND o.Bill_Location_ID = bpl.C_BPartner_Location_ID "
			    		 + "   AND bpl.C_Location_ID = l.C_Location_ID "
			    		 + "   AND l.Postal IS NOT NULL ", order_id);
			}
		}
		return accountLocationId;
	}
	
	/**
	 * Get shipper account number (ShipperAccount) from C_BP_ShippingAcct
	 * @param shipper_id
	 * @param c_bpartner_id
	 * @param c_bpartner_location_id
	 * @param org_id
	 * @param trxName
	 * @return shipper account number (if any)
	 */
	public static String getBPShipperAccount(int shipper_id, int c_bpartner_id, int c_bpartner_location_id, int org_id, String trxName)
	{
		StringBuilder sb = new StringBuilder();
    	sb.append("SELECT sa.ShipperAccount ");
    	sb.append("FROM C_BP_ShippingAcct sa ");
    	sb.append("WHERE sa.M_ShippingProcessor_ID IN (SELECT DISTINCT M_ShippingProcessor_ID FROM M_Shipper WHERE M_Shipper_ID = ?) ");
    	sb.append("AND sa.IsActive = 'Y' ");
    	sb.append("AND sa.C_BPartner_ID = ? ");
    	sb.append("AND (sa.C_BPartner_Location_ID IS NULL OR sa.C_BPartner_Location_ID = ?) ");
    	sb.append("AND sa.AD_Org_ID IN (0, ?) ");
    	sb.append("ORDER BY C_BPartner_Location_ID, AD_Org_ID ");
    	return DB.getSQLValueStringEx(trxName, sb.toString(), shipper_id, c_bpartner_id, c_bpartner_location_id, org_id);
	}
}