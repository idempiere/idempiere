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

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;


/**
 *  ToolBar & Button Restriction
 *  @author Nicolas Micoud
 */
public class MToolBarButtonRestrict extends X_AD_ToolBarButtonRestrict
{
	private static final String GET_OF_WINDOW_SQL = "SELECT AD_ToolBarButton_ID FROM AD_ToolBarButtonRestrict WHERE IsActive = 'Y'"
			+ " AND AD_Client_ID IN (0, ?)"
			+ " AND (AD_Role_ID IS NULL OR AD_Role_ID = ?)"	
			+ " AND (AD_Window_ID IS NULL OR (Action='W' AND AD_Window_ID=?))"
			+ " AND AD_ToolBarButton_ID IN" 
			+ " (SELECT AD_ToolBarButton_ID FROM AD_ToolBarButton WHERE AD_Tab_ID IS NULL AND IsActive='Y' AND Action=?)";
	
	private static final String GET_OF_REPORT_SQL = "SELECT AD_ToolBarButton_ID FROM AD_ToolBarButtonRestrict WHERE IsActive = 'Y'"
			+ " AND AD_Client_ID IN (0, ?)"
			+ " AND (AD_Role_ID IS NULL OR AD_Role_ID = ?)"	
			+ " AND (AD_Process_ID IS NULL OR (Action='R' AND AD_Process_ID=?))"
			+ " AND AD_ToolBarButton_ID IN" 
			+ " (SELECT AD_ToolBarButton_ID FROM AD_ToolBarButton WHERE AD_Tab_ID IS NULL AND IsActive='Y' AND Action=?)";

	private static final String GET_OF_TAB_SQL = "SELECT AD_ToolBarButton_ID FROM AD_ToolBarButtonRestrict WHERE IsActive = 'Y'"
			+ " AND AD_Client_ID IN (0, ?)"
			+ " AND (AD_Role_ID IS NULL OR AD_Role_ID = ?)"	
			+ " AND Action='W'"
			+ " AND AD_ToolBarButton_ID IN" 
			+ " (SELECT AD_ToolBarButton_ID FROM AD_ToolBarButton WHERE AD_Tab_ID=?" 
			+ " AND AD_Process_ID IS NOT NULL AND IsActive='Y' AND Action='W')";

	/**
	 * 
	 */
	private static final long serialVersionUID = 751989571891306735L;

	private static CLogger s_log = CLogger.getCLogger(MToolBarButtonRestrict.class);

	/**
	 * 	Standard Constructor
	 * 	@param ctx context
	 * 	@param AD_Note_ID id
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
		if (s_log.isLoggable(Level.INFO))
			s_log.info("sql="+GET_OF_WINDOW_SQL);
		
		int[] ids = DB.getIDsEx(trxName, GET_OF_WINDOW_SQL, Env.getAD_Client_ID(ctx), AD_Role_ID, AD_Window_ID, reportViewer ? "R" : "W");

		return ids;
	}	//	getOfWindow
	
	/** 
	 * Returns a list of restrictions to be applied according to the role, the window of the form ...
	 * @param ctx
	 * @param AD_Role_ID
	 * @param AD_Window_ID
	 * @param trxName
	 **/
	public static int[] getOfReport(Properties ctx, int AD_Role_ID, int AD_Process_ID, String trxName)
	{		
		if (s_log.isLoggable(Level.INFO))
			s_log.info("sql="+GET_OF_REPORT_SQL);
		
		int[] ids = DB.getIDsEx(trxName, GET_OF_REPORT_SQL, Env.getAD_Client_ID(ctx), AD_Role_ID, AD_Process_ID, "R");

		return ids;
	}	//	getOf
	
	/** Returns a list of restrictions to be applied according to the role for ad_tab toolbar buttons **/
	public static int[] getOfTab(Properties ctx, int AD_Role_ID, int AD_Tab_ID, String trxName)
	{
		if (s_log.isLoggable(Level.INFO))
			s_log.info("sql="+GET_OF_TAB_SQL);
		
		int[] ids = DB.getIDsEx(trxName, GET_OF_TAB_SQL, Env.getAD_Client_ID(ctx), AD_Role_ID, AD_Tab_ID);

		return ids;
	}	//	getOfTab
	
	/**
	 * 	String Representation
	 *	@return	info
	 */
	public String toString()
	{
		StringBuffer sb = new StringBuffer ("MToolBarButtonRestrict[")
			.append(get_ID()).append(",AD_ToolBarButtonRestrict_ID=").append(getAD_ToolBarButtonRestrict_ID())
			.append("]");
		return sb.toString();
	}	//	toString

}	//	MToolBarButtonRestrict
