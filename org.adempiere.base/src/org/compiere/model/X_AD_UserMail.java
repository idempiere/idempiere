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

/** Generated Model for AD_UserMail
 *  @author iDempiere (generated)
 *  @version Release 12 - $Id$ */
@org.adempiere.base.Model(table="AD_UserMail")
public class X_AD_UserMail extends PO implements I_AD_UserMail, I_Persistent
{

	/**
	 *
	 */
	private static final long serialVersionUID = 20241222L;

    /** Standard Constructor */
    public X_AD_UserMail (Properties ctx, int AD_UserMail_ID, String trxName)
    {
      super (ctx, AD_UserMail_ID, trxName);
      /** if (AD_UserMail_ID == 0)
        {
			setAD_UserMail_ID (0);
			setAD_User_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_UserMail (Properties ctx, int AD_UserMail_ID, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_UserMail_ID, trxName, virtualColumns);
      /** if (AD_UserMail_ID == 0)
        {
			setAD_UserMail_ID (0);
			setAD_User_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_UserMail (Properties ctx, String AD_UserMail_UU, String trxName)
    {
      super (ctx, AD_UserMail_UU, trxName);
      /** if (AD_UserMail_UU == null)
        {
			setAD_UserMail_ID (0);
			setAD_User_ID (0);
        } */
    }

    /** Standard Constructor */
    public X_AD_UserMail (Properties ctx, String AD_UserMail_UU, String trxName, String ... virtualColumns)
    {
      super (ctx, AD_UserMail_UU, trxName, virtualColumns);
      /** if (AD_UserMail_UU == null)
        {
			setAD_UserMail_ID (0);
			setAD_User_ID (0);
        } */
    }

