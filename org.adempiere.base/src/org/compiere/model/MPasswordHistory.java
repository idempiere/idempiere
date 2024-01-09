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
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;

public class MPasswordHistory extends X_AD_Password_History {
	/**
	 * generated serial id 
	 */
    private static final long serialVersionUID = -5199700193821111847L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Password_History_UU  UUID key
     * @param trxName Transaction
     */
    public MPasswordHistory(Properties ctx, String AD_Password_History_UU, String trxName) {
        super(ctx, AD_Password_History_UU, trxName);
    }

    /**
     * @param ctx
     * @param AD_Password_History_ID
     * @param trxName
     */
	public MPasswordHistory(Properties ctx, int AD_Password_History_ID, String trxName) {
		super(ctx, AD_Password_History_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MPasswordHistory(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * @param salt
	 * @param password
	 */
	public MPasswordHistory(String salt, String password) {
		super(Env.getCtx(), 0, null);
		this.setSalt(salt);
		this.setPassword(password);
	}
	
	/**
	 * get password history records with age &lt;= passwordMaxDay + daysReuse
	 * @param daysReuse max day can't reuse password, get from password rule
	 * @param userId AD_User_ID
	 * @return list of password history record 
	 */
	public static List<MPasswordHistory> getPasswordHistoryForCheck (int daysReuse, int userId){
		if (daysReuse <= 0) {
			return new ArrayList<MPasswordHistory>();
		}
		StringBuilder whereClause = new StringBuilder()
				.append("getDate()-")
				.append(daysReuse)
				.append("<=DatePasswordChanged AND AD_User_ID=")
				.append(userId);
		
		Query query = new Query(Env.getCtx(), MPasswordHistory.Table_Name, whereClause.toString(), null);
		query.setClient_ID(true);
		
		return query.list();
	}

}
