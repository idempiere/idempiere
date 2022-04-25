/******************************************************************************
 * Copyright (C) 2018 Logilite Technologies LLP								  *
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
package org.adempiere.impexp;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Properties;
import java.util.logging.Level;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Footer;
import org.apache.poi.ss.usermodel.Header;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFPrintSetup;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.compiere.model.MSysConfig;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * Abstract MS Excel Format (xlsx) Exporter
 * 
 * @author Deepak Pansheriya
 */
public abstract class AbstractXLSXExporter
{
	/**
	 * Is the current Row a Function Row
	 * 
	 * @return true if function row
	 */
	public abstract boolean isFunctionRow();

	/**
	 * Get Columns Count
	 * 
	 * @return number of columns
	 */
	public abstract int getColumnCount();

	/**
	 * Get Rows Count
	 * 
	 * @return number of rows
	 */
	public abstract int getRowCount();

	/**
	 * Set current row
	 * 
	 * @param row row index
	 */
	protected abstract void setCurrentRow(int row);

	/**
	 * @return current row index
	 */
	protected abstract int getCurrentRow();

	/**
	 * Check if column is printed (displayed)
	 * 
	 * @param col column index
	 * @return true if is visible
	 */
	public abstract boolean isColumnPrinted(int col);

	/**
	 * Get column header name
	 * 
	 * @param col column index
	 * @return header name
	 */
	public abstract String getHeaderName(int col);

	/**
	 * Get cell display type (see {@link DisplayType})
	 * 
	 * @param row row index
	 * @param col column index
	 * @return display type
	 */
	public abstract int getDisplayType(int row, int col);

	/**
	 * Get cell value
	 * 
	 * @param row row index
	 * @param col column index
	 * @return cell value
	 */
	public abstract Object getValueAt(int row, int col);

	/**
	 * Check if there is a page break on given cell
	 * 
	 * @param row row index
	 * @param col column index
	 * @return true if there is a page break
	 */
	public abstract boolean isPageBreak(int row, int col);
	
	/**
	 * Check if there is a display logic
	 * 
	 * @param row row index
	 * @param col column index
	 * @return true if there is no logic or evaluate logic specified in print item
	 */
	public abstract boolean isDisplayed(int row, int col);
	
	/** Logger */
	protected final CLogger					log				= CLogger.getCLogger(getClass());
	//
	protected XSSFWorkbook					m_workbook;
	private XSSFDataFormat					m_dataFormat;
	private XSSFFont						m_fontHeader	= null;
	private XSSFFont						m_fontDefault	= null;
	protected Language						m_lang			= null;
	private int								m_sheetCount	= 0;
	//
	private int								m_colSplit		= 1;
	private int								m_rowSplit		= 1;
	private boolean							currentRowOnly	= false;
	/** Styles cache */
	private HashMap<String, XSSFCellStyle>	m_styles		= new HashMap<String, XSSFCellStyle>();

	protected Boolean[]						colSuppressRepeats;
	private int noOfParameter = 0;

	public AbstractXLSXExporter()
	{
		m_workbook = new XSSFWorkbook();
		m_dataFormat = m_workbook.createDataFormat();
	}

	protected Properties getCtx()
	{
		return Env.getCtx();
	}

	protected void setFreezePane(int colSplit, int rowSplit)
	{
		m_colSplit = colSplit;
		m_rowSplit = rowSplit;
	}

	private String fixString(String str)
	{
		// ms excel doesn't support UTF8 charset
		return Util.stripDiacritics(str);
	}

	protected Language getLanguage()
	{
		if (m_lang == null)
			m_lang = Env.getLanguage(getCtx());
		return m_lang;
	}

