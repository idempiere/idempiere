/******************************************************************************
 * Copyright (C) 2019 devCoffee - #3858                                       *
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

/**
 * Model class for Process Parameter Customizations
 *
 * @author raphael.gildo (devCoffee, www.devcoffee.com.br)
 *
 */
public class MUserDefProcParameter extends X_AD_UserDef_Proc_Parameter {

	/**
	 *
	 */
	private static final long serialVersionUID = -203142278687451678L;

	/**
	 * @param ctx
	 * @param AD_UserDef_Proc_Parameter_ID
	 * @param trxName
	 */
	public MUserDefProcParameter(Properties ctx, int AD_UserDef_Proc_Parameter_ID, String trxName) {
		super(ctx, AD_UserDef_Proc_Parameter_ID, trxName);
		// TODO Auto-generated constructor stub
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MUserDefProcParameter(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
		// TODO Auto-generated constructor stub
	}

	public static MUserDefProcParameter get (Properties ctx, int AD_Field_ID, int AD_Process_ID)
	{

		MUserDefProc userdefProc = MUserDefProc.getBestMatch(ctx, AD_Process_ID);
		if (userdefProc == null)
			return null;

		MUserDefProcParameter retValue = null;

		StringBuilder sql = new StringBuilder("SELECT * "
				+ " FROM AD_UserDef_Proc_Parameter f "
				+ " WHERE f.AD_Process_Para_ID=? AND f.IsActive='Y' "
				+ " AND f.AD_UserDef_Proc_ID=? ");

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			//	create statement
			pstmt = DB.prepareStatement(sql.toString(), null);
			pstmt.setInt(1, AD_Field_ID);
			pstmt.setInt(2, userdefProc.getAD_UserDef_Proc_ID());
			// 	get data
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				retValue = new MUserDefProcParameter(ctx, rs, null);
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
	}

}
