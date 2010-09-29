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

import java.util.List;

/**
 * This is a very simple factory for service locators
 * 
 * @author viola
 * 
 */
public class Service {

	private static final String LOCATOR_CLASS = "ServiceLocator";
	private static final String DEFAULT_LOCATOR_CLASS = "org.adempiere.base.equinox.EquinoxServiceLocator";

	private static IServiceLocator theLocator;

	public static IServiceLocator locator() {
		if (theLocator == null) {
			synchronized (Service.class) {
				if (theLocator == null) {
					theLocator = createServiceLocator();
				}
			}
		}
		return theLocator;
	}

	private static IServiceLocator createServiceLocator() {
		String className = System.getProperty(LOCATOR_CLASS);
		if (className==null)
			className = DEFAULT_LOCATOR_CLASS;
		try {
			Class<?> clazz = Class.forName(className);
			IServiceLocator locator =  (IServiceLocator) clazz.newInstance();
			System.out.println("Started service locator: " + locator);
			return locator;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	public static <T> T locate(Class<T> type) {
		return locate(type, type.getName());
	}

	public static <T> T locate(Class<T> type, String id) {
		return locator().locate(type, id);
	}
	
	public static <T> T locate(Class<T> type, ServiceQuery query) {
		return locate(type, type.getName(), query);
	}

	public static <T> T locate(Class<T> type, String id, ServiceQuery query) {
		return locator().locate(type, id, query);
	}
	
	public static <T> List<T> list(Class<T> type) {
		return list(type, type.getName());
	}

	public static <T> List<T> list(Class<T> type, String id) {
		return locator().list(type, id);
	}
	
	public static <T> List<T> list(Class<T> type, ServiceQuery query) {
		return locator().list(type, type.getName(), query);
	}
	
	public static <T> List<T> list(Class<T> type, String id, ServiceQuery query) {
		return locator().list(type, id, query);
	}
}
