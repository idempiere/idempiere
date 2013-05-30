/******************************************************************************
 * Copyright (C) 2008 Elaine Tan                                              *
 * Copyright (C) 2008 Idalica Corporation                                     *
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
package org.adempiere.webui.dashboard;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;

import org.compiere.model.MRole;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * Dashboard item: Workflow activities, notices and requests
 * @author Elaine
 * @date November 20, 2008
 * 
 * Contributors:
 * CarlosRuiz - globalqss - Add unprocessed button to iDempiere
 * 
 * 
 * Contributors: 
 * Deepak Pansheriya - showing only notes message
 */
public class DPActivitiesModel {

	private static final CLogger logger = CLogger.getCLogger(DPActivitiesModel.class);
	
	public static boolean isShowUnprocessed() {
		return 	(Env.getAD_Client_ID(Env.getCtx()) > 0);
	}
	
	/**
	 * Get notice count
	 * @return number of notice
	 */
	public static int getNoticeCount()
	{
		String sql = "SELECT COUNT(1) FROM AD_Note "
			+ "WHERE AD_Client_ID=? AND AD_User_ID IN (0,?)"
			+ " AND Processed='N' AND AD_BroadcastMessage_ID IS NULL";

		int retValue = DB.getSQLValue(null, sql, Env.getAD_Client_ID(Env.getCtx()), Env.getAD_User_ID(Env.getCtx()));
		return retValue;
	}

	/**
	 * Get request count
	 * @return number of request
	 */
	public static int getRequestCount()
	{
		String sql = MRole.getDefault().addAccessSQL ("SELECT COUNT(1) FROM R_Request "
				+ "WHERE (SalesRep_ID=? OR AD_Role_ID=?) AND Processed='N'"
				+ " AND (DateNextAction IS NULL OR TRUNC(DateNextAction) <= TRUNC(SysDate))"
				+ " AND (R_Status_ID IS NULL OR R_Status_ID IN (SELECT R_Status_ID FROM R_Status WHERE IsClosed='N'))",
					"R_Request", false, true);	//	not qualified - RW
		int retValue = DB.getSQLValue(null, sql, Env.getAD_User_ID(Env.getCtx()), Env.getAD_Role_ID(Env.getCtx()));
		return retValue;
	}

	/**
	 * Get workflow activity count
	 * @return number of workflow activity
	 */
	public static int getWorkflowCount()
	{
		int count = 0;

		String sql = "SELECT count(*) FROM AD_WF_Activity a "
			+ "WHERE "
			+ "a.Processed='N' AND a.WFState='OS' AND ("
			//	Owner of Activity
			+ " a.AD_User_ID=?"	//	#1
			//	Invoker (if no invoker = all)
			+ " OR EXISTS (SELECT * FROM AD_WF_Responsible r WHERE a.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID"
			+ " AND r.ResponsibleType='H' AND COALESCE(r.AD_User_ID,0)=0 AND COALESCE(r.AD_Role_ID,0)=0 AND (a.AD_User_ID=? OR a.AD_User_ID IS NULL))"	//	#2
			//  Responsible User
			+ " OR EXISTS (SELECT * FROM AD_WF_Responsible r WHERE a.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID"
			+ " AND r.ResponsibleType='H' AND r.AD_User_ID=?)"		//	#3
			//	Responsible Role
			+ " OR EXISTS (SELECT * FROM AD_WF_Responsible r INNER JOIN AD_User_Roles ur ON (r.AD_Role_ID=ur.AD_Role_ID)"
			+ " WHERE a.AD_WF_Responsible_ID=r.AD_WF_Responsible_ID AND r.ResponsibleType='R' AND ur.AD_User_ID=?)"	//	#4
			//
			+ ") AND a.AD_Client_ID=?";	//	#5
		int AD_User_ID = Env.getAD_User_ID(Env.getCtx());
		int AD_Client_ID = Env.getAD_Client_ID(Env.getCtx());
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, null);
			pstmt.setInt (1, AD_User_ID);
			pstmt.setInt (2, AD_User_ID);
			pstmt.setInt (3, AD_User_ID);
			pstmt.setInt (4, AD_User_ID);
			pstmt.setInt (5, AD_Client_ID);
			rs = pstmt.executeQuery ();
			if (rs.next ()) {
				count = rs.getInt(1);
			}
		}
		catch (Exception e)
		{
			logger.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}

		return count;
	}

	/**
	 * Get unprocessed count
	 * @return number of unprocessed
	 */
	public static int getUnprocessedCount()
	{
		if (! isShowUnprocessed())
			return 0;
		
		String sql = "SELECT COUNT(1) FROM RV_Unprocessed "
			+ "WHERE AD_Client_ID=? AND CreatedBy=?";

		int retValue = DB.getSQLValue(null, sql, Env.getAD_Client_ID(Env.getCtx()), Env.getAD_User_ID(Env.getCtx()));
		return retValue;
	}
}
