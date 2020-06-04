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
import java.util.ArrayList;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import javax.jws.WebService;
import javax.xml.namespace.QName;
import javax.xml.ws.WebServiceContext;

import org.apache.commons.codec.binary.Base64;
import org.apache.cxf.jaxrs.ext.MessageContext;
import org.apache.xmlbeans.StringEnumAbstractBase.Table;
import org.apache.xmlbeans.XmlInt;
import org.apache.xmlbeans.impl.values.XmlValueOutOfRangeException;
import org.compiere.model.I_AD_Column;
import org.compiere.model.Lookup;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MRefTable;
import org.compiere.model.MReference;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.MWebServiceType;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.X_WS_WebServiceFieldInput;
import org.compiere.model.X_WS_WebService_Para;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
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

	private static final CLogger	log = CLogger.getCLogger(ModelADServiceImpl.class);
	
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
	
	public ModelADServiceImpl(WebServiceContext soapContext,  MessageContext jaxrsContext)
	{
		this.jaxwsContext = soapContext;
		this.jaxrsContext = jaxrsContext;
		
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
		Trx trx=null;
		try {
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
	
			trx = Trx.get(trxName, true);
			if (manageTrx)
				trx.setDisplayName(getClass().getName()+"_"+webServiceName+"_setDocAction");
			
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
	
			// resp.setError("");
			resp.setIsError(false);
	
			POInfo poinfo = POInfo.getPOInfo(ctx, table.getAD_Table_ID());
			setOuputFields(resp, m_webservicetype, po, poinfo);
			
			
			
			return ret;
		} finally {
			if (manageTrx && trx != null)
				trx.close();

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
				if (log.isLoggable(Level.INFO))log.log(Level.INFO, "Web service type "
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
		return validateParameter(parameterName, i, null);
	}
	
	private int validateParameter(String parameterName, int i, String uuid) {
		Integer io = Integer.valueOf(i);
		String string = validateParameter(parameterName, io.toString());
		// Use the UUID only if the returned string is empty to not override the constant value if any
		if (string == null || string.equals("0"))
			string = uuid;
		
		if (string == null)
			return -1;
		if (string.equals(io.toString()))
			return i;
		if (parameterName.endsWith("_ID") && ADLookup.isUUID(string)) {
			String tableName = parameterName.substring(0, parameterName.length()-3);
			StringBuilder sql = new StringBuilder("SELECT ");
			sql.append(parameterName).append(" FROM ").append(tableName)
				.append(" WHERE ").append(tableName).append("_UU=?");
			return DB.getSQLValue(null, sql.toString(), string);
		}
		
		Map<String, Object> requestCtx = getRequestCtx();
		if (requestCtx != null && string.charAt(0) == '@') {
			Object value = parseVariable(getCompiereService(), requestCtx, parameterName, string);
			if (value != null && value instanceof Number) {
				return ((Number)value).intValue();
			} else if (value != null ){
				string = value.toString();
			} else {
				return -1;
			}
		}
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
		try {
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
			try {
				modelRunProcess.setADMenuID(validateParameter("AD_Menu_ID", modelRunProcess.getADMenuID()));
			} catch(XmlValueOutOfRangeException e) { //	Catch the exception when the Menu ID is not an Integer
				String menuUU = getUUIDValue(modelRunProcess.xgetADMenuID());
				if (menuUU == null) {
					throw e;
				}
				modelRunProcess.setADMenuID(validateParameter("AD_Menu_ID", 0, menuUU));
			}
			try {
				modelRunProcess.setADProcessID(validateParameter("AD_Process_ID", modelRunProcess.getADProcessID()));
			} catch(XmlValueOutOfRangeException e) { //	Catch the exception when the Process ID is not an Integer
				String processUU = getUUIDValue(modelRunProcess.xgetADProcessID());
				if (processUU == null) {
					throw e;
				}
				modelRunProcess.setADProcessID(validateParameter("AD_Process_ID", 0, processUU));
			}
			modelRunProcess.setADRecordID(validateParameter("AD_Record_ID", modelRunProcess.getADRecordID()));
			modelRunProcess.setDocAction(validateParameter("DocAction", modelRunProcess.getDocAction()));
	
			RunProcessDocument docprocess = RunProcessDocument.Factory.newInstance();
			RunProcess reqprocess = docprocess.addNewRunProcess();
			reqprocess.setParamValues(modelRunProcess.getParamValues());
			reqprocess.setADProcessID(modelRunProcess.getADProcessID());
			reqprocess.setADMenuID(modelRunProcess.getADMenuID());
			reqprocess.setADRecordID(modelRunProcess.getADRecordID());
			reqprocess.setDocAction(modelRunProcess.getDocAction());
			RunProcessResponseDocument response = Process.runProcess(getCompiereService(), docprocess, getRequestCtx(), localTrxName);
			if (response != null && response.getRunProcessResponse() != null && response.getRunProcessResponse().getIsError())
				log.warning("Error running webservice " + serviceType + " -> " + response.getRunProcessResponse().getError());
			Map<String, Object> requestCtx = getRequestCtx();
			requestCtx.put(serviceType+"_Summary", response.getRunProcessResponse().getSummary());
			return response;
		} finally {
			getCompiereService().disconnect();
		}
	}
	
	private String getUUIDValue(XmlInt xmlInt) {
		if (xmlInt != null) {
			// String xml <...> blocks
		    String content = xmlInt.toString().replaceAll("<[^>]*>", "");
		    if (! Util.isEmpty(content, true) && ADLookup.isUUID(content))
		    	return content;
		}

		//No UUID value
		return null;
	}

	public WindowTabDataDocument getList(ModelGetListRequestDocument req) {
		try {
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
			try {
				modelGetList.setADReferenceID(validateParameter("AD_Reference_ID", modelGetList.getADReferenceID()));
			} catch(XmlValueOutOfRangeException e) { //	Catch the exception when the Reference ID is not an Integer
				String refUU = getUUIDValue(modelGetList.xgetADReferenceID());
				if (refUU == null) {
					throw e;
				}
				modelGetList.setADReferenceID(validateParameter("AD_Reference_ID", 0, refUU));
			}
			modelGetList.setFilter(validateParameter("Filter", modelGetList.getFilter()));
	
	    	int ref_id = modelGetList.getADReferenceID();
	    	String filter = modelGetList.getFilter();
	    	if (filter == null || filter.length() == 0)
	    		filter = "";
	    	else
	    		filter = " AND " + filter;
	
	    	CompiereService m_cs = getCompiereService();
	    	
	    	Properties ctx = m_cs.getCtx();
	
	    	MReference ref = MReference.get(ctx, ref_id);
	    	
	    	String sql = null;
			ArrayList<String> listColumnNames = new ArrayList<String>();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			MWebServiceType m_webservicetype= getWebServiceType();
	    	if (MReference.VALIDATIONTYPE_ListValidation.equals(ref.getValidationType())) {
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
	
	    	} else if (MReference.VALIDATIONTYPE_TableValidation.equals(ref.getValidationType())) {
	    		// Fill values from a reference table
	    		MRole role = MRole.get(ctx, roleid);
	    		MRefTable rt = MRefTable.get(ctx,  ref_id);
	    		if (rt == null || rt.get_ID() == 0)
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
			getCompiereService().disconnect();
		}
	} // getList

	public StandardResponseDocument deleteData(ModelCRUDRequestDocument req) {
		Trx trx = null;
		try {
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
			
			if (trxName == null) {
				trxName = Trx.createTrxName("ws_modelCreateData");
				manageTrx = true;
			}
	
			trx = Trx.get(trxName, true);
			if (manageTrx)
				trx.setDisplayName(getClass().getName()+"_"+webServiceName+"_deleteData");
	
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
	
			return ret;
		} finally {
			if (manageTrx && trx != null)
				trx.close();
			
			getCompiereService().disconnect();
		}
	}

	private void validateCRUD(ModelCRUD modelCRUD) {
		modelCRUD.setTableName(validateParameter("TableName", modelCRUD.getTableName()));
		modelCRUD.setRecordID(validateParameter("RecordID", modelCRUD.getRecordID()));
		modelCRUD.setFilter(validateParameter("Filter", modelCRUD.getFilter()));
		modelCRUD.setAction(validateParameter("Action", modelCRUD.getAction(), ModelCRUD.Action.Enum.table));
	}

	public StandardResponseDocument createData(ModelCRUDRequestDocument req) {
		Trx trx = null;
		try {
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
	    	
	    	if(trxName==null){
	    		trxName = Trx.createTrxName("ws_modelCreateData");
	    		manageTrx = true;
	    	}
	    		
	    	trx = Trx.get(trxName, true);
	    	if (manageTrx)
	    		trx.setDisplayName(getClass().getName()+"_"+webServiceName+"_createData");
	    	
	    	
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
	
			setOuputFields(resp, m_webservicetype,po,poinfo);
			
			return ret;
		} finally {
			if (manageTrx && trx != null)
				trx.close();
			
			getCompiereService().disconnect();
				
		}
	} // createData

	public StandardResponseDocument createUpdateData(ModelCRUDRequestDocument req) {
		Trx trx = null;
		try {
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
			
			if (trxName == null) {
				trxName = Trx.createTrxName("ws_modelCreateData");
				manageTrx = true;
			}
			trx = Trx.get(trxName, true);
			if (manageTrx)
				trx.setDisplayName(getClass().getName()+"_"+webServiceName+"_createUpdateData");
	
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
									+ ": Record Identifier column " + colName + " must be set");
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
	
			setOuputFields(resp, m_webservicetype, po, poinfo);
	
			return ret;
		} finally {
			if (manageTrx && trx != null)
				trx.close();
			
			getCompiereService().disconnect();
		}
	} // createUpdateData

	private void setValueAccordingToClass(PO po, POInfo poinfo, DataField field, int idxcol,X_WS_WebServiceFieldInput fieldInput) {
		CompiereService m_cs = getCompiereService();
		// Evaluate the type of the column and assign a proper variable
		Class<?> columnClass = poinfo.getColumnClass(idxcol);
		Object value = null;
		String strValue = field.getVal();
		String lookupValue = field.getLval();
		if (!Util.isEmpty(lookupValue)) {
			Lookup lookup = null;
			
			if(fieldInput.getAD_Reference_ID() > 0 && fieldInput.getAD_Reference_Value_ID()>0)
			{
				try{
					lookup = MLookupFactory.get(m_cs.getCtx(),0,poinfo.getAD_Column_ID(poinfo.getColumnName(idxcol)),fieldInput.getAD_Reference_ID(),Env.getLanguage(m_cs.getCtx()),poinfo.getColumnName(idxcol),fieldInput.getAD_Reference_Value_ID(),false,null); 
				}catch (Exception e) {
					throw new IdempiereServiceFault("Exception in resolving overridden lookup ", new QName(
							"LookupResolutionFailed"));
				}
			}
			else
			{
				lookup = poinfo.getColumnLookup(idxcol);
			}
			
			if (lookup == null) {
				throw new IdempiereServiceFault(field.getColumn() + " is not lookup column. Pass Value in val element ", new QName(
						"LookupResolutionFailed"));
			}
			
			int AD_Reference_ID = 0;
			if(lookup instanceof MLookup){
				AD_Reference_ID = ((MLookup)lookup).getDisplayType();
			}
			
			if(AD_Reference_ID==DisplayType.List)
			{
				if (lookup.getSize() == 0)
					lookup.refresh();
				Object[] list = lookup.getData(true, true, true, false,false).toArray(); // IDEMPIERE 90
	
				for (Object pair : list) {
					if (pair instanceof KeyNamePair) {
						KeyNamePair p = (KeyNamePair) pair;
						if (p.getName().equalsIgnoreCase(lookupValue)) {
							value = p.getID();
							break;
						}
					} else {
						ValueNamePair p = (ValueNamePair) pair;
						if (p.getName().equalsIgnoreCase(lookupValue)) {
							value = p.getValue();
							break;
						}
					}
				}
			}else{
				String sql = ADLookup.getDirectAccessSQL(lookup, lookupValue.toUpperCase());
				int id = DB.getSQLValue(localTrxName, sql); 
				if (id > 0)
					value = id;
			}
			if (value == null) {
				throw new IdempiereServiceFault(" Invalid Lookup value:" + lookupValue, new QName("LookupResolutionFailed"));
			}

		} else if (strValue == null || strValue.length() == 0) {
			value = null;
		} else {
			Map<String, Object> requestCtx = getRequestCtx();
			if (requestCtx != null && strValue.charAt(0) == '@') {
				value = parseVariable(getCompiereService(), requestCtx, field.getColumn(), strValue);
			}
			if (value == null) {
				value = convertToObj(strValue, columnClass, field.getColumn());
			} else if (value instanceof String && !columnClass.equals(String.class)) {
				value = convertToObj(value.toString(), columnClass, field.getColumn());
			}
		}
		if (!po.set_ValueOfColumnReturningBoolean(field.getColumn(), value)) {
			ValueNamePair error = CLogger.retrieveError();
			if (error != null) {
				log.log(Level.SEVERE, error.getValue() + ", " + error.getName() + ": " + field.getColumn());
			}
			throw new IdempiereServiceFault("Cannot set value of column " + field.getColumn(), new QName("setValueAccordingToClass"));
		}
		//Setting context for lookup resolution
		Env.setContext(Env.getCtx(), 0, field.getColumn(), 	value==null ? null : value.toString());
	}

	public static Object parseVariable(CompiereService cs, Map<String, Object> requestCtx, String name, String strValue) {		
		String varName = strValue.substring(1);
		if (varName.charAt(0) == '#') {
			return cs.getCtx().getProperty(varName);
		} else {
			int indDot = varName.indexOf(".");
			if (indDot == -1) {
				// If there is no table name, then it should be
				// premitive data type
				return requestCtx.get(varName);
			} else {
				String tblName = varName.substring(0, indDot);
				String colName = varName.substring(indDot + 1);
				if (colName.indexOf(".") >= 0) {
					throw new IdempiereServiceFault(strValue + " contains un supported multi level object resolution",
							new QName("resolveCtxVariable"));
				}
				Object obj = requestCtx.get(tblName);
				if (obj == null || !(obj instanceof PO)) {
					throw new IdempiereServiceFault(" input column " + name + " can not found object of " + tblName
							+ ". Request variable " + strValue + " can not resolved", new QName("resolveCtxVariable"));
				}

				PO refPO = (PO) obj;
				return refPO.get_Value(colName);

			}
		}
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
					Object objVal = null;
					String val = field.getVal();
					if(val!=null && val.length() > 0 && val.charAt(0) == '@')
						objVal = parseVariable(field.getVal(), po, poinfo, requestCtx);
					else
						objVal = convertToObj(field.getVal(),columnClass,varName);
					
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
							setValueAccordingToClass(po, poinfo, field, idxcol,fieldInput);
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
		Trx trx = null;
		try {
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
	    	
	    	if(trxName==null){
	    		trxName = Trx.createTrxName("ws_modelCreateData");
	    		manageTrx = true;
	    	}
	    	
	    	trx = Trx.get(trxName, true);
	    	if (manageTrx)
	    		trx.setDisplayName(getClass().getName()+"_"+webServiceName+"_updateData");
	    	
	    	
	    	
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
				
			setOuputFields(resp, m_webservicetype, po, poinfo);
	
			return ret;
		} finally {
			if (manageTrx && trx != null)
				trx.close();
			
			getCompiereService().disconnect();
		}
	} // updateData

	public WindowTabDataDocument readData(ModelCRUDRequestDocument req) {
		try {
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
					if (po.get_Value(i) != null){						
						if(po.get_Value(i) instanceof byte[]){
							dfid.setVal(new String(Base64.encodeBase64((byte[]) po.get_Value(i))));
						}
						else if(po.get_Value(i) instanceof Boolean) {
							dfid.setVal((Boolean)po.get_Value(i) ? "Y" : "N");
						}
						else {
							dfid.setVal(po.get_Value(i).toString());
						}
					}else
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
			getCompiereService().disconnect();
		}
	}

	public WindowTabDataDocument queryData(ModelCRUDRequestDocument req) {
		Trx trx=null;
		try {
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
	    	Map<String, Object> reqCtx = getRequestCtx();
	    	MWebServiceType  m_webservicetype = getWebServiceType();
	    	// get the PO for the tablename and record ID
	    	MTable table = MTable.get(ctx, tableName);
	    	if (table == null)
				throw new IdempiereServiceFault("Web service type "
						+ m_webservicetype.getValue() + ": table "
						+ tableName + " not found",
						new QName("queryData"));
	
			int roleid = reqlogin.getRoleID();
			MRole role = MRole.get(ctx, roleid);
			
			// start a trx
			String trxName = localTrxName;

			if (trxName == null) {
				trxName = Trx.createTrxName("ws_modelQueryData");
				manageTrx = true;
			}
			trx = Trx.get(trxName, true);
			if (manageTrx)
				trx.setDisplayName(getClass().getName()+"_"+webServiceName+"_queryData");
			
	    	StringBuilder sqlBuilder = new StringBuilder(role.addAccessSQL("SELECT * FROM " + tableName, tableName, true, MRole.SQL_RO));
			
			ArrayList<Object> sqlParaList = new ArrayList<Object>();
			PO holderPo = table.getPO(0, trxName);
			POInfo poinfo = POInfo.getPOInfo(ctx, table.getAD_Table_ID());
			
			if (modelCRUD.getDataRow() != null)
			{
				DataRow dr = modelCRUD.getDataRow();
				DataField fields[] = dr.getFieldArray();
				StandardResponseDocument stdRet = StandardResponseDocument.Factory.newInstance();
				StandardResponse stdResp = stdRet.addNewStandardResponse();
		
				StandardResponseDocument retResp = invokeWSValidator(m_webservicetype, IWSValidator.TIMING_BEFORE_PARSE, holderPo, fields, trx,
						reqCtx, stdResp, stdRet);
				if (retResp != null){
					throw new IdempiereServiceFault(retResp.getStandardResponse().getError(), new QName("queryData"));
				}
		
				retResp = scanFields(fields, m_webservicetype, holderPo, poinfo, trx, stdResp, stdRet);
				
				if (retResp != null){
					throw new IdempiereServiceFault(retResp.getStandardResponse().getError(), new QName("queryData"));
				}
		
				
				for (DataField field : modelCRUD.getDataRow().getFieldArray()) {
		    		if (m_webservicetype.isInputColumnNameAllowed(field.getColumn())) {
		    			
		    			// Jan Thielemann Solution for query using the sentence like
		    			X_WS_WebServiceFieldInput inputField = m_webservicetype.getFieldInput(field.getColumn());
		    			I_AD_Column col = inputField.getAD_Column();		    			
		    			String sqlType = DisplayType.getSQLDataType(col.getAD_Reference_ID(), col.getColumnName(), col.getFieldLength());		    					
		    			if(sqlType.contains("CHAR"))
		    				sqlBuilder.append(" AND ").append(field.getColumn()).append(" LIKE ?");
		    			else
		    				sqlBuilder.append(" AND ").append(field.getColumn()).append("=?");
		    			
		    			sqlParaList.add(holderPo.get_Value(field.getColumn()));
				    	// End Jan Thielemann Solution for query using the sentence like		    			
		    		}else if(m_webservicetype.getFieldInput(field.getColumn())==null){
		    			//If not even ctx variable column
						throw new IdempiereServiceFault("Web service type "
								+ m_webservicetype.getValue() + ": input column "
								+ field.getColumn() + " not allowed", new QName("queryData"));
		    		}
				}
			}
			
			if (modelCRUD.getFilter() != null && modelCRUD.getFilter().length() > 0){
				String sql = parseSQL(" WHERE " + modelCRUD.getFilter(), sqlParaList, holderPo, poinfo, reqCtx);
				sqlBuilder.append(" AND ").append(sql.substring(6));
			}
			
	    	int cnt = 0;
	    	int rowCnt = 0;
			int offset = modelCRUD.getOffset();
			int limit = modelCRUD.getLimit();
	
	    	PreparedStatement pstmtquery = null;
			ResultSet rsquery = null;
			try
			{
				pstmtquery = DB.prepareStatement (sqlBuilder.toString(), trxName);
				DB.setParameters(pstmtquery, sqlParaList);
				
				rsquery = pstmtquery.executeQuery();
				// Angelo Dabala' (genied) must create just one DataSet, moved outside of the while loop
				DataSet ds = resp.addNewDataSet();
				while (rsquery.next ()) {
					cnt++;
					if ((offset >= cnt) || (limit > 0 && offset+limit < cnt))
						continue;
					rowCnt++;
					DataRow dr = ds.addNewDataRow();
					for (int i = 0; i < poinfo.getColumnCount(); i++) {
			    		String columnName = poinfo.getColumnName(i);
						if (m_webservicetype.isOutputColumnNameAllowed(columnName)) {							
							DataField dfid = dr.addNewField();
							dfid.setColumn(columnName);
							if(rsquery.getObject(columnName) instanceof byte[])
								dfid.setVal(new String(Base64.encodeBase64(rsquery.getBytes(columnName))));						
							else
								dfid.setVal(rsquery.getString(columnName));
						}
			    	}
				}
			}
			catch (Exception e)
			{
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
				throw new IdempiereServiceFault(e);
			}
			finally
			{
				DB.close(rsquery, pstmtquery);
				rsquery = null; pstmtquery = null;
			}
	
			resp.setSuccess(true);			
	    	resp.setRowCount(rowCnt);
	    	resp.setNumRows(rowCnt);
	    	resp.setTotalRows(cnt);
	    	resp.setStartRow(offset);
	
			return ret;
		} finally {
			if (manageTrx && trx != null)
				trx.close();
			
			getCompiereService().disconnect();
		}
	}
}