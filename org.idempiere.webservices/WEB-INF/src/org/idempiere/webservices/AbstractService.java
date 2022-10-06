/******************************************************************************
 * Copyright (C) 2012 Trek Global                                             *
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.idempiere.webservices;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;
import javax.xml.namespace.QName;
import javax.xml.ws.WebServiceContext;
import javax.xml.ws.handler.MessageContext;

import org.adempiere.base.ServiceQuery;
import org.adempiere.base.equinox.EquinoxExtensionLocator;
import org.adempiere.exceptions.AdempiereException;
import org.apache.commons.codec.binary.Base64;
import org.compiere.model.Lookup;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.Query;
import org.idempiere.webservices.model.X_WS_WebServiceMethod;
import org.idempiere.webservices.model.X_WS_WebServiceTypeAccess;
import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Login;
import org.compiere.util.NamePair;
import org.compiere.util.Trx;
import org.idempiere.adInterface.x10.ADLoginRequest;
import org.idempiere.adInterface.x10.DataField;
import org.idempiere.adInterface.x10.OutputField;
import org.idempiere.adInterface.x10.OutputFields;
import org.idempiere.adInterface.x10.StandardResponse;
import org.idempiere.adInterface.x10.StandardResponseDocument;
import org.idempiere.adinterface.CompiereService;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.webservices.fault.IdempiereServiceFault;
import org.idempiere.webservices.model.MWebService;
import org.idempiere.webservices.model.MWebServiceType;



/**
 * 
 * @author Deepak Pansheriya
 *
 */
public class AbstractService {

	public static final String ROLE_TYPES_WEBSERVICE = "NULL,WS";  //webservice+null
	private static final String ROLE_ACCESS_SQL = "SELECT IsActive FROM WS_WebServiceTypeAccess WHERE AD_Role_ID IN ("
			+ "SELECT AD_Role_ID FROM AD_Role WHERE AD_Role_ID=? UNION "
			+ "SELECT Included_Role_ID as AD_Role_ID FROM AD_Role_Included WHERE AD_Role_ID=?) "
	        + "AND WS_WebServiceType_ID=?";
	private static final String COMPIERE_SERVICE = "CompiereService";
	@Resource
	protected WebServiceContext jaxwsContext; //soap context
	
	@Context
	protected org.apache.cxf.jaxrs.ext.MessageContext jaxrsContext ; //rest context

