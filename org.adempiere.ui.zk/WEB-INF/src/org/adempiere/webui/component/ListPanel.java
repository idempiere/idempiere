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
package org.adempiere.webui.component;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.table.AbstractTableModel;

import org.adempiere.model.MTabCustomization;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.editor.WEditor;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.MSysConfig;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.South;
import org.zkoss.zul.Paging;
import org.zkoss.zul.event.ZulEvents;

/**
 * Grid view implemented using the Listbox component
 * @author Low Heng Sin
 *
 */
public class ListPanel extends Borderlayout implements EventListener
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

	private GridTableListModel listModel;

	private Paging paging;

	private GridTabListItemRenderer renderer;

	private South south;
	
	private Map<Integer, String> columnWidthMap;
	
	public ListPanel()
	{
		this(0);
	}
	
	/**
	 * @param windowNo
	 */
	public ListPanel(int windowNo)
	{
		this.windowNo = windowNo;
		listbox = new Listbox();
		south = new South();
		this.appendChild(south);
		
		//default paging size
		pageSize = MSysConfig.getIntValue(MSysConfig.ZK_PAGING_SIZE, 100);
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
		
		updateListIndex(true);
		
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
			else
			{
				if (renderer != null)
					renderer.stopEditing(false);
				
				int oldSelected = listbox.getSelectedIndex();
				updateListIndex(false);
				if (listbox.getSelectedIndex() == oldSelected && oldSelected >= 0)
					listModel.updateComponent(oldSelected);
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
		if (this.gridTab != gridTab)
		{
			init = false;
			init(gridTab);
		}
		else
		{
			renderer.stopEditing(false);
			listbox.setModel(listModel);
			updateListIndex(true);
		}				
	}

	/**
	 * Update listbox selection to sync with grid current row pointer changes
	 */
	public void updateListIndex() {
		updateListIndex(false);
	}
	
	/**
	 * Update listbox selection to sync with grid current row pointer changes
	 * @param updateSelectionOnly if true, doesn't attempt to refresh current row from model
	 */
	public void updateListIndex(boolean updateSelectionOnly) {
		int rowIndex  = gridTab.isOpen() ? gridTab.getCurrentRow() : -1;
		if (pageSize > 0) {			
			if (paging.getTotalSize() != gridTab.getRowCount())
				paging.setTotalSize(gridTab.getRowCount());
			int pgIndex = rowIndex % pageSize;
			int pgNo = (rowIndex - pgIndex) / pageSize;
			
			boolean pgChange = false;
			if (listModel.getPage() != pgNo) {
				listModel.setPage(pgNo);
				pgChange = true;
			}
			if (paging.getActivePage() != pgNo) {
				paging.setActivePage(pgNo);
			}			
			if (listbox.getSelectedIndex() != pgIndex) {
				if (!updateSelectionOnly) {					
					renderer.stopEditing(false);
					if (!pgChange) {					
						listModel.updateComponent(listbox.getSelectedIndex());
					}
					listModel.updateComponent(pgIndex);
				}
				listbox.setSelectedIndex(pgIndex);				
			}
		} else {
			if (listbox.getSelectedIndex() != rowIndex) {
				if (!updateSelectionOnly) {
					renderer.stopEditing(false);
					listModel.updateComponent(listbox.getSelectedIndex());
					listModel.updateComponent(rowIndex);
				}
				listbox.setSelectedIndex(rowIndex);				
			}
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
	
	/**
	 * 
	 * @param bool
	 */
	public void showGrid(boolean bool)
	{
		if (bool)
			this.setVisible(true);
		else
			this.setVisible(false);
	}
	
	private void setupColumns()
	{		
		if (init) return;
		
		ListHead header = new ListHead();
		header.setSizable(true);
		
		Map<Integer, String> colnames = new HashMap<Integer, String>();
		int index = 0;
		for (int i = 0; i < numColumns; i++)
		{
			if (gridField[i].isDisplayed())
			{
				colnames.put(index, gridField[i].getHeader());
				index++;
				ListHeader colHeader = new ListHeader();
				colHeader.setSort("auto");
				colHeader.setLabel(gridField[i].getHeader());
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
	
	private void render()
	{
		LayoutUtils.addSclass("adtab-grid-panel", this);
		
		listbox.setVflex(true);
		listbox.setFixedLayout(true);
		listbox.addEventListener(Events.ON_SELECT, this);
		
		LayoutUtils.addSclass("adtab-grid", listbox);
		
		updateModel();				
		
		Center center = new Center();
		center.appendChild(listbox);
		this.appendChild(center);
		
		if (pageSize > 0) 
		{
			paging = new Paging();
			paging.setPageSize(pageSize);
			paging.setTotalSize(tableModel.getRowCount());
			paging.setDetailed(true);
			south.appendChild(paging);
			paging.addEventListener(ZulEvents.ON_PAGING, this);
			renderer.setPaging(paging);
			this.getParent().invalidate();						
		}
		else
		{
			south.setVisible(false);
		}
				
	}
	
	private void updateModel() {
		listModel = new GridTableListModel((GridTable)tableModel, windowNo);		
		listModel.setPageSize(pageSize);
		if (renderer != null)
			renderer.stopEditing(false);
		renderer = new GridTabListItemRenderer(gridTab, windowNo);
				
		listbox.setItemRenderer(renderer);
		listbox.setModel(listModel);
	}
	
	/**
	 * deactive panel
	 */
	public void deactivate() {
		if (renderer != null)
			renderer.stopEditing(false);
	}

	public void onEvent(Event event) throws Exception
	{		
		if (event == null)
			return;		
		else if (event.getTarget() == listbox)
		{
			int index = listbox.getSelectedIndex();
			onSelectedRowChange(index);				
        }
		else if (event.getTarget() == paging)
		{
			int pgNo = paging.getActivePage();
			if (pgNo != listModel.getPage())
			{
				listbox.clearSelection();
				listModel.setPage(pgNo);
				listbox.setSelectedIndex(0);
				onSelectedRowChange(0);
			}
		}
	}

	private void onSelectedRowChange(int index) {
		if (updateModelIndex()) {			
			listModel.updateComponent(index);
			listbox.setSelectedIndex(index);
		} else if (!renderer.isInitialize()) {
			listModel.updateComponent(index);
			listbox.setSelectedIndex(index);
		}
	}

	private boolean updateModelIndex() {
		int rowIndex = listbox.getSelectedIndex();
		if (pageSize > 0) {
			int start = listModel.getPage() * listModel.getPageSize();
			rowIndex = start + rowIndex;
		} 
		
		if (gridTab.getCurrentRow() != rowIndex) {
			renderer.stopEditing(true);
			gridTab.navigate(rowIndex);
			return true;
		}
		return false;
	}
	
	/**
	 * 
	 * @return Listbox
	 */
	public Listbox getListbox() {
		return listbox;
	}
	
	/**
	 * validate the display properties of fields of current row
	 * @param col
	 */
	public void dynamicDisplay(int col) {
		if (!gridTab.isOpen())
        {
            return;
        }
        
        //  Selective
        if (col > 0)
        	return;

        boolean noData = gridTab.getRowCount() == 0;
        List<WEditor> list =  renderer.getEditors();
        for (WEditor comp : list)
        {
            GridField mField = comp.getGridField();
            if (mField != null && mField.getIncluded_Tab_ID() <= 0)
            {
                if (noData)
                {
                    comp.setReadWrite(false);
                }
                else
                {
                	comp.dynamicDisplay();
                    boolean rw = mField.isEditable(true);   //  r/w - check Context
                    comp.setReadWrite(rw);
                }
            }
        }   //  all components
	}

	/**
	 * 
	 * @param windowNo
	 */
	public void setWindowNo(int windowNo) {
		this.windowNo = windowNo;
	}
	
	public void reInit() {
		this.setupFields(gridTab);
		if (listbox.getListHead() != null) {
			listbox.removeChild(listbox.getListHead());
		}
		init = false;
		setupColumns();
		init = true;
		updateModel();
	}

	public GridField[] getFields() {
		return gridField;
	}
}
