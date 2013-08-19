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
/** Generated Model - DO NOT CHANGE */
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.util.Env;

/** Generated Model for C_OrderLandedCost
 *  @author iDempiere (generated) 
 *  @version Release 1.0c - $Id$ */
public class X_C_OrderLandedCost extends PO implements I_C_OrderLandedCost, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130806L;

    /** Standard Constructor */
    public X_C_OrderLandedCost (Properties ctx, int C_OrderLandedCost_ID, String trxName)
    {
      super (ctx, C_OrderLandedCost_ID, trxName);
      /** if (C_OrderLandedCost_ID == 0)
        {
			setAmt (Env.ZERO);
// 0
			setC_Order_ID (0);
			setC_OrderLandedCost_ID (0);
			setLandedCostDistribution (null);
// Q
			setM_CostElement_ID (0);
			setProcessed (false);
// N
        } */
    }

    /** Load Constructor */
    public X_C_OrderLandedCost (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 1 - Org 
      */
    protected int get_AccessLevel()
    {
      return accessLevel.intValue();
    }

    /** Load Meta Data */
    protected POInfo initPO (Properties ctx)
    {
      POInfo poi = POInfo.getPOInfo (ctx, Table_ID, get_TrxName());
      return poi;
    }

    public String toString()
    {
      StringBuffer sb = new StringBuffer ("X_C_OrderLandedCost[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Amount.
		@param Amt 
		Amount
	  */
	public void setAmt (BigDecimal Amt)
	{
		set_Value (COLUMNNAME_Amt, Amt);
	}

	/** Get Amount.
		@return Amount
	  */
	public BigDecimal getAmt () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Amt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_C_Order getC_Order() throws RuntimeException
    {
		return (org.compiere.model.I_C_Order)MTable.get(getCtx(), org.compiere.model.I_C_Order.Table_Name)
			.getPO(getC_Order_ID(), get_TrxName());	}

	/** Set Order.
		@param C_Order_ID 
		Order
	  */
	public void setC_Order_ID (int C_Order_ID)
	{
		if (C_Order_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_Order_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_Order_ID, Integer.valueOf(C_Order_ID));
	}

	/** Get Order.
		@return Order
	  */
	public int getC_Order_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Order_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Estimated Landed Cost.
		@param C_OrderLandedCost_ID Estimated Landed Cost	  */
	public void setC_OrderLandedCost_ID (int C_OrderLandedCost_ID)
	{
		if (C_OrderLandedCost_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_OrderLandedCost_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_OrderLandedCost_ID, Integer.valueOf(C_OrderLandedCost_ID));
	}

	/** Get Estimated Landed Cost.
		@return Estimated Landed Cost	  */
	public int getC_OrderLandedCost_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_OrderLandedCost_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_OrderLandedCost_UU.
		@param C_OrderLandedCost_UU C_OrderLandedCost_UU	  */
	public void setC_OrderLandedCost_UU (String C_OrderLandedCost_UU)
	{
		set_Value (COLUMNNAME_C_OrderLandedCost_UU, C_OrderLandedCost_UU);
	}

	/** Get C_OrderLandedCost_UU.
		@return C_OrderLandedCost_UU	  */
	public String getC_OrderLandedCost_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_OrderLandedCost_UU);
	}

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** LandedCostDistribution AD_Reference_ID=339 */
	public static final int LANDEDCOSTDISTRIBUTION_AD_Reference_ID=339;
	/** Quantity = Q */
	public static final String LANDEDCOSTDISTRIBUTION_Quantity = "Q";
	/** Line = L */
	public static final String LANDEDCOSTDISTRIBUTION_Line = "L";
	/** Volume = V */
	public static final String LANDEDCOSTDISTRIBUTION_Volume = "V";
	/** Weight = W */
	public static final String LANDEDCOSTDISTRIBUTION_Weight = "W";
	/** Costs = C */
	public static final String LANDEDCOSTDISTRIBUTION_Costs = "C";
	/** Set Cost Distribution.
		@param LandedCostDistribution 
		Landed Cost Distribution
	  */
	public void setLandedCostDistribution (String LandedCostDistribution)
	{

		set_Value (COLUMNNAME_LandedCostDistribution, LandedCostDistribution);
	}

	/** Get Cost Distribution.
		@return Landed Cost Distribution
	  */
	public String getLandedCostDistribution () 
	{
		return (String)get_Value(COLUMNNAME_LandedCostDistribution);
	}

	public org.compiere.model.I_M_CostElement getM_CostElement() throws RuntimeException
    {
		return (org.compiere.model.I_M_CostElement)MTable.get(getCtx(), org.compiere.model.I_M_CostElement.Table_Name)
			.getPO(getM_CostElement_ID(), get_TrxName());	}

	/** Set Cost Element.
		@param M_CostElement_ID 
		Product Cost Element
	  */
	public void setM_CostElement_ID (int M_CostElement_ID)
	{
		if (M_CostElement_ID < 1) 
			set_Value (COLUMNNAME_M_CostElement_ID, null);
		else 
			set_Value (COLUMNNAME_M_CostElement_ID, Integer.valueOf(M_CostElement_ID));
	}

	/** Get Cost Element.
		@return Product Cost Element
	  */
	public int getM_CostElement_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_CostElement_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Processed.
		@param Processed 
		The document has been processed
	  */
	public void setProcessed (boolean Processed)
	{
		set_Value (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/** Get Processed.
		@return The document has been processed
	  */
	public boolean isProcessed () 
	{
		Object oo = get_Value(COLUMNNAME_Processed);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}
}