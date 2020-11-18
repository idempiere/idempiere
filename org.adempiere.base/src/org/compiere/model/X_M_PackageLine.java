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
import org.compiere.util.KeyNamePair;

/** Generated Model for M_PackageLine
 *  @author iDempiere (generated) 
 *  @version Release 8.1 - $Id$ */
public class X_M_PackageLine extends PO implements I_M_PackageLine, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20201103L;

    /** Standard Constructor */
    public X_M_PackageLine (Properties ctx, int M_PackageLine_ID, String trxName)
    {
      super (ctx, M_PackageLine_ID, trxName);
      /** if (M_PackageLine_ID == 0)
        {
			setM_InOutLine_ID (0);
			setM_Package_ID (0);
			setM_PackageLine_ID (0);
			setQty (Env.ZERO);
        } */
    }

    /** Load Constructor */
    public X_M_PackageLine (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_M_PackageLine[")
        .append(get_ID()).append("]");
      return sb.toString();
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

	public org.compiere.model.I_M_InOutLine getM_InOutLine() throws RuntimeException
    {
		return (org.compiere.model.I_M_InOutLine)MTable.get(getCtx(), org.compiere.model.I_M_InOutLine.Table_Name)
			.getPO(getM_InOutLine_ID(), get_TrxName());	}

	/** Set Shipment/Receipt Line.
		@param M_InOutLine_ID 
		Line on Shipment or Receipt document
	  */
	public void setM_InOutLine_ID (int M_InOutLine_ID)
	{
		if (M_InOutLine_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_InOutLine_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_InOutLine_ID, Integer.valueOf(M_InOutLine_ID));
	}

	/** Get Shipment/Receipt Line.
		@return Line on Shipment or Receipt document
	  */
	public int getM_InOutLine_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_InOutLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_Package getM_Package() throws RuntimeException
    {
		return (org.compiere.model.I_M_Package)MTable.get(getCtx(), org.compiere.model.I_M_Package.Table_Name)
			.getPO(getM_Package_ID(), get_TrxName());	}

	/** Set Package.
		@param M_Package_ID 
		Shipment Package
	  */
	public void setM_Package_ID (int M_Package_ID)
	{
		if (M_Package_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_Package_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_Package_ID, Integer.valueOf(M_Package_ID));
	}

	/** Get Package.
		@return Shipment Package
	  */
	public int getM_Package_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Package_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), String.valueOf(getM_Package_ID()));
    }

	/** Set Package Line.
		@param M_PackageLine_ID 
		The detail content of the Package
	  */
	public void setM_PackageLine_ID (int M_PackageLine_ID)
	{
		if (M_PackageLine_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_PackageLine_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_PackageLine_ID, Integer.valueOf(M_PackageLine_ID));
	}

	/** Get Package Line.
		@return The detail content of the Package
	  */
	public int getM_PackageLine_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_PackageLine_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_PackageLine_UU.
		@param M_PackageLine_UU M_PackageLine_UU	  */
	public void setM_PackageLine_UU (String M_PackageLine_UU)
	{
		set_Value (COLUMNNAME_M_PackageLine_UU, M_PackageLine_UU);
	}

	/** Get M_PackageLine_UU.
		@return M_PackageLine_UU	  */
	public String getM_PackageLine_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_PackageLine_UU);
	}

	public org.compiere.model.I_M_PackageMPS getM_PackageMPS() throws RuntimeException
    {
		return (org.compiere.model.I_M_PackageMPS)MTable.get(getCtx(), org.compiere.model.I_M_PackageMPS.Table_Name)
			.getPO(getM_PackageMPS_ID(), get_TrxName());	}

	/** Set Package MPS.
		@param M_PackageMPS_ID Package MPS	  */
	public void setM_PackageMPS_ID (int M_PackageMPS_ID)
	{
		if (M_PackageMPS_ID < 1) 
			set_Value (COLUMNNAME_M_PackageMPS_ID, null);
		else 
			set_Value (COLUMNNAME_M_PackageMPS_ID, Integer.valueOf(M_PackageMPS_ID));
	}

	/** Get Package MPS.
		@return Package MPS	  */
	public int getM_PackageMPS_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_PackageMPS_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_M_Product getM_Product() throws RuntimeException
    {
		return (org.compiere.model.I_M_Product)MTable.get(getCtx(), org.compiere.model.I_M_Product.Table_Name)
			.getPO(getM_Product_ID(), get_TrxName());	}

	/** Set Product.
		@param M_Product_ID 
		Product, Service, Item
	  */
	public void setM_Product_ID (int M_Product_ID)
	{
		if (M_Product_ID < 1) 
			set_Value (COLUMNNAME_M_Product_ID, null);
		else 
			set_Value (COLUMNNAME_M_Product_ID, Integer.valueOf(M_Product_ID));
	}

	/** Get Product.
		@return Product, Service, Item
	  */
	public int getM_Product_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Product_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Quantity.
		@param Qty 
		Quantity
	  */
	public void setQty (BigDecimal Qty)
	{
		set_Value (COLUMNNAME_Qty, Qty);
	}

	/** Get Quantity.
		@return Quantity
	  */
	public BigDecimal getQty () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Qty);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}
}