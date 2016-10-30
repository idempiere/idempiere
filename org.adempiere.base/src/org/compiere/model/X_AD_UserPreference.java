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

/** Generated Model for AD_UserPreference
 *  @author iDempiere (generated) 
 *  @version Release 4.1 - $Id$ */
public class X_AD_UserPreference extends PO implements I_AD_UserPreference, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20161030L;

    /** Standard Constructor */
    public X_AD_UserPreference (Properties ctx, int AD_UserPreference_ID, String trxName)
    {
      super (ctx, AD_UserPreference_ID, trxName);
      /** if (AD_UserPreference_ID == 0)
        {
			setAD_User_ID (0);
			setAD_UserPreference_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_UserPreference (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_AD_UserPreference[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
    {
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_Name)
			.getPO(getAD_User_ID(), get_TrxName());	}

	/** Set User/Contact.
		@param AD_User_ID 
		User within the system - Internal or Business Partner Contact
	  */
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
	}

	/** Get User/Contact.
		@return User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_User_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserPreference_ID.
		@param AD_UserPreference_ID AD_UserPreference_ID	  */
	public void setAD_UserPreference_ID (int AD_UserPreference_ID)
	{
		if (AD_UserPreference_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_UserPreference_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_UserPreference_ID, Integer.valueOf(AD_UserPreference_ID));
	}

	/** Get AD_UserPreference_ID.
		@return AD_UserPreference_ID	  */
	public int getAD_UserPreference_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserPreference_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserPreference_UU.
		@param AD_UserPreference_UU AD_UserPreference_UU	  */
	public void setAD_UserPreference_UU (String AD_UserPreference_UU)
	{
		set_Value (COLUMNNAME_AD_UserPreference_UU, AD_UserPreference_UU);
	}

	/** Get AD_UserPreference_UU.
		@return AD_UserPreference_UU	  */
	public String getAD_UserPreference_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_UserPreference_UU);
	}

	/** Set Automatic Commit.
		@param AutoCommit Automatic Commit	  */
	public void setAutoCommit (boolean AutoCommit)
	{
		set_Value (COLUMNNAME_AutoCommit, Boolean.valueOf(AutoCommit));
	}

	/** Get Automatic Commit.
		@return Automatic Commit	  */
	public boolean isAutoCommit () 
	{
		Object oo = get_Value(COLUMNNAME_AutoCommit);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Automatic Decimal Places For Amounts.
		@param AutomaticDecimalPlacesForAmoun 
		Automatically insert a decimal point
	  */
	public void setAutomaticDecimalPlacesForAmoun (int AutomaticDecimalPlacesForAmoun)
	{
		set_Value (COLUMNNAME_AutomaticDecimalPlacesForAmoun, Integer.valueOf(AutomaticDecimalPlacesForAmoun));
	}

	/** Get Automatic Decimal Places For Amounts.
		@return Automatically insert a decimal point
	  */
	public int getAutomaticDecimalPlacesForAmoun () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AutomaticDecimalPlacesForAmoun);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Automatic New Record.
		@param AutoNew Automatic New Record	  */
	public void setAutoNew (boolean AutoNew)
	{
		set_Value (COLUMNNAME_AutoNew, Boolean.valueOf(AutoNew));
	}

	/** Get Automatic New Record.
		@return Automatic New Record	  */
	public boolean isAutoNew () 
	{
		Object oo = get_Value(COLUMNNAME_AutoNew);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Toggle on Double Click.
		@param ToggleOnDoubleClick 
		Defines if double click in a field on grid mode switch to form view
	  */
	public void setToggleOnDoubleClick (boolean ToggleOnDoubleClick)
	{
		set_Value (COLUMNNAME_ToggleOnDoubleClick, Boolean.valueOf(ToggleOnDoubleClick));
	}

	/** Get Toggle on Double Click.
		@return Defines if double click in a field on grid mode switch to form view
	  */
	public boolean isToggleOnDoubleClick () 
	{
		Object oo = get_Value(COLUMNNAME_ToggleOnDoubleClick);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}
}