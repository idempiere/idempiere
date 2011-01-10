/*******************************************************************************
 * Copyright (c) 2005, 2007 Cognos Incorporated, IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *     Cognos Incorporated - initial API and implementation
 *     IBM Corporation - bug fixes and enhancements
 *******************************************************************************/

package org.eclipse.equinox.http.servlet.internal;

import org.osgi.framework.*;

// Factory to create http services. This is because the service needs to be customized for each bundle in order to implement the default resource lookups.
public class HttpServiceFactory implements ServiceFactory {

	private ProxyServlet proxy;

	public HttpServiceFactory(ProxyServlet proxy) {
		this.proxy = proxy;
	}

	public Object getService(Bundle bundle, ServiceRegistration registration) {
		return new HttpServiceImpl(bundle, proxy);
	}

	public void ungetService(Bundle bundle, ServiceRegistration registration, Object service) {
		((HttpServiceImpl) service).shutdown();

	}

}
