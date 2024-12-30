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

/** Generated Interface for SSO_PrincipalConfig
 *  @author iDempiere (generated) 
 *  @version Release 12
 */
public interface I_SSO_PrincipalConfig 
{

    /** TableName=SSO_PrincipalConfig */
    public static final String Table_Name = "SSO_PrincipalConfig";

    /** AD_Table_ID=200360 */
    public static final int Table_ID = 200360;

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

    /** Column name IsDefault */
    public static final String COLUMNNAME_IsDefault = "IsDefault";

	/** Set Default.
	  * Default value
	  */
	public void setIsDefault (boolean IsDefault);

	/** Get Default.
	  * Default value
	  */
	public boolean isDefault();

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

    /** Column name SSO_ApplicationClientID */
    public static final String COLUMNNAME_SSO_ApplicationClientID = "SSO_ApplicationClientID";

	/** Set Application Client ID.
	  * SSO Application Client ID
	  */
	public void setSSO_ApplicationClientID (String SSO_ApplicationClientID);

	/** Get Application Client ID.
	  * SSO Application Client ID
	  */
	public String getSSO_ApplicationClientID();

    /** Column name SSO_ApplicationDiscoveryURI */
    public static final String COLUMNNAME_SSO_ApplicationDiscoveryURI = "SSO_ApplicationDiscoveryURI";

	/** Set Application Discovery URI.
	  * SSO Application Discovery URI
	  */
	public void setSSO_ApplicationDiscoveryURI (String SSO_ApplicationDiscoveryURI);

	/** Get Application Discovery URI.
	  * SSO Application Discovery URI
	  */
	public String getSSO_ApplicationDiscoveryURI();

    /** Column name SSO_ApplicationLogoutURL */
    public static final String COLUMNNAME_SSO_ApplicationLogoutURL = "SSO_ApplicationLogoutURL";

	/** Set Application Logout URL.
	  * SSO Application Logout URL
	  */
	public void setSSO_ApplicationLogoutURL (String SSO_ApplicationLogoutURL);

	/** Get Application Logout URL.
	  * SSO Application Logout URL
	  */
	public String getSSO_ApplicationLogoutURL();

    /** Column name SSO_ApplicationRedirectURIs */
    public static final String COLUMNNAME_SSO_ApplicationRedirectURIs = "SSO_ApplicationRedirectURIs";

	/** Set Application Redirect URIs.
	  * SSO Application Redirect URIs
	  */
	public void setSSO_ApplicationRedirectURIs (String SSO_ApplicationRedirectURIs);

	/** Get Application Redirect URIs.
	  * SSO Application Redirect URIs
	  */
	public String getSSO_ApplicationRedirectURIs();

    /** Column name SSO_ApplicationSecretKey */
    public static final String COLUMNNAME_SSO_ApplicationSecretKey = "SSO_ApplicationSecretKey";

	/** Set Application Secret Key.
	  * SSO Application Secret Key
	  */
	public void setSSO_ApplicationSecretKey (String SSO_ApplicationSecretKey);

	/** Get Application Secret Key.
	  * SSO Application Secret Key
	  */
	public String getSSO_ApplicationSecretKey();

    /** Column name SSO_AuthorizationTenantID */
    public static final String COLUMNNAME_SSO_AuthorizationTenantID = "SSO_AuthorizationTenantID";

	/** Set Tenant ID.
	  * SSO Tenant ID
	  */
	public void setSSO_AuthorizationTenantID (String SSO_AuthorizationTenantID);

	/** Get Tenant ID.
	  * SSO Tenant ID
	  */
	public String getSSO_AuthorizationTenantID();

    /** Column name SSO_IDempMonitorRedirectURIs */
    public static final String COLUMNNAME_SSO_IDempMonitorRedirectURIs = "SSO_IDempMonitorRedirectURIs";

	/** Set iDempiere Monitor Redirect URIs.
	  * iDempiere Monitor Redirect URIs
	  */
	public void setSSO_IDempMonitorRedirectURIs (String SSO_IDempMonitorRedirectURIs);

	/** Get iDempiere Monitor Redirect URIs.
	  * iDempiere Monitor Redirect URIs
	  */
	public String getSSO_IDempMonitorRedirectURIs();

    /** Column name SSO_OSGIRedirectURIs */
    public static final String COLUMNNAME_SSO_OSGIRedirectURIs = "SSO_OSGIRedirectURIs";

	/** Set Felix Web Console Redirect URIs.
	  * Apache Felix Web Console Bundles Redirect URIs
	  */
	public void setSSO_OSGIRedirectURIs (String SSO_OSGIRedirectURIs);

	/** Get Felix Web Console Redirect URIs.
	  * Apache Felix Web Console Bundles Redirect URIs
	  */
	public String getSSO_OSGIRedirectURIs();

    /** Column name SSO_PrincipalConfig_ID */
    public static final String COLUMNNAME_SSO_PrincipalConfig_ID = "SSO_PrincipalConfig_ID";

	/** Set SSO Configuration	  */
	public void setSSO_PrincipalConfig_ID (int SSO_PrincipalConfig_ID);

	/** Get SSO Configuration	  */
	public int getSSO_PrincipalConfig_ID();

    /** Column name SSO_PrincipalConfig_UU */
    public static final String COLUMNNAME_SSO_PrincipalConfig_UU = "SSO_PrincipalConfig_UU";

	/** Set SSO Configuration UU	  */
	public void setSSO_PrincipalConfig_UU (String SSO_PrincipalConfig_UU);

	/** Get SSO Configuration UU	  */
	public String getSSO_PrincipalConfig_UU();

    /** Column name SSO_Provider */
    public static final String COLUMNNAME_SSO_Provider = "SSO_Provider";

	/** Set SSO Provider.
	  * Single Sign-On (SSO) Providers ( Microsoft Azure , Google, Jump Cloud etc..)
	  */
	public void setSSO_Provider (String SSO_Provider);

	/** Get SSO Provider.
	  * Single Sign-On (SSO) Providers ( Microsoft Azure , Google, Jump Cloud etc..)
	  */
	public String getSSO_Provider();

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
