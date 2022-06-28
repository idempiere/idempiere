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
package org.cloudempiere.model;

import java.util.Properties;

import org.compiere.model.CalloutEngine;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessDrillRule;
import org.compiere.model.MReportView;

/**
 *
 * @author Igor Pojzl, Cloudempiere
 *
 */
public class CalloutProcessDrillRule extends CalloutEngine {

	/**
	 * Process Callout Setup
	 *  @param ctx context
	 *  @param WindowNo current Window No
	 *  @param mTab Grid Tab
	 *  @param mField Grid Field
	 *  @param value New Value
	 *  @return null or error message
	 */
	public String process (Properties ctx, int WindowNo, GridTab mTab, GridField mField, Object value)
	{
		// set AD_Table_ID
		Integer AD_Process_ID = (Integer)value;
		if (AD_Process_ID == null || AD_Process_ID.intValue() == 0)
			return "";

		MProcess process = MProcess.get(AD_Process_ID);

		if(process == null || process.getAD_ReportView_ID() <= 0) {
			mTab.setValue(MProcessDrillRule.COLUMNNAME_AD_Table_ID, null);
			mTab.setValue(MProcessDrillRule.COLUMNNAME_AD_ReportView_ID, null);
			mTab.setValue(MProcessDrillRule.COLUMNNAME_AD_Process_Para_ID, null);
			return "";
		}

		MReportView reportView = MReportView.get(process.getAD_ReportView_ID());

		if(reportView == null || reportView.getAD_Table_ID() <= 0)
			return "";

		mTab.setValue(MProcessDrillRule.COLUMNNAME_AD_Table_ID, reportView.getAD_Table_ID());
		return "";
	}

}
