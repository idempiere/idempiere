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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.util.CLogger;

/**
 * Persistence model for attachment file
 * 
 * @author Carlos Ruiz - globalqss - bxservice
 */
public class MAttachmentFile extends X_AD_AttachmentFile {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1785291963308055733L;

	/** Static Logger */
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger(MAttachmentFile.class);

	/**
	 * UUID based Constructor
	 * 
	 * @param ctx            Context
	 * @param AD_AttachmentFile_UU UUID key
	 * @param trxName        Transaction
	 */
	public MAttachmentFile(Properties ctx, String AD_AttachmentFile_UU, String trxName) {
		super(ctx, AD_AttachmentFile_UU, trxName);
	}

	/**
	 * Load Constructor
	 * 
	 * @param ctx     context
	 * @param rs      result set
	 * @param trxName transaction
	 */
	public MAttachmentFile(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MAttachmentFile

} // MAttachmentFile