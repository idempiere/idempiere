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
package org.compiere.print.layout;

import org.compiere.util.ValueNamePair;

/**
 * @author hengsin
 *
 */
public class TableProperties {

	private ValueNamePair[] columnHeader;
	private int[] columnMaxWidth;
	private int[] columnMaxHeight;
	private boolean[] fixedWidth;
	private Boolean[] colSuppressRepeats;
	private String[] columnJustification;

	/**
	 * 
	 * @param columnHeader
	 * @param columnMaxWidth
	 * @param columnMaxHeight
	 * @param fixedWidth
	 * @param colSuppressRepeats
	 * @param columnJustification
	 */
	public TableProperties(ValueNamePair[] columnHeader, int[] columnMaxWidth, int[] columnMaxHeight,
			boolean[] fixedWidth, Boolean[] colSuppressRepeats, String[] columnJustification) {
		this.columnHeader = columnHeader;
		this.columnMaxWidth = columnMaxWidth;
		this.columnMaxHeight = columnMaxHeight;
		this.fixedWidth = fixedWidth;
		this.colSuppressRepeats = colSuppressRepeats;
		this.columnJustification = columnJustification;
	}

	/**
	 * 
	 * @return column headers
	 */
	public ValueNamePair[] getColumnHeader() {
		return columnHeader;
	}

	/**
	 * 
	 * @param columnHeader
	 */
	public void setColumnHeader(ValueNamePair[] columnHeader) {
		this.columnHeader = columnHeader;
	}

	/**
	 * 
	 * @return max width for columns
	 */
	public int[] getColumnMaxWidth() {
		return columnMaxWidth;
	}

	/**
	 * 
	 * @param columnMaxWidth
	 */
	public void setColumnMaxWidth(int[] columnMaxWidth) {
		this.columnMaxWidth = columnMaxWidth;
	}

	/**
	 * 
	 * @return max height for columns
	 */
	public int[] getColumnMaxHeight() {
		return columnMaxHeight;
	}

	/**
	 * 
	 * @param columnMaxHeight
	 */
	public void setColumnMaxHeight(int[] columnMaxHeight) {
		this.columnMaxHeight = columnMaxHeight;
	}

	/**
	 * 
	 * @return fixed width option for columns
	 */
	public boolean[] getFixedWidth() {
		return fixedWidth;
	}

	/**
	 * 
	 * @param fixedWidth
	 */
	public void setFixedWidth(boolean[] fixedWidth) {
		this.fixedWidth = fixedWidth;
	}

	/**
	 * 
	 * @return suppress repeating value setting for columns
	 */
	public Boolean[] getColSuppressRepeats() {
		return colSuppressRepeats;
	}

	/**
	 * 
	 * @param colSuppressRepeats
	 */
	public void setColSuppressRepeats(Boolean[] colSuppressRepeats) {
		this.colSuppressRepeats = colSuppressRepeats;
	}

	/**
	 * 
	 * @return justification setting for columns
	 */
	public String[] getColumnJustification() {
		return columnJustification;
	}

	/**
	 * 
	 * @param columnJustification
	 */
	public void setColumnJustification(String[] columnJustification) {
		this.columnJustification = columnJustification;
	}

}
