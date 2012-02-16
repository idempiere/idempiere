/* ClassLocator.java

{{IS_NOTE
	Purpose:
		
	Description:
		
	History:
		Tue Aug 30 09:56:06     2005, Created by tomyeh
}}IS_NOTE

Copyright (C) 2005 Potix Corporation. All Rights Reserved.

{{IS_RIGHT
	This program is distributed under GPL Version 3.0 in the hope that
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

import org.zkoss.lang.D;
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
 * <p>Besides {@link Locator}, it also provides additional methods,
 * such as {@link #getResources}.
 *
 * <p>Since this locator is used frequently, {@link Locators#getDefault}
 * is provided to return an instance of this class,
 *
 * @author tomyeh
 */
public class ClassLocator implements Locator {
	private static final Log log = Log.lookup(ClassLocator.class);

	public ClassLocator() {
	}

	/** Returns an enumeration of resources.
	 * Unlike {@link #getDependentXMLResources}, it doesn't resolve the dependence
	 * among the resouces.
	 *
	 * @param name the resouce name, such as "metainfo/i3-com.xml".
	 */
	public Enumeration getResources(String name) throws IOException {
		name = resolveName(name);
		if (Activator.getContext() != null) {
			final Enumeration en = Activator.getContext().getBundle().getResources(name);
			if (en != null && en.hasMoreElements()) return en;
		}
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		if (cl != null) {
			final Enumeration en = cl.getResources(name);
			if (en.hasMoreElements()) return en;
		}
		cl = ClassLocator.class.getClassLoader();
		if (cl != null) {
			final Enumeration en = cl.getResources(name);
			if (en.hasMoreElements()) return en;
		}
		return ClassLoader.getSystemResources(name);
	}
	/** Returns a list of resources ({@link Resource}) after resolving
	 * the dependence.
	 * The resource is returned in the format of {@link Resource}
	 *
	 * <p>To resolve the dependence, it assumes each resource has two
	 * element whose name is identified by elName and elDepends.
	 * The elName element specifies the unique name of each resource.
	 * The elDepends element specifies a list of names of resources
	 * that this resource depends on. If not found, it assumes it could
	 * be loaded first.
	 *
	 * @param name the resouce name, such as "metainfo/i3-comp.xml".
	 * @param elName the element used to specify the name.
	 * @param elDepends the element used to specify the dependence.
	 * @return a list of {@link Resource} of the specified name.
	 */
	public List getDependentXMLResources(String name, String elName,
	String elDepends) throws IOException {
		final Map rcmap = new LinkedHashMap();
		for (Enumeration en = getResources(name); en.hasMoreElements();) {
			final URL url = (URL)en.nextElement();
			final XMLResource xr = new XMLResource(url, elName, elDepends);
			final XMLResource old = (XMLResource)rcmap.put(xr.name, xr);
			if (old != null)
				log.warning("Replicate resource: "+xr.name
					+"\nOverwrite "+old.url+"\nwith "+xr.url);
			//it is possible if zcommon.jar is placed in both
			//WEB-INF/lib and shared/lib, i.e., appear twice in the class path
			//We overwrite because the order is the parent class loader first
			//so WEB-INF/lib is placed after
		}
		if (D.ON && rcmap.isEmpty() && log.debugable()) log.debug("No resouce is found for "+name);

		final List rcs = new LinkedList(); //a list of Document
		final Set resolving = new LinkedHashSet();
			//a set of names used to prevent dead-loop
		while (!rcmap.isEmpty()) {
			final Iterator it = rcmap.values().iterator();
			final XMLResource xr = (XMLResource)it.next();
			it.remove();
			resolveDependency(xr, rcs, rcmap, resolving);
			assert D.OFF || resolving.isEmpty();
		}
		return rcs;
	}
	private static
	void resolveDependency(XMLResource xr, List rcs, Map rcmap, Set resolving) {
		if (!resolving.add(xr.name))
			throw new IllegalStateException("Recusrive reference among "+resolving);

		for (Iterator it = xr.depends.iterator(); it.hasNext();) {
			final String nm = (String)it.next();
			final XMLResource dep = (XMLResource)rcmap.remove(nm);
			if (dep != null) //not resolved yet
				resolveDependency(dep, rcs, rcmap, resolving); //recusrively
		}

		rcs.add(new Resource(xr.url, xr.document));
		resolving.remove(xr.name);

		if (D.ON && log.debugable()) log.debug("Adding resolved resource: "+xr.name);
	}
	/** Info used with getDependentXMLResource. */
	private static class XMLResource {
		private final String name;
		private final URL url;
		private final Document document;
		private final List depends;
		private XMLResource(URL url, String elName, String elDepends)
		throws IOException{
			if (D.ON && log.debugable()) log.debug("Loading "+url);
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
				this.depends = Collections.EMPTY_LIST;
			} else {
				this.depends = new LinkedList();
				CollectionsX.parse(this.depends, deps, ',');
				if (D.ON && log.finerable()) log.finer(this.name+" depends on "+this.depends);
			}
		}
		public String toString() {
			return "["+name+": "+url+" depends on "+depends+']';
		}
	};

	/** An item of the list returned by {@link ClassLocator#getDependentXMLResources}.
	 */
	public static class Resource {
		/** The URL of the resource. */
		public final URL url;
		/** The content of the resource. */
		public final Document document;
		private Resource(URL url, Document document) {
			this.url = url;
			this.document = document;
		}
		public String toString() {
			return "[res: " + url + ']';
		}
	}

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
		return o instanceof ClassLocator;
	}
}
