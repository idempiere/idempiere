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
package org.adempiere.base.equinox;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.util.Properties;

import org.eclipse.core.runtime.IConfigurationElement;
import org.eclipse.core.runtime.Platform;
import org.eclipse.osgi.service.datalocation.Location;

/**
 *
 * @author hengsin
 *
 */
public class ExtensionPriorityManager {
	private Properties priorityMap = new Properties();

	private static final ExtensionPriorityManager instance = new ExtensionPriorityManager();

	private ExtensionPriorityManager() {
		Location location = Platform.getInstanceLocation();
		URL url = location.getURL();
		File file = new File(url.getPath(), "extensions-priorty.properties");
		if (file.exists() && file.canRead()) {
			FileInputStream fileInput = null;
			try {
				fileInput = new FileInputStream(file);
				priorityMap.load(fileInput);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally{
				if (fileInput != null) {
					try {
						fileInput.close();
					} catch (Exception e2) {}
					fileInput = null;
				}
			}
			
		}
	}

	/**
	 * @param element
	 * @return priority of extension
	 */
	public int getPriority(IConfigurationElement element) {
		int priority = 0;
		String id = element.getDeclaringExtension().getUniqueIdentifier();
		if (id != null) {
			String p = priorityMap.getProperty(id);
			if (p != null) {
				try {
					priority = Integer.parseInt(p);
					return priority;
				} catch (NumberFormatException e) {}
			}
		}
		String p = element.getAttribute("priority");
		if (p != null) {
			try {
				priority = Integer.parseInt(p);
				return priority;
			} catch (NumberFormatException e) {}
		}
		return priority;
	}

	/**
	 * @return ExtensionPriorityManager singleton instance
	 */
	public static ExtensionPriorityManager getInstance() {
		return instance;
	}
}
