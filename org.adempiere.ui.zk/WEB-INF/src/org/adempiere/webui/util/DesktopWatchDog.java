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
 *                                                                     *
 * Contributors:                                                       *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.util;

import java.util.Iterator;
import java.util.concurrent.ConcurrentLinkedDeque;
import java.util.concurrent.TimeUnit;

import org.compiere.Adempiere;
import org.compiere.util.CLogger;
import org.idempiere.ui.zk.DelegatingServerPush;
import org.idempiere.ui.zk.websocket.WebSocketServerPush;
import org.zkoss.zk.ui.Desktop;
import org.zkoss.zk.ui.Session;
import org.zkoss.zk.ui.WebApp;
import org.zkoss.zk.ui.sys.DesktopCache;
import org.zkoss.zk.ui.sys.DesktopCtrl;
import org.zkoss.zk.ui.sys.ServerPush;
import org.zkoss.zk.ui.sys.WebAppCtrl;

import fi.jawsy.jawwa.zk.atmosphere.AtmosphereServerPush;

/**
 * Watch for disconnected desktop and destroy it
 * @author hengsin
 */
public class DesktopWatchDog {

	/** Logger */
	protected static CLogger log = CLogger.getCLogger(DesktopWatchDog.class);

	/** singleton instance **/
	private final static DesktopWatchDog INSTANCE = new DesktopWatchDog();
	
	/** Desktops being watched **/
	private final ConcurrentLinkedDeque<DesktopEntry> desktops = new ConcurrentLinkedDeque<DesktopWatchDog.DesktopEntry>();
	
	/**
	 * default constructor
	 */
	private DesktopWatchDog() {
		//Check disconnected desktop every 40 seconds
		Adempiere.getThreadPoolExecutor().scheduleWithFixedDelay(() -> {
			doMonitoring();
		}, 60, 40, TimeUnit.SECONDS);
	}

	/**
	 * Check each entries in {@link #desktops}.
	 */
	private void doMonitoring() {
		Iterator<DesktopEntry> iterator = desktops.iterator();
		while (iterator.hasNext()) {
			DesktopEntry entry = iterator.next();
			//not active, remove from watch list
			if (!entry.desktop.isAlive()) {
				iterator.remove();
				continue;
			}
			if (entry.desktop.isServerPushEnabled() == false) {
				entry.noMessageCount++;
			} else {
				ServerPush spush = ((DesktopCtrl)entry.desktop).getServerPush();
				if (spush == null) {
					entry.noMessageCount++;
				} else {
					if (spush instanceof DelegatingServerPush)
						spush = ((DelegatingServerPush) spush).getDelegate();
					if (spush instanceof WebSocketServerPush) {
						var endPoint = WebSocketServerPush.getEndPoint(entry.desktop.getId());
						if (endPoint == null || !endPoint.getAndResetMessageIndicator())
							entry.noMessageCount++;
						else
							entry.noMessageCount=0;
					} else if (spush instanceof AtmosphereServerPush) {
						AtmosphereServerPush asp = (AtmosphereServerPush) spush;
						if (!asp.hasAtmosphereResource())
							entry.noMessageCount++;
						else
							entry.noMessageCount=0;
					} else {
						// Unknown implementation - log warning and increment counter for eventual cleanup
						if (entry.noMessageCount == 0 || (entry.noMessageCount == 1 && entry.desktop.isServerPushEnabled()))
							log.warning("Unknown ServerPush implementation: " + spush.getClass().getName());
						entry.noMessageCount++;
					}
				}
			}
			if (entry.noMessageCount >= 5) {
				//no message from desktop for 5 consecutive run of doMonitoring.
				//remove desktop from DesktopCache.
				iterator.remove();
		        try {
		        	final WebApp wapp = entry.desktop.getWebApp();
		        	final Session session = entry.desktop.getSession();
		    	    final DesktopCache desktopCache = ((WebAppCtrl) wapp).getDesktopCache(session);
		    		desktopCache.removeDesktop(entry.desktop);
		    	} catch (Throwable t) {
		    		t.printStackTrace();
		    	}
			}
		}
	}

	private final static class DesktopEntry {		
		Desktop desktop;
		int noMessageCount = 0;
		
		private DesktopEntry(Desktop desktop) {
			this.desktop = desktop;
		}
	}
	
	/**
	 * Add desktop to watch list
	 * @param desktop
	 */
	public static void addDesktop(Desktop desktop) {
		INSTANCE.desktops.add(new DesktopEntry(desktop));
	}
	
	/**
	 * Remove desktop from watch list
	 * @param desktop
	 */
	public static void removeDesktop(Desktop desktop) {
		Iterator<DesktopEntry> iterator = INSTANCE.desktops.iterator();
		while (iterator.hasNext()) {
			DesktopEntry entry = iterator.next();
			if (entry.desktop == desktop) {
				iterator.remove();
				break;
			}
		}
	}
	
	/**
	 * Remove other desktops that share the same session with the pass in desktop parameter
	 * @param desktop
	 */
	public static void removeOtherDesktopsInSession(Desktop desktop) {
		Iterator<DesktopEntry> iterator = INSTANCE.desktops.iterator();
		while (iterator.hasNext()) {
			DesktopEntry entry = iterator.next();
			if (entry.desktop == desktop)
				continue;
			if (entry.desktop.getSession() != desktop.getSession())
				continue;
			
			iterator.remove();
	        try {
	        	final WebApp wapp = desktop.getWebApp();
	        	final Session session = desktop.getSession();
	    	    final DesktopCache desktopCache = ((WebAppCtrl) wapp).getDesktopCache(session);
	    		desktopCache.removeDesktop(entry.desktop);
	    	} catch (Throwable t) {
	    		t.printStackTrace();
	    	}
		}
	}
}
