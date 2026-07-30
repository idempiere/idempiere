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
package org.adempiere.webui.window;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Supplier;
import java.util.logging.Level;

import org.adempiere.webui.window.IReportViewerExportSource.ExportFormat;
import org.compiere.model.MSysConfig;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.idempiere.ui.zk.media.Medias;
import org.idempiere.print.IReportContentRenderer;
import org.idempiere.print.ReportContentType;
import org.zkoss.util.media.AMedia;

import com.google.common.net.MediaType;

import net.sf.jasperreports.engine.DefaultJasperReportsContext;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReportsContext;
import net.sf.jasperreports.engine.SimpleJasperReportsContext;
import net.sf.jasperreports.engine.export.HtmlExporter;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.SimpleCsvExporterConfiguration;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleHtmlExporterOutput;
import net.sf.jasperreports.export.SimpleHtmlReportConfiguration;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimpleWriterExporterOutput;
import net.sf.jasperreports.export.SimpleXlsReportConfiguration;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;

/**
 * Media renderer for JasperPrint
 */
public class JasperPrintRenderer implements IReportContentRenderer {

	protected JasperPrint jasperPrint;

	protected final Map<String, Supplier<File>> mediaSuppliers = new HashMap<String, Supplier<File>>();

	private String title;

	private List<JasperPrint> jasperPrintList;
	
	private boolean isList;
	
	private static final CLogger log = CLogger.getCLogger(JasperPrintRenderer.class);
	
	private File pdfFile;

	private int rowCount;

	private final ReportContentType[] supportedContentTypes = new ReportContentType[] {
			new ReportContentType(Msg.getMsg(Env.getCtx(), "FilePDF"), Medias.PDF_FILE_EXT, Medias.PDF_MIME_TYPE),
			new ReportContentType(Msg.getMsg(Env.getCtx(), "FileHTML"), Medias.HTML_FILE_EXT, Medias.HTML_MIME_TYPE),
			new ReportContentType(Msg.getMsg(Env.getCtx(), "FileCSV"), Medias.CSV_FILE_EXT, Medias.CSV_MIME_TYPE),
			new ReportContentType(Msg.getMsg(Env.getCtx(), "FileXLS"), Medias.EXCEL_FILE_EXT, Medias.EXCEL_MIME_TYPE),
			new ReportContentType(Msg.getMsg(Env.getCtx(), "FileXLSX"), Medias.EXCEL_XML_FILE_EXT, Medias.EXCEL_XML_MIME_TYPE),
			new ReportContentType(Msg.getMsg(Env.getCtx(), "FileSSV"), Medias.SSV_FILE_EXT, Medias.CSV_MIME_TYPE)
	};
	
	/**
	 * @param jasperPrint
	 * @param title
	 */
	public JasperPrintRenderer(JasperPrint jasperPrint, String title) {
		this.jasperPrint = jasperPrint;
		this.title = title;
		isList = false;
		initMediaSuppliers();
	}

	/**
	 * @param jasperPrintList
	 * @param title
	 */
	public JasperPrintRenderer(java.util.List<JasperPrint> jasperPrintList, String title) {
		this.jasperPrintList = jasperPrintList;
		this.title = title;
		isList = true;
		initMediaSuppliers();
	}
	
