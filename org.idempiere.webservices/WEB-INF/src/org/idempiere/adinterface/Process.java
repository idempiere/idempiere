package org.idempiere.adinterface;

import java.io.ByteArrayOutputStream;
import java.io.CharArrayWriter;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Properties;
import java.util.logging.Level;

import net.sf.compilo.report.ReportProcessor;
import net.sf.jasperreports.engine.JasperPrint;

import org.compiere.model.Lookup;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MPaySelectionCheck;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.model.MQuery;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.PrintInfo;
import org.compiere.print.MPrintFormat;
import org.compiere.print.ReportEngine;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.NamePair;
import org.compiere.util.Trx;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWorkflow;
import org.idempiere.adInterface.x10.DataField;
import org.idempiere.adInterface.x10.DataRow;
import org.idempiere.adInterface.x10.GetProcessParamsDocument;
import org.idempiere.adInterface.x10.LookupValues;
import org.idempiere.adInterface.x10.ProcessParam;
import org.idempiere.adInterface.x10.ProcessParamList;
import org.idempiere.adInterface.x10.ProcessParams;
import org.idempiere.adInterface.x10.ProcessParamsDocument;
import org.idempiere.adInterface.x10.RunProcess;
import org.idempiere.adInterface.x10.RunProcessDocument;
import org.idempiere.adInterface.x10.RunProcessResponse;
import org.idempiere.adInterface.x10.RunProcessResponseDocument;

/*
 * ADEMPIERE/COMPIERE
 * 
 * GridField na GridField
 * GridTab na GridTab
 */

public class Process {
	
	private static CLogger	log = CLogger.getCLogger(Process.class);

