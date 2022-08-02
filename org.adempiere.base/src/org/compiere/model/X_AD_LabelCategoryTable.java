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

/** Generated Model for AD_LabelCategoryTable
 *  @author iDempiere (generated) 
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="AD_LabelCategoryTable")
public class X_AD_LabelCategoryTable extends PO implements I_AD_LabelCategoryTable, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220525L;

    /** Standard Constructor */
    public X_AD_LabelCategoryTable (Properties ctx, int AD_LabelCategoryTable_ID, String trxName)
    {
      super (ctx, AD_LabelCategoryTable_ID, trxName);
      /** if (AD_LabelCategoryTable_ID == 0)
        {
			setAD_LabelCategory_ID (0);
			setAD_Table_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_LabelCategoryTable (Properties ctx, int AD_LabelCategoryTable_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_LabelCategoryTable_ID, trxName, virtualColumns);
      /** if (AD_LabelCategoryTable_ID == 0)
        {
			setAD_LabelCategory_ID (0);
			setAD_Table_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_LabelCategoryTable (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_LabelCategoryTable[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_LabelCategory getAD_LabelCategory() throws RuntimeException
	{
		return (org.compiere.model.I_AD_LabelCategory)MTable.get(getCtx(), org.compiere.model.I_AD_LabelCategory.Table_ID)
			.getPO(getAD_LabelCategory_ID(), get_TrxName());
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

	/** Set Label Category Table Access.
		@param AD_LabelCategoryTable_ID Label Category Table Access
	*/
	public void setAD_LabelCategoryTable_ID (int AD_LabelCategoryTable_ID)
	{
		if (AD_LabelCategoryTable_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_LabelCategoryTable_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_LabelCategoryTable_ID, Integer.valueOf(AD_LabelCategoryTable_ID));
	}

	/** Get Label Category Table Access.
		@return Label Category Table Access	  */
	public int getAD_LabelCategoryTable_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_LabelCategoryTable_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Label Category Table Access.
		@param AD_LabelCategoryTable_UU Label Category Table Access
	*/
	public void setAD_LabelCategoryTable_UU (String AD_LabelCategoryTable_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_LabelCategoryTable_UU, AD_LabelCategoryTable_UU);
	}

	/** Get Label Category Table Access.
		@return Label Category Table Access	  */
	public String getAD_LabelCategoryTable_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_LabelCategoryTable_UU);
	}

	public org.compiere.model.I_AD_Table getAD_Table() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Table)MTable.get(getCtx(), org.compiere.model.I_AD_Table.Table_ID)
			.getPO(getAD_Table_ID(), get_TrxName());
	}

	/** Set Table.
		@param AD_Table_ID Database Table information
	*/
	public void setAD_Table_ID (int AD_Table_ID)
	{
		if (AD_Table_ID < 1)
			set_Value (COLUMNNAME_AD_Table_ID, null);
		else
			set_Value (COLUMNNAME_AD_Table_ID, Integer.valueOf(AD_Table_ID));
	}

	/** Get Table.
		@return Database Table information
	  */
	public int getAD_Table_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Table_ID);
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
}