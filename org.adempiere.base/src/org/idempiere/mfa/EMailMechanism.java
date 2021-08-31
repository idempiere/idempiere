/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - Carlos Ruiz (sponsored by FH)                                     *
 **********************************************************************/

package org.idempiere.mfa;

import java.sql.Timestamp;
import java.util.Properties;
import java.util.Random;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.IMFAMechanism;
import org.compiere.model.MClient;
import org.compiere.model.MMFAMethod;
import org.compiere.model.MMFARegistration;
import org.compiere.model.MMailText;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

public class EMailMechanism implements IMFAMechanism {

	/**
	 * Implement the registration mechanism for EMail Generate random code and
	 * return in the array
	 * 
	 * @param ctx
	 * @param method
	 * @param prm     email
	 * @param trxName
	 * @return Object[] - first object is the String with the instructions to follow
	 *         second object is the registration generated
	 */
	@Override
	public Object[] register(Properties ctx, MMFAMethod method, String prm, String trxName) {
		if (Util.isEmpty(prm))
			throw new AdempiereException(Msg.getMsg(ctx, "MFAEMailRequired"));
		if (!EMail.validate(prm))
			throw new AdempiereException(Msg.getMsg(ctx, "MFAInvalidEMail"));
		if (method.getR_MailText_ID() <= 0)
			throw new AdempiereException("EMail method wrongly configured - requires mail template");

		// just one time allowed per EMail
		if (MMFARegistration.alreadyExistsValid(method, prm))
			throw new AdempiereException(Msg.getMsg(ctx, "MFAMethodAlreadyRegistered"));

		// Generate a random code and save it in MFA_Registration
		String otp = generateRandomString(6);

		int expireMinutes = method.getExpireInMinutes();
		if (expireMinutes <= 0)
			expireMinutes = 15; // default to 15 minutes

		MUser user = MUser.get(ctx);
		MMFARegistration reg = new MMFARegistration(ctx, 0, trxName);
		reg.setName(obfuscateEMail(prm));
		reg.setParameterValue(prm);
		reg.setMFA_Method_ID(method.getMFA_Method_ID());
		reg.setAD_User_ID(user.getAD_User_ID());
		reg.setMFASecret(otp);
		reg.setIsValid(false);
		reg.setIsUserMFAPreferred(false);
		reg.setExpiration(new Timestamp(System.currentTimeMillis() + (expireMinutes * 60000)));
		reg.saveEx();

		// send the email
		MClient client = MClient.get(ctx);
		MMailText mt = new MMailText(ctx, method.getR_MailText_ID(), trxName);
		mt.setLanguage(Env.getContext(ctx, "#AD_Language"));
		mt.setUser(user.getAD_User_ID());
		mt.setPO(reg);
		String message = mt.getMailText(true);
		EMail email = client.createEMail(prm, mt.getMailHeader(), message, mt.isHtml());
		if (mt.isHtml())
			email.setMessageHTML(mt.getMailHeader(), message);
		else {
			email.setSubject(mt.getMailHeader());
			email.setMessageText(message);
		}
		if (!email.isValid() && !email.isValid(true))
			throw new AdempiereException("The EMail is not valid, check configuration");
		if (!EMail.SENT_OK.equals(email.send()))
			throw new AdempiereException(Msg.getMsg(ctx, "MFAProblemSendingEMail"));

		// Invalidate any other previous pending registration with same method and email
		MMFARegistration.invalidatePreviousPending(method, prm, reg);

		// Notify the user to check the email for the code
		Object[] ret = new Object[2];
		ret[0] = Msg.getMsg(Env.getCtx(), "MFAEMailCodeSent");
		ret[1] = reg;
		return ret;
	}

	/**
	 * Generates a numeric random string of the specified length
	 * 
	 * @param len
	 * @return random String
	 */
	public static String generateRandomString(int len) {
		// String chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"; // if upper alphanumeric is wanted
		String chars = "0123456789";
		Random rnd = new Random();
		StringBuilder sb = new StringBuilder(len);
		for (int i = 0; i < len; i++)
			sb.append(chars.charAt(rnd.nextInt(chars.length())));
		return sb.toString();
	}

