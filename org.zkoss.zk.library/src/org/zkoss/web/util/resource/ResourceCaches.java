/* ResourceCaches.java

	Purpose:
		
	Description:
		
	History:
		Tue Aug 30 18:31:05     2005, Created by tomyeh

Copyright (C) 2005 Potix Corporation. All Rights Reserved.

{{IS_RIGHT
	This program is distributed under LGPL Version 2.1 in the hope that
	it will be useful, but WITHOUT ANY WARRANTY.
}}IS_RIGHT
*/
package org.zkoss.web.util.resource;

import java.io.File;
import java.io.IOException;
import java.net.URL;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.zkoss.lang.SystemException;
import org.zkoss.web.servlet.Servlets;

/**
 * Utilities to load (and parse) the Servlet resource.
 * Notice that {@link ResourceCache} and {@link ResourceLoader}
 * must be used rather than
 * {@link org.zkoss.util.resource.ResourceCache}
 * and {@link org.zkoss.util.resource.Loader}.
 *
 * <p>Usage:
 * <ol>
 * <li>Implements a loader by extending from {@link ResourceLoader}.</li>
 * <li>Creates a resource cache ({@link ResourceCache})
 * by use of the loader in the previous step.</li>
 * <li>Invoke {@link #get} to load the resource.</li>
 * </ol>
 *
 * @author tomyeh
 */
public class ResourceCaches {
	private static final Logger log = LoggerFactory.getLogger(ResourceCaches.class);

	/** Loads, parses and returns the resource of the specified URI,
	 * or null if not found. The parser is defined by the loader defined
	 * in {@link ResourceCache}.
	 *
	 * @param cache the resource cache.
	 * Note: its loader must extend from {@link ResourceLoader}.
	 * @param path the URI path
	 * @param extra the extra parameter that will be passed to
	 * {@link ResourceLoader#parse(String,File,Object)} and
	 * {@link ResourceLoader#parse(String,URL,Object)}
	 */
	public static final <V>
	V get(ResourceCache<V> cache, ServletContext ctx, String path, Object extra) {
	//20050905: Tom Yeh
	//We don't need to handle the default name if user specifies only a dir
	//because it is handled by the container directly
	//And, web  developer has to specify <welcome-file> in web.xml
		URL url = null;
		if (path == null || path.length() == 0) path = "/";
		else if (path.charAt(0) != '/') {
			if (path.indexOf("://") > 0) {
				try {
					url = new URL(path);
				} catch (java.net.MalformedURLException ex) {
					throw new SystemException(ex);
				}
			}else path = '/' + path;
		}

		if (url == null) {
			if (path.startsWith("/~")) {
				final ServletContext ctx0 = ctx;
				final String path0 = path;
				final int j = path.indexOf('/', 2);
				final String ctxpath;
				if (j >= 0) {
					ctxpath = "/" + path.substring(2, j);
					path = path.substring(j);
				} else {
					ctxpath = "/" + path.substring(2);
					path = "/";
				}

				final ExtendletContext extctx =
					Servlets.getExtendletContext(ctx, ctxpath.substring(1));
				if (extctx != null) {
					url = extctx.getResource(path);
//					if (log.isDebugEnabled()) log.debug("Resolving "+path0+" to "+url);
					if (url == null)
						return null;
					try {
						return cache.get(new ResourceInfo(path, url, extra));
					} catch (Throwable ex) {
						final IOException ioex = getIOException(ex);
						if (ioex == null)
							throw SystemException.Aide.wrap(ex);
						log.warn("Unable to load "+url, ioex);
					}
					return null;
				}

				ctx = ctx.getContext(ctxpath);
				if (ctx == null) { //failed
//					if (log.isDebugEnabled()) log.debug("Context not found: "+ctxpath);
					ctx = ctx0; path = path0;//restore
				}
			}

			final String flnm = ctx.getRealPath(path);
			if (flnm != null) {
				File file = new File(flnm);
				if (file.exists()) {
					try {
						return cache.get(new ResourceInfo(path, file, extra));
							//it is loader's job to check the existence
					} catch (Throwable ex) {
						final IOException ioex = getIOException(ex);
						if (ioex == null)
							throw SystemException.Aide.wrap(ex);
						log.warn("Unable to load "+flnm, ioex);
					}
					return null;
				}
			}
		}

		//try url because some server uses JAR format
		try {
			if (url == null)
				url = ctx.getResource(path);
			if (url != null)
				return cache.get(new ResourceInfo(path, url, extra));
		} catch (Throwable ex) {
			final IOException ioex = getIOException(ex);
			if (ioex == null)
				throw SystemException.Aide.wrap(ex);
			log.warn("Unable to load "+path, ioex);
		}
		return null;
	}
	//don't eat exceptions other than IOException
	private static IOException getIOException(Throwable ex) {
		for (; ex != null; ex = ex.getCause())
			if (ex instanceof IOException)
				return (IOException)ex;
		return null;
	}
}
