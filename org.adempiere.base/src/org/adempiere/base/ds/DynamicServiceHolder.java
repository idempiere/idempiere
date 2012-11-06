/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.adempiere.base.ds;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.adempiere.base.IServiceHolder;
import org.adempiere.base.IServicesHolder;
import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;

/**
 * @author hengsin
 *
 */
public class DynamicServiceHolder<T> implements IServiceHolder<T>, IServicesHolder<T> {

	private ServiceTracker<T, T> serviceTracker;

	/**
	 * @param tracker
	 */
	public DynamicServiceHolder(ServiceTracker<T, T> tracker) {
		serviceTracker = tracker;
		if (serviceTracker.getTrackingCount() == -1)
			serviceTracker.open();
	}

	@Override
	public T getService() {
		T service = serviceTracker.getService();
		return service;
	}

	@Override
	public List<T> getServices() {
		List<T> services = new ArrayList<T>();
		ServiceReference<T>[] objects = serviceTracker.getServiceReferences();
		List<ServiceReference<T>> references = new ArrayList<ServiceReference<T>>();
		if (objects != null && objects.length > 0) {
			references = Arrays.asList(objects);
		}
		Collections.sort(references, Collections.reverseOrder());
		for(ServiceReference<T> reference : references) {
			services.add(serviceTracker.getService(reference));
		}
		return services;
	}
}
