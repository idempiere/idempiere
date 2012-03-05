/* ClassLocator.java

	Purpose:
		
	Description:
		
	History:
		Tue Aug 30 09:56:06     2005, Created by tomyeh

Copyright (C) 2005 Potix Corporation. All Rights Reserved.

{{IS_RIGHT
	This program is distributed under LGPL Version 2.1 in the hope that
	it will be useful, but WITHOUT ANY WARRANTY.
}}IS_RIGHT
*/
package org.zkoss.util.resource;

import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.LinkedList;
import java.util.List;
import java.util.Collections;
import java.util.Iterator;
import java.io.InputStream;
import java.io.IOException;
import java.net.URL;

import org.zkoss.util.CollectionsX;
import org.zkoss.util.logging.Log;
import org.zkoss.zk.library.Activator;
import org.zkoss.idom.Document;
import org.zkoss.idom.Element;
import org.zkoss.idom.util.IDOMs;
import org.zkoss.idom.input.SAXBuilder;

/**
 * The locator searches the current thread's context class loader,
 * and then this class's class loader.
 *
 * <p>It is important to use this locator if you want to load something
 * in other jar files.
 *
 * <p>Since this locator is used frequently, {@link Locators#getDefault}
 * is provided to return an instance of this class,
 *
 * @author tomyeh
 */
public class ClassLocator implements XMLResourcesLocator {
	private static final Log log = Log.lookup(ClassLocator.class);

	public ClassLocator() {
	}

	//XMLResourcesLocator//
	public Enumeration<URL> getResources(String name) throws IOException {
		name = resolveName(name);
		if (Activator.getContext() != null) {
			final Enumeration<URL> en = Activator.getContext().getBundle().getResources(name);
			if (en != null && en.hasMoreElements()) return en;
		}
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		if (cl != null) {
			final Enumeration<URL> en = cl.getResources(name);
			if (en.hasMoreElements()) return en;
		}
		cl = ClassLocator.class.getClassLoader();
		if (cl != null) {
			final Enumeration<URL> en = cl.getResources(name);
			if (en.hasMoreElements()) return en;
		}
		return ClassLoader.getSystemResources(name);
	}
	public List<Resource> getDependentXMLResources(String name, String elName,
	String elDepends) throws IOException {
		final Map<String, XMLResource> rcmap = new LinkedHashMap<String, XMLResource>();
		for (Enumeration<URL> en = getResources(name); en.hasMoreElements();) {
			final URL url = en.nextElement();
			final XMLResource xr = new XMLResource(url, elName, elDepends);
			final XMLResource old = rcmap.put(xr.name, xr);
			if (old != null)
				log.warning("Replicate resource: "+xr.name
					+"\nOverwrite "+old.url+"\nwith "+xr.url);
			//it is possible if zcommon.jar is placed in both
			//WEB-INF/lib and shared/lib, i.e., appear twice in the class path
			//We overwrite because the order is the parent class loader first
			//so WEB-INF/lib is placed after
		}
//		if (rcmap.isEmpty() && log.debugable()) log.debug("No resouce is found for "+name);

		final List<Resource> rcs = new LinkedList<Resource>(); //a list of Document
		final Set<String> resolving = new LinkedHashSet<String>();
			//a set of names used to prevent dead-loop
		while (!rcmap.isEmpty()) {
			final Iterator<XMLResource> it = rcmap.values().iterator();
			final XMLResource xr = it.next();
			it.remove();
			resolveDependency(xr, rcs, rcmap, resolving);
			assert resolving.isEmpty();
		}
		return rcs;
	}
	private static void resolveDependency(XMLResource xr,
	List<Resource> rcs, Map<String, XMLResource> rcmap, Set<String> resolving) {
		if (!resolving.add(xr.name))
			throw new IllegalStateException("Recusrive reference among "+resolving);

		for (String nm: xr.depends) {
			final XMLResource dep = rcmap.remove(nm);
			if (dep != null) //not resolved yet
				resolveDependency(dep, rcs, rcmap, resolving); //recusrively
		}

		rcs.add(new Resource(xr.url, xr.document));
		resolving.remove(xr.name);

		if (log.debugable()) log.debug("Adding resolved resource: "+xr.name);
	}
	/** Info used with getDependentXMLResource. */
	private static class XMLResource {
		private final String name;
		private final URL url;
		private final Document document;
		private final List<String> depends;

		private XMLResource(URL url, String elName, String elDepends)
		throws IOException{
			if (log.debugable()) log.debug("Loading "+url);
			try {
				this.document = new SAXBuilder(false, false, true).build(url);
			} catch (Exception ex) {
				if (ex instanceof IOException) throw (IOException)ex;
				if (ex instanceof RuntimeException) throw (RuntimeException)ex;
				final IOException ioex = new IOException("Unable to load "+url);
				ioex.initCause(ex);
				throw ioex;
			}

			this.url = url;
			final Element root = this.document.getRootElement();
			this.name = IDOMs.getRequiredElementValue(root, elName);
			final String deps = root.getElementValue(elDepends, true);
			if (deps == null || deps.length() == 0) {
				this.depends = Collections.emptyList();
			} else {
				this.depends = new LinkedList<String>();
				CollectionsX.parse(this.depends, deps, ',');
				if (log.finerable()) log.finer(this.name+" depends on "+this.depends);
			}
		}
		public String toString() {
			return "["+name+": "+url+" depends on "+depends+']';
		}
	};

	//-- Locator --//
	/** Always returns null.
	 */
	public String getDirectory() {
		return null;
	}
	public URL getResource(String name) {
		if (Activator.getContext() != null) {
			final URL url = Activator.getContext().getBundle().getResource(name);
			if (url != null) return url;
		}
		final ClassLoader cl = Thread.currentThread().getContextClassLoader();
		final URL url = cl != null ? cl.getResource(resolveName(name)): null;
		return url != null ? url: ClassLocator.class.getResource(name);
	}
	public InputStream getResourceAsStream(String name) {
		final ClassLoader cl = Thread.currentThread().getContextClassLoader();
		final InputStream is =
			cl != null ? cl.getResourceAsStream(resolveName(name)): null;
		return is != null ? is: ClassLocator.class.getResourceAsStream(name);
	}
	private static String resolveName(String name) {
		return name != null && name.startsWith("/") ?
			name.substring(1): name;
	}

	//-- Object --//
	public int hashCode() {
		return 1123;
	}
	public boolean equals(Object o) {
		if (this == o) return true;
		return o instanceof ClassLocator;
	}
}
