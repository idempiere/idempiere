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

public class RangePartitionInterval {
	private String columnName;
	private String name;
	private Object from;
	private Object to;

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
	
	public static List<List<RangePartitionInterval>> createIntervals(MTable table, List<RangePartitionColumn> rangePartitionColumns, String trxName) {
		List<List<RangePartitionInterval>> columnRangePartitionIntervals = new ArrayList<List<RangePartitionInterval>>();
		Pattern pattern1 = Pattern.compile("(\\d+)\\s+year(?:s)?\\s+(\\d+)\\s+month(?:s)?");
		Pattern pattern2 = Pattern.compile("(\\d+)\\s+year(?:s)?");
		Pattern pattern3 = Pattern.compile("(\\d+)\\s+month(?:s)?");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		List<MColumn> partitionKeyColumns = table.getPartitionKeyColumns();		
		List<String> partitionKeyColumnNames = table.getPartitionKeyColumnNames();
		for (int x = 0; x < partitionKeyColumnNames.size(); x++)
		{
			List<RangePartitionInterval> rangePartitionIntervals = new ArrayList<RangePartitionInterval>();

			MColumn partitionKeyColumn = partitionKeyColumns.get(x);
			RangePartitionColumn rangePartitonColumn = rangePartitionColumns.get(x);
			if (DisplayType.isDate(partitionKeyColumn.getAD_Reference_ID()) || DisplayType.isTimestampWithTimeZone(partitionKeyColumn.getAD_Reference_ID()))
			{
				int years = 0;
				int months = 0;
				Matcher matcher = pattern1.matcher(rangePartitonColumn.getIntervalPattern());
				if (matcher.matches())
				{
					years = Integer.parseInt(matcher.group(1));
					months = Integer.parseInt(matcher.group(2));
				}
				else
				{
					matcher = pattern2.matcher(rangePartitonColumn.getIntervalPattern());
					if (matcher.matches())
						years = Integer.parseInt(matcher.group(1));
					else
					{
						matcher = pattern3.matcher(rangePartitonColumn.getIntervalPattern());
						if (matcher.matches())
							months = Integer.parseInt(matcher.group(1));
					}
				}
				
				if (years < 0 || months < 0 || (years == 0 && months == 0))
					throw new IllegalArgumentException("Invalid range interval: " + years + " year(s) " + months + " month(s)");
				
				Timestamp minValue = (Timestamp) rangePartitonColumn.getMinValue();
				Timestamp maxValue = (Timestamp) rangePartitonColumn.getMaxValue();					
				
				Calendar cal = Calendar.getInstance();
				cal.setTimeInMillis(minValue.getTime());
				cal.set(cal.get(Calendar.YEAR), (months > 0) ? cal.get(Calendar.MONTH) : 0, 1);

				Calendar cal2 = Calendar.getInstance();
				cal2.setTimeInMillis(maxValue.getTime());

				while (cal.before(cal2))
				{
					String name = cal.get(Calendar.YEAR) + 
							(months > 0 ? (cal.get(Calendar.MONTH)+1) >=10 ? "_" + (cal.get(Calendar.MONTH)+1) 
									: "_0" + (cal.get(Calendar.MONTH)+1) : "");
					
					String from = dateFormat.format(cal.getTime());	
					cal.add(Calendar.YEAR, years);
					cal.add(Calendar.MONTH, months);			
					String to = dateFormat.format(cal.getTime());
					
					rangePartitionIntervals.add(new RangePartitionInterval(rangePartitonColumn.getColumnName(), name, "'" + from + "'", "'" + to + "'"));
				}
			}
			else if (DisplayType.isNumeric(partitionKeyColumn.getAD_Reference_ID()))
			{
				BigDecimal interval = new BigDecimal(rangePartitonColumn.getIntervalPattern());
				if (interval.signum() <= 0)
					throw new IllegalArgumentException("Invalid range interval: " + interval);
				
				BigDecimal minValue = (BigDecimal) rangePartitonColumn.getMinValue();
				BigDecimal maxValue = (BigDecimal) rangePartitonColumn.getMaxValue();

				BigDecimal value = minValue.divide(interval);
				value.setScale(interval.scale(), RoundingMode.DOWN);
				
				while (value.compareTo(maxValue) <= 0)
				{
					String name = value.toString().replaceAll(".", "-");
					BigDecimal from = value;
					value = value.add(interval);
					BigDecimal to = value;
					
					rangePartitionIntervals.add(new RangePartitionInterval(rangePartitonColumn.getColumnName(), name, from, to));
				}
			}
			else
				throw new IllegalArgumentException("Range key column type not supported: " + partitionKeyColumn);
			
			columnRangePartitionIntervals.add(rangePartitionIntervals);
		}
		return columnRangePartitionIntervals;
	}
}