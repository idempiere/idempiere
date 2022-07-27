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
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.cache.ImmutableIntPOCache;
import org.idempiere.cache.ImmutablePOSupport;

/**
 *	Menu Model
 *	
 *  @author Jorg Janke
 *  @author victor.perez@e-evolution.com
 *  see FR [ 1966326 ] Is necessary create method to get ID menu use menu Name https://sourceforge.net/p/adempiere/feature-requests/426/
 *  @author red1 - FR: [ 2214883 ] Remove SQL code and Replace for Query
 *  @version $Id: MMenu.java,v 1.3 2006/07/30 00:58:18 jjanke Exp $
 */
public class MMenu extends X_AD_Menu implements ImmutablePOSupport
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8157805998814206274L;
	/** Cache */
	private static ImmutableIntPOCache<Integer, MMenu>	s_cache				= new ImmutableIntPOCache<Integer, MMenu>(Table_Name, 50);

	/**
	 * Get Menu method from cache
	 * 
	 * @param AD_Menu_ID menu id
	 */
	public static MMenu get(int AD_Menu_ID)
	{
		return get(Env.getCtx(), AD_Menu_ID);
	}

	/**
	 * Get Menu method from cache
	 * 
	 * @param ctx
	 * @param AD_Menu_ID menu id
	 */
	public static MMenu get(Properties ctx, int AD_Menu_ID)
	{
		if (s_cache.containsKey(AD_Menu_ID))
			return s_cache.get(ctx, AD_Menu_ID, e -> new MMenu(Env.getCtx(), e));

		MMenu menu = new MMenu(Env.getCtx(), AD_Menu_ID, (String)null);
		if (menu.get_ID() == AD_Menu_ID)
		{
			s_cache.put(AD_Menu_ID, menu, e -> new MMenu(Env.getCtx(), e));
			return menu;
		}
		return null;
	}

	/**
	 * @param ctx
	 * @param copy
	 */
	public MMenu(Properties ctx, MMenu copy)
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MMenu(Properties ctx, MMenu copy, String trxName)
	{
		this(ctx, 0, trxName);
		copyPO(copy);
	}

	/**
	 * Get menues with where clause
	 * @param ctx context
	 * @param whereClause where clause w/o the actual WHERE
	 * @return MMenu
	 * @deprecated
	 */
	public static MMenu[] get (Properties ctx, String whereClause)
	{
		return get(ctx, whereClause, null);
	}
	
	/**
	 * Get menues with where clause
	 * @param ctx context
	 * @param whereClause where clause w/o the actual WHERE
	 * @param trxName transaction
	 * @return MMenu
	 */
	public static MMenu[] get (Properties ctx, final String whereClause, String trxName)
	{
		List<MMenu> list = new Query(ctx,I_AD_Menu.Table_Name,whereClause,trxName)
		.list();

		MMenu[] retValue = new MMenu[list.size()];
		list.toArray (retValue);
		return retValue;
	}	//	get
	
	/**	Static Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MMenu.class);
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_Menu_ID id
	 *	@param trxName transaction
	 */
	public MMenu (Properties ctx, int AD_Menu_ID, String trxName)
	{
		super (ctx, AD_Menu_ID, trxName);
		if (AD_Menu_ID == 0)
		{
			setEntityType (ENTITYTYPE_UserMaintained);	// U
			setIsReadOnly (false);	// N
			setIsSOTrx (false);
			setIsSummary (false);
		}
	}	//	MMenu

	/**
	 * 	Load Contrusctor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MMenu (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MMenu

	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		//	Reset info
		if (isSummary() && getAction() != null)
			setAction(null);
		if (isSummary() && isCentrallyMaintained())
			setIsCentrallyMaintained(false);
		String action = getAction();
		if (action == null)
			action = "";
		//	Clean up references
		if (getAD_Window_ID() != 0 && !action.equals(ACTION_Window))
			setAD_Window_ID(0);
		if (getAD_Form_ID() != 0 && !action.equals(ACTION_Form))
			setAD_Form_ID(0);
		if (getAD_Workflow_ID() != 0 && !action.equals(ACTION_WorkFlow))
			setAD_Workflow_ID(0);
		if (getAD_Task_ID() != 0 && !action.equals(ACTION_Task))
			setAD_Task_ID(0);
		if (getAD_Process_ID() != 0 
			&& !(action.equals(ACTION_Process) || action.equals(ACTION_Report)))
			setAD_Process_ID(0);
		if (getAD_InfoWindow_ID() != 0 && !action.equals(ACTION_Info))
			setAD_InfoWindow_ID(0);
		return true;
	}	//	beforeSave
	
	
	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return success
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		if (newRecord)
			insert_Tree(MTree_Base.TREETYPE_Menu);
		return success;
	}	//	afterSave

	/**
	 * 	After Delete
	 *	@param success
	 *	@return deleted
	 */
	protected boolean afterDelete (boolean success)
	{
		if (success)
			delete_Tree(MTree_Base.TREETYPE_Menu);
		return success;
	}	//	afterDelete
	
	/**
	 *  FR [ 1966326 ]
	 * 	get Menu ID
	 *	@param menuName String Menu Name
	 *	@return int retValue
	 */
	public static int getMenu_ID(String menuName) {
		int retValue = 0;
		String SQL = "SELECT AD_Menu_ID FROM AD_Menu WHERE Name = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(SQL, null);
			pstmt.setString(1, menuName);
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
	public PO markImmutable() {
		if(is_Immutable())
			return this;
		
		makeImmutable();
		return this;
	}

	/** Returns the name using UserDef module ; if nothing is defined, fallback to the translated name */
	public String getDisplayedName() {

		if (!Util.isEmpty(getAction())) {
			if (ACTION_Window.equals(getAction())) {
				MUserDefWin userDef = MUserDefWin.getBestMatch(getCtx(), getAD_Window_ID());
				if (userDef != null) {
					if (userDef.getName() != null)
						return userDef.getName();
				}
			}
			else if (ACTION_Process.equals(getAction()) || ACTION_Report.equals(getAction())) {
				MUserDefProc userDef = MUserDefProc.getBestMatch(getCtx(), getAD_Process_ID());
				if (userDef != null) {
					if (userDef.getName() != null)
						return userDef.getName();
				}
			}
			else if (ACTION_Info.equals(getAction())) {
				MUserDefInfo userDef = MUserDefInfo.getBestMatch(getCtx(), getAD_InfoWindow_ID());
				if (userDef != null) {
					if (userDef.getName() != null)
						return userDef.getName();
				}
			}
		}

		return get_Translation(MMenu.COLUMNNAME_Name);
	}

}	//	MMenu
