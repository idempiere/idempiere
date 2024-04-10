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
import org.compiere.model.MMatchInv;
import org.compiere.model.MProcessPara;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.idempiere.fa.exceptions.AssetException;

/**
 * Process to create asset from match invoice
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 */
@org.adempiere.base.annotation.Process
public class A_Asset_CreateFromMatchInv extends SvrProcess {
	private int p_M_MatchInv_ID = -1;
	
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	@Override
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("M_MatchInv_ID"))
				p_M_MatchInv_ID = para[i].getParameterAsInt();
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
		}
	}	//	prepare 
	
	@Override
	protected String doIt() throws Exception
	{
		MMatchInv match = new MMatchInv(getCtx(), p_M_MatchInv_ID, get_TrxName());
		if (match == null || match.get_ID() <= 0) {
			throw new AssetException("@NotFound@ @M_MatchInv_ID@=" + match + "(ID="+p_M_MatchInv_ID+")");
		}
		MAssetAddition assetAdd = MAssetAddition.createAsset(match);
		
		return "@A_Asset_Addition_ID@ - " + assetAdd;
	}
}
