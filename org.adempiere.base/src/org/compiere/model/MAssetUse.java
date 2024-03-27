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
import java.util.logging.Level;

import org.compiere.util.DB;

/**
 * Asset use model
 */
public class MAssetUse extends X_A_Asset_Use
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1247516669047870893L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param A_Asset_Use_UU  UUID key
     * @param trxName Transaction
     */
    public MAssetUse(Properties ctx, String A_Asset_Use_UU, String trxName) {
        super(ctx, A_Asset_Use_UU, trxName);
    }

    /**
     * @param ctx
     * @param A_Asset_Use_ID
     * @param trxName
     */
	public MAssetUse (Properties ctx, int A_Asset_Use_ID, String trxName)
	{
		super (ctx, A_Asset_Use_ID, trxName);
	}	//	MAssetUse

	/**
	 *  Load Constructor
	 *  @param ctx context
	 *  @param rs result set record
	 */
	public MAssetUse (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MAssetUse

	@Override
	protected boolean afterSave (boolean newRecord,boolean success)
	{
		if(log.isLoggable(Level.INFO)) log.info ("afterSave");
		if (!success)
			return success;
		int		p_A_Asset_ID = 0;
		int		total_unitsused = 0;	
		p_A_Asset_ID = getA_Asset_ID();
				
		// Update total UseUnits of asset
		String sql = "SELECT SUM(USEUNITS) FROM A_Asset_use WHERE A_Asset_ID=? and usedate <= getDate()";
		total_unitsused = DB.getSQLValueEx(null, sql, getA_Asset_ID());
		
		MAsset asset = MAsset.get(getCtx(), p_A_Asset_ID, null);
		asset.setUseUnits(total_unitsused);
		asset.setProcessing(false);	
		asset.saveEx();
				
		// Record changes to asset
		MAssetChange change = new MAssetChange (getCtx(), 0,null);
			
		change.setA_Asset_ID(p_A_Asset_ID);            
		change.setChangeType("USE");
		change.setTextDetails(MRefList.getListDescription (getCtx(),"A_Update_Type" , "USE"));
		change.setUseUnits(getUseUnits());
		change.saveEx();
		
		return success;
		 		
	}	//	afterSave

}