	/**
	 * Create exporter for supported format type (html, pdf, etc)
	 */
	private void initMediaSuppliers() {
		mediaSuppliers.put(toMediaType(Medias.PDF_MIME_TYPE, Medias.PDF_FILE_EXT), () -> {
			try {
				createPDF();
				return pdfFile;
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
		
		mediaSuppliers.put(toMediaType(Medias.HTML_MIME_TYPE, Medias.HTML_FILE_EXT), () -> {
			try {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, "."+Medias.HTML_FILE_EXT, new File(path));
	
				HtmlExporter exporter = new HtmlExporter();
				SimpleHtmlReportConfiguration htmlConfig = new SimpleHtmlReportConfiguration();
				htmlConfig.setEmbedImage(true);
				htmlConfig.setAccessibleHtml(true);
				if (!isList){
					jasperPrintList = new ArrayList<>();
					jasperPrintList.add(jasperPrint);
				}
				exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
				exporter.setExporterOutput(new SimpleHtmlExporterOutput(file));
				exporter.setConfiguration(htmlConfig);
		 	    exporter.exportReport();
				return file;
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
		
		mediaSuppliers.put(toMediaType(Medias.EXCEL_MIME_TYPE, Medias.EXCEL_FILE_EXT), () -> {
			try {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, ".xls", new File(path));
				FileOutputStream fos = null;
				try {
			        fos = new FileOutputStream(file);
		
					// coding For Excel:
					JRXlsExporter exporterXLS = new JRXlsExporter();
					SimpleXlsReportConfiguration xlsConfig = new SimpleXlsReportConfiguration();
					xlsConfig.setOnePagePerSheet(false);
		
					if (!isList){
						jasperPrintList = new ArrayList<>();
						jasperPrintList.add(jasperPrint);
					}
					validateJasperPrintNameForExcelExporter(jasperPrintList);
					exporterXLS.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
					exporterXLS.setExporterOutput(new SimpleOutputStreamExporterOutput(fos));
					exporterXLS.setConfiguration(xlsConfig);
					exporterXLS.exportReport();
				} finally {
					if (fos != null)
						fos.close();
				}
				return file;
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
		
		mediaSuppliers.put(toMediaType(Medias.EXCEL_XML_MIME_TYPE, Medias.EXCEL_XML_FILE_EXT), () -> {
			try {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, "."+Medias.EXCEL_XML_FILE_EXT, new File(path));
				FileOutputStream fos = null;
				try {
			        fos = new FileOutputStream(file);
	
					// coding For Excel:
					JRXlsxExporter exporterXLSX = new JRXlsxExporter();
					SimpleXlsxReportConfiguration xlsxConfig = new SimpleXlsxReportConfiguration();
					xlsxConfig.setOnePagePerSheet(false);
		
					if (!isList){
						jasperPrintList = new ArrayList<>();
						jasperPrintList.add(jasperPrint);
					}
					validateJasperPrintNameForExcelExporter(jasperPrintList);
					exporterXLSX.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
					exporterXLSX.setExporterOutput(new SimpleOutputStreamExporterOutput(fos));
					exporterXLSX.setConfiguration(xlsxConfig);
					exporterXLSX.exportReport();
				} finally {
					if (fos != null)
						fos.close();
				}
				return file;
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
		
		mediaSuppliers.put(toMediaType(Medias.CSV_MIME_TYPE, Medias.CSV_FILE_EXT), () -> {
			try {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, "."+Medias.CSV_FILE_EXT, new File(path));
				FileOutputStream fos = null;
				try {
			        fos = new FileOutputStream(file);
					JRCsvExporter exporter= new JRCsvExporter();
					SimpleCsvExporterConfiguration csvConfig = new SimpleCsvExporterConfiguration();
					csvConfig.setEscapeFormula(MSysConfig.getBooleanValue(MSysConfig.CSV_EXPORT_SANITIZATION, true, Env.getAD_Client_ID(Env.getCtx())));
					if (!isList){
						jasperPrintList = new ArrayList<>();
						jasperPrintList.add(jasperPrint);
					}
					exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
					exporter.setExporterOutput(new SimpleWriterExporterOutput(fos));
					exporter.setConfiguration(csvConfig);
					exporter.exportReport();
				} finally {
					if (fos != null)
						fos.close();
				}	
				return file;
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
		
		mediaSuppliers.put(toMediaType(Medias.CSV_MIME_TYPE, Medias.SSV_FILE_EXT), () -> {
			try {
				String path = System.getProperty("java.io.tmpdir");
				String prefix = null;
				if (isList)
					prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
				else
					prefix = makePrefix(jasperPrint.getName());
				if (prefix.length() < 3)
					prefix += "_".repeat(3-prefix.length());
				if (log.isLoggable(Level.FINE)) log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
				File file = File.createTempFile(prefix, "."+Medias.SSV_FILE_EXT, new File(path));
				FileOutputStream fos = null;
				try {
					fos = new FileOutputStream(file);
					JRCsvExporter exporter= new JRCsvExporter();
					SimpleCsvExporterConfiguration csvConfig = new SimpleCsvExporterConfiguration();
					csvConfig.setFieldDelimiter(";");
					csvConfig.setEscapeFormula(MSysConfig.getBooleanValue(MSysConfig.CSV_EXPORT_SANITIZATION, true, Env.getAD_Client_ID(Env.getCtx())));
					if (!isList){
						jasperPrintList = new ArrayList<>();
						jasperPrintList.add(jasperPrint);
					}
					exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
					exporter.setExporterOutput(new SimpleWriterExporterOutput(fos));
					exporter.setConfiguration(csvConfig);
					exporter.exportReport();
				} finally {
					if (fos != null)
						fos.close();
				}
				return file;
			} catch (Exception e) {
				if (e instanceof RuntimeException)
					throw (RuntimeException)e;
				else
					throw new RuntimeException(e);
			}
		});
	}

	/**
	 * Replace characters from JasperPrint.Name that causes error for excel (xls & xlsx) export with _
	 * @param jaspers
	 */
	private void validateJasperPrintNameForExcelExporter(List<JasperPrint> jaspers) {
		for(JasperPrint jasper : jaspers) {
			String name = makePrefix(jasper.getName());
			if (!name.equals(jasper.getName()))
				jasper.setName(name);
		}
	}

	/**
	 * Create media output for requested contentType+fileExtension
	 * @param contentType
	 * @param fileExtension
	 * @return media
	 */
	@Override
	public File getContent(String contentType, String fileExtension) {
		Supplier<File> supplier = mediaSuppliers.get(toMediaType(contentType, fileExtension));
		return supplier != null ? supplier.get() : null;
	}

	@Override
	public ReportContentType[] getSupportedContentTypes() {
		return supportedContentTypes;
	}

	/**
	 * Creates ZK media for legacy viewer consumers.
	 * @param contentType MIME type
	 * @param fileExtension file extension
	 * @return media or {@code null}
	 */
	public AMedia getMedia(String contentType, String fileExtension) {
		File file = getContent(contentType, fileExtension);
		if (file == null)
			return null;
		try {
			return new AMedia(file.getName(), fileExtension, contentType, file, true);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
	}

	/**
	 * Gets ZK export formats for legacy viewer consumers.
	 * @return export formats
	 */
	public ExportFormat[] getExportFormats() {
		return java.util.Arrays.stream(getSupportedContentTypes())
				.map(type -> new ExportFormat(type.name(), type.fileExtension(), type.contentType()))
				.toArray(ExportFormat[]::new);
	}
	
	/**
	 * Get supported preview types
	 * @param canExport true if role has export right
	 * @return preview types
	 */
	public static ValueNamePair[] getPreviewType(boolean canExport) {
		List<ValueNamePair> list = new ArrayList<ValueNamePair>();
		if (canExport) {
			list.add(new ValueNamePair(ZkJRViewer.PDF_OUTPUT_TYPE, ZkJRViewer.PDF_OUTPUT_TYPE));
			list.add(new ValueNamePair(ZkJRViewer.HTML_OUTPUT_TYPE, ZkJRViewer.HTML_OUTPUT_TYPE));
			list.add(new ValueNamePair(ZkJRViewer.XLS_OUTPUT_TYPE, ZkJRViewer.XLS_OUTPUT_TYPE));
			list.add(new ValueNamePair(ZkJRViewer.CSV_OUTPUT_TYPE, ZkJRViewer.CSV_OUTPUT_TYPE));
			list.add(new ValueNamePair(ZkJRViewer.XLSX_OUTPUT_TYPE, ZkJRViewer.XLSX_OUTPUT_TYPE));
		} else {
			list.add(new ValueNamePair(ZkJRViewer.PDF_OUTPUT_TYPE, ZkJRViewer.PDF_OUTPUT_TYPE));
			list.add(new ValueNamePair(ZkJRViewer.HTML_OUTPUT_TYPE, ZkJRViewer.HTML_OUTPUT_TYPE));
		}
		
		return list.toArray(new ValueNamePair[0]);
	}
	
	/**
	 * Construct media supplier key
	 * @param contentType
	 * @param fileExtension
	 * @return contentType + ; + fileExtension
	 */
	private String toMediaType(String contentType, String fileExtension) {
		return contentType + ";" + fileExtension;
	}
	
	/**
	 * Create file name prefix from name
	 * @param name
	 * @return file name prefix
	 */
	private String makePrefix(String name) {
		StringBuilder prefix = new StringBuilder();
		char[] nameArray = name.toCharArray();
		for (char ch : nameArray) {
			if (Character.isLetterOrDigit(ch)) {
				prefix.append(ch);
			} else {
				prefix.append("_");
			}
		}
		return prefix.toString();
	}
	
	/**
	 * Create PDF output
	 * @return PDF file
	 * @throws IOException
	 * @throws JRException
	 */
	protected File createPDF() throws IOException, JRException {
		String path = System.getProperty("java.io.tmpdir");

		String prefix = null;
		if (isList)
			prefix = makePrefix(jasperPrintList.get(0).getName())+"_List";
		else
			prefix = makePrefix(jasperPrint.getName());

		if (log.isLoggable(Level.FINE))
		{
			log.log(Level.FINE, "Path="+path + " Prefix="+prefix);
		}
		pdfFile = new File(FileUtil.getTempMailName(prefix, "."+Medias.PDF_FILE_EXT));
		JasperReportsContext context = new SimpleJasperReportsContext(DefaultJasperReportsContext.getInstance());
		JRPdfExporter exporter = new JRPdfExporter(context);
		if (!isList){
			jasperPrintList = new ArrayList<>();
			jasperPrintList.add(jasperPrint);
		}
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(pdfFile));
		exporter.exportReport();
		return pdfFile;
	}
	
	/**
	 * Get generated PDF file
	 * @return pdf file or null
	 */
	protected File getPDF() {
		return pdfFile;
	}

	/**
	 * Set row count
	 * @param rowCount
	 */
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}
	
	/**
	 * Get row count
	 * @return
	 */
	@Override
	public int getRowCount() {
		return rowCount;
	}
	
	/**
	 * Get MIME type
	 * @param outputType
	 * @return MIME type
	 */
	public static String getMIMEType(String outputType) {
		if (ZkJRViewer.PDF_OUTPUT_TYPE.equals(outputType)) {
			return Medias.PDF_MIME_TYPE;
		} else if (ZkJRViewer.HTML_OUTPUT_TYPE.equals(outputType)) {
			return Medias.HTML_MIME_TYPE;
		} else if (ZkJRViewer.XLS_OUTPUT_TYPE.equals(outputType)) {
			return Medias.EXCEL_MIME_TYPE;
		} else if (ZkJRViewer.XLSX_OUTPUT_TYPE.equals(outputType)) {
			return Medias.EXCEL_XML_MIME_TYPE;
		} else if (ZkJRViewer.CSV_OUTPUT_TYPE.equals(outputType)) {
			return Medias.CSV_MIME_TYPE;
		} else {
			return MediaType.APPLICATION_BINARY.toString();
		}
	}
	
	/**
	 * Get file extension
	 * @param outputType
	 * @return file extension
	 */
	public static String getFileExtension(String outputType) {
		if (ZkJRViewer.PDF_OUTPUT_TYPE.equals(outputType)) {
			return Medias.PDF_FILE_EXT;
		} else if (ZkJRViewer.HTML_OUTPUT_TYPE.equals(outputType)) {
			return Medias.HTML_FILE_EXT;
		} else if (ZkJRViewer.XLS_OUTPUT_TYPE.equals(outputType)) {
			return Medias.EXCEL_FILE_EXT;
		} else if (ZkJRViewer.XLSX_OUTPUT_TYPE.equals(outputType)) {
			return Medias.EXCEL_XML_FILE_EXT;
		} else if (ZkJRViewer.CSV_OUTPUT_TYPE.equals(outputType)) {
			return Medias.CSV_FILE_EXT;
		} else {
			return ".binary";
		}
	}
}
