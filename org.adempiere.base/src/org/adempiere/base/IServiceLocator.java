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
 * Interface for dynamic discovery of services.<br/>
 * This is the primary entry point for iDempiere service discovery.
 * 
 * @author viola
 *
 */
public interface IServiceLocator {
	/**
	 * Locate matching service by type (order by service.ranking priority)
	 * @param type service interface
	 * @return holder for dynamic service
	 */
	<T> IServiceHolder<T> locate(Class<T> type);
	
	/**
	 * Locate matching service by type and query expression
	 * @param type
	 * @param query
	 * @return holder for service
	 */
	<T> IServiceHolder<T> locate(Class<T> type, ServiceQuery query);
	
	/**
	 * Locate matching service by component name and query expression
	 * @param type
	 * @param componentName service component name
	 * @param query
	 * @return holder for dynamic service
	 */
	<T> IServiceHolder<T> locate(Class<T> type, String componentName, ServiceQuery query);
	
	/**
	 * Find all matching services by type
	 * @param type
	 * @return holder for list of dynamic service
	 */
	<T> IServicesHolder<T> list(Class<T> type);
	
	/**
	 * Find all matching services by type and query expression
	 * @param type
	 * @param query
	 * @return holder for list of dynamic service
	 */
	<T> IServicesHolder<T> list(Class<T> type, ServiceQuery query);
	
	/**
	 * Find all matching services by component name and query expression
	 * @param type
	 * @param componentName osgi service component name
	 * @param query
	 * @return holder for list of dynamic service
	 */
	<T> IServicesHolder<T> list(Class<T> type, String componentName, ServiceQuery query);	
}
