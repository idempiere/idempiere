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

/** Generated Interface for AD_AuthorizationCredential
 *  @author iDempiere (generated) 
 *  @version Release 9
 */
public interface I_AD_AuthorizationCredential 
{

    /** TableName=AD_AuthorizationCredential */
    public static final String Table_Name = "AD_AuthorizationCredential";

    /** AD_Table_ID=200271 */
    public static final int Table_ID = 200271;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 6 - System - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(6);

    /** Load Meta Data */

    /** Column name AD_AuthorizationCredential_ID */
    public static final String COLUMNNAME_AD_AuthorizationCredential_ID = "AD_AuthorizationCredential_ID";

	/** Set Authorization Credential	  */
	public void setAD_AuthorizationCredential_ID (int AD_AuthorizationCredential_ID);

	/** Get Authorization Credential	  */
	public int getAD_AuthorizationCredential_ID();

    /** Column name AD_AuthorizationCredential_UU */
    public static final String COLUMNNAME_AD_AuthorizationCredential_UU = "AD_AuthorizationCredential_UU";

	/** Set AD_AuthorizationCredential_UU	  */
	public void setAD_AuthorizationCredential_UU (String AD_AuthorizationCredential_UU);

	/** Get AD_AuthorizationCredential_UU	  */
	public String getAD_AuthorizationCredential_UU();

    /** Column name AD_AuthorizationProvider_ID */
    public static final String COLUMNNAME_AD_AuthorizationProvider_ID = "AD_AuthorizationProvider_ID";

	/** Set Authorization Provider	  */
	public void setAD_AuthorizationProvider_ID (int AD_AuthorizationProvider_ID);

	/** Get Authorization Provider	  */
	public int getAD_AuthorizationProvider_ID();

	public org.compiere.model.I_AD_AuthorizationProvider getAD_AuthorizationProvider() throws RuntimeException;

    /** Column name AD_AuthorizationScopeList */
    public static final String COLUMNNAME_AD_AuthorizationScopeList = "AD_AuthorizationScopeList";

	/** Set Scope List	  */
	public void setAD_AuthorizationScopeList (String AD_AuthorizationScopeList);

	/** Get Scope List	  */
	public String getAD_AuthorizationScopeList();

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

    /** Column name AuthorizationClientId */
    public static final String COLUMNNAME_AuthorizationClientId = "AuthorizationClientId";

	/** Set Authorization client-id	  */
	public void setAuthorizationClientId (String AuthorizationClientId);

	/** Get Authorization client-id	  */
	public String getAuthorizationClientId();

    /** Column name AuthorizationClientSecret */
    public static final String COLUMNNAME_AuthorizationClientSecret = "AuthorizationClientSecret";

	/** Set Authorization client-secret	  */
	public void setAuthorizationClientSecret (String AuthorizationClientSecret);

	/** Get Authorization client-secret	  */
	public String getAuthorizationClientSecret();

    /** Column name AuthorizationRedirectURL */
    public static final String COLUMNNAME_AuthorizationRedirectURL = "AuthorizationRedirectURL";

	/** Set Authorization Redirect URL	  */
	public void setAuthorizationRedirectURL (String AuthorizationRedirectURL);

	/** Get Authorization Redirect URL	  */
	public String getAuthorizationRedirectURL();

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
