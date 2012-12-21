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

/** Generated Model for X_Shipper
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_X_Shipper extends PO implements I_X_Shipper, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20121213L;

    /** Standard Constructor */
    public X_X_Shipper (Properties ctx, int X_Shipper_ID, String trxName)
    {
      super (ctx, X_Shipper_ID, trxName);
      /** if (X_Shipper_ID == 0)
        {
			setIsInternational (false);
// N
			setIsOnline (false);
// N
			setIsResidential (false);
// N
			setIsSaturdayDelivery (false);
// N
			setName (null);
			setX_Shipper_ID (0);
        } */
    }

    /** Load Constructor */
    public X_X_Shipper (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_X_Shipper[")
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

	/** Set International.
		@param IsInternational International	  */
	public void setIsInternational (boolean IsInternational)
	{
		set_Value (COLUMNNAME_IsInternational, Boolean.valueOf(IsInternational));
	}

	/** Get International.
		@return International	  */
	public boolean isInternational () 
	{
		Object oo = get_Value(COLUMNNAME_IsInternational);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Online Access.
		@param IsOnline 
		Can be accessed online 
	  */
	public void setIsOnline (boolean IsOnline)
	{
		set_Value (COLUMNNAME_IsOnline, Boolean.valueOf(IsOnline));
	}

	/** Get Online Access.
		@return Can be accessed online 
	  */
	public boolean isOnline () 
	{
		Object oo = get_Value(COLUMNNAME_IsOnline);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Residential.
		@param IsResidential Residential	  */
	public void setIsResidential (boolean IsResidential)
	{
		set_Value (COLUMNNAME_IsResidential, Boolean.valueOf(IsResidential));
	}

	/** Get Residential.
		@return Residential	  */
	public boolean isResidential () 
	{
		Object oo = get_Value(COLUMNNAME_IsResidential);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Saturday Delivery.
		@param IsSaturdayDelivery Saturday Delivery	  */
	public void setIsSaturdayDelivery (boolean IsSaturdayDelivery)
	{
		set_Value (COLUMNNAME_IsSaturdayDelivery, Boolean.valueOf(IsSaturdayDelivery));
	}

	/** Get Saturday Delivery.
		@return Saturday Delivery	  */
	public boolean isSaturdayDelivery () 
	{
		Object oo = get_Value(COLUMNNAME_IsSaturdayDelivery);
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

	/** Set Service Code.
		@param ShippingServiceCode Service Code	  */
	public void setShippingServiceCode (String ShippingServiceCode)
	{
		set_Value (COLUMNNAME_ShippingServiceCode, ShippingServiceCode);
	}

	/** Get Service Code.
		@return Service Code	  */
	public String getShippingServiceCode () 
	{
		return (String)get_Value(COLUMNNAME_ShippingServiceCode);
	}

	/** Set Tracking URL.
		@param TrackingURL 
		URL of the shipper to track shipments
	  */
	public void setTrackingURL (String TrackingURL)
	{
		set_Value (COLUMNNAME_TrackingURL, TrackingURL);
	}

	/** Get Tracking URL.
		@return URL of the shipper to track shipments
	  */
	public String getTrackingURL () 
	{
		return (String)get_Value(COLUMNNAME_TrackingURL);
	}

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

	/** Set X_Shipper_UU.
		@param X_Shipper_UU X_Shipper_UU	  */
	public void setX_Shipper_UU (String X_Shipper_UU)
	{
		set_Value (COLUMNNAME_X_Shipper_UU, X_Shipper_UU);
	}

	/** Get X_Shipper_UU.
		@return X_Shipper_UU	  */
	public String getX_Shipper_UU () 
	{
		return (String)get_Value(COLUMNNAME_X_Shipper_UU);
	}

	public org.compiere.model.I_X_ShippingProcessor getX_ShippingProcessor() throws RuntimeException
    {
		return (org.compiere.model.I_X_ShippingProcessor)MTable.get(getCtx(), org.compiere.model.I_X_ShippingProcessor.Table_Name)
			.getPO(getX_ShippingProcessor_ID(), get_TrxName());	}

	/** Set Shipping Processor.
		@param X_ShippingProcessor_ID Shipping Processor	  */
	public void setX_ShippingProcessor_ID (int X_ShippingProcessor_ID)
	{
		if (X_ShippingProcessor_ID < 1) 
			set_Value (COLUMNNAME_X_ShippingProcessor_ID, null);
		else 
			set_Value (COLUMNNAME_X_ShippingProcessor_ID, Integer.valueOf(X_ShippingProcessor_ID));
	}

	/** Get Shipping Processor.
		@return Shipping Processor	  */
	public int getX_ShippingProcessor_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_X_ShippingProcessor_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}