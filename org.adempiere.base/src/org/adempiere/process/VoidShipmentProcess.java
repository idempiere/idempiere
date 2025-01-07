/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2008 Carlos Ruiz											  *
 * Copyright (C) 2008 Idalica              									  *
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

import java.math.BigDecimal;
import java.sql.Timestamp;

import org.compiere.model.MPackage;
import org.compiere.model.MProcessPara;
import org.compiere.model.MShippingTransaction;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;

/**
 * Process to perform online void of a shipment package ({@link MPackage}).
 * @author Low Heng Sin
 *
 */
@org.adempiere.base.annotation.Process
public class VoidShipmentProcess extends SvrProcess 
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
		MPackage m_package = new MPackage(getCtx(), getRecord_ID(), get_TrxName());
		boolean ok = m_package.processOnline(MShippingTransaction.ACTION_VoidShipment, false);
		m_package.saveEx();
		if (!ok)
		{
			getProcessInfo().setError(true);
			getProcessInfo().addLog(new ProcessInfoLog(getProcessInfo().getAD_Process_ID(), 
					new Timestamp(System.currentTimeMillis()), null, m_package.getErrorMessage()));
			return m_package.getErrorMessage();
		}
		else
		{
			m_package.setPrice(BigDecimal.ZERO);
			m_package.setSurcharges(BigDecimal.ZERO);
			m_package.saveEx();
		}
		getProcessInfo().addLog(new ProcessInfoLog(getProcessInfo().getAD_Process_ID(), 
				new Timestamp(System.currentTimeMillis()), null, m_package.getShippingRespMessage()));
		return m_package.getShippingRespMessage();
	}
}