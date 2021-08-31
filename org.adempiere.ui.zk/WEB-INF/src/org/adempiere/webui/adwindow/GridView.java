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

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.swing.table.AbstractTableModel;

import org.adempiere.base.Core;
import org.adempiere.model.MTabCustomization;
import org.adempiere.util.Callback;
import org.adempiere.util.GridRowCtx;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.EditorBox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.NumberBox;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.util.SortComparator;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.MSysConfig;
import org.compiere.model.StateChangeEvent;
import org.compiere.model.StateChangeListener;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.lang.Library;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.AbstractComponent;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.IdSpace;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Center;
import org.zkoss.zul.Column;
import org.zkoss.zul.Div;
import org.zkoss.zul.Frozen;
import org.zkoss.zul.Paging;
import org.zkoss.zul.Row;
import org.zkoss.zul.Vlayout;
import org.zkoss.zul.event.ZulEvents;
import org.zkoss.zul.impl.CustomGridDataLoader;

/**
 * Grid view implemented using the Grid component.
 * @author Low Heng Sin
 *
 */
public class GridView extends Vlayout implements EventListener<Event>, IdSpace, IFieldEditorContainer, StateChangeListener
{
	public static final String ZERO_PX_WIDTH = "0px";

	private static final String GRID_VIEW_GRID_FIELD_INDEX = "gridView.gridField.index";

	public static final String COLUMN_WIDTH_ORIGINAL = "column.width.original";

	private static final String COLUMN_HFLEX_ORIGINAL = "column.hflex.original";

	private static final int MIN_COLUMN_MOBILE_WIDTH = 100;

	/**
	 * 
	 */
	private static final long serialVersionUID = 3995829393137424527L;

	private static final String HEADER_GRID_STYLE = "border: none; margin:0; padding: 0;";

	private static final int DEFAULT_DETAIL_PAGE_SIZE = 10;

	private static final int DEFAULT_MOBILE_PAGE_SIZE = 20;
	
	private static final int DEFAULT_PAGE_SIZE = 20;

	private static final int MIN_COLUMN_WIDTH = 100;

	private static final int MAX_COLUMN_WIDTH = 300;

	private static final int MIN_COMBOBOX_WIDTH = 160;

	private static final int MIN_NUMERIC_COL_WIDTH = 120;

	private static final String ATTR_ON_POST_SELECTED_ROW_CHANGED = "org.adempiere.webui.adwindow.GridView.onPostSelectedRowChanged";

	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (GridView.class);

	private Grid listbox = null;

	private int pageSize = DEFAULT_PAGE_SIZE;

	/**
	 * list field display in grid mode, in case user customize grid
	 * this list container only customize list.
	 */
	private GridField[] gridField;
	private AbstractTableModel tableModel;

	private int numColumns = 5;

	private int windowNo;

	private GridTab gridTab;

	private boolean init;

	private GridTableListModel listModel;

	private Paging paging;

	private GridTabRowRenderer renderer;

	private Div gridFooter;

	private boolean modeless = true;

	private String columnOnClick;

	private AbstractADWindowContent windowPanel;

	private boolean refreshing;

	private Map<Integer, String> columnWidthMap;

	private boolean detailPaneMode;

	protected Checkbox selectAll;
	
	boolean isHasCustomizeData = false;

	private boolean showCurrentRowIndicatorColumn = true;

	private String m_isAutoHideEmptyColumn;

	public GridView()
	{
		this(0);
	}

	/**
	 * @param windowNo
	 */
	public GridView(int windowNo)
	{
		this.windowNo = windowNo;
		setId("gridView");
		createListbox();

		ZKUpdateUtil.setHflex(this, "1");
		
		gridFooter = new Div();
		ZKUpdateUtil.setVflex(gridFooter, "0");
		
		//default paging size
		if (ClientInfo.isMobile())
		{
			//Should be <= 20 on mobile
			pageSize = MSysConfig.getIntValue(MSysConfig.ZK_MOBILE_PAGING_SIZE, DEFAULT_MOBILE_PAGE_SIZE, Env.getAD_Client_ID(Env.getCtx()));
			String limit = Library.getProperty(CustomGridDataLoader.GRID_DATA_LOADER_LIMIT);
			if (limit == null || !(limit.equals(Integer.toString(pageSize)))) {
				Library.setProperty(CustomGridDataLoader.GRID_DATA_LOADER_LIMIT, Integer.toString(pageSize));
			}
		}
		else
		{
			pageSize = MSysConfig.getIntValue(MSysConfig.ZK_PAGING_SIZE, DEFAULT_PAGE_SIZE, Env.getAD_Client_ID(Env.getCtx()));
			String limit = Library.getProperty(CustomGridDataLoader.GRID_DATA_LOADER_LIMIT);
			if (limit == null || !(limit.equals(Integer.toString(pageSize)))) {
				Library.setProperty(CustomGridDataLoader.GRID_DATA_LOADER_LIMIT, Integer.toString(pageSize));
			}
		}		
		
		//default true for better UI experience
		if (ClientInfo.isMobile())
			modeless = MSysConfig.getBooleanValue(MSysConfig.ZK_GRID_MOBILE_EDIT_MODELESS, false) && MSysConfig.getBooleanValue(MSysConfig.ZK_GRID_MOBILE_EDITABLE, false);
		else
			modeless = MSysConfig.getBooleanValue(MSysConfig.ZK_GRID_EDIT_MODELESS, true);
		
		appendChild(listbox);
		appendChild(gridFooter);								
		ZKUpdateUtil.setVflex(this, "true");
		
		setStyle(HEADER_GRID_STYLE);
		gridFooter.setStyle(HEADER_GRID_STYLE);
		
		addEventListener("onSelectRow", this);
		addEventListener("onCustomizeGrid", this);
	}

