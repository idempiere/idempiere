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
	private static final long serialVersionUID = -422120961441035731L;
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

	/** Renvoie une liste des restrictions à appliquer en fonction du rôle, de la fenêtre, du formulaire, ...	**/
	public static ArrayList<Integer> getOf (Properties ctx, int AD_Role_ID, String Action, int Action_ID, String trxName)
	{
		// Action : R-Report, W-Window, X-form
		ArrayList<Integer> list = new ArrayList<Integer>();

		String sql = "SELECT AD_ToolBarButton_ID FROM AD_ToolBarButtonRestrict WHERE IsActive = 'Y'"
				+ " AND AD_Client_ID IN (0, " + Env.getAD_Client_ID(ctx) + ")"
				+ " AND (AD_Role_ID IS NULL OR AD_Role_ID = " + AD_Role_ID + ")"		
				+ " AND (Action IS NULL "
				+ " OR Action='" + Action + "' AND (AD_Window_ID IS NULL OR AD_Window_ID = " + Action_ID + "))";
		s_log.warning("sql="+sql);

		PreparedStatement pstmt = DB.prepareStatement(sql, trxName);
		ResultSet rs;
		try {
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				if (!list.contains(rs.getInt(1)))
					list.add (rs.getInt(1));
			}
		} catch (SQLException e) { 
			s_log.log(Level.SEVERE, sql, e);
		}

		return list;
	}	//	getOf
	
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
