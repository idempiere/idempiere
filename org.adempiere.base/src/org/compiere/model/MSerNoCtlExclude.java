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

import org.compiere.util.Env;

public class MSerNoCtlExclude extends X_M_SerNoCtlExclude {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -5338323423136199056L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param M_SerNoCtlExclude_UU  UUID key
     * @param trxName Transaction
     */
    public MSerNoCtlExclude(Properties ctx, String M_SerNoCtlExclude_UU, String trxName) {
        super(ctx, M_SerNoCtlExclude_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param M_SerNoCtlExclude_ID
	 * @param trxName
	 */
	public MSerNoCtlExclude(Properties ctx, int M_SerNoCtlExclude_ID, String trxName) {
		super(ctx, M_SerNoCtlExclude_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MSerNoCtlExclude(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MSerNoCtlExclude(MSerNoCtlExclude copy) {
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MSerNoCtlExclude(Properties ctx, MSerNoCtlExclude copy) {
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MSerNoCtlExclude(Properties ctx, MSerNoCtlExclude copy, String trxName) {
		this(ctx, 0, trxName);
		copyPO(copy);
	}
}
