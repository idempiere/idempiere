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

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pdf.Document;
import org.compiere.print.ArchiveEngine;
import org.compiere.print.ReportEngine;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.osgi.service.component.annotations.Component;

import com.google.common.net.MediaType;

/**
 * PDF content rendering service for report engine
 */
@Component(service = IReportRenderer.class, immediate = true)
public class PDFReportRenderer implements IReportRenderer<PDFReportRendererConfiguration> {

	private static final CLogger log = CLogger.getCLogger(PDFReportRenderer.class);
	
	public PDFReportRenderer() {
	}

	@Override
	public String getId() {
		return PDFReportRendererConfiguration.ID;
	}

	@Override
	public String getName() {
		return Msg.getMsg(Env.getCtx(), "FilePDF");
	}

	@Override
	public String getContentType() {
		return MediaType.PDF.toString();
	}

	@Override
	public String getFileExtension() {
		return PDFReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public void renderReport(ReportEngine reportEngine, PDFReportRendererConfiguration configuration) {
		try
		{
			OutputStream os = null;
			if (configuration.getOutputFile() != null)
				os = new FileOutputStream(configuration.getOutputFile());
			else
				os = configuration.getOutputStream();
			Document.writePDF(reportEngine.getLayout().getPageable(false), os);
			if (configuration.getOutputFile() != null)
				ArchiveEngine.get().archive(configuration.getOutputFile(), reportEngine.getPrintInfo());
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

	@Override
	public Class<PDFReportRendererConfiguration> getConfigurationType() {
		return PDFReportRendererConfiguration.class;
	}

}
