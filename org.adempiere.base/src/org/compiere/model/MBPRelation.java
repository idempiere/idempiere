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
 * Persistence model for BP Relation
 * 
 * @author Carlos Ruiz - globalqss - bxservice
 */
public class MBPRelation extends X_C_BP_Relation {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7497379597365273790L;

	/** Static Logger */
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger(MBPRelation.class);

	/**
	 * ID based Constructor
	 * 
	 * @param ctx            Context
	 * @param C_BP_Relation_ID ID key
	 * @param trxName        Transaction
	 */
	public MBPRelation(Properties ctx, int C_BP_Relation_ID, String trxName) {
		super(ctx, C_BP_Relation_ID, trxName);
	}

	/**
	 * UUID based Constructor
	 * 
	 * @param ctx            Context
	 * @param C_BP_Relation_UU UUID key
	 * @param trxName        Transaction
	 */
	public MBPRelation(Properties ctx, String C_BP_Relation_UU, String trxName) {
		super(ctx, C_BP_Relation_UU, trxName);
	}

	/**
	 * Load Constructor
	 * 
	 * @param ctx     context
	 * @param rs      result set
	 * @param trxName transaction
	 */
	public MBPRelation(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MAttachmentFile

	/**
	 * Validates if the BP Relation can be used to pay a document
	 * @param ctx
	 * @param bpProxyId
	 * @param bpDocId
	 * @param trxName
	 * @return
	 */
	public static boolean canPay(Properties ctx, int bpProxyId, int bpDocId, String trxName) {
		int cnt = new Query(ctx, Table_Name, "IsPayFrom='Y' AND C_BPartner_ID=? AND C_BPartnerRelation_ID=?", trxName)
				.setParameters(bpDocId, bpProxyId)
				.setOnlyActiveRecords(true)
				.count();
		return cnt > 0;
	}

} // MBPRelation