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

import java.awt.Color;
import java.awt.Font;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.logging.Level;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;

import org.adempiere.base.Core;
import org.adempiere.exceptions.AdempiereException;
import org.apache.ecs.MultiPartElement;
import org.apache.ecs.XhtmlDocument;
import org.apache.ecs.xhtml.*;
import org.compiere.model.MAttachment;
import org.compiere.model.MColumn;
import org.compiere.model.MImage;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MStyle;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_StyleLine;
import org.compiere.print.IHTMLExtension;
import org.compiere.print.MPrintColor;
import org.compiere.print.MPrintFont;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.MPrintTableFormat;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.print.ReportEngine;
import org.compiere.print.layout.InstanceAttributeColumn;
import org.compiere.print.layout.InstanceAttributeData;
import org.compiere.print.layout.LayoutEngine;
import org.compiere.print.layout.PrintDataEvaluatee;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluator;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.osgi.service.component.annotations.Component;

import com.google.common.io.ByteStreams;
import com.google.common.net.MediaType;
import com.googlecode.htmlcompressor.compressor.HtmlCompressor;

/**
 * HTML content renderer service for report engine
 */
@Component(service = IReportRenderer.class, immediate = true)
public class HTMLReportRenderer implements IReportRenderer<HTMLReportRendererConfiguration> {

	private static final CLogger log = CLogger.getCLogger(HTMLReportRenderer.class);
	
	public HTMLReportRenderer() {
	}

	@Override
	public String getId() {
		return HTMLReportRendererConfiguration.ID;
	}

	@Override
	public String getName() {
		return Msg.getMsg(Env.getCtx(), "FileHTML");
	}

	@Override
	public String getContentType() {
		return MediaType.HTML_UTF_8.toString();
	}

