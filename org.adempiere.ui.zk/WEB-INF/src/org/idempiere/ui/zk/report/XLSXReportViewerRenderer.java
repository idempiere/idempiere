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
import org.idempiere.print.renderer.IReportRenderer;
import org.idempiere.print.renderer.IReportRendererConfiguration;
import org.idempiere.print.renderer.XLSXReportRendererConfiguration;
import org.osgi.service.component.annotations.Component;
import org.zkoss.util.media.AMedia;

import com.google.common.net.MediaType;

@Component(service = IReportViewerRenderer.class, immediate = true)
public class XLSXReportViewerRenderer implements IReportViewerRenderer {

	private static final CLogger log = CLogger.getCLogger(XLSXReportViewerRenderer.class);
	
	public XLSXReportViewerRenderer() {
	}

	@Override
	public String getId() {
		return XLSXReportRendererConfiguration.ID;
	}

	@Override
	public String getExportLabel() {
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
	public boolean isExport() {
		return false;
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
			if (log.isLoggable(Level.FINE))
			{
				log.log(Level.FINE, "Path=" + path + " Prefix=" + prefix);
			}
			File file = FileUtil.createTempFile(prefix, "."+getFileExtension(), new File(path));
			IReportRenderer<IReportRendererConfiguration> renderer = Core.getReportRenderer(getId());
			XLSXReportRendererConfiguration config = new XLSXReportRendererConfiguration()
					.setLanguage(reportEngine.getPrintFormat().getLanguage())
					.setOutputFile(file);
			renderer.renderReport(reportEngine, config);
			return new AMedia(file.getName(), getFileExtension(), getContentType(), file, true);
		} catch (Exception e) {
			if (e instanceof RuntimeException)
				throw (RuntimeException)e;
			else
				throw new RuntimeException(e);
		}
	}
}
