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
 **********************************************************************/
package org.compiere.db.partition;

/**
 * Value object for a range partition column
 */
public class RangePartitionColumn {
	private String columnName;
	private String intervalPattern;
	private Object minValue;
	private Object maxValue;
	
	/**
	 * @param columnName
	 * @param intervalPattern
	 * @param minValue
	 * @param maxValue
	 */
	public RangePartitionColumn(String columnName, String intervalPattern, Object minValue, Object maxValue)
	{
		this.columnName = columnName;
		this.intervalPattern = intervalPattern;
		this.minValue = minValue;
		this.maxValue = maxValue;
	}

	/**
	 * @return column name
	 */
	public String getColumnName() {
		return columnName;
	}

	/**
	 * @return interval pattern for range
	 */
	public String getIntervalPattern() {
		return intervalPattern;
	}

	/**
	 * @return minimum value of range
	 */
	public Object getMinValue() {
		return minValue;
	}

	/**
	 * @return maximum value of range
	 */
	public Object getMaxValue() {
		return maxValue;
	}
}