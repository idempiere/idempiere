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

/** Generated Interface for AD_Client
 *  @author iDempiere (generated) 
 *  @version Release 8.1
 */
public interface I_AD_Client 
{

    /** TableName=AD_Client */
    public static final String Table_Name = "AD_Client";

    /** AD_Table_ID=112 */
    public static final int Table_ID = 112;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 6 - System - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(6);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Client.
	  * Client/Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Client_UU */
    public static final String COLUMNNAME_AD_Client_UU = "AD_Client_UU";

	/** Set AD_Client_UU	  */
	public void setAD_Client_UU (String AD_Client_UU);

	/** Get AD_Client_UU	  */
	public String getAD_Client_UU();

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

    /** Column name AD_PasswordRule_ID */
    public static final String COLUMNNAME_AD_PasswordRule_ID = "AD_PasswordRule_ID";

	/** Set Password Policies	  */
	public void setAD_PasswordRule_ID (int AD_PasswordRule_ID);

	/** Get Password Policies	  */
	public int getAD_PasswordRule_ID();

	public org.compiere.model.I_AD_PasswordRule getAD_PasswordRule() throws RuntimeException;

    /** Column name AD_ReplicationStrategy_ID */
    public static final String COLUMNNAME_AD_ReplicationStrategy_ID = "AD_ReplicationStrategy_ID";

	/** Set Replication Strategy.
	  * Data Replication Strategy
	  */
	public void setAD_ReplicationStrategy_ID (int AD_ReplicationStrategy_ID);

	/** Get Replication Strategy.
	  * Data Replication Strategy
	  */
	public int getAD_ReplicationStrategy_ID();

	public org.compiere.model.I_AD_ReplicationStrategy getAD_ReplicationStrategy() throws RuntimeException;

    /** Column name AutoArchive */
    public static final String COLUMNNAME_AutoArchive = "AutoArchive";

	/** Set Auto Archive.
	  * Enable and level of automatic Archive of documents
	  */
	public void setAutoArchive (String AutoArchive);

	/** Get Auto Archive.
	  * Enable and level of automatic Archive of documents
	  */
	public String getAutoArchive();

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

    /** Column name DocumentDir */
    public static final String COLUMNNAME_DocumentDir = "DocumentDir";

	/** Set Document Directory.
	  * Directory for documents from the application server
	  */
	public void setDocumentDir (String DocumentDir);

	/** Get Document Directory.
	  * Directory for documents from the application server
	  */
	public String getDocumentDir();

    /** Column name EMailTest */
    public static final String COLUMNNAME_EMailTest = "EMailTest";

	/** Set EMail Test.
	  * Test EMail
	  */
	public void setEMailTest (String EMailTest);

	/** Get EMail Test.
	  * Test EMail
	  */
	public String getEMailTest();

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

    /** Column name IsMultiLingualDocument */
    public static final String COLUMNNAME_IsMultiLingualDocument = "IsMultiLingualDocument";

	/** Set Multi Lingual Documents.
	  * Documents are Multi Lingual
	  */
	public void setIsMultiLingualDocument (boolean IsMultiLingualDocument);

	/** Get Multi Lingual Documents.
	  * Documents are Multi Lingual
	  */
	public boolean isMultiLingualDocument();

    /** Column name IsPostImmediate */
    public static final String COLUMNNAME_IsPostImmediate = "IsPostImmediate";

	/** Set Post Immediately (Deprecated).
	  * Post the accounting immediately for testing (Deprecated)
	  */
	public void setIsPostImmediate (boolean IsPostImmediate);

	/** Get Post Immediately (Deprecated).
	  * Post the accounting immediately for testing (Deprecated)
	  */
	public boolean isPostImmediate();

    /** Column name IsSecureSMTP */
    public static final String COLUMNNAME_IsSecureSMTP = "IsSecureSMTP";

	/** Set SMTP SSL/TLS.
	  * Use SSL/TLS for SMTP
	  */
	public void setIsSecureSMTP (boolean IsSecureSMTP);

	/** Get SMTP SSL/TLS.
	  * Use SSL/TLS for SMTP
	  */
	public boolean isSecureSMTP();

    /** Column name IsServerEMail */
    public static final String COLUMNNAME_IsServerEMail = "IsServerEMail";

	/** Set Server EMail.
	  * Send EMail from Server
	  */
	public void setIsServerEMail (boolean IsServerEMail);

	/** Get Server EMail.
	  * Send EMail from Server
	  */
	public boolean isServerEMail();

