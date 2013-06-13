/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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

package org.adempiere.webui.panel;

import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.EventQueue;
import org.zkoss.zk.ui.event.EventQueues;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Toolbar;

/**
 * Menu Search Panel
 * @author Elaine
 * @date July 31, 2012
 */
public class MenuSearchPanel extends AbstractMenuPanel
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 5308522340852904168L;
	
	protected MenuTreeSearchPanel pnlSearch;

	private EventListener<Event> listener;
    
    public MenuSearchPanel(Component parent)
    {
    	super(parent);
    	this.setSclass("menu-search-panel-container");
    }

	protected void init() 
	{
		super.init();
        pnlSearch.initialise();                       
	}
    
    protected void initComponents()
    {
    	super.initComponents();
    	
    	createSearchPanel();
    }

	protected void createSearchPanel() {
		Toolbar toolbar = new Toolbar();
        toolbar.setMold("panel");
        this.appendChild(toolbar);
        
        pnlSearch = new MenuTreeSearchPanel(getMenuTree());
        pnlSearch.setSclass("menu-search-panel");
        toolbar.appendChild(pnlSearch);
	}
	
	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.AbstractComponent#onPageDetached(org.zkoss.zk.ui.Page)
	 */
	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		if (listener != null) {
			try {
				EventQueue<Event> queue = EventQueues.lookup(MenuTreeFilterPanel.MENU_TREE_FILTER_CHECKED_QUEUE, EventQueues.DESKTOP, true);
				if (queue != null)
					queue.unsubscribe(listener);
			} finally {
				listener = null;
			}
			
		}
	}

	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (listener == null) {
			listener = new EventListener<Event>() {
				public void onEvent(Event event) throws Exception {
					if (event.getName() == Events.ON_CHECK)
					{
						Checkbox chk = (Checkbox) event.getData();
						if (chk != null)
						{
							if ("flatView".equals(chk.getId()))
								MenuTreeFilterPanel.toggleFlatView(getMenuTree(), chk);
							else
								MenuTreeFilterPanel.toggle(getMenuTree(), chk);
							if (pnlSearch != null)
								pnlSearch.refreshSearchList();
							getMenuTree().invalidate();
						}
					}
				}
			}; 
		}
		EventQueues.lookup(MenuTreeFilterPanel.MENU_TREE_FILTER_CHECKED_QUEUE, EventQueues.DESKTOP, true).subscribe(listener);
	}
	
	
}