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

import java.sql.ResultSet;
import java.util.Properties;
import org.compiere.util.KeyNamePair;

/** Generated Model for M_ShipperPickupTypesCfg
 *  @author iDempiere (generated) 
 *  @version Release 2.0 - $Id$ */
public class X_M_ShipperPickupTypesCfg extends PO implements I_M_ShipperPickupTypesCfg, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131031L;

    /** Standard Constructor */
    public X_M_ShipperPickupTypesCfg (Properties ctx, int M_ShipperPickupTypesCfg_ID, String trxName)
    {
      super (ctx, M_ShipperPickupTypesCfg_ID, trxName);
      /** if (M_ShipperPickupTypesCfg_ID == 0)
        {
			setIsDefault (false);
// N
			setM_ShipperCfg_ID (0);
			setM_ShipperPickupTypesCfg_ID (0);
			setName (null);
			setValue (null);
        } */
    }

    /** Load Constructor */
    public X_M_ShipperPickupTypesCfg (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_M_ShipperPickupTypesCfg[")
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

	/** Set Shipper Pickup Types Configuration.
		@param M_ShipperPickupTypesCfg_ID Shipper Pickup Types Configuration	  */
	public void setM_ShipperPickupTypesCfg_ID (int M_ShipperPickupTypesCfg_ID)
	{
		if (M_ShipperPickupTypesCfg_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_ShipperPickupTypesCfg_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_ShipperPickupTypesCfg_ID, Integer.valueOf(M_ShipperPickupTypesCfg_ID));
	}

	/** Get Shipper Pickup Types Configuration.
		@return Shipper Pickup Types Configuration	  */
	public int getM_ShipperPickupTypesCfg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShipperPickupTypesCfg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_ShipperPickupTypesCfg_UU.
		@param M_ShipperPickupTypesCfg_UU M_ShipperPickupTypesCfg_UU	  */
	public void setM_ShipperPickupTypesCfg_UU (String M_ShipperPickupTypesCfg_UU)
	{
		set_Value (COLUMNNAME_M_ShipperPickupTypesCfg_UU, M_ShipperPickupTypesCfg_UU);
	}

	/** Get M_ShipperPickupTypesCfg_UU.
		@return M_ShipperPickupTypesCfg_UU	  */
	public String getM_ShipperPickupTypesCfg_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_ShipperPickupTypesCfg_UU);
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
}