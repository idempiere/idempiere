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
package org.zkoss.util.resource;

import java.util.ArrayList;
import java.util.List;

/**
 * @author hengsin
 *
 */
public class ResourceLocatorRegistry {

	private List<IResourceLocator> locators = new ArrayList<IResourceLocator>();
	
	private static ResourceLocatorRegistry INSTANCE = null;
	
	/**
	 * 
	 * @param locator
	 */
	public synchronized void addLocator(IResourceLocator locator) {
		System.err.println("addLocator " + locator);
		locators.add(locator);
		if (INSTANCE == null) {
			INSTANCE = this;
		}
	}
	
	/**
	 * 
	 * @param locator
	 */
	public synchronized void removeLocator(IResourceLocator locator) {
		locators.remove(locator);
	}
	
	/**
	 * @return list of resource locator
	 */
	public synchronized static List<IResourceLocator> getLocators() {
		return INSTANCE != null ? INSTANCE.locators : null;
	}
}
