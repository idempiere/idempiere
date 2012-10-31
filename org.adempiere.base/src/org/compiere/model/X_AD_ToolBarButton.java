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

/** Generated Model for AD_ToolBarButton
 *  @author iDempiere (generated) 
 *  @version Release 1.0a - $Id$ */
public class X_AD_ToolBarButton extends PO implements I_AD_ToolBarButton, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20121031L;

    /** Standard Constructor */
    public X_AD_ToolBarButton (Properties ctx, int AD_ToolBarButton_ID, String trxName)
    {
      super (ctx, AD_ToolBarButton_ID, trxName);
      /** if (AD_ToolBarButton_ID == 0)
        {
			setAction (null);
// W
			setAD_ToolBarButton_ID (0);
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

	/** Action AD_Reference_ID=104 */
	public static final int ACTION_AD_Reference_ID=104;
	/** Window = W */
	public static final String ACTION_Window = "W";
	/** Task = T */
	public static final String ACTION_Task = "T";
	/** WorkFlow = F */
	public static final String ACTION_WorkFlow = "F";
	/** Process = P */
	public static final String ACTION_Process = "P";
	/** Report = R */
	public static final String ACTION_Report = "R";
	/** Form = X */
	public static final String ACTION_Form = "X";
	/** Workbench = B */
	public static final String ACTION_Workbench = "B";
	/** Set Action.
		@param Action 
		Indicates the Action to be performed
	  */
	public void setAction (String Action)
	{

		set_Value (COLUMNNAME_Action, Action);
	}

	/** Get Action.
		@return Indicates the Action to be performed
	  */
	public String getAction () 
	{
		return (String)get_Value(COLUMNNAME_Action);
	}

	/** Set Service Component Name.
		@param ActionClassName 
		The service component name that implements the interface for toolbar actions
	  */
	public void setActionClassName (String ActionClassName)
	{
		set_Value (COLUMNNAME_ActionClassName, ActionClassName);
	}

	/** Get Service Component Name.
		@return The service component name that implements the interface for toolbar actions
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

	public org.compiere.model.I_AD_Tab getAD_Tab() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Tab)MTable.get(getCtx(), org.compiere.model.I_AD_Tab.Table_Name)
			.getPO(getAD_Tab_ID(), get_TrxName());	}

	/** Set Tab.
		@param AD_Tab_ID 
		Tab within a Window
	  */
	public void setAD_Tab_ID (int AD_Tab_ID)
	{
		if (AD_Tab_ID < 1) 
			set_Value (COLUMNNAME_AD_Tab_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Tab_ID, Integer.valueOf(AD_Tab_ID));
	}

	/** Get Tab.
		@return Tab within a Window
	  */
	public int getAD_Tab_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Tab_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	/** Set AD_ToolBarButton_UU.
		@param AD_ToolBarButton_UU AD_ToolBarButton_UU	  */
	public void setAD_ToolBarButton_UU (String AD_ToolBarButton_UU)
	{
		set_Value (COLUMNNAME_AD_ToolBarButton_UU, AD_ToolBarButton_UU);
	}

	/** Get AD_ToolBarButton_UU.
		@return AD_ToolBarButton_UU	  */
	public String getAD_ToolBarButton_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_ToolBarButton_UU);
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

	/** Set Display Logic.
		@param DisplayLogic 
		If the Field is displayed, the result determines if the field is actually displayed
	  */
	public void setDisplayLogic (String DisplayLogic)
	{
		set_Value (COLUMNNAME_DisplayLogic, DisplayLogic);
	}

	/** Get Display Logic.
		@return If the Field is displayed, the result determines if the field is actually displayed
	  */
	public String getDisplayLogic () 
	{
		return (String)get_Value(COLUMNNAME_DisplayLogic);
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

	/** Set Sequence.
		@param SeqNo 
		Method of ordering records; lowest number comes first
	  */
	public void setSeqNo (int SeqNo)
	{
		set_Value (COLUMNNAME_SeqNo, Integer.valueOf(SeqNo));
	}

	/** Get Sequence.
		@return Method of ordering records; lowest number comes first
	  */
	public int getSeqNo () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SeqNo);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}