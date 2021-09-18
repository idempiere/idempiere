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
package org.compiere.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import org.compiere.util.KeyNamePair;

/** Generated Interface for AD_CtxHelpSuggestion
 *  @author iDempiere (generated) 
 *  @version Development 9.0
 */
public interface I_AD_CtxHelpSuggestion 
{

    /** TableName=AD_CtxHelpSuggestion */
    public static final String Table_Name = "AD_CtxHelpSuggestion";

    /** AD_Table_ID=200210 */
    public static final int Table_ID = 200210;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 4 - System 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(4);

    /** Load Meta Data */

    /** Column name AcceptSuggestion */
    public static final String COLUMNNAME_AcceptSuggestion = "AcceptSuggestion";

	/** Set Accept.
	  * Accept suggested changes
	  */
	public void setAcceptSuggestion (String AcceptSuggestion);

	/** Get Accept.
	  * Accept suggested changes
	  */
	public String getAcceptSuggestion();

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Client.
	  * Client/Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_CtxHelp_ID */
    public static final String COLUMNNAME_AD_CtxHelp_ID = "AD_CtxHelp_ID";

	/** Set Context Help	  */
	public void setAD_CtxHelp_ID (int AD_CtxHelp_ID);

	/** Get Context Help	  */
	public int getAD_CtxHelp_ID();

	public org.compiere.model.I_AD_CtxHelp getAD_CtxHelp() throws RuntimeException;

    /** Column name AD_CtxHelpMsg_ID */
    public static final String COLUMNNAME_AD_CtxHelpMsg_ID = "AD_CtxHelpMsg_ID";

	/** Set Context Help Message	  */
	public void setAD_CtxHelpMsg_ID (int AD_CtxHelpMsg_ID);

	/** Get Context Help Message	  */
	public int getAD_CtxHelpMsg_ID();

	public org.compiere.model.I_AD_CtxHelpMsg getAD_CtxHelpMsg() throws RuntimeException;

    /** Column name AD_CtxHelpSuggestion_ID */
    public static final String COLUMNNAME_AD_CtxHelpSuggestion_ID = "AD_CtxHelpSuggestion_ID";

	/** Set Context Help Suggestion	  */
	public void setAD_CtxHelpSuggestion_ID (int AD_CtxHelpSuggestion_ID);

	/** Get Context Help Suggestion	  */
	public int getAD_CtxHelpSuggestion_ID();

    /** Column name AD_CtxHelpSuggestion_UU */
    public static final String COLUMNNAME_AD_CtxHelpSuggestion_UU = "AD_CtxHelpSuggestion_UU";

	/** Set Context Help Suggestion UUID	  */
	public void setAD_CtxHelpSuggestion_UU (String AD_CtxHelpSuggestion_UU);

	/** Get Context Help Suggestion UUID	  */
	public String getAD_CtxHelpSuggestion_UU();

    /** Column name AD_Language */
    public static final String COLUMNNAME_AD_Language = "AD_Language";

	/** Set Language.
	  * Language for this entity
	  */
	public void setAD_Language (String AD_Language);

	/** Get Language.
	  * Language for this entity
	  */
	public String getAD_Language();

    /** Column name AD_Org_ID */
    public static final String COLUMNNAME_AD_Org_ID = "AD_Org_ID";

	/** Set Organization.
	  * Organizational entity within client
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within client
	  */
	public int getAD_Org_ID();

    /** Column name AD_UserClient_ID */
    public static final String COLUMNNAME_AD_UserClient_ID = "AD_UserClient_ID";

	/** Set Tenant of User	  */
	public void setAD_UserClient_ID (int AD_UserClient_ID);

	/** Get Tenant of User	  */
	public int getAD_UserClient_ID();

	public org.compiere.model.I_AD_AllClients_V getAD_UserClient() throws RuntimeException;

    /** Column name AD_User_ID */
    public static final String COLUMNNAME_AD_User_ID = "AD_User_ID";

	/** Set User/Contact.
	  * User within the system - Internal or Business Partner Contact
	  */
	public void setAD_User_ID (int AD_User_ID);

	/** Get User/Contact.
	  * User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID();

	public org.compiere.model.I_AD_AllUsers_V getAD_User() throws RuntimeException;

    /** Column name CompareSuggestion */
    public static final String COLUMNNAME_CompareSuggestion = "CompareSuggestion";

	/** Set Compare.
	  * Compare suggested text with original text
	  */
	public void setCompareSuggestion (String CompareSuggestion);

	/** Get Compare.
	  * Compare suggested text with original text
	  */
	public String getCompareSuggestion();

    /** Column name Created */
    public static final String COLUMNNAME_Created = "Created";

	/** Get Created.
	  * Date this record was created
	  */
	public Timestamp getCreated();

    /** Column name CreatedBy */
    public static final String COLUMNNAME_CreatedBy = "CreatedBy";

	/** Get Created By.
	  * User who created this records
	  */
	public int getCreatedBy();

    /** Column name IsActive */
    public static final String COLUMNNAME_IsActive = "IsActive";

	/** Set Active.
	  * The record is active in the system
	  */
	public void setIsActive (boolean IsActive);

	/** Get Active.
	  * The record is active in the system
	  */
	public boolean isActive();

    /** Column name IsApproved */
    public static final String COLUMNNAME_IsApproved = "IsApproved";

	/** Set Approved.
	  * Indicates if this document requires approval
	  */
	public void setIsApproved (boolean IsApproved);

	/** Get Approved.
	  * Indicates if this document requires approval
	  */
	public boolean isApproved();

    /** Column name IsSaveAsTenantCustomization */
    public static final String COLUMNNAME_IsSaveAsTenantCustomization = "IsSaveAsTenantCustomization";

	/** Set Save As Tenant Customization.
	  * Apply changes as tenant customization
	  */
	public void setIsSaveAsTenantCustomization (boolean IsSaveAsTenantCustomization);

	/** Get Save As Tenant Customization.
	  * Apply changes as tenant customization
	  */
	public boolean isSaveAsTenantCustomization();

    /** Column name MsgText */
    public static final String COLUMNNAME_MsgText = "MsgText";

	/** Set Message Text.
	  * Textual Informational, Menu or Error Message
	  */
	public void setMsgText (String MsgText);

	/** Get Message Text.
	  * Textual Informational, Menu or Error Message
	  */
	public String getMsgText();

    /** Column name Processed */
    public static final String COLUMNNAME_Processed = "Processed";

	/** Set Processed.
	  * The document has been processed
	  */
	public void setProcessed (boolean Processed);

	/** Get Processed.
	  * The document has been processed
	  */
	public boolean isProcessed();

    /** Column name RejectSuggestion */
    public static final String COLUMNNAME_RejectSuggestion = "RejectSuggestion";

	/** Set Reject.
	  * Reject suggested changes
	  */
	public void setRejectSuggestion (String RejectSuggestion);

	/** Get Reject.
	  * Reject suggested changes
	  */
	public String getRejectSuggestion();

    /** Column name Updated */
    public static final String COLUMNNAME_Updated = "Updated";

	/** Get Updated.
	  * Date this record was updated
	  */
	public Timestamp getUpdated();

    /** Column name UpdatedBy */
    public static final String COLUMNNAME_UpdatedBy = "UpdatedBy";

	/** Get Updated By.
	  * User who updated this records
	  */
	public int getUpdatedBy();
}
