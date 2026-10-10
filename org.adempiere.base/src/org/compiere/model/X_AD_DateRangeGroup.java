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


/** Generated Model for AD_DateRangeGroup
 *  @author iDempiere (generated) 
 *  @version Release 14 - $Id$ */
@org.adempiere.base.Model(table="AD_DateRangeGroup")
public class X_AD_DateRangeGroup extends PO implements I_AD_DateRangeGroup, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20261009L;

    /** Standard Constructor */
    public X_AD_DateRangeGroup (Properties ctx, int AD_DateRangeGroup_ID, String trxName)
    {
      super (ctx, AD_DateRangeGroup_ID, trxName);
      /** if (AD_DateRangeGroup_ID == 0)
        {
			setAD_DateRangeGroup_ID (0);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_DateRangeGroup (Properties ctx, int AD_DateRangeGroup_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_DateRangeGroup_ID, trxName, virtualColumns);
      /** if (AD_DateRangeGroup_ID == 0)
        {
			setAD_DateRangeGroup_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_DateRangeGroup (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_DateRangeGroup[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Date Range Group.
		@param AD_DateRangeGroup_ID Group of date ranges
	*/
	public void setAD_DateRangeGroup_ID (int AD_DateRangeGroup_ID)
	{
		if (AD_DateRangeGroup_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_DateRangeGroup_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_DateRangeGroup_ID, Integer.valueOf(AD_DateRangeGroup_ID));
	}

	/** Get Date Range Group.
		@return Group of date ranges
	  */
	public int getAD_DateRangeGroup_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_DateRangeGroup_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_DateRangeGroup_UU.
		@param AD_DateRangeGroup_UU AD_DateRangeGroup_UU
	*/
	public void setAD_DateRangeGroup_UU (String AD_DateRangeGroup_UU)
	{
		set_Value (COLUMNNAME_AD_DateRangeGroup_UU, AD_DateRangeGroup_UU);
	}

	/** Get AD_DateRangeGroup_UU.
		@return AD_DateRangeGroup_UU	  */
	public String getAD_DateRangeGroup_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_DateRangeGroup_UU);
	}

	/** Set Description.
		@param Description Optional short description of the record
	*/
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription()
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Name.
		@param Name Alphanumeric identifier of the entity
	*/
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName()
	{
		return (String)get_Value(COLUMNNAME_Name);
	}
}