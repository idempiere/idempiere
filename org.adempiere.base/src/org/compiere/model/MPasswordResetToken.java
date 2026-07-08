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
package org.compiere.model;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Util;

/**
 * Password reset token model.
 * <p>
 * Persists a single password-reset request: the emailed 6-digit code (hashed) and,
 * after the code is verified, the short-lived verified token (hashed) that authorizes
 * setting a new password. Auto-registered with the model factory as the leaf subclass
 * of the {@code @Model}-annotated {@link X_AD_PasswordResetToken}.
 *
 * @author d-ruiz - IDEMPIERE-7060
 */
public class MPasswordResetToken extends X_AD_PasswordResetToken
{
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 20260707L;

	public MPasswordResetToken(Properties ctx, int AD_PasswordResetToken_ID, String trxName)
	{
		super(ctx, AD_PasswordResetToken_ID, trxName);
	}

	public MPasswordResetToken(Properties ctx, int AD_PasswordResetToken_ID, String trxName, String... virtualColumns)
	{
		super(ctx, AD_PasswordResetToken_ID, trxName, virtualColumns);
	}

	public MPasswordResetToken(Properties ctx, String AD_PasswordResetToken_UU, String trxName)
	{
		super(ctx, AD_PasswordResetToken_UU, trxName);
	}

	public MPasswordResetToken(Properties ctx, String AD_PasswordResetToken_UU, String trxName, String... virtualColumns)
	{
		super(ctx, AD_PasswordResetToken_UU, trxName, virtualColumns);
	}

	public MPasswordResetToken(Properties ctx, ResultSet rs, String trxName)
	{
		super(ctx, rs, trxName);
	}

	/**
	 * Expire every still-pending reset token for the given email. Issuing a new code
	 * calls this so only the most recently emailed code remains verifiable.
	 * @param email token email
	 * @param trxName transaction
	 * @return number of tokens expired
	 */
	public static int expirePendingForEMail(String email, String trxName)
	{
		if (Util.isEmpty(email, true))
			return 0;
		return DB.executeUpdateEx(
				"UPDATE " + Table_Name + " SET " + COLUMNNAME_TokenStatus + "=?"
						+ " WHERE " + COLUMNNAME_EMail + "=? AND " + COLUMNNAME_TokenStatus + "=?",
				new Object[]{TOKENSTATUS_Expired, email.trim(), TOKENSTATUS_Pending}, trxName);
	}

	/**
	 * @return true if the reset code has expired (or no expiration set)
	 */
	public boolean isCodeExpired()
	{
		Timestamp exp = getExpiration();
		return exp == null || !exp.after(new Timestamp(System.currentTimeMillis()));
	}

	/**
	 * @return true if the verified token has expired (or none/not yet verified)
	 */
	public boolean isVerifiedTokenExpired()
	{
		Timestamp exp = getVerifiedTokenExpires();
		return exp == null || !exp.after(new Timestamp(System.currentTimeMillis()));
	}

	/**
	 * Increment and store the used-attempts counter.
	 * @return the new number of attempts used
	 */
	public int incrementAttempts()
	{
		int used = getAttemptsUsed() + 1;
		setAttemptsUsed(used);
		return used;
	}
}
