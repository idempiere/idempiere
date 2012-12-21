/*******************************************************************************
 * Copyright (c) 2005-2007 Cognos Incorporated, IBM Corporation and others
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Contributors:
 *     Cognos Incorporated - initial API and implementation
 *     IBM Corporation - bug fixes and enhancements
 *     Angelo Zerr <angelo.zerr@gmail.com> - give the capability to use resources (JSP, HTML, Servlet...) 
 *     from the Bridge webapp with HTTP Filter.     
 *******************************************************************************/
package org.eclipse.equinox.http.servlet.internal;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.security.*;
import javax.servlet.http.*;
import org.osgi.service.http.HttpContext;

public class ResourceServlet extends HttpServlet {
	private static final long serialVersionUID = 3586876493076122102L;
	private static final String LAST_MODIFIED = "Last-Modified"; //$NON-NLS-1$
	private static final String IF_MODIFIED_SINCE = "If-Modified-Since"; //$NON-NLS-1$
	private static final String IF_NONE_MATCH = "If-None-Match"; //$NON-NLS-1$
	private static final String ETAG = "ETag"; //$NON-NLS-1$

	private String internalName;
	HttpContext httpContext;
	private AccessControlContext acc;

	public ResourceServlet(String internalName, HttpContext context, AccessControlContext acc) {
		this.internalName = internalName;
		if (internalName.equals("/")) { //$NON-NLS-1$
			this.internalName = ""; //$NON-NLS-1$
		}
		this.httpContext = context;
		this.acc = acc;
	}

	public void service(HttpServletRequest req, final HttpServletResponse resp) throws IOException {
		String method = req.getMethod();
		if (method.equals("GET") || method.equals("POST") || method.equals("HEAD")) { //$NON-NLS-1$//$NON-NLS-2$ //$NON-NLS-3$
			String pathInfo = HttpServletRequestAdaptor.getDispatchPathInfo(req, null);
			if (pathInfo == null)
				pathInfo = ""; //$NON-NLS-1$
			String resourcePath = internalName + pathInfo;
			URL resourceURL = httpContext.getResource(resourcePath);
			if (resourceURL != null)
				writeResource(req, resp, resourcePath, resourceURL);
			else
				resp.sendError(HttpServletResponse.SC_NOT_FOUND, "ProxyServlet: " + req.getRequestURI()); //$NON-NLS-1$
		} else {
			resp.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		}
	}

	private void writeResource(final HttpServletRequest req, final HttpServletResponse resp, final String resourcePath, final URL resourceURL) throws IOException {
		try {
			AccessController.doPrivileged(new PrivilegedExceptionAction<Object>() {

				public Object run() throws Exception {
					URLConnection connection = resourceURL.openConnection();
					long lastModified = connection.getLastModified();
					int contentLength = connection.getContentLength();

					String etag = null;
					if (lastModified != -1 && contentLength != -1)
						etag = "W/\"" + contentLength + "-" + lastModified + "\""; //$NON-NLS-1$//$NON-NLS-2$//$NON-NLS-3$

					// Check for cache revalidation.
					// We should prefer ETag validation as the guarantees are stronger and all HTTP 1.1 clients should be using it
					String ifNoneMatch = req.getHeader(IF_NONE_MATCH);
					if (ifNoneMatch != null && etag != null && ifNoneMatch.indexOf(etag) != -1) {
						resp.setStatus(HttpServletResponse.SC_NOT_MODIFIED);
						return Boolean.TRUE;
					}

					long ifModifiedSince = req.getDateHeader(IF_MODIFIED_SINCE);
					// for purposes of comparison we add 999 to ifModifiedSince since the fidelity
					// of the IMS header generally doesn't include milli-seconds
					if (ifModifiedSince > -1 && lastModified > 0 && lastModified <= (ifModifiedSince + 999)) {
						resp.setStatus(HttpServletResponse.SC_NOT_MODIFIED);
						return Boolean.TRUE;
					}

					// return the full contents regularly
					if (contentLength != -1)
						resp.setContentLength(contentLength);

					String contentType = httpContext.getMimeType(resourcePath);
					if (contentType == null)
						contentType = getServletConfig().getServletContext().getMimeType(resourcePath);

					if (contentType != null)
						resp.setContentType(contentType);

					if (lastModified > 0)
						resp.setDateHeader(LAST_MODIFIED, lastModified);

					if (etag != null)
						resp.setHeader(ETAG, etag);

					if (contentLength != 0) {
						// open the input stream
						InputStream is = null;
						try {
							is = connection.getInputStream();
							// write the resource
							try {
								OutputStream os = resp.getOutputStream();
								int writtenContentLength = writeResourceToOutputStream(is, os);
								if (contentLength == -1 || contentLength != writtenContentLength)
									resp.setContentLength(writtenContentLength);
							} catch (IllegalStateException e) { // can occur if the response output is already open as a Writer
								Writer writer = resp.getWriter();
								writeResourceToWriter(is, writer);
								// Since ContentLength is a measure of the number of bytes contained in the body
								// of a message when we use a Writer we lose control of the exact byte count and
								// defer the problem to the Servlet Engine's Writer implementation.
							}
						} catch (FileNotFoundException e) {
							// FileNotFoundException may indicate the following scenarios
							// - url is a directory
							// - url is not accessible
							sendError(resp, HttpServletResponse.SC_FORBIDDEN);
						} catch (SecurityException e) {
							// SecurityException may indicate the following scenarios
							// - url is not accessible
							sendError(resp, HttpServletResponse.SC_FORBIDDEN);
						} finally {
							if (is != null)
								try {
									is.close();
								} catch (IOException e) {
									// ignore
								}
						}
					}
					return Boolean.TRUE;
				}
			}, acc);
		} catch (PrivilegedActionException e) {
			throw (IOException) e.getException();
		}
	}

	void sendError(final HttpServletResponse resp, int sc) throws IOException {

		try {
			// we need to reset headers for 302 and 403
			resp.reset();
			resp.sendError(sc);
		} catch (IllegalStateException e) {
			// this could happen if the response has already been committed
		}
	}

	int writeResourceToOutputStream(InputStream is, OutputStream os) throws IOException {
		byte[] buffer = new byte[8192];
		int bytesRead = is.read(buffer);
		int writtenContentLength = 0;
		while (bytesRead != -1) {
			os.write(buffer, 0, bytesRead);
			writtenContentLength += bytesRead;
			bytesRead = is.read(buffer);
		}
		return writtenContentLength;
	}

	void writeResourceToWriter(InputStream is, Writer writer) throws IOException {
		Reader reader = new InputStreamReader(is);
		try {
			char[] buffer = new char[8192];
			int charsRead = reader.read(buffer);
			while (charsRead != -1) {
				writer.write(buffer, 0, charsRead);
				charsRead = reader.read(buffer);
			}
		} finally {
			if (reader != null) {
				reader.close(); // will also close input stream
			}
		}
	}
}
