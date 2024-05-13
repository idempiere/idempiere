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
 */
public class MDashboardContentAccess extends X_PA_DashboardContent_Access {

	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = -4460812046437256244L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param PA_DashboardContent_Access_UU  UUID key
     * @param trxName Transaction
     */
    public MDashboardContentAccess(Properties ctx, String PA_DashboardContent_Access_UU, String trxName) {
        super(ctx, PA_DashboardContent_Access_UU, trxName);
    }

	/**
	 * @param ctx
	 * @param PA_DashboardContent_Access_ID
	 * @param trxName
	 */
	public MDashboardContentAccess(Properties ctx, int PA_DashboardContent_Access_ID, String trxName) {
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
	
	/**
	 * @param ctx
	 * @param AD_Role
	 * @param AD_User
	 * @param trxname
	 * @return array of MDashboardContent
	 */
	public static MDashboardContent[] get (Properties ctx,int AD_Role, int AD_User, String trxname)
	{
		
		int AD_Client_ID = Env.getAD_Client_ID(ctx);
		ArrayList<MDashboardContent> content =new ArrayList<MDashboardContent>() ;
		List<Object> parameters = new ArrayList<Object>();
		
		parameters.add(AD_Client_ID);
		parameters.add(AD_Client_ID);
		
		StringBuilder sql= new StringBuilder();
		// First part : dashboards not configured in access and flagged to be shown in login (this is intended to show new dashboards, otherwise new dashboards won't be shown unless the user go and configure them)
		sql.append("SELECT PA_DashboardContent_ID,ColumnNo ")
		   .append(" FROM PA_DashboardContent ")
		   .append(" WHERE PA_DashboardContent_ID NOT IN (")
		   .append("  SELECT PA_DashboardContent_ID ")
		   .append("  FROM  PA_DashboardContent_Access" )
		   .append("   WHERE IsActive='Y' AND AD_Client_ID IN (0, ?))")
		   .append(" AND IsShowInLogin='Y'")
		   .append(" AND IsActive='Y' AND AD_Client_ID IN (0, ?)");

		// New part : remove dashboard if inactive records 
		sql.append(" AND PA_DashboardContent_ID NOT IN (SELECT PA_DashboardContent_ID FROM PA_DashboardContent_Access ct2 WHERE ct2.IsActive='N' AND ct2.AD_Client_ID in (0,?)");
		parameters.add(AD_Client_ID);
		if (AD_Role >= 0) {
			sql.append(" AND COALESCE(ct2.AD_Role_ID, ?) = ?");			  
			parameters.add(AD_Role);
			parameters.add(AD_Role);
		}
		if (AD_User >= 0) {
			sql.append(" AND COALESCE(ct2.AD_User_ID, ?) = ?");
			parameters.add(AD_User);
			parameters.add(AD_User);
		}
		sql.append(")");

		sql.append(" UNION  ALL")
		   // Second part : second part is to process the dashboards configured in content access
		   .append(" SELECT ct.PA_DashboardContent_ID,ct.ColumnNo")
		   .append(" FROM  PA_DashboardContent ct")
		   .append(" INNER JOIN PA_DashboardContent_Access cta on (ct.PA_DashboardContent_ID = cta.PA_DashboardContent_ID)")
		   .append(" WHERE cta.IsActive='Y'")
		   .append(" AND ct.IsActive='Y'");
				
		if(AD_Role >= 0) {
			sql.append(" AND COALESCE(cta.AD_Role_ID, ?) = ?");			  
			parameters.add(AD_Role);
			parameters.add(AD_Role);
		}
		if (AD_User >= 0) {
			sql.append(" AND COALESCE(cta.AD_User_ID, ?) = ?");
			parameters.add(AD_User);
			parameters.add(AD_User);
		}

		sql.append(" AND cta.AD_Client_ID in (0,?)");
		parameters.add(AD_Client_ID);

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
