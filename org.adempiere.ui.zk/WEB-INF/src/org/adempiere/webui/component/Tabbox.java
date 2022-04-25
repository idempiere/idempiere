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

package org.adempiere.webui.component;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Iterator;

import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.SelectEvent;
import org.zkoss.zul.Tab;
import org.zkoss.zul.Tabpanels;
import org.zkoss.zul.Tabs;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class Tabbox extends org.zkoss.zul.Tabbox implements EventListener<Event>
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1400484283064851775L;
	private boolean isSupportTabDragDrop = false;
	private boolean isActiveBySeq = false;
	private boolean isCheckVisibleOnlyForNextActive = true;

	private Deque<Tab> activeTabSeq = new ArrayDeque<>();
	public Tabbox () {
		super();
		this.addEventListener(Events.ON_SELECT, this);
	}
	
	public Tabpanel getTabpanel(int index)
    {
        try
        {
            Tabpanels tabpanels = this.getTabpanels();
            Tabpanel tabPanel = (Tabpanel)tabpanels.getChildren().get(index);
            return tabPanel;
        }
        catch (Exception ex)
        {
            throw new IndexOutOfBoundsException(ex.getMessage());
        }
    }
    
    public Tabpanel getSelectedTabpanel()
    {
        return getTabpanel(this.getSelectedIndex());
    }
    
    public boolean isSupportTabDragDrop() {
		return isSupportTabDragDrop;
	}

    /**
     * let support drag&amp;drop {@link Tab}
     * @param isSupportTabDragDrop
     */
	public void setSupportTabDragDrop(boolean isSupportTabDragDrop) {
		this.isSupportTabDragDrop = isSupportTabDragDrop;
	}

	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		Events.sendEvent("onPageAttached", this, null);
		
	}
	
	@Override
	public void onPageDetached(Page page) {
		super.onPageDetached(page);
		Events.sendEvent("onPageDetached", this, null);
	}

	/**
	 * add current selected tab to stack when a new tab is selected
	 */
	@Override
	public void onEvent(Event event) throws Exception {
		if (event instanceof SelectEvent && isActiveBySeq()) {
			@SuppressWarnings("rawtypes")
			SelectEvent selectEvent = (SelectEvent)event;
			@SuppressWarnings("rawtypes")
			Iterator itPrevSelectedTab = selectEvent.getPreviousSelectedItems().iterator();
			if (itPrevSelectedTab.hasNext()) {
				activeTabSeq.push((Tab)itPrevSelectedTab.next());
			}
			
		}
		
	}

	/**
	 * override to add active tab to stack when tab is selected by add to {@link Tabs}
	 */
	@Override
	public void setSelectedTab(Tab tab) {
		if (getSelectedTab() != null && getSelectedTab() != tab && isActiveBySeq()) {//DEFER SET SELECTED TAB
			activeTabSeq.push(getSelectedTab());
		}
		super.setSelectedTab(tab);
	}
	
	public boolean isActiveBySeq() {
		return isActiveBySeq;
	}

	public void setActiveBySeq(boolean isActiveBySeq) {
		this.isActiveBySeq = isActiveBySeq;
	}
	
	/**
	 * select next active tab by order store on stack folow FILO
	 * @return
	 */
	public Tab getNextActiveBySeq (Tab currentTab) {
		Tab cadidateTabActive = null;
		while ((cadidateTabActive = activeTabSeq.peek()) != null) {
			boolean canNotActive = cadidateTabActive.isDisabled() || (!cadidateTabActive.isVisible() && isCheckVisibleOnlyForNextActive());
			if (canNotActive) {
				// move disable item to last stack it can be active late
				cadidateTabActive = activeTabSeq.pop();
				activeTabSeq.addLast(cadidateTabActive);
			}else if (cadidateTabActive.getParent() == null || currentTab == cadidateTabActive) {// when call close other tab menu, remain tab = first tab on stack, so have to ignore it when find next tab
				activeTabSeq.pop();// this tab is close by code or by close at unselected state so just remove it from stack
			}else {
				return activeTabSeq.pop();
			}
		}
		
		return null;
	}
	
	/**
	 * activeTabSeq is maintain by selected tab event, so when close by code or close on unselected state should call this function to save memory<br/>
	 * in case don't call it, it still manage from {@link #getNextActiveBySeq(Tab)}
	 * @param closeTab
	 */
	public void removeTabFromActiveSeq (Tab closeTab) {
		activeTabSeq.remove(closeTab);
	}
	
	public boolean isCheckVisibleOnlyForNextActive() {
		return isCheckVisibleOnlyForNextActive;
	}
	
	/**
	 * Ignore invisible tab for next active by seq
	 * @param isVisibleOnly
	 */
	public void setCheckVisibleOnlyForNextActive(boolean isVisibleOnly) {
		isCheckVisibleOnlyForNextActive = isVisibleOnly;
	}
}
