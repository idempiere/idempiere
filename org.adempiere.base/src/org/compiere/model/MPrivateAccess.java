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

import org.compiere.util.CLogger;
import org.compiere.util.Env;

/**
 *	Private Access
 *	
 *  @author Jorg Janke
 *  @version $Id: MPrivateAccess.java,v 1.3 2006/07/30 00:58:18 jjanke Exp $
 */
public class MPrivateAccess extends X_AD_Private_Access
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1928860386263332639L;

	/**
	 * 	Get Private Access
	 *	@param ctx context 
	 *	@param AD_User_ID user
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 *	@return private access instance or null if not found
	 */
	public static MPrivateAccess get (Properties ctx, int AD_User_ID, int AD_Table_ID, int Record_ID)
	{
		return new Query(ctx, Table_Name, "AD_User_ID=? AND AD_Table_ID=? AND Record_ID=?", null)
				.setParameters(AD_User_ID, AD_Table_ID, Record_ID)
				.first();
	}	//	get

	/**
	 * 	Get Where Clause of Locked Records for Table.
	 *	@param AD_Table_ID table
	 *	@param AD_User_ID user requesting access
	 *	@return not in private access clause
	 */
	public static String getLockedRecordWhere (int AD_Table_ID, int AD_User_ID)
	{
		StringBuilder whereClause = new StringBuilder(" NOT IN (SELECT Record_ID FROM AD_Private_Access WHERE AD_Table_ID=")
			.append(AD_Table_ID)
			.append(" AND AD_User_ID<>")
			.append(AD_User_ID)
			.append(" AND IsActive='Y')");
		return whereClause.toString();
	}	//	get
	
	/**	Logger					*/
	private static CLogger		s_log = CLogger.getCLogger(MPrivateAccess.class);
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Private_Access_UU  UUID key
     * @param trxName Transaction
     */
    public MPrivateAccess(Properties ctx, String AD_Private_Access_UU, String trxName) {
        super(ctx, AD_Private_Access_UU, trxName);
    }

	/**
	 *	@param ctx context
	 *	@param ignored ignored
	 *	@param trxName transaction
	 */
	public MPrivateAccess (Properties ctx, int ignored, String trxName)
	{
		super(ctx, 0, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	}	//	MPrivateAccess

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MPrivateAccess(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MPrivateAccess

	/**
	 * 	New Constructor
	 *	@param ctx context
	 *	@param AD_User_ID user
	 *	@param AD_Table_ID table
	 *	@param Record_ID record
	 */
	public MPrivateAccess (Properties ctx, int AD_User_ID, int AD_Table_ID, int Record_ID)
	{
		super(ctx, 0, null);
		setAD_User_ID (AD_User_ID);
		setAD_Table_ID (AD_Table_ID);
		setRecord_ID (Record_ID);
	}	//	MPrivateAccess

	/**
	 * String representation of this object, used in Recent Items
	 */
	@Override
	public String toString() {
		MUser user = MUser.get(getAD_User_ID());
		MTable table = MTable.get(getAD_Table_ID());
		StringBuilder sb = new StringBuilder ("Private Access[")
				.append(user.getName())
				.append(",")
				.append(table.getName())
				.append(",")
				.append(getRecord_ID())
				.append("]");
		return sb.toString();
	}

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (!canUpdate()) {
			s_log.warning("Denied permission to update AD_Private_Access[" + getAD_Private_Access_UU() + "] on session " + Env.getContext(p_ctx, Env.AD_SESSION_ID));
			return false;
		}
		return true;
	}

	@Override
	protected boolean beforeDelete() {
		if (!canUpdate()) {
			s_log.warning("Denied permission to delete AD_Private_Access[" + getAD_Private_Access_UU() + "] on session " + Env.getContext(p_ctx, Env.AD_SESSION_ID));
			return false;
		}
		return true;
	}

	/**
	 * Validate if the current user/role can update this private access record<br/>
	 * - the owner of the record can update it<br/>
	 * - the role with IsPersonalAccess permission can update it
	 * @return true if can update
	 */
	private boolean canUpdate() {
		if (Env.getAD_User_ID(getCtx()) == getAD_User_ID())
			return true;
		if (MRole.getDefault().isPersonalAccess())
			return true;
		return false;
	}

}	//	MPrivateAccess
