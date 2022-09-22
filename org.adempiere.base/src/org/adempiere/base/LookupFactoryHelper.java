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

import org.compiere.model.GridFieldVO;
import org.compiere.model.InfoColumnVO;
import org.compiere.model.Lookup;
import org.compiere.util.CCache;
import org.osgi.framework.Constants;

/**
 * Static helper methods for working with {@link ILookupFactory}
 * @author hengsin
 *
 */
public final class LookupFactoryHelper {

	private LookupFactoryHelper() {
	}

	private static final CCache<Long, IServiceReferenceHolder<ILookupFactory>> s_lookupFactoryCache = new CCache<Long, IServiceReferenceHolder<ILookupFactory>>(
			null, "ILookupFactory", 10, false);

	/**
	 * Get lookup from osgi factory
	 * 
	 * @param gridFieldVO
	 * @return {@link Lookup}
	 */
	public static Lookup getLookup(GridFieldVO gridFieldVO) {
		List<Long> visitedIds = new ArrayList<Long>();
		if (!s_lookupFactoryCache.isEmpty()) {
			Long[] keys = s_lookupFactoryCache.keySet().toArray(new Long[0]);
			for (Long key : keys) {
				IServiceReferenceHolder<ILookupFactory> serviceReference = s_lookupFactoryCache.get(key);
				if (serviceReference != null) {
					ILookupFactory service = serviceReference.getService();
					if (service != null) {
						visitedIds.add(key);
						Lookup lookup = service.getLookup(gridFieldVO);
						if (lookup != null)
							return lookup;
					} else {
						s_lookupFactoryCache.remove(key);
					}
				}
			}
		}
		List<IServiceReferenceHolder<ILookupFactory>> serviceReferences = Service.locator().list(ILookupFactory.class)
				.getServiceReferences();
		for (IServiceReferenceHolder<ILookupFactory> serviceReference : serviceReferences) {
			Long serviceId = (Long) serviceReference.getServiceReference().getProperty(Constants.SERVICE_ID);
			if (visitedIds.contains(serviceId))
				continue;
			ILookupFactory service = serviceReference.getService();
			if (service != null) {
				s_lookupFactoryCache.put(serviceId, serviceReference);
				Lookup lookup = service.getLookup(gridFieldVO);
				if (lookup != null)
					return lookup;
			}
		}
		return null;
	}
	
	/**
	 * Check lookup from osgi factory 
	 * 
	 * @param gridFieldVO
	 * @return true if gridFieldVO is a lookup field
	 */
	public static boolean isLookup(GridFieldVO gridFieldVO) {
		List<Long> visitedIds = new ArrayList<Long>();
		if (!s_lookupFactoryCache.isEmpty()) {
			Long[] keys = s_lookupFactoryCache.keySet().toArray(new Long[0]);
			for (Long key : keys) {
				IServiceReferenceHolder<ILookupFactory> serviceReference = s_lookupFactoryCache.get(key);
				if (serviceReference != null) {
					ILookupFactory service = serviceReference.getService();
					if (service != null) {
						visitedIds.add(key);
						if (service.isLookup(gridFieldVO))
							return true;
					} else {
						s_lookupFactoryCache.remove(key);
					}
				}
			}
		}
		List<IServiceReferenceHolder<ILookupFactory>> serviceReferences = Service.locator().list(ILookupFactory.class)
				.getServiceReferences();
		for (IServiceReferenceHolder<ILookupFactory> serviceReference : serviceReferences) {
			Long serviceId = (Long) serviceReference.getServiceReference().getProperty(Constants.SERVICE_ID);
			if (visitedIds.contains(serviceId))
				continue;
			ILookupFactory service = serviceReference.getService();
			if (service != null) {
				s_lookupFactoryCache.put(serviceId, serviceReference);
				if (service.isLookup(gridFieldVO))
					return true;
			}
		}
		return false;
	}
	
	/**
	 * Check lookup from osgi factory 
	 * 
	 * @param infoColumnVO
	 * @return true if infoColumnVO is a lookup field
	 */
	public static boolean isLookup(InfoColumnVO infoColumnVO) {
		List<Long> visitedIds = new ArrayList<Long>();
		if (!s_lookupFactoryCache.isEmpty()) {
			Long[] keys = s_lookupFactoryCache.keySet().toArray(new Long[0]);
			for (Long key : keys) {
				IServiceReferenceHolder<ILookupFactory> serviceReference = s_lookupFactoryCache.get(key);
				if (serviceReference != null) {
					ILookupFactory service = serviceReference.getService();
					if (service != null) {
						visitedIds.add(key);
						if (service.isLookup(infoColumnVO))
							return true;
					} else {
						s_lookupFactoryCache.remove(key);
					}
				}
			}
		}
		List<IServiceReferenceHolder<ILookupFactory>> serviceReferences = Service.locator().list(ILookupFactory.class)
				.getServiceReferences();
		for (IServiceReferenceHolder<ILookupFactory> serviceReference : serviceReferences) {
			Long serviceId = (Long) serviceReference.getServiceReference().getProperty(Constants.SERVICE_ID);
			if (visitedIds.contains(serviceId))
				continue;
			ILookupFactory service = serviceReference.getService();
			if (service != null) {
				s_lookupFactoryCache.put(serviceId, serviceReference);
				if (service.isLookup(infoColumnVO))
					return true;
			}
		}
		return false;
	}
}
