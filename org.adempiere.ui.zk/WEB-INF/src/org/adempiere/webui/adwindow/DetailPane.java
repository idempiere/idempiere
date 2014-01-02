/**
 * 
 */
package org.adempiere.webui.adwindow;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.base.IServiceHolder;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.action.Actions;
import org.adempiere.webui.action.IAction;
import org.adempiere.webui.component.ADTabListModel.ADTabLabel;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.ToolBar;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MToolBarButton;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.image.AImage;
import org.zkoss.zhtml.Text;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Execution;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.IdSpace;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.sys.ExecutionCtrl;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Space;
import org.zkoss.zul.Tabpanels;
import org.zkoss.zul.Tabs;
import org.zkoss.zul.Toolbar;

/**
 * @author hengsin
 *
 */
public class DetailPane extends Panel implements EventListener<Event>, IdSpace {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5714780894880069158L;

	private static final String BTN_PROCESS_ID = "BtnProcess";

	private static final String BTN_DELETE_ID = "BtnDelete";

	private static final String BTN_EDIT_ID = "BtnEdit";

	private static final String BTN_NEW_ID = "BtnNew";
	
	private static final String BTN_SAVE_ID = "BtnSave";

	private static final String TABBOX_ONSELECT_ATTRIBUTE = "detailpane.tabbox.onselect";

	public static final String ON_POST_SELECT_TAB_EVENT = "onPostSelectTab";

	private static final String STATUS_TEXT_ATTRIBUTE = "status.text";

	private static final String STATUS_ERROR_ATTRIBUTE = "status.error";

	private static final String DELETE_IMAGE = "images/Delete16.png";
	private static final String EDIT_IMAGE = "images/EditRecord16.png";
	private static final String NEW_IMAGE = "images/New16.png";
	private static final String PROCESS_IMAGE = "images/Process16.png";
	private static final String SAVE_IMAGE = "images/Save16.png";


	private ToolBarButton btnNew;
	private long prevKeyEventTime = 0;
	private KeyEvent prevKeyEvent;

	private Tabbox tabbox;

	private EventListener<Event> eventListener;

	private Map<Integer, Hbox> messageContainers = new HashMap<Integer, Hbox>();

	private Div msgPopupCnt;

	private Window msgPopup;
	
	private int prevSelectedIndex = 0;

	public static final String ON_ACTIVATE_DETAIL_EVENT = "onActivateDetail";
	
	public static final String ON_DELETE_EVENT = "onDelete";

	public static final String ON_NEW_EVENT = "onNew";

	public static final String ON_EDIT_EVENT = "onEdit";
	
	public static final String ON_SAVE_EVENT = "onSave";
	
    private HashMap<String, ToolBarButton> buttons = new HashMap<String, ToolBarButton>();
    private List<ToolbarCustomButton> toolbarCustomButtons = new ArrayList<ToolbarCustomButton>();

