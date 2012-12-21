/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2008 Low Heng Sin											  *
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

import java.sql.Timestamp;
import java.util.logging.Level;

import org.compiere.model.MPackage;
import org.compiere.model.MShippingTransaction;
import org.compiere.process.ProcessInfoLog;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.SvrProcess;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class OnlineShipmentProcess extends SvrProcess 
{
	@Override
	protected void prepare() 
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else
				log.log(Level.SEVERE, "prepare - Unknown Parameter: " + name);
		}
    }
	
	@Override
	protected String doIt() throws Exception 
	{
		MPackage m_package = new MPackage(getCtx(), getRecord_ID(), get_TrxName());
		boolean ok = m_package.processOnline(MShippingTransaction.ACTION_ProcessShipment, false);
		m_package.saveEx();
		if (!ok)
		{
			getProcessInfo().setError(true);
			getProcessInfo().addLog(new ProcessInfoLog(getProcessInfo().getAD_Process_ID(), 
					new Timestamp(System.currentTimeMillis()), null, m_package.getErrorMessage()));
			return m_package.getErrorMessage();
		}
		getProcessInfo().addLog(new ProcessInfoLog(getProcessInfo().getAD_Process_ID(), 
				new Timestamp(System.currentTimeMillis()), null, m_package.getShippingRespMessage()));
		return m_package.getShippingRespMessage();
	}

/*	
    private void validatePackage() throws Exception
    {
        if(m_package == null)
            throw new Exception("No Package");

        //Yvonne
        if( m_package.get_Value(X_Shipping.COLUMN_IS_SHIP_ITN_REQ)!=null?((Boolean)m_package.get_Value(X_Shipping.COLUMN_IS_SHIP_ITN_REQ)).booleanValue():false && ( m_package.get_Value(X_Shipping.COLUMN_ITN) == null || ((String)m_package.get_Value(X_Shipping.COLUMN_ITN)).trim().length() == 0 ) )
        {
            int windowNo = X_Shipping.m_Window_No;
            
            if (Ini.isClient())
			{
            	try
                {
                    Class cl = Class.forName("org.compiere.apps.ADialog");
                    Class paramTypes[] = {int.class, Container.class, String.class, String.class};
                    Object params[] = {windowNo, Env.getWindow(windowNo), "Package ITN for this shipment is blank.", "Are you sure you want to continue?"};
                    Method method = cl.getDeclaredMethod("ask", paramTypes);
                    Boolean ok = (Boolean) method.invoke(null, params);
                    
                    if(!ok)
                	{
                		throw new Exception("Online shipment processing canceled by user.");
                	}
                }
                catch (Exception ex)
                {
                	throw new AdempiereException(ex);
                }
			}
			else
			{
				try
				{
					ClassLoader loader = Thread.currentThread().getContextClassLoader();
					if (loader == null)
						loader = this.getClass().getClassLoader();
	    	    	Class<?> clazz = loader.loadClass("org.adempiere.webui.window.FDialog");
	    	    	Class<?> clazz1 = loader.loadClass("org.zkoss.zk.ui.Component");
	    		      
	    	    	Method m = clazz.getMethod("ask", Integer.TYPE, clazz1, String.class, String.class);
	    	    	Boolean returnCode = (Boolean)m.invoke(null, 0, null, "Packaget ITN for this shipment is blank.",
                            "Are you sure you want to continue?");
	    		    
	    	    	if(!returnCode)
	                {
	    	    		throw new Exception("Online shipment processing canceled by user.");
	                }
				} 
				catch (Exception e)
				{
					throw new AdempiereException(e);
				}
			}            
        }     
    }
*/    
}
