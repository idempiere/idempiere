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

import java.io.ByteArrayOutputStream;

import org.adempiere.base.Core;
import org.adempiere.webui.window.ZkReportViewer;
import org.compiere.print.ReportEngine;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.print.renderer.IReportRenderer;
import org.idempiere.print.renderer.IReportRendererConfiguration;
import org.idempiere.print.renderer.PSReportRendererConfiguration;
import org.osgi.service.component.annotations.Component;
import org.zkoss.util.media.AMedia;

import com.google.common.net.MediaType;

/**
 * Postscript content rendering service for report viewer
 */
@Component(service = IReportViewerRenderer.class, immediate = true)
public class PSReportViewerRenderer implements IReportViewerRenderer {

	public PSReportViewerRenderer() {
	}

	@Override
	public String getId() {
		return PSReportRendererConfiguration.ID;
	}

	@Override
	public String getExportLabel() {
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
	public boolean isExport() {
		return true;
	}

	@Override
	public boolean isPreview(boolean roleCanExport) {
		return false;
	}
	
	@Override
	public AMedia renderMedia(ZkReportViewer viewer, boolean export) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ReportEngine m_reportEngine = viewer.getReportEngine();
		m_reportEngine.createPS(baos);
		IReportRenderer<IReportRendererConfiguration> renderer = Core.getReportRenderer(getId());
		PSReportRendererConfiguration config = new PSReportRendererConfiguration().setOutputStream(baos);
		renderer.renderReport(m_reportEngine, config);
		byte[] data = baos.toByteArray();
		return new AMedia(m_reportEngine.getName() + "."+getFileExtension(), getFileExtension(), getContentType(), data);
	}
}
