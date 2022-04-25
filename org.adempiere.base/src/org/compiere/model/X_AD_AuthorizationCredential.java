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

/** Generated Model for AD_AuthorizationCredential
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_AuthorizationCredential")
public class X_AD_AuthorizationCredential extends PO implements I_AD_AuthorizationCredential, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_AuthorizationCredential (Properties ctx, int AD_AuthorizationCredential_ID, String trxName)
    {
      super (ctx, AD_AuthorizationCredential_ID, trxName);
      /** if (AD_AuthorizationCredential_ID == 0)
        {
			setAD_AuthorizationCredential_ID (0);
			setAD_AuthorizationProvider_ID (0);
			setAD_AuthorizationScopeList (null);
			setAuthorizationClientId (null);
			setAuthorizationClientSecret (null);
			setAuthorizationRedirectURL (null);
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_AuthorizationCredential (Properties ctx, int AD_AuthorizationCredential_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_AuthorizationCredential_ID, trxName, virtualColumns);
      /** if (AD_AuthorizationCredential_ID == 0)
        {
			setAD_AuthorizationCredential_ID (0);
			setAD_AuthorizationProvider_ID (0);
			setAD_AuthorizationScopeList (null);
			setAuthorizationClientId (null);
			setAuthorizationClientSecret (null);
			setAuthorizationRedirectURL (null);
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_AuthorizationCredential (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_AuthorizationCredential[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set Authorization Credential.
		@param AD_AuthorizationCredential_ID Authorization Credential
	*/
	public void setAD_AuthorizationCredential_ID (int AD_AuthorizationCredential_ID)
	{
		if (AD_AuthorizationCredential_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_AuthorizationCredential_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_AuthorizationCredential_ID, Integer.valueOf(AD_AuthorizationCredential_ID));
	}

	/** Get Authorization Credential.
		@return Authorization Credential	  */
	public int getAD_AuthorizationCredential_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_AuthorizationCredential_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_AuthorizationCredential_UU.
		@param AD_AuthorizationCredential_UU AD_AuthorizationCredential_UU
	*/
	public void setAD_AuthorizationCredential_UU (String AD_AuthorizationCredential_UU)
	{
		set_Value (COLUMNNAME_AD_AuthorizationCredential_UU, AD_AuthorizationCredential_UU);
	}

	/** Get AD_AuthorizationCredential_UU.
		@return AD_AuthorizationCredential_UU	  */
	public String getAD_AuthorizationCredential_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_AuthorizationCredential_UU);
	}

	public org.compiere.model.I_AD_AuthorizationProvider getAD_AuthorizationProvider() throws RuntimeException
	{
		return (org.compiere.model.I_AD_AuthorizationProvider)MTable.get(getCtx(), org.compiere.model.I_AD_AuthorizationProvider.Table_ID)
			.getPO(getAD_AuthorizationProvider_ID(), get_TrxName());
	}

	/** Set Authorization Provider.
		@param AD_AuthorizationProvider_ID Authorization Provider
	*/
	public void setAD_AuthorizationProvider_ID (int AD_AuthorizationProvider_ID)
	{
		if (AD_AuthorizationProvider_ID < 1)
			set_Value (COLUMNNAME_AD_AuthorizationProvider_ID, null);
		else
			set_Value (COLUMNNAME_AD_AuthorizationProvider_ID, Integer.valueOf(AD_AuthorizationProvider_ID));
	}

	/** Get Authorization Provider.
		@return Authorization Provider	  */
	public int getAD_AuthorizationProvider_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_AuthorizationProvider_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** AD_AuthorizationScopeList AD_Reference_ID=200185 */
	public static final int AD_AUTHORIZATIONSCOPELIST_AD_Reference_ID=200185;
	/** Calendar = Calendar */
	public static final String AD_AUTHORIZATIONSCOPELIST_Calendar = "Calendar";
	/** Document = Document */
	public static final String AD_AUTHORIZATIONSCOPELIST_Document = "Document";
	/** EMail = EMail */
	public static final String AD_AUTHORIZATIONSCOPELIST_EMail = "EMail";
	/** Profile = Profile */
	public static final String AD_AUTHORIZATIONSCOPELIST_Profile = "Profile";
	/** Storage = Storage */
	public static final String AD_AUTHORIZATIONSCOPELIST_Storage = "Storage";
	/** Set Scope List.
		@param AD_AuthorizationScopeList Scope List
	*/
	public void setAD_AuthorizationScopeList (String AD_AuthorizationScopeList)
	{

		set_Value (COLUMNNAME_AD_AuthorizationScopeList, AD_AuthorizationScopeList);
	}

	/** Get Scope List.
		@return Scope List	  */
	public String getAD_AuthorizationScopeList()
	{
		return (String)get_Value(COLUMNNAME_AD_AuthorizationScopeList);
	}

	/** Set Authorization client-id.
		@param AuthorizationClientId Authorization client-id
	*/
	public void setAuthorizationClientId (String AuthorizationClientId)
	{
		set_Value (COLUMNNAME_AuthorizationClientId, AuthorizationClientId);
	}

	/** Get Authorization client-id.
		@return Authorization client-id	  */
	public String getAuthorizationClientId()
	{
		return (String)get_Value(COLUMNNAME_AuthorizationClientId);
	}

	/** Set Authorization client-secret.
		@param AuthorizationClientSecret Authorization client-secret
	*/
	public void setAuthorizationClientSecret (String AuthorizationClientSecret)
	{
		set_Value (COLUMNNAME_AuthorizationClientSecret, AuthorizationClientSecret);
	}

	/** Get Authorization client-secret.
		@return Authorization client-secret	  */
	public String getAuthorizationClientSecret()
	{
		return (String)get_Value(COLUMNNAME_AuthorizationClientSecret);
	}

	/** Set Authorization Redirect URL.
		@param AuthorizationRedirectURL Authorization Redirect URL
	*/
	public void setAuthorizationRedirectURL (String AuthorizationRedirectURL)
	{
		set_Value (COLUMNNAME_AuthorizationRedirectURL, AuthorizationRedirectURL);
	}

	/** Get Authorization Redirect URL.
		@return Authorization Redirect URL	  */
	public String getAuthorizationRedirectURL()
	{
		return (String)get_Value(COLUMNNAME_AuthorizationRedirectURL);
	}

	/** Set Comment/Help.
		@param Help Comment or Hint
	*/
	public void setHelp (String Help)
	{
		set_Value (COLUMNNAME_Help, Help);
	}

	/** Get Comment/Help.
		@return Comment or Hint
	  */
	public String getHelp()
	{
		return (String)get_Value(COLUMNNAME_Help);
	}

	/** Set Name.
		@param Name Alphanumeric identifier of the entity
	*/
	public void setName (String Name)
	{
		set_Value (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName()
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
}