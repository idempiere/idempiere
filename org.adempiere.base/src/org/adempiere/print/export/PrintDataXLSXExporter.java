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

import java.sql.Timestamp;
import java.util.Date;

import javax.print.attribute.standard.MediaSizeName;

import org.adempiere.impexp.AbstractXLSXExporter;
import org.apache.poi.hssf.usermodel.HSSFPrintSetup;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.MPrintPaper;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.print.layout.PrintDataEvaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;
/**
 * Export PrintData to Excel (XLSX) file
 * 
 * @author Deepak Pansheriya
 */
public class PrintDataXLSXExporter extends AbstractXLSXExporter
{
	private PrintData		m_printData;
	private MPrintFormat	m_printFormat;

	public PrintDataXLSXExporter(PrintData printData, MPrintFormat printFormat, Boolean[] colSuppressRepeats)
	{
		super();
		this.m_printData = printData;
		this.m_printFormat = printFormat;
		this.colSuppressRepeats = colSuppressRepeats;
	}

	@Override
	public int getColumnCount()
	{
		return m_printFormat.getItemCount();
	}

	private PrintDataElement getPDE(int row, int col)
	{
		if (m_printData.getRowIndex() != row)
			m_printData.setRowIndex(row);
		//
		MPrintFormatItem item = m_printFormat.getItem(col);
		int AD_Column_ID = item.getAD_Column_ID();
		Object obj = null;
		if (AD_Column_ID > 0)
			obj = m_printData.getNode(Integer.valueOf(AD_Column_ID));
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
		return value;
	}

	@Override
	public String getHeaderName(int col)
	{
		return m_printFormat.getItem(col).getPrintName(getLanguage());
	}

	@Override
	public int getRowCount()
	{
		return m_printData.getRowCount();
	}

	@Override
	public boolean isColumnPrinted(int col)
	{
		MPrintFormatItem item = m_printFormat.getItem(col);
		return item.isPrinted();
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
			paperSize = HSSFPrintSetup.LETTER_PAPERSIZE;
		}
		else if (MediaSizeName.NA_LEGAL.equals(mediaSizeName))
		{
			paperSize = HSSFPrintSetup.LEGAL_PAPERSIZE;
		}
		else if (MediaSizeName.EXECUTIVE.equals(mediaSizeName))
		{
			paperSize = HSSFPrintSetup.EXECUTIVE_PAPERSIZE;
		}
		else if (MediaSizeName.ISO_A4.equals(mediaSizeName))
		{
			paperSize = HSSFPrintSetup.A4_PAPERSIZE;
		}
		else if (MediaSizeName.ISO_A5.equals(mediaSizeName))
		{
			paperSize = HSSFPrintSetup.A5_PAPERSIZE;
		}
		else if (MediaSizeName.NA_NUMBER_10_ENVELOPE.equals(mediaSizeName))
		{
			paperSize = HSSFPrintSetup.ENVELOPE_10_PAPERSIZE;
		}
		else if (MediaSizeName.MONARCH_ENVELOPE.equals(mediaSizeName))
		{
			paperSize = HSSFPrintSetup.ENVELOPE_MONARCH_PAPERSIZE;
		}
		if (paperSize != -1)
		{
			sheet.getPrintSetup().setPaperSize(paperSize);
		}

		// Set Landscape/Portrait:
		sheet.getPrintSetup().setLandscape(paper.isLandscape());

		// Set Paper Margin:
		sheet.setMargin(HSSFSheet.TopMargin, ((double) paper.getMarginTop()) / 72);
		sheet.setMargin(HSSFSheet.RightMargin, ((double) paper.getMarginRight()) / 72);
		sheet.setMargin(HSSFSheet.LeftMargin, ((double) paper.getMarginLeft()) / 72);
		sheet.setMargin(HSSFSheet.BottomMargin, ((double) paper.getMarginBottom()) / 72);
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
}
