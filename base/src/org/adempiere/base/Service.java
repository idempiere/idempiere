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

import org.adempiere.base.equinox.EquinoxServiceLocator;

/**
 * This is a very simple factory for service locators
 * 
 * @author viola
 * 
 */
public class Service {

	private static IServiceLocator theLocator;

	public static IServiceLocator locator() {
		if (theLocator == null) {
			synchronized (Service.class) {
				if (theLocator == null) {
					theLocator = new EquinoxServiceLocator();
					System.out
							.println("Started service locator: " + theLocator);
				}
			}
		}
		return theLocator;
	}

	public static <T extends IService> T locate(Class<T> type) {
		return locator().locate(type);
	}

	public static <T extends IService> T locate(Class<T> type, ServiceQuery query) {
		return locator().locate(type, query);
	}

	public static <T extends IService> List<T> list(Class<T> type) {
		return locator().list(type);
	}

	public static <T extends IService> List<T> list(Class<T> type, ServiceQuery query) {
		return locator().list(type, query);
	}
}
