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
import org.compiere.model.GridField;
import org.compiere.model.InfoColumnVO;
import org.compiere.model.MStyle;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.KeyNamePair;
import org.zkoss.zul.Listcell;

public class WInfoWindowListItemRenderer extends WListItemRenderer
{
	private InfoColumnVO[]	gridDisplayedInfoColumns = null;
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
			if(infoColumn.isReadOnly() == false 
					&& columnIndex > 0)
			{
				ListCell listCell = new ListCell();

				
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
		
			if (gridField.getAD_FieldStyle_ID() > 0)
			{
				MStyle style = MStyle.get(Env.getCtx(), gridField.getAD_FieldStyle_ID());
				//devCoffee #5960
				String styleStr = style.buildStyle(ThemeManager.getTheme(), new Evaluatee() {

					@Override
					public String get_ValueAsString(String variableName) {
						String value = null;

						int idx = 0;
						for (InfoColumnVO ic : gridDisplayedInfoColumns)
						{
							if (ic != null && ic.getColumnName().equals(variableName))
							{
								value = String.valueOf(table.getValueAt(rowIndex, idx));
								break;
							}

							idx++;
						}

						return value;
					}
				});
				if (styleStr != null && styleStr.startsWith(MStyle.SCLASS_PREFIX)) {
					String sclass = styleStr.substring(MStyle.SCLASS_PREFIX.length());
					listcell.setSclass(sclass);
				} else if (style != null && styleStr.startsWith(MStyle.ZCLASS_PREFIX)) {
					String zclass = styleStr.substring(MStyle.ZCLASS_PREFIX.length());
					listcell.setZclass(zclass);
				} else {
					ZkCssHelper.appendStyle(listcell, styleStr);
				}
			}
		}

		if(listcell == null)
			listcell = super.getCellComponent(table, field, rowIndex, columnIndex);

		return listcell;
	}

//
//	//devCoffee #5960 - Get CSS Style if pass through display logic.
//	private String getStatusStyle(ListCell listcell, PO po) {
//		if(po instanceof MInfoWindow) {
//			if(po.get_ValueAsInt("AD_FieldStyle_ID") != 0 && listcell != null) {
//				try {
//					MTable t = new MTable(Env.getCtx(), po.get_ValueAsInt("AD_Table_ID"), null);
//					PO recordPO = (PO) new Query(Env.getCtx(), t.getTableName(), t.getTableName() + "_ID =" + listcell.getValue(), null).first();
//
//					List<X_AD_StyleLine> lines = new Query(Env.getCtx(), X_AD_StyleLine.Table_Name, "AD_Style_ID = " + po.get_ValueAsInt("AD_FieldStyle_ID"), null).list();
//
//					StringBuilder styleBuilder = new StringBuilder();
//					for (X_AD_StyleLine line : lines)
//					{
//						String inlineStyle = line.getInlineStyle().trim();
//						String displayLogic = line.getDisplayLogic();
//						String theme = line.getTheme();
//						if (!Util.isEmpty(theme)) {
//							if (!ThemeManager.getTheme().equals(theme))
//								continue;
//						}
//						if (!Util.isEmpty(displayLogic))
//						{
//							if (!Evaluator.evaluateLogic(recordPO, displayLogic))
//								continue;
//						}
//						if (styleBuilder.length() > 0 && !(styleBuilder.charAt(styleBuilder.length()-1)==';'))
//							styleBuilder.append("; ");
//
//						styleBuilder.append(inlineStyle);
//					}
//
//					//listcell.setStyle(styleBuilder.toString());
//					return styleBuilder.toString();
//				} catch (Exception e) {
//					throw new AdempiereException(e.getMessage());
//				}
//			}
//		}
//
//		return "";
//	}




}
