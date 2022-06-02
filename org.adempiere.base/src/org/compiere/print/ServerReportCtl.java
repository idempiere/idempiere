package org.compiere.print;

import static org.compiere.model.SystemIDs.PROCESS_RPT_C_DUNNING;
import static org.compiere.model.SystemIDs.PROCESS_RPT_C_INVOICE;
import static org.compiere.model.SystemIDs.PROCESS_RPT_C_ORDER;
import static org.compiere.model.SystemIDs.PROCESS_RPT_C_PROJECT;
import static org.compiere.model.SystemIDs.PROCESS_RPT_C_RFQRESPONSE;
import static org.compiere.model.SystemIDs.PROCESS_RPT_FINREPORT;
import static org.compiere.model.SystemIDs.PROCESS_RPT_FINSTATEMENT;
import static org.compiere.model.SystemIDs.PROCESS_RPT_M_INOUT;
import static org.compiere.model.SystemIDs.PROCESS_RPT_M_INVENTORY;
import static org.compiere.model.SystemIDs.PROCESS_RPT_M_MOVEMENT;

import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MQuery;
import org.compiere.model.MTable;
import org.compiere.model.PrintInfo;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ServerProcessCtl;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Trx;



public class ServerReportCtl {

	/**
	 * Constants used to pass process parameters to Jasper Process
	 */
	public static final String PARAM_PRINTER_NAME = "PRINTER_NAME";
	public static final String PARAM_PRINT_FORMAT = "PRINT_FORMAT";
	public static final String PARAM_PRINT_INFO = "PRINT_INFO";
	
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (ServerReportCtl.class);
	
	/**
	 * Start Document Print for Type with specified printer.
	 * @param type
	 * @param customPrintFormat
	 * @param Record_ID
	 * @param printerName
	 * @return
	 */
	public static boolean startDocumentPrint (int type, MPrintFormat customPrintFormat, int Record_ID, String printerName)
	{
		return startDocumentPrint(type, customPrintFormat, Record_ID, printerName, null);
	}
	
	/**
	 * 	Start Document Print for Type with specified printer.
	 * 	@param type document type in ReportEngine
	 *  @param customPrintFormat
	 * 	@param Record_ID id
	 * 	@param printerName 	Specified printer name
	 *  @param pi
	 * 	@return true if success
	 */
	public static boolean startDocumentPrint (int type, MPrintFormat customPrintFormat, int Record_ID, String printerName, ProcessInfo pi)
	{
		ReportEngine re = ReportEngine.get (Env.getCtx(), type, Record_ID);
		if (re == null)
		{
			CLogger log = CLogger.getCLogger(ServerReportCtl.class);
			log.warning("NoDocPrintFormat");
			return false;
		}
		if (customPrintFormat!=null) {
			// Use custom print format if available
			re.setPrintFormat(customPrintFormat);
		}
		
		if (re.getPrintFormat()!=null)
		{
			MPrintFormat format = re.getPrintFormat();
			
			// We have a Jasper Print Format
			// ==============================
			if(format.getJasperProcess_ID() > 0)	
			{
				boolean result = runJasperProcess(Record_ID, re, true, printerName, pi);
				return(result);
			}
			else
			// Standard Print Format (Non-Jasper)
			// ==================================
			{
				if (pi != null && pi.isBatch() && pi.isPrintPreview())
				{
					if ("HTML".equals(pi.getReportType())) 
					{
						pi.setExport(true);
						pi.setExportFileExtension("html");
						pi.setExportFile(re.getHTML());
					}
					else if ("CSV".equals(pi.getReportType()))
					{
						pi.setExport(true);
						pi.setExportFileExtension("csv");
						pi.setExportFile(re.getCSV());					
					}
					else if ("XLS".equals(pi.getReportType()))
					{
						pi.setExport(true);
						pi.setExportFileExtension("xls");
						pi.setExportFile(re.getXLS());					
					}
					else if ("XLSX".equals(pi.getReportType()))
					{
						pi.setExport(true);
						pi.setExportFileExtension("xlsx");
						pi.setExportFile(re.getXLSX());					
					}
					else
					{
						pi.setPDFReport(re.getPDF());
					}
				}
				else
				{
					createOutput(re, printerName);
				}
				ReportEngine.printConfirm (type, Record_ID);
			}
		}
		return true;
	}	//	StartDocumentPrint
	
