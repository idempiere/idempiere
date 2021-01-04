/**********************************************************************
* This file is part of iDempiere ERP Open Source                      *
* http://www.idempiere.org                                            *
*                                                                     *
* Copyright (C) Contributors                                          *
*                                                                     *
* This program is free software; you can redistribute it and/or       *
* modify it under the terms of the GNU General Public License         *
* as published by the Free Software Foundation; either version 2      *
* of the License, or (at your option) any later version.              *
*                                                                     *
* This program is distributed in the hope that it will be useful,     *
* but WITHOUT ANY WARRANTY; without even the implied warranty of      *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
* GNU General Public License for more details.                        *
*                                                                     *
* You should have received a copy of the GNU General Public License   *
* along with this program; if not, write to the Free Software         *
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
* MA 02110-1301, USA.                                                 *
*                                                                     *
* Contributors:                                                       *
* - Igor Pojzl, Cloudempiere                                          *
**********************************************************************/
package org.compiere.model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;

/**
 * User overrides for Info Window Related Model
 * @author Igor Pojzl, Cloudempiere
 * @version $Id$
 */
public class MUserDefInfoRelated extends X_AD_UserDef_Info_Related {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2317004482077725245L;
	
	public MUserDefInfoRelated(Properties ctx, int AD_UserDef_Info_Related_ID, String trxName) {
		super(ctx, AD_UserDef_Info_Related_ID, trxName);
	}
	public MUserDefInfoRelated(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * Get matching MUserDefInfoRelated related to current Info Column and user definition for Info window
	 * @param ctx
	 * @param AD_InfoRelated_ID
	 * @param AD_InfoWindow_ID
	 * @return
	 */
	public static MUserDefInfoRelated get (Properties ctx, int AD_InfoRelated_ID, int AD_InfoWindow_ID )
	{

		MUserDefInfo userdefInfo = MUserDefInfo.getBestMatch(ctx, AD_InfoWindow_ID);
		if (userdefInfo == null)
			return null;
		
		MUserDefInfoRelated retValue = null;

		StringBuilder sql = new StringBuilder("SELECT * "
				+ " FROM AD_UserDef_Info_Related c " 
				+ " WHERE c.AD_InfoRelated_ID=? AND c.IsActive='Y' "
				+ " AND c.AD_UserDef_Info_ID=? ");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			//	create statement
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, AD_InfoRelated_ID);
			pstmt.setInt(2, userdefInfo.getAD_UserDef_Info_ID());
			// 	get data
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				retValue = new MUserDefInfoRelated(ctx,rs,null);
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
	}	//get
}