	/**
	 * Complete/Validate a previous EMail registration
	 * 
	 * @param ctx
	 * @param reg                 The registration object
	 * @param p_MFAValidationCode The code to be validated
	 * @param p_Name              Optional - a name to assign the registration
	 * @param get_TrxName
	 * @return msg A message indicating success, errors throw exception
	 */
	@Override
	public String complete(Properties ctx, MMFARegistration reg, String code, String name, boolean preferred, String trxName) {
		boolean valid = code.equals(reg.getMFASecret());
		if (! valid) {
			reg.setLastFailure(new Timestamp(System.currentTimeMillis()));
			reg.setFailedLoginCount(reg.getFailedLoginCount() + 1);
			try {
				PO.setCrossTenantSafe();
				reg.saveEx();
			} finally {
				PO.clearCrossTenantSafe();
			}
			throw new AdempiereException(Msg.getMsg(ctx, "MFACodeInvalid"));
		}

		// valid code
		reg.setMFALastSecret(code);
		reg.setLastSuccess(new Timestamp(System.currentTimeMillis()));
		reg.setFailedLoginCount(0);
		reg.setIsValid(true);
		reg.setMFAValidatedAt(new Timestamp(System.currentTimeMillis()));
		reg.setExpiration(null);
		if (!Util.isEmpty(name))
			reg.setName(name);
		if (preferred)
			reg.setIsUserMFAPreferred(true);
		try {
			PO.setCrossTenantSafe();
			reg.saveEx();
		} finally {
			PO.clearCrossTenantSafe();
		}

		return Msg.getMsg(ctx, "MFARegistrationCompleted");
	}

	/**
	 * Send email with validation code
	 * @param reg
	 * @return
	 */
	@Override
	public String generateValidationCode(MMFARegistration reg) {
		Properties ctx = reg.getCtx();
		MMFAMethod method = new MMFAMethod(ctx, reg.getMFA_Method_ID(), reg.get_TrxName());

		// Generate a random code and save it in MFA_Registration
		String otp = generateRandomString(6);

		int expireMinutes = method.getExpireInMinutes();
		if (expireMinutes <= 0)
			expireMinutes = 15; // default to 15 minutes

		MUser user = MUser.get(reg.getCtx());
		reg.setMFASecret(otp);
		reg.setExpiration(new Timestamp(System.currentTimeMillis() + (expireMinutes * 60000)));
		try {
			PO.setCrossTenantSafe();
			reg.saveEx();
		} finally {
			PO.clearCrossTenantSafe();
		}

		String mail_to = reg.getParameterValue();
		// send the email
		MClient client = MClient.get(ctx);
		MMailText mt = new MMailText(ctx, method.getR_MailText_ID(), reg.get_TrxName());
		mt.setLanguage(Env.getContext(ctx, "#AD_Language"));
		mt.setUser(user.getAD_User_ID());
		mt.setPO(reg);
		String message = mt.getMailText(true);
		EMail email = client.createEMail(mail_to, mt.getMailHeader(), message, mt.isHtml());
		if (mt.isHtml())
			email.setMessageHTML(mt.getMailHeader(), message);
		else {
			email.setSubject(mt.getMailHeader());
			email.setMessageText(message);
		}
		if (!email.isValid() && !email.isValid(true))
			throw new AdempiereException("The EMail is not valid, check configuration");
		if (!EMail.SENT_OK.equals(email.send()))
			throw new AdempiereException(Msg.getMsg(ctx, "MFAProblemSendingEMail"));

		return Msg.getMsg(Env.getCtx(), "MFAEMailValidationCodeSent", new Object[] { obfuscateEMail(mail_to) });
	}

	/**
	 * Replace internal characters in email with *
	 * @param mail
	 * @return
	 */
	private String obfuscateEMail(String mail) {
		StringBuilder mailObfuscated = new StringBuilder();
		boolean atFound = false;
		for (int idx = 0; idx < mail.length(); idx++) {
			char chr = mail.charAt(idx);
			if (chr == '@') {
				atFound = true;
			} else if ((!atFound && idx > 1) || (atFound && idx < mail.length() - 4)) {
				chr = '*';
			}
			mailObfuscated.append(chr);
		}
		return mailObfuscated.toString();
	}

	/**
	 * Validate a code
	 * @param reg
	 * @param code
	 * @param setPreferred
	 * @return message on error, null when OK
	 */
	@Override
	public String validateCode(MMFARegistration reg, String code, boolean setPreferred) {
		Properties ctx = reg.getCtx();
		Timestamp now = new Timestamp(System.currentTimeMillis());
		if (reg.getExpiration() != null && now.after(reg.getExpiration()))
			return Msg.getMsg(ctx, "MFARegistrationExpired");
		if (code.equals(reg.getMFALastSecret()))
			return Msg.getMsg(ctx, "MFACodeAlreadyConsumed");

		boolean valid = code.equals(reg.getMFASecret());
		if (! valid) {
			reg.setLastFailure(new Timestamp(System.currentTimeMillis()));
			reg.setFailedLoginCount(reg.getFailedLoginCount() + 1);
			reg.saveEx();
			return Msg.getMsg(ctx, "MFACodeInvalid");
		}

		reg.setMFALastSecret(code);
		reg.setLastSuccess(new Timestamp(System.currentTimeMillis()));
		reg.setFailedLoginCount(0);
		if (setPreferred)
			reg.setIsUserMFAPreferred(true);
		try {
			PO.setCrossTenantSafe();
			reg.saveEx();
		} finally {
			PO.clearCrossTenantSafe();
		}
		
		return null;
	}

}
