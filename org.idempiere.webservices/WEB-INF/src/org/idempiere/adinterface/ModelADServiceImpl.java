/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Carlos Ruiz - globalqss                               *
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
* - Carlos Ruiz  (globalqss@users.sourceforge.net)                    *
*                                                                     *
* Sponsors:                                                           *
* - GlobalQSS (http://www.globalqss.com)                              *
***********************************************************************/

package org.idempiere.adinterface;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import javax.jws.WebService;
import javax.xml.namespace.QName;
import javax.xml.ws.WebServiceContext;

import org.apache.xmlbeans.StringEnumAbstractBase.Table;
import org.compiere.model.Lookup;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MRefTable;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.MWebServiceType;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.X_AD_Reference;
import org.compiere.model.X_WS_WebServiceFieldInput;
import org.compiere.model.X_WS_WebService_Para;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.idempiere.adInterface.x10.ADLoginRequest;
import org.idempiere.adInterface.x10.DataField;
import org.idempiere.adInterface.x10.DataRow;
import org.idempiere.adInterface.x10.DataSet;
import org.idempiere.adInterface.x10.ModelCRUD;
import org.idempiere.adInterface.x10.ModelCRUD.Action.Enum;
import org.idempiere.adInterface.x10.ModelCRUDRequestDocument;
import org.idempiere.adInterface.x10.ModelGetList;
import org.idempiere.adInterface.x10.ModelGetListRequestDocument;
import org.idempiere.adInterface.x10.ModelRunProcess;
import org.idempiere.adInterface.x10.ModelRunProcessRequestDocument;
import org.idempiere.adInterface.x10.ModelSetDocAction;
import org.idempiere.adInterface.x10.ModelSetDocActionRequestDocument;
import org.idempiere.adInterface.x10.RunProcess;
import org.idempiere.adInterface.x10.RunProcessDocument;
import org.idempiere.adInterface.x10.RunProcessResponse;
import org.idempiere.adInterface.x10.RunProcessResponseDocument;
import org.idempiere.adInterface.x10.StandardResponse;
import org.idempiere.adInterface.x10.StandardResponseDocument;
import org.idempiere.adInterface.x10.WindowTabData;
import org.idempiere.adInterface.x10.WindowTabDataDocument;
import org.idempiere.webservices.AbstractService;
import org.idempiere.webservices.IWSValidator;
import org.idempiere.webservices.fault.IdempiereServiceFault;

/*
 * ADEMPIERE/COMPIERE
 *
 * replacement:
 * GridField by GridFieldVO
 * GridTabVO by GridTabVO
 * GridWindowVO by GridWindowVO	
 *
 * Contributors: Carlos Ruiz - globalqss
 *     Add model oriented method modelSetDocAction
 *     Some Polish messages translated to english using google translate
 *     Deepak Pansheriya 
 *     Abstracting out Authenticate and login method
 *     Re factored to add support for composite web service
 *     Added CreateUpdate end point
 *     Added Support for Ctx Variable and ability to pass ctx variable in request
 *     Added configurable output fields
 */


/**
 *
 * @author kolec
 *
 */
@WebService(endpointInterface="org.idempiere.adinterface.ModelADService", serviceName="ModelADService",targetNamespace="http://idempiere.org/ADInterface/1_0")
public class ModelADServiceImpl extends AbstractService implements ModelADService {

	private static CLogger	log = CLogger.getCLogger(ModelADServiceImpl.class);
	
	private static String webServiceName = new String("ModelADService");
	
	private boolean manageTrx = true;

	private String localTrxName = null;
	
	public boolean isManageTrx() {
		return manageTrx;
	}

	public void setManageTrx(boolean manageTrx) {
		this.manageTrx = manageTrx;
	}

	public String getLocalTrxName() {
		return localTrxName;
	}

	public void setLocalTrxName(String locatTrxName) {
		this.localTrxName = locatTrxName;
	}

	public ModelADServiceImpl()
	{
		
		log.info("Creating session object ADService");
	}
	
	public ModelADServiceImpl(WebServiceContext ctx)
	{
		this.ctx =ctx;
		
		log.info("Creating session object ADService");
	}
	public String getVersion() {
		return "0.8.0";
	}

	/*
	 * Model oriented web service to change DocAction for documents, i.e.
	 * Complete a Material Receipt WARNING!!! This web service complete
	 * documents not via workflow, so it jump over any approval step considered
	 * in document workflow To complete documents using workflow it's better to
	 * use the runProcess web service
	 */
	public StandardResponseDocument setDocAction(ModelSetDocActionRequestDocument req) {
		boolean connected = getCompiereService().isConnected();
		
		try {
			if (!connected)
				getCompiereService().connect();
			
			StandardResponseDocument ret = StandardResponseDocument.Factory.newInstance();
			StandardResponse resp = ret.addNewStandardResponse();
			ModelSetDocAction modelSetDocAction = req.getModelSetDocActionRequest().getModelSetDocAction();
			String serviceType = modelSetDocAction.getServiceType();
	
			ADLoginRequest reqlogin = req.getModelSetDocActionRequest().getADLoginRequest();
	
			CompiereService m_cs = getCompiereService();
	
			String err = login(reqlogin, webServiceName, "setDocAction", serviceType);
			if (err != null && err.length() > 0) {
				resp.setError(err);
				resp.setIsError(true);
				return ret;
			}
	
	
			try {
				// Validate parameters
				modelSetDocAction.setTableName(validateParameter("tableName", modelSetDocAction.getTableName()));
				modelSetDocAction.setRecordID(validateParameter("recordID", modelSetDocAction.getRecordID()));
				modelSetDocAction.setDocAction(validateParameter("docAction", modelSetDocAction.getDocAction()));
			} catch (IdempiereServiceFault e) {
				resp.setError(e.getMessage());
				resp.setIsError(true);
				return ret;
			}
			
			Properties ctx = m_cs.getCtx();
	
			// start a trx
			String trxName = localTrxName;
			if (trxName == null) {
				trxName = Trx.createTrxName("ws_modelSetDocAction");
				manageTrx = true;
			}
	
			Trx trx = Trx.get(trxName, true);
			
			Map<String, Object> requestCtx = getRequestCtx();
	
			String tableName = modelSetDocAction.getTableName();
	
			String recordIDVar = modelSetDocAction.getRecordIDVariable();
			int recordID = modelSetDocAction.getRecordID();
	
			if (recordIDVar != null && recordIDVar.startsWith("@")) {
				Integer retVal = (Integer) parseVariable(recordIDVar, null, null, requestCtx);
				if (retVal == null) {
					return rollbackAndSetError(trx, resp, ret, true, "Cannot resolve variable: " + recordIDVar);
				}
				recordID=retVal;
			}
	
			String docAction = modelSetDocAction.getDocAction();
			resp.setRecordID(recordID);
	
			// get the PO for the tablename and record ID
			MTable table = MTable.get(ctx, tableName);
			if (table == null)
				return rollbackAndSetError(trx, resp, ret, true, "No table " + tableName);
	
			PO po = table.getPO(recordID, trxName);
			if (po == null)
				return rollbackAndSetError(trx, resp, ret, true, "No Record " + recordID + " in " + tableName);
	
			// set explicitly the column DocAction to avoid automatic process of
			// default option
			po.set_ValueOfColumn("DocAction", docAction);
			if (!po.save())
				return rollbackAndSetError(trx, resp, ret, true,
						"Cannot save before set docAction: " + CLogger.retrieveErrorString("no log message"));
	
			MWebServiceType m_webservicetype = getWebServiceType();
	
			// For passing action to validators
			requestCtx.put("DocAction", docAction);
	
			// Fire Event
			StandardResponseDocument retResp = invokeWSValidator(m_webservicetype, IWSValidator.TIMING_BEFORE_PARSE, po, null, trx, requestCtx,
					resp, ret);
			if (retResp != null)
				return retResp;
	
			// call process it
			try {
				if (!((org.compiere.process.DocAction) po).processIt(docAction))
					return rollbackAndSetError(trx, resp, ret, true,
							"Couldn't set docAction: " + ((org.compiere.process.DocAction) po).getProcessMsg());
			} catch (Exception e) {
				return rollbackAndSetError(trx, resp, ret, true, e.toString());
			}
	
			// Fire Event
			retResp = invokeWSValidator(m_webservicetype, IWSValidator.TIMING_BEFORE_SAVE, po, null, trx, requestCtx, resp, ret);
			if (retResp != null)
				return retResp;
	
			// close the trx
			if (!po.save())
				return rollbackAndSetError(trx, resp, ret, true,
						"Cannot save after set docAction: " + CLogger.retrieveErrorString("no log message"));
	
			// Fire Event
			retResp = invokeWSValidator(m_webservicetype, IWSValidator.TIMING_AFTER_SAVE, po, null, trx, requestCtx, resp, ret);
			if (retResp != null)
				return retResp;
	
			if (manageTrx && !trx.commit())
				return rollbackAndSetError(trx, resp, ret, true, "Cannot commit after docAction");
	
			if (manageTrx)
				trx.close();
	
			// resp.setError("");
			resp.setIsError(false);
	
			POInfo poinfo = POInfo.getPOInfo(ctx, table.getAD_Table_ID());
			setOuputFields(resp, m_webservicetype, po, poinfo);
			
			
			
			return ret;
		} finally {
			if (!connected)
				getCompiereService().disconnect();
		}
	}

	private String validateParameter(String parameterName, String string) {
		
		MWebServiceType m_webservicetype= getWebServiceType();
		
		X_WS_WebService_Para para = m_webservicetype.getParameter(parameterName);
		if (para == null && (string == null || string.length() == 0))
			// if parameter not configured but didn't receive value (optional param)
			return null;
		
		if (para == null)
			throw new IdempiereServiceFault("Web service type "
					+ m_webservicetype.getValue() + ": invalid parameter "
					+ parameterName,
					new QName("validateParameter"));

		if (X_WS_WebService_Para.PARAMETERTYPE_Constant.equals(para.getParameterType())) {
			if (string == null || string.length() == 0) {
				log.log(Level.INFO, "Web service type "
						+ m_webservicetype.getValue() + ": constant parameter "
						+ parameterName + " set to "
						+ para.getConstantValue());
				return para.getConstantValue();
			} else if (! para.getConstantValue().equals(string)) {
				log.log(Level.WARNING, "Web service type "
						+ m_webservicetype.getValue() + ": constant parameter "
						+ parameterName + " changed to "
						+ para.getConstantValue());
				return para.getConstantValue();
			}
		}
		
		// it must be parameter FREE
		return string;
	}

	private int validateParameter(String parameterName, int i) {
		Integer io = Integer.valueOf(i);
		String string = validateParameter(parameterName, io.toString());
		if (string == null)
			return -1;
		if (string.equals(io.toString()))
			return i;
		return Integer.parseInt(string);
	}

	private Enum validateParameter(String parameterName, Enum action, Table table) {
		String string = null;
		if (action == null)
			string = validateParameter(parameterName, string);
		else
			string = validateParameter(parameterName, action.toString());
		if (string == null)
			return (Enum) table.forInt(-1);
		if (action != null && string.equals(action.toString()))
			return action;
		return (Enum) table.forString(string);
	}

	

	public RunProcessResponseDocument runProcess(ModelRunProcessRequestDocument req) {
		boolean connected = getCompiereService().isConnected();
		
		try {
			if (!connected)
				getCompiereService().connect();
			
			RunProcessResponseDocument resbadlogin = RunProcessResponseDocument.Factory.newInstance();
			RunProcessResponse rbadlogin = resbadlogin.addNewRunProcessResponse();
			ModelRunProcess modelRunProcess = req.getModelRunProcessRequest().getModelRunProcess();
			String serviceType = modelRunProcess.getServiceType();
	
			ADLoginRequest reqlogin = req.getModelRunProcessRequest().getADLoginRequest();
	
			String err = login(reqlogin, webServiceName, "runProcess", serviceType);
			if (err != null && err.length() > 0) {
				rbadlogin.setError(err);
				rbadlogin.setIsError(true);
				return resbadlogin;
			}
	
			// Validate parameters
			modelRunProcess.setADMenuID(validateParameter("AD_Menu_ID", modelRunProcess.getADMenuID()));
			modelRunProcess.setADProcessID(validateParameter("AD_Process_ID", modelRunProcess.getADProcessID()));
			modelRunProcess.setADRecordID(validateParameter("AD_Record_ID", modelRunProcess.getADRecordID()));
			modelRunProcess.setDocAction(validateParameter("DocAction", modelRunProcess.getDocAction()));
	
			RunProcessDocument docprocess = RunProcessDocument.Factory.newInstance();
			RunProcess reqprocess = docprocess.addNewRunProcess();
			reqprocess.setParamValues(modelRunProcess.getParamValues());
			reqprocess.setADProcessID(modelRunProcess.getADProcessID());
			reqprocess.setADMenuID(modelRunProcess.getADMenuID());
			reqprocess.setADRecordID(modelRunProcess.getADRecordID());
			reqprocess.setDocAction(modelRunProcess.getDocAction());
			return Process.runProcess(getCompiereService(), docprocess);
		} finally {
			if (!connected)
				getCompiereService().disconnect();
		}
	}

	public WindowTabDataDocument getList(ModelGetListRequestDocument req) {
		boolean connected = getCompiereService().isConnected();
		
		try {
			if (!connected)
				getCompiereService().connect();
			
			WindowTabDataDocument resdoc = WindowTabDataDocument.Factory.newInstance();
			WindowTabData res = resdoc.addNewWindowTabData();
	    	DataSet ds = res.addNewDataSet();
	    	ModelGetList modelGetList = req.getModelGetListRequest().getModelGetList();
			String serviceType = modelGetList.getServiceType();
	    	int cnt = 0;
	
			ADLoginRequest reqlogin = req.getModelGetListRequest().getADLoginRequest();
	
	    	String err = login(reqlogin, webServiceName, "getList", serviceType);
	    	if (err != null && err.length() > 0) {
	    		res.setError(err);
	    		res.setErrorInfo(err);
	    		res.setSuccess(false);
	        	return resdoc;
	    	}
			int roleid = reqlogin.getRoleID();
	
	    	// Validate parameters
			modelGetList.setADReferenceID(validateParameter("AD_Reference_ID", modelGetList.getADReferenceID()));
			modelGetList.setFilter(validateParameter("Filter", modelGetList.getFilter()));
	
	    	int ref_id = modelGetList.getADReferenceID();
	    	String filter = modelGetList.getFilter();
	    	if (filter == null || filter.length() == 0)
	    		filter = "";
	    	else
	    		filter = " AND " + filter;
	
	    	CompiereService m_cs = getCompiereService();
	    	
	    	Properties ctx = m_cs.getCtx();
	
	    	X_AD_Reference ref = new X_AD_Reference(ctx, ref_id, null);
	    	
	    	String sql = null;
			ArrayList<String> listColumnNames = new ArrayList<String>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			MWebServiceType m_webservicetype= getWebServiceType();
	    	if (X_AD_Reference.VALIDATIONTYPE_ListValidation.equals(ref.getValidationType())) {
	    		// Fill List Reference
	    		String ad_language = Env.getAD_Language(ctx);
	    		boolean isBaseLanguage = Env.isBaseLanguage(ad_language, "AD_Ref_List");
	    		sql = isBaseLanguage ?
	    			"SELECT AD_Ref_List.AD_Ref_List_ID, AD_Ref_List.Value, AD_Ref_List.Name, AD_Ref_List.Description " +
	    			"FROM AD_Ref_List " +
	    			"WHERE AD_Ref_List.AD_Reference_ID=? AND AD_Ref_List.IsActive='Y' " +
	    			filter +
	    			" ORDER BY AD_Ref_List.Name"
	    			:
	       			"SELECT AD_Ref_List.AD_Ref_List_ID, AD_Ref_List.Value, AD_Ref_List_Trl.Name, AD_Ref_List_Trl.Description " +
	       			"FROM AD_Ref_List, AD_Ref_List_Trl " +
	       			"WHERE AD_Ref_List.AD_Reference_ID=? AND AD_Ref_List.IsActive='Y' AND AD_Ref_List_Trl.AD_Language=? AND AD_Ref_List.AD_Ref_List_ID=AD_Ref_List_Trl.AD_Ref_List_ID " +
	       			filter +
	       			" ORDER BY AD_Ref_List_Trl.Name";
	    		listColumnNames.add("AD_Ref_List_ID");
	    		listColumnNames.add("Value");
	    		listColumnNames.add("Name");
	    		listColumnNames.add("Description");
	   			try {
	   	   			pstmt = DB.prepareStatement(sql, null);
					pstmt.setInt(1, ref_id);
		   			if (!isBaseLanguage)
		   				pstmt.setString(2, ad_language);
		   			rs = pstmt.executeQuery();
				} catch (SQLException e)
	    		{
	    			res.setError(e.getMessage());
	    			res.setErrorInfo(sql);
	    			res.setSuccess(false);
	    			DB.close(rs, pstmt);
	    			rs = null; pstmt = null;
					throw new IdempiereServiceFault(e.getClass().toString() + " " + e.getMessage() + " sql=" + sql, e.getCause(), new QName("getList"));
	    		}
	
	    	} else if (X_AD_Reference.VALIDATIONTYPE_TableValidation.equals(ref.getValidationType())) {
	    		// Fill values from a reference table
	    		MRole role = new MRole(ctx, roleid, null);
	    		String sqlrt = "SELECT * FROM AD_Ref_Table WHERE AD_Reference_ID=?";
	    		MRefTable rt = null;
	   			PreparedStatement pstmtrt = null;
	    		ResultSet rsrt = null;
	    		try
	    		{
	    			pstmtrt = DB.prepareStatement (sqlrt, null);
	    			pstmtrt.setInt (1, ref_id);
	    			rsrt = pstmtrt.executeQuery ();
	    			if (rsrt.next ())
	    	    		rt = new MRefTable(ctx, rsrt, null);
	    		}
	    		catch (Exception e)
	    		{
	    			// ignore this exception
	    		}
	    		finally
	    		{
	    			DB.close(rsrt, pstmtrt);
	    			rsrt = null; pstmtrt = null;
	    		}
	    		if (rt == null)
	    			throw new IdempiereServiceFault("Web service type "
	    					+ m_webservicetype.getValue() + ": reference table "
	    					+ ref_id + " not found",
	    					new QName("getList"));
	    		
	    		MTable table = new MTable(ctx, rt.getAD_Table_ID(), null);
	    		MColumn column = new MColumn(ctx, rt.getAD_Key(), null);
	
	    		// TODO: if any value or identifier column is translated, then get them from trl table (and client has multilanguage documents enabled)
	    		sql = "SELECT " + column.getColumnName();
	    		listColumnNames.add(column.getColumnName());
	    		if (rt.isValueDisplayed()) {
	    			sql += ",Value";
	    			listColumnNames.add("Value");
	    		}
	    		
	    		String sqlident = "SELECT ColumnName FROM AD_Column WHERE AD_Table_ID=? AND IsActive='Y' AND IsIdentifier='Y' ORDER BY SeqNo";
	   			PreparedStatement pstmtident = null;
	    		ResultSet rsident = null;
	    		try
	    		{
	    			pstmtident = DB.prepareStatement (sqlident, null);
	    			pstmtident.setInt (1, rt.getAD_Table_ID());
	    			rsident = pstmtident.executeQuery ();
	    			while (rsident.next ()) {
	    				String colnameident = rsident.getString("ColumnName");
	    				if (rt.isValueDisplayed() && colnameident.equalsIgnoreCase("Value")) {
	    					// Value already added
	    				} else {
	            			sql += "," + colnameident;
	            			listColumnNames.add(colnameident);
	    				}
	    			}
	    		}
	    		catch (Exception e)
	    		{
	    			// ignore this exception
	    		}
	    		finally
	    		{
	    			DB.close(rsident, pstmtident);
	    			rsident = null; pstmtident = null;
	    		}
	    		
	    		sql += " FROM " + table.getTableName() + " WHERE IsActive='Y'";
	    		sql = role.addAccessSQL(sql, table.getTableName(), true, true);
	    		sql += filter;
	    		if (rt.getWhereClause() != null && rt.getWhereClause().length() > 0)
	    			sql += " AND " + rt.getWhereClause();
	    		if (rt.getOrderByClause() != null && rt.getOrderByClause().length() > 0)
	    			sql += " ORDER BY " + rt.getOrderByClause();
	
	    		try {
	   	   			pstmt = DB.prepareStatement(sql, null);
		   			rs = pstmt.executeQuery();
				} catch (SQLException e) {
	    			res.setError(e.getMessage());
	    			res.setErrorInfo(sql);
	    			res.setSuccess(false);
	    			DB.close(rs, pstmt);
	    			rs = null; pstmt = null;
					throw new IdempiereServiceFault(e.getClass().toString() + " " + e.getMessage() + " sql=" + sql, e.getCause(), new QName("getList"));
	    		}
	    		
	    	} else {
	    		// Don't fill - wrong type
	    	}
	
	    	if (rs != null) {
	    		try
	    		{
	    			while (rs.next()) {
	    				cnt++;
	    				// Add values to the dataset
	    				DataRow dr = ds.addNewDataRow();
	    				for (String listColumnName : listColumnNames) {
	    					if (m_webservicetype.isOutputColumnNameAllowed(listColumnName)) {
	        					DataField dfid = dr.addNewField();
	        					dfid.setColumn(listColumnName);
	        					dfid.setVal(rs.getString(listColumnName));
	    					}
	    				}
	    			}
	    			res.setSuccess(true);
	    		}
	    		catch (SQLException e)
	    		{
	    			res.setError(e.getMessage());
	    			res.setErrorInfo(sql);
	    			res.setSuccess(false);
					throw new IdempiereServiceFault(e.getClass().toString() + " " + e.getMessage() + " sql=" + sql, e.getCause(), new QName("getList"));
	    		}
	    		finally
	    		{
	    			DB.close(rs, pstmt);
	    			rs = null; pstmt = null;
	    		}
	    	}
	    	
	    	res.setRowCount(cnt);
	    	res.setNumRows(cnt);
	    	res.setTotalRows(cnt);
	    	res.setStartRow(1);
	
			return resdoc;
		} finally {
			if (!connected)
				getCompiereService().disconnect();
		}
	} // getList

	public StandardResponseDocument deleteData(ModelCRUDRequestDocument req) {
		boolean connected = getCompiereService().isConnected();
		
		try {
			if (!connected)
				getCompiereService().connect();
			
			StandardResponseDocument ret = StandardResponseDocument.Factory.newInstance();
			StandardResponse resp = ret.addNewStandardResponse();
			ModelCRUD modelCRUD = req.getModelCRUDRequest().getModelCRUD();
			String serviceType = modelCRUD.getServiceType();
	
			ADLoginRequest reqlogin = req.getModelCRUDRequest().getADLoginRequest();
			String err = login(reqlogin, webServiceName, "deleteData", serviceType);
			if (err != null && err.length() > 0) {
				resp.setError(err);
				resp.setIsError(true);
				return ret;
			}
	
			// Validate parameters vs service type
			try{
				validateCRUD(modelCRUD);
			} catch (IdempiereServiceFault e) {
				resp.setError(e.getMessage());
				resp.setIsError(true);
				return ret;
			}
	
			String tableName = modelCRUD.getTableName();
			int recordID = modelCRUD.getRecordID();
			resp.setRecordID(recordID);
	
			CompiereService m_cs = getCompiereService();
			Properties ctx = m_cs.getCtx();
	
			// start a trx
			String trxName = localTrxName;
			Trx trx = null;
			if (trxName == null) {
				trxName = Trx.createTrxName("ws_modelCreateData");
				manageTrx = true;
			}
	
			trx = Trx.get(trxName, true);
	
			// get the PO for the tablename and record ID
			MTable table = MTable.get(ctx, tableName);
			if (table == null)
				return rollbackAndSetError(trx, resp, ret, true, "No table " + tableName);
			PO po = table.getPO(recordID, trxName);
			if (po == null)
				return rollbackAndSetError(trx, resp, ret, true, "No Record " + recordID + " in " + tableName);
	
			if (!po.delete(false))
				return rollbackAndSetError(trx, resp, ret, true,
						"Cannot delete record " + recordID + " in " + tableName + ": " + CLogger.retrieveErrorString("no log message"));
	
			// close the trx
			if (manageTrx && !trx.commit())
				return rollbackAndSetError(trx, resp, ret, true, "Cannot commit transaction after delete record " + recordID + " in "
						+ tableName);
	
			if (manageTrx)
				trx.close();
	
			return ret;
		} finally {
			if (!connected)
				getCompiereService().disconnect();
		}
	}

	private void validateCRUD(ModelCRUD modelCRUD) {
		modelCRUD.setTableName(validateParameter("TableName", modelCRUD.getTableName()));
		modelCRUD.setRecordID(validateParameter("RecordID", modelCRUD.getRecordID()));
		modelCRUD.setFilter(validateParameter("Filter", modelCRUD.getFilter()));
		modelCRUD.setAction(validateParameter("Action", modelCRUD.getAction(), ModelCRUD.Action.Enum.table));
	}

	public StandardResponseDocument createData(ModelCRUDRequestDocument req){
		
		boolean connected = getCompiereService().isConnected();
		
		try {
			if (!connected)
				getCompiereService().connect();
			
	    	StandardResponseDocument ret = StandardResponseDocument.Factory.newInstance();
	    	StandardResponse resp = ret.addNewStandardResponse();
	    	ModelCRUD modelCRUD = req.getModelCRUDRequest().getModelCRUD();
			String serviceType = modelCRUD.getServiceType();
	    	
	    	ADLoginRequest reqlogin = req.getModelCRUDRequest().getADLoginRequest();
	    	String err = login(reqlogin, webServiceName, "createData", serviceType);
	    	if (err != null && err.length() > 0) {
	    		resp.setError(err);
	        	resp.setIsError(true);
	        	return ret;
	    	}
	
	    	// Validate parameters vs service type
	    	try{
	    		validateCRUD(modelCRUD);
	    	} catch (IdempiereServiceFault e) {
				resp.setError(e.getMessage());
				resp.setIsError(true);
				return ret;
			}
	
	    	String tableName = modelCRUD.getTableName();
	
	    	CompiereService m_cs= getCompiereService();
	    	Properties ctx = m_cs.getCtx();
	    	
	    	// start a trx
	    	String trxName = localTrxName;
	    	Trx trx = null;
	    	if(trxName==null){
	    		trxName = Trx.createTrxName("ws_modelCreateData");
	    		manageTrx = true;
	    	}
	    		
	    	trx = Trx.get(trxName, true);
	    	
	    	
	    	// get the PO for the tablename and record ID
	    	MTable table = MTable.get(ctx, tableName);
	    	if (table == null)
	    		return rollbackAndSetError(trx, resp, ret, true, "No table " + tableName);
	    	
	    	PO po = table.getPO(0, trxName);
	    	if (po == null)
	    		return rollbackAndSetError(trx, resp, ret, true, "Cannot create PO for " + tableName);
	    	POInfo poinfo = POInfo.getPOInfo(ctx, table.getAD_Table_ID());
	    	
	    	DataRow dr = modelCRUD.getDataRow();
	    	MWebServiceType m_webservicetype= getWebServiceType();
	
	    	Map<String,Object> requestCtx = getRequestCtx();
	    	
	    	DataField[] fields = dr.getFieldArray();
	    	StandardResponseDocument retResp =invokeWSValidator(m_webservicetype, IWSValidator.TIMING_BEFORE_PARSE, po, fields,trx,requestCtx, resp, ret);
			if (retResp != null)
				return retResp;
			
	    	retResp= scanFields(fields, m_webservicetype, po, poinfo, trx,resp,ret);
	    	if(retResp!=null)
	    		return retResp;
	    	
	    	retResp =invokeWSValidator(m_webservicetype, IWSValidator.TIMING_AFTER_PARSE, po, fields,trx,requestCtx, resp, ret);
			if (retResp != null)
				return retResp;
	    	
	
	    	retResp =invokeWSValidator(m_webservicetype, IWSValidator.TIMING_BEFORE_SAVE, po, fields,trx,requestCtx, resp, ret);
			if (retResp != null)
				return retResp;
			
	    	if (!po.save())
	    		return rollbackAndSetError(trx, resp, ret, true, "Cannot save record in " + tableName + ": " + CLogger.retrieveErrorString("no log message"));
	
	    	retResp =invokeWSValidator(m_webservicetype, IWSValidator.TIMING_AFTER_SAVE, po, fields,trx,requestCtx, resp, ret);
			if (retResp != null)
				return retResp;
			
	    	int recordID = po.get_ID();
	    	resp.setRecordID (recordID);
	    	
	    	//Update ctx variable for consecutive calls
	    	if(requestCtx!=null){
	    		requestCtx.put(po.get_TableName(), po);
	    	}
	
	    	// close the trx
			if (manageTrx && !trx.commit())
	    		return rollbackAndSetError(trx, resp, ret, true, "Cannot commit transaction after create record " + recordID + " in " + tableName);
	
			if (manageTrx)
				trx.close();
	    	
			setOuputFields(resp, m_webservicetype,po,poinfo);
			
			return ret;
		} finally {
			if (!connected)
				getCompiereService().disconnect();
				
		}
	} // createData

	public StandardResponseDocument createUpdateData(ModelCRUDRequestDocument req) {
		boolean connected = getCompiereService().isConnected();
		
		try {
			if (!connected)
				getCompiereService().connect();
			
			StandardResponseDocument ret = StandardResponseDocument.Factory.newInstance();
			StandardResponse resp = ret.addNewStandardResponse();
			ModelCRUD modelCRUD = req.getModelCRUDRequest().getModelCRUD();
			String serviceType = modelCRUD.getServiceType();
	
			ADLoginRequest reqlogin = req.getModelCRUDRequest().getADLoginRequest();
			String err = login(reqlogin, webServiceName, "createData", serviceType);
			if (err != null && err.length() > 0) {
				resp.setError(err);
				resp.setIsError(true);
				return ret;
			}
	
			// Validate parameters vs service type
			try{
				validateCRUD(modelCRUD);
			} catch (IdempiereServiceFault e) {
				resp.setError(e.getMessage());
				resp.setIsError(true);
				return ret;
			}
	
			String tableName = modelCRUD.getTableName();
	
			CompiereService m_cs = getCompiereService();
			Properties ctx = m_cs.getCtx();
	
			// start a trx
			String trxName = localTrxName;
			Trx trx = null;
			if (trxName == null) {
				trxName = Trx.createTrxName("ws_modelCreateData");
				manageTrx = true;
			}
			trx = Trx.get(trxName, true);
	
			// get the PO for the tablename and record ID
			MTable table = MTable.get(ctx, tableName);
			if (table == null)
				return rollbackAndSetError(trx, resp, ret, true, "No table " + tableName);
	
			DataRow dr = modelCRUD.getDataRow();
			DataField fields[] = dr.getFieldArray();
	
			PO holderPo = table.getPO(0, trxName);
			POInfo poinfo = POInfo.getPOInfo(ctx, table.getAD_Table_ID());
	
			MWebServiceType m_webservicetype = getWebServiceType();
			Map<String, Object> requestCtx = getRequestCtx();
	
			StandardResponseDocument retResp = invokeWSValidator(m_webservicetype, IWSValidator.TIMING_BEFORE_PARSE, holderPo, fields, trx,
					requestCtx, resp, ret);
			if (retResp != null)
				return retResp;
	
			retResp = scanFields(fields, m_webservicetype, holderPo, poinfo, trx, resp, ret);
			if (retResp != null)
				return retResp;
	
			retResp = invokeWSValidator(m_webservicetype, IWSValidator.TIMING_AFTER_PARSE, holderPo, fields, trx, requestCtx, resp, ret);
			if (retResp != null)
				return retResp;
	
			boolean isCreate = false;
			boolean isUpdate = false;
	
			String action = modelCRUD.getAction().toString();
			if (action.equals("Create"))
				isCreate = true;
			if (action.equals("Update"))
				isUpdate = true;
			if (action.equals("CreateUpdate")) {
				isCreate = true;
				isUpdate = true;
			}
	
			ArrayList<String> identifierList = m_webservicetype.getKeyColumns();
	
			// For update it is mandatory to pass key column
			if (isUpdate && identifierList.size() == 0) {
				return rollbackAndSetError(trx, resp, ret, true, "Web service type " + m_webservicetype.getValue()
						+ ": There is no key column found ");
			}
	
			// Check for existing element
			int record_id = 0;
			ArrayList<Object> resovedValue = new ArrayList<Object>();
			if (identifierList.size() > 0) {
				StringBuilder sqlBuilder = new StringBuilder("Select ");
				sqlBuilder.append(table.getTableName()).append("_ID from ").append(table.getTableName()).append(" ot Where ");
				ArrayList<Object> sqlParaList = new ArrayList<Object>();
				for (String colName : identifierList) {
					X_WS_WebServiceFieldInput fieldInput = m_webservicetype.getFieldInput(colName);
					if (fieldInput.getIdentifierLogic() == null) {
						if (holderPo.get_Value(colName) == null && fieldInput.isNullIdentifier()) {
							sqlBuilder.append(" ot.").append(colName).append(" Is Null AND ");
						} else if (holderPo.get_Value(colName) == null) {
							return rollbackAndSetError(trx, resp, ret, true, "Web service type " + m_webservicetype.getValue()
									+ ": Record Identifiier column " + colName + " must be set");
						} else {
							sqlBuilder.append(" ot.").append(colName).append("=? AND ");
							sqlParaList.add(holderPo.get_Value(colName));
							resovedValue.add(holderPo.get_Value(colName));
						}
					} else {
						// SQL
						String sql = parseSQL(fieldInput.getIdentifierLogic(), sqlParaList, holderPo, poinfo, requestCtx);
						sqlBuilder.append(" ot.").append(colName).append(" = (").append(sql).append(") AND ");
						resovedValue.add("DYN SQL");
					}
				}
				sqlBuilder.append(" ot.AD_Client_ID= ?");
				sqlParaList.add(Env.getAD_Client_ID(Env.getCtx()));
	
				String sql = sqlBuilder.toString();
				if (log.isLoggable(Level.INFO)) log.info("Web service type " + m_webservicetype.getValue() + "SQL to check existing record " + sql);
				try {
					record_id = DB.getSQLValueEx(trxName, sql, sqlParaList);
				} catch (Exception e) {
					log.log(Level.SEVERE, "ExistingRecordCheck: Exception while executing SQL :" + sql);
					return rollbackAndSetError(trx, resp, ret, true, "Web service type " + m_webservicetype.getValue()
							+ " Exception while executing sql :" + sql);
				}
			}
			if (record_id == -1)
				record_id = 0;
	
			if (!isCreate && record_id == 0) {
				resp.setError("No Record to update for " + table.getTableName() + " with (" + identifierList.toString() + ") = ("
						+ resovedValue.toString() + ")");
				resp.setIsError(true);
				return ret;
			}
	
			if (record_id > 0 && !isUpdate) {
				resp.setError("Record already presents with " + table.getTableName() + "_ID = " + record_id);
				resp.setIsError(true);
				return ret;
			}
	
			PO po = table.getPO(record_id, trxName);
	
			if (po == null)
				return rollbackAndSetError(trx, resp, ret, true, "Cannot create PO for " + tableName);
	
			if (po.get_ColumnIndex("Processed") >= 0 && po.get_ValueAsBoolean("Processed")) {
				resp.setError("Record not updatable for " + table.getTableName() + "_ID = " + record_id);
				resp.setIsError(true);
				return ret;
			}
	
			// Setting value back from holder to new persistent po
			for (DataField field : fields) {
				int indx = poinfo.getColumnIndex(field.getColumn());
				if (indx != -1) {
					po.set_ValueNoCheck(field.getColumn(), holderPo.get_Value(field.getColumn()));
				}
			}
	
			retResp = invokeWSValidator(m_webservicetype, IWSValidator.TIMING_BEFORE_SAVE, holderPo, fields, trx, requestCtx, resp, ret);
			if (retResp != null)
				return retResp;
	
			if (!po.save())
				return rollbackAndSetError(trx, resp, ret, true,
						"Cannot save record in " + tableName + ": " + CLogger.retrieveErrorString("no log message"));
	
			retResp = invokeWSValidator(m_webservicetype, IWSValidator.TIMING_AFTER_SAVE, holderPo, fields, trx, requestCtx, resp, ret);
			if (retResp != null)
				return retResp;
	
			int recordID = po.get_ID();
			resp.setRecordID(recordID);
	
			// Update ctx variable for consecutive calls
			if (requestCtx != null) {
				requestCtx.put(po.get_TableName(), po);
			}
	
			// close the trx
			if (manageTrx && !trx.commit())
				return rollbackAndSetError(trx, resp, ret, true, "Cannot commit transaction after create record " + recordID + " in "
						+ tableName);
	
			if (manageTrx)
				trx.close();
	
			setOuputFields(resp, m_webservicetype, po, poinfo);
	
			return ret;
		} finally {
			if (!connected)
				getCompiereService().disconnect();
		}
	} // createUpdateData

	private void setValueAccordingToClass(PO po, POInfo poinfo, DataField field, int idxcol) {
		CompiereService m_cs = getCompiereService();
		// Evaluate the type of the column and assign a proper variable
		Class<?> columnClass = poinfo.getColumnClass(idxcol);
		Object value = null;
		String strValue = field.getVal();
		String lookupValue = field.getLval();
		if (lookupValue != null && !"".equals(lookupValue)) {

			Lookup lookup = poinfo.getColumnLookup(idxcol);
			if (lookup == null) {
				throw new IdempiereServiceFault(field.getColumn() + " is not lookup column. Pass Value in val element ", new QName(
						"LookupResolutionFailed"));
			}
			
			String sql = getDirectAccessSQL(lookup, lookupValue.toUpperCase());
			int id = DB.getSQLValue(localTrxName, sql); 
			if (id > 0)
				value = id;

			if (value == null) {
				throw new IdempiereServiceFault(" Invalid Lookup value:" + lookupValue, new QName("LookupResolutionFailed"));
			}

		} else if (strValue == null || strValue.length() == 0) {
			value = null;
		} else {
			Map<String, Object> requestCtx = getRequestCtx();
			if (requestCtx != null && strValue.charAt(0) == '@') {
				String varName = strValue.substring(1);
				if (varName.charAt(0) == '#') {
					varName = varName.substring(1);
					strValue = m_cs.getCtx().getProperty(varName);
				} else {
					int indDot = varName.indexOf(".");
					if (indDot == -1) {
						// If there is no table name, then it should be
						// premitive data type
						value = requestCtx.get(varName);
					} else {
						String tblName = varName.substring(0, indDot);
						String colName = varName.substring(indDot + 1);
						if (colName.indexOf(".") >= 0) {
							throw new IdempiereServiceFault(field.getVal() + " contains un supported multi level object resolution",
									new QName("resolveCtxVariable"));
						}
						Object obj = requestCtx.get(tblName);
						if (obj == null || !(obj instanceof PO)) {
							throw new IdempiereServiceFault(" input column " + field.getColumn() + " can not found object of " + tblName
									+ ". Request variable " + field.getVal() + " can not resolved", new QName("resolveCtxVariable"));
						}

						PO refPO = (PO) obj;
						value = refPO.get_Value(colName);

					}

					if (value == null) {
						throw new IdempiereServiceFault(
								" input column " + field.getColumn() + " can not be resolved for value " + strValue, new QName(
										"resolveCtxVariable"));
					}
				}
			}
			if (value == null) {

				value = convertToObj(strValue, columnClass, field.getColumn());
			}
		}
		if (!po.set_ValueOfColumnReturningBoolean(field.getColumn(), value))
			throw new IdempiereServiceFault("Cannot set value of column " + field.getColumn(), new QName("setValueAccordingToClass"));
		//Setting context for lookup resolution
		Env.setContext(Env.getCtx(), 0, field.getColumn(), 	value==null ? null : value.toString());
	}

	public StandardResponseDocument scanFields(DataField[] fields,MWebServiceType m_webservicetype,PO po,POInfo poinfo,Trx trx,StandardResponse resp, StandardResponseDocument ret){
		Map<String,Object> requestCtx = getRequestCtx();
		
		//Clear ctx
		Env.clearWinContext(Env.getCtx(),0);
		
		for (DataField field : fields) {
			// Implement lookup
			X_WS_WebServiceFieldInput fieldInput = m_webservicetype.getFieldInput(field.getColumn());
			if (fieldInput != null) {
				//Is ctx variable
				if (fieldInput.getAD_Column_ID() == 0 && fieldInput.getColumnName() != null) { 
					String varName = fieldInput.getColumnName();
					Class<?> columnClass = getVariableType(varName, fieldInput.getAD_Reference_ID());
					Object objVal = convertToObj(field.getVal(),columnClass,varName); 
					requestCtx.put(varName, objVal);
					
				} else{ 

					int idxcol = po.get_ColumnIndex(field.getColumn());
					if (idxcol < 0) {
						// The column doesn't exist - it must exist as it's
						// defined in security
						return rollbackAndSetError(trx, resp, ret, true, "Web service type " + m_webservicetype.getValue()
								+ ": input column " + field.getColumn() + " does not exist");
					} else {
						try {
							setValueAccordingToClass(po, poinfo, field, idxcol);
						} catch (IdempiereServiceFault e) {
							log.log(Level.WARNING, "Error setting value", e);
							return rollbackAndSetError(trx, resp, ret, true, "Web service type " + m_webservicetype.getValue()
									+ ": input column " + field.getColumn() + " value could not be set: " + e.getLocalizedMessage());
						}
					}
				}
			} else {

				return rollbackAndSetError(trx, resp, ret, true, "Web service type " + m_webservicetype.getValue() + ": input column "
						+ field.getColumn() + " not allowed");
			}
		}
		
		return null;
	}
	
	public StandardResponseDocument updateData(ModelCRUDRequestDocument req){
		boolean connected = getCompiereService().isConnected();
		
		try {
			if (!connected)
				getCompiereService().connect();
			
	    	StandardResponseDocument ret = StandardResponseDocument.Factory.newInstance();
	    	StandardResponse resp = ret.addNewStandardResponse();
	    	ModelCRUD modelCRUD = req.getModelCRUDRequest().getModelCRUD();
			String serviceType = modelCRUD.getServiceType();
	    	
	    	ADLoginRequest reqlogin = req.getModelCRUDRequest().getADLoginRequest();
	    	String err = login(reqlogin, webServiceName, "updateData", serviceType);
	    	if (err != null && err.length() > 0) {
	    		resp.setError(err);
	        	resp.setIsError(true);
	        	return ret;
	    	}
	
	    	// Validate parameters vs service type
			try{
				validateCRUD(modelCRUD);
			} catch (IdempiereServiceFault e) {
				resp.setError(e.getMessage());
				resp.setIsError(true);
				return ret;
			}
	
	    	String tableName = modelCRUD.getTableName();
	    	int recordID = modelCRUD.getRecordID();
	    	resp.setRecordID (recordID);
	
	    	CompiereService m_cs = getCompiereService();
	    	MWebServiceType m_webservicetype= getWebServiceType();
	    	Properties ctx = m_cs.getCtx();
	    	
	    	// start a trx
	    	String trxName = localTrxName;
	    	Trx trx = null;
	    	if(trxName==null){
	    		trxName = Trx.createTrxName("ws_modelCreateData");
	    		manageTrx = true;
	    	}
	    	
	    	trx = Trx.get(trxName, true);
	    	
	    	
	    	
	    	// get the PO for the tablename and record ID
	    	MTable table = MTable.get(ctx, tableName);
	    	if (table == null)
	    		return rollbackAndSetError(trx, resp, ret, true, "No table " + tableName);
	    	PO po = table.getPO(recordID, trxName);
	    	if (po == null)
	    		return rollbackAndSetError(trx, resp, ret, true, "No Record " + recordID + " in " + tableName);
	    	POInfo poinfo = POInfo.getPOInfo(ctx, table.getAD_Table_ID());
	
	    	DataRow dr = modelCRUD.getDataRow();
	    	
	    	StandardResponseDocument retResp = scanFields(dr.getFieldArray(), m_webservicetype, po, poinfo, trx, resp, ret);
			if (retResp != null)
				return retResp;
	
	    	if(po.get_ColumnIndex("Processed")>=0 && po.get_ValueAsBoolean("Processed")){
	    		resp.setError("Record is processed and can not be updated");
	    		resp.setIsError(true);
	    		return ret;
	    	}
	    	
	    	if (!po.save())
	    		return rollbackAndSetError(trx, resp, ret, true, "Cannot save record in " + tableName + ": " + CLogger.retrieveErrorString("no log message"));
	
			// close the trx
			if (manageTrx && !trx.commit())
				return rollbackAndSetError(trx, resp, ret, true, "Cannot commit transaction after create record " + recordID + " in "
						+ tableName);
	
			if (manageTrx)
				trx.close();
	
			setOuputFields(resp, m_webservicetype, po, poinfo);
	
			return ret;
		} finally {
			if (!connected)
				getCompiereService().disconnect();
		}
	} // updateData

	public WindowTabDataDocument readData(ModelCRUDRequestDocument req) {
		boolean connected = getCompiereService().isConnected();
		
		try {
			if (!connected)
				getCompiereService().connect();
			
			WindowTabDataDocument ret = WindowTabDataDocument.Factory.newInstance();
			WindowTabData resp = ret.addNewWindowTabData();
	    	ModelCRUD modelCRUD = req.getModelCRUDRequest().getModelCRUD();
			String serviceType = modelCRUD.getServiceType();
			int cnt = 0;
	    	
	    	ADLoginRequest reqlogin = req.getModelCRUDRequest().getADLoginRequest();
	    	String err = login(reqlogin, webServiceName, "readData", serviceType);
	    	if (err != null && err.length() > 0) {
	    		resp.setError(err);
	        	return ret;
	    	}
	
	    	// Validate parameters vs service type
			try{
				validateCRUD(modelCRUD);
			} catch (IdempiereServiceFault e) {
				resp.setError(e.getMessage());
				return ret;
			}
	
			CompiereService m_cs = getCompiereService();
	    	MWebServiceType m_webservicetype= getWebServiceType();
	    	
	    	// start a trx
	    	String trxName = localTrxName;
	    	
	    	
	    	Properties ctx = m_cs.getCtx();
	    	String tableName = modelCRUD.getTableName();
	    	
	    	String recordIDVar = modelCRUD.getRecordIDVariable();
			int recordID = modelCRUD.getRecordID();
	
			if (recordIDVar != null && recordIDVar.startsWith("@")) {
				Integer retVal = (Integer) parseVariable(recordIDVar, null, null, getRequestCtx());
				if (retVal == null) {
					resp.setError("Cannot resolve variable: " + recordIDVar);
					return ret;
				}
				recordID=retVal;
			}
	
	    	// get the PO for the tablename and record ID
	    	MTable table = MTable.get(ctx, tableName);
	    	if (table == null)
				throw new IdempiereServiceFault("Web service type "
						+ m_webservicetype.getValue() + ": table "
						+ tableName + " not found",
						new QName("readData"));
	    	PO po = table.getPO(recordID, trxName);
	    	if (po == null) {
	    		resp.setSuccess(false);
	        	resp.setRowCount(cnt);
	        	resp.setNumRows(cnt);
	        	resp.setTotalRows(cnt);
	        	resp.setStartRow(0);
	    		return ret;
	    	}
	    	cnt = 1;
	    	
	    	POInfo poinfo = POInfo.getPOInfo(ctx, table.getAD_Table_ID());
	
	    	DataSet ds = resp.addNewDataSet();
			DataRow dr = ds.addNewDataRow();
			for (int i = 0; i < poinfo.getColumnCount(); i++) {
	    		String columnName = poinfo.getColumnName(i);
				if (m_webservicetype.isOutputColumnNameAllowed(columnName)) {
					DataField dfid = dr.addNewField();
					dfid.setColumn(columnName);
					if (po.get_Value(i) != null)
						dfid.setVal(po.get_Value(i).toString());
					else
						dfid.setVal(null);
				}
	    	}
	    	
			resp.setSuccess(true);
	    	resp.setRowCount(cnt);
	    	resp.setNumRows(cnt);
	    	resp.setTotalRows(cnt);
	    	resp.setStartRow(1);
	
			return ret;
		} finally {
			if (!connected)
				getCompiereService().disconnect();
		}
	}

	public WindowTabDataDocument queryData(ModelCRUDRequestDocument req) {
		boolean connected = getCompiereService().isConnected();
		
		try {
			if (!connected)
				getCompiereService().connect();
			
			CompiereService m_cs = getCompiereService();
			WindowTabDataDocument ret = WindowTabDataDocument.Factory.newInstance();
			WindowTabData resp = ret.addNewWindowTabData();
	    	ModelCRUD modelCRUD = req.getModelCRUDRequest().getModelCRUD();
			String serviceType = modelCRUD.getServiceType();
	    	
	    	ADLoginRequest reqlogin = req.getModelCRUDRequest().getADLoginRequest();
	    	String err = login(reqlogin, webServiceName, "queryData", serviceType);
	    	if (err != null && err.length() > 0) {
	    		resp.setError(err);
	        	return ret;
	    	}
	
	    	// Validate parameters vs service type
			validateCRUD(modelCRUD);
	
	    	Properties ctx = m_cs.getCtx();
	    	String tableName = modelCRUD.getTableName();
	    	
	    	MWebServiceType  m_webservicetype = getWebServiceType();
	    	// get the PO for the tablename and record ID
	    	MTable table = MTable.get(ctx, tableName);
	    	if (table == null)
				throw new IdempiereServiceFault("Web service type "
						+ m_webservicetype.getValue() + ": table "
						+ tableName + " not found",
						new QName("queryData"));
	
			int roleid = reqlogin.getRoleID();
			MRole role = new MRole(ctx, roleid, null);
	
	    	String sqlquery = "SELECT * FROM " + tableName;
			sqlquery = role.addAccessSQL(sqlquery, tableName, true, true);
			
			for (DataField field : modelCRUD.getDataRow().getFieldArray()) {
	    		if (m_webservicetype.isInputColumnNameAllowed(field.getColumn())) {
	        		sqlquery += " AND " + field.getColumn() + "=?";
	    		} else {
					throw new IdempiereServiceFault("Web service type "
							+ m_webservicetype.getValue() + ": input column "
							+ field.getColumn() + " not allowed", new QName("queryData"));
	    		}
			}
			
			if (modelCRUD.getFilter() != null && modelCRUD.getFilter().length() > 0)
				sqlquery += " AND " + modelCRUD.getFilter();
			
	    	POInfo poinfo = POInfo.getPOInfo(ctx, table.getAD_Table_ID());
	    	int cnt = 0;
	
	    	PreparedStatement pstmtquery = null;
			ResultSet rsquery = null;
			try
			{
				pstmtquery = DB.prepareStatement (sqlquery, null);
				int p = 1;
				for (DataField field : modelCRUD.getDataRow().getFieldArray()) {
	    			int idx = poinfo.getColumnIndex(field.getColumn());
	    			Class<?> c = poinfo.getColumnClass(idx);
	    			if (c == Integer.class)
		        		pstmtquery.setInt(p++, Integer.valueOf(field.getVal()));
	    			else if (c == Timestamp.class)
		        		pstmtquery.setTimestamp(p++, Timestamp.valueOf(field.getVal()));
	    			else if (c == Boolean.class || c == String.class)
		        		pstmtquery.setString(p++, field.getVal());
				}
				rsquery = pstmtquery.executeQuery ();
				// Angelo Dabala' (genied) must create just one DataSet, moved outside of the while loop
				DataSet ds = resp.addNewDataSet();
				while (rsquery.next ()) {
					cnt++;
					DataRow dr = ds.addNewDataRow();
					for (int i = 0; i < poinfo.getColumnCount(); i++) {
			    		String columnName = poinfo.getColumnName(i);
						if (m_webservicetype.isOutputColumnNameAllowed(columnName)) {
							DataField dfid = dr.addNewField();
							dfid.setColumn(columnName);
							dfid.setVal(rsquery.getString(columnName));
						}
			    	}
				}
			}
			catch (Exception e)
			{
				// ignore this exception
			}
			finally
			{
				DB.close(rsquery, pstmtquery);
				rsquery = null; pstmtquery = null;
			}
	
			resp.setSuccess(true);
	    	resp.setRowCount(cnt);
	    	resp.setNumRows(cnt);
	    	resp.setTotalRows(cnt);
	    	resp.setStartRow(1);
	
			return ret;
		} finally {
			if (!connected)
				getCompiereService().disconnect();
		}
	}

	
	/**
	 * 	Generate Access SQL for Search.
	 * 	The SQL returns the ID of the value entered
	 * 	Also sets m_tableName and m_keyColumnName
	 *	@param text uppercase text for LIKE comparison
	 *	@return sql or ""
	 *  Example
	 *	SELECT C_Payment_ID FROM C_Payment WHERE UPPER(DocumentNo) LIKE x OR ...
	 */
	private String getDirectAccessSQL (Lookup lookup, String text)
	{
		String m_columnName = lookup.getColumnName();

		String m_tableName = null;
		String m_keyColumnName = null;
		StringBuffer sql = new StringBuffer();
		if (m_columnName.indexOf(".") > 0) {
			m_tableName = m_columnName.substring(0, m_columnName.indexOf("."));
			m_keyColumnName = m_columnName.substring(m_columnName.indexOf(".")+1);
		} else {
			m_tableName = m_columnName.substring(0, m_columnName.length()-3);
			m_keyColumnName = m_columnName;
		}

		if (m_columnName.equals("M_Product_ID"))
		{
			sql.append("SELECT M_Product_ID FROM M_Product WHERE (UPPER(Value) LIKE ")
				.append(DB.TO_STRING(text))
				.append(" OR UPPER(Name) LIKE ").append(DB.TO_STRING(text))
				.append(" OR UPC LIKE ").append(DB.TO_STRING(text)).append(")");
		}
		else if (m_columnName.equals("C_BPartner_ID"))
		{
			sql.append("SELECT C_BPartner_ID FROM C_BPartner WHERE (UPPER(Value) LIKE ")
				.append(DB.TO_STRING(text))
				.append(" OR UPPER(Name) LIKE ").append(DB.TO_STRING(text)).append(")");
		}
		else if (m_columnName.equals("C_Order_ID"))
		{
			sql.append("SELECT C_Order_ID FROM C_Order WHERE UPPER(DocumentNo) LIKE ")
				.append(DB.TO_STRING(text));
		}
		else if (m_columnName.equals("C_Invoice_ID"))
		{
			sql.append("SELECT C_Invoice_ID FROM C_Invoice WHERE UPPER(DocumentNo) LIKE ")
				.append(DB.TO_STRING(text));
		}
		else if (m_columnName.equals("M_InOut_ID"))
		{
			sql.append("SELECT M_InOut_ID FROM M_InOut WHERE UPPER(DocumentNo) LIKE ")
				.append(DB.TO_STRING(text));
		}
		else if (m_columnName.equals("C_Payment_ID"))
		{
			sql.append("SELECT C_Payment_ID FROM C_Payment WHERE UPPER(DocumentNo) LIKE ")
				.append(DB.TO_STRING(text));
		}
		else if (m_columnName.equals("GL_JournalBatch_ID"))
		{
			sql.append("SELECT GL_JournalBatch_ID FROM GL_JournalBatch WHERE UPPER(DocumentNo) LIKE ")
				.append(DB.TO_STRING(text));
		}
		else if (m_columnName.equals("SalesRep_ID"))
		{
			sql.append("SELECT AD_User_ID FROM AD_User WHERE UPPER(Name) LIKE ")
				.append(DB.TO_STRING(text));

			m_tableName = "AD_User";
			m_keyColumnName = "AD_User_ID";
		}

		//	Predefined

		if (sql.length() > 0)
		{
			String wc = getWhereClause(lookup);

			if (wc != null && wc.length() > 0)
				sql.append(" AND ").append(wc);

			sql.append(" AND IsActive='Y'");
			//	***

			if (log.isLoggable(Level.FINEST))
				log.finest(m_columnName + " (predefined) " + sql.toString());

			return MRole.getDefault().addAccessSQL(sql.toString(),
				m_tableName, MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
		}

		//	Check if it is a Table Reference

		if (lookup != null && lookup instanceof MLookup)
		{
			int AD_Reference_ID = ((MLookup)lookup).getAD_Reference_Value_ID();

			if (AD_Reference_ID != 0)
			{
				boolean isValueDisplayed = false;
				String query = "SELECT kc.ColumnName, dc.ColumnName, t.TableName, rt.IsValueDisplayed "
					+ "FROM AD_Ref_Table rt"
					+ " INNER JOIN AD_Column kc ON (rt.AD_Key=kc.AD_Column_ID)"
					+ " INNER JOIN AD_Column dc ON (rt.AD_Display=dc.AD_Column_ID)"
					+ " INNER JOIN AD_Table t ON (rt.AD_Table_ID=t.AD_Table_ID) "
					+ "WHERE rt.AD_Reference_ID=?";

				String displayColumnName = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try
				{
					pstmt = DB.prepareStatement(query, null);
					pstmt.setInt(1, AD_Reference_ID);
					rs = pstmt.executeQuery();

					if (rs.next())
					{
						m_keyColumnName = rs.getString(1);
						displayColumnName = rs.getString(2);
						m_tableName = rs.getString(3);
						String t = rs.getString(4);
						isValueDisplayed = "Y".equalsIgnoreCase(t);
					}
				}
				catch (Exception e)
				{
					log.log(Level.SEVERE, query, e);
				}
				finally
				{
					DB.close(rs, pstmt);
				}


				if (displayColumnName != null)
				{
					sql = new StringBuffer();
					sql.append("SELECT ").append(m_keyColumnName)
						.append(" FROM ").append(m_tableName)
						.append(" WHERE (UPPER(").append(displayColumnName)
						.append(") LIKE ").append(DB.TO_STRING(text));
					if (isValueDisplayed)
					{
						sql.append(" OR UPPER(").append("Value")
						   .append(") LIKE ").append(DB.TO_STRING(text));
					}
					sql.append(")");
					sql.append(" AND IsActive='Y'");

					String wc = getWhereClause(lookup);

					if (wc != null && wc.length() > 0)
						sql.append(" AND ").append(wc);

					//	***

					if (log.isLoggable(Level.FINEST))
						log.finest(m_columnName + " (Table) " + sql.toString());

					return MRole.getDefault().addAccessSQL(sql.toString(),
								m_tableName, MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
				}
			} // Table Reference
		} // MLookup

		/** Check Well Known Columns of Table - assumes TableDir	**/

		String query = "SELECT t.TableName, c.ColumnName "
			+ "FROM AD_Column c "
			+ " INNER JOIN AD_Table t ON (c.AD_Table_ID=t.AD_Table_ID AND t.IsView='N') "
			+ "WHERE (c.ColumnName IN ('DocumentNo', 'Value', 'Name') OR c.IsIdentifier='Y')"
			+ " AND c.AD_Reference_ID IN (10,14)"
			+ " AND EXISTS (SELECT * FROM AD_Column cc WHERE cc.AD_Table_ID=t.AD_Table_ID"
				+ " AND cc.IsKey='Y' AND cc.ColumnName=?)";

		sql = new StringBuffer();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(query, null);
			pstmt.setString(1, m_keyColumnName);
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				if (sql.length() != 0)
					sql.append(" OR ");

				m_tableName = rs.getString(1);
				sql.append("UPPER(").append(rs.getString(2)).append(") LIKE ").append(DB.TO_STRING(text));
			}
		}
		catch (SQLException ex)
		{
			log.log(Level.SEVERE, query, ex);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//
		if (sql.length() == 0)
		{
			log.log(Level.SEVERE, m_columnName + " (TableDir) - no standard/identifier columns");
			return "";
		}
		//
		StringBuffer retValue = new StringBuffer ("SELECT ")
			.append(m_columnName).append(" FROM ").append(m_tableName)
			.append(" WHERE ").append(sql)
			.append(" AND IsActive='Y'");

		String wc = getWhereClause(lookup);

		if (wc != null && wc.length() > 0)
			retValue.append(" AND ").append(wc);
		//	***
		if (log.isLoggable(Level.FINEST))
			log.finest(m_columnName + " (TableDir) " + sql.toString());
		return MRole.getDefault().addAccessSQL(retValue.toString(),
					m_tableName, MRole.SQL_NOTQUALIFIED, MRole.SQL_RO);
	}
	
	private String getWhereClause(Lookup lookup)
	{
		String whereClause = "";

		if (lookup == null)
			return "";

		if (lookup.getZoomQuery() != null)
			whereClause = lookup.getZoomQuery().getWhereClause();

		String validation = lookup.getValidation();

		if (validation == null)
			validation = "";

		if (whereClause.length() == 0)
			whereClause = validation;
		else if (validation.length() > 0)
			whereClause += " AND " + validation;

		//	log.finest("ZoomQuery=" + (lookup.getZoomQuery()==null ? "" : lookup.getZoomQuery().getWhereClause())
	//		+ ", Validation=" + lookup.getValidation());

		if (whereClause.indexOf('@') != -1)
		{
			String validated = Env.parseContext(Env.getCtx(), lookup.getWindowNo(), whereClause, false);

			if (validated.length() == 0)
				log.severe(lookup.getColumnName() + " - Cannot Parse=" + whereClause);
			else
			{
				if (log.isLoggable(Level.FINE))
					log.fine(lookup.getColumnName() + " - Parsed: " + validated);
				return validated;
			}
		}
		return whereClause;
	}	//	getWhereClause
}