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

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.apps.DocumentSearchController.SearchResult;
import org.adempiere.webui.component.Bandbox;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.util.DocumentSearch;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.InputEvent;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Bandpopup;
import org.zkoss.zul.Div;

/**
 * @author hengsin
 *
 */
public class GlobalSearch extends Div implements EventListener<Event> {

	private static final String ON_ENTER_KEY = "onEnterKey";

	private static final String ON_POST_ENTER_KEY = "onPostEnterKey";

	private static final String ON_CREATE_ECHO = "onCreateEcho";

	private static final String ON_SEARCH = "onSearch";

	private static final String PREFIX_DOCUMENT_SEARCH = "/";
	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8793878697269469837L;
	
	private Bandbox bandbox;
	
	private MenuSearchController menuController;
	private DocumentSearchController docController;

	private Tabbox tabbox;

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
		bandbox.setSclass("global-search-box");
		appendChild(bandbox);
//		ZKUpdateUtil.setWidth(bandbox, "100%");
		bandbox.setAutodrop(true);
		bandbox.setId("globalSearchBox");
		bandbox.addEventListener(Events.ON_CHANGING, this);
		bandbox.addEventListener(Events.ON_CHANGE, this);
		bandbox.setCtrlKeys("#up#down");
		bandbox.addEventListener(Events.ON_CTRL_KEY, this);
		
		Bandpopup popup = new Bandpopup();
		ZKUpdateUtil.setWindowHeightX(popup, ClientInfo.get().desktopHeight-50);
		bandbox.appendChild(popup);		
		
		tabbox = new Tabbox();
		ZKUpdateUtil.setVflex(tabbox, "true");
		tabbox.addEventListener(Events.ON_SELECT, this);
		Tabs tabs = new Tabs();
		tabbox.appendChild(tabs);
		Tab tab = new Tab();
		tab.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(),"Menu")));
		tabs.appendChild(tab);		
		Tabpanels tabPanels = new Tabpanels();
		tabbox.appendChild(tabPanels);
		Tabpanel tabPanel = new Tabpanel();
		ZKUpdateUtil.setVflex(tabPanel, "true");
		tabPanel.setSclass("global-search-tabpanel");
		tabPanels.appendChild(tabPanel);
		popup.appendChild(tabbox);
		menuController.create(tabPanel);
		
		tab = new Tab();
		tab.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(),"search")));
		tabs.appendChild(tab);
		tabPanel = new Tabpanel();
		tabPanel.setSclass("global-search-tabpanel");
		tabPanels.appendChild(tabPanel);
		docController.create(tabPanel);
		
		addEventListener(ON_SEARCH, this);
		addEventListener(ON_CREATE_ECHO, this);
		bandbox.addEventListener(ON_ENTER_KEY, this);
		addEventListener(ON_POST_ENTER_KEY, this);				
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
        			if (tabbox.getSelectedIndex()==0) {
	        			MenuItem selected = menuController.selectPrior();
	        			if (selected != null) {
	        				bandbox.setText(selected.getLabel());
	        			}
        			} else {
        				SearchResult selected = docController.selectPrior();
        				if (selected != null) {
        					bandbox.setText(selected.getLabel());
        				}
        			}
        		}
        	} else if (ke.getKeyCode() == KeyEvent.DOWN) {
        		if (bandbox.getFirstChild().isVisible()) {
        			if (tabbox.getSelectedIndex()==0) {
	        			MenuItem selected = menuController.selectNext();
	        			if (selected != null && !"...".equals(selected.getType())) {
	        				bandbox.setText(selected.getLabel());
	        			}
        			} else {
        				SearchResult selected = docController.selectNext();
        				if (selected != null) {
        					bandbox.setText(selected.getLabel());
        				}
        			}
        		}
        	}
        } else if (event.getName().equals(ON_SEARCH)) {
        	String value = (String) event.getData();
        	if (tabbox.getSelectedIndex()==0)
        		menuController.search(value);
        	else
        		docController.search(value);
			bandbox.focus();
        } else if (event.getName().equals(ON_CREATE_ECHO)) {
    		StringBuilder script = new StringBuilder("jq('#")
    			.append(bandbox.getUuid())
    			.append("').bind('keydown', function(e) {let code=e.keyCode||e.which;if(code==13){")
    			.append("let widget=zk.Widget.$(this);")
    			.append("let event=new zk.Event(widget,'")
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
        	if (bandbox.getValue() != null && bandbox.getValue().startsWith(PREFIX_DOCUMENT_SEARCH)) {
        		DocumentSearch search = new DocumentSearch();
            	if (search.openDocumentsByDocumentNo(bandbox.getValue().substring(1)))
    				bandbox.setText(null);
        	} else {        	
	        	if (tabbox.getSelectedIndex()==0) {
	        		menuController.onOk(bandbox);
	        	} else {
	        		docController.onOk(bandbox);
	        	}
        	}
        } else if (event.getName().equals(Events.ON_SELECT)) {
        	String value = (String) bandbox.getAttribute("last.onchanging");
        	if (value == null) {
        		value = bandbox.getValue();
        	}
        	Events.postEvent(ON_SEARCH, this, value);
        }
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.AbstractComponent#onPageAttached(org.zkoss.zk.ui.Page, org.zkoss.zk.ui.Page)
	 */
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		Events.echoEvent(ON_CREATE_ECHO, this, null);		
	}
	
	public void closePopup() {
		if (bandbox != null) {
			bandbox.close();
		}
	}
	
	public void onClientInfo() {
		ZKUpdateUtil.setWindowHeightX(bandbox.getDropdown(), ClientInfo.get().desktopHeight-50);	
	}
}
