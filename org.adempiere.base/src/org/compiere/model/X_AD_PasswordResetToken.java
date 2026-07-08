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

/** Generated Model for AD_PasswordResetToken
 *  @author iDempiere (generated)
 *  @version Release 14 - $Id$ */
@org.adempiere.base.Model(table="AD_PasswordResetToken")
public class X_AD_PasswordResetToken extends PO implements I_AD_PasswordResetToken, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20260708L;

    /** Standard Constructor */
    public X_AD_PasswordResetToken (Properties ctx, int AD_PasswordResetToken_ID, String trxName)
    {
      super (ctx, AD_PasswordResetToken_ID, trxName);
      /** if (AD_PasswordResetToken_ID == 0)
        {
			setAD_PasswordResetToken_ID (0);
			setAttemptsUsed (0);
// 0
			setEMail (null);
			setExpiration (new Timestamp( System.currentTimeMillis() ));
			setOneTimeCode (null);
			setTokenStatus (null);
// P
        } */
    }

    /** Standard Constructor */
    public X_AD_PasswordResetToken (Properties ctx, int AD_PasswordResetToken_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_PasswordResetToken_ID, trxName, virtualColumns);
      /** if (AD_PasswordResetToken_ID == 0)
        {
			setAD_PasswordResetToken_ID (0);
			setAttemptsUsed (0);
// 0
			setEMail (null);
			setExpiration (new Timestamp( System.currentTimeMillis() ));
			setOneTimeCode (null);
			setTokenStatus (null);
// P
        } */
    }

    /** Standard Constructor */
    public X_AD_PasswordResetToken (Properties ctx, String AD_PasswordResetToken_UU, String trxName)
    {
      super (ctx, AD_PasswordResetToken_UU, trxName);
      /** if (AD_PasswordResetToken_UU == null)
        {
			setAD_PasswordResetToken_ID (0);
			setAttemptsUsed (0);
// 0
			setEMail (null);
			setExpiration (new Timestamp( System.currentTimeMillis() ));
			setOneTimeCode (null);
			setTokenStatus (null);
// P
        } */
    }

    /** Standard Constructor */
    public X_AD_PasswordResetToken (Properties ctx, String AD_PasswordResetToken_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_PasswordResetToken_UU, trxName, virtualColumns);
      /** if (AD_PasswordResetToken_UU == null)
        {
			setAD_PasswordResetToken_ID (0);
			setAttemptsUsed (0);
// 0
			setEMail (null);
			setExpiration (new Timestamp( System.currentTimeMillis() ));
			setOneTimeCode (null);
			setTokenStatus (null);
// P
        } */
    }

    /** Load Constructor */
    public X_AD_PasswordResetToken (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_PasswordResetToken[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set Password Reset Token.
		@param AD_PasswordResetToken_ID Password Reset Token
	*/
	public void setAD_PasswordResetToken_ID (int AD_PasswordResetToken_ID)
	{
		if (AD_PasswordResetToken_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_PasswordResetToken_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_PasswordResetToken_ID, Integer.valueOf(AD_PasswordResetToken_ID));
	}

	/** Get Password Reset Token.
		@return Password Reset Token	  */
	public int getAD_PasswordResetToken_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_PasswordResetToken_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_PasswordResetToken_UU.
		@param AD_PasswordResetToken_UU AD_PasswordResetToken_UU
	*/
	public void setAD_PasswordResetToken_UU (String AD_PasswordResetToken_UU)
	{
		set_Value (COLUMNNAME_AD_PasswordResetToken_UU, AD_PasswordResetToken_UU);
	}

	/** Get AD_PasswordResetToken_UU.
		@return AD_PasswordResetToken_UU	  */
	public String getAD_PasswordResetToken_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_PasswordResetToken_UU);
	}

	/** Set Attempts Used.
		@param AttemptsUsed Attempts Used
	*/
	public void setAttemptsUsed (int AttemptsUsed)
	{
		set_Value (COLUMNNAME_AttemptsUsed, Integer.valueOf(AttemptsUsed));
	}

	/** Get Attempts Used.
		@return Attempts Used	  */
	public int getAttemptsUsed()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AttemptsUsed);
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

	/** Set Expire On.
		@param Expiration Expire On
	*/
	public void setExpiration (Timestamp Expiration)
	{
		set_Value (COLUMNNAME_Expiration, Expiration);
	}

	/** Get Expire On.
		@return Expire On
	  */
	public Timestamp getExpiration()
	{
		return (Timestamp)get_Value(COLUMNNAME_Expiration);
	}

	/** Set One Time Code.
		@param OneTimeCode One Time Code
	*/
	public void setOneTimeCode (String OneTimeCode)
	{
		set_ValueE (COLUMNNAME_OneTimeCode, OneTimeCode);
	}

	/** Get One Time Code.
		@return One Time Code	  */
	public String getOneTimeCode()
	{
		return (String)get_ValueE(COLUMNNAME_OneTimeCode);
	}

	/** TokenStatus AD_Reference_ID=200288 */
	public static final int TOKENSTATUS_AD_Reference_ID=200288;
	/** Completed = C */
	public static final String TOKENSTATUS_Completed = "C";
	/** Cancelled = N */
	public static final String TOKENSTATUS_Cancelled = "N";
	/** Pending = P */
	public static final String TOKENSTATUS_Pending = "P";
	/** Verified = V */
	public static final String TOKENSTATUS_Verified = "V";
	/** Expired = X */
	public static final String TOKENSTATUS_Expired = "X";
	/** Set Token Status.
		@param TokenStatus Token Status
	*/
	public void setTokenStatus (String TokenStatus)
	{

		set_Value (COLUMNNAME_TokenStatus, TokenStatus);
	}

	/** Get Token Status.
		@return Token Status	  */
	public String getTokenStatus()
	{
		return (String)get_Value(COLUMNNAME_TokenStatus);
	}

	/** Set Verified Token Expires.
		@param VerifiedTokenExpires Deadline to submit the new password after verifying
	*/
	public void setVerifiedTokenExpires (Timestamp VerifiedTokenExpires)
	{
		set_Value (COLUMNNAME_VerifiedTokenExpires, VerifiedTokenExpires);
	}

	/** Get Verified Token Expires.
		@return Deadline to submit the new password after verifying
	  */
	public Timestamp getVerifiedTokenExpires()
	{
		return (Timestamp)get_Value(COLUMNNAME_VerifiedTokenExpires);
	}

	/** Set Verified Token Hash.
		@param VerifiedTokenHash Verified Token Hash
	*/
	public void setVerifiedTokenHash (String VerifiedTokenHash)
	{
		set_Value (COLUMNNAME_VerifiedTokenHash, VerifiedTokenHash);
	}

	/** Get Verified Token Hash.
		@return Verified Token Hash	  */
	public String getVerifiedTokenHash()
	{
		return (String)get_Value(COLUMNNAME_VerifiedTokenHash);
	}
}