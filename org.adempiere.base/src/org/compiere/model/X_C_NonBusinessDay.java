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
import org.compiere.util.KeyNamePair;

/** Generated Model for C_NonBusinessDay
 *  @author iDempiere (generated) 
 *  @version Release 7.1 - $Id$ */
public class X_C_NonBusinessDay extends PO implements I_C_NonBusinessDay, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20200413L;

    /** Standard Constructor */
    public X_C_NonBusinessDay (Properties ctx, int C_NonBusinessDay_ID, String trxName)
    {
      super (ctx, C_NonBusinessDay_ID, trxName);
      /** if (C_NonBusinessDay_ID == 0)
        {
			setC_Calendar_ID (0);
			setC_NonBusinessDay_ID (0);
			setDate1 (new Timestamp( System.currentTimeMillis() ));
        } */
    }

    /** Load Constructor */
    public X_C_NonBusinessDay (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_C_NonBusinessDay[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_C_Calendar getC_Calendar() throws RuntimeException
    {
		return (org.compiere.model.I_C_Calendar)MTable.get(getCtx(), org.compiere.model.I_C_Calendar.Table_Name)
			.getPO(getC_Calendar_ID(), get_TrxName());	}

	/** Set Calendar.
		@param C_Calendar_ID 
		Accounting Calendar Name
	  */
	public void setC_Calendar_ID (int C_Calendar_ID)
	{
		if (C_Calendar_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_Calendar_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_Calendar_ID, Integer.valueOf(C_Calendar_ID));
	}

	/** Get Calendar.
		@return Accounting Calendar Name
	  */
	public int getC_Calendar_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Calendar_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_C_Country getC_Country() throws RuntimeException
    {
		return (org.compiere.model.I_C_Country)MTable.get(getCtx(), org.compiere.model.I_C_Country.Table_Name)
			.getPO(getC_Country_ID(), get_TrxName());	}

	/** Set Country.
		@param C_Country_ID 
		Country 
	  */
	public void setC_Country_ID (int C_Country_ID)
	{
		if (C_Country_ID < 1) 
			set_Value (COLUMNNAME_C_Country_ID, null);
		else 
			set_Value (COLUMNNAME_C_Country_ID, Integer.valueOf(C_Country_ID));
	}

	/** Get Country.
		@return Country 
	  */
	public int getC_Country_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Country_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Non Business Day.
		@param C_NonBusinessDay_ID 
		Day on which business is not transacted
	  */
	public void setC_NonBusinessDay_ID (int C_NonBusinessDay_ID)
	{
		if (C_NonBusinessDay_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_C_NonBusinessDay_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_C_NonBusinessDay_ID, Integer.valueOf(C_NonBusinessDay_ID));
	}

	/** Get Non Business Day.
		@return Day on which business is not transacted
	  */
	public int getC_NonBusinessDay_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_NonBusinessDay_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_NonBusinessDay_UU.
		@param C_NonBusinessDay_UU C_NonBusinessDay_UU	  */
	public void setC_NonBusinessDay_UU (String C_NonBusinessDay_UU)
	{
		set_Value (COLUMNNAME_C_NonBusinessDay_UU, C_NonBusinessDay_UU);
	}

	/** Get C_NonBusinessDay_UU.
		@return C_NonBusinessDay_UU	  */
	public String getC_NonBusinessDay_UU () 
	{
		return (String)get_Value(COLUMNNAME_C_NonBusinessDay_UU);
	}

	/** Set Date.
		@param Date1 
		Date when business is not conducted
	  */
	public void setDate1 (Timestamp Date1)
	{
		set_Value (COLUMNNAME_Date1, Date1);
	}

	/** Get Date.
		@return Date when business is not conducted
	  */
	public Timestamp getDate1 () 
	{
		return (Timestamp)get_Value(COLUMNNAME_Date1);
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
}