	/**
	 * Login to web Services
	 * @param loginRequest
	 * @param webService
	 * @param method
	 * @param serviceType
	 * @return
	 */
	protected String login(ADLoginRequest loginRequest, String webService, String method, String serviceType) {

		CompiereService m_cs = getCompiereService();
		if (m_cs.getUserName() == null) {
			HttpServletRequest req = getHttpServletRequest();
			// search for a non-expired CompiereService with same login data
			CompiereService cachedCs = CompiereService.get(req, loginRequest);
			if (cachedCs != null) {
				m_cs = cachedCs;
				req.setAttribute(COMPIERE_SERVICE, cachedCs);
				m_cs.connectCacheInstance();
				return authenticate(webService, method, serviceType, cachedCs); // already logged with same data
			}
		}

		if (m_cs.isLoggedIn() && m_cs.getAD_Client_ID() == loginRequest.getClientID() && loginRequest.getClientID() == Env.getAD_Client_ID(Env.getCtx())
				&& m_cs.getAD_Org_ID() == loginRequest.getOrgID() && m_cs.getAD_Role_ID() == loginRequest.getRoleID()
				&& m_cs.getM_Warehouse_ID() == loginRequest.getWarehouseID() && loginRequest.getUser().equals(m_cs.getUserName()))
			return authenticate(webService, method, serviceType, m_cs); // already logged with same data

		String ret =invokeLoginValidator(loginRequest, m_cs.getCtx(), null, IWSValidator.TIMING_BEFORE_LOGIN);
		if(ret!=null && ret.length()>0)
			return ret;
		
		Login login = new Login(m_cs.getCtx());
		KeyNamePair[] clients = login.getClients(loginRequest.getUser(), loginRequest.getPass(), ROLE_TYPES_WEBSERVICE);
		if (clients == null)
			return "Error login - User invalid";
		m_cs.setPassword(loginRequest.getPass());
		m_cs.setExpiryMinutes(loginRequest.getStage());
		m_cs.setIPAddress(getHttpServletRequest().getRemoteAddr());

		boolean okclient = false;
		KeyNamePair selectedClient = null;
		for (KeyNamePair client : clients) {
			if (client.getKey() == loginRequest.getClientID()) {
				okclient = true;
				selectedClient = client;
				break;
			}
		}
		if (!okclient)
			return "Error logging in - tenant not allowed for this user";

		m_cs.getCtx().setProperty(Env.AD_CLIENT_ID, "" + loginRequest.getClientID());
       	Env.setContext(m_cs.getCtx(), Env.AD_CLIENT_ID, (String) selectedClient.getID());
    	MUser user = MUser.get (m_cs.getCtx(), loginRequest.getUser());
    	if (user != null) {
    		Env.setContext(m_cs.getCtx(), Env.AD_USER_ID, user.getAD_User_ID() );
    		Env.setContext(m_cs.getCtx(), Env.AD_USER_NAME, user.getName() );
    		Env.setContext(m_cs.getCtx(), Env.SALESREP_ID, user.getAD_User_ID() );
    		String userAgent = getHttpServletRequest().getHeader("User-Agent");
    		Env.setContext(m_cs.getCtx(), "#UserAgent",   userAgent == null ? "Unknown" : userAgent);
    	}

		KeyNamePair[] roles = login.getRoles(loginRequest.getUser(), selectedClient, ROLE_TYPES_WEBSERVICE);
		if (roles != null) {
			boolean okrole = false;
			for (KeyNamePair role : roles) {
				if (role.getKey() == loginRequest.getRoleID()) {
					okrole = true;
					break;
				}
			}
			if (!okrole)
				return "Error logging in - role not allowed for this user";

			KeyNamePair[] orgs = login.getOrgs(new KeyNamePair(loginRequest.getRoleID(), ""));

			if (orgs == null)
				return "Error logging in - no organizations for this role";

			KeyNamePair orglogin = null;
			boolean okorg = false;
			for (KeyNamePair org : orgs) {
				if (org.getKey() == loginRequest.getOrgID()) {
					okorg = true;
					orglogin = org;
					break;
				}
			}
			if (!okorg)
				return "Error logging in - org not allowed for this role";

			KeyNamePair[] warehouses = login.getWarehouses(new KeyNamePair(loginRequest.getOrgID(), ""));
			if (warehouses != null)
			{
				boolean okwh = false;
				for (KeyNamePair warehouse : warehouses) {
					if (warehouse.getKey() == loginRequest.getWarehouseID()) {
						okwh = true;
						break;
					}
				}
				if (!okwh)
					return "Error logging in - warehouse not allowed for this org";
			}
			else if (warehouses == null && loginRequest.getWarehouseID() > 0)
				return "Error logging in - warehouse not allowed for this org";

			String error = login.validateLogin(orglogin);
			if (error != null && error.length() > 0)
				return error;

			int AD_User_ID = Env.getAD_User_ID(m_cs.getCtx());

			
			if (!m_cs.login(AD_User_ID, loginRequest.getRoleID(), loginRequest.getClientID(), loginRequest.getOrgID(), loginRequest.getWarehouseID(), loginRequest.getLang()))
				return "Error logging in";
			
		} else {
			return "Error logging in - no roles or user/pwd invalid for user " + loginRequest.getUser();
		}

		ret =invokeLoginValidator(loginRequest, m_cs.getCtx(), null, IWSValidator.TIMING_AFTER_LOGIN);
		if(ret!=null && ret.length()>0)
			return ret;
		
		return authenticate(webService, method, serviceType, m_cs);
	}

