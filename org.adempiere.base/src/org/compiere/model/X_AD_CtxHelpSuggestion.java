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

/** Generated Model for AD_CtxHelpSuggestion
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_CtxHelpSuggestion")
public class X_AD_CtxHelpSuggestion extends PO implements I_AD_CtxHelpSuggestion, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_CtxHelpSuggestion (Properties ctx, int AD_CtxHelpSuggestion_ID, String trxName)
    {
      super (ctx, AD_CtxHelpSuggestion_ID, trxName);
      /** if (AD_CtxHelpSuggestion_ID == 0)
        {
			setAD_CtxHelp_ID (0);
			setAD_CtxHelpMsg_ID (0);
			setAD_CtxHelpSuggestion_ID (0);
			setAD_CtxHelpSuggestion_UU (null);
			setAD_Language (null);
			setAD_UserClient_ID (0);
			setAD_User_ID (0);
			setIsApproved (false);
// N
			setIsSaveAsTenantCustomization (false);
// N
			setMsgText (null);
			setProcessed (false);
// N
        } */
    }

    /** Standard Constructor */
    public X_AD_CtxHelpSuggestion (Properties ctx, int AD_CtxHelpSuggestion_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_CtxHelpSuggestion_ID, trxName, virtualColumns);
      /** if (AD_CtxHelpSuggestion_ID == 0)
        {
			setAD_CtxHelp_ID (0);
			setAD_CtxHelpMsg_ID (0);
			setAD_CtxHelpSuggestion_ID (0);
			setAD_CtxHelpSuggestion_UU (null);
			setAD_Language (null);
			setAD_UserClient_ID (0);
			setAD_User_ID (0);
			setIsApproved (false);
// N
			setIsSaveAsTenantCustomization (false);
// N
			setMsgText (null);
			setProcessed (false);
// N
        } */
    }

    /** Load Constructor */
    public X_AD_CtxHelpSuggestion (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_CtxHelpSuggestion[")
        .append(get_ID()).append("]");
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

	public org.compiere.model.I_AD_CtxHelp getAD_CtxHelp() throws RuntimeException
	{
		return (org.compiere.model.I_AD_CtxHelp)MTable.get(getCtx(), org.compiere.model.I_AD_CtxHelp.Table_ID)
			.getPO(getAD_CtxHelp_ID(), get_TrxName());
	}

	/** Set Context Help.
		@param AD_CtxHelp_ID Context Help
	*/
	public void setAD_CtxHelp_ID (int AD_CtxHelp_ID)
	{
		if (AD_CtxHelp_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelp_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelp_ID, Integer.valueOf(AD_CtxHelp_ID));
	}

	/** Get Context Help.
		@return Context Help	  */
	public int getAD_CtxHelp_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_CtxHelp_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	public org.compiere.model.I_AD_CtxHelpMsg getAD_CtxHelpMsg() throws RuntimeException
	{
		return (org.compiere.model.I_AD_CtxHelpMsg)MTable.get(getCtx(), org.compiere.model.I_AD_CtxHelpMsg.Table_ID)
			.getPO(getAD_CtxHelpMsg_ID(), get_TrxName());
	}

	/** Set Context Help Message.
		@param AD_CtxHelpMsg_ID Context Help Message
	*/
	public void setAD_CtxHelpMsg_ID (int AD_CtxHelpMsg_ID)
	{
		if (AD_CtxHelpMsg_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelpMsg_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelpMsg_ID, Integer.valueOf(AD_CtxHelpMsg_ID));
	}

	/** Get Context Help Message.
		@return Context Help Message	  */
	public int getAD_CtxHelpMsg_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_CtxHelpMsg_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Context Help Suggestion.
		@param AD_CtxHelpSuggestion_ID Context Help Suggestion
	*/
	public void setAD_CtxHelpSuggestion_ID (int AD_CtxHelpSuggestion_ID)
	{
		if (AD_CtxHelpSuggestion_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelpSuggestion_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_CtxHelpSuggestion_ID, Integer.valueOf(AD_CtxHelpSuggestion_ID));
	}

	/** Get Context Help Suggestion.
		@return Context Help Suggestion	  */
	public int getAD_CtxHelpSuggestion_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_CtxHelpSuggestion_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Context Help Suggestion UUID.
		@param AD_CtxHelpSuggestion_UU Context Help Suggestion UUID
	*/
	public void setAD_CtxHelpSuggestion_UU (String AD_CtxHelpSuggestion_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_CtxHelpSuggestion_UU, AD_CtxHelpSuggestion_UU);
	}

	/** Get Context Help Suggestion UUID.
		@return Context Help Suggestion UUID	  */
	public String getAD_CtxHelpSuggestion_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_CtxHelpSuggestion_UU);
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

	/** Set Save As Tenant Customization.
		@param IsSaveAsTenantCustomization Apply changes as tenant customization
	*/
	public void setIsSaveAsTenantCustomization (boolean IsSaveAsTenantCustomization)
	{
		set_Value (COLUMNNAME_IsSaveAsTenantCustomization, Boolean.valueOf(IsSaveAsTenantCustomization));
	}

	/** Get Save As Tenant Customization.
		@return Apply changes as tenant customization
	  */
	public boolean isSaveAsTenantCustomization()
	{
		Object oo = get_Value(COLUMNNAME_IsSaveAsTenantCustomization);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Message Text.
		@param MsgText Textual Informational, Menu or Error Message
	*/
	public void setMsgText (String MsgText)
	{
		set_Value (COLUMNNAME_MsgText, MsgText);
	}

	/** Get Message Text.
		@return Textual Informational, Menu or Error Message
	  */
	public String getMsgText()
	{
		return (String)get_Value(COLUMNNAME_MsgText);
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