/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * Online transaction history model
 * @author Elaine
 *
 */
public class MOnlineTrxHistory extends X_C_OnlineTrxHistory {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 2160888813932490117L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_OnlineTrxHistory_UU  UUID key
     * @param trxName Transaction
     */
    public MOnlineTrxHistory(Properties ctx, String C_OnlineTrxHistory_UU, String trxName) {
        super(ctx, C_OnlineTrxHistory_UU, trxName);
    }

    /**
     * @param ctx
     * @param C_OnlineTrxHistory_ID
     * @param trxName
     */
	public MOnlineTrxHistory(Properties ctx, int C_OnlineTrxHistory_ID, String trxName)
	{
		super(ctx, C_OnlineTrxHistory_ID, trxName);
	}
	
	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MOnlineTrxHistory(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}
}
