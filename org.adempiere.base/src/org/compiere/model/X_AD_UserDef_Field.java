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

/** Generated Model for AD_UserDef_Field
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="AD_UserDef_Field")
public class X_AD_UserDef_Field extends PO implements I_AD_UserDef_Field, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_AD_UserDef_Field (Properties ctx, int AD_UserDef_Field_ID, String trxName)
    {
      super (ctx, AD_UserDef_Field_ID, trxName);
      /** if (AD_UserDef_Field_ID == 0)
        {
			setAD_Field_ID (0);
			setAD_UserDef_Field_ID (0);
			setAD_UserDef_Tab_ID (0);
			setSeqNo (0);
// 0
			setSeqNoGrid (0);
// 0
        } */
    }

    /** Load Constructor */
    public X_AD_UserDef_Field (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_UserDef_Field[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_FieldGroup getAD_FieldGroup() throws RuntimeException
	{
		return (org.compiere.model.I_AD_FieldGroup)MTable.get(getCtx(), org.compiere.model.I_AD_FieldGroup.Table_ID)
			.getPO(getAD_FieldGroup_ID(), get_TrxName());
	}

	/** Set Field Group.
		@param AD_FieldGroup_ID 
		Logical grouping of fields
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
	public int getAD_FieldGroup_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_FieldGroup_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Field getAD_Field() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Field)MTable.get(getCtx(), org.compiere.model.I_AD_Field.Table_ID)
			.getPO(getAD_Field_ID(), get_TrxName());
	}

	/** Set Field.
		@param AD_Field_ID 
		Field on a database table
	  */
	public void setAD_Field_ID (int AD_Field_ID)
	{
		if (AD_Field_ID < 1) 
			set_Value (COLUMNNAME_AD_Field_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Field_ID, Integer.valueOf(AD_Field_ID));
	}

	/** Get Field.
		@return Field on a database table
	  */
	public int getAD_Field_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Field_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), String.valueOf(getAD_Field_ID()));
    }

	public org.compiere.model.I_AD_Style getAD_FieldStyle() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Style)MTable.get(getCtx(), org.compiere.model.I_AD_Style.Table_ID)
			.getPO(getAD_FieldStyle_ID(), get_TrxName());
	}

	/** Set Field Style.
		@param AD_FieldStyle_ID 
		Field CSS Style 
	  */
	public void setAD_FieldStyle_ID (int AD_FieldStyle_ID)
	{
		if (AD_FieldStyle_ID < 1) 
			set_Value (COLUMNNAME_AD_FieldStyle_ID, null);
		else 
			set_Value (COLUMNNAME_AD_FieldStyle_ID, Integer.valueOf(AD_FieldStyle_ID));
	}

	/** Get Field Style.
		@return Field CSS Style 
	  */
	public int getAD_FieldStyle_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_FieldStyle_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Style getAD_LabelStyle() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Style)MTable.get(getCtx(), org.compiere.model.I_AD_Style.Table_ID)
			.getPO(getAD_LabelStyle_ID(), get_TrxName());
	}

	/** Set Label Style.
		@param AD_LabelStyle_ID 
		Label CSS Style
	  */
	public void setAD_LabelStyle_ID (int AD_LabelStyle_ID)
	{
		if (AD_LabelStyle_ID < 1) 
			set_Value (COLUMNNAME_AD_LabelStyle_ID, null);
		else 
			set_Value (COLUMNNAME_AD_LabelStyle_ID, Integer.valueOf(AD_LabelStyle_ID));
	}

	/** Get Label Style.
		@return Label CSS Style
	  */
	public int getAD_LabelStyle_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_LabelStyle_ID);
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
		@param AD_Reference_ID 
		System Reference and Validation
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
	public int getAD_Reference_ID () 
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
		@param AD_Reference_Value_ID 
		Required to specify, if data type is Table or List
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
	public int getAD_Reference_Value_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Reference_Value_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set User defined Field.
		@param AD_UserDef_Field_ID User defined Field	  */
	public void setAD_UserDef_Field_ID (int AD_UserDef_Field_ID)
	{
		if (AD_UserDef_Field_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Field_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Field_ID, Integer.valueOf(AD_UserDef_Field_ID));
	}

	/** Get User defined Field.
		@return User defined Field	  */
	public int getAD_UserDef_Field_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Field_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserDef_Field_UU.
		@param AD_UserDef_Field_UU AD_UserDef_Field_UU	  */
	public void setAD_UserDef_Field_UU (String AD_UserDef_Field_UU)
	{
		set_Value (COLUMNNAME_AD_UserDef_Field_UU, AD_UserDef_Field_UU);
	}

	/** Get AD_UserDef_Field_UU.
		@return AD_UserDef_Field_UU	  */
	public String getAD_UserDef_Field_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_UserDef_Field_UU);
	}

	public org.compiere.model.I_AD_UserDef_Tab getAD_UserDef_Tab() throws RuntimeException
	{
		return (org.compiere.model.I_AD_UserDef_Tab)MTable.get(getCtx(), org.compiere.model.I_AD_UserDef_Tab.Table_ID)
			.getPO(getAD_UserDef_Tab_ID(), get_TrxName());
	}

	/** Set User defined Tab.
		@param AD_UserDef_Tab_ID User defined Tab	  */
	public void setAD_UserDef_Tab_ID (int AD_UserDef_Tab_ID)
	{
		if (AD_UserDef_Tab_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Tab_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Tab_ID, Integer.valueOf(AD_UserDef_Tab_ID));
	}

	/** Get User defined Tab.
		@return User defined Tab	  */
	public int getAD_UserDef_Tab_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Tab_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Val_Rule getAD_Val_Rule() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Val_Rule)MTable.get(getCtx(), org.compiere.model.I_AD_Val_Rule.Table_ID)
			.getPO(getAD_Val_Rule_ID(), get_TrxName());
	}

	/** Set Dynamic Validation.
		@param AD_Val_Rule_ID 
		Dynamic Validation Rule
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
	public int getAD_Val_Rule_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Val_Rule_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Val_Rule getAD_Val_Rule_Lookup() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Val_Rule)MTable.get(getCtx(), org.compiere.model.I_AD_Val_Rule.Table_ID)
			.getPO(getAD_Val_Rule_Lookup_ID(), get_TrxName());
	}

	/** Set Dynamic Validation (Lookup).
		@param AD_Val_Rule_Lookup_ID 
		Override Dynamic Validation Rule for Lookup Window
	  */
	public void setAD_Val_Rule_Lookup_ID (int AD_Val_Rule_Lookup_ID)
	{
		if (AD_Val_Rule_Lookup_ID < 1) 
			set_Value (COLUMNNAME_AD_Val_Rule_Lookup_ID, null);
		else 
			set_Value (COLUMNNAME_AD_Val_Rule_Lookup_ID, Integer.valueOf(AD_Val_Rule_Lookup_ID));
	}

	/** Get Dynamic Validation (Lookup).
		@return Override Dynamic Validation Rule for Lookup Window
	  */
	public int getAD_Val_Rule_Lookup_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Val_Rule_Lookup_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Column Span.
		@param ColumnSpan 
		Number of column for a box of field
	  */
	public void setColumnSpan (int ColumnSpan)
	{
		set_Value (COLUMNNAME_ColumnSpan, Integer.valueOf(ColumnSpan));
	}

	/** Get Column Span.
		@return Number of column for a box of field
	  */
	public int getColumnSpan () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_ColumnSpan);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	/** Set Display Length.
		@param DisplayLength 
		Length of the display in characters
	  */
	public void setDisplayLength (int DisplayLength)
	{
		set_Value (COLUMNNAME_DisplayLength, Integer.valueOf(DisplayLength));
	}

	/** Get Display Length.
		@return Length of the display in characters
	  */
	public int getDisplayLength () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_DisplayLength);
		if (ii == null)
			 return 0;
		return ii.intValue();
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

	/** IsAlwaysUpdateable AD_Reference_ID=319 */
	public static final int ISALWAYSUPDATEABLE_AD_Reference_ID=319;
	/** No = N */
	public static final String ISALWAYSUPDATEABLE_No = "N";
	/** Yes = Y */
	public static final String ISALWAYSUPDATEABLE_Yes = "Y";
	/** Set Always Updatable.
		@param IsAlwaysUpdateable 
		The column is always updateable, even if the record is not active or processed
	  */
	public void setIsAlwaysUpdateable (String IsAlwaysUpdateable)
	{

		set_Value (COLUMNNAME_IsAlwaysUpdateable, IsAlwaysUpdateable);
	}

	/** Get Always Updatable.
		@return The column is always updateable, even if the record is not active or processed
	  */
	public String getIsAlwaysUpdateable () 
	{
		return (String)get_Value(COLUMNNAME_IsAlwaysUpdateable);
	}

	/** IsAutocomplete AD_Reference_ID=319 */
	public static final int ISAUTOCOMPLETE_AD_Reference_ID=319;
	/** No = N */
	public static final String ISAUTOCOMPLETE_No = "N";
	/** Yes = Y */
	public static final String ISAUTOCOMPLETE_Yes = "Y";
	/** Set Autocomplete.
		@param IsAutocomplete 
		Automatic completion for textfields
	  */
	public void setIsAutocomplete (String IsAutocomplete)
	{

		set_Value (COLUMNNAME_IsAutocomplete, IsAutocomplete);
	}

	/** Get Autocomplete.
		@return Automatic completion for textfields
	  */
	public String getIsAutocomplete () 
	{
		return (String)get_Value(COLUMNNAME_IsAutocomplete);
	}

	/** IsDisplayed AD_Reference_ID=319 */
	public static final int ISDISPLAYED_AD_Reference_ID=319;
	/** No = N */
	public static final String ISDISPLAYED_No = "N";
	/** Yes = Y */
	public static final String ISDISPLAYED_Yes = "Y";
	/** Set Displayed.
		@param IsDisplayed 
		Determines, if this field is displayed
	  */
	public void setIsDisplayed (String IsDisplayed)
	{

		set_Value (COLUMNNAME_IsDisplayed, IsDisplayed);
	}

	/** Get Displayed.
		@return Determines, if this field is displayed
	  */
	public String getIsDisplayed () 
	{
		return (String)get_Value(COLUMNNAME_IsDisplayed);
	}

	/** IsDisplayedGrid AD_Reference_ID=319 */
	public static final int ISDISPLAYEDGRID_AD_Reference_ID=319;
	/** No = N */
	public static final String ISDISPLAYEDGRID_No = "N";
	/** Yes = Y */
	public static final String ISDISPLAYEDGRID_Yes = "Y";
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

	/** IsMandatory AD_Reference_ID=319 */
	public static final int ISMANDATORY_AD_Reference_ID=319;
	/** No = N */
	public static final String ISMANDATORY_No = "N";
	/** Yes = Y */
	public static final String ISMANDATORY_Yes = "Y";
	/** Set Mandatory.
		@param IsMandatory 
		Data entry is required in this column
	  */
	public void setIsMandatory (String IsMandatory)
	{

		set_Value (COLUMNNAME_IsMandatory, IsMandatory);
	}

	/** Get Mandatory.
		@return Data entry is required in this column
	  */
	public String getIsMandatory () 
	{
		return (String)get_Value(COLUMNNAME_IsMandatory);
	}

	/** IsReadOnly AD_Reference_ID=319 */
	public static final int ISREADONLY_AD_Reference_ID=319;
	/** No = N */
	public static final String ISREADONLY_No = "N";
	/** Yes = Y */
	public static final String ISREADONLY_Yes = "Y";
	/** Set Read Only.
		@param IsReadOnly 
		Field is read only
	  */
	public void setIsReadOnly (String IsReadOnly)
	{

		set_Value (COLUMNNAME_IsReadOnly, IsReadOnly);
	}

	/** Get Read Only.
		@return Field is read only
	  */
	public String getIsReadOnly () 
	{
		return (String)get_Value(COLUMNNAME_IsReadOnly);
	}

	/** IsSameLine AD_Reference_ID=319 */
	public static final int ISSAMELINE_AD_Reference_ID=319;
	/** No = N */
	public static final String ISSAMELINE_No = "N";
	/** Yes = Y */
	public static final String ISSAMELINE_Yes = "Y";
	/** Set Same Line.
		@param IsSameLine 
		Displayed on same line as previous field
	  */
	public void setIsSameLine (String IsSameLine)
	{

		set_Value (COLUMNNAME_IsSameLine, IsSameLine);
	}

	/** Get Same Line.
		@return Displayed on same line as previous field
	  */
	public String getIsSameLine () 
	{
		return (String)get_Value(COLUMNNAME_IsSameLine);
	}

	/** IsToolbarButton AD_Reference_ID=200099 */
	public static final int ISTOOLBARBUTTON_AD_Reference_ID=200099;
	/** Both = B */
	public static final String ISTOOLBARBUTTON_Both = "B";
	/** Window = N */
	public static final String ISTOOLBARBUTTON_Window = "N";
	/** Toolbar = Y */
	public static final String ISTOOLBARBUTTON_Toolbar = "Y";
	/** Set Toolbar Button.
		@param IsToolbarButton 
		Show the button on the toolbar, the window, or both
	  */
	public void setIsToolbarButton (String IsToolbarButton)
	{

		set_Value (COLUMNNAME_IsToolbarButton, IsToolbarButton);
	}

	/** Get Toolbar Button.
		@return Show the button on the toolbar, the window, or both
	  */
	public String getIsToolbarButton () 
	{
		return (String)get_Value(COLUMNNAME_IsToolbarButton);
	}

	/** IsUpdateable AD_Reference_ID=319 */
	public static final int ISUPDATEABLE_AD_Reference_ID=319;
	/** No = N */
	public static final String ISUPDATEABLE_No = "N";
	/** Yes = Y */
	public static final String ISUPDATEABLE_Yes = "Y";
	/** Set Updatable.
		@param IsUpdateable 
		Determines, if the field can be updated
	  */
	public void setIsUpdateable (String IsUpdateable)
	{

		set_Value (COLUMNNAME_IsUpdateable, IsUpdateable);
	}

	/** Get Updatable.
		@return Determines, if the field can be updated
	  */
	public String getIsUpdateable () 
	{
		return (String)get_Value(COLUMNNAME_IsUpdateable);
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

	/** Set Number of Lines.
		@param NumLines 
		Number of lines for a field
	  */
	public void setNumLines (int NumLines)
	{
		set_Value (COLUMNNAME_NumLines, Integer.valueOf(NumLines));
	}

	/** Get Number of Lines.
		@return Number of lines for a field
	  */
	public int getNumLines () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_NumLines);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_PA_DashboardContent getPA_DashboardContent() throws RuntimeException
	{
		return (org.compiere.model.I_PA_DashboardContent)MTable.get(getCtx(), org.compiere.model.I_PA_DashboardContent.Table_ID)
			.getPO(getPA_DashboardContent_ID(), get_TrxName());
	}

	/** Set Dashboard Content.
		@param PA_DashboardContent_ID Dashboard Content	  */
	public void setPA_DashboardContent_ID (int PA_DashboardContent_ID)
	{
		if (PA_DashboardContent_ID < 1) 
			set_Value (COLUMNNAME_PA_DashboardContent_ID, null);
		else 
			set_Value (COLUMNNAME_PA_DashboardContent_ID, Integer.valueOf(PA_DashboardContent_ID));
	}

	/** Get Dashboard Content.
		@return Dashboard Content	  */
	public int getPA_DashboardContent_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_PA_DashboardContent_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Placeholder.
		@param Placeholder Placeholder	  */
	public void setPlaceholder (String Placeholder)
	{
		set_Value (COLUMNNAME_Placeholder, Placeholder);
	}

	/** Get Placeholder.
		@return Placeholder	  */
	public String getPlaceholder () 
	{
		return (String)get_Value(COLUMNNAME_Placeholder);
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

	/** Set Grid Sequence No.
		@param SeqNoGrid Grid Sequence No	  */
	public void setSeqNoGrid (int SeqNoGrid)
	{
		set_Value (COLUMNNAME_SeqNoGrid, Integer.valueOf(SeqNoGrid));
	}

	/** Get Grid Sequence No.
		@return Grid Sequence No	  */
	public int getSeqNoGrid () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SeqNoGrid);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Record Sort No.
		@param SortNo 
		Determines in what order the records are displayed
	  */
	public void setSortNo (int SortNo)
	{
		set_Value (COLUMNNAME_SortNo, Integer.valueOf(SortNo));
	}

	/** Get Record Sort No.
		@return Determines in what order the records are displayed
	  */
	public int getSortNo () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SortNo);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Value Format.
		@param VFormat 
		Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"
	  */
	public void setVFormat (String VFormat)
	{
		set_Value (COLUMNNAME_VFormat, VFormat);
	}

	/** Get Value Format.
		@return Format of the value; Can contain fixed format elements, Variables: "_lLoOaAcCa09"
	  */
	public String getVFormat () 
	{
		return (String)get_Value(COLUMNNAME_VFormat);
	}

	/** Set X Position.
		@param XPosition 
		Absolute X (horizontal) position in 1/72 of an inch
	  */
	public void setXPosition (int XPosition)
	{
		set_Value (COLUMNNAME_XPosition, Integer.valueOf(XPosition));
	}

	/** Get X Position.
		@return Absolute X (horizontal) position in 1/72 of an inch
	  */
	public int getXPosition () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_XPosition);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}