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
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.adempiere.base.equinox.StackTraceCommand;
import org.compiere.Adempiere;
import org.eclipse.osgi.framework.console.CommandProvider;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Filter;
import org.osgi.util.tracker.ServiceTracker;

/**
 * @author hengsin
 *
 */
public class BaseActivator implements BundleActivator {

	private static BundleContext bundleContext = null;
	private ComponentBlackListService blacklistService;

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
		//Load Init Properties 
		loadInitProperties(Adempiere.getAdempiereHome());
		bundleContext = context;
		context.registerService(CommandProvider.class.getName(), new StackTraceCommand(), null);
		
		blacklistService = new ComponentBlackListService(context);
	}
	
	/* 
	 * Load idempiereInit.properties into the system.
	 */
	private void loadInitProperties(String filePath)  {

		Properties props = new Properties();
		String fileName = filePath+ File.separator+"idempiereInit.properties";
		File env = new File (fileName);
		boolean loadOk = true;
		if (env.exists() && env.isFile() && env.canRead())
		{
			FileInputStream fis = null;
			try
			{
				fis = new FileInputStream(env);
				props.load(fis);
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
				Enumeration<?> enumeration = props.propertyNames();
			     while (enumeration.hasMoreElements()) {
			        key = (String) enumeration.nextElement();
			        value = props.getProperty(key);
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
		for(Map<String, ServiceTracker<?,?>> cacheMap : trackerCache.values()) {
			for(ServiceTracker<?,?> cacheTracker : cacheMap.values()) {
				if (cacheTracker.getTrackingCount() != -1) {
					cacheTracker.close();
				}
			}
		}
		trackerCache.clear();
		if (blacklistService != null) {
			blacklistService.stop(context);
			blacklistService = null;
		}
		Adempiere.stop();
	}

	/**
	 * @return bundle context
	 */
	public static BundleContext getBundleContext() {
		return bundleContext;
	}
	
	private static Map<String, Map<String, ServiceTracker<?,?>>> trackerCache = new HashMap<String, Map<String,ServiceTracker<?,?>>>();
	
	@SuppressWarnings("unchecked")
	/**
	 * @param type
	 * @param filter
	 * @return service tracker
	 */
	public static <T> ServiceTracker<T, T> getServiceTracker(Class<T> type, Filter filter) {
		ServiceTracker<T, T> tracker = null;
		String className = type.getName();
		Map<String, ServiceTracker<?,?>> cacheMap = null;
		synchronized (trackerCache) {
			cacheMap = trackerCache.get(className);
			if (cacheMap == null) {
				cacheMap = new HashMap<String, ServiceTracker<?,?>>();
				trackerCache.put(className, cacheMap);
			}
		}
		
		String filterKey = filter.toString();
		synchronized (cacheMap) {
			ServiceTracker<?, ?> cacheTracker = cacheMap.get(filterKey);
			if (cacheTracker == null) {
				tracker = new ServiceTracker<T, T>(bundleContext, filter, null);
				cacheMap.put(filterKey, tracker);
			} else {
				tracker = (ServiceTracker<T, T>) cacheTracker;
			}
		}
				
		return tracker;
	}
}
