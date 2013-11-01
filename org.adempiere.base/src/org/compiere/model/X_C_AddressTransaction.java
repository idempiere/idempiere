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

/** Generated Model for C_AddressTransaction
 *  @author iDempiere (generated) 
 *  @version Release 2.0 - $Id$ */
public class X_C_AddressTransaction extends PO implements I_C_AddressTransaction, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20131031L;

    /** Standard Constructor */
    public X_C_AddressTransaction (Properties ctx, int C_AddressTransaction_ID, String trxName)
    {
      super (ctx, C_AddressTransaction_ID, trxName);
      /** if (C_AddressTransaction_ID == 0)
        {
			setC_AddressTransaction_ID (0);
			setC_AddressValidation_ID (0);
			setIsValid (false);
// N
			setProcessed (false);
// N
        } */
    }

    /** Load Constructor */
    public X_C_AddressTransaction (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_C_AddressTransaction[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Address 1.
		@param Address1 
		Address line 1 for this location
	  */
	public void setAddress1 (String Address1)
	{
		set_Value (COLUMNNAME_Address1, Address1);
	}

	/** Get Address 1.
		@return Address line 1 for this location
	  */
	public String getAddress1 () 
	{
		return (String)get_Value(COLUMNNAME_Address1);
	}

	/** Set Address 2.
		@param Address2 
		Address line 2 for this location
	  */
	public void setAddress2 (String Address2)
	{
		set_Value (COLUMNNAME_Address2, Address2);
	}

	/** Get Address 2.
		@return Address line 2 for this location
	  */
	public String getAddress2 () 
	{
		return (String)get_Value(COLUMNNAME_Address2);
	}

	/** Set Address 3.
		@param Address3 
		Address Line 3 for the location
	  */
	public void setAddress3 (String Address3)
	{
		set_Value (COLUMNNAME_Address3, Address3);
	}

	/** Get Address 3.
		@return Address Line 3 for the location
	  */
	public String getAddress3 () 
	{
		return (String)get_Value(COLUMNNAME_Address3);
	}

	/** Set Address 4.
		@param Address4 
		Address Line 4 for the location
	  */
	public void setAddress4 (String Address4)
	{
		set_Value (COLUMNNAME_Address4, Address4);
	}

	/** Get Address 4.
		@return Address Line 4 for the location
	  */
	public String getAddress4 () 
	{
		return (String)get_Value(COLUMNNAME_Address4);
	}

	/** Set Address Transaction.
		@param C_AddressTransaction_ID Address Transaction	  */
	public void setC_AddressTransaction_ID (int C_AddressTransaction_ID)
	{
		if (C_AddressTransaction_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_AddressTransaction_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_AddressTransaction_ID, Integer.valueOf(C_AddressTransaction_ID));
	}

	/** Get Address Transaction.
		@return Address Transaction	  */
	public int getC_AddressTransaction_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_AddressTransaction_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_AddressTransaction_UU.
		@param C_AddressTransaction_UU C_AddressTransaction_UU	  */
	public void setC_AddressTransaction_UU (String C_AddressTransaction_UU)
	{
		set_Value (COLUMNNAME_C_AddressTransaction_UU, C_AddressTransaction_UU);
	}

	/** Get C_AddressTransaction_UU.
		@return C_AddressTransaction_UU	  */
	public String getC_AddressTransaction_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_AddressTransaction_UU);
	}

	public org.compiere.model.I_C_AddressValidation getC_AddressValidation() throws RuntimeException
    {
		return (org.compiere.model.I_C_AddressValidation)MTable.get(getCtx(), org.compiere.model.I_C_AddressValidation.Table_Name)
			.getPO(getC_AddressValidation_ID(), get_TrxName());	}

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

	/** Set City.
		@param City 
		Identifies a City
	  */
	public void setCity (String City)
	{
		set_Value (COLUMNNAME_City, City);
	}

	/** Get City.
		@return Identifies a City
	  */
	public String getCity () 
	{
		return (String)get_Value(COLUMNNAME_City);
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getCity());
    }

	public I_C_Location getC_Location() throws RuntimeException
    {
		return (I_C_Location)MTable.get(getCtx(), I_C_Location.Table_Name)
			.getPO(getC_Location_ID(), get_TrxName());	}

	/** Set Address.
		@param C_Location_ID 
		Location or Address
	  */
	public void setC_Location_ID (int C_Location_ID)
	{
		if (C_Location_ID < 1) 
			set_Value (COLUMNNAME_C_Location_ID, null);
		else 
			set_Value (COLUMNNAME_C_Location_ID, Integer.valueOf(C_Location_ID));
	}

	/** Get Address.
		@return Location or Address
	  */
	public int getC_Location_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Location_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Country.
		@param Country Country	  */
	public void setCountry (String Country)
	{
		set_ValueNoCheck (COLUMNNAME_Country, Country);
	}

	/** Get Country.
		@return Country	  */
	public String getCountry () 
	{
		return (String)get_Value(COLUMNNAME_Country);
	}

	/** Set Valid.
		@param IsValid 
		Element is valid
	  */
	public void setIsValid (boolean IsValid)
	{
		set_Value (COLUMNNAME_IsValid, Boolean.valueOf(IsValid));
	}

	/** Get Valid.
		@return Element is valid
	  */
	public boolean isValid () 
	{
		Object oo = get_Value(COLUMNNAME_IsValid);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set ZIP.
		@param Postal 
		Postal code
	  */
	public void setPostal (String Postal)
	{
		set_Value (COLUMNNAME_Postal, Postal);
	}

	/** Get ZIP.
		@return Postal code
	  */
	public String getPostal () 
	{
		return (String)get_Value(COLUMNNAME_Postal);
	}

	/** Set Processed.
		@param Processed 
		The document has been processed
	  */
	public void setProcessed (boolean Processed)
	{
		set_Value (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/** Get Processed.
		@return The document has been processed
	  */
	public boolean isProcessed () 
	{
		Object oo = get_Value(COLUMNNAME_Processed);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Region.
		@param Region Region	  */
	public void setRegion (String Region)
	{
		set_ValueNoCheck (COLUMNNAME_Region, Region);
	}

	/** Get Region.
		@return Region	  */
	public String getRegion () 
	{
		return (String)get_Value(COLUMNNAME_Region);
	}

	/** Set Result.
		@param Result 
		Result of the action taken
	  */
	public void setResult (String Result)
	{
		set_ValueNoCheck (COLUMNNAME_Result, Result);
	}

	/** Get Result.
		@return Result of the action taken
	  */
	public String getResult () 
	{
		return (String)get_Value(COLUMNNAME_Result);
	}
}