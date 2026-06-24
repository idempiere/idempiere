/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 **********************************************************************/
package org.idempiere.ui.zk.field;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.adempiere.webui.editor.WEditor;
import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Deactivate;
import org.osgi.service.component.annotations.Reference;
import org.osgi.service.component.annotations.ReferenceCardinality;
import org.osgi.service.component.annotations.ReferencePolicy;

/**
 * OSGi component provider for WEditor.DynamicDisplayListener services.
 * Matches listeners based on the AD_Field_UU service property.
 * 
 * @author Antigravity
 * @author hengsin
 */
@Component(immediate = true, service = {FieldDynamicDisplayListenerProvider.class})
public class FieldDynamicDisplayListenerProvider {

	private static volatile FieldDynamicDisplayListenerProvider instance;

	private final Map<String, List<WEditor.DynamicDisplayListener>> listeners = new ConcurrentHashMap<>();

	@Activate
	public void activate() {
		instance = this;
	}
  
	@Deactivate
	public void deactivate() {
		listeners.clear();
		instance = null;
	}

	/**
	 * Bind dynamic display listener
	 * @param listener
	 * @param properties
	 */
	@Reference(
		service = WEditor.DynamicDisplayListener.class,
		cardinality = ReferenceCardinality.MULTIPLE,
		policy = ReferencePolicy.DYNAMIC,
		unbind = "unbindDynamicDisplayListener"
	)
	public synchronized void bindDynamicDisplayListener(WEditor.DynamicDisplayListener listener, Map<String, Object> properties) {
		if (listener == null || properties == null)
			return;

		Object val = properties.get("AD_Field_UU");
		if (val instanceof String str) {
			String uu = str.trim();
			if (!uu.isEmpty()) {
				List<WEditor.DynamicDisplayListener> list = listeners.computeIfAbsent(uu, k -> new CopyOnWriteArrayList<>());
				if (!list.contains(listener)) {
					list.add(listener);
				}
			}
		}
	}

	/**
	 * Unbind dynamic display listener
	 * @param listener
	 */
	public synchronized void unbindDynamicDisplayListener(WEditor.DynamicDisplayListener listener) {
		if (listener == null)
			return;

		String keyToRemove = null;
		for (Map.Entry<String, List<WEditor.DynamicDisplayListener>> entry : listeners.entrySet()) {
			if (entry.getValue().remove(listener)) {
				if (entry.getValue().isEmpty()) {
					keyToRemove = entry.getKey();
				}
				break;
			}
		}

		if (keyToRemove != null) {
			listeners.remove(keyToRemove);
		}
	}

	/**
	 * Get dynamic display listeners for field UUID
	 * @param adFieldUU field UUID
	 * @return array of dynamic display listeners, or empty array if none
	 */
	public static WEditor.DynamicDisplayListener[] getListeners(String adFieldUU) {
		FieldDynamicDisplayListenerProvider provider = instance;
		if (provider == null || adFieldUU == null)
			return new WEditor.DynamicDisplayListener[0];
		
		List<WEditor.DynamicDisplayListener> list = provider.listeners.get(adFieldUU);
		if (list == null) {
			return new WEditor.DynamicDisplayListener[0];
		}
		return list.toArray(new WEditor.DynamicDisplayListener[0]);
	}
}
