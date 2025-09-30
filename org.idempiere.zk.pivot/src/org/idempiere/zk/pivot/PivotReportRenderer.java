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
package org.idempiere.zk.pivot;

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
import java.util.Iterator;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.PrintData;
import org.compiere.print.PrintDataElement;
import org.compiere.print.ReportEngine;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.print.renderer.IReportRenderer;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.osgi.service.component.annotations.Component;
import org.zkoss.zk.ui.Executions;

import com.google.common.net.MediaType;

@Component(service = IReportRenderer.class, immediate = true)
public class PivotReportRenderer implements IReportRenderer<PivotReportRendererConfiguration> {

	private static final CLogger log = CLogger.getCLogger(PivotReportRenderer.class);
	
	public PivotReportRenderer() {
	}

	@Override
	public String getId() {
		return PivotReportRendererConfiguration.ID;
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
		return PivotReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public void renderReport(ReportEngine reportEngine, PivotReportRendererConfiguration configuration) {
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
			createHTML (reportEngine, new BufferedWriter(fw), lang, configuration.isExport());
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

	/**
	 * Write html content to writer
	 * @param reportEngine
	 * @param bw
	 * @param lang
	 * @param export
	 */
	private void createHTML(ReportEngine reportEngine, BufferedWriter bw, Language lang, boolean export) {
		PrintData printData = reportEngine.getPrintData();
		MPrintFormat printFormat = reportEngine.getPrintFormat();
		PrintWriter w = new PrintWriter(bw);
		try
		{
			if (lang == null)
				lang = Language.getLoginLanguage();
			w.println(
				"""
				<!DOCTYPE html>
				<html>
				    <head>
						<meta charset="utf-8"/>\s\
						<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.css">
				        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.5/d3.min.js"></script>
				        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/c3/0.4.11/c3.min.js"></script>
				        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
				        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
				""");
			
			appendStyle(w, export, "~./js/pivot/pivot.css");
			appendScript(w, export, "~./js/pivot/pivot.js");
			appendScript(w, export, "~./js/pivot/c3_renderers.js");
			
			w.println(
				"""
				        <style>
				            body {font-family: Verdana;}
				            .c3-line, .c3-focused {stroke-width: 3px !important;}
				            .c3-bar {stroke: white !important; stroke-width: 1;}
				            .c3 text { font-size: 12px; color: grey;}
				            .tick line {stroke: white;}
				            .c3-axis path {stroke: grey;}
				            .c3-circle { opacity: 1 !important; }
				            .c3-xgrid-focus {visibility: hidden !important;}
				        </style>
				        <!-- optional: mobile support with jqueryui-touch-punch -->
				        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>
				"""); 

			// Prepare Derived Attributes
			JSONObject derivedAttributes = new JSONObject();

			JSONArray ja = new JSONArray();
			//	for all rows (-1 = header row)
			for (int row = 0; row < printData.getRowCount(); row++)
			{
				JSONObject jo = new JSONObject();
				printData.setRowIndex(row);
				if (printData.isFunctionRow()) 
					continue;

				//	for all columns
				for (int col = 0; col < printFormat.getItemCount(); col++)
				{
					MPrintFormatItem item = printFormat.getItem(col);
					if (item.isPrinted())
					{
						var printName = item.getPrintName(lang);
						if (Util.isEmpty(printName))
							continue;
						Object obj = printData.getNodeByPrintFormatItem(item);
						if (obj instanceof PrintDataElement)
						{
							PrintDataElement pde = (PrintDataElement) obj;
							String value = pde.getValueDisplay(lang);	//	formatted
							// Check if Item is Date
							if(pde.isDate()) {
								putPivotAttributes(derivedAttributes, item.getPrintName(lang), lang);
								value = pde.getValueAsString();	//	unformatted Date for Parsing Fix									
							}							

							if (DisplayType.isNumeric(pde.getDisplayType()))
								value = pde.getValueAsString();
							jo.append(printName, value);
						}			
					}	//	for all columns
				}
				ja.put(jo);
			}	//	for all rows

			w.println();

			w.println("<script type=\"text/javascript\">\n" + 
					"    $(function(){\n" + 
					"	let jsonObject = "+ja.toString()+";\n" + 
					"   let derivers = $.pivotUtilities.derivers;\n"); 
			// Get DateFormat Function for Dates
			if(derivedAttributes.keys().hasNext()) {
				w.println(" let dateFormat = $.pivotUtilities.derivers.dateFormat;\n");				
			}
			w.println(
				"""
				        let renderers = $.extend($.pivotUtilities.renderers,
				            $.pivotUtilities.c3_renderers);
							$("#output").pivotUI(jsonObject, {
				"""); 

			// Apply Derivates for Dates
			if(derivedAttributes.keys().hasNext()) {
				w.println("       derivedAttributes: { \n");
				Iterator<String> keys = derivedAttributes.keys();				
				while(keys.hasNext()) {
					String key = keys.next();					
					String dateFormatString = derivedAttributes.getString(key);

					w.println(" \"" + key + "\": " + dateFormatString); 	
					if(keys.hasNext())
						w.println(", ");
					w.println("\n");	
				}			

				w.println(" }, \n");	
			}

			w.println(
				"""
					  renderers: renderers,
					           cols: [""], rows: [""],
					           rendererName: "Horizontal Stacked Bar Chart",
					           rowOrder: "value_z_to_a", colOrder: "value_z_to_a",
					           rendererOptions: {
					                c3: { data: {colors: {
					                        Liberal: '#dc3912', Conservative: '#3366cc', NDP: '#ff9900',
					                        Green:'#109618', 'Bloc Quebecois': '#990099'
					                    }}}
					           }
					     });
					 });
					</script>
					</head>
				    <body>
				        <div id="output" style="margin: 30px;"></div>
				    </body>
				</html>
				""");
			w.flush();
			w.close();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(w)", e);
		}
	}

	/**
	 * Add Prepared Date Derivates
	 * @param derivedAttributes
	 * @param dateName
	 * @param language
	 */
	private void putPivotAttributes(JSONObject derivedAttributes, String dateName, Language language) {
		// Prepare Derived Attributes
		try {
			derivedAttributes.put( dateName+"("+Msg.translate(language, "CalendarYear")+")", "dateFormat(\""+dateName+"\", \"%y\", true)");
			derivedAttributes.put( dateName+"("+Msg.translate(language, "Month") +")", "dateFormat(\""+dateName+"\", \"%m-%n\", true)");
		} catch (JSONException e) {
			log.log(Level.SEVERE, "(w)", e);
		}
	}

	@Override
	public boolean isBinary() {
		return false;
	}

	@Override
	public Class<PivotReportRendererConfiguration> getConfigurationType() {
		return PivotReportRendererConfiguration.class;
	}

	/**
	 * If isExport embed css content, otherwise embed css link
	 * @param writer
	 * @param isExport
	 * @param csslink
	 * @throws IOException
	 * @throws URISyntaxException
	 */
	private void appendStyle(PrintWriter writer, boolean isExport, String csslink) throws IOException, URISyntaxException{
		if (isExport){
			// embed extend css by content
			URL url = getClass().getResource(csslink.replace("~./", "/web/"));
			writer.println("<style>");
			writer.println(readResource(url).toString());
			writer.println("</style>");
		} else {
			writer.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"");
			writer.print(Executions.encodeURL(csslink));
			writer.println("\">");
		}	
	}

	/**
	 * If isExport embed script content, otherwise embed script link
	 * @param writer
	 * @param isExport
	 * @param scriptlink
	 * @throws IOException
	 * @throws URISyntaxException
	 */
	private void appendScript(PrintWriter writer, boolean isExport, String scriptlink) throws IOException, URISyntaxException{
		if (isExport){
			// embed extend css by content
			URL url = getClass().getResource(scriptlink.replace("~./", "/web/"));
			writer.println("<script language='javascript'>");
			writer.println(readResource(url).toString());
			writer.println("</script>");
		} else {
			writer.print("<script type=\"text/javascript\" src=\"");
			writer.print(Executions.encodeURL(scriptlink));
			writer.println("\"/>");
		}	
	}
	
	/**
	 * Read content from URL
	 * @param url
	 * @return content from URL
	 * @throws IOException
	 */
	private StringBuilder readResource(URL url) throws IOException {
		StringBuilder builder = new StringBuilder();
		InputStream is = url.openStream();
		try(BufferedReader reader = new BufferedReader(new InputStreamReader(is))){
		String line;
		while ((line = reader.readLine()) != null) {
		    builder.append(line);
		}}
		return builder;
	}
}
