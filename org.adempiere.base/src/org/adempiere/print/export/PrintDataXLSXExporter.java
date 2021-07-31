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
package org.adempiere.print.export;

import java.io.OutputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;

import javax.print.attribute.standard.MediaSizeName;

import org.adempiere.impexp.AbstractXLSXExporter;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFPrintSetup;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.compiere.model.MQuery;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.MPrintPaper;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.print.layout.PrintDataEvaluatee;
import org.compiere.util.DisplayType;
import org.compiere.util.Evaluator;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * Export PrintData to Excel (XLSX) file
 * 
 * @author Deepak Pansheriya
 */
public class PrintDataXLSXExporter extends AbstractXLSXExporter
{
	//constant for form rendering
	private static final int COLUMN_WIDTH_DIVISOR = 64;
	private static final int ROW_HEIGHT_DIVISOR = 20;
		
	private PrintData		m_printData;
	private MPrintFormat	m_printFormat;
	private Map<MPrintFormatItem, PrintData> childPrintFormatDetails;
	private ArrayList<Object> columns;
	private MQuery m_query;

	//variables for form rendering
	private int m_previousFormRow = -1;
	private int m_lastHeaderRow = -1;
	private int m_firstHeaderRow = -1;
	private int m_firstFooterRow = -1;
	private int m_previousFormCol = -1;
	private String m_previousAreaType = null;
		
	public PrintDataXLSXExporter(PrintData printData, MPrintFormat printFormat) 
	{
		this(printData, printFormat, null);
	}
	
	public PrintDataXLSXExporter(PrintData printData, MPrintFormat printFormat, Boolean[] colSuppressRepeats)
	{
		this(printData, printFormat, null, colSuppressRepeats, null);
	}
	
	public PrintDataXLSXExporter(PrintData printData, MPrintFormat printFormat, Map<MPrintFormatItem, PrintData> childPrintFormatDetails, Boolean[] colSuppressRepeats, MQuery query)
	{
		super();
		this.m_printData = printData;
		this.m_printFormat = printFormat;
		this.colSuppressRepeats = colSuppressRepeats;
		this.childPrintFormatDetails = childPrintFormatDetails;
		this.m_query = query;
	}

	@Override
	public int getColumnCount()
	{
		return columns.size();
	}

	private PrintDataElement getPDE(int row, int col)
	{
		if (m_printData.getRowIndex() != row)
			m_printData.setRowIndex(row);
		//
		MPrintFormatItem item = (MPrintFormatItem) columns.get(col);
		Object obj = null;

		if (item.isTypeField() || item.isTypePrintFormat() && item.isImageField()) 
		{
			obj = m_printData.getNodeByPrintFormatItemId(item.getAD_PrintFormatItem_ID());
		}
		
		/** DEVCOFFEE: script column **/
		if (item.isTypeScript())
		{
			obj = m_printData.getNodeByPrintFormatItemId(item.getAD_PrintFormatItem_ID());
		}
		
		if (obj != null && obj instanceof PrintDataElement)
		{
			return (PrintDataElement) obj;
		}
		return null;
	}

	@Override
	public int getDisplayType(int row, int col)
	{
		PrintDataElement pde = getPDE(row, col);
		if (pde != null)
		{
			return pde.getDisplayType();
		}
		return -1;
		//
	}

