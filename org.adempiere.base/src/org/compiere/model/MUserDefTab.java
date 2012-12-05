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


/**
 *	User overrides for tab model
 *  @author Dirk Niemeyer, action 42 GmbH
 *  @version $Id$
 *  
 */
public class MUserDefTab extends X_AD_UserDef_Tab
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 20120403111900L;

	/**
	 * 	Standard constructor.
	 * 	You must implement this constructor for Adempiere Persistency
	 *	@param ctx context
	 *	@param ID the primary key ID
	 *	@param trxName transaction
	 */
	public MUserDefTab (Properties ctx, int ID, String trxName)
	{
		super (ctx, ID, trxName);
	}	//	MUserDefTab

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
	public MUserDefTab (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MUserDefTab

	/**
	 * Get matching MUserDefTab related to current tab and user definition for window
	 * @param ctx
	 * @param AD_Tab_ID
	 * @param AD_UserDefWin_ID
	 * @return
	 */
	public static MUserDefTab getMatch (Properties ctx, int AD_Tab_ID, int AD_UserDefWin_ID )
	{

		MUserDefTab retValue = null;

		StringBuilder sql = new StringBuilder("SELECT * "
				+ " FROM AD_UserDef_Tab " 
				+ " WHERE AD_UserDef_Win_ID=? AND IsActive='Y' "
				+ " AND AD_Tab_ID=? ");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			//	create statement
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, AD_UserDefWin_ID);
			pstmt.setInt(2, AD_Tab_ID);
			// 	get data
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				retValue = new MUserDefTab(ctx,rs,null);
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

		return retValue;
	}

	/**
	 * Get matching MUserDefTab related to current tab and window 
	 * @param ctx
	 * @param AD_Tab_ID
	 * @param AD_Window_ID
	 * @return
	 */
	public static MUserDefTab get (Properties ctx, int AD_Tab_ID, int AD_Window_ID) {
		
		MUserDefWin userdefWin = MUserDefWin.getBestMatch(ctx, AD_Window_ID);
		if (userdefWin == null)
			return null;
		
		return getMatch(ctx, AD_Tab_ID, userdefWin.getAD_UserDef_Win_ID());
		
	}
		
}	//	MUserDefTab
