/******************************************************************************
 * This file is part of Adempiere ERP Bazaar                                  *
 * http://www.adempiere.org                                                   *
 *                                                                            *
 * Copyright (C) Low Heng Sin												  *
 * Copyright (C) Contributors												  *
 *                                                                            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *                                                                            *
 * Contributors:                                                              *
 *****************************************************************************/
package org.adempiere.base;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Properties;

import org.adempiere.base.equinox.StackTraceCommand;
import org.compiere.Adempiere;
import org.eclipse.osgi.framework.console.CommandProvider;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

/**
 * @author hengsin
 *
 */
public class BaseActivator implements BundleActivator {

	private static BundleContext bundleContext = null;

	/**
	 * default constructor
	 */
	public BaseActivator() {
	}

	/* (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	@Override
	public void start(BundleContext context) throws Exception {
		//Load SSL 
		loadSSLDBProperties(Adempiere.getAdempiereHome());
		bundleContext = context;
		context.registerService(CommandProvider.class.getName(), new StackTraceCommand(), null);
	}
	
	/* 
	 * Load idempiereInit.properties into the system.
	 */
	private void loadSSLDBProperties(String filePath)  {

		Properties s_prop = new Properties();
		String fileName = filePath+ File.separator+"idempiereInit.properties";
		File env = new File (fileName);
		boolean loadOk = true;
		if (env.exists())
		{
			FileInputStream fis = null;
			try
			{
				fis = new FileInputStream(env);
				s_prop.load(fis);
			}catch (Exception e){
				loadOk = false;
				System.err.println("Exception while loading idempiereInit.properties: "+ e.toString());
			}finally{
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (loadOk) {	
			    String key = null;
			    String value =null;
				Enumeration<?> enumeration = s_prop.propertyNames();
			     while (enumeration.hasMoreElements()) {
			        key = (String) enumeration.nextElement();
			        value = s_prop.getProperty(key);
			        System.setProperty(key,value) ;
			        //System.out.println("Loaded Key: "+ key + "- Value :"+value);                        
	            }			
			}
		}
	}

	/* (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	@Override
	public void stop(BundleContext context) throws Exception {
		bundleContext = null;
		Adempiere.stop();
	}

	public static BundleContext getBundleContext() {
		return bundleContext;
	}
}
