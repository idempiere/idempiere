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

import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;

/**
 * @author hengsin
 *
 */
public class TouchEventHelper implements TouchEvents, EventListener<Event> {

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

	private void addClientTouchListener(Component component) {
		StringBuilder touchScript = new StringBuilder();
        touchScript.append("var widget = zk.Widget.$('")
        	.append(component.getUuid()).append("');");
        touchScript.append("jq(widget.$n()).bind('touchstart',");                
        touchScript.append("function(event){");
        touchScript.append("var widget = zk.Widget.$('");
        touchScript.append(component.getUuid()).append("');");                
        touchScript.append("var zEvent = new zk.Event(widget, 'onTouchstart', {}, {toServer: true});");
        touchScript.append("zAu.send(zEvent);");               
        touchScript.append("});");
        
        touchScript.append("jq(widget.$n()).bind('touchend',");                
        touchScript.append("function(event){");
        touchScript.append("var widget = zk.Widget.$('");
        touchScript.append(component.getUuid()).append("');");                
        touchScript.append("var zEvent = new zk.Event(widget, 'onTouchend', {}, {toServer: true});");
        touchScript.append("zAu.send(zEvent);");               
        touchScript.append("});");
        Clients.response(new AuScript(component, touchScript.toString()));
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
				Events.sendEvent(component, new Event(ON_TAP, component, null));
				component.setAttribute(TOUCH_TAP_TIME, System.currentTimeMillis());
			}
		} 
	}
	
	public static void addOnTapEventListener(Component component, EventListener<Event> listener) {
		new TouchEventHelper(component);
		component.addEventListener(ON_TAP, listener);
	}
	
	public static boolean isIgnoreClick(Component component) {
		Number n = (Number) component.getAttribute(TOUCH_TAP_TIME);
		return n != null && ((System.currentTimeMillis() - n.longValue()) < (60000));
	}
}
