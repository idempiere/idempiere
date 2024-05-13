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
import java.util.logging.Level;

import javax.xml.transform.stream.StreamResult;

import org.compiere.print.ReportEngine;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Msg;
import org.osgi.service.component.annotations.Component;

import com.google.common.net.MediaType;

/**
 * XML content rendering service for report engine
 */
@Component(service = IReportRenderer.class, immediate = true)
public class XMLReportRenderer implements IReportRenderer<XMLReportRendererConfiguration> {

	private static final CLogger log = CLogger.getCLogger(XMLReportRenderer.class);
	
	public XMLReportRenderer() {
	}

	@Override
	public String getId() {
		return XMLReportRendererConfiguration.ID;
	}

	@Override
	public String getName() {
		return Msg.getMsg(Env.getCtx(), "FileXML");
	}

	@Override
	public String getContentType() {
		return MediaType.XML_UTF_8.toString();
	}

	@Override
	public String getFileExtension() {
		return XMLReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public void renderReport(ReportEngine reportEngine, XMLReportRendererConfiguration configuration) {
		try {
			Writer fw = null;
			if (configuration.getOutputFile() != null)
				fw = new OutputStreamWriter(new FileOutputStream(configuration.getOutputFile(), false), Ini.getCharset());
			else 
				fw = configuration.getOutputWriter();
			createXML(reportEngine, fw);
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
	 * 	Write XML content to writer
	 *  @param reportEngine
	 * 	@param writer writer
	 */
	public void createXML (ReportEngine reportEngine, Writer writer)
	{
		try
		{
			reportEngine.getPrintData().createXML(new StreamResult(writer));
			writer.flush();
			writer.close();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(w)", e);
		}
	}	//	createXML

	@Override
	public Class<XMLReportRendererConfiguration> getConfigurationType() {
		return XMLReportRendererConfiguration.class;
	}
}
