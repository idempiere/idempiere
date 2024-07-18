/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - deepak															   *
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.window;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.util.Callback;
import org.adempiere.webui.adwindow.ADTabpanel;
import org.adempiere.webui.adwindow.GridView;
import org.adempiere.webui.adwindow.QuickGridView;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.panel.CustomizeGridViewPanel;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.panel.QuickCustomizeGridViewPanel;
import org.compiere.model.GridField;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Column;
import org.zkoss.zul.Columns;

/**
 * Dialog to customize grid view layout
 */
public class CustomizeGridViewDialog extends Window {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -138153049225192685L;

	private CustomizeGridViewPanel customizePanel;
	private QuickCustomizeGridViewPanel quickCustomizePanel;
	private boolean isQuickForm = false;

	/**
	 *	Standard Constructor
	 * 	@param windowNo window no
	 *  @param AD_Tab_ID tab
	 * 	@param AD_User_ID user
	 *  @param columnsWidth 
	 *  @param isQuickForm 
	 */
	public CustomizeGridViewDialog(int windowNo, int AD_Tab_ID, int AD_User_ID, Map<Integer, String> columnsWidth,
			ArrayList<Integer> gridFieldIds, boolean isQuickForm) {
		setClosable(true);
		setTitle(Msg.getMsg(Env.getCtx(), "Customize"));
		this.isQuickForm = isQuickForm;
		initComponent(windowNo, AD_Tab_ID, AD_User_ID, columnsWidth, gridFieldIds);
	}
	
	/**
	 * Create components and layout dialog
	 * @param windowNo
	 * @param AD_Tab_ID
	 * @param AD_User_ID
	 * @param columnsWidth
	 * @param gridFieldIds
	 */
	private void initComponent(int windowNo, int AD_Tab_ID, int AD_User_ID, Map<Integer, String> columnsWidth, ArrayList<Integer> gridFieldIds) {
		if (isQuickForm)
		{
			quickCustomizePanel = new QuickCustomizeGridViewPanel(windowNo, AD_Tab_ID, AD_User_ID, columnsWidth,
					gridFieldIds);
		}
		else
		{
			customizePanel = new CustomizeGridViewPanel(windowNo, AD_Tab_ID, AD_User_ID, columnsWidth, gridFieldIds);
		}
		this.setStyle("position : relative;");
		
		this.setBorder("normal");
		this.setSclass("popup-dialog customize-grid-view-dialog");
		
		if (isQuickForm)
		{
			ZKUpdateUtil.setWindowWidthX(this, 500);
			ZKUpdateUtil.setWindowHeightX(this, 410);
			quickCustomizePanel.createUI();
			quickCustomizePanel.loadData();
			appendChild(quickCustomizePanel);
		}
		else
		{
			if (!ThemeManager.isUseCSSForWindowSize()) {
				ZKUpdateUtil.setWindowWidthX(this, 600);
				ZKUpdateUtil.setWindowHeightX(this, 500);
			} else {
				addCallback(AFTER_PAGE_ATTACHED, t-> {
					ZKUpdateUtil.setCSSHeight(this);
					ZKUpdateUtil.setCSSWidth(this);
				});
			}

			appendChild(customizePanel);
			customizePanel.createUI();
			customizePanel.query();
		}
		addEventListener(Events.ON_CANCEL, e -> customizePanel.onCancel());
	}

	/**
	 * @return whether change have been successfully save to db
	 */
	public boolean isSaved() {
		if (isQuickForm)
			return quickCustomizePanel.isSaved();
		else
			return customizePanel.isSaved();
	}
	
	/**
	 * @param gridPanel
	 */
	public void setGridPanel(GridView gridPanel){
		customizePanel.setGridPanel(gridPanel);
	}

	/**
	 * show grid view customization dialog for tabPanel
	 * @param tabPanel
	 * @return ignore the return value, it is not working correctly
	 * @deprecated
	 */
	@Deprecated(forRemoval = true, since = "11")
	public static boolean onCustomize(ADTabpanel tabPanel) {
		onCustomize(tabPanel, null);
		return true;
	}

