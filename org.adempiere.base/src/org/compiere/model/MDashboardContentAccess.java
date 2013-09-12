/**
 * 
 */
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * @author juliana
 *
 */
public class MDashboardContentAccess extends X_PA_DashboardContent_Access {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4460812046437256244L;

	/**
	 * @param ctx
	 * @param PA_DashboardContent_Access_ID
	 * @param trxName
	 */
	public MDashboardContentAccess(Properties ctx,
			int PA_DashboardContent_Access_ID, String trxName) {
		super(ctx, PA_DashboardContent_Access_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MDashboardContentAccess(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	public static MDashboardContent[] get (Properties ctx,int AD_Role, int AD_User, String trxname, boolean isShowinDashboard)
	{
		
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		ArrayList<MDashboardContent> content =new ArrayList<MDashboardContent>() ;
		List<Object> parameters = new ArrayList<Object>();
		
		if(isShowinDashboard){
			parameters.add("Y");
			parameters.add("Y");
		}else{
			parameters.add("N");
			parameters.add("N");
		}
		
		StringBuffer sql= new StringBuffer();
		sql.append("SELECT PA_DashboardContent_ID,ColumnNo ")
		   .append(" FROM PA_DashboardContent ")
		   .append(" WHERE PA_DashboardContent_ID NOT IN (")
		   .append("  SELECT PA_DashboardContent_ID ")
		   .append("  FROM  PA_DashboardContent_Access" )
		   .append("   WHERE IsActive='Y' )")
		   .append(" AND IsShowInLogin='Y'")
		   .append(" AND IsActive='Y'")
		   .append(" AND IsShowInDashboard=?")
		   .append(" UNION  ALL")
		   .append(" SELECT ct.PA_DashboardContent_ID,ct.ColumnNo")
		   .append(" FROM  PA_DashboardContent ct")
		   .append(" INNER JOIN PA_DashboardContent_Access cta on (ct.PA_DashboardContent_ID = cta.PA_DashboardContent_ID)")
		   .append(" WHERE cta.IsActive='Y'")
		   .append(" AND ct.IsActive='Y'")
		   .append(" AND ct.IsShowInDashboard=?");
				
		if(AD_Role > 0){
			sql.append(" AND cta.AD_Role_ID = ?");			  
			parameters.add(AD_Role);
		}
		
		if (AD_User > 0){
			sql.append(" OR cta.AD_User_ID = ?");
			parameters.add(AD_User);
		}

		if (AD_Client_ID > 0){
			sql.append(" AND cta.AD_Client_ID in (0,?)");
			parameters.add(AD_Client_ID);
		}
        sql.append(" ORDER BY ColumnNo");
 
        PreparedStatement pstmt=null;
        ResultSet rs = null;
        
        try{
        	pstmt= DB.prepareStatement(sql.toString(), trxname);
        	
        	for (int i=0; i < parameters.size() ; i++){
        		pstmt.setObject(i+1, parameters.get(i));
        	}
        	
        	rs = pstmt.executeQuery();
        	
        	while(rs != null && rs.next()){
        		int ID= rs.getInt(1);
        		MDashboardContent cont = new MDashboardContent(ctx, ID, trxname);
        		content.add(cont);
        	}
        	
        }catch (Exception e) {
			throw new AdempiereException(e.getLocalizedMessage());
		}finally{
			DB.close(rs, pstmt);
		}
        
		return content.toArray(new MDashboardContent[content.size()]);	
	}
}
