package org.adempiere.webui;

import java.util.Arrays;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

import org.adempiere.webui.session.WebUIServlet;
import org.eclipse.core.runtime.Plugin;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceReference;
import org.osgi.service.http.HttpContext;
import org.osgi.service.http.HttpService;
import org.osgi.util.tracker.ServiceTracker;
import org.zkoss.zk.au.http.DHtmlUpdateServlet;

public class Activator extends Plugin {

	private ServiceTracker httpServiceTracker;
	
	public void start(BundleContext context) throws Exception {
		System.out.println("Starting WebUI");
		httpServiceTracker = new HttpServiceTracker(context);
		httpServiceTracker.open();
	}

	public void stop(BundleContext context) throws Exception {
		System.out.println("Stopping WebUI");
		httpServiceTracker.close();
		httpServiceTracker = null;
	}

	private class HttpServiceTracker extends ServiceTracker {

		public HttpServiceTracker(BundleContext context) {
			super(context, HttpService.class.getName(), null);
		}

		public Object addingService(ServiceReference reference) {
			HttpService httpService = (HttpService) context.getService(reference);
			System.out.println("Adding zkLoader: "+httpService);
			try {			
//				MappingServlet mapping = new MappingServlet();

				Hashtable<String, String> params = new Hashtable<String, String>();
				params.put("update-uri", "/zkau");
				HttpContext ctx = httpService.createDefaultHttpContext();
				httpService.registerServlet("/*.zul", new WebUIServlet(), params , ctx); //$NON-NLS-1$
				httpService.registerServlet("/*.zhtml", new WebUIServlet(), params , ctx); //$NON-NLS-1$
				
				DelegatingServlet updateServlet = new DelegatingServlet(new DHtmlUpdateServlet()) {
					private ServletConfig cfg;
					@Override
					public void init(ServletConfig config)
							throws ServletException {
						super.init(config);
						cfg = config;
					}
					@Override
					public ServletConfig getServletConfig() {
						return cfg;
					}
				};
				httpService.registerServlet("/zkau", updateServlet, params , ctx); //$NON-NLS-1$
				
				httpService.registerResources("/", "/", ctx);
				
				System.out.println("zkLoader added: " + httpService.toString());
			} catch (Exception e) {
				e.printStackTrace();
			}
			return httpService;
		}		
		
		public void removedService(ServiceReference reference, Object service) {
			HttpService httpService = (HttpService) service;
			httpService.unregister("/"); //$NON-NLS-1$
			super.removedService(reference, service);
		}
	}
}
