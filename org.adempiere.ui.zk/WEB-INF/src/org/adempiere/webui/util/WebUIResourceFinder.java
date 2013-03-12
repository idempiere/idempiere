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
import java.util.Enumeration;

import org.adempiere.base.IResourceFinder;
import org.adempiere.webui.WebUIActivator;
import org.adempiere.webui.theme.ThemeManager;

/**
 *
 * @author hengsin
 *
 */
public class WebUIResourceFinder implements IResourceFinder {

	private Enumeration<URL> find(String name) {
		int pathIndex = name.lastIndexOf("/");
		String path = "/";
		String pattern = null;
		if (pathIndex > 0) {
			path = name.substring(0, pathIndex);
			pattern = name.substring(pathIndex+1);
		} else {
			pattern = name;
		}
		return WebUIActivator.getBundleContext().getBundle().findEntries(path, pattern, false);
	}
	
	@Override
	public URL getResource(String name) {
		Enumeration<URL> e = find(name);
		URL url = e != null && e.hasMoreElements() ? e.nextElement() : null;
		if (url == null && name.startsWith("org/compiere/images")) {
			String t = name.substring("org/compiere/".length());
			t = ThemeManager.getThemeResource(t);
			e = find(t);
			url = e != null && e.hasMoreElements() ? e.nextElement() : null;
			if (url == null && t.endsWith(".gif")) {
				t = t.replace(".gif", ".png");
				e = find(t);
				url = e != null && e.hasMoreElements() ? e.nextElement() : null;
			}
		} else if (url == null && name.startsWith("/org/compiere/images")) {
			String t = name.substring("/org/compiere/".length());
			t = ThemeManager.getThemeResource(t);
			e = find(t);
			url = e != null && e.hasMoreElements() ? e.nextElement() : null;
			if (url == null && t.endsWith(".gif")) {
				t = t.replace(".gif", ".png");
				e = find(t);
				url = e != null && e.hasMoreElements() ? e.nextElement() : null;
			}
		}
		return url;
	}
}
