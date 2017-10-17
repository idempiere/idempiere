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

public class WindowValidatorManager implements BundleActivator, ServiceTrackerCustomizer<WindowValidator, WindowValidator> {

	private static WindowValidatorManager instance = null;
	
	private BundleContext context;
	private Map<String, List<WindowValidator>> validatorMap = new HashMap<String, List<WindowValidator>>();
	private List<WindowValidator> globalValidators = new ArrayList<WindowValidator>();

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

	void addService(WindowValidator service, String uuid) {
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

	void removeService(WindowValidator service, String uuid) {
		List<WindowValidator> list = validatorMap.get(uuid);
		if (list != null) {
			list.remove(service);
		}
	}

	@Override
	public void start(BundleContext context) throws Exception {
		this.context = context;
		serviceTracker = new ServiceTracker<WindowValidator, WindowValidator>(context, WindowValidator.class.getName(), this);
		serviceTracker.open();
		
		instance = this;
	}

	@Override
	public void stop(BundleContext context) throws Exception {
		serviceTracker.close();
		this.context = null;
		instance = null;
	}

	public static WindowValidatorManager getInstance() {
		return instance;
	}
	
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
	
	private static class ChainCallback implements Callback<Boolean> {

		private Callback<Boolean> callback;
		private WindowValidator[] validators;
		private WindowValidatorEvent event;
		private int index = -1;

		public ChainCallback(WindowValidatorEvent event, WindowValidator[] validators, Callback<Boolean> callback) {
			this.event = event;
			this.validators = validators;
			this.callback = callback;
		}
		
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
