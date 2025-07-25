/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *	User Query Model
 *	
 *  @author Jorg Janke
 *  @version $Id$
 */
public class MUserQuery extends X_AD_UserQuery
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -7615897105314639570L;

	/**
	 * 	Get all active queries of client for Tab
	 *	@param ctx context
	 *	@param AD_Tab_ID tab
	 *	@return array of queries
	 */
	public static MUserQuery[] get (Properties ctx, int AD_Tab_ID)
	{
		ArrayList<MUserQuery> list = getUserOnlyQueries(ctx, AD_Tab_ID);
		list.addAll(getAllUsersQueries(ctx, AD_Tab_ID));
		list.addAll(getClientQueries(ctx, AD_Tab_ID));
		list.addAll(getRoleQueries(ctx, AD_Tab_ID));

		Collections.sort(list, new Comparator<MUserQuery>() {
			@Override
			public int compare(MUserQuery uq1, MUserQuery uq2) {
				return uq1.getName().compareTo(uq2.getName());
			}
		});

		MUserQuery[] retValue = new MUserQuery[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	get
	
	/**
	 * 	Get all active user only queries for Tab
	 *	@param ctx context
	 *	@param AD_Tab_ID tab
	 *	@return array of queries
	 */
	public static ArrayList<MUserQuery> getUserOnlyQueries(Properties ctx, int AD_Tab_ID)
	{
		int AD_User_ID = Env.getAD_User_ID(ctx);
		String sql = "SELECT * FROM AD_UserQuery "
			 + "WHERE AD_Client_ID=? AND AD_Tab_ID=? AND IsActive='Y' "
			 + "AND AD_User_ID in (0, ?) "
			 + "ORDER BY Name";
		int AD_Client_ID = Env.getAD_Client_ID (ctx);
		ArrayList<MUserQuery> list = new ArrayList<MUserQuery>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, AD_Client_ID);
			pstmt.setInt (2, AD_Tab_ID);
			pstmt.setInt (3, AD_User_ID);
			rs = pstmt.executeQuery();
			while (rs.next ())
				list.add(new MUserQuery (ctx, rs, null));
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return list;
	}	//	getUserOnlyQueries
	
	/**
	 * 	Get all active queries of system tenant for Tab
	 *	@param ctx context
	 *	@param AD_Tab_ID tab
	 *	@return array of queries
	 */
	public static ArrayList<MUserQuery> getAllUsersQueries(Properties ctx, int AD_Tab_ID)
	{
		String sql = "SELECT * FROM AD_UserQuery "
			 + "WHERE AD_Client_ID=0 AND AD_Tab_ID=? AND IsActive='Y' "
			 + "AND AD_User_ID IS NULL AND AD_Role_ID IS NULL "
			 + "ORDER BY Name";
		ArrayList<MUserQuery> list = new ArrayList<MUserQuery>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, AD_Tab_ID);
			rs = pstmt.executeQuery();
			while (rs.next ())
				list.add(new MUserQuery (ctx, rs, null));
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return list;
	}	//	getAllUsersQueries
	
	/**
	 * 	Get all active client only queries for Tab
	 *	@param ctx context
	 *	@param AD_Tab_ID tab
	 *	@return array of queries
	 */
	public static ArrayList<MUserQuery> getClientQueries(Properties ctx, int AD_Tab_ID)
	{
		String sql = "SELECT * FROM AD_UserQuery "
			 + "WHERE AD_Client_ID=? AND AD_Tab_ID=? AND IsActive='Y' "
			 + "AND AD_User_ID IS NULL AND AD_Role_ID IS NULL "
			 + "ORDER BY Name";
		int AD_Client_ID = Env.getAD_Client_ID (ctx);
		ArrayList<MUserQuery> list = new ArrayList<MUserQuery>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, AD_Client_ID);
			pstmt.setInt (2, AD_Tab_ID);
			rs = pstmt.executeQuery();
			while (rs.next ())
				list.add(new MUserQuery (ctx, rs, null));
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return list;
	}	//	getClientQueries
	
	/**
	 * 	Get all active role only queries for Tab
	 *	@param ctx context
	 *	@param AD_Tab_ID tab
	 *	@return array of queries
	 */
	public static ArrayList<MUserQuery> getRoleQueries(Properties ctx, int AD_Tab_ID)
	{
		String sql = "SELECT * FROM AD_UserQuery "
			 + "WHERE AD_Client_ID IN (0,?) AND AD_Tab_ID=? AND IsActive='Y' "
			 + "AND AD_User_ID IS NULL "
			 + "AND (AD_Role_ID = ? OR AD_Role_ID IN (SELECT Included_Role_ID FROM   AD_Role_Included WHERE  AD_Role_id = ? AND IsActive = 'Y')) "
			 + "ORDER BY Name";
		int AD_Client_ID = Env.getAD_Client_ID (ctx);
		int AD_Role_ID = Env.getAD_Role_ID (ctx);
		ArrayList<MUserQuery> list = new ArrayList<MUserQuery>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, AD_Client_ID);
			pstmt.setInt (2, AD_Tab_ID);
			pstmt.setInt (3, AD_Role_ID);
			pstmt.setInt (4, AD_Role_ID);
			rs = pstmt.executeQuery();
			while (rs.next ())
				list.add(new MUserQuery (ctx, rs, null));
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return list;
	}	//	getRoleQueries
	
	/**
	 * 	Get Specific Tab Query via name (use case insensitive like matching).
	 *	@param ctx context
	 *	@param AD_Tab_ID tab
	 *	@param name query name
	 *	@return query or null
	 */
	public static MUserQuery get (Properties ctx, int AD_Tab_ID, String name)
	{
		int AD_User_ID = Env.getAD_User_ID(ctx);
		String sql = "SELECT * FROM AD_UserQuery "
			 + "WHERE AD_Client_ID=? AND AD_Tab_ID=? AND UPPER(Name) LIKE ? AND IsActive='Y' "
			 + "AND AD_User_ID in (0, " + AD_User_ID + ") "
			 + "ORDER BY Name";
		int AD_Client_ID = Env.getAD_Client_ID (ctx);
		if (name == null)
			name = "%";
		MUserQuery retValue = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, AD_Client_ID);
			pstmt.setInt (2, AD_Tab_ID);
			pstmt.setString (3, name.toUpperCase());
			rs = pstmt.executeQuery ();
			if (rs.next ())
				retValue = new MUserQuery (ctx, rs, null);
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return retValue;
	}	//	get
	
	/**
	 * 	Get Tab Query via name (use case insensitive like matching). 
	 *  Private or global.
	 *	@param ctx context
	 *	@param AD_Tab_ID tab
	 *	@param name query name
	 *	@return query or null
	 */
	public static MUserQuery getUserQueryByName(Properties ctx, int AD_Tab_ID, String name)
	{
		String sqlWhere = " AD_Client_ID=? AND AD_Tab_ID=? AND UPPER(Name) LIKE ? "
			 + "AND (AD_User_ID = ? OR AD_User_ID IS NULL) ";

		return new Query(ctx, Table_Name, sqlWhere, null)
				.setParameters(Env.getAD_Client_ID (ctx), AD_Tab_ID, name.toUpperCase(), Env.getAD_User_ID(ctx))
				.setOnlyActiveRecords(true)
				.setOrderBy("Name")
				.first();
	}	//	getUserQueryByName

	/**	Logger	*/
	private static CLogger s_log = CLogger.getCLogger (MUserQuery.class);
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_UserQuery_UU  UUID key
     * @param trxName Transaction
     */
    public MUserQuery(Properties ctx, String AD_UserQuery_UU, String trxName) {
        super(ctx, AD_UserQuery_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_UserQuery_ID id
	 *	@param trxName trx
	 */
	public MUserQuery(Properties ctx, int AD_UserQuery_ID, String trxName)
	{
		super (ctx, AD_UserQuery_ID, trxName);
	}	//	MUserQuery

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MUserQuery(Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MUserQuery

	@Override
	protected boolean beforeSave(boolean newRecord) {
		if (getAD_Tab_ID() > 0) {
			// Set AD_Window_ID and AD_Table_ID from AD_Tab_ID
			if (newRecord || is_ValueChanged(COLUMNNAME_AD_Tab_ID)) {
				MTab tab = new MTab(getCtx(), getAD_Tab_ID(), get_TrxName());
				setAD_Window_ID(tab.getAD_Window_ID());
				setAD_Table_ID(tab.getAD_Table_ID());
			}
		} else {
			setAD_Window_ID(0);
		}
		return true;
	}
	
	/**
	 * Can user save this query record.
	 * @return true if the current user can save the query privately and is not a SQL Query
	 */
	public boolean userCanSave() {
		if (getAD_Client_ID() != Env.getAD_Client_ID(Env.getCtx()) || //Cannot modify a query from another client (e.g. System) 
				getAD_User_ID() != Env.getAD_User_ID(Env.getCtx()) || //Cannot save a query from a different user
				get_Value(COLUMNNAME_AD_User_ID) == null) //Cannot save privately (user-specific) an already existing global query
			return false;

		return !getCode().startsWith(MColumn.VIRTUAL_UI_COLUMN_PREFIX);
	}
	
	/**
	 * Can use share this query record.
	 * @return true if the current users has permission to share or modify the query globally and is not a SQL Query
	 */
	public boolean userCanShare() {
		if (!MRole.PREFERENCETYPE_Client.equals(MRole.getDefault().getPreferenceType()) || //Share button only works for roles with preference level = Client
        		getAD_Client_ID() != Env.getAD_Client_ID(Env.getCtx())) //Cannot modify a query from another client (e.g. System) 
			return false;

		return !getCode().startsWith(MColumn.VIRTUAL_UI_COLUMN_PREFIX);
	}
	
	/**
	 * Retrieves the default user query for the specified window, tab, and user.
	 *
	 * <p>This method constructs a query to fetch the default user query for the current user
	 * based on the `AD_Window_ID`, `AD_Tab_ID`, and `AD_User_ID`. It ensures that only active records
	 * are considered and filters the results by the current client.</p>
	 *
	 * @return The default `MUserQuery` object for the specified window, tab, and user, or `null` if no match is found.
	 */
	public MUserQuery getDefaultQueryForUserAndTab() {
		String whereClause = "AD_Window_ID=? AND AD_Tab_ID=? AND AD_User_ID=? "
				+ "AND AD_UserQuery_ID !=? AND IsDefault=?";		
		return new Query(Env.getCtx(), Table_Name, whereClause,null)
				.setParameters(getAD_Window_ID(), getAD_Tab_ID(), Env.getAD_User_ID(Env.getCtx()), getAD_UserQuery_ID(), true)
				.setClient_ID()
				.setOnlyActiveRecords(true)
				.first();
	}	//	getDefaultQueriesForUserAndTab
	
	public boolean isShared() {
		return getAD_User_ID() <= 0;
	} // isShared

}	//	MUserQuery
