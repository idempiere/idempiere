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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.osgi.framework.Bundle;
import org.osgi.framework.ServiceFactory;
import org.osgi.framework.ServiceRegistration;
import org.osgi.service.http.HttpService;

/**
 * 
 * @author hengsin
 *
 */
public class HttpServiceProxyFactory implements ServiceFactory<HttpService> {

	private static Map<String, ProxyServlet> delegateMap = new HashMap<String, ProxyServlet>();
	private static List<HttpServiceProxy> proxies  = new ArrayList<HttpServiceProxy>();
	
	@Override
	public HttpService getService(Bundle bundle,
			ServiceRegistration<HttpService> registration) {
		HttpServiceProxy service = new HttpServiceProxy(bundle, this);
		proxies.add(service);
		return service;
	}

	@Override
	public void ungetService(Bundle bundle,
			ServiceRegistration<HttpService> registration, HttpService service) {
		proxies.remove(service);
	}
	
	/**
	 * 
	 * @param httpContext
	 * @param proxy
	 * @return the previous value associated with the key or null if there was no mapping for key
	 */
	public static synchronized ProxyServlet registerServletDelegate(String httpContext, ProxyServlet proxy) {
		ProxyServlet old = delegateMap.put(httpContext, proxy);
		for(HttpServiceProxy p : proxies) {
			try {
				p.processPendingRegistration(httpContext);
			} catch (Exception e) {
			}
		}
		return old;
	}

	/**
	 * @param proxy
	 * @return the proxy if it have been register previously
	 */
	public static synchronized ProxyServlet unregisterServletDelegate(ProxyServlet proxy) {
		return delegateMap.remove(proxy.getHttpContext());
	}
	
	/**
	 * 
	 * @param bundle
	 * @param httpContext
	 * @return http service delegate for httpContext ( if any )
	 */
	public HttpService getHttpServiceDelegate(Bundle bundle, String httpContext) {
		ProxyServlet proxy = delegateMap.get(httpContext);
		if (proxy != null)
			return new HttpServiceImpl(bundle, proxy);
		else
			return null;
	}

}
