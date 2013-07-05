package org.idempiere.adinterface;

import java.io.ByteArrayOutputStream;
import java.io.CharArrayWriter;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import javax.xml.namespace.QName;

import net.sf.compilo.report.ReportProcessor;
import net.sf.jasperreports.engine.JasperPrint;

import org.adempiere.util.ProcessUtil;
import org.compiere.model.Lookup;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
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
import org.compiere.process.ProcessInfoParameter;
import org.compiere.process.ProcessInfoUtil;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.NamePair;
import org.compiere.util.Trx;
import org.compiere.util.Util;
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
import org.idempiere.webservices.fault.IdempiereServiceFault;

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
	 * 	Run process
	 *	@param m_cs
	 *  @param req
	 *	@return {@link RunProcessResponseDocument}
	 */
	public static RunProcessResponseDocument runProcess (CompiereService m_cs, RunProcessDocument req )
	{
		return runProcess(m_cs, req, null, null);
	}
	
	/**************************************************************************
	 * 	Run process
	 *	@param m_cs
	 *  @param req
	 *  @param requestCtx
	 *  @param trxName
	 *	@return {@link RunProcessResponseDocument}
	 */
	public static RunProcessResponseDocument runProcess (CompiereService m_cs, RunProcessDocument req, Map<String, Object> requestCtx, String trxName )
	{
		RunProcessResponseDocument res = RunProcessResponseDocument.Factory.newInstance();
		RunProcessResponse r= res.addNewRunProcessResponse();

		RunProcess rp = req.getRunProcess();
		int AD_Process_ID = rp.getADProcessID();
		int m_record_id = rp.getADRecordID();
	  	
		MProcess process = MProcess.get (m_cs.getCtx() , AD_Process_ID);
		//	need to check if Role can access
		if (process == null)
		{
			r.setError("Process not found");
			r.setIsError( true );
			return res;
		}
		
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
							po.saveEx();
				    	}
			    	}
				}
			}
		}

		//	Create Process Instance
		MPInstance pInstance = null;
		try 
		{
			pInstance = fillParameter (m_cs, rp.getParamValues(), process, requestCtx);
		}
		catch (Exception ex)
		{
			r.setError(ex.getMessage());
			r.setIsError( true );
			return res;
		}
		
		DataField[] fields = rp.getParamValues().getFieldArray();
		for(DataField field : fields) {
			if ("AD_Record_ID".equals(field.getColumn())) {
				Object value = null;
				String s = field.getVal();
				if (requestCtx != null && !Util.isEmpty(s) && s.charAt(0) == '@') {
					value = ModelADServiceImpl.parseVatriable(m_cs, requestCtx, field.getColumn(), s);
					if (value != null) {
						if (value instanceof Number) {
							m_record_id = ((Number)value).intValue();
						} else {
							try {
								m_record_id = Integer.parseInt(value.toString());
							} catch (Exception e){}
						}
					}
				} else if (!Util.isEmpty(s)) {
					try {
						m_record_id = Integer.parseInt(s);
					} catch (Exception e){}
				}
			}
		}
		
		if (m_record_id>0)
		{
			pInstance.setRecord_ID( m_record_id);
			pInstance.saveEx();
		}
		//
		ProcessInfo pi = new ProcessInfo (process.getName(), process.getAD_Process_ID());
		pi.setAD_User_ID(Env.getAD_User_ID(m_cs.getCtx()));
		pi.setAD_Client_ID(Env.getAD_Client_ID(m_cs.getCtx()));
		pi.setAD_PInstance_ID(pInstance.getAD_PInstance_ID());
		if (m_record_id >0)
			pi.setRecord_ID( m_record_id  );
		ProcessInfoParameter[] parameters = pi.getParameter();
		if (parameters == null)
		{
			ProcessInfoUtil.setParameterFromDB(pi);
			parameters = pi.getParameter();
		}
		for(DataField field : fields) {
			if (isDataURI(field.getVal())) {
				for(ProcessInfoParameter param : parameters) {
					if (param.getParameterName().equals(field.getColumn())) {
						String data = field.getVal().substring(field.getVal().indexOf(";base64,")+";base64,".length());
						param.setParameter(data);
						break;
					}
				}
			}
		}
		
		boolean processOK = false;
		boolean jasperreport =
				(process != null
				 && (process.getJasperReport() != null
				     || (process.getClassname() != null
				         && process.getClassname().indexOf(ProcessUtil.JASPER_STARTER_CLASS) >= 0
				        )
				    )
				);
		
		if (jasperreport)
		{
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
			}
		}
	
		if (process.isJavaProcess() && !jasperreport)
		{
			Trx trx = trxName == null ? Trx.get(Trx.createTrxName("WebPrc"), true) : Trx.get(trxName, true);
			try
			{
				processOK = process.processIt(pi, trx, false);
				if (trxName == null)
					trx.commit();				
			}
			catch (Throwable t)
			{
				trx.rollback();
			}
			finally
			{
				if (trxName == null)
					trx.close();
			}
			if (!processOK || pi.isError())
			{
				r.setSummary(pi.getSummary());
				r.setError(pi.getSummary());
				r.setLogInfo(pi.getLogInfo(true));
				r.setIsError( true );				
				processOK = false;
			} 
			else
			{
				r.setSummary(pi.getSummary());
				r.setError(pi.getSummary());
				r.setLogInfo(pi.getLogInfo(true));
				r.setIsError( false );
			}
		}
		
		//	Report
		if ((process.isReport() || jasperreport))
		{
			r.setIsReport(true);
			ReportEngine re=null;
			if (!jasperreport) 
				re = start(pi);

			if (re == null && !jasperreport)
			{
				; 
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
						
						ok = true;
					}
					else
					{
						JasperPrint jp = getJasperReportPrint( m_cs.getCtx(), pi);
						ByteArrayOutputStream wr = new ByteArrayOutputStream();
						net.sf.jasperreports.engine.JasperExportManager.exportReportToPdfStream(jp, wr); 
						file_type ="pdf";							
						r.setData(wr.toByteArray());	
						r.setReportFormat(file_type);
						ok = true;
					}
											
					if (ok)
					{
						//	Marker that Process is OK
						m_cs.getCtx().put("AD_PInstance_ID=" + pInstance.getAD_PInstance_ID(), "ok");
					}
					else
					{
						r.setError("Cannot create report");
						r.setLogInfo(pi.getLogInfo(true) );
						r.setIsError( true );
						return res;								
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
		return res;
	}	//	createProcessPage

	
	
	private static MPInstance fillParameter(CompiereService m_cs, DataRow dr, MProcess process, Map<String, Object> requestCtx) throws Exception
	{
		MPInstance pInstance = new MPInstance (process, 0);
		
		DataField f[] = dr.getFieldArray();
		HashMap<String,DataField> fmap = new HashMap<String,DataField>();
		for (int i=0; i<f.length; i++)
			fmap.put(f[i].getColumn(), f[i]);
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
			DataField dataField = fmap.get( key );
			if (dataField != null && !Util.isEmpty(dataField.getVal()))
			{
				valueString = dataField.getVal();
				if (requestCtx != null && valueString.charAt(0) == '@') 
				{
					Object value = ModelADServiceImpl.parseVatriable(m_cs, requestCtx, iPara.getParameterName(), valueString);
					valueString = value != null ? value.toString() : null;
				}
			}
			else if (dataField != null && !Util.isEmpty(dataField.getLval()))
				valueString = getLookupValue(pPara, dataField);
			
			if (isDataURI(valueString))
			{
				valueString = "";
				iPara.setInfo("binary");
			}
			
			String valueString2 = null;
			if (pPara.isRange())
			{
				dataField = fmap.get( key+"_2" );
				if (dataField != null && !Util.isEmpty(dataField.getVal()))
				{
					valueString2 = dataField.toString();
					if (requestCtx != null && valueString2.charAt(0) == '@') 
					{
						Object value = ModelADServiceImpl.parseVatriable(m_cs, requestCtx, iPara.getParameterName(), valueString2);
						valueString2 = value != null ? value.toString() : null;
					}
				}
				else if (dataField != null && !Util.isEmpty(dataField.getLval()))
					valueString2 = getLookupValue(pPara, dataField);
			}
			if (log.isLoggable(Level.FINE)) log.fine("fillParameter - " + key + " = " + valueString);
			
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
						if (log.isLoggable(Level.FINE)) log.fine("fillParameter - " + key
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

						
						if (log.isLoggable(Level.FINE)) log.fine("fillParameter - " + key
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
					iPara.saveEx();
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
		
		pInstance.saveEx(); // kolec - tego chyba brakowalo
				
		return pInstance;
	}	//	fillParameter

	private static String getLookupValue(MProcessPara pPara, DataField dataField) {
		MLookup lookup = null;
		try {
			lookup = MLookupFactory.get(pPara.getCtx(),0,0,pPara.getAD_Reference_ID(),Env.getLanguage(pPara.getCtx()),pPara.getColumnName(),pPara.getAD_Reference_Value_ID(),false,null);
		} catch (Exception e) {
			throw new IdempiereServiceFault("Exception in resolving lookup ", new QName(
					"LookupResolutionFailed"));
		}
		
		String sql = ADLookup.getDirectAccessSQL(lookup, dataField.getLval().toUpperCase());
		sql = sql + " ORDER BY AD_Client_ID DESC ";
		int id = DB.getSQLValue(null, sql); 
		if (id > 0)
			return Integer.toString(id);

		return null;
	}

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
		if (log.isLoggable(Level.INFO)) log.info("start - " + pi);

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

	private static boolean isDataURI(String s)
	{
		if (Util.isEmpty(s)) return false;
		
		if (s.startsWith("data:") && s.indexOf(";base64,") > 0)
			return true;
		else
			return false;
	}
	
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
