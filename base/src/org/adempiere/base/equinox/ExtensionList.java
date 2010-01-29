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

import java.util.Iterator;

import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IConfigurationElement;
import org.eclipse.core.runtime.Platform;

public class ExtensionList<T> implements Iterable<T>{

	public class ExtensionIterator<T> implements Iterator<T> {

		private int index = 0;

		public boolean hasNext() {
			return index<elements.length;
		}

		@SuppressWarnings("unchecked")
		public T next() {
			IConfigurationElement e = elements[index++];
			try {
				return (T) e.createExecutableExtension("class");
			} catch (CoreException ex) {
				throw new IllegalStateException(ex);
			}
		}

		public void remove() {
			throw new UnsupportedOperationException();
		}

	}

	private IConfigurationElement[] elements;

	public ExtensionList(Class<T> clazz, String id) {
		try {
			elements = Platform.getExtensionRegistry().getConfigurationElementsFor(id);
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	public Iterator<T> iterator() {
		return new ExtensionIterator<T>();
	}

}
