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

/** Generated Model for C_AddressValidation
 *  @author iDempiere (generated) 
 *  @version Release 2.0 - $Id$ */
public class X_C_AddressValidation extends PO implements I_C_AddressValidation, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131031L;

    /** Standard Constructor */
    public X_C_AddressValidation (Properties ctx, int C_AddressValidation_ID, String trxName)
    {
      super (ctx, C_AddressValidation_ID, trxName);
      /** if (C_AddressValidation_ID == 0)
        {
			setC_AddressValidationCfg_ID (0);
			setC_AddressValidation_ID (0);
			setConnectionPassword (null);
			setName (null);
			setSeqNo (0);
			setUserID (null);
        } */
    }

    /** Load Constructor */
    public X_C_AddressValidation (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_C_AddressValidation[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_C_AddressValidationCfg getC_AddressValidationCfg() throws RuntimeException
    {
		return (org.compiere.model.I_C_AddressValidationCfg)MTable.get(getCtx(), org.compiere.model.I_C_AddressValidationCfg.Table_Name)
			.getPO(getC_AddressValidationCfg_ID(), get_TrxName());	}

	/** Set Address Validation Configuration.
		@param C_AddressValidationCfg_ID Address Validation Configuration	  */
	public void setC_AddressValidationCfg_ID (int C_AddressValidationCfg_ID)
	{
		if (C_AddressValidationCfg_ID < 1) 
			set_Value (COLUMNNAME_C_AddressValidationCfg_ID, null);
		else 
			set_Value (COLUMNNAME_C_AddressValidationCfg_ID, Integer.valueOf(C_AddressValidationCfg_ID));
	}

	/** Get Address Validation Configuration.
		@return Address Validation Configuration	  */
	public int getC_AddressValidationCfg_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_AddressValidationCfg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Address Validation.
		@param C_AddressValidation_ID Address Validation	  */
	public void setC_AddressValidation_ID (int C_AddressValidation_ID)
	{
		if (C_AddressValidation_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_AddressValidation_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_AddressValidation_ID, Integer.valueOf(C_AddressValidation_ID));
	}

	/** Get Address Validation.
		@return Address Validation	  */
	public int getC_AddressValidation_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_AddressValidation_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_AddressValidation_UU.
		@param C_AddressValidation_UU C_AddressValidation_UU	  */
	public void setC_AddressValidation_UU (String C_AddressValidation_UU)
	{
		set_Value (COLUMNNAME_C_AddressValidation_UU, C_AddressValidation_UU);
	}

	/** Get C_AddressValidation_UU.
		@return C_AddressValidation_UU	  */
	public String getC_AddressValidation_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_AddressValidation_UU);
	}

	/** Set Connection Key.
		@param ConnectionKey Connection Key	  */
	public void setConnectionKey (String ConnectionKey)
	{
		set_Value (COLUMNNAME_ConnectionKey, ConnectionKey);
	}

	/** Get Connection Key.
		@return Connection Key	  */
	public String getConnectionKey () 
	{
		return (String)get_Value(COLUMNNAME_ConnectionKey);
	}

	/** Set Connection Password.
		@param ConnectionPassword Connection Password	  */
	public void setConnectionPassword (String ConnectionPassword)
	{
		set_Value (COLUMNNAME_ConnectionPassword, ConnectionPassword);
	}

	/** Get Connection Password.
		@return Connection Password	  */
	public String getConnectionPassword () 
	{
		return (String)get_Value(COLUMNNAME_ConnectionPassword);
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

	/** Set Sequence.
		@param SeqNo 
		Method of ordering records; lowest number comes first
	  */
	public void setSeqNo (int SeqNo)
	{
		set_Value (COLUMNNAME_SeqNo, Integer.valueOf(SeqNo));
	}

	/** Get Sequence.
		@return Method of ordering records; lowest number comes first
	  */
	public int getSeqNo () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SeqNo);
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

	/** Set User ID.
		@param UserID 
		User ID or account number
	  */
	public void setUserID (String UserID)
	{
		set_Value (COLUMNNAME_UserID, UserID);
	}

	/** Get User ID.
		@return User ID or account number
	  */
	public String getUserID () 
	{
		return (String)get_Value(COLUMNNAME_UserID);
	}
}