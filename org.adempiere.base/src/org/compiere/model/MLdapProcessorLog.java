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

import org.compiere.util.Util;

/**
 *	LDAP Processor Log
 *  @author Jorg Janke
 *  @version $Id$
 */
public class MLdapProcessorLog extends X_AD_LdapProcessorLog implements AdempiereProcessorLog
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -2587778949013986055L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_LdapProcessorLog_UU  UUID key
     * @param trxName Transaction
     */
    public MLdapProcessorLog(Properties ctx, String AD_LdapProcessorLog_UU, String trxName) {
        super(ctx, AD_LdapProcessorLog_UU, trxName);
		if (Util.isEmpty(AD_LdapProcessorLog_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_LdapProcessorLog_ID id
	 *	@param trxName trx
	 */
	public MLdapProcessorLog(Properties ctx, int AD_LdapProcessorLog_ID,
		String trxName)
	{
		super (ctx, AD_LdapProcessorLog_ID, trxName);
		if (AD_LdapProcessorLog_ID == 0)
			setInitialDefaults();
	}	//	MLdapProcessorLog

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setIsError (false);
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MLdapProcessorLog(Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MLdapProcessorLog

	/**
	 * 	Parent Constructor
	 *	@param parent parent
	 *	@param summary summary
	 */
	public MLdapProcessorLog(MLdapProcessor parent, String summary)
	{
		this (parent.getCtx (), 0, null);
		setClientOrg (parent);
		setAD_LdapProcessor_ID (parent.getAD_LdapProcessor_ID());
		setSummary (summary);
	}	//	MLdapProcessorLog

}	//	MLdapProcessorLog
