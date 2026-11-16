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
 **********************************************************************/
package org.adempiere.base;

import java.security.SecureRandom;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MClient;
import org.compiere.model.MMailText;
import org.compiere.model.MPasswordResetToken;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.X_AD_PasswordResetToken;
import org.compiere.util.CCache;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.EMail;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.SecureEngine;
import org.compiere.util.Trx;
import org.compiere.util.Util;

/**
 * Default {@link IPasswordResetService} implementation (code-based reset).
 *
 * @author d-ruiz - IDEMPIERE-7060
 */
public class DefaultPasswordResetService implements IPasswordResetService
{
	private static final CLogger log = CLogger.getCLogger(DefaultPasswordResetService.class);

	/** Name of the seed R_MailText carrying the reset code */
	private static final String MAIL_TEXT_NAME = "Password Reset Code";

	/**
	 * Per-email decoy state for unknown addresses, so an email that is NOT registered produces the
	 * same verify/request responses as a registered one (anti-enumeration) without ever creating a
	 * token row or sending mail. Never persisted.
	 * <p>
	 * Marked distributed so the counters are shared across cluster nodes (a real email locks
	 * cluster-wide via its DB token, so the decoy must too); on a clustered instance the entries live
	 * in a Hazelcast map bounded by the shipped {@code hazelcast.xml} default map config (LRU per node
	 * + max-idle TTL), and on a stand-alone instance it falls back to the local capped/expiring cache.
	 */
	private static final CCache<String, Integer> s_decoyVerifyAttempts =
			new CCache<>(null, "PasswordResetDecoyVerify", 100, 15, true, 10000);
	private static final CCache<String, List<Long>> s_decoyRequestTimes =
			new CCache<>(null, "PasswordResetDecoyRequest", 100, 60, true, 10000);

	@Override
	public void requestReset(String email, int AD_Client_ID, String language)
	{
		if (Util.isEmpty(email, true))
			return;
		email = email.trim();

		List<MUser> users = findUsers(email);
		if (users.isEmpty())
		{
			// unknown email: apply the same cooldown / per-hour limits from memory so it can also
			// return TooManyRequests, without creating a token or sending mail
			if (isVirtualRequestRateLimited(email, AD_Client_ID))
				throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PasswordResetTooManyRequests"));
			return; // neutral response - do not reveal whether the account exists
		}

		if (isRateLimited(email, AD_Client_ID))
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PasswordResetTooManyRequests"));

		int expiryMin = MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_CODE_EXPIRY_MINUTES, 10, AD_Client_ID);
		String code = generateCode();

		Trx trx = Trx.get(Trx.createTrxName("PwdResetReq"), true);
		try
		{
			// issuing a new code invalidates any earlier pending code for this email,
			// so only the most recently emailed code can be verified (avoids the
			// silent failure where an older code no longer matches the latest token)
			MPasswordResetToken.expirePendingForEMail(email, trx.getTrxName());

			MPasswordResetToken token = new MPasswordResetToken(Env.getCtx(), 0, trx.getTrxName());
			token.setEMail(email);
			token.setOneTimeCode(code); // stored encrypted at rest (AD_Column IsEncrypted='Y')
			token.setTokenStatus(X_AD_PasswordResetToken.TOKENSTATUS_Pending);
			token.setAttemptsUsed(0);
			token.setExpiration(new Timestamp(System.currentTimeMillis() + expiryMin * 60000L));
			token.saveEx();

			trx.commit(true);
		}
		catch (Exception e)
		{
			trx.rollback();
			if (e instanceof AdempiereException)
				throw (AdempiereException) e;
			throw new AdempiereException(e);
		}
		finally
		{
			trx.close();
		}

