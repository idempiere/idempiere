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
package org.idempiere.print.renderer;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.print.ReportEngine;
import org.compiere.print.layout.InstanceAttributeColumn;
import org.compiere.print.layout.InstanceAttributeData;
import org.compiere.print.layout.LayoutEngine;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Language;

/**
 * Abstract base class for renderer that output delimited text content.
 * @param <C> Renderer configuration type
 */
public abstract class DelimitedReportRenderer<C extends DelimitedReportRendererConfiguration> implements IReportRenderer<C> {

	private static final CLogger log = CLogger.getCLogger(DelimitedReportRenderer.class);
	
	public DelimitedReportRenderer() {
	}

	@Override
	public void renderReport(ReportEngine reportEngine, C configuration) {
		try {
			Writer fw = null;
			if (configuration.getOutputFile() != null)
				fw = new OutputStreamWriter(new FileOutputStream(configuration.getOutputFile(), false), Ini.getCharset());
			else 
				fw = configuration.getOutputWriter();
			createdDelimitedOutput(reportEngine, fw, configuration.getDelimiter(), configuration.getLanguage());
		}
		catch (FileNotFoundException fnfe) {
			log.log(Level.SEVERE, "(f) - " + fnfe.toString());
		}
		catch (Exception e) {
			log.log(Level.SEVERE, "(f)", e);
		}		
	}

	@Override
	public boolean isBinary() {
		return false;
	}

	/**
	 * 	Write delimited text to writer
	 * 	@param writer writer
	 *  @param delimiter delimiter, e.g. comma, tab
	 *  @param language translation language
	 * 	@return true if success
	 */
	private boolean createdDelimitedOutput (ReportEngine reportEngine, Writer writer, char delimiter, Language language)
	{
		MPrintFormat printFormat = reportEngine.getPrintFormat();
		PrintData printData = reportEngine.getPrintData();
		LayoutEngine layout = reportEngine.getLayout();
		if (delimiter == 0)
			delimiter = '\t';
		try
		{
			//collect columns to be printed
			ArrayList<Object> columns = new ArrayList<>();
			List<InstanceAttributeData> asiElements = new ArrayList<>();
			int columnCount = 0;
			for (int col = 0; col < printFormat.getItemCount(); col++)
			{
				MPrintFormatItem item = printFormat.getItem(col);
				if (item.isPrinted())
				{
					if (item.isTypeField() && item.isPrintInstanceAttributes())
					{
						InstanceAttributeData asiElement = new InstanceAttributeData(item, columnCount);
						asiElement.readAttributesData(printData);
						asiElements.add(asiElement);						
						continue;
					}
					else 
					{
						columns.add(item);
						columnCount++;
					}
				}
			}
			if (asiElements.size() > 0)
			{
				int columnCreated = 0;
				for(InstanceAttributeData data : asiElements)
				{
					List<InstanceAttributeColumn> instanceColumns = data.getColumns();
					int index = data.getColumnIndex() + columnCreated;
					for(InstanceAttributeColumn c : instanceColumns)
					{
						columns.add(index, c);
						index++;
						columnCreated++;
					}
				}
			}
						
			Boolean [] colSuppressRepeats = layout == null || layout.colSuppressRepeats == null? LayoutEngine.getColSuppressRepeats(printFormat):layout.colSuppressRepeats;
			Object [] preValues = null;
			if (colSuppressRepeats != null){
				preValues = new Object [colSuppressRepeats.length];
			}
			int printColIndex = -1;
			//	for all rows (-1 = header row)
			for (int row = -1; row < printData.getRowCount(); row++)
			{
				printColIndex = -1;
				StringBuffer sb = new StringBuffer();
				if (row != -1)
					printData.setRowIndex(row);

				//	for all columns
				boolean first = true;	//	first column to print
				for (int col = 0; col < columns.size(); col++)
				{
					Object colObj = columns.get(col);
					MPrintFormatItem item = null;
					InstanceAttributeColumn iaColumn = null;
					if (colObj instanceof InstanceAttributeColumn)
					{
						iaColumn = (InstanceAttributeColumn) colObj;
						item = iaColumn.getPrintFormatItem();
					} 
					else if (colObj instanceof MPrintFormatItem)
					{
						item = (MPrintFormatItem)colObj;
					}
					if (item != null)
					{
						//	column delimiter (comma or tab)
						if (first)
							first = false;
						else
							sb.append(delimiter);
						//	header row
						if (row == -1)
						{
							String printName = iaColumn != null ? iaColumn.getName() : item.getPrintName(language);
							addDelimitedValue (sb, delimiter, printName);
						}
						else
						{
							printColIndex++;
							Object obj = iaColumn != null ? iaColumn.getPrintDataElement(row) : printData.getNodeByPrintFormatItemId(item.getAD_PrintFormatItem_ID());
							String data = "";
							if (obj == null || !ReportEngine.isDisplayPFItem(printData, item)){
								if (colSuppressRepeats != null && colSuppressRepeats[printColIndex]){
									preValues[printColIndex] = null;
								}
							}
							else if (obj instanceof PrintDataElement)
							{
								PrintDataElement pde = (PrintDataElement)obj;
								if (pde.isPKey())
									data = pde.getValueAsString();
								else
									data = pde.getValueDisplay(language);	//	formatted
								
								if (colSuppressRepeats != null && colSuppressRepeats[printColIndex]){
									if (data.equals(preValues[printColIndex])){
										continue;
									}else{
										preValues[printColIndex] = data;
									}
								}
							}
							else if (obj instanceof PrintData)
							{
							}
							else
								log.log(Level.SEVERE, "Element not PrintData(Element) " + obj.getClass());
							addDelimitedValue (sb, delimiter, data);
						}
					}	//	printed
				}	//	for all columns
				writer.write(sb.toString());
				writer.write(Env.NL);
			}	//	for all rows
			//
			writer.flush();			
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(w)", e);
			return false;
		}
		finally
		{
			try
			{
				writer.close();
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, "(w) - close", e);
			}
		}
		return true;
	}	//	createCSV
	
	/**
	 * 	Add content to delimited string.
	 *  Encapsulate/mask content in " if required
	 * 	@param sb StringBuffer to add to
	 * 	@param delimiter delimiter
	 * 	@param content column value
	 */
	private void addDelimitedValue (StringBuffer sb, char delimiter, String content)
	{
		//	nothing to add
		if (content == null || content.length() == 0)
			return;
		//
		boolean needMask = false;
		StringBuilder buff = new StringBuilder();
		char chars[] = content.toCharArray();
		for (int i = 0; i < chars.length; i++)
		{
			char c = chars[i];
			if (c == '"')
			{
				needMask = true;
				buff.append(c);		//	repeat twice
			}	//	mask if any control character
			else if (!needMask && (c == delimiter || !Character.isLetterOrDigit(c)))
				needMask = true;
			buff.append(c);
		}

		//	Optionally mask value
		if (needMask)
			sb.append('"').append(buff).append('"');
		else
			sb.append(buff);
	}	
}
