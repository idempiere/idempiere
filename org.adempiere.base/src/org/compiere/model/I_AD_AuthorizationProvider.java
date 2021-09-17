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

/** Generated Interface for AD_AuthorizationProvider
 *  @author iDempiere (generated) 
 *  @version Development 9.0
 */
public interface I_AD_AuthorizationProvider 
{

    /** TableName=AD_AuthorizationProvider */
    public static final String Table_Name = "AD_AuthorizationProvider";

    /** AD_Table_ID=200269 */
    public static final int Table_ID = 200269;

    KeyNamePair Model = new KeyNamePair(Table_ID, Table_Name);

    /** AccessLevel = 6 - System - Client 
     */
    BigDecimal accessLevel = BigDecimal.valueOf(6);

    /** Load Meta Data */

    /** Column name AD_AuthorizationProvider_ID */
    public static final String COLUMNNAME_AD_AuthorizationProvider_ID = "AD_AuthorizationProvider_ID";

	/** Set Authorization Provider	  */
	public void setAD_AuthorizationProvider_ID (int AD_AuthorizationProvider_ID);

	/** Get Authorization Provider	  */
	public int getAD_AuthorizationProvider_ID();

    /** Column name AD_AuthorizationProvider_UU */
    public static final String COLUMNNAME_AD_AuthorizationProvider_UU = "AD_AuthorizationProvider_UU";

	/** Set AD_AuthorizationProvider_UU	  */
	public void setAD_AuthorizationProvider_UU (String AD_AuthorizationProvider_UU);

	/** Get AD_AuthorizationProvider_UU	  */
	public String getAD_AuthorizationProvider_UU();

    /** Column name AD_AuthorizationType */
    public static final String COLUMNNAME_AD_AuthorizationType = "AD_AuthorizationType";

	/** Set Authorization Type	  */
	public void setAD_AuthorizationType (String AD_AuthorizationType);

	/** Get Authorization Type	  */
	public String getAD_AuthorizationType();

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

    /** Column name AuthorizationEndpoint */
    public static final String COLUMNNAME_AuthorizationEndpoint = "AuthorizationEndpoint";

	/** Set Authorization Endpoint	  */
	public void setAuthorizationEndpoint (String AuthorizationEndpoint);

	/** Get Authorization Endpoint	  */
	public String getAuthorizationEndpoint();

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

    /** Column name RevokeEndpoint */
    public static final String COLUMNNAME_RevokeEndpoint = "RevokeEndpoint";

	/** Set Revoke Endpoint	  */
	public void setRevokeEndpoint (String RevokeEndpoint);

	/** Get Revoke Endpoint	  */
	public String getRevokeEndpoint();

    /** Column name TokenEndpoint */
    public static final String COLUMNNAME_TokenEndpoint = "TokenEndpoint";

	/** Set Token Endpoint	  */
	public void setTokenEndpoint (String TokenEndpoint);

	/** Get Token Endpoint	  */
	public String getTokenEndpoint();

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
