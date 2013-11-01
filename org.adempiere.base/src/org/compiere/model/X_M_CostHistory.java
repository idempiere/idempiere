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

/** Generated Model for M_CostHistory
 *  @author iDempiere (generated) 
 *  @version Release 2.0 - $Id$ */
public class X_M_CostHistory extends PO implements I_M_CostHistory, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131031L;

    /** Standard Constructor */
    public X_M_CostHistory (Properties ctx, int M_CostHistory_ID, String trxName)
    {
      super (ctx, M_CostHistory_ID, trxName);
      /** if (M_CostHistory_ID == 0)
        {
			setM_AttributeSetInstance_ID (0);
			setM_CostDetail_ID (0);
			setM_CostElement_ID (0);
			setM_CostHistory_ID (0);
			setM_CostHistory_UU (null);
			setM_CostType_ID (0);
			setNewCostPrice (Env.ZERO);
			setNewQty (Env.ZERO);
			setOldCostPrice (Env.ZERO);
			setOldQty (Env.ZERO);
        } */
    }

    /** Load Constructor */
    public X_M_CostHistory (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 3 - Client - Org 
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
      StringBuffer sb = new StringBuffer ("X_M_CostHistory[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public I_M_AttributeSetInstance getM_AttributeSetInstance() throws RuntimeException
    {
		return (I_M_AttributeSetInstance)MTable.get(getCtx(), I_M_AttributeSetInstance.Table_Name)
			.getPO(getM_AttributeSetInstance_ID(), get_TrxName());	}

	/** Set Attribute Set Instance.
		@param M_AttributeSetInstance_ID 
		Product Attribute Set Instance
	  */
	public void setM_AttributeSetInstance_ID (int M_AttributeSetInstance_ID)
	{
		if (M_AttributeSetInstance_ID < 0) 
			set_ValueNoCheck (COLUMNNAME_M_AttributeSetInstance_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_AttributeSetInstance_ID, Integer.valueOf(M_AttributeSetInstance_ID));
	}

	/** Get Attribute Set Instance.
		@return Product Attribute Set Instance
	  */
	public int getM_AttributeSetInstance_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_AttributeSetInstance_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_CostDetail getM_CostDetail() throws RuntimeException
    {
		return (org.compiere.model.I_M_CostDetail)MTable.get(getCtx(), org.compiere.model.I_M_CostDetail.Table_Name)
			.getPO(getM_CostDetail_ID(), get_TrxName());	}

	/** Set Cost Detail.
		@param M_CostDetail_ID 
		Cost Detail Information
	  */
	public void setM_CostDetail_ID (int M_CostDetail_ID)
	{
		if (M_CostDetail_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_CostDetail_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_CostDetail_ID, Integer.valueOf(M_CostDetail_ID));
	}

	/** Get Cost Detail.
		@return Cost Detail Information
	  */
	public int getM_CostDetail_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_CostDetail_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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
			set_ValueNoCheck (COLUMNNAME_M_CostElement_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_CostElement_ID, Integer.valueOf(M_CostElement_ID));
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

	/** Set Cost History.
		@param M_CostHistory_ID 
		Movement history for M_Cost
	  */
	public void setM_CostHistory_ID (int M_CostHistory_ID)
	{
		if (M_CostHistory_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_CostHistory_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_CostHistory_ID, Integer.valueOf(M_CostHistory_ID));
	}

	/** Get Cost History.
		@return Movement history for M_Cost
	  */
	public int getM_CostHistory_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_CostHistory_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Cost History UUID.
		@param M_CostHistory_UU Cost History UUID	  */
	public void setM_CostHistory_UU (String M_CostHistory_UU)
	{
		set_ValueNoCheck (COLUMNNAME_M_CostHistory_UU, M_CostHistory_UU);
	}

	/** Get Cost History UUID.
		@return Cost History UUID	  */
	public String getM_CostHistory_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_CostHistory_UU);
	}

	public org.compiere.model.I_M_CostType getM_CostType() throws RuntimeException
    {
		return (org.compiere.model.I_M_CostType)MTable.get(getCtx(), org.compiere.model.I_M_CostType.Table_Name)
			.getPO(getM_CostType_ID(), get_TrxName());	}

	/** Set Cost Type.
		@param M_CostType_ID 
		Type of Cost (e.g. Current, Plan, Future)
	  */
	public void setM_CostType_ID (int M_CostType_ID)
	{
		if (M_CostType_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_CostType_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_CostType_ID, Integer.valueOf(M_CostType_ID));
	}

	/** Get Cost Type.
		@return Type of Cost (e.g. Current, Plan, Future)
	  */
	public int getM_CostType_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_CostType_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set New Accumulated Amt.
		@param NewCAmt 
		Accumulated Amt after processing of M_CostDetail
	  */
	public void setNewCAmt (BigDecimal NewCAmt)
	{
		set_ValueNoCheck (COLUMNNAME_NewCAmt, NewCAmt);
	}

	/** Get New Accumulated Amt.
		@return Accumulated Amt after processing of M_CostDetail
	  */
	public BigDecimal getNewCAmt () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_NewCAmt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set New Cost Price.
		@param NewCostPrice 
		New current cost price after processing of M_CostDetail
	  */
	public void setNewCostPrice (BigDecimal NewCostPrice)
	{
		set_ValueNoCheck (COLUMNNAME_NewCostPrice, NewCostPrice);
	}

	/** Get New Cost Price.
		@return New current cost price after processing of M_CostDetail
	  */
	public BigDecimal getNewCostPrice () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_NewCostPrice);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set New Accumulated Qty.
		@param NewCQty 
		New Accumulated Qty after processing of M_CostDetail
	  */
	public void setNewCQty (BigDecimal NewCQty)
	{
		set_ValueNoCheck (COLUMNNAME_NewCQty, NewCQty);
	}

	/** Get New Accumulated Qty.
		@return New Accumulated Qty after processing of M_CostDetail
	  */
	public BigDecimal getNewCQty () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_NewCQty);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set New Current Quantity.
		@param NewQty 
		New current quantity after processing of M_CostDetail
	  */
	public void setNewQty (BigDecimal NewQty)
	{
		set_ValueNoCheck (COLUMNNAME_NewQty, NewQty);
	}

	/** Get New Current Quantity.
		@return New current quantity after processing of M_CostDetail
	  */
	public BigDecimal getNewQty () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_NewQty);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Old Accumulated Amt.
		@param OldCAmt 
		Old accumulated amt before the processing of M_CostDetail
	  */
	public void setOldCAmt (BigDecimal OldCAmt)
	{
		set_ValueNoCheck (COLUMNNAME_OldCAmt, OldCAmt);
	}

	/** Get Old Accumulated Amt.
		@return Old accumulated amt before the processing of M_CostDetail
	  */
	public BigDecimal getOldCAmt () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_OldCAmt);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Old Current Cost Price.
		@param OldCostPrice 
		Old current cost price before the processing of M_CostDetail
	  */
	public void setOldCostPrice (BigDecimal OldCostPrice)
	{
		set_ValueNoCheck (COLUMNNAME_OldCostPrice, OldCostPrice);
	}

	/** Get Old Current Cost Price.
		@return Old current cost price before the processing of M_CostDetail
	  */
	public BigDecimal getOldCostPrice () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_OldCostPrice);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Old Accumulated Qty.
		@param OldCQty 
		Old accumulated qty before the processing of M_CostDetail
	  */
	public void setOldCQty (BigDecimal OldCQty)
	{
		set_ValueNoCheck (COLUMNNAME_OldCQty, OldCQty);
	}

	/** Get Old Accumulated Qty.
		@return Old accumulated qty before the processing of M_CostDetail
	  */
	public BigDecimal getOldCQty () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_OldCQty);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	/** Set Old Current Quantity.
		@param OldQty 
		Old current quantity before the processing of M_CostDetail
	  */
	public void setOldQty (BigDecimal OldQty)
	{
		set_ValueNoCheck (COLUMNNAME_OldQty, OldQty);
	}

	/** Get Old Current Quantity.
		@return Old current quantity before the processing of M_CostDetail
	  */
	public BigDecimal getOldQty () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_OldQty);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}
}