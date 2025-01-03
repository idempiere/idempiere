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

/** Generated Model for AD_UserDef_Theme_Detail
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="AD_UserDef_Theme_Detail")
public class X_AD_UserDef_Theme_Detail extends PO implements I_AD_UserDef_Theme_Detail, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_AD_UserDef_Theme_Detail (Properties ctx, int AD_UserDef_Theme_Detail_ID, String trxName)
    {
      super (ctx, AD_UserDef_Theme_Detail_ID, trxName);
      /** if (AD_UserDef_Theme_Detail_ID == 0)
        {
			setAD_UserDef_Theme_Detail_ID (0);
			setAD_UserDef_Theme_ID (0);
			setCurrentValue (null);
			setNewValue (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_UserDef_Theme_Detail (Properties ctx, int AD_UserDef_Theme_Detail_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_UserDef_Theme_Detail_ID, trxName, virtualColumns);
      /** if (AD_UserDef_Theme_Detail_ID == 0)
        {
			setAD_UserDef_Theme_Detail_ID (0);
			setAD_UserDef_Theme_ID (0);
			setCurrentValue (null);
			setNewValue (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_UserDef_Theme_Detail (Properties ctx, String AD_UserDef_Theme_Detail_UU, String trxName)
    {
      super (ctx, AD_UserDef_Theme_Detail_UU, trxName);
      /** if (AD_UserDef_Theme_Detail_UU == null)
        {
			setAD_UserDef_Theme_Detail_ID (0);
			setAD_UserDef_Theme_ID (0);
			setCurrentValue (null);
			setNewValue (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_UserDef_Theme_Detail (Properties ctx, String AD_UserDef_Theme_Detail_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_UserDef_Theme_Detail_UU, trxName, virtualColumns);
      /** if (AD_UserDef_Theme_Detail_UU == null)
        {
			setAD_UserDef_Theme_Detail_ID (0);
			setAD_UserDef_Theme_ID (0);
			setCurrentValue (null);
			setNewValue (null);
        } */
    }

    /** Load Constructor */
    public X_AD_UserDef_Theme_Detail (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_UserDef_Theme_Detail[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Theme Customization Detail.
		@param AD_UserDef_Theme_Detail_ID Theme Customization Detail
	*/
	public void setAD_UserDef_Theme_Detail_ID (int AD_UserDef_Theme_Detail_ID)
	{
		if (AD_UserDef_Theme_Detail_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Theme_Detail_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Theme_Detail_ID, Integer.valueOf(AD_UserDef_Theme_Detail_ID));
	}

	/** Get Theme Customization Detail.
		@return Theme Customization Detail	  */
	public int getAD_UserDef_Theme_Detail_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Theme_Detail_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserDef_Theme_Detail_UU.
		@param AD_UserDef_Theme_Detail_UU AD_UserDef_Theme_Detail_UU
	*/
	public void setAD_UserDef_Theme_Detail_UU (String AD_UserDef_Theme_Detail_UU)
	{
		set_Value (COLUMNNAME_AD_UserDef_Theme_Detail_UU, AD_UserDef_Theme_Detail_UU);
	}

	/** Get AD_UserDef_Theme_Detail_UU.
		@return AD_UserDef_Theme_Detail_UU	  */
	public String getAD_UserDef_Theme_Detail_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_UserDef_Theme_Detail_UU);
	}

	public org.compiere.model.I_AD_UserDef_Theme getAD_UserDef_Theme() throws RuntimeException
	{
		return (org.compiere.model.I_AD_UserDef_Theme)MTable.get(getCtx(), org.compiere.model.I_AD_UserDef_Theme.Table_ID)
			.getPO(getAD_UserDef_Theme_ID(), get_TrxName());
	}

	/** Set Theme Customization.
		@param AD_UserDef_Theme_ID Theme Customization
	*/
	public void setAD_UserDef_Theme_ID (int AD_UserDef_Theme_ID)
	{
		if (AD_UserDef_Theme_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Theme_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Theme_ID, Integer.valueOf(AD_UserDef_Theme_ID));
	}

	/** Get Theme Customization.
		@return Theme Customization	  */
	public int getAD_UserDef_Theme_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Theme_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Current Value.
		@param CurrentValue Current Value
	*/
	public void setCurrentValue (String CurrentValue)
	{
		set_Value (COLUMNNAME_CurrentValue, CurrentValue);
	}

	/** Get Current Value.
		@return Current Value	  */
	public String getCurrentValue()
	{
		return (String)get_Value(COLUMNNAME_CurrentValue);
	}

	/** Set New Value.
		@param NewValue New field value
	*/
	public void setNewValue (String NewValue)
	{
		set_Value (COLUMNNAME_NewValue, NewValue);
	}

	/** Get New Value.
		@return New field value
	  */
	public String getNewValue()
	{
		return (String)get_Value(COLUMNNAME_NewValue);
	}
}