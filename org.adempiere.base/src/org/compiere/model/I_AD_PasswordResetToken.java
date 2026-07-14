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

/** Generated Interface for AD_PasswordResetToken
 *  @author iDempiere (generated) 
 *  @version Release 14
 */
public interface I_AD_PasswordResetToken 
{

    /** TableName=AD_PasswordResetToken */
    public static final String Table_Name = "AD_PasswordResetToken";

    /** AD_Table_ID=200449 */
    public static final int Table_ID = 200449;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 4 - System 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(4);

    /** Load Meta Data */

    /** Column name AD_Client_ID */
    public static final String COLUMNNAME_AD_Client_ID = "AD_Client_ID";

	/** Get Tenant.
	  * Tenant for this installation.
	  */
	public int getAD_Client_ID();

    /** Column name AD_Org_ID */
    public static final String COLUMNNAME_AD_Org_ID = "AD_Org_ID";

	/** Set Organization.
	  * Organizational entity within tenant
	  */
	public void setAD_Org_ID (int AD_Org_ID);

	/** Get Organization.
	  * Organizational entity within tenant
	  */
	public int getAD_Org_ID();

    /** Column name AD_PasswordResetToken_ID */
    public static final String COLUMNNAME_AD_PasswordResetToken_ID = "AD_PasswordResetToken_ID";

	/** Set Password Reset Token	  */
	public void setAD_PasswordResetToken_ID (int AD_PasswordResetToken_ID);

	/** Get Password Reset Token	  */
	public int getAD_PasswordResetToken_ID();

    /** Column name AD_PasswordResetToken_UU */
    public static final String COLUMNNAME_AD_PasswordResetToken_UU = "AD_PasswordResetToken_UU";

	/** Set AD_PasswordResetToken_UU	  */
	public void setAD_PasswordResetToken_UU (String AD_PasswordResetToken_UU);

	/** Get AD_PasswordResetToken_UU	  */
	public String getAD_PasswordResetToken_UU();

    /** Column name AttemptsUsed */
    public static final String COLUMNNAME_AttemptsUsed = "AttemptsUsed";

	/** Set Attempts Used	  */
	public void setAttemptsUsed (int AttemptsUsed);

	/** Get Attempts Used	  */
	public int getAttemptsUsed();

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

    /** Column name Expiration */
    public static final String COLUMNNAME_Expiration = "Expiration";

	/** Set Expire On.
	  * Expire On
	  */
	public void setExpiration (Timestamp Expiration);

	/** Get Expire On.
	  * Expire On
	  */
	public Timestamp getExpiration();

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

    /** Column name OneTimeCode */
    public static final String COLUMNNAME_OneTimeCode = "OneTimeCode";

	/** Set One Time Code	  */
	public void setOneTimeCode (String OneTimeCode);

	/** Get One Time Code	  */
	public String getOneTimeCode();

    /** Column name TokenStatus */
    public static final String COLUMNNAME_TokenStatus = "TokenStatus";

	/** Set Token Status	  */
	public void setTokenStatus (String TokenStatus);

	/** Get Token Status	  */
	public String getTokenStatus();

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

    /** Column name VerifiedTokenExpires */
    public static final String COLUMNNAME_VerifiedTokenExpires = "VerifiedTokenExpires";

	/** Set Verified Token Expires.
	  * Deadline to submit the new password after verifying
	  */
	public void setVerifiedTokenExpires (Timestamp VerifiedTokenExpires);

	/** Get Verified Token Expires.
	  * Deadline to submit the new password after verifying
	  */
	public Timestamp getVerifiedTokenExpires();

    /** Column name VerifiedTokenHash */
    public static final String COLUMNNAME_VerifiedTokenHash = "VerifiedTokenHash";

	/** Set Verified Token Hash	  */
	public void setVerifiedTokenHash (String VerifiedTokenHash);

	/** Get Verified Token Hash	  */
	public String getVerifiedTokenHash();
}
