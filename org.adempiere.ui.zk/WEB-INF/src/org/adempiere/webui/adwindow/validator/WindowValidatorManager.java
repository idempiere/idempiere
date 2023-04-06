/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.adwindow.validator;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.util.Callback;
import org.adempiere.webui.adwindow.ADWindow;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.osgi.util.tracker.ServiceTracker;
import org.osgi.util.tracker.ServiceTrackerCustomizer;

/**
 * 
 * Manage {@link WindowValidator} osgi services
 * @author hengsin
 *
 */
public class WindowValidatorManager implements BundleActivator, ServiceTrackerCustomizer<WindowValidator, WindowValidator> {

	/** Singleton WindowValidatorManager instance **/
	private static WindowValidatorManager instance = null;
	
	/** {@link BundleContext} instance **/
	private BundleContext context;
	/** AD_Window_UU:List<WindowValidator> **/
	private Map<String, List<WindowValidator>> validatorMap = new HashMap<String, List<WindowValidator>>();
	/** WindowValidator for all AD Window **/
	private List<WindowValidator> globalValidators = new ArrayList<WindowValidator>();

	/** WindowValidator osgi service tracker **/
	private ServiceTracker<WindowValidator, WindowValidator> serviceTracker;

	@Override
	public WindowValidator addingService(
			ServiceReference<WindowValidator> reference) {
		WindowValidator service = context.getService(reference);

		Object obj = reference.getProperty("AD_Window_UU");

		if (obj instanceof String) {
			String uuid = (String) reference.getProperty("AD_Window_UU");
			if (uuid == null || "*".equals(uuid)) {
				globalValidators.add(service);
				return service;
			}
			addService(service, uuid);
		}
		else if (obj instanceof String []) {
			String[] uuids = (String []) reference.getProperty("AD_Window_UU");
			for (String uuid : uuids)
				addService(service, uuid);
		}
		return service;
	}

	/**
	 * Add {@link WindowValidator} service for an AD Window
	 * @param service
	 * @param uuid AD_Window_UU
	 */
	protected void addService(WindowValidator service, String uuid) {
		List<WindowValidator> list = validatorMap.get(uuid);
		if (list == null) {
			list = new ArrayList<WindowValidator>();
			validatorMap.put(uuid, list);
		}
		list.add(service);
	}

	@Override
	public void modifiedService(ServiceReference<WindowValidator> reference,
			WindowValidator service) {
	}

	@Override
	public void removedService(ServiceReference<WindowValidator> reference,
			WindowValidator service) {
		
		Object obj = reference.getProperty("AD_Window_UU");
		
		if (obj instanceof String) {
			String uuid = (String) reference.getProperty("AD_Window_UU");
			if (uuid == null || "*".equals(uuid)) {
				globalValidators.remove(service);
			}
			else
				removeService(service, uuid);
		}
		else if (obj instanceof String []) {
			String[] uuids = (String []) reference.getProperty("AD_Window_UU");
			for (String uuid : uuids)
				removeService(service, uuid);
		}
	}

	/**
	 * 
	 * @param service
	 * @param uuid
	 */
	protected void removeService(WindowValidator service, String uuid) {
		List<WindowValidator> list = validatorMap.get(uuid);
		if (list != null) {
			list.remove(service);
		}
	}

	/**
	 * Create {@link #serviceTracker} and {@link #instance}
	 */
	@Override
	public void start(BundleContext context) throws Exception {
		this.context = context;
		serviceTracker = new ServiceTracker<WindowValidator, WindowValidator>(context, WindowValidator.class.getName(), this);
		serviceTracker.open();
		
		instance = this;
	}

	/**
	 * Close {@link #serviceTracker} and dispose {@link #instance}
	 */
	@Override
	public void stop(BundleContext context) throws Exception {
		serviceTracker.close();
		this.context = null;
		instance = null;
	}

	/**
	 * 
	 * @return {@link WindowValidatorManager}
	 */
	public static WindowValidatorManager getInstance() {
		return instance;
	}
	
	/**
	 * fire window validator event for all register {@link WindowValidator} service
	 * @param event
	 * @param callback optional callback
	 */
	public void fireWindowValidatorEvent(WindowValidatorEvent event, Callback<Boolean> callback) {
		ADWindow window = event.getWindow();
		String uuid = window.getAD_Window_UU();
		List<WindowValidator> list = validatorMap.get(uuid);
		int listSize = list != null ? list.size() : 0;
		WindowValidator[] validators = new WindowValidator[listSize+globalValidators.size()];
		int index = -1;
		if (listSize > 0) {
			for(WindowValidator validator : list) {
				index++;
				validators[index] = validator;
			}
		}
		for(WindowValidator validator : globalValidators) {
			index++;
			validators[index] = validator;
		}
		ChainCallback chain = new ChainCallback(event, validators, callback);
		chain.start();
	}
	
	/**
	 * class to call a list of {@link WindowValidator} through {@link Callback} chain. 
	 */
	private static class ChainCallback implements Callback<Boolean> {
		/** optional callback to invoke after execution of all {@link #validators} or when there's error **/
		private Callback<Boolean> callback;
		private WindowValidator[] validators;
		/** event for {@link #validators} **/
		private WindowValidatorEvent event;
		/** current index of {@link #validators} **/
		private int index = -1;

		/**
		 * @param event
		 * @param validators
		 * @param callback optional callback to invoke after execution of all {@link #validators} or when there's error
		 */
		public ChainCallback(WindowValidatorEvent event, WindowValidator[] validators, Callback<Boolean> callback) {
			this.event = event;
			this.validators = validators;
			this.callback = callback;
		}
		
		/**
		 * Start the @link {@link WindowValidator} callback chain.
		 */
		public void start() {
			index = 0;
			if (index < validators.length)
				validators[index].onWindowEvent(event, this);
			else if (callback != null)
				callback.onCallback(true);
		}
		
		@Override
		public void onCallback(Boolean result) {
			if (result) {
				if (index < validators.length-1) {
					index++;
					validators[index].onWindowEvent(event, this);
				} else if (callback != null){					
					callback.onCallback(result);
				}
			} else if (callback != null){
				callback.onCallback(result);
			}
		}
		
	}
}