	/**
	 * Runs a Jasper process that prints the record
	 * 
	 * @param Record_ID
	 * @param re
	 * @param IsDirectPrint
	 * @param printerName
	 * @return
	 */
	public static boolean runJasperProcess(int Record_ID, ReportEngine re, boolean IsDirectPrint, String printerName) {
		return runJasperProcess(Record_ID, re, IsDirectPrint, printerName, null);
	}

	/**
	 * Runs a Jasper process that prints the record
	 * 
	 * @param Record_ID
	 * @param re
	 * @param IsDirectPrint
	 * @param printerName
	 * @param pi
	 * @return
	 */
	public static boolean runJasperProcess(int Record_ID, ReportEngine re, boolean IsDirectPrint, String printerName, ProcessInfo pi) {
		MPrintFormat format = re.getPrintFormat();
		ProcessInfo jasperProcessInfo = new ProcessInfo ("", format.getJasperProcess_ID());
		PrintInfo printInfo = re.getPrintInfo();
		if (pi != null) {
			jasperProcessInfo.setPrintPreview(pi.isPrintPreview());
			jasperProcessInfo.setIsBatch(pi.isBatch());
		} else {
			jasperProcessInfo.setPrintPreview( !IsDirectPrint );
		}
		jasperProcessInfo.setRecord_ID ( Record_ID );
		jasperProcessInfo.setTable_ID(printInfo.getAD_Table_ID());
		ArrayList<ProcessInfoParameter> jasperPrintParams = new ArrayList<ProcessInfoParameter>();
		ProcessInfoParameter pip;
		if (printerName!=null && printerName.trim().length()>0) {
			// Override printer name
			pip = new ProcessInfoParameter(PARAM_PRINTER_NAME, printerName, null, null, null);
			jasperPrintParams.add(pip);
		}
		pip = new ProcessInfoParameter(PARAM_PRINT_FORMAT, format, null, null, null);
		jasperPrintParams.add(pip);
		pip = new ProcessInfoParameter(PARAM_PRINT_INFO, re.getPrintInfo(), null, null, null);
		jasperPrintParams.add(pip);
		
		jasperProcessInfo.setParameter(jasperPrintParams.toArray(new ProcessInfoParameter[]{}));
		
		ServerProcessCtl.process(jasperProcessInfo, pi != null ? Trx.get(pi.getTransactionName(),false) : null); 		
		
		boolean result = !jasperProcessInfo.isError();
		if (result && pi != null && pi.isBatch())
		{
			pi.setPDFReport(jasperProcessInfo.getPDFReport());
		}
		return(result);
	}
	
