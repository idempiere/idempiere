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
 * - Peter Takacs, Cloudempiere                                       *
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.temporal.TemporalAdjusters;
import java.time.temporal.WeekFields;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import org.compiere.util.Env;

/**
 * Model class of AD_DateRange, a named date range (absolute or relative) for date range pickers.
 * @author Peter Takacs, Cloudempiere
 */
public class MDateRange extends X_AD_DateRange {

	private static final long serialVersionUID = 4014916636548604317L;

	/**
	 * @param ctx
	 * @param AD_DateRange_ID
	 * @param trxName
	 */
	public MDateRange(Properties ctx, int AD_DateRange_ID, String trxName) {
		super(ctx, AD_DateRange_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param AD_DateRange_ID
	 * @param trxName
	 * @param virtualColumns
	 */
	public MDateRange(Properties ctx, int AD_DateRange_ID, String trxName, String... virtualColumns) {
		super(ctx, AD_DateRange_ID, trxName, virtualColumns);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MDateRange(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}

	/**
	 * Get active Date Ranges of System or Client without Date Range Group, with the given Comparison Type
	 * @param ctx
	 * @param comparisonType
	 * @param trxName
	 * @return
	 */
	public static MDateRange[] getOfComparisonType(Properties ctx, String comparisonType, String trxName) {
		List<MDateRange> list = new Query(ctx, I_AD_DateRange.Table_Name, "AD_Client_ID IN (?,0) AND AD_DateRangeGroup_ID IS NULL AND RangeComparisonType IN(?,'"+RANGECOMPARISONTYPE_StandardAndComparisonRange+"')", trxName)
				.setParameters(Env.getAD_Client_ID(ctx), comparisonType)
				.setOnlyActiveRecords(true)
				.setOrderBy(COLUMNNAME_SeqNo)
				.list();
		return list.toArray(new MDateRange[list.size()]);
	}

	/**
	 * Resolve this date range to a start and an end date.
	 * An absolute range returns its own dates (an open end stays null).
	 * A relative range is resolved against the reference date, see {@link #getInterval(String, int, int, LocalDate, Locale)}.
	 * Previous period ranges depend on a main range and are not resolved here.
	 * @param reference date the relative range is counted from
	 * @return {dateFrom, dateTo}, or null if the range type cannot be resolved without a main range
	 */
	public Timestamp[] getInterval(Timestamp reference) {
		String rangeType = getRangeType();
		if (RANGETYPE_Absolute.equals(rangeType))
			return new Timestamp[] {getDateFrom(), getDateTo()};
		if (RANGETYPE_Relative.equals(rangeType) && getTimeUnit() != null)
			return getInterval(getTimeUnit(), getTimeOffset(), getTimeScope(), reference.toLocalDateTime().toLocalDate(), Env.getLocale(getCtx()));
		return null;
	}

	/**
	 * Resolve a relative range: <code>timeScope</code> whole time units, starting <code>timeOffset</code> units from the
	 * unit that contains the reference date. For example unit Month, offset -1, scope 1 is the last month;
	 * unit Day, offset -29, scope 30 is the last 30 days including the reference day.
	 * @param timeUnit {@link X_AD_Chart#TIMEUNIT_Day} and the other time units of a chart
	 * @param timeOffset units from the reference unit, negative for the past
	 * @param timeScope number of units, at least 1
	 * @param reference date the range is counted from
	 * @param locale locale that defines the first day of the week
	 * @return {first day at 00:00:00.000, last day at 23:59:59.999}, or null for an unknown time unit
	 */
	public static Timestamp[] getInterval(String timeUnit, int timeOffset, int timeScope, LocalDate reference, Locale locale) {
		int scope = Math.max(timeScope, 1);
		LocalDate first;
		LocalDate last;
		switch (timeUnit) {
		case MChart.TIMEUNIT_Day:
			first = reference.plusDays(timeOffset);
			last = first.plusDays(scope - 1L);
			break;
		case MChart.TIMEUNIT_Week:
			first = reference.plusWeeks(timeOffset).with(WeekFields.of(locale).dayOfWeek(), 1);
			last = first.plusWeeks(scope - 1L).plusDays(6);
			break;
		case MChart.TIMEUNIT_Month:
			first = reference.plusMonths(timeOffset).with(TemporalAdjusters.firstDayOfMonth());
			last = first.plusMonths(scope - 1L).with(TemporalAdjusters.lastDayOfMonth());
			break;
		case MChart.TIMEUNIT_Quarter:
			LocalDate inQuarter = reference.plusMonths(3L * timeOffset);
			first = inQuarter.withMonth((inQuarter.getMonthValue() - 1) / 3 * 3 + 1).with(TemporalAdjusters.firstDayOfMonth());
			last = first.plusMonths(3L * (scope - 1) + 2).with(TemporalAdjusters.lastDayOfMonth());
			break;
		case MChart.TIMEUNIT_Year:
			first = reference.plusYears(timeOffset).with(TemporalAdjusters.firstDayOfYear());
			last = first.plusYears(scope - 1L).with(TemporalAdjusters.lastDayOfYear());
			break;
		default:
			return null;
		}
		return new Timestamp[] {Timestamp.valueOf(first.atStartOfDay()), Timestamp.valueOf(last.atTime(LocalTime.MAX).withNano(999_000_000))};
	}

}
