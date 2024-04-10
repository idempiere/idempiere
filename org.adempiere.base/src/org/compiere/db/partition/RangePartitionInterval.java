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

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;

/**
 * Range interval for a partition column
 */
public class RangePartitionInterval {
	private String columnName;
	private String name;
	private Object from;
	private Object to;

	private static Pattern yearMonthPattern = Pattern.compile("^([1-9]{1}[0-9]?)\\s+year(?:s)?\\s+([1-9]{1}[0-9]?)\\s+month(?:s)?$");
	private static Pattern yearPattern = Pattern.compile("^([1-9]{1}[0-9]?)\\s+(year)(?:s)?$");
	private static Pattern monthPattern = Pattern.compile("^([1-9]{1}[0-9]?)\\s+(month)(?:s)?$");
	
	/**
	 * @param name
	 * @param from
	 * @param to
	 */
	public RangePartitionInterval(String columnName, String name, Object from, Object to)
	{
		this.columnName = columnName;
		this.name = name;
		this.from = from;
		this.to = to;
	}
	
	/**
	 * @return column name
	 */
	public String getColumnName() {
		return columnName;
	}

	/**
	 * @return interval name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @return interval from value
	 */
	public Object getFrom() {
		return from;
	}

	/**
	 * @return interval to value
	 */
	public Object getTo() {
		return to;
	}
	
	/**
	 * Validate range partition interval pattern
	 * @param column
	 * @return String error-code - null if not error
	 */
	public static String validateIntervalPattern(MColumn column) {
		if (DisplayType.isDate(column.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(column.getAD_Reference_ID()))
		{			
			Matcher matcher = yearMonthPattern.matcher(column.getRangePartitionInterval());
			if (!matcher.matches())
			{
				matcher = yearPattern.matcher(column.getRangePartitionInterval());
				if (!matcher.matches())
				{
					matcher = monthPattern.matcher(column.getRangePartitionInterval());
					if (!matcher.matches())
						return Msg.getMsg(Env.getCtx(), "InvalidRangePartitionInterval");
					return null;
				}
				return null;
			}
			return null;
		}
		else if (DisplayType.isNumeric(column.getAD_Reference_ID()) || DisplayType.isID(column.getAD_Reference_ID()))
		{
			Pattern pattern = Pattern.compile("^[1-9]\\d*$");
			Matcher matcher = pattern.matcher(column.getRangePartitionInterval());
			if (!matcher.matches())
				return Msg.getMsg(Env.getCtx(), "InvalidRangePartitionInterval");
			return null;
		}
		else
			return Msg.getMsg(Env.getCtx(), "RangePartitionKeyTypeNotSupported");
	}
	
	/**
	 * @param table
	 * @param rangePartitionColumn
	 * @param trxName
	 * @return RangePartitionInterval
	 */
	public static List<RangePartitionInterval> createInterval(MTable table, RangePartitionColumn rangePartitionColumn, String trxName) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		MColumn partitionKeyColumn = table.getColumn(rangePartitionColumn.getColumnName());		
		List<RangePartitionInterval> rangePartitionIntervals = new ArrayList<>();

		if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
		{
			Interval interval = getInterval(partitionKeyColumn);
			
			Timestamp minValue = (Timestamp) rangePartitionColumn.getMinValue();
			Timestamp maxValue = (Timestamp) rangePartitionColumn.getMaxValue();					
			
			Calendar cal = Calendar.getInstance();
			cal.setTimeInMillis(minValue.getTime());
			cal.set(cal.get(Calendar.YEAR), (interval.months > 0) ? cal.get(Calendar.MONTH) : 0, 1);

			Calendar cal2 = Calendar.getInstance();
			cal2.setTimeInMillis(maxValue.getTime());

			while (cal.before(cal2))
			{
				String name = cal.get(Calendar.YEAR) + 
						(interval.months > 0 ? (cal.get(Calendar.MONTH)+1) >=10 ? "_" + (cal.get(Calendar.MONTH)+1) 
								: "_0" + (cal.get(Calendar.MONTH)+1) : "");
				
				String from = dateFormat.format(cal.getTime());	
				cal.add(Calendar.YEAR, interval.years);
				cal.add(Calendar.MONTH, interval.months);			
				String to = dateFormat.format(cal.getTime());
				
				RangePartitionInterval rangePartitionInterval = new RangePartitionInterval(rangePartitionColumn.getColumnName(), name, "'" + from + "'", "'" + to + "'");
				rangePartitionIntervals.add(rangePartitionInterval);
			}
		}
		else if (DisplayType.isNumeric(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isID(partitionKeyColumn.getAD_Reference_ID()))
		{
			Pattern pattern = Pattern.compile("^[1-9]\\d*$");
			Matcher matcher = pattern.matcher(rangePartitionColumn.getIntervalPattern());
			if (!matcher.matches())
				throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "InvalidRangePartitionInterval") + " [" + partitionKeyColumn + "]");
			
			BigDecimal interval = new BigDecimal(rangePartitionColumn.getIntervalPattern());	
			BigDecimal minValue = (BigDecimal) rangePartitionColumn.getMinValue();
			BigDecimal maxValue = (BigDecimal) rangePartitionColumn.getMaxValue();

			BigDecimal value = minValue.divide(interval).setScale(0, RoundingMode.DOWN).multiply(interval);
			while (value.compareTo(maxValue) <= 0)
			{
				String name = String.valueOf(value.intValue());
				BigDecimal from = value;
				value = value.add(interval);
				BigDecimal to = value;
				
				RangePartitionInterval rangePartitionInterval = new RangePartitionInterval(rangePartitionColumn.getColumnName(), name, from, to);
				rangePartitionIntervals.add(rangePartitionInterval);
			}
		}
		else
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "RangePartitionKeyTypeNotSupported") + " [" + partitionKeyColumn + "]");
		
		return rangePartitionIntervals;
	}
	
	/**
	 * Get year and month interval from AD_Column.RangePartitionInterval.<br/>
	 * Throw exception if pattern is invalid.
	 * @param partitionKeyColumn
	 * @return year and month interval
	 */
	public static Interval getInterval(MColumn partitionKeyColumn) {
		int years = 0;
		int months = 0;
		Matcher matcher = yearMonthPattern.matcher(partitionKeyColumn.getRangePartitionInterval());
		if (matcher.matches())
		{
			years = Integer.parseInt(matcher.group(1));
			months = Integer.parseInt(matcher.group(2));
		}
		else
		{
			matcher = yearPattern.matcher(partitionKeyColumn.getRangePartitionInterval());
			if (matcher.matches())
				years = Integer.parseInt(matcher.group(1));
			else
			{
				matcher = monthPattern.matcher(partitionKeyColumn.getRangePartitionInterval());
				if (matcher.matches())
					months = Integer.parseInt(matcher.group(1));
			}
		}
		
		if (years < 0 || months < 0 || (years == 0 && months == 0))
			throw new IllegalArgumentException(Msg.getMsg(Env.getCtx(), "InvalidRangePartitionInterval") + " [" + partitionKeyColumn + "]");
		
		return new Interval(years, months);
	}
	
	/**
	 * Year and month interval
	 */
	public static record Interval(int years, int months) {
	}
}