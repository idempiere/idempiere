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
package org.adempiere.base;

import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.List;
import java.util.function.BiFunction;
import java.util.function.Function;
import java.util.logging.Level;

import org.adempiere.base.annotation.EventTopicDelegate;
import org.adempiere.base.annotation.ImportEventTopic;
import org.adempiere.base.annotation.ModelEventTopic;
import org.adempiere.base.annotation.ProcessEventTopic;
import org.adempiere.base.event.IEventManager;
import org.adempiere.base.event.annotations.EventDelegate;
import org.adempiere.base.event.annotations.ModelEventDelegate;
import org.adempiere.base.event.annotations.ModelEventHandler;
import org.adempiere.base.event.annotations.SimpleEventHandler;
import org.adempiere.base.event.annotations.imp.ImportEventDelegate;
import org.adempiere.base.event.annotations.imp.ImportEventHandler;
import org.adempiere.base.event.annotations.process.ProcessEventDelegate;
import org.adempiere.base.event.annotations.process.ProcessEventHandler;
import org.compiere.model.PO;
import org.compiere.util.CLogger;
import org.compiere.util.Util;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.osgi.framework.wiring.BundleWiring;
import org.osgi.service.component.ComponentContext;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.event.Event;
import org.osgi.service.event.EventHandler;
import org.osgi.util.tracker.ServiceTracker;
import org.osgi.util.tracker.ServiceTrackerCustomizer;

import io.github.classgraph.AnnotationClassRef;
import io.github.classgraph.AnnotationInfo;
import io.github.classgraph.ClassGraph;
import io.github.classgraph.ClassGraph.ScanResultProcessor;
import io.github.classgraph.ClassInfo;

/**
 * Scan, discover and register classes with {@link EventTopicDelegate} annotation
 * @author hengsin
 *
 */
public abstract class AnnotationBasedEventManager extends AnnotationBasedFactory {

	private static final CLogger s_log = CLogger.getCLogger(AnnotationBasedEventManager.class); 
	
	private IEventManager eventManager;
	private BundleContext bundleContext;
	private List<EventHandler> handlers = new ArrayList<>();

	private ServiceTracker<IEventManager, IEventManager> serviceTracker;
	
	/**
	 * default constructor
	 */
	public AnnotationBasedEventManager() {
	}

	/**
	 * Subclass would override this to define the list of packages to perform the scan, discover and register operation
	 * @return packages to scan
	 */
	public abstract String[] getPackages();
	
	@Activate
	public void activate(ComponentContext context) {
		bundleContext = context.getBundleContext();
		serviceTracker = new ServiceTracker<IEventManager, IEventManager>(bundleContext, IEventManager.class, 
				new Customizer());
		serviceTracker.open();
	}
	
	@Deactivate
	public void deactivate(ComponentContext context) {
		if (serviceTracker != null) {
			serviceTracker.close();
			serviceTracker = null;
		}
		if (eventManager != null) {
			if (handlers.size() > 0)
				unbindService(eventManager);
			eventManager = null;
		}
	}
	
	/**
	 * 
	 * @param eventManager
	 */
	protected void bindService(IEventManager eventManager) {
		this.eventManager = eventManager;
		if (eventManager != null)
			scan();
	}
	
	/**
	 * 
	 * @param eventManager
	 */
	protected void unbindService(IEventManager eventManager) {
		if (eventManager != null && eventManager == this.eventManager) {
			if (handlers.size() > 0) {
				for(EventHandler handler : handlers)
					eventManager.unregister(handler);
			}
			this.eventManager = null;
		}
	}
	
