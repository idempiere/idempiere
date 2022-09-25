/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.print;

import static org.compiere.model.SystemIDs.PROCESS_RPT_M_INVENTORY;
import static org.compiere.model.SystemIDs.PROCESS_RPT_M_MOVEMENT;

import java.awt.Color;
import java.awt.Font;
import java.awt.print.PrinterJob;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.logging.Level;

import javax.print.DocFlavor;
import javax.print.StreamPrintService;
import javax.print.StreamPrintServiceFactory;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.standard.Copies;
import javax.print.attribute.standard.JobName;
import javax.print.event.PrintServiceAttributeEvent;
import javax.print.event.PrintServiceAttributeListener;
import javax.xml.transform.stream.StreamResult;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pdf.Document;
import org.adempiere.print.export.PrintDataExcelExporter;
import org.adempiere.print.export.PrintDataXLSXExporter;
import org.apache.ecs.XhtmlDocument;
import org.apache.ecs.xhtml.a;
import org.apache.ecs.xhtml.script;
import org.apache.ecs.xhtml.style;
import org.apache.ecs.xhtml.table;
import org.apache.ecs.xhtml.tbody;
import org.apache.ecs.xhtml.td;
import org.apache.ecs.xhtml.th;
import org.apache.ecs.xhtml.thead;
import org.apache.ecs.xhtml.tr;
import org.compiere.model.I_AD_PrintFormat;
import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MDunningRunEntry;
import org.compiere.model.MInOut;
import org.compiere.model.MInventory;
import org.compiere.model.MInvoice;
import org.compiere.model.MMovement;
import org.compiere.model.MOrder;
import org.compiere.model.MPaySelectionCheck;
import org.compiere.model.MProcess;
import org.compiere.model.MProject;
import org.compiere.model.MQuery;
import org.compiere.model.MRfQResponse;
import org.compiere.model.MRole;
import org.compiere.model.MStyle;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.PrintInfo;
import org.compiere.model.X_AD_StyleLine;
import org.compiere.print.layout.InstanceAttributeColumn;
import org.compiere.print.layout.InstanceAttributeData;
import org.compiere.print.layout.LayoutEngine;
import org.compiere.print.layout.PrintDataEvaluatee;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ServerProcessCtl;
import org.compiere.tools.FileUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluator;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.eevolution.model.MDDOrder;
import org.eevolution.model.X_PP_Order;

import com.googlecode.htmlcompressor.compressor.HtmlCompressor;

/**
 *	Report Engine.
 *  For a given PrintFormat,
 *  create a Report
 *  <p>
 *  Change log:
 *  <ul>
 *  <li>2007-02-12 - teo_sarca - [ 1658127 ] Select charset encoding on import
 *  <li>2007-02-10 - teo_sarca - [ 1652660 ] Save XML,HTML,CSV should have utf8 charset
 *  <li>2009-02-06 - globalqss - [ 2574162 ] Priority to choose invoice print format not working
 *  <li>2009-07-10 - trifonnt - [ 2819637 ] Wrong print format on non completed order
 *  </ul>
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: ReportEngine.java,v 1.4 2006/10/08 06:52:51 comdivision Exp $
 * 
 * @author Teo Sarca, www.arhipac.ro
 * 			<li>BF [ 2828300 ] Error when printformat table differs from DOC_TABLES
 * 				https://sourceforge.net/p/adempiere/bugs/1995/
 * 			<li>BF [ 2828886 ] Problem with reports from temporary tables
 * 				https://sourceforge.net/p/adempiere/bugs/2000/
 * 
 *  FR 2872010 - Dunning Run for a complete Dunning (not just level) - Developer: Carlos Ruiz - globalqss - Sponsor: Metas
 */
public class ReportEngine implements PrintServiceAttributeListener
{
	
	/**
	 *	Constructor
	 * 	@param ctx context
	 *  @param pf Print Format
	 *  @param query Optional Query
	 *  @param info print info
	 */
	public ReportEngine (Properties ctx, MPrintFormat pf, MQuery query, PrintInfo info)
	{
		this(ctx, pf, query, info, null);
	}	//	ReportEngine
	
	/**
	 * Set report engine with summary and null transaction
	 * @param ctx
	 * @param pf
	 * @param query
	 * @param info
	 * @param isSummary
	 */
	public ReportEngine (Properties ctx, MPrintFormat pf, MQuery query, PrintInfo info, boolean isSummary)
	{
		this(ctx, pf, query, info, isSummary, null);
	}	//	ReportEngine
	
	/**
	 * Set report engine with summary = false
	 * @param ctx
	 * @param pf
	 * @param query
	 * @param info
	 * @param trxName
	 */
	public ReportEngine (Properties ctx, MPrintFormat pf, MQuery query, PrintInfo info, String trxName){
		this(ctx, pf, query, info, false, trxName);
	}
	
	/**
	 *	Constructor
	 * 	@param ctx context
	 *  @param pf Print Format
	 *  @param query Optional Query
	 *  @param info print info
	 *  @param isSummary
	 *  @param trxName
	 */
	public ReportEngine (Properties ctx, MPrintFormat pf, MQuery query, PrintInfo info, boolean isSummary, String trxName)
	{
		this(ctx, pf, query, info, false, trxName, 0);
	}

	/**
	 * Set report engine with summary = false
	 * @param ctx
	 * @param pf
	 * @param query
	 * @param info
	 * @param trxName
	 * @param windowNo
	 */
	public ReportEngine (Properties ctx, MPrintFormat pf, MQuery query, PrintInfo info, String trxName, int windowNo){
		this(ctx, pf, query, info, false, trxName, windowNo);
	}

	/**
	 *	Constructor
	 * 	@param ctx context
	 *  @param pf Print Format
	 *  @param query Optional Query
	 *  @param info print info
	 *  @param isSummary
	 *  @param trxName
	 *  @param windowNo
	 */
	public ReportEngine (Properties ctx, MPrintFormat pf, MQuery query, PrintInfo info, boolean isSummary, String trxName, int windowNo)
	{
		m_summary = isSummary;
		if (pf == null)
			throw new IllegalArgumentException("ReportEngine - no PrintFormat");
		if (log.isLoggable(Level.INFO)) log.info(pf + " -- " + query);
		m_ctx = ctx;
		//
		m_printFormat = pf;
		m_info = info;
		m_trxName = trxName;
		m_windowNo = windowNo;
		initName();
		setQuery(query);		//	loads Data
		
	}	//	ReportEngine

	/**	Static Logger	*/
	private static CLogger	log	= CLogger.getCLogger (ReportEngine.class);

	/**	Context					*/
	private Properties		m_ctx;

	/**	Print Format			*/
	private MPrintFormat	m_printFormat;
	/** Print Info				*/
	private PrintInfo		m_info;
	/**	Query					*/
	private MQuery			m_query;
	/**	Query Data				*/
	private PrintData		m_printData;
	/** Layout					*/
	private LayoutEngine 	m_layout = null;
	/**	Printer					*/
	private String			m_printerName = Ini.getProperty(Ini.P_PRINTER);	
	/** Transaction Name 		*/
	private String 			m_trxName = null;
	/** Where filter */
	private String 			m_whereExtended = null;
	/** Window */
	private int m_windowNo = 0;
	
	private int m_language_id = 0;
	
	private boolean m_summary = false;
	
	private String m_name = null;
	
	private boolean m_isReplaceTabContent = false;
	
	/**
	 * store all column has same css rule into a list
	 * for IDEMPIERE-2640
	 */
	private Map<CSSInfo, List<ColumnInfo>> mapCssInfo = new HashMap<CSSInfo, List<ColumnInfo>>();
	
	private List<IReportEngineEventListener> eventListeners = new ArrayList<IReportEngineEventListener>();

	public void addEventListener(IReportEngineEventListener listener)
	{
		eventListeners.add(listener);
	}
	
	public boolean removeEventListener(IReportEngineEventListener listener)
	{
		return eventListeners.remove(listener);
	}
	
	/**
	 * 	Set PrintFormat.
	 *  If Layout was created, re-create layout
	 * 	@param pf print format
	 */
	public void setPrintFormat (MPrintFormat pf)
	{
		m_printFormat = pf;
		pf.reloadItems();
		if (m_layout != null)
		{
			setPrintData();
			m_layout.setPrintFormat(pf, false);
			m_layout.setPrintData(m_printData, m_query, true);	//	format changes data
		}
		
		IReportEngineEventListener[] listeners = eventListeners.toArray(new IReportEngineEventListener[0]);
		for(IReportEngineEventListener listener : listeners)
		{
			listener.onPrintFormatChanged(new ReportEngineEvent(this));
		}
	}	//	setPrintFormat
	
	/**
	 * 	Set Query and generate PrintData.
	 *  If Layout was created, re-create layout
	 * 	@param query query
	 */
	public void setQuery (MQuery query)
	{
		m_query = query;
		if (query == null)
			return;
		//
		setPrintData();
		if (m_layout != null)
			m_layout.setPrintData(m_printData, m_query, true);
		
		IReportEngineEventListener[] listeners = eventListeners.toArray(new IReportEngineEventListener[0]);
		for(IReportEngineEventListener listener : listeners)
		{
			listener.onQueryChanged(new ReportEngineEvent(this));
		}
	}	//	setQuery

	/**
	 * 	Get Query
	 * 	@return query
	 */
	public MQuery getQuery()
	{
		return m_query;
	}	//	getQuery

	/**
	 * 	Set PrintData for Format restricted by Query.
	 * 	Nothing set if there is no query
	 *  Sets m_printData
	 */
	private void setPrintData()
	{
		if (m_query == null)
			return;
		
		DataEngine de = new DataEngine(m_printFormat.getLanguage(),m_trxName, m_windowNo);
		setPrintData(de.getPrintData (m_ctx, m_printFormat, m_query, m_summary));
	//	m_printData.dump();
	}	//	setPrintData


	/**
	 * 	Get PrintData
	 * 	@return print data
	 */
	public PrintData getPrintData()
	{
		return m_printData;
	}	//	getPrintData

	/**
	 * 	Set PrintData
	 * 	@param printData printData
	 */
	public void setPrintData (PrintData printData)
	{
		if (printData == null)
			return;
		m_printData = printData;
	}	//	setPrintData

	
	/**************************************************************************
	 * 	Layout
	 */
	private void layout()
	{
		if (m_printFormat == null)
			throw new IllegalStateException ("No print format");
		if (m_printData == null)
			throw new IllegalStateException ("No print data (Delete Print Format and restart)");
		m_layout = new LayoutEngine (m_printFormat, m_printData, m_query, m_info, m_trxName, m_windowNo);
	}	//	layout

	/**
	 * 	Get Layout
	 *  @return Layout
	 */
	public LayoutEngine getLayout()
	{
		if (m_layout == null)
			layout();
		return m_layout;
	}	//	getLayout

	/**
	 * 	Initialize Report Name
	 */
	public void initName()
	{
		Language language = m_printFormat.getLanguage();
		String processFileNamePattern = m_printFormat.get_Translation(MPrintFormat.COLUMNNAME_FileNamePattern, language.getAD_Language());
	 	if (m_info.getAD_Process_ID()>0) {
			MProcess process = new MProcess(Env.getCtx(), m_info.getAD_Process_ID(), m_trxName);
			if (process !=null && !Util.isEmpty(process.getFileNamePattern())) {
				processFileNamePattern = process.getFileNamePattern();
			}
		}  

		if(Util.isEmpty(processFileNamePattern)) {
			m_name = m_printFormat.get_Translation(MPrintFormat.COLUMNNAME_Name);
		} else {
			m_name = FileUtil.parseTitle(m_ctx, processFileNamePattern, m_info.getAD_Table_ID(), m_info.getRecord_ID(), m_windowNo, m_trxName);
		}
	}	//	initName
	
