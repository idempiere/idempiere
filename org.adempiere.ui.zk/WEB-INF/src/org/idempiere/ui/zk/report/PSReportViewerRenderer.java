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
