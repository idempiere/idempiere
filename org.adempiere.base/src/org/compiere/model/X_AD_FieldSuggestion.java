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

/** Generated Model for AD_FieldSuggestion
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_FieldSuggestion")
public class X_AD_FieldSuggestion extends PO implements I_AD_FieldSuggestion, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_FieldSuggestion (Properties ctx, int AD_FieldSuggestion_ID, String trxName)
    {
      super (ctx, AD_FieldSuggestion_ID, trxName);
      /** if (AD_FieldSuggestion_ID == 0)
        {
			setAD_Field_ID (0);
			setAD_FieldSuggestion_ID (0);
			setAD_FieldSuggestion_UU (null);
			setAD_Language (null);
			setAD_UserClient_ID (0);
			setAD_User_ID (0);
			setFieldSuggestionTarget (null);
// E
			setIsApproved (false);
// N
			setIsUpdateBaseLanguage (true);
// Y
			setProcessed (false);
// N
        } */
    }

    /** Standard Constructor */
    public X_AD_FieldSuggestion (Properties ctx, int AD_FieldSuggestion_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_FieldSuggestion_ID, trxName, virtualColumns);
      /** if (AD_FieldSuggestion_ID == 0)
        {
			setAD_Field_ID (0);
			setAD_FieldSuggestion_ID (0);
			setAD_FieldSuggestion_UU (null);
			setAD_Language (null);
			setAD_UserClient_ID (0);
			setAD_User_ID (0);
			setFieldSuggestionTarget (null);
// E
			setIsApproved (false);
// N
			setIsUpdateBaseLanguage (true);
// Y
			setProcessed (false);
// N
        } */
    }

    /** Load Constructor */
    public X_AD_FieldSuggestion (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_FieldSuggestion[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Accept.
		@param AcceptSuggestion Accept suggested changes
	*/
	public void setAcceptSuggestion (String AcceptSuggestion)
	{
		set_Value (COLUMNNAME_AcceptSuggestion, AcceptSuggestion);
	}

	/** Get Accept.
		@return Accept suggested changes
	  */
	public String getAcceptSuggestion()
	{
		return (String)get_Value(COLUMNNAME_AcceptSuggestion);
	}

	public org.compiere.model.I_AD_Field getAD_Field() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Field)MTable.get(getCtx(), org.compiere.model.I_AD_Field.Table_ID)
			.getPO(getAD_Field_ID(), get_TrxName());
	}

	/** Set Field.
		@param AD_Field_ID Field on a database table
	*/
	public void setAD_Field_ID (int AD_Field_ID)
	{
		if (AD_Field_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_Field_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_Field_ID, Integer.valueOf(AD_Field_ID));
	}

	/** Get Field.
		@return Field on a database table
	  */
	public int getAD_Field_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Field_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Field Suggestions.
		@param AD_FieldSuggestion_ID Field Suggestions
	*/
	public void setAD_FieldSuggestion_ID (int AD_FieldSuggestion_ID)
	{
		if (AD_FieldSuggestion_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_FieldSuggestion_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_FieldSuggestion_ID, Integer.valueOf(AD_FieldSuggestion_ID));
	}

	/** Get Field Suggestions.
		@return Field Suggestions	  */
	public int getAD_FieldSuggestion_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_FieldSuggestion_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Field Suggestions UUID.
		@param AD_FieldSuggestion_UU Field Suggestions UUID
	*/
	public void setAD_FieldSuggestion_UU (String AD_FieldSuggestion_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_FieldSuggestion_UU, AD_FieldSuggestion_UU);
	}

	/** Get Field Suggestions UUID.
		@return Field Suggestions UUID	  */
	public String getAD_FieldSuggestion_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_FieldSuggestion_UU);
	}

	/** AD_Language AD_Reference_ID=106 */
	public static final int AD_LANGUAGE_AD_Reference_ID=106;
	/** Set Language.
		@param AD_Language Language for this entity
	*/
	public void setAD_Language (String AD_Language)
	{

		set_ValueNoCheck (COLUMNNAME_AD_Language, AD_Language);
	}

	/** Get Language.
		@return Language for this entity
	  */
	public String getAD_Language()
	{
		return (String)get_Value(COLUMNNAME_AD_Language);
	}

	public org.compiere.model.I_AD_Tab getAD_Tab() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Tab)MTable.get(getCtx(), org.compiere.model.I_AD_Tab.Table_ID)
			.getPO(getAD_Tab_ID(), get_TrxName());
	}

	/** Set Tab.
		@param AD_Tab_ID Tab within a Window
	*/
	public void setAD_Tab_ID (int AD_Tab_ID)
	{
		throw new IllegalArgumentException ("AD_Tab_ID is virtual column");	}

	/** Get Tab.
		@return Tab within a Window
	  */
	public int getAD_Tab_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Tab_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_AllClients_V getAD_UserClient() throws RuntimeException
	{
		return (org.compiere.model.I_AD_AllClients_V)MTable.get(getCtx(), org.compiere.model.I_AD_AllClients_V.Table_ID)
			.getPO(getAD_UserClient_ID(), get_TrxName());
	}

	/** Set Tenant of User.
		@param AD_UserClient_ID Tenant of User
	*/
	public void setAD_UserClient_ID (int AD_UserClient_ID)
	{
		if (AD_UserClient_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserClient_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserClient_ID, Integer.valueOf(AD_UserClient_ID));
	}

	/** Get Tenant of User.
		@return Tenant of User	  */
	public int getAD_UserClient_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserClient_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_AllUsers_V getAD_User() throws RuntimeException
	{
		return (org.compiere.model.I_AD_AllUsers_V)MTable.get(getCtx(), org.compiere.model.I_AD_AllUsers_V.Table_ID)
			.getPO(getAD_User_ID(), get_TrxName());
	}

	/** Set User/Contact.
		@param AD_User_ID User within the system - Internal or Business Partner Contact
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
	public int getAD_User_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_User_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_Window getAD_Window() throws RuntimeException
	{
		return (org.compiere.model.I_AD_Window)MTable.get(getCtx(), org.compiere.model.I_AD_Window.Table_ID)
			.getPO(getAD_Window_ID(), get_TrxName());
	}

	/** Set Window.
		@param AD_Window_ID Data entry or display window
	*/
	public void setAD_Window_ID (int AD_Window_ID)
	{
		throw new IllegalArgumentException ("AD_Window_ID is virtual column");	}

	/** Get Window.
		@return Data entry or display window
	  */
	public int getAD_Window_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_Window_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Compare.
		@param CompareSuggestion Compare suggested text with original text
	*/
	public void setCompareSuggestion (String CompareSuggestion)
	{
		set_Value (COLUMNNAME_CompareSuggestion, CompareSuggestion);
	}

	/** Get Compare.
		@return Compare suggested text with original text
	  */
	public String getCompareSuggestion()
	{
		return (String)get_Value(COLUMNNAME_CompareSuggestion);
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

	/** FieldSuggestionTarget AD_Reference_ID=200123 */
	public static final int FIELDSUGGESTIONTARGET_AD_Reference_ID=200123;
	/** Element = E */
	public static final String FIELDSUGGESTIONTARGET_Element = "E";
	/** Field = F */
	public static final String FIELDSUGGESTIONTARGET_Field = "F";
	/** Set Apply Suggestion To.
		@param FieldSuggestionTarget Apply Suggestion To
	*/
	public void setFieldSuggestionTarget (String FieldSuggestionTarget)
	{

		set_Value (COLUMNNAME_FieldSuggestionTarget, FieldSuggestionTarget);
	}

	/** Get Apply Suggestion To.
		@return Apply Suggestion To	  */
	public String getFieldSuggestionTarget()
	{
		return (String)get_Value(COLUMNNAME_FieldSuggestionTarget);
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

	/** Set Approved.
		@param IsApproved Indicates if this document requires approval
	*/
	public void setIsApproved (boolean IsApproved)
	{
		set_Value (COLUMNNAME_IsApproved, Boolean.valueOf(IsApproved));
	}

	/** Get Approved.
		@return Indicates if this document requires approval
	  */
	public boolean isApproved()
	{
		Object oo = get_Value(COLUMNNAME_IsApproved);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Update Base Language.
		@param IsUpdateBaseLanguage Update Base Language
	*/
	public void setIsUpdateBaseLanguage (boolean IsUpdateBaseLanguage)
	{
		set_Value (COLUMNNAME_IsUpdateBaseLanguage, Boolean.valueOf(IsUpdateBaseLanguage));
	}

	/** Get Update Base Language.
		@return Update Base Language	  */
	public boolean isUpdateBaseLanguage()
	{
		Object oo = get_Value(COLUMNNAME_IsUpdateBaseLanguage);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
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

	/** Set Processed.
		@param Processed The document has been processed
	*/
	public void setProcessed (boolean Processed)
	{
		set_Value (COLUMNNAME_Processed, Boolean.valueOf(Processed));
	}

	/** Get Processed.
		@return The document has been processed
	  */
	public boolean isProcessed()
	{
		Object oo = get_Value(COLUMNNAME_Processed);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Reject.
		@param RejectSuggestion Reject suggested changes
	*/
	public void setRejectSuggestion (String RejectSuggestion)
	{
		set_Value (COLUMNNAME_RejectSuggestion, RejectSuggestion);
	}

	/** Get Reject.
		@return Reject suggested changes
	  */
	public String getRejectSuggestion()
	{
		return (String)get_Value(COLUMNNAME_RejectSuggestion);
	}
}