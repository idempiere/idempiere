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
package org.adempiere.base;

import java.util.List;

import org.adempiere.base.ds.DynamicServiceLocator;

/**
 * Delegate to available service locator
 * @author hengsin
 *
 */
public class DelegatingServiceLocator implements IServiceLocator {

	private IServicesHolder<IServiceLocator> locatorsHolder;

	public DelegatingServiceLocator() {
		DynamicServiceLocator serviceLocator = new DynamicServiceLocator();
		locatorsHolder = serviceLocator.list(IServiceLocator.class);
	}

	private IServiceLocator[] getLocators() {
		List<IServiceLocator> locators = locatorsHolder.getServices();
		return locators.toArray(new IServiceLocator[0]);
	}
	
	/* (non-Javadoc)
	 * @see org.adempiere.base.IServiceLocator#locate(java.lang.Class)
	 */
	@Override
	public <T> IServiceHolder<T> locate(Class<T> type) {
		DelegatingServiceHolder<T> holder = new DelegatingServiceHolder<T>();
		for(IServiceLocator locator : getLocators()) {
			IServiceHolder<T> t = locator.locate(type);
			if (t != null)
				holder.addServiceHolder(t);
		}
		return holder;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IServiceLocator#locate(java.lang.Class, java.lang.String)
	 */
	@Override
	public <T> IServiceHolder<T> locate(Class<T> type, String serviceType) {
		DelegatingServiceHolder<T> holder = new DelegatingServiceHolder<T>();
		for(IServiceLocator locator : getLocators()) {
			IServiceHolder<T> t = locator.locate(type, serviceType);
			if (t != null)
				holder.addServiceHolder(t);
		}
		return holder;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IServiceLocator#locate(java.lang.Class, org.adempiere.base.ServiceQuery)
	 */
	@Override
	public <T> IServiceHolder<T> locate(Class<T> type, ServiceQuery query) {
		DelegatingServiceHolder<T> holder = new DelegatingServiceHolder<T>();
		for(IServiceLocator locator : getLocators()) {
			IServiceHolder<T> t = locator.locate(type, query);
			if (t != null)
				holder.addServiceHolder(t);
		}
		return holder;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IServiceLocator#locate(java.lang.Class, java.lang.String, org.adempiere.base.ServiceQuery)
	 */
	@Override
	public <T> IServiceHolder<T> locate(Class<T> type, String serviceId, ServiceQuery query) {
		DelegatingServiceHolder<T> holder = new DelegatingServiceHolder<T>();
		for(IServiceLocator locator : getLocators()) {
			IServiceHolder<T> t = locator.locate(type, serviceId, query);
			if (t != null)
				holder.addServiceHolder(t);
		}
		return holder;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IServiceLocator#locate(java.lang.Class, java.lang.String, java.lang.String, org.adempiere.base.ServiceQuery)
	 */
	@Override
	public <T> IServiceHolder<T> locate(Class<T> type, String serviceType,
			String serviceId, ServiceQuery query) {
		DelegatingServiceHolder<T> holder = new DelegatingServiceHolder<T>();
		for(IServiceLocator locator : getLocators()) {
			IServiceHolder<T> t = locator.locate(type, serviceType, serviceId, query);
			if (t != null)
				holder.addServiceHolder(t);
		}
		return holder;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IServiceLocator#list(java.lang.Class)
	 */
	@Override
	public <T> IServicesHolder<T> list(Class<T> type) {
		DelegatingServiceHolder<T> holder = new DelegatingServiceHolder<T>();
		for(IServiceLocator locator : getLocators()) {
			IServicesHolder<T> t = locator.list(type);
			if (t != null)
				holder.addServicesHolder(t);
		}
		return holder;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IServiceLocator#list(java.lang.Class, java.lang.String)
	 */
	@Override
	public <T> IServicesHolder<T> list(Class<T> type, String serviceType) {
		DelegatingServiceHolder<T> holder = new DelegatingServiceHolder<T>();
		for(IServiceLocator locator : getLocators()) {
			IServicesHolder<T> t = locator.list(type, serviceType);
			if (t != null)
				holder.addServicesHolder(t);
		}
		return holder;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IServiceLocator#list(java.lang.Class, org.adempiere.base.ServiceQuery)
	 */
	@Override
	public <T> IServicesHolder<T> list(Class<T> type, ServiceQuery query) {
		DelegatingServiceHolder<T> holder = new DelegatingServiceHolder<T>();
		for(IServiceLocator locator : getLocators()) {
			IServicesHolder<T> t = locator.list(type, query);
			if (t != null)
				holder.addServicesHolder(t);
		}
		return holder;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IServiceLocator#list(java.lang.Class, java.lang.String, org.adempiere.base.ServiceQuery)
	 */
	@Override
	public <T> IServicesHolder<T> list(Class<T> type, String serviceId, ServiceQuery query) {
		DelegatingServiceHolder<T> holder = new DelegatingServiceHolder<T>();
		for(IServiceLocator locator : getLocators()) {
			IServicesHolder<T> t = locator.list(type, serviceId, query);
			if (t != null)
				holder.addServicesHolder(t);
		}
		return holder;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.base.IServiceLocator#list(java.lang.Class, java.lang.String, java.lang.String, org.adempiere.base.ServiceQuery)
	 */
	@Override
	public <T> IServicesHolder<T> list(Class<T> type, String serviceType,
			String serviceId, ServiceQuery query) {
		DelegatingServiceHolder<T> holder = new DelegatingServiceHolder<T>();
		for(IServiceLocator locator : getLocators()) {
			IServicesHolder<T> t = locator.list(type, serviceType, serviceId, query);
			if (t != null)
				holder.addServicesHolder(t);
		}
		return holder;
	}

}
