/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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

package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;

/**
 * Dashboard preference
 * @author Elaine
 * @date August 22, 2012
 */
public class MDashboardPreference extends X_PA_DashboardPreference
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7568476952229922042L;

	public static int getForSessionColumnCount(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
        int noOfCols = getForSessionQuery(isShowInDashboard, AD_User_ID, AD_Role_ID).aggregate("DISTINCT "+COLUMNNAME_ColumnNo, Query.AGGREGATE_COUNT, Integer.class);
        return noOfCols;
	}
	
	public static MDashboardPreference[] getForSession(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
		List<MDashboardPreference> list = getForSessionQuery(isShowInDashboard, AD_User_ID, AD_Role_ID).list();
		return list.toArray(new MDashboardPreference[list.size()]);
	}
	
	public static Query getForSessionQuery(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
		Properties ctx = Env.getCtx();
		
		StringBuilder whereClause = new StringBuilder(COLUMNNAME_IsShowInDashboard).append("=?")
			.append(" AND ").append(COLUMNNAME_AD_Role_ID).append("=?")
			.append(" AND ").append(COLUMNNAME_AD_User_ID).append("=?");
		
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
	
	public static MDashboardPreference[] getForSession(int AD_User_ID, int AD_Role_ID)
	{
		List<MDashboardPreference> list = getForSessionQuery(AD_User_ID, AD_Role_ID).list();
		return list.toArray(new MDashboardPreference[list.size()]);
	}
	
	public static Query getForSessionQuery(int AD_User_ID, int AD_Role_ID)
	{
		Properties ctx = Env.getCtx();
		
		StringBuilder whereClause = new StringBuilder()
			.append(COLUMNNAME_AD_Role_ID).append("=?")
			.append(" AND ").append(COLUMNNAME_AD_User_ID).append("=?");
		
		List<Object> parameters = new ArrayList<Object>();
		parameters.add(AD_Role_ID);
		parameters.add(AD_User_ID);
		
		return new Query(ctx, Table_Name, whereClause.toString(), null)
		.setParameters(parameters)
		.setOnlyActiveRecords(false)
		.setApplyAccessFilter(true, false)
		.setOrderBy(COLUMNNAME_ColumnNo+","+COLUMNNAME_AD_Client_ID+","+COLUMNNAME_Line);
	}
	
    public MDashboardPreference (Properties ctx, int PA_DashboardPreference_ID, String trxName)
    {
      super (ctx, PA_DashboardPreference_ID, trxName);
    }
    
    public MDashboardPreference (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }
}
