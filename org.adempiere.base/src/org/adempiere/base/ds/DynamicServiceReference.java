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
package org.adempiere.base.ds;

import org.adempiere.base.IServiceReferenceHolder;
import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;

/**
 * IServiceReferenceHolder implementation using ServiceTracker
 * @author hengsin
 *
 * @param <T>
 */
public class DynamicServiceReference<T> implements IServiceReferenceHolder<T> {

	private ServiceTracker<T, T> serviceTracker;
	private ServiceReference<T> serviceReference;
	
	/**
	 * 
	 * @param tracker
	 * @param serviceReference
	 */
	public DynamicServiceReference(ServiceTracker<T, T> tracker, ServiceReference<T> serviceReference) {
		this.serviceTracker = tracker;
		this.serviceReference = serviceReference;
	}

	@Override
	public T getService() {
		return serviceTracker.getService(serviceReference);
	}

	@Override
	public ServiceReference<T> getServiceReference() {
		return serviceReference;
	}
}
