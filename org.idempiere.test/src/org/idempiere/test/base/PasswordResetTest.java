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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.lang.reflect.Method;
import java.sql.Timestamp;

import org.adempiere.base.Core;
import org.adempiere.base.DefaultPasswordResetService;
import org.adempiere.base.IPasswordResetService;
import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MPasswordResetToken;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.Query;
import org.compiere.model.X_AD_PasswordResetToken;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Tests for the code-based password reset feature (IDEMPIERE-7060).
 * <p>
 * Scope is limited to logic that is either pure, participates in the test transaction (so it
 * rolls back), or is a read-only guard. The service happy paths
 * ({@code requestReset}/{@code verifyCode}/{@code completeReset}) manage their own transactions,
 * commit, and (for {@code requestReset}) send SMTP mail, so they are intentionally not covered here.
 *
 * @author d-ruiz - IDEMPIERE-7060
 */
public class PasswordResetTest extends AbstractTestCase
{
	public PasswordResetTest()
	{
	}

	/**
	 * {@link MPasswordResetToken} expiry/attempt helpers (pure, no persistence).
	 */
	@Test
	public void testTokenHelpers()
	{
		MPasswordResetToken token = new MPasswordResetToken(Env.getCtx(), 0, getTrxName());

		// code expiry
		assertTrue(token.isCodeExpired(), "null expiration should count as expired");
		token.setExpiration(new Timestamp(System.currentTimeMillis() - 1000L));
		assertTrue(token.isCodeExpired(), "past expiration should be expired");
		token.setExpiration(new Timestamp(System.currentTimeMillis() + 60000L));
		assertFalse(token.isCodeExpired(), "future expiration should not be expired");

		// verified-token expiry
		assertTrue(token.isVerifiedTokenExpired(), "no verified token yet -> expired");
		token.setVerifiedTokenExpires(new Timestamp(System.currentTimeMillis() + 60000L));
		assertFalse(token.isVerifiedTokenExpired(), "future verified expiration should not be expired");

		// attempts counter
		assertEquals(0, token.getAttemptsUsed());
		assertEquals(1, token.incrementAttempts(), "first increment returns 1");
		assertEquals(1, token.getAttemptsUsed(), "counter field is updated");
		assertEquals(2, token.incrementAttempts(), "second increment returns 2");
	}

	/**
	 * {@link MSession#invalidateSessionsForUser(int, String)} marks the user's active sessions
	 * processed. Runs on the test transaction so all writes roll back.
	 */
	@Test
	public void testInvalidateSessionsForUser()
	{
		int userId = getAD_User_ID();

		MSession session = new MSession(Env.getCtx(), getTrxName());
		session.saveEx();
		int sessionId = session.getAD_Session_ID();
		assertTrue(sessionId > 0, "session should be created");
		assertFalse(session.isProcessed(), "a new session should be active");

		int no = MSession.invalidateSessionsForUser(userId, getTrxName());
		assertTrue(no >= 1, "should invalidate at least the session we created");

		MSession reloaded = new MSession(Env.getCtx(), sessionId, getTrxName());
		assertEquals(sessionId, reloaded.getAD_Session_ID(), "session should reload");
		assertTrue(reloaded.isProcessed(), "session should now be marked processed");

		// guard: a non-positive user id is a no-op
		assertEquals(0, MSession.invalidateSessionsForUser(0, getTrxName()));
		assertEquals(0, MSession.invalidateSessionsForUser(-1, getTrxName()));
	}

	/**
	 * Read-only guard paths of the reset service (no writes / no SMTP).
	 */
	@Test
	public void testServiceGuards()
	{
		IPasswordResetService service = Core.getPasswordResetService();
		assertNotNull(service, "IPasswordResetService should be registered");

		String unknownEmail = "no-such-" + System.nanoTime() + "@example.com";

		// unknown email -> neutral no-op: no exception and no token row created
		service.requestReset(unknownEmail, getAD_Client_ID(), "en_US");
		int tokens = new Query(Env.getCtx(), MPasswordResetToken.Table_Name, "EMail=?", null)
				.setParameters(unknownEmail)
				.count();
		assertEquals(0, tokens, "no token should be created for an unknown email");

		// verifying a code when there is no pending token must fail
		assertThrows(AdempiereException.class,
				() -> service.verifyCode(unknownEmail, "000000"),
				"verifyCode without a pending token should throw");

		// completing with a bogus verified token must fail
		assertThrows(AdempiereException.class,
				() -> service.completeReset("deadbeef-not-a-real-token", "Str0ng#Pass1"),
				"completeReset with an invalid token should throw");
	}

