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
 * Extend {@link org.zkoss.zul.Tabbox}
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Feb 25, 2007
 * @version $Revision: 0.10 $
 */
public class Tabbox extends org.zkoss.zul.Tabbox implements EventListener<Event>
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1400484283064851775L;
	private boolean isSupportTabDragDrop = false;
	private boolean isActiveBySeq = false;
	private boolean isCheckVisibleOnlyForNextActive = true;

	/**
	 * Deque of tab by selection sequence. Each time when a Tab is selected by user, the Tab is push to front of queue.
	 */
	private Deque<Tab> activeTabSeq = new ArrayDeque<>();
	
	/**
	 * Default constructor
	 */
	public Tabbox () {
		super();
		this.addEventListener(Events.ON_SELECT, this);
	}
	
	/**
	 * Get tab panel at index
	 * @param index
	 * @return Tabpanel. Throw IndexOutOfBoundsException if index is invalid.
	 */
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
    
	/**
	 * @return selected Tabpanel
	 */
    public Tabpanel getSelectedTabpanel()
    {
        return getTabpanel(this.getSelectedIndex());
    }
    
    /**
     * @return true if drag and drop of tab is enable
     */
    public boolean isSupportTabDragDrop() {
		return isSupportTabDragDrop;
	}

    /**
     * Set enable/disable the drag and drop of {@link Tab}
     * @param isSupportTabDragDrop
     */
	public void setSupportTabDragDrop(boolean isSupportTabDragDrop) {
		this.isSupportTabDragDrop = isSupportTabDragDrop;
	}

	/**
	 * Send onPageAttached event
	 */
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		Events.sendEvent("onPageAttached", this, null);
		
	}
	
	/**
	 * Send onPageDetached event
	 */
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
	
	/**
	 * @return true if set next active tab using {@link #activeTabSeq}
	 */
	public boolean isActiveBySeq() {
		return isActiveBySeq;
	}

	/**
	 * Enable/disable the use of {@link #activeTabSeq} for the setting of next active tab.
	 * @param isActiveBySeq
	 */
	public void setActiveBySeq(boolean isActiveBySeq) {
		this.isActiveBySeq = isActiveBySeq;
	}
	
	/**
	 * Get next active tab by selection sequence store on {@link #activeTabSeq}.
	 * @param currentTab current Tab to skip/ignore
	 * @return Tab or null if no valid candidate from {@link #activeTabSeq}.
	 */
	public Tab getNextActiveBySeq (Tab currentTab) {
		Tab cadidateTabActive = null;
		while ((cadidateTabActive = activeTabSeq.peek()) != null) {
			boolean canNotActive = cadidateTabActive.isDisabled() || (!cadidateTabActive.isVisible() && isCheckVisibleOnlyForNextActive());
			if (canNotActive) {
				// move disable item to last stack it can be active late
				cadidateTabActive = activeTabSeq.pop();
				activeTabSeq.addLast(cadidateTabActive);
			}else if (cadidateTabActive.getParent() == null || currentTab == cadidateTabActive) {
				activeTabSeq.pop(); //not attached to page or == currentTab, remove
			}else {
				return activeTabSeq.pop();
			}
		}
		
		return null;
	}
	
	/**
	 * {@link #activeTabSeq} is maintain by selected tab event, so when a tab is close, code should call this function to save memory<br/>
	 * @param closeTab
	 */
	public void removeTabFromActiveSeq (Tab closeTab) {
		activeTabSeq.remove(closeTab);
	}
	
	/**
	 * @return true if {@link #activeTabSeq} should ignore invisible tab.
	 */
	public boolean isCheckVisibleOnlyForNextActive() {
		return isCheckVisibleOnlyForNextActive;
	}
	
	/**
	 * Ignore invisible tab for next active by selection sequence
	 * @param isVisibleOnly
	 */
	public void setCheckVisibleOnlyForNextActive(boolean isVisibleOnly) {
		isCheckVisibleOnlyForNextActive = isVisibleOnly;
	}
}
