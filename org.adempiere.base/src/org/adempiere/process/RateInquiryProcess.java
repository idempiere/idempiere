package org.adempiere.process;

import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MPackage;
import org.compiere.model.MShippingTransaction;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;

public class RateInquiryProcess extends SvrProcess 
{
	private boolean p_IsPriviledgedRate = false;
	
	@Override
	protected void prepare() 
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals(MShippingTransaction.COLUMNNAME_IsPriviledgedRate))
				p_IsPriviledgedRate = ((String)para[i].getParameter()).equals("Y");
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
    }
	
	@Override
	protected String doIt() throws Exception 
	{
		MPackage m_package = new MPackage(getCtx(), getRecord_ID(), get_TrxName());
		boolean ok = m_package.processOnline(MShippingTransaction.ACTION_RateInquiry, p_IsPriviledgedRate);
		m_package.saveEx();
		if (!ok)
		{
			getProcessInfo().setError(true);
			getProcessInfo().addLog(new ProcessInfoLog(getProcessInfo().getAD_Process_ID(), 
					new Timestamp(System.currentTimeMillis()), null, m_package.getErrorMessage()));			
			return m_package.getErrorMessage();
		}
		getProcessInfo().addLog(new ProcessInfoLog(getProcessInfo().getAD_Process_ID(), 
				new Timestamp(System.currentTimeMillis()), null, m_package.getRateInquiryMessage()));
		return m_package.getRateInquiryMessage();
	}
}