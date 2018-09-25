/**********************************************************************
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
**********************************************************************/
package org.adempiere.webui.component;

import java.util.List;

import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.info.InfoWindow;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.GridField;
import org.compiere.model.MInfoColumn;
import org.compiere.util.KeyNamePair;
import org.zkoss.zul.Listcell;

public class WInfoWindowListItemRenderer extends WListItemRenderer
{
	private MInfoColumn[]	gridDisplayedInfoColumns = null;
	private ColumnInfo[]	gridDisplayedColumnInfos = null;
	private InfoWindow infoWindow = null;

	public WInfoWindowListItemRenderer(InfoWindow infoWindow)
	{
		this.infoWindow = infoWindow;
	}

	public WInfoWindowListItemRenderer(InfoWindow infoWindow, List<? extends String> columnNames)
	{
		super(columnNames);
		this.infoWindow = infoWindow;
	}
	
	public void setGridDisplaydInfoColumns(MInfoColumn[] infoColumns, ColumnInfo[] columnInfos)
	{
		this.gridDisplayedInfoColumns = infoColumns;
		this.gridDisplayedColumnInfos = columnInfos;
	}		
		
	@Override
	protected Listcell getCellComponent(WListbox table, Object field,
			final int rowIndex, final int columnIndex)
	{
		if(gridDisplayedInfoColumns == null || gridDisplayedColumnInfos == null)
		{
			return super.getCellComponent(table, field, rowIndex, columnIndex);
		}
				
		Listcell listcell = null;
		ListModelTable model = table.getModel();
		Object obj = model.get(rowIndex);
		
		MInfoColumn infoColumn = gridDisplayedInfoColumns[columnIndex];
		
		if(model.isSelected(obj) && infoColumn != null) // First index may be null
		{
			if(infoColumn.isReadOnly() == false 
					&& columnIndex > 0)
			{
				ListCell listCell = new ListCell();

				final GridField gridField = gridDisplayedColumnInfos[columnIndex].getGridField();
				final WEditor editor = WebEditorFactory.getEditor(gridField, false);
				
				// Set editor value
				
				Object value = table.getValueAt(rowIndex, columnIndex);
				
				if(value instanceof IDColumn)
				{
					IDColumn idc = (IDColumn)value;
					value = idc.getRecord_ID();
				}
				else if(value instanceof KeyNamePair)
				{
					KeyNamePair knp = (KeyNamePair)value;
					value = knp.getKey();
				}
				
				editor.setValue(value);
				
				editor.addValueChangeListener(new ValueChangeListener()
				{					
					@Override
					public void valueChange(ValueChangeEvent evt)
					{
						infoWindow.onCellEditCallback(evt, rowIndex, columnIndex, editor, gridField);
					}
				});
				
				listCell.appendChild(editor.getComponent());
				listcell = listCell;
			}
		}
		
		if(listcell == null)
			listcell = super.getCellComponent(table, field, rowIndex, columnIndex);
		
		return listcell;
	}

}
