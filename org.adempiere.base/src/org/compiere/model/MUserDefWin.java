/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Dirk Niemeyer                                           *
 * Copyright (C) 2012 action 42 GmbH                                          *
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

import java.sql.*;
import java.util.*;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *	
 *  @author Dirk Niemeyer, action42 GmbH
 *  @version $Id$
 */
public class MUserDefWin extends X_AD_UserDef_Win
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 	Standard constructor.
	 * 	You must implement this constructor for Adempiere Persistency
	 *	@param ctx context
	 *	@param ID the primary key ID
	 *	@param trxName transaction
	 */
	public MUserDefWin (Properties ctx, int ID, String trxName)
	{
		super (ctx, ID, trxName);
	}	//	MyModelExample

	/**
	 * 	Optional Load Constructor.
	 * 	You would use this constructor to load several business objects.
	 *  <code>
	 * 	SELECT * FROM MyModelExample WHERE ...
	 *  </code> 
	 *  @param ctx context
	 *  @param rs result set
	 *	@param trxName transaction
	 */
	public MUserDefWin (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MyModelExample


	private static MUserDefWin[] getAll (Properties ctx, int window_ID )
	{

		List<MUserDefWin> list = new ArrayList<MUserDefWin>();

		StringBuffer sql = new StringBuffer("SELECT * "
				+ " FROM AD_UserDef_Win w "
				+ " WHERE w.AD_Window_ID=? AND w.IsActive='Y' "
				+ " AND w.AD_Language=? "
				+ " AND w.AD_Client_ID=? ");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			//      create statement
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, window_ID);
			pstmt.setString(2, Env.getAD_Language(ctx));
			pstmt.setInt(3, Env.getAD_Client_ID(ctx));
			//      get data
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MUserDefWin userDef = new MUserDefWin(Env.getCtx(),rs,null);
				list.add(userDef);
			}
		}
		catch (SQLException ex)
		{
			CLogger.get().log(Level.SEVERE, sql.toString(), ex);
			return null;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; 
			pstmt = null;
		}
		
		if (list.size() == 0)
			return null;

		return list.toArray(new MUserDefWin[list.size()]);

	}
	
	public static MUserDefWin getBestMatch (Properties ctx, int window_ID)
	{
		// parameters
		final int AD_Org_ID = Env.getAD_Org_ID(ctx);
		//final int anyOrg = 0;
		final int AD_Role_ID = Env.getAD_Role_ID(ctx);
		//final String anyRole = "NULL";
		final int AD_User_ID = Env.getAD_User_ID(ctx);
		//final String anyUser = "NULL";
		
		// candidates
		MUserDefWin[] candidates = getAll(ctx, window_ID);
		if (candidates == null)
			return null;
		final int size = candidates.length;
		int[] weight = new int[size];
		
		// this user + this role + this org => weight = 7
		// this user + this role + any org  => weight = 6
		// this user + any role  + this org => weight = 5
		// this user + any role  + any org  => weight = 4
		// any user  + this role + this org => weight = 3
		// any user  + this role + any org  => weight = 2
		// any user  + any role  + this org => weight = 1
		// any user  + any role  + any org  => weight = 0
		// other user or other role or other org => weight = -1 and thus ruled out
		for (int i=0; i < size; i++)
		{
			weight[i] = 0;
			if (candidates[i].getAD_User_ID() > 0) {
				if (candidates[i].getAD_User_ID() == AD_User_ID) {
					weight[i] = weight[i] + 4;
				} else {
					weight[i] = -1;
				}
			}
			if (weight[i] > -1 && candidates[i].getAD_Role_ID() > 0) {
				if (candidates[i].getAD_Role_ID() == AD_Role_ID) {
					weight[i] = weight[i] + 2;
				} else {
					weight[i] = -1;
				}
			}
			if (weight[i] > -1 && candidates[i].getAD_Org_ID() > 0) {
				if (candidates[i].getAD_Org_ID() == AD_Org_ID) {
					weight[i] = weight[i] + 1;
				} else {
					weight[i] = -1;
				}
			}
			// others are implicit
		}

	    int maximum = weight[0];   // start with the first value
	    int maxindex = 0;
	    for (int j=0; j<weight.length; j++) {
	        if (weight[j] > maximum) {
	            maximum = weight[j];   // new maximum
	            maxindex = j;
	        }
	    }

	    if (weight[maxindex] > -1) {
		return candidates[maxindex];
	    } else {
	    	return null;
	    }
	}
		
}	//	MUserDefWin
