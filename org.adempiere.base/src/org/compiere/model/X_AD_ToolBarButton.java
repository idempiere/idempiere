/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2007 ComPiere, Inc. All Rights Reserved.                *
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
import org.compiere.model.*;
import org.compiere.util.KeyNamePair;

/** Generated Model for AD_ToolBarButton
 *  @author Adempiere (generated) 
 *  @version 360LTS.015 - $Id$ */
public class X_AD_ToolBarButton extends PO implements I_AD_ToolBarButton, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20120329L;

    /** Standard Constructor */
    public X_AD_ToolBarButton (Properties ctx, int AD_ToolBarButton_ID, String trxName)
    {
      super (ctx, AD_ToolBarButton_ID, trxName);
      /** if (AD_ToolBarButton_ID == 0)
        {
			setAD_ToolBarButton_ID (0);
			setClassname (null);
			setComponentName (null);
			setIsCustomization (false);
// N
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_ToolBarButton (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_AD_ToolBarButton[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Action Class Name.
		@param ActionClassName 
		The class name that implements the interface for toolbar actions
	  */
	public void setActionClassName (String ActionClassName)
	{
		set_Value (COLUMNNAME_ActionClassName, ActionClassName);
	}

	/** Get Action Class Name.
		@return The class name that implements the interface for toolbar actions
	  */
	public String getActionClassName () 
	{
		return (String)get_Value(COLUMNNAME_ActionClassName);
	}

	/** Set Action Name.
		@param ActionName 
		Action name on the toolbar
	  */
	public void setActionName (String ActionName)
	{
		set_Value (COLUMNNAME_ActionName, ActionName);
	}

	/** Get Action Name.
		@return Action name on the toolbar
	  */
	public String getActionName () 
	{
		return (String)get_Value(COLUMNNAME_ActionName);
	}

	/** Set ToolBar Button.
		@param AD_ToolBarButton_ID ToolBar Button	  */
	public void setAD_ToolBarButton_ID (int AD_ToolBarButton_ID)
	{
		if (AD_ToolBarButton_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_ToolBarButton_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_ToolBarButton_ID, Integer.valueOf(AD_ToolBarButton_ID));
	}

	/** Get ToolBar Button.
		@return ToolBar Button	  */
	public int getAD_ToolBarButton_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_ToolBarButton_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Classname.
		@param Classname 
		Java Classname
	  */
	public void setClassname (String Classname)
	{
		set_Value (COLUMNNAME_Classname, Classname);
	}

	/** Get Classname.
		@return Java Classname
	  */
	public String getClassname () 
	{
		return (String)get_Value(COLUMNNAME_Classname);
	}

	/** Set Component Name.
		@param ComponentName Component Name	  */
	public void setComponentName (String ComponentName)
	{
		set_Value (COLUMNNAME_ComponentName, ComponentName);
	}

	/** Get Component Name.
		@return Component Name	  */
	public String getComponentName () 
	{
		return (String)get_Value(COLUMNNAME_ComponentName);
	}

	/** Set Customization.
		@param IsCustomization 
		The change is a customization of the data dictionary and can be applied after Migration
	  */
	public void setIsCustomization (boolean IsCustomization)
	{
		set_Value (COLUMNNAME_IsCustomization, Boolean.valueOf(IsCustomization));
	}

	/** Get Customization.
		@return The change is a customization of the data dictionary and can be applied after Migration
	  */
	public boolean isCustomization () 
	{
		Object oo = get_Value(COLUMNNAME_IsCustomization);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set KeyCode.
		@param KeyStroke_KeyCode 
		KeyCode for shortcuts
	  */
	public void setKeyStroke_KeyCode (int KeyStroke_KeyCode)
	{
		set_Value (COLUMNNAME_KeyStroke_KeyCode, Integer.valueOf(KeyStroke_KeyCode));
	}

	/** Get KeyCode.
		@return KeyCode for shortcuts
	  */
	public int getKeyStroke_KeyCode () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_KeyStroke_KeyCode);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Keystroke Modifiers.
		@param KeyStroke_Modifiers 
		Keystroke Modifiers for shortcuts
	  */
	public void setKeyStroke_Modifiers (int KeyStroke_Modifiers)
	{
		set_Value (COLUMNNAME_KeyStroke_Modifiers, Integer.valueOf(KeyStroke_Modifiers));
	}

	/** Get Keystroke Modifiers.
		@return Keystroke Modifiers for shortcuts
	  */
	public int getKeyStroke_Modifiers () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_KeyStroke_Modifiers);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Name.
		@param Name 
		Alphanumeric identifier of the entity
	  */
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName () 
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }
}