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

import java.util.Enumeration;
import javax.servlet.Servlet;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

// This class adapts HttpSessions in order to return the right ServletContext
public class HttpSessionAdaptor implements HttpSession {

	private HttpSession session;
	private Servlet servlet;

	public HttpSessionAdaptor(HttpSession session, Servlet servlet) {
		this.session = session;
		this.servlet = servlet;
	}

	public ServletContext getServletContext() {
		return servlet.getServletConfig().getServletContext();
	}

	public Object getAttribute(String arg0) {
		return session.getAttribute(arg0);
	}

	public Enumeration getAttributeNames() {
		return session.getAttributeNames();
	}

	public long getCreationTime() {
		return session.getCreationTime();
	}

	public String getId() {
		return session.getId();
	}

	public long getLastAccessedTime() {
		return session.getLastAccessedTime();
	}

	public int getMaxInactiveInterval() {
		return session.getMaxInactiveInterval();
	}

	/**@deprecated*/
	public javax.servlet.http.HttpSessionContext getSessionContext() {
		return session.getSessionContext();
	}

	/**@deprecated*/
	public Object getValue(String arg0) {
		return session.getValue(arg0);
	}

	/**@deprecated*/
	public String[] getValueNames() {
		return session.getValueNames();
	}

	public void invalidate() {
		session.invalidate();
	}

	public boolean isNew() {
		return session.isNew();
	}

	/**@deprecated*/
	public void putValue(String arg0, Object arg1) {
		session.putValue(arg0, arg1);
	}

	public void removeAttribute(String arg0) {
		session.removeAttribute(arg0);
	}

	/**@deprecated*/
	public void removeValue(String arg0) {
		session.removeValue(arg0);
	}

	public void setAttribute(String arg0, Object arg1) {
		session.setAttribute(arg0, arg1);
	}

	public void setMaxInactiveInterval(int arg0) {
		session.setMaxInactiveInterval(arg0);
	}

}
