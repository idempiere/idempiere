/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2007 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2007 Low Heng Sin hengsin@avantz.com
 * _____________________________________________
 *****************************************************************************/
package org.adempiere.webui;

import java.io.Serializable;
import java.util.TimeZone;

import org.adempiere.webui.session.SessionManager;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.sys.ComponentCtrl;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class ClientInfo implements Serializable {	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2686811277627911861L;
	
	public int colorDepth;
	public int desktopWidth;
	public int desktopHeight;
	public int desktopXOffset;
	public int desktopYOffset;
	public int screenHeight;
	public int screenWidth;
	public String orientation;
	public TimeZone timeZone;
	public String userAgent;
	public boolean tablet;
	public double devicePixelRatio;
	
	public static final int LARGE_WIDTH = 1200;
	public static final int MEDIUM_WIDTH = 1000;
	public static final int SMALL_WIDTH = 700;
	public static final int EXTRA_SMALL_WIDTH = 500;
	
	public static final int LARGE_HEIGHT = 1000;
	public static final int MEDIUM_HEIGHT = 700;
	public static final int SMALL_HEIGHT = 500;
	public static final int EXTRA_SMALL_HEIGHT = 360;
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User Agent: ")
			.append(userAgent)
			.append("\r\n")
			.append("Time Zone: ")
			.append(timeZone.getID())
			.append("\r\n")
			.append("Screen Size: ")
			.append(screenWidth)
			.append(" x ")
			.append(screenHeight)
			.append("\r\n")
			.append("Browser Desktop Size: ")
			.append(desktopWidth)
			.append(" x ")
			.append(desktopHeight)
			.append("\r\n")
			.append("Orientation: ")
			.append(orientation)
			.append("\r\n")
			.append("Color Depth: ")
			.append(colorDepth)
			.append("\r\n")
			.append("Pixel Ratio: ")
			.append(devicePixelRatio);
		
		return builder.toString();
	}

	/**
	 * @return true if mobile browser
	 */
	public static boolean isMobile() {
		return "Y".equals(Env.getContext(Env.getCtx(), Env.CLIENT_INFO_MOBILE));
	}

	/**
	 * 
	 * @param version null to match all version
	 * @return true if browser is firefox and match the pass in version parameter
	 */
	public static boolean isFirefox(String version) {
		StringBuilder ua = new StringBuilder("Firefox");
		if (!Util.isEmpty(version, true))
			ua.append("/").append(version);
		return get() != null && get().userAgent != null && get().userAgent.contains(ua.toString());
	}
	
	/**
	 * @return the current clientinfo instance
	 */
	public static ClientInfo get() {
		return SessionManager.getSessionApplication().getClientInfo();
	}
	
	/**
	 * 
	 * @param minWidth
	 * @return true if desktopWidth &gt;= minWidth
	 */
	public static boolean minWidth(int minWidth) {
		return ClientInfo.get().desktopWidth > 0 && ClientInfo.get().desktopWidth >= minWidth;
	}
	
	/**
	 * 
	 * @param maxWidth
	 * @return true if desktopWidth &lt;= maxWidth
	 */
	public static boolean maxWidth(int maxWidth) {
		return ClientInfo.get().desktopWidth > 0 && ClientInfo.get().desktopWidth <= maxWidth;
	}	
	
	/**
	 * 
	 * @param minHeight
	 * @return true if desktopHeight &gt;= minHeight
	 */
	public static boolean minHeight(int minHeight) {
		return ClientInfo.get().desktopHeight > 0 && ClientInfo.get().desktopHeight >= minHeight;
	}
	
	/**
	 * 
	 * @param maxHeight
	 * @return true if desktopHeight &lt;= maxHeight
	 */
	public static boolean maxHeight(int maxHeight) {
		return ClientInfo.get().desktopHeight > 0 && ClientInfo.get().desktopHeight <= maxHeight;
	}

	private static String AFTER_PAGE_DETACHED = "afterPageDetached";
	
	/**
	 * Call runnable on client info update
	 * @param component
	 * @param runnable
	 */
	public static void onClientInfo(Component component, Runnable runnable) {
		ComponentCtrl ctrl = (ComponentCtrl) component;		
		EventListener<Event> eventListener = evt -> runnable.run();
		
		Component root = SessionManager.getAppDesktop().getComponent().getRoot();
		root.addEventListener(Events.ON_CLIENT_INFO, eventListener);
		ctrl.addCallback(AFTER_PAGE_DETACHED, t -> root.removeEventListener(Events.ON_CLIENT_INFO, eventListener));
	}
	
	/**
	 * @return true if screen orientation is portrait, false otherwise
	 */
	public boolean isPortrait() {
		return "portrait".equalsIgnoreCase(orientation);
	}
}
