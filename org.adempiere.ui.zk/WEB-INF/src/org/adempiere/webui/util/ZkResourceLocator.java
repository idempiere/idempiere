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
package org.adempiere.webui.util;

import java.net.URL;

import org.adempiere.webui.WebUIActivator;
import org.zkoss.util.resource.IResourceLocator;

/**
 * @author hengsin
 *
 */
public class ZkResourceLocator implements IResourceLocator {

	private static ZkResourceLocator INSTANCE;
	
	public ZkResourceLocator() {
		INSTANCE = this;
	}
	
	/* (non-Javadoc)
	 * @see org.zkoss.util.resource.IResourceLocator#getResource(java.lang.String)
	 */
	@Override
	public URL getResource(String name) {
		return WebUIActivator.getBundleContext().getBundle().getEntry(name);
	}
	
	public static boolean isStarted() {
		return INSTANCE != null;
	}

}
