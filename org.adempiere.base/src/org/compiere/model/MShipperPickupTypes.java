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

import java.sql.ResultSet;
import java.util.Properties;

/**
 * Shipper pickup type model
 */
public class MShipperPickupTypes extends X_M_ShipperPickupTypes 
{	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2836350317204286835L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_ShipperPickupTypes_UU  UUID key
     * @param trxName Transaction
     */
    public MShipperPickupTypes(Properties ctx, String M_ShipperPickupTypes_UU, String trxName) {
        super(ctx, M_ShipperPickupTypes_UU, trxName);
    }

    /**
     * @param ctx
     * @param M_ShipperPickupTypes_ID
     * @param trxName
     */
	public MShipperPickupTypes(Properties ctx, int M_ShipperPickupTypes_ID, String trxName) 
	{
		super(ctx, M_ShipperPickupTypes_ID, trxName);
	}
	
	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MShipperPickupTypes(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	/**
	 * @return value (search key) of pickup type
	 */
	public String getValue()
	{
		return getM_ShipperPickupTypesCfg().getValue();
	}
	
}
