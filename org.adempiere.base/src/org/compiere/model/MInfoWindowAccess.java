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
 * @author hengsin
 *
 */
public class MInfoWindowAccess extends X_AD_InfoWindow_Access {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -5134731157350014858L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_InfoWindow_Access_UU  UUID key
     * @param trxName Transaction
     */
    public MInfoWindowAccess(Properties ctx, String AD_InfoWindow_Access_UU, String trxName) {
        super(ctx, AD_InfoWindow_Access_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param ignored
	 * @param trxName
	 */
	public MInfoWindowAccess(Properties ctx, int ignored, String trxName) {
		super(ctx, 0, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MInfoWindowAccess(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * 	Parent Constructor
	 *	@param parent parent
	 *	@param AD_Role_ID role id
	 */
	public MInfoWindowAccess (MInfoWindow parent, int AD_Role_ID)
	{
		super (parent.getCtx(), 0, parent.get_TrxName());
		MRole role = MRole.get(parent.getCtx(), AD_Role_ID);
		setClientOrg(role);
		setAD_InfoWindow_ID(parent.getAD_InfoWindow_ID());
		setAD_Role_ID (AD_Role_ID);
	}	//	MInfoWindowAccess

}
