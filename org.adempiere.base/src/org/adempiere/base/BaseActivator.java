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
import org.apache.poi.extractor.ExtractorFactory;
import org.apache.poi.ooxml.extractor.POIXMLExtractorFactory;
import org.apache.poi.sl.usermodel.SlideShowFactory;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xslf.usermodel.XSLFSlideShowFactory;
import org.apache.poi.xssf.usermodel.XSSFWorkbookFactory;
import org.compiere.Adempiere;
import org.eclipse.osgi.framework.console.CommandProvider;
import org.osgi.framework.Bundle;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.BundleEvent;
import org.osgi.framework.Filter;
import org.osgi.util.tracker.BundleTracker;
import org.osgi.util.tracker.ServiceTracker;

/**
 * Activator for org.adempiere.base bundle.
 * @author hengsin
 */
public class BaseActivator implements BundleActivator {

	/**
	 * The tracker monitors the Poi Bundle. <br/>
	 * If both poi and poi-ooxml libraries are present, it adds the factory from poi-ooxml to the list of providers.
	 */
	private static final class PoiBundleTracker extends BundleTracker<Bundle> {
		// to indicate whether the wrapped.org.apache.poi.poi library is present
		boolean hasPoiBundle = false;
		// to indicate whether the wrapped.org.apache.poi.poi-ooxml library is present
		boolean hasPoiOoxml = false;

		private PoiBundleTracker(BundleContext context, int stateMask) {
			super(context, stateMask, null);
		}

		/**
		 * {@inheritDoc}<br/><br/>
		 * The function is called whenever a bundle is placed on a state within the stateMask.<br/> 
		 * However, it is not called when a bundle is moved between states within the state mask<br/><br/>
		 * When a function is called for the first time, the event object might be null because it hasn't been populated yet
		 */
		public Bundle addingBundle(Bundle bundle, BundleEvent event) {
			// Determine the bundle responsible for the current call
			boolean isAddingPoiBundle = "wrapped.org.apache.poi.poi".equals(bundle.getSymbolicName());
			boolean isAddingPoiOoxmlBundle = "wrapped.org.apache.poi.poi-ooxml".equals(bundle.getSymbolicName());
			
			// tracking only poi
			if (!isAddingPoiBundle && !isAddingPoiOoxmlBundle)
				return null;
			
			if (isAddingPoiBundle) {
				hasPoiBundle = true;
			}else if (isAddingPoiOoxmlBundle) {
				hasPoiOoxml = true;
			}
			
			// adds the factory from poi-ooxml to the list of providers
			if (hasPoiBundle && hasPoiOoxml) {
				WorkbookFactory.addProvider(new XSSFWorkbookFactory());
		        SlideShowFactory.addProvider(new XSLFSlideShowFactory());
		        ExtractorFactory.addProvider(new POIXMLExtractorFactory());
			}
			
			return super.addingBundle(bundle, event);
		}

		/**
		 * {@inheritDoc}<br/><br/>
		 * The function is called whenever a bundle is placed on a state out of the stateMask.<br/>
		 */
		public void removedBundle(Bundle bundle, BundleEvent event, Bundle trackedObj) {
			super.removedBundle(bundle, event, trackedObj);
			
			boolean isPoiBundle = "wrapped.org.apache.poi.poi".equals(bundle.getSymbolicName());
			boolean isPoiOoxmlBundle = "wrapped.org.apache.poi.poi-ooxml".equals(bundle.getSymbolicName());
			
			if (!isPoiBundle && !isPoiOoxmlBundle)
				return;
			
			if (isPoiBundle) {
				hasPoiBundle = false;
			}else if (isPoiOoxmlBundle) {
				hasPoiOoxml = false;
			}
			
			// We have removed the factory of poi-ooxml from the list of available providers
			if ((isPoiBundle && !hasPoiBundle) || (isPoiOoxmlBundle && !hasPoiOoxml)) {
				WorkbookFactory.removeProvider(XSSFWorkbookFactory.class);
		        SlideShowFactory.removeProvider(XSLFSlideShowFactory.class);
		        ExtractorFactory.removeProvider(POIXMLExtractorFactory.class);
			}
		}
	}

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
		
		int trackStates = Bundle.RESOLVED | Bundle.STOPPING | Bundle.ACTIVE | Bundle.STARTING;
		new PoiBundleTracker(context, trackStates).open();
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