	@Override
	public Object getValueAt(int row, int col)
	{
		PrintDataElement pde = getPDE(row, col);
		Object value = null;
		if (pde == null)
			;
		else if (pde.isDate())
		{
			Object o = pde.getValue();
			if (o instanceof Date)
				value = new Timestamp(((Date) o).getTime());
			else
				value = (Timestamp) pde.getValue();
		}
		else if (pde.isNumeric())
		{
			Object o = pde.getValue();
			if (o instanceof Number)
			{
				value = ((Number) o).doubleValue();
			}
		}
		else if (pde.isYesNo())
		{
			value = pde.getValue();
		}
		else if (pde.isPKey())
		{
			value = pde.getValueAsString();
		}
		else
		{
			value = pde.getValueDisplay(getLanguage());
		}
		//
		MPrintFormatItem item = null;
		Object colObj = columns.get(col);
		if (colObj instanceof MPrintFormatItem)
			item = (MPrintFormatItem) colObj;
		if(item != null && item.getAD_PrintFormatChild_ID()!=0)
		{
			MPrintFormat mPrintFormat = null;
		
			if(childPrintFormatDetails!=null)
			{
				for (Iterator<Map.Entry<MPrintFormatItem,PrintData>> iter = childPrintFormatDetails.entrySet().iterator(); iter.hasNext();) 
				{
					try {
						Map.Entry<MPrintFormatItem,PrintData> entry = (Map.Entry<MPrintFormatItem,PrintData>) iter.next();
						MPrintFormatItem mPrintFormatItem = (MPrintFormatItem)entry.getKey();
						if (mPrintFormatItem.equals(item)) 
						{
							mPrintFormat = new MPrintFormat(getCtx(), mPrintFormatItem.getAD_PrintFormatChild_ID(), null);
							PrintData printData = (PrintData)entry.getValue();	
							PrintDataXLSXExporter exp =new PrintDataXLSXExporter(printData, mPrintFormat);
							exp.exportToWorkbook(m_workbook, m_lang);
							m_previousFormRow = m_workbook.getSheetAt(m_workbook.getNumberOfSheets()-1).getLastRowNum();
							break;
						}
					}
					catch(Exception ex)
					{
						log.log(Level.WARNING, ex.getMessage(), ex);
						break;
					}
				}
			}
		}
		return value;
	}

	@Override
	public String getHeaderName(int col)
	{
		Object colObj = columns.get(col);
		if (colObj instanceof MPrintFormatItem) {
			MPrintFormatItem item = (MPrintFormatItem) colObj;
			return item.getPrintName(getLanguage());
		} else {
			return "";
		}
	}

	@Override
	public int getRowCount()
	{
		return m_printData.getRowCount();
	}

	@Override
	public boolean isColumnPrinted(int col)
	{
		if (columns != null && col < columns.size())
			return true;
		else
			return false;
	}

	@Override
	public boolean isPageBreak(int row, int col)
	{
		PrintDataElement pde = getPDE(row, col);
		return pde != null ? pde.isPageBreak() : false;
	}

	@Override
	protected void setCurrentRow(int row)
	{
		m_printData.setRowIndex(row);
	}

	protected int getCurrentRow()
	{
		return m_printData.getRowIndex();
	}

	@Override
	public boolean isFunctionRow()
	{
		return m_printData.isFunctionRow();
	}

	@Override
	protected void formatPage(XSSFSheet sheet)
	{
		super.formatPage(sheet);
		MPrintPaper paper = MPrintPaper.get(this.m_printFormat.getAD_PrintPaper_ID());

		// Set paper size:
		short paperSize = -1;
		MediaSizeName mediaSizeName = paper.getMediaSize().getMediaSizeName();
		if (MediaSizeName.NA_LETTER.equals(mediaSizeName))
		{
			paperSize = XSSFPrintSetup.LETTER_PAPERSIZE;
		}
		else if (MediaSizeName.NA_LEGAL.equals(mediaSizeName))
		{
			paperSize = XSSFPrintSetup.LEGAL_PAPERSIZE;
		}
		else if (MediaSizeName.EXECUTIVE.equals(mediaSizeName))
		{
			paperSize = XSSFPrintSetup.EXECUTIVE_PAPERSIZE;
		}
		else if (MediaSizeName.ISO_A4.equals(mediaSizeName))
		{
			paperSize = XSSFPrintSetup.A4_PAPERSIZE;
		}
		else if (MediaSizeName.ISO_A5.equals(mediaSizeName))
		{
			paperSize = XSSFPrintSetup.A5_PAPERSIZE;
		}
		else if (MediaSizeName.NA_NUMBER_10_ENVELOPE.equals(mediaSizeName))
		{
			paperSize = XSSFPrintSetup.ENVELOPE_10_PAPERSIZE;
		}
		else if (MediaSizeName.MONARCH_ENVELOPE.equals(mediaSizeName))
		{
			paperSize = XSSFPrintSetup.ENVELOPE_MONARCH_PAPERSIZE;
		}
		if (paperSize != -1)
		{
			sheet.getPrintSetup().setPaperSize(paperSize);
		}

		// Set Landscape/Portrait:
		sheet.getPrintSetup().setLandscape(paper.isLandscape());

		// Set Paper Margin:
		sheet.setMargin(XSSFSheet.TopMargin, ((double) paper.getMarginTop()) / 72);
		sheet.setMargin(XSSFSheet.RightMargin, ((double) paper.getMarginRight()) / 72);
		sheet.setMargin(XSSFSheet.LeftMargin, ((double) paper.getMarginLeft()) / 72);
		sheet.setMargin(XSSFSheet.BottomMargin, ((double) paper.getMarginBottom()) / 72);
	}
	

