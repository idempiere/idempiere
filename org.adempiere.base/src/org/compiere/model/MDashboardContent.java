/**
 * 
 */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.compiere.util.CCache;
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
	private static final long serialVersionUID = -3565359682982006243L;
	
	private static CCache<Integer,MDashboardContent> s_cache = new CCache<Integer,MDashboardContent>("PA_DashboardContent_ID", 30, 60);
 	
	public static MDashboardContent get (Properties ctx, int PA_DashboardContent_ID)
	{
		Integer key = new Integer(PA_DashboardContent_ID);
		MDashboardContent retValue = (MDashboardContent)s_cache.get(key);
		if (retValue == null)
		{
			retValue = new MDashboardContent (ctx, PA_DashboardContent_ID, null);
			s_cache.put(key, retValue);
		}
		
		return retValue;
	}	//	get

	public static int getForSessionColumnCount(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
        int noOfCols = getForSessionQuery(isShowInDashboard, AD_User_ID, AD_Role_ID).aggregate("DISTINCT "+COLUMNNAME_ColumnNo, Query.AGGREGATE_COUNT, Integer.class);
        return noOfCols;
	}
	
	public static MDashboardContent[] getForSession(boolean isShowInDashboard, int AD_User_ID, int AD_Role_ID)
	{
		List<MDashboardContent> list = getForSessionQuery(isShowInDashboard, AD_User_ID, AD_Role_ID).list();
		return list.toArray(new MDashboardContent[list.size()]);
	}
	
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
	
	public static MDashboardContent[] getForUserList( int AD_User_ID, int AD_Role_ID)
	{
		List<MDashboardContent> list = getForUser( AD_User_ID, AD_Role_ID).list();
		return list.toArray(new MDashboardContent[list.size()]);
	}
	
	public static  Query getForUser( int AD_User_ID, int AD_Role_ID)
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
	
	public static MDashboardContent[] getForSession(int AD_User_ID, int AD_Role_ID)
	{
		List<MDashboardContent> list = getForSessionQuery(AD_User_ID, AD_Role_ID).list();
		return list.toArray(new MDashboardContent[list.size()]);
	}
	
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
