/*******************************************************************************
 * Copyright (c) 2010 IBM Corporation and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *     IBM Corporation - initial API and implementation
 *******************************************************************************/
package org.eclipse.equinox.http.servlet.internal;

import java.util.*;
import javax.servlet.*;

public class FilterConfigImpl implements FilterConfig {

	private static final Dictionary<String, String> EMPTY_PARAMS = new Hashtable<String, String>(0);
	private static final String FILTER_NAME = "filter-name"; //$NON-NLS-1$
	private Filter filter;
	private Dictionary<String, String> initparams;
	private ServletContext servletContext;

	public FilterConfigImpl(Filter filter, Dictionary<String, String> initparams, ServletContext servletContext) {
		this.filter = filter;
		this.initparams = (initparams != null) ? initparams : EMPTY_PARAMS;
		this.servletContext = servletContext;
	}

	/*
	 * @see javax.servlet.FilterConfig#getFilterName()
	 * 
	 * The OSGi Http Service does not specify a way to set a filter name at the API level. This 
	 * implementation will try to use the value of the "filter-name" initial parameter if available.
	 */
	public String getFilterName() {
		String filterName = (String) initparams.get(FILTER_NAME);
		return (filterName != null) ? filterName : filter.getClass().getName();
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
