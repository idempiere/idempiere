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
* - Trek Global Corporation                                           *
* - Heng Sin Low                                                      *
**********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.idempiere.cache.ImmutablePOSupport;

/**
 * @author hengsin
 *
 */
public class MUserBPAccess extends X_AD_UserBPAccess implements ImmutablePOSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4549943360035715233L;

	/**
	 * @param ctx
	 * @param AD_UserBPAccess_ID
	 * @param trxName
	 */
	public MUserBPAccess(Properties ctx, int AD_UserBPAccess_ID, String trxName) {
		super(ctx, AD_UserBPAccess_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MUserBPAccess(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	@Override
	public MUserBPAccess markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
