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
 * Period Group
 * 
 * @author Peter Takacs, Cloudempiere
 *
 */
public class MPeriodDocGroup extends X_C_PeriodDocGroup {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4619625345276666731L;
	
	/**	Period Group Lines			*/
	private MPeriodDocGroupLine[]	m_lines;

	public MPeriodDocGroup(Properties ctx, int C_PeriodDocGroup_ID, String trxName) {
		super(ctx, C_PeriodDocGroup_ID, trxName);
	}

	public MPeriodDocGroup(Properties ctx, int C_PeriodDocGroup_ID, String trxName, String[] virtualColumns) {
		super(ctx, C_PeriodDocGroup_ID, trxName, virtualColumns);
	}

	public MPeriodDocGroup(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	public MPeriodDocGroup(Properties ctx, String C_PeriodDocGroup_UU, String trxName) {
		super(ctx, C_PeriodDocGroup_UU, trxName);
	}

	public MPeriodDocGroup(Properties ctx, String C_PeriodDocGroup_UU, String trxName,
			String[] virtualColumns) {
		super(ctx, C_PeriodDocGroup_UU, trxName, virtualColumns);
	}
	
	/**
	 * 	Get Period Group Lines
	 * 	@param requery
	 * 	@return lines
	 */
	public MPeriodDocGroupLine[] getLines (boolean requery)
	{
		if (m_lines == null || m_lines.length == 0 || requery)
		{
			List<MPeriodDocGroupLine> list = new Query(getCtx(), I_C_PeriodDocGroupLine.Table_Name, MPeriodDocGroup.COLUMNNAME_C_PeriodDocGroup_ID+"=?", get_TrxName())
					.setParameters(getC_PeriodDocGroup_ID())
					.list();		
			m_lines =  list.toArray(new MPeriodDocGroupLine[list.size()]);
		}
		set_TrxName(m_lines, get_TrxName());
		return m_lines;
	}	//	getLines

	/**
	 * 	Get Period Group Lines
	 * 	@return lines
	 */
	public MPeriodDocGroupLine[] getLines()
	{
		return getLines(false);
	}	//	getLines
	
}
