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
import org.compiere.util.Util;


/**
 *	Inventory Material Allocation
 *	
 *  @author Jorg Janke
 *  @version $Id: MInventoryLineMA.java,v 1.3 2006/07/30 00:51:04 jjanke Exp $
 */
public class MInventoryLineMA extends X_M_InventoryLineMA
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 811710371747854597L;


	/**
	 * 	Get Material Allocations for Line
	 *	@param ctx context
	 *	@param M_InventoryLine_ID line
	 *	@param trxName trx
	 *	@return allocations
	 */
	public static MInventoryLineMA[] get (Properties ctx, int M_InventoryLine_ID, String trxName)
	{
		ArrayList<MInventoryLineMA> list = new ArrayList<MInventoryLineMA>();
		String sql = "SELECT * FROM M_InventoryLineMA WHERE M_InventoryLine_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, trxName);
			pstmt.setInt (1, M_InventoryLine_ID);
			rs = pstmt.executeQuery ();
			while (rs.next ())
				list.add (new MInventoryLineMA (ctx, rs, trxName));
		}
		catch (Exception e)
		{
			s_log.log (Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
		
		MInventoryLineMA[] retValue = new MInventoryLineMA[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	get
	
	/**
	 * 	Delete all Material Allocation for Inventory
	 *	@param M_Inventory_ID inventory
	 *	@param trxName transaction
	 *	@return number of rows deleted or -1 for error
	 */
	public static int deleteInventoryMA (int M_Inventory_ID, String trxName)
	{
		StringBuilder sql = new StringBuilder("DELETE FROM M_InventoryLineMA ma WHERE EXISTS ")
			.append("(SELECT * FROM M_InventoryLine l WHERE l.M_InventoryLine_ID=ma.M_InventoryLine_ID")
			.append(" AND M_Inventory_ID=").append(M_Inventory_ID).append(")");
		return DB.executeUpdate(sql.toString(), trxName);
	}	//	deleteInventoryMA

	/**
	 * 	Delete all Material Allocation for Inventory
	 *	@param M_InventoryLine_ID inventory
	 *	@param trxName transaction
	 *	@return number of rows deleted or -1 for error
	 */
	public static int deleteInventoryLineMA (int M_InventoryLine_ID, String trxName)
	{
		StringBuilder sql = new StringBuilder("DELETE FROM M_InventoryLineMA ma WHERE EXISTS ")
			.append("(SELECT * FROM M_InventoryLine l WHERE l.M_InventoryLine_ID=ma.M_InventoryLine_ID")
			.append(" AND M_InventoryLine_ID=").append(M_InventoryLine_ID).append(")");
		return DB.executeUpdate(sql.toString(), trxName);
	}	//	deleteInventoryMA
	
	/**	Logger	*/
	private static CLogger	s_log	= CLogger.getCLogger (MInventoryLineMA.class);

	
	/**************************************************************************
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param M_InventoryLineMA_ID ignored
	 *	@param trxName trx
	 */
	public MInventoryLineMA (Properties ctx, int M_InventoryLineMA_ID, String trxName)
	{
		super (ctx, M_InventoryLineMA_ID, trxName);
		if (M_InventoryLineMA_ID != 0)
			throw new IllegalArgumentException("Multi-Key");
	}	//	MInventoryLineMA

	/**
	 * 	Load Cosntructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MInventoryLineMA (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MInventoryLineMA
	
	/**
	 * 	Parent Constructor
	 *	@param parent parent
	 *	@param M_AttributeSetInstance_ID asi
	 *	@param MovementQty qty
	 *  @param DateMaterialPolicy
	 */
	public MInventoryLineMA (MInventoryLine parent, int M_AttributeSetInstance_ID, BigDecimal MovementQty,Timestamp DateMaterialPolicy)
	{
		this (parent.getCtx(), 0, parent.get_TrxName());
		setClientOrg(parent);
		setM_InventoryLine_ID(parent.getM_InventoryLine_ID());
		//
		setM_AttributeSetInstance_ID(M_AttributeSetInstance_ID);
		setMovementQty(MovementQty);
		if (DateMaterialPolicy == null)
		{
			if (M_AttributeSetInstance_ID > 0)
			{
				MAttributeSetInstance asi = new MAttributeSetInstance(parent.getCtx(), M_AttributeSetInstance_ID, parent.get_TrxName());
				DateMaterialPolicy = asi.getCreated();
			}
			else
			{
				DateMaterialPolicy = parent.getParent().getMovementDate();
			}
		}
		setDateMaterialPolicy(DateMaterialPolicy);
	}	//	MInventoryLineMA
	
	@Override
	public void setDateMaterialPolicy(Timestamp DateMaterialPolicy) {
		if (DateMaterialPolicy != null)
			DateMaterialPolicy = Util.removeTime(DateMaterialPolicy);
		super.setDateMaterialPolicy(DateMaterialPolicy);
	}

	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MInventoryLineMA[");
		sb.append("M_InventoryLine_ID=").append(getM_InventoryLine_ID())
			.append(",M_AttributeSetInstance_ID=").append(getM_AttributeSetInstance_ID())
			.append(", Qty=").append(getMovementQty())
			.append ("]");
		return sb.toString ();
	}	//	toString
	
	public static MInventoryLineMA addOrCreate(MInventoryLine line, int M_AttributeSetInstance_ID, BigDecimal MovementQty, Timestamp DateMaterialPolicy)
	{
		Query query = new Query(Env.getCtx(), I_M_InventoryLineMA.Table_Name, "M_InventoryLine_ID=? AND M_AttributeSetInstance_ID=? AND DateMaterialPolicy=trunc(cast(? as date))", 
					line.get_TrxName());
		MInventoryLineMA po = query.setParameters(line.getM_InventoryLine_ID(), M_AttributeSetInstance_ID, DateMaterialPolicy).first();
		if (po == null)
			po = new MInventoryLineMA(line, M_AttributeSetInstance_ID, MovementQty, DateMaterialPolicy);
		else
			po.setMovementQty(po.getMovementQty().add(MovementQty));
		return po;
	}
}	//	MInventoryLineMA
