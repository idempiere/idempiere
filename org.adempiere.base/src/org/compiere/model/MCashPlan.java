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
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;

/**
 *	Cash Plan model
 *
 *  @author Carlos Ruiz - GlobalQSS
 */
public class MCashPlan extends X_C_CashPlan
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3068952163785661012L;

	/**	Logger			*/
	private static CLogger s_log = CLogger.getCLogger(MCashPlan.class);

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_CashPlan_ID id
	 *	@param trxName transaction
	 */
	public MCashPlan (Properties ctx, int C_CashPlan_ID, String trxName)
	{
	      super (ctx, C_CashPlan_ID, trxName);
	      /** if (C_CashPlan_ID == 0)
	        {
				setC_Activity_ID (0);
				setC_CashPlan_ID (0);
				setC_Project_ID (0);
				setDateDoc (new Timestamp(System.currentTimeMillis()));
	// @#Date@
				setDocumentNo (null);
				setGrandTotal (Env.ZERO);
				setIsApproved (false);
	// @IsApproved@
				setIsSOTrx (false);
				setProcessed (false);
	        } */
	}	//	MCashPlan

	/**
	 * 	Load Constructor
	 *	@param ctx ctx
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MCashPlan (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MCashPlan

	/**
	 * 	Before Delete
	 *	@return true
	 */
	protected boolean beforeDelete ()
	{
		/*
		// delete the lines using model classes
		boolean success = true;
		for (MCashPlanLine cpl : getLines()) {
			success = cpl.delete(true, get_TrxName());
			if (! success)
				break;
		}
		return success;
		*/
		// delete the lines using direct SQL (to avoid logging and updating of header on every step) - same as cascade foreign key
		int nodel = DB.executeUpdate("DELETE FROM C_CashPlanLine WHERE C_CashPlan_ID=?", getC_CashPlan_ID(), get_TrxName());
		return (nodel >= 0);
	}	//	beforeDelete

	/**
	 * 	Get Cash Plan Lines of Cash Plan
	 * 	@return lines
	 */
	public MCashPlanLine[] getLines ()
	{
		ArrayList<MCashPlanLine> list = new ArrayList<MCashPlanLine>();
		String sql = "SELECT * FROM C_CashPlanLine WHERE C_CashPlan_ID=? ORDER BY Line";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, get_TrxName());
			pstmt.setInt(1, getC_CashPlan_ID());
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				MCashPlanLine il = new MCashPlanLine(getCtx(), rs, get_TrxName());
				list.add(il);
			}
			rs.close();
			pstmt.close();
			pstmt = null;
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "getLines", e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		//
		MCashPlanLine[] lines = new MCashPlanLine[list.size()];
		list.toArray(lines);
		return lines;
	}	//	getLines

}	//	MCashPlan
