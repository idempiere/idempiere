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
 * - Carlos Ruiz - globalqss                                           *
 **********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 *	Context Help Model
 *	
 *  @author Carlos Ruiz
 */
public class MCtxHelp extends X_AD_CtxHelp {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6004459503884638672L;

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_CtxHelp_ID
	 *	@param trxName transaction
	 */
	public MCtxHelp (Properties ctx, int AD_CtxHelp_ID, String trxName) {
		super (ctx, AD_CtxHelp_ID, trxName);
	}	//	MCtxHelp

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MCtxHelp (Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}	//	MCtxHelp

	/* (non-Javadoc)
	 * @see org.compiere.model.PO#setClientOrg(int, int)
	 */
	@Override
	public void setClientOrg(int AD_Client_ID, int AD_Org_ID) {
		super.setClientOrg(AD_Client_ID, AD_Org_ID);
	}

}	//	MCtxHelp
