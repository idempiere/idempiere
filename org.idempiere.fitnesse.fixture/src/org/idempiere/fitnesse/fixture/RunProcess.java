/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Carlos Ruiz                                           *
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
*                                                                     *
* Contributors:                                                       *
* - Carlos Ruiz - globalqss                                           *
***********************************************************************/

package org.idempiere.fitnesse.fixture;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Properties;

import org.compiere.model.Lookup;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstanceLog;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.NamePair;
import org.compiere.util.Trx;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWorkflow;

import fitnesse.fixtures.TableFixture;

/**
 *	iDempiere Run Process fixture for use with fitnesse framework testing
 *
 *  @author Carlos Ruiz - globalqss
 */
public class RunProcess extends TableFixture {
	private static Instance adempiereInstance = null;
	
	private static CLogger	log = CLogger.getCLogger(RunProcess.class);

	@Override
	protected void doStaticTable(int rows) {
		if (adempiereInstance == null) {
			adempiereInstance = Static_iDempiereInstance.getInstance();
		}
		if (adempiereInstance.getAdempiereService() == null || ! adempiereInstance.getAdempiereService().isLoggedIn()) {
			wrong(rows-1, 1);
			getCell(rows-1, 1).addToBody("not logged in");
			return;
		}
		Properties ctx = adempiereInstance.getAdempiereService().getCtx();
		int windowNo = adempiereInstance.getAdempiereService().getWindowNo();

		MProcess process = null;
		MProcessPara[] processParams = null;
		MPInstance pInstance = null;
		HashMap fmap = new HashMap();
		int recordID = 0;
		String docAction = null;
		for (int i = 0; i < rows; i++) {
			String cell_title = getText(i, 0);
			String cell_value = getText(i, 1);
			if (cell_title.equalsIgnoreCase("*ProcessValue*")) {
				if (i > 0) {
					exception(getCell(i, 1), new Exception("*ProcessValue* must be defined in first row"));
					return;
				}
				String processValue = cell_value;
				int processID = MProcess.getProcess_ID(processValue, null);
				if (processID <= 0) {
					exception(getCell(i, 1), new Exception("Process with Value=" + processValue + " doesn't exist"));
					return;
				}
				process = new MProcess(ctx, processID, null);
			} else if (cell_title.equalsIgnoreCase("*ProcessID*")) {
				if (i > 0) {
					exception(getCell(i, 1), new Exception("*ProcessID* must be defined in first row"));
					return;
				}
				int processID = getInt(i, 1);
				process = new MProcess(ctx, processID, null);
				if (process == null || process.get_ID() <= 0) {
					exception(getCell(i, 1), new Exception("Process with ID=" + processID + " doesn't exist"));
					return;
				}
			} else if (cell_title.equalsIgnoreCase("*Run*")) {
				if (i != rows-1) {
					exception(getCell(i, 1), new Exception("*Run* must be called in last row"));
					return;
				}
				processParams = process.getParameters();
				pInstance = new MPInstance (process, 0);
				MPInstancePara[] iParams = pInstance.getParameters();
				String errorMsg = setParams(process, iParams, fmap);
				if (errorMsg != null)
					exception(getCell(i, 1), new Exception(errorMsg));
				if (recordID > 0)
					pInstance.setRecord_ID( recordID);
				pInstance.save();
				if (docAction != null) {
					if (docAction != null && docAction.length() > 0) {
						// Requirements
						// - the process must be a workflow document
						if (process.getAD_Workflow_ID() > 0) {
							MWorkflow wf = MWorkflow.get(ctx, process.getAD_Workflow_ID());
							if (wf.getWorkflowType().equals(MWorkflow.WORKFLOWTYPE_DocumentProcess)) {
								// - get the table associated with the workflow document
								// - set DocAction in such table

						    	// get the PO for the tablename and record ID
						    	MTable table = MTable.get(ctx, wf.getAD_Table_ID());
						    	if (table != null) {
							    	PO po = table.getPO(recordID, null);
							    	if (po != null) {
							    		po.set_ValueOfColumn("DocAction", docAction);
										po.save();
							    	}
						    	}
							}
						}
					}
				}
				ProcessInfo pi = new ProcessInfo (process.getName(), process.getAD_Process_ID());
				pi.setAD_User_ID(Env.getAD_User_ID(ctx));
				pi.setAD_Client_ID(Env.getAD_Client_ID(ctx));
				pi.setAD_PInstance_ID(pInstance.getAD_PInstance_ID());
				if (recordID >0)
					pi.setRecord_ID(recordID);
				boolean processOK = false;
				boolean jasperreport = (process != null && process.getClassname()!=null && process.getClassname().indexOf( "net.sf.compilo.report.ReportStarter" ) >=0 );
				//	Start
				if (process.isWorkflow())
				{
					try
					{
						int AD_Workflow_ID = process.getAD_Workflow_ID();
						MWorkflow wf = MWorkflow.get (ctx, AD_Workflow_ID);
						MWFProcess wfProcess = wf.startWait(pi);	//	may return null
						if(wfProcess != null)
						{
							getCell(i, 1).addToBody(Msg.parseTranslation(ctx, pi.getSummary()));
							addLogInfo(pInstance, i);
							right(getCell(i, 1));
						}
					}
					catch(Exception ex)
					{
						exception(getCell(i, 1), ex);
					}
					//started = wfProcess != null;
				}
			
				if (process.isJavaProcess() && !jasperreport)
				{
					Trx trx = Trx.get(Trx.createTrxName("FixturePrc"), true);
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
						exception(getCell(i, 1), new Exception(pi.getSummary()));
						processOK = false;
					} 
					else
					{
						getCell(i, 1).addToBody(Msg.parseTranslation(ctx, pi.getSummary()));
						addLogInfo(pInstance, i);
						right(getCell(i, 1));
					}
				}
				
				//	Report
				if (/*processOK &&*/ (process.isReport() || jasperreport))//&& !m_jasperreport)
				{
					exception(getCell(i, 1), new Exception("Report not supported yet"));
					return;
				}
			} else {
				if (i <= 0 || i >= rows-1) {
					exception(getCell(i, 1), new Exception("Parameters must be defined in middle rows"));
					return;
				}
				// Parameter
				String parameterName = cell_title;
				String value_evaluated = Util.evaluate(ctx, windowNo, cell_value, getCell(i, 1));
				if (parameterName.equalsIgnoreCase("*RecordID*")) {
					try {
						recordID = Integer.parseInt(value_evaluated);
					} catch (NumberFormatException e) {
						exception(getCell(i, 1), e);
						continue;
					}
				}
				else if (parameterName.equalsIgnoreCase("*DocAction*"))
					docAction = value_evaluated;
				else
					fmap.put(parameterName, value_evaluated);
			}
		}

	} // doStaticTable

	private void addLogInfo(MPInstance pInstance, int i) {
		// pi.getLogInfo was cleared by unlock - the results must be read from database
		MPInstanceLog[] pils = pInstance.getLog();
		if (pils != null && pils.length > 0) {
			getCell(i, 1).addToBody("<hr>");
			SimpleDateFormat dateFormat = DisplayType.getDateFormat(DisplayType.DateTime);
			for (MPInstanceLog pil : pInstance.getLog()) {
				if (pil.getP_Date() != null)
					getCell(i, 1).addToBody(dateFormat.format(pil.getP_Date()) + " \t");
				if (pil.getP_Number() != null)
					getCell(i, 1).addToBody(pil.getP_Number() + " \t");
				if (pil.getP_Msg() != null)
					getCell(i, 1).addToBody(Msg.parseTranslation(Env.getCtx(), pil.getP_Msg()).replaceAll("\\n", "<br>"));
			}
		}
	}

	private String setParams(MProcess process, MPInstancePara[] iParams, HashMap fmap) {
		// Code brought from 3E_WebServices Process
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
		for (int pi = 0; pi < iParams.length; pi++)
		{
			MPInstancePara iPara = iParams[pi];
			String key = iPara.getParameterName();
			MProcessPara pPara = process.getParameter(key);
			if (pPara == null)
			{
				return "Parameter not found: " + key;
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
					return "Parameter "+ pPara.getName() +" is required";
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
							d = dateFormat.parse(value.toString());

						else    // TODO: datetime
							d = dateFormat.parse(value.toString());
						//d = m_cs.dateTimeFormat.parse(value.toString());

						Timestamp ts = null;
						ts = new Timestamp(d.getTime());
						iPara.setP_Date(ts);

						if (pPara.isRange())
						{
							if (displayType == DisplayType.DateTime)
								d = dateFormat.parse(valueString2); 
							//d = m_cs.dateTimeFormat.parse(valueString2);
							else
							{
								if (valueString2 == null || valueString2.length() == 0)
									d = new java.util.Date();
								else
									d = dateFormat.parse(valueString2); //TODO: datetime
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
					return "fillParameter - " + key
							+ " = " + valueString + " (" + value
							+ ") " + value.getClass().getName()
							+ " - " + e.getLocalizedMessage();
				}
			}	//	not null
		}	//	instance parameter loop
		
		return null;

	} // setParams

} // AdempiereRunProcess
