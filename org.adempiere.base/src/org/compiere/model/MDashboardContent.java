/**
 * 
 */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;

/**
 * @author teo_sarca
 *
 */
public class MDashboardContent extends X_PA_DashboardContent
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5425307033413466516L;

	public static int getForSessionColumnCount(boolean isShowInDashboard, int AD_User_ID)
	{
        int noOfCols = getForSessionQuery(isShowInDashboard, AD_User_ID).aggregate("DISTINCT "+COLUMNNAME_ColumnNo, Query.AGGREGATE_COUNT, Integer.class);
        return noOfCols;
	}
	
	public static MDashboardContent[] getForSession(boolean isShowInDashboard, int AD_User_ID)
	{
		List<MDashboardContent> list = getForSessionQuery(isShowInDashboard, AD_User_ID).list();
		return list.toArray(new MDashboardContent[list.size()]);
	}
	
	public static Query getForSessionQuery(boolean isShowInDashboard, int AD_User_ID)
	{
		Properties ctx = Env.getCtx();
		
		String whereClause = COLUMNNAME_IsShowInDashboard+"=? AND ("
				+COLUMNNAME_AD_Role_ID+" IS NULL OR "+COLUMNNAME_AD_Role_ID+" IN (0,?))";
		if (AD_User_ID == 0)
			whereClause += " AND ("+COLUMNNAME_AD_User_ID+" IS NULL OR "+COLUMNNAME_AD_User_ID+"=?)";
		else
			whereClause += " AND "+COLUMNNAME_AD_User_ID+"=?";
		
		List<Object> parameters = new ArrayList<Object>();
		parameters.add(isShowInDashboard);
		parameters.add(Env.getAD_Role_ID(ctx));
		parameters.add(AD_User_ID);
		
		return new Query(ctx, Table_Name, whereClause, null)
		.setParameters(parameters)
		.setOnlyActiveRecords(true)
		.setApplyAccessFilter(true, false)
		.setOrderBy(COLUMNNAME_ColumnNo+","+COLUMNNAME_AD_Client_ID+","+COLUMNNAME_Line);
	}
	
	public static MDashboardContent[] getForSession(int AD_User_ID)
	{
		List<MDashboardContent> list = getForSessionQuery(AD_User_ID).list();
		return list.toArray(new MDashboardContent[list.size()]);
	}
	
	public static Query getForSessionQuery(int AD_User_ID)
	{
		Properties ctx = Env.getCtx();
		
		String whereClause = "("+COLUMNNAME_AD_Role_ID+" IS NULL OR "+COLUMNNAME_AD_Role_ID+" IN (0,?))";
		if (AD_User_ID == 0)
			whereClause += " AND ("+COLUMNNAME_AD_User_ID+" IS NULL OR "+COLUMNNAME_AD_User_ID+"=?)";
		else
			whereClause += " AND "+COLUMNNAME_AD_User_ID+"=?";
		
		List<Object> parameters = new ArrayList<Object>();
		parameters.add(Env.getAD_Role_ID(ctx));
		parameters.add(AD_User_ID);
		
		return new Query(ctx, Table_Name, whereClause, null)
		.setParameters(parameters)
		.setOnlyActiveRecords(true)
		.setApplyAccessFilter(true, false)
		.setOrderBy(COLUMNNAME_ColumnNo+","+COLUMNNAME_AD_Client_ID+","+COLUMNNAME_Line);
	}
	
    public MDashboardContent (Properties ctx, int PA_DashboardContent_ID, String trxName)
    {
      super (ctx, PA_DashboardContent_ID, trxName);
    }
    public MDashboardContent (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }
    
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
    
    public I_AD_Menu getAD_Menu()
    {
    	return (I_AD_Menu)MTable.get(getCtx(), I_AD_Menu.Table_Name)
    		.getPO(getAD_Menu_ID(), get_TrxName());
    }
}
