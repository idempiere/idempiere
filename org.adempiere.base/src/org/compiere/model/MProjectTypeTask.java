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
import org.compiere.util.Util;

/**
 * 	Project Type Task Model
 *
 *	@author Jorg Janke
 *	@version $Id: MProjectTypeTask.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class MProjectTypeTask extends X_C_Task
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -5649262800489348606L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_Task_UU  UUID key
     * @param trxName Transaction
     */
    public MProjectTypeTask(Properties ctx, String C_Task_UU, String trxName) {
        super(ctx, C_Task_UU, trxName);
		if (Util.isEmpty(C_Task_UU))
			setInitialDefaults();
    }

    /**
     * @param ctx
     * @param C_Task_ID
     * @param trxName
     */
	public MProjectTypeTask (Properties ctx, int C_Task_ID, String trxName)
	{
		super (ctx, C_Task_ID, trxName);
		if (C_Task_ID == 0)
			setInitialDefaults();
	}	//	MProjectTypeTask

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setSeqNo (0);
		setStandardQty (Env.ZERO);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MProjectTypeTask (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MProjectTypeTask

}	//	MProjectTypeTask
