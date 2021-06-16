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

/** Generated Model for AD_WListboxCustomization
 *  @author iDempiere (generated) 
 *  @version Release 8.2 - $Id$ */
public class X_AD_WListboxCustomization extends PO implements I_AD_WListboxCustomization, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210207L;

    /** Standard Constructor */
    public X_AD_WListboxCustomization (Properties ctx, int AD_WListboxCustomization_ID, String trxName)
    {
      super (ctx, AD_WListboxCustomization_ID, trxName);
      /** if (AD_WListboxCustomization_ID == 0)
        {
			setAD_User_ID (0);
			setAD_WListboxCustomization_ID (0);
			setCustom (null);
			setwlistboxname (null);
        } */
    }

    /** Load Constructor */
    public X_AD_WListboxCustomization (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_WListboxCustomization[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Form getAD_Form() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Form)MTable.get(getCtx(), org.compiere.model.I_AD_Form.Table_Name)
			.getPO(getAD_Form_ID(), get_TrxName());	}

	/** Set Special Form.
		@param AD_Form_ID 
		Special Form
	  */
	public void setAD_Form_ID (int AD_Form_ID)
	{
		if (AD_Form_ID < 1) 
			set_Value (COLUMNNAME_AD_Form_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Form_ID, Integer.valueOf(AD_Form_ID));
	}

	/** Get Special Form.
		@return Special Form
	  */
	public int getAD_Form_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Form_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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
			set_ValueNoCheck (COLUMNNAME_AD_InfoWindow_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_InfoWindow_ID, Integer.valueOf(AD_InfoWindow_ID));
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
		if (AD_Window_ID < 0) 
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

	/** Set ad_wlistbox_customization_uu.
		@param ad_wlistbox_customization_uu ad_wlistbox_customization_uu	  */
	public void setad_wlistbox_customization_uu (String ad_wlistbox_customization_uu)
	{
		set_Value (COLUMNNAME_ad_wlistbox_customization_uu, ad_wlistbox_customization_uu);
	}

	/** Get ad_wlistbox_customization_uu.
		@return ad_wlistbox_customization_uu	  */
	public String getad_wlistbox_customization_uu () 
	{
		return (String)get_Value(COLUMNNAME_ad_wlistbox_customization_uu);
	}

	/** Set AD_WListboxCustomization.
		@param AD_WListboxCustomization_ID AD_WListboxCustomization	  */
	public void setAD_WListboxCustomization_ID (int AD_WListboxCustomization_ID)
	{
		if (AD_WListboxCustomization_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_WListboxCustomization_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_WListboxCustomization_ID, Integer.valueOf(AD_WListboxCustomization_ID));
	}

	/** Get AD_WListboxCustomization.
		@return AD_WListboxCustomization	  */
	public int getAD_WListboxCustomization_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_WListboxCustomization_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Custom.
		@param Custom Custom	  */
	public void setCustom (String Custom)
	{
		set_Value (COLUMNNAME_Custom, Custom);
	}

	/** Get Custom.
		@return Custom	  */
	public String getCustom () 
	{
		return (String)get_Value(COLUMNNAME_Custom);
	}

	/** IsDisplayedGrid AD_Reference_ID=319 */
	public static final int ISDISPLAYEDGRID_AD_Reference_ID=319;
	/** Yes = Y */
	public static final String ISDISPLAYEDGRID_Yes = "Y";
	/** No = N */
	public static final String ISDISPLAYEDGRID_No = "N";
	/** Set Show in Grid.
		@param IsDisplayedGrid Show in Grid	  */
	public void setIsDisplayedGrid (String IsDisplayedGrid)
	{

		set_Value (COLUMNNAME_IsDisplayedGrid, IsDisplayedGrid);
	}

	/** Get Show in Grid.
		@return Show in Grid	  */
	public String getIsDisplayedGrid () 
	{
		return (String)get_Value(COLUMNNAME_IsDisplayedGrid);
	}

	/** Set Quick Form.
		@param IsQuickForm 
		Display in Quick Form
	  */
	public void setIsQuickForm (boolean IsQuickForm)
	{
		set_Value (COLUMNNAME_IsQuickForm, Boolean.valueOf(IsQuickForm));
	}

	/** Get Quick Form.
		@return Display in Quick Form
	  */
	public boolean isQuickForm () 
	{
		Object oo = get_Value(COLUMNNAME_IsQuickForm);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set wlistboxname.
		@param wlistboxname wlistboxname	  */
	public void setwlistboxname (String wlistboxname)
	{
		set_Value (COLUMNNAME_wlistboxname, wlistboxname);
	}

	/** Get wlistboxname.
		@return wlistboxname	  */
	public String getwlistboxname () 
	{
		return (String)get_Value(COLUMNNAME_wlistboxname);
	}
}