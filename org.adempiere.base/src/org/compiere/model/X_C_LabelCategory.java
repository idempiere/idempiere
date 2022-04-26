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

/** Generated Model for C_LabelCategory
 *  @author iDempiere (generated) 
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="C_LabelCategory")
public class X_C_LabelCategory extends PO implements I_C_LabelCategory, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220426L;

    /** Standard Constructor */
    public X_C_LabelCategory (Properties ctx, int C_LabelCategory_ID, String trxName)
    {
      super (ctx, C_LabelCategory_ID, trxName);
      /** if (C_LabelCategory_ID == 0)
        {
			setC_LabelCategory_ID (0);
			setIsDefault (false);
// N
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_C_LabelCategory (Properties ctx, int C_LabelCategory_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_LabelCategory_ID, trxName, virtualColumns);
      /** if (C_LabelCategory_ID == 0)
        {
			setC_LabelCategory_ID (0);
			setIsDefault (false);
// N
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_C_LabelCategory (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_C_LabelCategory[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Label Category.
		@param C_LabelCategory_ID Label Category
	*/
	public void setC_LabelCategory_ID (int C_LabelCategory_ID)
	{
		if (C_LabelCategory_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_LabelCategory_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_LabelCategory_ID, Integer.valueOf(C_LabelCategory_ID));
	}

	/** Get Label Category.
		@return Label Category	  */
	public int getC_LabelCategory_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_LabelCategory_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_LabelCategory_UU.
		@param C_LabelCategory_UU C_LabelCategory_UU
	*/
	public void setC_LabelCategory_UU (String C_LabelCategory_UU)
	{
		set_Value (COLUMNNAME_C_LabelCategory_UU, C_LabelCategory_UU);
	}

	/** Get C_LabelCategory_UU.
		@return C_LabelCategory_UU	  */
	public String getC_LabelCategory_UU()
	{
		return (String)get_Value(COLUMNNAME_C_LabelCategory_UU);
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
}