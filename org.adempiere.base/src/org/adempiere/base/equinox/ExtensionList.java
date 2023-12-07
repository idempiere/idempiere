/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.adempiere.base.equinox;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.NavigableSet;
import java.util.TreeMap;

import org.adempiere.base.ServiceQuery;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IConfigurationElement;
import org.eclipse.core.runtime.Platform;

/**
 * This List looks up services as extensions in equinox.<br/>
 * The extension point must be the class name of the service interface. <br/>
 * The query attributes are checked against the attributes
 * of the extension configuration element.
 * <p>
 * In order to minimize equinox lookups, a filtering iterator is used.
 * @author viola
 *
 * @param <T> The service this list holds implementations of.
 */
public class ExtensionList<T> implements Iterable<T>{

	/**
	 * Iterator implementation for Equinox extension 
	 * @param <E>
	 */
	public class ExtensionIterator<E extends T> implements Iterator<T> {

		private int index = 0;

		@Override
		public boolean hasNext() {
			iterateUntilAccepted();
			return index<elements.length;
		}

		/**
		 * Increment {@link #index} until we found the next matching element
		 */
		private void iterateUntilAccepted() {
			while (index<elements.length) {
				if (accept(elements[index]))
					break;
				index++;
			}
		}

		/**
		 * @param element
		 * @return true if current element match extension id or filter parameter
		 */
		private boolean accept(IConfigurationElement element) {
			if (extensionId != null) {
				String id = element.getDeclaringExtension().getUniqueIdentifier();
				if (!extensionId.equals(id))
					return false;
			}
			for (String name : filters.keySet()) {
				String expected = filters.get(name);
				String actual = element.getAttribute(name);
				if (!expected.equals(actual))
					return false;
			}
			return true;
		}

		@SuppressWarnings("unchecked")
		@Override
		public E next() {
			iterateUntilAccepted();
			IConfigurationElement e = elements[index++];
			if (e.getAttribute("class") == null) {
				IConfigurationElement[] childs = e.getChildren();
				if (childs != null && childs.length > 0) {
					for(IConfigurationElement child : childs) {
						if (child.getAttribute("class") != null) {
							e = child;
							break;
						}
					}
				}
			}
			try {
				return (E) e.createExecutableExtension("class");
			} catch (CoreException ex) {
				throw new IllegalStateException(ex);
			}
		}

		/**
		 * Not supported, will throw exception.
		 */
		@Override
		public void remove() {
			throw new UnsupportedOperationException();
		}

	}

	private IConfigurationElement[] elements;
	private HashMap<String, String> filters = new HashMap<String, String>();
	private String extensionId;

	/**
	 * @param clazz
	 * @param extensionPointId
	 */
	public ExtensionList(Class<T> clazz, String extensionPointId) {
		if (extensionPointId == null)
			extensionPointId = clazz.getName();
		
		try {
			elements = Platform.getExtensionRegistry().getConfigurationElementsFor(extensionPointId);
			if (elements != null && elements.length > 1) {
				elements = sort(elements);
			}
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}

	/**
	 * @param type
	 * @param extensionPointId
	 * @param extensionId
	 * @param query
	 */
	public ExtensionList(Class<T> type, String extensionPointId, String extensionId, ServiceQuery query) {
		this(type, extensionPointId);
		this.extensionId = extensionId;
		if (query != null) {
			for (String key : query.keySet()) {
				addFilter(key, query.get(key));
			}
		}
	}
	
	/**
	 * Sort by extension priority (if defined in extensions-priorty.properties).
	 * @param elementArray
	 * @return sorted elementArray
	 */
	private IConfigurationElement[] sort(IConfigurationElement[] elementArray) {
		IConfigurationElement[] result = elementArray;
		TreeMap<Integer, List<IConfigurationElement>> elementMap = new TreeMap<Integer, List<IConfigurationElement>>();
		List<IConfigurationElement> elementList = new ArrayList<IConfigurationElement>();
		for(IConfigurationElement element : elementArray) {
			int priority = ExtensionPriorityManager.getInstance().getPriority(element);
			if (priority > 0) {
				List<IConfigurationElement> list = elementMap.get(priority);
				if (list == null) {
					list = new ArrayList<IConfigurationElement>();
					elementMap.put(priority, list);
				}
				list.add(element);
			} else {
				elementList.add(element);
			}
		}
		if (!elementMap.isEmpty()) {
			result = new IConfigurationElement[elementArray.length];
			NavigableSet<Integer> keySet = elementMap.descendingKeySet();
			int i = 0;
			for(Integer key : keySet) {
				List<IConfigurationElement> list= elementMap.get(key);
				for(IConfigurationElement element : list) {
					result[i] = element;
					i++;
				}
			}
			for(IConfigurationElement element : elementList) {
				result[i] = element;
				i++;
			}
		}
		return result;
	}

	/**
	 * @return Iterator 
	 */
	public Iterator<T> iterator() {
		return new ExtensionIterator<T>();
	}

	/**
	 * add filter for discovery of extensions 
	 * @param attribute
	 * @param value
	 */
	public void addFilter(String attribute, String value) {
		filters.put(attribute, value);
	}

	/**
	 * @return first matching extension
	 */
	public T first() {
		Iterator<T> i = iterator();
		if (!i.hasNext())
			return null;
		return i.next();
	}

	/**
	 * @return list of matching extension
	 */
	public List<T> asList() {
		List<T> result = new ArrayList<T>();
		for (T t : this) {
			result.add(t);
		}
		return result;
	}

}
