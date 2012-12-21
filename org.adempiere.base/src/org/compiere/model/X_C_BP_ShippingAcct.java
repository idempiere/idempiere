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

/** Generated Model for C_BP_ShippingAcct
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_C_BP_ShippingAcct extends PO implements I_C_BP_ShippingAcct, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20121207L;

    /** Standard Constructor */
    public X_C_BP_ShippingAcct (Properties ctx, int C_BP_ShippingAcct_ID, String trxName)
    {
      super (ctx, C_BP_ShippingAcct_ID, trxName);
      /** if (C_BP_ShippingAcct_ID == 0)
        {
			setC_BP_ShippingAcct_ID (0);
			setC_BPartner_ID (0);
        } */
    }

    /** Load Constructor */
    public X_C_BP_ShippingAcct (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_C_BP_ShippingAcct[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Business Partner Shipping Account.
		@param C_BP_ShippingAcct_ID Business Partner Shipping Account	  */
	public void setC_BP_ShippingAcct_ID (int C_BP_ShippingAcct_ID)
	{
		if (C_BP_ShippingAcct_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_BP_ShippingAcct_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_BP_ShippingAcct_ID, Integer.valueOf(C_BP_ShippingAcct_ID));
	}

	/** Get Business Partner Shipping Account.
		@return Business Partner Shipping Account	  */
	public int getC_BP_ShippingAcct_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BP_ShippingAcct_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_BP_ShippingAcct_UU.
		@param C_BP_ShippingAcct_UU C_BP_ShippingAcct_UU	  */
	public void setC_BP_ShippingAcct_UU (String C_BP_ShippingAcct_UU)
	{
		set_Value (COLUMNNAME_C_BP_ShippingAcct_UU, C_BP_ShippingAcct_UU);
	}

	/** Get C_BP_ShippingAcct_UU.
		@return C_BP_ShippingAcct_UU	  */
	public String getC_BP_ShippingAcct_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_BP_ShippingAcct_UU);
	}

	public org.compiere.model.I_C_BPartner getC_BPartner() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner)MTable.get(getCtx(), org.compiere.model.I_C_BPartner.Table_Name)
			.getPO(getC_BPartner_ID(), get_TrxName());	}

	/** Set Business Partner .
		@param C_BPartner_ID 
		Identifies a Business Partner
	  */
	public void setC_BPartner_ID (int C_BPartner_ID)
	{
		if (C_BPartner_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_BPartner_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_BPartner_ID, Integer.valueOf(C_BPartner_ID));
	}

	/** Get Business Partner .
		@return Identifies a Business Partner
	  */
	public int getC_BPartner_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BPartner_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_BPartner_Location getC_BPartner_Location() throws RuntimeException
    {
		return (org.compiere.model.I_C_BPartner_Location)MTable.get(getCtx(), org.compiere.model.I_C_BPartner_Location.Table_Name)
			.getPO(getC_BPartner_Location_ID(), get_TrxName());	}

	/** Set Partner Location.
		@param C_BPartner_Location_ID 
		Identifies the (ship to) address for this Business Partner
	  */
	public void setC_BPartner_Location_ID (int C_BPartner_Location_ID)
	{
		if (C_BPartner_Location_ID < 1) 
			set_Value (COLUMNNAME_C_BPartner_Location_ID, null);
		else 
			set_Value (COLUMNNAME_C_BPartner_Location_ID, Integer.valueOf(C_BPartner_Location_ID));
	}

	/** Get Partner Location.
		@return Identifies the (ship to) address for this Business Partner
	  */
	public int getC_BPartner_Location_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_BPartner_Location_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Duties Shipper Account.
		@param DutiesShipperAccount Duties Shipper Account	  */
	public void setDutiesShipperAccount (String DutiesShipperAccount)
	{
		set_Value (COLUMNNAME_DutiesShipperAccount, DutiesShipperAccount);
	}

	/** Get Duties Shipper Account.
		@return Duties Shipper Account	  */
	public String getDutiesShipperAccount () 
	{
		return (String)get_Value(COLUMNNAME_DutiesShipperAccount);
	}

	public org.compiere.model.I_M_ShippingProcessor getM_ShippingProcessor() throws RuntimeException
    {
		return (org.compiere.model.I_M_ShippingProcessor)MTable.get(getCtx(), org.compiere.model.I_M_ShippingProcessor.Table_Name)
			.getPO(getM_ShippingProcessor_ID(), get_TrxName());	}

	/** Set Shipping Processor.
		@param M_ShippingProcessor_ID Shipping Processor	  */
	public void setM_ShippingProcessor_ID (int M_ShippingProcessor_ID)
	{
		if (M_ShippingProcessor_ID < 1) 
			set_Value (COLUMNNAME_M_ShippingProcessor_ID, null);
		else 
			set_Value (COLUMNNAME_M_ShippingProcessor_ID, Integer.valueOf(M_ShippingProcessor_ID));
	}

	/** Get Shipping Processor.
		@return Shipping Processor	  */
	public int getM_ShippingProcessor_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_ShippingProcessor_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Shipper Account Number.
		@param ShipperAccount Shipper Account Number	  */
	public void setShipperAccount (String ShipperAccount)
	{
		set_Value (COLUMNNAME_ShipperAccount, ShipperAccount);
	}

	/** Get Shipper Account Number.
		@return Shipper Account Number	  */
	public String getShipperAccount () 
	{
		return (String)get_Value(COLUMNNAME_ShipperAccount);
	}

	/** Set Shipper Meter.
		@param ShipperMeter Shipper Meter	  */
	public void setShipperMeter (String ShipperMeter)
	{
		set_Value (COLUMNNAME_ShipperMeter, ShipperMeter);
	}

	/** Get Shipper Meter.
		@return Shipper Meter	  */
	public String getShipperMeter () 
	{
		return (String)get_Value(COLUMNNAME_ShipperMeter);
	}
}