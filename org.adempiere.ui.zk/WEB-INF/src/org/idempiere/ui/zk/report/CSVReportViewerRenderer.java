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
package org.idempiere.ui.zk.report;

import java.io.File;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.webui.window.ZkReportViewer;
import org.compiere.print.ReportEngine;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.print.renderer.CSVReportRendererConfiguration;
import org.idempiere.print.renderer.IReportRenderer;
import org.idempiere.print.renderer.IReportRendererConfiguration;
import org.osgi.service.component.annotations.Component;
import org.zkoss.util.media.AMedia;

import com.google.common.net.MediaType;

/**
 * Comma separated content rendering service for report viewer
 */
@Component(service = IReportViewerRenderer.class, immediate = true)
public class CSVReportViewerRenderer implements IReportViewerRenderer {

	private static final CLogger log = CLogger.getCLogger(CSVReportViewerRenderer.class);
	
	public CSVReportViewerRenderer() {
	}

	@Override
	public String getId() {
		return CSVReportRendererConfiguration.ID;
	}

	@Override
	public String getExportLabel() {
		return Msg.getMsg(Env.getCtx(), "FileCSV");
	}

	@Override
	public String getContentType() {
		return MediaType.CSV_UTF_8.toString();
	}

	@Override
	public String getFileExtension() {
		return CSVReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public boolean isExport() {
		return true;
	}

	@Override
	public boolean isPreview(boolean roleCanExport) {
		return roleCanExport;
	}
	
	@Override
	public AMedia renderMedia(ZkReportViewer viewer, boolean export) {
		ReportEngine reportEngine = viewer.getReportEngine();
		try {
			String path = System.getProperty("java.io.tmpdir");
			String prefix = makePrefix(reportEngine.getName());
			if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
			File file = FileUtil.createTempFile(prefix, "."+getFileExtension(), new File(path));
			IReportRenderer<IReportRendererConfiguration> renderer = Core.getReportRenderer(getId());
			CSVReportRendererConfiguration config = new CSVReportRendererConfiguration()
					.setLanguage(reportEngine.getPrintFormat().getLanguage())
					.setOutputFile(file);
			renderer.renderReport(reportEngine, config);
			return new AMedia(file.getName(), getFileExtension(), getContentType(), file, false);
		} catch (Exception e) {
			if (e instanceof RuntimeException)
				throw (RuntimeException)e;
			else
				throw new RuntimeException(e);
		}
	}
}
