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
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;

/**
 * Extended model class of M_AttributeInstanceLine 
 */
public class MAttributeInstanceLine extends X_M_AttributeInstanceLine {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8228055830143742344L;

	/**
	 * @param ctx
	 * @param M_AttributeInstanceLine_ID
	 * @param trxName
	 */
	public MAttributeInstanceLine(Properties ctx, int M_AttributeInstanceLine_ID, String trxName) {
		super(ctx, M_AttributeInstanceLine_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param M_AttributeInstanceLine_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MAttributeInstanceLine(Properties ctx, int M_AttributeInstanceLine_ID, String trxName,
			String... virtualColumns) {
		super(ctx, M_AttributeInstanceLine_ID, trxName, virtualColumns);
	}

	/**
	 * @param ctx
	 * @param M_AttributeInstanceLine_UU
	 * @param trxName
	 */
	public MAttributeInstanceLine(Properties ctx, String M_AttributeInstanceLine_UU, String trxName) {
		super(ctx, M_AttributeInstanceLine_UU, trxName);
	}

	/**
	 * @param ctx
	 * @param M_AttributeInstanceLine_UU
	 * @param trxName
	 * @param virtualColumns
	 */
	public MAttributeInstanceLine(Properties ctx, String M_AttributeInstanceLine_UU, String trxName,
			String... virtualColumns) {
		super(ctx, M_AttributeInstanceLine_UU, trxName, virtualColumns);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MAttributeInstanceLine(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * Get active MAttributeInstanceLine records of a MAttributeInstance record.
	 * @param mai
	 * @return list of MAttributeInstanceLine records
	 */
	public static List<MAttributeInstanceLine> getOfAttributeInstance(MAttributeInstance mai) {
		Query query = new Query(Env.getCtx(), MAttributeInstanceLine.Table_Name, MAttributeInstance.COLUMNNAME_M_AttributeInstance_UU+"=?", mai.get_TrxName());
		return query.setOnlyActiveRecords(true)
					.setParameters(mai.getM_AttributeInstance_UU())
					.list();
	}
}
