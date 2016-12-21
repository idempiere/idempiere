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

import java.util.Comparator;

import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;

import org.adempiere.webui.util.SortComparator;
import org.compiere.model.GridField;
import org.compiere.model.GridTable;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zul.AbstractListModel;
import org.zkoss.zul.ListModel;
import org.zkoss.zul.ListitemComparator;
import org.zkoss.zul.event.ListDataEvent;
import org.zkoss.zul.ext.Sortable;

/**
 * 
 * @author Low Heng Sin
 *
 */
public class SimpleGridTableListModel extends AbstractListModel<GridTableRow> implements TableModelListener, Sortable<Object> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 698185856751242764L;
	private GridTable tableModel;
	@SuppressWarnings("unused")
	private GridField[] gridField;
	@SuppressWarnings("unused")
	private int windowNo;
	
	/**
	 * 
	 * @param tableModel
	 * @param windowNo
	 */
	public SimpleGridTableListModel(GridTable tableModel, int windowNo) {
		this.tableModel = tableModel;
		this.windowNo = windowNo;
		gridField = tableModel.getFields();
		tableModel.addTableModelListener(this);
	}

	/**
	 * @param rowIndex
	 * @see ListModel#getElementAt(int)
	 */
	public GridTableRow getElementAt(int rowIndex) {
		GridTableRow row = null;
		int columnCount = tableModel.getColumnCount();
		Object[] values = new Object[columnCount];
		if (rowIndex < tableModel.getRowCount()) {
			for (int i = 0; i < columnCount; i++) {
				values[i] = tableModel.getValueAt(rowIndex, i);
			}
			row = new GridTableRow(tableModel.getKeyID(rowIndex), values);
		}
				
		return row;
	}
	
	/**
	 * Get total number of rows
	 * @return int
	 * @see ListModel#getSize()
	 */
	public int getSize() {
		return tableModel.getRowCount(); 
	}
	
	/**
	 * Request components that attached to this model to re-render a row.
	 * @param row
	 */
	public void updateComponent(int row) {
		updateComponent(row, row);
	}
	
	/**
	 * Request components that attached to this model to re-render a range of row.
	 * @param fromRow
	 * @param toRow
	 */
	public void updateComponent(int fromRow, int toRow) {
		//must run from the UI thread
		if (Executions.getCurrent() != null) {
			fireEvent(ListDataEvent.CONTENTS_CHANGED, fromRow, toRow);
		}
	}

	/**
	 * @param cmpr
	 * @param ascending
	 * @see ListModelExt#sort(Comparator, boolean) 
	 */
	public void sort(Comparator<Object> cmpr, boolean ascending) {
		//use default zk comparator
		if (cmpr instanceof ListitemComparator) {			
			ListitemComparator lic = (ListitemComparator) cmpr;
			Integer index = (Integer) lic.getListheader().getAttribute("ColumnIndex");
			if (index != null && index.intValue() >= 0)
				tableModel.sort(index.intValue(), ascending);
			else
				tableModel.sort(lic.getListheader().getColumnIndex(), ascending);
		} else if (cmpr instanceof SortComparator) {
			SortComparator sc = (SortComparator)cmpr;
			tableModel.sort(sc.getColumnIndex(), ascending);
		}
		fireEvent(ListDataEvent.CONTENTS_CHANGED, -1, -1);
	}

	/**
	 * @param e
	 * @see TableModelListener#tableChanged(TableModelEvent) 
	 */
	public void tableChanged(TableModelEvent e) {
		if (Executions.getCurrent() != null) {
			if (e.getType() == TableModelEvent.DELETE) 
			{
				fireEvent(ListDataEvent.INTERVAL_REMOVED, e.getFirstRow(), e.getLastRow());
			}
			else if (e.getType() == TableModelEvent.INSERT)
			{
				fireEvent(ListDataEvent.INTERVAL_ADDED, e.getFirstRow(), e.getLastRow());
			}
			else if (e.getLastRow() == Integer.MAX_VALUE)
			{
				fireEvent(ListDataEvent.CONTENTS_CHANGED, -1, -1);
			}
			else
			{
				fireEvent(ListDataEvent.CONTENTS_CHANGED, e.getFirstRow(), e.getLastRow());
			}
		}
	}

	@Override
	public String getSortDirection(Comparator<Object> cmpr) {
		return "natural";
	}

}
