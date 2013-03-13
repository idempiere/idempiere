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
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DateFormat;
import java.util.Date;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;
import java.util.concurrent.ScheduledThreadPoolExecutor;

import org.compiere.Adempiere;
import org.compiere.model.ServerStateChangeEvent;
import org.compiere.model.ServerStateChangeListener;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

import com.hazelcast.config.Config;
import com.hazelcast.config.FileSystemXmlConfig;
import com.hazelcast.core.*;

/**
 * 
 * @author hengsin
 *
 */
public class Activator implements BundleActivator {

	private static BundleContext context;

	static BundleContext getContext() {
		return context;
	}

	private volatile static HazelcastInstance hazelcastInstance;
	private static Future<?> future;

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
	}

	private static synchronized void createHazelCastInstance() {
		ScheduledThreadPoolExecutor executor = Adempiere.getThreadPoolExecutor();
		
		future = executor.submit(new Runnable() {			
			@Override
			public void run() {
				String dataArea = System.getProperty("osgi.install.area");
				if (dataArea != null && dataArea.trim().length() > 0) {
					try {
						URL url = new URL(dataArea);
						File file = new File(url.getPath(), "hazelcast.xml");
						if (file.exists()) {
							try {
								Config config = new FileSystemXmlConfig(file);
								hazelcastInstance = Hazelcast.newHazelcastInstance(config);
								return;
							} catch (FileNotFoundException e) {}
						} 
					} catch (MalformedURLException e1) {
					}
				}
				hazelcastInstance = Hazelcast.newHazelcastInstance(null);		
			}
		});
	}

	public static synchronized HazelcastInstance getHazelcastInstance() {
		if (future != null && !future.isDone()) {
			try {
				future.get();
			} catch (InterruptedException e) {
			} catch (ExecutionException e) {
			}		
		}
				
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
			if (future != null && !future.isDone()) {
				future.cancel(true); 
			} else if (hazelcastInstance != null) {
				hazelcastInstance.getLifecycleService().shutdown();
				hazelcastInstance = null;
			}
		}
	}
}
