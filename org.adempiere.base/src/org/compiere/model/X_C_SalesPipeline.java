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

/** Generated Model for C_SalesPipeline
 *  @author iDempiere (generated)
 *  @version Release 14 - $Id$ */
@org.adempiere.base.Model(table="C_SalesPipeline")
public class X_C_SalesPipeline extends PO implements I_C_SalesPipeline, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20260528L;

    /** Standard Constructor */
    public X_C_SalesPipeline (Properties ctx, int C_SalesPipeline_ID, String trxName)
    {
      super (ctx, C_SalesPipeline_ID, trxName);
      /** if (C_SalesPipeline_ID == 0)
        {
			setC_SalesPipeline_ID (0);
			setIsDefault (false);
// N
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_C_SalesPipeline (Properties ctx, int C_SalesPipeline_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_SalesPipeline_ID, trxName, virtualColumns);
      /** if (C_SalesPipeline_ID == 0)
        {
			setC_SalesPipeline_ID (0);
			setIsDefault (false);
// N
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_C_SalesPipeline (Properties ctx, String C_SalesPipeline_UU, String trxName)
    {
      super (ctx, C_SalesPipeline_UU, trxName);
      /** if (C_SalesPipeline_UU == null)
        {
			setC_SalesPipeline_ID (0);
			setIsDefault (false);
// N
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_C_SalesPipeline (Properties ctx, String C_SalesPipeline_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, C_SalesPipeline_UU, trxName, virtualColumns);
      /** if (C_SalesPipeline_UU == null)
        {
			setC_SalesPipeline_ID (0);
			setIsDefault (false);
// N
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_C_SalesPipeline (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_C_SalesPipeline[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Sales Pipeline.
		@param C_SalesPipeline_ID Defines a sales pipeline (e.g. &quot;Standard Sales&quot;, &quot;Complex Project&quot;, etc.)
	*/
	public void setC_SalesPipeline_ID (int C_SalesPipeline_ID)
	{
		if (C_SalesPipeline_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_SalesPipeline_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_SalesPipeline_ID, Integer.valueOf(C_SalesPipeline_ID));
	}

	/** Get Sales Pipeline.
		@return Defines a sales pipeline (e.g. &quot;Standard Sales&quot;, &quot;Complex Project&quot;, etc.)
	  */
	public int getC_SalesPipeline_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_SalesPipeline_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_SalesPipeline_UU.
		@param C_SalesPipeline_UU C_SalesPipeline_UU
	*/
	public void setC_SalesPipeline_UU (String C_SalesPipeline_UU)
	{
		set_Value (COLUMNNAME_C_SalesPipeline_UU, C_SalesPipeline_UU);
	}

	/** Get C_SalesPipeline_UU.
		@return C_SalesPipeline_UU	  */
	public String getC_SalesPipeline_UU()
	{
		return (String)get_Value(COLUMNNAME_C_SalesPipeline_UU);
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

	/** Set Default.
		@param IsDefault Default value
	*/
	public void setIsDefault (boolean IsDefault)
	{
		set_Value (COLUMNNAME_IsDefault, Boolean.valueOf(IsDefault));
	}

	/** Get Default.
		@return Default value
	  */
	public boolean isDefault()
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