/******************************************************************************
 * Product: BrERP Gestão Empresarial Completa (http://brerp.org)              *
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

/** Generated Model for AD_UserDef_Proc_Parameter
 *  @author BrERP Gestão Empresarial Completa (generated) 
 *  @version Release 5.1 - $Id$ */
public class X_AD_UserDef_Proc_Parameter extends PO implements I_AD_UserDef_Proc_Parameter, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20171129L;

    /** Standard Constructor */
    public X_AD_UserDef_Proc_Parameter (Properties ctx, int AD_UserDef_Proc_Parameter_ID, String trxName)
    {
      super (ctx, AD_UserDef_Proc_Parameter_ID, trxName);
      /** if (AD_UserDef_Proc_Parameter_ID == 0)
        {
			setAD_Process_Para_ID (0);
			setAD_UserDef_Proc_ID (0);
			setAD_UserDef_Proc_Parameter_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_UserDef_Proc_Parameter (Properties ctx, ResultSet rs, String trxName)
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
      StringBuffer sb = new StringBuffer ("X_AD_UserDef_Proc_Parameter[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Process_Para getAD_Process_Para() throws RuntimeException
    {
		return (org.compiere.model.I_AD_Process_Para)MTable.get(getCtx(), org.compiere.model.I_AD_Process_Para.Table_Name)
			.getPO(getAD_Process_Para_ID(), get_TrxName());	}

	/** Set Process Parameter.
		@param AD_Process_Para_ID Process Parameter	  */
	public void setAD_Process_Para_ID (int AD_Process_Para_ID)
	{
		if (AD_Process_Para_ID < 1) 
			set_Value (COLUMNNAME_AD_Process_Para_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Process_Para_ID, Integer.valueOf(AD_Process_Para_ID));
	}

	/** Get Process Parameter.
		@return Process Parameter	  */
	public int getAD_Process_Para_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Process_Para_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_UserDef_Proc getAD_UserDef_Proc() throws RuntimeException
    {
		return (org.compiere.model.I_AD_UserDef_Proc)MTable.get(getCtx(), org.compiere.model.I_AD_UserDef_Proc.Table_Name)
			.getPO(getAD_UserDef_Proc_ID(), get_TrxName());	}

	/** Set User defined Process.
		@param AD_UserDef_Proc_ID 
		Primary Key : User defined Process
	  */
	public void setAD_UserDef_Proc_ID (int AD_UserDef_Proc_ID)
	{
		if (AD_UserDef_Proc_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Proc_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Proc_ID, Integer.valueOf(AD_UserDef_Proc_ID));
	}

	/** Get User defined Process.
		@return Primary Key : User defined Process
	  */
	public int getAD_UserDef_Proc_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Proc_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserDef_Proc_Parameter_ID.
		@param AD_UserDef_Proc_Parameter_ID 
		Primary Key : User defined Process Parameter
	  */
	public void setAD_UserDef_Proc_Parameter_ID (int AD_UserDef_Proc_Parameter_ID)
	{
		if (AD_UserDef_Proc_Parameter_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Proc_Parameter_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Proc_Parameter_ID, Integer.valueOf(AD_UserDef_Proc_Parameter_ID));
	}

	/** Get AD_UserDef_Proc_Parameter_ID.
		@return Primary Key : User defined Process Parameter
	  */
	public int getAD_UserDef_Proc_Parameter_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Proc_Parameter_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserDef_Proc_Parameter_UU.
		@param AD_UserDef_Proc_Parameter_UU AD_UserDef_Proc_Parameter_UU	  */
	public void setAD_UserDef_Proc_Parameter_UU (String AD_UserDef_Proc_Parameter_UU)
	{
		set_Value (COLUMNNAME_AD_UserDef_Proc_Parameter_UU, AD_UserDef_Proc_Parameter_UU);
	}

	/** Get AD_UserDef_Proc_Parameter_UU.
		@return AD_UserDef_Proc_Parameter_UU	  */
	public String getAD_UserDef_Proc_Parameter_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_UserDef_Proc_Parameter_UU);
	}

	/** Set Default Logic.
		@param DefaultValue 
		Default value hierarchy, separated by ;
	  */
	public void setDefaultValue (String DefaultValue)
	{
		set_Value (COLUMNNAME_DefaultValue, DefaultValue);
	}

	/** Get Default Logic.
		@return Default value hierarchy, separated by ;
	  */
	public String getDefaultValue () 
	{
		return (String)get_Value(COLUMNNAME_DefaultValue);
	}

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
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

	/** Set Comment/Help.
		@param Help 
		Comment or Hint
	  */
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp () 
	{
		return (String)get_Value(COLUMNNAME_Help);
	}

	/** Set Displayed.
		@param IsDisplayed 
		Determines, if this field is displayed
	  */
	public void setIsDisplayed (boolean IsDisplayed)
	{
		set_Value (COLUMNNAME_IsDisplayed, Boolean.valueOf(IsDisplayed));
	}

	/** Get Displayed.
		@return Determines, if this field is displayed
	  */
	public boolean isDisplayed () 
	{
		Object oo = get_Value(COLUMNNAME_IsDisplayed);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Read Only.
		@param IsReadOnly 
		Field is read only
	  */
	public void setIsReadOnly (boolean IsReadOnly)
	{
		set_Value (COLUMNNAME_IsReadOnly, Boolean.valueOf(IsReadOnly));
	}

	/** Get Read Only.
		@return Field is read only
	  */
	public boolean isReadOnly () 
	{
		Object oo = get_Value(COLUMNNAME_IsReadOnly);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Mandatory Logic.
		@param MandatoryLogic Mandatory Logic	  */
	public void setMandatoryLogic (String MandatoryLogic)
	{
		set_Value (COLUMNNAME_MandatoryLogic, MandatoryLogic);
	}

	/** Get Mandatory Logic.
		@return Mandatory Logic	  */
	public String getMandatoryLogic () 
	{
		return (String)get_Value(COLUMNNAME_MandatoryLogic);
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

	/** Set Read Only Logic.
		@param ReadOnlyLogic 
		Logic to determine if field is read only (applies only when field is read-write)
	  */
	public void setReadOnlyLogic (String ReadOnlyLogic)
	{
		set_Value (COLUMNNAME_ReadOnlyLogic, ReadOnlyLogic);
	}

	/** Get Read Only Logic.
		@return Logic to determine if field is read only (applies only when field is read-write)
	  */
	public String getReadOnlyLogic () 
	{
		return (String)get_Value(COLUMNNAME_ReadOnlyLogic);
	}
}