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

import java.io.File;
import java.util.*;

import javax.servlet.FilterChain;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.osgi.service.http.HttpContext;

/**
 * The ProxyContext provides something similar to a ServletContext for all servlets and resources under a particular ProxyServlet.
 * In particular it holds and represent the concept of "context path" through the Proxy Servlets servlet path.
 * The Http Service also requires a ServletContext namespaced by each individual HttpContext. The ProxyContext provides support for the
 * attribute map of a ServletContext again namespaced by HttpContext as specified in the Http Service specification. The ContextAttributes
 * are reference counted so that when the HttpContext is no longer referenced the associated context attributes can be
 * garbage collected and the context temp dir deleteted.
 */
public class ProxyContext {
	private static final String JAVAX_SERVLET_CONTEXT_TEMPDIR = "javax.servlet.context.tempdir"; //$NON-NLS-1$

	private String servletPath;
	private HashMap attributesMap = new HashMap();
	File proxyContextTempDir;

	public ProxyContext(ServletContext servletContext) {
		File tempDir = (File) servletContext.getAttribute(JAVAX_SERVLET_CONTEXT_TEMPDIR);
		if (tempDir != null) {
			proxyContextTempDir = new File(tempDir, "proxytemp"); //$NON-NLS-1$
			deleteDirectory(proxyContextTempDir);
			proxyContextTempDir.mkdirs();
		}
	}

	public void destroy() {
		if (proxyContextTempDir != null)
			deleteDirectory(proxyContextTempDir);
	}

	synchronized void initializeServletPath(HttpServletRequest req, FilterChain filterChain) {
		if (servletPath == null) {
			if (filterChain != null)
				servletPath = "/";
			else
				servletPath = HttpServletRequestAdaptor.getDispatchServletPath(req);
		}
	}

	synchronized String getServletPath() {
		return servletPath;
	}

	synchronized void createContextAttributes(HttpContext httpContext) {
		ContextAttributes attributes = (ContextAttributes) attributesMap.get(httpContext);
		if (attributes == null) {
			attributes = new ContextAttributes(httpContext);
			attributesMap.put(httpContext, attributes);
		}
		attributes.addReference();
	}

	synchronized void destroyContextAttributes(HttpContext httpContext) {
		ContextAttributes attributes = (ContextAttributes) attributesMap.get(httpContext);
		attributes.removeReference();
		if (attributes.referenceCount() == 0) {
			attributesMap.remove(httpContext);
			attributes.destroy();
		}
	}

	synchronized Dictionary getContextAttributes(HttpContext httpContext) {
		return (Dictionary) attributesMap.get(httpContext);
	}

	/**
	 * deleteDirectory is a convenience method to recursively delete a directory
	 * @param directory - the directory to delete.
	 * @return was the delete succesful
	 */
	protected static boolean deleteDirectory(File directory) {
		if (directory.exists() && directory.isDirectory()) {
			File[] files = directory.listFiles();
			for (int i = 0; i < files.length; i++) {
				if (files[i].isDirectory()) {
					deleteDirectory(files[i]);
				} else {
					files[i].delete();
				}
			}
		}
		return directory.delete();
	}

	public class ContextAttributes extends Hashtable {
		private static final long serialVersionUID = 1916670423277243587L;
		private int referenceCount;

		public ContextAttributes(HttpContext httpContext) {
			if (proxyContextTempDir != null) {
				File contextTempDir = new File(proxyContextTempDir, "hc_" + httpContext.hashCode()); //$NON-NLS-1$
				contextTempDir.mkdirs();
				put(JAVAX_SERVLET_CONTEXT_TEMPDIR, contextTempDir);
			}
		}

		public void destroy() {
			File contextTempDir = (File) get(JAVAX_SERVLET_CONTEXT_TEMPDIR);
			if (contextTempDir != null)
				deleteDirectory(contextTempDir);
		}

		public void addReference() {
			referenceCount++;
		}

		public void removeReference() {
			referenceCount--;
		}

		public int referenceCount() {
			return referenceCount;
		}
	}
}
