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

import static dev.samstevens.totp.util.Utils.getDataUriForImage;

import java.net.UnknownHostException;
import java.sql.Timestamp;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.IMFAMechanism;
import org.compiere.model.MMFAMethod;
import org.compiere.model.MMFARegistration;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

import dev.samstevens.totp.code.CodeGenerator;
import dev.samstevens.totp.code.DefaultCodeGenerator;
import dev.samstevens.totp.code.DefaultCodeVerifier;
import dev.samstevens.totp.exceptions.QrGenerationException;
import dev.samstevens.totp.qr.QrData;
import dev.samstevens.totp.qr.QrGenerator;
import dev.samstevens.totp.qr.ZxingPngQrGenerator;
import dev.samstevens.totp.secret.DefaultSecretGenerator;
import dev.samstevens.totp.secret.SecretGenerator;
import dev.samstevens.totp.time.NtpTimeProvider;
import dev.samstevens.totp.time.SystemTimeProvider;
import dev.samstevens.totp.time.TimeProvider;

public class TOTPMechanism implements IMFAMechanism {

	/**
	 * Implement the registration mechanism for TOTP
	 * Generate the secret and the qrcode and return in the array
	 * @param ctx
	 * @param method
	 * @param prm         optional - assigned name from the user
	 * @param trxName
	 * @return Object[] - first object is the String with the instructions to follow
	 *                    second object is the registration generated
	 *                    third message qrcode
	 *                    fourth qrcode
	 *                    fifth message secret
	 *                    sixth secret
	 */
	@Override
	public Object[] register(Properties ctx, MMFAMethod method, String prm, String trxName) {
		if (Util.isEmpty(method.getMFAIssuer()))
			throw new AdempiereException(Msg.getMsg(ctx, "MFATOTPIssuerRequired"));

		if (MMFARegistration.alreadyExistsValid(method, prm))
			throw new AdempiereException(Msg.getMsg(ctx, "MFAMethodAlreadyRegistered"));

		MUser user = MUser.get(ctx);
		String label;
		boolean email_login = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
		if (email_login)
			label = user.getEMail();
		else
			label = user.getName();

		SecretGenerator secretGenerator = new DefaultSecretGenerator();
		String secret = secretGenerator.generate();

		QrData data = new QrData.Builder()
				.label(label)
				.secret(secret)
				.issuer(method.getMFAIssuer())
				.build();

		QrGenerator generator = new ZxingPngQrGenerator();
		byte[] imageData;
		try {
			imageData = generator.generate(data);
		} catch (QrGenerationException e) {
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "MFATOTPErrorGeneratingQR"), e);
		}
		String mimeType = generator.getImageMimeType();
		String dataUri = getDataUriForImage(imageData, mimeType);

		int expireMinutes = method.getExpireInMinutes();

		MMFARegistration reg = new MMFARegistration(ctx, 0, trxName);
		if (! Util.isEmpty(prm)) {
			reg.setName(prm);
			reg.setParameterValue(prm);
		} else {
			reg.setName(label);
		}
		reg.setMFA_Method_ID(method.getMFA_Method_ID());
		reg.setAD_User_ID(user.getAD_User_ID());
		reg.setMFASecret(secret);
		reg.setIsValid(false);
		reg.setIsUserMFAPreferred(false);
		if (expireMinutes > 0)
			reg.setExpiration(new Timestamp(System.currentTimeMillis() + (expireMinutes*60000)));
		reg.saveEx();

		// Invalidate any other previous pending registration with same method
		MMFARegistration.invalidatePreviousPending(method, prm, reg);

		// Notify the user that TOTP mechanism was registered and follow next step
		Object[] ret = new Object[6];
		ret[0] = Msg.getMsg(Env.getCtx(), "MFATOTPRegistered");
		ret[1] = reg;
		ret[2]  = Msg.getMsg(Env.getCtx(), "MFATOTPImage");
		ret[3] = dataUri;
		ret[4]  = Msg.getMsg(Env.getCtx(), "MFATOTPSecret");
		ret[5] = secret;

		return ret;
	}

	/**
	 * Complete/Validate a previous TOTP registration
	 * @param ctx
	 * @param reg                  The registration object
	 * @param p_MFAValidationCode  The code to be validated
	 * @param p_Name               Optional - a name to assign the registration
	 * @param trxName
	 * @return msg    A message indicating success, errors throw exception
	 */
	@Override
	public String complete(Properties ctx, MMFARegistration reg, String code, String name, boolean preferred, String trxName) {
		if (! isValidCode(ctx, reg, code, trxName))
			throw new AdempiereException(Msg.getMsg(ctx, "MFACodeInvalid"));

		// valid code
		reg.setIsValid(true);
		reg.setMFAValidatedAt(new Timestamp(System.currentTimeMillis()));
		reg.setExpiration(null);
		if (!Util.isEmpty(name))
			reg.setName(name);
		if (preferred)
			reg.setIsUserMFAPreferred(true);
		reg.saveEx();

		return Msg.getMsg(ctx, "MFARegistrationCompleted");
	}

	/**
	 * @param reg
	 * @param code
	 * @param trxName
	 * @return
	 */
	private boolean isValidCode(Properties ctx, MMFARegistration reg, String code, String trxName) {
		MMFAMethod method = new MMFAMethod(ctx, reg.getMFA_Method_ID(), trxName);
		TimeProvider timeProvider;
		if (MMFAMethod.MFATIMEPROVIDER_Ntp.equals(method.getMFATimeProvider())) {
			String ntpServer = method.getMFATimeServer();
			if (Util.isEmpty(ntpServer))
				ntpServer = "pool.ntp.org";
			int timeout = MSysConfig.getIntValue(MSysConfig.MFA_NTP_TIMEOUT_IN_MILLISECONDS, 5000);
			try {
				timeProvider = new NtpTimeProvider(ntpServer, timeout);
			} catch (UnknownHostException e) {
				throw new AdempiereException(Msg.getMsg(ctx, "MFANTPServerError") + e.getLocalizedMessage(), e);
			}
		} else { // default to System
			timeProvider = new SystemTimeProvider();
		}
		CodeGenerator codeGenerator = new DefaultCodeGenerator();
		DefaultCodeVerifier verifier = new DefaultCodeVerifier(codeGenerator, timeProvider);
		if (method.getMFAAllowedTimeDiscrepancy() > 0) {
			// allow codes valid for the time periods configured before/after to pass as valid (default is 1)
			verifier.setAllowedTimePeriodDiscrepancy(method.getMFAAllowedTimeDiscrepancy());
		}

		boolean valid = verifier.isValidCode(reg.getMFASecret(), code);
		if (valid) {
			reg.setMFALastSecret(code);
			reg.setLastSuccess(new Timestamp(System.currentTimeMillis()));
			reg.setFailedLoginCount(0);
		} else  {
			reg.setLastFailure(new Timestamp(System.currentTimeMillis()));
			reg.setFailedLoginCount(reg.getFailedLoginCount() + 1);
		}
		try {
			PO.setCrossTenantSafe();
			reg.saveEx();
		} finally {
			PO.clearCrossTenantSafe();
		}
		return valid;
	}

	/**
	 * Generate a validation code - do nothing for TOTP
	 * @param reg
	 * @return
	 */
	@Override
	public String generateValidationCode(MMFARegistration reg) {
		return Msg.getMsg(Env.getCtx(), "MFATOTPEnterValidationCode");
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
		if (code.equals(reg.getMFALastSecret()))
			return Msg.getMsg(ctx, "MFACodeAlreadyConsumed");

		if (! isValidCode(ctx, reg, code, reg.get_TrxName()))
			return Msg.getMsg(ctx, "MFACodeInvalid");

		if (setPreferred) {
			reg.setIsUserMFAPreferred(true);
			try {
				PO.setCrossTenantSafe();
				reg.saveEx();
			} finally {
				PO.clearCrossTenantSafe();
			}
		}

		return null;
	}

}
