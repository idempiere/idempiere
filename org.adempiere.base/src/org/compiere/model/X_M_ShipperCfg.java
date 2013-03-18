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

/** Generated Model for M_ShipperCfg
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_M_ShipperCfg extends PO implements I_M_ShipperCfg, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20130318L;

    /** Standard Constructor */
    public X_M_ShipperCfg (Properties ctx, int M_ShipperCfg_ID, String trxName)
    {
      super (ctx, M_ShipperCfg_ID, trxName);
      /** if (M_ShipperCfg_ID == 0)
        {
			setIsInternational (false);
// N
			setIsOnline (false);
// N
			setIsResidential (false);
// N
			setIsSaturdayDelivery (false);
// N
			setM_ShipperCfg_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_M_ShipperCfg (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_M_ShipperCfg[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Copy From.
		@param CopyFrom 
		Copy From Record
	  */
	public void setCopyFrom (String CopyFrom)
	{
		set_Value (COLUMNNAME_CopyFrom, CopyFrom);
	}

	/** Get Copy From.
		@return Copy From Record
	  */
	public String getCopyFrom () 
	{
		return (String)get_Value(COLUMNNAME_CopyFrom);
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

	/** Set M_ShipperCfg_UU.
		@param M_ShipperCfg_UU M_ShipperCfg_UU	  */
	public void setM_ShipperCfg_UU (String M_ShipperCfg_UU)
	{
		set_Value (COLUMNNAME_M_ShipperCfg_UU, M_ShipperCfg_UU);
	}

	/** Get M_ShipperCfg_UU.
		@return M_ShipperCfg_UU	  */
	public String getM_ShipperCfg_UU () 
	{
		return (String)get_Value(COLUMNNAME_M_ShipperCfg_UU);
	}

	public org.compiere.model.I_M_ShippingProcessorCfg getM_ShippingProcessorCfg() throws RuntimeException
    {
		return (org.compiere.model.I_M_ShippingProcessorCfg)MTable.get(getCtx(), org.compiere.model.I_M_ShippingProcessorCfg.Table_Name)
			.getPO(getM_ShippingProcessorCfg_ID(), get_TrxName());	}

	/** Set Shipping Processor Configuration.
		@param M_ShippingProcessorCfg_ID Shipping Processor Configuration	  */
	public void setM_ShippingProcessorCfg_ID (int M_ShippingProcessorCfg_ID)
	{
		if (M_ShippingProcessorCfg_ID < 1) 
			set_Value (COLUMNNAME_M_ShippingProcessorCfg_ID, null);
		else 
			set_Value (COLUMNNAME_M_ShippingProcessorCfg_ID, Integer.valueOf(M_ShippingProcessorCfg_ID));
	}

	/** Get Shipping Processor Configuration.
		@return Shipping Processor Configuration	  */
	public int getM_ShippingProcessorCfg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShippingProcessorCfg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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
}