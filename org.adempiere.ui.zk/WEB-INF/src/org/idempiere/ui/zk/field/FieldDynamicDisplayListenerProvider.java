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

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.adempiere.webui.editor.WEditor;
import org.osgi.service.component.annotations.Component;
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

	private static final Map<String, List<WEditor.DynamicDisplayListener>> s_listeners = new ConcurrentHashMap<>();

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
		if (val instanceof String) {
			String uu = (String) val;
			if (!uu.trim().isEmpty()) {
				List<WEditor.DynamicDisplayListener> list = s_listeners.computeIfAbsent(uu, k -> new CopyOnWriteArrayList<>());
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

		for (Map.Entry<String, List<WEditor.DynamicDisplayListener>> entry : s_listeners.entrySet()) {
			if (entry.getValue().remove(listener)) {
				if (entry.getValue().isEmpty()) {
					s_listeners.remove(entry.getKey());
				}
				break;
			}
		}
	}

	/**
	 * Get dynamic display listeners for field UUID
	 * @param adFieldUU field UUID
	 * @return list of dynamic display listeners, or empty list if none
	 */
	public static List<WEditor.DynamicDisplayListener> getListeners(String adFieldUU) {
		if (adFieldUU == null)
			return Collections.emptyList();
		List<WEditor.DynamicDisplayListener> list = s_listeners.get(adFieldUU);
		if (list == null) {
			return Collections.emptyList();
		}
		return list;
	}
}
