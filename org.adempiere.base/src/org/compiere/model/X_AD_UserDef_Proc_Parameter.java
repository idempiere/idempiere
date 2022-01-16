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

/** Generated Model for AD_UserDef_Proc_Parameter
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_UserDef_Proc_Parameter")
public class X_AD_UserDef_Proc_Parameter extends PO implements I_AD_UserDef_Proc_Parameter, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

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

    /** Standard Constructor */
    public X_AD_UserDef_Proc_Parameter (Properties ctx, int AD_UserDef_Proc_Parameter_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_UserDef_Proc_Parameter_ID, trxName, virtualColumns);
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
      StringBuilder sb = new StringBuilder ("X_AD_UserDef_Proc_Parameter[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_FieldGroup getAD_FieldGroup() throws RuntimeException
	{
		return (org.compiere.model.I_AD_FieldGroup)MTable.get(getCtx(), org.compiere.model.I_AD_FieldGroup.Table_ID)
			.getPO(getAD_FieldGroup_ID(), get_TrxName());
	}

	/** Set Field Group.
		@param AD_FieldGroup_ID Logical grouping of fields
	*/
	public void setAD_FieldGroup_ID (int AD_FieldGroup_ID)
	{
		if (AD_FieldGroup_ID < 1)
			set_Value (COLUMNNAME_AD_FieldGroup_ID, null);
		else
			set_Value (COLUMNNAME_AD_FieldGroup_ID, Integer.valueOf(AD_FieldGroup_ID));
	}

	/** Get Field Group.
		@return Logical grouping of fields
	  */
	public int getAD_FieldGroup_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_FieldGroup_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Process_Para getAD_Process_Para() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Process_Para)MTable.get(getCtx(), org.compiere.model.I_AD_Process_Para.Table_ID)
			.getPO(getAD_Process_Para_ID(), get_TrxName());
	}

	/** Set Process Parameter.
		@param AD_Process_Para_ID Process Parameter
	*/
	public void setAD_Process_Para_ID (int AD_Process_Para_ID)
	{
		if (AD_Process_Para_ID < 1)
			set_Value (COLUMNNAME_AD_Process_Para_ID, null);
		else
			set_Value (COLUMNNAME_AD_Process_Para_ID, Integer.valueOf(AD_Process_Para_ID));
	}

	/** Get Process Parameter.
		@return Process Parameter	  */
	public int getAD_Process_Para_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Process_Para_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Reference getAD_Reference() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Reference)MTable.get(getCtx(), org.compiere.model.I_AD_Reference.Table_ID)
			.getPO(getAD_Reference_ID(), get_TrxName());
	}

	/** Set Reference.
		@param AD_Reference_ID System Reference and Validation
	*/
	public void setAD_Reference_ID (int AD_Reference_ID)
	{
		if (AD_Reference_ID < 1)
			set_Value (COLUMNNAME_AD_Reference_ID, null);
		else
			set_Value (COLUMNNAME_AD_Reference_ID, Integer.valueOf(AD_Reference_ID));
	}

	/** Get Reference.
		@return System Reference and Validation
	  */
	public int getAD_Reference_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Reference_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Reference getAD_Reference_Value() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Reference)MTable.get(getCtx(), org.compiere.model.I_AD_Reference.Table_ID)
			.getPO(getAD_Reference_Value_ID(), get_TrxName());
	}

	/** Set Reference Key.
		@param AD_Reference_Value_ID Required to specify, if data type is Table or List
	*/
	public void setAD_Reference_Value_ID (int AD_Reference_Value_ID)
	{
		if (AD_Reference_Value_ID < 1)
			set_Value (COLUMNNAME_AD_Reference_Value_ID, null);
		else
			set_Value (COLUMNNAME_AD_Reference_Value_ID, Integer.valueOf(AD_Reference_Value_ID));
	}

	/** Get Reference Key.
		@return Required to specify, if data type is Table or List
	  */
	public int getAD_Reference_Value_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Reference_Value_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_UserDef_Proc getAD_UserDef_Proc() throws RuntimeException
	{
		return (org.compiere.model.I_AD_UserDef_Proc)MTable.get(getCtx(), org.compiere.model.I_AD_UserDef_Proc.Table_ID)
			.getPO(getAD_UserDef_Proc_ID(), get_TrxName());
	}

	/** Set User defined Process.
		@param AD_UserDef_Proc_ID Primary Key : User defined Process
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
	public int getAD_UserDef_Proc_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Proc_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserDef_Proc_Parameter_ID.
		@param AD_UserDef_Proc_Parameter_ID Primary Key : User defined Process Parameter
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
	public int getAD_UserDef_Proc_Parameter_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Proc_Parameter_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserDef_Proc_Parameter_UU.
		@param AD_UserDef_Proc_Parameter_UU AD_UserDef_Proc_Parameter_UU
	*/
	public void setAD_UserDef_Proc_Parameter_UU (String AD_UserDef_Proc_Parameter_UU)
	{
		set_Value (COLUMNNAME_AD_UserDef_Proc_Parameter_UU, AD_UserDef_Proc_Parameter_UU);
	}

	/** Get AD_UserDef_Proc_Parameter_UU.
		@return AD_UserDef_Proc_Parameter_UU	  */
	public String getAD_UserDef_Proc_Parameter_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_UserDef_Proc_Parameter_UU);
	}

	public org.compiere.model.I_AD_Val_Rule getAD_Val_Rule() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Val_Rule)MTable.get(getCtx(), org.compiere.model.I_AD_Val_Rule.Table_ID)
			.getPO(getAD_Val_Rule_ID(), get_TrxName());
	}

	/** Set Dynamic Validation.
		@param AD_Val_Rule_ID Dynamic Validation Rule
	*/
	public void setAD_Val_Rule_ID (int AD_Val_Rule_ID)
	{
		if (AD_Val_Rule_ID < 1)
			set_Value (COLUMNNAME_AD_Val_Rule_ID, null);
		else
			set_Value (COLUMNNAME_AD_Val_Rule_ID, Integer.valueOf(AD_Val_Rule_ID));
	}

	/** Get Dynamic Validation.
		@return Dynamic Validation Rule
	  */
	public int getAD_Val_Rule_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Val_Rule_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Default Logic.
		@param DefaultValue Default value hierarchy, separated by ;
	*/
	public void setDefaultValue (String DefaultValue)
	{
		set_Value (COLUMNNAME_DefaultValue, DefaultValue);
	}

	/** Get Default Logic.
		@return Default value hierarchy, separated by ;
	  */
	public String getDefaultValue()
	{
		return (String)get_Value(COLUMNNAME_DefaultValue);
	}

	/** Set Default Logic 2.
		@param DefaultValue2 Default value hierarchy, separated by ;
	*/
	public void setDefaultValue2 (String DefaultValue2)
	{
		set_Value (COLUMNNAME_DefaultValue2, DefaultValue2);
	}

	/** Get Default Logic 2.
		@return Default value hierarchy, separated by ;
	  */
	public String getDefaultValue2()
	{
		return (String)get_Value(COLUMNNAME_DefaultValue2);
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

	/** Set Display Logic.
		@param DisplayLogic If the Field is displayed, the result determines if the field is actually displayed
	*/
	public void setDisplayLogic (String DisplayLogic)
	{
		set_Value (COLUMNNAME_DisplayLogic, DisplayLogic);
	}

	/** Get Display Logic.
		@return If the Field is displayed, the result determines if the field is actually displayed
	  */
	public String getDisplayLogic()
	{
		return (String)get_Value(COLUMNNAME_DisplayLogic);
	}

	/** Set Comment/Help.
		@param Help Comment or Hint
	*/
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp()
	{
		return (String)get_Value(COLUMNNAME_Help);
	}

	/** IsDisplayed AD_Reference_ID=319 */
	public static final int ISDISPLAYED_AD_Reference_ID=319;
	/** No = N */
	public static final String ISDISPLAYED_No = "N";
	/** Yes = Y */
	public static final String ISDISPLAYED_Yes = "Y";
	/** Set Displayed.
		@param IsDisplayed Determines, if this field is displayed
	*/
	public void setIsDisplayed (String IsDisplayed)
	{

		set_Value (COLUMNNAME_IsDisplayed, IsDisplayed);
	}

	/** Get Displayed.
		@return Determines, if this field is displayed
	  */
	public String getIsDisplayed()
	{
		return (String)get_Value(COLUMNNAME_IsDisplayed);
	}

	/** IsMandatory AD_Reference_ID=319 */
	public static final int ISMANDATORY_AD_Reference_ID=319;
	/** No = N */
	public static final String ISMANDATORY_No = "N";
	/** Yes = Y */
	public static final String ISMANDATORY_Yes = "Y";
	/** Set Mandatory.
		@param IsMandatory Data entry is required in this column
	*/
	public void setIsMandatory (String IsMandatory)
	{

		set_Value (COLUMNNAME_IsMandatory, IsMandatory);
	}

	/** Get Mandatory.
		@return Data entry is required in this column
	  */
	public String getIsMandatory()
	{
		return (String)get_Value(COLUMNNAME_IsMandatory);
	}

	/** Set Range.
		@param IsRange The parameter is a range of values
	*/
	public void setIsRange (boolean IsRange)
	{
		set_Value (COLUMNNAME_IsRange, Boolean.valueOf(IsRange));
	}

	/** Get Range.
		@return The parameter is a range of values
	  */
	public boolean isRange()
	{
		Object oo = get_Value(COLUMNNAME_IsRange);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Mandatory Logic.
		@param MandatoryLogic Mandatory Logic
	*/
	public void setMandatoryLogic (String MandatoryLogic)
	{
		set_Value (COLUMNNAME_MandatoryLogic, MandatoryLogic);
	}

	/** Get Mandatory Logic.
		@return Mandatory Logic	  */
	public String getMandatoryLogic()
	{
		return (String)get_Value(COLUMNNAME_MandatoryLogic);
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

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** Set Placeholder.
		@param Placeholder Placeholder
	*/
	public void setPlaceholder (String Placeholder)
	{
		set_Value (COLUMNNAME_Placeholder, Placeholder);
	}

	/** Get Placeholder.
		@return Placeholder	  */
	public String getPlaceholder()
	{
		return (String)get_Value(COLUMNNAME_Placeholder);
	}

	/** Set Placeholder2.
		@param Placeholder2 Placeholder2
	*/
	public void setPlaceholder2 (String Placeholder2)
	{
		set_Value (COLUMNNAME_Placeholder2, Placeholder2);
	}

	/** Get Placeholder2.
		@return Placeholder2	  */
	public String getPlaceholder2()
	{
		return (String)get_Value(COLUMNNAME_Placeholder2);
	}

	/** Set Read Only Logic.
		@param ReadOnlyLogic Logic to determine if field is read only (applies only when field is read-write)
	*/
	public void setReadOnlyLogic (String ReadOnlyLogic)
	{
		set_Value (COLUMNNAME_ReadOnlyLogic, ReadOnlyLogic);
	}

	/** Get Read Only Logic.
		@return Logic to determine if field is read only (applies only when field is read-write)
	  */
	public String getReadOnlyLogic()
	{
		return (String)get_Value(COLUMNNAME_ReadOnlyLogic);
	}

	/** Set Sequence.
		@param SeqNo Method of ordering records; lowest number comes first
	*/
	public void setSeqNo (int SeqNo)
	{
		set_Value (COLUMNNAME_SeqNo, Integer.valueOf(SeqNo));
	}

	/** Get Sequence.
		@return Method of ordering records; lowest number comes first
	  */
	public int getSeqNo()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SeqNo);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Max. Value.
		@param ValueMax Maximum Value for a field
	*/
	public void setValueMax (String ValueMax)
	{
		set_Value (COLUMNNAME_ValueMax, ValueMax);
	}

	/** Get Max. Value.
		@return Maximum Value for a field
	  */
	public String getValueMax()
	{
		return (String)get_Value(COLUMNNAME_ValueMax);
	}

	/** Set Min. Value.
		@param ValueMin Minimum Value for a field
	*/
	public void setValueMin (String ValueMin)
	{
		set_Value (COLUMNNAME_ValueMin, ValueMin);
	}

	/** Get Min. Value.
		@return Minimum Value for a field
	  */
	public String getValueMin()
	{
		return (String)get_Value(COLUMNNAME_ValueMin);
	}

	/** Set Value Format.
		@param VFormat Format of the value; Can contain fixed format elements, Variables: &quot;_lLoOaAcCa09&quot;
	*/
	public void setVFormat (String VFormat)
	{
		set_Value (COLUMNNAME_VFormat, VFormat);
	}

	/** Get Value Format.
		@return Format of the value; Can contain fixed format elements, Variables: &quot;_lLoOaAcCa09&quot;
	  */
	public String getVFormat()
	{
		return (String)get_Value(COLUMNNAME_VFormat);
	}
}