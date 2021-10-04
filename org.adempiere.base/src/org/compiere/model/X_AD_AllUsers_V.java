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
import java.sql.Timestamp;
import java.util.Properties;

/** Generated Model for AD_AllUsers_V
 *  @author iDempiere (generated) 
 *  @version Development 9.0 - $Id$ */
@org.adempiere.base.Model(table="AD_AllUsers_V")
public class X_AD_AllUsers_V extends PO implements I_AD_AllUsers_V, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20210917L;

    /** Standard Constructor */
    public X_AD_AllUsers_V (Properties ctx, int AD_AllUsers_V_ID, String trxName)
    {
      super (ctx, AD_AllUsers_V_ID, trxName);
      /** if (AD_AllUsers_V_ID == 0)
        {
        } */
    }

    /** Load Constructor */
    public X_AD_AllUsers_V (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_AllUsers_V[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	public org.compiere.model.I_AD_AllClients_V getAD_AllClients_V() throws RuntimeException
	{
		return (org.compiere.model.I_AD_AllClients_V)MTable.get(getCtx(), org.compiere.model.I_AD_AllClients_V.Table_ID)
			.getPO(getAD_AllClients_V_ID(), get_TrxName());
	}

	/** Set Client (All).
		@param AD_AllClients_V_ID Client (All)	  */
	public void setAD_AllClients_V_ID (int AD_AllClients_V_ID)
	{
		if (AD_AllClients_V_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_AllClients_V_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_AllClients_V_ID, Integer.valueOf(AD_AllClients_V_ID));
	}

	/** Get Client (All).
		@return Client (All)	  */
	public int getAD_AllClients_V_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_AllClients_V_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set User (All).
		@param AD_AllUsers_V_ID User (All)	  */
	public void setAD_AllUsers_V_ID (int AD_AllUsers_V_ID)
	{
		if (AD_AllUsers_V_ID < 1) 
			set_ValueNoCheck (COLUMNNAME_AD_AllUsers_V_ID, null);
		else 
			set_ValueNoCheck (COLUMNNAME_AD_AllUsers_V_ID, Integer.valueOf(AD_AllUsers_V_ID));
	}

	/** Get User (All).
		@return User (All)	  */
	public int getAD_AllUsers_V_ID () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_AllUsers_V_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_AllUsers_V_UU.
		@param AD_AllUsers_V_UU AD_AllUsers_V_UU	  */
	public void setAD_AllUsers_V_UU (String AD_AllUsers_V_UU)
	{
		set_ValueNoCheck (COLUMNNAME_AD_AllUsers_V_UU, AD_AllUsers_V_UU);
	}

	/** Get AD_AllUsers_V_UU.
		@return AD_AllUsers_V_UU	  */
	public String getAD_AllUsers_V_UU () 
	{
		return (String)get_Value(COLUMNNAME_AD_AllUsers_V_UU);
	}

	/** Set Date Account Locked.
		@param DateAccountLocked Date Account Locked	  */
	public void setDateAccountLocked (Timestamp DateAccountLocked)
	{
		set_Value (COLUMNNAME_DateAccountLocked, DateAccountLocked);
	}

	/** Get Date Account Locked.
		@return Date Account Locked	  */
	public Timestamp getDateAccountLocked () 
	{
		return (Timestamp)get_Value(COLUMNNAME_DateAccountLocked);
	}

	/** Set Date Last Login.
		@param DateLastLogin Date Last Login	  */
	public void setDateLastLogin (Timestamp DateLastLogin)
	{
		set_ValueNoCheck (COLUMNNAME_DateLastLogin, DateLastLogin);
	}

	/** Get Date Last Login.
		@return Date Last Login	  */
	public Timestamp getDateLastLogin () 
	{
		return (Timestamp)get_Value(COLUMNNAME_DateLastLogin);
	}

	/** Set Date Password Changed.
		@param DatePasswordChanged Date Password Changed	  */
	public void setDatePasswordChanged (Timestamp DatePasswordChanged)
	{
		set_ValueNoCheck (COLUMNNAME_DatePasswordChanged, DatePasswordChanged);
	}

	/** Get Date Password Changed.
		@return Date Password Changed	  */
	public Timestamp getDatePasswordChanged () 
	{
		return (Timestamp)get_Value(COLUMNNAME_DatePasswordChanged);
	}

	/** Set Description.
		@param Description 
		Optional short description of the record
	  */
	public void setDescription (String Description)
	{
		set_ValueNoCheck (COLUMNNAME_Description, Description);
	}

	/** Get Description.
		@return Optional short description of the record
	  */
	public String getDescription () 
	{
		return (String)get_Value(COLUMNNAME_Description);
	}

	/** Set EMail Address.
		@param EMail 
		Electronic Mail Address
	  */
	public void setEMail (String EMail)
	{
		set_ValueNoCheck (COLUMNNAME_EMail, EMail);
	}

	/** Get EMail Address.
		@return Electronic Mail Address
	  */
	public String getEMail () 
	{
		return (String)get_Value(COLUMNNAME_EMail);
	}

	/** Set Failed Login Count.
		@param FailedLoginCount Failed Login Count	  */
	public void setFailedLoginCount (int FailedLoginCount)
	{
		set_ValueNoCheck (COLUMNNAME_FailedLoginCount, Integer.valueOf(FailedLoginCount));
	}

	/** Get Failed Login Count.
		@return Failed Login Count	  */
	public int getFailedLoginCount () 
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_FailedLoginCount);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Expired.
		@param IsExpired Expired	  */
	public void setIsExpired (boolean IsExpired)
	{
		set_ValueNoCheck (COLUMNNAME_IsExpired, Boolean.valueOf(IsExpired));
	}

	/** Get Expired.
		@return Expired	  */
	public boolean isExpired () 
	{
		Object oo = get_Value(COLUMNNAME_IsExpired);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Locked.
		@param IsLocked Locked	  */
	public void setIsLocked (boolean IsLocked)
	{
		set_ValueNoCheck (COLUMNNAME_IsLocked, Boolean.valueOf(IsLocked));
	}

	/** Get Locked.
		@return Locked	  */
	public boolean isLocked () 
	{
		Object oo = get_Value(COLUMNNAME_IsLocked);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set No Expire.
		@param IsNoExpire No Expire	  */
	public void setIsNoExpire (boolean IsNoExpire)
	{
		set_Value (COLUMNNAME_IsNoExpire, Boolean.valueOf(IsNoExpire));
	}

	/** Get No Expire.
		@return No Expire	  */
	public boolean isNoExpire () 
	{
		Object oo = get_Value(COLUMNNAME_IsNoExpire);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set No Password Reset.
		@param IsNoPasswordReset No Password Reset	  */
	public void setIsNoPasswordReset (boolean IsNoPasswordReset)
	{
		set_ValueNoCheck (COLUMNNAME_IsNoPasswordReset, Boolean.valueOf(IsNoPasswordReset));
	}

	/** Get No Password Reset.
		@return No Password Reset	  */
	public boolean isNoPasswordReset () 
	{
		Object oo = get_Value(COLUMNNAME_IsNoPasswordReset);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set Support User.
		@param IsSupportUser Support User	  */
	public void setIsSupportUser (boolean IsSupportUser)
	{
		set_Value (COLUMNNAME_IsSupportUser, Boolean.valueOf(IsSupportUser));
	}

	/** Get Support User.
		@return Support User	  */
	public boolean isSupportUser () 
	{
		Object oo = get_Value(COLUMNNAME_IsSupportUser);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set LDAP User Name.
		@param LDAPUser 
		User Name used for authorization via LDAP (directory) services
	  */
	public void setLDAPUser (String LDAPUser)
	{
		set_ValueNoCheck (COLUMNNAME_LDAPUser, LDAPUser);
	}

	/** Get LDAP User Name.
		@return User Name used for authorization via LDAP (directory) services
	  */
	public String getLDAPUser () 
	{
		return (String)get_Value(COLUMNNAME_LDAPUser);
	}

	/** Set Name.
		@param Name 
		Alphanumeric identifier of the entity
	  */
	public void setName (String Name)
	{
		set_ValueNoCheck (COLUMNNAME_Name, Name);
	}

	/** Get Name.
		@return Alphanumeric identifier of the entity
	  */
	public String getName () 
	{
		return (String)get_Value(COLUMNNAME_Name);
	}

	/** Set Password.
		@param Password 
		Password of any length (case sensitive)
	  */
	public void setPassword (String Password)
	{
		set_ValueNoCheck (COLUMNNAME_Password, Password);
	}

	/** Get Password.
		@return Password of any length (case sensitive)
	  */
	public String getPassword () 
	{
		return (String)get_Value(COLUMNNAME_Password);
	}

	/** Set Salt.
		@param Salt 
		Random data added to improve password hash effectiveness
	  */
	public void setSalt (String Salt)
	{
		set_ValueNoCheck (COLUMNNAME_Salt, Salt);
	}

	/** Get Salt.
		@return Random data added to improve password hash effectiveness
	  */
	public String getSalt () 
	{
		return (String)get_Value(COLUMNNAME_Salt);
	}

	/** Set User PIN.
		@param UserPIN User PIN	  */
	public void setUserPIN (String UserPIN)
	{
		set_ValueNoCheck (COLUMNNAME_UserPIN, UserPIN);
	}

	/** Get User PIN.
		@return User PIN	  */
	public String getUserPIN () 
	{
		return (String)get_Value(COLUMNNAME_UserPIN);
	}

	/** Set Search Key.
		@param Value 
		Search key for the record in the format required - must be unique
	  */
	public void setValue (String Value)
	{
		set_ValueNoCheck (COLUMNNAME_Value, Value);
	}

	/** Get Search Key.
		@return Search key for the record in the format required - must be unique
	  */
	public String getValue () 
	{
		return (String)get_Value(COLUMNNAME_Value);
	}
}