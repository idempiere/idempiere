/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.base.equinox;

import java.util.List;

import org.adempiere.base.IServiceHolder;
import org.adempiere.base.IServicesHolder;

/**
 * @author hengsin
 *
 */
public class EquinoxServiceHolder<T> implements IServiceHolder<T>, IServicesHolder<T> {

	private ExtensionList<T> extensionList;

	/**
	 * @param list
	 */
	public EquinoxServiceHolder(ExtensionList<T> list) {
		extensionList = list;
	}

	@Override
	public T getService() {
		return extensionList.first();
	}

	@Override
	public List<T> getServices() {
		return extensionList.asList();
	}

}
