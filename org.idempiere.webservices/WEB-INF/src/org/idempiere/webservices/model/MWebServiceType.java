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

package org.idempiere.webservices.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Web Services Type Model
 *	
 *  @author Carlos Ruiz
 *  @author Deepak Pansheriya - Updated to support CreateUpdate service
 */
@org.adempiere.base.Model(table = X_WS_WebServiceType.Table_Name)
public class MWebServiceType extends X_WS_WebServiceType implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6105547694847198509L;

	/**	Parameters	*/
	private MWebServicePara[]	m_para = null;
	
	/**	Allowed input columns	*/
	private String[]	m_inputcolumnnames = null;
	/**	Allowed output columns	*/
	private String[]	m_outputcolumnnames = null;
	
	private Map<String, X_WS_WebServiceFieldInput> m_inputFieldMap = null;
	
	private ArrayList<String> m_keyColumns = null;	
	
	public ArrayList<String> getKeyColumns() {
		getInputFieldMap(false);
		return m_keyColumns;
	}

	/**
	 * 	Get Parameters
	 *	@param requery requery
	 *	@return array of methods
	 */
	public MWebServicePara[] getParameters (boolean requery)
	{
		if (m_para != null && !requery)
			return m_para;
		List<MWebServicePara> list = new Query(getCtx(), MWebServicePara.Table_Name,
				"WS_WebService_Para.WS_WebServiceType_ID=? AND WS_WebService_Para.AD_Client_ID=WS_WebServiceType.AD_Client_ID", get_TrxName())
				.addJoinClause("JOIN WS_WebServiceType ON (WS_WebServiceType.WS_WebServiceType_ID=WS_WebService_Para.WS_WebServiceType_ID)")
				.setOnlyActiveRecords(true)
				.setParameters(getWS_WebServiceType_ID())
				.list();
		m_para = new MWebServicePara[list.size ()];
		list.toArray (m_para);
		return m_para;
	}	//	getParameters

	/**
	 * 	Get Parameter
	 *	@param parameterName
	 *	@return parameter if found
	 */
	public X_WS_WebService_Para getParameter (String parameterName)
	{
		if (parameterName == null || parameterName.length() == 0)
			return null;
		getParameters(false);
		//
		for (int i = 0; i < m_para.length; i++)
		{
			if (parameterName.equals(m_para[i].getParameterName()))
				return m_para[i];
		}
		return null;
	}	//	getParameter
	
	/**
	 * 	Get Input Columnnames
	 *	@param requery requery
	 *	@return array of methods
	 */
	public String[] getInputColumnNames (boolean requery)
	{
		if (m_inputcolumnnames != null && !requery)
			return m_inputcolumnnames;
		final String sql = ""
				+ "SELECT c.ColumnName FROM WS_WebServiceFieldInput f "
				+ "  JOIN AD_Column c ON (c.AD_Column_ID=f.AD_Column_ID) "
				+ "  JOIN WS_WebServiceType t ON t.WS_WebServiceType_ID=f.WS_WebServiceType_ID "
				+ "WHERE f.WS_WebServiceType_ID=? "
				+ "  AND f.AD_Client_ID=t.AD_Client_ID "
				+ "  AND c.IsActive='Y' "
				+ "  AND f.IsActive='Y' "
				+ "ORDER BY c.ColumnName";
		List<List<Object>> list = DB.getSQLArrayObjectsEx(get_TrxName(), sql, getWS_WebServiceType_ID());
		if (list == null) {
			m_inputcolumnnames = new String[0];
		} else {
			m_inputcolumnnames = new String[list.size()];
			for (int idx = 0; idx < list.size(); idx++) {
				m_inputcolumnnames[idx] = (String) list.get(idx).get(0);
			}
		}
		return m_inputcolumnnames;
	}	//	getInputColumnNames

	/**
	 * 	Is Input Column Name Allowed
	 *	@param columnName
	 *	@return true if allowed
	 */
	public boolean isInputColumnNameAllowed (String columnName)
	{
		if (columnName == null || columnName.length() == 0)
			return false;
		getInputColumnNames(false);
		//
		for (int i = 0; i < m_inputcolumnnames.length; i++)
		{
			if (columnName.equals(m_inputcolumnnames[i]))
				return true;
		}
		return false;
	}	//	isInputColumnNameAllowed
	
	/**
	 * 	Get Output Columnnames
	 *	@param requery requery
	 *	@return array of methods
	 */
	public String[] getOutputColumnNames (boolean requery)
	{
		if (m_outputcolumnnames != null && !requery)
			return m_outputcolumnnames;
		final String sql = ""
				+ "SELECT c.ColumnName FROM WS_WebServiceFieldOutput f "
				+ "  JOIN AD_Column c ON (c.AD_Column_ID=f.AD_Column_ID) "
				+ "  JOIN WS_WebServiceType t ON t.WS_WebServiceType_ID=f.WS_WebServiceType_ID "
				+ "WHERE f.WS_WebServiceType_ID=? "
				+ "  AND f.AD_Client_ID=t.AD_Client_ID "
				+ "  AND c.IsActive='Y' "
				+ "  AND f.IsActive='Y' "
				+ "ORDER BY c.ColumnName";
		List<List<Object>> list = DB.getSQLArrayObjectsEx(get_TrxName(), sql, getWS_WebServiceType_ID());
		if (list == null) {
			m_outputcolumnnames = new String[0];
		} else {
			m_outputcolumnnames = new String[list.size()];
			for (int idx = 0; idx < list.size(); idx++) {
				m_outputcolumnnames[idx] = (String) list.get(idx).get(0);
			}
		}
		return m_outputcolumnnames;
	}	//	getOutputColumnNames

	/**
	 * 	Is Output Column Name Allowed
	 *	@param columnName
	 *	@return true if allowed
	 */
	public boolean isOutputColumnNameAllowed (String columnName)
	{
		if (columnName == null || columnName.length() == 0)
			return false;
		getOutputColumnNames(false);
		//
		for (int i = 0; i < m_outputcolumnnames.length; i++)
		{
			if (columnName.equals(m_outputcolumnnames[i]))
				return true;
		}
		return false;
	}	//	isOutputColumnNameAllowed
	
	/**	Static Logger	*/
	@SuppressWarnings("unused")
	private static final CLogger	s_log	= CLogger.getCLogger (MWebServiceType.class);
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param WS_WebServiceType_ID
	 *	@param trxName transaction
	 */
	public MWebServiceType (Properties ctx, int WS_WebServiceType_ID, String trxName)
	{
		super (ctx, WS_WebServiceType_ID, trxName);
        /** if (WS_WebServiceType_ID == 0)
        {
			setName (null);
			setValue (null);
			setWS_WebService_ID (0);
			setWS_WebServiceMethod_ID (0);
			setWS_WebServiceType_ID (0);
        } */
	}	//	MWebServiceType

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MWebServiceType (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MWebServiceType
	
	/**
	 * 
	 * @param copy
	 */
	public MWebServiceType(MWebServiceType copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MWebServiceType(Properties ctx, MWebServiceType copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MWebServiceType(Properties ctx, MWebServiceType copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_para = copy.m_para != null ? Arrays.stream(copy.m_para).map(e -> {return new MWebServicePara(ctx, e, trxName);}).toArray(MWebServicePara[]::new) : null;
		this.m_inputcolumnnames = copy.m_inputcolumnnames != null ? Arrays.copyOf(copy.m_inputcolumnnames, copy.m_inputcolumnnames.length) : null;
		this.m_outputcolumnnames = copy.m_outputcolumnnames != null ? Arrays.copyOf(copy.m_outputcolumnnames, copy.m_outputcolumnnames.length) : null;
		this.m_inputFieldMap = copy.m_inputFieldMap != null ? new HashMap<String, X_WS_WebServiceFieldInput>(copy.m_inputFieldMap) : null;
		this.m_keyColumns = copy.m_keyColumns != null ? new ArrayList<String>(copy.m_keyColumns) : null;
	}

	/**
	 * 
	 * @param requery
	 */
	public void getInputFieldMap(boolean requery){
		if(!requery && m_inputFieldMap!=null)
			return;
		
		if(m_inputFieldMap!=null)
			m_inputFieldMap.clear();
		else
			m_inputFieldMap = new HashMap<String, X_WS_WebServiceFieldInput>();
			
		if(m_keyColumns==null)
			m_keyColumns = new ArrayList<String>();
		else
			m_keyColumns.clear();
		List<X_WS_WebServiceFieldInput> list = new Query(getCtx(), X_WS_WebServiceFieldInput.Table_Name,
				"WS_WebServiceFieldInput.WS_WebServiceType_ID=? AND WS_WebServiceFieldInput.AD_Client_ID=WS_WebServiceFieldInput.AD_Client_ID",
				get_TrxName())
				.addJoinClause("JOIN WS_WebServiceType ON (WS_WebServiceType.WS_WebServiceType_ID=WS_WebServiceFieldInput.WS_WebServiceType_ID)")
				.addJoinClause("LEFT JOIN AD_Column ON (AD_Column.AD_Column_ID=WS_WebServiceFieldInput.AD_Column_ID)")
				.setOnlyActiveRecords(true)
				.setOrderBy("AD_Column.ColumnName")
				.setParameters(getWS_WebServiceType_ID())
				.list();
		for (X_WS_WebServiceFieldInput inputField : list) {
			String colName = inputField.getColumnName();
			if (inputField.getAD_Column_ID() > 0) {
				MColumn col = MColumn.get(getCtx(), inputField.getAD_Column_ID());
				if (! col.isActive()) {
					continue;
				}
				colName = col.getColumnName();
			}
			if(inputField.isIdentifier())
				m_keyColumns.add(colName);
			m_inputFieldMap.put(colName,inputField );
		}
	}
	
	public X_WS_WebServiceFieldInput getFieldInput(String colName){
		getInputFieldMap(false);
		
		return m_inputFieldMap.get(colName);
	}

	public void insertParameters() {

		MWebService ws = MWebService.get(getCtx(), getWS_WebService_ID());
		if (ws != null && "ModelADService".equals(ws.getValue())) {
			X_WS_WebServiceMethod wsm = new X_WS_WebServiceMethod(getCtx(), getWS_WebServiceMethod_ID(), get_TrxName());
			String method = wsm.getValue();

			if ("getList".equals(method)) {
				addWsParameter("AD_Reference_ID", X_WS_WebService_Para.PARAMETERTYPE_Free, "");
			} else if ("runProcess".equals(method)) {
				addWsParameter("AD_Process_ID", X_WS_WebService_Para.PARAMETERTYPE_Constant, ""); // can't fill it as the process is unknown
				addWsParameter("AD_Menu_ID", X_WS_WebService_Para.PARAMETERTYPE_Constant, "0");
				addWsParameter("AD_Record_ID", X_WS_WebService_Para.PARAMETERTYPE_Free, "");
			} else {
				String value = "";
				if ("createData".equals(method))
					value = "Create";
				else if ("deleteData".equals(method))
					value = "Delete";
				else if ("queryData".equals(method))
					value = "Read";
				else if ("readData".equals(method))
					value = "Read";
				else if ("updateData".equals(method))
					value = "Update";

				addWsParameter("TableName", X_WS_WebService_Para.PARAMETERTYPE_Constant, MTable.get(getCtx(), getAD_Table_ID()).getTableName());
				addWsParameter("Action", X_WS_WebService_Para.PARAMETERTYPE_Constant, value);
				addWsParameter("RecordID", X_WS_WebService_Para.PARAMETERTYPE_Free, "");
			}
		}
	}

	private void addWsParameter(String name, String type, String value) {
		
		if (DB.getSQLValueEx(get_TrxName(), "SELECT 1 FROM WS_WebService_Para WHERE WS_WebServiceType_ID = ? AND ParameterName = ?", getWS_WebServiceType_ID(), name) != 1) {
			MWebServicePara wsp = new MWebServicePara(getCtx(), 0, get_TrxName());
			wsp.setAD_Org_ID(getAD_Org_ID());
			wsp.setWS_WebServiceType_ID(getWS_WebServiceType_ID());
			wsp.setParameterName(name);
			wsp.setParameterType(type);
			wsp.setConstantValue(value);
			wsp.saveEx();	
		}
	}
	
	@Override
	public MWebServiceType markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	MWebServiceType