	public static ProcessParamsDocument getProcessParams( CompiereService cs, GetProcessParamsDocument req ) 
	{
		ProcessParamsDocument res = ProcessParamsDocument.Factory.newInstance();
		ProcessParams params = res.addNewProcessParams();
		ProcessParamList PL = params.addNewParams();
		
		int AD_Menu_ID = req.getGetProcessParams().getADMenuID();
		int AD_Process_ID = req.getGetProcessParams().getADProcessID();
		MProcess process  = null;
		
		if (AD_Menu_ID>0 && AD_Process_ID==0 )
			process = MProcess.getFromMenu( cs.getCtx(), AD_Menu_ID);			
		else
		if (AD_Menu_ID==0 && AD_Process_ID>0 )
			process = new MProcess( cs.getCtx(), AD_Process_ID, null);

		if (process != null)
		{

			params.setDescription(process.getDescription());
			params.setHelp(process.getHelp());
			params.setName( process.getName() );
			params.setADProcessID( process.getAD_Process_ID());

			MProcessPara[] parameter = process.getParameters();
			for (int i = 0; i < parameter.length; i++)
			{
				MProcessPara para = parameter[i];
				
				ProcessParam p = PL.addNewParam();
				p.setName( para.getName() );
				p.setDescription( para.getDescription() );
				p.setDisplayType( para.getAD_Reference_ID() );
				p.setIsMandatory( para.isMandatory() );
				p.setFieldLength( para.getFieldLength() );
				p.setIsRange( para.isRange() );
				p.setColumnName( para.getColumnName() );
				p.setDefaultValue( para.getDefaultValue() );
				p.setDefaultValue2( para.getDefaultValue2() );												
				if (para.getDefaultValue()!=null )
				{				
					if (DisplayType.isDate(para.getAD_Reference_ID()))
					{
						if (para.getDefaultValue().indexOf( "@#Date@")>=0) {
							//Object t = Env.getContextAsDate( cs.getM_ctx(), "#Date" );
							//String t = Env.getContext( cs.getM_ctx(), "#Date" );
							String t= cs.dateFormat.format( Env.getContextAsDate( cs.getCtx(), "#Date") );	
							
							p.setDefaultValue( t ); //cs.dateFormat.format( t ));
						}
					} else
					if (DisplayType.YesNo ==para.getAD_Reference_ID() )
					{
						if ("Y".equalsIgnoreCase(para.getDefaultValue())) 
								p.setDefaultValue("true");
						else
							    p.setDefaultValue("false");
					}
				} else {
					if (DisplayType.YesNo ==para.getAD_Reference_ID()) 
							    p.setDefaultValue("false");
				}

				if (para.getDefaultValue2()!=null)
				{				
					if (DisplayType.isDate(para.getAD_Reference_ID()))
					{						
						if (para.getDefaultValue2().indexOf( "@#Date@")>=0) {
							//Object t = Env.getContextAsDate( cs.getM_ctx(), "#Date" );
							//String t = Env.getContext( cs.getM_ctx(), "#Date" );
							String t= cs.dateFormat.format( Env.getContextAsDate( cs.getCtx(), "#Date") );
							p.setDefaultValue2( t ); //cs.dateFormat.format( t ) );
						}							
					}
				}
				
				
				if (para.isLookup())
				{
					LookupValues lvs = p.addNewLookup();
					Lookup lookup = para.getLookup();	
					try {
					ADLookup.fillLookupValues( lvs, lookup, para.isMandatory(), false /*isReadOnly*/, false ); // IDEMPIERE 90
					} catch (Exception ex) {
						System.out.println("getProcessParams exception: " +ex.getMessage());
						ex.printStackTrace();
					}
				}
			}
		}
		
		return res;
	}
	
	
	/**************************************************************************
	 * 	Create Process Page
	 *	@param AD_Process_ID Process
	 *	@return Page
	 */
	public static RunProcessResponseDocument runProcess (CompiereService m_cs, RunProcessDocument req )
	{
		RunProcessResponseDocument res = RunProcessResponseDocument.Factory.newInstance();
		RunProcessResponse r= res.addNewRunProcessResponse();

		RunProcess rp = req.getRunProcess();
		int AD_Process_ID = rp.getADProcessID();
		int m_record_id = rp.getADRecordID();
	  	//WebSessionCtx wsc = WebSessionCtx.get (request);
	  	
		MProcess process = MProcess.get (m_cs.getCtx() , AD_Process_ID);
		//	need to check if Role can access
		if (process == null)
		{
			// WebDoc doc = WebDoc.createWindow("Process not found");
			r.setError("Process not found");
			r.setIsError( true );
			return res;
		}
		//process.getDescription()
		//process.getHelp()
		
		// Evaluate DocAction, if call have DocAction parameter, then try to set DocAction before calling workflow process
		String docAction = rp.getDocAction();
		if (docAction != null && docAction.length() > 0) {
			// Requirements
			// - the process must be a workflow document
			if (process.getAD_Workflow_ID() > 0) {
				MWorkflow wf = MWorkflow.get(m_cs.getCtx(), process.getAD_Workflow_ID());
				if (wf.getWorkflowType().equals(MWorkflow.WORKFLOWTYPE_DocumentProcess)) {
					// - get the table associated with the workflow document
					// - set DocAction in such table
			    	
			    	// get the PO for the tablename and record ID
			    	MTable table = MTable.get(m_cs.getCtx(), wf.getAD_Table_ID());
			    	if (table != null) {
				    	PO po = table.getPO(m_record_id, null);
				    	if (po != null) {
				    		po.set_ValueOfColumn("DocAction", docAction);
							po.save();
				    	}
			    	}
				}
			}
		}

		//	Create Process Instance
		MPInstance pInstance = null;
		try 
		{
			pInstance = fillParameter (m_cs, rp.getParamValues(), process);
		}
		catch (Exception ex)
		{
			//center.addElement(new p("B��d: " + ex.getMessage(), AlignType.LEFT).setClass("ProcesResultError"));
			r.setError(ex.getMessage());
			r.setIsError( true );
			return res;
		}
		
		if (m_record_id>0)
		{
			pInstance.setRecord_ID( m_record_id);
			pInstance.save();
		}
		//
		ProcessInfo pi = new ProcessInfo (process.getName(), process.getAD_Process_ID());
		pi.setAD_User_ID(Env.getAD_User_ID(m_cs.getCtx()));
		pi.setAD_Client_ID(Env.getAD_Client_ID(m_cs.getCtx()));
		pi.setAD_PInstance_ID(pInstance.getAD_PInstance_ID());
		if (m_record_id >0)
			pi.setRecord_ID( m_record_id  );
		
		//	Info
		//p p = new p();
		//p.addElement(Msg.translate(wsc.ctx, "AD_PInstance_ID") + ": " + pInstance.getAD_PInstance_ID());
		//center.addElement(p);
		boolean processOK = false;
		
		boolean jasperreport = (process != null && process.getClassname()!=null && process.getClassname().indexOf( "net.sf.compilo.report.ReportStarter" ) >=0 );
		
		if (jasperreport)
		{
			//this.jasperReport( request, response, wsc.ctx, pi);
			processOK = true;
		}
		
		//	Start
		if (process.isWorkflow())
		{
			try
			{
				int AD_Workflow_ID = process.getAD_Workflow_ID();
				MWorkflow wf = MWorkflow.get (Env.getCtx(), AD_Workflow_ID);
				MWFProcess wfProcess = wf.startWait(pi);	//	may return null
				if(wfProcess != null)
				{
					//wynik
					r.setSummary(pi.getSummary());
					r.setLogInfo(pi.getLogInfo(true));
					r.setIsError( false );
					return res;					
				}
			}
			catch(Exception ex)
			{
				r.setError(ex.getMessage());
				r.setLogInfo(pi.getLogInfo(true) );
				r.setIsError( true );
				return res;				
				//Wyj�tek: pi.getLogInfo(true) pi.getLogInfo(true)
			}
			//started = wfProcess != null;
		}
	
		if (process.isJavaProcess() && !jasperreport)
		{
			Trx trx = Trx.get(Trx.createTrxName("WebPrc"), true);
			try
			{
				processOK = process.processIt(pi, trx);
				trx.commit();
				trx.close();
			}
			catch (Throwable t)
			{
				trx.rollback();
				trx.close();
			}
			if (!processOK || pi.isError())
			{
				// b��d:  pi.getSummary()
				r.setSummary(pi.getSummary());
				r.setLogInfo(pi.getLogInfo(true));
				r.setIsError( true );				
				processOK = false;
			} 
			else
			{
				r.setSummary(pi.getSummary());
				r.setLogInfo(pi.getLogInfo(true));
				r.setIsError( false );
				//return res;	
				// wynik - String summary = pi.getSummary();
			}
		}
		
		//	Report
		if (/*processOK &&*/ (process.isReport() || jasperreport))//&& !m_jasperreport)
		{
			r.setIsReport(true);
			//if (m_jasperreport)
			//{
			//	center.addElement(new p("JASPER REPORT", AlignType.LEFT).setClass("Cerror"));
			//} 
			//else
			{
				ReportEngine re=null;
				if (!jasperreport) 
					re = start(pi);

				if (re == null && !jasperreport)
				{
					//b��d: "Nie uda�o si� uruchomi� silnika raport�w (ReportEngine)", 
				}
				else
				{
					try
					{
						boolean ok = false;
						String file_type = "pdf"; 
						if (!jasperreport)
						{
							MPrintFormat pf = re.getPrintFormat();
							if (pf.isTableBased())
							{
								CharArrayWriter wr = new CharArrayWriter();
								ok = ReportEngineEx.createEXCEL_HTML_wr( re, m_cs.getCtx(), wr, false, re.getPrintFormat().getLanguage() );
								file_type ="xls";
								String data = wr.toString();
								if (data!=null)
									r.setData(data.getBytes());
								r.setReportFormat(file_type);
							} else
							{
								byte dat[] = re.createPDFData();
								file_type ="pdf";
								r.setData(dat);		
								r.setReportFormat(file_type);
							}
							
							//r.setReportFormat("xls");							
							ok = true;
						}
						else
						{
							JasperPrint jp = getJasperReportPrint( m_cs.getCtx(), pi);
							//file = File.createTempFile("WProcess", ".pdf");
							ByteArrayOutputStream wr = new ByteArrayOutputStream();
							net.sf.jasperreports.engine.JasperExportManager.exportReportToPdfStream(jp, wr); 
							//exportReportToPdfFile( jp, file.getAbsolutePath() );							
							file_type ="pdf";							
							r.setData(wr.toByteArray());	
							r.setReportFormat(file_type);
							ok = true;
						}
												
						if (ok)
						{
							//pInstance.getAD_PInstance_ID()
							//file.getAbsolutePath()
							
							//	Marker that Process is OK
							m_cs.getCtx().put("AD_PInstance_ID=" + pInstance.getAD_PInstance_ID(), "ok");
						}
						else
						{
							r.setError("Cannot create report");
							r.setLogInfo(pi.getLogInfo(true) );
							r.setIsError( true );
							return res;								
							//"Cannot create report:",
						}
					}
					catch (Exception e)
					{
						r.setError("Cannot create report:" + e.getMessage());
						r.setLogInfo(pi.getLogInfo(true) );
						r.setIsError( true );
						return res;								
						// , 
					}  
				}
			}
		}
		return res;
	}	//	createProcessPage

	
	
