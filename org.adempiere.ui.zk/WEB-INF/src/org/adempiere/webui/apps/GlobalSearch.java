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

import org.adempiere.base.search.SearchResult;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.component.Bandbox;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.util.DocumentSearch;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MSearchDefinition;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.InputEvent;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Bandpopup;
import org.zkoss.zul.Div;

/**
 * Global search component at desktop header.
 * @author hengsin
 */
public class GlobalSearch extends Div implements EventListener<Event> {

	/** {@link #bandbox} attribute to store value from last {@link Events#ON_CHANGING} event **/
	private static final String LAST_ONCHANGING_ATTR = "last.onchanging";

	/** Event send from client side upon keyDown of enter key **/
	private static final String ON_ENTER_KEY_EVENT = "onEnterKey";

	/** Event echo from ON_ENTER_KEY_EVENT to allow showing of in progress dialog before execution of search **/
	private static final String ON_POST_ENTER_KEY_EVENT = "onPostEnterKey";

	/** Event to execute search. **/
	private static final String ON_SEARCH_EVENT = "onSearch";

	/** Prefix to start document search using definition from {@link MSearchDefinition} **/
	private static final String PREFIX_DOCUMENT_SEARCH = "/";

	/** Period (in ms) after which a pending search is considered lost and no longer waited for **/
	private static final long PENDING_SEARCH_TIMEOUT = 60000;

	/** Logger **/
	private static final CLogger log = CLogger.getCLogger(GlobalSearch.class);
	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8793878697269469837L;
	
	/** Bandbox to capture search text from user and display result in popup **/
	private Bandbox bandbox;
	
	/** controller to search AD_Menu **/
	private MenuSearchController menuController;
	
	/** controller to search tables **/
	private DocumentSearchController docController;

	/** tabbox to host menu and document search tab **/
	private Tabbox tabbox;

	/** count of posted search events that haven't completed yet **/
	private int pendingSearches = 0;

	/** time stamp of the oldest pending search, 0 if there is none **/
	private long pendingSearchesSince = 0;

	/** true if Enter key is pressed and waiting for pending searches to complete **/
	private boolean postEnterKeyPending = false;

	/**
	 * @param menuController
	 */
	public GlobalSearch(MenuSearchController menuController) {
		this.menuController = menuController;
		docController = new DocumentSearchController();
		init();
	}

