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
import org.compiere.util.KeyNamePair;

/** Generated Model for AD_Preference
 *  @author iDempiere (generated) 
 *  @version Release 7.1 - $Id$ */
public class X_AD_Preference extends PO implements I_AD_Preference, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20200413L;

    /** Standard Constructor */
    public X_AD_Preference (Properties ctx, int AD_Preference_ID, String trxName)
    {
      super (ctx, AD_Preference_ID, trxName);
      /** if (AD_Preference_ID == 0)
        {
			setAD_Preference_ID (0);
			setAttribute (null);
			setPreferenceFor (null);
// W
			setValue (null);
        } */
    }

    /** Load Constructor */
    public X_AD_Preference (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_Preference[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_InfoWindow getAD_InfoWindow() throws RuntimeException
    {
		return (org.compiere.model.I_AD_InfoWindow)MTable.get(getCtx(), org.compiere.model.I_AD_InfoWindow.Table_Name)
			.getPO(getAD_InfoWindow_ID(), get_TrxName());	}

	/** Set Info Window.
		@param AD_InfoWindow_ID 
		Info and search/select Window
	  */
	public void setAD_InfoWindow_ID (int AD_InfoWindow_ID)
	{
		if (AD_InfoWindow_ID < 1) 
			set_Value (COLUMNNAME_AD_InfoWindow_ID, null);
		else 
			set_Value (COLUMNNAME_AD_InfoWindow_ID, Integer.valueOf(AD_InfoWindow_ID));
	}

	/** Get Info Window.
		@return Info and search/select Window
	  */
	public int getAD_InfoWindow_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_InfoWindow_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Preference.
		@param AD_Preference_ID 
		Personal Value Preference
	  */
	public void setAD_Preference_ID (int AD_Preference_ID)
	{
		if (AD_Preference_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_Preference_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_Preference_ID, Integer.valueOf(AD_Preference_ID));
	}

	/** Get Preference.
		@return Personal Value Preference
	  */
	public int getAD_Preference_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Preference_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_Preference_UU.
		@param AD_Preference_UU AD_Preference_UU	  */
	public void setAD_Preference_UU (String AD_Preference_UU)
	{
		set_Value (COLUMNNAME_AD_Preference_UU, AD_Preference_UU);
	}

	/** Get AD_Preference_UU.
		@return AD_Preference_UU	  */
	public String getAD_Preference_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_Preference_UU);
	}

	public org.compiere.model.I_AD_Process getAD_Process() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Process)MTable.get(getCtx(), org.compiere.model.I_AD_Process.Table_Name)
			.getPO(getAD_Process_ID(), get_TrxName());	}

	/** Set Process.
		@param AD_Process_ID 
		Process or Report
	  */
	public void setAD_Process_ID (int AD_Process_ID)
	{
		if (AD_Process_ID < 1) 
			set_Value (COLUMNNAME_AD_Process_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Process_ID, Integer.valueOf(AD_Process_ID));
	}

	/** Get Process.
		@return Process or Report
	  */
	public int getAD_Process_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Process_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_AllUsers_V getAD_User() throws RuntimeException
    {
		return (org.compiere.model.I_AD_AllUsers_V)MTable.get(getCtx(), org.compiere.model.I_AD_AllUsers_V.Table_Name)
			.getPO(getAD_User_ID(), get_TrxName());	}

	/** Set User/Contact.
		@param AD_User_ID 
		User within the system - Internal or Business Partner Contact
	  */
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID < 1) 
			set_Value (COLUMNNAME_AD_User_ID, null);
		else 
			set_Value (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
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

	public org.compiere.model.I_AD_Window getAD_Window() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Window)MTable.get(getCtx(), org.compiere.model.I_AD_Window.Table_Name)
			.getPO(getAD_Window_ID(), get_TrxName());	}

	/** Set Window.
		@param AD_Window_ID 
		Data entry or display window
	  */
	public void setAD_Window_ID (int AD_Window_ID)
	{
		if (AD_Window_ID < 1) 
			set_Value (COLUMNNAME_AD_Window_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Window_ID, Integer.valueOf(AD_Window_ID));
	}

	/** Get Window.
		@return Data entry or display window
	  */
	public int getAD_Window_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Window_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Attribute.
		@param Attribute Attribute	  */
	public void setAttribute (String Attribute)
	{
		set_Value (COLUMNNAME_Attribute, Attribute);
	}

	/** Get Attribute.
		@return Attribute	  */
	public String getAttribute () 
	{
		return (String)get_Value(COLUMNNAME_Attribute);
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getAttribute());
    }

	/** PreferenceFor AD_Reference_ID=200084 */
	public static final int PREFERENCEFOR_AD_Reference_ID=200084;
	/** Window = W */
	public static final String PREFERENCEFOR_Window = "W";
	/** Process = P */
	public static final String PREFERENCEFOR_Process = "P";
	/** Set Preference For.
		@param PreferenceFor 
		Type of preference, it can window, info window or parameter process
	  */
	public void setPreferenceFor (String PreferenceFor)
	{

		set_Value (COLUMNNAME_PreferenceFor, PreferenceFor);
	}

	/** Get Preference For.
		@return Type of preference, it can window, info window or parameter process
	  */
	public String getPreferenceFor () 
	{
		return (String)get_Value(COLUMNNAME_PreferenceFor);
	}

	/** Set Search Key.
		@param Value 
		Search key for the record in the format required - must be unique
	  */
	public void setValue (String Value)
	{
		set_Value (COLUMNNAME_Value, Value);
	}

	/** Get Search Key.
		@return Search key for the record in the format required - must be unique
	  */
	public String getValue () 
	{
		return (String)get_Value(COLUMNNAME_Value);
	}
}