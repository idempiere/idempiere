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

import java.io.File;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.print.export.PrintDataXLSXExporter;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.print.PrintData;
import org.compiere.print.ReportEngine;
import org.compiere.print.layout.LayoutEngine;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.osgi.service.component.annotations.Component;

import com.google.common.net.MediaType;

/**
 * Excel open xml (xlsx) content rendering service for report engine
 */
@Component(service = IReportRenderer.class, immediate = true)
public class XLSXReportRenderer implements IReportRenderer<XLSXReportRendererConfiguration> {

	private static final CLogger log = CLogger.getCLogger(XLSReportRenderer.class);

	public XLSXReportRenderer() {
	}

	@Override
	public String getId() {
		return XLSXReportRendererConfiguration.ID;
	}

	@Override
	public String getName() {
		return Msg.getMsg(Env.getCtx(), "FileXLSX");
	}

	@Override
	public String getContentType() {
		return MediaType.OOXML_SHEET.toString();
	}

	@Override
	public String getFileExtension() {
		return XLSXReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public void renderReport(ReportEngine reportEngine, XLSXReportRendererConfiguration configuration) {
		try {
			createXLSX(reportEngine, configuration.getOutputFile(), configuration.getLanguage());
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getMessage(), e);
			throw new AdempiereException(e);
		}
	}

	@Override
	public boolean isBinary() {
		return true;
	}

	/**
	 * Create Excel open XML file
	 * @param reportEngine
	 * @param outFile output file
	 * @param language
	 * @throws Exception if error
	 */
	private void createXLSX(ReportEngine reportEngine, File outFile, Language language)
	throws Exception
	{
		LayoutEngine layout = reportEngine.getLayout();
		MPrintFormat printFormat = reportEngine.getPrintFormat();
		Boolean [] colSuppressRepeats = layout == null || layout.colSuppressRepeats == null? LayoutEngine.getColSuppressRepeats(printFormat):layout.colSuppressRepeats;
		Map<MPrintFormatItem, PrintData> childFormats = layout != null ? layout.getChildPrintFormatDetails() : null;
		PrintDataXLSXExporter exp = new PrintDataXLSXExporter(reportEngine.getPrintData(), printFormat, childFormats, colSuppressRepeats, reportEngine.getQuery());
		exp.export(outFile, language);
	}

	@Override
	public Class<XLSXReportRendererConfiguration> getConfigurationType() {
		return XLSXReportRendererConfiguration.class;
	}
}