	private static MPInstance fillParameter(CompiereService m_cs, DataRow dr, MProcess process) throws Exception
	{
		MPInstance pInstance = new MPInstance (process, 0);
		
		DataField f[] = dr.getFieldArray();
		HashMap<String,String> fmap = new HashMap<String,String>();
		for (int i=0; i<f.length; i++)
			fmap.put(f[i].getColumn(), f[i].getVal());
		//
		MPInstancePara[] iParams = pInstance.getParameters();
		for (int pi = 0; pi < iParams.length; pi++)
		{
			MPInstancePara iPara = iParams[pi];
			String key = iPara.getParameterName();
			MProcessPara pPara = process.getParameter(key);
			if (pPara == null)
			{
				log.log(Level.SEVERE, "Parameter not found: " + key);
				continue;
			}
			int displayType = pPara.getAD_Reference_ID();
			
			String valueString = null; 
			Object ob = fmap.get( key );
			if (ob!=null )
				valueString = ob.toString();
			String valueString2 = null;
			if (pPara.isRange())
			{
				ob = fmap.get( key+"_2" );
				if (ob!=null)
				valueString2 = ob.toString(); 
			}
			log.fine("fillParameter - " + key + " = " + valueString);
			Object value = valueString;
			if (valueString != null && valueString.length() == 0)
				value = null;
			if (value != null && (DisplayType.List == displayType ||
					DisplayType.TableDir== displayType ||
					DisplayType.Table== displayType)&& value.equals("-1"))
				value= null;
			//	No Value
			if (value == null && DisplayType.YesNo != pPara.getAD_Reference_ID()) 
			{
				if (pPara.isMandatory())
					throw new Exception(" Parameter "+pPara.getName() +" is required.");
			}
			else
			{
				//	Convert to Type
				try
				{
					if (DisplayType.isNumeric(displayType) 
						|| DisplayType.isID(displayType))
					{
						BigDecimal bd = null;
						if (value instanceof BigDecimal)
							bd = (BigDecimal)value;
						else if (value instanceof Integer)
							bd = new BigDecimal (((Integer)value).intValue());
						else
							bd = new BigDecimal (value.toString());
						iPara.setP_Number(bd);
						log.fine("fillParameter - " + key
								+ " = " + valueString + " (=" + bd + "=)");
						
						if (pPara.isRange())
						{
							bd = null;
							bd = new BigDecimal (valueString2.toString());
							iPara.setP_Number_To( bd );
						}
					}
					else if (DisplayType.isDate(displayType))
					{
						java.util.Date d;
						if (displayType == DisplayType.DateTime)
							d = m_cs.dateTimeFormat.parse(value.toString());
							
						else  
							d = m_cs.dateFormat.parse(value.toString());
						 
						Timestamp ts = null;
						ts = new Timestamp(d.getTime());
						iPara.setP_Date(ts);
						
						if (pPara.isRange())
						{
							if (displayType == DisplayType.DateTime)
								d = m_cs.dateTimeFormat.parse(valueString2); 
							else
							{
								if (valueString2 == null || valueString2.length() == 0)
									d = new java.util.Date();
								else
									d = m_cs.dateFormat.parse(valueString2);
							}
							
							ts = new Timestamp(d.getTime());
							iPara.setP_Date_To(ts );
						}

						
						log.fine("fillParameter - " + key
							+ " = " + valueString + " (=" + ts + "=)");
					}
					else if (DisplayType.YesNo == pPara.getAD_Reference_ID())
					{
						String bv = "N";
						if (value == null)
							bv = "N";
						else
						//if (value.toString().toLowerCase().charAt(0)=='t')
						{
							if ("true".equalsIgnoreCase(valueString) || "y".equalsIgnoreCase(valueString)) bv = "Y"; else bv = "N";
						}
							//bv ="Y";
						iPara.setP_String(bv);
					}
					else
					{
						iPara.setP_String(value.toString());
					}
					
					if (pPara.isLookup()) // kolec - ustawia wartosc dla parametru Lookup
					{
						Lookup lok = pPara.getLookup();
						if (lok != null)
						{
							NamePair np = lok.getDirect( value, false, false);
							if (np!=null)
							{
								iPara.setInfo( np.getName() );
							}
						}
					} else
					{
						if (value != null)
						  iPara.setInfo( value.toString() );
						if (valueString2 != null)
							iPara.setInfo_To( valueString2 );
					}
					
					//
					iPara.save();
				}
				catch (Exception e)
				{
					log.warning("fillParameter - " + key
						+ " = " + valueString + " (" + value
						+ ") " + value.getClass().getName()
						+ " - " + e.getLocalizedMessage());
				}
			}	//	not null
		}	//	instance parameter loop
		
		pInstance.save(); // kolec - tego chyba brakowalo
		
		return pInstance;
	}	//	fillParameter

