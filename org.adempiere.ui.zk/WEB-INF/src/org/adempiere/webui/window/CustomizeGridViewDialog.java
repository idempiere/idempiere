package org.adempiere.webui.window;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.zkoss.zul.Column;
import org.zkoss.zul.Columns;

public class CustomizeGridViewDialog extends Window {

	/**
	 * 
	 */
	private static final long serialVersionUID = -138153049225192685L;

	private CustomizeGridViewPanel customizePanel;
	private QuickCustomizeGridViewPanel quickCustomizePanel;
	private boolean isQuickForm = false;

	/**
	 *	Standard Constructor
	 * 	@param WindowNo window no
	 *  @param AD_Tab_ID tab
	 * 	@param AD_User_ID user
	 * @param columnsWidth 
	 * @param isQuickForm 
	 */
	public CustomizeGridViewDialog(int windowNo, int AD_Tab_ID, int AD_User_ID, Map<Integer, String> columnsWidth,
			ArrayList<Integer> gridFieldIds, boolean isQuickForm) {
		setClosable(true);
		setTitle(Msg.getMsg(Env.getCtx(), "Customize"));
		this.isQuickForm = isQuickForm;
		initComponent(windowNo, AD_Tab_ID, AD_User_ID, columnsWidth, gridFieldIds);
	}
	
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
	
	public void setGridPanel(GridView gridPanel){
		customizePanel.setGridPanel(gridPanel);
	}

	/**
	 * show grid view customization dialog for tabPanel
	 * @param tabPanel
	 * @return true if saved is ok
	 */
	public static boolean onCustomize(ADTabpanel tabPanel) {
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
			columnsWidth.put(fields[i].getAD_Field_ID(), width);
			gridFieldIds.add(fields[i].getAD_Field_ID());

		}
		return showCustomize(0, tabPanel.getGridTab().getAD_Tab_ID(), columnsWidth,gridFieldIds,tabPanel.getGridView(), null, false);
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
	 */
	public static boolean showCustomize(int WindowNo, int AD_Tab_ID, Map <Integer, String> columnsWidth, ArrayList <Integer> gridFieldIds, GridView gridPanel,
		QuickGridView quickGridView, boolean isQuickForm)
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
		AEnv.showWindow(customizeWindow);
		return customizeWindow.isSaved();
	} // showCustomize

	/**
	 * @param QuickGridView
	 */
	private void setquickGridView(QuickGridView quickGridView)
	{
		quickCustomizePanel.setGridPanel(quickGridView);
	}

}
