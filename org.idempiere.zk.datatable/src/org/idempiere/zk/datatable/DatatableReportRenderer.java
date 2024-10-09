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
import java.io.ByteArrayInputStream;
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
import java.util.Base64;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
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
import org.compiere.model.MElement;
import org.compiere.model.MImage;
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

import com.google.common.io.ByteStreams;
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
			DataTableOptions dataTableOptions = new DataTableOptions(language.getLocale().toLanguageTag());
			//collect column to print
			List<Object> columns = new ArrayList<>();
			List<InstanceAttributeData> asiElements = new ArrayList<>();
			int columnCount = 0;
			for (int col = 0; col < printFormat.getItemCount(); col++)
			{
				MPrintFormatItem item = printFormat.getItem(col);
				if (item.isPrinted())
				{
					if (item.isNextLine() && item.getBelowColumn() >= 1) 
					{
						columns.add(item);
						continue;
					}
					
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
				
				appendStyles(doc, isExport, dataTableOptions.geti18nURL());

				appendScripts (doc, isExport);

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
			
			thead thead = new thead();
			thead.setClass("sticky");
			tbody tbody = new tbody();
			tbody.setNeedClosingTag(false);
			
			Boolean [] colSuppressRepeats = layout == null || layout.colSuppressRepeats == null? LayoutEngine.getColSuppressRepeats(printFormat):layout.colSuppressRepeats;
			Object [] preValues = null;
			if (colSuppressRepeats != null){
				preValues = new Object [colSuppressRepeats.length];
			}

			int printColIndex = -1;
			HashMap<Integer, th> suppressMap = new HashMap<>();
			
			//search input at header
			{
				tr tr = new tr();
				for (int col = 0; col < printFormat.getItemCount(); col++)
				{
					MPrintFormatItem item = printFormat.getItem(col);
					if (item.isPrinted())
					{
						if (item.isNextLine() && item.getBelowColumn() >= 1)
							continue;
						var printName = item.getPrintName(language);
						if (!Util.isEmpty(printName))
						{
							th th = new th();
							th.addAttribute("data-dt-order", "disable");
							tr.addElement(th);
							input searchInput = new input();
							searchInput.addAttribute("placeholder", "Search "+printName);								
							th.addElement(searchInput);
						}
					}
				}
				thead.addElement(tr);
			}
			
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
							if (item.isGroupBy())
								dataTableOptions.setOrdering(false);

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
							tdMap.put(printColIndex, td);
							printColumn(reportEngine, language, extension, isExport, td, item, instanceAttributeColumn, row, printData,
									colSuppressRepeats, printColIndex, preValues, suppressMap, cssPrefix, printFormat, mapCssInfo);
						}
					}	//	printed
				}	//	for all columns
				
				dataTableOptions.setPrintColLastIndex(printColIndex);
				
				/* output table header */
				if (row == -1){
					w.print(HTMLReportRenderer.compress(thead.toString(), minify));
					// output open of tbody
					w.print(HTMLReportRenderer.compress(tbody.toString(), minify));
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
										colSuppressRepeats, printColIndex, preValues, suppressMap, cssPrefix, printFormat, mapCssInfo);
								div.setClass("");
							}
						}
					}
				}

				// output row by row
				if (row != -1)						
					w.print(HTMLReportRenderer.compress(tr.toString(), minify));
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
				String dataTableOptionString = dataTableOptions.getDataTableOptions();
				if( dataTableOptionString != null ) {
					w.print("<script type=\"text/javascript\"> ");
					String jsDataTables = "$(document).ready(function() { "
							+ "  let t = $('#"+JS_DATA_IDENTIFIER+"').DataTable( " + dataTableOptionString + " ); "
							+ " });";

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
	 * @param printFormat
	 * @param mapCssInfo
	 */
	private static void printColumn(ReportEngine reportEngine, Language language, IHTMLExtension extension, boolean isExport, MultiPartElement td, 
									MPrintFormatItem item, InstanceAttributeColumn instanceAttributeColumn, int row, PrintData printData, 
									Boolean[] colSuppressRepeats, int printColIndex, Object[] preValues, HashMap<Integer, th> suppressMap, String cssPrefix, MPrintFormat printFormat, Map<HTMLReportRenderer.CSSInfo, List<HTMLReportRenderer.ColumnInfo>> mapCssInfo) {
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
						td.addElementToRegistry(span);
					}
					else {
						HTMLReportRenderer.setStyle(printData, td, style);
						td.addElementToRegistry(Util.maskHTML(value));
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
					td.addElementToRegistry(span);
				}
				else {
					HTMLReportRenderer.setStyle(printData, td, style);
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
	 * If isExport, embed script content, otherwise embed script url
	 * @param doc
	 * @param isExport
	 * @throws IOException
	 * @throws URISyntaxException 
	 */
	private void appendScripts (XhtmlDocument doc, boolean isExport) throws IOException, URISyntaxException{
		List<String> urls = Arrays.asList("~./js/datatables/datatables.min.js");		
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
	 * @param i18nURL
	 * @throws IOException
	 * @throws URISyntaxException 
	 */
	private void appendStyles (XhtmlDocument doc, boolean isExport, String i18nURL) throws IOException, URISyntaxException{
		List<String> urls = Arrays.asList("~./js/datatables/datatables.min.css", "~./js/datatables/customization.css");		
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
				if (i18nURL != null) {
					link link = new link();
					link.setHref(i18nURL);
					link.setRel("prefetch");
					link.setType("application/json");
					doc.appendHead(link);
				}
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
	 * @param styleUrl
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