	/**
	 * Perform scan, discover and register of annotated classes
	 */
	protected void scan() {
		long start = System.currentTimeMillis();
		ClassLoader classLoader = bundleContext.getBundle().adapt(BundleWiring.class).getClassLoader();

		ClassGraph graph = new ClassGraph()
				.enableAnnotationInfo()
				.overrideClassLoaders(classLoader)
				.disableNestedJarScanning()
				.disableModuleScanning()
				.acceptPackagesNonRecursive(getPackages());

		ScanResultProcessor scanResultProcessor = scanResult ->
		{
		    for (ClassInfo classInfo : scanResult.getClassesWithAnnotation(EventTopicDelegate.class)) {
		    	if (classInfo.isAbstract())
		    		continue;
		        String className = classInfo.getName();
		        AnnotationInfo baseInfo = classInfo.getAnnotationInfo(EventTopicDelegate.class);
		        String filter = (String) baseInfo.getParameterValues().getValue("filter");
		        if (classInfo.hasAnnotation(ModelEventTopic.class)) {
		        	AnnotationInfo annotationInfo = classInfo.getAnnotationInfo(ModelEventTopic.class);
			        modelEventDelegate(classLoader, className, annotationInfo, filter);
		        } else if (classInfo.hasAnnotation(ImportEventTopic.class)) {
		        	AnnotationInfo annotationInfo = classInfo.getAnnotationInfo(ImportEventTopic.class);
		        	importEventDelegate(classLoader, className, annotationInfo, filter);
		        } else if (classInfo.hasAnnotation(ProcessEventTopic.class)) {
		        	AnnotationInfo annotationInfo = classInfo.getAnnotationInfo(ProcessEventTopic.class);
		        	processEventDelegate(classLoader, className, annotationInfo, filter);
		        } else {
		        	simpleEventDelegate(classLoader, className, filter);
		        }
		    }
			long end = System.currentTimeMillis();
			s_log.info(() -> this.getClass().getSimpleName() + " loaded " + handlers.size() + " classes in "
						+ ((end-start)/1000f) + "s");
			signalScanCompletion(true);
		};

		graph.scanAsync(getExecutorService(), getMaxThreads(), scanResultProcessor, getScanFailureHandler());
	}

	private void simpleEventDelegate(ClassLoader classLoader, String className, String filter) {
		try {
			@SuppressWarnings("unchecked")
			Class<? extends EventDelegate> delegateClass = (Class<? extends EventDelegate>) classLoader.loadClass(className);
			Constructor<?> constructor = delegateClass.getConstructor(Event.class);
			EventDelegateSupplier supplier = new EventDelegateSupplier(constructor);
			SimpleEventHandler handler = new SimpleEventHandler(delegateClass, supplier);
			if (!Util.isEmpty(filter, true))
				handler.setFilter(filter);
			handlers.add(handler);
		    eventManager.register(handler.getTopics(), handler.getFilter(), handler);
		} catch (Exception e) {
			if (s_log.isLoggable(Level.INFO))
				s_log.log(Level.INFO, e.getMessage(), e);
		}
	}

	private void processEventDelegate(ClassLoader classLoader, String className, AnnotationInfo annotationInfo, String filter) {		
		try {
			String processUUID = (String) annotationInfo.getParameterValues().getValue("processUUID");
			@SuppressWarnings("unchecked")
			Class<? extends ProcessEventDelegate> delegateClass = (Class<? extends ProcessEventDelegate>) classLoader.loadClass(className);
			Constructor<?> constructor = delegateClass.getConstructor(Event.class);
			ProcessDelegateSupplier supplier = new ProcessDelegateSupplier(constructor);
			ProcessEventHandler handler = new ProcessEventHandler(delegateClass, processUUID, supplier);
			if (!Util.isEmpty(filter, true))
				handler.setFilter(filter);
			handlers.add(handler);
		    eventManager.register(handler.getTopics(), handler.getFilter(), handler);
		} catch (Exception e) {
			if (s_log.isLoggable(Level.INFO))
				s_log.log(Level.INFO, e.getMessage(), e);
		}
	}

	private void importEventDelegate(ClassLoader classLoader, String className, AnnotationInfo annotationInfo, String filter) {		
		try {
			String importTableName = (String) annotationInfo.getParameterValues().getValue("importTableName");
			@SuppressWarnings("unchecked")
			Class<? extends ImportEventDelegate> delegateClass = (Class<? extends ImportEventDelegate>) classLoader.loadClass(className);
			Constructor<?> constructor = delegateClass.getConstructor(Event.class);
			ImportDelegateSupplier supplier = new ImportDelegateSupplier(constructor);
			ImportEventHandler handler = new ImportEventHandler(delegateClass, importTableName, supplier);
			if (!Util.isEmpty(filter, true))
				handler.setFilter(filter);
			handlers.add(handler);
		    eventManager.register(handler.getTopics(), handler.getFilter(), handler);
		} catch (Exception e) {
			if (s_log.isLoggable(Level.INFO))
				s_log.log(Level.INFO, e.getMessage(), e);
		}
	}

