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

/** Generated Interface for AD_AllUsers_V
 *  @author iDempiere (generated) 
 *  @version Release 9
 */
public interface I_AD_AllUsers_V 
{

    /** TableName=AD_AllUsers_V */
    public static final String Table_Name = "AD_AllUsers_V";

    /** AD_Table_ID=200224 */
    public static final int Table_ID = 200224;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 4 - System 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(4);

    /** Load Meta Data */

    /** Column name AD_AllClients_V_ID */
    public static final String COLUMNNAME_AD_AllClients_V_ID = "AD_AllClients_V_ID";

	/** Set Client (All)	  */
	public void setAD_AllClients_V_ID (int AD_AllClients_V_ID);

	/** Get Client (All)	  */
	public int getAD_AllClients_V_ID();

	public org.compiere.model.I_AD_AllClients_V getAD_AllClients_V() throws RuntimeException;

    /** Column name AD_AllUsers_V_ID */
    public static final String COLUMNNAME_AD_AllUsers_V_ID = "AD_AllUsers_V_ID";

	/** Set User (All)	  */
	public void setAD_AllUsers_V_ID (int AD_AllUsers_V_ID);

	/** Get User (All)	  */
	public int getAD_AllUsers_V_ID();

    /** Column name AD_AllUsers_V_UU */
    public static final String COLUMNNAME_AD_AllUsers_V_UU = "AD_AllUsers_V_UU";

	/** Set AD_AllUsers_V_UU	  */
	public void setAD_AllUsers_V_UU (String AD_AllUsers_V_UU);

	/** Get AD_AllUsers_V_UU	  */
	public String getAD_AllUsers_V_UU();

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Client.
	  * Client/Tenant for this installation.
	  */
	public int getAD_Client_ID();

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

    /** Column name DateAccountLocked */
    public static final String COLUMNNAME_DateAccountLocked = "DateAccountLocked";

	/** Set Date Account Locked	  */
	public void setDateAccountLocked (Timestamp DateAccountLocked);

	/** Get Date Account Locked	  */
	public Timestamp getDateAccountLocked();

    /** Column name DateLastLogin */
    public static final String COLUMNNAME_DateLastLogin = "DateLastLogin";

	/** Set Date Last Login	  */
	public void setDateLastLogin (Timestamp DateLastLogin);

	/** Get Date Last Login	  */
	public Timestamp getDateLastLogin();

    /** Column name DatePasswordChanged */
    public static final String COLUMNNAME_DatePasswordChanged = "DatePasswordChanged";

	/** Set Date Password Changed	  */
	public void setDatePasswordChanged (Timestamp DatePasswordChanged);

	/** Get Date Password Changed	  */
	public Timestamp getDatePasswordChanged();

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

    /** Column name EMail */
    public static final String COLUMNNAME_EMail = "EMail";

	/** Set EMail Address.
	  * Electronic Mail Address
	  */
	public void setEMail (String EMail);

	/** Get EMail Address.
	  * Electronic Mail Address
	  */
	public String getEMail();

    /** Column name FailedLoginCount */
    public static final String COLUMNNAME_FailedLoginCount = "FailedLoginCount";

	/** Set Failed Login Count	  */
	public void setFailedLoginCount (int FailedLoginCount);

	/** Get Failed Login Count	  */
	public int getFailedLoginCount();

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

    /** Column name IsExpired */
    public static final String COLUMNNAME_IsExpired = "IsExpired";

	/** Set Expired	  */
	public void setIsExpired (boolean IsExpired);

	/** Get Expired	  */
	public boolean isExpired();

    /** Column name IsLocked */
    public static final String COLUMNNAME_IsLocked = "IsLocked";

	/** Set Locked	  */
	public void setIsLocked (boolean IsLocked);

	/** Get Locked	  */
	public boolean isLocked();

    /** Column name IsNoExpire */
    public static final String COLUMNNAME_IsNoExpire = "IsNoExpire";

	/** Set No Expire	  */
	public void setIsNoExpire (boolean IsNoExpire);

	/** Get No Expire	  */
	public boolean isNoExpire();

    /** Column name IsNoPasswordReset */
    public static final String COLUMNNAME_IsNoPasswordReset = "IsNoPasswordReset";

	/** Set No Password Reset	  */
	public void setIsNoPasswordReset (boolean IsNoPasswordReset);

	/** Get No Password Reset	  */
	public boolean isNoPasswordReset();

    /** Column name IsSupportUser */
    public static final String COLUMNNAME_IsSupportUser = "IsSupportUser";

	/** Set Support User	  */
	public void setIsSupportUser (boolean IsSupportUser);

	/** Get Support User	  */
	public boolean isSupportUser();

    /** Column name LDAPUser */
    public static final String COLUMNNAME_LDAPUser = "LDAPUser";

	/** Set LDAP User Name.
	  * User Name used for authorization via LDAP (directory) services
	  */
	public void setLDAPUser (String LDAPUser);

	/** Get LDAP User Name.
	  * User Name used for authorization via LDAP (directory) services
	  */
	public String getLDAPUser();

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

    /** Column name Password */
    public static final String COLUMNNAME_Password = "Password";

	/** Set Password.
	  * Password of any length (case sensitive)
	  */
	public void setPassword (String Password);

	/** Get Password.
	  * Password of any length (case sensitive)
	  */
	public String getPassword();

    /** Column name Salt */
    public static final String COLUMNNAME_Salt = "Salt";

	/** Set Salt.
	  * Random data added to improve password hash effectiveness
	  */
	public void setSalt (String Salt);

	/** Get Salt.
	  * Random data added to improve password hash effectiveness
	  */
	public String getSalt();

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

    /** Column name UserPIN */
    public static final String COLUMNNAME_UserPIN = "UserPIN";

	/** Set User PIN	  */
	public void setUserPIN (String UserPIN);

	/** Get User PIN	  */
	public String getUserPIN();

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
