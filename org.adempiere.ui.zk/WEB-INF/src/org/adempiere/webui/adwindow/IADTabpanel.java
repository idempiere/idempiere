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
 * Interface for AD_Tab UI (with all the AD_Fields definition)
 * @author Low Heng Sin
 *
 */
public interface IADTabpanel extends Component, Evaluatee {

	/** Activate/Deactivate event for IADTabpanel. Fire for init or after tab selection changed. **/
	public static final String ON_ACTIVATE_EVENT = "onActivate";
	
	/** Component boolean attribute to indicate ON_ACTIVATE_EVENT have been posted for the current execution cycle **/
	public static final String ATTR_ON_ACTIVATE_POSTED = "org.adempiere.webui.adwindow.IADTabpanel.onActivatePosted";

	/**
	 * @param winPanel
	 * @param gridTab
	 */
	public void init(AbstractADWindowContent winPanel, GridTab gridTab);

	/**
	 * @return display logic
	 */
	public String getDisplayLogic();

	/**
	 * @return tab level
	 */
	public int getTabLevel();

	/**
	 * @return table name from GridTab
	 */
	public String getTableName();

	/**
	 * @return record ID of current row
	 */
	public int getRecord_ID();

	/**
	 * @return true if refresh is not needed
	 */
	public boolean isCurrent();

	/**
	 * @return title of tab
	 */
	public String getTitle();

	/**
	 * Layout fields of the tab panel
	 */
	public void createUI();

	/**
	 * @return {@link GridTab} instance that back this IADTabpanel instance
	 */
	public GridTab getGridTab();

	/**
	 * Activate/deactivate this IADTabpanel instance.
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
	 * Switch between grid/list and form view
	 */
	public void switchRowPresentation();

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
	 * @return true if current presentation of the tab panel is grid/list view
	 */
	public boolean isGridView();
	
	/**
	 * @return true if the tab panel have been activated
	 */
	public boolean isActivated();

	/**
	 * Turn on/off detail mode, i.e either tab panel is currently a header or detail tab of the UI.
	 * @param detailMode
	 */
	public void setDetailPaneMode(boolean detailMode);
	
	/**
	 * @return true if the panel is in detail mode (i.e a detail tab in DetailPane)
	 */
	public boolean isDetailPaneMode();

	/**
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
	 * Save changes.
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
	 * @return tab no ( ad_tab.tabno )
	 */
	public int getTabNo();
	
	/**
	 * Set the {@link DetailPane} part that own this IADTabpanel instance
	 * @param detailPane
	 */
	public void setDetailPane(DetailPane detailPane);
	
	/**
	 * @return the {@link DetailPane} part that own this IADTabpanel instance
	 */
	public DetailPane getDetailPane();

	/**
	 * Reset detail data grid when parent tab current record is new and not saved yet.
	 * Call {@link GridTab#resetDetailForNewParentRecord()}
	 */
	public void resetDetailForNewParentRecord();
	
	/**
	 * @return {@link ADTreePanel} instance
	 */
	public ADTreePanel getTreePanel();	

	/**
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
	 * @return List of toolbar buttons
	 */
	public List<Button> getToolbarButtons();

	/**
	 * @return true if customize grid button is enabled
	 */
	public boolean isEnableCustomizeButton();

	/**
	 * @return true if process Button is Enabled
	 */
	default public boolean isEnableProcessButton() {
		boolean isNewRow = getGridTab().getRowCount() == 0 || getGridTab().isNew();
		return getToolbarButtons().size() > 0 && !isNewRow;
	}

	/**
	 * Enabled/Disabled ADWindowToolbar buttons
	 * 
	 * @param toolbar - {@link ADWindowToolbar}
	 */
	public void updateToolbar(ADWindowToolbar toolbar);

	/**
	 * Enabled/Disabled {@link DetailPane} toolbar buttons
	 * 
	 * @param toolbar - {@link Toolbar}
	 */
	public void updateDetailToolbar(Toolbar toolbar);

}
