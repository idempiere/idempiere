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

/** Generated Model for C_Label
 *  @author iDempiere (generated) 
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="C_Label")
public class X_C_Label extends PO implements I_C_Label, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220415L;

    /** Standard Constructor */
    public X_C_Label (Properties ctx, int C_Label_ID, String trxName)
    {
      super (ctx, C_Label_ID, trxName);
      /** if (C_Label_ID == 0)
        {
			setC_Label_ID (0);
			setC_LabelCategory_ID (0);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_C_Label (Properties ctx, int C_Label_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, C_Label_ID, trxName, virtualColumns);
      /** if (C_Label_ID == 0)
        {
			setC_Label_ID (0);
			setC_LabelCategory_ID (0);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_C_Label (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_C_Label[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Label.
		@param C_Label_ID Label
	*/
	public void setC_Label_ID (int C_Label_ID)
	{
		if (C_Label_ID < 1)
			set_ValueNoCheck (COLUMNNAME_C_Label_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_C_Label_ID, Integer.valueOf(C_Label_ID));
	}

	/** Get Label.
		@return Label	  */
	public int getC_Label_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_C_Label_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set C_Label_UU.
		@param C_Label_UU C_Label_UU
	*/
	public void setC_Label_UU (String C_Label_UU)
	{
		set_Value (COLUMNNAME_C_Label_UU, C_Label_UU);
	}

	/** Get C_Label_UU.
		@return C_Label_UU	  */
	public String getC_Label_UU()
	{
		return (String)get_Value(COLUMNNAME_C_Label_UU);
	}

	public org.compiere.model.I_C_LabelCategory getC_LabelCategory() throws RuntimeException
	{
		return (org.compiere.model.I_C_LabelCategory)MTable.get(getCtx(), org.compiere.model.I_C_LabelCategory.Table_ID)
			.getPO(getC_LabelCategory_ID(), get_TrxName());
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