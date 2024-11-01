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
package org.adempiere.webui.adwindow;

import java.util.List;

import org.compiere.model.GridTab;
import org.compiere.util.Evaluatee;
import org.zkoss.zk.ui.Component;
import org.zkoss.zul.Button;
import org.zkoss.zul.Toolbar;

/**
 * Interface for AD_Tab panel component (with all the AD_Fields definition)
 * @author Low Heng Sin
 */
public interface IADTabpanel extends Component, Evaluatee {

	/** Activate/Deactivate event for IADTabpanel. Fire for init or after tab selection changed. **/
	public static final String ON_ACTIVATE_EVENT = "onActivate";
	
	/** Component boolean attribute to indicate ON_ACTIVATE_EVENT have been posted for the current execution cycle **/
	public static final String ATTR_ON_ACTIVATE_POSTED = "org.adempiere.webui.adwindow.IADTabpanel.onActivatePosted";

	/**
	 * Initialized tab panel
	 * @param winPanel
	 * @param gridTab
	 */
	public void init(AbstractADWindowContent winPanel, GridTab gridTab);

	/**
	 * Get display logic
	 * @return display logic
	 */
	public String getDisplayLogic();

	/**
	 * Get tab level
	 * @return tab level
	 */
	public int getTabLevel();

	/**
	 * Get table name
	 * @return table name from GridTab
	 */
	public String getTableName();

	/**
	 * Get record id of current row
	 * @return record ID of current row
	 */
	public int getRecord_ID();

	/**
	 * Is current row not stall
	 * @return true if refresh is not needed
	 */
	public boolean isCurrent();

	/**
	 * Get title of tab
	 * @return title of tab
	 */
	public String getTitle();

	/**
	 * Layout fields of the tab panel
	 */
	public void createUI();

	/**
	 * Get GridTab of tab
	 * @return {@link GridTab} instance that back this IADTabpanel instance
	 */
	public GridTab getGridTab();

	/**
	 * Activate/deactivate this IADTabpanel instance.<br/>
	 * Call by init or after tab selection changed. 
	 * @param b
	 */
	public void activate(boolean b);

	/**
	 * Execute query through the backed {@link GridTab} instance.
	 */
	public void query();

	/**
	 * Refresh data through the backed {@link GridTab} instance.
	 */
	public void refresh();

	/**
	 * Call {@link GridTab#query(boolean, int, int)}
	 * @param currentRows
	 * @param currentDays
	 * @param maxRows
	 */
	public void query(boolean currentRows, int currentDays, int maxRows);

	/**
	 * Switch between grid and form view
	 */
	public void switchRowPresentation();

	/**
     * After Find window closes switch to grid view if configured
     * @return void
     */
	public void onAfterFind();

	/**
	 * Dynamic update of every field's UI properties ( visibility, filter and mandatory ).
	 * @param col optional column name
	 */
	public void dynamicDisplay(int col);

	/**
	 * Handle after save event
	 * @param onSaveEvent
	 */
	public void afterSave(boolean onSaveEvent);

	/**
	 * Handle enter key event
	 * @return true if the event is process
	 */
	public boolean onEnterKey();
	
	/**
	 * Is tab panel showing grid view
	 * @return true if current presentation of the tab panel is grid/list view
	 */
	public boolean isGridView();
	
	/**
	 * Is tab panel have been activated
	 * @return true if the tab panel have been activated
	 */
	public boolean isActivated();

	/**
	 * Turn on/off detail mode, i.e whether tab panel is currently a header or detail tab of the window.
	 * @param detailMode
	 */
	public void setDetailPaneMode(boolean detailMode);
	
	/**
	 * Is tab panel in detail pane mode
	 * @return true if the panel is in detail mode (i.e a tab in DetailPane)
	 */
	public boolean isDetailPaneMode();

	/**
	 * Get GridView component
	 * @return {@link GridView} instance
	 */
	public GridView getGridView();	
	
	/**
	 * Call {@link GridTab#needSave(boolean, boolean)}
	 * @param rowChange
	 * @param onlyRealChange
	 * @return true if there are pending changes 
	 */
	public boolean needSave(boolean rowChange, boolean onlyRealChange);

	/**
	 * Save changes.<br/>
	 * Call {@link GridTab#dataSave(boolean)}
	 * @param onSaveEvent
	 * @return true if the save operation completed successfully
	 */
	public boolean dataSave(boolean onSaveEvent);
	
	/**
	 * Set tab number/sequence within an AD_Window
	 * @param tabNo
	 */
	public void setTabNo(int tabNo);
	
	/**
	 * Get tab no
	 * @return tab no ( ad_tab.tabno )
	 */
	public int getTabNo();
	
	/**
	 * Set the {@link DetailPane} part that own this IADTabpanel instance
	 * @param detailPane
	 */
	public void setDetailPane(DetailPane detailPane);
	
	/**
	 * Get parent detail pane
	 * @return the {@link DetailPane} part that own this IADTabpanel instance
	 */
	public DetailPane getDetailPane();

	/**
	 * Reset detail data grid when current record of parent tab is new and not saved yet.<br/>
	 * Call {@link GridTab#resetDetailForNewParentRecord()}
	 */
	public void resetDetailForNewParentRecord();
	
	/**
	 * Get tree panel component
	 * @return {@link ADTreePanel} instance
	 */
	public ADTreePanel getTreePanel();	

	/**
	 * Is quick form enabled
	 * @return true if Quick Form Button is Enabled
	 */
	public boolean isEnableQuickFormButton();

	/**
	 * Get is detail pane visible
	 * @return true if the containing {@link DetailPane} instance is visible
	 */
	public default boolean isDetailVisible() {
		return false;
	}
	
	/**
	 * Get toolbar buttons
	 * @return List of toolbar buttons
	 */
	public List<Button> getToolbarButtons();

	/**
	 * Is customize grid button enable
	 * @return true if customize grid button is enabled
	 */
	public boolean isEnableCustomizeButton();

	/**
	 * Is process button enable
	 * @return true if process Button is Enabled
	 */
	default public boolean isEnableProcessButton() {
		boolean isNewRow = getGridTab().getRowCount() == 0 || getGridTab().isNew();
		return getToolbarButtons().size() > 0 && !isNewRow;
	}

	/**
	 * Update ADWindowToolbar buttons state
	 * 
	 * @param toolbar - {@link ADWindowToolbar}
	 */
	public void updateToolbar(ADWindowToolbar toolbar);

	/**
	 * Update {@link DetailPane} toolbar buttons state
	 * 
	 * @param toolbar - {@link Toolbar}
	 */
	public void updateDetailToolbar(Toolbar toolbar);

}
