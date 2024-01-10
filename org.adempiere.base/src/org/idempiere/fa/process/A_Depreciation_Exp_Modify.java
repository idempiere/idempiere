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

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.FillMandatoryException;
import org.compiere.model.MDepreciationEntry;
import org.compiere.model.MDepreciationExp;
import org.compiere.model.MProcessPara;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;

/**
 * WARNING: INTERNAL PROCESS
 * @author Anca Bradau www.arhipac.ro
 *
 */
@org.adempiere.base.annotation.Process
public class A_Depreciation_Exp_Modify extends SvrProcess
{
	private int p_A_Depreciation_Exp_ID = -1; 
	private int p_DR_Account_ID = -1; 
	private int p_CR_Account_ID = -1;
	private boolean p_IsTest = true;
	
	@Override	
	protected void prepare()
	{
		;
		for (ProcessInfoParameter para : getParameter())
		{
			String name = para.getParameterName();
			if (para.getParameter() == null)
				;
			else if (name.equals("IsTest"))
			{
				p_IsTest = para.getParameterAsBoolean();
			}
			else if(name.equals(MDepreciationExp.COLUMNNAME_A_Depreciation_Exp_ID))
			{
				p_A_Depreciation_Exp_ID = para.getParameterAsInt();
			}
			else if (name.equals(MDepreciationExp.COLUMNNAME_DR_Account_ID))
			{
				 p_DR_Account_ID = para.getParameterAsInt();
			}
			else if (name.equals(MDepreciationExp.COLUMNNAME_CR_Account_ID))
			{
				p_CR_Account_ID = para.getParameterAsInt();
			}
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para);
		}
		
	
	}

	@Override
	protected String doIt() throws Exception
	{
		//
		if (p_A_Depreciation_Exp_ID <= 0)
		{
			throw new FillMandatoryException("A_Depreciation_Exp_ID");
		}
		//
		MDepreciationExp exp = new MDepreciationExp(getCtx(), p_A_Depreciation_Exp_ID, get_TrxName());
		if (exp.get_ID() != p_A_Depreciation_Exp_ID)
		{
			throw new AdempiereException("@NotFound@ @A_Depreciation_Exp_ID@ = "+p_A_Depreciation_Exp_ID);
		}
		//
		MDepreciationEntry.deleteFacts(exp);
		exp.setDR_Account_ID(p_DR_Account_ID);
		exp.setCR_Account_ID(p_CR_Account_ID);
		exp.saveEx();
		//
		if (p_IsTest)
		{
			rollback();
		}
		//
		return "Ok";
	}
}
