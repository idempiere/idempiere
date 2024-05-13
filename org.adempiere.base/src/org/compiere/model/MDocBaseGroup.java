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
import java.util.List;
import java.util.Properties;

/**
 * Document Base Type Group
 * 
 * @author Peter Takacs, Cloudempiere
 *
 */
public class MDocBaseGroup extends X_C_DocBaseGroup {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -4619625345276666731L;
	
	/**	Document Base Type Group Lines			*/
	private MDocBaseGroupLine[]	m_lines;

	/**
	 * @param ctx
	 * @param C_DocBaseGroup_ID
	 * @param trxName
	 */
	public MDocBaseGroup(Properties ctx, int C_DocBaseGroup_ID, String trxName) {
		super(ctx, C_DocBaseGroup_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param C_DocBaseGroup_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MDocBaseGroup(Properties ctx, int C_DocBaseGroup_ID, String trxName, String[] virtualColumns) {
		super(ctx, C_DocBaseGroup_ID, trxName, virtualColumns);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MDocBaseGroup(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * @param ctx
	 * @param C_DocBaseGroup_UU
	 * @param trxName
	 */
	public MDocBaseGroup(Properties ctx, String C_DocBaseGroup_UU, String trxName) {
		super(ctx, C_DocBaseGroup_UU, trxName);
	}

	/**
	 * @param ctx
	 * @param C_DocBaseGroup_UU
	 * @param trxName
	 * @param virtualColumns
	 */
	public MDocBaseGroup(Properties ctx, String C_DocBaseGroup_UU, String trxName,
			String[] virtualColumns) {
		super(ctx, C_DocBaseGroup_UU, trxName, virtualColumns);
	}
	
	/**
	 * 	Get Document Base Type Group Lines
	 * 	@param requery
	 * 	@return lines
	 */
	public MDocBaseGroupLine[] getLines (boolean requery)
	{
		if (m_lines == null || m_lines.length == 0 || requery)
		{
			List<MDocBaseGroupLine> list = new Query(getCtx(), I_C_DocBaseGroupLine.Table_Name, MDocBaseGroup.COLUMNNAME_C_DocBaseGroup_ID+"=?", get_TrxName())
					.setParameters(getC_DocBaseGroup_ID())
					.list();		
			m_lines =  list.toArray(new MDocBaseGroupLine[list.size()]);
		}
		set_TrxName(m_lines, get_TrxName());
		return m_lines;
	}	//	getLines

	/**
	 * 	Get Document Base Type Group Lines
	 * 	@return lines
	 */
	public MDocBaseGroupLine[] getLines()
	{
		return getLines(false);
	}	//	getLines
	
}
