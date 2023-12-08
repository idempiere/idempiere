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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;

/**
 * Shipper label model
 */
public class MShipperLabels extends X_M_ShipperLabels 
{	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 3903237243862044930L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_ShipperLabels_UU  UUID key
     * @param trxName Transaction
     */
    public MShipperLabels(Properties ctx, String M_ShipperLabels_UU, String trxName) {
        super(ctx, M_ShipperLabels_UU, trxName);
    }

    /**
     * @param ctx
     * @param M_ShipperLabels_ID
     * @param trxName
     */
	public MShipperLabels(Properties ctx, int M_ShipperLabels_ID, String trxName) 
	{
		super(ctx, M_ShipperLabels_ID, trxName);
	}
	
	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MShipperLabels(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
	
	/**
	 * @return value (search key) of label
	 */
	public String getValue()
	{
		return getM_ShipperLabelsCfg().getValue();
	}
	
	/**
	 * @return label height
	 */
	public BigDecimal getHeight()
	{
		return getM_ShipperLabelsCfg().getHeight();
	}
	
	/**
	 * @return label width
	 */
	public BigDecimal getWidth()
	{
		return getM_ShipperLabelsCfg().getWidth();
	}
	
}
