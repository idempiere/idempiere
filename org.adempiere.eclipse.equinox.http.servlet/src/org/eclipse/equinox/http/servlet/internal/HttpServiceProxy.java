/******************************************************************************
 * Copyright (C) 2013 Heng Sin Low                                            *
 * Copyright (C) 2013 Trek Global                 							  *
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
package org.eclipse.equinox.http.servlet.internal;

import java.util.ArrayList;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.Servlet;
import javax.servlet.ServletException;

import org.eclipse.equinox.http.servlet.ExtendedHttpService;
import org.osgi.framework.Bundle;
import org.osgi.service.http.HttpContext;
import org.osgi.service.http.HttpService;
import org.osgi.service.http.NamespaceException;

/**
 * @author hengsin
 *
 */
public class HttpServiceProxy implements HttpService, ExtendedHttpService {
	
	private Bundle bundle;
	
	private Map<Filter, ExtendedHttpService> filterMap = new HashMap<Filter, ExtendedHttpService>();
	private HttpServiceProxyFactory factory;
	private List<FilterEntry> filters = new ArrayList<HttpServiceProxy.FilterEntry>();
	private List<ServletEntry> servlets = new ArrayList<HttpServiceProxy.ServletEntry>();
	private List<ResourceEntry> resources = new ArrayList<HttpServiceProxy.ResourceEntry>();
	
	public HttpServiceProxy(Bundle bundle, HttpServiceProxyFactory httpServiceProxyFactory) {
		this.bundle = bundle;
		this.factory = httpServiceProxyFactory;
	}
	
	/* (non-Javadoc)
	 * @see org.eclipse.equinox.http.servlet.ExtendedHttpService#registerFilter(java.lang.String, javax.servlet.Filter, java.util.Dictionary, org.osgi.service.http.HttpContext)
	 */
	@Override
	public void registerFilter(String alias, Filter filter,
			Dictionary<String, String> initparams, HttpContext context)
			throws ServletException, NamespaceException {
		String httpContextClass = context != null ? context.getClass().getName() : DefaultHttpContext.class.getName();
		HttpService delegate = factory.getHttpServiceDelegate(bundle, httpContextClass);
		if (delegate != null && delegate instanceof ExtendedHttpService) {
			((ExtendedHttpService)delegate).registerFilter(alias, filter, initparams, context);
			filterMap.put(filter, (ExtendedHttpService) delegate);
		} else {
			filters.add(new FilterEntry(alias, filter, initparams, context));
		}
	}

	/* (non-Javadoc)
	 * @see org.eclipse.equinox.http.servlet.ExtendedHttpService#unregisterFilter(javax.servlet.Filter)
	 */
	@Override
	public void unregisterFilter(Filter filter) {
		ExtendedHttpService service = filterMap.get(filter);
		if (service != null) {
			service.unregisterFilter(filter);
		}
	}

	/* (non-Javadoc)
	 * @see org.osgi.service.http.HttpService#registerServlet(java.lang.String, javax.servlet.Servlet, java.util.Dictionary, org.osgi.service.http.HttpContext)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public void registerServlet(String alias, Servlet servlet,
			Dictionary initparams, HttpContext context)
			throws ServletException, NamespaceException {
		String httpContextClass = context != null ? context.getClass().getName() : DefaultHttpContext.class.getName();
		HttpService delegate = factory.getHttpServiceDelegate(bundle, httpContextClass);
		if (delegate != null ) {
			delegate.registerServlet(alias, servlet, initparams, context);
		} else {
			servlets.add(new ServletEntry(alias, servlet, initparams, context));
		}
	}

	/* (non-Javadoc)
	 * @see org.osgi.service.http.HttpService#registerResources(java.lang.String, java.lang.String, org.osgi.service.http.HttpContext)
	 */
	@Override
	public void registerResources(String alias, String name, HttpContext context)
			throws NamespaceException {
		String httpContextClass = context != null ? context.getClass().getName() : DefaultHttpContext.class.getName();
		HttpService delegate = factory.getHttpServiceDelegate(bundle, httpContextClass);
		if (delegate != null ) {
			delegate.registerResources(alias, name, context);
		} else {
			resources.add(new ResourceEntry(alias, name, context));
		}
	}
	
	/**
	 * process registration that happens before the start of http service delegate
	 * @param httpContext
	 * @throws ServletException
	 * @throws NamespaceException
	 */
	protected void processPendingRegistration(String httpContext) throws ServletException, NamespaceException {
		if (!filters.isEmpty()) {
			List<FilterEntry> list = new ArrayList<HttpServiceProxy.FilterEntry>();
			list.addAll(filters);
			filters.clear();
			for (FilterEntry e : list) {
				if (e.getHttpContext().equals(httpContext)) {
					registerFilter(e.alias, e.filter, e.initparams, e.context);
				} else {
					filters.add(e);
				}
			}
		}
		
		if (!servlets.isEmpty()) {
			List<ServletEntry> list = new ArrayList<HttpServiceProxy.ServletEntry>();
			list.addAll(servlets);
			servlets.clear();
			for (ServletEntry e : list) {
				if (e.getHttpContext().equals(httpContext)) {
					registerServlet(e.alias, e.servlet, e.initparams, e.context);
				} else {
					servlets.add(e);
				}
			}
		}
		
		if (!resources.isEmpty()) {
			List<ResourceEntry> list = new ArrayList<HttpServiceProxy.ResourceEntry>();
			list.addAll(resources);
			resources.clear();
			for (ResourceEntry e : list) {
				if (e.getHttpContext().equals(httpContext)) {
					registerResources(e.alias, e.name, e.context);
				} else {
					resources.add(e);
				}
			}
		}
	}

	/* (non-Javadoc)
	 * @see org.osgi.service.http.HttpService#unregister(java.lang.String)
	 */
	@Override
	public void unregister(String alias) {
	}

	/* (non-Javadoc)
	 * @see org.osgi.service.http.HttpService#createDefaultHttpContext()
	 */
	@Override
	public HttpContext createDefaultHttpContext() {
		return new DefaultHttpContext(bundle);
	}
	
	class Entry {
		protected HttpContext context;
		
		protected Entry(HttpContext context) {
			this.context = context;
		}
		
		protected String getHttpContext() {
			return context != null ? context.getClass().getName() : DefaultHttpContext.class.getName();
		}
	}
	
	class FilterEntry extends Entry {
		protected String alias; 
		protected Filter filter;
		protected Dictionary<String, String> initparams; 
		
		protected FilterEntry(String alias, Filter filter,
				Dictionary<String, String> initparams, HttpContext context) {
			super(context);
			this.alias = alias;
			this.filter = filter;
			this.initparams = initparams;
		}				
	}
	
	class ServletEntry extends Entry {
		protected String alias;
		protected Servlet servlet;
		protected Dictionary<?,?> initparams;
		protected ServletEntry(String alias, Servlet servlet,
				Dictionary<?, ?> initparams, HttpContext context) {
			super(context);
			this.alias = alias;
			this.servlet = servlet;
			this.initparams = initparams;
			this.context = context;
		}		
	}
	
	class ResourceEntry extends Entry {
		protected String alias;
		protected String name; 
		
		protected ResourceEntry(String alias, String name, HttpContext context) {
			super(context);
			this.alias = alias;
			this.name = name;
		}
	}
}
