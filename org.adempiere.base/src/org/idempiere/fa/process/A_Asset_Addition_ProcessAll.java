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

import org.compiere.model.MAssetAddition;
import org.compiere.model.POResultSet;
import org.compiere.model.Query;
import org.compiere.process.SvrProcess;
import org.compiere.util.DB;

/**
 * Process All (not processed) Additions
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
@org.adempiere.base.annotation.Process
public class A_Asset_Addition_ProcessAll extends SvrProcess
{
	@Override
	protected void prepare() {
	}
	
	@Override
	protected String doIt() throws Exception {
		int cnt_ok = 0, cnt_err = 0;
		//
		String whereClause = "AD_Client_ID=? AND IsActive=?"
								+" AND "+MAssetAddition.COLUMNNAME_Processed+"=?";
		POResultSet<MAssetAddition>	rs = null;
		try {
			rs = new Query(getCtx(), MAssetAddition.Table_Name, whereClause, get_TrxName())
			.setParameters(new Object[]{getAD_Client_ID(), "N", "N"})
			.scroll();
			while (rs.hasNext()) {
				MAssetAddition a = rs.next();
				boolean ret = a.processIt(MAssetAddition.DOCACTION_Complete);
				if (ret)
					cnt_ok++;
				else
					cnt_err++;
			}
		}
		finally {
			DB.close(rs); rs = null;
		}
		//
		return "OK/Error: "+cnt_ok+"/"+cnt_err;
	}
}
