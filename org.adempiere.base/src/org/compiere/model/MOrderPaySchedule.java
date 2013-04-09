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

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;

/**
 *	Order Payment Schedule Model 
 *	
 *  @author Jorg Janke
 *  @version $Id: MOrderPaySchedule.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MOrderPaySchedule extends X_C_OrderPaySchedule
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5506706349428999742L;

	/**
	 * 	Get Payment Schedule of the Order
	 * 	@param ctx context
	 * 	@param C_Order_ID order id (direct)
	 * 	@param C_OrderPaySchedule_ID id (indirect)
	 *	@param trxName transaction
	 *	@return array of schedule
	 */
	public static MOrderPaySchedule[] getOrderPaySchedule(Properties ctx, 
		int C_Order_ID, int C_OrderPaySchedule_ID, String trxName)
	{
		String sql = "SELECT * FROM C_OrderPaySchedule ips WHERE IsActive='Y' ";
		if (C_Order_ID != 0)
			sql += "AND C_Order_ID=? ";
		else
			sql += "AND EXISTS (SELECT * FROM C_OrderPaySchedule x"
			+ " WHERE x.C_OrderPaySchedule_ID=? AND ips.C_Order_ID=x.C_Order_ID) ";
		sql += "ORDER BY DueDate";
		//
		ArrayList<MOrderPaySchedule> list = new ArrayList<MOrderPaySchedule>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, trxName);
			if (C_Order_ID != 0)
				pstmt.setInt(1, C_Order_ID);
			else
				pstmt.setInt(1, C_OrderPaySchedule_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				list.add (new MOrderPaySchedule(ctx, rs, trxName));
			}
		}
		catch (Exception e)
		{
			s_log.log(Level.SEVERE, "getOrderPaySchedule", e); 
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		
		MOrderPaySchedule[] retValue = new MOrderPaySchedule[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getSchedule

	/** Static Logger					*/
	private static CLogger		s_log = CLogger.getCLogger (MOrderPaySchedule.class);

	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_OrderPaySchedule_ID id
	 *	@param trxName transaction
	 */
	public MOrderPaySchedule (Properties ctx, int C_OrderPaySchedule_ID, String trxName)
	{
		super(ctx, C_OrderPaySchedule_ID, trxName);
		if (C_OrderPaySchedule_ID == 0)
		{
		//	setC_Order_ID (0);
		//	setDiscountAmt (Env.ZERO);
		//	setDiscountDate (new Timestamp(System.currentTimeMillis()));
		//	setDueAmt (Env.ZERO);
		//	setDueDate (new Timestamp(System.currentTimeMillis()));
			setIsValid (false);
		}
	}	//	MOrderPaySchedule

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MOrderPaySchedule (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MOrderPaySchedule

	/**
	 * 	Parent Constructor
	 *	@param order order
	 *	@param paySchedule payment schedule
	 */
	public MOrderPaySchedule (MOrder order, MPaySchedule paySchedule)
	{
		super (order.getCtx(), 0, order.get_TrxName());
		m_parent = order;
		setClientOrg(order);
		setC_Order_ID(order.getC_Order_ID());
		setC_PaySchedule_ID(paySchedule.getC_PaySchedule_ID());
		
		//	Amounts
		int scale = MCurrency.getStdPrecision(getCtx(), order.getC_Currency_ID());
		BigDecimal due = order.getGrandTotal();
		if (due.compareTo(Env.ZERO) == 0)
		{
			setDueAmt (Env.ZERO);
			setDiscountAmt (Env.ZERO);
			setIsValid(false);
		}
		else
		{
			due = due.multiply(paySchedule.getPercentage())
				.divide(Env.ONEHUNDRED, scale, BigDecimal.ROUND_HALF_UP);
			setDueAmt (due);
			BigDecimal discount = due.multiply(paySchedule.getDiscount())
				.divide(Env.ONEHUNDRED, scale, BigDecimal.ROUND_HALF_UP);
			setDiscountAmt (discount);
			setIsValid(true);
		}
		
		//	Dates		
		Timestamp dueDate = TimeUtil.addDays(order.getDateOrdered(), paySchedule.getNetDays());
		setDueDate (dueDate);
		Timestamp discountDate = TimeUtil.addDays(order.getDateOrdered(), paySchedule.getDiscountDays());
		setDiscountDate (discountDate);
	}	//	MOrderPaySchedule
	
	/**	Parent						*/
	private MOrder	m_parent = null;

	
	/**
	 * @return Returns the parent.
	 */
	public MOrder getParent ()
	{
		if (m_parent == null)
			m_parent = new MOrder (getCtx(), getC_Order_ID(), get_TrxName()); 
		return m_parent;
	}	//	getParent
	
	/**
	 * @param parent The parent to set.
	 */
	public void setParent (MOrder parent)
	{
		m_parent = parent;
	}	//	setParent
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString()
	{
		StringBuilder sb = new StringBuilder("MOrderPaySchedule[");
		sb.append(get_ID()).append("-Due=" + getDueDate() + "/" + getDueAmt())
			.append(";Discount=").append(getDiscountDate() + "/" + getDiscountAmt())
			.append("]");
		return sb.toString();
	}	//	toString
	
	
	
	/**
	 * 	Before Save
	 *	@param newRecord new
	 *	@return true
	 */
	protected boolean beforeSave (boolean newRecord)
	{
		if (is_ValueChanged("DueAmt"))
		{
			log.fine("beforeSave");
			setIsValid(false);
		}
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
		if (is_ValueChanged("DueAmt"))
		{
			log.fine("afterSave");
			getParent();
			m_parent.validatePaySchedule();
			m_parent.saveEx();
		}
		return success;
	}	//	afterSave

	
}	//	MOrderPaySchedule
