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

/** Generated Interface for MFA_Registration
 *  @author iDempiere (generated) 
 *  @version Development 9.0
 */
public interface I_MFA_Registration 
{

    /** TableName=MFA_Registration */
    public static final String Table_Name = "MFA_Registration";

    /** AD_Table_ID=200275 */
    public static final int Table_ID = 200275;

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

    /** Column name FailedLoginCount */
    public static final String COLUMNNAME_FailedLoginCount = "FailedLoginCount";

	/** Set Failed Login Count	  */
	public void setFailedLoginCount (int FailedLoginCount);

	/** Get Failed Login Count	  */
	public int getFailedLoginCount();

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

    /** Column name IsUserMFAPreferred */
    public static final String COLUMNNAME_IsUserMFAPreferred = "IsUserMFAPreferred";

	/** Set Preferred	  */
	public void setIsUserMFAPreferred (boolean IsUserMFAPreferred);

	/** Get Preferred	  */
	public boolean isUserMFAPreferred();

    /** Column name IsValid */
    public static final String COLUMNNAME_IsValid = "IsValid";

	/** Set Valid.
	  * Element is valid
	  */
	public void setIsValid (boolean IsValid);

	/** Get Valid.
	  * Element is valid
	  */
	public boolean isValid();

    /** Column name LastFailure */
    public static final String COLUMNNAME_LastFailure = "LastFailure";

	/** Set Last Failure	  */
	public void setLastFailure (Timestamp LastFailure);

	/** Get Last Failure	  */
	public Timestamp getLastFailure();

    /** Column name LastSuccess */
    public static final String COLUMNNAME_LastSuccess = "LastSuccess";

	/** Set Last Success	  */
	public void setLastSuccess (Timestamp LastSuccess);

	/** Get Last Success	  */
	public Timestamp getLastSuccess();

    /** Column name MFALastSecret */
    public static final String COLUMNNAME_MFALastSecret = "MFALastSecret";

	/** Set Last MFA Secret	  */
	public void setMFALastSecret (String MFALastSecret);

	/** Get Last MFA Secret	  */
	public String getMFALastSecret();

    /** Column name MFA_Method_ID */
    public static final String COLUMNNAME_MFA_Method_ID = "MFA_Method_ID";

	/** Set MFA Method.
	  * Multi-factor Authentication Method
	  */
	public void setMFA_Method_ID (int MFA_Method_ID);

	/** Get MFA Method.
	  * Multi-factor Authentication Method
	  */
	public int getMFA_Method_ID();

	public org.compiere.model.I_MFA_Method getMFA_Method() throws RuntimeException;

    /** Column name MFA_Registration_ID */
    public static final String COLUMNNAME_MFA_Registration_ID = "MFA_Registration_ID";

	/** Set MFA Registration	  */
	public void setMFA_Registration_ID (int MFA_Registration_ID);

	/** Get MFA Registration	  */
	public int getMFA_Registration_ID();

    /** Column name MFA_Registration_UU */
    public static final String COLUMNNAME_MFA_Registration_UU = "MFA_Registration_UU";

	/** Set MFA_Registration_UU	  */
	public void setMFA_Registration_UU (String MFA_Registration_UU);

	/** Get MFA_Registration_UU	  */
	public String getMFA_Registration_UU();

    /** Column name MFASecret */
    public static final String COLUMNNAME_MFASecret = "MFASecret";

	/** Set MFA Secret.
	  * Multi-factor Authentication Secret
	  */
	public void setMFASecret (String MFASecret);

	/** Get MFA Secret.
	  * Multi-factor Authentication Secret
	  */
	public String getMFASecret();

    /** Column name MFAUnregisteredAt */
    public static final String COLUMNNAME_MFAUnregisteredAt = "MFAUnregisteredAt";

	/** Set Unregistered at	  */
	public void setMFAUnregisteredAt (Timestamp MFAUnregisteredAt);

	/** Get Unregistered at	  */
	public Timestamp getMFAUnregisteredAt();

    /** Column name MFAValidatedAt */
    public static final String COLUMNNAME_MFAValidatedAt = "MFAValidatedAt";

	/** Set Validated at	  */
	public void setMFAValidatedAt (Timestamp MFAValidatedAt);

	/** Get Validated at	  */
	public Timestamp getMFAValidatedAt();

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

    /** Column name ParameterValue */
    public static final String COLUMNNAME_ParameterValue = "ParameterValue";

	/** Set Parameter Value	  */
	public void setParameterValue (String ParameterValue);

	/** Get Parameter Value	  */
	public String getParameterValue();

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
