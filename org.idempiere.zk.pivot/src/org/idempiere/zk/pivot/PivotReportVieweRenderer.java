package org.idempiere.zk.pivot;

import java.io.File;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.webui.window.ZkReportViewer;
import org.compiere.print.ReportEngine;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.idempiere.print.renderer.IReportRenderer;
import org.idempiere.print.renderer.IReportRendererConfiguration;
import org.idempiere.ui.zk.report.IReportViewerRenderer;
import org.osgi.service.component.annotations.Component;
import org.zkoss.util.media.AMedia;

import com.google.common.net.MediaType;

@Component(service = IReportViewerRenderer.class, immediate = true)
public class PivotReportVieweRenderer implements IReportViewerRenderer {

	private static final CLogger log = CLogger.getCLogger(PivotReportVieweRenderer.class);
	
	public PivotReportVieweRenderer() {
	}

	@Override
	public String getId() {
		return PivotReportRendererConfiguration.ID;
	}

	@Override
	public String getExportLabel() {
		return getId();
	}

	@Override
	public String getContentType() {
		return MediaType.HTML_UTF_8.toString();
	}

	@Override
	public String getFileExtension() {
		return PivotReportRendererConfiguration.FILE_EXTENSION;
	}

	@Override
	public boolean isExport() {
		return true;
	}

	@Override
	public boolean isPreview(boolean roleCanExport) {
		return true;
	}

	@Override
	public AMedia renderMedia(ZkReportViewer viewer, boolean export) {
		ReportEngine reportEngine = viewer.getReportEngine();
		try {
			String path = System.getProperty("java.io.tmpdir");
			String prefix = makePrefix(reportEngine.getName());
			if (prefix.length() < 3)
				prefix += "_".repeat(3-prefix.length());
			if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
			File file = FileUtil.createTempFile(prefix, "."+getFileExtension(), new File(path));
			IReportRenderer<IReportRendererConfiguration> renderer = Core.getReportRenderer(getId());
			PivotReportRendererConfiguration config = new PivotReportRendererConfiguration()
					.setLanguage(reportEngine.getPrintFormat().getLanguage())
					.setOutputFile(file)
					.setExport(export);
			renderer.renderReport(reportEngine, config);
			return new AMedia(file.getName(), getFileExtension(), getContentType(), file, false);
		} catch (Exception e) {
			if (e instanceof RuntimeException)
				throw (RuntimeException)e;
			else
				throw new RuntimeException(e);
		}
	}

	@Override
	public boolean isSameContentForExportAndPreview() {
		return false;
	}	
}
