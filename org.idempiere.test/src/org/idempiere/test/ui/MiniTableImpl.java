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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.ui;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.minigrid.IMiniTable;
import org.compiere.model.PO;
import org.compiere.util.KeyNamePair;

/**
 * 
 * @author hengsin
 *
 */
public class MiniTableImpl implements IMiniTable {

	/**	Array of table details. */
	private List<TableColumn> m_tableColumns = new ArrayList<TableColumn>();
	
	private List<Map<String, Object>> model = new ArrayList<Map<String,Object>>();

	private ColumnInfo[] m_layout;

	private int m_keyColumnIndex;

	private int m_selectedRow = -1;
	
	public MiniTableImpl() {
	}

	@Override
	public boolean isCellEditable(int row, int column) {
		return false;
	}

	@Override
	public Object getValueAt(int row, int column) {
		if (column < m_tableColumns.size()) {
			String columnName = m_tableColumns.get(column).getHeaderValue();
			if (row < model.size()) {
				return model.get(row).get(columnName);
			}
		}
		return null;
	}

	@Override
	public void setValueAt(Object value, int row, int column) {
		if (column < m_tableColumns.size()) {
			String columnName = m_tableColumns.get(column).getHeaderValue();
			if (row < model.size()) {
				model.get(row).put(columnName, value);
			}
		}
	}

	@Override
	public int convertColumnIndexToModel(int viewColumnIndex) {
		return viewColumnIndex;
	}

	@Override
	public void setColumnReadOnly(int index, boolean readOnly) {
	}

	@Override
	public String prepareTable(ColumnInfo[] layout, String from, String where, boolean multiSelection,
			String tableName) {
		m_layout = layout;
		m_tableColumns.clear();
		model.clear();
		for (int columnIndex = 0; columnIndex < layout.length; columnIndex++) {
			addColumn(layout[columnIndex].getColHeader(), layout[columnIndex].getColDescription(), layout[columnIndex].getAD_Reference_ID(), layout[columnIndex].getColClass());
			if (layout[columnIndex].getColClass() == IDColumn.class)
            {
                m_keyColumnIndex = columnIndex;
            }
		}
		return null;
	}

	@Override
	public void addColumn(String header) {
		addColumn(header, null, 0, null);
	}

	@Override
	public void setColumnClass(int index, Class<?> classType, boolean readOnly, String header) {
		if (index < m_tableColumns.size()) {
			m_tableColumns.get(index).setColumnClass(classType);
		}
	}

	@Override
	public void setColumnClass(int index, Class<?> classType, boolean readOnly) {
		if (index < m_tableColumns.size()) {
			m_tableColumns.get(index).setColumnClass(classType);
		}
	}

	@Override
	public void loadTable(ResultSet rs) {
		model.clear();
		try
		{
			while (rs.next())
			{
				Map<String, Object> row = new HashMap<String, Object>();
				int rsColOffset = 1;
				for (int col = 0; col < m_layout.length; col++)
				{
					//reset the data value
					Object data = null;
					Class<?> columnClass = m_layout[col].getColClass();
					int rsColIndex = col + rsColOffset;

					if (columnClass == IDColumn.class)
					{
						data = new IDColumn(rs.getInt(rsColIndex));
					}
					else if (columnClass == Boolean.class)
					{
						data = Boolean.valueOf(rs.getString(rsColIndex).equals("Y"));
					}
					else if (columnClass == Timestamp.class)
					{
						data = rs.getTimestamp(rsColIndex);
					}
					else if (columnClass == BigDecimal.class)
					{
						data = rs.getBigDecimal(rsColIndex);
					}
					else if (columnClass == Double.class)
					{
						data = Double.valueOf(rs.getDouble(rsColIndex));
					}
					else if (columnClass == Integer.class)
					{
						data = Integer.valueOf(rs.getInt(rsColIndex));
					}
					else if (columnClass == KeyNamePair.class)
					{
						String display = rs.getString(rsColIndex);
						int key = rs.getInt(rsColIndex + 1);
						data = new KeyNamePair(key, display);
						rsColOffset++;
					}
					else
					{
						String s = rs.getString(rsColIndex);
						if (s != null)
						{
							data = s.trim();	//	problems with NCHAR
						}
						else
						{
							data=null;
						}
					}
					//  store in underlying model
					row.put(m_tableColumns.get(col).headerValue, data);
				}
				model.add(row);
			}
		}
		catch (SQLException exception)
		{
			throw new RuntimeException(exception);
		}

	}

	@Override
	public void loadTable(PO[] pos) {
		model.clear();
		for (int poIndex = 0; poIndex < pos.length; poIndex++)
		{
			PO myPO = pos[poIndex];
			Map<String, Object> row = new HashMap<String, Object>();

			for (int col = 0; col < m_layout.length; col++)
			{
				String columnName = m_layout[col].getColSQL();
				Object data = myPO.get_Value(columnName);
				if (data != null)
				{
					Class<?> columnClass = m_layout[col].getColClass();

					if (columnClass == IDColumn.class)
					{
						data = new IDColumn(((Integer)data).intValue());
					}
					else if (columnClass == Double.class)
					{
						data = Double.valueOf(((BigDecimal)data).doubleValue());
					}
				}
				//  store
				row.put(m_tableColumns.get(col).headerValue, data);
			}
			model.add(row);
		}
	}

	@Override
	public Integer getSelectedRowKey() {
		int row = getSelectedRow();

		// make common function
		return getRowKeyAt (row);
	}

	/**
	 * get key of record at index
	 * @param index
	 * @return
	 */
	public Integer getRowKeyAt (int index){
		if (index < 0 || m_keyColumnIndex < 0 || index >= model.size())
			return null;
		
		
		Object data = model.get(index).get(m_tableColumns.get(m_keyColumnIndex).headerValue);

		if (data instanceof IDColumn)
		{
			data = ((IDColumn)data).getRecord_ID();
		}
		if (data instanceof Integer)
		{
			return (Integer)data;
		}
		return null;
	}
	
	@Override
	public int getSelectedRow() {
		return m_selectedRow;
	}
	
	public void setSelectedRow(int selected) {
		if (selected < model.size()) 
			m_selectedRow = selected;
	}

	@Override
	public void setRowCount(int rowCount) {
		while (model.size() < rowCount) {
			model.add(new HashMap<String, Object>());
		}
	}

	@Override
	public ColumnInfo[] getLayoutInfo() {
		return m_layout;
	}

	@Override
	public int getColumnCount() {
		return m_tableColumns.size();
	}

	@Override
	public int getRowCount() {
		return model.size();
	}

	@Override
	public void setMultiSelection(boolean multiSelection) {
	}

	@Override
	public boolean isMultiSelection() {
		return false;
	}

	@Override
	public int getColorCode(int row) {
		return 0;
	}

	@Override
	public void setColorCompare(Object dataCompare) {
	}

	@Override
	public void repaint() {
	}

	@Override
	public void autoSize() {
	}

	@Override
	public void setShowTotals(boolean show) {
	}

	/**
	 * Add Table Column and specify the column header.
	 *
	 * @param header	name of column header
	 * @param description
	 * @param colClass 
	 */
	public void addColumn (String header, String description, int AD_Reference_ID, Class<?> colClass)
	{
		TableColumn column = new TableColumn();
		column.setHeaderValue(header);
		column.setTooltipText(description);
		column.setAD_Reference_ID(AD_Reference_ID);
		column.setColumnClass(colClass);
		m_tableColumns.add(column);
	}   //  addColumn
}