	/**
	 * 	Get PrintFormat (Report) Name
	 * 	@return name
	 */
	public String getName()
	{
		if (m_name==null)
			initName();
		return m_name;
	}	//	getName

	/**
	 * 	Get PrintFormat
	 * 	@return print format
	 */
	public MPrintFormat getPrintFormat()
	{
		return m_printFormat;
	}	//	getPrintFormat

	/**
	 * 	Get Print Info
	 *	@return info
	 */
	public PrintInfo getPrintInfo()
	{
		return m_info;
	}	//	getPrintInfo
	
	/**
	 * 	Get PrintLayout (Report) Context
	 * 	@return context
	 */
	public Properties getCtx()
	{
		return m_ctx;
	}	//	getCtx
	
	/**
	 * 	Get Row Count
	 * 	@return row count
	 */
	public int getRowCount()
	{
		return m_printData.getRowCount();
	}	//	getRowCount

	/**
	 * 	Get Column Count
	 * 	@return column count
	 */
	public int getColumnCount()
	{
		if (m_layout != null)
			return m_layout.getColumnCount();
		return 0;
	}	//	getColumnCount

	
	/**************************************************************************
	 * 	Print Report
	 */
	public void print ()
	{
		if (log.isLoggable(Level.INFO)) log.info(m_info.toString());
		if (m_layout == null)
			layout();
		
		//	Paper Attributes: 	media-printable-area, orientation-requested, media
		PrintRequestAttributeSet prats = m_layout.getPaper().getPrintRequestAttributeSet();
		//	add:				copies, job-name, priority
		if (m_info.isDocumentCopy() || m_info.getCopies() < 1)
			prats.add (new Copies(1));
		else
			prats.add (new Copies(m_info.getCopies()));
		Locale locale = Language.getLoginLanguage().getLocale();
		prats.add(new JobName(m_printFormat.getName(), locale));
		prats.add(PrintUtil.getJobPriority(m_layout.getNumberOfPages(), m_info.getCopies(), true));

		try
		{
			//	PrinterJob
			PrinterJob job = getPrinterJob(m_info.getPrinterName());
		//	job.getPrintService().addPrintServiceAttributeListener(this);
			job.setPageable(m_layout.getPageable(false));	//	no copy
		//	Dialog
			try
			{
				if (m_info.isWithDialog() && !job.printDialog(prats))
					return;
			}
			catch (Exception e)
			{
				log.log(Level.WARNING, "Operating System Print Issue, check & try again", e);
				return;
			}

		//	submit
			boolean printCopy = m_info.isDocumentCopy() && m_info.getCopies() > 1;
			ArchiveEngine.get().archive(m_layout, m_info);
			PrintUtil.print(job, prats, false, printCopy);

			//	Document: Print Copies
			if (printCopy)
			{
				if (log.isLoggable(Level.INFO)) log.info("Copy " + (m_info.getCopies()-1));
				prats.add(new Copies(m_info.getCopies()-1));
				job = getPrinterJob(m_info.getPrinterName());
				job.setPageable (m_layout.getPageable(true));		//	Copy
				PrintUtil.print(job, prats, false, false);
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
		}
	}	//	print

	/**
	 * 	Print Service Attribute Listener.
	 * 	@param psae event
	 */
	public void attributeUpdate(PrintServiceAttributeEvent psae)
	{
		/**
PrintEvent on Win32 Printer : \\MAIN\HP LaserJet 5L
PrintServiceAttributeSet - length=2
queued-job-count = 0  (class javax.print.attribute.standard.QueuedJobCount)
printer-is-accepting-jobs = accepting-jobs  (class javax.print.attribute.standard.PrinterIsAcceptingJobs)
PrintEvent on Win32 Printer : \\MAIN\HP LaserJet 5L
PrintServiceAttributeSet - length=1
queued-job-count = 1  (class javax.print.attribute.standard.QueuedJobCount)
PrintEvent on Win32 Printer : \\MAIN\HP LaserJet 5L
PrintServiceAttributeSet - length=1
queued-job-count = 0  (class javax.print.attribute.standard.QueuedJobCount)
		**/
		if (log.isLoggable(Level.FINE)) log.fine("attributeUpdate - " + psae);
	}	//	attributeUpdate


	/**
	 * 	Get PrinterJob based on PrinterName
	 * 	@param printerName optional Printer Name
	 * 	@return PrinterJob
	 */
	private PrinterJob getPrinterJob (String printerName)
	{
		if (printerName != null && printerName.length() > 0)
			return PrintUtil.getPrinterJob(printerName);
		return PrintUtil.getPrinterJob(m_printerName);
	}	//	getPrinterJob

	/**
	 * 	Show Dialog and Set Paper
	 *  Optionally re-calculate layout
	 */
	public void pageSetupDialog ()
	{
		if (m_layout == null)
			layout();
		m_layout.pageSetupDialog(getPrinterJob(m_printerName));
		
		IReportEngineEventListener[] listeners = eventListeners.toArray(new IReportEngineEventListener[0]);
		for(IReportEngineEventListener listener : listeners)
		{
			listener.onPageSetupChanged(new ReportEngineEvent(this));
		}
	}	//	pageSetupDialog

	/**
	 * 	Set Printer (name)
	 * 	@param printerName valid printer name
	 */
	public void setPrinterName(String printerName)
	{
		if (printerName == null)
			m_printerName = Ini.getProperty(Ini.P_PRINTER);
		else
			m_printerName = printerName;
	}	//	setPrinterName

	/**
	 * 	Get Printer (name)
	 * 	@return printer name
	 */
	public String getPrinterName()
	{
		return m_printerName;
	}	//	getPrinterName

	/**************************************************************************
	 * 	Create HTML File
	 * 	@param file file
	 *  @param onlyTable if false create complete HTML document
	 *  @param language optional language - if null the default language is used to format nubers/dates
	 * 	@return true if success
	 */
	public boolean createHTML (File file, boolean onlyTable, Language language)
	{
		return createHTML(file, onlyTable, language, null);
	}
	
	/**************************************************************************
	 * 	Create HTML File
	 * 	@param file file
	 *  @param onlyTable if false create complete HTML document
	 *  @param language optional language - if null the default language is used to format nubers/dates
	 *  @param extension optional extension for html output
	 * 	@return true if success
	 */
	public boolean createHTML (File file, boolean onlyTable, Language language, IHTMLExtension extension)
	{
		try
		{
			Language lang = language;
			if (lang == null)
				lang = Language.getLoginLanguage();
			Writer fw = new OutputStreamWriter(new FileOutputStream(file, false), Ini.getCharset()); // teo_sarca: save using adempiere charset [ 1658127 ]
			return createHTML (new BufferedWriter(fw), onlyTable, lang, extension);
		}
		catch (FileNotFoundException fnfe)
		{
			log.log(Level.SEVERE, "(f) - " + fnfe.toString());
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(f)", e);
			throw new AdempiereException(e);
		}
		return false;
	}	//	createHTML

	/**
	 * 	Write HTML to writer
	 * 	@param writer writer
	 *  @param onlyTable if false create complete HTML document
	 *  @param language optional language - if null nubers/dates are not formatted
	 * 	@return true if success
	 */
	public boolean createHTML (Writer writer, boolean onlyTable, Language language)
	{
		return createHTML(writer, onlyTable, language, null);
	}
	
	/**
	 * 	Write HTML to writer with isExport = false
	 * 	@param writer writer
	 *  @param onlyTable if false create complete HTML document
	 *  @param language optional language - if null numbers/dates are not formatted
	 *  @param extension optional extension for html output
	 * 	@return true if success
	 */
	public boolean createHTML (Writer writer, boolean onlyTable, Language language, IHTMLExtension extension){
		return createHTML (writer, onlyTable, language, extension, false);
	}
	
	/**
	 * 	Write HTML to writer
	 * 	@param writer writer
	 *  @param onlyTable if false create complete HTML document
	 *  @param language optional language - if null numbers/dates are not formatted
	 *  @param extension optional extension for html output
	 *  @param isExport when isExport = true will don't embed resource dependent zk framework
	 * 	@return true if success
	 */
	public boolean createHTML (Writer writer, boolean onlyTable, Language language, IHTMLExtension extension, boolean isExport)
	{
		try
		{
			//collect column to print
			List<Object> columns = new ArrayList<>();
			List<InstanceAttributeData> asiElements = new ArrayList<>();
			int columnCount = 0;
			for (int col = 0; col < m_printFormat.getItemCount(); col++)
			{
				MPrintFormatItem item = m_printFormat.getItem(col);
				if (item.isPrinted())
				{
					if (item.isTypeField() && item.isPrintInstanceAttributes())
					{
						InstanceAttributeData asiElement = new InstanceAttributeData(item, columnCount);
						asiElement.readAttributesData(m_printData);
						asiElements.add(asiElement);						
						continue;
					}
					else 
					{
						columns.add(item);
						columnCount++;
					}
				}
			}
			if (asiElements.size() > 0)
			{
				int columnCreated = 0;
				for(InstanceAttributeData data : asiElements)
				{
					List<InstanceAttributeColumn> instanceColumns = data.getColumns();
					int index = data.getColumnIndex() + columnCreated;
					for(InstanceAttributeColumn c : instanceColumns)
					{
						columns.add(index, c);
						index++;
						columnCreated++;
					}
				}
			}
			
			String cssPrefix = extension != null ? extension.getClassPrefix() : null;
			if (cssPrefix != null && cssPrefix.trim().length() == 0)
				cssPrefix = null;
			
			table parameterTable = null;
			if (!m_printFormat.isForm()) {
				if (m_query != null && m_query.isActive()) {
					int rows = m_query.getReportProcessQuery() != null ? m_query.getReportProcessQuery().getRestrictionCount() : m_query.getRestrictionCount();
					if (rows > 0) {
						parameterTable = new table();
						if (cssPrefix != null)
							parameterTable.setClass(cssPrefix + "-parameter-table");
						else
							parameterTable.setClass("parameter-table");
						parameterTable.setNeedClosingTag(false);
					}
				}
			}
			
			table table = new table();
			if (cssPrefix != null)
				table.setClass(cssPrefix + "-table");
			//
			//
			table.setNeedClosingTag(false);
			PrintWriter w = new PrintWriter(writer);
			XhtmlDocument doc = null;
			boolean minify = MSysConfig.getBooleanValue(MSysConfig.HTML_REPORT_MINIFY, true, Env.getAD_Client_ID(getCtx()));
						
			if (onlyTable)
				w.print(compress(table.toString(), minify));
			else
			{
				doc = new XhtmlDocument();
				doc.getHtml().setNeedClosingTag(false);
				doc.getBody().setNeedClosingTag(false);
				doc.appendHead("<meta charset=\"UTF-8\" />");
				
				if (extension != null && extension.getStyleURL() != null)
				{
					// maybe cache style content with key is path
					String pathStyleFile = extension.getFullPathStyle(); // creates a temp file - delete below
					Path path = Paths.get(pathStyleFile);
				    List<String> styleLines = Files.readAllLines(path, Ini.getCharset());
				    Files.delete(path); // delete temp file
				    StringBuilder styleBuild = new StringBuilder();
				    for (String styleLine : styleLines){
				    	styleBuild.append(styleLine); //.append("\n");
				    }
				    appendInlineCss (doc, styleBuild);
				}
				if (extension != null && extension.getScriptURL() != null && !isExport)
				{
					script jslink = new script();
					jslink.setLanguage("javascript");
					jslink.setSrc(extension.getScriptURL());
					doc.appendHead(jslink);
				}
				
				if (extension != null && !isExport){
					extension.setWebAttribute(doc.getBody());
				}				
			}
			
			if (doc != null)
			{
				//IDEMPIERE-4113
				mapCssInfo.clear();
				MPrintFormatItem item = null;
				int printColIndex = -1;
				for(int col = 0; col < columns.size(); col++)
				{
					Object colobj = columns.get(col);
					if (colobj instanceof MPrintFormatItem)
						item = (MPrintFormatItem) colobj;
					else if (colobj instanceof InstanceAttributeColumn)
						item = ((InstanceAttributeColumn) colobj).getPrintFormatItem();
					if(item != null)
					{
						printColIndex++;
						addCssInfo(item, printColIndex);
					}
				}//IDEMPIERE-4113
				appendInlineCss(doc);
				
				StringBuilder styleBuild = new StringBuilder();
				MPrintTableFormat tf = m_printFormat.getTableFormat();
				CSSInfo cssInfo = new CSSInfo(tf.getPageHeader_Font(), tf.getPageHeaderFG_Color());
				if (cssPrefix != null) {
					if (parameterTable != null)
						styleBuild.append("."+cssPrefix + "-parameter-table th").append(cssInfo.getCssRule());						
					styleBuild.append("."+cssPrefix + "-table th").append(cssInfo.getCssRule());
				}
				else {
					if (parameterTable != null)						
						styleBuild.append("parameter-table th").append(cssInfo.getCssRule());
					styleBuild.append("table th").append(cssInfo.getCssRule());
				}
				
				cssInfo = new CSSInfo(tf.getParameter_Font(), tf.getParameter_Color());
				styleBuild.append(".tr-parameter td").append(cssInfo.getCssRule());
				
				cssInfo = new CSSInfo(tf.getFunct_Font(), tf.getFunctFG_Color());
				styleBuild.append(".tr-function td").append(cssInfo.getCssRule());
				
				MPrintFont printFont = MPrintFont.get(m_printFormat.getAD_PrintFont_ID());
				Font base = printFont.getFont();
				Font newFont = new Font(base.getName(), Font.PLAIN, base.getSize()-1);
				cssInfo = new CSSInfo(newFont, null);
				styleBuild.append(".tr-level-1 td").append(cssInfo.getCssRule());
				
				newFont = new Font(base.getName(), Font.PLAIN, base.getSize()-2);
				cssInfo = new CSSInfo(newFont, null);
				styleBuild.append(".tr-level-2 td").append(cssInfo.getCssRule());
				
				styleBuild = new StringBuilder(styleBuild.toString().replaceAll(";", "!important;"));
				appendInlineCss (doc, styleBuild);
				
				w.print(compress(doc.toString(), minify));
				
				w.print("<div class='"+cssPrefix+"-flex-container'>");
				String paraWrapId = null;
				if (parameterTable != null) {
					paraWrapId = cssPrefix + "-para-table-wrap";
					w.print("<div id='" + paraWrapId + "'>");
					w.print(compress(parameterTable.toString(), minify));
					
					tr tr = new tr();
					tr.setClass("tr-parameter");
					th th = new th();
					tr.addElement(th);
					th.addElement(Msg.getMsg(getCtx(), "Parameter") + ":");
					
					MQuery query = m_query;
					if (m_query.getReportProcessQuery() != null)
						query = m_query.getReportProcessQuery();
					for (int r = 0; r < query.getRestrictionCount(); r++)
					{
						if (r > 0) {
							tr = new tr();
							tr.setClass("tr-parameter");
							td td = new td();
							tr.addElement(td);
							td.addElement("&nbsp;");
						}
						
						td td = new td();
						tr.addElement(td);
						td.addElement(query.getInfoName(r));
						
						td = new td();
						tr.addElement(td);
						td.addElement(query.getInfoOperator(r));
						
						td = new td();
						tr.addElement(td);
						td.addElement(query.getInfoDisplayAll(r));
						
						w.print(compress(tr.toString(), minify));
					}
										
					w.print("</table>");
					w.print("</div>");
				}
				
				StringBuilder tableWrapDiv = new StringBuilder();
				tableWrapDiv.append("<div class='").append(cssPrefix).append("-table-wrap' ");
				if (paraWrapId != null) {
					tableWrapDiv.append("onscroll=\"if (this.scrollTop > 0) document.getElementById('")
						.append(paraWrapId).append("').style.display='none'; ")
						.append("else document.getElementById('").append(paraWrapId).append("').style.display='block';\"");
				}
				tableWrapDiv.append(" >");
				
				w.print(compress(tableWrapDiv.toString(), minify));
				w.print(compress(table.toString(), minify));
			}
			
			thead thead = new thead();
			tbody tbody = new tbody();
			tbody.setNeedClosingTag(false);
			
			Boolean [] colSuppressRepeats = m_layout == null || m_layout.colSuppressRepeats == null? LayoutEngine.getColSuppressRepeats(m_printFormat):m_layout.colSuppressRepeats;
			Object [] preValues = null;
			if (colSuppressRepeats != null){
				preValues = new Object [colSuppressRepeats.length];
			}

			int printColIndex = -1;
			HashMap<Integer, th> suppressMap = new HashMap<>();
			
			//	for all rows (-1 = header row)
			for (int row = -1; row < m_printData.getRowCount(); row++)
			{
				tr tr = new tr();
				if (row != -1)
				{
					m_printData.setRowIndex(row);					
					if (extension != null && !isExport)
					{
						extension.extendRowElement(tr, m_printData);
					}
					if (m_printData.isFunctionRow()) {
						tr.setClass(cssPrefix + "-functionrow");
					} else if ( row < m_printData.getRowCount() && m_printData.isFunctionRow(row+1)) {
						tr.setClass(cssPrefix + "-lastgrouprow");
					}
					// add row to table body
					//tbody.addElement(tr);
				} else {
					// add row to table header
					thead.addElement(tr);
				}
				
				printColIndex = -1;
				//	for all columns
				for (int col = 0; col < columns.size(); col++)
				{
					Object colObj = columns.get(col);
					MPrintFormatItem item = null;
					InstanceAttributeColumn instanceAttributeColumn = null;
					if (colObj instanceof MPrintFormatItem)
					{
						item = (MPrintFormatItem) colObj;
					}
					else if (colObj instanceof InstanceAttributeColumn)
					{
						instanceAttributeColumn = (InstanceAttributeColumn) colObj;
						item = instanceAttributeColumn.getPrintFormatItem();
					}
					if (item != null)
					{
						printColIndex++;
						//	header row
						if (row == -1)
						{
							th th = new th();
							tr.addElement(th);
							String columnHeader = instanceAttributeColumn != null ? instanceAttributeColumn.getName() : item.getPrintName(language);
							th.addElement(Util.maskHTML(columnHeader));
							if (cssPrefix != null && instanceAttributeColumn == null) 
							{
								MColumn column = MColumn.get(getCtx(), item.getAD_Column_ID());
								if (column != null && column.getAD_Column_ID() > 0)
								{
									if (DisplayType.isNumeric(column.getAD_Reference_ID()))
									{
										th.setClass(cssPrefix + "-number");
									}
								}
							}
							if (item.isSuppressNull()) 
							{
								suppressMap.put(printColIndex, th);
								th.setID("report-th-"+printColIndex);
							}
						}
						else
						{
							td td = new td();
							tr.addElement(td);
							//set style
							int AD_FieldStyle_ID = item.getAD_FieldStyle_ID();
							if(AD_FieldStyle_ID > 0) {
								MStyle style = MStyle.get(Env.getCtx(), AD_FieldStyle_ID);
								X_AD_StyleLine[] lines = style.getStyleLines();
								StringBuilder styleBuilder = new StringBuilder();
								for (X_AD_StyleLine line : lines)
								{
									String inlineStyle = line.getInlineStyle().trim();
									String displayLogic = line.getDisplayLogic();
									if (!Util.isEmpty(displayLogic))
									{
										if (!Evaluator.evaluateLogic(new PrintDataEvaluatee(null, m_printData), displayLogic))
											continue;
									}
									if (styleBuilder.length() > 0 && !(styleBuilder.charAt(styleBuilder.length()-1)==';'))
										styleBuilder.append("; ");
									styleBuilder.append(inlineStyle);
								}
								if(styleBuilder.length() > 0)
									td.setStyle(styleBuilder.toString());
							}
							//
							Object obj = instanceAttributeColumn != null ? instanceAttributeColumn.getPrintDataElement(row)
									: m_printData.getNodeByPrintFormatItemId(item.getAD_PrintFormatItem_ID());
							if (obj == null || !isDisplayPFItem(item)){
								td.addElement("&nbsp;");
								if (colSuppressRepeats != null && colSuppressRepeats[printColIndex]){
									preValues[printColIndex] = null;
								}
								if (item.isSuppressNull() && obj != null && suppressMap.containsKey(printColIndex))
									suppressMap.remove(printColIndex);
							}
							else if (obj instanceof PrintDataElement)
							{
								PrintDataElement pde = (PrintDataElement) obj;
								String value = pde.getValueDisplay(language);	//	formatted

								if (colSuppressRepeats != null && colSuppressRepeats[printColIndex]){
									if (value.equals(preValues[printColIndex])){
										td.addElement("&nbsp;");
										continue;
									}else{
										preValues[printColIndex] = value;
									}
								}

								if (item.isSuppressNull() && obj != null && suppressMap.containsKey(printColIndex))
									suppressMap.remove(printColIndex);
								
								if (pde.getColumnName().endsWith("_ID") && extension != null && !isExport)
								{
									boolean isZoom = false;
									if (item.getColumnName().equals("Record_ID")) {
										Object tablePDE = m_printData.getNode("AD_Table_ID");
										if (tablePDE != null && tablePDE instanceof PrintDataElement) {
											int tableID = -1;
											try {
												tableID = Integer.parseInt(((PrintDataElement)tablePDE).getValueAsString());
											} catch (Exception e) {
												tableID = -1;
											}
											if (tableID > 0) {
												MTable mTable = MTable.get(getCtx(), tableID);
												String tableName = mTable.getTableName();
												
												ArrayList<MColumn> list = new ArrayList<MColumn>();
												for (String idColumnName : mTable.getIdentifierColumns()) {
													MColumn column = mTable.getColumn(idColumnName);
													list.add (column);
												}
												if(list.size() > 0) {
													StringBuilder displayColumn = new StringBuilder();
													String separator = MSysConfig.getValue(MSysConfig.IDENTIFIER_SEPARATOR, "_", Env.getAD_Client_ID(Env.getCtx()));
													
													for(int i = 0; i < list.size(); i++) {
														MColumn identifierColumn = list.get(i);
														if(i > 0)
															displayColumn.append("||'").append(separator).append("'||");
														
														displayColumn.append("NVL(")
																	.append(DB.TO_CHAR(identifierColumn.getColumnName(), 
																						identifierColumn.getAD_Reference_ID(), 
																						Env.getAD_Language(Env.getCtx())))
																	.append(",'')");
													}
													StringBuilder sql = new StringBuilder("SELECT ");
													sql.append(displayColumn.toString());
													sql.append(" FROM ").append(tableName);
													sql.append(" WHERE ")
														.append(tableName).append(".").append(tableName).append("_ID=?");
													
													value = DB.getSQLValueStringEx(null, sql.toString(), Integer.parseInt(value));
												}
												String foreignColumnName = tableName + "_ID";
												pde.setForeignColumnName(foreignColumnName);
												isZoom = true;
											}
										}
									} else {
										isZoom = true;
									}
									if (isZoom) {
										// check permission on the zoomed window
										MTable mTable = MTable.get(getCtx(), pde.getForeignColumnName().substring(0, pde.getForeignColumnName().length()-3));
										int Record_ID = -1;
										try {
											Record_ID = Integer.parseInt(pde.getValueAsString());
										} catch (Exception e) {
											Record_ID = -1;
										}
							    		Boolean canAccess = null;
										if (Record_ID >= 0 && mTable != null) {
											int AD_Window_ID = Env.getZoomWindowID(mTable.get_ID(), Record_ID);
								    		canAccess = MRole.getDefault().getWindowAccess(AD_Window_ID);
										}
							    		if (canAccess == null) {
							    			isZoom = false;
							    		}
									}
									if (isZoom) {
										//link for column
										a href = new a("javascript:void(0)");									
										href.setID(pde.getColumnName() + "_" + row + "_a");									
										td.addElement(href);
										href.addElement(Util.maskHTML(value));
										if (cssPrefix != null)
											href.setClass(cssPrefix + "-href");
										extension.extendIDColumn(row, td, href, pde);
									} else {
										td.addElement(Util.maskHTML(value));
									}

								}
								else
								{
									td.addElement(Util.maskHTML(value));
								}
								if (cssPrefix != null)
								{
									if (DisplayType.isNumeric(pde.getDisplayType()))
										td.setClass(cssPrefix + "-number");
									else if (DisplayType.isDate(pde.getDisplayType()))
										td.setClass(cssPrefix + "-date");
									else
										td.setClass(cssPrefix + "-text");
								}											
							}
							else if (obj instanceof PrintData)
							{
								//	ignore contained Data
							}
							else
								log.log(Level.SEVERE, "Element not PrintData(Element) " + obj.getClass());
						}
					}	//	printed
				}	//	for all columns
				
				/* output table header */
				if (row == -1){
					w.print(compress(thead.toString(), minify));
					// output open of tbody
					w.print(compress(tbody.toString(), minify));
				}else{
					// output row by row 
					w.print(compress(tr.toString(), minify));
				}
				
			}	//	for all rows
			
			w.print("</tbody>");
			w.print("</table>");
			if (suppressMap.size() > 0) 
			{
				StringBuilder st = new StringBuilder();
				for(th t : suppressMap.values()) 
				{
					if (st.length() > 0)
						st.append(",");
					st.append("#").append(t.getAttribute("id"));
				}
				st.append(" {\n\t\tdisplay:none;\n\t}");
				style styleTag = new style();
				styleTag.addElement(st.toString());
				w.print(compress(styleTag.toString(), minify));
			}
			if (!onlyTable)
			{
				w.print("</div>");
				w.print("</div>");
				w.print("</body>");
				w.print("</html>");
			}
			w.flush();
			w.close();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(w)", e);
			throw new AdempiereException(e);
		}
		return true;
	}	//	createHTML


	private String getCSSFontFamily(String fontFamily) {
		if ("Dialog".equals(fontFamily) || "DialogInput".equals(fontFamily) || 	"Monospaced".equals(fontFamily))
		{
			return "monospace";
		} else if ("SansSerif".equals(fontFamily))
		{
			return "sans-serif";
		} else if ("Serif".equals(fontFamily))
		{
			return "serif";
		}
		return null;
	}

	/**************************************************************************
	 * 	Create CSV File
	 * 	@param file file
	 *  @param delimiter delimiter, e.g. comma, tab
	 *  @param language translation language
	 * 	@return true if success
	 */
	public boolean createCSV (File file, char delimiter, Language language)
	{
		try
		{
			Writer fw = new OutputStreamWriter(new FileOutputStream(file, false), Ini.getCharset()); // teo_sarca: save using adempiere charset [ 1658127 ]
			return createCSV (new BufferedWriter(fw), delimiter, language);
		}
		catch (FileNotFoundException fnfe)
		{
			log.log(Level.SEVERE, "(f) - " + fnfe.toString());
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(f)", e);
		}
		return false;
	}	//	createCSV

	/**
	 * 	Write CSV to writer
	 * 	@param writer writer
	 *  @param delimiter delimiter, e.g. comma, tab
	 *  @param language translation language
	 * 	@return true if success
	 */
	public boolean createCSV (Writer writer, char delimiter, Language language)
	{
		if (delimiter == 0)
			delimiter = '\t';
		try
		{
			//collect columns to be printed
			ArrayList<Object> columns = new ArrayList<>();
			List<InstanceAttributeData> asiElements = new ArrayList<>();
			int columnCount = 0;
			for (int col = 0; col < m_printFormat.getItemCount(); col++)
			{
				MPrintFormatItem item = m_printFormat.getItem(col);
				if (item.isPrinted())
				{
					if (item.isTypeField() && item.isPrintInstanceAttributes())
					{
						InstanceAttributeData asiElement = new InstanceAttributeData(item, columnCount);
						asiElement.readAttributesData(m_printData);
						asiElements.add(asiElement);						
						continue;
					}
					else 
					{
						columns.add(item);
						columnCount++;
					}
				}
			}
			if (asiElements.size() > 0)
			{
				int columnCreated = 0;
				for(InstanceAttributeData data : asiElements)
				{
					List<InstanceAttributeColumn> instanceColumns = data.getColumns();
					int index = data.getColumnIndex() + columnCreated;
					for(InstanceAttributeColumn c : instanceColumns)
					{
						columns.add(index, c);
						index++;
						columnCreated++;
					}
				}
			}
						
			Boolean [] colSuppressRepeats = m_layout == null || m_layout.colSuppressRepeats == null? LayoutEngine.getColSuppressRepeats(m_printFormat):m_layout.colSuppressRepeats;
			Object [] preValues = null;
			if (colSuppressRepeats != null){
				preValues = new Object [colSuppressRepeats.length];
			}
			int printColIndex = -1;
			//	for all rows (-1 = header row)
			for (int row = -1; row < m_printData.getRowCount(); row++)
			{
				printColIndex = -1;
				StringBuffer sb = new StringBuffer();
				if (row != -1)
					m_printData.setRowIndex(row);

				//	for all columns
				boolean first = true;	//	first column to print
				for (int col = 0; col < columns.size(); col++)
				{
					Object colObj = columns.get(col);
					MPrintFormatItem item = null;
					InstanceAttributeColumn iaColumn = null;
					if (colObj instanceof InstanceAttributeColumn)
					{
						iaColumn = (InstanceAttributeColumn) colObj;
						item = iaColumn.getPrintFormatItem();
					} 
					else if (colObj instanceof MPrintFormatItem)
					{
						item = (MPrintFormatItem)colObj;
					}
					if (item != null)
					{
						//	column delimiter (comma or tab)
						if (first)
							first = false;
						else
							sb.append(delimiter);
						//	header row
						if (row == -1)
						{
							String printName = iaColumn != null ? iaColumn.getName() : item.getPrintName(language);
							createCSVvalue (sb, delimiter, printName);
						}
						else
						{
							printColIndex++;
							Object obj = iaColumn != null ? iaColumn.getPrintDataElement(row) : m_printData.getNodeByPrintFormatItemId(item.getAD_PrintFormatItem_ID());
							String data = "";
							if (obj == null || !isDisplayPFItem(item)){
								if (colSuppressRepeats != null && colSuppressRepeats[printColIndex]){
									preValues[printColIndex] = null;
								}
							}
							else if (obj instanceof PrintDataElement)
							{
								PrintDataElement pde = (PrintDataElement)obj;
								if (pde.isPKey())
									data = pde.getValueAsString();
								else
									data = pde.getValueDisplay(language);	//	formatted
								
								if (colSuppressRepeats != null && colSuppressRepeats[printColIndex]){
									if (data.equals(preValues[printColIndex])){
										continue;
									}else{
										preValues[printColIndex] = data;
									}
								}
							}
							else if (obj instanceof PrintData)
							{
							}
							else
								log.log(Level.SEVERE, "Element not PrintData(Element) " + obj.getClass());
							createCSVvalue (sb, delimiter, data);
						}
					}	//	printed
				}	//	for all columns
				writer.write(sb.toString());
				writer.write(Env.NL);
			}	//	for all rows
			//
			writer.flush();
			writer.close();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(w)", e);
			return false;
		}
		return true;
	}	//	createCSV

	/**
	 * 	Add Content to CSV string.
	 *  Encapsulate/mask content in " if required
	 * 	@param sb StringBuffer to add to
	 * 	@param delimiter delimiter
	 * 	@param content column value
	 */
	private void createCSVvalue (StringBuffer sb, char delimiter, String content)
	{
		//	nothing to add
		if (content == null || content.length() == 0)
			return;
		//
		boolean needMask = false;
		StringBuilder buff = new StringBuilder();
		char chars[] = content.toCharArray();
		for (int i = 0; i < chars.length; i++)
		{
			char c = chars[i];
			if (c == '"')
			{
				needMask = true;
				buff.append(c);		//	repeat twice
			}	//	mask if any control character
			else if (!needMask && (c == delimiter || !Character.isLetterOrDigit(c)))
				needMask = true;
			buff.append(c);
		}

		//	Optionally mask value
		if (needMask)
			sb.append('"').append(buff).append('"');
		else
			sb.append(buff);
	}	//	addCSVColumnValue

	
	/**************************************************************************
	 * 	Create XML File
	 * 	@param file file
	 * 	@return true if success
	 */
	public boolean createXML (File file)
	{
		try
		{
			Writer fw = new OutputStreamWriter(new FileOutputStream(file, false), Ini.getCharset()); // teo_sarca: save using adempiere charset [ 1658127 ]
			return createXML (new BufferedWriter(fw));
		}
		catch (FileNotFoundException fnfe)
		{
			log.log(Level.SEVERE, "(f) - " + fnfe.toString());
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(f)", e);
		}
		return false;
	}	//	createXML

	/**
	 * 	Write XML to writer
	 * 	@param writer writer
	 * 	@return true if success
	 */
	public boolean createXML (Writer writer)
	{
		try
		{
			m_printData.createXML(new StreamResult(writer));
			writer.flush();
			writer.close();
			return true;
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(w)", e);
		}
		return false;
	}	//	createXML

	
	/**************************************************************************
	 * 	Create PDF file.
	 * 	(created in temporary storage)
	 *	@return PDF file
	 */
	public File getPDF()
	{
		return getPDF (null);
	}	//	getPDF

	/**
	 * 	Create PDF file.
	 * 	@param file file
	 *	@return PDF file
	 */
	public File getPDF (File file)
	{
		try
		{
			if (file == null)
				file = FileUtil.createTempFile (makePrefix(getName()), ".pdf");
		}
		catch (IOException e)
		{
			log.log(Level.SEVERE, "", e);
		}
		if (createPDF (file))
			return file;
		return null;
	}	//	getPDF

	/**************************************************************************
	 * 	Create HTML file.
	 * 	(created in temporary storage)
	 *	@return HTML file
	 */
	public File getHTML()
	{
		return getHTML(null);
	}	//	getHTML

	/**
	 * 	Create HTML file.
	 * 	@param file file
	 *	@return HTML file
	 */
	public File getHTML(File file)
	{
		try
		{
			if (file == null)
				file = FileUtil.createTempFile (makePrefix(getName()), ".html");
		}
		catch (IOException e)
		{
			log.log(Level.SEVERE, "", e);
		}
		if (createHTML(file, false, Env.getLanguage(getCtx())))
			return file;
		return null;
	}	//	getHTML
	
	/**************************************************************************
	 * 	Create CSV file.
	 * 	(created in temporary storage)
	 *	@return CSV file
	 */
	public File getCSV()
	{
		return getCSV(null);
	}	//	getCSV

	/**
	 * 	Create CSV file.
	 * 	@param file file
	 *	@return CSV file
	 */
	public File getCSV(File file)
	{
		try
		{
			if (file == null)
				file = FileUtil.createTempFile (makePrefix(getName()), ".csv");
		}
		catch (IOException e)
		{
			log.log(Level.SEVERE, "", e);
		}
		if (createCSV(file, ',', Env.getLanguage(getCtx())))
			return file;
		return null;
	}	//	getCSV
	
	/**************************************************************************
	 * 	Create XLS file.
	 * 	(created in temporary storage)
	 *	@return XLS file
	 */
	public File getXLS()
	{
		return getXLS(null);
	}	//	getXLS

	/**
	 * 	Create XLS file.
	 * 	@param file file
	 *	@return XLS file
	 */
	public File getXLS(File file)
	{
		try
		{
			if (file == null)
				file = FileUtil.createTempFile (makePrefix(getName()), ".xls");
		}
		catch (IOException e)
		{
			log.log(Level.SEVERE, "", e);
		}
		try 
		{
			createXLS(file, Env.getLanguage(getCtx()));
			return file;
		} 
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
			return null;
		}
	}	//	getXLS
	
