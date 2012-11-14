/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2010 Heng Sin Low                							  *
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

import org.adempiere.base.IResourceFinder;
import org.adempiere.webui.WebUIActivator;

/**
 *
 * @author hengsin
 *
 */
public class WebUIResourceFinder implements IResourceFinder {

	@Override
	public URL getResource(String name) {
		URL url = WebUIActivator.getBundleContext().getBundle().getEntry(name);
		if (url == null && name.startsWith("org/compiere/images")) {
			String t = name.substring("org/compiere/".length());
			url = WebUIActivator.getBundleContext().getBundle().getEntry(t);
			if (url == null && t.endsWith(".gif")) {
				t = t.replace(".gif", ".png");
				url = WebUIActivator.getBundleContext().getBundle().getEntry(t);
			}
		} else if (url == null && name.startsWith("/org/compiere/images")) {
			String t = name.substring("/org/compiere/".length());
			url = WebUIActivator.getBundleContext().getBundle().getEntry(t);
			if (url == null && t.endsWith(".gif")) {
				t = t.replace(".gif", ".png");
				url = WebUIActivator.getBundleContext().getBundle().getEntry(t);
			}
		}
		return url;
	}
}