    /** Column name IsSmtpAuthorization */
    public static final String COLUMNNAME_IsSmtpAuthorization = "IsSmtpAuthorization";

	/** Set SMTP Authentication.
	  * Your mail server requires Authentication
	  */
	public void setIsSmtpAuthorization (boolean IsSmtpAuthorization);

	/** Get SMTP Authentication.
	  * Your mail server requires Authentication
	  */
	public boolean isSmtpAuthorization();

    /** Column name IsUseASP */
    public static final String COLUMNNAME_IsUseASP = "IsUseASP";

	/** Set IsUseASP	  */
	public void setIsUseASP (boolean IsUseASP);

	/** Get IsUseASP	  */
	public boolean isUseASP();

    /** Column name IsUseBetaFunctions */
    public static final String COLUMNNAME_IsUseBetaFunctions = "IsUseBetaFunctions";

	/** Set Use Beta Functions.
	  * Enable the use of Beta Functionality
	  */
	public void setIsUseBetaFunctions (boolean IsUseBetaFunctions);

	/** Get Use Beta Functions.
	  * Enable the use of Beta Functionality
	  */
	public boolean isUseBetaFunctions();

    /** Column name MMPolicy */
    public static final String COLUMNNAME_MMPolicy = "MMPolicy";

	/** Set Material Policy.
	  * Material Movement Policy
	  */
	public void setMMPolicy (String MMPolicy);

	/** Get Material Policy.
	  * Material Movement Policy
	  */
	public String getMMPolicy();

    /** Column name ModelValidationClasses */
    public static final String COLUMNNAME_ModelValidationClasses = "ModelValidationClasses";

	/** Set Model Validation Classes.
	  * List of data model validation classes separated by ;

	  */
	public void setModelValidationClasses (String ModelValidationClasses);

	/** Get Model Validation Classes.
	  * List of data model validation classes separated by ;

	  */
	public String getModelValidationClasses();

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

    /** Column name RequestEMail */
    public static final String COLUMNNAME_RequestEMail = "RequestEMail";

	/** Set Request EMail.
	  * EMail address to send automated mails from or receive mails for automated processing (fully qualified)
	  */
	public void setRequestEMail (String RequestEMail);

	/** Get Request EMail.
	  * EMail address to send automated mails from or receive mails for automated processing (fully qualified)
	  */
	public String getRequestEMail();

    /** Column name RequestFolder */
    public static final String COLUMNNAME_RequestFolder = "RequestFolder";

	/** Set Request Folder.
	  * EMail folder to process incoming emails;
 if empty INBOX is used
	  */
	public void setRequestFolder (String RequestFolder);

	/** Get Request Folder.
	  * EMail folder to process incoming emails;
 if empty INBOX is used
	  */
	public String getRequestFolder();

    /** Column name RequestUser */
    public static final String COLUMNNAME_RequestUser = "RequestUser";

	/** Set Request User.
	  * User Name (ID) of the email owner
	  */
	public void setRequestUser (String RequestUser);

	/** Get Request User.
	  * User Name (ID) of the email owner
	  */
	public String getRequestUser();

    /** Column name RequestUserPW */
    public static final String COLUMNNAME_RequestUserPW = "RequestUserPW";

	/** Set Request User Password.
	  * Password of the user name (ID) for mail processing
	  */
	public void setRequestUserPW (String RequestUserPW);

	/** Get Request User Password.
	  * Password of the user name (ID) for mail processing
	  */
	public String getRequestUserPW();

    /** Column name SMTPHost */
    public static final String COLUMNNAME_SMTPHost = "SMTPHost";

	/** Set Mail Host.
	  * Hostname of Mail Server for SMTP and IMAP
	  */
	public void setSMTPHost (String SMTPHost);

	/** Get Mail Host.
	  * Hostname of Mail Server for SMTP and IMAP
	  */
	public String getSMTPHost();

    /** Column name SMTPPort */
    public static final String COLUMNNAME_SMTPPort = "SMTPPort";

	/** Set SMTP Port.
	  * SMTP Port Number
	  */
	public void setSMTPPort (int SMTPPort);

	/** Get SMTP Port.
	  * SMTP Port Number
	  */
	public int getSMTPPort();

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

    /** Column name Value */
    public static final String COLUMNNAME_Value = "Value";

	/** Set Search Key.
	  * Search key for the record in the format required - must be unique
	  */
	public void setValue (String Value);

	/** Get Search Key.
	  * Search key for the record in the format required - must be unique
	  */
	public String getValue();
}
