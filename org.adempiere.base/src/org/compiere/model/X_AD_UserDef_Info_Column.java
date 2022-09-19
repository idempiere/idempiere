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

/** Generated Model for AD_UserDef_Info_Column
 *  @author iDempiere (generated) 
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="AD_UserDef_Info_Column")
public class X_AD_UserDef_Info_Column extends PO implements I_AD_UserDef_Info_Column, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220914L;

    /** Standard Constructor */
    public X_AD_UserDef_Info_Column (Properties ctx, int AD_UserDef_Info_Column_ID, String trxName)
    {
      super (ctx, AD_UserDef_Info_Column_ID, trxName);
      /** if (AD_UserDef_Info_Column_ID == 0)
        {
			setAD_InfoColumn_ID (0);
			setAD_UserDef_Info_Column_ID (0);
			setAD_UserDef_Info_ID (0);
// @AD_UserDef_Info_ID@
        } */
    }

    /** Standard Constructor */
    public X_AD_UserDef_Info_Column (Properties ctx, int AD_UserDef_Info_Column_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_UserDef_Info_Column_ID, trxName, virtualColumns);
      /** if (AD_UserDef_Info_Column_ID == 0)
        {
			setAD_InfoColumn_ID (0);
			setAD_UserDef_Info_Column_ID (0);
			setAD_UserDef_Info_ID (0);
// @AD_UserDef_Info_ID@
        } */
    }

    /** Load Constructor */
    public X_AD_UserDef_Info_Column (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_UserDef_Info_Column[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_Style getAD_FieldStyle() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Style)MTable.get(getCtx(), org.compiere.model.I_AD_Style.Table_ID)
			.getPO(getAD_FieldStyle_ID(), get_TrxName());
	}

	/** Set Field Style.
		@param AD_FieldStyle_ID Field CSS Style 
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
	public int getAD_FieldStyle_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_FieldStyle_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_InfoColumn getAD_InfoColumn() throws RuntimeException
	{
		return (org.compiere.model.I_AD_InfoColumn)MTable.get(getCtx(), org.compiere.model.I_AD_InfoColumn.Table_ID)
			.getPO(getAD_InfoColumn_ID(), get_TrxName());
	}

	/** Set Info Column.
		@param AD_InfoColumn_ID Info Window Column
	*/
	public void setAD_InfoColumn_ID (int AD_InfoColumn_ID)
	{
		if (AD_InfoColumn_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_InfoColumn_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_InfoColumn_ID, Integer.valueOf(AD_InfoColumn_ID));
	}

	/** Get Info Column.
		@return Info Window Column
	  */
	public int getAD_InfoColumn_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_InfoColumn_ID);
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

	/** Set User defined Info Column.
		@param AD_UserDef_Info_Column_ID User defined Info Column
	*/
	public void setAD_UserDef_Info_Column_ID (int AD_UserDef_Info_Column_ID)
	{
		if (AD_UserDef_Info_Column_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_Column_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_Column_ID, Integer.valueOf(AD_UserDef_Info_Column_ID));
	}

	/** Get User defined Info Column.
		@return User defined Info Column	  */
	public int getAD_UserDef_Info_Column_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Info_Column_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserDef_Info_Column_UU.
		@param AD_UserDef_Info_Column_UU AD_UserDef_Info_Column_UU
	*/
	public void setAD_UserDef_Info_Column_UU (String AD_UserDef_Info_Column_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_Column_UU, AD_UserDef_Info_Column_UU);
	}

	/** Get AD_UserDef_Info_Column_UU.
		@return AD_UserDef_Info_Column_UU	  */
	public String getAD_UserDef_Info_Column_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_UserDef_Info_Column_UU);
	}

	public org.compiere.model.I_AD_UserDef_Info getAD_UserDef_Info() throws RuntimeException
	{
		return (org.compiere.model.I_AD_UserDef_Info)MTable.get(getCtx(), org.compiere.model.I_AD_UserDef_Info.Table_ID)
			.getPO(getAD_UserDef_Info_ID(), get_TrxName());
	}

	/** Set User defined Info Window.
		@param AD_UserDef_Info_ID User defined Info Window
	*/
	public void setAD_UserDef_Info_ID (int AD_UserDef_Info_ID)
	{
		if (AD_UserDef_Info_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserDef_Info_ID, Integer.valueOf(AD_UserDef_Info_ID));
	}

	/** Get User defined Info Window.
		@return User defined Info Window	  */
	public int getAD_UserDef_Info_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserDef_Info_ID);
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

	/** Set Input field validation.
		@param InputFieldValidation Input field validation query
	*/
	public void setInputFieldValidation (String InputFieldValidation)
	{
		set_Value (COLUMNNAME_InputFieldValidation, InputFieldValidation);
	}

	/** Get Input field validation.
		@return Input field validation query
	  */
	public String getInputFieldValidation()
	{
		return (String)get_Value(COLUMNNAME_InputFieldValidation);
	}

	/** IsAutocomplete AD_Reference_ID=319 */
	public static final int ISAUTOCOMPLETE_AD_Reference_ID=319;
	/** No = N */
	public static final String ISAUTOCOMPLETE_No = "N";
	/** Yes = Y */
	public static final String ISAUTOCOMPLETE_Yes = "Y";
	/** Set Auto complete.
		@param IsAutocomplete Automatic completion for text fields
	*/
	public void setIsAutocomplete (String IsAutocomplete)
	{

		set_Value (COLUMNNAME_IsAutocomplete, IsAutocomplete);
	}

	/** Get Auto complete.
		@return Automatic completion for text fields
	  */
	public String getIsAutocomplete()
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

	/** IsQueryAfterChange AD_Reference_ID=319 */
	public static final int ISQUERYAFTERCHANGE_AD_Reference_ID=319;
	/** No = N */
	public static final String ISQUERYAFTERCHANGE_No = "N";
	/** Yes = Y */
	public static final String ISQUERYAFTERCHANGE_Yes = "Y";
	/** Set Query After Change.
		@param IsQueryAfterChange Issues a query request after the user has made changes to the field
	*/
	public void setIsQueryAfterChange (String IsQueryAfterChange)
	{

		set_Value (COLUMNNAME_IsQueryAfterChange, IsQueryAfterChange);
	}

	/** Get Query After Change.
		@return Issues a query request after the user has made changes to the field
	  */
	public String getIsQueryAfterChange()
	{
		return (String)get_Value(COLUMNNAME_IsQueryAfterChange);
	}

	/** IsQueryCriteria AD_Reference_ID=319 */
	public static final int ISQUERYCRITERIA_AD_Reference_ID=319;
	/** No = N */
	public static final String ISQUERYCRITERIA_No = "N";
	/** Yes = Y */
	public static final String ISQUERYCRITERIA_Yes = "Y";
	/** Set Query Criteria.
		@param IsQueryCriteria The column is also used as a query criteria
	*/
	public void setIsQueryCriteria (String IsQueryCriteria)
	{

		set_Value (COLUMNNAME_IsQueryCriteria, IsQueryCriteria);
	}

	/** Get Query Criteria.
		@return The column is also used as a query criteria
	  */
	public String getIsQueryCriteria()
	{
		return (String)get_Value(COLUMNNAME_IsQueryCriteria);
	}

	/** IsReadOnly AD_Reference_ID=319 */
	public static final int ISREADONLY_AD_Reference_ID=319;
	/** No = N */
	public static final String ISREADONLY_No = "N";
	/** Yes = Y */
	public static final String ISREADONLY_Yes = "Y";
	/** Set Read Only.
		@param IsReadOnly Field is read only
	*/
	public void setIsReadOnly (String IsReadOnly)
	{

		set_Value (COLUMNNAME_IsReadOnly, IsReadOnly);
	}

	/** Get Read Only.
		@return Field is read only
	  */
	public String getIsReadOnly()
	{
		return (String)get_Value(COLUMNNAME_IsReadOnly);
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

	/** Set Query Function.
		@param QueryFunction Database function for query
	*/
	public void setQueryFunction (String QueryFunction)
	{
		set_Value (COLUMNNAME_QueryFunction, QueryFunction);
	}

	/** Get Query Function.
		@return Database function for query
	  */
	public String getQueryFunction()
	{
		return (String)get_Value(COLUMNNAME_QueryFunction);
	}

	/** QueryOperator AD_Reference_ID=200061 */
	public static final int QUERYOPERATOR_AD_Reference_ID=200061;
	/** != = != */
	public static final String QUERYOPERATOR_NotEq = "!=";
	/** &lt; = &lt; */
	public static final String QUERYOPERATOR_Le = "<";
	/** &lt;= = &lt;= */
	public static final String QUERYOPERATOR_LeEq = "<=";
	/** = = = */
	public static final String QUERYOPERATOR_Eq = "=";
	/** &gt; = &gt; */
	public static final String QUERYOPERATOR_Gt = ">";
	/** &gt;= = &gt;= */
	public static final String QUERYOPERATOR_GtEq = ">=";
	/** Like = Like */
	public static final String QUERYOPERATOR_Like = "Like";
	/** Full Like = LIKE */
	public static final String QUERYOPERATOR_FullLike = "LIKE";
	/** Set Query Operator.
		@param QueryOperator Operator for database query
	*/
	public void setQueryOperator (String QueryOperator)
	{

		set_Value (COLUMNNAME_QueryOperator, QueryOperator);
	}

	/** Get Query Operator.
		@return Operator for database query
	  */
	public String getQueryOperator()
	{
		return (String)get_Value(COLUMNNAME_QueryOperator);
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

	/** Set Selection Column Sequence.
		@param SeqNoSelection Selection Column Sequence
	*/
	public void setSeqNoSelection (int SeqNoSelection)
	{
		set_Value (COLUMNNAME_SeqNoSelection, Integer.valueOf(SeqNoSelection));
	}

	/** Get Selection Column Sequence.
		@return Selection Column Sequence
	  */
	public int getSeqNoSelection()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SeqNoSelection);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}
}