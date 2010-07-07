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
		private BundleContext context;
		public HttpServiceTracker(BundleContext context) {
			super(context, HttpService.class.getName(), null);
			this.context = context;
		}

		public Object addingService(ServiceReference reference) {
			HttpService httpService = (HttpService) context.getService(reference);
			System.out.println("Adding zkLoader: "+httpService);
			try {
//				MappingServlet mapping = new MappingServlet();

				Hashtable<String, String> params = new Hashtable<String, String>();
				params.put("update-uri", "/zkau");
				HttpContext ctx = httpService.createDefaultHttpContext();
				WebUIServlet webuiServlet = new WebUIServlet();
				httpService.registerServlet("/*.zul", webuiServlet, params , ctx); //$NON-NLS-1$
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
//				httpService.registerServlet("/*.zhtml", webuiServlet, params , ctx); //$NON-NLS-1$
				httpService.registerResources("/", "/WebContent", ctx);
				httpService.registerResources("/WEB-INF/zk.xml", "/zk.xml", ctx);

				System.out.println("zkLoader added: " + httpService.toString());
			} catch (Exception e) {
				e.printStackTrace();
			}
			return httpService;
		}

		public void removedService(ServiceReference reference, Object service) {
			HttpService httpService = (HttpService) service;
			httpService.unregister("/"); //$NON-NLS-1$
			System.out.println("zkLoader removedss: " + httpService.toString());
			super.removedService(reference, service);
		}
	}
}
