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
 *	Request Processor Log
 *	
 *  @author Jorg Janke
 *  @version $Id: MRequestProcessorLog.java,v 1.2 2006/07/30 00:51:05 jjanke Exp $
 */
public class MRequestProcessorLog extends X_R_RequestProcessorLog
	implements AdempiereProcessorLog
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = 3295903266591998482L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param R_RequestProcessorLog_UU  UUID key
     * @param trxName Transaction
     */
    public MRequestProcessorLog(Properties ctx, String R_RequestProcessorLog_UU, String trxName) {
        super(ctx, R_RequestProcessorLog_UU, trxName);
		if (Util.isEmpty(R_RequestProcessorLog_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param R_RequestProcessorLog_ID id
	 *  @param trxName
	 */
	public MRequestProcessorLog (Properties ctx, int R_RequestProcessorLog_ID, String trxName)
	{
		super (ctx, R_RequestProcessorLog_ID, trxName);
		if (R_RequestProcessorLog_ID == 0)
			setInitialDefaults();
	}	//	MRequestProcessorLog

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
	 *  @param trxName
	 */
	public MRequestProcessorLog (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MRequestProcessorLog

	/**
	 * 	Parent Constructor
	 *	@param parent parent
	 *	@param summary summary
	 */
	public MRequestProcessorLog (MRequestProcessor parent, String summary)
	{
		this (parent.getCtx(), 0, parent.get_TrxName());
		setClientOrg(parent);
		setR_RequestProcessor_ID(parent.getR_RequestProcessor_ID());
		setSummary(summary);
	}	//	MRequestProcessorLog
	
}	//	MRequestProcessorLog
