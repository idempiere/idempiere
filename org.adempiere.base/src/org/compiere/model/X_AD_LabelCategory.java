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

/** Generated Model for AD_LabelCategory
 *  @author iDempiere (generated) 
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="AD_LabelCategory")
public class X_AD_LabelCategory extends PO implements I_AD_LabelCategory, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20221224L;

    /** Standard Constructor */
    public X_AD_LabelCategory (Properties ctx, int AD_LabelCategory_ID, String trxName)
    {
      super (ctx, AD_LabelCategory_ID, trxName);
      /** if (AD_LabelCategory_ID == 0)
        {
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_LabelCategory (Properties ctx, int AD_LabelCategory_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_LabelCategory_ID, trxName, virtualColumns);
      /** if (AD_LabelCategory_ID == 0)
        {
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_LabelCategory (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_LabelCategory[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Label Category.
		@param AD_LabelCategory_ID Category of a Label
	*/
	public void setAD_LabelCategory_ID (int AD_LabelCategory_ID)
	{
		if (AD_LabelCategory_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_LabelCategory_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_LabelCategory_ID, Integer.valueOf(AD_LabelCategory_ID));
	}

	/** Get Label Category.
		@return Category of a Label
	  */
	public int getAD_LabelCategory_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_LabelCategory_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Label Category.
		@param AD_LabelCategory_UU Category of a Label
	*/
	public void setAD_LabelCategory_UU (String AD_LabelCategory_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_LabelCategory_UU, AD_LabelCategory_UU);
	}

	/** Get Label Category.
		@return Category of a Label
	  */
	public String getAD_LabelCategory_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_LabelCategory_UU);
	}

	public org.compiere.model.I_AD_Style getAD_LabelStyle() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Style)MTable.get(getCtx(), org.compiere.model.I_AD_Style.Table_ID)
			.getPO(getAD_LabelStyle_ID(), get_TrxName());
	}

	/** Set Label Style.
		@param AD_LabelStyle_ID Label CSS Style
	*/
	public void setAD_LabelStyle_ID (int AD_LabelStyle_ID)
	{
		if (AD_LabelStyle_ID < 1)
			set_Value (COLUMNNAME_AD_LabelStyle_ID, null);
		else
			set_Value (COLUMNNAME_AD_LabelStyle_ID, Integer.valueOf(AD_LabelStyle_ID));
	}

	/** Get Label Style.
		@return Label CSS Style
	  */
	public int getAD_LabelStyle_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_LabelStyle_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	/** Set Can Be Used in All Tables.
		@param IsCanBeUsedInAllTables Can Be Used in All Tables
	*/
	public void setIsCanBeUsedInAllTables (boolean IsCanBeUsedInAllTables)
	{
		set_Value (COLUMNNAME_IsCanBeUsedInAllTables, Boolean.valueOf(IsCanBeUsedInAllTables));
	}

	/** Get Can Be Used in All Tables.
		@return Can Be Used in All Tables	  */
	public boolean isCanBeUsedInAllTables()
	{
		Object oo = get_Value(COLUMNNAME_IsCanBeUsedInAllTables);
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
}