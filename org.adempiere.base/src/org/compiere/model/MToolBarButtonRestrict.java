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

import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;


/**
 *  ToolBar and Button Restriction
 *  @author Nicolas Micoud
 */
public class MToolBarButtonRestrict extends X_AD_ToolBarButtonRestrict
{

	/** Cache for toolbar button restricted */
	private static CCache<String, Boolean>	cache_toolbarBtnRestriction		= new CCache<String, Boolean>("ToolbarButtonRestricted", 50);

	private static final String GET_OF_WINDOW_SQL = "SELECT AD_ToolBarButton_ID FROM AD_ToolBarButtonRestrict WHERE IsActive = 'Y'"
			+ " AND AD_Client_ID IN (0, ?)"
			+ " AND (AD_Role_ID IS NULL OR AD_Role_ID = ?)"	
			+ " AND (AD_Window_ID IS NULL OR (Action='W' AND AD_Window_ID=?))"
			+ " AND AD_Tab_ID IS NULL"
			+ " AND AD_ToolBarButton_ID IN" 
			+ " (SELECT AD_ToolBarButton_ID FROM AD_ToolBarButton WHERE AD_Tab_ID IS NULL AND IsActive='Y' AND Action=?)";
	
	private static final String GET_OF_REPORT_SQL = "SELECT AD_ToolBarButton_ID FROM AD_ToolBarButtonRestrict WHERE IsActive = 'Y'"
			+ " AND AD_Client_ID IN (0, ?)"
			+ " AND (AD_Role_ID IS NULL OR AD_Role_ID = ?)"	
			+ " AND (AD_Process_ID IS NULL OR (Action='R' AND AD_Process_ID=?))"
			+ " AND AD_ToolBarButton_ID IN" 
			+ " (SELECT AD_ToolBarButton_ID FROM AD_ToolBarButton WHERE AD_Tab_ID IS NULL AND IsActive='Y' AND Action=?)";

	private static final String GET_PROCESS_BUTTON_OF_TAB_SQL = "SELECT AD_ToolBarButton_ID FROM AD_ToolBarButtonRestrict WHERE IsActive = 'Y'"
			+ " AND AD_Client_ID IN (0, ?)"
			+ " AND (AD_Role_ID IS NULL OR AD_Role_ID = ?)"	
			+ " AND Action='W'"
			+ " AND AD_ToolBarButton_ID IN" 
			+ " (SELECT AD_ToolBarButton_ID FROM AD_ToolBarButton WHERE AD_Tab_ID=?" 
			+ " AND AD_Process_ID IS NOT NULL AND IsActive='Y' AND Action='W')";

	private static final String GET_OF_TAB_SQL = "SELECT AD_ToolBarButton_ID FROM AD_ToolBarButtonRestrict WHERE IsActive = 'Y'"
			+ " AND AD_Client_ID IN (0, ?)"
			+ " AND (AD_Role_ID IS NULL OR AD_Role_ID = ?)"	
			+ " AND AD_Window_ID=?"
			+ " AND AD_Tab_ID=?"
			+ " AND AD_ToolBarButton_ID IN" 
			+ " (SELECT AD_ToolBarButton_ID FROM AD_ToolBarButton WHERE AD_Process_ID IS NULL AND IsActive='Y')";

	// Toolbar button access restriction
	public static final String SQL_IS_TOOLBAR_BTN_EXCLUDED = "SELECT tbr.IsExclude FROM AD_ToolBarButton tb 														"
			+ " INNER JOIN AD_ToolBarButtonRestrict tbr ON 																											"
			+ "						  	( tbr.AD_ToolBarButton_ID=tb.AD_ToolBarButton_ID AND tbr.AD_Client_ID IN (0,?) AND tbr.IsActive='Y' AND 					"
			+ " 						  tbr.Action='W' AND (tbr.AD_Role_ID IS NULL OR tbr.AD_Role_ID=?) AND (tbr.AD_Window_ID IS NULL OR tbr.AD_Window_ID=?))		"
			+ " LEFT JOIN AD_Tab t ON 	( t.AD_Tab_ID=tbr.AD_Tab_ID AND t.IsActive='Y' AND t.AD_Window_ID=? AND ((t.TabLevel=0 AND 0=?) OR t.AD_Tab_ID=?))			"
			+ " WHERE tb.IsActive='Y' AND tb.Action='W' AND tb.AD_ToolBarButton_ID=? AND tb.AD_Tab_ID IS NULL AND (tbr.AD_Tab_ID IS NULL OR t.AD_Tab_ID IS NOT NULL)"
			+ " ORDER BY tbr.AD_Client_ID DESC, tbr.AD_Window_ID, tbr.AD_Tab_ID 																					";

	/**
	 * 
	 */
	private static final long serialVersionUID = 751989571891306735L;

	private static CLogger s_log = CLogger.getCLogger(MToolBarButtonRestrict.class);