	@Override
	public String getFileExtension() {
		return HTMLReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public void renderReport(ReportEngine reportEngine, HTMLReportRendererConfiguration configuration) {		
		try
		{
			Language lang = configuration.getLanguage();
			if (lang == null)
				lang = Language.getLoginLanguage();
			Writer fw = null;
			if (configuration.getOutputFile() != null)
				fw = new OutputStreamWriter(new FileOutputStream(configuration.getOutputFile(), false), Ini.getCharset());
			else 
				fw = configuration.getOutputWriter();
			createHTML (reportEngine, new BufferedWriter(fw), configuration.isOnlyTable(), lang, configuration.getExtension(), configuration.isExport());
		}
		catch (FileNotFoundException fnfe)
		{
			log.log(Level.SEVERE, "(f) - " + fnfe.toString());
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(f)", e);
			throw new AdempiereException(e);
		}
	}

	@Override
	public boolean isBinary() {
		return false;
	}

	/**
	 * 	Write HTML to writer
	 *  @param reportEngine 
	 * 	@param writer writer
	 *  @param onlyTable if false create complete HTML document
	 *  @param language optional language - if null numbers/dates are not formatted
	 *  @param extension optional extension for html output
	 *  @param isExport when isExport = true will don't embed resource dependent zk framework
	 */
	private void createHTML (ReportEngine reportEngine, Writer writer, boolean onlyTable, Language language, IHTMLExtension extension, boolean isExport)
	{
		MPrintFormat printFormat = reportEngine.getPrintFormat();
		PrintData printData = reportEngine.getPrintData();
		MQuery reportEngineQuery = reportEngine.getQuery();
		LayoutEngine layout = reportEngine.getLayout();
		Map<CSSInfo, List<ColumnInfo>> mapCssInfo = new HashMap<CSSInfo, List<ColumnInfo>>();
		try
		{
			//collect column to print
			List<Object> columns = new ArrayList<>();
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
			
			String cssPrefix = extension != null ? extension.getClassPrefix() : null;
			if (cssPrefix != null && cssPrefix.trim().length() == 0)
				cssPrefix = null;
			
			table parameterTable = null;
			if (!printFormat.isForm()) {
				if (reportEngineQuery != null && reportEngineQuery.isActive()) {
					int rows = reportEngineQuery.getReportProcessQuery() != null ? reportEngineQuery.getReportProcessQuery().getRestrictionCount() : reportEngineQuery.getRestrictionCount();
					if (rows > 0) {
						parameterTable = new table();
						if (cssPrefix != null)
							parameterTable.setClass(cssPrefix + "-parameter-table");
						else
							parameterTable.setClass("parameter-table");
						parameterTable.setNeedClosingTag(false);
					}
				}
			}
			
			table table = new table();
			if (cssPrefix != null)
				table.setClass(cssPrefix + "-table");
			//
			//
			table.setNeedClosingTag(false);
			PrintWriter w = new PrintWriter(writer);
			XhtmlDocument doc = null;
			boolean minify = MSysConfig.getBooleanValue(MSysConfig.HTML_REPORT_MINIFY, true, Env.getAD_Client_ID(Env.getCtx()));
						
			if (onlyTable)
				w.print(compress(table.toString(), minify));
			else
			{
				doc = new XhtmlDocument();
				doc.getHtml().setNeedClosingTag(false);
				doc.getBody().setNeedClosingTag(false);
				doc.appendHead("<meta charset=\"UTF-8\" />");
				
				if (extension != null && !Util.isEmpty(extension.getWebFontLinks(), true))
				{
					doc.appendHead(extension.getWebFontLinks());
				}

				if (extension != null && extension.getStyleURL() != null)
				{
					// maybe cache style content with key is path
					String pathStyleFile = extension.getFullPathStyle(); // creates a temp file - delete below
					Path path = Paths.get(pathStyleFile);
				    List<String> styleLines = Files.readAllLines(path, Ini.getCharset());
				    Files.delete(path); // delete temp file
				    StringBuilder styleBuild = new StringBuilder();
				    for (String styleLine : styleLines){
				    	styleBuild.append(styleLine); //.append("\n");
				    }
				    appendInlineCss (doc, styleBuild);
				}
				if (extension != null && extension.getScriptURL() != null && !isExport)
				{
					script jslink = new script();
					jslink.setLanguage("javascript");
					jslink.setSrc(extension.getScriptURL());
					doc.appendHead(jslink);
				}
				
				if (extension != null && !isExport){
					extension.setWebAttribute(doc.getBody());
				}				
			}
			
			if (doc != null)
			{
				MPrintFormatItem item = null;
				int printColIndex = -1;
				for(int col = 0; col < columns.size(); col++)
				{
					Object colobj = columns.get(col);
					if (colobj instanceof MPrintFormatItem)
						item = (MPrintFormatItem) colobj;
					else if (colobj instanceof InstanceAttributeColumn)
						item = ((InstanceAttributeColumn) colobj).getPrintFormatItem();
					if(item != null)
					{
						if (item.isNextLine() && item.getBelowColumn() >= 1)
							continue;
						printColIndex++;
						addCssInfo(printFormat, item, printColIndex, mapCssInfo);
					}
				}//IDEMPIERE-4113
				appendInlineCss(doc, mapCssInfo);
				
				StringBuilder styleBuild = new StringBuilder();
				MPrintTableFormat tf = printFormat.getTableFormat();
				CSSInfo cssInfo = new CSSInfo(tf.getPageHeader_Font(), tf.getPageHeaderFG_Color());
				if (cssPrefix != null) {
					if (parameterTable != null)
						styleBuild.append("."+cssPrefix + "-parameter-table th").append(cssInfo.getCssRule());						
					styleBuild.append("."+cssPrefix + "-table th").append(cssInfo.getCssRule());
				}
				else {
					if (parameterTable != null)						
						styleBuild.append("parameter-table th").append(cssInfo.getCssRule());
					styleBuild.append("table th").append(cssInfo.getCssRule());
				}
				
				cssInfo = new CSSInfo(tf.getParameter_Font(), tf.getParameter_Color());
				styleBuild.append(".tr-parameter td").append(cssInfo.getCssRule());
				
				cssInfo = new CSSInfo(tf.getFunct_Font(), tf.getFunctFG_Color());
				styleBuild.append(".tr-function td").append(cssInfo.getCssRule());
				
				MPrintFont printFont = MPrintFont.get(printFormat.getAD_PrintFont_ID());
				Font base = printFont.getFont();
				Font newFont = new Font(base.getName(), Font.PLAIN, base.getSize()-1);
				cssInfo = new CSSInfo(newFont, null);
				styleBuild.append(".tr-level-1 td").append(cssInfo.getCssRule());
				
				newFont = new Font(base.getName(), Font.PLAIN, base.getSize()-2);
				cssInfo = new CSSInfo(newFont, null);
				styleBuild.append(".tr-level-2 td").append(cssInfo.getCssRule());
				
				styleBuild = new StringBuilder(styleBuild.toString().replaceAll(";", "!important;"));
				appendInlineCss (doc, styleBuild);
				
				w.print(compress(doc.toString(), minify));
				
				w.print("<div class='"+cssPrefix+"-flex-container'>");
				String paraWrapId = null;
				if (parameterTable != null) {
					paraWrapId = cssPrefix + "-para-table-wrap";
					w.print("<details id='" + paraWrapId + "' open=true style='cursor:pointer'>");
					w.print("<summary style='cursor:pointer'>"+Msg.getMsg(Env.getCtx(), "Parameter")+"</summary>");
					w.print(compress(parameterTable.toString(), minify));
					
					tr tr = new tr();
					tr.setClass("tr-parameter");
					
					MQuery query = reportEngineQuery;
					if (reportEngineQuery.getReportProcessQuery() != null)
						query = reportEngineQuery.getReportProcessQuery();
					for (int r = 0; r < query.getRestrictionCount(); r++)
					{
						if (r > 0) {
							tr = new tr();
							tr.setClass("tr-parameter");
						}
						
						td td = new td();
						tr.addElement(td);
						td.addElement(query.getInfoName(r));
						
						td = new td();
						tr.addElement(td);
						td.addElement(query.getInfoOperator(r));
						
						td = new td();
						tr.addElement(td);
						td.addElement(query.getInfoDisplayAll(r));
						
						w.print(compress(tr.toString(), minify));
					}
										
					w.print("</table>");
					w.print("</details>");
				}
				
				StringBuilder tableWrapDiv = new StringBuilder();
				tableWrapDiv.append("<div class='").append(cssPrefix).append("-table-wrap' ");
				if (paraWrapId != null) {
					String paraWrapGet = "document.getElementById(\""+paraWrapId+"\")";
					tableWrapDiv.append("onscroll='setTimeout(() => {if (this.scrollTop > 0) ")
						.append(" if(").append(paraWrapGet).append(".open) ")
						.append(paraWrapGet).append(".open=false;}, 100)'");
				}
				tableWrapDiv.append(" >");
				
				w.print(compress(tableWrapDiv.toString(), minify));
				w.print(compress(table.toString(), minify));
			}
			
			thead thead = new thead();
			tbody tbody = new tbody();
			tbody.setNeedClosingTag(false);
			
			Boolean [] colSuppressRepeats = layout == null || layout.colSuppressRepeats == null? LayoutEngine.getColSuppressRepeats(printFormat):layout.colSuppressRepeats;
			Object [] preValues = null;
			if (colSuppressRepeats != null){
				preValues = new Object [colSuppressRepeats.length];
			}

			int printColIndex = -1;
			HashMap<Integer, th> suppressMap = new HashMap<>();
			
			//	for all rows (-1 = header row)
			for (int row = -1; row < printData.getRowCount(); row++)
			{
				//list of next line + below column items List<below column:column>
				List<Map<Integer, Integer>> belowColumnMap = new ArrayList<>();
				//print column index:td
				Map<Integer, td> tdMap = new HashMap<>();
				tr tr = new tr();
				if (row != -1)
				{
					printData.setRowIndex(row);					
					if (extension != null && !isExport)
					{
						extension.extendRowElement(tr, printData);
					}
					if (printData.isFunctionRow()) {
						tr.setClass(cssPrefix + "-functionrow");
					} else if ( row < printData.getRowCount() && printData.isFunctionRow(row+1)) {
						tr.setClass(cssPrefix + "-lastgrouprow");
					}
				} else {
					// add row to table header
					thead.addElement(tr);
				}
				
				printColIndex = -1;
				//	for all columns
				for (int col = 0; col < columns.size(); col++)
				{
					Object colObj = columns.get(col);
					MPrintFormatItem item = null;
					InstanceAttributeColumn instanceAttributeColumn = null;
					if (colObj instanceof MPrintFormatItem)
					{
						item = (MPrintFormatItem) colObj;
					}
					else if (colObj instanceof InstanceAttributeColumn)
					{
						instanceAttributeColumn = (InstanceAttributeColumn) colObj;
						item = instanceAttributeColumn.getPrintFormatItem();
					}
					if (item != null)
					{
						if (item.isNextLine() && item.getBelowColumn() >= 1)
						{
							if (row != -1)
							{
								//adjust to zero base
								int belowColumn = item.getBelowColumn()-1;
								if (belowColumnMap.isEmpty())
									belowColumnMap.add(new HashMap<>());
								boolean added = false;
								for(Map<Integer, Integer> map : belowColumnMap)
								{
									if (!map.containsKey(belowColumn))
									{
										map.put(belowColumn, col);
										added = true;
										break;
									}
								}
								if (!added)
								{
									Map<Integer, Integer> map = new HashMap<>();
									map.put(belowColumn, col);
									belowColumnMap.add(map);
								}
							}
							continue;
						}
						printColIndex++;
						//	header row
						if (row == -1)
						{
							th th = new th();
							tr.addElement(th);
							String columnHeader = instanceAttributeColumn != null ? instanceAttributeColumn.getName() : item.getPrintName(language);
							th.addElement(Util.maskHTML(columnHeader));
							if (cssPrefix != null && instanceAttributeColumn == null) 
							{
								MColumn column = MColumn.get(Env.getCtx(), item.getAD_Column_ID());
								if (column != null && column.getAD_Column_ID() > 0)
								{
									if (DisplayType.isNumeric(column.getAD_Reference_ID()))
									{
										th.setClass(cssPrefix + "-number");
									}
								}
							}
							if (item.isSuppressNull()) 
							{
								suppressMap.put(printColIndex, th);
								th.setID("report-th-"+printColIndex);
							}
						}
						else 
						{
							td td = new td();
							tr.addElement(td);
							tdMap.put(printColIndex, td);
							printColumn(reportEngine, language, extension, isExport, td, item, instanceAttributeColumn, row, printData,
									colSuppressRepeats, printColIndex, preValues, suppressMap, cssPrefix);
						}
					}	//	printed
				}	//	for all columns
				
				/* output table header */
				if (row == -1){
					w.print(compress(thead.toString(), minify));
					// output open of tbody
					w.print(compress(tbody.toString(), minify));
				}
				
				//render next line+below column items
				if (!belowColumnMap.isEmpty())
				{
					for(Map<Integer, Integer> map : belowColumnMap)
					{
						printColIndex = -1;
						for (int col = 0; col < columns.size(); col++) {
							if (map.containsValue(col))
								continue;
							printColIndex++;
							if (!map.containsKey(printColIndex)) {
								continue;
							}
							int mapTo = map.get(printColIndex);
							Object colObj = columns.get(mapTo);
							MPrintFormatItem item = null;
							InstanceAttributeColumn instanceAttributeColumn = null;
							if (colObj instanceof MPrintFormatItem) {
								item = (MPrintFormatItem) colObj;
							} else if (colObj instanceof InstanceAttributeColumn) {
								instanceAttributeColumn = (InstanceAttributeColumn) colObj;
								item = instanceAttributeColumn.getPrintFormatItem();
							}
							if (item != null) {
								Object obj = instanceAttributeColumn != null ? instanceAttributeColumn.getPrintDataElement(row)
										: printData.getNodeByPrintFormatItemId(item.getAD_PrintFormatItem_ID());
								if (obj == null || !ReportEngine.isDisplayPFItem(printData, item)){
									continue;
								} else if (obj instanceof PrintDataElement pde) {
									String value = pde.getValueDisplay(language);
									if (Util.isEmpty(value, true))
										continue;
								} else {
									continue;
								}
								td td = tdMap.get(printColIndex);
								div div = new div();
								td.addElement(div);
								printColumn(reportEngine, language, extension, isExport, div, item, instanceAttributeColumn, row, printData,
										colSuppressRepeats, printColIndex, preValues, suppressMap, cssPrefix);
								div.setClass("");
							}
						}
					}
				}

				// output row by row
				if (row != -1)						
					w.print(compress(tr.toString(), minify));
			}	//	for all rows
			
			w.print("</tbody>");
			w.print("</table>");
			if (suppressMap.size() > 0) 
			{
				StringBuilder st = new StringBuilder();
				for(th t : suppressMap.values()) 
				{
					if (st.length() > 0)
						st.append(",");
					st.append("#").append(t.getAttribute("id"));
				}
				st.append(" {\n\t\tdisplay:none;\n\t}");
				style styleTag = new style();
				styleTag.addElement(st.toString());
				w.print(compress(styleTag.toString(), minify));
			}
			if (!onlyTable)
			{
				w.print("</div>");
				w.print("</div>");
				w.print("</body>");
				w.print("</html>");
			}
			w.flush();
			w.close();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(w)", e);
			throw new AdempiereException(e);
		}
	}	//	createHTML

	/**
	 * Create content for column
	 * @param reportEngine
	 * @param language
	 * @param extension
	 * @param isExport
	 * @param td column parent element
	 * @param item
	 * @param instanceAttributeColumn
	 * @param row
	 * @param printData
	 * @param colSuppressRepeats
	 * @param printColIndex
	 * @param preValues
	 * @param suppressMap
	 * @param cssPrefix
	 */
	private static void printColumn(ReportEngine reportEngine, Language language, IHTMLExtension extension, boolean isExport, MultiPartElement td, 
									   MPrintFormatItem item, InstanceAttributeColumn instanceAttributeColumn, int row, PrintData printData, 
									   Boolean[] colSuppressRepeats, int printColIndex, Object[] preValues, HashMap<Integer, th> suppressMap, String cssPrefix) {
		MStyle style = item.getAD_FieldStyle_ID() > 0 ? MStyle.get(Env.getCtx(), item.getAD_FieldStyle_ID()) : null;
		Object obj = instanceAttributeColumn != null ? instanceAttributeColumn.getPrintDataElement(row)
				: printData.getNodeByPrintFormatItemId(item.getAD_PrintFormatItem_ID());
		if (obj == null || !ReportEngine.isDisplayPFItem(printData, item)){
			td.addElementToRegistry("&nbsp;");
			if (colSuppressRepeats != null && colSuppressRepeats[printColIndex]){
				preValues[printColIndex] = null;
			}
			if (item.isSuppressNull() && obj != null && suppressMap.containsKey(printColIndex))
				suppressMap.remove(printColIndex);
		}
		else if (obj instanceof PrintDataElement)
		{
			PrintDataElement pde = (PrintDataElement) obj;
			String value = pde.getValueDisplay(language);	//	formatted

			if (colSuppressRepeats != null && colSuppressRepeats[printColIndex]){
				if (value.equals(preValues[printColIndex])){
					td.addElementToRegistry("&nbsp;");
					return;
				}else{
					preValues[printColIndex] = value;
				}
			}

			if (item.isSuppressNull() && obj != null && suppressMap.containsKey(printColIndex))
				suppressMap.remove(printColIndex);
			
			if (item.isTypeImage())
			{
				printImageColumn(td, item, pde);
			}
			else if (pde.getColumnName().endsWith("_ID") && extension != null && !isExport)
			{
				boolean isZoom = false;
				if (item.getColumnName().equals("Record_ID")) {
					Object tablePDE = printData.getNode("AD_Table_ID");
					if (tablePDE != null && tablePDE instanceof PrintDataElement) {
						int tableID = -1;
						try {
							tableID = Integer.parseInt(((PrintDataElement)tablePDE).getValueAsString());
						} catch (Exception e) {
							tableID = -1;
						}
						if (tableID > 0) {
							MTable mTable = MTable.get(Env.getCtx(), tableID);
							String tableName = mTable.getTableName();
							
							value = reportEngine.getIdentifier(mTable, tableName, Integer.parseInt(value));
							
							String foreignColumnName = tableName + "_ID";
							pde.setForeignColumnName(foreignColumnName);
							isZoom = true;
						}
					}
				} else {
					isZoom = true;
				}
				if (isZoom) {
					// check permission on the zoomed window
					MTable mTable = MTable.get(Env.getCtx(), pde.getForeignColumnName().substring(0, pde.getForeignColumnName().length()-3));
					int Record_ID = -1;
					try {
						Record_ID = Integer.parseInt(pde.getValueAsString());
					} catch (Exception e) {
						Record_ID = -1;
					}
					Boolean canAccess = null;
					if (Record_ID >= 0 && mTable != null) {
						int AD_Window_ID = Env.getZoomWindowID(mTable.get_ID(), Record_ID);
						canAccess = MRole.getDefault().getWindowAccess(AD_Window_ID);
					}
					if (canAccess == null) {
						isZoom = false;
					}
				}
				if (isZoom) {
					//link for column
					a href = new a("javascript:void(0)");
					href.setID(pde.getColumnName() + "_" + row + "_a");									
					td.addElementToRegistry(href);
					href.addElement(Util.maskHTML(value));
					if (cssPrefix != null)
						href.setClass(cssPrefix + "-href");
					// Set Style
					if(style != null && style.isWrapWithSpan())
						setStyle(printData, href, style);
					else
						setStyle(printData, td, style);
					extension.extendIDColumn(row, td, href, pde);
				} else {
					// Set Style
					if(style != null && style.isWrapWithSpan()) {
						span span = new span();
						setStyle(printData, span, style);
						span.addElement(Util.maskHTML(value));
						td.addElementToRegistry(span);
					}
					else {
						setStyle(printData, td, style);
						td.addElementToRegistry(Util.maskHTML(value));
					}
				}

			}
			else
			{
				// Set Style
				if(style != null && style.isWrapWithSpan()) {
					span span = new span();
					setStyle(printData, span, style);
					span.addElement(Util.maskHTML(value));
					td.addElementToRegistry(span);
				}
				else {
					setStyle(printData, td, style);
					td.addElementToRegistry(Util.maskHTML(value));
				}
			}
			if (cssPrefix != null)
			{
				if (item.isTypeImage())
					td.setClass(cssPrefix + "-image");
				else if (DisplayType.isNumeric(pde.getDisplayType()))
					td.setClass(cssPrefix + "-number");
				else if (DisplayType.isDate(pde.getDisplayType()))
					td.setClass(cssPrefix + "-date");
				else
					td.setClass(cssPrefix + "-text");
			}											
		}
		else if (obj instanceof PrintData)
		{
			//	ignore contained Data
		}
		else
			log.log(Level.SEVERE, "Element not PrintData(Element) " + obj.getClass());
	}

	private static void printImageColumn(MultiPartElement td, MPrintFormatItem item, PrintDataElement pde) {
		if (item.isImageField())
		{
			Object data = pde.getValue();
			if (data != null)
			{
				if (pde.getDisplayType() == DisplayType.Image)
				{
					if (data instanceof Number number)
					{
						int id = number.intValue();
						MImage image = MImage.get(id);
						byte[] imageData = image.getBinaryData();
						createDataURLImageElement(td, imageData, item);
					}
				}
				else 
				{
					String url = data.toString();
					// not a URL - may be a resource
					if (url.indexOf("://") == -1)
					{
						ClassLoader cl = HTMLReportRenderer.class.getClassLoader();
						URL resource = cl.getResource(url);
						if (resource != null)
							createDataURLImageElement(td, resource, item);
						resource = Core.getResourceFinder().getResource(url);
						if (resource != null)
							createDataURLImageElement(td, resource, item);
					}
					else
					{
						img image = new img(url);
						td.addElementToRegistry(image);
						applyHeightAndWidth(item, image);
					}
				}
			}
		}
		else if (item.isImageIsAttached())
		{
			MAttachment attachment = MAttachment.get(Env.getCtx(), MPrintFormatItem.Table_ID, item.get_ID(), null, null);
			if (attachment != null)
			{
				if (attachment.getEntryCount() != 1)
				{
					log.log(Level.WARNING, "Need just 1 Attachment Entry = " + attachment.getEntryCount());
					return;
				}
				byte[] imageData = attachment.getEntryData(0);
				createDataURLImageElement(td, imageData, item);
			}
		}
		else if (!Util.isEmpty(item.getImageURL(), true))
		{
			img image = new img(item.getImageURL());
			td.addElementToRegistry(image);
			applyHeightAndWidth(item, image);
		}
	}

	private static void applyHeightAndWidth(MPrintFormatItem item, img image) {
		StringBuilder style = new StringBuilder();
		if (item.getMaxHeight() > 0) 
			style.append("height:").append(item.getMaxHeight()).append("px;");
		if (item.getMaxWidth() > 0) 
			style.append("width:").append(item.getMaxWidth()).append("px;");
		if (style.length() > 0)
			image.setStyle(style.toString());
	}

	private static void createDataURLImageElement(MultiPartElement td, URL url, MPrintFormatItem item) {
		byte[] imageData = null;
		try {
			imageData = ByteStreams.toByteArray(url.openStream());
			createDataURLImageElement(td, imageData, item);
		} catch (IOException e) {
			log.log(Level.WARNING, e.getLocalizedMessage(), e);
		}		
	}
	
	private static void createDataURLImageElement(MultiPartElement td, byte[] imageData, MPrintFormatItem item) {
		String contentType = null;
		Iterator<ImageReader> readers = null;
		try {
			readers = ImageIO.getImageReaders(ImageIO.createImageInputStream(new ByteArrayInputStream(imageData)));
		} catch (IOException e) {
			log.log(Level.WARNING, e.getLocalizedMessage(), e);
			return;
		}
		while(readers.hasNext()) {
			ImageReader reader = readers.next();
			try {
				contentType = reader.getFormatName();
				if (!Util.isEmpty(contentType))
					break;
			} catch (IOException e) {
			}
		}
		if (contentType != null) {
			StringBuilder builder = new StringBuilder("data:")
					.append(contentType)
					.append(";base64,");
			builder.append(Base64.getEncoder().encodeToString(imageData));
			img image = new img(builder.toString());
			td.addElementToRegistry(image);
			applyHeightAndWidth(item, image);
		}
	}

	/**
	 * Compress html content
	 * @param src
	 * @param minify
	 * @return compressed content
	 */
	public static String compress(String src, boolean minify) {		
		if(minify) {
			HtmlCompressor compressor = new HtmlCompressor();
		    compressor.setEnabled(true);
		    compressor.setCompressCss(true);
		    compressor.setCompressJavaScript(true);
		    compressor.setRemoveComments(true);
		    compressor.setRemoveMultiSpaces(true);
		    compressor.setRemoveIntertagSpaces(true);
//		    compressor.setGenerateStatistics(false);
//		    compressor.setRemoveQuotes(false);
//		    compressor.setSimpleDoctype(false);
//		    compressor.setRemoveScriptAttributes(false);
//		    compressor.setRemoveStyleAttributes(false);
//		    compressor.setRemoveLinkAttributes(false);
//		    compressor.setRemoveFormAttributes(false);
//		    compressor.setRemoveInputAttributes(false);
//		    compressor.setSimpleBooleanAttributes(false);
//		    compressor.setRemoveJavaScriptProtocol(false);
//		    compressor.setRemoveHttpProtocol(false);
//		    compressor.setRemoveHttpsProtocol(false);
//		    compressor.setPreserveLineBreaks(false);
		    
		    return compressor.compress(src);
		}
		else {
			return src;
		}
	}
		
	/**
	 * Append css for table from mapCssInfo
	 * @param doc
	 */
	public static void appendInlineCss (XhtmlDocument doc, Map<CSSInfo, List<ColumnInfo>> mapCssInfo){
		StringBuilder buildCssInline = new StringBuilder();
		
		// each entry is a css class
		for (Entry<CSSInfo, List<ColumnInfo>> cssClassInfo : mapCssInfo.entrySet()){
			// each column is a css name.
			for (int i = 0; i < cssClassInfo.getValue().size(); i++){
				if (i > 0)
					buildCssInline.append (",");
				
				buildCssInline.append(cssClassInfo.getValue().get(i).getCssSelector());
			}
			
			buildCssInline.append(cssClassInfo.getKey().getCssRule());
			buildCssInline.append("\n");
		}
		
		appendInlineCss (doc, buildCssInline);
	}
	
	/**
	 * Append inline css content
	 * @param doc
	 * @param buildCssInline
	 */
	public static void appendInlineCss (XhtmlDocument doc, StringBuilder buildCssInline){
		if (buildCssInline.length() > 0){
			buildCssInline.insert(0, "<style>");
			buildCssInline.append("</style>");
			doc.appendHead(buildCssInline.toString());
		}
	}
	
	/**
	 * Create css info from formatItem, add all column has same CSSInfo in a list
	 * @param formatItem
	 * @param index
	 */
	public static void addCssInfo (MPrintFormat printFormat, MPrintFormatItem formatItem, int index, Map<CSSInfo, List<ColumnInfo>> mapCssInfo){
		CSSInfo cadidateCss = new CSSInfo(printFormat, formatItem);
		if (mapCssInfo.containsKey(cadidateCss)) {
			mapCssInfo.get(cadidateCss).add(new ColumnInfo(index, formatItem));
		} else {
			List<ColumnInfo> newColumnList = new ArrayList<ColumnInfo>();
			newColumnList.add(new ColumnInfo(index, formatItem));
			mapCssInfo.put(cadidateCss, newColumnList);
		}
	}
	
	/**
	 * Store info for css rule
	 * @author hieplq
	 */
	public static class CSSInfo {
		private Font font;		
		private Color color;
		private String cssStr;
		public CSSInfo (MPrintFormat printFormat, MPrintFormatItem item){
			MPrintFont mPrintFont = null;
			
			if (item.getAD_PrintFont_ID() > 0) 
			{
				mPrintFont = MPrintFont.get(item.getAD_PrintFont_ID());
			}			
			else if (printFormat.getAD_PrintFont_ID() > 0)
			{
				mPrintFont = MPrintFont.get(printFormat.getAD_PrintFont_ID());
			}
			if (mPrintFont != null && mPrintFont.getAD_PrintFont_ID() > 0)
			{
				font = mPrintFont.getFont();				
			}
			
			MPrintColor mPrintColor = null;
			if (item.getAD_PrintColor_ID() > 0) 
			{
				mPrintColor = MPrintColor.get(Env.getCtx(), item.getAD_PrintColor_ID());
			}
			else if (printFormat.getAD_PrintColor_ID() > 0)
			{
				mPrintColor = MPrintColor.get(Env.getCtx(), printFormat.getAD_PrintColor_ID());
			}
			if (mPrintColor != null && mPrintColor.getAD_PrintColor_ID() > 0)
			{
				color = mPrintColor.getColor();
				
			}
		}
		
		public CSSInfo (Font font, Color color) {
			this.font = font;
			this.color = color;
		}
		
		/**
		 * Sum hashCode of color and font
		 */
		@Override
		public int hashCode() {
			return (color == null ? 0 : color.hashCode()) + (font == null ? 0 : font.hashCode());
		}
		
		/**
		 * equal when same color and font
		 */
		@Override
		public boolean equals(Object obj) {
			if (obj == null || !(obj instanceof CSSInfo) || obj.hashCode() != this.hashCode())
				return false;
			
			CSSInfo compareObj = (CSSInfo)obj;
			
			return compareObj (compareObj.color, color) && compareObj (compareObj.font, font);			
		}
		
		/**
		 * Compare two object equal when both is null or equal
		 * @param obj1
		 * @param obj2
		 * @return true if both is null or equal
		 */
		protected boolean compareObj(Object obj1, Object obj2) {
			if (obj1 == null && obj2 != null)
				return false;
			
			if (obj1 == null && obj2 == null){
				return true;
			}
			
			return obj1.equals(obj2);
		}
		
		/**
		 * Append a css rule to a css class
		 * @param cssBuild css class builder
		 * @param ruleName
		 * @param ruleValue
		 */
		protected void addCssRule(StringBuilder cssBuild, String ruleName, String ruleValue) {
			cssBuild.append (ruleName);
			cssBuild.append (":");
			cssBuild.append (ruleValue);
			cssBuild.append (";");
		}
		
		/**
		 * Build css rule
		 * @return css rule
		 */
		public String getCssRule (){
			if (cssStr != null)
				return cssStr;
			
			StringBuilder cssBuild = new StringBuilder();
			cssBuild.append ("{");
			
			if (font != null){
				
				String fontFamily = font.getFamily();
				fontFamily = getCSSFontFamily(fontFamily);
				if (fontFamily != null){
					addCssRule(cssBuild, "font-family", fontFamily);
				}
				
				if (font.isBold())
				{
					addCssRule(cssBuild, "font-weight", "bold");					
				}
				
				if (font.isItalic())
				{
					addCssRule(cssBuild, "font-style", "italic");
				}									
				
				int size = font.getSize();
				addCssRule(cssBuild, "font-size", size + "pt");
			}
			
			if (color != null)
			{
				cssBuild.append("color:rgb(");
				cssBuild.append(color.getRed()); 
				cssBuild.append(",");
				cssBuild.append(color.getGreen());
				cssBuild.append(",");
				cssBuild.append(color.getBlue());
				cssBuild.append(");");
			}
			cssBuild.append ("}");
			cssStr = cssBuild.toString();
			
			return cssStr;
		}
	}
	
	/**
	 * Get CSS font family
	 * @param fontFamily Java font family
	 * @return CSS font family
	 */
	private static String getCSSFontFamily(String fontFamily) {
		if ("Dialog".equals(fontFamily) || "DialogInput".equals(fontFamily) || 	"Monospaced".equals(fontFamily))
		{
			return "monospace";
		} else if ("SansSerif".equals(fontFamily))
		{
			return "sans-serif";
		} else if ("Serif".equals(fontFamily))
		{
			return "serif";
		}
		return null;
	}
	
	/**
	 * Set inline style of element
	 * @param printData
	 * @param element
	 * @param style
	 */
	public static void setStyle(PrintData printData, MultiPartElement element, MStyle style) {
		if (style == null || style.getAD_Style_ID() == 0)
			return;

		X_AD_StyleLine[] lines = style.getStyleLines();
		StringBuilder styleBuilder = new StringBuilder();
		for (X_AD_StyleLine line : lines)
		{
			String inlineStyle = line.getInlineStyle().trim();
			String displayLogic = line.getDisplayLogic();
			if (!Util.isEmpty(displayLogic))
			{
				if (!Evaluator.evaluateLogic(new PrintDataEvaluatee(null, printData), displayLogic))
					continue;
			}
			if (styleBuilder.length() > 0 && !(styleBuilder.charAt(styleBuilder.length()-1)==';'))
				styleBuilder.append("; ");
			styleBuilder.append(inlineStyle);
		}
		if(styleBuilder.length() > 0)
			element.setStyle(styleBuilder.toString());
		//
	}
	
	/**
	 * Store info of report column, <br/>
	 * now just use index to create css selector, but for later maybe will construct a complex class name
	 * @author hieplq
	 *
	 */
	public static class ColumnInfo {
		protected static String CSS_SELECTOR_TEMPLATE = "table > tbody > tr > td:nth-child(%1$s)";
		int index = -1;
		public ColumnInfo (int index, MPrintFormatItem formatItem){
			this.index = index;
			
		}
		
		public String getCssSelector(){
			return String.format(CSS_SELECTOR_TEMPLATE, index + 1);
		}
	}

	@Override
	public Class<HTMLReportRendererConfiguration> getConfigurationType() {
		return HTMLReportRendererConfiguration.class;
	}
}