	@Override
	public boolean isDisplayed(int row, int col)
	{
		if (m_printData.getRowIndex() != row)
			m_printData.setRowIndex(row);

		MPrintFormatItem item = m_printFormat.getItem(col);
		if ( Util.isEmpty(item.getDisplayLogic()))
			return true;
		
		return Evaluator.evaluateLogic(new PrintDataEvaluatee(null, m_printData), item.getDisplayLogic());
	}
	
	@Override
	protected String getCellFormat(int row, int col) {
		String cellFormat = null;
		PrintDataElement pde = getPDE(row, col);
		
		if (pde != null && !Util.isEmpty(pde.getM_formatPattern())) {
			String formatPattern = pde.getM_formatPattern();
			int displayType = pde.getDisplayType();
			if (DisplayType.isDate(displayType)) {
				cellFormat = DisplayType.getDateFormat(displayType, getLanguage(), formatPattern).toPattern();
			} else if (DisplayType.isNumeric(displayType)) {
				cellFormat = DisplayType.getNumberFormat(displayType, getLanguage(), formatPattern).toPattern();
			}
		} else {
			return super.getCellFormat(row, col);
		}
		
		return cellFormat;
	}
	
	@Override
	protected void export(OutputStream out) throws Exception {
		columns = new ArrayList<>();
		for (int col = 0; col < m_printFormat.getItemCount(); col++)
		{
			MPrintFormatItem item = m_printFormat.getItem(col);
			if (item.isPrinted())
			{
				columns.add(item);
			}
		}

		super.export(out);
	}
	
	@Override
	protected void createParameter(XSSFSheet sheet) {
		if (!m_printFormat.isForm()) {
			if (m_query != null && m_query.isActive()) {
				int rows = m_query.getReportProcessQuery() != null ? m_query.getReportProcessQuery().getRestrictionCount() : m_query.getRestrictionCount();
				if (rows > 0) {
					setNoOfParameter(rows);
					setFreezePane(1, rows + 1);
					
					XSSFCellStyle parameterStyle = m_workbook.createCellStyle();
					XSSFFont parameterFont = m_workbook.createFont();
					parameterFont.setItalic(true);
					parameterStyle.setFont(parameterFont);
					
					MQuery query = m_query;
					if (m_query.getReportProcessQuery() != null)
						query = m_query.getReportProcessQuery();
					for (int r = 0; r < query.getRestrictionCount(); r++)
					{
						XSSFRow row = sheet.createRow(r);
						if (r == 0) {
							XSSFCell cell = row.createCell(0);
							XSSFCellStyle style = m_workbook.createCellStyle();
							XSSFFont font = m_workbook.createFont();
							font.setBold(true);
							style.setFont(font);
							cell.setCellStyle(style);
							String value = Util.stripDiacritics(Msg.getMsg(getCtx(), "Parameter") + ":");
							cell.setCellValue(new XSSFRichTextString(value));
						}
						XSSFCell cell = row.createCell(1);
						cell.setCellStyle(parameterStyle);
						String value = Util.stripDiacritics(query.getInfoName(r));
						cell.setCellValue(new XSSFRichTextString(value));
						
						cell = row.createCell(2);
						cell.setCellStyle(parameterStyle);
						value = Util.stripDiacritics(query.getInfoOperator(r));
						cell.setCellValue(new XSSFRichTextString(value));
						
						cell = row.createCell(3);
						cell.setCellStyle(parameterStyle);
						value = Util.stripDiacritics(query.getInfoDisplayAll(r));
						cell.setCellValue(new XSSFRichTextString(value));
					}
				}
			}
		}
	}
	
