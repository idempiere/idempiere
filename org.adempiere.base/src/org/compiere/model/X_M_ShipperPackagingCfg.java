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

/** Generated Model for M_ShipperPackagingCfg
 *  @author iDempiere (generated) 
 *  @version Release 1.0b - $Id$ */
public class X_M_ShipperPackagingCfg extends PO implements I_M_ShipperPackagingCfg, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130425L;

    /** Standard Constructor */
    public X_M_ShipperPackagingCfg (Properties ctx, int M_ShipperPackagingCfg_ID, String trxName)
    {
      super (ctx, M_ShipperPackagingCfg_ID, trxName);
      /** if (M_ShipperPackagingCfg_ID == 0)
        {
			setIsDefault (false);
// N
			setM_ShipperCfg_ID (0);
			setM_ShipperPackagingCfg_ID (0);
			setName (null);
			setValue (null);
        } */
    }

    /** Load Constructor */
    public X_M_ShipperPackagingCfg (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_M_ShipperPackagingCfg[")
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

	public org.compiere.model.I_M_ShipperCfg getM_ShipperCfg() throws RuntimeException
    {
		return (org.compiere.model.I_M_ShipperCfg)MTable.get(getCtx(), org.compiere.model.I_M_ShipperCfg.Table_Name)
			.getPO(getM_ShipperCfg_ID(), get_TrxName());	}

	/** Set Shipper Configuration.
		@param M_ShipperCfg_ID Shipper Configuration	  */
	public void setM_ShipperCfg_ID (int M_ShipperCfg_ID)
	{
		if (M_ShipperCfg_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_ShipperCfg_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_ShipperCfg_ID, Integer.valueOf(M_ShipperCfg_ID));
	}

	/** Get Shipper Configuration.
		@return Shipper Configuration	  */
	public int getM_ShipperCfg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShipperCfg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Shipper Packaging Configuration.
		@param M_ShipperPackagingCfg_ID Shipper Packaging Configuration	  */
	public void setM_ShipperPackagingCfg_ID (int M_ShipperPackagingCfg_ID)
	{
		if (M_ShipperPackagingCfg_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_ShipperPackagingCfg_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_ShipperPackagingCfg_ID, Integer.valueOf(M_ShipperPackagingCfg_ID));
	}

	/** Get Shipper Packaging Configuration.
		@return Shipper Packaging Configuration	  */
	public int getM_ShipperPackagingCfg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShipperPackagingCfg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_ShipperPackagingCfg_UU.
		@param M_ShipperPackagingCfg_UU M_ShipperPackagingCfg_UU	  */
	public void setM_ShipperPackagingCfg_UU (String M_ShipperPackagingCfg_UU)
	{
		set_Value (COLUMNNAME_M_ShipperPackagingCfg_UU, M_ShipperPackagingCfg_UU);
	}

	/** Get M_ShipperPackagingCfg_UU.
		@return M_ShipperPackagingCfg_UU	  */
	public String getM_ShipperPackagingCfg_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_ShipperPackagingCfg_UU);
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
}