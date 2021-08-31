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
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.base;

import java.util.ArrayList;
import java.util.List;

import org.compiere.model.Callout;
import org.compiere.util.CCache;
import org.osgi.framework.ServiceReference;

/**
 * Contains static methods for retrieval of {@link IColumnCallout}, {@link Callout} and default {@link IMappedColumnCalloutFactory}
 * @author hengsin
 *
 */
public final class ColumnCalloutManager {

	/**
	 * Virtual table name for {@link Callout} factory cache. 
	 * Call CacheMgt.get().reset(_ICALLOUT_FACTORY_CACHE_TABLE_NAME) to reset Callout factory cache.
	 */
	public static final String ICALLOUT_FACTORY_CACHE_TABLE_NAME = "_ICalloutFactory_Cache";

	/**
	 * Virtual table name for {@link IColumnCallout} factory cache. 
	 * Call CacheMgt.get().reset(LIST_ICOLUMNCALLOUT_FACTORY_CACHE_TABLE_NAME) to reset IColumnCallout factory cache.
	 */
	public static final String LIST_ICOLUMNCALLOUT_FACTORY_CACHE_TABLE_NAME = "_List_IColumnCalloutFactory_Cache";
	
	private static final CCache<String, IServiceReferenceHolder<ICalloutFactory>> s_calloutFactoryCache = new CCache<>(ICALLOUT_FACTORY_CACHE_TABLE_NAME, "ICalloutFactory", 100, false);
	private static final CCache<String, List<IServiceReferenceHolder<IColumnCalloutFactory>>> s_columnCalloutFactoryCache = new CCache<>(LIST_ICOLUMNCALLOUT_FACTORY_CACHE_TABLE_NAME, "List<IColumnCalloutFactory>", 100, false);	
	private static final CCache<String, List<ServiceReference<IColumnCalloutFactory>>> s_columnCalloutFactoryNegativeCache = new CCache<>(LIST_ICOLUMNCALLOUT_FACTORY_CACHE_TABLE_NAME, "List<IColumnCalloutFactory> Negative", 100, false);
	private static IServiceReferenceHolder<IMappedColumnCalloutFactory> s_mappedColumnCalloutFactoryReference = null;
	
	private ColumnCalloutManager() {
	}
	
