/**
 *  Product: Posterita Web-Based POS and Adempiere Plugin
 *  Copyright (C) 2007  Posterita Ltd
 *  This file is part of POSterita
 *  
 *  POSterita is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program; if not, write to the Free Software Foundation, Inc.,
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 * Created on 27-Jul-2005 by alok
 *
 */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

@Deprecated
public class MRoleMenu extends X_U_RoleMenu
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 9022716123964882452L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param U_RoleMenu_UU  UUID key
     * @param trxName Transaction
     */
    public MRoleMenu(Properties ctx, String U_RoleMenu_UU, String trxName) {
        super(ctx, U_RoleMenu_UU, trxName);
    }

    /**
     * @param ctx
     * @param U_RoleMenu_ID
     * @param trxName
     */
	public MRoleMenu(Properties ctx, int U_RoleMenu_ID, String trxName)
	{
		super(ctx, U_RoleMenu_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MRoleMenu(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
}
