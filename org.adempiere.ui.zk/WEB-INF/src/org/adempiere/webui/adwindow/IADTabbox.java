/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
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
package org.adempiere.webui.adwindow;

import org.adempiere.webui.part.UIPart;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.GridTab;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;

/**
 * Controller interface for header+details AD_Tabs UI for AD_Window.
 * @author <a href="mailto:hengsin@gmail.com">Low Heng Sin</a>
 *
 */
public interface IADTabbox extends UIPart {

	/**
	 * Get selected header tab index
	 * @return selected header tab index
	 */
	public int getSelectedIndex();

	/**
	 * Set selected header tab
	 * @param i tab index
	 */
	public void setSelectedIndex(int i);

	/**
	 * Change selected header tab index from oldTabIndex to newTabIndex
	 * @param oldTabIndex
	 * @param newTabIndex
	 * @return true if selected tab successfully change to newTabIndex
	 */
	public boolean updateSelectedIndex(int oldTabIndex, int newTabIndex);

	/**
	 * Get selected header tab panel
	 * @return selected header {@link IADTabpanel} instance
	 */
	public IADTabpanel getSelectedTabpanel();

	/**
	 * Is navigation allow from fromIndex to toIndex
	 * @param fromIndex
	 * @param toIndex
	 * @return true if user can change selected tab from fromIndex to toIndex, false otherwise
	 */
	public boolean canNavigateTo(int fromIndex, int toIndex);

	/**
	 * Is header tab at index visible
	 * @param index
	 * @return true if tab at index visible, false otherwise
	 */
	public boolean isDisplay(int index);

	/**
	 * Add new header tab (AD_Tab)
	 * @param tab {@link GridTab} for AD_Tab
	 * @param tabPanel {@link IADTabpanel} instance for AD_Tab
	 */
	public void addTab(GridTab tab, IADTabpanel tabPanel);

	/**
	 * Get number of header tab
	 * @return Number of tab
	 */
	public int getTabCount();

	/**
	 * Evaluate state of each tab after DataStatusEvent
	 * @param e
	 */
	public void evaluate(DataStatusEvent e);

	/**
	 * Get full path to the selected header tab (for e.g Business Partner > Location)
	 * @return folder like parent/child path to the selected tab (for e.g Business Partner > Location)
	 */
	public String getPath();

	/**
	 * Set event listener for tab selection change event
	 * @param listener
	 */
	public void setSelectionEventListener(EventListener<Event> listener);

	/**
	 * Get header IADTabpanel at index
	 * @param index tab index
	 * @return {@link IADTabpanel} instance at index
	 */
	public IADTabpanel getADTabpanel(int index);

	/**
	 * Find IADTabpanel by GridTab
	 * @param gTab
	 * @return {@link IADTabpanel} instance for gTab or null if not found
	 */
	public IADTabpanel findADTabpanel(GridTab gTab);

	/**
	 * Set parent AD Window panel
	 * @param abstractADWindowPanel
	 */
	public void setADWindowPanel(AbstractADWindowContent abstractADWindowPanel);

	/**
	 * Edit current row of selected detail tab.<br/>
	 * The selected detail tab will become the new header tab.
	 */
	public void onDetailRecord();

	/**
	 * Is current selected header tab a sort tab
	 * @return true if current header tab is a sort tab
	 */
	public boolean isSortTab();

	/**
	 * Is current selected header or detail tab has pending changes to save
	 * Call {@link IADTabpanel#needSave(boolean, boolean)}
	 * @param rowChange
	 * @param onlyRealChange
	 * @return true if there are changes pending to be save
	 */
	public boolean needSave(boolean rowChange, boolean onlyRealChange);

	/**
	 * Ignore/undo all pending changes
	 */
	public void dataIgnore();

	/**
	 * Get Grid of selected header tab
	 * @return {@link GridTab} instance of header tab
	 */
	public GridTab getSelectedGridTab();

	/**
	 * Save changes
	 * @param onSaveEvent
	 * @return true if save is successful
	 */
	public boolean dataSave(boolean onSaveEvent);

	/**
	 * Update status text of {@link DetailPane}
	 * @param status
	 * @param error
	 */
	public void setDetailPaneStatusMessage(String status, boolean error);

	/**
	 * Get IADTabpanel of selected detail tab
	 * @return the selected detail {@link IADTabpanel} instance
	 */
	IADTabpanel getSelectedDetailADTabpanel();

	/**
	 * Get IADTabpanel that has pending changes to save
	 * @return dirty {@link IADTabpanel} that need save ( if any )
	 */
	IADTabpanel getDirtyADTabpanel();

	/**
	 * Update state of detail pane toolbar.<br/>
	 * Call {@link DetailPane#updateToolbar(boolean, boolean)}
	 * @param changed true if header tab has changed
	 * @param readOnly true if header tab is readonly
	 */
	public void updateDetailPaneToolbar(boolean changed, boolean readOnly);

	/**
	 * Set selected tab of {@link DetailPane} to tabIndex.
	 * @param tabIndex
	 * @param currentRow set current row of tab at tabIndex to currentRow 
	 */
	public void setDetailPaneSelectedTab(int tabIndex, int currentRow);

	/**
	 * Is detail pane loaded
	 * @return true if all the tabs of detail pane have been linked up with header tab
	 */
	public boolean isDetailPaneLoaded();
	
}