	private void modelEventDelegate(ClassLoader classLoader, String className, AnnotationInfo annotationInfo, String filter) {		
		try {			
			AnnotationClassRef classRef = (AnnotationClassRef) annotationInfo.getParameterValues().getValue("modelClass");
			@SuppressWarnings("unchecked")
			Class<? extends PO> modelClass = (Class<? extends PO>)classRef.loadClass();
		    @SuppressWarnings("unchecked")
			Class<? extends ModelEventDelegate<? extends PO>> delegateClass = (Class<ModelEventDelegate<? extends PO>>) classLoader.loadClass(className);
		    Constructor<?> constructor = delegateClass.getDeclaredConstructor(modelClass, Event.class);
		    ModelDelegateSupplier supplier = new ModelDelegateSupplier(constructor);
		    @SuppressWarnings({ "rawtypes", "unchecked" })
			ModelEventHandler<?> handler = new ModelEventHandler(modelClass, delegateClass, supplier);
		    if (!Util.isEmpty(filter, true))
				handler.setFilter(filter);
		    handlers.add(handler);
		    eventManager.register(handler.getTopics(), handler.getFilter(), handler);
		} catch (Exception e) {
			if (s_log.isLoggable(Level.INFO))
				s_log.log(Level.INFO, e.getMessage(), e);
		}
	}
	
	private class Customizer implements ServiceTrackerCustomizer<IEventManager, IEventManager> {
		@Override
		public IEventManager addingService(ServiceReference<IEventManager> reference) {
			IEventManager eventManager = bundleContext.getService(reference);
			bindService(eventManager);
			return eventManager;
		}

		@Override
		public void modifiedService(ServiceReference<IEventManager> reference, IEventManager service) {
			if (eventManager != null && eventManager != service) {
				unbindService(eventManager);
				bindService(service);
			}
		}

		@Override
		public void removedService(ServiceReference<IEventManager> reference, IEventManager service) {
			unbindService(service);
		}
	}
	
	private static class ModelDelegateSupplier implements BiFunction<PO, Event, ModelEventDelegate<?>> {

		private Constructor<?> constructor;

		private ModelDelegateSupplier(Constructor<?> constructor) {
			this.constructor = constructor;
		}
		
		@Override
		public ModelEventDelegate<?> apply(PO t, Event u) {
			ModelEventDelegate<?> delegate = null;
			if (constructor != null) {
				try {
					delegate = (ModelEventDelegate<?>) constructor.newInstance(t, u);
				} catch (Exception e) {
					constructor = null;
					s_log.log(Level.WARNING, e.getMessage(), e);
				}
			}
			return delegate;
		}		
	}
	
	private static class ImportDelegateSupplier implements Function<Event, ImportEventDelegate> {

		private Constructor<?> constructor;

		private ImportDelegateSupplier(Constructor<?> constructor) {
			this.constructor = constructor;
		}
		
		@Override
		public ImportEventDelegate apply(Event t) {
			ImportEventDelegate delegate = null;
			if (constructor != null) {
				try {
					delegate = (ImportEventDelegate) constructor.newInstance(t);
				} catch (Exception e) {
					constructor = null;
					s_log.log(Level.WARNING, e.getMessage(), e);
				}
			}
			return delegate;
		}
		
	}
	
	private static class ProcessDelegateSupplier implements Function<Event, ProcessEventDelegate> {

		private Constructor<?> constructor;

		private ProcessDelegateSupplier(Constructor<?> constructor) {
			this.constructor = constructor;
		}
		
		@Override
		public ProcessEventDelegate apply(Event t) {
			ProcessEventDelegate delegate = null;
			if (constructor != null) {
				try {
					delegate = (ProcessEventDelegate) constructor.newInstance(t);
				} catch (Exception e) {
					constructor = null;
					s_log.log(Level.WARNING, e.getMessage(), e);
				}
			}
			return delegate;
		}
		
	}
	
	private static class EventDelegateSupplier implements Function<Event, EventDelegate> {

		private Constructor<?> constructor;

		private EventDelegateSupplier(Constructor<?> constructor) {
			this.constructor = constructor;
		}
		
		@Override
		public EventDelegate apply(Event t) {
			EventDelegate delegate = null;
			if (constructor != null) {
				try {
					delegate = (EventDelegate) constructor.newInstance(t);
				} catch (Exception e) {
					constructor = null;
					s_log.log(Level.WARNING, e.getMessage(), e);
				}
			}
			return delegate;
		}
		
	}
}
