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
package org.idempiere.hazelcast.service;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.text.DateFormat;
import java.util.Date;
import java.util.Enumeration;

import org.compiere.Adempiere;
import org.compiere.model.ServerStateChangeEvent;
import org.compiere.model.ServerStateChangeListener;
import org.compiere.util.CLogger;
import org.eclipse.osgi.framework.console.CommandProvider;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

import com.hazelcast.config.Config;
import com.hazelcast.config.FileSystemXmlConfig;
import com.hazelcast.config.MapConfig;
import com.hazelcast.config.UrlXmlConfig;
import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;

/**
 * 
 * @author hengsin
 *
 */
public class Activator implements BundleActivator {

	private static BundleContext context;
	protected final static CLogger logger = CLogger.getCLogger(Activator.class.getName());

	static BundleContext getContext() {
		return context;
	}

	private volatile static HazelcastInstance hazelcastInstance;

	/*
	 * (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	public void start(BundleContext bundleContext) throws Exception {
		Activator.context = bundleContext;
		
		if (Adempiere.isStarted())
			createHazelCastInstance();
		else {
			Adempiere.addServerStateChangeListener(new ServerStateChangeListener() {
				@Override
				public void stateChange(ServerStateChangeEvent event) {
					if (event.getEventType() == ServerStateChangeEvent.SERVER_START) 
						createHazelCastInstance();
				}
			});
		}
        bundleContext.registerService(CommandProvider.class.getName(), new CacheConsoleProvider(), null);
	}

	private static synchronized void createHazelCastInstance() {
			File file = null;
			//try idempiere home
			String dataArea = System.getProperty("IDEMPIERE_HOME");
			if (dataArea != null && dataArea.trim().length() > 0) {
				try {
					file = new File(dataArea, "hazelcast.xml");
					if (!file.exists())
						file = null;
				} catch (Exception e) {}
			}
			//try working directory
			if (file == null) {
				dataArea = System.getProperty("user.dir");
				if (dataArea != null && dataArea.trim().length() > 0) {
					try {
						file = new File(dataArea, "hazelcast.xml");
						if (!file.exists())
							file = null;
					} catch (Exception e) {}
				}
			}				
			//try osgi install area
			if (file == null) {
				dataArea = System.getProperty("osgi.install.area");
				if (dataArea != null && dataArea.trim().length() > 0) {
					try {
						URL url = new URL(dataArea);
						file = new File(url.getPath(), "hazelcast.xml");
						if (!file.exists())
							file = null;
					} catch (Exception e) {}
				}
			}
			//try hazelcast.config - to be consistent with hazelcast configuration documentation
			if (file == null) {
				dataArea = System.getProperty("hazelcast.config");
				if (dataArea != null && dataArea.trim().length() > 0) {
					try {
						file = new File(dataArea);
						if (!file.exists())
							file = null;
					} catch (Exception e) {}
				}
			}
			if (file != null && file.exists()) {
				try {
					Config config = new FileSystemXmlConfig(file);
					config.setClassLoader(Activator.class.getClassLoader());
					logger.warning("Starting hazelcast with configuration from file " + file.getName());
					hazelcastInstance = Hazelcast.newHazelcastInstance(config);
					MapConfig mc = config.getMapConfig("default");
					if (mc != null) {
						logger.info("Hazelcast Max Size Config: "+mc.getMaxSizeConfig().getMaxSizePolicy() + " " + mc.getMaxSizeConfig().getSize());
					}
					return;
				} catch (FileNotFoundException e) {}
			}
			
			Enumeration<URL> entries = getContext().getBundle().findEntries("/", "hazelcast.xml", false);
			URL url = entries.hasMoreElements() ? entries.nextElement() : null;
			if (url != null) {
				try {
					Config config = new UrlXmlConfig(url);
					config.setClassLoader(Activator.class.getClassLoader());
					logger.warning("Starting hazelcast with configuration from URL " + url.toString());
					hazelcastInstance = Hazelcast.newHazelcastInstance(config);
					MapConfig mc = config.getMapConfig("default");
					if (mc != null) {
						logger.info("Hazelcast Max Size Config: "+mc.getMaxSizeConfig().getMaxSizePolicy() + " " + mc.getMaxSizeConfig().getSize());
					}
					return;
				} catch (IOException e) {}
			}
			
			Config config = new Config();
			config.setClassLoader(Activator.class.getClassLoader());
			hazelcastInstance = Hazelcast.newHazelcastInstance(config);	
			logger.warning("Starting hazelcast with default configuration");
			MapConfig mc = config.getMapConfig("default");
			if (mc != null) {
				logger.info("Hazelcast Max Size Config: "+mc.getMaxSizeConfig().getMaxSizePolicy() + " " + mc.getMaxSizeConfig().getSize());
			}
	}

	public static synchronized HazelcastInstance getHazelcastInstance() {
		if (hazelcastInstance != null) {
			if (!hazelcastInstance.getLifecycleService().isRunning()) {
				System.err.println(DateFormat.getDateTimeInstance().format(new Date()) + " Hazelcast instance is down!");
				//recreate
				try {
					hazelcastInstance = Hazelcast.newHazelcastInstance(null);
					if (!hazelcastInstance.getLifecycleService().isRunning()) {
						hazelcastInstance = null;
						System.err.println(DateFormat.getDateTimeInstance().format(new Date()) + " Failed to re-create Hazelcast instance!");
					} else {
						System.err.println(DateFormat.getDateTimeInstance().format(new Date()) + " Hazelcast instance re-created!");
					}
				} catch (Throwable t) {
					t.printStackTrace();
					hazelcastInstance = null;
					System.err.println(DateFormat.getDateTimeInstance().format(new Date()) + " Failed to re-create Hazelcast instance!");
				}				
			}						
		}
		
		return hazelcastInstance;
	}
	
	/*
	 * (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	public void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null;
		synchronized (Activator.class) {
			if (hazelcastInstance != null) {
				hazelcastInstance.getLifecycleService().shutdown();
				hazelcastInstance = null;
			}
		}
	}
}
