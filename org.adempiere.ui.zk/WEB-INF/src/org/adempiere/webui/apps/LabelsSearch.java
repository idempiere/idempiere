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
 * - Nicolas Micoud (TGI)                                              *
 * - Alan Lescano                                                      *
 * - Norbert Bede                                                      *
 **********************************************************************/
package org.adempiere.webui.apps;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.apps.LabelsSearchController.LabelItem;
import org.adempiere.webui.component.Bandbox;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.InputEvent;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Bandpopup;
import org.zkoss.zul.Div;

public class LabelsSearch extends Div implements EventListener<Event> {
	private static final long serialVersionUID = -8793878697269469837L;
	private static final String ON_ENTER_KEY = "onEnterKey";
	private static final String ON_CREATE_ECHO = "onCreateEcho";
	private static final String ON_SEARCH = "onSearch";
	private Bandbox bandbox;	
	private LabelsSearchController controller;

	/**
	 * Standard constructot
	 * @param controller
	 */
	public LabelsSearch(LabelsSearchController controller) {
		this.controller = controller;
		init();
	}

	private void init() {
		bandbox = new Bandbox();
		appendChild(bandbox);
		ZKUpdateUtil.setWidth(bandbox, "100%");
		bandbox.setAutodrop(true);
		bandbox.setId("labelsSearchBox");
		bandbox.addEventListener(Events.ON_CHANGING, this);
		bandbox.addEventListener(Events.ON_CHANGE, this);
		bandbox.setCtrlKeys("#up#down");
		bandbox.addEventListener(Events.ON_CTRL_KEY, this);
		bandbox.setPlaceholder(Msg.getMsg(Env.getCtx(),"TypeToSearchOrCreate"));
		
		Bandpopup popup = new Bandpopup();
		ZKUpdateUtil.setWindowHeightX(popup, 100);
		ZKUpdateUtil.setWindowWidthX(popup, 176);
		bandbox.appendChild(popup);		
		controller.create(popup);
		
		addEventListener(ON_SEARCH, this);
		addEventListener(ON_CREATE_ECHO, this);		
		addEventListener(LabelsSearchController.ON_POST_SELECT_LABELITEM_EVENT, this);
		bandbox.addEventListener(ON_ENTER_KEY, this);
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_CHANGING.equals(event.getName())) {			
			InputEvent inputEvent = (InputEvent) event;
			String value = inputEvent.getValue();		
			bandbox.setAttribute("last.onchanging", value);
			Events.postEvent(ON_SEARCH, this, value);		
		} else if (Events.ON_CHANGE.equals(event.getName())) {
			bandbox.removeAttribute("last.onchanging");
        } else if (Events.ON_CTRL_KEY.equals(event.getName())) {
        	KeyEvent ke = (KeyEvent) event;
        	if (ke.getKeyCode() == KeyEvent.UP) {
        		if (bandbox.getFirstChild().isVisible()) {
        			LabelItem selected = controller.selectPrior();
        			
        			if (selected != null) {
        				bandbox.setText(selected.getLabel());
        			}
        		}
        	} else if (ke.getKeyCode() == KeyEvent.DOWN) {
        		if (bandbox.getFirstChild().isVisible()) {
        			LabelItem selected = controller.selectNext();
        			
        			if (selected != null) {
        				bandbox.setText(selected.getLabel());
        			}
        		}
        	}
        } else if (event.getName().equals(ON_SEARCH)) {
        	String value = (String) event.getData();
       		controller.search(value);
			bandbox.focus();
        } else if (event.getName().equals(ON_CREATE_ECHO)) {
    		StringBuilder script = new StringBuilder("jq('#")
    			.append(bandbox.getUuid())
    			.append("').bind('keydown', function(e) {var code=e.keyCode||e.which;if(code==13){")
    			.append("var widget=zk.Widget.$(this);")
    			.append("var event=new zk.Event(widget,'")
    			.append(ON_ENTER_KEY)
    			.append("',{},{toServer:true});")
    			.append("zAu.send(event);")
    			.append("}});");
    		Clients.evalJavaScript(script.toString());
        } else if (event.getName().equals(ON_ENTER_KEY)) {
        	if (event.getTarget() instanceof Bandbox) {
	        	controller.onSelect(controller.getSelectedItem());
        	}     	
        } else if (event.getName().equals(Events.ON_SELECT)) {
        	String value = (String) bandbox.getAttribute("last.onchanging");
        	if (value == null) {
        		value = bandbox.getValue();
        	}
        	
        	Events.postEvent(ON_SEARCH, this, value);
        }
		
		if (event.getName().equals(LabelsSearchController.ON_POST_SELECT_LABELITEM_EVENT)) {
			closePopup();
			bandbox.focus();
			bandbox.setText(null);
			bandbox.setValue(null);
		}
	}

	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		Events.echoEvent(ON_CREATE_ECHO, this, null);		
	}
	
	/**
	 * Close the search dropdown
	 */
	public void closePopup() {
		if (bandbox != null) {
			bandbox.close();
		}
	}
	
	/**
	 * Set height of the search dropdown
	 */
	public void onClientInfo() {
		ZKUpdateUtil.setWindowHeightX(bandbox.getDropdown(), ClientInfo.get().desktopHeight-50);	
	}
}
