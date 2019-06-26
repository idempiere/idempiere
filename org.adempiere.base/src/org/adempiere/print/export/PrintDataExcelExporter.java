/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2008 SC ARHIPAC SERVICE SRL. All Rights Reserved.            *
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

import org.adempiere.impexp.AbstractExcelExporter;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPrintSetup;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.compiere.model.MQuery;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.MPrintPaper;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.util.DisplayType;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * Export PrintData to Excel (XLS) file
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1939010 ] Excel Export ERROR - java.sql.Date - integrated Mario Grigioni's fix
 * 			<li>BF [ 1974309 ] Exporting a report to XLS is not setting page format
 */
public class PrintDataExcelExporter
extends AbstractExcelExporter
{
	private PrintData m_printData;
	private MPrintFormat m_printFormat;
	private Map<MPrintFormatItem, PrintData> childPrintFormatDetails;
	private ArrayList<Object> columns;
	private MQuery m_query;
	
	public PrintDataExcelExporter(PrintData printData, MPrintFormat printFormat) {
		this(printData, printFormat, null, null);
	}
	
	public PrintDataExcelExporter(PrintData printData, MPrintFormat printFormat, Map<MPrintFormatItem, PrintData> childPrintFormatDetails, Boolean[] colSuppressRepeats) {
		this(printData, printFormat, childPrintFormatDetails, colSuppressRepeats, null);
	}
	
	public PrintDataExcelExporter(PrintData printData, MPrintFormat printFormat, Map<MPrintFormatItem, PrintData> childPrintFormatDetails, Boolean[] colSuppressRepeats, MQuery query) {
		super();
		this.m_printData = printData;
		this.m_printFormat = printFormat;
		this.childPrintFormatDetails = childPrintFormatDetails;
		this.colSuppressRepeats = colSuppressRepeats;
		this.m_query = query;
	}

	@Override
	public int getColumnCount() {
		return columns.size();
	}

	private PrintDataElement getPDE(int row, int col) {
		if (m_printData.getRowIndex() != row)
			m_printData.setRowIndex(row);
		//
		MPrintFormatItem item = (MPrintFormatItem) columns.get(col);
		Object obj = null;

		if (item.isTypeField() || item.isTypePrintFormat() && item.isImageField()) {
			int AD_Column_ID = item.getAD_Column_ID();
			if (AD_Column_ID > 0)
				obj = m_printData.getNode(Integer.valueOf(AD_Column_ID));
		}

		if (obj != null && obj instanceof PrintDataElement) {
			return (PrintDataElement)obj;
		}
		return null;
	}
	@Override
	public int getDisplayType(int row, int col) {
		PrintDataElement pde = getPDE(row, col);
		if (pde != null) {
			return pde.getDisplayType();
		}
		return -1;
		//
	}

	@Override
	public Object getValueAt(int row, int col) {
		PrintDataElement pde = getPDE(row, col);
		Object value = null;
		if (pde == null)
			;
		else if (pde.isDate()) {
			Object o = pde.getValue();
			if (o instanceof Date)
				value = new Timestamp(((Date)o).getTime());
			else
				value = (Timestamp)pde.getValue();
		}
		else if (pde.isNumeric()) {
			Object o = pde.getValue();
			if (o instanceof Number) {
				value = ((Number)o).doubleValue();
			}
		}
		else if (pde.isYesNo()) {
			value = pde.getValue();
		}
		else if (pde.isPKey()) {
			value = pde.getValueAsString();
		}
		else {
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
							PrintDataExcelExporter exp =new PrintDataExcelExporter(printData, mPrintFormat);
							exp.exportToWorkbook(m_workbook, m_lang);
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
	public String getHeaderName(int col) {
		Object colObj = columns.get(col);
		if (colObj instanceof MPrintFormatItem) {
			MPrintFormatItem item = (MPrintFormatItem) colObj;
			return item.getPrintName(getLanguage());
		} else {
			return "";
		}
	}

	@Override
	public int getRowCount() {
		return m_printData.getRowCount();
	}

	@Override
	public boolean isColumnPrinted(int col) {
		if (columns != null && col < columns.size())
			return true;
		else
			return false;
	}

	@Override
	public boolean isPageBreak(int row, int col) {
		PrintDataElement pde = getPDE(row, col);
		return pde != null ? pde.isPageBreak() : false;
	}

	@Override
	protected void setCurrentRow(int row) {
		m_printData.setRowIndex(row);
	}

	protected int getCurrentRow() {
		return m_printData.getRowIndex();
	}

	@Override
	public boolean isFunctionRow() {
		return m_printData.isFunctionRow();
	}

	@Override
	protected void formatPage(HSSFSheet sheet) {
		super.formatPage(sheet);
		MPrintPaper paper = MPrintPaper.get(this.m_printFormat.getAD_PrintPaper_ID());
		//
		// Set paper size:
		short paperSize = -1;
		MediaSizeName mediaSizeName = paper.getMediaSize().getMediaSizeName();
		if (MediaSizeName.NA_LETTER.equals(mediaSizeName)) {
			paperSize = HSSFPrintSetup.LETTER_PAPERSIZE;
		}
		else if (MediaSizeName.NA_LEGAL.equals(mediaSizeName)) {
		  	paperSize = HSSFPrintSetup.LEGAL_PAPERSIZE;
		}
		else if (MediaSizeName.EXECUTIVE.equals(mediaSizeName)) {
			paperSize = HSSFPrintSetup.EXECUTIVE_PAPERSIZE;
		}
		else if (MediaSizeName.ISO_A4.equals(mediaSizeName)) {
			paperSize = HSSFPrintSetup.A4_PAPERSIZE;
		}
		else if (MediaSizeName.ISO_A5.equals(mediaSizeName)) {
			paperSize = HSSFPrintSetup.A5_PAPERSIZE;
		}
		else if (MediaSizeName.NA_NUMBER_10_ENVELOPE.equals(mediaSizeName)) {
			paperSize = HSSFPrintSetup.ENVELOPE_10_PAPERSIZE;
		}
//		else if (MediaSizeName..equals(mediaSizeName)) {
//			paperSize = HSSFPrintSetup.ENVELOPE_DL_PAPERSIZE;
//		}
//		else if (MediaSizeName..equals(mediaSizeName)) {
//			paperSize = HSSFPrintSetup.ENVELOPE_CS_PAPERSIZE;
//		}
		else if (MediaSizeName.MONARCH_ENVELOPE.equals(mediaSizeName)) {
			paperSize = HSSFPrintSetup.ENVELOPE_MONARCH_PAPERSIZE;
		}
		if (paperSize != -1) {
			sheet.getPrintSetup().setPaperSize(paperSize);
		}
		//
		// Set Landscape/Portrait:
		sheet.getPrintSetup().setLandscape(paper.isLandscape());
		//
		// Set Paper Margin:
		sheet.setMargin(HSSFSheet.TopMargin, ((double)paper.getMarginTop()) /72);
		sheet.setMargin(HSSFSheet.RightMargin, ((double)paper.getMarginRight()) / 72);
		sheet.setMargin(HSSFSheet.LeftMargin, ((double)paper.getMarginLeft()) / 72);
		sheet.setMargin(HSSFSheet.BottomMargin, ((double)paper.getMarginBottom()) / 72);
		//
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
	protected void createParameter(HSSFSheet sheet) {
		if (!m_printFormat.isForm()) {
			if (m_query != null && m_query.isActive()) {
				int rows = m_query.getReportProcessQuery() != null ? m_query.getReportProcessQuery().getRestrictionCount() : m_query.getRestrictionCount();
				if (rows > 0) {
					setNoOfParameter(rows);
					setFreezePane(1, rows + 1);
					
					HSSFCellStyle parameterStyle = m_workbook.createCellStyle();
					HSSFFont parameterFont = m_workbook.createFont();
					parameterFont.setItalic(true);
					parameterStyle.setFont(parameterFont);
					
					MQuery query = m_query;
					if (m_query.getReportProcessQuery() != null)
						query = m_query.getReportProcessQuery();
					for (int r = 0; r < query.getRestrictionCount(); r++)
					{
						HSSFRow row = sheet.createRow(r);
						if (r == 0) {
							HSSFCell cell = row.createCell(0);
							HSSFCellStyle style = m_workbook.createCellStyle();
							HSSFFont font = m_workbook.createFont();
							font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
							style.setFont(font);
							cell.setCellStyle(style);
							String value = Util.stripDiacritics(Msg.getMsg(getCtx(), "Parameter") + ":");
							cell.setCellValue(new HSSFRichTextString(value));
						}
						HSSFCell cell = row.createCell(1);
						cell.setCellStyle(parameterStyle);
						String value = Util.stripDiacritics(query.getInfoName(r));
						cell.setCellValue(new HSSFRichTextString(value));
						
						cell = row.createCell(2);
						cell.setCellStyle(parameterStyle);
						value = Util.stripDiacritics(query.getInfoOperator(r));
						cell.setCellValue(new HSSFRichTextString(value));
						
						cell = row.createCell(3);
						cell.setCellStyle(parameterStyle);
						value = Util.stripDiacritics(query.getInfoDisplayAll(r));
						cell.setCellValue(new HSSFRichTextString(value));
					}
				}
			}
		}
	}
}
