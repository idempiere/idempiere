package org.idempiere.zk.pivot;

import java.io.File;
import java.io.Writer;

import org.compiere.util.Language;
import org.idempiere.print.renderer.IReportRendererConfiguration;

public class PivotReportRendererConfiguration implements IReportRendererConfiguration {

	public static final String ID = "Pivot";
	public static final String FILE_EXTENSION = "pivot.html";
	
	private boolean isExport;
	private File file;
	private Writer writer;
	private Language language;
	
	public PivotReportRendererConfiguration() {
	}

	public boolean isExport() {
		return isExport;
	}

	public PivotReportRendererConfiguration setExport(boolean isExport) {
		this.isExport = isExport;
		return this;
	}

	@Override	
	public File getOutputFile() {
		return file;
	}

	public PivotReportRendererConfiguration setOutputFile(File file) {
		this.file = file;
		return this;
	}

	@Override
	public Writer getOutputWriter() {
		return writer;
	}

	public PivotReportRendererConfiguration setOutputWriter(Writer writer) {
		this.writer = writer;
		return this;
	}

	public PivotReportRendererConfiguration setLanguage(Language language) {
		this.language = language;
		return this;
	}
	
	public Language getLanguage() {
		return language;
	}
	
}
