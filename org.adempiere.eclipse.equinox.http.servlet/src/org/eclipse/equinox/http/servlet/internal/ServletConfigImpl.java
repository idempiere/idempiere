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

import java.util.*;
import javax.servlet.*;

public class ServletConfigImpl implements ServletConfig {

	private static final Dictionary<String, String> EMPTY_PARAMS = new Hashtable<String, String>(0);
	private static final String SERVLET_NAME = "servlet-name"; //$NON-NLS-1$
	private Servlet servlet;
	private Dictionary<String, String> initparams;
	private ServletContext servletContext;

	public ServletConfigImpl(Servlet servlet, Dictionary<String, String> initparams, ServletContext servletContext) {
		this.servlet = servlet;
		this.initparams = (initparams != null) ? initparams : EMPTY_PARAMS;
		this.servletContext = servletContext;
	}

	/*
	 * @see javax.servlet.ServletConfig#getServletName()
	 * 
	 * The OSGi Http Service does not specify a way to set a servlet name at the API level. This 
	 * implementation will try to use the value of the "servlet-name" initial parameter if available.
	 */
	public String getServletName() {
		String servletName = (String) initparams.get(SERVLET_NAME);
		return (servletName != null) ? servletName : servlet.getClass().getName();
	}

	public ServletContext getServletContext() {
		return servletContext;
	}

	public String getInitParameter(String name) {
		return (String) initparams.get(name);
	}

	public Enumeration<String> getInitParameterNames() {
		return initparams.keys();
	}
}
