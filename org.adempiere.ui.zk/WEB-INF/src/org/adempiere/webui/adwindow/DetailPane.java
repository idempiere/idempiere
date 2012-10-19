/**
 * 
 */
package org.adempiere.webui.adwindow;

import java.util.HashMap;
import java.util.Map;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.ToolBar;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.component.ADTabListModel.ADTabLabel;
import org.adempiere.webui.session.SessionManager;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zhtml.Text;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Caption;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Image;
import org.zkoss.zul.Space;
import org.zkoss.zul.Tabpanels;
import org.zkoss.zul.Tabs;
import org.zkoss.zul.Toolbar;

/**
 * @author hengsin
 *
 */
public class DetailPane extends Panel implements EventListener<Event> {

	private static final String STATUS_TEXT_ATTRIBUTE = "status.text";

	private static final String STATUS_ERROR_ATTRIBUTE = "status.error";

	private static final String DELETE_IMAGE = "/images/Delete16.png";
	private static final String EDIT_IMAGE = "/images/EditRecord16.png";
	private static final String NEW_IMAGE = "/images/New16.png";
	private static final String PROCESS_IMAGE = "/images/Process16.png";

	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -7914602940626352282L;
	
	private static final String INFO_INDICATOR_IMAGE = "/images/InfoIndicator16.png";

	private static final String ERROR_INDICATOR_IMAGE = "/images/ErrorIndicator16.png";
	
	private Tabbox tabbox;

	private EventListener<Event> eventListener;

	private Map<Integer, Hbox> messageContainers = new HashMap<Integer, Hbox>();

	private Div msgPopupCnt;

	private Window msgPopup;

	private Caption msgPopupCaption;
	
	private int prevSelectedIndex = 0;

	public static final String ON_ACTIVATE_DETAIL_EVENT = "onActivateDetail";
	
	public static final String ON_DELETE_EVENT = "onDelete";

	public static final String ON_NEW_EVENT = "onNew";

	public static final String ON_EDIT_EVENT = "onEdit";
	