		// send the code after the token is committed, so the DB transaction is not held
		// open across the SMTP round-trip (lock/connection contention) and a commit failure
		// can never leave the user with a code that was emailed but not persisted
		if (!sendCodeEmail(users.get(0), email, code, expiryMin, language))
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "RequestActionEMailError") + ": " + email);
	}

	@Override
	public String verifyCode(String email, String code)
	{
		if (Util.isEmpty(email, true) || Util.isEmpty(code, true))
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PasswordResetInvalidCode"));
		email = email.trim();
		code = code.trim();

		MPasswordResetToken token = getLatestPending(email);
		if (token == null)
			throw decoyVerifyException(email); // unknown email: mimic the real token's attempt lockout

		int maxAttempts = MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_MAX_ATTEMPTS, 5, token.getAD_Client_ID());

		if (token.isCodeExpired())
		{
			token.setTokenStatus(X_AD_PasswordResetToken.TOKENSTATUS_Expired);
			token.saveEx();
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PasswordResetCodeExpired"));
		}

		if (token.getAttemptsUsed() >= maxAttempts)
		{
			token.setTokenStatus(X_AD_PasswordResetToken.TOKENSTATUS_Expired);
			token.saveEx();
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PasswordResetAttemptsExceeded"));
		}

		// the code is stored encrypted; PO decrypts getOneTimeCode() on read for a direct compare
		if (!code.equals(token.getOneTimeCode()))
		{
			int used = token.incrementAttempts();
			boolean locked = used >= maxAttempts;
			if (locked)
				token.setTokenStatus(X_AD_PasswordResetToken.TOKENSTATUS_Expired);
			token.saveEx();
			throw new AdempiereException(Msg.getMsg(Env.getCtx(),
					locked ? "PasswordResetAttemptsExceeded" : "PasswordResetInvalidCode"));
		}

		// code matches -> mint a verified token
		int verifiedMin = MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_VERIFIED_TOKEN_EXPIRY_MINUTES, 5, token.getAD_Client_ID());
		String verifiedToken = generateVerifiedToken();
		token.setVerifiedTokenHash(hashToken(verifiedToken));
		token.setVerifiedTokenExpires(new Timestamp(System.currentTimeMillis() + verifiedMin * 60000L));
		token.setTokenStatus(X_AD_PasswordResetToken.TOKENSTATUS_Verified);
		token.saveEx();
		return verifiedToken;
	}

	@Override
	public void completeReset(String verifiedToken, String newPassword)
	{
		if (Util.isEmpty(verifiedToken, true) || Util.isEmpty(newPassword, false))
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PasswordResetInvalidCode"));

		MPasswordResetToken token = new Query(Env.getCtx(), MPasswordResetToken.Table_Name,
				"VerifiedTokenHash=? AND TokenStatus=?", null)
				.setParameters(hashToken(verifiedToken.trim()), X_AD_PasswordResetToken.TOKENSTATUS_Verified)
				.first();
		if (token == null)
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PasswordResetInvalidCode"));

		if (token.isVerifiedTokenExpired())
		{
			token.setTokenStatus(X_AD_PasswordResetToken.TOKENSTATUS_Expired);
			token.saveEx();
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PasswordResetCodeExpired"));
		}

		String email = token.getEMail();
		List<MUser> users = findUsers(email);
		if (users.isEmpty())
			throw new AdempiereException(Msg.getMsg(Env.getCtx(), "PasswordResetInvalidCode"));

		Trx trx = Trx.get(Trx.createTrxName("PwdResetDone"), true);
		try
		{
			PO.setCrossTenantSafe();
			for (MUser user : users)
			{
				user.set_TrxName(trx.getTrxName());
				// honor CHANGE_PASSWORD_MUST_DIFFER: the forgot-password flow has no typed old
				// password, so compare the new password against this user's current stored password
				// (mirrors WResetPassword's old-password check). Must run before set_ValueOfColumn.
				if (MSysConfig.getBooleanValue(MSysConfig.CHANGE_PASSWORD_MUST_DIFFER, true))
				{
					boolean same = MSysConfig.getBooleanValue(MSysConfig.USER_PASSWORD_HASH, false)
							? user.authenticateHash(newPassword)
							: newPassword.equals(user.getPassword());
					if (same)
						throw new AdempiereException(Msg.getMsg(Env.getCtx(), "NewPasswordMustDiffer"));
				}
				user.set_ValueOfColumn("Password", newPassword); // hashed & policy-validated on saveEx
				// the user proved control of the email + code, so clear any failed-login lockout
				// (Login.java otherwise keeps them locked out until MAX_ACCOUNT_LOCK_MINUTES elapses)
				if (user.isLocked() || user.getFailedLoginCount() > 0)
				{
					user.setFailedLoginCount(0);
					user.setDateAccountLocked(null);
				}
				user.saveEx(); // cross-tenant already enabled by the surrounding setCrossTenantSafe()
				MSession.invalidateSessionsForUser(user.getAD_User_ID(), trx.getTrxName());
			}
			token.set_TrxName(trx.getTrxName());
			token.setTokenStatus(X_AD_PasswordResetToken.TOKENSTATUS_Completed);
			token.saveEx();
			trx.commit(true);
		}
		catch (Exception e)
		{
			trx.rollback();
			if (e instanceof AdempiereException)
				throw (AdempiereException) e;
			throw new AdempiereException(e);
		}
		finally
		{
			PO.clearCrossTenantSafe();
			trx.close();
		}
	}

	/**
	 * Find all active users that can reset their password using this email (across tenants).
	 * Mirrors the query used by the legacy reset flow: password set, active user with an
	 * active role and active client.
	 */
	private List<MUser> findUsers(String email)
	{
		StringBuilder where = new StringBuilder("Password IS NOT NULL AND EMail=?")
				.append(" AND EXISTS (SELECT 1 FROM AD_User_Roles ur")
				.append("   INNER JOIN AD_Role r ON (ur.AD_Role_ID=r.AD_Role_ID)")
				.append("   WHERE ur.AD_User_ID=AD_User.AD_User_ID AND ur.IsActive='Y' AND r.IsActive='Y')")
				.append(" AND EXISTS (SELECT 1 FROM AD_Client c")
				.append("   WHERE c.AD_Client_ID=AD_User.AD_Client_ID AND c.IsActive='Y')")
				.append(" AND AD_User.IsActive='Y'");
		try
		{
			PO.setCrossTenantSafe();
			return new Query(Env.getCtx(), MUser.Table_Name, where.toString(), null)
					.setParameters(email)
					.setOrderBy(MUser.COLUMNNAME_AD_User_ID)
					.list();
		}
		finally
		{
			PO.clearCrossTenantSafe();
		}
	}

	/**
	 * @return the newest still-pending token for the email, or null
	 */
	private MPasswordResetToken getLatestPending(String email)
	{
		return new Query(Env.getCtx(), MPasswordResetToken.Table_Name, "EMail=? AND TokenStatus=?", null)
				.setParameters(email, X_AD_PasswordResetToken.TOKENSTATUS_Pending)
				.setOrderBy(X_AD_PasswordResetToken.COLUMNNAME_Created + " DESC")
				.first();
	}

	/**
	 * @return true if a new request should be blocked (cooldown or per-hour cap)
	 */
	private boolean isRateLimited(String email, int AD_Client_ID)
	{
		int cooldownSec = MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_REQUEST_COOLDOWN_SECONDS, 60, AD_Client_ID);
		int maxPerHour = MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_MAX_REQUESTS_PER_HOUR, 5, AD_Client_ID);
		long now = System.currentTimeMillis();

		if (cooldownSec > 0)
		{
			int recent = DB.getSQLValueEx(null,
					"SELECT COUNT(*) FROM AD_PasswordResetToken WHERE EMail=? AND Created > ?",
					email, new Timestamp(now - cooldownSec * 1000L));
			if (recent > 0)
				return true;
		}
		if (maxPerHour > 0)
		{
			int lastHour = DB.getSQLValueEx(null,
					"SELECT COUNT(*) FROM AD_PasswordResetToken WHERE EMail=? AND Created > ?",
					email, new Timestamp(now - 3600000L));
			if (lastHour >= maxPerHour)
				return true;
		}
		return false;
	}

	/**
	 * No pending token exists for this email (unknown address or an already-consumed code). Mirror the
	 * real token's attempt accounting from memory so the response is indistinguishable from a
	 * registered email, without creating any DB row: attempts 1..max-1 report "invalid code" and
	 * attempt {@code max} reports "too many attempts" (matching the real token flipping to Expired),
	 * then the counter resets and the cycle repeats. This mirrors a registered email whose token
	 * expires at {@code max} and drops back into this same decoy path, so the lockout message recurs
	 * for both and neither can be told apart by a bot that keeps guessing.
	 *
	 * @param email trimmed email
	 * @return the exception to throw
	 */
	private AdempiereException decoyVerifyException(String email)
	{
		int max = MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_MAX_ATTEMPTS, 5);
		int used;
		synchronized (s_decoyVerifyAttempts)
		{
			Integer prev = s_decoyVerifyAttempts.get(email);
			used = (prev == null ? 0 : prev.intValue()) + 1;
			// reset after the lockout boundary so an unknown email cycles invalid*(max-1) -> exceeded
			// repeatedly, exactly like a registered email whose token expires and re-enters this path
			// (otherwise "AttemptsExceeded" fires only once here and only registered emails repeat it,
			// which would let a bot tell registered from unregistered addresses)
			s_decoyVerifyAttempts.put(email, Integer.valueOf(used >= max ? 0 : used));
		}
		String key = (used >= max) ? "PasswordResetAttemptsExceeded" : "PasswordResetInvalidCode";
		return new AdempiereException(Msg.getMsg(Env.getCtx(), key));
	}

	/**
	 * In-memory twin of {@link #isRateLimited(String, int)} for unknown emails: records a virtual
	 * request when allowed (mirroring the token row a real request would create) and blocks on the same
	 * cooldown / per-hour thresholds, so a registered and an unregistered email throw
	 * {@code PasswordResetTooManyRequests} under identical conditions. No token row is created.
	 *
	 * @return true if the (virtual) request should be blocked
	 */
	private boolean isVirtualRequestRateLimited(String email, int AD_Client_ID)
	{
		int cooldownSec = MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_REQUEST_COOLDOWN_SECONDS, 60, AD_Client_ID);
		int maxPerHour = MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_MAX_REQUESTS_PER_HOUR, 5, AD_Client_ID);
		long now = System.currentTimeMillis();
		synchronized (s_decoyRequestTimes)
		{
			List<Long> times = s_decoyRequestTimes.get(email);
			times = (times == null) ? new ArrayList<>() : new ArrayList<>(times);
			times.removeIf(t -> t <= now - 3600000L); // prune > 1h (matches the per-hour window)
			boolean cooled = cooldownSec > 0 && times.stream().anyMatch(t -> t > now - cooldownSec * 1000L);
			boolean capped = maxPerHour > 0 && times.size() >= maxPerHour;
			if (cooled || capped)
			{
				// blocked -> caller throws; do not record (mirrors the valid path not creating a token)
				s_decoyRequestTimes.put(email, times);
				return true;
			}
			times.add(Long.valueOf(now));
			s_decoyRequestTimes.put(email, times);
			return false;
		}
	}

	/**
	 * Send the reset code by email using the {@value #MAIL_TEXT_NAME} R_MailText template.
	 * @return true if the mail was sent
	 */
	private boolean sendCodeEmail(MUser to, String email, String code, int expiryMin, String language)
	{
		Properties ctx = Env.getCtx();
		MClient client = MClient.get(ctx, 0); // system client for SMTP config
		int R_MailText_ID = DB.getSQLValue(null,
				"SELECT R_MailText_ID FROM R_MailText WHERE IsActive='Y' AND Name=? AND AD_Client_ID IN (?, 0) ORDER BY AD_Client_ID DESC",
				MAIL_TEXT_NAME, to.getAD_Client_ID());
		if (R_MailText_ID <= 0)
			return false;

		MMailText mailText = new MMailText(ctx, R_MailText_ID, null);
		mailText.setLanguage(!Util.isEmpty(language) ? language : Env.getContext(ctx, Env.LANGUAGE));
		mailText.setUser(to);
		String message = mailText.getMailText(true, true, true);
		Env.setContext(ctx, "#ResetCode", code);
		Env.setContext(ctx, "#ResetCodeExpiryMinutes", String.valueOf(expiryMin));
		try
		{
			message = Env.parseVariable(message, to, null, true);
		}
		finally
		{
			// always clear the plaintext code from the session context, even if parsing fails
			Env.setContext(ctx, "#ResetCode", "");
			Env.setContext(ctx, "#ResetCodeExpiryMinutes", "");
		}

		EMail mail = client.createEMail(email, mailText.getMailHeader(), message, mailText.isHtml());
		if (mailText.isHtml())
			mail.setMessageHTML(mailText.getMailHeader(), message);
		else
		{
			mail.setSubject(mailText.getMailHeader());
			mail.setMessageText(message);
		}
		if (!mail.isValid() && !mail.isValid(true))
		{
			if (log.isLoggable(Level.WARNING)) log.warning("NOT VALID - " + mail);
			return false;
		}
		return EMail.SENT_OK.equals(mail.send());
	}

	/**
	 * @return a random numeric code whose length is set by the
	 *         {@link MSysConfig#PASSWORD_RESET_CODE_LENGTH} system configuration (default 6)
	 */
	private String generateCode()
	{
		int length = MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_CODE_LENGTH, 6);
		if (length < 4) // sane floor so a misconfig cannot make codes trivially guessable
			length = 4;
		try
		{
			SecureRandom random = SecureEngine.getSecureRandom();
			StringBuilder sb = new StringBuilder(length);
			for (int i = 0; i < length; i++)
				sb.append(random.nextInt(10));
			return sb.toString();
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
	}

	/**
	 * @return a 256-bit random token as a 64-char hex string
	 */
	private String generateVerifiedToken()
	{
		try
		{
			SecureRandom random = SecureEngine.getSecureRandom();
			byte[] bytes = new byte[32];
			random.nextBytes(bytes);
			StringBuilder sb = new StringBuilder(bytes.length * 2);
			for (byte b : bytes)
				sb.append(String.format("%02x", b));
			return sb.toString();
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
	}

	/** SHA-256 (64 hex chars) of the verified token */
	private String hashToken(String token)
	{
		return SecureEngine.getSHA256Digest(token);
	}
}
