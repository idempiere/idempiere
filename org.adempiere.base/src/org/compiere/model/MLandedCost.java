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
import org.compiere.util.Msg;
import org.compiere.util.Util;

/**
 * 	Landed Cost Model
 *  @author Jorg Janke
 *  @version $Id: MLandedCost.java,v 1.3 2006/07/30 00:51:03 jjanke Exp $
 */
public class MLandedCost extends X_C_LandedCost
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -5645509613930428050L;

	/**
	 *	Get Landed Costs of Invoice Line
	 * 	@param il invoice line
	 *	@return array of landed cost lines
	 */
	public static MLandedCost[] getLandedCosts (MInvoiceLine il)
	{
		ArrayList<MLandedCost> list = new ArrayList<MLandedCost> ();
		String sql = "SELECT * FROM C_LandedCost WHERE C_InvoiceLine_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement (sql, il.get_TrxName());
			pstmt.setInt (1, il.getC_InvoiceLine_ID());
			rs = pstmt.executeQuery ();
			while (rs.next ())
			{
				list.add (new MLandedCost (il.getCtx(), rs, il.get_TrxName()));
			}
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
		//
		MLandedCost[] retValue = new MLandedCost[list.size ()];
		list.toArray (retValue);
		return retValue;
	}	// getLandedCosts

	/**	Logger	*/
	private static CLogger s_log = CLogger.getCLogger (MLandedCost.class);
	
    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param C_LandedCost_UU  UUID key
     * @param trxName Transaction
     */
    public MLandedCost(Properties ctx, String C_LandedCost_UU, String trxName) {
        super(ctx, C_LandedCost_UU, trxName);
		if (Util.isEmpty(C_LandedCost_UU))
			setInitialDefaults();
    }

	/**
	 * Standard Constructor
	 * 
	 * @param ctx context
	 * @param C_LandedCost_ID id
	 * @param trxName trx
	 */
	public MLandedCost (Properties ctx, int C_LandedCost_ID, String trxName)
	{
		super (ctx, C_LandedCost_ID, trxName);
		if (C_LandedCost_ID == 0)
			setInitialDefaults();
	}	//	MLandedCost

	/**
	 * Set the initial defaults for a new record
	 */
	private void setInitialDefaults() {
		setLandedCostDistribution (LANDEDCOSTDISTRIBUTION_Quantity);	// Q
	}

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MLandedCost (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MLandedCost
	
	/**
	 * 	Check that one of M_Product_ID, M_InOut_ID or M_InOutLine_ID is fill.<br/>
	 *  Ensure M_Product_ID is 0 if M_InOutLine_ID is fill.
	 *	@param newRecord new
	 *	@return true if ok
	 */
	@Override
	protected boolean beforeSave (boolean newRecord)
	{
		//	One Reference
		if (getM_Product_ID() == 0 
			&& getM_InOut_ID() == 0 
			&& getM_InOutLine_ID() == 0)
		{
			log.saveError("Error", Msg.parseTranslation(getCtx(), 
				"@NotFound@ @M_Product_ID@ | @M_InOut_ID@ | @M_InOutLine_ID@"));
			return false;
		}
		//	No Product if Line entered
		if (getM_InOutLine_ID() != 0 && getM_Product_ID() != 0)
			setM_Product_ID(0);
				
		return true;
	}	//	beforeSave
	
	/**
	 * 	Allocate Landed Costs.
	 * 	Done at Invoice Line Level.
	 * 	@return error message or ""
	 */
	public String allocateCosts()
	{
		MInvoiceLine il = new MInvoiceLine (getCtx(), getC_InvoiceLine_ID(), get_TrxName());
		return il.allocateLandedCosts();
	}	//	allocateCosts
	
	/**
	 * 	String Representation
	 *	@return info
	 */
	@Override
	public String toString ()
	{
		StringBuilder sb = new StringBuilder ("MLandedCost[");
		sb.append (get_ID ())
			.append (",CostDistribution=").append (getLandedCostDistribution())
			.append(",M_CostElement_ID=").append(getM_CostElement_ID());
		if (getM_InOut_ID() != 0)
			sb.append (",M_InOut_ID=").append (getM_InOut_ID());
		if (getM_InOutLine_ID() != 0)
			sb.append (",M_InOutLine_ID=").append (getM_InOutLine_ID());
		if (getM_Product_ID() != 0)
			sb.append (",M_Product_ID=").append (getM_Product_ID());
		sb.append ("]");
		return sb.toString ();
	} //	toString
	
}	//	MLandedCost
