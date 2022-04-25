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

import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * 	Scheduler Recipient Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MSchedulerRecipient.java,v 1.2 2006/07/30 00:51:03 jjanke Exp $
 */
public class MSchedulerRecipient extends X_AD_SchedulerRecipient implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4928359768598663557L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_SchedulerRecipient_ID id
	 *	@param trxName transaction
	 */	
	public MSchedulerRecipient (Properties ctx, int AD_SchedulerRecipient_ID,
		String trxName)
	{
		super (ctx, AD_SchedulerRecipient_ID, trxName);
	}	//	MSchedulerRecipient

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MSchedulerRecipient (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MSchedulerRecipient
	
	/**
	 * 
	 * @param copy
	 */
	public MSchedulerRecipient(MSchedulerRecipient copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MSchedulerRecipient(Properties ctx, MSchedulerRecipient copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MSchedulerRecipient(Properties ctx, MSchedulerRecipient copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public MSchedulerRecipient markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString() 
	{
		StringBuilder sb = new StringBuilder("MSchedulerRecipient[");
		sb.append(get_ID()).append("-")
			.append("AD_User_ID").append("=").append(getAD_User_ID())
			.append(",AD_Role_ID").append("=").append(getAD_Role_ID())
			.append(",IsUpload").append("=").append(isUpload())
			.append(",AD_AuthorizationAccount_ID").append("=").append(getAD_AuthorizationAccount_ID())
			.append("]");
		return sb.toString();
	} //	toString
}	//	MSchedulerRecipient