	public DetailPane() {
		tabbox = new Tabbox();
		tabbox.setParent(this);
		tabbox.addEventListener(Events.ON_SELECT, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				fireActivateDetailEvent();
			}
		});
		tabbox.setSclass("adwindow-detailpane-tabbox");
		
		createPopup();
		
		this.setSclass("adwindow-detailpane");
		
	}
	
	public int getSelectedIndex() {
		return tabbox.getSelectedIndex();
	}
	
	public void setSelectedIndex(int curTabIndex) {
		tabbox.setSelectedIndex(curTabIndex);
		prevSelectedIndex = curTabIndex;
	}
	
	public int getTabcount() {
		int count = 0;
		Tabs tabs = tabbox.getTabs();
		if (tabs != null)
			count = tabs.getChildren().size();
		return count;
	}
	
	public void undoLastTabSelection() {
		tabbox.setSelectedIndex(prevSelectedIndex);
	}

	public void refresh() {
		tabbox.invalidate();
	}
	
	public void addADTabpanel(IADTabpanel tabPanel, ADTabLabel tabLabel) {
		addADTabpanel(tabPanel, tabLabel, true);
	}
	
	public void addADTabpanel(IADTabpanel tabPanel, ADTabLabel tabLabel, boolean enabled) {
		Tabs tabs = tabbox.getTabs();
		if (tabs == null) {
			tabs = new Tabs();
			tabbox.appendChild(tabs);
		}
		Tab tab = new Tab();
		tabs.appendChild(tab);
		tab.setLabel(tabLabel.label);
		if (!enabled) {
			tab.setDisabled(true);
			tab.setSclass("adwindow-detailpane-sub-tab");
		}
		
		tab.addEventListener(Events.ON_DOUBLE_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Tab tab = (Tab) event.getTarget();
				if (!tab.isSelected()) 
					return;
				org.zkoss.zul.Tabpanel zkTabpanel = tab.getLinkedPanel();
				ADTabpanel adtab = null;
				for(Component c : zkTabpanel.getChildren()) {
					if (c instanceof ADTabpanel) {
						adtab = (ADTabpanel) c;
						break;
					}
				}
				if (adtab != null && adtab.getGridView() != null
					&& adtab.getGridView().isDetailPaneMode()) {
					onEdit();
				}
			}
		});
		
		Tabpanels tabpanels = tabbox.getTabpanels();
		if (tabpanels == null) {
			tabpanels = new Tabpanels();
			tabpanels.setWidth("100%");
			tabbox.appendChild(tabpanels);
		}
		Tabpanel tp = new Tabpanel();
		tabpanels.appendChild(tp);
		tp.setStyle("background-color: #fff");				
		ToolBar toolbar = new ToolBar();
		tp.appendChild(toolbar);
		ToolBarButton button = new ToolBarButton();
		
		button = new ToolBarButton();		
		button.setImage(NEW_IMAGE);
		toolbar.appendChild(button);
		button.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Event openEvent = new Event(ON_NEW_EVENT, DetailPane.this);
				eventListener.onEvent(openEvent);
			}
		});
		button.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "New")));
		
		button = new ToolBarButton();
		button.setImage(EDIT_IMAGE);
		toolbar.appendChild(button);
		button.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				onEdit();
			}
		});
		button.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "EditRecord")));
		
		button = new ToolBarButton();
		button.setImage(DELETE_IMAGE);
		toolbar.appendChild(button);
		button.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Event openEvent = new Event(ON_DELETE_EVENT, DetailPane.this);
				eventListener.onEvent(openEvent);
			}
		});
		button.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Delete")));
		
		button = new ToolBarButton();
		button.setImage(PROCESS_IMAGE);
		toolbar.appendChild(button);
		button.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				onProcess(event.getTarget());
			}
		});
		button.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Process")));
		
		Hbox messageContainer = new Hbox();
		messageContainer.setPack("end");
		messageContainer.setAlign("center");
		messageContainer.setSclass("adwindow-detailpane-message");
		
		toolbar.appendChild(messageContainer);
		toolbar.setSclass("adwindow-detailpane-toolbar");
		toolbar.setVflex("0");
		messageContainers.put(tabLabel.AD_Tab_ID, messageContainer);
		tabPanel.setAttribute("AD_Tab_ID", tabLabel.AD_Tab_ID);
		
		tp.appendChild(tabPanel);
		if (tabPanel.getGridView() != null) {
			tabPanel.addEventListener(ADTabpanel.ON_DYNAMIC_DISPLAY_EVENT, this);
			tabPanel.getGridView().addEventListener(ON_EDIT_EVENT, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					GridView gridView = (GridView) event.getTarget();
					if (gridView.isDetailPaneMode())
						onEdit();
				}				
			});
		}
	}
	
	protected void onProcess(Component button) {
		ProcessButtonPopup popup = new ProcessButtonPopup();
		ADTabpanel adtab = (ADTabpanel) getSelectedADTabpanel();
		popup.render(adtab.getToolbarButtons());
		
		LayoutUtils.openPopupWindow(button, popup, "after_start");		
	}

	public void setEventListener(EventListener<Event> listener) {
		eventListener = listener;
	}

	public void reset() {
		if (tabbox.getTabs() != null) {
			tabbox.getTabs().getChildren().clear();
		}
		if (tabbox.getTabpanels() != null) {
			tabbox.getTabpanels().getChildren().clear();
		}
			
	}

	public IADTabpanel getADTabpanel(int index) {
		if (index < 0 || index >= tabbox.getTabpanels().getChildren().size())
			return null;
		
		org.zkoss.zul.Tabpanel tabPanel = tabbox.getTabpanel(index);
		for(Component c : tabPanel.getChildren()) {
			if (c instanceof IADTabpanel)
				return (IADTabpanel)c;
		}
		return null;
	}
	
	public IADTabpanel getSelectedADTabpanel() {
		org.zkoss.zul.Tabpanel selectedPanel = tabbox.getSelectedPanel();
		if (selectedPanel != null) {
			for(Component c : selectedPanel.getChildren()) {
				if (c instanceof IADTabpanel)
					return (IADTabpanel)c;
			}
		}
		return null;
	}

	public void setStatusMessage(String status, boolean error) {		
		IADTabpanel tabPanel = getSelectedADTabpanel();
		if (tabPanel == null) return;
		Hbox messageContainer = messageContainers.get(tabPanel.getAttribute("AD_Tab_ID"));
		
		Execution execution = Executions.getCurrent();
    	if (execution != null) {
    		String key = this.getClass().getName()+"."+messageContainer.getUuid();
    		Object o = execution.getAttribute(key);
    		if (o != null) {
    			if (status == null || status.trim().length() == 0)
    				return;
    		} else {
    			execution.setAttribute(key, Boolean.TRUE);
    		}
    	}
    	
		messageContainer.getChildren().clear();
		messageContainer.setAttribute(STATUS_ERROR_ATTRIBUTE, error);
    	messageContainer.setAttribute(STATUS_TEXT_ATTRIBUTE, status);
    	
    	if (status == null || status.trim().length() == 0)
    		return;
    	
		Image image = null;
    	if (error)
    		image = new Image(ERROR_INDICATOR_IMAGE);
    	else
			image = new Image(INFO_INDICATOR_IMAGE);
    	
		image.setAttribute("org.zkoss.zul.image.preload", Boolean.TRUE);		
    	messageContainer.appendChild(image);
    	String labelText = buildLabelText(status);
    	if (error) {
    		Clients.showNotification(buildNotificationText(status), "error", image, "overlap_start", 3500, true);
    	}
    	Label label = new Label(labelText);
    	messageContainer.appendChild(label);
    	if (labelText.length() != status.length()) {
    		image.addEventListener(Events.ON_CLICK, this);
    		image.setStyle("cursor: pointer");
    		label.addEventListener(Events.ON_CLICK, this);
    		label.setStyle("cursor: pointer");
    		
    		label = new Label(" ...");
    		label.setStyle("cursor: pointer");
    		messageContainer.appendChild(label);
    		label.addEventListener(Events.ON_CLICK, this);
    	}    	
    	
    	messageContainer.appendChild(new Space());
	}

	private String buildLabelText(String statusText) {
		if (statusText == null)
			return "";
		if (statusText.length() <= 80)
			return statusText;
		
		int index = statusText.indexOf(" - java.lang.Exception");
		if (index > 0)
			return statusText.substring(0, index);
		return statusText.substring(0, 80);
	}

	private String buildNotificationText(String statusText) {
		if (statusText == null)
			return "";
		if (statusText.length() <= 140)
			return statusText;
		
		int index = statusText.indexOf(" - java.lang.Exception");
		if (index > 0)
			return statusText.substring(0, index);
		return statusText.substring(0, 136) + " ...";
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(Events.ON_CLICK)) {
			Component messageContainer = event.getTarget().getParent();
			Boolean error = (Boolean) messageContainer.getAttribute(STATUS_ERROR_ATTRIBUTE);
			String status = (String) messageContainer.getAttribute(STATUS_TEXT_ATTRIBUTE);
			
			createPopupContent(status);
			showPopup(error, messageContainer);
		} else if (event.getName().equals(ADTabpanel.ON_DYNAMIC_DISPLAY_EVENT)) {
			updateProcessToolbar();
		}
	}
	
	protected void createPopupContent(String status) {
		Text t = new Text(status);
		msgPopupCnt.getChildren().clear();
		msgPopupCnt.appendChild(t);
	}
	
	private void showPopup(boolean error, Component messageContainer) {
		msgPopupCaption.setImage(error ? ERROR_INDICATOR_IMAGE : INFO_INDICATOR_IMAGE);
		LayoutUtils.openOverlappedWindow(messageContainer, msgPopup, "overlap_end");
	}
	
	private void createPopup() {
		msgPopupCnt = new Div();
		msgPopupCnt.setVflex("1");

		
		msgPopup = new Window();
		msgPopup.setBorder(true);
		msgPopup.setClosable(true);
		msgPopup.setSizable(true);
		msgPopup.setContentStyle("overflow: auto");
        msgPopup.setWidth("500px");
        msgPopup.appendChild(msgPopupCnt);
        msgPopup.setPage(SessionManager.getAppDesktop().getComponent().getPage());
        msgPopup.setShadow(true);
        msgPopupCaption = new Caption();
        msgPopup.appendChild(msgPopupCaption);        
	}
	
	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		if (msgPopup != null)
			msgPopup.detach();
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.HtmlBasedComponent#setVflex(java.lang.String)
	 */
	@Override
	public void setVflex(String flex) {
		super.setVflex(flex);
		tabbox.setVflex(flex);
	}

	public void updateToolbar(boolean changed, boolean readOnly) {
		int index = getSelectedIndex();
		if (index < 0 || index >= getTabcount()) return;
		
		Tabpanel tabpanel = tabbox.getTabpanel(index);
		Toolbar toolbar = (Toolbar) tabpanel.getFirstChild();
		
		IADTabpanel adtab = getADTabpanel(index);
		if (adtab.getGridTab().isSortTab())
			readOnly = true;
		
		boolean insertRecord = !readOnly;
		if (insertRecord)
        {
            insertRecord = adtab.getGridTab().isInsertRecord();
        }
        boolean enableNew = !changed && insertRecord && !adtab.getGridTab().isSortTab();
        boolean enableDelete = !changed && !readOnly && !adtab.getGridTab().isSortTab();
        for(Component c : toolbar.getChildren()) {
        	if (c instanceof ToolBarButton) {
        		ToolBarButton btn = (ToolBarButton) c;
        		if (NEW_IMAGE.equals(btn.getImage())) {
        			btn.setDisabled(!enableNew);
        		} else if (DELETE_IMAGE.equals(btn.getImage())) {
        			btn.setDisabled(!enableDelete);
        		}
        	}        	
        }
	}
	
	private void updateProcessToolbar() {
		int index = getSelectedIndex();
		if (index < 0 || index >= getTabcount()) return;
		
		Tabpanel tabpanel = tabbox.getTabpanel(index);
		Toolbar toolbar = (Toolbar) tabpanel.getFirstChild();
		
		IADTabpanel adtab = getADTabpanel(index);
		
        for(Component c : toolbar.getChildren()) {
        	if (c instanceof ToolBarButton) {
        		ToolBarButton btn = (ToolBarButton) c;
        		if (PROCESS_IMAGE.equals(btn.getImage())) {
        			if (adtab.getGridTab().isSortTab()) {
        				btn.setDisabled(true);
        			} else {
        				btn.setDisabled(((ADTabpanel)adtab).getToolbarButtons().isEmpty());
        			}
        			break;
        		}
        	}        	
        }
	}

	public void onEdit() throws Exception {
		Event openEvent = new Event(ON_EDIT_EVENT, DetailPane.this);
		eventListener.onEvent(openEvent);
	}

	public void fireActivateDetailEvent() {
		int index = tabbox.getSelectedIndex();
		IADTabpanel tabPanel = (IADTabpanel) tabbox.getTabpanel(index).getChildren().get(1);
		Event activateEvent = new Event(ON_ACTIVATE_DETAIL_EVENT, tabPanel, prevSelectedIndex);
		Events.sendEvent(activateEvent);
	}

	public void setTabVisibility(int i, boolean visible) {
		if (i < 0 || tabbox.getTabs() == null || i >= tabbox.getTabs().getChildren().size())
			return;
		
		tabbox.getTabs().getChildren().get(i).setVisible(visible);
	}
	
	public boolean isTabVisible(int i) {
		if (i < 0 || tabbox.getTabs() == null || i >= tabbox.getTabs().getChildren().size())
			return false;
		
		return tabbox.getTabs().getChildren().get(i).isVisible();
	}
	
	public boolean isTabEnabled(int i) {
		if (i < 0 || tabbox.getTabs() == null || i >= tabbox.getTabs().getChildren().size())
			return false;
		
		Tab tab = (Tab) tabbox.getTabs().getChildren().get(i);
		return !tab.isDisabled();
	}
	
	public void setTabEnabled(int i, boolean enabled) {
		if (i < 0 || tabbox.getTabs() == null || i >= tabbox.getTabs().getChildren().size())
			return;
		
		Tab tab = (Tab) tabbox.getTabs().getChildren().get(i);
		tab.setDisabled(!enabled);
	}
	
	public void disableToolbar() {
		int index = getSelectedIndex();
		if (index < 0 || index >= getTabcount()) return;
		
		Tabpanel tabpanel = tabbox.getTabpanel(index);
		Toolbar toolbar = (Toolbar) tabpanel.getFirstChild();
		for(Component c : toolbar.getChildren()) {
        	if (c instanceof ToolBarButton) {
        		ToolBarButton btn = (ToolBarButton) c;
        		btn.setDisabled(true);
        	}
		}
	}
}
