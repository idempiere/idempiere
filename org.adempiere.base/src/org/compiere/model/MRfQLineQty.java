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

import org.compiere.util.CCache;
import org.compiere.util.DB;
import org.compiere.util.Env;

/**
 *	RfQ Line Qty Model
 *	
 *  @author Jorg Janke
 *  @version $Id: MRfQLineQty.java,v 1.3 2006/07/30 00:51:05 jjanke Exp $
 */
public class MRfQLineQty extends X_C_RfQLineQty
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2742007712266317681L;

	/**
	 * 	Get MRfQLineQty from Cache
	 *	@param ctx context
	 *	@param C_RfQLineQty_ID id
	 *	@param trxName transaction
	 *	@return MRfQLineQty
	 */
	public static MRfQLineQty get (Properties ctx, int C_RfQLineQty_ID, String trxName)
	{
		Integer key = Integer.valueOf(C_RfQLineQty_ID);
		MRfQLineQty retValue = (MRfQLineQty) s_cache.get (key);
		if (retValue != null)
			return new MRfQLineQty(ctx, retValue, trxName);
		retValue = new MRfQLineQty (ctx, C_RfQLineQty_ID, trxName);
		if (retValue.get_ID () == C_RfQLineQty_ID)
		{
			s_cache.put (key, new MRfQLineQty(Env.getCtx(), retValue));
			return retValue;
		}
		return null;
	} //	get

	/**	Cache						*/
	private static CCache<Integer,MRfQLineQty>	s_cache	= new CCache<Integer,MRfQLineQty>(Table_Name, 20);
	
	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param C_RfQLineQty_ID id
	 *	@param trxName transaction
	 */
	public MRfQLineQty (Properties ctx, int C_RfQLineQty_ID, String trxName)
	{
		super (ctx, C_RfQLineQty_ID, trxName);
		if (C_RfQLineQty_ID == 0)
		{
			setIsOfferQty (false);
			setIsPurchaseQty (false);
			setQty (Env.ONE);	// 1
		}
	}	//	MRfQLineQty

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName transaction
	 */
	public MRfQLineQty (Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}	//	MRfQLineQty
	
	/**
	 * 	Parent Constructor
	 *	@param line RfQ line
	 */
	public MRfQLineQty (MRfQLine line)
	{
		this (line.getCtx(), 0, line.get_TrxName());
		setClientOrg(line);
		setC_RfQLine_ID (line.getC_RfQLine_ID());
	}	//	MRfQLineQty
	
	/**
	 * 
	 * @param copy
	 */
	public MRfQLineQty(MRfQLineQty copy) 
	{
		this(Env.getCtx(), copy);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 */
	public MRfQLineQty(Properties ctx, MRfQLineQty copy) 
	{
		this(ctx, copy, (String) null);
	}

	/**
	 * 
	 * @param ctx
	 * @param copy
	 * @param trxName
	 */
	public MRfQLineQty(Properties ctx, MRfQLineQty copy, String trxName) 
	{
		this(ctx, 0, trxName);
		copyPO(copy);
		this.m_uom = copy.m_uom != null ? new MUOM(ctx, copy.m_uom, trxName) : null;
	}
	
	/**	Unit of Measure		*/
	private MUOM	m_uom = null;
	
	/**
	 * 	Get Uom Name
	 *	@return UOM
	 */
	public String getUomName()
	{
		if (m_uom == null)
			m_uom = MUOM.get(getCtx(), getC_UOM_ID());
		return m_uom.getName();
	}	//	getUomText
	
	/**
	 * 	Get active Response Qtys of this RfQ Qty
	 * 	@param onlyValidAmounts only valid amounts
	 *	@return array of response line qtys
	 */
	public MRfQResponseLineQty[] getResponseQtys (boolean onlyValidAmounts)
	{
		ArrayList<MRfQResponseLineQty> list = new ArrayList<MRfQResponseLineQty>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM C_RfQResponseLineQty WHERE C_RfQLineQty_ID=? AND IsActive='Y'";
		try
		{
			pstmt = DB.prepareStatement (sql, get_TrxName());
			pstmt.setInt (1, getC_RfQLineQty_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				MRfQResponseLineQty qty = new MRfQResponseLineQty(getCtx(), rs, get_TrxName());
				if (onlyValidAmounts && !qty.isValidAmt())
					;
				else
					list.add (qty);
			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}
		MRfQResponseLineQty[] retValue = new MRfQResponseLineQty[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	//	getResponseQtys
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MRfQLineQty[");
		sb.append(get_ID()).append(",Qty=").append(getQty())
			.append(",Offer=").append(isOfferQty())
			.append(",Purchase=").append(isPurchaseQty())
			.append ("]");
		return sb.toString ();
	}	//	toString
}	//	MRfQLineQty
