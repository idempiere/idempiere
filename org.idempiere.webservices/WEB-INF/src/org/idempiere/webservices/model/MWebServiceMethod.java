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
package org.idempiere.webservices.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;

/**
 * @author hengsin
 *
 */
@org.adempiere.base.Model(table = X_WS_WebServiceMethod.Table_Name)
public class MWebServiceMethod extends X_WS_WebServiceMethod implements ImmutablePOSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6822623209157500849L;

	/**
	 * @param ctx
	 * @param WS_WebServiceMethod_ID
	 * @param trxName
	 */
	public MWebServiceMethod(Properties ctx, int WS_WebServiceMethod_ID, String trxName) {
		super(ctx, WS_WebServiceMethod_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MWebServiceMethod(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * 
	 * @param copy
	 */
	public MWebServiceMethod(MWebServiceMethod copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MWebServiceMethod(Properties ctx, MWebServiceMethod copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MWebServiceMethod(Properties ctx, MWebServiceMethod copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	@Override
	public MWebServiceMethod markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}
