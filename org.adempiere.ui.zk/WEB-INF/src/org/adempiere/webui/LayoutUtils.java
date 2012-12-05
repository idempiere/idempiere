/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin  All Rights Reserved.                      *
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
package org.adempiere.webui;

import java.io.IOException;
import java.io.StringWriter;

import org.adempiere.webui.component.Label;
import org.zkoss.zk.au.out.AuOuter;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.AbstractComponent;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Div;
import org.zkoss.zul.Window;

/**
 * 
 * @author Low Heng Sin
 *
 */
public final class LayoutUtils {

	public static final String ON_REDRAW_EVENT = "onRedraw";
	
	/**
	 * @param layout
	 */
	public static void sendDeferLayoutEvent(Borderlayout layout, int timeout) {
		StringBuilder content = new StringBuilder();		
		content.append("ad_deferRenderBorderLayout('")
			   .append(layout.getUuid())
			   .append("',").append(timeout).append(");");
		
		AuScript as = new AuScript(null, content.toString());
		Clients.response("deferRenderBorderLayout", as);		
	}
	
	/**
	 * 
	 * @param cls
	 * @param target
	 */
	public static void addSclass(String cls, HtmlBasedComponent target) {
		final String sclass = target.getSclass();
		if (!hasSclass(cls, target))
			target.setSclass(sclass == null ? cls : sclass + " " + cls);
	}
	
	/**
	 * 
	 * @param cls
	 * @param target
	 * @return boolean
	 */
	public static boolean hasSclass(String cls, HtmlBasedComponent target) {
		String sclass = target.getSclass();
		if (sclass == null)
			sclass = "";
		return cls == null
				|| ((" " + sclass + " ").indexOf(" " + cls + " ") > -1);
	}	
	
	public static Component makeRightAlign(Label label) {
		Div div = new Div();
		div.setStyle("text-align: right");
		div.appendChild(label);
		
		return div;
	}

	/**
	 * open popup window overlapping the ref component
	 * @param ref
	 * @param window
	 */
	public static void openPopupWindow(Component ref, Window window) {
		openPopupWindow(ref, window, "overlap");
	}
	
	/**
	 * open popup window relative to the ref component
	 * @param ref
	 * @param window
	 * @param position
	 */
	public static void openPopupWindow(Component ref, Window window, String position) {
		if (window.getPage() == null)
			window.setPage(ref.getPage());
		StringBuilder script = new StringBuilder();
		script.append("_idempiere_popup_window('#")
			.append(ref.getUuid())
			.append("','#")
			.append(window.getUuid())
			.append("','")
			.append(position)
			.append("');");
		window.doPopup();
		Clients.response("_openPopupWindow_", new AuScript(window, script.toString()));
	}
	
	/**
	 * open popup window relative to the ref component
	 * @param ref
	 * @param window
	 * @param position
	 */
	public static void openOverlappedWindow(Component ref, Window window, String position) {
		if (window.getPage() == null)
			window.setPage(ref.getPage());
		StringBuilder script = new StringBuilder();
		script.append("_idempiere_popup_window('#")
			.append(ref.getUuid())
			.append("','#")
			.append(window.getUuid())
			.append("','")
			.append(position)
			.append("');");
		window.doOverlapped();
		Clients.response("_openPopupWindow_", new AuScript(window, script.toString()));
	}
	
	public static void redraw(AbstractComponent component) {
		StringWriter writer = new StringWriter(1024);
		try {
			component.redraw(writer);
			Clients.response(new AuOuter(component, writer.toString()));
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}
}