	/**
	 * 	Standard Constructor
	 * 	@param ctx context
	 * 	@param AD_ToolBarButtonRestrict_ID id
	 *	@param trxName transaction
	 */
	public MToolBarButtonRestrict (Properties ctx, int AD_ToolBarButtonRestrict_ID, String trxName)
	{
		super (ctx, AD_ToolBarButtonRestrict_ID, trxName);
	}	//	MToolBarButtonRestrict

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MToolBarButtonRestrict(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MToolBarButtonRestrict

	/** 
	 * Returns a list of restrictions to be applied according to the role, the window of the form ...
	 * @param ctx
	 * @param AD_Role_ID
	 * @param AD_Window_ID
	 * @param reportViewer
	 * @param trxName
	 **/
	public static int[] getOfWindow(Properties ctx, int AD_Role_ID, int AD_Window_ID, boolean reportViewer, String trxName)
	{		
		if (s_log.isLoggable(Level.INFO)) s_log.info("sql="+GET_OF_WINDOW_SQL);
		
		int[] ids = DB.getIDsEx(trxName, GET_OF_WINDOW_SQL, Env.getAD_Client_ID(ctx), AD_Role_ID, AD_Window_ID, reportViewer ? "R" : "W");

		return ids;
	}	//	getOfWindow
	
	/** 
	 * Returns a list of restrictions to be applied according to the role, the tab of the window ...
	 * @param ctx
	 * @param AD_Role_ID
	 * @param AD_Window_ID
	 * @param AD_Tab_ID
	 * @param trxName
	 **/
	public static int[] getOfTab(Properties ctx, int AD_Role_ID, int AD_Window_ID, int AD_Tab_ID, String trxName)
	{		
		if (s_log.isLoggable(Level.INFO)) s_log.info("sql="+GET_OF_TAB_SQL);
		
		int[] ids = DB.getIDsEx(trxName, GET_OF_TAB_SQL, Env.getAD_Client_ID(ctx), AD_Role_ID, AD_Window_ID, AD_Tab_ID);

		return ids;
	}	//	getOfWindow
	
	/** 
	 * Returns a list of restrictions to be applied according to the role, the report/process ...
	 * @param ctx
	 * @param AD_Role_ID
	 * @param AD_Process_ID
	 * @param trxName
	 **/
	public static int[] getOfReport(Properties ctx, int AD_Role_ID, int AD_Process_ID, String trxName)
	{		
		if (s_log.isLoggable(Level.INFO)) s_log.info("sql="+GET_OF_REPORT_SQL);
		
		int[] ids = DB.getIDsEx(trxName, GET_OF_REPORT_SQL, Env.getAD_Client_ID(ctx), AD_Role_ID, AD_Process_ID, "R");

		return ids;
	}	//	getOf
	
	/** 
	 * Returns a list of restrictions to be applied according to the role for tab process toolbar buttons
	 * @param ctx
	 * @param AD_Role_ID
	 * @param AD_Tab_ID
	 * @param trxName 
	 **/
	public static int[] getProcessButtonOfTab(Properties ctx, int AD_Role_ID, int AD_Tab_ID, String trxName)
	{
		if (s_log.isLoggable(Level.INFO)) s_log.info("sql="+GET_PROCESS_BUTTON_OF_TAB_SQL);
		
		int[] ids = DB.getIDsEx(trxName, GET_PROCESS_BUTTON_OF_TAB_SQL, Env.getAD_Client_ID(ctx), AD_Role_ID, AD_Tab_ID);

		return ids;
	}	//	getOfTab
	
	/**
	 * 	String Representation
	 *	@return	info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder ("MToolBarButtonRestrict[")
			.append(get_ID()).append(",AD_ToolBarButtonRestrict_ID=").append(getAD_ToolBarButtonRestrict_ID())
			.append("]");
		return sb.toString();
	}	//	toString

	/**
	 * Check Window access for ReadWrite and New Toolbar button
	 * 
	 * @param  windowID - AD_Window_ID
	 * @return          True if Toolbar button is restricted
	 */
	public static boolean isNewButtonRestricted(int windowID)
	{
		return isNewButtonRestricted(windowID, 0);
	} // isNewButtonRestricted

	/**
	 * Check Window access for ReadWrite and New Toolbar button
	 * 
	 * @param  windowID - AD_Window_ID
	 * @param  tabID    - AD_Tab_ID
	 * @return          True if Toolbar button is restricted
	 */
	public static boolean isNewButtonRestricted(int windowID, int tabID)
	{
		boolean isReadWrite = MRole.getDefault().getWindowAccess(windowID);
		if (!isReadWrite)
			return true;

		return isToolbarButtonRestricted(windowID, tabID, SystemIDs.TOOLBAR_BTN_ID_WINDOW_NEW);
	} // isNewButtonRestricted

	/**
	 * Check toolbar button restriction
	 * 
	 * @param  windowID     - AD_Window_ID
	 * @param  tabID        - AD_Tab_ID
	 * @param  toolbarBtnID - Toolbar button ID
	 * @return              True if Toolbar button is restricted
	 */
	public static boolean isToolbarButtonRestricted(int windowID, int tabID, int toolbarBtnID)
	{
		int clientID = Env.getAD_Client_ID(Env.getCtx());
		int roleID = MRole.getDefault().getAD_Role_ID();

		String key = clientID + "_" + roleID + "_" + windowID + "_" + tabID + "_" + toolbarBtnID;
		if (cache_toolbarBtnRestriction.containsKey(key))
			return cache_toolbarBtnRestriction.get(key);

		String isExclude = DB.getSQLValueString(null, SQL_IS_TOOLBAR_BTN_EXCLUDED, clientID, roleID, windowID, windowID, tabID, tabID, toolbarBtnID);
		boolean isRestricted = isExclude != null && isExclude.equals("Y");
		cache_toolbarBtnRestriction.put(key, isRestricted);

		return isRestricted;
	} // isToolbarButtonRestricted

}	//	MToolBarButtonRestrict