	@Override
	protected boolean isForm()
	{
		return m_printFormat.isForm();
	}
	
	@Override
	protected XSSFCell getFormCell(XSSFRow row, int colnum) {
		XSSFCell cell = null;
		if (colnum >= 0 && colnum < columns.size()) {
			MPrintFormatItem item = (MPrintFormatItem) columns.get(colnum);		
			int previousCol = m_previousFormCol >= 0 ? m_previousFormCol : 0;
			if (m_previousAreaType != null && !m_previousAreaType.equals(item.getPrintAreaType())) {
				previousCol = 0;
			}
			if (item.isRelativePosition()) {
				int offset = item.getXSpace() > 0 ? item.getXSpace() / COLUMN_WIDTH_DIVISOR : 0;
				if (offset == 0 && item.getXSpace() > 0)
					offset = 1;
				int col = previousCol + offset;			
				cell = row.getCell(col);
				if (cell == null)
					cell = row.createCell(col);
			} else {
				int offset = item.getXPosition() > 0 ? item.getXPosition() / COLUMN_WIDTH_DIVISOR : 0;
				cell = row.getCell(offset);
				if (cell == null)
					cell = row.createCell(offset);
			}
			if (cell != null) {
				m_previousFormCol = cell.getColumnIndex();
				m_previousAreaType  = item.getPrintAreaType();
			}
		}
		
		return cell;
	}

