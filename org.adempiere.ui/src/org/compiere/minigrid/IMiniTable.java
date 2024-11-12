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

import java.io.Serializable;
import java.sql.ResultSet;

import org.compiere.model.PO;

/**
 * UI Table interface
 * @author hengsin
 *
 */
public interface IMiniTable 
{
	/**
	 * Is column editable 
	 * @param row
	 * @param column
	 * @return true if column is editable
	 */
	public boolean isCellEditable(int row, int column);
	
	/**
	 * Get value at row and column
	 * @param row
	 * @param column
	 * @return value at row and column
	 */
	public Object getValueAt(int row, int column);
	
	/**
	 * Set value at row and column
	 * @param value
	 * @param row
	 * @param column
	 */
	public void setValueAt(Object value, int row, int column);
	
	/**
	 * Convert view column index to model index
	 * @param viewColumnIndex
	 * @return corresponding index at underlying model
	 */
	public int convertColumnIndexToModel(int viewColumnIndex);
	
	/**
	 * Change readonly attribute of a column
	 * @param index
	 * @param readOnly
	 */
	public void setColumnReadOnly (int index, boolean readOnly);
	
	/**
	 * Prepare Table and return SQL to get resultset to populate table
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
	 * Set column class type
	 * @param index
	 * @param classType
	 * @param readOnly
	 * @param header
	 */
	public void setColumnClass (int index, Class<?> classType, boolean readOnly, String header);
	
	/**
	 * Set column class type
	 * @param index
	 * @param classType
	 * @param readOnly
	 */
	public void setColumnClass (int index, Class<?> classType, boolean readOnly);
	
	/**
	 * Populate table from result set
	 * @param rs
	 */
	public void loadTable(ResultSet rs);
	
	/**
	 * Populate table from POs
	 * @param pos
	 */
	public void loadTable(PO[] pos);
	
	/**
	 * Get row key of selected row
	 * @return row key
	 */
	public <T extends Serializable> T getSelectedRowKey();
	
	/**
	 * Get selected row index
	 * @return selected row index or -1 if no selected row
	 */
	public int getSelectedRow();
	
	/**
	 * Ensure table has >= rowCount rows.<br/>
	 * i.e to grow a table by 1 row, call table.setRowCount(table.getRowCount()+1)
	 * @param rowCount
	 */
	public void setRowCount (int rowCount);
	
	/**
	 * Get table column layout
	 * @return array of {@link ColumnInfo}
	 */
	public ColumnInfo[] getLayoutInfo();

	/**
	 * Get number of columns
	 * @return number of columns
	 */
	public int getColumnCount();
	
	/**
	 * Get number of rows
	 * @return number of rows
	 */
	public int getRowCount();
	
	/**
	 * Change multiple selection attribute of table
	 * @param multiSelection
	 */
	public void setMultiSelection(boolean multiSelection);
	
	/**
	 * Is multi selection turn on
	 * @return true if multi selection is turn on
	 */
	public boolean isMultiSelection();
	
	/**
	 * Get color code of row
	 * @param row
	 * @return color code
	 */
	public int getColorCode (int row);
	
	/**
	 * Set comparison object for determination of row color code 
	 * @param dataCompare
	 */
	public void setColorCompare (Object dataCompare);
	
	/**
	 * Redraw the whole table
	 */
	public void repaint();
	
	/**
	 * Auto size column width
	 */
	public void autoSize();
	
	/**
	 * Change show total attribute of table
	 * @param show
	 */
	public void setShowTotals(boolean show);

}