	/**
	 * Happy path for {@link IPasswordResetService#verifyCode(String, String)}: a wrong code
	 * increments the attempt counter, the correct code mints a verified token and flips the token
	 * to {@code Verified}.
	 * <p>
	 * The service auto-commits, so the token is created committed and removed in {@code finally}.
	 */
	@Test
	public void testVerifyCodeHappyPath()
	{
		String email = "pwreset-verify-" + System.nanoTime() + "@example.com";
		String code = "123456";
		try
		{
			MPasswordResetToken token = new MPasswordResetToken(Env.getCtx(), 0, null);
			token.setEMail(email);
			token.setOneTimeCode(code);
			token.setTokenStatus(X_AD_PasswordResetToken.TOKENSTATUS_Pending);
			token.setAttemptsUsed(0);
			token.setExpiration(new Timestamp(System.currentTimeMillis() + 600000L));
			token.saveEx();
			int tokenId = token.getAD_PasswordResetToken_ID();

			IPasswordResetService service = Core.getPasswordResetService();
			assertNotNull(service, "IPasswordResetService should be registered");

			// wrong code -> throws, attempt counted, token still pending
			assertThrows(AdempiereException.class, () -> service.verifyCode(email, "999999"),
					"a wrong code should be rejected");
			MPasswordResetToken afterWrong = new MPasswordResetToken(Env.getCtx(), tokenId, null);
			assertEquals(1, afterWrong.getAttemptsUsed(), "wrong attempt should be counted");
			assertEquals(X_AD_PasswordResetToken.TOKENSTATUS_Pending, afterWrong.getTokenStatus());

			// correct code -> verified token returned, token flipped to Verified
			String verified = service.verifyCode(email, code);
			assertFalse(Util.isEmpty(verified, true), "verifyCode should return a verified token");

			MPasswordResetToken afterOk = new MPasswordResetToken(Env.getCtx(), tokenId, null);
			assertEquals(X_AD_PasswordResetToken.TOKENSTATUS_Verified, afterOk.getTokenStatus());
			assertFalse(Util.isEmpty(afterOk.getVerifiedTokenHash(), true), "verified token hash should be stored");
		}
		finally
		{
			DB.executeUpdateEx("DELETE FROM AD_PasswordResetToken WHERE EMail=?", new Object[]{email}, null);
		}
	}

	/**
	 * Issuing a new code expires any earlier pending code for the same email
	 * ({@link MPasswordResetToken#expirePendingForEMail(String, String)}, the seam
	 * {@code requestReset} uses). Runs on the test transaction so all writes roll back;
	 * the SMTP-bound {@code requestReset} full path is intentionally not exercised here.
	 */
	@Test
	public void testRequestResetExpiresPriorPending()
	{
		String email = "pwreset-expire-" + System.nanoTime() + "@example.com";

		int id1 = newPendingToken(email);
		int id2 = newPendingToken(email);
		assertEquals(X_AD_PasswordResetToken.TOKENSTATUS_Pending,
				new MPasswordResetToken(Env.getCtx(), id1, getTrxName()).getTokenStatus(),
				"token should start pending");

		int expired = MPasswordResetToken.expirePendingForEMail(email, getTrxName());
		assertEquals(2, expired, "both prior pending tokens should be expired");

		assertEquals(X_AD_PasswordResetToken.TOKENSTATUS_Expired,
				new MPasswordResetToken(Env.getCtx(), id1, getTrxName()).getTokenStatus());
		assertEquals(X_AD_PasswordResetToken.TOKENSTATUS_Expired,
				new MPasswordResetToken(Env.getCtx(), id2, getTrxName()).getTokenStatus());
	}