	/*
	static ReportServer server = null;
	
	private void jasperReport(HttpServletRequest request, HttpServletResponse response, Properties ctx, int AD_Process_ID, int AD_Instance_ID) throws Exception
	{
	
		MProcess process = MProcess.get (ctx, AD_Process_ID);
		//	need to check if Role can access
		if (process == null)
			throw new Exception( "Brak procesu" );
		
		MPInstance pInstance = new MPInstance( ctx, AD_Instance_ID, null );
		if (pInstance == null)
			throw new Exception( "Brak intancji procesu" );
		
		ProcessInfo pi = new ProcessInfo (process.getName(), process.getAD_Process_ID());
		pi.setAD_User_ID(pInstance.getAD_User_ID());
		pi.setAD_Client_ID(pInstance.getAD_Client_ID());
		pi.setAD_PInstance_ID(pInstance.getAD_PInstance_ID());
		pi.setRecord_ID( pInstance.getRecord_ID()  );
		
		jasperReport( request, response, ctx, pi);
	}
	*/
	
	/**
	 * Procedura obsluguje raporty jasper - przekazuje wynik raportu w postaci PDF
	 * @param request
	 * @param response
	 * @param ctx
	 * @param pi
	 */
	/*
	private void jasperReport(HttpServletRequest request, HttpServletResponse response, Properties ctx, ProcessInfo pi)
	{
		try
		{
				JasperPrint jasperPrint = getJasperReportPrint( ctx, pi );
	        	
	        	ServletOutputStream output = response.getOutputStream();
	        	net.sf.jasperreports.engine.JasperExportManager.exportReportToPdfStream(jasperPrint, output);
	        	
	        	int bufferSize = 2048; //	2k Buffer
	        	
	        	//response.setContentType(mimeType.getMimeType());
				response.setBufferSize(bufferSize);
				
	        	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
	        	response.setHeader("Pragma","no-cache"); //HTTP 1.0
	        	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
				
				response.setContentType( "application/pdf" );
				
				//response.setHeader("Content-disposition","inline;filename=generated.pdf");		
				//	response.setHeader("Pragma","no-cache");	
				//	response.setHeader("Cache-Control", "no-cache");
				//	response.setHeader("Cache-Control","no-store" );
				//	response.setDateHeader("Expires", -1);
				//	response.setHeader("Content-Type","application/pdf" );
				//response.setContentType( "application/pdf" );
				//response.setHeader("Content-Type","application/pdf" );
								
								
	        	output.flush();
	        	output.close();

	        	
	        }        
	        catch (JRException e)
	        {
	            log.saveError("ReportStarter.startProcess: Can not run report - ", e);
	            return;
	            //return e.getMessage();
	        }
	        catch (Exception ex)
			{
	        	log.saveError("ReportStarter.startProcess: Can not run report - ", ex);
	        	return;
	        	// return ex.getMessage();
			}
		
		
	}
	
	*/
	
