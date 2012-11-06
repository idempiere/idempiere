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
package org.adempiere.base;

import java.util.ArrayList;
import java.util.List;

/**
 * @author hengsin
 *
 */
public class DelegatingServiceHolder<T> implements IServiceHolder<T>,
		IServicesHolder<T> {

	private List<IServiceHolder<T>> serviceHolder = new ArrayList<IServiceHolder<T>>();
	private List<IServicesHolder<T>> servicesHolder = new ArrayList<IServicesHolder<T>>();
	
	/**
	 * 
	 */
	public DelegatingServiceHolder() {
	}
	
	public void addServiceHolder(IServiceHolder<T> holder) {
		serviceHolder.add(holder);
	}

	public void addServicesHolder(IServicesHolder<T> holder) {
		servicesHolder.add(holder);
	}
	
	@Override
	public List<T> getServices() {
		List<T> list = new ArrayList<T>();
		for(IServicesHolder<T> holder : servicesHolder) {
			List<T> t = holder.getServices();
			if (t != null && !t.isEmpty())
				list.addAll(t);
		}
		return list;
	}

	@Override
	public T getService() {
		T t = null;
		for(IServiceHolder<T> holder : serviceHolder) {
			t = holder.getService();
			if (t != null) break;
		}
		return t;
	}

}
