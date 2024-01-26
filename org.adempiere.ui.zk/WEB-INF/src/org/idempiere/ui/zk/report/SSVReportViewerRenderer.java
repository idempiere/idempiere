package org.idempiere.ui.zk.report;

import java.io.StringWriter;

import org.adempiere.base.Core;
import org.adempiere.webui.window.ZkReportViewer;
import org.compiere.print.ReportEngine;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.idempiere.print.renderer.IReportRenderer;
import org.idempiere.print.renderer.IReportRendererConfiguration;
import org.idempiere.print.renderer.SSVReportRendererConfiguration;
import org.osgi.service.component.annotations.Component;
import org.zkoss.util.media.AMedia;

import com.google.common.net.MediaType;

@Component(service = IReportViewerRenderer.class, immediate = true)
public class SSVReportViewerRenderer implements IReportViewerRenderer {

	public SSVReportViewerRenderer() {
	}

	@Override
	public String getId() {
		return SSVReportRendererConfiguration.ID;
	}

	@Override
	public String getExportLabel() {
		return Msg.getMsg(Env.getCtx(), "FileSSV");
	}

	@Override
	public String getContentType() {
		return MediaType.CSV_UTF_8.toString();
	}

	@Override
	public String getFileExtension() {
		return SSVReportRendererConfiguration.FILE_EXTENSION;
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
		SSVReportRendererConfiguration config = new SSVReportRendererConfiguration()
				.setLanguage(reportEngine.getPrintFormat().getLanguage())
				.setOutputWriter(sw);
		renderer.renderReport(reportEngine, config);
		String data = sw.getBuffer().toString();
		return new AMedia(reportEngine.getName() + "."+getFileExtension(), getFileExtension(), getContentType(), data);
	}

}