	private static JasperPrint getJasperReportPrint(Properties ctx, ProcessInfo pi)
	{
        try
        {
            JasperPrint jasperPrint;
            
            ReportProcessor rp = new ReportProcessor(ctx, pi);
            jasperPrint = rp.runReport();
            
        	if(jasperPrint == null)		
        	{
        		log.finer("ReportStarter.startProcess Cannot process JasperPrint Object");
        		return null;
        	}
        	else
        		return jasperPrint;
        }        
        catch (Exception ex)
		{
        	log.saveError("ReportStarter.startProcess: Can not run report - ", ex);
        	return null;
        	// return ex.getMessage();
		}
	}

	
	static public ReportEngine start (ProcessInfo pi)
	{
		log.info("start - " + pi);

		/**
		 *	Order Print
		 */
		if (pi.getAD_Process_ID() == 110)			//	C_Order
			return startDocumentPrint(ReportEngine.ORDER, pi.getRecord_ID());
		else if (pi.getAD_Process_ID() == 116)		//	C_Invoice
			return startDocumentPrint(ReportEngine.INVOICE, pi.getRecord_ID());
		else if (pi.getAD_Process_ID() == 117)		//	M_InOut
			return startDocumentPrint(ReportEngine.SHIPMENT, pi.getRecord_ID());
		else if (pi.getAD_Process_ID() == 217)		//	C_Project
			return startDocumentPrint(ReportEngine.PROJECT, pi.getRecord_ID());
		else if (pi.getAD_Process_ID() == 276)		//	C_RfQResponse
			return startDocumentPrint(ReportEngine.RFQ, pi.getRecord_ID());
		else if (pi.getAD_Process_ID() == 313)		//	C_Payment
			return startCheckPrint(pi.getRecord_ID());
		/**
		else if (pi.AD_Process_ID == 9999999)	//	PaySelection
			return startDocumentPrint(CHECK, pi, IsDirectPrint);
		else if (pi.AD_Process_ID == 9999999)	//	PaySelection
			return startDocumentPrint(REMITTANCE, pi, IsDirectPrint);
		**/
		else if (pi.getAD_Process_ID() == 159)		//	Dunning
			return startDocumentPrint(ReportEngine.DUNNING, pi.getRecord_ID());
	   else if (pi.getAD_Process_ID() == 202			//	Financial Report
			|| pi.getAD_Process_ID() == 204)			//	Financial Statement
		   return startFinReport (pi);
		/********************
		 *	Standard Report
		 *******************/
		return startStandardReport (pi);
	}	//	create

	
	/**
	 * 	Start Document Print for Type.
	 *  	Called also directly from ProcessDialog, VInOutGen, VInvoiceGen, VPayPrint
	 * 	@param type document type in ReportEngine
	 * 	@param Record_ID id
	 * 	@param IsDirectPrint if true, prints directly - otherwise View
	 * 	@return true if success
	 */
	public static ReportEngine startDocumentPrint (int type, int Record_ID)
	{
		ReportEngine re = ReportEngine.get (Env.getCtx(), type, Record_ID);
		if (re == null)
		{
			//ADialog.error(0, null, "NoDocPrintFormat");
			return null;
		}
/*		if (IsDirectPrint)
		{
			re.print ();
			ReportEngine.printConfirm (type, Record_ID);
		}
		else
			new Viewer(re);*/
		
		return re;
	}	//	StartDocumentPrint
	
	
	/**************************************************************************
	 *	Start Standard Report.
	 *  - Get Table Info & submit
	 *  @param pi Process Info
	 *  @param IsDirectPrint if true, prints directly - otherwise View
	 *  @return true if OK
	 */
	static public ReportEngine startStandardReport (ProcessInfo pi)
	{
		ReportEngine re = ReportEngine.get(Env.getCtx(), pi);
		if (re == null)
		{
			pi.setSummary("No ReportEngine");
			return null;
		}
		//if (IsDirectPrint)
		//{
		//	re.print();
		//}
		//else
		//	new Viewer(re);
		return re;
	}	//	startStandardReport

	
	/**
	 * 	Start Check Print.
	 * 	Find/Create
	 *	@param C_Payment_ID Payment
	 * 	@param IsDirectPrint if true, prints directly - otherwise View
	 * 	@return true if success
	 */
	public static ReportEngine startCheckPrint (int C_Payment_ID)
	{
		int C_PaySelectionCheck_ID = 0;
		MPaySelectionCheck psc = MPaySelectionCheck.getOfPayment(Env.getCtx(), C_Payment_ID, null);
		if (psc != null)
			C_PaySelectionCheck_ID = psc.getC_PaySelectionCheck_ID();
		else
		{
			psc = MPaySelectionCheck.createForPayment(Env.getCtx(), C_Payment_ID, null);
			if (psc != null)
				C_PaySelectionCheck_ID = psc.getC_PaySelectionCheck_ID();
		}
		return startDocumentPrint (ReportEngine.CHECK, C_PaySelectionCheck_ID);
	}	//	startCheckPrint

	/**
	 *	Start Financial Report.
	 *  @param pi Process Info
	 *  @return true if OK
	 */
	static public ReportEngine startFinReport (ProcessInfo pi)
	{

		//  Create Query from Parameters
		String TableName = pi.getAD_Process_ID() == 202 ? "T_Report" : "T_ReportStatement";
		MQuery query = MQuery.get (Env.getCtx(), pi.getAD_PInstance_ID(), TableName);

		//	Get PrintFormat
		MPrintFormat format = (MPrintFormat)pi.getTransientObject();
		if (format == null)
			format = (MPrintFormat)pi.getSerializableObject();
		if (format == null)
		{
			log.log(Level.SEVERE, "startFinReport - No PrintFormat");
			return null;
		}
		PrintInfo info = new PrintInfo(pi);

		ReportEngine re = new ReportEngine(Env.getCtx(), format, query, info);
		//new Viewer(re);
		return re;
	}	//	startFinReport	
}
