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
package org.adempiere.webui.event;

import org.adempiere.webui.apps.AEnv;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Grid;

/**
 * @author hengsin
 *
 */
public class TouchEventHelper implements TouchEvents, EventListener<Event> {

	private static final String TOUCH_LISTENER_INIT = "touch.listener.init";
	private static final String TABLET_SCROLLING_FIX_INIT = "tablet.scrolling.fix.init";
	private static final String TOUCH_TAP_TIME = "touch.tap.time";
	private Component touchStart = null;
    private long touchStartTime = 0;
    
    private Component touchEnd = null;
    private long touchEndTime = 0;
	private Component component;
    
	/**
	 * 
	 */
	private TouchEventHelper(Component component) {
		component.addEventListener(ON_TOUCH_START, this);
		component.addEventListener(ON_TOUCH_END, this);
		addClientTouchListener(component);
		this.component = component;
	}

	/**
	 * add client side listener to enable the touchstart, touchmove and touchend event
	 * @param component
	 */
	public static void addClientTouchListener(Component component) {
		Boolean b = (Boolean) component.getAttribute(TOUCH_LISTENER_INIT);
		if (b != null && b.booleanValue())
			return;
		
		StringBuilder touchScript = new StringBuilder();
        touchScript.append("var widget = zk.Widget.$('")
        	.append(component.getUuid()).append("');");
        touchScript.append("jq(widget.$n()).bind('touchstart',");                
        touchScript.append("function(e){");
        touchScript.append("var widget = zk.Widget.$('");
        touchScript.append(component.getUuid()).append("');");                
        touchScript.append("var zEvent = new zk.Event(widget, 'onTouchstart', {altKey: e.altKey, ctrlKey: e.ctrlKey, metaKey: e.metaKey," +
        		"rotation: e.rotation, scale: e.scale, shiftKey: e.shiftKey}, {toServer: true});");
        touchScript.append("zAu.send(zEvent);");               
        touchScript.append("});");
        
        touchScript.append("jq(widget.$n()).bind('touchend',");                
        touchScript.append("function(e){");
        touchScript.append("var widget = zk.Widget.$('");
        touchScript.append(component.getUuid()).append("');");                
        touchScript.append("var zEvent = new zk.Event(widget, 'onTouchend', {altKey: e.altKey, ctrlKey: e.ctrlKey, metaKey: e.metaKey," +
        		"rotation: e.rotation, scale: e.scale, shiftKey: e.shiftKey}, {toServer: true});");
        touchScript.append("zAu.send(zEvent);");               
        touchScript.append("});");
        Clients.response(new AuScript(component, touchScript.toString()));
        
        touchScript.append("jq(widget.$n()).bind('touchmove',");                
        touchScript.append("function(event){");
        touchScript.append("var widget = zk.Widget.$('");
        touchScript.append(component.getUuid()).append("');");                
        touchScript.append("var zEvent = new zk.Event(widget, 'onTouchmove', {altKey: e.altKey, ctrlKey: e.ctrlKey, metaKey: e.metaKey," +
        		"rotation: e.rotation, scale: e.scale, shiftKey: e.shiftKey}, {toServer: true});");
        touchScript.append("zAu.send(zEvent);");               
        touchScript.append("});");
        Clients.response(new AuScript(component, touchScript.toString()));
        
        component.setAttribute(TOUCH_LISTENER_INIT, Boolean.TRUE);
	}
	
	private void registerTouchStart(Event event) {
		touchStart = event.getTarget();
		touchStartTime = System.currentTimeMillis();
	}
	
	private void registerTouchEnd(Event event) {
		touchEnd = event.getTarget();
		touchEndTime = System.currentTimeMillis();
	}
	
	private boolean isTap() {
		return touchStart != null && touchStart == touchEnd && (touchEndTime - touchStartTime) < 500;
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(ON_TOUCH_START)) {
			registerTouchStart(event);
		} else if (event.getName().equals(ON_TOUCH_END)) {
			registerTouchEnd(event);
			if (isTap()) {
				reset();
				Events.sendEvent(component, new Event(ON_TAP, component, null));
				component.setAttribute(TOUCH_TAP_TIME, System.currentTimeMillis());
			}
		} 
	}

	private void reset() {
		touchStart = null; 
		touchEnd = null;
		touchStartTime = 0;
		touchEndTime = 0;
	}
	
	/**
	 * add OnTap event hook
	 * @param component
	 * @param listener
	 */
	public static void addOnTapEventListener(Component component, EventListener<Event> listener) {
		new TouchEventHelper(component);
		component.addEventListener(ON_TAP, listener);
	}
	
	/**
	 * 
	 * @param component
	 * @return true if onClick should be ignore ( replace by onTap )
	 */
	public static boolean isIgnoreClick(Component component) {
		Boolean b = (Boolean) component.getAttribute(TOUCH_LISTENER_INIT);
		if (b != null && b.booleanValue() && AEnv.isTablet())
			return true;
		else
			return false;
	}
	
	/**
	 * iPad: Use client side listener to workaround the issue that grid header doesn't scroll together with body.
	 * Outstanding Issues: Frozen not working. 
	 * @param grid
	 */
	public static void addTabletScrollingFix(Grid grid) {
		Boolean b = (Boolean) grid.getAttribute(TABLET_SCROLLING_FIX_INIT);
		if (b != null && b.booleanValue())
			return;
		
		String script = "jq('#" + grid.getUuid() + "-body').bind('scroll'," +
				"function(event) { setTimeout(function(){" +
				"jq('#" + grid.getUuid() + "-head').scrollLeft(" +
				"jq('#" + grid.getUuid() + "-body').scrollLeft()); },0);});";
				
		Clients.response(new AuScript(grid, script));
		
		grid.setAttribute(TABLET_SCROLLING_FIX_INIT, Boolean.TRUE);
	}
}
