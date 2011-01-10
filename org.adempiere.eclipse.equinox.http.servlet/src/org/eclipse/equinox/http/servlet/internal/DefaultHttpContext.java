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

import java.io.IOException;
import java.net.URL;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.osgi.framework.Bundle;
import org.osgi.service.http.HttpContext;

public class DefaultHttpContext implements HttpContext {

	private Bundle bundle;

	public DefaultHttpContext(Bundle bundle) {
		this.bundle = bundle;
	}

	public boolean handleSecurity(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// default behaviour assumes the container has already performed authentication
		return true;
	}

	public URL getResource(String name) {
		return bundle.getResource(name);
	}

	public String getMimeType(String name) {
		return null;
	}
}