	/**
	 * Create output (server only)
	 * 
	 * @param re
	 * @param printerName
	 */
	private static void createOutput(ReportEngine re, String printerName)
	{
		if (printerName!=null) {
			re.getPrintInfo().setPrinterName(printerName);
		}
		re.print();
	}
	
	
	/**
	 *	Create Report.
	 *	Called from ProcessCtl.
	 *	- Check special reports first, if not, create standard Report
	 *
	 *  @param pi process info
	 *  @return true if created
	 */
	static public boolean start (ProcessInfo pi)
	{

		MPInstance instance = new MPInstance(Env.getCtx(), pi.getAD_PInstance_ID(), null);
		instance.setIsProcessing(true);
		instance.saveEx();
		
		try {
			/**
			 *	Order Print
			 */
			if (pi.getAD_Process_ID() == PROCESS_RPT_C_ORDER)			//	C_Order
				return startDocumentPrint(ReportEngine.ORDER, null, pi.getRecord_ID(), null, pi);
			if (pi.getAD_Process_ID() ==  MProcess.getProcess_ID("Rpt PP_Order", null))			//	C_Order
				return startDocumentPrint(ReportEngine.MANUFACTURING_ORDER, null, pi.getRecord_ID(), null, pi);
			if (pi.getAD_Process_ID() ==  MProcess.getProcess_ID("Rpt DD_Order", null))			//	C_Order
				return startDocumentPrint(ReportEngine.DISTRIBUTION_ORDER, null, pi.getRecord_ID(), null, pi);
			else if (pi.getAD_Process_ID() == PROCESS_RPT_C_INVOICE)		//	C_Invoice
				return startDocumentPrint(ReportEngine.INVOICE, null, pi.getRecord_ID(), null, pi);
			else if (pi.getAD_Process_ID() == PROCESS_RPT_M_INOUT)		//	M_InOut
				return startDocumentPrint(ReportEngine.SHIPMENT, null, pi.getRecord_ID(), null, pi);
			else if (pi.getAD_Process_ID() == PROCESS_RPT_C_PROJECT)		//	C_Project
				return startDocumentPrint(ReportEngine.PROJECT, null, pi.getRecord_ID(), null, pi);
			else if (pi.getAD_Process_ID() == PROCESS_RPT_C_RFQRESPONSE)		//	C_RfQResponse
				return startDocumentPrint(ReportEngine.RFQ, null, pi.getRecord_ID(), null, pi);
			else if (pi.getAD_Process_ID() == PROCESS_RPT_C_DUNNING)		//	Dunning
				return startDocumentPrint(ReportEngine.DUNNING, null, pi.getRecord_ID(), null, pi);
	 	    else if (pi.getAD_Process_ID() == PROCESS_RPT_FINREPORT			//	Financial Report
				|| pi.getAD_Process_ID() == PROCESS_RPT_FINSTATEMENT)			//	Financial Statement
			   return startFinReport (pi);
			else if (pi.getAD_Process_ID() == PROCESS_RPT_M_INVENTORY)			//	M_Inventory
				return startDocumentPrint(ReportEngine.INVENTORY, null, pi.getRecord_ID(), null, pi);
			else if (pi.getAD_Process_ID() == PROCESS_RPT_M_MOVEMENT)			//	M_Movement
				return startDocumentPrint(ReportEngine.MOVEMENT, null, pi.getRecord_ID(), null, pi);
			/********************
			 *	Standard Report
			 *******************/
			return startStandardReport (pi);
		}
		finally {
			instance.setIsProcessing(false);
			instance.saveEx();
		}
	}	//	create

	/**************************************************************************
	 *	Start Standard Report.
	 *  - Get Table Info and submit
	 *  @param pi Process Info
	 *  @param IsDirectPrint if true, prints directly - otherwise View
	 *  @return true if OK
	 */
	static public boolean startStandardReport (ProcessInfo pi, boolean IsDirectPrint)
	{
		pi.setPrintPreview(!IsDirectPrint);
		return startStandardReport(pi);
	}
	
