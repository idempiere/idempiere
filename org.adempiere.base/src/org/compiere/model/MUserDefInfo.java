/**********************************************************************
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
 * User overrides for Info Window Model
 * @author Igor Pojzl, Cloudempiere
 * @version $Id$
 */
public class MUserDefInfo extends X_AD_UserDef_Info {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5611033457579880793L;

	public MUserDefInfo(Properties ctx, int AD_UserDef_Info_ID, String trxName) {
		super(ctx, AD_UserDef_Info_ID, trxName);
	}

	public MUserDefInfo(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}



}
