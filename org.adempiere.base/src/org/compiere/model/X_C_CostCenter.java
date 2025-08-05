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

/** Generated Model for C_CostCenter
 *  @author iDempiere (generated)
 *  @version Release 13 - $Id$ */
@org.adempiere.base.Model(table="C_CostCenter")
public class X_C_CostCenter extends PO implements I_C_CostCenter, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20250805L;

    /** Standard Constructor */
    public X_C_CostCenter (Properties ctx, int C_CostCenter_ID, String trxName)
    {
      super (ctx, C_CostCenter_ID, trxName);
      /** if (C_CostCenter_ID == 0)
        {
			setValue (null);
        } */
    }

    /** Standard Constructor */
    public X_C_CostCenter (Properties ctx, int C_CostCenter_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_CostCenter_ID, trxName, virtualColumns);
      /** if (C_CostCenter_ID == 0)
        {
			setValue (null);
        } */
    }

    /** Standard Constructor */
    public X_C_CostCenter (Properties ctx, String C_CostCenter_UU, String trxName)
    {
      super (ctx, C_CostCenter_UU, trxName);
      /** if (C_CostCenter_UU == null)
        {
			setValue (null);
        } */
    }

    /** Standard Constructor */
    public X_C_CostCenter (Properties ctx, String C_CostCenter_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, C_CostCenter_UU, trxName, virtualColumns);
      /** if (C_CostCenter_UU == null)
        {
			setValue (null);
        } */
    }

    /** Load Constructor */
    public X_C_CostCenter (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_C_CostCenter[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Cost Center.
		@param C_CostCenter_ID Cost Center
	*/
	public void setC_CostCenter_ID (int C_CostCenter_ID)
	{
		if (C_CostCenter_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_CostCenter_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_CostCenter_ID, Integer.valueOf(C_CostCenter_ID));
	}

	/** Get Cost Center.
		@return Cost Center	  */
	public int getC_CostCenter_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_CostCenter_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Cost Center UU.
		@param C_CostCenter_UU Cost Center UU
	*/
	public void setC_CostCenter_UU (String C_CostCenter_UU)
	{
		set_ValueNoCheck (COLUMNNAME_C_CostCenter_UU, C_CostCenter_UU);
	}

	/** Get Cost Center UU.
		@return Cost Center UU	  */
	public String getC_CostCenter_UU()
	{
		return (String)get_Value(COLUMNNAME_C_CostCenter_UU);
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

	/** Set Search Key.
		@param Value Search key for the record in the format required - must be unique
	*/
	public void setValue (String Value)
	{
		set_Value (COLUMNNAME_Value, Value);
	}

	/** Get Search Key.
		@return Search key for the record in the format required - must be unique
	  */
	public String getValue()
	{
		return (String)get_Value(COLUMNNAME_Value);
	}
}