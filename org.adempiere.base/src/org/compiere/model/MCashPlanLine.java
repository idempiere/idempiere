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

import org.compiere.util.CLogger;
import org.compiere.util.DB;

/**
 *	Cash Plan model
 *
 *  @author Carlos Ruiz - GlobalQSS
 */
public class MCashPlanLine extends X_C_CashPlanLine
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 3897658515979106674L;

	/**	Logger			*/
	@SuppressWarnings("unused")
	private static CLogger s_log = CLogger.getCLogger(MCashPlanLine.class);

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_CashPlanLine_ID id
	 *	@param trxName transaction
	 */
	public MCashPlanLine (Properties ctx, int C_CashPlanLine_ID, String trxName)
	{
	      super (ctx, C_CashPlanLine_ID, trxName);
	      /** if (C_CashPlanLine_ID == 0)
	        {
				setC_CashPlan_ID (0);
				setC_CashPlanLine_ID (0);
				setDateTrx (new Timestamp(System.currentTimeMillis()));
				setLine (0);
	// @SQL=SELECT NVL(MAX(Line),0)+10 AS DefaultValue FROM C_CashPlanLine WHERE C_CashPlanLine_ID=@C_CashPlanLine_ID@
				setProcessed (false);
				setQtyEntered (Env.ZERO);
	// 1
	        } */
	}	//	MCashPlanLine

	/**
	 * 	Load Constructor
	 *	@param ctx ctx
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MCashPlanLine (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MCashPlanLine

	/**************************************************************************
	 * 	Before Save
	 *	@param newRecord
	 *	@return true if it can be sabed
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		//	Charge
		if (getC_Charge_ID() != 0 && getM_Product_ID() != 0)
			setM_Product_ID(0);
		
		//	Get Line No
		if (getLine() == 0)
		{
			String sql = "SELECT COALESCE(MAX(Line),0)+10 FROM C_CashPlanLine WHERE C_CashPlan_ID=?";
			int ii = DB.getSQLValue (get_TrxName(), sql, getC_CashPlan_ID());
			setLine (ii);
		}
		
		return true;
	}	//	beforeSave

	/**
	 * 	After Save
	 *	@param newRecord new
	 *	@param success success
	 *	@return saved
	 */
	protected boolean afterSave (boolean newRecord, boolean success)
	{
		if (!success)
			return success;
		return updateHeader();
	}	//	afterSave

	/**
	 *	Update Header
	 *	@return true if header updated
	 */
	private boolean updateHeader()
	{
		//	Update Cash Plan Header
		StringBuilder sql = new StringBuilder("UPDATE C_CashPlan ")
			.append(" SET GrandTotal=")
				.append("(SELECT COALESCE(SUM(LineTotalAmt),0) FROM C_CashPlanLine WHERE C_CashPlan.C_CashPlan_ID=C_CashPlanLine.C_CashPlan_ID) ")
			.append("WHERE C_CashPlan_ID=").append(getC_CashPlan_ID());
		int no = DB.executeUpdate(sql.toString(), get_TrxName());
		if (no != 1)
			log.warning("(1) #" + no);

		return no == 1;
	}	//	updateHeaderTax
	
}	//	MCashPlanLine
