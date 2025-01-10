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
import java.util.List;
import java.util.Properties;

import org.compiere.util.CLogger;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 *	User Org Access
 *	
 *  @author Jorg Janke
 *  @version $Id: MUserOrgAccess.java,v 1.3 2006/07/30 00:58:37 jjanke Exp $
 */
public class MUserOrgAccess extends X_AD_User_OrgAccess
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6016959957385716517L;

	/**
	 * 	Get Organizational Access of User
	 *	@param ctx context
	 *	@param AD_User_ID user
	 *	@return array of User Org Access
	 */
	public static MUserOrgAccess[] getOfUser (Properties ctx, int AD_User_ID)
	{
		return get (ctx, "AD_User_ID=?", AD_User_ID);
	}	//	getOfUser

	/**
	 * 	Get Organizational Access of User
	 *	@param ctx context
	 *	@param where SQL where clause
	 *	@param id user id
	 *	@return array of User Org Access
	 */
	private static MUserOrgAccess[] get (Properties ctx, String where, int id)
	{
		List<MUserOrgAccess> list = new Query(ctx, Table_Name, where, null)
				.setParameters(id)
				.setOnlyActiveRecords(true)
				.list();
		MUserOrgAccess[] retValue = new MUserOrgAccess[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	get

	/**	Static Logger	*/
	@SuppressWarnings("unused")
	private static CLogger	s_log	= CLogger.getCLogger (MUserOrgAccess.class);
	
	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MUserOrgAccess (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MUserOrgAccess

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_User_OrgAccess_UU  UUID key
     * @param trxName Transaction
     */
    public MUserOrgAccess(Properties ctx, String AD_User_OrgAccess_UU, String trxName) {
        super(ctx, AD_User_OrgAccess_UU, trxName);
		if (Util.isEmpty(AD_User_OrgAccess_UU))
			setInitialDefaults();
    }

	/**
	 * 	New Record Constructor
	 *	@param ctx context
	 *	@param ignored ignored
	 *	@param trxName transaction
	 */
	public MUserOrgAccess (Properties ctx, int ignored, String trxName)
	{
		super(ctx, 0, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
		setInitialDefaults();
	}	//	MUserOrgAccess
	
	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setIsReadOnly(false);
	}

	/**
	 * 	Organization Constructor
	 *	@param org org
	 *	@param AD_User_ID role
	 */
	public MUserOrgAccess (MOrg org, int AD_User_ID)
	{
		this (org.getCtx(), 0, org.get_TrxName());
		setClientOrg (org);
		setAD_User_ID (AD_User_ID);
	}	//	MUserOrgAccess

	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MUserOrgAccess[");
		sb.append("AD_User_ID=").append(getAD_User_ID())
			.append(",AD_Client_ID=").append(getAD_Client_ID())
			.append(",AD_Org_ID=").append(getAD_Org_ID())
			.append(",RO=").append(isReadOnly());	
		sb.append("]");
		return sb.toString();
	}	//	toString
	
	/**
	 * 	Extended String Representation
	 * 	@param ctx context
	 *	@return extended info
	 */
	public String toStringX (Properties ctx)
	{
		StringBuilder sb = new StringBuilder();
		sb.append(Msg.translate(ctx, "AD_Client_ID")).append("=").append(getClientName()).append(" - ")
			.append(Msg.translate(ctx, "AD_Org_ID")).append("=").append(getOrgName());	
		return sb.toString();
	}	//	toStringX

	private String	m_clientName;
	private String	m_orgName;
	
	/**
	 * 	Get Tenant Name
	 *	@return tenant name
	 */
	public String getClientName()
	{
		if (m_clientName == null)
		{
			MOrg org = MOrg.get(getAD_Org_ID());
			MClient client = MClient.get(org.getAD_Client_ID());
			m_clientName = client.getName();
			m_orgName = org.getName();
		}
		return m_clientName;
	}	//	getClientName
	
	/**
	 * 	Get Organization Name
	 *	@return organization name
	 */
	public String getOrgName()
	{
		if (m_orgName == null)
			getClientName();
		return m_orgName;
	}	//	getOrgName

}	//	MUserOrgAccess
