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

/** Generated Model for AD_TableAttributeSet
 *  @author iDempiere (generated)
 *  @version Release 13 - $Id$ */
@org.adempiere.base.Model(table="AD_TableAttributeSet")
public class X_AD_TableAttributeSet extends PO implements I_AD_TableAttributeSet, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20250805L;

    /** Standard Constructor */
    public X_AD_TableAttributeSet (Properties ctx, int AD_TableAttributeSet_ID, String trxName)
    {
      super (ctx, AD_TableAttributeSet_ID, trxName);
      /** if (AD_TableAttributeSet_ID == 0)
        {
			setAD_TableAttributeSet_ID (0);
			setAD_Table_ID (0);
			setM_AttributeSet_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_TableAttributeSet (Properties ctx, int AD_TableAttributeSet_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_TableAttributeSet_ID, trxName, virtualColumns);
      /** if (AD_TableAttributeSet_ID == 0)
        {
			setAD_TableAttributeSet_ID (0);
			setAD_Table_ID (0);
			setM_AttributeSet_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_TableAttributeSet (Properties ctx, String AD_TableAttributeSet_UU, String trxName)
    {
      super (ctx, AD_TableAttributeSet_UU, trxName);
      /** if (AD_TableAttributeSet_UU == null)
        {
			setAD_TableAttributeSet_ID (0);
			setAD_Table_ID (0);
			setM_AttributeSet_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_TableAttributeSet (Properties ctx, String AD_TableAttributeSet_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_TableAttributeSet_UU, trxName, virtualColumns);
      /** if (AD_TableAttributeSet_UU == null)
        {
			setAD_TableAttributeSet_ID (0);
			setAD_Table_ID (0);
			setM_AttributeSet_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_TableAttributeSet (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 4 - System
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
      StringBuilder sb = new StringBuilder ("X_AD_TableAttributeSet[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Table Attribute Set.
		@param AD_TableAttributeSet_ID Table Attribute Set
	*/
	public void setAD_TableAttributeSet_ID (int AD_TableAttributeSet_ID)
	{
		if (AD_TableAttributeSet_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_TableAttributeSet_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_TableAttributeSet_ID, Integer.valueOf(AD_TableAttributeSet_ID));
	}

	/** Get Table Attribute Set.
		@return Table Attribute Set	  */
	public int getAD_TableAttributeSet_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_TableAttributeSet_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_TableAttributeSet_UU.
		@param AD_TableAttributeSet_UU AD_TableAttributeSet_UU
	*/
	public void setAD_TableAttributeSet_UU (String AD_TableAttributeSet_UU)
	{
		set_Value (COLUMNNAME_AD_TableAttributeSet_UU, AD_TableAttributeSet_UU);
	}

	/** Get AD_TableAttributeSet_UU.
		@return AD_TableAttributeSet_UU	  */
	public String getAD_TableAttributeSet_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_TableAttributeSet_UU);
	}

	@Deprecated(since="13") // use better methods with cache
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
			set_ValueNoCheck (COLUMNNAME_AD_Table_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Table_ID, Integer.valueOf(AD_Table_ID));
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

	@Deprecated(since="13") // use better methods with cache
	public org.compiere.model.I_M_AttributeSet getM_AttributeSet() throws RuntimeException
	{
		return (org.compiere.model.I_M_AttributeSet)MTable.get(getCtx(), org.compiere.model.I_M_AttributeSet.Table_ID)
			.getPO(getM_AttributeSet_ID(), get_TrxName());
	}

	/** Set Attribute Set.
		@param M_AttributeSet_ID Product Attribute Set
	*/
	public void setM_AttributeSet_ID (int M_AttributeSet_ID)
	{
		if (M_AttributeSet_ID < 0)
			set_Value (COLUMNNAME_M_AttributeSet_ID, null);
		else
			set_Value (COLUMNNAME_M_AttributeSet_ID, Integer.valueOf(M_AttributeSet_ID));
	}

	/** Get Attribute Set.
		@return Product Attribute Set
	  */
	public int getM_AttributeSet_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_M_AttributeSet_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}