	private static ImmutablePOCache<String,MWebServiceType> s_WebServiceTypeCache	= new ImmutablePOCache<String,MWebServiceType>(MWebServiceType.Table_Name, 10, 60);	//60 minutes
	private static CCache<String,Boolean> s_RoleAccessCache = new CCache<>(X_WS_WebServiceTypeAccess.Table_Name, 60, CCache.DEFAULT_EXPIRE_MINUTE);

	/**
	 * Authenticate user for requested service type
	 * @param webServiceValue
	 * @param methodValue
	 * @param serviceTypeValue
	 * @param m_cs
	 * @return
	 */
	protected String authenticate(String webServiceValue, String methodValue, String serviceTypeValue, CompiereService m_cs) {

		MWebService m_webservice = MWebService.get(m_cs.getCtx(), webServiceValue);
		if (m_webservice == null || !m_webservice.isActive())
			return "Web Service " + webServiceValue + " not registered";

		X_WS_WebServiceMethod m_webservicemethod = m_webservice.getMethod(methodValue);
		if (m_webservicemethod == null || !m_webservicemethod.isActive())
			return "Method " + methodValue + " not registered";

		MWebServiceType m_webservicetype = null;
		String key = m_cs.getAD_Client_ID() + "|" + m_webservice.getWS_WebService_ID() + "|" 
				+ m_webservicemethod.getWS_WebServiceMethod_ID() + "|" + serviceTypeValue;
		synchronized (s_WebServiceTypeCache) {
			m_webservicetype = s_WebServiceTypeCache.get(m_cs.getCtx(), key, e -> new MWebServiceType(m_cs.getCtx(), e));
			if (m_webservicetype == null) {
				m_webservicetype = new Query(m_cs.getCtx(), MWebServiceType.Table_Name,
						"AD_Client_ID IN (0,?) AND WS_WebService_ID=? AND WS_WebServiceMethod_ID=? AND Value=?",
						null)
						.setOnlyActiveRecords(true)
						.setParameters(m_cs.getAD_Client_ID(), m_webservice.getWS_WebService_ID(), m_webservicemethod.getWS_WebServiceMethod_ID(), serviceTypeValue)
						.setOrderBy("AD_Client_ID DESC") // IDEMPIERE-3394 give precedence to tenant defined if there are system+tenant
						.first();
				if (m_webservicetype != null) {
					s_WebServiceTypeCache.put(key, m_webservicetype, e -> new MWebServiceType(Env.getCtx(), e));
				}
			}
		}

		if (m_webservicetype == null)
			return "Service type " + serviceTypeValue + " not configured";

		getHttpServletRequest().setAttribute("MWebServiceType", m_webservicetype);
		
		int AD_Role_ID = Env.getAD_Role_ID( m_cs.getCtx());
		key = AD_Role_ID + "|" + m_webservicetype.get_ID();
		synchronized (s_RoleAccessCache) {
			Boolean bAccess = s_RoleAccessCache.get(key);
			if (bAccess == null) {
				// Check if role has access on web-service
		        String hasAccess = DB.getSQLValueStringEx(null, ROLE_ACCESS_SQL,
		                AD_Role_ID, AD_Role_ID, m_webservicetype.get_ID());
		        bAccess = "Y".equals(hasAccess);
		        s_RoleAccessCache.put(key, bAccess);
			}
	        if (!bAccess.booleanValue())
	        {
	            return "Web Service Error: Login role does not have access to the service type";
	        }			
		}
        
		String ret=invokeLoginValidator(null, m_cs.getCtx(), m_webservicetype, IWSValidator.TIMING_ON_AUTHORIZATION);
		if(ret!=null && ret.length()>0)
			return ret;

		m_cs.refreshLastAuthorizationTime();

		return null;
	}

	/**
	 * Rollback and set error on standard response
	 * @param trx
	 * @param resp
	 * @param ret
	 * @param isError
	 * @param string
	 * @return
	 */
	protected static StandardResponseDocument rollbackAndSetError(Trx trx, StandardResponse resp, StandardResponseDocument ret, boolean isError,
			String string) {
		resp.setError(string);
		resp.setIsError(isError);
		trx.rollback();
		trx.close();
		return ret;
	}

