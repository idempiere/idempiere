/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.adempiere.base;

/**
 * A service locator looks up services.
 * This is the central authority for adempiere service definition,
 * because each service defined has to be looked up via this interface.
 * 
 * A service in adempiere is an implementation for the registered interface, expose through osgi service registry or equinox extension registry
 * 
 * @author viola
 *
 */
public interface IServiceLocator {
	/**
	 * 
	 * @param type service interface
	 * @return holder for dynamic service
	 */
	<T> IServiceHolder<T> locate(Class<T> type);
	
	/**
	 * 
	 * @param type
	 * @param serviceType equinox extension point id, ignore by osgi service locator
	 * type.getName
	 * @return holder for dynamic service
	 */
	<T> IServiceHolder<T> locate(Class<T> type, String serviceType);
	
	/**
	 * 
	 * @param type
	 * @param query
	 * @return
	 */
	<T> IServiceHolder<T> locate(Class<T> type, ServiceQuery query);
	
	/**
	 * 
	 * @param type
	 * @param serviceId component name or extension id
	 * @param query
	 * @return holder for dynamic service
	 */
	<T> IServiceHolder<T> locate(Class<T> type, String serviceId, ServiceQuery query);
	
	/**
	 * 
	 * @param type
	 * @param serviceType equinox extension point id, ignore by osgi service locator
	 * @param serviceId component name or extension id
	 * @param query
	 * @return holder for dynamic service
	 */
	<T> IServiceHolder<T> locate(Class<T> type, String serviceType, String serviceId, ServiceQuery query);
	
	/**
	 * 
	 * @param type
	 * @return holder for list of dynamic service
	 */
	<T> IServicesHolder<T> list(Class<T> type);
	
	/**
	 * 
	 * @param type
	 * @param serviceType equinox extension point id, ignore by osgi service locator
	 * @return holder for list of dynamic service
	 */
	<T> IServicesHolder<T> list(Class<T> type, String serviceType);
	
	/**
	 * 
	 * @param type
	 * @param query
	 * @return holder for list of dynamic service
	 */
	<T> IServicesHolder<T> list(Class<T> type, ServiceQuery query);
	
	/**
	 * 
	 * @param type
	 * @param serviceId component name or extension id
	 * @param query
	 * @return holder for list of dynamic service
	 */
	<T> IServicesHolder<T> list(Class<T> type, String serviceId, ServiceQuery query);
	
	/**
	 * 
	 * @param type
	 * @param serviceType equinox extension point id, ignore by osgi service locator
	 * @param serviceId component name or extension id
	 * @param query
	 * @return holder for list of dynamic service
	 */
	<T> IServicesHolder<T> list(Class<T> type, String serviceType, String serviceId, ServiceQuery query);
}
