/*******************************************************************************
 * Copyright (C) 2016 Trek Global Inc.										   *
 * Copyright (C) 2016 Low Heng Sin                                             *
 * This program is free software; you can redistribute it and/or modify it     *
 * under the terms version 2 of the GNU General Public License as published    *
 * by the Free Software Foundation. This program is distributed in the hope    *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied  *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.            *
 * See the GNU General Public License for more details.                        *
 * You should have received a copy of the GNU General Public License along     *
 * with this program; if not, write to the Free Software Foundation, Inc.,     *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                      *
 *******************************************************************************/
package org.adempiere.webui.editor.grid.selection;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.adempiere.webui.component.ListCell;
import org.adempiere.webui.component.ListItem;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.util.DisplayType;
import org.zkoss.zk.ui.Component;
import org.zkoss.zul.Listbox;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.ListitemRenderer;
import org.zkoss.zul.ListitemRendererExt;
import org.zkoss.zul.RendererCtrl;

/**
 * ListItem renderer for GridTabSelectionListView
 * @author hengsin
 *
 */
public class GridTabSelectionListViewRenderer implements ListitemRenderer<GridTableRow>, ListitemRendererExt, RendererCtrl {

	private static final int MAX_TEXT_LENGTH = 60;
	private GridTab gridTab;
	@SuppressWarnings("unused")
	private int windowNo;
	private Map<GridField, WEditor> editors = new HashMap<GridField, WEditor>();
	private GridTabSelectionListView listView;

	/**
	 * 
	 * @param gridTab
	 * @param windowNo
	 */
	public GridTabSelectionListViewRenderer(GridTab gridTab, int windowNo) {
		this.gridTab = gridTab;
		this.windowNo = windowNo;
	}
	
	/**
	 * @param listitem
	 * @param data
	 * @see ListitemRenderer#render(Listitem, Object)
	 */
	@Override
	public void render(Listitem listitem, GridTableRow data, int index) throws Exception {
		//don't render if not visible
		if (listView != null && !listView.isVisible()) {
			return;
		}
		
		GridField[] listViewFields = listView.getFields();
		int columnCount = listViewFields.length;
		
		GridField[] gridTabFields = gridTab.getFields();
		boolean isGridViewCustomized = gridTabFields.length != listViewFields.length;
		if (!isGridViewCustomized) {
			for(int i = 0; i < gridTabFields.length; i++) {
				if (listViewFields[i].getAD_Field_ID() != gridTabFields[i].getAD_Field_ID()) {
					isGridViewCustomized = true;
					break;
				}
			}
		}

		for(Component c = listitem.getParent(); c != null; c = c.getParent()) {
			if (!c.isVisible())
				return;
		}
		Object[] values = null;
		if (!isGridViewCustomized) {
			values = data.getValues();
		} else {
			List<Object> dataList = new ArrayList<Object>();
			for(GridField gridField : listViewFields) {
				for(int i = 0; i < gridTabFields.length; i++) {
					if (gridField.getAD_Field_ID() == gridTabFields[i].getAD_Field_ID()) {
						dataList.add(data.getValues()[i]);
						break;
					}
				}
			}
			values = dataList.toArray(new Object[0]);
		}
		
		Listcell selectionCell = new Listcell();
		listitem.appendChild(selectionCell);
		
		for (int i = 0; i < columnCount; i++) {
			if (!listViewFields[i].isDisplayedGrid()) {
				continue;
			}
			if (!editors.containsKey(listViewFields[i])) {
				WEditor editor = null;
				int displayType = listViewFields[i].getDisplayType();
				if (displayType != DisplayType.YesNo && displayType != DisplayType.Image && displayType != DisplayType.Chart &&
						displayType != DisplayType.Button && displayType != DisplayType.DashboardContent) {
					editor = WebEditorFactory.getEditor(listViewFields[i], true);
					editor.setReadWrite(false);
				}
				editors.put(listViewFields[i], editor);
			}
						
			Listcell cell = renderCell(listViewFields[i], values[i]);
			cell.setParent(listitem);
		}
	}

	private Listcell renderCell(GridField gridField, Object value) {
		Listcell cell;
		if (gridField.getDisplayType() == DisplayType.YesNo) {
			cell = new Listcell("", null);			
			cell.setStyle("text-align:center");
			WEditor editor = WebEditorFactory.getEditor(gridField, true);
			editor.setReadWrite(false);
			editor.setValue(value);
			cell.appendChild(editor.getComponent());
		} else if (gridField.getDisplayType() == DisplayType.Image || gridField.getDisplayType() == DisplayType.Chart) {
			WEditor editor = WebEditorFactory.getEditor(gridField, true);
			editor.setReadWrite(false);
			editor.setValue(value);
			cell = new Listcell("", null);
			cell.appendChild(editor.getComponent());
		} else {
			String text = getDisplayText(gridField, value);
			String display = text;
			if (text != null && text.length() > MAX_TEXT_LENGTH)
				display = text.substring(0, MAX_TEXT_LENGTH - 3) + "...";
			cell = new Listcell(display, null);
			if (text != null && text.length() > MAX_TEXT_LENGTH)
				cell.setTooltiptext(text);
			if (DisplayType.isNumeric(gridField.getDisplayType())) {
				cell.setStyle("text-align:right");
			} else if (gridField.getDisplayType() == DisplayType.Image) {
				cell.setStyle("text-align:center");
			}
		}
		return cell;
	}

	/**
	 * @see ListitemRendererExt#getControls()
	 */
	public int getControls() {
		return DETACH_ON_RENDER;
	}

	/**
	 * @param item
	 * @see ListitemRendererExt#newListcell(Listitem)
	 */
	public Listcell newListcell(Listitem item) {
		ListCell listCell = new ListCell();
		listCell.applyProperties();
		listCell.setParent(item);
		return listCell;
	}

	/**
	 * @param listbox
	 * @see ListitemRendererExt#newListitem(Listbox)
	 */
	public Listitem newListitem(Listbox listbox) {
		ListItem item = new ListItem();
		item.applyProperties();
		return item;
	}

	private String getDisplayText(GridField gridField, Object value)
	{
		if (value == null)
			return "";
		
		if (gridField.isEncryptedField())
		{
			return "********";
		}
    	else if (DisplayType.Button == gridField.getDisplayType())
    	{
    		return "";
    	}
    	else 
    	{
    		WEditor editor = editors.get(gridField);
    		if (editor != null)
    			return editor.getDisplayTextForGridView(value);
    		else
        		return value.toString();
    	}    	
	}
	
	/**
	 * Is renderer initialize
	 * @return boolean
	 */
	public boolean isInitialize() {
		return !editors.isEmpty();
	}

	/**
	 * 
	 * @return active editor list
	 */
	public List<WEditor> getEditors() {
		List<WEditor> editorList = new ArrayList<WEditor>();
		if (!editors.isEmpty())
			editorList.addAll(editors.values());
		
		return editorList;
	}
	
	/**
	 * @see RendererCtrl#doCatch(Throwable)
	 */
	public void doCatch(Throwable ex) throws Throwable {
	}

	/**
	 * @see RendererCtrl#doFinally()
	 */
	public void doFinally() {
	}

	/**
	 * @see RendererCtrl#doTry()
	 */
	public void doTry() {
	}

	public void setListView (GridTabSelectionListView listView) {
		this.listView = listView;
	}

	public GridTabSelectionListView getListView() {
		return listView;
	}
}
