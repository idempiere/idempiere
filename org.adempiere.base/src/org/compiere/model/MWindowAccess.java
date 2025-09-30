/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.Adempiere;
import org.compiere.util.CacheMgt;
import org.compiere.util.Util;

/**
 *  Extended model class for AD_Window_Access
 *	
 *  @author Jorg Janke
 *  @version $Id: MWindowAccess.java,v 1.4 2006/07/30 00:54:54 jjanke Exp $
 */
public class MWindowAccess extends X_AD_Window_Access
{
    /**
	 * generated serial id
	 */
	private static final long serialVersionUID = 7056606424817652079L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Window_Access_UU  UUID key
     * @param trxName Transaction
     */
    public MWindowAccess(Properties ctx, String AD_Window_Access_UU, String trxName) {
        super(ctx, AD_Window_Access_UU, trxName);
		if (Util.isEmpty(AD_Window_Access_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param ignored -
	 *	@param trxName transaction
	 */
	public MWindowAccess (Properties ctx, int ignored, String trxName)
	{
		super(ctx, 0, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
		else
			setInitialDefaults();
	}	//	MWindowAccess

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setIsReadWrite (true);
	}

	/**
	 * 	MWindowAccess
	 *	@param ctx
	 *	@param rs
	 *	@param trxName transaction
	 */
	public MWindowAccess (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MWindowAccess

	/**
	 * 	Parent Constructor
	 *	@param parent parent
	 *	@param AD_Role_ID role id
	 */
	public MWindowAccess (MWindow parent, int AD_Role_ID)
	{
		super (parent.getCtx(), 0, parent.get_TrxName());
		MRole role = MRole.get(parent.getCtx(), AD_Role_ID);
		setClientOrg(role);
		setAD_Window_ID(parent.getAD_Window_ID());
		setAD_Role_ID (AD_Role_ID);
	}	//	MWindowAccess

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

}	//	MWindowAccess