	protected void createListbox() {
		listbox = new Grid();		
		listbox.setSizedByContent(false);				
		ZKUpdateUtil.setVflex(listbox, "1");
		ZKUpdateUtil.setHflex(listbox, "1");
		listbox.setSclass("adtab-grid");
		listbox.setEmptyMessage(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Processing")));
	}
	
	public void setDetailPaneMode(boolean detailPaneMode, GridTab gridTab) {
		if (this.detailPaneMode != detailPaneMode) {
			this.detailPaneMode = detailPaneMode;
			pageSize = detailPaneMode ? getDetailPageSize(gridTab) : MSysConfig.getIntValue(MSysConfig.ZK_PAGING_SIZE, 20, Env.getAD_Client_ID(Env.getCtx()));
			updatePaging();
		}
	}

	/** Returns the number of records to be displayed in detail grid */
	private int getDetailPageSize(GridTab gridTab) {
		int size = DEFAULT_DETAIL_PAGE_SIZE;
		String pageDetailSizes = MSysConfig.getValue(MSysConfig.ZK_PAGING_DETAIL_SIZE, Env.getAD_Client_ID(Env.getCtx()));
		if (Util.isEmpty(pageDetailSizes, true)) {
			return size;
		}
		/* Format of ZK_PAGING_DETAIL_SIZE is a list of components separated by ;
		 * first component is the wide default
		 * next components are exceptions defined as pair of tab:size - where tab can be AD_Tab_ID, AD_Tab_UU or AD_TableName
		 */
		for (String pageDetailSize : pageDetailSizes.split(";")) {
			String[] parts = pageDetailSize.split(":");
			if (parts.length < 1 || parts.length > 2) {
				s_log.warning("Misconfiguration of ZK_PAGING_DETAIL_SIZE - cannot split : in -> " + pageDetailSize);
				return size;
			}
			String sizeToParse = null;
			if (parts.length == 1) {
				sizeToParse = parts[0];
			} else {
				String tab = parts[0];
				if (   tab.equalsIgnoreCase(String.valueOf(gridTab.getAD_Tab_ID()))
					|| tab.equalsIgnoreCase(String.valueOf(gridTab.getAD_Tab_UU()))
					|| tab.equalsIgnoreCase(String.valueOf(gridTab.getTableName()))) {
					sizeToParse = parts[1];
				}
			}
			if (sizeToParse != null) {
				int sizeParsed = -1;
				try {
					sizeParsed = Integer.valueOf(sizeToParse);
				} catch (NumberFormatException e) {
					s_log.warning("Misconfiguration of ZK_PAGING_DETAIL_SIZE - cannot parse as integer -> " + sizeToParse);
					return size;
				}
				if (sizeParsed > 0) {
					size = sizeParsed;
					if (parts.length > 1) {
						// found a specific tab size configuration
						break;
					}
				}
			}
		}
		return size;
	}

	public boolean isDetailPaneMode() {
		return this.detailPaneMode;
	}
	
	private void updatePaging() {
		if (paging != null && paging.getPageSize() != pageSize) {
			paging.setPageSize(pageSize);
			updateModel();
			if (paging.getPageCount() > 1) {
				showPagingControl();
			} else {
				hidePagingControl();
			}
		}
	}

	/**
	 *
	 * @param gridTab
	 */
	public void init(GridTab gridTab)
	{
		if (init) return;

		if (this.gridTab != null)
			this.gridTab.removeStateChangeListener(this);
		
		setupFields(gridTab);

		setupColumns();
		render();
		
		if (listbox.getFrozen() != null){
			listbox.getFrozen().setWidgetOverride("syncScroll", "function (){idempiere.syncScrollFrozen(this);}");
		}
		
		updateListIndex();

		autoHideEmptyColumns();
		
		this.init = true;
		
		showRecordsCount();
	}

	private void showRecordsCount() {
		Component parent = this.getParent();
		while (parent != null) {
			if (parent instanceof DetailPane) {
				DetailPane p = (DetailPane) parent;
				if (p.getSelectedADTabpanel() != null && p.getSelectedADTabpanel().getGridTab() == this.gridTab)
					p.setStatusMessage(tableModel.getRowCount() + " " + Msg.getMsg(Env.getCtx(), "Records"), false);
				break;
			} 
			parent = parent.getParent();					
		}
	}
	
	private void setupFields(GridTab gridTab) {		
		this.gridTab = gridTab;		
		gridTab.addStateChangeListener(this);
		
		tableModel = gridTab.getTableModel();
		columnWidthMap = new HashMap<Integer, String>();
		GridField[] tmpFields = ((GridTable)tableModel).getFields();
		MTabCustomization tabCustomization = MTabCustomization.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()), gridTab.getAD_Tab_ID(), null);
		isHasCustomizeData = tabCustomization != null && tabCustomization.getAD_Tab_Customization_ID() > 0 
				&& tabCustomization.getCustom() != null && tabCustomization.getCustom().trim().length() > 0;
		if (isHasCustomizeData) {
			String custom = tabCustomization.getCustom().trim();
			String[] customComponent = custom.split(";");
			String[] fieldIds = customComponent[0].split("[,]");
			List<GridField> fieldList = new ArrayList<GridField>();
			for(String fieldIdStr : fieldIds) {
				fieldIdStr = fieldIdStr.trim();
				if (fieldIdStr.length() == 0) continue;
				int AD_Field_ID = Integer.parseInt(fieldIdStr);
				for(GridField gridField : tmpFields) {
					if (gridField.getAD_Field_ID() == AD_Field_ID) {
						// IDEMPIERE-2204 add field in tabCustomization list to display list event this field have showInGrid = false
						if((gridField.isDisplayedGrid() || gridField.isDisplayed()) && !gridField.isToolbarOnlyButton())
							fieldList.add(gridField);
						
						break;
					}
				}
			}
			gridField = fieldList.toArray(new GridField[0]);			
			if (customComponent.length == 2) {
				String[] widths = customComponent[1].split("[,]");
				for(int i = 0; i< gridField.length && i<widths.length; i++) {
					columnWidthMap.put(gridField[i].getAD_Field_ID(), widths[i]);
				}
			}
			m_isAutoHideEmptyColumn = tabCustomization.getIsAutoHideEmptyColumn();
		} else {
			ArrayList<GridField> gridFieldList = new ArrayList<GridField>();
			
			//limit number of columns on mobile for better performance
			int max = 0;
			if (ClientInfo.isMobile())
				max = MSysConfig.getIntValue(MSysConfig.ZK_GRID_MOBILE_MAX_COLUMNS, 10, Env.getAD_Client_ID(Env.getCtx()));
			for(GridField field:tmpFields){
				if(field.isDisplayedGrid() && !field.isToolbarOnlyButton()) {
					gridFieldList.add(field);
				}
				if (max > 0 && gridFieldList.size() >= max)
					break;
			}
			
			Collections.sort(gridFieldList, new Comparator<GridField>() {
				@Override
				public int compare(GridField o1, GridField o2) {
					return o1.getSeqNoGrid()-o2.getSeqNoGrid();
				}
			});
			
			gridField = new GridField[gridFieldList.size()];
			gridFieldList.toArray(gridField);
		}
		numColumns = gridField.length;
	}

	/**
	 *
	 * @return boolean
	 */
	public boolean isInit() {
		return init;
	}

	/**
	 * call when tab is activated
	 * @param gridTab
	 */
	public void activate(GridTab gridTab) {
		if (!isInit()) {
			init(gridTab);
		} else {
			showRecordsCount();
		}
		if (this.isVisible())
			listbox.invalidate();
	}

	/**
	 * refresh after switching from form view
	 * @param gridTab
	 */
	public void refresh(GridTab gridTab) {
		if (this.gridTab != gridTab || !isInit())
		{
			init = false;
			init(gridTab);
		}
		else
		{
			refreshing = true;
			listbox.setModel(listModel);
			updateListIndex();
			refreshing = false;			
			if (gridTab.getRowCount() == 0 && selectAll.isChecked())
				selectAll.setChecked(false);
		}
	}

	public boolean isRefreshing() {
		return refreshing;
	}

	/**
	 * Update current row from model
	 */
	public void updateListIndex() {
		if (gridTab == null || !gridTab.isOpen()) return;

		updateEmptyMessage();		
		
		int rowIndex  = gridTab.getCurrentRow();
		if (pageSize > 0) {
			if (paging.getTotalSize() != gridTab.getRowCount())
				paging.setTotalSize(gridTab.getRowCount());
			if (paging.getPageCount() > 1 && !gridFooter.isVisible()) {
				showPagingControl();
			}
			int pgIndex = rowIndex >= 0 ? rowIndex % pageSize : 0;
			int pgNo = rowIndex >= 0 ? (rowIndex - pgIndex) / pageSize : 0;
			if (listModel.getPage() != pgNo) {
				listModel.setPage(pgNo);
				if (renderer.isEditing()) {
					renderer.stopEditing(false);
				}
			} else if (rowIndex == renderer.getCurrentRowIndex()){
				if (modeless && !renderer.isEditing())
					echoOnPostSelectedRowChanged();
				return;
			} else {
				if (renderer.isEditing()) {
					renderer.stopEditing(false);
					int editingRow = renderer.getCurrentRowIndex();
					if (editingRow >= 0) {
						int editingPgIndex = editingRow % pageSize;
						int editingPgNo = (editingRow - editingPgIndex) / pageSize;
						if (editingPgNo == pgNo) {
							listModel.updateComponent(renderer.getCurrentRowIndex() % pageSize);
						}
					}
				}
			}
			if (paging.getActivePage() != pgNo) {
				paging.setActivePage(pgNo);
			}
			if (paging.getPageCount() == 1) {
				hidePagingControl();
			} else {
				showPagingControl();
			}
			if (rowIndex >= 0 && pgIndex >= 0) {
				echoOnPostSelectedRowChanged();
			}
		} else {
			if (rowIndex >= 0) {
				echoOnPostSelectedRowChanged();
			}
		}		
	}

	private void hidePagingControl() {
		if (gridFooter.isVisible())
			gridFooter.setVisible(false);
	}

	private void showPagingControl() {
		if (!gridFooter.isVisible())
			gridFooter.setVisible(true);		
	}

	/**
	 * 
	 */
	protected void echoOnPostSelectedRowChanged() {
		if (getAttribute(ATTR_ON_POST_SELECTED_ROW_CHANGED) == null) {
			setAttribute(ATTR_ON_POST_SELECTED_ROW_CHANGED, Boolean.TRUE);
			Events.echoEvent("onPostSelectedRowChanged", this, null);
		}
	}

	/**
	 * set paging size
	 * @param pageSize
	 */
	public void setPageSize(int pageSize)
	{
		this.pageSize = pageSize;
	}

	public void clear()
	{
		this.getChildren().clear();
	}

	private void setupColumns()
	{
		if (init) return;

		Columns columns = new Columns();
		
		//frozen not working well on tablet devices yet
		//unlikely to be fixed since the working 'smooth scrolling frozen' is a zk ee only feature
		if (!ClientInfo.isMobile())
		{
			Frozen frozen = new Frozen();
			//freeze selection and indicator column
			frozen.setColumns(2);
			listbox.appendChild(frozen);
		}
				
		org.zkoss.zul.Column selection = new Column();
		selection.setHeight("2em");
		ZKUpdateUtil.setWidth(selection, "22px");
		try{
			selection.setSort("none");
		} catch (Exception e) {}
		selection.setStyle("border-right: none");
		selectAll = new Checkbox();
		selection.appendChild(selectAll);
		selectAll.setId("selectAll");
		selectAll.addEventListener(Events.ON_CHECK, this);
		columns.appendChild(selection);
		
		if (ClientInfo.isMobile())
			showCurrentRowIndicatorColumn = MSysConfig.getBooleanValue(MSysConfig.ZK_GRID_MOBILE_SHOW_CURRENT_ROW_INDICATOR, false);
		
		if (showCurrentRowIndicatorColumn)
		{
			org.zkoss.zul.Column indicator = new Column();
			indicator.setHeight("2em");
			ZKUpdateUtil.setWidth(indicator, "22px");
			try {
				indicator.setSort("none");
			} catch (Exception e) {}
			indicator.setStyle("border-left: none");
			columns.appendChild(indicator);
		}
		
		listbox.appendChild(columns);
		columns.setSizable(true);
		columns.setMenupopup("none");
		columns.setColumnsgroup(false);

		Map<Integer, String> colnames = new HashMap<Integer, String>();
		int index = 0;
		
		for (int i = 0; i < numColumns; i++)
		{
			// IDEMPIERE-2148: when has tab customize, ignore check properties isDisplayedGrid
			if ((isHasCustomizeData || gridField[i].isDisplayedGrid()) && !gridField[i].isToolbarOnlyButton())
			{
				colnames.put(index, gridField[i].getHeader());
				index++;
				org.zkoss.zul.Column column = new Column();
				column.setAttribute(GRID_VIEW_GRID_FIELD_INDEX, i);
				column.setHeight("2em");
				int colindex =tableModel.findColumn(gridField[i].getColumnName()); 
				column.setSortAscending(new SortComparator(colindex, true, Env.getLanguage(Env.getCtx())));
				column.setSortDescending(new SortComparator(colindex, false, Env.getLanguage(Env.getCtx())));
				//IDEMPIERE-2898 - UX: Field only showing title at header on grid
				if( gridField[i].isFieldOnly() )
					column.setLabel("");
				else
					column.setLabel(gridField[i].getHeader());

				if (columnWidthMap != null && columnWidthMap.get(gridField[i].getAD_Field_ID()) != null && !columnWidthMap.get(gridField[i].getAD_Field_ID()).equals("")) {
					ZKUpdateUtil.setWidth(column, columnWidthMap.get(gridField[i].getAD_Field_ID()));
				} else {
					if (gridField[i].getDisplayType()==DisplayType.YesNo) {
						if (i > 0) {
							ZKUpdateUtil.setHflex(column, "min");
						} else {
							int estimatedWidth=60;
							int headerWidth = (gridField[i].getHeader().length()+2) * 8;
							if (headerWidth > estimatedWidth)
								estimatedWidth = headerWidth;
							ZKUpdateUtil.setWidth(column, estimatedWidth+"px");
						}
					} else if (DisplayType.isNumeric(gridField[i].getDisplayType()) && "Line".equals(gridField[i].getColumnName())) {
						//special treatment for line
						if (i > 0)
							ZKUpdateUtil.setHflex(column, "min");
						else
							ZKUpdateUtil.setWidth(column, "60px");
					} else {
						int estimatedWidth = 0;
						if (DisplayType.isNumeric(gridField[i].getDisplayType()))
							estimatedWidth = MIN_NUMERIC_COL_WIDTH;
						else if (DisplayType.isLookup(gridField[i].getDisplayType()))
							estimatedWidth = MIN_COMBOBOX_WIDTH;
						else if (DisplayType.isText(gridField[i].getDisplayType()))
							estimatedWidth = gridField[i].getDisplayLength() * 8;
						else
							estimatedWidth = MIN_COLUMN_WIDTH;
					
						int headerWidth = (gridField[i].getHeader().length()+2) * 8;
						if (headerWidth > estimatedWidth)
							estimatedWidth = headerWidth;
						
						//hflex=min for first column not working well
						if (i > 0 && !ClientInfo.isMobile())
						{
							if (DisplayType.isLookup(gridField[i].getDisplayType()))
							{
								if (headerWidth > MIN_COMBOBOX_WIDTH)
									ZKUpdateUtil.setHflex(column, "min");
							}
							else if (DisplayType.isNumeric(gridField[i].getDisplayType()))
							{
								if (headerWidth > MIN_NUMERIC_COL_WIDTH)
									ZKUpdateUtil.setHflex(column, "min");
							}
							else if (!DisplayType.isText(gridField[i].getDisplayType()))
							{
								if (headerWidth > MIN_COLUMN_WIDTH)
									ZKUpdateUtil.setHflex(column, "min");
							}
						}
						
						//set estimated width if not using hflex=min
						if (!"min".equals(column.getHflex())) {
							if (ClientInfo.isMobile() && ClientInfo.get() != null &&
								ClientInfo.get().desktopWidth <= ClientInfo.SMALL_WIDTH) {
								int maxWidth = ClientInfo.get().desktopWidth / 5;
								if (maxWidth < MIN_COLUMN_MOBILE_WIDTH)
									maxWidth = MIN_COLUMN_MOBILE_WIDTH;
								if (estimatedWidth > maxWidth)
									estimatedWidth = maxWidth;
							} else {
								if (estimatedWidth > MAX_COLUMN_WIDTH)
									estimatedWidth = MAX_COLUMN_WIDTH;
								else if ( estimatedWidth < MIN_COLUMN_WIDTH)
									estimatedWidth = MIN_COLUMN_WIDTH;								
							}
							ZKUpdateUtil.setWidth(column, Integer.toString(estimatedWidth) + "px");
						}
					}
				} 
				columns.appendChild(column);
			}
		}
	}

	private void render()
	{
		updateEmptyMessage();
		
		listbox.addEventListener(Events.ON_CLICK, this);

		updateModel();

		if (pageSize > 0)
		{
			paging = new Paging();
			paging.setPageSize(pageSize);
			paging.setTotalSize(tableModel.getRowCount());
			paging.setDetailed(true);
			paging.setId("paging");
			gridFooter.appendChild(paging);			
			paging.addEventListener(ZulEvents.ON_PAGING, this);
			renderer.setPaging(paging);
			if (paging.getPageCount() == 1) {
				hidePagingControl();
			} else {
				showPagingControl();				
			}						
			positionPagingControl();
		}
		else
		{
			hidePagingControl();
		}		
		
	}

	/**
	 * auto hide empty columns
	 */
	protected void autoHideEmptyColumns() {
		if (!isAutoHideEmptyColumns()) {
			return;
		}
		
		String attr = listbox.getUuid()+".autoHideEmptyColumns";
		if (Executions.getCurrent().getAttribute(attr) != null) {
			return;
		} else {
			Executions.getCurrent().setAttribute(attr, Boolean.TRUE);
		}
		
		org.zkoss.zul.Columns columns = listbox.getColumns();
		List<Column> columnList = columns.getChildren();
		int rowCount = listModel.getSize();
		GridField[] gridTabFields = gridTab.getFields();
		Map<Integer, Integer> indexMap = new HashMap<Integer, Integer>();
		if (rowCount > 0) {
			for(Column column : columnList) {
				Object value = column.getAttribute(GRID_VIEW_GRID_FIELD_INDEX);
				if (value == null || !(value instanceof Integer))
					continue;
				int index = (Integer)value;
				for(int i = 0; i < gridTabFields.length; i++) {
					if (gridField[index].getAD_Field_ID() == gridTabFields[i].getAD_Field_ID()) {
						indexMap.put(index, i);
						break;
					}
				}
			}
		}
		
		for(Column column : columnList) {
			Object value = column.getAttribute(GRID_VIEW_GRID_FIELD_INDEX);
			if (value == null || !(value instanceof Integer))
				continue;
			int index = (Integer)value;
			boolean hideColumn = false;
			if (rowCount > 0) {
				int valueIndex = indexMap.get(index);
				hideColumn = true;
				for (int i = 0; i < rowCount; i++) {
					Object[] values = (Object[]) listModel.getElementAt(i);					
					int rowIndex = i;
					if (paging != null && paging.getPageSize() > 0) {
						rowIndex = (paging.getActivePage() * paging.getPageSize()) + rowIndex;
					}
					String display = renderer.getDisplayTextWithEditorCheck(values[valueIndex], gridField[index], rowIndex);
					if (!Util.isEmpty(display, true)) {
						hideColumn = false;
						break;
					} else if (gridTab.getCurrentRow() == rowIndex && gridTab.isNew()) {
						if (gridField[index].isEditable(false) && (gridField[index].isMandatory(false) || !Util.isEmpty(gridField[index].getVO().MandatoryLogic) 
							|| !Util.isEmpty(gridField[index].getVO().DisplayLogic)
							|| !Util.isEmpty(gridField[index].getVO().ReadOnlyLogic))) {
							hideColumn = false;
							break;
						}
					}
				}
			}
			
			if (hideColumn && column.isVisible() && !ZERO_PX_WIDTH.equals(column.getWidth())) {
				String width = column.getWidth();
				String hflex = column.getHflex();
				if (!Util.isEmpty(hflex, true)) {
					column.setAttribute(COLUMN_HFLEX_ORIGINAL, hflex);
					column.setHflex(null);
				}
				column.setWidth(ZERO_PX_WIDTH);
				if (column.getAttribute(COLUMN_WIDTH_ORIGINAL) == null)
					column.setAttribute(COLUMN_WIDTH_ORIGINAL, width != null ? width : "");
			} else if (!hideColumn && column.isVisible() && ZERO_PX_WIDTH.equals(column.getWidth()) && column.getAttribute(COLUMN_WIDTH_ORIGINAL) != null) {
				if (column.getAttribute(COLUMN_HFLEX_ORIGINAL) != null ) {
					String hflex = (String)column.getAttribute(COLUMN_HFLEX_ORIGINAL);
					column.setWidth(null);
					column.setHflex(hflex);
				} else {
					column.setWidth((String) column.getAttribute(COLUMN_WIDTH_ORIGINAL));
				}
			}
		}
	}

	private boolean isAutoHideEmptyColumns() {
		if (!Util.isEmpty(m_isAutoHideEmptyColumn, true)) 
			return "Y".equalsIgnoreCase(m_isAutoHideEmptyColumn);
		else
			return MSysConfig.getBooleanValue(MSysConfig.ZK_GRID_AUTO_HIDE_EMPTY_COLUMNS, false, Env.getAD_Client_ID(Env.getCtx()));
	}

	private void updateEmptyMessage() {
		if (gridTab.getRowCount() == 0)
		{
			listbox.setEmptyMessage(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "FindZeroRecords")));
		}
		else
		{
			listbox.setEmptyMessage(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Processing")));
		}
	}

	private void updateModel() {
		if (listModel != null)
			((GridTable)tableModel).removeTableModelListener(listModel);
		listModel = new GridTableListModel((GridTable)tableModel, windowNo);
		listModel.setPageSize(pageSize);
		if (renderer != null && renderer.isEditing())
			renderer.stopEditing(false);
		renderer = new GridTabRowRenderer(gridTab, windowNo);
		renderer.setGridPanel(this);
		renderer.setADWindowPanel(windowPanel);
		if (pageSize > 0 && paging != null)
			renderer.setPaging(paging);

		listbox.setModel(listModel);
		if (listbox.getRows() == null) 
			listbox.appendChild(new Rows());
		listbox.setRowRenderer(renderer);
	}

	/**
	 * deactivate panel
	 */
	public void deactivate() {
		if (renderer != null && renderer.isEditing())
			renderer.stopEditing(true);
	}

	public void onEvent(Event event) throws Exception
	{
		if (event == null)
			return;
		else if (event.getTarget() == listbox && Events.ON_CLICK.equals(event.getName()))
		{
			Object data = event.getData();
			org.zkoss.zul.Row row = null;
			String columnName = null;
			if (data != null && data instanceof Component)
			{
				if (data instanceof org.zkoss.zul.Row)
					row = (org.zkoss.zul.Row) data;
				else
				{
					AbstractComponent cmp = (AbstractComponent) data;
					if (cmp.getParent() instanceof org.zkoss.zul.Row)
					{
						row = (Row) cmp.getParent();
						columnName = (String) cmp.getAttribute("columnName");
					}
				}
			}
			if (row != null)
			{
				//click on selected row to enter edit mode
				if (row == renderer.getCurrentRow())
				{
					if (!renderer.isEditing())
					{
						renderer.editCurrentRow();
						if (columnName != null && columnName.trim().length() > 0)
							setFocusToField(columnName);
						else
							renderer.focusToFirstEditor();
					}
				}
				else
				{
					int index = listbox.getRows().getChildren().indexOf(row);
					if (index >= 0 ) {
						columnOnClick = columnName;
						onSelectedRowChange(index);
					}
				}
			}
			event.stopPropagation();
        }
		else if (event.getTarget() == paging)
		{
			int pgNo = paging.getActivePage();
			if (pgNo != listModel.getPage())
			{
				listModel.setPage(pgNo);
				onSelectedRowChange(0);
				gridTab.clearSelection();
				invalidateGridView();
			}
		}
		else if (event.getTarget() == selectAll)
		{
			toggleSelectionForAll(selectAll.isChecked());
		}
		else if (event.getName().equals("onSelectRow"))
		{
			Checkbox checkbox = (Checkbox) event.getData();
			int rowIndex = (Integer) checkbox.getAttribute(GridTabRowRenderer.GRID_ROW_INDEX_ATTR);			
			if (checkbox.isChecked())
			{
				gridTab.addToSelection(rowIndex);
				if (!selectAll.isChecked() && isAllSelected())
				{
					selectAll.setChecked(true);
				}
			}
			else
			{
				gridTab.removeFromSelection(rowIndex);
				if (selectAll.isChecked())
					selectAll.setChecked(false);
			}
		}
		else if (event.getName().equals("onCustomizeGrid"))
		{
			reInit();
		}
	}

	private Center findCenter(GridView gridView) {
		if (gridView == null)
			return null;
		Component p = gridView.getParent();
		while (p != null) {
			if (p instanceof Center)
				return (Center)p;
			p = p.getParent();
		}
		return null;
	}
	
	private boolean isAllSelected() {
		org.zkoss.zul.Rows rows = listbox.getRows();
		List<Component> childs = rows.getChildren();
		boolean all = false;
		for(Component comp : childs) {
			org.zkoss.zul.Row row = (org.zkoss.zul.Row) comp;
			Component firstChild = row.getFirstChild();
			if (firstChild instanceof Cell) {
				firstChild = firstChild.getFirstChild();
			}
			if (firstChild instanceof Checkbox) {
				Checkbox checkbox = (Checkbox) firstChild;
				if (!checkbox.isChecked())
					return false;
				else
					all = true;
			}
		}
		return all;
	}

	private void toggleSelectionForAll(boolean b) {
		org.zkoss.zul.Rows rows = listbox.getRows();
		List<Component> childs = rows.getChildren();
		for(Component comp : childs) {
			org.zkoss.zul.Row row = (org.zkoss.zul.Row) comp;
			Component firstChild = row.getFirstChild();
			if (firstChild instanceof Cell) {
				firstChild = firstChild.getFirstChild();
			}
			if (firstChild instanceof Checkbox) {
				Checkbox checkbox = (Checkbox) firstChild;
				checkbox.setChecked(b);
				int rowIndex = (Integer) checkbox.getAttribute(GridTabRowRenderer.GRID_ROW_INDEX_ATTR);
				if (b)
					gridTab.addToSelection(rowIndex);
				else
					gridTab.removeFromSelection(rowIndex);
			}
		}		
	}

	private void onSelectedRowChange(int index) {
		if (updateModelIndex(index)) {
			updateListIndex();
		}
	}

	/**
	 * Event after the current selected row change
	 */
	public void onPostSelectedRowChanged() {
		removeAttribute(ATTR_ON_POST_SELECTED_ROW_CHANGED);
		if (listbox.getRows() == null || listbox.getRows().getChildren().isEmpty())
			return;

		int rowIndex  = gridTab.isOpen() ? gridTab.getCurrentRow() : -1;
		if (rowIndex >= 0 && pageSize > 0) {
			int pgIndex = rowIndex >= 0 ? rowIndex % pageSize : 0;
			org.zkoss.zul.Row row = (org.zkoss.zul.Row) listbox.getRows().getChildren().get(pgIndex);
			if (!isRowRendered(row, pgIndex)) {
				listbox.renderRow(row);
			} else {
				renderer.setCurrentRow(row);
				//remark: following 3 line cause the previously selected row being render twice
//				if (old != null && old != row && oldIndex >= 0 && oldIndex != gridTab.getCurrentRow())
//				{
//					listModel.updateComponent(oldIndex % pageSize);
//				}
			}
			if (modeless && !renderer.isEditing()) {
				renderer.editCurrentRow();
				if (columnOnClick != null && columnOnClick.trim().length() > 0) {
					setFocusToField(columnOnClick);
					columnOnClick = null;
				} else {
					focusToFirstEditorIfNotDetailTab();
				}
			} else {
				focusToRow(row);
			}
		} else if (rowIndex >= 0) {
			org.zkoss.zul.Row row = (org.zkoss.zul.Row) listbox.getRows().getChildren().get(rowIndex);
			if (!isRowRendered(row, rowIndex)) {
				listbox.renderRow(row);
			} else {
				renderer.setCurrentRow(row);
				//remark: following 3 line cause the previously selected row being render twice
//				if (old != null && old != row && oldIndex >= 0 && oldIndex != gridTab.getCurrentRow())
//				{
//					listModel.updateComponent(oldIndex);
//				}
			}
			if (modeless && !renderer.isEditing()) {
				renderer.editCurrentRow();
				if (columnOnClick != null && columnOnClick.trim().length() > 0) {
					setFocusToField(columnOnClick);
					columnOnClick = null;
				} else {
					renderer.focusToFirstEditor();
				}
			} else {
				focusToRow(row);
			}
		}
	}

	private void focusToFirstEditorIfNotDetailTab() {
		ADTabpanel adtabpanel = null;
		boolean setFocus = true;
		Component parent = listbox.getParent();
		while (parent != null) {
			if (parent instanceof ADTabpanel) {
				adtabpanel = (ADTabpanel) parent;
				break;
			}
			parent = parent.getParent();
		}					
		if (adtabpanel != null)
		{
			ADWindow adwindow = ADWindow.findADWindow(adtabpanel);
			if (adwindow != null) {
				IADTabpanel selectedADTabpanel = adwindow.getADWindowContent().getADTab().getSelectedTabpanel();
				IADTabpanel  selectedADDetailTabpanel = null ;
				if(selectedADTabpanel.getDetailPane() != null)
					selectedADDetailTabpanel = selectedADTabpanel.getDetailPane().getSelectedADTabpanel();
				
				if (selectedADTabpanel != adtabpanel && selectedADDetailTabpanel != null && selectedADDetailTabpanel != adtabpanel)
					setFocus = false;
			}
		}
		if (setFocus)
			renderer.focusToFirstEditor();
	}

	/**
	 * scroll grid to the current focus row
	 */
	public void scrollToCurrentRow() {
		onPostSelectedRowChanged();
	}
	
	private void focusToRow(org.zkoss.zul.Row row) {
		if (renderer.isEditing()) {
			if (columnOnClick != null && columnOnClick.trim().length() > 0) {
				setFocusToField(columnOnClick);
				columnOnClick = null;
			} else {
				focusToFirstEditorIfNotDetailTab();
			}
		} else {
			Component cmp = null;
			List<?> childs = row.getChildren();
			for (Object o : childs) {
				Component c = (Component) o;
				if (!c.isVisible())
					continue;
				if (c instanceof Cell) {
					cmp = c;
					break;
				}
			}
			if (cmp != null)
				Clients.response(new AuScript(null, "idempiere.scrollToRow('" + cmp.getUuid() + "');"));

			if (columnOnClick != null && columnOnClick.trim().length() > 0) {
				List<?> list = row.getChildren();
				for(Object element : list) {
					if (element instanceof Div) {
						Div div = (Div) element;
						if (columnOnClick.equals(div.getAttribute("columnName"))) {
							cmp = div.getFirstChild();
							Clients.response(new AuScript(null, "idempiere.scrollToRow('" + cmp.getUuid() + "');"));
							break;
						}
					}
				}
				columnOnClick = null;
			}
		}
	}

	private boolean isRowRendered(org.zkoss.zul.Row row, int index) {
		if (row.getChildren().size() == 0) {
			return false;
		} else if (row.getChildren().size() == 1) {
			if (!(row.getChildren().get(0) instanceof Div)) {
				return false;
			}
		}
		return true;
	}

	private boolean updateModelIndex(int rowIndex) {
		if (pageSize > 0) {
			int start = listModel.getPage() * listModel.getPageSize();
			rowIndex = start + rowIndex;
		}

		if (gridTab.getCurrentRow() != rowIndex) {
			ADWindow adwindow = ADWindow.findADWindow(this);
			if (adwindow != null) {
				final boolean[] retValue = new boolean[] {false};
				final int index = rowIndex;
				adwindow.getADWindowContent().saveAndNavigate(e -> {
					if (e) {
						gridTab.navigate(index);
						retValue[0] = true;
					}
				});
				return retValue[0];
			}
			
			gridTab.navigate(rowIndex);
			return true;
		}
		return false;
	}

	/**
	 * @return Grid
	 */
	public Grid getListbox() {
		return listbox;
	}

	/**
	 * Validate display properties of fields of current row
	 * @param col
	 */
	public void dynamicDisplay(int col) {
		if (gridTab == null || !gridTab.isOpen())
        {
            return;
        }
		
		if (renderer.getEditors().isEmpty())
			listbox.onInitRender();

        //  Selective
        if (col > 0)
        {
        	GridField changedField = gridTab.getField(col);
            String columnName = changedField.getColumnName();
            ArrayList<?> dependants = gridTab.getDependantFields(columnName);
			if ( ! (   dependants.size() > 0
					|| changedField.getCallout().length() > 0
					|| Core.findCallout(gridTab.getTableName(), columnName).size() > 0)) {
                return;
            }
        }
        	

        boolean noData = gridTab.getRowCount() == 0;
        List<WEditor> list =  renderer.getEditors();
        dynamicDisplayEditors(noData, list);   //  all components
        
        if (gridTab.getRowCount() == 0 && selectAll.isChecked())
			selectAll.setChecked(false);        
	}

	private void dynamicDisplayEditors(boolean noData, List<WEditor> list) {
		for (WEditor comp : list)
        {
            GridField mField = comp.getGridField();
            if (mField != null)
            {
            	Properties ctx = isDetailPane() ? new GridRowCtx(Env.getCtx(), gridTab) 
                		: mField.getVO().ctx;
            	
                if (noData)
                {
                    comp.setReadWrite(false);
                }
                else
                {
                    boolean rw = mField.isEditable(true);   //  r/w - check Context
                    if (rw && !comp.isReadWrite()) // IDEMPIERE-3421 - if it was read-only the list can contain direct values
                    	mField.refreshLookup();
                    comp.setReadWrite(rw);
                    comp.setMandatory(mField.isMandatory(true));    //  check context
                	comp.dynamicDisplay(ctx);
                }
                
                comp.setVisible((isHasCustomizeData || mField.isDisplayedGrid()) && mField.isDisplayed(ctx, true));
            }
        }
	}

	private boolean isDetailPane() {
		Component parent = this.getParent();
		while (parent != null) {
			if (parent instanceof DetailPane) {
				return true;
			} 
			parent = parent.getParent();					
		}
		return false;
	}
	
	/**
	 *
	 * @param windowNo
	 */
	public void setWindowNo(int windowNo) {
		this.windowNo = windowNo;
	}

	@Override
	public void focus() {
		if (renderer != null && renderer.isEditing()) {
			renderer.focusToFirstEditor();
		}
	}

	/**
	 * Handle enter key event
	 */
	public boolean onEnterKey() {
		if (!modeless && renderer != null && !renderer.isEditing()) {
			renderer.editCurrentRow();
			renderer.focusToFirstEditor();
			return true;
		}
		return false;
	}

	/**
	 * @param columnName
	 */
	public void setFocusToField(String columnName) {
		for (WEditor editor : renderer.getEditors()) {
			if (columnName.equals(editor.getColumnName())) {
				Component c = editor.getComponent();
				if (c instanceof EditorBox) {
					c = ((EditorBox)c).getTextbox();
				} else if (c instanceof NumberBox) {
					c = ((NumberBox)c).getDecimalbox();
				}
				Clients.response(new AuFocus(c));
				break;
			}
		}
	}

	/**
	 * @param winPanel
	 */
	public void setADWindowPanel(AbstractADWindowContent winPanel) {
		windowPanel = winPanel;
		if (renderer != null)
			renderer.setADWindowPanel(windowPanel);
	}

	public void reInit() {
		listbox.getChildren().clear();
		listbox.detach();
		
		if (paging != null) {
			paging.detach();
			paging = null;
		}
		
		renderer = null;
		init = false;
		
		Grid tmp = listbox;
		createListbox();
		tmp.copyEventListeners(listbox);
		insertBefore(listbox, gridFooter);
		
		refresh(gridTab);
		scrollToCurrentRow();
		invalidateGridView();
	}

	/**
	 * redraw grid view
	 */
	public void invalidateGridView() {
		Center center = findCenter(this);
		if (center != null)
			center.invalidate();
		else
			this.invalidate();
	}

	/**
	 * list field display in grid mode, in case user customize grid
	 * this list container only customize list.
	 */
	public GridField[] getFields() {
		return gridField;
	}
	
	public void onEditCurrentRow() {
		onEditCurrentRow(null);
	}
	
	public void onEditCurrentRow(Event event) {
		if (!renderer.isEditing()) {
			Row currentRow = renderer.getCurrentRow();
			if (currentRow == null || currentRow.getParent() == null || !currentRow.isVisible()) {
				if (event == null) {
					Events.postEvent("onEditCurrentRow", this, null);
				}
			} else {
				renderer.editCurrentRow();
				renderer.focusToFirstEditor();
			}
		} 
	}

	@Override
	public void focusToFirstEditor() {
		if (renderer.isEditing()) {
			renderer.focusToFirstEditor();
		}
	}

	@Override
	public void focusToNextEditor(WEditor ref) {
		if (renderer.isEditing()) {
			renderer.focusToNextEditor(ref);
		}
	}

	@Override
	public void stateChange(StateChangeEvent event) {
		switch(event.getEventType()) {
			case StateChangeEvent.DATA_NEW:
			case StateChangeEvent.DATA_QUERY:
			case StateChangeEvent.DATA_REFRESH_ALL:
				if (selectAll.isChecked())
					selectAll.setChecked(false);
				break;
			case StateChangeEvent.DATA_DELETE:
			case StateChangeEvent.DATA_IGNORE:
				if (!selectAll.isChecked() && isAllSelected())
					selectAll.setChecked(true);
				break;
		}
	}

	protected void onADTabPanelParentChanged() {
		positionPagingControl();
	}

	private void positionPagingControl() {
		if (isDetailPane()) {
			Component parent = this.getParent();
			while (parent != null) {
				if (parent instanceof DetailPane.Tabpanel) {
					((DetailPane.Tabpanel) parent).setPagingControl(gridFooter);
					break;
				}
				parent = parent.getParent();
			}
			if (paging != null)
				paging.setDetailed(false);
		}
		else 
		{
			if (gridFooter.getParent() != this) {
				ZKUpdateUtil.setHflex(gridFooter, "1");
				gridFooter.setSclass("adtab-grid-south");
				appendChild(gridFooter);
			}
			if (paging != null)
				paging.setDetailed(true);			
		}
	}

	@Override
	public void editorTraverse(Callback<WEditor> editorTaverseCallback) {
		editorTraverse(editorTaverseCallback, renderer.getEditors());
		
	}
	
	public boolean isShowCurrentRowIndicatorColumn() {
		return showCurrentRowIndicatorColumn;
	}
}
