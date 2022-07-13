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
 * - hengsin                                                           *
 * - carlos                         								   *
 * - richard morales                                                   *
 **********************************************************************/
package org.compiere.minigrid;

import java.sql.ResultSet;

import org.compiere.model.PO;

/**
 * 
 * @author hengsin
 *
 */
public interface IMiniTable 
{
	/**
	 * 
	 * @param row
	 * @param column
	 * @return true if column is editable
	 */
	public boolean isCellEditable(int row, int column);
	
	/**
	 * 
	 * @param row
	 * @param column
	 * @return value at row and column
	 */
	public Object getValueAt(int row, int column);
	
	/**
	 * set value at row and column
	 * @param value
	 * @param row
	 * @param column
	 */
	public void setValueAt(Object value, int row, int column);
	
	/**
	 * 
	 * @param viewColumnIndex
	 * @return corresponding index at underlying model
	 */
	public int convertColumnIndexToModel(int viewColumnIndex);
	
	/**
	 * change readonly attribute of a column
	 * @param index
	 * @param readOnly
	 */
	public void setColumnReadOnly (int index, boolean readOnly);
	
	/**
	 * Prepare Table and return SQL required to get resultset to populate table
	 * @param layout
	 * @param from
	 * @param where
	 * @param multiSelection
	 * @param tableName
	 * @return sql
	 */
	public String prepareTable(ColumnInfo[] layout, String from, String where, boolean multiSelection, String tableName);
	
	/**
	 * add column with header
	 * @param header
	 */
	public void addColumn (String header);
	
	/**
	 * set column class type
	 * @param index
	 * @param classType
	 * @param readOnly
	 * @param header
	 */
	public void setColumnClass (int index, Class<?> classType, boolean readOnly, String header);
	
	/**
	 * set column class type
	 * @param index
	 * @param classType
	 * @param readOnly
	 */
	public void setColumnClass (int index, Class<?> classType, boolean readOnly);
	
	/**
	 * populate table
	 * @param rs
	 */
	public void loadTable(ResultSet rs);
	
	/**
	 * populate table
	 * @param pos
	 */
	public void loadTable(PO[] pos);
	
	/**
	 * 
	 * @return row key
	 */
	public Integer getSelectedRowKey();
	
	/**
	 * 
	 * @return selected row index or -1 if no selected row
	 */
	public int getSelectedRow();
	
	/**
	 * ensure table has >= rowCount rows.
	 * i.e to grow a table by 1 row, call table.setRowCount(table.getRowCount()+1)
	 * @param rowCount
	 */
	public void setRowCount (int rowCount);
	
	/**
	 * get table layout
	 * @return array of {@link ColumnInfo}
	 */
	public ColumnInfo[] getLayoutInfo();

	/**
	 * 
	 * @return number of columns
	 */
	public int getColumnCount();
	
	/**
	 * 
	 * @return number of rows
	 */
	public int getRowCount();
	
	/**
	 * change multi selection attribute of table
	 * @param multiSelection
	 */
	public void setMultiSelection(boolean multiSelection);
	
	/**
	 * 
	 * @return true if multi selection is turn on
	 */
	public boolean isMultiSelection();
	
	/**
	 * 
	 * @param row
	 * @return color code
	 */
	public int getColorCode (int row);
	
	/**
	 * 
	 * @param dataCompare
	 */
	public void setColorCompare (Object dataCompare);
	
	/**
	 * redraw the whole table
	 */
	public void repaint();
	
	/**
	 * auto size column width
	 */
	public void autoSize();
	
	/**
	 * change show total attribute of table
	 * @param show
	 */
	public void setShowTotals(boolean show);

}
