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
package org.adempiere.base.equinox;

import org.adempiere.base.ServiceQuery;


/**
 * This is the Equinox implementation of extension Locator.
 * It delegates work to the ExtensionList that lookups up extensions.
 * Usually, the ids of extension points correspond to the interface names of the services.
 *  
 * @author viola
 *
 */
public class EquinoxExtensionLocator {
	
	private final static EquinoxExtensionLocator INSTANCE = new EquinoxExtensionLocator(); 

	private EquinoxExtensionLocator() {}
	
	public static EquinoxExtensionLocator instance() {
		return INSTANCE;
	}
	
	/**
	 * 
	 * @param type
	 * @return equinox extension holder
	 */
	public <T> EquinoxExtensionHolder<T> list(Class<T> type) {
		return list(type, type.getName());
	}
	
	/**
	 * 
	 * @param type
	 * @param extensionPointId
	 * @return equinox extension holder
	 */
	public <T> EquinoxExtensionHolder<T> list(Class<T> type, String extensionPointId) {
		ExtensionList<T> list = new ExtensionList<T>(type, extensionPointId);
		return new EquinoxExtensionHolder<T>(list);
	}

	/**
	 * 
	 * @param type
	 * @param query
	 * @return equinox extension holder
	 */
	public <T> EquinoxExtensionHolder<T> list(Class<T> type, ServiceQuery query) {
		return list(type, type.getName(), null, query);
	}

	/**
	 * 
	 * @param type
	 * @param extensionId
	 * @param query
	 * @return equinox extension holder
	 */
	public <T> EquinoxExtensionHolder<T> list(Class<T> type, String extensionId, ServiceQuery query) {
		ExtensionList<T> list = new ExtensionList<T>(type, null, extensionId, query);
		return new EquinoxExtensionHolder<T>(list);
	}
	
	/**
	 * 
	 * @param type
	 * @param extensionPointId
	 * @param extensionId
	 * @param query
	 * @return equinox extension holder
	 */
	public <T> EquinoxExtensionHolder<T> list(Class<T> type, String extensionPointId, String extensionId,
			ServiceQuery query) {
		ExtensionList<T> list = new ExtensionList<T>(type, extensionPointId, extensionId, query);
		return new EquinoxExtensionHolder<T>(list);
	}
		
	/**
	 * 
	 * @param type
	 * @return equinox extension holder
	 */
	public <T> EquinoxExtensionHolder<T> locate(Class<T> type) {
		return locate(type, type.getName());
	}

	/**
	 * 
	 * @param type
	 * @param extensionPointId
	 * @return equinox extension holder
	 */
	public <T> EquinoxExtensionHolder<T> locate(Class<T> type, String extensionPointId) {
		ExtensionList<T> list = new ExtensionList<T>(type, extensionPointId);
		return new EquinoxExtensionHolder<T>(list);
	}
	
	/**
	 * 
	 * @param type
	 * @param query
	 * @return equinox extension holder
	 */
	public <T> EquinoxExtensionHolder<T> locate(Class<T> type, ServiceQuery query) {
		return locate(type, type.getName(), null, query);
	}

	/**
	 * 
	 * @param type
	 * @param extensionId
	 * @param query
	 * @return equinox extension holder
	 */
	public <T> EquinoxExtensionHolder<T> locate(Class<T> type, String extensionId, ServiceQuery query) {
		ExtensionList<T> list = new ExtensionList<T>(type, null, extensionId, query);
		return new EquinoxExtensionHolder<T>(list);
	}
	
	/**
	 * 
	 * @param type
	 * @param extensionPointId
	 * @param extensionId
	 * @param query
	 * @return equinox extension holder
	 */
	public <T> EquinoxExtensionHolder<T> locate(Class<T> type, String extensionPointId, String extensionId, ServiceQuery query) {
		ExtensionList<T> list = new ExtensionList<T>(type, extensionPointId, extensionId, query);
		return new EquinoxExtensionHolder<T>(list);
	}	
}
