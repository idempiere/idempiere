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

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.Msg;

/**
 * Period Group Line
 * 
 * @author Peter Takacs, Cloudempiere
 *
 */
public class MPeriodDocGroupLine extends X_C_PeriodDocGroupLine {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8604315901539608261L;
	
	/** Parent					*/
	protected MPeriodDocGroup m_parent = null;

	public MPeriodDocGroupLine(Properties ctx, int C_PeriodDocGroupLine_ID, String trxName) {
		super(ctx, C_PeriodDocGroupLine_ID, trxName);
	}

	public MPeriodDocGroupLine(Properties ctx, int C_PeriodDocGroupLine_ID, String trxName, String[] virtualColumns) {
		super(ctx, C_PeriodDocGroupLine_ID, trxName, virtualColumns);
	}

	public MPeriodDocGroupLine(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	public MPeriodDocGroupLine(Properties ctx, String C_PeriodDocGroupLine_UU, String trxName) {
		super(ctx, C_PeriodDocGroupLine_UU, trxName);
	}

	public MPeriodDocGroupLine(Properties ctx, String C_PeriodDocGroupLine_UU, String trxName,
			String[] virtualColumns) {
		super(ctx, C_PeriodDocGroupLine_UU, trxName, virtualColumns);
	}
	
	/**
	 * 	Get Parent
	 *	@return parent
	 */
	public MPeriodDocGroup getParent()
	{
		if (m_parent == null)
			m_parent = new MPeriodDocGroup(getCtx(), getC_PeriodDocGroup_ID(), get_TrxName());
		return m_parent;
	}
	
	@Override
	protected boolean beforeSave (boolean newRecord) {
		
		for(MPeriodDocGroupLine line : getParent().getLines()) {
			if(line.getDocBaseType().equalsIgnoreCase(this.getDocBaseType()))
				throw new AdempiereException(Msg.getMsg(getCtx(), "PeriodDocGroupLineUniqueDocBaseTypeError"));
		}
		
		return true;
	}
}