	@Override
	protected XSSFRow getFormRow(XSSFSheet sheet, int colnum) {
		XSSFRow row = null;
		if (m_firstHeaderRow == -1) {
			m_firstHeaderRow = sheet.getLastRowNum();
		}
		if (colnum >= 0 && colnum < columns.size()) {
			MPrintFormatItem item = (MPrintFormatItem) columns.get(colnum);
			if (item.isRelativePosition()) {				
				int firstContentRow = m_lastHeaderRow >= 0 ? m_lastHeaderRow+1 : m_firstHeaderRow;
				int relativeFrom = m_previousFormRow >= 0 ? m_previousFormRow : 0;
				if (item.getPrintAreaType().equals(MPrintFormatItem.PRINTAREATYPE_Content)) {
					if (relativeFrom < firstContentRow)
						relativeFrom = firstContentRow;
				} else if (item.getPrintAreaType().equals(MPrintFormatItem.PRINTAREATYPE_Footer)) {
					if (relativeFrom < m_firstFooterRow)
						relativeFrom = m_firstFooterRow;
					else if (m_firstFooterRow==-1 && relativeFrom <= firstContentRow)
						relativeFrom = firstContentRow + 1;
				}
				if (item.isNextLine()) {
					int offset = 1;
					row = sheet.getRow(relativeFrom+offset);
					if (row == null)
						row = sheet.createRow(relativeFrom+offset);
				} else if (item.getYSpace() == 0) {
					row = sheet.getRow(relativeFrom);
					if (row == null)
						row = sheet.createRow(relativeFrom);
				} else {
					int offset = (item.getYSpace() / ROW_HEIGHT_DIVISOR) + 1;
					row = sheet.getRow(relativeFrom+offset);
					if (row == null)
						row = sheet.createRow(relativeFrom+offset);						
				}
				m_previousFormRow = row.getRowNum();
				
				if (item.getPrintAreaType().equals(MPrintFormatItem.PRINTAREATYPE_Header)) {
					if (row.getRowNum() > m_lastHeaderRow) {
						m_lastHeaderRow = row.getRowNum();
					}
				}
			} else {
				if (item.getYPosition() == 0) {
					if (item.getPrintAreaType().equals(MPrintFormatItem.PRINTAREATYPE_Header)) {
						row = sheet.getRow(m_firstHeaderRow);
						if (row.getRowNum() > m_lastHeaderRow) {
							m_lastHeaderRow = row.getRowNum();
						}
					} else if (item.getPrintAreaType().equals(MPrintFormatItem.PRINTAREATYPE_Content)) {
						if (m_lastHeaderRow >= 0) {
							row = sheet.getRow(m_lastHeaderRow+1);
							if (row == null)
								row = sheet.createRow(m_lastHeaderRow+1);
						} else {
							row = sheet.getRow(m_firstHeaderRow);
						}
					} else if (item.getPrintAreaType().equals(MPrintFormatItem.PRINTAREATYPE_Footer)) {
						if (m_firstFooterRow >= 0) {
							row = sheet.getRow(m_firstFooterRow);
						} else {
							row = sheet.getRow(sheet.getLastRowNum()+1);
							if (row == null)
								row = sheet.createRow(sheet.getLastRowNum()+1);
							m_firstFooterRow = row.getRowNum();
						}
					}
					m_previousFormRow = row.getRowNum();
				} else {
					int offset = item.getYPosition() / ROW_HEIGHT_DIVISOR;
					if (item.getPrintAreaType().equals(MPrintFormatItem.PRINTAREATYPE_Header)) {
						row = sheet.getRow(m_firstHeaderRow+offset);
						if (row == null)
							row = sheet.createRow(m_firstHeaderRow+offset);
						if (row.getRowNum() > m_lastHeaderRow) {
							m_lastHeaderRow = row.getRowNum();
						}
					} else if (item.getPrintAreaType().equals(MPrintFormatItem.PRINTAREATYPE_Content)) {
						int firstContentRow = m_lastHeaderRow >= 0 ? m_lastHeaderRow+1 : m_firstHeaderRow;
						row = sheet.getRow(firstContentRow+offset);
						if (row == null)
							row = sheet.createRow(firstContentRow+offset);
					} else if (item.getPrintAreaType().equals(MPrintFormatItem.PRINTAREATYPE_Footer)) {
						if (m_firstFooterRow == -1)
							m_firstFooterRow = sheet.getLastRowNum()+1;
						row = sheet.getRow(m_firstFooterRow+offset);
						if (row == null)
							row = sheet.createRow(m_firstFooterRow+offset);
					}
					m_previousFormRow = row.getRowNum();
				}
			}
		}
		return row;
	}
	
	@Override
	protected boolean isSetFormRowPosition(int col) {
		Object value = col >= 0 && col < columns.size() ? columns.get(col) : null;
		if (value instanceof MPrintFormatItem) {
			MPrintFormatItem item = (MPrintFormatItem)value; 
			return item.isSetNLPosition();
		}
		return super.isSetFormRowPosition(col);
	}
	
	@Override
	protected boolean isSuppressNull(int col) {
		Object value = col >= 0 && col < columns.size() ? columns.get(col) : null;
		if (value instanceof MPrintFormatItem) {
			MPrintFormatItem item = (MPrintFormatItem)value;
			return item.isSuppressNull();
		}
		return super.isSuppressNull(col);
	}
	
	@Override
	protected boolean isVisible(int row, int col) {
		Object value = col >= 0 && col < columns.size() ? columns.get(col) : null;
		if (value instanceof MPrintFormatItem) {
			MPrintFormatItem item = (MPrintFormatItem)value;
			String displayLogic = item.getDisplayLogic();
			if (!Util.isEmpty(displayLogic, true)) {
				if (m_printData.getRowIndex() != row)
					m_printData.setRowIndex(row);
				PrintDataEvaluatee evaluatee = new PrintDataEvaluatee(null, m_printData);
				return Evaluator.evaluateLogic(evaluatee, displayLogic);
			}
		}
		return super.isVisible(row, col);
	}
}