	/**
	 * The reset code length is driven by the {@link MSysConfig#PASSWORD_RESET_CODE_LENGTH}
	 * system configuration (default 6, floor 4). Drives the private {@code generateCode()} directly
	 * via reflection while stubbing the SysConfig read, so no DB write / SMTP / transaction is involved.
	 */
	@Test
	public void testGenerateCodeLength() throws Exception
	{
		Method m = DefaultPasswordResetService.class.getDeclaredMethod("generateCode");
		m.setAccessible(true);
		DefaultPasswordResetService svc = new DefaultPasswordResetService();

		// default 6: length is exactly 6 and the code is all digits (checked over many draws)
		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS))
		{
			mocked.when(() -> MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_CODE_LENGTH, 6)).thenReturn(6);
			for (int i = 0; i < 20; i++)
			{
				String code = (String) m.invoke(svc);
				assertEquals(6, code.length(), "default length should be 6");
				assertTrue(code.matches("\\d+"), "code should be all digits: " + code);
			}
		}

		// configurator lengthens the code
		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS))
		{
			mocked.when(() -> MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_CODE_LENGTH, 6)).thenReturn(8);
			String code = (String) m.invoke(svc);
			assertEquals(8, code.length(), "configured length 8 should produce an 8-digit code");
			assertTrue(code.matches("\\d+"), "code should be all digits: " + code);
		}

		// a length below the floor clamps to 4
		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS))
		{
			mocked.when(() -> MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_CODE_LENGTH, 6)).thenReturn(2);
			String code = (String) m.invoke(svc);
			assertEquals(4, code.length(), "length below 4 should clamp to 4");
		}
	}

	/**
	 * Anti-enumeration: an UNKNOWN email must lock out exactly like a registered one at the verify
	 * step (invalid code -> ... -> too many attempts) instead of always reporting "invalid code",
	 * which would let a bot tell registered from unregistered addresses. Driven directly against the
	 * service; unknown emails create no token and send no mail.
	 */
	@Test
	public void testUnknownEmailVerifyLocksLikeRealEmail()
	{
		IPasswordResetService service = Core.getPasswordResetService();
		assertNotNull(service, "IPasswordResetService should be registered");

		String email = "pwreset-decoy-verify-" + System.nanoTime() + "@example.com";
		String invalid = Msg.getMsg(Env.getCtx(), "PasswordResetInvalidCode");
		String exceeded = Msg.getMsg(Env.getCtx(), "PasswordResetAttemptsExceeded");

		int max = 3;
		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS))
		{
			mocked.when(() -> MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_MAX_ATTEMPTS, 5)).thenReturn(max);

			// attempts 1..max-1 -> "invalid code"
			for (int i = 1; i < max; i++)
			{
				AdempiereException ex = assertThrows(AdempiereException.class,
						() -> service.verifyCode(email, "000000"));
				assertEquals(invalid, ex.getMessage(), "attempt " + i + " should report invalid code");
			}
			// attempt == max -> "too many attempts" (mirrors the real token flipping to Expired)
			AdempiereException locked = assertThrows(AdempiereException.class,
					() -> service.verifyCode(email, "000000"));
			assertEquals(exceeded, locked.getMessage(), "attempt at max should report too many attempts");
			// the decoy counter now resets, so the same email cycles invalid*(max-1) -> exceeded again,
			// exactly like a registered email whose token expires and re-enters the decoy path. If it
			// did not cycle, "too many attempts" would recur only for registered emails (enumeration).
			for (int i = max + 1; i < 2 * max; i++)
			{
				AdempiereException ex = assertThrows(AdempiereException.class,
						() -> service.verifyCode(email, "000000"));
				assertEquals(invalid, ex.getMessage(), "attempt " + i + " should report invalid code");
			}
			// attempt == 2*max -> "too many attempts" again (the cycle repeats)
			AdempiereException lockedAgain = assertThrows(AdempiereException.class,
					() -> service.verifyCode(email, "000000"));
			assertEquals(exceeded, lockedAgain.getMessage(),
					"attempt at 2*max should report too many attempts again (cycle)");
		}
	}

	/**
	 * Anti-enumeration: an UNKNOWN email must be able to hit the request rate limit
	 * ({@code PasswordResetTooManyRequests}) just like a registered one, instead of always returning
	 * neutrally. Still must not create a token row or send mail.
	 */
	@Test
	public void testUnknownEmailRequestCanRateLimit()
	{
		IPasswordResetService service = Core.getPasswordResetService();
		assertNotNull(service, "IPasswordResetService should be registered");

		String email = "pwreset-decoy-req-" + System.nanoTime() + "@example.com";
		int clientId = getAD_Client_ID();

		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS))
		{
			mocked.when(() -> MSysConfig.getIntValue(MSysConfig.PASSWORD_RESET_REQUEST_COOLDOWN_SECONDS, 60, clientId))
					.thenReturn(60);

			// first request for an unknown email -> neutral (no throw)
			service.requestReset(email, clientId, "en_US");
			// second request within the cooldown -> rate-limited, exactly like a registered email
			assertThrows(AdempiereException.class,
					() -> service.requestReset(email, clientId, "en_US"),
					"a second rapid request for an unknown email should be rate-limited");
		}

		// no token row was ever created for the unknown email (no table bloat)
		int tokens = new Query(Env.getCtx(), MPasswordResetToken.Table_Name, "EMail=?", null)
				.setParameters(email)
				.count();
		assertEquals(0, tokens, "no token should be created for an unknown email");
	}

	/**
	 * Create a pending token on the test transaction (rolled back after the test) and return its id.
	 */
	private int newPendingToken(String email)
	{
		MPasswordResetToken token = new MPasswordResetToken(Env.getCtx(), 0, getTrxName());
		token.setEMail(email);
		token.setOneTimeCode("000000");
		token.setTokenStatus(X_AD_PasswordResetToken.TOKENSTATUS_Pending);
		token.setAttemptsUsed(0);
		token.setExpiration(new Timestamp(System.currentTimeMillis() + 600000L));
		token.saveEx();
		return token.getAD_PasswordResetToken_ID();
	}
}
