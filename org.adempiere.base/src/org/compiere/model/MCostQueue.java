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
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;

import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 * 	Cost Queue Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MCostQueue.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MCostQueue extends X_M_CostQueue
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -1782836708418500130L;


	/**
	 * 	Get/Create Cost Queue Record.
	 * 	CostingLevel is not validated
	 *	@param product product
	 *	@param M_AttributeSetInstance_ID real asi
	 *	@param as accounting schema
	 *	@param AD_Org_ID real org
	 *	@param M_CostElement_ID element
	 *	@param trxName transaction
	 *	@return cost queue or null
	 */
	public static MCostQueue get (MProduct product, int M_AttributeSetInstance_ID,
		MAcctSchema as, int AD_Org_ID, int M_CostElement_ID, String trxName)
	{
		MCostQueue costQ = null;
		String sql = "SELECT * FROM M_CostQueue "
			+ "WHERE AD_Client_ID=? AND AD_Org_ID=?"
			+ " AND M_Product_ID=?"
			+ " AND M_AttributeSetInstance_ID=?"
			+ " AND M_CostType_ID=? AND C_AcctSchema_ID=?"
			+ " AND M_CostElement_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, product.getAD_Client_ID());
			pstmt.setInt (2, AD_Org_ID);
			pstmt.setInt (3, product.getM_Product_ID());
			pstmt.setInt (4, M_AttributeSetInstance_ID);
			pstmt.setInt (5, as.getM_CostType_ID());
			pstmt.setInt (6, as.getC_AcctSchema_ID());
			pstmt.setInt (7, M_CostElement_ID);
			rs = pstmt.executeQuery ();
			if (rs.next ())
				costQ = new MCostQueue (product.getCtx(), rs, trxName); 
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		//	New
		if (costQ == null)
			costQ = new MCostQueue (product, M_AttributeSetInstance_ID,
				as, AD_Org_ID, M_CostElement_ID, trxName);
		return costQ;
	}	//	get

	/**
	 * 	Get Cost Queue Records in Lifo/Fifo order
	 *	@param product product
	 *	@param M_ASI_ID costing level ASI
	 *	@param as accounting schema
	 *	@param Org_ID costing level org
	 *	@param ce Cost Element
	 *	@param trxName transaction
	 *	@return cost queue or null
	 */
	public static MCostQueue[] getQueue (MProduct product, int M_ASI_ID,
		MAcctSchema as, int Org_ID, MCostElement ce, String trxName)
	{
		ArrayList<MCostQueue> list = new ArrayList<MCostQueue>();
		StringBuilder sql = new StringBuilder("SELECT * FROM M_CostQueue ")
			.append("WHERE AD_Client_ID=? AND AD_Org_ID=?")
			.append(" AND M_Product_ID=?")
			.append(" AND M_CostType_ID=? AND C_AcctSchema_ID=?")
			.append(" AND M_CostElement_ID=?");
		if (M_ASI_ID != 0)
			sql.append(" AND M_AttributeSetInstance_ID=?");
		sql.append(" AND CurrentQty<>0 ")
			.append("ORDER BY M_AttributeSetInstance_ID ");
		if (!ce.isFifo())
			sql.append("DESC");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql.toString(), trxName);
			pstmt.setInt (1, product.getAD_Client_ID());
			pstmt.setInt (2, Org_ID);
			pstmt.setInt (3, product.getM_Product_ID());
			pstmt.setInt (4, as.getM_CostType_ID());
			pstmt.setInt (5, as.getC_AcctSchema_ID());
			pstmt.setInt (6, ce.getM_CostElement_ID());
			if (M_ASI_ID != 0)
				pstmt.setInt (7, M_ASI_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add(new MCostQueue (product.getCtx(), rs, trxName)); 
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		MCostQueue[] costQ = new MCostQueue[list.size()];
		list.toArray(costQ);
		return costQ;
	}	//	getQueue

	
	/**
	 * 	Adjust Qty based on in Lifo/Fifo order
	 *	@param product product
	 *	@param M_ASI_ID costing level ASI
	 *	@param as accounting schema
	 *	@param Org_ID costing level org
	 *	@param ce Cost Element
	 *	@param Qty quantity to be reduced
	 *	@param trxName transaction
	 *	@return cost price reduced or null of error
	 */
	public static BigDecimal adjustQty (MProduct product, int M_ASI_ID,
		MAcctSchema as, int Org_ID, MCostElement ce, BigDecimal Qty, 
		String trxName)
	{
		if (Qty.signum() == 0)
			return Env.ZERO;
		MCostQueue[] costQ = getQueue(product, M_ASI_ID, 
			as, Org_ID, ce, trxName);
		BigDecimal remainingQty = Qty;
		for (int i = 0; i < costQ.length; i++)
		{
			MCostQueue queue = costQ[i];
			//	Negative Qty i.e. add
			if (remainingQty.signum() < 0)
			{
				BigDecimal oldQty = queue.getCurrentQty();
				BigDecimal newQty = oldQty.subtract(remainingQty);
				queue.setCurrentQty(newQty);
				if (queue.save())
				{
					if (s_log.isLoggable(Level.FINE)) s_log.fine("Qty=" + remainingQty 
						+ "(!), ASI=" + queue.getM_AttributeSetInstance_ID()
						+ " - " + oldQty + " -> " + newQty);
					return queue.getCurrentCostPrice();
				}
				else
					return null;
			}
			
			//	Positive queue
			if (queue.getCurrentQty().signum() > 0)
			{
				BigDecimal reduction = remainingQty;
				if (reduction.compareTo(queue.getCurrentQty()) > 0)
					reduction = queue.getCurrentQty();
				BigDecimal oldQty = queue.getCurrentQty();
				BigDecimal newQty = oldQty.subtract(reduction);
				queue.setCurrentQty(newQty);
				if (queue.save())
				{
					if (s_log.isLoggable(Level.FINE)) s_log.fine("Qty=" + reduction 
						+ ", ASI=" + queue.getM_AttributeSetInstance_ID()
						+ " - " + oldQty + " -> " + newQty);
					remainingQty = remainingQty.subtract(reduction);
				}
				else
					return null;
				//
				if (remainingQty.signum() == 0)
				{
					return queue.getCurrentCostPrice();
				}
			}
		}	//	for queue	

		if (s_log.isLoggable(Level.FINE)) s_log.fine("RemainingQty=" + remainingQty);
		return null;
	}	//	adjustQty

	/**
	 * 	Calculate Cost based on Qty based on in Lifo/Fifo order
	 *	@param product product
	 *	@param M_ASI_ID costing level ASI
	 *	@param as accounting schema
	 *	@param Org_ID costing level org
	 *	@param ce Cost Element
	 *	@param Qty quantity to be reduced
	 *	@param trxName transaction
	 *	@return cost for qty or null of error
	 */
	public static BigDecimal getCosts (MProduct product, int M_ASI_ID,
		MAcctSchema as, int Org_ID, MCostElement ce, BigDecimal Qty, 
		String trxName)
	{
		if (Qty.signum() == 0)
			return Env.ZERO;
		MCostQueue[] costQ = getQueue(product, M_ASI_ID, 
			as, Org_ID, ce, trxName);
		//
		BigDecimal cost = Env.ZERO;
		BigDecimal remainingQty = Qty;
		BigDecimal firstPrice = null;
		BigDecimal lastPrice = null;
		//
		for (int i = 0; i < costQ.length; i++)
		{
			MCostQueue queue = costQ[i];
			//	Negative Qty i.e. add
			if (remainingQty.signum() <= 0)
			{
				@SuppressWarnings("unused")
				BigDecimal oldQty = queue.getCurrentQty();
				lastPrice = queue.getCurrentCostPrice();
				BigDecimal costBatch = lastPrice.multiply(remainingQty);
				cost = cost.add(costBatch);
				if (s_log.isLoggable(Level.CONFIG)) s_log.config("ASI=" + queue.getM_AttributeSetInstance_ID()
					+ " - Cost=" + lastPrice + " * Qty=" + remainingQty + "(!) = " + costBatch);
				return cost;
			}
			
			//	Positive queue
			if (queue.getCurrentQty().signum() > 0)
			{
				BigDecimal reduction = remainingQty;
				if (reduction.compareTo(queue.getCurrentQty()) > 0)
					reduction = queue.getCurrentQty();
				@SuppressWarnings("unused")
				BigDecimal oldQty = queue.getCurrentQty();
				lastPrice = queue.getCurrentCostPrice();
				BigDecimal costBatch = lastPrice.multiply(reduction);
				cost = cost.add(costBatch);
				if (s_log.isLoggable(Level.FINE)) s_log.fine("ASI=" + queue.getM_AttributeSetInstance_ID()
					+ " - Cost=" + lastPrice + " * Qty=" + reduction + " = " + costBatch);
				remainingQty = remainingQty.subtract(reduction);
				//	Done
				if (remainingQty.signum() == 0)
				{
					if (s_log.isLoggable(Level.CONFIG)) s_log.config("Cost=" + cost);
					return cost;
				}
				if (firstPrice == null)
					firstPrice = lastPrice;
			}
		}	//	for queue

		if (lastPrice == null)
		{
			lastPrice = MCost.getSeedCosts(product, M_ASI_ID, as, Org_ID, 
				ce.getCostingMethod(), 0);
			if (lastPrice == null)
			{
				s_log.info("No Price found");
				return null;
			}
			s_log.info("No Cost Queue");
		}
		BigDecimal costBatch = lastPrice.multiply(remainingQty);
		s_log.fine("RemainingQty=" + remainingQty + " * LastPrice=" + lastPrice + " = " + costBatch);
		cost = cost.add(costBatch);
		if (s_log.isLoggable(Level.CONFIG)) s_log.config("Cost=" + cost);
		return cost;
	}	//	getCosts
	
	/**	Logger	*/
	private static CLogger 	s_log = CLogger.getCLogger (MCostQueue.class);
	
	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param ignored multi-key
	 *	@param trxName trx
	 */
	public MCostQueue (Properties ctx, int ignored, String trxName)
	{
		super (ctx, ignored, trxName);
		if (ignored == 0)
		{
			setCurrentCostPrice (Env.ZERO);
			setCurrentQty (Env.ZERO);
		}
		else
			throw new IllegalArgumentException("Multi-Key");
	}	//	MCostQueue

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MCostQueue (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MCostQueue

	/**
	 * 	Parent Constructor
	 *	@param product Product
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param as Acct Schema
	 *	@param AD_Org_ID org
	 *	@param M_CostElement_ID cost element
	 *	@param trxName transaction
	 */
	public MCostQueue (MProduct product, int M_AttributeSetInstance_ID, 
		MAcctSchema as, int AD_Org_ID, int M_CostElement_ID, String trxName)
	{
		this (product.getCtx(), 0, trxName);
		setClientOrg(product.getAD_Client_ID(), AD_Org_ID);
		setC_AcctSchema_ID(as.getC_AcctSchema_ID());
		setM_CostType_ID(as.getM_CostType_ID());
		setM_Product_ID(product.getM_Product_ID());
		setM_AttributeSetInstance_ID(M_AttributeSetInstance_ID);
		setM_CostElement_ID(M_CostElement_ID);
	}	//	MCostQueue

	/**
	 * 	Update Record.
	 * 	((OldAvg*OldQty)+(Price*Qty)) / (OldQty+Qty)
	 *	@param amt total Amount
	 *	@param qty quantity
	 *	@param precision costing precision
	 */
	public void setCosts (BigDecimal amt, BigDecimal qty, int precision)
	{
		BigDecimal oldSum = getCurrentCostPrice().multiply(getCurrentQty());
		BigDecimal newSum = amt;	//	is total already
		BigDecimal sumAmt = oldSum.add(newSum);
		BigDecimal sumQty = getCurrentQty().add(qty);
		if (sumQty.signum() != 0)
		{
			BigDecimal cost = sumAmt.divide(sumQty, precision, RoundingMode.HALF_UP);
			setCurrentCostPrice(cost);
		}
		//
		setCurrentQty(getCurrentQty().add(qty));
	}	//	update
	
}	//	MCostQueue
