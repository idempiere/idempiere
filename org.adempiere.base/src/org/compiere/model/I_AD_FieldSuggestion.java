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

/** Generated Interface for AD_FieldSuggestion
 *  @author iDempiere (generated) 
 *  @version Development 9.0
 */
public interface I_AD_FieldSuggestion 
{

    /** TableName=AD_FieldSuggestion */
    public static final String Table_Name = "AD_FieldSuggestion";

    /** AD_Table_ID=200209 */
    public static final int Table_ID = 200209;

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

    /** Column name AD_Field_ID */
    public static final String COLUMNNAME_AD_Field_ID = "AD_Field_ID";

	/** Set Field.
	  * Field on a database table
	  */
	public void setAD_Field_ID (int AD_Field_ID);

	/** Get Field.
	  * Field on a database table
	  */
	public int getAD_Field_ID();

	public org.compiere.model.I_AD_Field getAD_Field() throws RuntimeException;

    /** Column name AD_FieldSuggestion_ID */
    public static final String COLUMNNAME_AD_FieldSuggestion_ID = "AD_FieldSuggestion_ID";

	/** Set Field Suggestions	  */
	public void setAD_FieldSuggestion_ID (int AD_FieldSuggestion_ID);

	/** Get Field Suggestions	  */
	public int getAD_FieldSuggestion_ID();

    /** Column name AD_FieldSuggestion_UU */
    public static final String COLUMNNAME_AD_FieldSuggestion_UU = "AD_FieldSuggestion_UU";

	/** Set Field Suggestions UUID	  */
	public void setAD_FieldSuggestion_UU (String AD_FieldSuggestion_UU);

	/** Get Field Suggestions UUID	  */
	public String getAD_FieldSuggestion_UU();

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

    /** Column name AD_Tab_ID */
    public static final String COLUMNNAME_AD_Tab_ID = "AD_Tab_ID";

	/** Set Tab.
	  * Tab within a Window
	  */
	public void setAD_Tab_ID (int AD_Tab_ID);

	/** Get Tab.
	  * Tab within a Window
	  */
	public int getAD_Tab_ID();

	public org.compiere.model.I_AD_Tab getAD_Tab() throws RuntimeException;

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

    /** Column name AD_Window_ID */
    public static final String COLUMNNAME_AD_Window_ID = "AD_Window_ID";

	/** Set Window.
	  * Data entry or display window
	  */
	public void setAD_Window_ID (int AD_Window_ID);

	/** Get Window.
	  * Data entry or display window
	  */
	public int getAD_Window_ID();

	public org.compiere.model.I_AD_Window getAD_Window() throws RuntimeException;

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

    /** Column name Description */
    public static final String COLUMNNAME_Description = "Description";

	/** Set Description.
	  * Optional short description of the record
	  */
	public void setDescription (String Description);

	/** Get Description.
	  * Optional short description of the record
	  */
	public String getDescription();

    /** Column name FieldSuggestionTarget */
    public static final String COLUMNNAME_FieldSuggestionTarget = "FieldSuggestionTarget";

	/** Set Apply Suggestion To	  */
	public void setFieldSuggestionTarget (String FieldSuggestionTarget);

	/** Get Apply Suggestion To	  */
	public String getFieldSuggestionTarget();

    /** Column name Help */
    public static final String COLUMNNAME_Help = "Help";

	/** Set Comment/Help.
	  * Comment or Hint
	  */
	public void setHelp (String Help);

	/** Get Comment/Help.
	  * Comment or Hint
	  */
	public String getHelp();

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

    /** Column name IsUpdateBaseLanguage */
    public static final String COLUMNNAME_IsUpdateBaseLanguage = "IsUpdateBaseLanguage";

	/** Set Update Base Language	  */
	public void setIsUpdateBaseLanguage (boolean IsUpdateBaseLanguage);

	/** Get Update Base Language	  */
	public boolean isUpdateBaseLanguage();

    /** Column name Name */
    public static final String COLUMNNAME_Name = "Name";

	/** Set Name.
	  * Alphanumeric identifier of the entity
	  */
	public void setName (String Name);

	/** Get Name.
	  * Alphanumeric identifier of the entity
	  */
	public String getName();

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
