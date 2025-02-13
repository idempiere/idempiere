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
 * - Carlos Ruiz                                                       *
 **********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.Adempiere;
import org.compiere.util.CacheMgt;

public class MDocumentActionAccess extends X_AD_Document_Action_Access {
    /**
	 * 
	 */
	private static final long serialVersionUID = -7387829651626682825L;

	/**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Document_Action_Access_UU  UUID key
     * @param trxName Transaction
     */
    public MDocumentActionAccess(Properties ctx, String AD_Document_Action_Access_UU, String trxName) {
        super(ctx, AD_Document_Action_Access_UU, trxName);
    }

	/**
	 * Standard Constructor
	 * 
	 * @param ctx     context
	 * @param ignored -
	 * @param trxName transaction
	 */
	public MDocumentActionAccess(Properties ctx, int ignored, String trxName) {
		super(ctx, 0, trxName);
		if (ignored != 0)
			throw new IllegalArgumentException("Multi-Key");
	} // MDocumentActionAccess

	/**
	 * MDocumentActionAccess
	 * 
	 * @param ctx
	 * @param rs
	 * @param trxName transaction
	 */
	public MDocumentActionAccess(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MDocumentActionAccess

	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		// Reset role cache
		if (success)
			Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(MRole.Table_Name, getAD_Role_ID()));
		return success;
	}	//	afterSave

	@Override
	protected boolean afterDelete(boolean success) {
		// Reset role cache
		if (success)
			Adempiere.getThreadPoolExecutor().submit(() -> CacheMgt.get().reset(MRole.Table_Name, getAD_Role_ID()));
		return success;
	}

} // MDocumentActionAccess
