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

/** Generated Interface for AD_AuthorizationAccount
 *  @author iDempiere (generated) 
 *  @version Development 9.0
 */
public interface I_AD_AuthorizationAccount 
{

    /** TableName=AD_AuthorizationAccount */
    public static final String Table_Name = "AD_AuthorizationAccount";

    /** AD_Table_ID=200272 */
    public static final int Table_ID = 200272;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 6 - System - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(6);

    /** Load Meta Data */

    /** Column name AccessToken */
    public static final String COLUMNNAME_AccessToken = "AccessToken";

	/** Set Access Token	  */
	public void setAccessToken (String AccessToken);

	/** Get Access Token	  */
	public String getAccessToken();

    /** Column name AccessTokenTimestamp */
    public static final String COLUMNNAME_AccessTokenTimestamp = "AccessTokenTimestamp";

	/** Set Access Token Timestamp	  */
	public void setAccessTokenTimestamp (Timestamp AccessTokenTimestamp);

	/** Get Access Token Timestamp	  */
	public Timestamp getAccessTokenTimestamp();

    /** Column name AD_AuthorizationAccount_ID */
    public static final String COLUMNNAME_AD_AuthorizationAccount_ID = "AD_AuthorizationAccount_ID";

	/** Set Authorization Account	  */
	public void setAD_AuthorizationAccount_ID (int AD_AuthorizationAccount_ID);

	/** Get Authorization Account	  */
	public int getAD_AuthorizationAccount_ID();

    /** Column name AD_AuthorizationAccount_UU */
    public static final String COLUMNNAME_AD_AuthorizationAccount_UU = "AD_AuthorizationAccount_UU";

	/** Set AD_AuthorizationAccount_UU	  */
	public void setAD_AuthorizationAccount_UU (String AD_AuthorizationAccount_UU);

	/** Get AD_AuthorizationAccount_UU	  */
	public String getAD_AuthorizationAccount_UU();

    /** Column name AD_AuthorizationCredential_ID */
    public static final String COLUMNNAME_AD_AuthorizationCredential_ID = "AD_AuthorizationCredential_ID";

	/** Set Authorization Credential	  */
	public void setAD_AuthorizationCredential_ID (int AD_AuthorizationCredential_ID);

	/** Get Authorization Credential	  */
	public int getAD_AuthorizationCredential_ID();

	public org.compiere.model.I_AD_AuthorizationCredential getAD_AuthorizationCredential() throws RuntimeException;

    /** Column name AD_AuthorizationScopes */
    public static final String COLUMNNAME_AD_AuthorizationScopes = "AD_AuthorizationScopes";

	/** Set Authorization Scopes	  */
	public void setAD_AuthorizationScopes (String AD_AuthorizationScopes);

	/** Get Authorization Scopes	  */
	public String getAD_AuthorizationScopes();

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

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException;

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

    /** Column name ExpireInSeconds */
    public static final String COLUMNNAME_ExpireInSeconds = "ExpireInSeconds";

	/** Set Expire in Seconds	  */
	public void setExpireInSeconds (BigDecimal ExpireInSeconds);

	/** Get Expire in Seconds	  */
	public BigDecimal getExpireInSeconds();

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

    /** Column name IsAccessRevoked */
    public static final String COLUMNNAME_IsAccessRevoked = "IsAccessRevoked";

	/** Set Access Revoked	  */
	public void setIsAccessRevoked (boolean IsAccessRevoked);

	/** Get Access Revoked	  */
	public boolean isAccessRevoked();

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

    /** Column name IsAuthorized */
    public static final String COLUMNNAME_IsAuthorized = "IsAuthorized";

	/** Set Authorized	  */
	public void setIsAuthorized (boolean IsAuthorized);

	/** Get Authorized	  */
	public boolean isAuthorized();

    /** Column name RefreshToken */
    public static final String COLUMNNAME_RefreshToken = "RefreshToken";

	/** Set Refresh Token	  */
	public void setRefreshToken (String RefreshToken);

	/** Get Refresh Token	  */
	public String getRefreshToken();

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
