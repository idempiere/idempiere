package org.idempiere.zk.datatable;

import java.io.File;
import java.io.Writer;

import org.compiere.print.IHTMLExtension;
import org.compiere.util.Language;
import org.idempiere.print.renderer.IReportRendererConfiguration;

public class DatatableReportRendererConfiguration implements IReportRendererConfiguration {

	public static final String ID = "Datatables";
	public static final String FILE_EXTENSION = "datatables.html";
	
	private boolean onlyTable;
	private IHTMLExtension extension;
	private boolean isExport;
	private File file;
	private Writer writer;
	private Language language;
	
	public DatatableReportRendererConfiguration() {
	}

	public boolean isOnlyTable() {
		return onlyTable;
	}

	public DatatableReportRendererConfiguration setOnlyTable(boolean onlyTable) {
		this.onlyTable = onlyTable;
		return this;
	}

	public IHTMLExtension getExtension() {
		return extension;
	}

	public DatatableReportRendererConfiguration setExtension(IHTMLExtension extension) {
		this.extension = extension;
		return this;
	}

	public boolean isExport() {
		return isExport;
	}

	public DatatableReportRendererConfiguration setExport(boolean isExport) {
		this.isExport = isExport;
		return this;
	}

	@Override	
	public File getOutputFile() {
		return file;
	}

	public DatatableReportRendererConfiguration setOutputFile(File file) {
		this.file = file;
		return this;
	}

	@Override
	public Writer getOutputWriter() {
		return writer;
	}

	public DatatableReportRendererConfiguration setOutputWriter(Writer writer) {
		this.writer = writer;
		return this;
	}

	public DatatableReportRendererConfiguration setLanguage(Language language) {
		this.language = language;
		return this;
	}
	
	public Language getLanguage() {
		return language;
	}
	
}
