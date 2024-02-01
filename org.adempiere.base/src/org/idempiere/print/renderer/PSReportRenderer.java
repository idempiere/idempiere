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

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.logging.Level;

import javax.print.DocFlavor;
import javax.print.StreamPrintService;
import javax.print.StreamPrintServiceFactory;
import javax.print.attribute.HashPrintRequestAttributeSet;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.print.ReportEngine;
import org.compiere.print.layout.LayoutEngine;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.osgi.service.component.annotations.Component;

import com.google.common.net.MediaType;

/**
 * Postscript content rendering service for report engine
 */
@Component(service = IReportRenderer.class, immediate = true)
public class PSReportRenderer implements IReportRenderer<PSReportRendererConfiguration> {

	private static final CLogger log = CLogger.getCLogger(PSReportRenderer.class);

	public PSReportRenderer() {
	}

	@Override
	public String getId() {
		return PSReportRendererConfiguration.ID;
	}

	@Override
	public String getName() {
		return Msg.getMsg(Env.getCtx(), "FilePS");
	}

	@Override
	public String getContentType() {
		return MediaType.POSTSCRIPT.toString();
	}

	@Override
	public String getFileExtension() {
		return PSReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public void renderReport(ReportEngine reportEngine, PSReportRendererConfiguration configuration) {
		try
		{
			OutputStream os = null;
			if (configuration.getOutputFile() != null)
				os = new FileOutputStream(configuration.getOutputFile());
			else
				os = configuration.getOutputStream();
			createPS(reportEngine, os);
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "PDF", e);
			throw new AdempiereException(e);
		}
	}

	@Override
	public boolean isBinary() {
		return true;
	}

	/**
	 * 	Write PostScript to output stream
	 * 	@param os output stream
	 */
	private void createPS (ReportEngine reportEngine, OutputStream os)
	{
		try
		{
			String outputMimeType = DocFlavor.BYTE_ARRAY.POSTSCRIPT.getMimeType();
			DocFlavor docFlavor = DocFlavor.SERVICE_FORMATTED.PAGEABLE;
			StreamPrintServiceFactory[] spsfactories =
				StreamPrintServiceFactory.lookupStreamPrintServiceFactories(docFlavor, outputMimeType);
			if (spsfactories.length == 0)
			{
				log.log(Level.SEVERE, "(fos) - No StreamPrintService");
				return;
			}
			//	just use first one - sun.print.PSStreamPrinterFactory
			StreamPrintService sps = spsfactories[0].getPrintService(os);
			//	get format
			LayoutEngine layout = reportEngine.getLayout();			
			//	print it
			sps.createPrintJob().print(layout.getPageable(false), 
				new HashPrintRequestAttributeSet());
			//
			os.flush();
			//following 2 line for backward compatibility
			if (os instanceof FileOutputStream)
				((FileOutputStream)os).close();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(fos)", e);
		}
	}	//	createPS

	@Override
	public Class<PSReportRendererConfiguration> getConfigurationType() {
		return PSReportRendererConfiguration.class;
	}
}
