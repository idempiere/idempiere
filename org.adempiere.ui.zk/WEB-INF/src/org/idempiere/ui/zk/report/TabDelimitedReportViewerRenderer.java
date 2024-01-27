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

import java.io.StringWriter;

import org.adempiere.base.Core;
import org.adempiere.webui.window.ZkReportViewer;
import org.compiere.print.ReportEngine;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.print.renderer.IReportRenderer;
import org.idempiere.print.renderer.IReportRendererConfiguration;
import org.idempiere.print.renderer.TabDelimitedReportRendererConfiguration;
import org.osgi.service.component.annotations.Component;
import org.zkoss.util.media.AMedia;

import com.google.common.net.MediaType;

/**
 * Tab separated content rendering service for report viewer
 */
@Component(service = IReportViewerRenderer.class, immediate = true)
public class TabDelimitedReportViewerRenderer implements IReportViewerRenderer {

	public TabDelimitedReportViewerRenderer() {
	}

	@Override
	public String getId() {
		return TabDelimitedReportRendererConfiguration.ID;
	}

	@Override
	public String getExportLabel() {
		return Msg.getMsg(Env.getCtx(), "FileTXT");
	}

	@Override
	public String getContentType() {
		return MediaType.PLAIN_TEXT_UTF_8.toString();
	}

	@Override
	public String getFileExtension() {
		return TabDelimitedReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public boolean isExport() {
		return true;
	}

	@Override
	public boolean isPreview(boolean roleCanExport) {
		return false;
	}

	@Override
	public AMedia renderMedia(ZkReportViewer viewer, boolean export) {
		StringWriter sw = new StringWriter();
		ReportEngine reportEngine = viewer.getReportEngine();
		IReportRenderer<IReportRendererConfiguration> renderer = Core.getReportRenderer(getId());
		TabDelimitedReportRendererConfiguration config = new TabDelimitedReportRendererConfiguration()
				.setLanguage(reportEngine.getPrintFormat().getLanguage())
				.setOutputWriter(sw);
		renderer.renderReport(reportEngine, config);
		String data = sw.getBuffer().toString();
		return new AMedia(reportEngine.getName() + "."+getFileExtension(), getFileExtension(), getContentType(), data);
	}

}
