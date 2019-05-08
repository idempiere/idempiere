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
 *****************************************************************************/

package org.adempiere.webui.panel;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.GlobalSearch;
import org.adempiere.webui.apps.MenuSearchController;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.AboutWindow;
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
import org.zkoss.zul.Image;
import org.zkoss.zul.Popup;
import org.zkoss.zul.impl.LabelImageElement;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @author  <a href="mailto:hengsin@gmail.com">Low Heng Sin</a>
 * @date    Mar 2, 2007
 * @date    July 7, 2007
 * @version $Revision: 0.20 $
 */

public class HeaderPanel extends Panel implements EventListener<Event>
{
	private static final long serialVersionUID = -2351317624519209484L;

	protected Image image;
	protected LabelImageElement btnMenu;
	protected Popup popMenu;

	private MenuTreePanel menuTreePanel;

    public HeaderPanel()
    {
        super();
        addEventListener(Events.ON_CREATE, this);              
    }

    protected void onCreate()
    {
    	image = (Image) getFellow("logo");
    	image.setSrc(ThemeManager.getSmallLogo());
    	image.addEventListener(Events.ON_CLICK, this);
    	image.setStyle("cursor: pointer;");

    	createPopupMenu();
    	
    	createSearchPanel();

    	btnMenu = (LabelImageElement) getFellow("menuButton");
    	btnMenu.setIconSclass("z-icon-sitemap");
    	btnMenu.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(),"Menu")));
    	btnMenu.addEventListener(Events.ON_CLICK, this);
    	if (ClientInfo.isMobile()) {
    		LayoutUtils.addSclass("mobile", this);
    		ClientInfo.onClientInfo(this, this::onClientInfo);
    	}
    	SessionManager.getSessionApplication().getKeylistener().addEventListener(Events.ON_CTRL_KEY, this);
    }

	protected void createPopupMenu() {
		popMenu = new Popup();
    	popMenu.setId("menuTreePopup");
		menuTreePanel = new MenuTreePanel(popMenu);
    	popMenu.setSclass("desktop-menu-popup");
    	ZKUpdateUtil.setHeight(popMenu, "90%");
    	ZKUpdateUtil.setWindowWidthX(popMenu, 600);
    	popMenu.setPage(this.getPage());
    	popMenu.addEventListener(Events.ON_OPEN, (OpenEvent evt) -> popMenuOpenEvent(evt));
	}

	private void popMenuOpenEvent(OpenEvent evt) {
		popMenu.setAttribute(popMenu.getUuid(), System.currentTimeMillis());
	}

	protected void createSearchPanel() {
		GlobalSearch globalSearch = new GlobalSearch(new MenuSearchController(menuTreePanel.getMenuTree()));
    	Component stub = getFellow("menuLookup");
    	stub.getParent().insertBefore(globalSearch, stub);
    	stub.detach();
    	globalSearch.setId("menuLookup");
	}

	public void onEvent(Event event) throws Exception {
		if (Events.ON_CLICK.equals(event.getName())) {
			if(event.getTarget() == image)
			{
				AboutWindow w = new AboutWindow();
				w.setPage(this.getPage());
				w.doHighlighted();
			}
			else if(event.getTarget() == btnMenu )
			{
				Long ts = (Long) popMenu.removeAttribute(popMenu.getUuid());
				if (ts != null) {
					if ((System.currentTimeMillis()-ts.longValue()) < 500)
						return;
				}
				popMenu.open(btnMenu, "after_start");
			}
		} else if (Events.ON_CREATE.equals(event.getName())) {
			onCreate();
		}else if (event instanceof KeyEvent)
		{
			//alt+m for the menu
			KeyEvent ke = (KeyEvent) event;
			if (ke.getKeyCode() == 77)
			{
				popMenu.open(btnMenu, "after_start");
				popMenu.setFocus(true);
			}else if (ke.getKeyCode() == 27) {
				popMenu.close();
			} 
		}
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.AbstractComponent#onPageAttached(org.zkoss.zk.ui.Page, org.zkoss.zk.ui.Page)
	 */
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null && popMenu != null)
			popMenu.setPage(newpage);
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.AbstractComponent#onPageDetached(org.zkoss.zk.ui.Page)
	 */
	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		if (popMenu != null)
			popMenu.setPage(null);
	}
	
	public Image getLogo() {
		return image;
	}
	
	public void closeSearchPopup() {
		Component c = getFellow("menuLookup");
		if (c != null && c instanceof GlobalSearch)
			((GlobalSearch)c).closePopup();
	}
	
	protected void onClientInfo() {
		ZKUpdateUtil.setWindowWidthX(popMenu, 600);
		Component c = getFellow("menuLookup");
		if (c != null && c instanceof GlobalSearch)
			((GlobalSearch)c).onClientInfo();
	}
}