	/**
	 * Show grid view customization dialog for tabPanel
	 * @param tabPanel
	 * @param callback
	 */
	public static void onCustomize(ADTabpanel tabPanel, Callback<Boolean> callback) {
		Columns columns = tabPanel.getGridView().getListbox().getColumns();
		List<Component> columnList = columns.getChildren();
		GridField[] fields = tabPanel.getGridView().getFields();
		Map<Integer, String> columnsWidth = new HashMap<Integer, String>();
		ArrayList<Integer> gridFieldIds = new ArrayList<Integer>();
		for (int i = 0; i < fields.length; i++) {
			// 2 is offset of num of column in grid view and actual data fields.
			// in grid view, add two function column, indicator column and selection (checkbox) column
			// @see GridView#setupColumns
			int offset = tabPanel.getGridView().isShowCurrentRowIndicatorColumn() ? 2 : 1;
			Column column = (Column) columnList.get(i+offset);
			String width = column.getWidth();
			if (GridView.ZERO_PX_WIDTH.equals(width) && column.getAttribute(GridView.COLUMN_WIDTH_ORIGINAL) != null) {
				width = (String) column.getAttribute(GridView.COLUMN_WIDTH_ORIGINAL);
			}
			columnsWidth.put(fields[i].getAD_Field_ID(), width);
			gridFieldIds.add(fields[i].getAD_Field_ID());

		}
		showCustomize(0, tabPanel.getGridTab().getAD_Tab_ID(), columnsWidth,gridFieldIds,tabPanel.getGridView(), null, false, callback);
	}
	
	/**
	 * Show User customize (modal)
	 * @param WindowNo window no
	 * @param AD_Tab_ID
	 * @param columnsWidth 
	 * @param gridFieldIds list fieldId current display in gridview
	 * @param gridPanel
	 * @param isQuickForm
	 * @param quickGridView
	 * @return ignore the return value, it is not working correctly
	 * @deprecated 
	 */
	@Deprecated(forRemoval = true, since = "11")
	public static boolean showCustomize(int WindowNo, int AD_Tab_ID, Map <Integer, String> columnsWidth, ArrayList <Integer> gridFieldIds, GridView gridPanel,
		QuickGridView quickGridView, boolean isQuickForm)
	{
		showCustomize(WindowNo, AD_Tab_ID, columnsWidth, gridFieldIds, gridPanel, quickGridView, isQuickForm, null);
		return true;
	}
	
	/**
	 * Show customize grid view dialog
	 * @param WindowNo window no
	 * @param AD_Tab_ID
	 * @param columnsWidth 
	 * @param gridFieldIds list of fieldId currently display in gridview
	 * @param gridPanel
	 * @param quickGridView
	 * @param isQuickForm
	 * @param callback 
	 */
	public static void showCustomize(int WindowNo, int AD_Tab_ID, Map <Integer, String> columnsWidth, ArrayList <Integer> gridFieldIds, GridView gridPanel,
		QuickGridView quickGridView, boolean isQuickForm, Callback<Boolean> callback)
	{
		CustomizeGridViewDialog customizeWindow = new CustomizeGridViewDialog(WindowNo, AD_Tab_ID, Env.getAD_User_ID(Env.getCtx()), columnsWidth, gridFieldIds,
				isQuickForm);
		if (isQuickForm)
		{
			customizeWindow.setquickGridView(quickGridView);
		}
		else
		{
			customizeWindow.setGridPanel(gridPanel);
		}
		customizeWindow.addCallback(Window.AFTER_PAGE_DETACHED, t -> {
			if (callback != null)
				callback.onCallback(customizeWindow.isSaved());
		});
		AEnv.showWindow(customizeWindow);
	} // showCustomize

	/**
	 * @param QuickGridView
	 */
	private void setquickGridView(QuickGridView quickGridView)
	{
		quickCustomizePanel.setGridPanel(quickGridView);
	}

}