	private XSSFFont getFont(boolean isHeader)
	{
		XSSFFont font = null;
		if (isHeader)
		{
			if (m_fontHeader == null)
			{
				m_fontHeader = m_workbook.createFont();
				m_fontHeader.setBold(true);
			}
			font = m_fontHeader;
		}
		else if (isFunctionRow())
		{
			font = m_workbook.createFont();
			font.setBold(true);
			font.setItalic(true);
		}
		else
		{
			if (m_fontDefault == null)
			{
				m_fontDefault = m_workbook.createFont();
			}
			font = m_fontDefault;
		}
		return font;
	}

	/**
	 * Get Excel number format string by given {@link NumberFormat}
	 * 
	 * @param df number format
	 * @param isHighlightNegativeNumbers highlight negative numbers using RED
	 *            color
	 * @return number excel format string
	 */
	private String getFormatString(NumberFormat df, boolean isHighlightNegativeNumbers)
	{
		StringBuilder format = new StringBuilder();
		int integerDigitsMin = df.getMinimumIntegerDigits();
		int integerDigitsMax = df.getMaximumIntegerDigits();
		for (int i = 0; i < integerDigitsMax; i++)
		{
			if (i < integerDigitsMin)
				format.insert(0, "0");
			else
				format.insert(0, "#");
			if (i == 2)
			{
				format.insert(0, ",");
			}
		}
		int fractionDigitsMin = df.getMinimumFractionDigits();
		int fractionDigitsMax = df.getMaximumFractionDigits();
		for (int i = 0; i < fractionDigitsMax; i++)
		{
			if (i == 0)
				format.append(".");
			if (i < fractionDigitsMin)
				format.append("0");
			else
				format.append("#");
		}
		if (isHighlightNegativeNumbers)
		{
			String f = format.toString();
			format = new StringBuilder(f).append(";[RED]-").append(f);
		}
		//
		if (log.isLoggable(Level.FINEST))
			log.finest("NumberFormat: " + format);
		return format.toString();

	}

	private XSSFCellStyle getStyle(int row, int col)
	{
		int displayType = getDisplayType(row, col);
		String key = "cell-" + col + "-" + displayType;
		XSSFCellStyle cs = m_styles.get(key);
		if (cs == null)
		{
			cs = m_workbook.createCellStyle();
			XSSFFont font = getFont(false);
			cs.setFont(font);
			// Border
			cs.setBorderLeft(BorderStyle.THIN);
			cs.setBorderTop(BorderStyle.THIN);
			cs.setBorderRight(BorderStyle.THIN);
			cs.setBorderBottom(BorderStyle.THIN);
			//
			String cellFormat = getCellFormat(row, col);
			if (cellFormat != null)
				cs.setDataFormat(m_dataFormat.getFormat(cellFormat));
			m_styles.put(key, cs);
		}
		return cs;
	}

	protected String getCellFormat(int row, int col) {
		boolean isHighlightNegativeNumbers = true;
		int displayType = getDisplayType(row, col);
		String cellFormat = null;
		
		if (DisplayType.isDate(displayType)) {
			cellFormat = DisplayType.getDateFormat(getLanguage()).toPattern();
		} else if (DisplayType.isNumeric(displayType)) {
			DecimalFormat df = DisplayType.getNumberFormat(displayType, getLanguage());
			cellFormat = getFormatString(df, isHighlightNegativeNumbers);
		}
		
		return cellFormat;
	}
	
	private XSSFCellStyle getHeaderStyle(int col)
	{
		String key = "header-" + col;
		XSSFCellStyle cs_header = m_styles.get(key);
		if (cs_header == null)
		{
			XSSFFont font_header = getFont(true);
			cs_header = m_workbook.createCellStyle();
			cs_header.setFont(font_header);
			cs_header.setBorderLeft(BorderStyle.MEDIUM);
			cs_header.setBorderTop(BorderStyle.MEDIUM);
			cs_header.setBorderRight(BorderStyle.MEDIUM);
			cs_header.setBorderBottom(BorderStyle.MEDIUM);
			cs_header.setDataFormat(m_workbook.createDataFormat().getFormat("text"));
			cs_header.setWrapText(true);
			m_styles.put(key, cs_header);
		}
		return cs_header;
	}