	/**
	 *
	 * @param tableName
	 * @param columnName
	 * @return list of {@link IColumnCallout} register for tableName.columnName
	 */
	public static List<IColumnCallout> findCallout(String tableName, String columnName) {
		List<IColumnCallout> list = new ArrayList<IColumnCallout>();
		
		String cacheKey = tableName + "." + columnName;
		List<IServiceReferenceHolder<IColumnCalloutFactory>> cache = s_columnCalloutFactoryCache.get(cacheKey);		
		List<ServiceReference<IColumnCalloutFactory>> negativeCache = s_columnCalloutFactoryNegativeCache.get(cacheKey);
		List<ServiceReference<IColumnCalloutFactory>> negativeServiceReferences = new ArrayList<ServiceReference<IColumnCalloutFactory>>();
		if (negativeCache != null) {
			negativeServiceReferences.addAll(negativeCache);
		}
		List<ServiceReference<IColumnCalloutFactory>> cacheReferences = new ArrayList<ServiceReference<IColumnCalloutFactory>>();
		List<IServiceReferenceHolder<IColumnCalloutFactory>> positiveReferenceHolders = new ArrayList<>();
		if (cache != null) {
			for (IServiceReferenceHolder<IColumnCalloutFactory> referenceHolder : cache) {
				cacheReferences.add(referenceHolder.getServiceReference());
				IColumnCalloutFactory service = referenceHolder.getService();
				if (service != null) {
					IColumnCallout[] callouts = service.getColumnCallouts(tableName, columnName);
					if (callouts != null && callouts.length > 0) {
						for(IColumnCallout callout : callouts) {
							list.add(callout);
						}
						positiveReferenceHolders.add(referenceHolder);
					} else {
						negativeServiceReferences.add(referenceHolder.getServiceReference());
					}
				}
			}
		}
		
		//init s_mappedColumnCalloutFactoryReference
		getMappedColumnCalloutFactory();
		
		int positiveAdded = 0;		
		int negativeAdded = 0;
		List<IServiceReferenceHolder<IColumnCalloutFactory>> referenceHolders = Service.locator().list(IColumnCalloutFactory.class).getServiceReferences();		
		if (referenceHolders != null) {
			for(IServiceReferenceHolder<IColumnCalloutFactory> referenceHolder : referenceHolders) {
				ServiceReference<IColumnCalloutFactory> serviceReference = referenceHolder.getServiceReference();
				if (cacheReferences.contains(serviceReference) || negativeServiceReferences.contains(serviceReference))
					continue;
				IColumnCalloutFactory service = referenceHolder.getService();
				if (service != null) {
					IColumnCallout[] callouts = service.getColumnCallouts(tableName, columnName);
					if (callouts != null && callouts.length > 0) {
						for(IColumnCallout callout : callouts) {
							list.add(callout);						
						}
						positiveReferenceHolders.add(referenceHolder);
						positiveAdded++;
					} else {
						synchronized (ColumnCalloutManager.class) {
							//don't add s_mappedColumnCalloutFactoryReference to negative cache since it is dynamic
							if (s_mappedColumnCalloutFactoryReference != null && serviceReference.equals(s_mappedColumnCalloutFactoryReference.getServiceReference()))
								continue;
						}
						negativeServiceReferences.add(serviceReference);
						negativeAdded++;
					}
				}
			}			
		}
		
		if (cache == null || cache.size() != positiveReferenceHolders.size() || positiveAdded > 0)
			s_columnCalloutFactoryCache.put(cacheKey, positiveReferenceHolders);
		if (negativeCache == null || negativeCache.size() != negativeServiceReferences.size() || negativeAdded > 0)
			s_columnCalloutFactoryNegativeCache.put(cacheKey, negativeServiceReferences);
				
		return list;
	}
		
	// IDEMPIERE-2732
	/**
	 *
	 * @param className
	 * @param methodName 
	 * @return {@link Callout} for className and methodName
	 */
	public static Callout getCallout(String className, String methodName) {
		String cacheKey = className + "::" + methodName;
		IServiceReferenceHolder<ICalloutFactory> cache = s_calloutFactoryCache.get(cacheKey);
		if (cache != null) {
			ICalloutFactory service = cache.getService();
			if (service != null) {
				Callout callout = service.getCallout(className, methodName);
				if (callout != null) {
					return callout;
				}
			}
			s_calloutFactoryCache.remove(cacheKey);
		}
		List<IServiceReferenceHolder<ICalloutFactory>> factories = Service.locator().list(ICalloutFactory.class).getServiceReferences();
		if (factories != null) {
			for(IServiceReferenceHolder<ICalloutFactory> factory : factories) {
				ICalloutFactory service = factory.getService();
				if (service != null) {
					Callout callout = service.getCallout(className, methodName);
					if (callout != null) {
						s_calloutFactoryCache.put(cacheKey, factory);
						return callout;
					}
				}
			}
		}
		return null;
	}
		
	/**
	 * 
	 * @return {@link IMappedColumnCalloutFactory}
	 */
	public synchronized static IMappedColumnCalloutFactory getMappedColumnCalloutFactory() {
		IMappedColumnCalloutFactory factoryService = null;
		if (s_mappedColumnCalloutFactoryReference != null) {
			factoryService = s_mappedColumnCalloutFactoryReference.getService();
			if (factoryService != null)
				return factoryService;
			else
				s_mappedColumnCalloutFactoryReference = null;
		}
		IServiceReferenceHolder<IMappedColumnCalloutFactory> serviceReference = Service.locator().locate(IMappedColumnCalloutFactory.class).getServiceReference();
		if (serviceReference != null) {
			factoryService = serviceReference.getService();
			s_mappedColumnCalloutFactoryReference = serviceReference;
		}
		return factoryService;
	}	
}
