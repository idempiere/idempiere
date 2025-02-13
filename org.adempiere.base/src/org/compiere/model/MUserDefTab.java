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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutablePOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	User, role, organization or tenant overrides of tab model
 *  @author Dirk Niemeyer, action 42 GmbH
 *  @version $Id$
 */
public class MUserDefTab extends X_AD_UserDef_Tab implements ImmutablePOSupport
{
	/**
	 * generated serial id 
	 */
	private static final long serialVersionUID = 20120403111900L;

	/**	Cache of selected MUserDefTab entries 					*/
	private static ImmutablePOCache<String,MUserDefTab> s_cache = new ImmutablePOCache<String,MUserDefTab>(Table_Name, 10);
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_UserDef_Tab_UU  UUID key
     * @param trxName Transaction
     */
    public MUserDefTab(Properties ctx, String AD_UserDef_Tab_UU, String trxName) {
        super(ctx, AD_UserDef_Tab_UU, trxName);
    }

	/**
	 * 	Standard constructor.
	 *	@param ctx context
	 *	@param ID the primary key ID
	 *	@param trxName transaction
	 */
	public MUserDefTab (Properties ctx, int ID, String trxName)
	{
		super (ctx, ID, trxName);
	}	//	MUserDefTab

	/**
	 * 	Load Constructor.
	 *  @param ctx context
	 *  @param rs result set
	 *	@param trxName transaction
	 */
	public MUserDefTab (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MUserDefTab

	/**
	 * Copy constructor
	 * @param copy
	 */
	public MUserDefTab(MUserDefTab copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MUserDefTab(Properties ctx, MUserDefTab copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MUserDefTab(Properties ctx, MUserDefTab copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}
	
	/**
	 * Get MUserDefTab for tab and user definition for window
	 * @param ctx
	 * @param AD_Tab_ID
	 * @param AD_UserDefWin_ID
	 * @return MUserDefTab or null
	 */
	public static MUserDefTab getMatch (Properties ctx, int AD_Tab_ID, int AD_UserDefWin_ID )
	{
		MUserDefTab retValue = null;
		
		//  Check Cache
		String key = new StringBuilder().append(AD_Tab_ID).append("_")
				.append(AD_UserDefWin_ID)
				.toString();
		if (s_cache.containsKey(key))
			return s_cache.get(ctx, key, e -> new MUserDefTab(ctx, e));
		
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
			s_cache.put(key, retValue, e -> new MUserDefTab(Env.getCtx(), e));
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
	 * Get best matching MUserDefTab for tab and window 
	 * @param ctx
	 * @param AD_Tab_ID
	 * @param AD_Window_ID
	 * @return MUserDefTab or null
	 */
	public static MUserDefTab get (Properties ctx, int AD_Tab_ID, int AD_Window_ID) {
		
		MUserDefWin userdefWin = MUserDefWin.getBestMatch(ctx, AD_Window_ID);
		if (userdefWin == null)
			return null;
		
		return getMatch(ctx, AD_Tab_ID, userdefWin.getAD_UserDef_Win_ID());		
	}

	@Override
	public PO markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}
		
}	//	MUserDefTab
