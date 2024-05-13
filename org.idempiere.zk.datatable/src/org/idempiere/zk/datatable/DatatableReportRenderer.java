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
package org.idempiere.zk.datatable;

import java.awt.Font;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.apache.ecs.XhtmlDocument;
import org.apache.ecs.xhtml.a;
import org.apache.ecs.xhtml.link;
import org.apache.ecs.xhtml.script;
import org.apache.ecs.xhtml.span;
import org.apache.ecs.xhtml.style;
import org.apache.ecs.xhtml.table;
import org.apache.ecs.xhtml.tbody;
import org.apache.ecs.xhtml.td;
import org.apache.ecs.xhtml.th;
import org.apache.ecs.xhtml.thead;
import org.apache.ecs.xhtml.tr;
import org.compiere.model.MColumn;
import org.compiere.model.MElement;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MStyle;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.print.IHTMLExtension;
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
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.print.renderer.HTMLReportRenderer;
import org.idempiere.print.renderer.IReportRenderer;
import org.osgi.service.component.annotations.Component;
import org.zkoss.zk.ui.Executions;

import com.google.common.net.MediaType;

@Component(service = IReportRenderer.class, immediate = true)
public class DatatableReportRenderer implements IReportRenderer<DatatableReportRendererConfiguration> {

	private static final CLogger log = CLogger.getCLogger(DatatableReportRenderer.class);
	private static final String JS_DATA_IDENTIFIER = "JS_DataTable";

	protected enum FunctionTypes {SUM, COUNT, MIN, MAX, AVG, DEVIATION, VARIANCE, GROUP_BY, ORDER_BY};
	
	public DatatableReportRenderer() {
	}

	@Override
	public String getId() {
		return DatatableReportRendererConfiguration.ID;
	}

	@Override
	public String getName() {
		return getId();
	}

	@Override
	public String getContentType() {
		return MediaType.HTML_UTF_8.toString();
	}

