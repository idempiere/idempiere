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

import java.util.concurrent.Future;
import java.util.concurrent.ScheduledThreadPoolExecutor;

import org.compiere.Adempiere;
import org.compiere.model.ServerStateChangeEvent;
import org.compiere.model.ServerStateChangeListener;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

import com.hazelcast.config.*;
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

	protected static HazelcastInstance hazelcastInstance;
	private Future<?> future;

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

	private void createHazelCastInstance() {
		ScheduledThreadPoolExecutor executor = Adempiere.getThreadPoolExecutor();
		future = executor.submit(new Runnable() {			
			@Override
			public void run() {
				Config config = new Config();
				hazelcastInstance = Hazelcast.newHazelcastInstance(config);				
			}
		});
	}

	/*
	 * (non-Javadoc)
	 * @see org.osgi.framework.BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	public void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null;
		if (future != null && !future.isDone()) {
			future.cancel(true); 
		} else if (hazelcastInstance != null) {
			hazelcastInstance.getLifecycleService().shutdown();
			hazelcastInstance = null;
		}
	}
}
