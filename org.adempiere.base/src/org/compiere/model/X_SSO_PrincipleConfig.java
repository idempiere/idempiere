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
/** Generated Model - DO NOT CHANGE */
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

/** Generated Model for SSO_PrincipleConfig
 *  @author iDempiere (generated) 
 *  @version Release 7.1 - $Id$ */
public class X_SSO_PrincipleConfig extends PO implements I_SSO_PrincipleConfig, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20221104L;

    /** Standard Constructor */
    public X_SSO_PrincipleConfig (Properties ctx, int SSO_PrincipleConfig_ID, String trxName)
    {
      super (ctx, SSO_PrincipleConfig_ID, trxName);
      /** if (SSO_PrincipleConfig_ID == 0)
        {
			setSSO_PrincipleConfig_ID (0);
			setSSO_Provider (null);
        } */
    }

    /** Load Constructor */
    public X_SSO_PrincipleConfig (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 4 - System 
      */
    protected int get_AccessLevel()
    {
      return accessLevel.intValue();
    }

    /** Load Meta Data */
    protected POInfo initPO (Properties ctx)
    {
      POInfo poi = POInfo.getPOInfo (ctx, Table_ID, get_TrxName());
      return poi;
    }

    public String toString()
    {
      StringBuffer sb = new StringBuffer ("X_SSO_PrincipleConfig[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Default.
		@param IsDefault 
		Default value
	  */
	public void setIsDefault (boolean IsDefault)
	{
		set_Value (COLUMNNAME_IsDefault, Boolean.valueOf(IsDefault));
	}

	/** Get Default.
		@return Default value
	  */
	public boolean isDefault () 
	{
		Object oo = get_Value(COLUMNNAME_IsDefault);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Name.
		@param Name 
		Alphanumeric identifier of the entity
	  */
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName () 
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** Set Application Client ID.
		@param SSO_ApplicationClientID 
		SSO Application Client ID
	  */
	public void setSSO_ApplicationClientID (String SSO_ApplicationClientID)
	{
		set_Value (COLUMNNAME_SSO_ApplicationClientID, SSO_ApplicationClientID);
	}

	/** Get Application Client ID.
		@return SSO Application Client ID
	  */
	public String getSSO_ApplicationClientID () 
	{
		return (String)get_Value(COLUMNNAME_SSO_ApplicationClientID);
	}

	/** Set Application Discovery URI.
		@param SSO_ApplicationDiscoveryURI 
		SSO Application Discovery URI
	  */
	public void setSSO_ApplicationDiscoveryURI (String SSO_ApplicationDiscoveryURI)
	{
		set_Value (COLUMNNAME_SSO_ApplicationDiscoveryURI, SSO_ApplicationDiscoveryURI);
	}

	/** Get Application Discovery URI.
		@return SSO Application Discovery URI
	  */
	public String getSSO_ApplicationDiscoveryURI () 
	{
		return (String)get_Value(COLUMNNAME_SSO_ApplicationDiscoveryURI);
	}

	/** Set Application Domain.
		@param SSO_ApplicationDomain 
		SSO Application Domain
	  */
	public void setSSO_ApplicationDomain (String SSO_ApplicationDomain)
	{
		set_Value (COLUMNNAME_SSO_ApplicationDomain, SSO_ApplicationDomain);
	}

	/** Get Application Domain.
		@return SSO Application Domain
	  */
	public String getSSO_ApplicationDomain () 
	{
		return (String)get_Value(COLUMNNAME_SSO_ApplicationDomain);
	}

	/** Set Application Logout URL.
		@param SSO_ApplicationLogoutURL 
		SSO Application Logout URL
	  */
	public void setSSO_ApplicationLogoutURL (String SSO_ApplicationLogoutURL)
	{
		set_Value (COLUMNNAME_SSO_ApplicationLogoutURL, SSO_ApplicationLogoutURL);
	}

	/** Get Application Logout URL.
		@return SSO Application Logout URL
	  */
	public String getSSO_ApplicationLogoutURL () 
	{
		return (String)get_Value(COLUMNNAME_SSO_ApplicationLogoutURL);
	}

	/** Set Application Redirect URIs.
		@param SSO_ApplicationRedirectURIs 
		SSO Application Redirect URIs
	  */
	public void setSSO_ApplicationRedirectURIs (String SSO_ApplicationRedirectURIs)
	{
		set_Value (COLUMNNAME_SSO_ApplicationRedirectURIs, SSO_ApplicationRedirectURIs);
	}

	/** Get Application Redirect URIs.
		@return SSO Application Redirect URIs
	  */
	public String getSSO_ApplicationRedirectURIs () 
	{
		return (String)get_Value(COLUMNNAME_SSO_ApplicationRedirectURIs);
	}

	/** Set Application Secret Key.
		@param SSO_ApplicationSecretKey 
		SSO Application Secret Key
	  */
	public void setSSO_ApplicationSecretKey (String SSO_ApplicationSecretKey)
	{
		set_Value (COLUMNNAME_SSO_ApplicationSecretKey, SSO_ApplicationSecretKey);
	}

	/** Get Application Secret Key.
		@return SSO Application Secret Key
	  */
	public String getSSO_ApplicationSecretKey () 
	{
		return (String)get_Value(COLUMNNAME_SSO_ApplicationSecretKey);
	}

	/** Set Tenant ID.
		@param SSO_AuthorizationTenantID 
		SSO Tenant ID
	  */
	public void setSSO_AuthorizationTenantID (String SSO_AuthorizationTenantID)
	{
		set_Value (COLUMNNAME_SSO_AuthorizationTenantID, SSO_AuthorizationTenantID);
	}

	/** Get Tenant ID.
		@return SSO Tenant ID
	  */
	public String getSSO_AuthorizationTenantID () 
	{
		return (String)get_Value(COLUMNNAME_SSO_AuthorizationTenantID);
	}

	/** Set SSO Configuration.
		@param SSO_PrincipleConfig_ID SSO Configuration	  */
	public void setSSO_PrincipleConfig_ID (int SSO_PrincipleConfig_ID)
	{
		if (SSO_PrincipleConfig_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_SSO_PrincipleConfig_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_SSO_PrincipleConfig_ID, Integer.valueOf(SSO_PrincipleConfig_ID));
	}

	/** Get SSO Configuration.
		@return SSO Configuration	  */
	public int getSSO_PrincipleConfig_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SSO_PrincipleConfig_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set SSO Configuration UU.
		@param SSO_PrincipleConfig_UU SSO Configuration UU	  */
	public void setSSO_PrincipleConfig_UU (String SSO_PrincipleConfig_UU)
	{
		set_ValueNoCheck (COLUMNNAME_SSO_PrincipleConfig_UU, SSO_PrincipleConfig_UU);
	}

	/** Get SSO Configuration UU.
		@return SSO Configuration UU	  */
	public String getSSO_PrincipleConfig_UU () 
	{
		return (String)get_Value(COLUMNNAME_SSO_PrincipleConfig_UU);
	}

	/** SSO_Provider AD_Reference_ID=200213 */
	public static final int SSO_PROVIDER_AD_Reference_ID=200213;
	/** Set SSO Provider.
		@param SSO_Provider 
		Single Sign-On (SSO) Providers ( Microsoft Azure , Google, Jump Cloud etc..)
	  */
	public void setSSO_Provider (String SSO_Provider)
	{

		set_Value (COLUMNNAME_SSO_Provider, SSO_Provider);
	}

	/** Get SSO Provider.
		@return Single Sign-On (SSO) Providers ( Microsoft Azure , Google, Jump Cloud etc..)
	  */
	public String getSSO_Provider () 
	{
		return (String)get_Value(COLUMNNAME_SSO_Provider);
	}
}