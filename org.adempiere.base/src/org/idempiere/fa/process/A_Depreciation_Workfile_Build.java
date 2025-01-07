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
package org.idempiere.fa.process;

import org.compiere.model.MDepreciationWorkfile;
import org.compiere.model.MProcessPara;
import org.compiere.model.POResultSet;
import org.compiere.model.Query;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;

/**
 * Process to Create Depreciation from depreciation work file ({@link MDepreciationWorkfile})
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
@org.adempiere.base.annotation.Process
public class A_Depreciation_Workfile_Build extends SvrProcess
{
	private int A_Depreciation_Workfile_ID = 0;
	
	@Override
	protected void prepare() {
		A_Depreciation_Workfile_ID = getRecord_ID();
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AllAssets")) {
				if ("Y".equals(para[i].getParameter()))
					A_Depreciation_Workfile_ID = 0;
			}
			else {
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
			}
		}
	}
	
	@Override
	protected String doIt() throws Exception {
		int cnt_all = 0;
		if (A_Depreciation_Workfile_ID > 0) {
			MDepreciationWorkfile wk = new MDepreciationWorkfile(getCtx(), A_Depreciation_Workfile_ID, get_TrxName());
			wk.buildDepreciation();
			wk.saveEx();
			cnt_all = 1;
		}
		else {
			String whereClause = MDepreciationWorkfile.COLUMNNAME_IsDepreciated + "='Y'";
			POResultSet<MDepreciationWorkfile>
			rs = new Query(getCtx(), MDepreciationWorkfile.Table_Name, whereClause, get_TrxName())
						.scroll();
			try {
				while(rs.hasNext()) {
					MDepreciationWorkfile wk = rs.next(); 
					wk.buildDepreciation();
					wk.saveEx();
				}
			}
			finally {
				DB.close(rs); rs = null;
			}
		}
		//
		return "@Processed@ #" + cnt_all;
	}
}
