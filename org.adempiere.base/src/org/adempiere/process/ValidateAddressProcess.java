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

import java.sql.Timestamp;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MAddressTransaction;
import org.compiere.model.MLocation;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Online validate address process
 * @author Elaine
 *
 */
public class ValidateAddressProcess extends SvrProcess 
{
	private int p_C_AddressValidation_ID;
	
	@Override
	protected void prepare() 
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals(MAddressTransaction.COLUMNNAME_C_AddressValidation_ID))
				p_C_AddressValidation_ID = para[i].getParameterAsInt();
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
	}

	@Override
	protected String doIt() throws Exception 
	{
		if (p_C_AddressValidation_ID == 0)
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "FillMandatory") + Msg.getElement(Env.getCtx(), MAddressTransaction.COLUMNNAME_C_AddressValidation_ID));

		MLocation m_location = new MLocation(getCtx(), getRecord_ID(), get_TrxName());
		boolean ok = m_location.processOnline(p_C_AddressValidation_ID);
		m_location.saveEx();
		
		if (!ok)
		{
			getProcessInfo().setError(true);
			getProcessInfo().addLog(new ProcessInfoLog(getProcessInfo().getAD_Process_ID(), new Timestamp(System.currentTimeMillis()), null, m_location.getErrorMessage()));
			return m_location.getErrorMessage();
		}
		
		getProcessInfo().addLog(new ProcessInfoLog(getProcessInfo().getAD_Process_ID(), new Timestamp(System.currentTimeMillis()), null, m_location.getResult()));
		return m_location.getResult();
	}
}
