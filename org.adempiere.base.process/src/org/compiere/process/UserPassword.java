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
package org.compiere.process;

import java.util.logging.Level;

import org.compiere.model.MClient;
import org.compiere.model.MPasswordRule;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.Util;
/**
 *	Reset Password
 *	
 *  @author Jorg Janke
 *  @version $Id: UserPassword.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class UserPassword extends SvrProcess
{
	private int		p_AD_User_ID = -1;
	private String 		p_OldPassword = null;
	private String 		p_NewPassword = null;
	private String 		p_NewPasswordConfirm = null;
	private String		p_NewEMail = null;
	private String		p_NewEMailConfirm = null;
	private String		p_NewEMailUser = null;
	private String		p_NewEMailUserPW = null;

	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else if (name.equals("AD_User_ID"))
				p_AD_User_ID = para[i].getParameterAsInt();
			else if (name.equals("OldPassword"))
				p_OldPassword = (String)para[i].getParameter();
			else if (name.equals("NewPassword"))
				p_NewPassword = (String)para[i].getParameter();
			else if (name.equals("NewEMail"))
				p_NewEMail = (String)para[i].getParameter();
			else if (name.equals("NewEMailUser"))
				p_NewEMailUser = (String)para[i].getParameter();
			else if (name.equals("NewEMailUserPW"))
				p_NewEMailUserPW = (String)para[i].getParameter();
			else if (name.equals("NewPasswordConfirm"))
				p_NewPasswordConfirm=(String)para[i].getParameter();
			else if (name.equals("NewEMailConfirm"))
				p_NewEMailConfirm = (String)para[i].getParameter();
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message 
	 *  @throws Exception if not successful
	 */
	protected String doIt() throws Exception
	{
		log.info ("AD_User_ID=" + p_AD_User_ID + " from " + getAD_User_ID());
		
		MUser user = MUser.get(getCtx(), p_AD_User_ID);
		MUser operator = MUser.get(getCtx(), getAD_User_ID());
		log.fine("User=" + user + ", Operator=" + operator);
		
		boolean hash_password = MSysConfig.getBooleanValue("USER_PASSWORD_HASH", false);
		
		//	Do we need a password ?
		if (Util.isEmpty(p_OldPassword))		//	Password required
		{
			if (p_AD_User_ID == 0			//	change of System
					|| p_AD_User_ID == 100		//	change of SuperUser
					|| !operator.isAdministrator())
				throw new IllegalArgumentException("@OldPasswordMandatory@");
		} else {
			//	is entered Password correct ?
			if (hash_password) {
				if (!user.authenticateHash(p_OldPassword))
					throw new IllegalArgumentException("@OldPasswordNoMatch@");
			} else {
				if (!p_OldPassword.equals(user.getPassword()))
					throw new IllegalArgumentException("@OldPasswordNoMatch@");
			}
		}
		
		// new password confirm
		if (!Util.isEmpty(p_NewPassword)) {
			if (Util.isEmpty(p_NewPasswordConfirm)) {
				throw new IllegalArgumentException("@NewPasswordConfirmMandatory@");
			} else {
				if (!p_NewPassword.equals(p_NewPasswordConfirm)) {
					throw new IllegalArgumentException("@PasswordNotMatch@");
				} else {
					String msg = validate();
					if (msg != null) {
						throw new IllegalArgumentException(msg);
					}
				}
			}
		}
		
		if (!Util.isEmpty(p_NewEMailUserPW)) {
			if (Util.isEmpty(p_NewEMailConfirm)) {
				throw new IllegalArgumentException("@NewEmailConfirmMandatory@");
			} else {
				if (!p_NewEMailUserPW.equals(p_NewEMailConfirm)) {
					throw new IllegalArgumentException("@NewEmailNotMatch@");
				}
			}
		}
		
		if (!Util.isEmpty(p_NewPassword))
			user.setPassword(p_NewPassword);
		if (!Util.isEmpty(p_NewEMail))
			user.setEMail(p_NewEMail);
		if (!Util.isEmpty(p_NewEMailUser))
			user.setEMailUser(p_NewEMailUser);
		if (!Util.isEmpty(p_NewEMailUserPW))
			user.setEMailUserPW(p_NewEMailUserPW);
		user.saveEx();

		return "OK";
	}	//	doIt

	
	private String validate()
	{	
		MClient client=new MClient(getCtx(), getAD_Client_ID(), get_TrxName());
		int ad_passwordrule_id = client.getAD_PasswordRule_ID();

		String error = null;
		if (ad_passwordrule_id > 0)
		{
			MPasswordRule rule =new MPasswordRule(getCtx(), ad_passwordrule_id, get_TrxName());
			error = rule.validate(p_NewPassword);
		}

		return error;		
	}
	
}	//	UserPassword

