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
package org.idempiere.test.print;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.spy;

import java.io.File;
import java.io.FileInputStream;
import java.io.Serializable;
import java.nio.file.Files;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Locale;
import java.util.TimeZone;

import org.adempiere.print.export.PrintDataExcelExporter;
import org.adempiere.print.export.PrintDataXLSXExporter;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.compiere.model.MLanguage;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataColumn;
import org.compiere.print.PrintDataElement;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Tests for {@link PrintDataExcelExporter}, {@link PrintDataXLSXExporter}, and
 * {@link DisplayType#getDateFormat(int, Language, String)} with {@link DisplayType#TimestampWithTimeZone}.
 */
public class PrintDataExcelExporterTest extends AbstractTestCase
{
	private MPrintFormatItem createMockItem(int id, String name)
	{
		MPrintFormatItem item = spy(new MPrintFormatItem(Env.getCtx(), 0, null));
		doReturn(id).when(item).getAD_PrintFormatItem_ID();
		doReturn(true).when(item).isPrinted();
		doReturn(true).when(item).isTypeField();
		doReturn(false).when(item).isPrintInstanceAttributes();
		doReturn(false).when(item).isTypeScript();
		doReturn(name).when(item).getPrintName(Env.getLanguage(Env.getCtx()));
		doReturn(null).when(item).getDisplayLogic();
		doReturn(false).when(item).isSuppressNull();
		doReturn(0).when(item).getAD_PrintFormatChild_ID();
		return item;
	}

	@Test
	public void testTimestampWithTimeZoneExport() throws Exception
	{
		String origClientTz = Env.getContext(Env.getCtx(), Env.CLIENT_INFO_TIME_ZONE);
		Instant instant = Instant.parse("2026-01-15T15:00:00Z");
		ZoneId jvmZone = TimeZone.getDefault().toZoneId();
		ZoneId nyZone = ZoneId.of("America/New_York");
		ZoneId clientZone = jvmZone.getRules().getOffset(instant).equals(nyZone.getRules().getOffset(instant))
				? ZoneId.of("Asia/Tokyo")
				: nyZone;
		String pattern = "yyyy-MM-dd HH:mm:ss";
		Timestamp ts = Timestamp.from(instant);
		LocalDateTime expectedClientTime = instant.atZone(clientZone).toLocalDateTime();
		LocalDateTime expectedJvmTime = instant.atZone(jvmZone).toLocalDateTime();
		assertNotEquals(expectedJvmTime, expectedClientTime,
				"Test requires client timezone offset to differ from JVM default timezone offset");

		File xlsFile = Files.createTempFile("PrintDataExcelExporterTest_", ".xls").toFile();
		File xlsxFile = Files.createTempFile("PrintDataExcelExporterTest_", ".xlsx").toFile();
		try
		{
			Env.setContext(Env.getCtx(), Env.CLIENT_INFO_TIME_ZONE, clientZone.getId());

			// Verify DisplayType.getDateFormat applies client timezone for TimestampWithTimeZone with custom pattern
			Language lang = Env.getLanguage(Env.getCtx());
			SimpleDateFormat sdf = DisplayType.getDateFormat(DisplayType.TimestampWithTimeZone, lang, pattern);
			assertEquals(clientZone.getId(), sdf.getTimeZone().getID(), "DateFormat should use client timezone");
			assertEquals(DateTimeFormatter.ofPattern(pattern).format(instant.atZone(clientZone)),
					sdf.format(ts), "Formatted TimestampWithTimeZone should reflect client timezone");

			SimpleDateFormat sdfNullLang = DisplayType.getDateFormat(DisplayType.TimestampWithTimeZone, null, pattern);
			assertEquals(clientZone.getId(), sdfNullLang.getTimeZone().getID(),
					"DateFormat with null language should use client timezone");

			// Verify DisplayType.setTimeZone preserves the requested Language locale symbols
			Language otherLang = Locale.getDefault().getLanguage().equals("de")
					? Language.getLanguage("en_US")
					: Language.getLanguage("de_DE");
			String localePattern = "dd MMM yyyy HH:mm";
			Timestamp decTs = Timestamp.from(Instant.parse("2026-12-15T15:00:00Z"));
			SimpleDateFormat localizedSdf = DisplayType.getDateFormat(DisplayType.TimestampWithTimeZone, otherLang, localePattern);
			SimpleDateFormat expectedLocalizedSdf = new SimpleDateFormat(localePattern, otherLang.getLocale());
			expectedLocalizedSdf.setTimeZone(TimeZone.getTimeZone(clientZone));
			assertEquals(clientZone.getId(), localizedSdf.getTimeZone().getID(),
					"Localized DateFormat should use client timezone");
			assertEquals(expectedLocalizedSdf.format(decTs), localizedSdf.format(decTs),
					"DisplayType.setTimeZone should preserve Language locale symbols");

			// Build PrintData with TimestampWithTimeZone (with and without formatPattern) and DateTime
			PrintData pd = new PrintData(Env.getCtx(), "Test TZ Export");
			PrintDataColumn[] cols = new PrintDataColumn[] {
				new PrintDataColumn(1001, 1001, "TZWithPattern", DisplayType.TimestampWithTimeZone, 30, "TZWithPattern", false),
				new PrintDataColumn(1002, 1002, "TZDefault", DisplayType.TimestampWithTimeZone, 30, "TZDefault", false),
				new PrintDataColumn(1003, 1003, "DateTimeNoTZ", DisplayType.DateTime, 30, "DateTimeNoTZ", false)
			};
			pd.setColumnInfo(cols);

			ArrayList<Serializable> nodes = new ArrayList<>();
			nodes.add(new PrintDataElement(1001, "TZWithPattern", ts, DisplayType.TimestampWithTimeZone, pattern));
			nodes.add(new PrintDataElement(1002, "TZDefault", ts, DisplayType.TimestampWithTimeZone, null));
			nodes.add(new PrintDataElement(1003, "DateTimeNoTZ", ts, DisplayType.DateTime, pattern));
			pd.addRow(false, 0, nodes);

			MPrintFormatItem item1 = createMockItem(1001, "TZWithPattern");
			MPrintFormatItem item2 = createMockItem(1002, "TZDefault");
			MPrintFormatItem item3 = createMockItem(1003, "DateTimeNoTZ");

			MPrintFormat pf = spy(new MPrintFormat(Env.getCtx(), DictionaryIDs.AD_PrintFormat.TEST_REPORT.id, getTrxName()));
			doReturn(3).when(pf).getItemCount();
			doReturn(item1).when(pf).getItem(0);
			doReturn(item2).when(pf).getItem(1);
			doReturn(item3).when(pf).getItem(2);

			// Export XLS & XLSX with valid client timezone
			exportAndAssert(pd, pf, lang, xlsFile, xlsxFile, expectedClientTime, expectedJvmTime, pattern);

			// Empty client timezone should fall back to JVM timezone
			Env.setContext(Env.getCtx(), Env.CLIENT_INFO_TIME_ZONE, "");
			exportAndAssert(pd, pf, lang, xlsFile, xlsxFile, expectedJvmTime, expectedJvmTime, pattern);

			// Invalid client timezone should fall back to JVM timezone (not GMT)
			Env.setContext(Env.getCtx(), Env.CLIENT_INFO_TIME_ZONE, "Invalid/Zone");
			exportAndAssert(pd, pf, lang, xlsFile, xlsxFile, expectedJvmTime, expectedJvmTime, pattern);
		}
		finally
		{
			Env.setContext(Env.getCtx(), Env.CLIENT_INFO_TIME_ZONE, origClientTz);
			Files.deleteIfExists(xlsFile.toPath());
			Files.deleteIfExists(xlsxFile.toPath());
		}
	}

	private void exportAndAssert(PrintData pd, MPrintFormat pf, Language lang, File xlsFile, File xlsxFile,
			LocalDateTime expectedTzTime, LocalDateTime expectedJvmTime, String pattern) throws Exception
	{
		PrintDataExcelExporter xlsExporter = new PrintDataExcelExporter(pd, pf);
		xlsExporter.export(xlsFile, lang, false);
		try (FileInputStream fis = new FileInputStream(xlsFile);
				Workbook wb = new HSSFWorkbook(fis))
		{
			assertExportedRow(wb, expectedTzTime, expectedJvmTime, pattern, "XLS");
		}

		PrintDataXLSXExporter xlsxExporter = new PrintDataXLSXExporter(pd, pf);
		xlsxExporter.export(xlsxFile, lang, false);
		try (FileInputStream fis = new FileInputStream(xlsxFile);
				Workbook wb = new XSSFWorkbook(fis))
		{
			assertExportedRow(wb, expectedTzTime, expectedJvmTime, pattern, "XLSX");
		}
	}

	private void assertExportedRow(Workbook wb, LocalDateTime expectedClientTime, LocalDateTime expectedJvmTime,
			String pattern, String formatName)
	{
		Sheet sheet = wb.getSheetAt(0);
		Row dataRow = sheet.getRow(1);
		assertEquals(expectedClientTime, dataRow.getCell(0).getLocalDateTimeCellValue(),
				formatName + ": TimestampWithTimeZone with pattern should export in client timezone");
		assertEquals(pattern, dataRow.getCell(0).getCellStyle().getDataFormatString(),
				formatName + ": Custom format pattern should be applied");
		assertEquals(expectedClientTime, dataRow.getCell(1).getLocalDateTimeCellValue(),
				formatName + ": TimestampWithTimeZone without pattern should export in client timezone");
		assertEquals(expectedJvmTime, dataRow.getCell(2).getLocalDateTimeCellValue(),
				formatName + ": DateTime without timezone should remain in JVM timezone");
	}

	@Test
	public void testDefaultDateCellFormats() throws Exception
	{
		Language lang = Env.getLanguage(Env.getCtx());
		Timestamp ts = Timestamp.from(Instant.parse("2026-01-15T15:00:00Z"));
		String expectedDatePattern = DisplayType.getDateFormat(lang).toPattern();

		PrintData pd = new PrintData(Env.getCtx(), "Test Default Date Formats");
		PrintDataColumn[] cols = new PrintDataColumn[] {
			new PrintDataColumn(2001, 2001, "DateCol", DisplayType.Date, 30, "DateCol", false),
			new PrintDataColumn(2002, 2002, "TimeCol", DisplayType.Time, 30, "TimeCol", false),
			new PrintDataColumn(2003, 2003, "DateTimeCol", DisplayType.DateTime, 30, "DateTimeCol", false),
			new PrintDataColumn(2004, 2004, "TZCol", DisplayType.TimestampWithTimeZone, 30, "TZCol", false)
		};
		pd.setColumnInfo(cols);

		ArrayList<Serializable> nodes = new ArrayList<>();
		nodes.add(new PrintDataElement(2001, "DateCol", ts, DisplayType.Date, null));
		nodes.add(new PrintDataElement(2002, "TimeCol", ts, DisplayType.Time, null));
		nodes.add(new PrintDataElement(2003, "DateTimeCol", ts, DisplayType.DateTime, null));
		nodes.add(new PrintDataElement(2004, "TZCol", ts, DisplayType.TimestampWithTimeZone, null));
		pd.addRow(false, 0, nodes);

		MPrintFormatItem item1 = createMockItem(2001, "DateCol");
		MPrintFormatItem item2 = createMockItem(2002, "TimeCol");
		MPrintFormatItem item3 = createMockItem(2003, "DateTimeCol");
		MPrintFormatItem item4 = createMockItem(2004, "TZCol");

		MPrintFormat pf = spy(new MPrintFormat(Env.getCtx(), DictionaryIDs.AD_PrintFormat.TEST_REPORT.id, getTrxName()));
		doReturn(4).when(pf).getItemCount();
		doReturn(item1).when(pf).getItem(0);
		doReturn(item2).when(pf).getItem(1);
		doReturn(item3).when(pf).getItem(2);
		doReturn(item4).when(pf).getItem(3);

		MLanguage realLang = MLanguage.get(Env.getCtx(), lang);

		File xlsFile = Files.createTempFile("PrintDataExcelExporterTest_fmt_", ".xls").toFile();
		File xlsxFile = Files.createTempFile("PrintDataExcelExporterTest_fmt_", ".xlsx").toFile();
		try
		{
			// 1. No AD_Language.TimePattern -> falls back to DisplayType.DEFAULT_TIME_FORMAT
			MLanguage noTimePatternLang = spy(realLang);
			doReturn(null).when(noTimePatternLang).getTimePattern();
			try (MockedStatic<MLanguage> mocked = mockStatic(MLanguage.class, Mockito.CALLS_REAL_METHODS))
			{
				mocked.when(() -> MLanguage.get(Env.getCtx(), lang)).thenReturn(noTimePatternLang);
				exportAndAssertFormats(pd, pf, lang, xlsFile, xlsxFile,
						expectedDatePattern,
						DisplayType.DEFAULT_TIME_FORMAT,
						expectedDatePattern + " " + DisplayType.DEFAULT_TIME_FORMAT);
			}

			// 2. AD_Language.TimePattern with Java AM/PM ('a') and timezone ('z') -> Excel 'AM/PM' without 'z'
			MLanguage amPmTzLang = spy(realLang);
			doReturn("hh:mm:ss a z").when(amPmTzLang).getTimePattern();
			try (MockedStatic<MLanguage> mocked = mockStatic(MLanguage.class, Mockito.CALLS_REAL_METHODS))
			{
				mocked.when(() -> MLanguage.get(Env.getCtx(), lang)).thenReturn(amPmTzLang);
				exportAndAssertFormats(pd, pf, lang, xlsFile, xlsxFile,
						expectedDatePattern,
						"hh:mm:ss AM/PM",
						expectedDatePattern + " hh:mm:ss AM/PM");
			}

			// 3. AD_Language.TimePattern with quoted literal ('at') and timezone letters (zzz, Z, X)
			MLanguage quotedLang = spy(realLang);
			doReturn("HH:mm:ss 'at' a zzz Z X").when(quotedLang).getTimePattern();
			try (MockedStatic<MLanguage> mocked = mockStatic(MLanguage.class, Mockito.CALLS_REAL_METHODS))
			{
				mocked.when(() -> MLanguage.get(Env.getCtx(), lang)).thenReturn(quotedLang);
				exportAndAssertFormats(pd, pf, lang, xlsFile, xlsxFile,
						expectedDatePattern,
						"HH:mm:ss 'at' AM/PM",
						expectedDatePattern + " HH:mm:ss 'at' AM/PM");
			}
		}
		finally
		{
			Files.deleteIfExists(xlsFile.toPath());
			Files.deleteIfExists(xlsxFile.toPath());
		}
	}

	private void exportAndAssertFormats(PrintData pd, MPrintFormat pf, Language lang, File xlsFile, File xlsxFile,
			String expectedDateFormat, String expectedTimeFormat, String expectedDateTimeFormat) throws Exception
	{
		PrintDataExcelExporter xlsExporter = new PrintDataExcelExporter(pd, pf);
		xlsExporter.export(xlsFile, lang, false);
		try (FileInputStream fis = new FileInputStream(xlsFile);
				Workbook wb = new HSSFWorkbook(fis))
		{
			assertCellFormats(wb, expectedDateFormat, expectedTimeFormat, expectedDateTimeFormat, "XLS");
		}

		PrintDataXLSXExporter xlsxExporter = new PrintDataXLSXExporter(pd, pf);
		xlsxExporter.export(xlsxFile, lang, false);
		try (FileInputStream fis = new FileInputStream(xlsxFile);
				Workbook wb = new XSSFWorkbook(fis))
		{
			assertCellFormats(wb, expectedDateFormat, expectedTimeFormat, expectedDateTimeFormat, "XLSX");
		}
	}

	private void assertCellFormats(Workbook wb, String expectedDateFormat, String expectedTimeFormat,
			String expectedDateTimeFormat, String formatName)
	{
		Row dataRow = wb.getSheetAt(0).getRow(1);
		assertEquals(expectedDateFormat, dataRow.getCell(0).getCellStyle().getDataFormatString(),
				formatName + ": Date column should use date format");
		assertEquals(expectedTimeFormat, dataRow.getCell(1).getCellStyle().getDataFormatString(),
				formatName + ": Time column should use Excel-compatible time format");
		assertEquals(expectedDateTimeFormat, dataRow.getCell(2).getCellStyle().getDataFormatString(),
				formatName + ": DateTime column should use Excel-compatible date-time format");
		assertEquals(expectedDateTimeFormat, dataRow.getCell(3).getCellStyle().getDataFormatString(),
				formatName + ": TimestampWithTimeZone column should use Excel-compatible date-time format");
	}
}
