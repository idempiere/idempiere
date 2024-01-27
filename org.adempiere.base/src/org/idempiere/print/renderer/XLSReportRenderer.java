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
import org.adempiere.print.export.PrintDataExcelExporter;
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
 * Excel (xls) content rendering service for report engine
 */
@Component(service = IReportRenderer.class, immediate = true)
public class XLSReportRenderer implements IReportRenderer<XLSReportRendererConfiguration> {

	
	private static final CLogger log = CLogger.getCLogger(XLSReportRenderer.class);
	
	public XLSReportRenderer() {
	}

	@Override
	public String getId() {
		return XLSReportRendererConfiguration.ID;
	}

	@Override
	public String getName() {
		return Msg.getMsg(Env.getCtx(), "FileXLS");
	}

	@Override
	public String getContentType() {
		return MediaType.MICROSOFT_EXCEL.toString();
	}

	@Override
	public String getFileExtension() {
		return XLSReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public void renderReport(ReportEngine reportEngine, XLSReportRendererConfiguration configuration) {
		try {
			createXLS(reportEngine, configuration.getOutputFile(), configuration.getLanguage());
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
	 * Create Excel file
	 * @param outFile output file
	 * @param language
	 * @throws Exception if error
	 */
	private void createXLS(ReportEngine reportEngine, File outFile, Language language)
	throws Exception
	{
		LayoutEngine layout = reportEngine.getLayout();
		MPrintFormat printFormat = reportEngine.getPrintFormat();		
		Boolean [] colSuppressRepeats = layout == null || layout.colSuppressRepeats == null? LayoutEngine.getColSuppressRepeats(printFormat):layout.colSuppressRepeats;
		Map<MPrintFormatItem, PrintData> childFormats = layout != null ? layout.getChildPrintFormatDetails() : null;
		PrintDataExcelExporter exp = new PrintDataExcelExporter(reportEngine.getPrintData(), printFormat, childFormats, colSuppressRepeats, reportEngine.getQuery());
		exp.export(outFile, language);
	}

	@Override
	public Class<XLSReportRendererConfiguration> getConfigurationType() {
		return XLSReportRendererConfiguration.class;
	}
}
