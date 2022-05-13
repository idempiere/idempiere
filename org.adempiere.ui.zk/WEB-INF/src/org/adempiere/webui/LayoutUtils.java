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
import java.util.ArrayList;
import java.util.List;

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
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.OpenEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Div;
import org.zkoss.zul.Grid;
import org.zkoss.zul.LayoutRegion;
import org.zkoss.zul.Popup;
import org.zkoss.zul.Row;
import org.zkoss.zul.Rows;
import org.zkoss.zul.Space;
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
	@Deprecated
	public static void sendDeferLayoutEvent(org.zkoss.zul.Borderlayout layout, int timeout) {
		/* this is not required anymore */
//		StringBuilder content = new StringBuilder();
//		content.append("ad_deferRenderBorderLayout('")
//			   .append(layout.getUuid())
//			   .append("',").append(timeout).append(");");
//
//		AuScript as = new AuScript(null, content.toString());
//		Clients.response("deferRenderBorderLayout", as);
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

	public static void openPopupWindow(Component ref, Window window) {
		openPopupWindow(ref, window, 0);
	}
	
	/**
	 * open popup window overlapping the ref component
	 * @param ref
	 * @param window
	 */
	public static void openPopupWindow(Component ref, Window window, int delayMs) {
		openPopupWindow(ref, window, "overlap", delayMs);
	}
	
	public static void openPopupWindow(Component ref, Window window, String position) {
		openPopupWindow(ref, window, position, 0);
	}
	
	/**
	 * open popup window relative to the ref component
	 * @param ref
	 * @param window
	 * @param position
	 */
	public static void openPopupWindow(Component ref, Window window, String position, int delayMs) {
		if (window.getPage() == null)
			window.setPage(ref.getPage());
		StringBuilder script = new StringBuilder();
		if (delayMs > 0) {
			script.append("setTimeout(function() { ");
		}
		script.append("idempiere.show_popup_window('#")
			.append(ref.getUuid())
			.append("','#")
			.append(window.getUuid())
			.append("','")
			.append(position)
			.append("'); ");
		script.append("zk.Widget.$('#").append(window.getUuid()).append("').focus(); ");
		if (delayMs > 0) {
			script.append(" }, ").append(delayMs).append(");");
		}
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
		script.append("idempiere.show_popup_window('#")
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
		script.append("idempiere.show_popup_window('#")
			.append(ref.getUuid())
			.append("','#")
			.append(window.getUuid())
			.append("','")
			.append(position)
			.append("');");
		Clients.response("_openPopupWindow_", new AuScript(window, script.toString()));
	}
	
	/**
	 * open embedded window relative to the ref component
	 * @param ref
	 * @param window
	 * @param position
	 */
	public static void openEmbeddedWindow(Component ref, Window window, String position) {
		StringBuilder script = new StringBuilder();
		script.append("idempiere.show_popup_window('#")
			.append(ref.getUuid())
			.append("','#")
			.append(window.getUuid())
			.append("','")
			.append(position)
			.append("');");
		window.setVisible(true);
		window.setMode(Mode.EMBEDDED);
		Clients.response("_openEmbeddedWindow_", new AuScript(window, script.toString()));
	}
	
	/**
	 * open highlighted window relative to the ref component
	 * @param ref
	 * @param window
	 * @param position
	 */
	public static void openHighlightedWindow(Component ref, Window window, String position) {
		StringBuilder script = new StringBuilder();
		script.append("idempiere.show_popup_window('#")
			.append(ref.getUuid())
			.append("','#")
			.append(window.getUuid())
			.append("','")
			.append(position)
			.append("');");
		window.setMode(Mode.HIGHLIGHTED);
		Clients.response("_openHighlightedWindow_", new AuScript(window, script.toString()));
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
	 * @return when show success return IMask object, it is own window, use {@link ISupportMask#hideMask()} to hidden mask. 
	 * other return null.  
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
	 * Show window in center of component
	 * @param window
	 * @param mask
	 */
	protected static void showWindowWithMask(Window window, ISupportMask mask){
		mask.showMask();
		mask.getMaskComponent().appendChild(window);
		
		StringBuilder script = new StringBuilder("(function(){let w=zk.Widget.$('#");
		script.append(mask.getMaskComponent().getUuid()).append("');");
		script.append("let d=zk.Widget.$('#").append(window.getUuid()).append("');w.busy=d;");
		script.append("})()");
		Clients.response(new AuScript(script.toString()));
		
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
	 * @param parentClass
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
	
	/**
	 * Compact grid to limit (for e.g, to max of 2 column)
	 * Note: doesn't handle row span
	 * @param grid
	 * @param limit
	 */
	public static void compactTo(Grid grid, int limit) {
		Rows rows = grid.getRows();
		if (rows == null) return;
		Row currentRow = (Row)rows.getFirstChild();
		while (currentRow != null) {
			int size = 0;
			int extraStart = 0;
			for (Component component : currentRow.getChildren()) {
				if (component instanceof Cell) {
					Cell cell = (Cell) component;
					size += cell.getColspan();
				} else {
					size++;
				}
				if (size > limit && extraStart == 0)
					extraStart = currentRow.getChildren().indexOf(component);
			}
			Row nextRow = (Row) currentRow.getNextSibling();
			if (size > limit) {
				List<Component> extras = new ArrayList<>();
				for(int i = extraStart; i < currentRow.getChildren().size(); i++) {
					extras.add(currentRow.getChildren().get(i));
				}				
				org.adempiere.webui.component.Row newRow = new org.adempiere.webui.component.Row();
				int spanOffset = 0;
				while (!extras.isEmpty()) {
					Component component = extras.remove(0);
					if (component instanceof Cell) {
						spanOffset += (((Cell)component).getColspan()-1);
					}
					newRow.appendChild(component);
					if (newRow.getChildren().size()+spanOffset >= limit) {
						if (nextRow != null)
							rows.insertBefore(newRow, nextRow);
						else
							rows.appendChild(newRow);
						newRow = new org.adempiere.webui.component.Row();
					}
				}
				if (newRow.getChildren().size() > 0) {
					if (nextRow != null)
						rows.insertBefore(newRow, nextRow);
					else
						rows.appendChild(newRow);
				}				
			}
			currentRow = nextRow;
		}
	}
	
	public static void expandTo(Grid grid, int min) {
		expandTo(grid, min, false);
	}
	
	/**
	 * Expand grid to min (for e.g, to min of 2 column)
	 * Note: doesn't handle row span
	 * @param grid
	 * @param min
	 * @param fillWithSpace if true, fill up row with space instead of 
	 * moving element from next row
	 */
	public static void expandTo(Grid grid, int min, boolean fillWithSpace) {
		Rows rows = grid.getRows();
		if (rows == null) return;
		Row currentRow = (Row)rows.getFirstChild();
		while (currentRow != null) {
			int size = 0;
			for (Component component : currentRow.getChildren()) {
				if (component instanceof Cell) {
					Cell cell = (Cell) component;
					size += cell.getColspan();
				} else {
					size++;
				}
			}
			Row nextRow = (Row) currentRow.getNextSibling();
			if (size < min) {
				if (fillWithSpace) {
					Cell cell = new Cell();
					cell.setColspan(min-size);
					cell.appendChild(new Space());
					currentRow.appendChild(cell);
				} else {
					while (size < min && nextRow != null) {
						List<Component> toAdd = new ArrayList<>();
						for (Component c : nextRow.getChildren()) {
							toAdd.add(c);
							if (c instanceof Cell)
								size += ((Cell)c).getColspan();
							else
								size++;
							if (size >= min)
								break;
						}
						for(Component c : toAdd) {
							currentRow.appendChild(c);
						}					
					}
					if (nextRow != null && nextRow.getChildren().isEmpty()) {
						nextRow.detach();
						continue;
					}
				}
			}
			currentRow = nextRow;
		}
	}
	
	private static final EventListener<OpenEvent> addSlideEventListener = (OpenEvent evt) -> {
		if (evt.isOpen())
			LayoutUtils.removeSclass("slide", (HtmlBasedComponent) evt.getTarget());
		else
			LayoutUtils.addSclass("slide", (HtmlBasedComponent) evt.getTarget());
	};
	
	/**
	 * enable slide sclass ( when slide out ) for collapsible region
	 * @param region
	 */
	public static void addSlideSclass(LayoutRegion region) {
		region.addEventListener(Events.ON_OPEN, addSlideEventListener);
	}
	
	/**
	 * find popup ancestor of comp
	 * @param comp
	 * @return {@link Popup} if comp or one of its ancestor is Popup
	 */
	public static Popup findPopup(Component comp) {
		Component c = comp;
		while (c != null) {
			if (c instanceof Popup)
				return (Popup) c;
			c = c.getParent();
		}
		return null;
	}

	/**
	 * call popup.detach when it is close
	 * @param popup
	 */
	public static void autoDetachOnClose(Popup popup) {
		popup.addEventListener(Events.ON_OPEN, (OpenEvent e) -> {
			if (!e.isOpen()) {
				popup.detach();
			}
		});
	}

	/**
	 * set target same width as ref using client side script
	 * @param target
	 * @param ref
	 */
	public static void sameWidth(HtmlBasedComponent target, HtmlBasedComponent ref) {
		StringBuilder script = new StringBuilder()
				.append("(function(){let t=zk.Widget.$('#").append(target.getUuid()).append("');")
				.append("let r=zk.Widget.$('#").append(ref.getUuid()).append("');")
				.append("jq(t).css({'width':").append("jq(r).width()+'px'});")
				.append("t.setWidth(\"").append("jq(r).width()+'px'\");");
		script.append("})()");
		Clients.response("_sameWidth_", new AuScript(target, script.toString()));
	}
}
