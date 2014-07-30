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
import org.adempiere.webui.component.Mask;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.session.SessionManager;
import org.compiere.util.Util;
import org.zkoss.zk.au.out.AuOuter;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.AbstractComponent;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Div;
import org.zkoss.zul.Window;
import org.zkoss.zul.Window.Mode;

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
	
	/**
	 * 
	 * @param label
	 * @return wrapped label
	 */
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
		window.focus();
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
	
	/**
	 * position opened window relative to the ref component
	 * @param ref
	 * @param window
	 * @param position
	 */
	public static void positionWindow(Component ref, Window window, String position) {
		StringBuilder script = new StringBuilder();
		script.append("_idempiere_popup_window('#")
			.append(ref.getUuid())
			.append("','#")
			.append(window.getUuid())
			.append("','")
			.append(position)
			.append("');");
		Clients.response("_openPopupWindow_", new AuScript(window, script.toString()));
	}
	
	/**
	 * open popup window relative to the ref component
	 * @param ref
	 * @param window
	 * @param position
	 */
	public static void openEmbeddedWindow(Component ref, Window window, String position) {
		StringBuilder script = new StringBuilder();
		script.append("_idempiere_popup_window('#")
			.append(ref.getUuid())
			.append("','#")
			.append(window.getUuid())
			.append("','")
			.append(position)
			.append("');");
		window.setVisible(true);
		window.setMode(Mode.EMBEDDED);
		Clients.response("_openPopupWindow_", new AuScript(window, script.toString()));
	}
	
	/**
	 * 
	 * @param component
	 */
	public static void redraw(AbstractComponent component) {
		StringWriter writer = new StringWriter(1024);
		try {
			component.redraw(writer);
			Clients.response(new AuOuter(component, writer.toString()));
		} catch (IOException e) {
			e.printStackTrace();
		}		
	}

	/**
	 * @param component
	 * @return true if the component and all its parent are visible
	 */
	public static boolean isReallyVisible(Component component) {
		if (!component.isVisible()) return false;
		Component parent = component.getParent();
		while (parent != null) {
			if (!parent.isVisible())
				return false;
			
			parent = parent.getParent();
		}
		return true;
	}

	public static void removeSclass(String cls, HtmlBasedComponent target) {
		String sclass = target.getSclass();
		if (Util.isEmpty(sclass))
			return;
		
		sclass = " " + sclass + " ";
		cls = " " + cls + " ";
		if (sclass.indexOf(cls) >= 0) {
			sclass = sclass.replace(cls, " ");
			sclass = sclass.trim();
			target.setSclass(sclass);
		}
	}
	
	public static final int OVERLAP_TAB_PANEL = 1;
	public static final int OVERLAP_ALL_PAGE = 2;
	public static final int OVERLAP_PARENT = 3;
	public static final int OVERLAP_SELF = 4;
	
	/**
	 * show window with a mask below. mask over tabPanel, all window or only over a control, dependency ownModel flag.
	 * when ownModel == {@link #OVERLAP_SELF}, window show overlap childOfOwn, 
	 * 					when childOfOwn isn't implement {@link ISupportMask} make new {@link Mask} object to make mask layout
	 *                	ownModel == {@link #OVERLAP_ALL_PAGE}, window show overlap all page
	 *                  ownModel == {@link #OVERLAP_TAB_PANEL}, window show overlap tabPanel
	 *                  ownModel == {@link #OVERLAP_PARENT}, search near parent of childOfOwn implement {@link ISupportMask} if not exist user as OVERLAP_ALL_PAGE
	 * @param window 
	 * @param childOfOwn  
	 * @param ownModel
	 * @return when show success return IMask object, it is own window, use {@link ISupportMask#hideMask()} to hiden mask. 
	 * other return null. with case return null (show over childOfOwn or parent of childOfOwn but childOfOwn or parent of childOfOwn isn't implement {@link ISupportMask}), please consider use {@link #showOverlapWithMask(Component, Component)}  
	 */
	public static ISupportMask showWindowWithMask(Window window, Component childOfOwn, int ownModel){
		ISupportMask ownWindow = null;
		// search to top parent, capture parent with interface ISupportMask
		if (ownModel == OVERLAP_SELF && ISupportMask.class.isInstance(childOfOwn)){
			ownWindow = (ISupportMask) childOfOwn;			
		}else  if (ownModel == OVERLAP_TAB_PANEL){
			ownWindow = findMaskParent (childOfOwn, Tabpanel.class);
		}else  if (ownModel == OVERLAP_PARENT){
			ownWindow = findMaskParent (childOfOwn, null);
		}else if (ownModel == OVERLAP_ALL_PAGE){
			IDesktop desktop = SessionManager.getAppDesktop();
			if (desktop != null && ISupportMask.class.isInstance(desktop)){
				ownWindow = (ISupportMask)desktop;				
			}			
		}
		
		// show window
		if (ownWindow != null){
			showWindowWithMask (window, ownWindow);
		}
		
		return ownWindow;		 
	}
	
	/**
	 * Show window in center of component get from {@link}
	 * @param window
	 * @param mask
	 */
	protected static void showWindowWithMask(Window window, ISupportMask mask){
		mask.showMask();
		mask.getMaskComponent().appendChild(window);
		LayoutUtils.openOverlappedWindow(mask.getMaskComponent(), window, "middle_center");
	}
	
	/**
	 * Show window over ownWindow with a mask, use when ownWindow isn't implement {@link ISupportMask}
	 * @param window
	 * @param ownWindow
	 * @param mask if mask = null, make new and return it
	 * @return {@link Mask} objec for hiden mask when close window.
	 */
	public static Mask showWindowWithMask(Window window, Component ownWindow, Mask mask){
		if (mask == null){
			mask = new Mask();
		}		
		ownWindow.appendChild(mask);		
		
		ownWindow.appendChild(window);		
		LayoutUtils.openOverlappedWindow(ownWindow, window, "middle_center");
		
		return mask;
	}
	
	/**
	 * find parent control of child control, parent must implement {@link ISupportMask}
	 * if parentClass != null, parent class must extends parentClass
	 * @param child
	 * @param ownModel
	 * @return
	 */
	public static ISupportMask findMaskParent (Component child, Class<?> parentClass){
		Component parent = child;
		ISupportMask trueParent = null;		
		while ((parent = parent.getParent()) != null){
			if (ISupportMask.class.isInstance(parent)){
				if (parentClass == null || parentClass.isInstance(parent)){						
					trueParent = (ISupportMask)parent;
					break;
				}
			}
		}
		return trueParent;
	}
}
