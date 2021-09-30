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
import org.compiere.util.KeyNamePair;

/** Generated Model for AD_AuthorizationProvider
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="AD_AuthorizationProvider")
public class X_AD_AuthorizationProvider extends PO implements I_AD_AuthorizationProvider, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_AD_AuthorizationProvider (Properties ctx, int AD_AuthorizationProvider_ID, String trxName)
    {
      super (ctx, AD_AuthorizationProvider_ID, trxName);
      /** if (AD_AuthorizationProvider_ID == 0)
        {
			setAD_AuthorizationProvider_ID (0);
			setAD_AuthorizationType (null);
			setAuthorizationEndpoint (null);
			setName (null);
			setTokenEndpoint (null);
        } */
    }

    /** Load Constructor */
    public X_AD_AuthorizationProvider (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 6 - System - Client 
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
      StringBuilder sb = new StringBuilder ("X_AD_AuthorizationProvider[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Authorization Provider.
		@param AD_AuthorizationProvider_ID Authorization Provider	  */
	public void setAD_AuthorizationProvider_ID (int AD_AuthorizationProvider_ID)
	{
		if (AD_AuthorizationProvider_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_AuthorizationProvider_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_AuthorizationProvider_ID, Integer.valueOf(AD_AuthorizationProvider_ID));
	}

	/** Get Authorization Provider.
		@return Authorization Provider	  */
	public int getAD_AuthorizationProvider_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_AuthorizationProvider_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_AuthorizationProvider_UU.
		@param AD_AuthorizationProvider_UU AD_AuthorizationProvider_UU	  */
	public void setAD_AuthorizationProvider_UU (String AD_AuthorizationProvider_UU)
	{
		set_Value (COLUMNNAME_AD_AuthorizationProvider_UU, AD_AuthorizationProvider_UU);
	}

	/** Get AD_AuthorizationProvider_UU.
		@return AD_AuthorizationProvider_UU	  */
	public String getAD_AuthorizationProvider_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_AuthorizationProvider_UU);
	}

	/** AD_AuthorizationType AD_Reference_ID=200184 */
	public static final int AD_AUTHORIZATIONTYPE_AD_Reference_ID=200184;
	/** OAuth2 = OAuth2 */
	public static final String AD_AUTHORIZATIONTYPE_OAuth2 = "OAuth2";
	/** SAML (not implemented yet) = SAML */
	public static final String AD_AUTHORIZATIONTYPE_SAMLNotImplementedYet = "SAML";
	/** Set Authorization Type.
		@param AD_AuthorizationType Authorization Type	  */
	public void setAD_AuthorizationType (String AD_AuthorizationType)
	{

		set_Value (COLUMNNAME_AD_AuthorizationType, AD_AuthorizationType);
	}

	/** Get Authorization Type.
		@return Authorization Type	  */
	public String getAD_AuthorizationType () 
	{
		return (String)get_Value(COLUMNNAME_AD_AuthorizationType);
	}

	/** Set Authorization Endpoint.
		@param AuthorizationEndpoint Authorization Endpoint	  */
	public void setAuthorizationEndpoint (String AuthorizationEndpoint)
	{
		set_Value (COLUMNNAME_AuthorizationEndpoint, AuthorizationEndpoint);
	}

	/** Get Authorization Endpoint.
		@return Authorization Endpoint	  */
	public String getAuthorizationEndpoint () 
	{
		return (String)get_Value(COLUMNNAME_AuthorizationEndpoint);
	}

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_Value (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set Comment/Help.
		@param Help 
		Comment or Hint
	  */
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp () 
	{
		return (String)get_Value(COLUMNNAME_Help);
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

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair() 
    {
        return new KeyNamePair(get_ID(), getName());
    }

	/** Set Revoke Endpoint.
		@param RevokeEndpoint Revoke Endpoint	  */
	public void setRevokeEndpoint (String RevokeEndpoint)
	{
		set_Value (COLUMNNAME_RevokeEndpoint, RevokeEndpoint);
	}

	/** Get Revoke Endpoint.
		@return Revoke Endpoint	  */
	public String getRevokeEndpoint () 
	{
		return (String)get_Value(COLUMNNAME_RevokeEndpoint);
	}

	/** Set Token Endpoint.
		@param TokenEndpoint Token Endpoint	  */
	public void setTokenEndpoint (String TokenEndpoint)
	{
		set_Value (COLUMNNAME_TokenEndpoint, TokenEndpoint);
	}

	/** Get Token Endpoint.
		@return Token Endpoint	  */
	public String getTokenEndpoint () 
	{
		return (String)get_Value(COLUMNNAME_TokenEndpoint);
	}
}