/******************************************************************************
 * Copyright (C) 2012 Heng Sin Low                                            *
 * Copyright (C) 2012 Trek Global                 							  *
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
package org.compiere.print.util;

import java.io.Serializable;
import java.util.List;

/**
 * Report data matrix (Nested list)
 * @param <T>
 */
public interface SerializableMatrix<T extends Serializable> {

	/**
	 * Add row
	 * @param data
	 */
	public void addRow(List<T> data);

	/**
	 * Set current row pointer index
	 * @param row
	 * @return true if set successfully
	 */
	public boolean setRowIndex(int row);

	/**
	 * 	Move current row pointer index to next position (i.e +1)
	 * 	@return true if success
	 */
	public boolean setRowNext(); //	setRowNext

	/**
	 * 	Get Row Count
	 * 	@return row count
	 */
	public int getRowCount(); //	getRowCount

	/**
	 * 	Get Current Row Pointer Index
	 * 	@return current row pointer index
	 */
	public int getRowIndex(); //	getRowIndex

	/**
	 * Get data of current row
	 * @return data of currrent row
	 */
	public List<T> getRowData();

	/**
	 * Set data of current row
	 * @param data
	 */
	public void setRowData(List<T> data);
}