	/**
	 * Layout UI and setup listeners
	 */
	private void init() {
		bandbox = new Bandbox();
		bandbox.setSclass("global-search-box");
		appendChild(bandbox);
		bandbox.setAutodrop(true);
		bandbox.setId("globalSearchBox");
		bandbox.addEventListener(Events.ON_CHANGING, this);
		bandbox.addEventListener(Events.ON_CHANGE, this);
		bandbox.setCtrlKeys("#up#down");
		bandbox.addEventListener(Events.ON_CTRL_KEY, this);
		//client side listener for enter key, part of widget definition so it survives re-rendering of the bandbox
		//InputWidget._stopOnChanging(this, true) flushes the delayed onChanging event, so the server has the last
		//typed text before onEnterKey is processed. updateChange_() is only done by ComboWidget.enterPressed_()
		//while the popup is open, call it here as well to cover the popup closed case.
		bandbox.setWidgetOverride("doKeyDown_", "function(evt){"
				+ "if(evt.keyCode==13&&evt.domTarget==this.getInputNode()){"
				+ "zul.inp.InputWidget._stopOnChanging(this,true);}"
				+ "this.$doKeyDown_(evt);"
				+ "if(evt.keyCode==13&&evt.domTarget==this.getInputNode()){"
				+ "this.updateChange_();"
				+ "zAu.send(new zk.Event(this,'" + ON_ENTER_KEY_EVENT + "',{},{toServer:true}));}}");
		bandbox.addEventListener(Events.ON_FOCUS, e -> {
			bandbox.setOpen(true);
			if (tabbox.getSelectedIndex() == 0)
				menuController.updateRecentItems();
		});
		
		Bandpopup popup = new Bandpopup();
		ZKUpdateUtil.setWindowHeightX(popup, ClientInfo.get().desktopHeight-100);
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
		
		addEventListener(ON_SEARCH_EVENT, this);
		bandbox.addEventListener(ON_ENTER_KEY_EVENT, this);
		addEventListener(ON_POST_ENTER_KEY_EVENT, this);				
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_CHANGING.equals(event.getName())) {
			// Post ON_SEARCH_EVENT for ON_CHANGING from bandbox 
			InputEvent inputEvent = (InputEvent) event;
			String value = inputEvent.getValue();
			// Auto switch to Search with "/"
			if (value != null && value.startsWith("/") && tabbox.getSelectedIndex()==0)
				tabbox.setSelectedIndex(1);
			if (value != null)
				value = value.trim();
			bandbox.setAttribute(LAST_ONCHANGING_ATTR, value);
			postSearchEvent(value);		
		} else if (Events.ON_CHANGE.equals(event.getName())) {
			bandbox.removeAttribute(LAST_ONCHANGING_ATTR);
        } else if (Events.ON_CTRL_KEY.equals(event.getName())) {
        	// Handle keyboard navigation for bandbox items
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
        } else if (event.getName().equals(ON_SEARCH_EVENT)) {
        	String value = (String) event.getData();
        	boolean echoed = false;
        	try {
        		if (tabbox.getSelectedIndex()==0) {
        			menuController.setHighlightText(value);
        			menuController.search(value, this::onSearchCompleted);
        		} else {
        			docController.search(value, this::onSearchCompleted);
        		}
        		echoed = true;
        		bandbox.focus();
        	} finally {
        		//the controller echoes the search event, release the matching pending
        		//count here if it failed before doing so
        		if (!echoed)
        			onSearchCompleted();
        	}
        } else if (event.getName().equals(ON_ENTER_KEY_EVENT)) {
        	if (pendingSearches > 0 && isPendingSearchStale()) {
        		//recover from a pending search that will never complete
        		log.warning("Pending search not completed after " + PENDING_SEARCH_TIMEOUT + " ms, continue with enter key handling");
        		resetPendingSearches();
        	}
        	Clients.showBusy(bandbox, null);
        	postEnterKeyPending = true;
        	Events.echoEvent(ON_POST_ENTER_KEY_EVENT, this, null);        	
        } else if (event.getName().equals(ON_POST_ENTER_KEY_EVENT)) {
        	if (!postEnterKeyPending)
        		return; //stale echo, the enter key has been handled already
        	if (pendingSearches > 0)
        		return; //resumed by the echo from onSearchCompleted
        	//execute search trigger by press of enter key
        	postEnterKey();
        } else if (event.getName().equals(Events.ON_SELECT)) {
        	if (tabbox.getSelectedIndex() == 0)
        		menuController.updateRecentItems();
        	String value = (String) bandbox.getAttribute(LAST_ONCHANGING_ATTR);
        	if (value == null) {
        		value = bandbox.getValue();
        	}
        	postSearchEvent(value);
        }
	}
	
	/**
	 * Post {@link #ON_SEARCH_EVENT} to execute search with value.<br/>
	 * Increase {@link #pendingSearches} so that {@link #ON_ENTER_KEY_EVENT} processing can wait for the search to complete.
	 * @param value search text
	 */
	private void postSearchEvent(String value) {
		//Events.postEvent is processed after the current event, the count is
		//updated before ON_SEARCH_EVENT is handled
		Events.postEvent(ON_SEARCH_EVENT, this, value);
		if (pendingSearches++ == 0)
			pendingSearchesSince = System.currentTimeMillis();
	}
	
	/**
	 * Callback from {@link MenuSearchController#search(String, Runnable)} and
	 * {@link DocumentSearchController#search(String, Runnable)} after a search has completed.<br/>
	 * Resume the deferred {@link #ON_ENTER_KEY_EVENT} processing when no search is pending anymore.
	 */
	private void onSearchCompleted() {
		if (pendingSearches > 0)
			pendingSearches--;
		if (pendingSearches == 0) {
			pendingSearchesSince = 0;
			if (postEnterKeyPending) {
				//don't run the enter key action in this execution: the search result items are
				//rendered at the end of it and MenuSearchController.onOk needs the rendered items
				Events.echoEvent(ON_POST_ENTER_KEY_EVENT, this, null);
			}
		}
	}
	
	/**
	 * @return true if the oldest pending search has been outstanding for longer than {@link #PENDING_SEARCH_TIMEOUT}
	 */
	private boolean isPendingSearchStale() {
		return pendingSearchesSince > 0
				&& System.currentTimeMillis() - pendingSearchesSince > PENDING_SEARCH_TIMEOUT;
	}
	
	/**
	 * Discard pending search state, used when a pending search is considered lost
	 */
	private void resetPendingSearches() {
		pendingSearches = 0;
		pendingSearchesSince = 0;
	}
	
	/**
	 * Execute the action of {@link #ON_ENTER_KEY_EVENT}, once all pending searches have completed
	 */
	private void postEnterKey() {
		postEnterKeyPending = false;
		resetPendingSearches();
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
	}

	/**
	 * Close {@link #bandbox} popup.
	 */
	public void closePopup() {
		if (bandbox != null) {
			bandbox.close();
		}
	}
	
	/**
	 * Handle client info event from browser.
	 */
	public void onClientInfo() {
		ZKUpdateUtil.setWindowHeightX(bandbox.getDropdown(), ClientInfo.get().desktopHeight-100);	
	}

	/**
	 * Set place holder text for global search input box
	 * @param placeHolder
	 */
	public void setPlaceHolderText(String placeHolder) {
		bandbox.setPlaceholder(placeHolder);
	}
	
	/**
	 * Set tooltip text for global search input box
	 * @param tooltipText
	 */
	public void setTooltipText(String tooltipText) {
		bandbox.setTooltiptext(tooltipText);
	}
}