	private void fixColumnWidth(XSSFSheet sheet, int lastColumnIndex)
	{
		for (short colnum = 0; colnum < lastColumnIndex; colnum++)
		{
			sheet.autoSizeColumn(colnum);
		}
	}

	private void closeTableSheet(XSSFSheet prevSheet, String prevSheetName, int colCount)
	{
		if (prevSheet == null)
			return;
		//
		fixColumnWidth(prevSheet, colCount);
		if ((m_colSplit >= 0 || m_rowSplit >= 0) && !isForm())
			prevSheet.createFreezePane(m_colSplit >= 0 ? m_colSplit : 0, m_rowSplit >= 0 ? m_rowSplit : 0);
		if (!Util.isEmpty(prevSheetName, true) && m_sheetCount > 0)
		{
			int prevSheetIndex = m_sheetCount - 1;
			try
			{
				m_workbook.setSheetName(prevSheetIndex, prevSheetName);
			}
			catch (Exception e)
			{
				log.log(Level.WARNING, "Error setting sheet " + prevSheetIndex + " name to " + prevSheetName, e);
			}
		}
	}

	private XSSFSheet createTableSheet()
	{
		XSSFSheet sheet = m_workbook.createSheet();
		formatPage(sheet);
		createHeaderFooter(sheet);
		createParameter(sheet);
		if (!isForm())
		{
			createTableHeader(sheet);
		}
		m_sheetCount++;
		//
		return sheet;
	}

	private void createTableHeader(XSSFSheet sheet)
	{
		createTableHeader(sheet, Math.max(noOfParameter, 0));
	}
	
	private void createTableHeader(XSSFSheet sheet, int headerRowNum)
	{
		int colnumMax = 0;

		XSSFRow row = sheet.createRow(headerRowNum);
		// for all columns
		int colnum = 0;
		for (int col = 0; col < getColumnCount(); col++)
		{
			if (colnum > colnumMax)
				colnumMax = colnum;
			//
			if (isColumnPrinted(col))
			{
				XSSFCell cell = row.createCell(colnum);
				// header row
				XSSFCellStyle style = getHeaderStyle(col);
				cell.setCellStyle(style);
				String str = fixString(getHeaderName(col));
				cell.setCellValue(new XSSFRichTextString(str));
				colnum++;
			} // printed
		} // for all columns
	}

	protected void createHeaderFooter(XSSFSheet sheet)
	{
		// Sheet Header
		Header header = sheet.getHeader();
		//&P == current page number
	    //&N == page numbers
		header.setRight("&P / &N");
		// Sheet Footer
		Footer footer = sheet.getFooter();
		footer.setLeft(Env.getStandardReportFooterTrademarkText());
		String s = MSysConfig.getValue(MSysConfig.ZK_FOOTER_SERVER_MSG, "", Env.getAD_Client_ID(Env.getCtx()));
		if (Util.isEmpty(s, true))
			footer.setCenter(Env.getHeader(getCtx(), 0));	
		else
			footer.setCenter(Msg.parseTranslation(Env.getCtx(), s));
		Timestamp now = new Timestamp(System.currentTimeMillis());
		s = MSysConfig.getValue(MSysConfig.ZK_FOOTER_SERVER_DATETIME_FORMAT, Env.getAD_Client_ID(Env.getCtx()));
		if (!Util.isEmpty(s, true))
			footer.setRight(new SimpleDateFormat(s).format(System.currentTimeMillis()));
		else
			footer.setRight(DisplayType.getDateFormat(DisplayType.DateTime, getLanguage()).format(now));
	}

	protected void formatPage(XSSFSheet sheet)
	{
		sheet.setFitToPage(true);
		// Print Setup
		XSSFPrintSetup ps = sheet.getPrintSetup();
		ps.setFitWidth((short) 1);
		ps.setNoColor(true);
		ps.setPaperSize(XSSFPrintSetup.A4_PAPERSIZE);
		ps.setLandscape(false);
	}