	/**************************************************************************
	 *	Start Standard Report.
	 *  - Get Table Info and submit.<br>
	 *  A report can be created from:
	 *  <ol>
	 *  <li>attached MPrintFormat, if any (see {@link ProcessInfo#setTransientObject(Object)}, {@link ProcessInfo#setSerializableObject(java.io.Serializable)}
	 *  <li>process information (AD_Process.AD_PrintFormat_ID, AD_Process.AD_ReportView_ID)
	 *  </ol>
	 *  @param pi Process Info
	 *  @return true if OK
	 */
	static public boolean startStandardReport (ProcessInfo pi)
	{
		ReportEngine re = null;
		//
		// Create Report Engine by using attached MPrintFormat (if any)
		Object o = pi.getTransientObject();
		if (o == null)
			o = pi.getSerializableObject();
		if (o != null && o instanceof MPrintFormat) {
			Properties ctx = Env.getCtx();
			MPrintFormat format = (MPrintFormat)o;
			String TableName = MTable.getTableName(ctx, format.getAD_Table_ID());
			MQuery query = MQuery.get (ctx, pi.getAD_PInstance_ID(), TableName);
			PrintInfo info = new PrintInfo(pi);
			re = new ReportEngine(ctx, format, query, info, pi.isSummary(), pi.getTransactionName());
			if (pi.isPrintPreview() && pi.isBatch())
			{
				if ("HTML".equals(pi.getReportType())) 
				{
					pi.setExport(true);
					pi.setExportFileExtension("html");
					pi.setExportFile(re.getHTML());
				}
				else if ("CSV".equals(pi.getReportType()))
				{
					pi.setExport(true);
					pi.setExportFileExtension("csv");
					pi.setExportFile(re.getCSV());					
				}
				else if ("XLS".equals(pi.getReportType()))
				{
					pi.setExport(true);
					pi.setExportFileExtension("xls");
					pi.setExportFile(re.getXLS());					
				}
				else if ("XLSX".equals(pi.getReportType()))
				{
					pi.setExport(true);
					pi.setExportFileExtension("xlsx");
					pi.setExportFile(re.getXLSX());					
				}
				else
				{
					pi.setPDFReport(re.getPDF());
				}
			}
			else
			{
				createOutput(re, null);
			}
			return true;
		}
		//
		// Create Report Engine normally
		else {
			re = ReportEngine.get(Env.getCtx(), pi);
			if (re == null)
			{
				pi.setSummary("No ReportEngine");
				return false;
			}
		}
		
		if (pi.isPrintPreview() && pi.isBatch())
		{
			if ("HTML".equals(pi.getReportType())) 
			{
				pi.setExport(true);
				pi.setExportFileExtension("html");
				pi.setExportFile(re.getHTML());
			}
			else if ("CSV".equals(pi.getReportType()))
			{
				pi.setExport(true);
				pi.setExportFileExtension("csv");
				pi.setExportFile(re.getCSV());					
			}
			else if ("XLS".equals(pi.getReportType()))
			{
				pi.setExport(true);
				pi.setExportFileExtension("xls");
				pi.setExportFile(re.getXLS());					
			}
			else if ("XLSX".equals(pi.getReportType()))
			{
				pi.setExport(true);
				pi.setExportFileExtension("xlsx");
				pi.setExportFile(re.getXLSX());					
			}
			else
			{
				pi.setPDFReport(re.getPDF());
			}
		}
		else
		{
			createOutput(re, null);
		}
		return true;
	}	//	startStandardReport

	/**
	 *	Start Financial Report.
	 *  @param pi Process Info
	 *  @return true if OK
	 */
	static public boolean startFinReport (ProcessInfo pi)
	{
		@SuppressWarnings("unused")
		int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());

		//  Create Query from Parameters
		String TableName = pi.getAD_Process_ID() == 202 ? "T_Report" : "T_ReportStatement";
		MQuery query = MQuery.get (Env.getCtx(), pi.getAD_PInstance_ID(), TableName);

		//	Get PrintFormat
		MPrintFormat format = (MPrintFormat)pi.getTransientObject();
		if (format == null)
			format = (MPrintFormat)pi.getSerializableObject();
		if (format == null)
		{
			s_log.log(Level.SEVERE, "startFinReport - No PrintFormat");
			return false;
		}
		PrintInfo info = new PrintInfo(pi);

		ReportEngine re = new ReportEngine(Env.getCtx(), format, query, info);
		if (pi.isPrintPreview() && pi.isBatch())
		{
			if ("HTML".equals(pi.getReportType())) 
			{
				pi.setExport(true);
				pi.setExportFileExtension("html");
				pi.setExportFile(re.getHTML());
			}
			else if ("CSV".equals(pi.getReportType()))
			{
				pi.setExport(true);
				pi.setExportFileExtension("csv");
				pi.setExportFile(re.getCSV());					
			}
			else if ("XLS".equals(pi.getReportType()))
			{
				pi.setExport(true);
				pi.setExportFileExtension("xls");
				pi.setExportFile(re.getXLS());					
			}
			else if ("XLSX".equals(pi.getReportType()))
			{
				pi.setExport(true);
				pi.setExportFileExtension("xlsx");
				pi.setExportFile(re.getXLSX());					
			}
			else
			{
				pi.setPDFReport(re.getPDF());
			}
		}
		else
		{
			createOutput(re, null);
		}
		return true;
	}	//	startFinReport
	
	
}
