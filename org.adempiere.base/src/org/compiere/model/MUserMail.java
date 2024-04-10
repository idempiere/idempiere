/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.model;

import java.sql.ResultSet;
import java.util.Properties;

import javax.mail.internet.InternetAddress;

import org.compiere.util.EMail;
import org.compiere.util.Env;

/**
 * 	User Mail Model
 *  @author Jorg Janke
 *  @version $Id: MUserMail.java,v 1.2 2006/07/30 00:51:02 jjanke Exp $
 */
public class MUserMail extends X_AD_UserMail
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -6933973466878945692L;

    /**
     * UUID based Constructor
     * @param ctx  Context
     * @param AD_UserMail_UU  UUID key
     * @param trxName Transaction
     */
    public MUserMail(Properties ctx, String AD_UserMail_UU, String trxName) {
        super(ctx, AD_UserMail_UU, trxName);
    }

	/**
	 * 	Standard Constructor
	 *	@param ctx context
	 *	@param AD_UserMail_ID id
	 *	@param trxName trx
	 */
	public MUserMail (Properties ctx, int AD_UserMail_ID, String trxName)
	{
		super (ctx, AD_UserMail_ID, trxName);
	}	//	MUserMail

	/**
	 * 	Load Constructor
	 *	@param ctx context
	 *	@param rs result set
	 *	@param trxName trx
	 */
	public MUserMail (Properties ctx, ResultSet rs, String trxName)
	{
		super (ctx, rs, trxName);
	}	//	MUserMail
	
	/**
	 * 	User Mail
	 *	@param parent Request Mail Text
	 *	@param AD_User_ID recipient user
	 *	@param mail email
	 */
	public MUserMail (MMailText parent, int AD_User_ID, EMail mail)
	{
		this (parent.getCtx(), 0, parent.get_TrxName());
		setAD_User_ID(AD_User_ID);
		setR_MailText_ID(parent.getR_MailText_ID());
		setMailValues(mail);
	}	//	MUserMail
	
	/**
	 * 	New User Mail record (not using trx from po)
	 *	@param po persistent object
	 *	@param AD_User_ID recipient user
	 *	@param mail email
	 */
	public MUserMail (PO po, int AD_User_ID, EMail mail)
	{
		this (po.getCtx(), 0, null);
		setClientOrg(po);
		setAD_User_ID(AD_User_ID);
		setMailValues(mail);
	}	//	MUserMail
	
	/**
	 * New user mail record
	 * @param ctx
	 * @param mail
	 */
	public MUserMail (Properties ctx, EMail mail)
	{
		this (ctx, 0, null);
		setAD_User_ID(Env.getAD_User_ID(ctx));
		setMailValues(mail);
	}	//	MUserMail
	
	/**
	 * Sets all columns related to the EMail.<br/>
	 * Subject - Mail Text - Sender - Recipient - Message ID - IsDelivered.
	 * @param mail
	 */
	private void setMailValues(EMail mail) {
		setSubject(mail.getSubject());
		setMailText(mail.getMessageCRLF());
		setSenderAndRecipient(mail);
		//
		if (mail.isSentOK())
			setMessageID(mail.getMessageID());
		else {
			setMessageID(mail.getSentMsg());
			setIsDelivered(ISDELIVERED_No);
		}
	}
	
	/**
	 * 	Is it Delivered
	 *	@return true if yes
	 */
	public boolean isDelivered()
	{
		String s = getIsDelivered();
		return s != null 
			&& ISDELIVERED_Yes.equals(s);
	}	//	isDelivered

	/**
	 * 	Is it not Delivered
	 *	@return true if deliver status is null or no
	 */
	public boolean isDeliveredNo()
	{
		String s = getIsDelivered();
		return s == null 
			|| ISDELIVERED_No.equals(s);
	}	//	isDelivered

	/**
	 * 	Is Delivered unknown
	 *	@return true if deliver status is null
	 */
	public boolean isDeliveredUnknown()
	{
		String s = getIsDelivered();
		return s == null;
	}	//	isDeliveredUnknown

	/** 
	 * Fill sender and recipients fields
	 * @param mail 
	 */
	public void setSenderAndRecipient(EMail mail)
	{
		setEMailFrom(mail.getFrom().toString());
		setRecipientTo(getRecipientWithCommaSeparator(mail.getTos()));
		setRecipientCc(getRecipientWithCommaSeparator(mail.getCcs()));
		setRecipientBcc(getRecipientWithCommaSeparator(mail.getBccs()));
	}

	/**
	 * Get comma separated list of recipients
	 * @param recipients
	 * @return comma separated list of recipients
	 */
	static public String getRecipientWithCommaSeparator(InternetAddress[] recipients)
	{
		StringBuilder retValue = new StringBuilder("");
		if (recipients != null) {
			for (InternetAddress ia : recipients)
				retValue.append(retValue.length() > 0 ? ", " : "" ).append(ia.getAddress());
		}
		return retValue.toString();
	}

}	//	MUserMail
