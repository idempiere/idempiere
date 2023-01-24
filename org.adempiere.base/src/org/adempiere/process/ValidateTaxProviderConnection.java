/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.process;

import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.ITaxProvider;
import org.compiere.model.MProcessPara;
import org.compiere.model.MTaxProvider;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.Msg;

/**
 * Online validate tax provider connection
 * @author Elaine
 *
 */
@org.adempiere.base.annotation.Process
public class ValidateTaxProviderConnection extends SvrProcess 
{
	@Override
	protected void prepare() 
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			if (para[i].getParameter() == null)
				;
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para[i]);
		}
	}
	
	@Override
	protected String doIt() throws Exception 
	{
		MTaxProvider provider = new MTaxProvider(getCtx(), getRecord_ID(), get_TrxName());			
		ITaxProvider calculator = Core.getTaxProvider(provider);
		if (calculator == null)
			throw new AdempiereException(Msg.getMsg(getCtx(), "TaxNoProvider"));
		return calculator.validateConnection(provider, getProcessInfo());
	}	
}
