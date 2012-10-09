/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *                                                                            *
 * Contributors:                                                              *
 * - Heng Sin Low                                                             *
 *                                                                            *
 * Sponsors:                                                                  *
 * - Idalica Corporation                                                      *
 *****************************************************************************/

package org.adempiere.webui.adwindow;

import java.util.List;
import java.util.Properties;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.panel.ITabOnCloseHandler;
import org.adempiere.webui.part.ITabOnSelectHandler;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.UserPreference;
import org.compiere.model.MQuery;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkforge.keylistener.Keylistener;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.East;
import org.zkoss.zul.North;
import org.zkoss.zul.South;
import org.zkoss.zul.Tab;
import org.zkoss.zul.West;

/**
 *
 * This class is based on org.compiere.apps.APanel written by Jorg Janke.
 * @author Jorg Janke
 *
 * @author <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @author <a href="mailto:hengsin@gmail.com">Low Heng Sin</a>
 * @date Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class ADWindowContent extends AbstractADWindowContent
{
    @SuppressWarnings("unused")
	private static final CLogger logger = CLogger.getCLogger(ADWindowContent.class);

	private Borderlayout layout;

	private Center contentArea;

	private West west;

	private East east;

	private Keylistener keyListener;	

    public ADWindowContent(Properties ctx, int windowNo)
    {
        super(ctx, windowNo);
    }

   	protected Component doCreatePart(Component parent)
    {
        layout = new Borderlayout();
        if (parent != null) {
	        layout.setParent(parent);
	        layout.setSclass("adwindow-layout");
        } else {
        	layout.setPage(page);
        }

        //toolbar
        North n = new North();
        n.setParent(layout);
        n.setCollapsible(false);
        n.setSclass("adwindow-north");
        Div div = new Div();
        div.setHflex("1");
        div.setVflex("1");
        n.appendChild(div);
        toolbar.setParent(div);
        toolbar.setWindowNo(getWindowNo());
        breadCrumb = new BreadCrumb(getWindowNo());
        breadCrumb.setStyle("background-color: #e9e9e9");
        breadCrumb.setToolbarListener(this);
        div.appendChild(breadCrumb);

        //status bar
        South s = new South();
        layout.appendChild(s);
        s.setCollapsible(false);
        s.setSclass("adwindow-south");
        statusBar.setParent(s);
        
        LayoutUtils.addSclass("adwindow-status", statusBar);

        contentArea = new Center();
        contentArea.setParent(layout);
        contentArea.setAutoscroll(true);
        adTabbox.createPart(contentArea);

        if (parent instanceof Tabpanel) {
        	TabOnCloseHanlder handler = new TabOnCloseHanlder();
        	((Tabpanel)parent).setOnCloseHandler(handler);
        }

    	if (keyListener != null)
    		keyListener.detach();
    	keyListener = new Keylistener();
    	statusBar.appendChild(keyListener);
    	keyListener.setCtrlKeys("#f1#f2#f3#f4#f5#f6#f7#f8#f9#f10#f11#f12^f^i^n^s^d@#left@#right@#up@#down@#pgup@#pgdn@p^p@z@x#enter");
    	keyListener.addEventListener(Events.ON_CTRL_KEY, toolbar);
    	keyListener.addEventListener(Events.ON_CTRL_KEY, this);
    	keyListener.setAutoBlur(false);

        layout.setAttribute(ITabOnSelectHandler.ATTRIBUTE_KEY, new ITabOnSelectHandler() {
			public void onSelect() {
				IADTabbox adTab = getADTab();
				if (adTab != null) {
					IADTabpanel iadTabpanel = adTab.getSelectedTabpanel();
					if (iadTabpanel != null && iadTabpanel instanceof ADTabpanel) {
						ADTabpanel adTabpanel = (ADTabpanel) iadTabpanel;
						if (adTabpanel.isGridView()) {
							adTabpanel.getGridView().scrollToCurrentRow();
						}
					}
				}
				getComponent().getParent().invalidate();
			}
		});
        
        return layout;
    }

    protected IADTabbox createADTab()
    {
    	CompositeADTabbox composite = new CompositeADTabbox();
    	return composite;
    }

	public Borderlayout getComponent() {
		return layout;
	}



	@Override
	public boolean initPanel(int adWindowId, MQuery query) {
		boolean retValue = super.initPanel(adWindowId, query);
		if (adTabbox.getTabCount() == 1) {
			if (west != null)
				west.setVisible(false);
			else if (east != null)
				east.setVisible(false);
		}
		return retValue;
	}


	/**
     * @param event
     * @see EventListener#onEvent(Event)
     */
    public void onEvent(Event event) {
    	if (Events.ON_CTRL_KEY.equals(event.getName())) {
    		KeyEvent keyEvent = (KeyEvent) event;
    		//enter == 13
    		if (keyEvent.getKeyCode() == 13 && this.getComponent().getParent().isVisible()) {
    			IADTabpanel panel = adTabbox.getSelectedTabpanel();
    			if (panel != null) {
    				if (panel.onEnterKey()) {
    					keyEvent.stopPropagation();
    				}
    			}
    		}
    	} else {
    		super.onEvent(event);
    	}
    }

	class TabOnCloseHanlder implements ITabOnCloseHandler {

		public void onClose(Tabpanel tabPanel) {
			if (ADWindowContent.this.onExit()) {
				Tab tab = tabPanel.getLinkedTab();
				Tabbox tabbox = (Tabbox) tab.getTabbox();
				if (tabbox.getSelectedTab() == tab) {
					Tabs tabs = (Tabs) tabbox.getTabs();
					List<?> childs = tabs.getChildren();
					for(int i = 0; i < childs.size(); i++) {
						if (childs.get(i) == tab) {
							if (i > 0)
								tabbox.setSelectedIndex((i-1));
							break;
						}
					}
				} else {
					tabbox.getSelectedPanel().invalidate();
				}
				tabPanel.detach();
				tab.detach();
				if (getWindowNo() > 0)
					SessionManager.getAppDesktop().unregisterWindow(getWindowNo());
			}
		}
	}	
}
