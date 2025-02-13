/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
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
 **********************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * @author teo_sarca
 *
 */
public class MDashboardContent extends X_PA_DashboardContent
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1360395253302002667L;

	/**
	 * @param isShowInDashboard true for main dashboard, false for side panel
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @return number of columns
	 */
	public static int getForSessionColumnCount(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
        int noOfCols = getForSessionQuery(isShowInDashboard, AD_User_ID, AD_Role_ID).aggregate("DISTINCT "+COLUMNNAME_ColumnNo, Query.AGGREGATE_COUNT, Integer.class);
        return noOfCols;
	}
	
	/**
	 * @param isShowInDashboard true for main dashboard, false for side panel
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @return array of MDashboardContent
	 */
	public static MDashboardContent[] getForSession(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
		List<MDashboardContent> list = getForSessionQuery(isShowInDashboard, AD_User_ID, AD_Role_ID).list();
		return list.toArray(new MDashboardContent[list.size()]);
	}
	
	/**
	 * @param isShowInDashboard
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @return Query
	 */
	public static Query getForSessionQuery(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
		Properties ctx = Env.getCtx();
		
		StringBuilder whereClause = new StringBuilder(COLUMNNAME_IsShowInDashboard).append("=?");
		
		if (AD_Role_ID == 0)
			whereClause.append(" AND (").append(COLUMNNAME_AD_Role_ID).append(" IS NULL OR ").append(COLUMNNAME_AD_Role_ID).append("=?)");
		else
			whereClause.append(" AND ").append(COLUMNNAME_AD_Role_ID).append("=?");

		if (AD_User_ID == 0)
			whereClause.append(" AND (").append(COLUMNNAME_AD_User_ID).append(" IS NULL OR ").append(COLUMNNAME_AD_User_ID).append("=?)");
		else
			whereClause.append(" AND ").append(COLUMNNAME_AD_User_ID).append("=?");
		
		List<Object> parameters = new ArrayList<Object>();
		parameters.add(isShowInDashboard);
		parameters.add(AD_Role_ID);
		parameters.add(AD_User_ID);
		
		return new Query(ctx, Table_Name, whereClause.toString(), null)
		.setParameters(parameters)
		.setOnlyActiveRecords(true)
		.setApplyAccessFilter(true, false)
		.setOrderBy(COLUMNNAME_ColumnNo+","+COLUMNNAME_AD_Client_ID+","+COLUMNNAME_Line);
	}
	
	/**
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @return array of MDashboardContent
	 */
	public static MDashboardContent[] getForUserList( int AD_User_ID, int AD_Role_ID)
	{
		List<MDashboardContent> list = getForUser( AD_User_ID, AD_Role_ID).list();
		return list.toArray(new MDashboardContent[list.size()]);
	}
	
	/**
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @return Query
	 */
	public static Query getForUser( int AD_User_ID, int AD_Role_ID)
	{
       Properties ctx = Env.getCtx();
      
       int AD_Client_ID = Env.getAD_Client_ID(ctx);
       List<Object> parameters = new ArrayList<Object>();
		
       StringBuilder whereClause = new StringBuilder();
		
		if (AD_Role_ID >= 0){			
			whereClause.append(COLUMNNAME_AD_Role_ID).append("= ?");
			whereClause.append(" OR ").append( COLUMNNAME_AD_Role_ID).append(" IS  NULL ");
			parameters.add(AD_Role_ID);
		}
		
		if(AD_User_ID >= 0){			
			whereClause.append(" AND ").append(COLUMNNAME_AD_User_ID).append("= ?");
			whereClause.append(" OR ").append( COLUMNNAME_AD_User_ID).append(" IS  NULL ");
			parameters.add(AD_User_ID);
		}
		
		if(AD_Client_ID >= 0){
			whereClause.append(" AND ").append( COLUMNNAME_AD_Client_ID).append(" IN ( 0 ,?)");
			parameters.add(AD_Client_ID);
		}
		
		whereClause.append(" AND IsShowInLogin='Y'");
		
		Query query= new Query(ctx, Table_Name, whereClause.toString(), null);
		if(parameters.size() > 0){
		   query.setParameters(parameters);
		}
		query.setOnlyActiveRecords(true);
		query.setApplyAccessFilter(true, false);
		query.setOrderBy(COLUMNNAME_ColumnNo+","+COLUMNNAME_AD_Client_ID+","+COLUMNNAME_Line);
		return query;
	}
	
	/**
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @return array of MDashboardContent
	 */
	public static MDashboardContent[] getForSession(int AD_User_ID, int AD_Role_ID)
	{
		List<MDashboardContent> list = getForSessionQuery(AD_User_ID, AD_Role_ID).list();
		return list.toArray(new MDashboardContent[list.size()]);
	}
	
	/**
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @return Query
	 */
	public static Query getForSessionQuery(int AD_User_ID, int AD_Role_ID)
	{
		Properties ctx = Env.getCtx();
		
		StringBuilder whereClause = new StringBuilder();
		
		if (AD_Role_ID == 0)
			whereClause.append("(").append(COLUMNNAME_AD_Role_ID).append(" IS NULL OR ").append(COLUMNNAME_AD_Role_ID).append("=?)");
		else
			whereClause.append(COLUMNNAME_AD_Role_ID).append("=?");
		
		if (AD_User_ID == 0)
			whereClause.append(" AND (").append(COLUMNNAME_AD_User_ID).append(" IS NULL OR ").append(COLUMNNAME_AD_User_ID).append("=?)");
		else
			whereClause.append(" AND ").append(COLUMNNAME_AD_User_ID).append("=?");
		
		List<Object> parameters = new ArrayList<Object>();
		parameters.add(AD_Role_ID);
		parameters.add(AD_User_ID);
		
		return new Query(ctx, Table_Name, whereClause.toString(), null)
		.setParameters(parameters)
		.setOnlyActiveRecords(true)
		.setApplyAccessFilter(true, false)
		.setOrderBy(COLUMNNAME_ColumnNo+","+COLUMNNAME_AD_Client_ID+","+COLUMNNAME_Line);
	}
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param PA_DashboardContent_UU  UUID key
     * @param trxName Transaction
     */
    public MDashboardContent(Properties ctx, String PA_DashboardContent_UU, String trxName) {
        super(ctx, PA_DashboardContent_UU, trxName);
    }

    /**
     * @param ctx
     * @param PA_DashboardContent_ID
     * @param trxName
     */
    public MDashboardContent (Properties ctx, int PA_DashboardContent_ID, String trxName)
    {
      super (ctx, PA_DashboardContent_ID, trxName);
    }

    /**
     * @param ctx
     * @param rs
     * @param trxName
     */
    public MDashboardContent (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }
    
    /**
     * @return AD_Menu_ID or -1
     */
    public int getAD_Menu_ID()
    {
    	if (m_AD_Menu_ID != null)
    		return m_AD_Menu_ID;
    	if (getAD_Window_ID() <= 0)
    	{
    		m_AD_Menu_ID = -1;
    		return m_AD_Menu_ID;
    	}
    	m_AD_Menu_ID = new Query(getCtx(), MMenu.Table_Name, MMenu.COLUMNNAME_AD_Window_ID+"=?", null)
    	.setParameters(getAD_Window_ID())
    	.setOnlyActiveRecords(true)
    	.setOrderBy(MMenu.COLUMNNAME_AD_Menu_ID+" DESC")
    	.firstId();
    	return m_AD_Menu_ID;
    }
    
    private Integer m_AD_Menu_ID = null;
    
    /**
     * @return I_AD_Menu
     */
    public I_AD_Menu getAD_Menu()
    {
    	return (I_AD_Menu)MTable.get(getCtx(), I_AD_Menu.Table_Name)
    		.getPO(getAD_Menu_ID(), get_TrxName());
    }
    
    /**
     * Parse Process Parameters
     * @param parameters
     * @return HashMap&lt;String parameterName, String value&gt;
     */
    public static Map<String, String> parseProcessParameters(String parameters)	{
    	Map<String, String> paramMap = new HashMap<String, String>();
		if (Util.isEmpty(parameters, true))
			return paramMap;
    	Map<String, String> multiSelections = new HashMap<String, String>();
    	final String placeHolder = "_MULTISELECTVALUE_";
    	String multiSelection;
    	String parsedParameters = parameters;
		int idx = 0;
    	Pattern p = Pattern.compile("\"(.*?)\"");	// regex to extract multiselection values between double quotes: "(.*?)"
    	Matcher m = p.matcher(parameters);
    	
    	// extract the multiselection values before splitting by [,]
    	while (m.find()) {
    		String multiSelectionKey = placeHolder+idx;
    		multiSelection = parameters.substring(m.start(), m.end());
    		multiSelections.put(multiSelectionKey, multiSelection.replace("\"", ""));
    		parsedParameters = parsedParameters.replaceFirst(multiSelection, multiSelectionKey);
    		idx++;
		}
    	
    	// split values by [,]
    	if (! Util.isEmpty(parsedParameters, true)) {
			String[] params = parsedParameters.split("[,]");
			for (String s : params)
			{
				int pos = s.indexOf("=");
				if (pos < 0)
					throw new AdempiereException(Msg.getMsg(Env.getCtx(), "WrongProcessParameters"));
				String key = s.substring(0, pos);
				String value = s.substring(pos + 1);
				if(value.startsWith(placeHolder)) {
					value = multiSelections.get(value);	// insert the multiselection values back to the HashMap
				}
				paramMap.put(key, value);
			}
    	}
    	return paramMap;
    }
    
    /**
     * Parse all Process Parameters that are mandatory and not set
     * @return String of comma separated parameter names
     */
    public String getEmptyMandatoryProcessPara() {
    	StringBuilder emptyPara = new StringBuilder();
    	int processID = getAD_Process_ID();
		if(processID > 0) {
			MProcess process = MProcess.get(processID);
			Map<String, String> paramMap = parseProcessParameters(getProcessParameters());
			for(MProcessPara processPara : process.getParameters()) {
				if(processPara.isMandatory() && Util.isEmpty(paramMap.get(processPara.getColumnName()), true)) {
					if(!Util.isEmpty(emptyPara.toString(), true))
						emptyPara.append(", ");
					emptyPara.append(processPara.getColumnName());
				}
			}
		}
		return emptyPara.toString();
    }
    
    @Override
	protected boolean beforeSave (boolean newRecord) {
		// For embedded report content, all mandatory process parameters need to be set
		if (getAD_Process_ID() > 0 && isEmbedReportContent()) {
			String emptyPara = getEmptyMandatoryProcessPara();
			if(!Util.isEmpty(emptyPara)) {
				log.saveError("Error", Msg.getMsg(getCtx(), "FillMandatoryParametersDashboard", new Object[] {emptyPara}));
				return false;
			}
		}
		return true;
	}
}
