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

/**
 * UI-agnostic password reset service (code-based flow).
 * <p>
 * Shared by the ZK WebUI and any other front-end (e.g. a REST plugin). The flow has three
 * steps: request a code (emailed), verify the code (returns a short-lived verified token),
 * and complete the reset (set the new password using the verified token). All password
 * writes go through the standard {@code MUser} path (hashing + {@code AD_Password_History}).
 * <p>
 * Obtain the registered implementation via {@code Core.getPasswordResetService()}.
 *
 * @author d-ruiz - IDEMPIERE-7060
 */
public interface IPasswordResetService
{
	/**
	 * Request a password reset for the given email. Generates a numeric code, persists it
	 * hashed with an expiry, and emails it to the address. Behaves neutrally (no account
	 * enumeration): a non-matching email produces no observable difference. May throw when
	 * the per-identifier request rate limits are exceeded.
	 *
	 * @param email the email address / login identifier
	 * @param AD_Client_ID tenant context used to resolve configuration (may be 0)
	 * @param language AD_Language used for the email template (may be null)
	 */
	public void requestReset(String email, int AD_Client_ID, String language);

	/**
	 * Verify a code previously sent to the email. On success mints and stores a high-entropy
	 * verified token and returns its plaintext value. Throws an {@code AdempiereException}
	 * carrying the appropriate message on invalid/expired code or when attempts are exceeded.
	 *
	 * @param email the email address / login identifier
	 * @param code the code entered by the user
	 * @return the plaintext verified token to pass to {@link #completeReset(String, String)}
	 */
	public String verifyCode(String email, String code);

	/**
	 * Complete the reset: validate the verified token and set the new password for every
	 * active user sharing the identifier (all tenants), then invalidate their existing
	 * sessions. Password policy is enforced by the standard {@code MUser} save path.
	 *
	 * @param verifiedToken the plaintext token returned by {@link #verifyCode(String, String)}
	 * @param newPassword the new password chosen by the user
	 */
	public void completeReset(String verifiedToken, String newPassword);
}