    /** Load Constructor */
    public X_AD_UserMail (Properties ctx, ResultSet rs, String trxName)
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
      StringBuilder sb = new StringBuilder ("X_AD_UserMail[")
        .append(get_ID()).append("]");
      return sb.toString();
    }

	/** Set User Mail.
		@param AD_UserMail_ID Mail sent to the user
	*/
	public void setAD_UserMail_ID (int AD_UserMail_ID)
	{
		if (AD_UserMail_ID < 1)
			set_ValueNoCheck (COLUMNNAME_AD_UserMail_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_AD_UserMail_ID, Integer.valueOf(AD_UserMail_ID));
	}

	/** Get User Mail.
		@return Mail sent to the user
	  */
	public int getAD_UserMail_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_AD_UserMail_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set AD_UserMail_UU.
		@param AD_UserMail_UU AD_UserMail_UU
	*/
	public void setAD_UserMail_UU (String AD_UserMail_UU)
	{
		set_Value (COLUMNNAME_AD_UserMail_UU, AD_UserMail_UU);
	}

	/** Get AD_UserMail_UU.
		@return AD_UserMail_UU	  */
	public String getAD_UserMail_UU()
	{
		return (String)get_Value(COLUMNNAME_AD_UserMail_UU);
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

    /** Get Record ID/ColumnName
        @return ID/ColumnName pair
      */
    public KeyNamePair getKeyNamePair()
    {
        return new KeyNamePair(get_ID(), String.valueOf(getAD_User_ID()));
    }

	/** Set Delivery Confirmation.
		@param DeliveryConfirmation EMail Delivery confirmation
	*/
	public void setDeliveryConfirmation (String DeliveryConfirmation)
	{
		set_ValueNoCheck (COLUMNNAME_DeliveryConfirmation, DeliveryConfirmation);
	}

	/** Get Delivery Confirmation.
		@return EMail Delivery confirmation
	  */
	public String getDeliveryConfirmation()
	{
		return (String)get_Value(COLUMNNAME_DeliveryConfirmation);
	}

	/** Set EMail sent from.
		@param EMailFrom EMail sent from
	*/
	public void setEMailFrom (String EMailFrom)
	{
		set_Value (COLUMNNAME_EMailFrom, EMailFrom);
	}

	/** Get EMail sent from.
		@return EMail sent from	  */
	public String getEMailFrom()
	{
		return (String)get_Value(COLUMNNAME_EMailFrom);
	}

	/** IsDelivered AD_Reference_ID=319 */
	public static final int ISDELIVERED_AD_Reference_ID=319;
	/** No = N */
	public static final String ISDELIVERED_No = "N";
	/** Yes = Y */
	public static final String ISDELIVERED_Yes = "Y";
	/** Set Delivered.
		@param IsDelivered Delivered
	*/
	public void setIsDelivered (String IsDelivered)
	{

		set_ValueNoCheck (COLUMNNAME_IsDelivered, IsDelivered);
	}

	/** Get Delivered.
		@return Delivered	  */
	public String getIsDelivered()
	{
		return (String)get_Value(COLUMNNAME_IsDelivered);
	}

	/** Set Mail Text.
		@param MailText Text used for Mail message
	*/
	public void setMailText (String MailText)
	{
		set_Value (COLUMNNAME_MailText, MailText);
	}

	/** Get Mail Text.
		@return Text used for Mail message
	  */
	public String getMailText()
	{
		return (String)get_Value(COLUMNNAME_MailText);
	}

	/** Set Message ID.
		@param MessageID EMail Message ID
	*/
	public void setMessageID (String MessageID)
	{
		set_ValueNoCheck (COLUMNNAME_MessageID, MessageID);
	}

	/** Get Message ID.
		@return EMail Message ID
	  */
	public String getMessageID()
	{
		return (String)get_Value(COLUMNNAME_MessageID);
	}

	public org.compiere.model.I_R_MailText getR_MailText() throws RuntimeException
	{
		return (org.compiere.model.I_R_MailText)MTable.get(getCtx(), org.compiere.model.I_R_MailText.Table_ID)
			.getPO(getR_MailText_ID(), get_TrxName());
	}

	/** Set Mail Template.
		@param R_MailText_ID Text templates for mailings
	*/
	public void setR_MailText_ID (int R_MailText_ID)
	{
		if (R_MailText_ID < 1)
			set_ValueNoCheck (COLUMNNAME_R_MailText_ID, null);
		else
			set_ValueNoCheck (COLUMNNAME_R_MailText_ID, Integer.valueOf(R_MailText_ID));
	}

	/** Get Mail Template.
		@return Text templates for mailings
	  */
	public int getR_MailText_ID()
	{
		Integer ii = (Integer)get_Value(COLUMNNAME_R_MailText_ID);
		if (ii == null)
			 return 0;
		return ii.intValue();
	}

	/** Set Bcc.
		@param RecipientBcc Bcc
	*/
	public void setRecipientBcc (String RecipientBcc)
	{
		set_Value (COLUMNNAME_RecipientBcc, RecipientBcc);
	}

	/** Get Bcc.
		@return Bcc	  */
	public String getRecipientBcc()
	{
		return (String)get_Value(COLUMNNAME_RecipientBcc);
	}

	/** Set Cc.
		@param RecipientCc Cc
	*/
	public void setRecipientCc (String RecipientCc)
	{
		set_Value (COLUMNNAME_RecipientCc, RecipientCc);
	}

	/** Get Cc.
		@return Cc	  */
	public String getRecipientCc()
	{
		return (String)get_Value(COLUMNNAME_RecipientCc);
	}

	/** Set To.
		@param RecipientTo To
	*/
	public void setRecipientTo (String RecipientTo)
	{
		set_Value (COLUMNNAME_RecipientTo, RecipientTo);
	}

	/** Get To.
		@return To	  */
	public String getRecipientTo()
	{
		return (String)get_Value(COLUMNNAME_RecipientTo);
	}

	/** Set Subject.
		@param Subject Email Message Subject
	*/
	public void setSubject (String Subject)
	{
		set_Value (COLUMNNAME_Subject, Subject);
	}

	/** Get Subject.
		@return Email Message Subject
	  */
	public String getSubject()
	{
		return (String)get_Value(COLUMNNAME_Subject);
	}
}