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
package org.compiere.process;

import org.compiere.model.MProcessDrillRule;
import org.compiere.util.Msg;

/**
 * 	Validate Drill Rule Parameters
 *	
 *  @author Peter Takacs, Cloudempiere
 */
@org.adempiere.base.annotation.Process
public class DrillRuleValidate extends SvrProcess
{
	/**	Drill Rule			*/
	private int p_AD_Process_DrillRule_ID = 0;
	
	/**
	 * 	Prepare
	 */
	protected void prepare ()
	{
		p_AD_Process_DrillRule_ID = getRecord_ID();
	}	//	prepare

	/**
	 * 	Process
	 *	@return info
	 *	@throws Exception
	 */
	protected String doIt ()
		throws Exception
	{
		MProcessDrillRule drillRule = new MProcessDrillRule(getCtx(), p_AD_Process_DrillRule_ID, null);
		drillRule.validate();
		drillRule.saveEx();
		if(getAD_Client_ID() == 0 && drillRule.hasMandatoryProcessPara() 
				&& !MProcessDrillRule.SHOWHELP_ShowHelp.equalsIgnoreCase(drillRule.getShowHelp())) {
			return "@NotValid@" + ": " + Msg.getMsg(getCtx(), "DrillParameterTenantCheck");
		}
		return drillRule.isValid() ? "@OK@" : "@NotValid@";
	}
	
}
