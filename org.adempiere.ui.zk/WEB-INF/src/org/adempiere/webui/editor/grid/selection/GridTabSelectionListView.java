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
package org.adempiere.webui.editor.grid.selection;


import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.swing.table.AbstractTableModel;

import org.adempiere.model.MTabCustomization;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListHead;
import org.adempiere.webui.component.ListHeader;
import org.adempiere.webui.component.Listbox;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.MSysConfig;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Box;
import org.zkoss.zul.ListModel;
import org.zkoss.zul.Vlayout;
import org.zkoss.zul.ext.Selectable;

/**
 * Read only grid view for single or multi selection
 * @author Low Heng Sin
 *
 */
public class GridTabSelectionListView extends Vlayout
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4145737989132101461L;

	private static final int MIN_COLUMN_WIDTH = 100;

	private static final int MAX_COLUMN_WIDTH = 300;

	private Listbox listbox = null;
	
	private int pageSize = 100;
	
	private GridField[] gridField;
	private AbstractTableModel tableModel;
	
	private int numColumns = 5;
	
	private int windowNo;
	
	private GridTab gridTab;
	
	private boolean init;

	private SimpleGridTableListModel listModel;

	private GridTabSelectionListViewRenderer renderer;

	private Box labelBox;
	
	private Map<Integer, String> columnWidthMap;

	private Label selectedLabel;
	
	public GridTabSelectionListView(boolean multiple)
	{
		this(multiple, 0);
	}
	
	/**
	 * @param windowNo
	 */
	public GridTabSelectionListView(boolean multiple, int windowNo)
	{
		this.windowNo = windowNo;
		listbox = new Listbox();
		listbox.setCheckmark(true);
		listbox.setMultiple(multiple);
		labelBox = new Box();
		this.appendChild(labelBox);
		
		//default paging size
		pageSize = MSysConfig.getIntValue(MSysConfig.ZK_PAGING_SIZE, 100);
		listbox.setMold("paging");
		listbox.setPageSize(pageSize);
		
		setStyle("min-height: 200px;");
	}

	/**
	 * 
	 * @param gridTab
	 */
	public void init(GridTab gridTab)
	{
		if (init) return;
						
		setupFields(gridTab);
				
		setupColumns();
		render();
		
		this.init = true;
	}

	private void setupFields(GridTab gridTab) {
		this.gridTab = gridTab;
		tableModel = gridTab.getTableModel();						
		GridField[] tmpFields = ((GridTable)tableModel).getFields();
		MTabCustomization tabCustomization = MTabCustomization.get(Env.getCtx(), Env.getAD_User_ID(Env.getCtx()), gridTab.getAD_Tab_ID(), null);
		if (tabCustomization != null && tabCustomization.getAD_Tab_Customization_ID() > 0 
			&& tabCustomization.getCustom() != null && tabCustomization.getCustom().trim().length() > 0) {
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
						fieldList.add(gridField);
						break;
					}
				}
			}
			gridField = fieldList.toArray(new GridField[0]);
			if (customComponent.length == 2) {
				String[] widths = customComponent[1].split("[,]");
				for(int i = 0; i< gridField.length; i++) {
					columnWidthMap.put(gridField[i].getAD_Field_ID(), widths[i]);
				}
			}
		} else {
			gridField = tmpFields;
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
	 * 
	 * @param gridTab
	 */
	public void activate(GridTab gridTab) {		
		if (isInit())
		{
			if (this.gridTab != gridTab)
			{
				init = false;
				init(gridTab);
			}
		}
		else
			init(gridTab);
	}
	
	/**
	 * 
	 * @param gridTab
	 */
	public void refresh(GridTab gridTab) {
		gridTab.query(false, 0, 0);
		gridTab.getTableModel().fireTableDataChanged();
		
		if (this.gridTab != gridTab)
		{
			init = false;
			init(gridTab);
		}
	}

	/**
	 * Set paging size
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
		
		ListHead header = new ListHead();
		header.setSizable(true);
		
		ListHeader selectionHeader = new ListHeader();
		selectionHeader.setWidth("40px");
		selectionHeader.setAlign("center");
		header.appendChild(selectionHeader);		
		
		Map<Integer, String> colnames = new HashMap<Integer, String>();
		int index = 0;
		for (int i = 0; i < numColumns; i++)
		{
			if (gridField[i].isDisplayed() && gridField[i].isDisplayedGrid())
			{
				colnames.put(index, gridField[i].getHeader());
				index++;
				ListHeader colHeader = new ListHeader();
				colHeader.setSort("auto");
				colHeader.setLabel(gridField[i].getHeader());
				colHeader.setAttribute("ColumnIndex", getColumnIndex(gridField[i].getColumnName()));
				if (columnWidthMap != null && columnWidthMap.get(gridField[i].getAD_Field_ID()) != null) {
					colHeader.setWidth(columnWidthMap.get(gridField[i].getAD_Field_ID()));
				} else {
					int l = DisplayType.isNumeric(gridField[i].getDisplayType()) 
						? 100 : gridField[i].getDisplayLength() * 9;
					if (gridField[i].getHeader().length() * 9 > l)
						l = gridField[i].getHeader().length() * 9;
					if (l > MAX_COLUMN_WIDTH) 
						l = MAX_COLUMN_WIDTH;
					else if ( l < MIN_COLUMN_WIDTH)
						l = MIN_COLUMN_WIDTH;
					colHeader.setWidth(Integer.toString(l) + "px");
				}
				header.appendChild(colHeader);
			}
		}		
		listbox.appendChild(header);
	}
	
	private int getColumnIndex(String columnName) {
		for(int i = 0; i < gridTab.getTableModel().getColumnCount(); i++) {
			if (gridTab.getTableModel().getColumnName(i).equals(columnName)) {
				return i;
			}
		}
		return -1;
	}

	private void render()
	{
		listbox.setStyle("min-height: 200px");
        ZKUpdateUtil.setVflex(listbox, "1");
        ZKUpdateUtil.setHflex(listbox, "1");
		listbox.setSizedByContent(true);
		
		updateModel();				
		
		Box listboxbox = new Box();
		listboxbox.appendChild(listbox);
        ZKUpdateUtil.setVflex(listboxbox, "1");
        ZKUpdateUtil.setHflex(listboxbox, "1");
		this.appendChild(listboxbox);
		
		selectedLabel = new Label(Msg.getMsg(Env.getCtx(), "Selected") + " : 0");
		labelBox.appendChild(selectedLabel);
	}
	
	private void updateModel() {
		listModel = new SimpleGridTableListModel((GridTable)tableModel, windowNo);	
		listModel.setMultiple(listbox.isMultiple());
		renderer = new GridTabSelectionListViewRenderer(gridTab, windowNo);
		renderer.setListView(this);
				
		listbox.setItemRenderer(renderer);
		listbox.setModel(listModel);
	}
	
	/**
	 * deactive panel
	 */
	public void deactivate() {
	}

	/**
	 * 
	 * @return Listbox
	 */
	public Listbox getListbox() {
		return listbox;
	}
	
	/**
	 * 
	 * @param windowNo
	 */
	public void setWindowNo(int windowNo) {
		this.windowNo = windowNo;
	}
	
	public GridField[] getFields() {
		return gridField;
	}

	/* (non-Javadoc)
	 * @see org.zkoss.zk.ui.AbstractComponent#addEventListener(int, java.lang.String, org.zkoss.zk.ui.event.EventListener)
	 */
	@Override
	public boolean addEventListener(int priority, String evtnm,
			EventListener<? extends Event> listener) {
		if (Events.ON_SELECT.equals(evtnm)) {
			return listbox.addEventListener(priority, evtnm, listener);
		} else {
			return super.addEventListener(priority, evtnm, listener);
		}
	}

	public void setSelectedIndices(int[] selectedIndices) {
		ListModel<Object> model = listbox.getModel();
		if (model != null && model instanceof Selectable) {
			Collection<Object> selection = new HashSet<Object>();
			@SuppressWarnings("unchecked")
			Selectable<Object> selectable = (Selectable<Object>) model;
			for (int selected : selectedIndices) {			
				selection.add(model.getElementAt(selected));
			}
			
			selectable.setSelection(selection);
		} else {
			listbox.setSelectedIndices(selectedIndices);
		}
		selectedLabel.setValue(Msg.getMsg(Env.getCtx(), "Selected") + " : " + selectedIndices.length);
	}

	public void clearSelection() {
		ListModel<Object> model = listbox.getModel();
		if (model != null && model instanceof Selectable) {
			Selectable<?> selectable = (Selectable<?>) model;
			selectable.clearSelection();
		} else {
			listbox.clearSelection();
		}
		selectedLabel.setValue(Msg.getMsg(Env.getCtx(), "Selected") + " : 0");
	}

	public void setSelectedIndex(int selected) {
		ListModel<Object> model = listbox.getModel();
		if (model != null && model instanceof Selectable) {
			@SuppressWarnings("unchecked")
			Selectable<Object> selectable = (Selectable<Object>) model;
			Collection<Object> selection = new HashSet<Object>();
			selection.add(model.getElementAt(selected));
			selectable.setSelection(selection);
			selectedLabel.setValue(Msg.getMsg(Env.getCtx(), "Selected") + " : " + selection.size());
		} else {
			listbox.setSelectedIndex(selected);
			selectedLabel.setValue(Msg.getMsg(Env.getCtx(), "Selected") + " : " + listbox.getSelectedCount());
		}		
	}	
}
