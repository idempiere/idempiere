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
	private static final long serialVersionUID = -3887344231734476767L;

	/**
	 *
	 * @param isShowInDashboard
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @return number of column
	 */
	public static int getForSessionColumnCount(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
        int noOfCols = getForSessionQuery(isShowInDashboard, AD_User_ID, AD_Role_ID)
        		.setOnlyActiveRecords(true)
        		.aggregate("DISTINCT "+COLUMNNAME_ColumnNo, Query.AGGREGATE_COUNT, Integer.class);
        return noOfCols;
	}

	/**
	 *
	 * @param isShowInDashboard
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @return number of row
	 */
	public static int getForSessionRowCount(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
        int noOfCols = getForSessionQuery(isShowInDashboard, AD_User_ID, AD_Role_ID)
        		.setOnlyActiveRecords(true)
        		.aggregate("DISTINCT "+COLUMNNAME_Line, Query.AGGREGATE_COUNT, Integer.class);
        return noOfCols;
	}

	/**
	 *
	 * @param isShowInDashboard
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @return MDashboardPreference[]
	 */
	public static MDashboardPreference[] getForSession(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
		List<MDashboardPreference> list = getForSessionQuery(isShowInDashboard, AD_User_ID, AD_Role_ID).list();
		return list.toArray(new MDashboardPreference[list.size()]);
	}

	private static Query getForSessionQuery(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
		return getForSessionQuery(isShowInDashboard, AD_User_ID, AD_Role_ID, -1);
	}

	private static Query getForSessionQuery(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID, int lineNo)
	{
		Properties ctx = Env.getCtx();

		StringBuilder whereClause = new StringBuilder(COLUMNNAME_IsShowInDashboard).append("=?")
			.append(" AND ").append(COLUMNNAME_AD_Role_ID).append("=?")
			.append(" AND ").append(COLUMNNAME_AD_User_ID).append("=?")
			.append(" AND ").append(COLUMNNAME_AD_Org_ID).append("=0");
		if(lineNo >= 0)
			whereClause.append(" AND ").append(COLUMNNAME_Line).append("=?");
		
		
		List<Object> parameters = new ArrayList<Object>();
		parameters.add(isShowInDashboard);
		parameters.add(AD_Role_ID);
		parameters.add(AD_User_ID);
		if(lineNo >= 0)
			parameters.add(lineNo);
		
		String orderByClause = (lineNo < 0) ? COLUMNNAME_ColumnNo+","+COLUMNNAME_AD_Client_ID+","+COLUMNNAME_Line 
				: COLUMNNAME_Line+","+COLUMNNAME_ColumnNo+","+COLUMNNAME_AD_Client_ID;
		
		return new Query(ctx, Table_Name, whereClause.toString(), null)
		.setParameters(parameters)
		.setOnlyActiveRecords(false)
		.setApplyAccessFilter(true, false)
		.setOrderBy(orderByClause);
	}

	/**
	 *
	 * @param AD_User_ID
	 * @param AD_Role_ID
	 * @param isCol
	 * @return MDashboardPreference[]
	 */
	public static MDashboardPreference[] getForSession(int AD_User_ID, int AD_Role_ID, boolean isCol)
	{
		List<MDashboardPreference> list = getForSessionQuery(AD_User_ID, AD_Role_ID, isCol).list();
		return list.toArray(new MDashboardPreference[list.size()]);
	}

	private static Query getForSessionQuery(int AD_User_ID, int AD_Role_ID, boolean isCol)
	{
		Properties ctx = Env.getCtx();

		StringBuilder whereClause = new StringBuilder()
			.append(COLUMNNAME_AD_Role_ID).append("=?")
			.append(" AND ").append(COLUMNNAME_AD_User_ID).append("=?")
			.append(" AND ").append(COLUMNNAME_AD_Org_ID).append("=0");
		
		List<Object> parameters = new ArrayList<Object>();
		parameters.add(AD_Role_ID);
		parameters.add(AD_User_ID);
		
		String orderByClause = "";
		if(isCol)
			orderByClause = COLUMNNAME_ColumnNo+","+COLUMNNAME_AD_Client_ID+","+ COLUMNNAME_Line;
		else
			orderByClause = COLUMNNAME_Line+","+COLUMNNAME_AD_Client_ID+","+ COLUMNNAME_ColumnNo; 
		
		return new Query(ctx, Table_Name, whereClause.toString(), null)
		.setParameters(parameters)
		.setOnlyActiveRecords(false)
		.setApplyAccessFilter(true, false)
		.setOrderBy(orderByClause);
	}

	/**
	 *
	 * @param ctx
	 * @param PA_DashboardPreference_ID
	 * @param trxName
	 */
    public MDashboardPreference (Properties ctx, int PA_DashboardPreference_ID, String trxName)
    {
      super (ctx, PA_DashboardPreference_ID, trxName);
    }

    /**
     *
     * @param ctx
     * @param rs
     * @param trxName
     */
    public MDashboardPreference (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

	/** Set User/Contact.
        @param AD_User_ID
        User within the system - Internal or Business Partner Contact
        Overridden to allow saving System record (zero ID)
	 */
	@Override
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID == SystemIDs.USER_SYSTEM_DEPRECATED) 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, AD_User_ID);
		else 
			super.setAD_User_ID(AD_User_ID);
	} //setAD_User_ID

}
