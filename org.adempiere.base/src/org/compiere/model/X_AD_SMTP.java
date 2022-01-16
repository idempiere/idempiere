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

/** Generated Model for AD_SMTP
 *  @author iDempiere (generated) 
 *  @version Release 9 - $Id$ */
@org.adempiere.base.Model(table="AD_SMTP")
public class X_AD_SMTP extends PO implements I_AD_SMTP, I_Persistent 
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20220116L;

    /** Standard Constructor */
    public X_AD_SMTP (Properties ctx, int AD_SMTP_ID, String trxName)
    {
      super (ctx, AD_SMTP_ID, trxName);
      /** if (AD_SMTP_ID == 0)
        {
			setAD_SMTP_ID (0);
			setIsSecureSMTP (false);
// N
			setIsSmtpAuthorization (false);
// N
			setName (null);
        } */
    }

    /** Standard Constructor */
    public X_AD_SMTP (Properties ctx, int AD_SMTP_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_SMTP_ID, trxName, virtualColumns);
      /** if (AD_SMTP_ID == 0)
        {
			setAD_SMTP_ID (0);
			setIsSecureSMTP (false);
// N
			setIsSmtpAuthorization (false);
// N
			setName (null);
        } */
    }

    /** Load Constructor */
    public X_AD_SMTP (Properties ctx, ResultSet rs, String trxName)
    {
      super (ctx, rs, trxName);
    }

    /** AccessLevel
      * @return 7 - System - Client - Org 
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
      StringBuilder sb = new StringBuilder ("X_AD_SMTP[")
        .append(get_ID()).append(",Name=").append(getName()).append("]");
      return sb.toString();
    }

	/** Set SMTP Server.
		@param AD_SMTP_ID SMTP Server
	*/
	public void setAD_SMTP_ID (int AD_SMTP_ID)
	{
		if (AD_SMTP_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_SMTP_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_SMTP_ID, Integer.valueOf(AD_SMTP_ID));
	}

	/** Get SMTP Server.
		@return SMTP Server	  */
	public int getAD_SMTP_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_SMTP_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_SMTP_UU.
		@param AD_SMTP_UU AD_SMTP_UU
	*/
	public void setAD_SMTP_UU (String AD_SMTP_UU)
	{
		set_Value (COLUMNNAME_AD_SMTP_UU, AD_SMTP_UU);
	}

	/** Get AD_SMTP_UU.
		@return AD_SMTP_UU	  */
	public String getAD_SMTP_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_SMTP_UU);
	}

	/** Set EMail Test.
		@param EMailTest Test EMail
	*/
	public void setEMailTest (String EMailTest)
	{
		set_Value (COLUMNNAME_EMailTest, EMailTest);
	}

	/** Get EMail Test.
		@return Test EMail
	  */
	public String getEMailTest()
	{
		return (String)get_Value(COLUMNNAME_EMailTest);
	}

	/** Set SMTP SSL/TLS.
		@param IsSecureSMTP Use SSL/TLS for SMTP
	*/
	public void setIsSecureSMTP (boolean IsSecureSMTP)
	{
		set_Value (COLUMNNAME_IsSecureSMTP, Boolean.valueOf(IsSecureSMTP));
	}

	/** Get SMTP SSL/TLS.
		@return Use SSL/TLS for SMTP
	  */
	public boolean isSecureSMTP()
	{
		Object oo = get_Value(COLUMNNAME_IsSecureSMTP);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
	}

	/** Set SMTP Authentication.
		@param IsSmtpAuthorization Your mail server requires Authentication
	*/
	public void setIsSmtpAuthorization (boolean IsSmtpAuthorization)
	{
		set_Value (COLUMNNAME_IsSmtpAuthorization, Boolean.valueOf(IsSmtpAuthorization));
	}

	/** Get SMTP Authentication.
		@return Your mail server requires Authentication
	  */
	public boolean isSmtpAuthorization()
	{
		Object oo = get_Value(COLUMNNAME_IsSmtpAuthorization);
		if (oo != null) 
		{
			 if (oo instanceof Boolean) 
				 return ((Boolean)oo).booleanValue(); 
			return "Y".equals(oo);
		}
		return false;
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

	/** Set Request User.
		@param RequestUser User Name (ID) of the email owner
	*/
	public void setRequestUser (String RequestUser)
	{
		set_Value (COLUMNNAME_RequestUser, RequestUser);
	}

	/** Get Request User.
		@return User Name (ID) of the email owner
	  */
	public String getRequestUser()
	{
		return (String)get_Value(COLUMNNAME_RequestUser);
	}

	/** Set Request User Password.
		@param RequestUserPW Password of the user name (ID) for mail processing
	*/
	public void setRequestUserPW (String RequestUserPW)
	{
		set_Value (COLUMNNAME_RequestUserPW, RequestUserPW);
	}

	/** Get Request User Password.
		@return Password of the user name (ID) for mail processing
	  */
	public String getRequestUserPW()
	{
		return (String)get_Value(COLUMNNAME_RequestUserPW);
	}

	/** Set Mail Host.
		@param SMTPHost Hostname of Mail Server for SMTP and IMAP
	*/
	public void setSMTPHost (String SMTPHost)
	{
		set_Value (COLUMNNAME_SMTPHost, SMTPHost);
	}

	/** Get Mail Host.
		@return Hostname of Mail Server for SMTP and IMAP
	  */
	public String getSMTPHost()
	{
		return (String)get_Value(COLUMNNAME_SMTPHost);
	}

	/** Set SMTP Port.
		@param SMTPPort SMTP Port Number
	*/
	public void setSMTPPort (int SMTPPort)
	{
		set_Value (COLUMNNAME_SMTPPort, Integer.valueOf(SMTPPort));
	}

	/** Get SMTP Port.
		@return SMTP Port Number
	  */
	public int getSMTPPort()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_SMTPPort);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Used by email or domain.
		@param UsedByEmailOrDomain Used by email or domain
	*/
	public void setUsedByEmailOrDomain (String UsedByEmailOrDomain)
	{
		set_Value (COLUMNNAME_UsedByEmailOrDomain, UsedByEmailOrDomain);
	}

	/** Get Used by email or domain.
		@return Used by email or domain	  */
	public String getUsedByEmailOrDomain()
	{
		return (String)get_Value(COLUMNNAME_UsedByEmailOrDomain);
	}
}