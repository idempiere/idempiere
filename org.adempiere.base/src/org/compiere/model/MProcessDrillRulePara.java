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
* - Igor Pojzl, Cloudempiere                                          *
* - Peter Takacs, Cloudempiere                                        *
**********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import org.idempiere.cache.ImmutablePOSupport;
import org.idempiere.model.IProcessParameter;

/**
 *
 * @author Igor Pojzl, Cloudempiere
 * @author Peter Takacs, Cloudempiere
 */
public class MProcessDrillRulePara extends X_AD_Process_DrillRule_Para implements ImmutablePOSupport, IProcessParameter {

	/**
	 *
	 */
	private static final long serialVersionUID = 1460684182951511710L;

	public MProcessDrillRulePara(Properties ctx, int AD_Process_DrillRule_Para_ID, String trxName) {
		super(ctx, AD_Process_DrillRule_Para_ID, trxName);
	}

	public MProcessDrillRulePara(Properties ctx, int AD_Process_DrillRule_Para_ID, String trxName,
			String[] virtualColumns) {
		super(ctx, AD_Process_DrillRule_Para_ID, trxName, virtualColumns);
	}

	public MProcessDrillRulePara(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/** Parameter Column Name		*/
	private MProcessPara	m_parameter = null;
	/** Parent						*/
	private MProcessDrillRule	m_parent = null;


	/**
	 * 	Get Parameter Column Name
	 *	@return column name
	 */
	public String getColumnName()
	{
		if (m_parameter == null)
			m_parameter = MProcessPara.get(getCtx(), getAD_Process_Para_ID());
		return m_parameter.getColumnName();
	}	//	getColumnName

	/**
	 * 	Get Display Type
	 *	@return display type
	 */
	public int getDisplayType()
	{
		if (m_parameter == null)
			m_parameter = MProcessPara.get(getCtx(), getAD_Process_Para_ID());
		return m_parameter.getAD_Reference_ID();
	}	//	getDisplayType

	@Override
	public PO markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

	@Override
	public void setParentID(int id) {
		setAD_Process_DrillRule_ID(id);
	}
	
	/**
	 * 	Get Parent
	 *	@return parent
	 */
	public MProcessDrillRule getParent()
	{
		if (m_parent == null)
			m_parent = new MProcessDrillRule(getCtx(), getAD_Process_DrillRule_ID(), get_TrxName());
		return m_parent;
	}	//	getParent
	
	@Override
	protected boolean afterSave(boolean newRecord, boolean success) {
		if(success) {
			getParent().validate();
			getParent().saveEx(get_TrxName());
		}
		return super.afterSave(newRecord, success);
	}

	@Override
	protected boolean afterDelete (boolean success) {
		if(success) {
			getParent().validate();
			getParent().saveEx(get_TrxName());
		}
		return super.afterDelete(success);
	}
}