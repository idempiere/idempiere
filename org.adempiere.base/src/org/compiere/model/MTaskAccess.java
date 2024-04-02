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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

/**
 *
 * @author Carlos Ruiz - globalqss - bxservice
 *
 */

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.Adempiere;
import org.compiere.util.CacheMgt;
import org.compiere.util.Util;

public class MTaskAccess extends X_AD_Task_Access
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2652529697830798536L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Task_Access_UU  UUID key
     * @param trxName Transaction
     */
    public MTaskAccess(Properties ctx, String AD_Task_Access_UU, String trxName) {
        super(ctx, AD_Task_Access_UU, trxName);
		if (Util.isEmpty(AD_Task_Access_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param ignored id=0
	 *	@param trxName trx
	 */
	public MTaskAccess (Properties ctx, int ignored, String trxName)
	{
		super(ctx, 0, trxName);
		if (ignored == 0)
			setInitialDefaults();
		else
			throw new IllegalArgumentException("Multi-Key");
	}	//	MTaskAccess

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setIsReadWrite (true);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MTaskAccess (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MTaskAccess
	
	/**
	 * 	Parent Constructor
	 *	@param parent parent
	 *	@param AD_Role_ID role id
	 */
	public MTaskAccess (MTask parent, int AD_Role_ID)
	{
		super (parent.getCtx(), 0, parent.get_TrxName());
		MRole role = MRole.get(parent.getCtx(), AD_Role_ID);
		setClientOrg(role);
		setAD_Task_ID(parent.getAD_Task_ID());
		setAD_Role_ID (AD_Role_ID);
	}	//	MTaskAccess

	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		// Reset role cache
		if (success)
			Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(MRole.Table_Name, getAD_Role_ID()));
		return success;
	}	//	afterSave

	@Override
	protected boolean afterDelete(boolean success) {
		// Reset role cache
		if (success)
			Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(MRole.Table_Name, getAD_Role_ID()));
		return success;
	}

}	//	MTaskAccess
