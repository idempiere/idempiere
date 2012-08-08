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

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.window.AboutWindow;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Hbox;
import org.zkoss.zul.Image;
import org.zkoss.zul.Popup;
import org.zkoss.zul.West;

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

	private Image image;
	private ToolBarButton btnMenu;
	private Popup popMenu;

    public HeaderPanel()
    {
        super();
        init();
    }

    private void init()
    {
    	LayoutUtils.addSclass("desktop-header", this);

    	UserPanel userPanel = new UserPanel();

    	image  = new Image(ThemeManager.getSmallLogo());
    	image.addEventListener(Events.ON_CLICK, this);
    	image.setStyle("cursor: pointer;");
    	image.setWidth("100px");

    	Borderlayout layout = new Borderlayout();
    	LayoutUtils.addSclass("desktop-header", layout);
    	layout.setParent(this);
    	West west = new West();
    	west.setParent(layout);

    	Hbox hbox = new Hbox();
    	hbox.setParent(west);
    	hbox.setHeight("100%");
    	hbox.setPack("center");
        hbox.setAlign("left");

    	image.setParent(hbox);
    	
    	new MenuSearchPanel(this).setParent(hbox);

    	popMenu = new Popup();
    	popMenu.setId("menuTreePopup");
		popMenu.appendChild(new MenuTreePanel(popMenu));
		popMenu.setWidth("600px");
    	popMenu.setHeight("500px");
    	popMenu.setParent(hbox);

    	btnMenu = new ToolBarButton();
    	btnMenu.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(),"Menu")));
    	LayoutUtils.addSclass("desktop-header-font", btnMenu);
    	btnMenu.setParent(hbox);
    	btnMenu.setPopup("menuTreePopup");
    	btnMenu.addEventListener(Events.ON_CLICK, this);    	

    	LayoutUtils.addSclass("desktop-header-left", west);
    	//the following doesn't work when declare as part of the header-left style
    	west.setStyle("background-color: transparent; border: none;");

    	// Elaine 2009/03/02
    	Center center = new Center();
    	center.setParent(layout);
    	userPanel.setParent(center);
    	userPanel.setWidth("100%");
    	userPanel.setHeight("100%");
    	userPanel.setStyle("position: absolute");
    	center.setFlex(true);
    	LayoutUtils.addSclass("desktop-header-right", center);
    	//the following doesn't work when declare as part of the header-right style
    	center.setStyle("background-color: transparent; border: none;");
    }

	public void onEvent(Event event) throws Exception {
		if (Events.ON_CLICK.equals(event.getName())) {
			if(event.getTarget() == image)
			{
				AboutWindow w = new AboutWindow();
				w.setPage(this.getPage());
				w.doHighlighted();
			}
			else if(event.getTarget() == btnMenu)
			{
				popMenu.open(btnMenu, "end_before");
			}
		}
	}
}
