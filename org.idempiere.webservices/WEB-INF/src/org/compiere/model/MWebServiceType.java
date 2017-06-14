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

package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.compiere.util.CLogger;
import org.compiere.util.DB;

/**
 *	Web Services Type Model
 *	
 *  @author Carlos Ruiz
 *  @author Deepak Pansheriya - Updated to support CreateUpdate service
 */
public class MWebServiceType extends X_WS_WebServiceType
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7216001796414414950L;

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
	private static CLogger	s_log	= CLogger.getCLogger (MWebServiceType.class);
	
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
	
}	//	MWebServiceType