	/**
	 * 
	 * @return Compiere Service object for current request
	 */
	protected CompiereService getCompiereService() {
		
		HttpServletRequest req = getHttpServletRequest();
		
		CompiereService m_cs = (CompiereService) req.getAttribute(COMPIERE_SERVICE);
		if (m_cs == null) {
			m_cs = new CompiereService();
			req.setAttribute(COMPIERE_SERVICE, m_cs);
		}
		return m_cs;
	}

	/**
	 * 
	 * @return
	 */
	protected MWebServiceType getWebServiceType() {

		return (MWebServiceType) getHttpServletRequest().getAttribute("MWebServiceType");

	}
	
	/**
	 * Get request Ctx
	 * @return
	 */
	protected Map<String, Object> getRequestCtx() {
		HttpServletRequest req = getHttpServletRequest();

		@SuppressWarnings("unchecked")
		Map<String,Object> reqCtx= (Map<String,Object>)req.getAttribute("RequestCtx");
		if(reqCtx==null){
			reqCtx = new HashMap<String, Object>();
			req.setAttribute("RequestCtx", reqCtx);
		}
		
		return reqCtx;
	}

	/**
	 * 
	 * @param resp
	 * @param m_webservicetype
	 */
	protected void setOuputFields(StandardResponse resp,MWebServiceType m_webservicetype,PO po,POInfo poInfo){
		String[] outCols = m_webservicetype.getOutputColumnNames(false);
		if(outCols.length>0){
			 OutputFields outputFields = resp.addNewOutputFields();
			 if(outputFields==null)
				 outputFields=resp.addNewOutputFields();
			 
			 for(String colName:outCols){
				 int indCol = poInfo.getColumnIndex(colName);
				 if(indCol<0)
					 continue;
				 
				 OutputField outField= outputFields.addNewOutputField();
				 outField.setColumn(colName);
				 if(po.get_Value(indCol)!=null){
					 if(po.get_Value(indCol) instanceof byte[])
						 outField.setValue(new String(Base64.encodeBase64((byte[]) po.get_Value(indCol))));
					 else
						 outField.setValue(po.get_Value(indCol).toString());
					 
					 Lookup lookup = poInfo.getColumnLookup(indCol);
					 if(lookup != null){
						 //Setting text
						 if(lookup.getSize()==0)
							 lookup.refresh();
						 
						 NamePair pair = lookup.getDirect(po.get_Value(indCol), false, false);
						 if (pair != null)
							 outField.setText(pair.getName());
					 }
				 }
			 }
		}
	}
	
	/**
	 * Parse variables inside SQL
	 * @param sql
	 * @param sqlParas
	 * @param po
	 * @param requestCtx
	 * @return
	 * @throws AdempiereException
	 */
	protected String parseSQL(String sql, ArrayList<Object> sqlParas, PO po,POInfo poInfo, Map<String, Object> requestCtx) throws AdempiereException {
		if (sql.startsWith("@SQL="))
			sql = sql.substring(5);

		if (sql.toLowerCase().indexOf(" where ") == -1)
			throw new AdempiereException("Invalid SQL: Query do not have any filetering criteria");

		StringBuilder sqlBuilder = new StringBuilder();

		if (sql.indexOf('@') == -1) {
			sqlBuilder.append(sql);
		} else {
			int firstInd = sql.indexOf('@');
			while (firstInd >= 0) {

				sqlBuilder.append(sql.substring(0, firstInd));

				sql = sql.substring(firstInd + 1);

				firstInd = sql.indexOf('@');
				if (firstInd == -1) {
					throw new AdempiereException("Missing closing '@' in SQL");
				}

				String token = sql.substring(0, firstInd);
				boolean isNullable = false;
				if(token.charAt(0)=='!'){
					isNullable = true;
					token = token.substring(1);
				}
				
				sql = sql.substring(firstInd + 1);

				Object val = parseVariable(token, po,poInfo, requestCtx);
				if(val == null && isNullable){
					int ind = sqlBuilder.lastIndexOf("=");
					sqlBuilder.replace(ind, sqlBuilder.length(), " Is Null ");
				}else if (val == null)
					throw new AdempiereException("Can not resolve variable '" + token + "' in sql");
				else{
					sqlBuilder.append(" ? ");
					sqlParas.add(val);
				}
				
				firstInd = sql.indexOf('@');
			}
			sqlBuilder.append(sql);
		}


		return sqlBuilder.toString();
	}

