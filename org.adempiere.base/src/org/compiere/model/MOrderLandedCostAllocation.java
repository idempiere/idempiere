/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2012 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;

import org.compiere.util.Env;

/**
 * @author hengsin
 *
 */
public class MOrderLandedCostAllocation extends X_C_OrderLandedCostAllocation {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -3876186097908624583L;

	/**
	 * @param ctx
	 * @param C_OrderLandedCostAllocation_ID
	 * @param trxName
	 */
	public MOrderLandedCostAllocation(Properties ctx,
			int C_OrderLandedCostAllocation_ID, String trxName) {
		super(ctx, C_OrderLandedCostAllocation_ID, trxName);
	}

	/**
	 * @param ctx
	 * @param rs
	 * @param trxName
	 */
	public MOrderLandedCostAllocation(Properties ctx, ResultSet rs,
			String trxName) {
		super(ctx, rs, trxName);
	}
	
	/**
	 * 	Set Amt
	 *	@param Amt amount
	 *	@param precision precision
	 */
	public void setAmt (double Amt, int precision)
	{
		BigDecimal bd = BigDecimal.valueOf(Amt);
		if (bd.scale() > precision)
			bd = bd.setScale(precision, BigDecimal.ROUND_HALF_UP);
		super.setAmt(bd);
	}	//	setAmt
	
	/**
	 * 	Get Lines of allocation
	 * 	@param whereClause starting with AND
	 * 	@return lines
	 */
	public static MOrderLandedCostAllocation[] getOfOrderLine(int C_OrderLine_ID, String trxName)
	{
		StringBuilder whereClause = new StringBuilder(COLUMNNAME_C_OrderLine_ID).append("=?");
		List<MOrderLandedCostAllocation> list = new Query(Env.getCtx(), I_C_OrderLandedCostAllocation.Table_Name, whereClause.toString(), trxName)
										.setParameters(C_OrderLine_ID)
										.list();
		return list.toArray(new MOrderLandedCostAllocation[list.size()]);
	}	//	getLines
}