	@Override
	public String getFileExtension() {
		return DatatableReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public void renderReport(ReportEngine reportEngine, DatatableReportRendererConfiguration configuration) {
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

	@Override
	public Class<DatatableReportRendererConfiguration> getConfigurationType() {
		return DatatableReportRendererConfiguration.class;
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
		Map<HTMLReportRenderer.CSSInfo, List<HTMLReportRenderer.ColumnInfo>> mapCssInfo = new HashMap<>();
		try
		{
			DataTableOptions dataTableOptions = new DataTableOptions(language.getLanguageCode());
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
			if (cssPrefix != null) {
				table.setClass("cell-border compact hover " + cssPrefix + "-table");				
			}
			table.setID(JS_DATA_IDENTIFIER);			
			//
			table.setNeedClosingTag(false);
			PrintWriter w = new PrintWriter(writer);
			XhtmlDocument doc = null;
			boolean minify = MSysConfig.getBooleanValue(MSysConfig.HTML_REPORT_MINIFY, true, Env.getAD_Client_ID(Env.getCtx()));
						
			if (onlyTable)
			{
				w.print(HTMLReportRenderer.compress(table.toString(), minify));
			}
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
				    HTMLReportRenderer.appendInlineCss (doc, styleBuild);
				}
				if (extension != null && extension.getScriptURL() != null && !isExport)
				{
					script jslink = new script();
					jslink.setLanguage("javascript");
					jslink.setSrc(extension.getScriptURL());
					doc.appendHead(jslink);
				}
				
				appendStyles(doc, isExport);

				appendScripts (doc, isExport);

				//FIXME Better implementation of Javascript
				doc.appendHead("<script type=\"text/javascript\" charset=\"utf8\" src=\"//cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.4/moment.min.js\"></script>");
				doc.appendHead("<script type=\"text/javascript\" charset=\"utf8\" src=\"//cdn.datatables.net/plug-ins/1.10.15/sorting/datetime-moment.js\"></script>");
				
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
						printColIndex++;
						HTMLReportRenderer.addCssInfo(printFormat, item, printColIndex, mapCssInfo);
					}
				}
				HTMLReportRenderer.appendInlineCss(doc, mapCssInfo);
				
				StringBuilder styleBuild = new StringBuilder();
				MPrintTableFormat tf = printFormat.getTableFormat();
				HTMLReportRenderer.CSSInfo cssInfo = new HTMLReportRenderer.CSSInfo(tf.getPageHeader_Font(), tf.getPageHeaderFG_Color());
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
				
				cssInfo = new HTMLReportRenderer.CSSInfo(tf.getParameter_Font(), tf.getParameter_Color());
				styleBuild.append(".tr-parameter td").append(cssInfo.getCssRule());
				
				cssInfo = new HTMLReportRenderer.CSSInfo(tf.getFunct_Font(), tf.getFunctFG_Color());
				styleBuild.append(".tr-function td").append(cssInfo.getCssRule());
				
				MPrintFont printFont = MPrintFont.get(printFormat.getAD_PrintFont_ID());
				Font base = printFont.getFont();
				Font newFont = new Font(base.getName(), Font.PLAIN, base.getSize()-1);
				cssInfo = new HTMLReportRenderer.CSSInfo(newFont, null);
				styleBuild.append(".tr-level-1 td").append(cssInfo.getCssRule());
				
				newFont = new Font(base.getName(), Font.PLAIN, base.getSize()-2);
				cssInfo = new HTMLReportRenderer.CSSInfo(newFont, null);
				styleBuild.append(".tr-level-2 td").append(cssInfo.getCssRule());
				
				styleBuild = new StringBuilder(styleBuild.toString().replaceAll(";", "!important;"));
				HTMLReportRenderer.appendInlineCss (doc, styleBuild);
				
				w.print(doc.toString());
				
				w.print("<div class='"+cssPrefix+"-flex-container'>");
				String paraWrapId = null;
				if (parameterTable != null) {
					paraWrapId = cssPrefix + "-para-table-wrap";
					w.print("<details id='" + paraWrapId + "' open=true style='cursor:pointer'>");
					w.print("<summary style='cursor:pointer'>"+Msg.getMsg(Env.getCtx(), "Parameter")+"</summary>");
					w.print(HTMLReportRenderer.compress(parameterTable.toString(), minify));
					
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
						
						w.print(HTMLReportRenderer.compress(tr.toString(), minify));
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
				
				w.print(HTMLReportRenderer.compress(tableWrapDiv.toString(), minify));
				w.print(HTMLReportRenderer.compress(table.toString(), minify));
			}
			
			w.print("<tfoot>");
			tr tfoot = new tr();

			for (int col = 0; col < printFormat.getItemCount(); col++)
			{
				MPrintFormatItem item = printFormat.getItem(col);
				if (item.isPrinted())
				{
					var printName = item.getPrintName(language);
					if (!Util.isEmpty(printName))
					{
						th th = new th();
						tfoot.addElement(th);
						th.setTagText(printName);
					}
				}
			}
			tfoot.output(w);
			w.print("</tfoot>");
			
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
				tr tr = new tr();
				if (row != -1)
				{
					printData.setRowIndex(row);
					if(printData.isFunctionRow())
						continue;
					if (extension != null && !isExport)
					{
						extension.extendRowElement(tr, printData);
					}
					if (printData.isFunctionRow()) {
						tr.setClass(cssPrefix + "-functionrow");
					} else if ( row < printData.getRowCount() && printData.isFunctionRow(row+1)) {
						tr.setClass(cssPrefix + "-lastgrouprow");
					}
					// add row to table body
					//tbody.addElement(tr);
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
							// Calculate DateTables Options
							if(isDataTableFunctionColumn(item)) {
								if(item.isOrderBy())
									dataTableOptions.addPrintColumnIndex(FunctionTypes.ORDER_BY, item.isDesc() ? dataTableOptions.DESC_OFFSET + printColIndex :  printColIndex);
								if(item.isGroupBy())
									dataTableOptions.addPrintColumnIndex(FunctionTypes.GROUP_BY, printColIndex);
								if(item.isSummarized())
									dataTableOptions.addPrintColumnIndex(FunctionTypes.SUM, printColIndex);
								if(item.isCounted())
									dataTableOptions.addPrintColumnIndex(FunctionTypes.COUNT, printColIndex);
								if(item.isMinCalc())
									dataTableOptions.addPrintColumnIndex(FunctionTypes.MIN, printColIndex);
								if(item.isMaxCalc())
									dataTableOptions.addPrintColumnIndex(FunctionTypes.MAX, printColIndex);
								if(item.isAveraged())
									dataTableOptions.addPrintColumnIndex(FunctionTypes.AVG, printColIndex);
								if(item.isDeviationCalc())
									dataTableOptions.addPrintColumnIndex(FunctionTypes.DEVIATION, printColIndex);
								if(item.isVarianceCalc())
									dataTableOptions.addPrintColumnIndex(FunctionTypes.VARIANCE, printColIndex);
							}

							if(item.getAD_Column_ID() > 0) {
								MColumn column = MColumn.get(item.getAD_Column_ID());
								String description = column.get_Translation(MElement.COLUMNNAME_Description,language.getAD_Language());
								if(!Util.isEmpty(description)) {
									th.addAttribute("title", description);
								}
							}
						}
						else
						{
							td td = new td();
							tr.addElement(td);
							MStyle style = item.getAD_FieldStyle_ID() > 0 ? MStyle.get(Env.getCtx(), item.getAD_FieldStyle_ID()) : null;
							Object obj = instanceAttributeColumn != null ? instanceAttributeColumn.getPrintDataElement(row)
									: printData.getNodeByPrintFormatItemId(item.getAD_PrintFormatItem_ID());
							if (obj == null || !ReportEngine.isDisplayPFItem(printData, item)){
								td.addElement("&nbsp;");
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
										td.addElement("&nbsp;");
										continue;
									}else{
										preValues[printColIndex] = value;
									}
								}

								if (item.isSuppressNull() && obj != null && suppressMap.containsKey(printColIndex))
									suppressMap.remove(printColIndex);
								
								if (pde.getColumnName().endsWith("_ID") && extension != null && !isExport)
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
										td.addElement(href);
										href.addElement(Util.maskHTML(value));
										if (cssPrefix != null)
											href.setClass(cssPrefix + "-href");
										// Set Style
										if(style != null && style.isWrapWithSpan())
											HTMLReportRenderer.setStyle(printData, href, style);
										else
											HTMLReportRenderer.setStyle(printData, td, style);
										extension.extendIDColumn(row, td, href, pde);
									} else {
										// Set Style
										if(style != null && style.isWrapWithSpan()) {
											span span = new span();
											HTMLReportRenderer.setStyle(printData, span, style);
											span.addElement(Util.maskHTML(value));
											td.addElement(span);
										}
										else {
											HTMLReportRenderer.setStyle(printData, td, style);
											td.addElement(Util.maskHTML(value));
										}
									}

								}
								else
								{
									// Set Style
									if(style != null && style.isWrapWithSpan()) {
										span span = new span();
										HTMLReportRenderer.setStyle(printData, span, style);
										span.addElement(Util.maskHTML(value));
										td.addElement(span);
									}
									else {
										HTMLReportRenderer.setStyle(printData, td, style);
										td.addElement(Util.maskHTML(value));
									}
								}
								if (cssPrefix != null)
								{
									if (DisplayType.isNumeric(pde.getDisplayType()))
										td.setClass(cssPrefix + "-number");
									else if (DisplayType.isDate(pde.getDisplayType()))
										td.setClass(cssPrefix + "-date");
									else
										td.setClass(cssPrefix + "-text");
								}
								//just run with on record
								if (row == 0)
									HTMLReportRenderer.addCssInfo(printFormat, item, printColIndex, mapCssInfo);
							}
							else if (obj instanceof PrintData)
							{
								//	ignore contained Data
							}
							else
								log.log(Level.SEVERE, "Element not PrintData(Element) " + obj.getClass());
						}
					}	//	printed
				}	//	for all columns
				
				dataTableOptions.setPrintColLastIndex(printColIndex);
				
				/* output table header */
				if (row == -1){
					w.print(HTMLReportRenderer.compress(thead.toString(), minify));
					// output open of tbody
					w.print(HTMLReportRenderer.compress(tbody.toString(), minify));
				}else{
					// output row by row 
					w.print(HTMLReportRenderer.compress(tr.toString(), minify));
				}
				
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
				w.print(HTMLReportRenderer.compress(styleTag.toString(), minify));
			}
			if (!onlyTable)
			{
				w.print("</div>");
				w.print("</div>");
				String dataTableOptionString = dataTableOptions.getDataTableOptions("~./web/js");
				if( dataTableOptionString != null ) {
					w.print("<script type=\"text/javascript\"> ");
					w.print(HTMLReportRenderer.compress(
						"""
						 class NumberParser {\s\
						  constructor(locale) {\
						    const parts = new Intl.NumberFormat(locale).formatToParts(12345.6);\s\
						    const numerals = [...new Intl.NumberFormat(locale, {useGrouping: false}).format(9876543210)].reverse();\s\
						    const index = new Map(numerals.map((d, i) => [d, i]));\s\
							   let groupValue = parts.find(d => d.type === "group").value;\
						    this._group = new RegExp(`[${groupValue.charCodeAt(0)==160 ? '&nbsp;' : groupValue}]`, "g");\s\
						    this._decimal = new RegExp(`[${parts.find(d => d.type === "decimal").value}]`);\s\
						    this._numeral = new RegExp(`[${numerals.join("")}]`, "g");\s\
							\
						    this._index = d => index.get(d); }\s\
						  parse(string) {\s\
						    let retValue = (string = string.trim()\s\
						      .replace(this._group, "")\s\
						      .replace(this._decimal, ".")\s\
								.replace(this._numeral, this._index)) ? +string : 0;\s\
								return Number.isNaN(retValue) ? 0 : retValue;\
						  } }
						 """,true));
					String jsDataTables = "$(document).ready(function() { "
							+ "  let t = $('#"+JS_DATA_IDENTIFIER+"').DataTable( " + dataTableOptionString + " ); "
							+ " });"
							+ " $('#"+JS_DATA_IDENTIFIER+" tfoot th').each(function () {\r\n"
							+ "        var title = $(this).text();\r\n"
							+ "        $(this).html('<input type=\"text\"   placeholder=\"Search ' + title + '\" />');\r\n" //placeholder=\"Search ' + title + '\"
							+ "    }); " ;

					w.print(jsDataTables);
					w.print("</script>");
				}
				w.print("</body>");
				w.print("</html>");
			}
			w.flush();
			w.close();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, e.getMessage(), e);
			throw new AdempiereException(e);
		}
	}	//	createHTML
	
	/** 
	 * Is PrintFormat Item Function for DataTables
	 * @param item
	 * @return
	 */
	private boolean isDataTableFunctionColumn(MPrintFormatItem item) {
		if(item.isOrderBy()
				|| item.isGroupBy()
				|| item.isSummarized()
				|| item.isCounted()
				|| item.isMinCalc()
				|| item.isAveraged()
				|| item.isDeviationCalc()
				|| item.isMaxCalc()
				|| item.isVarianceCalc())
			return true;
		return false;
	}
	
	/**
	 * If isExport, embed script content, otherwise embed script url
	 * @param doc
	 * @param isExport
	 * @throws IOException
	 * @throws URISyntaxException 
	 */
	private void appendScripts (XhtmlDocument doc, boolean isExport) throws IOException, URISyntaxException{
		List<String> urls = Arrays.asList("~./js/datatables/jquery.min.js","~./js/datatables/jquery.floatThead.min.js"
				,"~./js/datatables/datatables.js","~./js/datatables/jquery.dataTables.min.js","~./js/datatables/dataTables.rowGroup.min.js");		
		if (isExport){
			// embed script by content
			for (String extraScriptPath : urls){
				URL url = getClass().getResource(extraScriptPath.replace("~./", "/web/"));
				appendInlineScriptContent (doc, readResource(url));
			}
		} else {			
			// embed script by link
			for (String extraScriptUrl : urls){
				embedScriptLink (doc, Executions.encodeURL(extraScriptUrl));
			}
		}
	}

	/**
	 * If isExport, embed css content, otherwise embed css url
	 * @param doc
	 * @param isExport
	 * @throws IOException
	 * @throws URISyntaxException 
	 */
	private void appendStyles (XhtmlDocument doc, boolean isExport) throws IOException, URISyntaxException{
		List<String> urls = Arrays.asList("~./js/datatables/datatables.css");		
		if (isExport){
			// embed css by content
			for (String extraStylePath : urls){
				URL url = getClass().getResource(extraStylePath.replace("~./", "/web/"));
				HTMLReportRenderer.appendInlineCss(doc, readResource(url));
			}			
		} else {
			// embed css by link
			for (String extraStyleUrl : urls){
				embedStyleLink (doc, Executions.encodeURL(extraStyleUrl));
			}
		}	
	}

	/**
	 * Read contents from URL
	 * @param url
	 * @return contents from URL
	 * @throws IOException
	 */
	private StringBuilder readResource(URL url) throws IOException {
		StringBuilder builder = new StringBuilder();
		InputStream is = url.openStream();
		BufferedReader reader = new BufferedReader(new InputStreamReader(is));
		String line;
		while ((line = reader.readLine()) != null) {
		    builder.append(line);
		}
		reader.close();
		return builder;
	}

	/**
	 * Embed script url into head tag
	 * @param doc
	 * @param scriptUrl
	 */
	protected void embedScriptLink (XhtmlDocument doc, String scriptUrl){
		script jslink = new script();
		jslink.setLanguage("javascript");
		jslink.setSrc(scriptUrl);
		doc.appendHead(jslink);
	}

	/**
	 * Embed css url into head tag
	 * @param doc
	 * @param scriptUrl
	 */
	protected void embedStyleLink (XhtmlDocument doc, String styleUrl){
		link csslink = new link();
		csslink.setType("text/css");
		csslink.setRel("stylesheet");
		csslink.setHref(styleUrl);
		doc.appendHead(csslink);
	}

	/**
	 * Embed script content into head tag
	 * @param doc
	 * @param buildScriptContent
	 */
	private void appendInlineScriptContent (XhtmlDocument doc, StringBuilder buildScriptContent){
		if (buildScriptContent.length() > 0){
			buildScriptContent.insert(0, "<script type=\"text/javascript\">\n");
			buildScriptContent.append("\n</script>");
			doc.appendHead(buildScriptContent.toString());
		}
	}	
}
