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

/** Generated Model for M_ShipperPickupTypes
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_M_ShipperPickupTypes extends PO implements I_M_ShipperPickupTypes, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130109L;

    /** Standard Constructor */
    public X_M_ShipperPickupTypes (Properties ctx, int M_ShipperPickupTypes_ID, String trxName)
    {
      super (ctx, M_ShipperPickupTypes_ID, trxName);
      /** if (M_ShipperPickupTypes_ID == 0)
        {
			setIsDefault (false);
// N
			setM_Shipper_ID (0);
			setM_ShipperPickupTypes_ID (0);
			setName (null);
			setX_ShipperPickupTypes_ID (0);
        } */
    }

    /** Load Constructor */
    public X_M_ShipperPickupTypes (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_M_ShipperPickupTypes[")
        .append(get_ID()).append("]");
      return sb.toString();
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

	public org.compiere.model.I_M_Shipper getM_Shipper() throws RuntimeException
    {
		return (org.compiere.model.I_M_Shipper)MTable.get(getCtx(), org.compiere.model.I_M_Shipper.Table_Name)
			.getPO(getM_Shipper_ID(), get_TrxName());	}

	/** Set Shipper.
		@param M_Shipper_ID 
		Method or manner of product delivery
	  */
	public void setM_Shipper_ID (int M_Shipper_ID)
	{
		if (M_Shipper_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_Shipper_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_Shipper_ID, Integer.valueOf(M_Shipper_ID));
	}

	/** Get Shipper.
		@return Method or manner of product delivery
	  */
	public int getM_Shipper_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_Shipper_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Shipper Pickup Types.
		@param M_ShipperPickupTypes_ID Shipper Pickup Types	  */
	public void setM_ShipperPickupTypes_ID (int M_ShipperPickupTypes_ID)
	{
		if (M_ShipperPickupTypes_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_M_ShipperPickupTypes_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_M_ShipperPickupTypes_ID, Integer.valueOf(M_ShipperPickupTypes_ID));
	}

	/** Get Shipper Pickup Types.
		@return Shipper Pickup Types	  */
	public int getM_ShipperPickupTypes_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShipperPickupTypes_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set M_ShipperPickupTypes_UU.
		@param M_ShipperPickupTypes_UU M_ShipperPickupTypes_UU	  */
	public void setM_ShipperPickupTypes_UU (String M_ShipperPickupTypes_UU)
	{
		set_Value (COLUMNNAME_M_ShipperPickupTypes_UU, M_ShipperPickupTypes_UU);
	}

	/** Get M_ShipperPickupTypes_UU.
		@return M_ShipperPickupTypes_UU	  */
	public String getM_ShipperPickupTypes_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_ShipperPickupTypes_UU);
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

	public org.compiere.model.I_X_ShipperPickupTypes getX_ShipperPickupTypes() throws RuntimeException
    {
		return (org.compiere.model.I_X_ShipperPickupTypes)MTable.get(getCtx(), org.compiere.model.I_X_ShipperPickupTypes.Table_Name)
			.getPO(getX_ShipperPickupTypes_ID(), get_TrxName());	}

	/** Set Shipper Pickup Types.
		@param X_ShipperPickupTypes_ID Shipper Pickup Types	  */
	public void setX_ShipperPickupTypes_ID (int X_ShipperPickupTypes_ID)
	{
		if (X_ShipperPickupTypes_ID < 1) 
			set_Value (COLUMNNAME_X_ShipperPickupTypes_ID, null);
		else 
			set_Value (COLUMNNAME_X_ShipperPickupTypes_ID, Integer.valueOf(X_ShipperPickupTypes_ID));
	}

	/** Get Shipper Pickup Types.
		@return Shipper Pickup Types	  */
	public int getX_ShipperPickupTypes_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_X_ShipperPickupTypes_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}