	protected boolean isCurrentRowOnly()
	{
		return currentRowOnly;
	}

	protected void setCurrentRowOnly(boolean b)
	{
		currentRowOnly = b;
	}

	/**
	 * Export to given stream
	 * 
	 * @param out
	 * @throws Exception
	 */
	protected void export(OutputStream out) throws Exception
	{
		XSSFSheet sheet = null;
		if (out != null) 
		{
			sheet = createTableSheet();
		}
		else  
		{
			m_dataFormat = m_workbook.createDataFormat();
			sheet = m_workbook.getSheetAt(0);
			createTableHeader(sheet, sheet.getLastRowNum()+2);
		}
		String sheetName = null;
		//
		int colnumMax = 0;
		int rownum = isCurrentRowOnly() ? getCurrentRow() : 0;
		int lastRowNum = isCurrentRowOnly() ? getCurrentRow() + 1 : getRowCount();
		Object[] preValues = null;
		int printColIndex = -1;
		if (colSuppressRepeats != null)
		{
			preValues = new Object[colSuppressRepeats.length];
		}

		int initxls_rownum = 0;
		if (out != null)
			initxls_rownum = Math.max(noOfParameter+1, 1);
		else 
			initxls_rownum = Math.max(noOfParameter+1, sheet.getLastRowNum()+1);
		
		for (int xls_rownum = initxls_rownum; rownum < lastRowNum; rownum++, xls_rownum++)
		{
			if (!isCurrentRowOnly())
				setCurrentRow(rownum);

			boolean isPageBreak = false;
			XSSFRow row = sheet.createRow(xls_rownum);
			printColIndex = -1;
			// for all columns
			int colnum = 0;
			for (int col = 0; col < getColumnCount(); col++)
			{
				if (colnum > colnumMax)
					colnumMax = colnum;
				//
				if (isColumnPrinted(col))
				{
					printColIndex++;
					XSSFCell cell = null;
					// line row
					Object obj = getValueAt(rownum, col);
					if (isForm())
					{
						if (isVisible(rownum, col) && (!isSuppressNull(col) || (obj != null && !Util.isEmpty(obj.toString(), true))))
						{
							row = getFormRow(sheet, col);
							cell = getFormCell(row, col);
							String label = fixString(getHeaderName(col));
							if (!Util.isEmpty(label, true))
							{
								cell.setCellValue(new XSSFRichTextString(label));
								int index = cell.getColumnIndex()+1;
								cell = row.getCell(index);
								if (cell == null)
									cell = row.createCell(index);
							}
						}
						else if (isSetFormRowPosition(col))
						{
							row = getFormRow(sheet, col);
						}
					}
					else
					{
						cell = row.createCell(colnum);
					}
					
					int displayType = getDisplayType(rownum, col);
					if (obj == null || !isDisplayed(rownum, col))
					{
						if (colSuppressRepeats != null && colSuppressRepeats[printColIndex])
						{
							preValues[printColIndex] = null;
						}
					}
					else if (colSuppressRepeats != null && colSuppressRepeats[printColIndex]
							&& obj.equals(preValues[printColIndex]))
					{
						// suppress
					}
					else if (!isVisible(rownum, col)) 
					{
						;
					}
					else if (DisplayType.isDate(displayType))
					{
						Timestamp value = null;
						if (obj instanceof Date)
							value = new Timestamp(((Date)obj).getTime());
						else
							value = (Timestamp)obj;
						cell.setCellValue(value);
					}
					else if (DisplayType.isNumeric(displayType))
					{
						double value = 0;
						if (obj instanceof Number)
						{
							value = ((Number) obj).doubleValue();
						}
						cell.setCellValue(value);
					}
					else if (DisplayType.YesNo == displayType)
					{
						boolean value = false;
						if (obj instanceof Boolean)
							value = (Boolean) obj;
						else
							value = "Y".equals(obj);
						cell.setCellValue(new XSSFRichTextString(Msg.getMsg(getLanguage(), value == true ? "Y" : "N")));
					}
					else
					{
						String value = fixString(obj.toString()); // formatted
						cell.setCellValue(new XSSFRichTextString(value));
					}
					//
					if (cell != null) 
					{
						XSSFCellStyle style = getStyle(rownum, col);
						if (isForm())
							style.setWrapText(true);
						cell.setCellStyle(style);
					}
					// Page break
					if (isPageBreak(rownum, col))
					{
						isPageBreak = true;
						sheetName = fixString(cell.getRichStringCellValue().getString());
					}
					//
					colnum++;
					if (colSuppressRepeats != null)
						preValues[printColIndex] = obj;
				} // printed
			} // for all columns
				//
				// Page Break
			if (isPageBreak)
			{
				closeTableSheet(sheet, sheetName, colnumMax);
				sheet = createTableSheet();
				xls_rownum = 0;
				isPageBreak = false;
			}
		} // for all rows
		if (out == null)
			fixColumnWidth(sheet, colnumMax);
		else
			closeTableSheet(sheet, sheetName, colnumMax);
		//

		if (out != null)
		{
			m_workbook.write(out);
			out.close();
		}

		//
		// Workbook Info
		if (log.isLoggable(Level.FINE))
		{
			log.fine("Sheets #" + m_sheetCount);
			log.fine("Styles used #" + m_styles.size());
		}
	}

