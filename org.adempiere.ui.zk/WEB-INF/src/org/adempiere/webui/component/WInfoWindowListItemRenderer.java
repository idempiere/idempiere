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
import org.adempiere.webui.theme.ThemeManager;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.minigrid.UUIDColumn;
import org.compiere.model.GridField;
import org.compiere.model.InfoColumnVO;
import org.compiere.model.MColumn;
import org.compiere.model.MStyle;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.ValueNamePair;
import org.zkoss.zhtml.Text;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zul.Listcell;
import org.zkoss.zul.Span;

/**
 * List item renderer for Info Window list box. 
 */
public class WInfoWindowListItemRenderer extends WListItemRenderer
{
	private InfoColumnVO[]	gridDisplayedInfoColumns = null;
	private ColumnInfo[]	gridDisplayedColumnInfos = null;
	private InfoWindow infoWindow = null;

	/**
	 * @param infoWindow
	 */
	public WInfoWindowListItemRenderer(InfoWindow infoWindow)
	{
		this.infoWindow = infoWindow;
	}

	/**
	 * @param infoWindow
	 * @param columnNames
	 */
	public WInfoWindowListItemRenderer(InfoWindow infoWindow, List<? extends String> columnNames)
	{
		super(columnNames);
		this.infoWindow = infoWindow;
	}
	
	/**
	 * Set columns to display 
	 * @param infoColumns
	 * @param columnInfos
	 */
	public void setGridDisplaydInfoColumns(InfoColumnVO[] infoColumns, ColumnInfo[] columnInfos)
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
		
		InfoColumnVO infoColumn = gridDisplayedInfoColumns[columnIndex];
		if (infoColumn != null)
		{		
			final GridField gridField = gridDisplayedColumnInfos[columnIndex].getGridField();
			final WEditor editor = WebEditorFactory.getEditor(gridField, false);

			if(model.isSelected(obj)) // First index may be null
			{
				if(infoColumn.isReadOnly() == false && columnIndex > 0)
				{
					ListCell listCell = new ListCell();
					
					// Set editor value				
					Object value = table.getValueAt(rowIndex, columnIndex);
					
					if(value instanceof IDColumn)
					{
						IDColumn idc = (IDColumn)value;
						value = idc.getRecord_ID();
					}
					else if(value instanceof UUIDColumn)
					{
						UUIDColumn idc = (UUIDColumn)value;
						value = idc.getRecord_UU();
					}
					else if(value instanceof KeyNamePair)
					{
						KeyNamePair knp = (KeyNamePair)value;
						value = knp.getKey();
					}
					else if(value instanceof ValueNamePair)
					{
						ValueNamePair vnp = (ValueNamePair)value;
						value = vnp.getValue();
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
		
			if (gridField.getAD_FieldStyle_ID() > 0)
			{
				MStyle style = MStyle.get(Env.getCtx(), gridField.getAD_FieldStyle_ID());
				DefaultEvaluatee evaluatee = new DefaultEvaluatee(new TableDataProvider(table, rowIndex));
				String styleStr = style.buildStyle(ThemeManager.getTheme(), evaluatee);
				if(style.isWrapWithSpan()) {
					Span span = new Span();
					span.appendChild(new Text(listcell.getValue()));
					listcell.setLabel(null);
					listcell.appendChild(span);
					setStyle(span, styleStr);
				}
				else {
					setStyle(listcell, styleStr);
				}
			}
		}

		if(listcell == null)
			listcell = super.getCellComponent(table, field, rowIndex, columnIndex);

		return listcell;
	}
	
	private void setStyle(HtmlBasedComponent component, String style) {
		if (style != null && style.startsWith(MStyle.SCLASS_PREFIX)) {
			String sclass = style.substring(MStyle.SCLASS_PREFIX.length());
			component.setSclass(sclass);
		} else if (style != null && style.startsWith(MStyle.ZCLASS_PREFIX)) {
			String zclass = style.substring(MStyle.ZCLASS_PREFIX.length());
			component.setZclass(zclass);
		} else {
			ZkCssHelper.appendStyle(component, style);
		}
	}
	
	/**
	 * Data provider implementation for WListbox
	 */
	private class TableDataProvider implements DefaultEvaluatee.DataProvider {

		private WListbox table;
		private int rowIndex;

		private TableDataProvider(WListbox table, int rowIndex) {
			this.table = table;
			this.rowIndex = rowIndex;
		}
		
		@Override
		public Object getValue(String columnName) {
			String value = null;

			int idx = 0;
			for (InfoColumnVO ic : gridDisplayedInfoColumns)
			{
				if (ic != null && ic.getColumnName().equals(columnName))
				{
					value = String.valueOf(table.getValueAt(rowIndex, idx));
					break;
				}

				idx++;
			}

			return value;
		}

		@Override
		public Object getProperty(String propertyName) {
			return null;
		}

		@Override
		public MColumn getColumn(String columnName) {
			return null;
		}

		@Override
		public String getTrxName() {
			return null;
		}		
	}
}
