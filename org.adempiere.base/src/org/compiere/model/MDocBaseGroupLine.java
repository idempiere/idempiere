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
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/**
 * Document Base Type Group Line
 * 
 * @author Peter Takacs, Cloudempiere
 *
 */
public class MDocBaseGroupLine extends X_C_DocBaseGroupLine {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8604315901539608261L;
	
	/** Parent					*/
	protected MDocBaseGroup m_parent = null;

	/**
	 * @param ctx
	 * @param C_DocBaseGroupLine_ID
	 * @param trxName
	 */
	public MDocBaseGroupLine(Properties ctx, int C_DocBaseGroupLine_ID, String trxName) {
		super(ctx, C_DocBaseGroupLine_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param C_DocBaseGroupLine_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MDocBaseGroupLine(Properties ctx, int C_DocBaseGroupLine_ID, String trxName, String[] virtualColumns) {
		super(ctx, C_DocBaseGroupLine_ID, trxName, virtualColumns);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MDocBaseGroupLine(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * @param ctx
	 * @param C_DocBaseGroupLine_UU
	 * @param trxName
	 */
	public MDocBaseGroupLine(Properties ctx, String C_DocBaseGroupLine_UU, String trxName) {
		super(ctx, C_DocBaseGroupLine_UU, trxName);
	}

	/**
	 * @param ctx
	 * @param C_DocBaseGroupLine_UU
	 * @param trxName
	 * @param virtualColumns
	 */
	public MDocBaseGroupLine(Properties ctx, String C_DocBaseGroupLine_UU, String trxName,
			String[] virtualColumns) {
		super(ctx, C_DocBaseGroupLine_UU, trxName, virtualColumns);
	}
	
	/**
	 * 	Get Parent
	 *	@return parent
	 */
	public MDocBaseGroup getParent()
	{
		if (m_parent == null)
			m_parent = new MDocBaseGroup(getCtx(), getC_DocBaseGroup_ID(), get_TrxName());
		return m_parent;
	}
}