	/**
	 * Resolving context variable into object
	 * @param varName
	 * @param po
	 * @param requestCtx
	 * @return
	 */
	protected Object parseVariable(String varName, PO po,POInfo poInfo, Map<String, Object> requestCtx) {
		Object val = null;
		if (varName.charAt(0) == '@')
			varName = varName.substring(1);
		
		int indDot = varName.indexOf(".");
		if (indDot == -1) {
			if (varName.charAt(0) == '#') {
				val = getCompiereService().getCtx().getProperty(varName);
				if (varName.endsWith("_ID") && val != null) {
					Integer intVal = Integer.parseInt((String) val);
					val = intVal;
				}
			} else {
				// If there is no table name, then it should be
				// primitive data type
				if (po != null && poInfo.getColumnIndex(varName)!=-1)
					val = po.get_Value(varName);

				if (val == null)
					val = requestCtx.get(varName);
			}
		} else {
			
				
			String tblName = varName.substring(0, indDot);
			String colName = varName.substring(indDot + 1);
			if (colName.indexOf(".") >= 0) {
				throw new IdempiereServiceFault(" can not resolve " + varName + ". contains un supported multi level object resolution",
						new QName("resolveCtxVariable"));
			}

			Object obj = requestCtx.get(tblName);
			if (obj == null || !(obj instanceof PO)) {
				throw new IdempiereServiceFault(" can not found object of " + tblName + ". Request variable " + varName
						+ " can not resolved", new QName("resolveCtxVariable"));
			}

			PO refPO = (PO) obj;
			val = refPO.get_Value(colName);

		}

		return val;
	}
	
	/**
	 * @param strValue
	 * @param columnClass
	 * @param colName
	 * @return
	 */
	protected Object convertToObj(String strValue,Class<?> columnClass,String colName){
		
		Object value = null;

		if (columnClass == Boolean.class) {
			if ("Y".equalsIgnoreCase(strValue)
					|| "true".equalsIgnoreCase(strValue))
				value = Boolean.TRUE;
			else if ("N".equalsIgnoreCase(strValue)
					|| "false".equalsIgnoreCase(strValue))
				value = Boolean.FALSE;
			else
				throw new IdempiereServiceFault(" input column " + colName
						+ " wrong value " + strValue, new QName(
						"setValueAccordingToClass"));
		} else if (columnClass == Integer.class) {
			try {
				value = Integer.parseInt(strValue);
			} catch (NumberFormatException e) {
				throw new IdempiereServiceFault(e.getClass().toString()
						+ " " + e.getMessage() + " for "
						+ colName , e.getCause(), new QName(
						"setValueAccordingToClass"));
			}
		} else if (columnClass == BigDecimal.class) {
			try {
				value = new BigDecimal(strValue);
			} catch (Exception e) {
				throw new IdempiereServiceFault(e.getClass().toString()
						+ " " + e.getMessage() + " for "
						+ colName, e.getCause(), new QName(
						"setValueAccordingToClass"));
			}
		} else if (columnClass == Timestamp.class) {
			try {
				value = Timestamp.valueOf(strValue);
			} catch (Exception e) {
				throw new IdempiereServiceFault(e.getClass().toString()
						+ " " + e.getMessage() + " for "
						+ colName, e.getCause(), new QName(
						"setValueAccordingToClass"));
			}
		} else if (columnClass == byte[].class) {
			try {
				value = Base64.decodeBase64(strValue.getBytes());
			} catch (Exception e) {
				throw new IdempiereServiceFault(e.getClass().toString()
						+ " " + e.getMessage() + " for "
						+ colName, e.getCause(), new QName(
						"setValueAccordingToClass"));
			}
		} else {
			value = strValue;
		}
	
		return value;
	}
	
