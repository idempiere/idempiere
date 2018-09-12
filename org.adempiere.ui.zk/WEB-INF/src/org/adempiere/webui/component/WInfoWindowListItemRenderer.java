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
import org.compiere.minigrid.IDColumn;
import org.compiere.model.GridField;
import org.compiere.model.MInfoColumn;
import org.compiere.util.KeyNamePair;
import org.zkoss.zul.Listcell;

public class WInfoWindowListItemRenderer extends WListItemRenderer
{
	private MInfoColumn[]	infoColumns;
	private GridField[]	gridFields;
	private int	gridFieldsOffset = -1; // There are added columns in front of the first real gridField, instead of a fixed +1 we use an offset
	private InfoWindow infoWindow;

	public WInfoWindowListItemRenderer(InfoWindow infoWindow, MInfoColumn[] infoColumns, List<GridField> gridFields)
	{
		this.infoColumns = infoColumns;
		this.gridFields = gridFields.toArray(new GridField[infoColumns.length]);
		this.infoWindow = infoWindow;
	}

	public WInfoWindowListItemRenderer(InfoWindow infoWindow, MInfoColumn[] infoColumns, List<GridField> gridFields, List<? extends String> columnNames)
	{
		super(columnNames);
		this.infoColumns = infoColumns;
		this.gridFields = gridFields.toArray(new GridField[infoColumns.length]);
		this.infoWindow = infoWindow;
	}
	
	private void calculateFieldOffest()
	{
		int colCount = getTableColumns().size();
		
		if(colCount > infoColumns.length) // Added columns: selecetion
			gridFieldsOffset = colCount - infoColumns.length;		
	}
	
	@Override
	protected Listcell getCellComponent(WListbox table, Object field,
			final int rowIndex, final int columnIndex)
	{
		if(gridFieldsOffset < 0) // Just do it once, this assumes this rendered is not shared between grids
			calculateFieldOffest();
		
		Listcell listcell = null;
		ListModelTable model = table.getModel();
		Object obj = model.get(rowIndex);
		
		int effectiveFieldIndex = columnIndex - gridFieldsOffset;
		 				
		if(effectiveFieldIndex >= 0
				&& model.isSelected(obj) )
		{
			MInfoColumn infoColumn = infoColumns[effectiveFieldIndex];
			
			if(infoColumn.isReadOnly() == false 
					&& columnIndex > 0)
			{
				ListCell listCell = new ListCell();

				final GridField gridField = gridFields[effectiveFieldIndex];
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