	public DetailPane() {
		tabbox = new Tabbox();
		tabbox.setParent(this);
		tabbox.addEventListener(Events.ON_SELECT, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				fireActivateDetailEvent();
				Events.postEvent(new Event(ON_POST_SELECT_TAB_EVENT, DetailPane.this));			
				Executions.getCurrent().setAttribute(TABBOX_ONSELECT_ATTRIBUTE, Boolean.TRUE);
			}
		});
		tabbox.setSclass("adwindow-detailpane-tabbox");
		tabbox.setTabscroll(true);
		ZKUpdateUtil.setWidth(tabbox, "100%");
		
		createPopup();
		
		this.setSclass("adwindow-detailpane");
		
		addEventListener(LayoutUtils.ON_REDRAW_EVENT, this);		
				
		setId("detailPane");
		
	}
	
	/**
	 * @return selected tab index
	 */
	public int getSelectedIndex() {
		return tabbox.getSelectedIndex();
	}
	
	/**
	 * set selected tab index 
	 * @param curTabIndex
	 */
	public void setSelectedIndex(int curTabIndex) {
		tabbox.setSelectedIndex(curTabIndex);
		prevSelectedIndex = curTabIndex;
	}
	
	/**
	 * @return number of tabs
	 */
	public int getTabcount() {
		int count = 0;
		Tabs tabs = tabbox.getTabs();
		if (tabs != null)
			count = tabs.getChildren().size();
		return count;
	}
	
	/**
	 * undo last tab selection
	 */
	public void undoLastTabSelection() {
		tabbox.setSelectedIndex(prevSelectedIndex);
	}

	/**
	 * redraw tabbox
	 */
	public void refresh() {
		tabbox.invalidate();
	}
	
	/**
	 * replace of add
	 * @param index
	 * @param tabPanel
	 * @param tabLabel
	 */
	public void setADTabpanel(int index, IADTabpanel tabPanel, ADTabLabel tabLabel) {
		if (index < getTabcount()) {
			tabbox.getTabpanel(index).appendChild(tabPanel);
		} else {
			addADTabpanel(tabPanel, tabLabel);
		}
	}
	
	/**
	 * replace or add
	 * @param index
	 * @param tabPanel
	 * @param tabLabel
	 * @param enabled
	 */
	public void setADTabpanel(int index, IADTabpanel tabPanel, ADTabLabel tabLabel, boolean enabled) {
		if (index < getTabcount()) {
			tabbox.getTabpanel(index).appendChild(tabPanel);
		} else {
			addADTabpanel(tabPanel, tabLabel, enabled);
		}
	}
	
	/**
	 * 
	 * @param tabPanel
	 * @param tabLabel
	 */
	public void addADTabpanel(IADTabpanel tabPanel, ADTabLabel tabLabel) {
		addADTabpanel(tabPanel, tabLabel, true);
	}
	
	/**
	 * 
	 * @param tabPanel
	 * @param tabLabel
	 * @param enabled
	 */
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
		
		tab.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Tab tab = (Tab) event.getTarget();
				if (!tab.isSelected()) 
					return;
				
				if (Executions.getCurrent().getAttribute(TABBOX_ONSELECT_ATTRIBUTE) != null)
					return;
							
				org.zkoss.zul.Tabpanel zkTabpanel = tab.getLinkedPanel();
				IADTabpanel adtab = null;
				for(Component c : zkTabpanel.getChildren()) {
					if (c instanceof IADTabpanel) {
						adtab = (IADTabpanel) c;
						break;
					}
				}
				if (adtab != null && adtab.isDetailPaneMode()) {
					onEdit(adtab.getGridTab().isSingleRow());
				}
			}
		});
		
		Tabpanels tabpanels = tabbox.getTabpanels();
		if (tabpanels == null) {
			tabpanels = new Tabpanels();
			ZKUpdateUtil.setWidth(tabpanels, "100%");
			tabbox.appendChild(tabpanels);
		}
		Tabpanel tp = new Tabpanel();
		tabpanels.appendChild(tp);
		tp.setSclass("adwindow-detailpane-tabpanel");
		ToolBar toolbar = new ToolBar();
		tp.appendChild(toolbar);
		btnNew = new ToolBarButton();		
		btnNew.setImage(ThemeManager.getThemeResource(NEW_IMAGE));
		btnNew.setId(BTN_NEW_ID);
		btnNew.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				onNew();
			}
		});
		btnNew.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "New")) + "    Shift+Alt+N");
        buttons.put(BTN_NEW_ID.substring(3, BTN_NEW_ID.length()), btnNew);
		
		ToolBarButton button = new ToolBarButton();
		
		button = new ToolBarButton();
		button.setImage(ThemeManager.getThemeResource(EDIT_IMAGE));
		button.setId(BTN_EDIT_ID);
		button.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				onEdit(true);
			}
		});
		button.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "EditRecord")));
        buttons.put(BTN_EDIT_ID.substring(3, BTN_EDIT_ID.length()), button);

		button = new ToolBarButton();
		button.setImage(ThemeManager.getThemeResource(DELETE_IMAGE));
		button.setId(BTN_DELETE_ID);
		button.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Event openEvent = new Event(ON_DELETE_EVENT, DetailPane.this);
				eventListener.onEvent(openEvent);
			}
		});
		button.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Delete")));
        buttons.put(BTN_DELETE_ID.substring(3, BTN_DELETE_ID.length()), button);

		button = new ToolBarButton();
		button.setImage(ThemeManager.getThemeResource(SAVE_IMAGE));
		button.setId(BTN_SAVE_ID);
		button.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Event openEvent = new Event(ON_SAVE_EVENT, DetailPane.this);
				eventListener.onEvent(openEvent);
			}
		});
		button.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Save")));
        buttons.put(BTN_SAVE_ID.substring(3, BTN_SAVE_ID.length()), button);

		
		if (!tabPanel.getGridTab().isSortTab()) {
			button = new ToolBarButton();
			button.setImage(ThemeManager.getThemeResource(PROCESS_IMAGE));
			button.setId(BTN_PROCESS_ID);
			button.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
				@Override
				public void onEvent(Event event) throws Exception {
					onProcess(event.getTarget());
				}
			});
			button.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Process")));
	        buttons.put(BTN_PROCESS_ID.substring(3, BTN_PROCESS_ID.length()), button);
		}
		
		MToolBarButton[] officialButtons = MToolBarButton.getToolbarButtons("D", null);
		for (MToolBarButton toolbarButton : officialButtons) {
			if ( !toolbarButton.isActive() ) {
				buttons.remove(toolbarButton.getComponentName());
			} else {
				if ( toolbarButton.isCustomization() ) {
					String actionId = toolbarButton.getActionClassName();
					IServiceHolder<IAction> serviceHolder = Actions.getAction(actionId);
					if ( serviceHolder != null && serviceHolder.getService() != null ) {

						String labelKey = actionId + ".label";
						String tooltipKey = actionId + ".tooltip";
						String label = Msg.getMsg(Env.getCtx(), labelKey);
						String tooltiptext = Msg.getMsg(Env.getCtx(), tooltipKey);
						if ( labelKey.equals(label) ) {
							label = toolbarButton.getName();
						}
						if ( tooltipKey.equals(tooltiptext) ) {
							tooltipKey = null;
						}
						ToolBarButton btn = new ToolBarButton();
						btn.setName("Btn"+toolbarButton.getComponentName());
						btn.setId("Btn"+toolbarButton.getComponentName());
						btn.setTooltiptext(tooltiptext);
						btn.setDisabled(false);

						AImage aImage = Actions.getActionImage(actionId);
						if ( aImage != null ) {
							btn.setImageContent(aImage);
						} else {
							btn.setLabel(label);
						}

						ToolbarCustomButton toolbarCustomBtn = new ToolbarCustomButton(toolbarButton, btn, actionId, tabPanel.getGridTab().getWindowNo());
						toolbarCustomButtons.add(toolbarCustomBtn);

						toolbar.appendChild(btn);
					}
				} else {
					if (buttons.get(toolbarButton.getComponentName()) != null) {
						toolbar.appendChild(buttons.get(toolbarButton.getComponentName()));
						if (toolbarButton.isAddSeparator()) {
							toolbar.appendChild(new Separator("vertical"));
						}
					}
				}
			}
		}
		
		Hbox messageContainer = new Hbox();
		messageContainer.setPack("end");
		messageContainer.setAlign("center");
		messageContainer.setSclass("adwindow-detailpane-message");
		messageContainer.setId("messages");
		
		toolbar.appendChild(messageContainer);
		toolbar.setSclass("adwindow-detailpane-toolbar");
		ZKUpdateUtil.setVflex(toolbar, "0");
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
						onEdit(true);
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

	/**
	 * 
	 * @param listener
	 */
	public void setEventListener(EventListener<Event> listener) {
		eventListener = listener;
	}

	/**
	 * remove all tabs and tabpanels
	 */
	public void reset() {
		if (tabbox.getTabs() != null) {
			tabbox.getTabs().getChildren().clear();
		}
		if (tabbox.getTabpanels() != null) {
			tabbox.getTabpanels().getChildren().clear();
		}
			
	}

	/**
	 * @param index
	 * @return adtabpanel at index
	 */
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
	
	/**
	 * 
	 * @return selected adtabpanel
	 */
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

	/**
	 * 
	 * @param status
	 * @param error
	 */
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
    	messageContainer.setSclass(error ? "docstatus-error" : "docstatus-normal");
    	
    	if (status == null || status.trim().length() == 0)
    		return;
    	
    	String labelText = buildLabelText(status);
    	if (error) {
    		Clients.showNotification(buildNotificationText(status), "error", findTabpanel(this), "top_left", 3500, true);
    	}
    	Label label = new Label(labelText);
    	messageContainer.appendChild(label);
    	if (labelText.length() != status.length()) {
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
			
			showPopup(error, status);
		} else if (event.getName().equals(ADTabpanel.ON_DYNAMIC_DISPLAY_EVENT)) {
			if (LayoutUtils.isReallyVisible(this))
				updateProcessToolbar();
		} else if (event.getName().equals(LayoutUtils.ON_REDRAW_EVENT)) {
			ExecutionCtrl ctrl = (ExecutionCtrl) Executions.getCurrent();
			Event evt = ctrl.getNextEvent();
			if (evt != null) {
				Events.sendEvent(evt);
				Events.postEvent(new Event(LayoutUtils.ON_REDRAW_EVENT, this));
				return;
			}
			LayoutUtils.redraw(this);
        } else if (event.getName().equals(Events.ON_CTRL_KEY)) {
        	KeyEvent keyEvent = (KeyEvent) event;
        	if (LayoutUtils.isReallyVisible(this)) {
	        	//filter same key event that is too close
	        	//firefox fire key event twice when grid is visible
	        	long time = System.currentTimeMillis();
	        	if (prevKeyEvent != null && prevKeyEventTime > 0 &&
	        			prevKeyEvent.getKeyCode() == keyEvent.getKeyCode() &&
	    				prevKeyEvent.getTarget() == keyEvent.getTarget() &&
	    				prevKeyEvent.isAltKey() == keyEvent.isAltKey() &&
	    				prevKeyEvent.isCtrlKey() == keyEvent.isCtrlKey() &&
	    				prevKeyEvent.isShiftKey() == keyEvent.isShiftKey()) {
	        		if ((time - prevKeyEventTime) <= 300) {
	        			return;
	        		}
	        	}
	        	this.onCtrlKeyEvent(keyEvent);
        	}
		}
	}
	
	protected void createPopupContent(String status) {
		Text t = new Text(status);
		msgPopupCnt.getChildren().clear();
		msgPopupCnt.appendChild(t);
	}
	
	private void showPopup(boolean error, String msg) {		
		Clients.showNotification(buildNotificationText(msg), "error", findTabpanel(this), "at_pointer", 3500, true);
	}
	
	private void createPopup() {
		msgPopupCnt = new Div();
		ZKUpdateUtil.setVflex(msgPopupCnt, "1");

		
		msgPopup = new Window();
		msgPopup.setVisible(false);
		msgPopup.setBorder(true);
		msgPopup.setClosable(true);
		msgPopup.setSizable(true);
		msgPopup.setContentStyle("overflow: auto");
		ZKUpdateUtil.setWidth(msgPopup, "500px");
        msgPopup.appendChild(msgPopupCnt);
        msgPopup.setPage(SessionManager.getAppDesktop().getComponent().getPage());
        msgPopup.setShadow(true);
	}
	
	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		if (msgPopup != null)
			msgPopup.detach();
		try {
			SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, this);
		} catch (Exception e){}
	}

	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null) {
			SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
		}
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.HtmlBasedComponent#setVflex(java.lang.String)
	 */
	@Override
	public void setVflex(String flex) {
		if (getHeight() != null)
			setHeight(null);
		super.setVflex(flex);
		ZKUpdateUtil.setVflex(tabbox, flex);
	}

	/**
	 * update toolbar button state 
	 * @param changed
	 * @param readOnly
	 */
	public void updateToolbar(boolean changed, boolean readOnly) {
		int index = getSelectedIndex();
		if (index < 0 || index >= getTabcount()) return;
		
		Tabpanel tabpanel = tabbox.getTabpanel(index);
		Toolbar toolbar = (Toolbar) tabpanel.getFirstChild();
		
		IADTabpanel adtab = getADTabpanel(index);
		if (adtab == null)
			return;
		if (adtab.getGridTab().isSortTab() || adtab.getGridTab().isReadOnly())
			readOnly = true;
		
		boolean insertRecord = !readOnly;
    	boolean deleteRecord = !readOnly;

		if (insertRecord)
        {
            insertRecord = adtab.getGridTab().isInsertRecord();
        }
        boolean enableNew = !changed && insertRecord && !adtab.getGridTab().isSortTab();
		if (deleteRecord)
        {
			deleteRecord = adtab.getGridTab().isDeleteRecord();
        }
        boolean enableDelete = !changed && deleteRecord && !adtab.getGridTab().isSortTab();
        
        ADWindow adwindow = ADWindow.findADWindow(this);
        if (adwindow == null)
        	return;
        List<String> tabRestrictList = adwindow.getTabToolbarRestrictList(adtab.getGridTab().getAD_Tab_ID());
        List<String> windowRestrictList = adwindow.getWindowToolbarRestrictList();
        
        for(Component c : toolbar.getChildren()) {
        	if (c instanceof ToolBarButton) {
        		ToolBarButton btn = (ToolBarButton) c;
        		if (BTN_NEW_ID.equals(btn.getId())) {
        			btn.setDisabled(!enableNew);
        		} else if (BTN_DELETE_ID.equals(btn.getId())) {
        			btn.setDisabled(!enableDelete);
        		} else if (BTN_EDIT_ID.equals(btn.getId())) {
        			btn.setDisabled(false);
        		} else if (BTN_SAVE_ID.equals(btn.getId())) {
         			btn.setDisabled(false);
         		}
        		if (windowRestrictList.contains(btn.getId())) {
        			btn.setVisible(false);
        		} else if (tabRestrictList.contains(btn.getId())) {
        			btn.setVisible(false);
        		} else {
        			btn.setVisible(true);
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
		if (adtab == null) return;
		
		String processImage = ThemeManager.getThemeResource(PROCESS_IMAGE);
        for(Component c : toolbar.getChildren()) {
        	if (c instanceof ToolBarButton) {
        		ToolBarButton btn = (ToolBarButton) c;
        		if (processImage.equals(btn.getImage())) {
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

	/**
	 * Edit current record
	 * @param formView
	 * @throws Exception
	 */
	public void onEdit(boolean formView) throws Exception {
		Event openEvent = new Event(ON_EDIT_EVENT, DetailPane.this, Boolean.valueOf(formView));
		eventListener.onEvent(openEvent);
	}

	/**
	 * fire the on activate detail event
	 */
	public void fireActivateDetailEvent() {
		int index = tabbox.getSelectedIndex();
		IADTabpanel tabPanel = (IADTabpanel) tabbox.getTabpanel(index).getChildren().get(1);
		Event activateEvent = new Event(ON_ACTIVATE_DETAIL_EVENT, tabPanel, prevSelectedIndex);
		Events.sendEvent(activateEvent);
	}

	/**
	 * @param tabIndex
	 * @param visible
	 */
	public void setTabVisibility(int tabIndex, boolean visible) {
		if (tabIndex < 0 || tabbox.getTabs() == null || tabIndex >= tabbox.getTabs().getChildren().size())
			return;
		
		Tab tab = (Tab) tabbox.getTabs().getChildren().get(tabIndex);
		tab.setVisible(visible);
		if (tab.isSelected()) {
			tab.setSelected(false);
		}
		if (tab.getLinkedPanel() != null) {
			tab.getLinkedPanel().setVisible(visible);
		}
	}
	
	/**
	 * 
	 * @param tabIndex
	 * @return true if tab at tabIndex is visible
	 */
	public boolean isTabVisible(int tabIndex) {
		if (tabIndex < 0 || tabbox.getTabs() == null || tabIndex >= tabbox.getTabs().getChildren().size())
			return false;
		
		return tabbox.getTabs().getChildren().get(tabIndex).isVisible();
	}
	
	/**
	 * @param tabIndex
	 * @return true if tab at tabIndex is enable
	 */
	public boolean isTabEnabled(int tabIndex) {
		if (tabIndex < 0 || tabbox.getTabs() == null || tabIndex >= tabbox.getTabs().getChildren().size())
			return false;
		
		Tab tab = (Tab) tabbox.getTabs().getChildren().get(tabIndex);
		return !tab.isDisabled();
	}
	
	/**
	 * 
	 * @param tabIndex
	 * @param enabled
	 */
	public void setTabEnabled(int tabIndex, boolean enabled) {
		if (tabIndex < 0 || tabbox.getTabs() == null || tabIndex >= tabbox.getTabs().getChildren().size())
			return;
		
		Tab tab = (Tab) tabbox.getTabs().getChildren().get(tabIndex);
		tab.setDisabled(!enabled);
	}
	
	/**
	 * disable toolbar
	 */
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
	
	private Component findTabpanel(Component comp) {
		Component parent = comp.getParent();
		while (parent != null) {
			if (parent instanceof Tabpanel)
				return parent;
			
			parent = parent.getParent();
		}
		return null;
	}

	public void onNew() throws Exception {
		Event openEvent = new Event(ON_NEW_EVENT, DetailPane.this);
		eventListener.onEvent(openEvent);
	}

    public static final int VK_N              = 0x4E;
	private void onCtrlKeyEvent(KeyEvent keyEvent) {
		ToolBarButton btn = null;
		if (keyEvent.isAltKey() && !keyEvent.isCtrlKey() && keyEvent.isShiftKey()) { // Shift+Alt key
			if (keyEvent.getKeyCode() == VK_N) { // Shift+Alt+N
				btn = btnNew;
			}
		}
		if (btn != null) {
			prevKeyEventTime = System.currentTimeMillis();
        	prevKeyEvent = keyEvent;
			keyEvent.stopPropagation();
			if (!btn.isDisabled() && btn.isVisible()) {
				Events.sendEvent(btn, new Event(Events.ON_CLICK, btn));
				//client side script to close combobox popup
				String script = "var w=zk.Widget.$('#" + btn.getUuid()+"'); " +
						"zWatch.fire('onFloatUp', w);";
				Clients.response(new AuScript(script));
			}
		}
	}

}
