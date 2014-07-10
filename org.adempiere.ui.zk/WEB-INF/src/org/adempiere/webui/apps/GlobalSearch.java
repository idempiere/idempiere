/******************************************************************************
 * Copyright (C) 2014 Low Heng Sin                                            *
 * Copyright (C) 2014 Trek Global                                             *
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
package org.adempiere.webui.apps;

import org.adempiere.webui.component.Bandbox;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.InputEvent;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Bandpopup;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hlayout;
import org.zkoss.zul.Separator;

/**
 * @author hengsin
 *
 */
public class GlobalSearch extends Div implements EventListener<Event> {

	private static final String ON_ENTER_KEY = "onEnterKey";

	private static final String ON_POST_ENTER_KEY = "onPostEnterKey";

	private static final String ON_CREATE_ECHO = "onCreateEcho";

	private static final String ON_SEARCH = "onSearch";

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8793878697269469837L;
	
	private Bandbox bandbox;
	
	private MenuSearchController menuController;
	private DocumentSearchController docController;

	/**
	 * 
	 */
	public GlobalSearch(MenuSearchController menuController) {
		this.menuController = menuController;
		docController = new DocumentSearchController();
		init();
	}

	private void init() {
		bandbox = new Bandbox();
		appendChild(bandbox);
		bandbox.setWidth("100%");
		bandbox.setAutodrop(true);
		bandbox.addEventListener(Events.ON_CHANGING, this);
		bandbox.setCtrlKeys("#up#down");
		bandbox.addEventListener(Events.ON_CTRL_KEY, this);
		
		Bandpopup popup = new Bandpopup();
		popup.setWidth("700px");
		popup.setHeight("600px");
		bandbox.appendChild(popup);		
		
		Hlayout hlayout = new Hlayout();
		hlayout.setHflex("1");
		popup.appendChild(hlayout);
		menuController.create(hlayout);
		
		Separator separator = new Separator();
		separator.setHeight("100%");
		separator.setBar(true);
		separator.setHflex("0");
		separator.setOrient("horizontal");
		hlayout.appendChild(separator);
		docController.create(hlayout);	
		
		addEventListener(ON_SEARCH, this);
		addEventListener(ON_CREATE_ECHO, this);
		bandbox.addEventListener(ON_ENTER_KEY, this);
		addEventListener(ON_POST_ENTER_KEY, this);
		
		Events.echoEvent(ON_CREATE_ECHO, this, null);
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_CHANGING.equals(event.getName())) {	
			InputEvent inputEvent = (InputEvent) event;
			String value = inputEvent.getValue();		
			Events.postEvent(ON_SEARCH, this, value);						
        } else if (Events.ON_CTRL_KEY.equals(event.getName())) {
        	KeyEvent ke = (KeyEvent) event;
        	if (ke.getKeyCode() == KeyEvent.UP) {
        		if (bandbox.getFirstChild().isVisible()) {
        			MenuItem selected = menuController.selectPrior();
        			if (selected != null) {
        				bandbox.setText(selected.getLabel());
        			}
        		}
        	} else if (ke.getKeyCode() == KeyEvent.DOWN) {
        		if (bandbox.getFirstChild().isVisible()) {
        			MenuItem selected = menuController.selectNext();
        			if (selected != null && !"...".equals(selected.getType())) {
        				bandbox.setText(selected.getLabel());
        			}
        		}
        	}
        } else if (event.getName().equals(ON_SEARCH)) {
        	String value = (String) event.getData();
        	menuController.search(value);		
			docController.search(value);
			bandbox.focus();
        } else if (event.getName().equals(ON_CREATE_ECHO)) {
        	StringBuilder script = new StringBuilder("jq('#")
        		.append(bandbox.getUuid())
        		.append("').bind('keydown', function(e) {var code=e.keyCode||e.which;console.log(code);if(code==13){")
        		.append("var widget=zk.Widget.$('#").append(bandbox.getUuid()).append("');")
        		.append("var event=new zk.Event(widget,'")
        		.append(ON_ENTER_KEY)
        		.append("',{},{toServer:true});")
        		.append("zAu.send(event);")
        		.append("}});");
        	Clients.evalJavaScript(script.toString());
        } else if (event.getName().equals(ON_ENTER_KEY)) {
        	Clients.showBusy(bandbox, null);
        	Events.echoEvent(ON_POST_ENTER_KEY, this, null);        	
        } else if (event.getName().equals(ON_POST_ENTER_KEY)) {
        	Clients.clearBusy(bandbox);
        	if (menuController.onOk(bandbox)) {
        		return;
        	} else {
        		docController.onOk(bandbox);
        	}
        }
	}
}