	/**
	 * Export to file
	 * 
	 * @param file
	 * @param language reporting language
	 * @throws Exception
	 */
	public void export(File file, Language language) throws Exception
	{
		export(file, language, true);
	}

	/**
	 * Export to file
	 * 
	 * @param file
	 * @param language reporting language
	 * @param autoOpen auto open file after generated
	 * @throws Exception
	 */
	public void export(File file, Language language, boolean autoOpen) throws Exception
	{
		m_lang = language;
		if (file == null)
			file = File.createTempFile("Report_", ".xlsx");
		FileOutputStream out = new FileOutputStream(file);
		export(out);
		if (autoOpen && Ini.isClient())
			Env.startBrowser(file.toURI().toString());
	}

	public void exportToWorkbook(XSSFWorkbook workbook, Language language) throws Exception
	{
		m_lang = language;
		m_workbook = workbook;
		export(null);
	}
	
	/**
	 * @return true if it is form layout
	 */
	protected boolean isForm()
	{
		return false;
	}
	
	protected int getNoOfParameter()
	{
		return noOfParameter;
	}

	protected void setNoOfParameter(int noOfParameter)
	{
		this.noOfParameter = noOfParameter;
	}
		
	protected void createParameter(XSSFSheet sheet)
	{
		
	}
	
	/**
	 * 
	 * @param row
	 * @param col
	 * @return true if column is visible
	 */
	protected boolean isVisible(int row, int col)
	{
		return true;
	}
	
	/**
	 * 
	 * @param col
	 * @return true if column should be hidden when it is null
	 */
	protected boolean isSuppressNull(int col) {
		return false;
	}
	
	/**
	 * 
	 * @param col
	 * @return true if column is use to set new row position
	 */
	protected boolean isSetFormRowPosition(int col) {
		return false;
	}
	
	/**
	 * get cell for column. use for form layout
	 * @param row
	 * @param colnum
	 * @return cell for column
	 */
	protected XSSFCell getFormCell(XSSFRow row, int colnum) {
		return null;
	}

	/**
	 * get row for column. use for form layout
	 * @param sheet
	 * @param colnum
	 * @return row for column
	 */
	protected XSSFRow getFormRow(XSSFSheet sheet, int colnum) {
		return null;
	}
}
