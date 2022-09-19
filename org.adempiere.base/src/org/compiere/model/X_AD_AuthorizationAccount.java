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

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;
import org.compiere.util.Env;

/** Generated Model for AD_AuthorizationAccount
 *  @author iDempiere (generated) 
 *  @version Release 10 - $Id$ */
@org.adempiere.base.Model(table="AD_AuthorizationAccount")
public class X_AD_AuthorizationAccount extends PO implements I_AD_AuthorizationAccount, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220906L;

    /** Standard Constructor */
    public X_AD_AuthorizationAccount (Properties ctx, int AD_AuthorizationAccount_ID, String trxName)
    {
      super (ctx, AD_AuthorizationAccount_ID, trxName);
      /** if (AD_AuthorizationAccount_ID == 0)
        {
			setAD_AuthorizationAccount_ID (0);
			setIsAccessRevoked (false);
// N
			setIsAuthorized (false);
// N
        } */
    }

    /** Standard Constructor */
    public X_AD_AuthorizationAccount (Properties ctx, int AD_AuthorizationAccount_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_AuthorizationAccount_ID, trxName, virtualColumns);
      /** if (AD_AuthorizationAccount_ID == 0)
        {
			setAD_AuthorizationAccount_ID (0);
			setIsAccessRevoked (false);
// N
			setIsAuthorized (false);
// N
        } */
    }

    /** Load Constructor */
    public X_AD_AuthorizationAccount (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_AuthorizationAccount[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Access Token.
		@param AccessToken Access Token
	*/
	public void setAccessToken (String AccessToken)
	{
		set_Value (COLUMNNAME_AccessToken, AccessToken);
	}

	/** Get Access Token.
		@return Access Token	  */
	public String getAccessToken()
	{
		return (String)get_Value(COLUMNNAME_AccessToken);
	}

	/** Set Access Token Timestamp.
		@param AccessTokenTimestamp Access Token Timestamp
	*/
	public void setAccessTokenTimestamp (Timestamp AccessTokenTimestamp)
	{
		set_Value (COLUMNNAME_AccessTokenTimestamp, AccessTokenTimestamp);
	}

	/** Get Access Token Timestamp.
		@return Access Token Timestamp	  */
	public Timestamp getAccessTokenTimestamp()
	{
		return (Timestamp)get_Value(COLUMNNAME_AccessTokenTimestamp);
	}

	/** Set Authorization Account.
		@param AD_AuthorizationAccount_ID Authorization Account
	*/
	public void setAD_AuthorizationAccount_ID (int AD_AuthorizationAccount_ID)
	{
		if (AD_AuthorizationAccount_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_AuthorizationAccount_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_AuthorizationAccount_ID, Integer.valueOf(AD_AuthorizationAccount_ID));
	}

	/** Get Authorization Account.
		@return Authorization Account	  */
	public int getAD_AuthorizationAccount_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_AuthorizationAccount_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_AuthorizationAccount_UU.
		@param AD_AuthorizationAccount_UU AD_AuthorizationAccount_UU
	*/
	public void setAD_AuthorizationAccount_UU (String AD_AuthorizationAccount_UU)
	{
		set_Value (COLUMNNAME_AD_AuthorizationAccount_UU, AD_AuthorizationAccount_UU);
	}

	/** Get AD_AuthorizationAccount_UU.
		@return AD_AuthorizationAccount_UU	  */
	public String getAD_AuthorizationAccount_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_AuthorizationAccount_UU);
	}

	public org.compiere.model.I_AD_AuthorizationCredential getAD_AuthorizationCredential() throws RuntimeException
	{
		return (org.compiere.model.I_AD_AuthorizationCredential)MTable.get(getCtx(), org.compiere.model.I_AD_AuthorizationCredential.Table_ID)
			.getPO(getAD_AuthorizationCredential_ID(), get_TrxName());
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

	/** AD_AuthorizationScopes AD_Reference_ID=200185 */
	public static final int AD_AUTHORIZATIONSCOPES_AD_Reference_ID=200185;
	/** Calendar = Calendar */
	public static final String AD_AUTHORIZATIONSCOPES_Calendar = "Calendar";
	/** Document = Document */
	public static final String AD_AUTHORIZATIONSCOPES_Document = "Document";
	/** EMail = EMail */
	public static final String AD_AUTHORIZATIONSCOPES_EMail = "EMail";
	/** Profile = Profile */
	public static final String AD_AUTHORIZATIONSCOPES_Profile = "Profile";
	/** Storage = Storage */
	public static final String AD_AUTHORIZATIONSCOPES_Storage = "Storage";
	/** Set Authorization Scopes.
		@param AD_AuthorizationScopes Authorization Scopes
	*/
	public void setAD_AuthorizationScopes (String AD_AuthorizationScopes)
	{

		set_Value (COLUMNNAME_AD_AuthorizationScopes, AD_AuthorizationScopes);
	}

	/** Get Authorization Scopes.
		@return Authorization Scopes	  */
	public String getAD_AuthorizationScopes()
	{
		return (String)get_Value(COLUMNNAME_AD_AuthorizationScopes);
	}

	public org.compiere.model.I_AD_User getAD_User() throws RuntimeException
	{
		return (org.compiere.model.I_AD_User)MTable.get(getCtx(), org.compiere.model.I_AD_User.Table_ID)
			.getPO(getAD_User_ID(), get_TrxName());
	}

	/** Set User/Contact.
		@param AD_User_ID User within the system - Internal or Business Partner Contact
	*/
	public void setAD_User_ID (int AD_User_ID)
	{
		if (AD_User_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_User_ID, Integer.valueOf(AD_User_ID));
	}

	/** Get User/Contact.
		@return User within the system - Internal or Business Partner Contact
	  */
	public int getAD_User_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_User_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set EMail Address.
		@param EMail Electronic Mail Address
	*/
	public void setEMail (String EMail)
	{
		set_Value (COLUMNNAME_EMail, EMail);
	}

	/** Get EMail Address.
		@return Electronic Mail Address
	  */
	public String getEMail()
	{
		return (String)get_Value(COLUMNNAME_EMail);
	}

	/** Set Expire in Seconds.
		@param ExpireInSeconds Expire in Seconds
	*/
	public void setExpireInSeconds (BigDecimal ExpireInSeconds)
	{
		set_Value (COLUMNNAME_ExpireInSeconds, ExpireInSeconds);
	}

	/** Get Expire in Seconds.
		@return Expire in Seconds	  */
	public BigDecimal getExpireInSeconds()
	{
		BigDecimal bd = (BigDecimal)get_Value(COLUMNNAME_ExpireInSeconds);
		if (bd == null)
			 return Env.ZERO;
		return bd;
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

	/** Set Access Revoked.
		@param IsAccessRevoked Access Revoked
	*/
	public void setIsAccessRevoked (boolean IsAccessRevoked)
	{
		set_Value (COLUMNNAME_IsAccessRevoked, Boolean.valueOf(IsAccessRevoked));
	}

	/** Get Access Revoked.
		@return Access Revoked	  */
	public boolean isAccessRevoked()
	{
		Object oo = get_Value(COLUMNNAME_IsAccessRevoked);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Authorized.
		@param IsAuthorized Authorized
	*/
	public void setIsAuthorized (boolean IsAuthorized)
	{
		set_Value (COLUMNNAME_IsAuthorized, Boolean.valueOf(IsAuthorized));
	}

	/** Get Authorized.
		@return Authorized	  */
	public boolean isAuthorized()
	{
		Object oo = get_Value(COLUMNNAME_IsAuthorized);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Preferred User Name.
		@param Preferred_UserName Preferred User Name
	*/
	public void setPreferred_UserName (String Preferred_UserName)
	{
		set_Value (COLUMNNAME_Preferred_UserName, Preferred_UserName);
	}

	/** Get Preferred User Name.
		@return Preferred User Name	  */
	public String getPreferred_UserName()
	{
		return (String)get_Value(COLUMNNAME_Preferred_UserName);
	}

	/** Set Refresh Token.
		@param RefreshToken Refresh Token
	*/
	public void setRefreshToken (String RefreshToken)
	{
		set_Value (COLUMNNAME_RefreshToken, RefreshToken);
	}

	/** Get Refresh Token.
		@return Refresh Token	  */
	public String getRefreshToken()
	{
		return (String)get_Value(COLUMNNAME_RefreshToken);
	}
}