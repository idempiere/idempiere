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
import java.sql.Timestamp;
import java.util.Properties;

/** Generated Model for C_CountryGroupCountry
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="C_CountryGroupCountry")
public class X_C_CountryGroupCountry extends PO implements I_C_CountryGroupCountry, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_C_CountryGroupCountry (Properties ctx, int C_CountryGroupCountry_ID, String trxName)
    {
      super (ctx, C_CountryGroupCountry_ID, trxName);
      /** if (C_CountryGroupCountry_ID == 0)
        {
			setC_CountryGroupCountry_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_C_CountryGroupCountry (Properties ctx, int C_CountryGroupCountry_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_CountryGroupCountry_ID, trxName, virtualColumns);
      /** if (C_CountryGroupCountry_ID == 0)
        {
			setC_CountryGroupCountry_ID (0);
        } */
    }

    /** Load Constructor */
    public X_C_CountryGroupCountry (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 7 - System - Client - Org 
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
      StringBuilder sb = new StringBuilder ("X_C_CountryGroupCountry[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Country on Country Group.
		@param C_CountryGroupCountry_ID Country on Country Group
	*/
	public void setC_CountryGroupCountry_ID (int C_CountryGroupCountry_ID)
	{
		if (C_CountryGroupCountry_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_CountryGroupCountry_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_CountryGroupCountry_ID, Integer.valueOf(C_CountryGroupCountry_ID));
	}

	/** Get Country on Country Group.
		@return Country on Country Group	  */
	public int getC_CountryGroupCountry_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_CountryGroupCountry_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_CountryGroupCountry_UU.
		@param C_CountryGroupCountry_UU C_CountryGroupCountry_UU
	*/
	public void setC_CountryGroupCountry_UU (String C_CountryGroupCountry_UU)
	{
		set_Value (COLUMNNAME_C_CountryGroupCountry_UU, C_CountryGroupCountry_UU);
	}

	/** Get C_CountryGroupCountry_UU.
		@return C_CountryGroupCountry_UU	  */
	public String getC_CountryGroupCountry_UU()
	{
		return (String)get_Value(COLUMNNAME_C_CountryGroupCountry_UU);
	}

	public org.compiere.model.I_C_CountryGroup getC_CountryGroup() throws RuntimeException
	{
		return (org.compiere.model.I_C_CountryGroup)MTable.get(getCtx(), org.compiere.model.I_C_CountryGroup.Table_ID)
			.getPO(getC_CountryGroup_ID(), get_TrxName());
	}

	/** Set Country Group.
		@param C_CountryGroup_ID Country Group
	*/
	public void setC_CountryGroup_ID (int C_CountryGroup_ID)
	{
		if (C_CountryGroup_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_CountryGroup_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_CountryGroup_ID, Integer.valueOf(C_CountryGroup_ID));
	}

	/** Get Country Group.
		@return Country Group	  */
	public int getC_CountryGroup_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_CountryGroup_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Country getC_Country() throws RuntimeException
	{
		return (org.compiere.model.I_C_Country)MTable.get(getCtx(), org.compiere.model.I_C_Country.Table_ID)
			.getPO(getC_Country_ID(), get_TrxName());
	}

	/** Set Country.
		@param C_Country_ID Country 
	*/
	public void setC_Country_ID (int C_Country_ID)
	{
		if (C_Country_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_Country_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_Country_ID, Integer.valueOf(C_Country_ID));
	}

	/** Get Country.
		@return Country 
	  */
	public int getC_Country_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Country_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Date From.
		@param DateFrom Starting date for a range
	*/
	public void setDateFrom (Timestamp DateFrom)
	{
		set_Value (COLUMNNAME_DateFrom, DateFrom);
	}

	/** Get Date From.
		@return Starting date for a range
	  */
	public Timestamp getDateFrom()
	{
		return (Timestamp)get_Value(COLUMNNAME_DateFrom);
	}

	/** Set Date To.
		@param DateTo End date of a date range
	*/
	public void setDateTo (Timestamp DateTo)
	{
		set_Value (COLUMNNAME_DateTo, DateTo);
	}

	/** Get Date To.
		@return End date of a date range
	  */
	public Timestamp getDateTo()
	{
		return (Timestamp)get_Value(COLUMNNAME_DateTo);
	}
}