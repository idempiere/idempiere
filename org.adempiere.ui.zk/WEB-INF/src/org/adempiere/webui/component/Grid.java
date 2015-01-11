/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
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
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.component;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.zkoss.zk.ui.IdSpace;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class Grid extends org.zkoss.zul.Grid implements IdSpace
{
	private static final long serialVersionUID = -4483759833677794926L;
	private transient Map<String, List<EventListenerInfo>> listeners;
	
	public Grid() {
		super();
		listeners = new HashMap<String, List<EventListenerInfo>>();
	}

	public void makeNoStrip() {
    	setOddRowSclass("z-dummy");
    }

	public Rows newRows() {
		Rows rows = new Rows();
		appendChild(rows);
		
		return rows;
	}

	@Override
	public boolean addEventListener(int priority, String evtnm,
			EventListener<? extends Event> listener) {
		boolean b = super.addEventListener(priority, evtnm, listener);
		if (b) {
			final EventListenerInfo listenerInfo = new EventListenerInfo(priority, listener);
			List<EventListenerInfo> list = listeners.get(evtnm);
			if (list != null) {
				for (Iterator<EventListenerInfo> it = list.iterator(); it.hasNext();) {
					final EventListenerInfo li = it.next();
					if (li.listener.equals(listener)) {
						if (li.priority == priority)
							return false; //nothing to do
						it.remove(); //re-added later
						break;
					}
				}

				list.add(listenerInfo);
			} else {
				listeners.put(evtnm, list = new LinkedList<EventListenerInfo>());
				list.add(listenerInfo);
			}
		}
		return b;
	}

	@Override
	public boolean removeEventListener(String evtnm,
			EventListener<? extends Event> listener) {
		boolean b = super.removeEventListener(evtnm, listener);
		if (b) {
			List<EventListenerInfo> list = listeners.get(evtnm);
			if (list != null) {
				for (Iterator<EventListenerInfo> it = list.iterator(); it.hasNext();) {
					final EventListenerInfo li = it.next();
					if (li.listener.equals(listener)) {
						it.remove();
						break;
					}
				}
			}
		}
		
		return b;
	}
	
	public void copyEventListeners(Grid grid) {
		for(String evtnm : listeners.keySet()) {
			if (evtnm.equals("onInitModel"))
				continue;
			List<EventListenerInfo> list = listeners.get(evtnm);
			for(EventListenerInfo info : list) {
				grid.addEventListener(info.priority, evtnm, info.listener);
			}
		}
	}
	
	private static class EventListenerInfo {
		private final int priority;
		private final EventListener<? extends Event> listener;

		private EventListenerInfo(int priority, EventListener<? extends Event> listener) {
			this.priority = priority;
			this.listener = listener;
		}
	}
}
