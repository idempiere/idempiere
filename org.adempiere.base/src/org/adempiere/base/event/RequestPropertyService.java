/******************************************************************************
 * Copyright (C) 2013 Elaine	                                              *
 * Copyright (C) 2013 Trek Global
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

package org.adempiere.base.event;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.base.event.RequestEventHandler;
import org.compiere.util.CLogger;
import org.compiere.util.Ini;
import org.compiere.util.Util;
import org.osgi.framework.Bundle;
import org.osgi.framework.FrameworkUtil;
import org.osgi.service.cm.Configuration;
import org.osgi.service.cm.ConfigurationAdmin;

/**
 * Request property service
 * @author Elaine
 *
 */
public class RequestPropertyService {

	private static final String REQUESTEVENTHANDLER_PROPERTIES = "requesteventhandler.properties";
	
	private static final CLogger logger = CLogger.getCLogger(RequestPropertyService.class);
	
	public RequestPropertyService() {
	}

	public void bindConfigurationAdmin(ConfigurationAdmin configurationAdmin) {
		readProperties(configurationAdmin);
	}
	
	public void unbindConfigurationAdmin(ConfigurationAdmin configurationAdmin) {
		
	}
	
	private void readProperties(ConfigurationAdmin service) {
		File file = new File(Ini.getAdempiereHome(), REQUESTEVENTHANDLER_PROPERTIES);
		if (file.exists()) {
			Properties p = new Properties();
			FileInputStream is = null;
			try {
				is = new FileInputStream(file);
				p.load(is);
				String ignoreRequesTypes = p.getProperty(RequestEventHandler.IGNORE_REQUEST_TYPES);
				
				if (!Util.isEmpty(ignoreRequesTypes)) {
					Configuration configuration = service.getConfiguration("org.adempiere.base.event.request.service");
					if (configuration.getProperties() == null) {
						Dictionary<String, Object> map = new Hashtable<String, Object>();
						map.put(RequestEventHandler.IGNORE_REQUEST_TYPES, ignoreRequesTypes);
						configuration.update(map);
					} else {
						Bundle bundle = FrameworkUtil.getBundle(RequestEventHandler.class);
						String bundleLocation = bundle.getLocation();
						String configLocation = configuration.getBundleLocation();
						if (!bundleLocation.equals(configLocation)) {
							configuration.setBundleLocation(bundleLocation);
							configuration.update();
						}
					}
				}
			} catch (FileNotFoundException e) {
				logger.log(Level.WARNING, REQUESTEVENTHANDLER_PROPERTIES + " not found.", e);
			} catch (IOException e) {
				logger.log(Level.SEVERE, "Error reading " + REQUESTEVENTHANDLER_PROPERTIES, e);
			} finally {
				if (is != null) {
					try {
						is.close();
					} catch (Exception ex) {}
				}
			}
		}		
	}
}