	/**
	 * Retrieve variable data type
	 * @param columnName
	 * @param displayType
	 * @return
	 */
	protected Class<?> getVariableType(String columnName,int displayType){
		Class<?> ColumnClass= null;
		if (columnName.equals("AD_Language") || columnName.equals("EntityType"))
		{
			ColumnClass = String.class;
		}
		else if (columnName.equals("Posted") 
			|| columnName.equals("Processed")
			|| columnName.equals("Processing"))
		{
			ColumnClass = Boolean.class;
		}
		else if (columnName.equals("Record_ID"))
		{
			ColumnClass = Integer.class;
		}
		else
			ColumnClass = org.compiere.util.DisplayType.getClass(displayType, true);
		
		return ColumnClass;
	}
	
	/**
	 * retrieve web service Validators
	 * @param serviceType
	 * @return
	 */
	public static List<IWSValidator> getValidators(String serviceType){
		ServiceQuery query = new ServiceQuery();
		query.put("WSType",serviceType);
		
		return EquinoxExtensionLocator.instance().list(IWSValidator.class, query).getExtensions();
	}
	
	/**
	 * Invoke webservice Validator
	 * @param m_WebServiceType
	 * @param time
	 * @param po
	 * @param fields
	 * @param trx
	 * @param requestCtx
	 * @param resp
	 * @param ret
	 * @return
	 */
	public static StandardResponseDocument invokeWSValidator(MWebServiceType m_WebServiceType, int time,PO po, DataField fields[], Trx trx,Map<String, Object> requestCtx,StandardResponse resp,StandardResponseDocument ret){
		
		List<IWSValidator> validators = getValidators(m_WebServiceType.getValue());
		List<IWSValidator> globalValidators = getValidators("GLOBAL");
		//Call global validator
		for(IWSValidator validator:globalValidators){
			try{
				validator.validate(po, m_WebServiceType, fields, time,trx.getTrxName(),requestCtx);
			}catch (IdempiereServiceFault e) {
				return rollbackAndSetError(trx, resp, ret, true, e.getMessage());
			}
		}
		
		for(IWSValidator validator:validators){
				try{
					validator.validate(po, m_WebServiceType, fields, time,trx.getTrxName(),requestCtx);
				}catch (IdempiereServiceFault e) {
					return rollbackAndSetError(trx, resp, ret, true, e.getMessage());
				}
		}
		return null;
	}

	/**
	 * Invoke web Service Login Validator
	 * @param loginRequest
	 * @param ctx
	 * @param m_webserviceType
	 * @param time
	 * @return
	 */
	public static String invokeLoginValidator(ADLoginRequest loginRequest, Properties ctx, MWebServiceType m_webserviceType, int time) {

		List<IWSValidator> validators = null;
		if (m_webserviceType != null) {
			validators = getValidators(m_webserviceType.getValue());
		}
		List<IWSValidator> globalValidators = getValidators("GLOBAL");
		// Call global validator
		for (IWSValidator validator : globalValidators) {
			try {
				validator.login(loginRequest, ctx, m_webserviceType, time);
			} catch (IdempiereServiceFault e) {
				return e.getMessage();
			}
		}

		if (validators != null) {
			for (IWSValidator validator : validators) {
				try {
					validator.login(loginRequest, ctx, m_webserviceType, time);
				} catch (IdempiereServiceFault e) {
					return e.getMessage();
				}
			}
		}
		return null;
	}

	/**
	 * Get HttpServletRequest object
	 * @return HttpServletRequest
	 */
	private HttpServletRequest getHttpServletRequest() {
		HttpServletRequest req;
		if (jaxrsContext != null) {
			req = (HttpServletRequest) jaxrsContext.getHttpServletRequest();
		} else
			req = (HttpServletRequest) jaxwsContext.getMessageContext().get(
					MessageContext.SERVLET_REQUEST);
		return req;
	}
	
}
