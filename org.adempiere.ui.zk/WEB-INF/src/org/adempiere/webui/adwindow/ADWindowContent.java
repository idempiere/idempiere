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

import java.util.Properties;

import org.adempiere.util.Callback;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.panel.IHelpContext;
import org.adempiere.webui.panel.ITabOnCloseHandler;
import org.adempiere.webui.part.WindowContainer;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.X_AD_CtxHelp;
import org.compiere.util.CLogger;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.event.SwipeEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;
import org.zkoss.zul.Tab;
import org.zkoss.zul.Vlayout;

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

    private Vlayout layout;

    private Div contentArea;

	public ADWindowContent(Properties ctx, int windowNo, int adWindowId)
    {
        super(ctx, windowNo, adWindowId);
    }

   	protected Component doCreatePart(Component parent)
    {
   		layout = new ADWindowVlayout(this);
        if (parent != null) {
	        layout.setParent(parent);
	        layout.setSclass("adwindow-layout");
        } else {
        	layout.setPage(page);
        }
        layout.setSpacing("0px");

        //toolbar
        Div north = new Div();
        north.setParent(layout);        
        north.setSclass("adwindow-north");
        Div div = new Div();
        div.setStyle("height: 100%; width: 100%");
        north.appendChild(div);
        ZKUpdateUtil.setVflex(north, "0");
        toolbar.setParent(div);
        toolbar.setWindowNo(getWindowNo());
        breadCrumb = new BreadCrumb(this, getWindowNo());
        breadCrumb.setToolbarListener(this);
        breadCrumb.setId("breadCrumb");
        div.appendChild(breadCrumb);
        div.addEventListener(Events.ON_SWIPE, new EventListener<SwipeEvent>() {
			@Override
			public void onEvent(SwipeEvent event) throws Exception {
				if ("right".equals(event.getSwipeDirection())) {
					ToolBarButton nextBtn = breadCrumb.getNextButton();
					if (!nextBtn.isDisabled()) {
						nextBtn.setDisabled(true);
						String script = "var w=zk.Widget.$('#"+nextBtn.getUuid()+"');" +
								"w.fire('onClick',null,{toServer:true});";
						Clients.response(new AuScript(script));
					}
				} else if ("left".equals(event.getSwipeDirection())) {
					ToolBarButton previousBtn = breadCrumb.getPreviousButton();
					if (!previousBtn.isDisabled()) {
						previousBtn.setDisabled(true);
						String script = "var w=zk.Widget.$('#"+previousBtn.getUuid()+"');" +
								"w.fire('onClick',null,{toServer:true});";
						Clients.response(new AuScript(script));
					}
				} else if ("up".equals(event.getSwipeDirection())) {
					ToolBarButton parentBtn = toolbar.getButton("ParentRecord");
					if (!parentBtn.isDisabled()) {
						parentBtn.setDisabled(true);
						String script = "var w=zk.Widget.$('#"+parentBtn.getUuid()+"');" +
								"w.fire('onClick',null,{toServer:true});";
						Clients.response(new AuScript(script));
					}
				} else if ("down".equals(event.getSwipeDirection())) {
					ToolBarButton detailBtn = toolbar.getButton("DetailRecord");
					if (!detailBtn.isDisabled()) {
						detailBtn.setDisabled(true);
						String script = "var w=zk.Widget.$('#"+detailBtn.getUuid()+"');" +
								"w.fire('onClick',null,{toServer:true});";
						Clients.response(new AuScript(script));
					}
				}
			}
		});
        
        //status bar
        div.appendChild(statusBar);

        LayoutUtils.addSclass("adwindow-status", statusBar);

        contentArea = new Div();
        contentArea.setParent(layout);
        ZKUpdateUtil.setVflex(contentArea, "1");
        ZKUpdateUtil.setHflex(contentArea, "1");
        contentArea.setStyle("overflow: auto;");
        adTabbox.createPart(contentArea);
        
        if (parent instanceof Tabpanel) {
        	TabOnCloseHanlder handler = new TabOnCloseHanlder();
        	((Tabpanel)parent).setOnCloseHandler(handler);
        }

        SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
        
        layout.addEventListener(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT, this);
        
        return layout;
    }

    protected IADTabbox createADTab()
    {
    	CompositeADTabbox composite = new CompositeADTabbox();
    	return composite;
    }

	public Vlayout getComponent() {
		return layout;
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
    	}
    	else if (event.getName().equals(WindowContainer.ON_WINDOW_CONTAINER_SELECTION_CHANGED_EVENT)) {
    		SessionManager.getAppDesktop().updateHelpContext(X_AD_CtxHelp.CTXTYPE_Tab, adTabbox.getSelectedGridTab().getAD_Tab_ID());
    	}
    	else {
    		super.onEvent(event);
    	}
    }

	class TabOnCloseHanlder implements ITabOnCloseHandler, Callback<Boolean> {
		private Tabpanel tabPanel;
		public void onClose(Tabpanel tabPanel) {
			this.tabPanel = tabPanel;
			ADWindowContent.this.onExit(this);
		}
		@Override
		public void onCallback(Boolean result) {
			if (result){
				closeTab (tabPanel);			
			} 
			this.tabPanel = null;
		}
	}
	
	/**
	 * close tab contain this window
	 * @param tabPanel
	 */
	protected void closeTab (Tabpanel tabPanel) {
		Tab tab = tabPanel.getLinkedTab();
		tab.close();
		if (getWindowNo() > 0)
			SessionManager.getAppDesktop().unregisterWindow(getWindowNo());
	}
	
	public static class ADWindowVlayout extends Vlayout implements IHelpContext {
		/**
		 * generated serial id
		 */
		private static final long serialVersionUID = 6104341168705201721L;
		private AbstractADWindowContent content;

		protected ADWindowVlayout(AbstractADWindowContent content) {
			super();
			this.content = content;
		}

		@Override
		public void onPageDetached(Page page) {
			super.onPageDetached(page);
			try {
				SessionManager.getSessionApplication().getKeylistener().removeEventListener(Events.ON_CTRL_KEY, content);
			} catch (Exception e){}
		}
	}

	@Override
	protected void switchEditStatus(boolean editStatus) {
		layout.setWidgetOverride("isEditting", "'" + String.valueOf(editStatus) + "'");
	}	
}
