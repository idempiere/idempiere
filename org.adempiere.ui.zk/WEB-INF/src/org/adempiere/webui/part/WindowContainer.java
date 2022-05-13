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

package org.adempiere.webui.part;

import java.util.List;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.adwindow.AbstractADWindowContent;
import org.adempiere.webui.apps.ProcessDialog;
import org.adempiere.webui.component.Menupopup;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tab.DecorateInfo;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.ToolBar;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.desktop.TabbedDesktop;
import org.adempiere.webui.panel.IHelpContext;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.ZkReportViewer;
import org.compiere.model.MSysConfig;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.event.OpenEvent;
import org.zkoss.zk.ui.event.SwipeEvent;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Style;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class WindowContainer extends AbstractUIPart implements EventListener<Event>
{
	private static final String OPTION_CLOSE = "Close";
	private static final String OPTION_CLOSE_OTHER_WINDOWS = "CloseOtherWindows";
	private static final String OPTION_CLOSE_WINDOWS_TO_THE_LEFT = "CloseWindowsToTheLeft";
	private static final String OPTION_CLOSE_WINDOWS_TO_THE_RIGHT = "CloseWindowsToTheRight";
	private static final String OPTION_CLOSE_ALL_WINDOWS = "CloseAllWindows";

	public static final String ON_MOBILE_SET_SELECTED_TAB = "onMobileSetSelectedTab";

	private static final String ON_AFTER_TAB_CLOSE = "onAfterTabClose";

	private static final String ON_DEFER_SET_SELECTED_TAB = "onDeferSetSelectedTab";

	public static final String ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT = "onWindowContainerSelectionChanged";
	
	public static final String DEFER_SET_SELECTED_TAB = "deferSetSelectedTab";
	
	private static final int DEFAULT_MAX_TITLE_LENGTH = 30;
    
    private Tabbox  tabbox;
    private ToolBar toolbar;
    private ToolBarButton tabListBtn;

    public WindowContainer()
    {
    }
    
    /**
     * 
     * @param tb
     * @return WindowContainer
     */
    public static WindowContainer createFrom(Tabbox tb) 
    {
    	WindowContainer wc = new WindowContainer();
    	wc.tabbox = tb;
    	
    	return wc;
    }

    protected Component doCreatePart(Component parent)
    {
    	if (isDesktopAutoShrinkTabTitle())
    	{
    		//style to enable auto shrink tab title and hide tab scroll buttons
    		Style style = new Style();
    		style.setContent(".desktop-tabbox > .z-tabs > .z-tabs-content {display:flex;width: auto !important;} "
    				+ ".desktop-tabbox > .z-tabs > .z-tabs-content > .z-tab {text-overflow: ellipsis;flex-shrink: 1;flex-basis: auto;min-width: 70px;} "
    				+ ".desktop-tabbox.z-tabbox > .z-tabbox-icon.z-tabbox-left-scroll,"
    				+ ".desktop-tabbox.z-tabbox > .z-tabbox-icon.z-tabbox-right-scroll {color:transparent;border:none;background:none;width:0px;} "
    				+ ".desktop-tabbox.z-tabbox-scroll > .z-tabs {margin:0px;} ");
    		parent.getParent().getParent().appendChild(style);    		
    	}
    	
        tabbox = new Tabbox();
        tabbox.addEventListener("onPageAttached", this);
        tabbox.addEventListener("onPageDetached", this);
        tabbox.setSupportTabDragDrop(!isMobile());
        tabbox.setActiveBySeq(true);
        tabbox.setCheckVisibleOnlyForNextActive(!isMobile());
        tabbox.setSclass("desktop-tabbox");
        tabbox.setId("desktop_tabbox");
        tabbox.setMaximalHeight(true);
        tabbox.addEventListener(ON_DEFER_SET_SELECTED_TAB, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				Tab tab = (Tab) event.getData();
				if (tab != null)
					setSelectedTab(tab);
			}
		});
        tabbox.addEventListener(ON_AFTER_TAB_CLOSE, evt -> {
        	if (isMobile()) {
	        	updateMobileTabState(tabbox.getSelectedTab());	        	
        	}
        	if (isShowTabList()) {
        		updateTabListButton();
        	}
        });
        
        Tabpanels tabpanels = new Tabpanels();
        Tabs tabs = new Tabs();
        //fix tabs scrolling issue for multiple tabs + tab toolbar
        //not needed for mobile since mobile only show one tab at a time
        if (!isMobile())
        {
	        StringBuilder f = new StringBuilder();
	        f.append("function(way, tb) {\n")
	         .append("  let tabbox = this.getTabbox();let tabs = this.$n();\n")
	         .append("  this.$_scrollcheck(way,tb);\n")
	         .append("  if (tabs && !tabbox.isVertical() && !tabbox.inAccordionMold()) {\n")
	         .append("    this.__offsetWidth=tabs.offsetWidth;this.__scrollLeft=tabs.scrollLeft;\n")
	         .append("    this.__selectedIndex=tabbox.getSelectedIndex();\n")
	         .append("    this.__selectedTab=tabbox.getSelectedTab();\n")
	         .append("  } else {\n")
	         .append("    this.__offsetWidth=this.__scrollLeft==0;this.__selectedTab=null;this.__selectedIndex=-1;\n")
	         .append("  }\n")
	         .append("}");
	        tabs.setWidgetOverride("_scrollcheck", f.toString());
	        f = new StringBuilder();
	        f.append("function (toSel) {\n")
	         .append("  let tabbox = this.getTabbox();\n")
	         .append("  let tabs = this.$n();\n")
	         .append("  let tabsOffsetWidth=tabs.offsetWidth;\n")
	         .append("  this.$_fixWidth(toSel);\n")
	         .append("  if(this.__selectedTab && this.__selectedTab == tabbox.getSelectedTab() && this.__selectedIndex == tabbox.getSelectedIndex()) {\n")         
	         .append("    if(tabs.offsetWidth == this.__offsetWidth) {\n")
	         .append("      if(tabsOffsetWidth != this.__offsetWidth && tabs.scrollLeft != this.__scrollLeft) {\n")
	         .append("        this._fixTabsScrollLeft(this.__scrollLeft);\n")
	         .append("      }\n")
	         .append("    }\n")
	         .append("  }\n")
	         .append("}");
	        tabs.setWidgetOverride("_fixWidth", f.toString());
	        //change _doScroll to immediate
	        f = new StringBuilder();
	        f.append("function (to, move) {\n")
	         .append("  if (move <= 0) return;\n")
	         .append("  let self=this,tabs = this.$n();\n")
	         .append("  switch (to) {\n")
	         .append("  case 'right':\n")
	         .append("    self._fixTabsScrollLeft(self._tabsScrollLeft + move);break;")
	         .append("  case 'left':\n")
	         .append("    self._fixTabsScrollLeft(self._tabsScrollLeft - move);break;")
	         .append("  case 'up':\n")
	         .append("    self._fixTabsScrollTop(self._tabsScrollTop - move);break;")
	         .append("  default:\n")
	         .append("    self._fixTabsScrollTop(self._tabsScrollTop + move);\n")
	         .append("  }\n")
	         .append("  let tabsScrollLeft = self._tabsScrollLeft, tabsScrollTop = self._tabsScrollTop;\n")
	         .append("  self._fixTabsScrollLeft(tabsScrollLeft <= 0 ? 0 : tabsScrollLeft);\n")
	         .append("  self._fixTabsScrollTop(tabsScrollTop <= 0 ? 0 : tabsScrollTop);\n")
	         .append("}");
	        tabs.setWidgetOverride("_doScroll", f.toString());
        }

        tabbox.appendChild(tabs);
        tabbox.appendChild(tabpanels);
        ZKUpdateUtil.setWidth(tabbox, "100%");
        ZKUpdateUtil.setHeight(tabbox, "100%");
        ZKUpdateUtil.setVflex(tabbox, "1");
        ZKUpdateUtil.setHflex(tabbox, "1");
        
        tabbox.setParent(parent);
        
        toolbar = new ToolBar();
        toolbar.setSclass("window-container-toolbar");
        tabbox.appendChild(toolbar);
                            
        if (isShowHomeButton())
        {
        	ToolBarButton homeButton = new ToolBarButton();
        	if (ThemeManager.isUseFontIconForImage())
        		homeButton.setIconSclass("z-icon-Home");
        	else
        		homeButton.setImage(ThemeManager.getThemeResource("images/Home16.png"));
        	homeButton.setSclass("window-container-toolbar-btn");
        	homeButton.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Home")));
        	homeButton.addEventListener(Events.ON_CLICK, evt -> setSelectedTab(tabbox.getTabpanel(0).getLinkedTab()));
        	toolbar.appendChild(homeButton);
        }
        
        if (isShowTabList())
        {        	        	
        	tabListBtn = new ToolBarButton();
        	if (ThemeManager.isUseFontIconForImage()) 
        	{
        		tabListBtn.setIconSclass("z-icon-Expand");
        	} 
        	else 
        	{
        		tabListBtn.setImage(ThemeManager.getThemeResource("images/expand-header.png"));
        	}
        	tabListBtn.setSclass("window-container-toolbar-btn tab-list");
        	tabListBtn.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "ShowAllWindow")) + "   Alt+W");
        	tabListBtn.addEventListener(Events.ON_CLICK, evt -> showTabList());
        	tabListBtn.setVisible(false);
        	toolbar.appendChild(tabListBtn);        	        	 
        }
        
        SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, (KeyEvent e) -> onCtrlKey(e));
        
        return tabbox;
    }
    
    private void onCtrlKey(KeyEvent e) {
    	//alt+w
		if (e.isAltKey() && !e.isCtrlKey() && !e.isShiftKey()) {
			if (e.getKeyCode() == 87) {
				if (tabListBtn != null && tabListBtn.isVisible())
					Events.postEvent(Events.ON_CLICK, tabListBtn, null);
			}
		}
	}

	private boolean isShowHomeButton() {
		return isMobile() || isDesktopShowHomeButton();
	}

	private boolean isDesktopShowHomeButton() {
		return MSysConfig.getBooleanValue(MSysConfig.ZK_DESKTOP_SHOW_HOME_BUTTON, true, Env.getAD_Client_ID(Env.getCtx()));
	}

	private boolean isShowTabList() {
		return isMobile() || isDesktopAutoShrinkTabTitle() || isDesktopShowTabList();
	}

	private boolean isDesktopShowTabList() {
		return MSysConfig.getBooleanValue(MSysConfig.ZK_DESKTOP_SHOW_TAB_LIST_BUTTON, true, Env.getAD_Client_ID(Env.getCtx()));
	}

	private boolean isDesktopAutoShrinkTabTitle() {
		return MSysConfig.getBooleanValue(MSysConfig.ZK_DESKTOP_TAB_AUTO_SHRINK_TO_FIT, false, Env.getAD_Client_ID(Env.getCtx()));
	}

	private void showTabList() {
		org.zkoss.zul.Tabs tabs = tabbox.getTabs();
		List<Component> list = tabs.getChildren();
		Menupopup popup = new Menupopup();
		for(int i = 1; i < list.size(); i++) {
			Tab tab = (Tab) list.get(i);
			Menuitem item = new Menuitem(tab.getLabel().endsWith("...") && !Util.isEmpty(tab.getTooltiptext(), true) ? tab.getTooltiptext() : tab.getLabel());
			item.setValue(Integer.toString(i));
			if (!Util.isEmpty(tab.getTooltiptext(), true) && !(item.getLabel().equals(tab.getTooltiptext())))
				item.setTooltiptext(tab.getTooltiptext());
			if (i == tabbox.getSelectedIndex())
				item.setSclass("selected");
			popup.appendChild(item);
			item.addEventListener(Events.ON_CLICK, evt -> {
				Menuitem t = (Menuitem) evt.getTarget();
				String s = t.getValue();
				Integer ti = Integer.parseInt(s);
				setSelectedTab(tabbox.getTabpanel(ti.intValue()).getLinkedTab());				
			});
		}
		popup.setPage(tabbox.getPage());
		popup.open(tabListBtn, "after_start");
	}

	/**
     * @deprecated keep for compatible, replace by {@link #addWindow(Component, String, boolean, DecorateInfo)}
     * @param comp
     * @param title
     * @param closeable
     * @return
     */
    public Tab addWindow(Component comp, String title, boolean closeable){
    	return addWindow(comp, title, closeable, true, null);
    }
    
    /**
     * @deprecated keep for compatible, replace by {@link #addWindow(Component, String, boolean, boolean, DecorateInfo)}
     * @param comp
     * @param title
     * @param closeable
     * @param enable
     * @return
     */
    public Tab addWindow(Component comp, String title, boolean closeable, boolean enable) {
    	return addWindow(comp, title, closeable, true, null);
    }
    
    /**
     * @deprecated keep for compatible, replace by {@link #insertBefore(Tab, Component, String, boolean, boolean, DecorateInfo)}
     * @param refTab
     * @param comp
     * @param title
     * @param closeable
     * @param enable
     * @return
     */
    public Tab insertBefore(Tab refTab, Component comp, String title, boolean closeable, boolean enable){
    	return insertBefore(refTab, comp, title, closeable, enable, null);
    }
    
    /**
     * @deprecated keep for compatible, replace by {@link #insertAfter(Tab, Component, String, boolean, boolean, DecorateInfo)}
     * @param refTab
     * @param comp
     * @param title
     * @param closeable
     * @param enable
     * @return
     */
    public Tab insertAfter(Tab refTab, Component comp, String title, boolean closeable, boolean enable){
    	return insertAfter(refTab, comp, title, closeable, enable, null);
    }
    /**
     * 
     * @param comp
     * @param title
     * @param closeable
     */
    public Tab addWindow(Component comp, String title, boolean closeable, DecorateInfo decorateInfo)
    {
        return addWindow(comp, title, closeable, true, decorateInfo);
    }
    
    /**
     * 
     * @param comp
     * @param title
     * @param closeable
     * @param enable
     */
    public Tab addWindow(Component comp, String title, boolean closeable, boolean enable, DecorateInfo decorateInfo) 
    {
    	return insertBefore(null, comp, title, closeable, enable, decorateInfo);
    }
    
    /**
     * 
     * @param refTab
     * @param comp
     * @param title
     * @param closeable
     * @param enable
     */
    public Tab insertBefore(Tab refTab, Component comp, String title, boolean closeable, boolean enable, DecorateInfo decorateInfo)
    {
        final Menupopup popupClose = new Menupopup();
        final Tab tab = new Tab() {
        	/**
			 * 
			 */
			private static final long serialVersionUID = 2387473442130217806L;

			@Override
        	public void close() {
        		super.close();
        		popupClose.detach();
        		popupClose.removeEventListener(Events.ON_OPEN, WindowContainer.this);
        	}

			@Override
			public void onPageDetached(Page page) {
				super.onPageDetached(page);
				if (tabbox != null && tabbox.getPage() != null) {
					Events.postEvent(ON_AFTER_TAB_CLOSE, tabbox, null);
				}
			}        	
        };
        popupClose.addEventListener(Events.ON_OPEN, this);
        popupClose.setAttribute("tab", tab);
        tab.setDecorateInfo(decorateInfo);
        if (title != null) 
        {
	        setTabTitle(title, tab);
        }
        tab.setClosable(closeable);
        tab.addEventListener(Events.ON_SWIPE, new EventListener<SwipeEvent>() {

			@Override
			public void onEvent(SwipeEvent event) throws Exception {
				Tab tab = (Tab) event.getTarget();
				if (tab.isClosable() 
					&& ("right".equals(event.getSwipeDirection()) || "left".equals(event.getSwipeDirection()))) {
					tab.onClose();
				}
			}
		});
        
        // fix scroll position lost coming back into a grid view tab
        tab.addEventListener(Events.ON_SELECT, new EventListener<Event>() {
			public void onEvent(Event event) throws Exception {
				Tab tab = (Tab)event.getTarget();
				org.zkoss.zul.Tabpanel panel = tab.getLinkedPanel();
				if (panel == null) {
					System.console().printf("error");
				}
				Component component = panel.getFirstChild();
				if (component != null && component.getAttribute(ITabOnSelectHandler.ATTRIBUTE_KEY) instanceof ITabOnSelectHandler)
				{
					ITabOnSelectHandler handler = (ITabOnSelectHandler) component.getAttribute(ITabOnSelectHandler.ATTRIBUTE_KEY);
					handler.onSelect();
				}
				
				if (component instanceof IHelpContext)
					Events.sendEvent(new Event(ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT, component));
				else
					SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Home, 0);
			}
		});
        //disable text selection of tab label on mobile to
        //fix conflict with long press context menu
        if (ClientInfo.isMobile())
        	tab.setClientAttribute("onselectstart", "return false");
        
        Tabpanel tabpanel = null;
        if (comp instanceof Tabpanel) {
        	tabpanel = (Tabpanel) comp;
        } else {
        	tabpanel = new Tabpanel();
        	tabpanel.appendChild(comp);
        }                
        ZKUpdateUtil.setHeight(tabpanel, "100%");
        ZKUpdateUtil.setWidth(tabpanel, "100%");
        ZKUpdateUtil.setVflex(tabpanel, "1");
        ZKUpdateUtil.setHflex(tabpanel, "1");
        tabpanel.setSclass("desktop-tabpanel");
        
        if (refTab == null)  
        {
        	tabbox.getTabs().appendChild(tab);
        	tabbox.getTabpanels().appendChild(tabpanel);
        }
        else
        {
        	org.zkoss.zul.Tabpanel refpanel = refTab.getLinkedPanel();
        	tabbox.getTabs().insertBefore(tab, refTab);
        	tabbox.getTabpanels().insertBefore(tabpanel, refpanel);
        }

        if (enable)
        {
        	Boolean b = (Boolean) comp.getAttribute(DEFER_SET_SELECTED_TAB);
        	if (b != null && b.booleanValue())
        		Events.echoEvent(ON_DEFER_SET_SELECTED_TAB, tabbox, tab);
        	else
        		setSelectedTab(tab);
        }

        Menuitem mi;
        if (tab.getIndex() != 0) {
        	mi = new Menuitem(Msg.getMsg(Env.getCtx(), OPTION_CLOSE));
        	mi.setAttribute("option", OPTION_CLOSE);
        	popupClose.appendChild(mi);
        	mi.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
        		public void onEvent(Event event) throws Exception {
        			int currentTabIndex = tab.getIndex();
        			int focusTabIndex = currentTabIndex;
        			int tabsSizeBeforeClose = tabbox.getTabs().getChildren().size();
        			if (tabsSizeBeforeClose == currentTabIndex + 1) {
        				focusTabIndex = currentTabIndex - 1;
        			}
        			closeTabs(tab, currentTabIndex, currentTabIndex, focusTabIndex);
        		}
        	});

        	mi = new Menuitem(Msg.getMsg(Env.getCtx(), OPTION_CLOSE_OTHER_WINDOWS));
        	mi.setAttribute("option", OPTION_CLOSE_OTHER_WINDOWS);
        	popupClose.appendChild(mi);
        	mi.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
        		public void onEvent(Event event) throws Exception {
        			int currentTabIndex = tab.getIndex();
        			closeTabs(tab, currentTabIndex + 1, -1, currentTabIndex); // Right
        			int focusTabIndex = 1;
        			closeTabs(tab, 1, currentTabIndex - 1, focusTabIndex); // Left
        		}
        	});

        	mi = new Menuitem(Msg.getMsg(Env.getCtx(), OPTION_CLOSE_WINDOWS_TO_THE_LEFT));
        	mi.setAttribute("option", OPTION_CLOSE_WINDOWS_TO_THE_LEFT);
        	popupClose.appendChild(mi);
        	mi.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
        		public void onEvent(Event event) throws Exception {
        			int currentTabIndex = tab.getIndex();
        			int focusTabIndex = 1;
        			closeTabs(tab, 1, currentTabIndex - 1, focusTabIndex);
        		}
        	});

        	mi = new Menuitem(Msg.getMsg(Env.getCtx(), OPTION_CLOSE_WINDOWS_TO_THE_RIGHT));
        	mi.setAttribute("option", OPTION_CLOSE_WINDOWS_TO_THE_RIGHT);
        	popupClose.appendChild(mi);
        	mi.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
        		public void onEvent(Event event) throws Exception {
        			int currentTabIndex = tab.getIndex();
        			closeTabs(tab, currentTabIndex + 1, -1, currentTabIndex);
        		}
        	});
        }

        mi = new Menuitem(Msg.getMsg(Env.getCtx(), OPTION_CLOSE_ALL_WINDOWS));
        mi.setAttribute("option", OPTION_CLOSE_ALL_WINDOWS);
        popupClose.appendChild(mi);
        mi.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
        	public void onEvent(Event event) throws Exception {
        		int focusTabIndex = 0;
        		closeTabs(tab, 1, -1, focusTabIndex);
        	}
        });

        ZKUpdateUtil.setWidth(popupClose, "auto");
        popupClose.setPage(tab.getPage());
        tab.setContext(popupClose);

        if (isShowTabList())
        	updateTabListButton();
        
        return tab;
    }

    protected void closeTabs(Tab tab, int start, int end, int focus) {
    	List<Component> tabs = tabbox.getTabs().getChildren();
    	if (end == -1) {
    		end = tabs.size() - 1;
    	}
    	for (int i = end; i >= start; i--) {
    		((Tab)tabs.get( i )).setSelected(false);
    		((Tab)tabs.get( i )).onClose();
    	}
    	tabbox.setSelectedIndex(focus);
    	Events.postEvent(ON_AFTER_TAB_CLOSE, tabbox, null);
    }

	private void updateTabListButton() {
		if (isShowTabList() && tabListBtn != null) {
			int cnt = tabbox.getTabs().getChildren().size()-1;
			if (cnt > 0) {
				tabListBtn.setLabel(Integer.toString(cnt));
				tabListBtn.setVisible(true);
			} else {
				tabListBtn.setLabel("");
				tabListBtn.setVisible(false);
			}
		}
	}

	public void setTabTitle(String title, int windowNo) {
		setTabTitle(title, getTab(windowNo));
	}

	/**
	 * IDEMPIERE-2333 / getTab - get the tab based on the windowNo
	 * @param windowNo
	 * @return org.zkoss.zul.Tab
	 */
	private org.zkoss.zul.Tab getTab(int windowNo) {
		org.zkoss.zul.Tabpanels panels = tabbox.getTabpanels();
		List<?> childrens = panels.getChildren();
		for (Object child : childrens)
		{
			Tabpanel panel = (Tabpanel) child;
			Component component = panel.getFirstChild();
			Object att = component != null ? component.getAttribute(TabbedDesktop.WINDOWNO_ATTRIBUTE) : null;
			if (att != null && (att instanceof Integer))
			{
				if (windowNo == (Integer)att)
				{
					org.zkoss.zul.Tab tab = panel.getLinkedTab();
					return tab;
				}
			}
		}
		return null;
	}

	public void setTabTitle(String title, org.zkoss.zul.Tab tab) {
		if (tab == null)
			return;
		
		tab.setTooltiptext(title);
		if (title.length() <= getMaxTitleLength()) 
		{
			tab.setLabel(title);
		}
		else
		{			
			title = title.substring(0, getMaxTitleLength()-3) + "...";
			tab.setLabel(title);
		}
	}
    
    private int getMaxTitleLength() {
		return MSysConfig.getIntValue(MSysConfig.ZK_DESKTOP_TAB_MAX_TITLE_LENGTH, DEFAULT_MAX_TITLE_LENGTH, Env.getAD_Client_ID(Env.getCtx()));
	}

	/**
     * 
     * @param refTab
     * @param comp
     * @param title
     * @param closeable
     * @param enable
     */
    public Tab insertAfter(Tab refTab, Component comp, String title, boolean closeable, boolean enable, DecorateInfo decorateInfo)
    {
    	if (refTab == null)
    		return addWindow(comp, title, closeable, enable, decorateInfo);
    	else
    		return insertBefore((Tab)refTab.getNextSibling(), comp, title, closeable, enable, decorateInfo);
    }

    /**
     * IDEMPIERE-5275 - Tabular Report Re-Run button/close parameter window
     * @param refTab 
     * @param comp
     * @param title
     * @return
     */
    public Tab replace(Tab refTab, Window comp, String title) {
    	 
         if (refTab == null)  
         {
         	throw new IllegalArgumentException();
         }
         else
         {
         	org.zkoss.zul.Tabpanel refpanel = refTab.getLinkedPanel();
         	Component firstChild = refpanel.getFirstChild();
         	if(firstChild instanceof Window) {
	     		if(firstChild instanceof ProcessDialog)
	     			((ProcessDialog)firstChild).unlockUI(null);
	     		else if(firstChild instanceof ZkReportViewer)
					((ZkReportViewer)firstChild).hideBusyMask();
				else if(firstChild instanceof AbstractADWindowContent)
					((AbstractADWindowContent)firstChild).hideBusyMask();
	     		((Window) firstChild).onClose();
	     		comp.setParent(refpanel);
         	}
         	else {
         		firstChild.detach();
         		comp.setParent(refpanel);
         	}
         }
         if (title != null) 
         {
 	        setTabTitle(title, refTab);
         }
        return refTab;
    }
    /**
     * 
     * @param tab
     */
    public void setSelectedTab(org.zkoss.zul.Tab tab)
    {
    	if (isMobile())
    		updateMobileTabState(tab);
    	tabbox.setSelectedTab(tab); 
    }

	private void updateMobileTabState(org.zkoss.zul.Tab tab) {
		if (isMobile() && tabListBtn != null)
    	{
    		List<Component> tabs = tabbox.getTabs().getChildren();
    		for(Component c: tabs) {
    			if (c instanceof Tab) {
    				Tab t = (Tab) c;
    				t.setVisible(t == tab);
    				t.getLinkedPanel().setVisible(t == tab);
    				if (t.isVisible()) {
    					Events.postEvent(ON_MOBILE_SET_SELECTED_TAB, t.getLinkedPanel(), null);
    				}
    			}
    		}    		
    	}
	}

    private boolean isMobile() {
		return ClientInfo.isMobile();
	}

	/**
     * 
     * @return true if successfully close the active window
     */
    public boolean closeActiveWindow()
    {
    	Tab tab = (Tab) tabbox.getSelectedTab();
    	tabbox.getSelectedTab().onClose();
    	if (tab.getParent() == null)
    		return true;
    	else
    		return false;
    }
    
    /**
     * 
     * @return Tab
     */
    public Tab getSelectedTab() {
    	return (Tab) tabbox.getSelectedTab();
    }
    
    // Elaine 2008/07/21
    /**
     * @param tabNo
     * @param title
     * @param tooltip 
     */
    public void setTabTitle(int tabNo, String title, String tooltip)
    {
    	org.zkoss.zul.Tabs tabs = tabbox.getTabs();
    	Tab tab = (Tab) tabs.getChildren().get(tabNo);
    	setTabTitle(title, tab);
    	if (tooltip != null && tooltip.trim().length() > 0)
    	{
    		tab.setTooltiptext(tooltip);
    	}
    }
    //

	/**
	 * @return Tabbox
	 */
	public Tabbox getComponent() {
		return tabbox;
	}
	
	/**
	 * @return toolbar
	 */
	public ToolBar getToobar() {
		return toolbar;
	}

	@Override
	public void onEvent(Event event) throws Exception {
		
		if (event.getTarget() == tabbox && "onPageDetached".equals(event.getName())) {
			try {
				SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, this);
			} catch (Exception e) {}
		}else if (event.getTarget() == tabbox && "onPageAttached".equals(event.getName())) {
			try {
				SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
			} catch (Exception e) {}
		}else if (event instanceof OpenEvent && event.getTarget() instanceof Menupopup) {
			if (((OpenEvent)event).isOpen()) {
				Menupopup popup = (Menupopup) event.getTarget();
				List<Component> tabs = tabbox.getTabs().getChildren();
				int tabsSize = tabs.size();
				int currentTabIdx = -1;
				if (popup.getAttribute("tab") != null) {
					Tab currentTab = (Tab) popup.getAttribute("tab");
					for ( int i = tabsSize - 1; i > 0; i-- ) {
						Tab tab = ((Tab)tabs.get(i));
						if (currentTab.equals(tab)) {
							currentTabIdx = i;
							break;
						}
					}
				}
				if (currentTabIdx > 0) {
					List<Component> items = popup.getChildren();
					for (Component item : items) {
						if (item instanceof Menuitem) {
							String option = (String) item.getAttribute("option");
							boolean visible =
									   (OPTION_CLOSE.equals(option))
									|| (tabsSize > 2 && (OPTION_CLOSE_OTHER_WINDOWS.equals(option) || OPTION_CLOSE_ALL_WINDOWS.equals(option)))
									|| (currentTabIdx < tabsSize - 1 && OPTION_CLOSE_WINDOWS_TO_THE_RIGHT.equals(option))
									|| (currentTabIdx > 1 && OPTION_CLOSE_WINDOWS_TO_THE_LEFT.equals(option));
							item.setVisible(visible);
						}
					}
				}
			}
		}else if (Events.ON_CTRL_KEY.equals(event.getName())) {
			KeyEvent keyEvent = (KeyEvent) event;
			if (keyEvent.isAltKey() && keyEvent.getKeyCode() == KeyEvent.PAGE_DOWN
					&& tabbox.getSelectedTab() != null && tabbox.getSelectedTab().getNextSibling() != null) {
				tabbox.setSelectedTab((org.zkoss.zul.Tab)tabbox.getSelectedTab().getNextSibling());
				keyEvent.stopPropagation();
			}else if (keyEvent.isAltKey() && keyEvent.getKeyCode() == KeyEvent.PAGE_UP
					&& tabbox.getSelectedTab() != null && tabbox.getSelectedTab().getPreviousSibling() != null) {
				tabbox.setSelectedTab((org.zkoss.zul.Tab)tabbox.getSelectedTab().getPreviousSibling());
				keyEvent.stopPropagation();
			}
		}
		
	}
}
