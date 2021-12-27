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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.FillMandatoryException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Tab Model
 *	
 *  @author Jorg Janke
 *  @author victor.perez@e-evolution.com, e-Evolution
 * <li>RF [2826384] The Order and Included Columns should be to fill mandatory
 * <li>https://sourceforge.net/p/adempiere/feature-requests/775/
 *  @version $Id: MTab.java,v 1.2 2006/07/30 00:58:37 jjanke Exp $
 */
public class MTab extends X_AD_Tab implements ImmutablePOSupport
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8111075325920938135L;

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MTab> s_cache = new ImmutableIntPOCache<Integer,MTab>(Table_Name, 20);
	
	/**
	 * 
	 * @param AD_Tab_ID
	 * @return {@link MTab}
	 */
	public static MTab get(int AD_Tab_ID)
	{
		Integer key = Integer.valueOf(AD_Tab_ID);
		MTab retValue = s_cache.get (Env.getCtx(), key, e -> new MTab(Env.getCtx(), e));
		if (retValue != null) 
			return retValue;
		
		retValue = new MTab (Env.getCtx(), AD_Tab_ID, (String)null);
		if (retValue.get_ID () == AD_Tab_ID) {
			s_cache.put (key, retValue);
			return retValue;
		}
		return null;
	}
	
	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Tab_ID id
	 *	@param trxName transaction
	 */
	public MTab (Properties ctx, int AD_Tab_ID, String trxName)
	{
		super (ctx, AD_Tab_ID, trxName);
		if (AD_Tab_ID == 0)
		{
			setEntityType (ENTITYTYPE_UserMaintained);	// U
			setHasTree (false);
			setIsReadOnly (false);
			setIsSingleRow (false);
			setIsSortTab (false);	// N
			setIsTranslationTab (false);
			setSeqNo (0);
			setTabLevel (0);
			setIsInsertRecord(true);
			setIsAdvancedTab(false);
		}
	}	//	M_Tab

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MTab (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	M_Tab

	/**
	 * 	Parent Constructor
	 *	@param parent parent
	 */
	public MTab (MWindow parent)
	{
		this (parent.getCtx(), 0, parent.get_TrxName());
		setClientOrg(parent);
		setAD_Window_ID(parent.getAD_Window_ID());
		setEntityType(parent.getEntityType());
	}	//	M_Tab

	/**
	 * 	Parent Constructor
	 *	@param parent parent
	 *	@param from copy from
	 */
	public MTab (MWindow parent, MTab from)
	{
		this (parent.getCtx(), 0, parent.get_TrxName());
		copyValues(from, this);
		setClientOrg(parent);
		setAD_Window_ID(parent.getAD_Window_ID());
		setEntityType(parent.getEntityType());
	}	//	M_Tab
	
	/**
	 * 
	 * @param copy
	 */
	public MTab(MTab copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MTab(Properties ctx, MTab copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MTab(Properties ctx, MTab copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_fields = copy.m_fields != null ? Arrays.stream(copy.m_fields).map(e -> {return new MField(ctx, e, trxName);}).toArray(MField[]::new) : null;
	}
	
	/**	The Fields						*/
	private MField[]		m_fields	= null;

	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MTab.class);
	
	/**	Packages for Model Classes	*/
	/**
	 * 	Get Fields
	 *	@param reload reload data
	 *	@return array of lines
	 *	@param trxName transaction
	 */
	public MField[] getFields (boolean reload, String trxName)
	{
		if (m_fields != null && !reload)
			return m_fields;
		String sql = "SELECT * FROM AD_Field WHERE AD_Tab_ID=? ORDER BY SeqNo";
		ArrayList<MField> list = new ArrayList<MField>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, getAD_Tab_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MField (getCtx(), rs, trxName));
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		//
		m_fields = new MField[list.size ()];
		list.toArray (m_fields);
		return m_fields;
	}	//	getFields

	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (isReadOnly() && isInsertRecord())
			setIsInsertRecord(false);
		if (is_new() || is_ValueChanged(COLUMNNAME_AD_TabType))
			setIsSortTab(AD_TABTYPE_Sort.equals(getAD_TabType())); // preserve this redundant flag for backward compatibility
		//RF[2826384]
		if(isSortTab())
		{
			if(getAD_ColumnSortOrder_ID() == 0)
			{
				throw new FillMandatoryException("AD_ColumnSortOrder_ID");	
			}			
		}
		return true;
	}
	
	// begin e-evolution vpj-cd
	/**
	 * 	get Tab ID
	 *	@param AD_Window_ID String
	 *	@param TabName String
	 *	@return int retValue
	 */
	public static int getTab_ID(int AD_Window_ID , String TabName) {
		int retValue = 0;
		String SQL = "SELECT AD_Tab_ID FROM AD_Tab WHERE AD_Window_ID= ?  AND Name = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(SQL, null);
			pstmt.setInt(1, AD_Window_ID);
			pstmt.setString(2, TabName);
			rs = pstmt.executeQuery();
			if (rs.next())
				retValue = rs.getInt(1);
		}
		catch (SQLException e)
		{
			s_log.log(Level.SEVERE, SQL, e);
			retValue = -1;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		return retValue;
	}
	//end vpj-cd e-evolution

    public int getParentTabID() {
    	int parentTabID = -1;

    	if (getTabLevel() == 0)
    		return parentTabID; // tab level 0 doesn't have parent

    	final String sql = ""
    		+ "SELECT AD_Tab_ID "
    		+ "FROM   AD_Tab "
    		+ "WHERE  AD_Window_ID = ? "
    		+ "       AND SeqNo < ? "
    		+ "       AND TabLevel = ? "
    		+ "       AND IsActive = 'Y' "
    		+ "ORDER  BY SeqNo DESC";
    	parentTabID = DB.getSQLValue(get_TrxName(), sql, getAD_Window_ID(), getSeqNo(), getTabLevel()-1);
    	return parentTabID;
    }

    @Override
	public MTab markImmutable() {
		if (is_Immutable())
			return this;

		makeImmutable();
		return this;
	}

}	//	M_Tab
