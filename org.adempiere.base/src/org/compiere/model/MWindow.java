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

import java.awt.Dimension;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.compiere.wf.MWFNode;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Window Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MWindow.java,v 1.2 2006/07/30 00:58:05 jjanke Exp $
 */
public class MWindow extends X_AD_Window implements ImmutablePOSupport
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -7482290667487859946L;

	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MWindow.class);

	/**	Cache						*/
	private static ImmutableIntPOCache<Integer,MWindow> s_cache = new ImmutableIntPOCache<Integer,MWindow>(Table_Name, 20, 0, false, 0);

	/**
	 * 	Get Window from Cache (immutable)
	 *	@param AD_Window_ID id
	 *	@return MWindow
	 */
	public static MWindow get (int AD_Window_ID)
	{
		return get(Env.getCtx(), AD_Window_ID);
	}
	
	/**
	 * 	Get Window from Cache (immutable)
	 *	@param ctx context
	 *	@param AD_Window_ID id
	 *	@return MWindow
	 */
	public static MWindow get (Properties ctx, int AD_Window_ID)
	{
		Integer key = Integer.valueOf(AD_Window_ID);
		MWindow retValue = s_cache.get (ctx, key, e -> new MWindow(ctx, e));
		if (retValue != null) 
			return retValue;
		
		retValue = new MWindow (ctx, AD_Window_ID, (String)null);
		if (retValue.get_ID () == AD_Window_ID) {
			s_cache.put (key, retValue, e -> new MWindow(Env.getCtx(), e));
			return retValue;
		}
		return null;
	}	//	get

	/**
	 * Get window record by UUID
	 * @param ctx context
	 * @param uu AD_Window_UU
	 * @return MWindow object or null
	 */
	public static MWindow get(Properties ctx, String uu)
	{
		if (Util.isEmpty(uu, true))
			return null;
		MWindow[] it = s_cache.values().toArray(new MWindow[0]);
		for (MWindow retValue : it)
		{
			if (uu.equals(retValue.getAD_Window_UU()))
			{
				return new MWindow(ctx, retValue);
			}
		}

		final String whereClause = MWindow.COLUMNNAME_AD_Window_UU + "=?";
		MWindow retValue = new Query(ctx, MWindow.Table_Name, whereClause, (String)null)
				.setParameters(uu)
				.setOnlyActiveRecords(true)
				.first();

		return retValue;
	}

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_Window_UU  UUID key
     * @param trxName Transaction
     */
    public MWindow(Properties ctx, String AD_Window_UU, String trxName) {
        super(ctx, AD_Window_UU, trxName);
		if (Util.isEmpty(AD_Window_UU))
			setInitialDefaults();
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Window_ID
	 *	@param trxName transaction
	 */
	public MWindow (Properties ctx, int AD_Window_ID, String trxName)
	{
		super (ctx, AD_Window_ID, trxName);
		if (AD_Window_ID == 0)
			setInitialDefaults();
	}	//	M_Window

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setWindowType (WINDOWTYPE_Maintain);	// M
		setEntityType (ENTITYTYPE_UserMaintained);	// U
		setIsBetaFunctionality (false);
		setIsDefault (false);
		setIsSOTrx (true);	// Y
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MWindow (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	M_Window
	
	/**
	 * Copy constructor 
	 * @param copy
	 */
	public MWindow(MWindow copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 */
	public MWindow(Properties ctx, MWindow copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * Copy constructor
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MWindow(Properties ctx, MWindow copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_tabs = copy.m_tabs != null ? Arrays.stream(copy.m_tabs).map(e -> {return new MTab(ctx, e, trxName);}).toArray(MTab[]::new) : null;
	}
	
	/**
	 * 	Set Window Size
	 *	@param size size
	 */
	public void setWindowSize (Dimension size)
	{
		if (size != null)
		{
			setWinWidth(size.width);
			setWinHeight(size.height);
		}
	}	//	setWindowSize
	
	/**	The Tabs						*/
	private MTab[]		m_tabs	= null;

	/**
	 * 	Get Tabs
	 *	@param reload true to reload data
	 *  @param trxName transaction
	 *	@return array of tabs
	 */
	public MTab[] getTabs (boolean reload, String trxName)
	{
		if (m_tabs != null && !reload)
			return m_tabs;
		final String whereClause = I_AD_Tab.COLUMNNAME_AD_Window_ID+"=?";
		List<MTab> list = new Query(getCtx(),I_AD_Tab.Table_Name,whereClause,trxName)
		.setParameters(getAD_Window_ID())
		.setOrderBy(I_AD_Tab.COLUMNNAME_SeqNo)
		.list();
		//
		if (list.size() > 0 && is_Immutable())
			list.stream().forEach(e -> e.markImmutable());
		m_tabs = new MTab[list.size ()];
		list.toArray (m_tabs);
		return m_tabs;
	}	//	getTabs
	
	@Override
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		if (newRecord)	
		{
			// Create window access records for all automatic role
			MRole[] roles = MRole.getOf(getCtx(), "IsManual='N'");
			for (int i = 0; i < roles.length; i++)
			{
				MWindowAccess wa = new MWindowAccess(this, roles[i].getAD_Role_ID());
				wa.saveEx();
			}
		}
		//	Menu/Workflow
		else if (is_ValueChanged("IsActive") || is_ValueChanged("Name") 
			|| is_ValueChanged("Description") || is_ValueChanged("Help"))
		{
			// Update menu
			MMenu[] menues = MMenu.get(getCtx(), "AD_Window_ID=" + getAD_Window_ID(), get_TrxName());
			for (int i = 0; i < menues.length; i++)
			{
				menues[i].setName(getName());
				menues[i].setDescription(getDescription());
				menues[i].setIsActive(isActive());
				menues[i].saveEx();
			}
			// Update workflow node
			MWFNode[] nodes = MWFNode.getWFNodes(getCtx(), "AD_Window_ID=" + getAD_Window_ID(), get_TrxName());
			for (int i = 0; i < nodes.length; i++)
			{
				boolean changed = false;
				if (nodes[i].isActive() != isActive())
				{
					nodes[i].setIsActive(isActive());
					changed = true;
				}
				if (nodes[i].isCentrallyMaintained())
				{
					nodes[i].setName(getName());
					nodes[i].setDescription(getDescription());
					nodes[i].setHelp(getHelp());
					changed = true;
				}
				if (changed)
					nodes[i].saveEx();
			}
		}
		return success;
	}	//	afterSave
	
	/**
	 * @deprecated use {@link MWFNode#getWFNodes(Properties, String, String)} instead.
	 */
	@Deprecated
	public static MWFNode[] getWFNodes (Properties ctx, String whereClause, String trxName)
	{		
		return MWFNode.getWFNodes(ctx, whereClause, trxName);
	}	//	getWFNode
	
	/**
	 * 	Get Window ID
	 *	@param windowName window name
	 *	@return AD_Window_ID
	 */
	public static int getWindow_ID(String windowName) {
		int retValue = 0;
		String SQL = "SELECT AD_Window_ID FROM AD_Window WHERE Name = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(SQL, null);
			pstmt.setString(1, windowName);
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
		}
		return retValue;
	}
	
	@Override
	public MWindow markImmutable() {
		if (is_Immutable())
			return this;
		
		makeImmutable();
		if (m_tabs != null && m_tabs.length > 0)
			Arrays.stream(m_tabs).forEach(e -> e.markImmutable());
		return this;
	}

}	//	M_Window
