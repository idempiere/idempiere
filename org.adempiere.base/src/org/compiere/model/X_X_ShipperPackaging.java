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

/** Generated Model for X_ShipperPackaging
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_X_ShipperPackaging extends PO implements I_X_ShipperPackaging, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20121213L;

    /** Standard Constructor */
    public X_X_ShipperPackaging (Properties ctx, int X_ShipperPackaging_ID, String trxName)
    {
      super (ctx, X_ShipperPackaging_ID, trxName);
      /** if (X_ShipperPackaging_ID == 0)
        {
			setIsDefault (false);
// N
			setName (null);
			setValue (null);
			setX_Shipper_ID (0);
			setX_ShipperPackaging_ID (0);
        } */
    }

    /** Load Constructor */
    public X_X_ShipperPackaging (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 6 - System - Client 
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
      StringBuffer sb = new StringBuffer ("X_X_ShipperPackaging[")
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

	/** Set Default.
		@param IsDefault 
		Default value
	  */
	public void setIsDefault (boolean IsDefault)
	{
		set_Value (COLUMNNAME_IsDefault, Boolean.valueOf(IsDefault));
	}

	/** Get Default.
		@return Default value
	  */
	public boolean isDefault () 
	{
		Object oo = get_Value(COLUMNNAME_IsDefault);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Name.
		@param Name 
		Alphanumeric identifier of the entity
	  */
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName () 
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** Set Search Key.
		@param Value 
		Search key for the record in the format required - must be unique
	  */
	public void setValue (String Value)
	{
		set_Value (COLUMNNAME_Value, Value);
	}

	/** Get Search Key.
		@return Search key for the record in the format required - must be unique
	  */
	public String getValue () 
	{
		return (String)get_Value(COLUMNNAME_Value);
	}

	/** Set Weight.
		@param Weight 
		Weight of a product
	  */
	public void setWeight (BigDecimal Weight)
	{
		set_Value (COLUMNNAME_Weight, Weight);
	}

	/** Get Weight.
		@return Weight of a product
	  */
	public BigDecimal getWeight () 
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_Weight);
		if (bd == null)
			 return Env.ZERO;
		return bd;
	}

	public org.compiere.model.I_X_Shipper getX_Shipper() throws RuntimeException
    {
		return (org.compiere.model.I_X_Shipper)MTable.get(getCtx(), org.compiere.model.I_X_Shipper.Table_Name)
			.getPO(getX_Shipper_ID(), get_TrxName());	}

	/** Set Shipper.
		@param X_Shipper_ID Shipper	  */
	public void setX_Shipper_ID (int X_Shipper_ID)
	{
		if (X_Shipper_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_X_Shipper_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_X_Shipper_ID, Integer.valueOf(X_Shipper_ID));
	}

	/** Get Shipper.
		@return Shipper	  */
	public int getX_Shipper_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_X_Shipper_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Shipper Packaging.
		@param X_ShipperPackaging_ID Shipper Packaging	  */
	public void setX_ShipperPackaging_ID (int X_ShipperPackaging_ID)
	{
		if (X_ShipperPackaging_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_X_ShipperPackaging_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_X_ShipperPackaging_ID, Integer.valueOf(X_ShipperPackaging_ID));
	}

	/** Get Shipper Packaging.
		@return Shipper Packaging	  */
	public int getX_ShipperPackaging_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_X_ShipperPackaging_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set X_ShipperPackaging_UU.
		@param X_ShipperPackaging_UU X_ShipperPackaging_UU	  */
	public void setX_ShipperPackaging_UU (String X_ShipperPackaging_UU)
	{
		set_Value (COLUMNNAME_X_ShipperPackaging_UU, X_ShipperPackaging_UU);
	}

	/** Get X_ShipperPackaging_UU.
		@return X_ShipperPackaging_UU	  */
	public String getX_ShipperPackaging_UU () 
	{
		return (String)get_Value(COLUMNNAME_X_ShipperPackaging_UU);
	}
}