	/**************************************************************************
	 * 	Create XLSX file.
	 * 	(created in temporary storage)
	 *	@return XLSX file
	 */
	public File getXLSX()
	{
		return getXLSX(null);
	}	//	getXLSX

	/**
	 * 	Create XLSX file.
	 * 	@param file file
	 *	@return XLSX file
	 */
	public File getXLSX(File file)
	{
		try
		{
			if (file == null)
				file = FileUtil.createTempFile (makePrefix(getName()), ".xlsx");
		}
		catch (IOException e)
		{
			log.log(Level.SEVERE, "", e);
		}
		try 
		{
			createXLSX(file, Env.getLanguage(getCtx()));
			return file;
		} 
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
			return null;
		}
	}	//	getXLSX
	
	/**
	 * 	Create PDF File
	 * 	@param file file
	 * 	@return true if success
	 */
	public boolean createPDF (File file)
	{
		String fileName = null;
		URI uri = null;

		try
		{
			if (file == null)
				file = FileUtil.createTempFile ("ReportEngine", ".pdf");
			fileName = file.getAbsolutePath();
			uri = file.toURI();
			if (file.exists())
				file.delete();

		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "file", e);
			return false;
		}
			
		if (log.isLoggable(Level.FINE)) log.fine(uri.toString());

		try
		{
			if (m_printFormat != null && m_printFormat.getJasperProcess_ID() > 0) {
				ProcessInfo pi = new ProcessInfo ("", m_printFormat.getJasperProcess_ID(), m_printFormat.getAD_Table_ID(), m_info.getRecord_ID());
				if (m_printFormat.getLanguage() != null && m_printFormat.getLanguage().getAD_Language() != null) {
					ProcessInfoParameter reportLanguagePip = new ProcessInfoParameter("AD_Language", m_printFormat.getLanguage().getAD_Language(), null, null, null);
					pi.setParameter(new ProcessInfoParameter[] {reportLanguagePip});
				}
				pi.setIsBatch(true);
				pi.setPDFFileName(fileName);
				ServerProcessCtl.process(pi, (m_trxName == null ? null : Trx.get(m_trxName, false)));
			} else {
				if (m_layout == null)
					layout ();
				Document.getPDFAsFile(fileName, m_layout.getPageable(false));
				ArchiveEngine.get().archive(new File(fileName), m_info);
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "PDF", e);
			throw new AdempiereException(e);
		}

		File file2 = new File(fileName);
		if (log.isLoggable(Level.INFO)) log.info(file2.getAbsolutePath() + " - " + file2.length());
		return file2.exists();
	}	//	createPDF

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
	 * 	Create PDF as Data array
	 *	@return pdf data
	 */
	public byte[] createPDFData ()
	{
		try
		{
			if (m_layout == null)
				layout ();
			return Document.getPDFAsArray(m_layout.getPageable(false));
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "PDF", e);
		}
		return null;
	}	//	createPDFData
	
	/**************************************************************************
	 * 	Create PostScript File
	 * 	@param file file
	 * 	@return true if success
	 */
	public boolean createPS (File file)
	{
		try
		{
			return createPS (new FileOutputStream(file));
		}
		catch (FileNotFoundException fnfe)
		{
			log.log(Level.SEVERE, "(f) - " + fnfe.toString());
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(f)", e);
		}
		return false;
	}	//	createPS

	/**
	 * 	Write PostScript to writer
	 * 	@param os output stream
	 * 	@return true if success
	 */
	public boolean createPS (OutputStream os)
	{
		try
		{
			String outputMimeType = DocFlavor.BYTE_ARRAY.POSTSCRIPT.getMimeType();
			DocFlavor docFlavor = DocFlavor.SERVICE_FORMATTED.PAGEABLE;
			StreamPrintServiceFactory[] spsfactories =
				StreamPrintServiceFactory.lookupStreamPrintServiceFactories(docFlavor, outputMimeType);
			if (spsfactories.length == 0)
			{
				log.log(Level.SEVERE, "(fos) - No StreamPrintService");
				return false;
			}
			//	just use first one - sun.print.PSStreamPrinterFactory
			//	System.out.println("- " + spsfactories[0]);
			StreamPrintService sps = spsfactories[0].getPrintService(os);
			//	get format
			if (m_layout == null)
				layout();
			//	print it
			sps.createPrintJob().print(m_layout.getPageable(false), 
				new HashPrintRequestAttributeSet());
			//
			os.flush();
			//following 2 line for backward compatibility
			if (os instanceof FileOutputStream)
				((FileOutputStream)os).close();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "(fos)", e);
		}
		return false;
	}	//	createPS

	/**
	 * Create Excel file
	 * @param outFile output file
	 * @param language
	 * @throws Exception if error
	 */
	public void createXLS(File outFile, Language language)
	throws Exception
	{
		Boolean [] colSuppressRepeats = m_layout == null || m_layout.colSuppressRepeats == null? LayoutEngine.getColSuppressRepeats(m_printFormat):m_layout.colSuppressRepeats;
		Map<MPrintFormatItem, PrintData> childFormats = m_layout != null ? m_layout.getChildPrintFormatDetails() : null;
		PrintDataExcelExporter exp = new PrintDataExcelExporter(getPrintData(), getPrintFormat(), childFormats, colSuppressRepeats, m_query);
		exp.export(outFile, language);
	}

	/**
	 * Create ExcelX file
	 * @param outFile output file
	 * @param language
	 * @throws Exception if error
	 */
	public void createXLSX(File outFile, Language language)
	throws Exception
	{
		Boolean [] colSuppressRepeats = m_layout == null || m_layout.colSuppressRepeats == null? LayoutEngine.getColSuppressRepeats(m_printFormat):m_layout.colSuppressRepeats;
		Map<MPrintFormatItem, PrintData> childFormats = m_layout != null ? m_layout.getChildPrintFormatDetails() : null;
		PrintDataXLSXExporter exp = new PrintDataXLSXExporter(getPrintData(), getPrintFormat(), childFormats, colSuppressRepeats, m_query);
		exp.export(outFile, language);
	}
	
	/**************************************************************************
	 * 	Get Report Engine for process info 
	 *	@param ctx context
	 *	@param pi process info with AD_PInstance_ID
	 *	@return report engine or null
	 */
	static public ReportEngine get (Properties ctx, ProcessInfo pi)
	{
		return get(ctx, pi, 0);
	}

	/**************************************************************************
	 * 	Get Report Engine for process info 
	 *	@param ctx context
	 *	@param pi process info with AD_PInstance_ID
	 *  @param windowNo Window No
	 *	@return report engine or null
	 */
	static public ReportEngine get (Properties ctx, ProcessInfo pi, int windowNo)
	{
		int AD_Client_ID = pi.getAD_Client_ID();
		//
		int AD_Table_ID = 0;
		int AD_ReportView_ID = 0;
		String TableName = null;
		int AD_PrintFormat_ID = 0;
		boolean IsForm = false;
		int Client_ID = -1;

		//	Get AD_Table_ID and TableName
		StringBuilder sql = new StringBuilder("SELECT rv.AD_ReportView_ID,rv.WhereClause,")
			.append(" t.AD_Table_ID,t.TableName, pf.AD_PrintFormat_ID, pf.IsForm, pf.AD_Client_ID ")
			.append("FROM AD_PInstance pi")
			.append(" INNER JOIN AD_Process p ON (pi.AD_Process_ID=p.AD_Process_ID)")
			.append(" INNER JOIN AD_ReportView rv ON (p.AD_ReportView_ID=rv.AD_ReportView_ID)")
			.append(" INNER JOIN AD_Table t ON (rv.AD_Table_ID=t.AD_Table_ID)")
			.append(" LEFT OUTER JOIN AD_PrintFormat pf ON (p.AD_ReportView_ID=pf.AD_ReportView_ID AND pf.AD_Client_ID IN (0,?) AND pf.IsActive='Y') ")
			.append("WHERE pi.AD_PInstance_ID=? ")		//	#2
			.append("ORDER BY pf.AD_Client_ID DESC, pf.IsDefault DESC");	//	own first
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, AD_Client_ID);
			pstmt.setInt(2, pi.getAD_PInstance_ID());
			rs = pstmt.executeQuery();
			//	Just get first
			if (rs.next())
			{
				AD_ReportView_ID = rs.getInt(1);		//	required
				//
				AD_Table_ID = rs.getInt(3);
				TableName = rs.getString(4);			//	required for query
				AD_PrintFormat_ID = rs.getInt(5);		//	required
				IsForm = "Y".equals(rs.getString(6));	//	required
				Client_ID = rs.getInt(7);
			}
		}
		catch (SQLException e1)
		{
			log.log(Level.SEVERE, "(1) - " + sql, e1);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//	Nothing found
		if (AD_ReportView_ID == 0)
		{
			//	Check Print format in Report Directly
			sql = new StringBuilder("SELECT t.AD_Table_ID,t.TableName, pf.AD_PrintFormat_ID, pf.IsForm ")
				.append("FROM AD_PInstance pi")
				.append(" INNER JOIN AD_Process p ON (pi.AD_Process_ID=p.AD_Process_ID)")
				.append(" INNER JOIN AD_PrintFormat pf ON (p.AD_PrintFormat_ID=pf.AD_PrintFormat_ID)")
				.append(" INNER JOIN AD_Table t ON (pf.AD_Table_ID=t.AD_Table_ID) ")
				.append("WHERE pi.AD_PInstance_ID=?");
			try
			{
				pstmt = DB.prepareStatement(sql.toString(), null);
				pstmt.setInt(1, pi.getAD_PInstance_ID());
				rs = pstmt.executeQuery();
				if (rs.next())
				{
					AD_Table_ID = rs.getInt(1);
					TableName = rs.getString(2);			//	required for query
					AD_PrintFormat_ID = rs.getInt(3);		//	required
					IsForm = "Y".equals(rs.getString(4));	//	required
					Client_ID = AD_Client_ID;
				}
			}
			catch (SQLException e1)
			{
				log.log(Level.SEVERE, "(2) - " + sql, e1);
			}
			finally {
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
			}
			if (AD_PrintFormat_ID == 0)
			{
				log.log(Level.SEVERE, "Report Info NOT found AD_PInstance_ID=" + pi.getAD_PInstance_ID() 
					+ ",AD_Client_ID=" + AD_Client_ID);
				return null;
			}
		}

		//  Create Query from Parameters
		MQuery query = null;
		if (IsForm && pi.getRecord_ID() != 0		//	Form = one record
				&& !TableName.startsWith("T_") )	//	Not temporary table - teo_sarca, BF [ 2828886 ]
		{
			query = MQuery.getEqualQuery(TableName + "_ID", pi.getRecord_ID());
		}
		else
		{
			query = MQuery.get (ctx, pi.getAD_PInstance_ID(), TableName);
		}

		//	Get Print Format
		MPrintFormat format = null;
		Object so = pi.getSerializableObject();
		if (so instanceof MPrintFormat)
			format = (MPrintFormat)so;
		if (format == null && AD_PrintFormat_ID != 0)
		{
			//	We have a PrintFormat with the correct Client
			if (Client_ID == AD_Client_ID)
				format = MPrintFormat.get (ctx, AD_PrintFormat_ID, false);
			else
				format = MPrintFormat.copyToClient (ctx, AD_PrintFormat_ID, AD_Client_ID);
		}
		if (format != null && format.getItemCount() == 0)
		{
			if (log.isLoggable(Level.INFO)) log.info("No Items - recreating:  " + format);
			format.delete(true);
			format = null;
		}
		//	Create Format
		if (format == null && AD_ReportView_ID != 0)
			format = MPrintFormat.createFromReportView(ctx, AD_ReportView_ID, pi.getTitle());
		if (format == null)
			return null;
		//
		format.setTranslationLanguage(format.getLanguage());
		//
		PrintInfo info = new PrintInfo (pi);
		info.setAD_Table_ID(AD_Table_ID);
		
		return new ReportEngine(ctx, format, query, info, pi.isSummary(), pi.getTransactionName(), windowNo);
	}	//	get
	
	/*************************************************************************/

	/** Order = 0				*/
	public static final int		ORDER = 0;
	/** Shipment = 1				*/
	public static final int		SHIPMENT = 1;
	/** Invoice = 2				*/
	public static final int		INVOICE = 2;
	/** Project = 3				*/
	public static final int		PROJECT = 3;
	/** RfQ = 4					*/
	public static final int		RFQ = 4;
	/** Remittance = 5			*/
	public static final int		REMITTANCE = 5;
	/** Check = 6				*/
	public static final int		CHECK = 6;
	/** Dunning = 7				*/
	public static final int		DUNNING = 7;
	/** Manufacturing Order = 8  */
	public static final int		MANUFACTURING_ORDER = 8;
	/** Distribution Order = 9  */
	public static final int		DISTRIBUTION_ORDER = 9;
	/** Physical Inventory = 10  */
	public static final int		INVENTORY = 10;
	/** Inventory Move = 11  */
	public static final int		MOVEMENT = 11;
	
	private static final String[]	DOC_BASETABLES = new String[] {
		"C_Order", "M_InOut", "C_Invoice", "C_Project",
		"C_RfQResponse",
		"C_PaySelectionCheck", "C_PaySelectionCheck", 
		"C_DunningRunEntry","PP_Order", "DD_Order", "M_Inventory", "M_Movement"};
	private static final String[]	DOC_IDS = new String[] {
		"C_Order_ID", "M_InOut_ID", "C_Invoice_ID", "C_Project_ID",
		"C_RfQResponse_ID",
		"C_PaySelectionCheck_ID", "C_PaySelectionCheck_ID", 
		"C_DunningRunEntry_ID" , "PP_Order_ID" , "DD_Order_ID", "M_Inventory_ID", "M_Movement_ID" };
	private static final int[]	DOC_TABLE_ID = new int[] {
		MOrder.Table_ID, MInOut.Table_ID, MInvoice.Table_ID, MProject.Table_ID,
		MRfQResponse.Table_ID,
		MPaySelectionCheck.Table_ID, MPaySelectionCheck.Table_ID, 
		MDunningRunEntry.Table_ID, X_PP_Order.Table_ID, MDDOrder.Table_ID, MInventory.Table_ID, MMovement.Table_ID };

	/**************************************************************************
	 * 	Get Document Print Engine for Document Type.
	 * 	@param ctx context
	 * 	@param type document type
	 * 	@param Record_ID id
	 * 	@return Report Engine or null
	 */
	public static ReportEngine get (Properties ctx, int type, int Record_ID)
	{
		return get(ctx, type, Record_ID, null, 0);
	}
	
	/**************************************************************************
	 * 	Get Document Print Engine for Document Type.
	 * 	@param ctx context
	 * 	@param type document type
	 * 	@param Record_ID id
	 * 	@return Report Engine or null
	 */
	public static ReportEngine get (Properties ctx, int type, int Record_ID, int windowNo)
	{
		return get(ctx, type, Record_ID, null, windowNo);
	}
	
	/**************************************************************************
	 * 	Get Document Print Engine for Document Type.
	 * 	@param ctx context
	 * 	@param type document type
	 * 	@param Record_ID id
	 *  @param trxName
	 * 	@return Report Engine or null
	 */
	public static ReportEngine get (Properties ctx, int type, int Record_ID, String trxName)
	{
		return get(ctx, type, Record_ID, trxName, 0);
	}

	/**************************************************************************
	 * 	Get Document Print Engine for Document Type.
	 * 	@param ctx context
	 * 	@param type document type
	 * 	@param Record_ID id
	 *  @param trxName
	 *  @param windowNo
	 * 	@return Report Engine or null
	 */
	public static ReportEngine get(Properties ctx, int type, int Record_ID, String trxName, int windowNo)
	{
		if (Record_ID < 1)
		{
			log.log(Level.WARNING, "No PrintFormat for Record_ID=" + Record_ID 
					+ ", Type=" + type);
			return null;
		}
		//	Order - Print Shipment or Invoice
		if (type == ORDER)
		{
			int[] what = getDocumentWhat (Record_ID);
			if (what != null)
			{
				type = what[0];
				Record_ID = what[1];
			}
		}	//	Order

		int AD_PrintFormat_ID = 0;
		int C_BPartner_ID = 0;
		String DocumentNo = null;
		int copies = 1;

		//	Language
		MClient client = MClient.get(ctx);
		Language language = client.getLanguage();	
		//	Get Document Info
		StringBuilder sql = null;
		if (type == CHECK)
			sql = new StringBuilder("SELECT bad.Check_PrintFormat_ID,")								//	1
				.append("	c.IsMultiLingualDocument,bp.AD_Language,bp.C_BPartner_ID,d.DocumentNo ")		//	2..5
				.append("FROM C_PaySelectionCheck d")
				.append(" INNER JOIN C_PaySelection ps ON (d.C_PaySelection_ID=ps.C_PaySelection_ID)")
				.append(" INNER JOIN C_BankAccountDoc bad ON (ps.C_BankAccount_ID=bad.C_BankAccount_ID AND d.PaymentRule=bad.PaymentRule)")
				.append(" INNER JOIN AD_Client c ON (d.AD_Client_ID=c.AD_Client_ID)")
				.append(" INNER JOIN C_BPartner bp ON (d.C_BPartner_ID=bp.C_BPartner_ID) ")
				.append("WHERE d.C_PaySelectionCheck_ID=?");		//	info from BankAccount
		else if (type == DUNNING)
			sql = new StringBuilder("SELECT dl.Dunning_PrintFormat_ID,")
				.append(" c.IsMultiLingualDocument,bp.AD_Language,bp.C_BPartner_ID,dr.DunningDate ")
				.append("FROM C_DunningRunEntry d")
				.append(" INNER JOIN AD_Client c ON (d.AD_Client_ID=c.AD_Client_ID)")
				.append(" INNER JOIN C_BPartner bp ON (d.C_BPartner_ID=bp.C_BPartner_ID)")
				.append(" INNER JOIN C_DunningRun dr ON (d.C_DunningRun_ID=dr.C_DunningRun_ID)")
				.append(" INNER JOIN C_DunningLevel dl ON (dl.C_DunningLevel_ID=d.C_DunningLevel_ID) ")
				.append("WHERE d.C_DunningRunEntry_ID=?");			//	info from Dunning
		else if (type == REMITTANCE)
			sql = new StringBuilder("SELECT pf.Remittance_PrintFormat_ID,")
				.append(" c.IsMultiLingualDocument,bp.AD_Language,bp.C_BPartner_ID,d.DocumentNo ")
				.append("FROM C_PaySelectionCheck d")
				.append(" INNER JOIN AD_Client c ON (d.AD_Client_ID=c.AD_Client_ID)")
				.append(" INNER JOIN AD_PrintForm pf ON (c.AD_Client_ID=pf.AD_Client_ID)")
				.append(" INNER JOIN C_BPartner bp ON (d.C_BPartner_ID=bp.C_BPartner_ID) ")
				.append("WHERE d.C_PaySelectionCheck_ID=?")		//	info from PrintForm
				.append(" AND pf.AD_Org_ID IN (0,d.AD_Org_ID) ORDER BY pf.AD_Org_ID DESC");
		else if (type == PROJECT)
			sql = new StringBuilder("SELECT pf.Project_PrintFormat_ID,")
				.append(" c.IsMultiLingualDocument,bp.AD_Language,bp.C_BPartner_ID,d.Value ")
				.append("FROM C_Project d")
				.append(" INNER JOIN AD_Client c ON (d.AD_Client_ID=c.AD_Client_ID)")
				.append(" INNER JOIN AD_PrintForm pf ON (c.AD_Client_ID=pf.AD_Client_ID)")
				.append(" LEFT OUTER JOIN C_BPartner bp ON (d.C_BPartner_ID=bp.C_BPartner_ID) ")
				.append("WHERE d.C_Project_ID=?")					//	info from PrintForm
				.append(" AND pf.AD_Org_ID IN (0,d.AD_Org_ID) ORDER BY pf.AD_Org_ID DESC");
		else if (type == MANUFACTURING_ORDER)
			sql = new StringBuilder("SELECT pf.Manuf_Order_PrintFormat_ID,")
				.append(" c.IsMultiLingualDocument,bp.AD_Language, 0 , d.DocumentNo ")
				.append("FROM PP_Order d")
				.append(" INNER JOIN AD_Client c ON (d.AD_Client_ID=c.AD_Client_ID)")
				.append(" LEFT OUTER JOIN AD_User u ON (u.AD_User_ID=d.Planner_ID)")
				.append(" LEFT OUTER JOIN C_BPartner bp ON (u.C_BPartner_ID=bp.C_BPartner_ID) ")
				.append(" INNER JOIN AD_PrintForm pf ON (c.AD_Client_ID=pf.AD_Client_ID)")
				.append("WHERE d.PP_Order_ID=?")					//	info from PrintForm
				.append(" AND pf.AD_Org_ID IN (0,d.AD_Org_ID) ORDER BY pf.AD_Org_ID DESC");
		else if (type == DISTRIBUTION_ORDER)
			sql = new StringBuilder("SELECT pf.Distrib_Order_PrintFormat_ID,")
				.append(" c.IsMultiLingualDocument,bp.AD_Language, bp.C_BPartner_ID , d.DocumentNo ")
				.append("FROM DD_Order d")
				.append(" INNER JOIN AD_Client c ON (d.AD_Client_ID=c.AD_Client_ID)")
				.append(" INNER JOIN AD_PrintForm pf ON (c.AD_Client_ID=pf.AD_Client_ID)")
				.append(" LEFT OUTER JOIN C_BPartner bp ON (d.C_BPartner_ID=bp.C_BPartner_ID) ")
				.append("WHERE d.DD_Order_ID=?")					//	info from PrintForm
				.append(" AND pf.AD_Org_ID IN (0,d.AD_Org_ID) ORDER BY pf.AD_Org_ID DESC");
		else if (type == RFQ)
			sql = new StringBuilder("SELECT COALESCE(t.AD_PrintFormat_ID, pf.AD_PrintFormat_ID),")
				.append(" c.IsMultiLingualDocument,bp.AD_Language,bp.C_BPartner_ID,rr.Name ")
				.append("FROM C_RfQResponse rr")
				.append(" INNER JOIN C_RfQ r ON (rr.C_RfQ_ID=r.C_RfQ_ID)")
				.append(" INNER JOIN C_RfQ_Topic t ON (r.C_RfQ_Topic_ID=t.C_RfQ_Topic_ID)")
				.append(" INNER JOIN AD_Client c ON (rr.AD_Client_ID=c.AD_Client_ID)")
				.append(" INNER JOIN C_BPartner bp ON (rr.C_BPartner_ID=bp.C_BPartner_ID),")
				.append(" AD_PrintFormat pf ")
				.append("WHERE pf.AD_Client_ID IN (0,rr.AD_Client_ID)")
				.append(" AND pf.AD_Table_ID=725 AND pf.IsTableBased='N'")	//	from RfQ PrintFormat
				.append(" AND rr.C_RfQResponse_ID=? ")				//	Info from RfQTopic
				.append("ORDER BY t.AD_PrintFormat_ID, pf.AD_Client_ID DESC, pf.AD_Org_ID DESC");
		// Fix [2574162] Priority to choose invoice print format not working
		else if (type == ORDER || type == INVOICE)
			sql = new StringBuilder("SELECT pf.Order_PrintFormat_ID,pf.Shipment_PrintFormat_ID,")		//	1..2
				//	Prio: 1. BPartner 2. DocType, 3. PrintFormat (Org)	//	see InvoicePrint
				.append(" COALESCE (bp.Invoice_PrintFormat_ID,dt.AD_PrintFormat_ID,pf.Invoice_PrintFormat_ID),") // 3
				.append(" pf.Project_PrintFormat_ID, pf.Remittance_PrintFormat_ID,")		//	4..5
				.append(" c.IsMultiLingualDocument, bp.AD_Language,")						//	6..7
				.append(" COALESCE(dt.DocumentCopies,0)+COALESCE(bp.DocumentCopies,1), ") 	// 	8
				.append(" dt.AD_PrintFormat_ID,bp.C_BPartner_ID,d.DocumentNo ")			//	9..11
				.append("FROM " + DOC_BASETABLES[type] + " d")
				.append(" INNER JOIN AD_Client c ON (d.AD_Client_ID=c.AD_Client_ID)")
				.append(" INNER JOIN AD_PrintForm pf ON (c.AD_Client_ID=pf.AD_Client_ID)")
				.append(" INNER JOIN C_BPartner bp ON (d.C_BPartner_ID=bp.C_BPartner_ID)")
				.append(" LEFT OUTER JOIN C_DocType dt ON ((d.C_DocType_ID>0 AND d.C_DocType_ID=dt.C_DocType_ID) OR (d.C_DocType_ID=0 AND d.C_DocTypeTarget_ID=dt.C_DocType_ID)) ")
				.append("WHERE d." + DOC_IDS[type] + "=?")			//	info from PrintForm
				.append(" AND pf.AD_Org_ID IN (0,d.AD_Org_ID) ")
				.append("ORDER BY pf.AD_Org_ID DESC");
		else if (type == INVENTORY || type == MOVEMENT)
			sql = new StringBuilder("SELECT COALESCE (dt.AD_PrintFormat_ID, 0), 0,") 			// 1..2
				.append(" NULL, 0 , d.DocumentNo ")				// 3..5
				.append("FROM " + DOC_BASETABLES[type] + " d")
				.append(" LEFT OUTER JOIN C_DocType dt ON (d.C_DocType_ID=dt.C_DocType_ID) ")
				.append("WHERE d." + DOC_IDS[type] + "=?");			//	info from PrintForm
		else	//	Get PrintFormat from Org or 0 of document client
			sql = new StringBuilder("SELECT pf.Order_PrintFormat_ID,pf.Shipment_PrintFormat_ID,")		//	1..2
				//	Prio: 1. BPartner 2. DocType, 3. PrintFormat (Org)	//	see InvoicePrint
				.append(" COALESCE (bp.Invoice_PrintFormat_ID,dt.AD_PrintFormat_ID,pf.Invoice_PrintFormat_ID),") // 3
				.append(" pf.Project_PrintFormat_ID, pf.Remittance_PrintFormat_ID,")		//	4..5
				.append(" c.IsMultiLingualDocument, bp.AD_Language,")						//	6..7
				.append(" COALESCE(dt.DocumentCopies,0)+COALESCE(bp.DocumentCopies,1), ") 	// 	8
				.append(" dt.AD_PrintFormat_ID,bp.C_BPartner_ID,d.DocumentNo, ")			//  9..11 
				.append(" pf.Manuf_Order_PrintFormat_ID, pf.Distrib_Order_PrintFormat_ID ")	//	12..13
				.append("FROM " + DOC_BASETABLES[type] + " d")
				.append(" INNER JOIN AD_Client c ON (d.AD_Client_ID=c.AD_Client_ID)")
				.append(" INNER JOIN AD_PrintForm pf ON (c.AD_Client_ID=pf.AD_Client_ID)")
				.append(" INNER JOIN C_BPartner bp ON (d.C_BPartner_ID=bp.C_BPartner_ID)")
				.append(" LEFT OUTER JOIN C_DocType dt ON (d.C_DocType_ID=dt.C_DocType_ID) ")
				.append("WHERE d." + DOC_IDS[type] + "=?")			//	info from PrintForm
				.append(" AND pf.AD_Org_ID IN (0,d.AD_Org_ID) ")
				.append("ORDER BY pf.AD_Org_ID DESC");
		//
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), trxName);
			pstmt.setInt(1, Record_ID);
			rs = pstmt.executeQuery();
			if (rs.next())	//	first record only
			{
				if (type == CHECK || type == DUNNING || type == REMITTANCE 
					|| type == PROJECT || type == RFQ || type == MANUFACTURING_ORDER || type == DISTRIBUTION_ORDER 
					|| type == INVENTORY || type == MOVEMENT)
				{
					AD_PrintFormat_ID = rs.getInt(1);
					copies = 1;
					//	Set Language when enabled
					String AD_Language = rs.getString(3);
					if (AD_Language != null)// && "Y".equals(rs.getString(2)))	//	IsMultiLingualDocument
						language = Language.getLanguage(AD_Language);
					C_BPartner_ID = rs.getInt(4);
					if (type == DUNNING)
					{
						Timestamp ts = rs.getTimestamp(5);
						DocumentNo = ts.toString();
					}
					else
						DocumentNo = rs.getString(5);
					
					if(AD_PrintFormat_ID == 0 && type == INVENTORY){
						MProcess process = MProcess.get(ctx, PROCESS_RPT_M_INVENTORY);
						AD_PrintFormat_ID = process.getAD_PrintFormat_ID();
					}
					
					if(AD_PrintFormat_ID == 0 && type == MOVEMENT){
						MProcess process = MProcess.get(ctx, PROCESS_RPT_M_MOVEMENT);
						AD_PrintFormat_ID = process.getAD_PrintFormat_ID();
					}
					
				}
				else
				{
					//	Set PrintFormat
					AD_PrintFormat_ID = rs.getInt(type+1);
					if (type != INVOICE && rs.getInt(9) != 0)		//	C_DocType.AD_PrintFormat_ID
						AD_PrintFormat_ID = rs.getInt(9);
					copies = rs.getInt(8);
					//	Set Language when enabled
					String AD_Language = rs.getString(7);
					if (AD_Language != null) // && "Y".equals(rs.getString(6)))	//	IsMultiLingualDocument
						language = Language.getLanguage(AD_Language);
					C_BPartner_ID = rs.getInt(10);
					DocumentNo = rs.getString(11);
				}
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "Record_ID=" + Record_ID + ", SQL=" + sql, e);
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (AD_PrintFormat_ID == 0)
		{
			log.log(Level.SEVERE, "No PrintFormat found for Type=" + type + ", Record_ID=" + Record_ID);
			return null;
		}

		//	Get Format & Data
		MPrintFormat format = MPrintFormat.get (ctx, AD_PrintFormat_ID, false);
		format.setLanguage(language);		//	BP Language if Multi-Lingual
		format.setTranslationLanguage(language);
		//	query
		MQuery query = new MQuery(format.getAD_Table_ID());
		query.addRestriction(DOC_IDS[type], MQuery.EQUAL, Record_ID);

		//
		if (DocumentNo == null || DocumentNo.length() == 0)
			DocumentNo = "DocPrint";
		PrintInfo info = new PrintInfo(
			DocumentNo,
			DOC_TABLE_ID[type],
			Record_ID,
			C_BPartner_ID);
		info.setCopies(copies);
		info.setDocumentCopy(false);		//	true prints "Copy" on second
		info.setPrinterName(format.getPrinterName());
		
		//	Engine
		ReportEngine re = new ReportEngine(ctx, format, query, info, trxName, windowNo);
		return re;
	}	//	get

	/**
	 *	Determine what Order document to print.
	 *  @param C_Order_ID id
	 *	@return int Array with [printWhat, ID]
	 */
	private static int[] getDocumentWhat (int C_Order_ID)
	{
		int[] what = new int[2];
		what[0] = ORDER;
		what[1] = C_Order_ID;
		//
		StringBuilder sql = new StringBuilder("SELECT dt.DocSubTypeSO ")
			.append("FROM C_DocType dt, C_Order o ")
			.append("WHERE o.C_DocType_ID=dt.C_DocType_ID")
			.append(" AND o.C_Order_ID=?");
		String DocSubTypeSO = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, C_Order_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
				DocSubTypeSO = rs.getString(1);
			
			// @Trifon - Order is not completed(C_DoctType_ID=0) then try with C_DocTypeTarget_ID
			// [ 2819637 ] Wrong print format on non completed order - https://sourceforge.net/p/adempiere/bugs/1977/
			if (DocSubTypeSO == null || "".equals(DocSubTypeSO)) {
				sql = new StringBuilder("SELECT dt.DocSubTypeSO ")
					.append("FROM C_DocType dt, C_Order o ")
					.append("WHERE o.C_DocTypeTarget_ID=dt.C_DocType_ID")
					.append(" AND o.C_Order_ID=?");
				DB.close(rs, pstmt);
				rs = null; pstmt = null;
				pstmt = DB.prepareStatement(sql.toString(), null);
				pstmt.setInt(1, C_Order_ID);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					DocSubTypeSO = rs.getString(1);
				}
			}
		}
		catch (SQLException e1)
		{
			log.log(Level.SEVERE, "(1) - " + sql, e1);
			return null;		//	error
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (DocSubTypeSO == null)
			DocSubTypeSO = "";
		//	WalkIn Receipt, WalkIn Invoice,
		if (DocSubTypeSO.equals("WR") || DocSubTypeSO.equals("WI"))
			what[0] = INVOICE;
		//	WalkIn Pickup,
		else if (DocSubTypeSO.equals("WP"))
			what[0] = SHIPMENT;
		//	Offer Binding, Offer Nonbinding, Standard Order
		else
			return what;

		//	Get Record_ID of Invoice/Receipt
		if (what[0] == INVOICE)
			sql = new StringBuilder("SELECT C_Invoice_ID REC FROM C_Invoice WHERE C_Order_ID=?")	//	1
				.append(" ORDER BY C_Invoice_ID DESC");
		else
			sql = new StringBuilder("SELECT M_InOut_ID REC FROM M_InOut WHERE C_Order_ID=?") 	//	1
				.append(" ORDER BY M_InOut_ID DESC");
		try
		{
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, C_Order_ID);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				what[1] = rs.getInt(1);
			}
			else	//	No Document Found
				what[0] = ORDER;
		}
		catch (SQLException e2)
		{
			log.log(Level.SEVERE, "(2) - " + sql, e2);
			return null;
		}
		finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		if (log.isLoggable(Level.FINE)) log.fine("Order => " + what[0] + " ID=" + what[1]);
		return what;
	}	//	getDocumentWhat

	/**
	 * 	Print Confirm.
	 *  Update Date Printed
	 * 	@param type document type
	 * 	@param Record_ID record id
	 */
	public static void printConfirm (int type, int Record_ID)
	{
		StringBuilder sql = new StringBuilder();
		if (type == ORDER || type == SHIPMENT || type == INVOICE)
			sql.append("UPDATE ").append(DOC_BASETABLES[type])
				.append(" SET DatePrinted=getDate(), IsPrinted='Y' WHERE ")
				.append(DOC_IDS[type]).append("=").append(Record_ID);
		//
		if (sql.length() > 0)
		{
			int no = DB.executeUpdate(sql.toString(), null);
			if (no != 1)
				log.log(Level.SEVERE, "Updated records=" + no + " - should be just one");
		}
	}	//	printConfirm

	public void setWhereExtended(String whereExtended) {
		m_whereExtended = whereExtended;
	}

	public String getWhereExtended() {
		return m_whereExtended;
	}

	/* Save windowNo of the report to parse the context */
	public void setWindowNo(int windowNo) {
		m_windowNo = windowNo;
	}
	
	public int getWindowNo() {
		return m_windowNo;
	}

	public void setSummary(boolean summary)
	{
		m_summary = summary;
	}

	public boolean isSummary()
	{
		return m_summary;
	}
	
	public void setLanguageID(int languageID)
	{
		m_language_id = languageID;
	}

	public int getLanguageID()
	{
		return m_language_id;
	}
	
	private String reportType;
	
	public void setReportType(String type)
	{
		reportType = type;
	}
	
	public String getReportType()
	{
		return reportType;
	}
	
	/**
	 * Determines, if current tab content should be replaced, or a new tab should be opened
	 * @return
	 */
	public boolean isReplaceTabContent() {
		return m_isReplaceTabContent;
	}

	/**
	 * Sets, if current tab content should be replaced, or a new tab should be opened
	 * @param m_isReplaceTabContent
	 */
	public void setIsReplaceTabContent(boolean m_isReplaceTabContent) {
		this.m_isReplaceTabContent = m_isReplaceTabContent;
	}
	
	/**
	 * Get Report Engine Type from Table_ID
	 * @param tableID
	 * @return Report Engine Type 
	 * -1 if Report Engine Type was not found
	 */
	public static int getReportEngineType(int tableID) {
		for(int i = 0; i < DOC_TABLE_ID.length; i++) {
			if(DOC_TABLE_ID[i] == tableID)
				return i;
		}
		return -1;
	}
	
	/**
	 * build css for table from mapCssInfo
	 * @param doc
	 */
	public void appendInlineCss (XhtmlDocument doc){
		StringBuilder buildCssInline = new StringBuilder();
		
		// each entry is a css class
		for (Entry<CSSInfo, List<ColumnInfo>> cssClassInfo : mapCssInfo.entrySet()){
			// each column is a css name.
			for (int i = 0; i < cssClassInfo.getValue().size(); i++){
				if (i > 0)
					buildCssInline.append (",");
				
				buildCssInline.append(cssClassInfo.getValue().get(i).getCssSelector());
			}
			
			buildCssInline.append(cssClassInfo.getKey().getCssRule());
			buildCssInline.append("\n");
		}
		
		appendInlineCss (doc, buildCssInline);
	}
	
	public void appendInlineCss (XhtmlDocument doc, StringBuilder buildCssInline){
		if (buildCssInline.length() > 0){
			buildCssInline.insert(0, "<style>");
			buildCssInline.append("</style>");
			doc.appendHead(buildCssInline.toString());
		}
	}
	
	/**
	 * create css info from formatItem, add all column has same formatItem in a list
	 * @param formatItem
	 * @param index
	 */
	public void addCssInfo (MPrintFormatItem formatItem, int index){
		CSSInfo cadidateCss = new CSSInfo(formatItem);
		if (mapCssInfo.containsKey(cadidateCss)){
			mapCssInfo.get(cadidateCss).add(new ColumnInfo(index, formatItem));
		}else{
			List<ColumnInfo> newColumnList = new ArrayList<ColumnInfo>();
			newColumnList.add(new ColumnInfo(index, formatItem));
			mapCssInfo.put(cadidateCss, newColumnList);
		}
	}
	
	/**
	 * Store info for make css rule
	 * @author hieplq
	 *
	 */
	public class CSSInfo {
		private Font font;		
		private Color color;
		private String cssStr;
		public CSSInfo (MPrintFormatItem item){
			MPrintFont mPrintFont = null;
			I_AD_PrintFormat m_printFormat = item.getAD_PrintFormat();
			
			if (item.getAD_PrintFont_ID() > 0) 
			{
				mPrintFont = MPrintFont.get(item.getAD_PrintFont_ID());
			}			
			else if (m_printFormat.getAD_PrintFont_ID() > 0)
			{
				mPrintFont = MPrintFont.get(m_printFormat.getAD_PrintFont_ID());
			}
			if (mPrintFont != null && mPrintFont.getAD_PrintFont_ID() > 0)
			{
				font = mPrintFont.getFont();				
			}
			
			MPrintColor mPrintColor = null;
			if (item.getAD_PrintColor_ID() > 0) 
			{
				mPrintColor = MPrintColor.get(m_ctx, item.getAD_PrintColor_ID());
			}
			else if (m_printFormat.getAD_PrintColor_ID() > 0)
			{
				mPrintColor = MPrintColor.get(m_ctx, m_printFormat.getAD_PrintColor_ID());
			}
			if (mPrintColor != null && mPrintColor.getAD_PrintColor_ID() > 0)
			{
				color = mPrintColor.getColor();
				
			}
		}
		
		public CSSInfo (Font font, Color color) {
			this.font = font;
			this.color = color;
		}
		
		/**
		 * sum hashCode of partial
		 */
		@Override
		public int hashCode() {
			return (color == null ? 0 : color.hashCode()) + (font == null ? 0 : font.hashCode());
		}
		
		/**
		 * equal only when same color and font
		 */
		@Override
		public boolean equals(Object obj) {
			if (obj == null || !(obj instanceof CSSInfo) || obj.hashCode() != this.hashCode())
				return false;
			
			CSSInfo compareObj = (CSSInfo)obj;
			
			return compareObj (compareObj.color, color) && compareObj (compareObj.font, font);			
		}
		
		/**
		 * compare two object equal when both is null or result of equal
		 * @param obj1
		 * @param obj2
		 * @return
		 */
		protected boolean compareObj(Object obj1, Object obj2) {
			if (obj1 == null && obj2 != null)
				return false;
			
			if (obj1 == null && obj2 == null){
				return true;
			}
			
			return obj1.equals(obj2);
		}
		
		/**
		 * append a css rule to css class
		 * @param cssBuild
		 * @param ruleName
		 * @param ruleValue
		 */
		protected void addCssRule(StringBuilder cssBuild, String ruleName, String ruleValue) {
			cssBuild.append (ruleName);
			cssBuild.append (":");
			cssBuild.append (ruleValue);
			cssBuild.append (";");
		}
		
		/**
		 * build css rule
		 * @return
		 */
		public String getCssRule (){
			if (cssStr != null)
				return cssStr;
			
			StringBuilder cssBuild = new StringBuilder();
			cssBuild.append ("{");
			
			if (font != null){
				
				String fontFamily = font.getFamily();
				fontFamily = getCSSFontFamily(fontFamily);
				if (fontFamily != null){
					addCssRule(cssBuild, "font-family", fontFamily);
				}
				
				if (font.isBold())
				{
					addCssRule(cssBuild, "font-weight", "bold");					
				}
				
				if (font.isItalic())
				{
					addCssRule(cssBuild, "font-style", "italic");
				}									
				
				int size = font.getSize();
				addCssRule(cssBuild, "font-size", size + "pt");
			}
			
			if (color != null)
			{
				cssBuild.append("color:rgb(");
				cssBuild.append(color.getRed()); 
				cssBuild.append(",");
				cssBuild.append(color.getGreen());
				cssBuild.append(",");
				cssBuild.append(color.getBlue());
				cssBuild.append(");");
			}
			cssBuild.append ("}");
			cssStr = cssBuild.toString();
			
			return cssStr;
		}
	}
	
	/**
	 * store info of report column,
	 * now just use index to create css selector, but for later maybe will construct a complex class name
	 * @author hieplq
	 *
	 */
	public static class ColumnInfo {
		protected static String CSS_SELECTOR_TEMPLATE = "table > tbody > tr > td:nth-child(%1$s)";
		int index = -1;
		public ColumnInfo (int index, MPrintFormatItem formatItem){
			this.index = index;
			
		}
		
		public String getCssSelector(){
			return String.format(CSS_SELECTOR_TEMPLATE, index + 1);
		}
	}
	
	private boolean isDisplayPFItem(MPrintFormatItem item)
	{
		if(Util.isEmpty(item.getDisplayLogic()))
			return true;
		
		return Evaluator.evaluateLogic(new PrintDataEvaluatee(null, m_printData), item.getDisplayLogic());
	}

	public String compress(String src, boolean minify) {
		
		if(minify) {
			HtmlCompressor compressor = new HtmlCompressor();
		    compressor.setEnabled(true);
		    compressor.setCompressCss(true);
		    compressor.setCompressJavaScript(true);
		    compressor.setRemoveComments(true);
		    compressor.setRemoveMultiSpaces(true);
		    compressor.setRemoveIntertagSpaces(true);
//		    compressor.setGenerateStatistics(false);
//		    compressor.setRemoveQuotes(false);
//		    compressor.setSimpleDoctype(false);
//		    compressor.setRemoveScriptAttributes(false);
//		    compressor.setRemoveStyleAttributes(false);
//		    compressor.setRemoveLinkAttributes(false);
//		    compressor.setRemoveFormAttributes(false);
//		    compressor.setRemoveInputAttributes(false);
//		    compressor.setSimpleBooleanAttributes(false);
//		    compressor.setRemoveJavaScriptProtocol(false);
//		    compressor.setRemoveHttpProtocol(false);
//		    compressor.setRemoveHttpsProtocol(false);
//		    compressor.setPreserveLineBreaks(false);
		    
		    return compressor.compress(src);
		}
		else {
			return src;
		}
	}
}	//	ReportEngine
