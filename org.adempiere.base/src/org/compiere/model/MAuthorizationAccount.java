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
package org.compiere.model;

import java.io.IOException;
import java.math.BigDecimal;
import java.security.GeneralSecurityException;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.SecureEngine;

import com.google.api.client.googleapis.auth.oauth2.GoogleRefreshTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

/**
 * Authorization Account
 */
public class MAuthorizationAccount extends X_AD_AuthorizationAccount {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1857286033575224828L;

	/**
	 * Create empty Authorization Account
	 * 
	 * @param ctx              context
	 * @param AD_AuthorizationAccount_ID ID
	 * @param trxName          transaction
	 */
	public MAuthorizationAccount(Properties ctx, int AD_AuthorizationAccount_ID, String trxName) {
		super(ctx, AD_AuthorizationAccount_ID, trxName);
	} // MAuthorizationAccount

	/**
	 * Create Authorization Account from current row in ResultSet
	 * 
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MAuthorizationAccount(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MAuthorizationAccount

	/**
	 * Try to find a refresh token from another account with same email in the same credential
	 * @return
	 */
	public String findRefreshToken() {
		final String where = "AD_AuthorizationCredential_ID=? "
				+ "AND EMail=? "
				+ "AND AD_AuthorizationAccount_ID!=? "
				+ "AND IsAuthorized='Y' "
				+ "AND AccessToken IS NOT NULL "
				+ "AND RefreshToken IS NOT NULL";
		MAuthorizationAccount other = new Query(Env.getCtx(), Table_Name, where, get_TrxName())
				.setOnlyActiveRecords(true)
				.setParameters(getAD_AuthorizationCredential_ID(), getEMail(), getAD_AuthorizationAccount_ID())
				.first();
		return other != null ? other.getRefreshToken() : null;
	}

	/**
	 * Synchronize information on other accounts with same email in the same credential
	 */
	public void syncOthers() {
		final String script = "UPDATE AD_AuthorizationAccount "
				+ "SET AccessToken=?, AccessTokenTimestamp=?, ExpireInSeconds=? "
				+ "WHERE AD_AuthorizationAccount_ID!=? "
				+ "AND EMail=? "
				+ "AND AD_AuthorizationCredential_ID=? "
				+ "AND IsAuthorized='Y' "
				+ "AND RefreshToken IS NOT NULL";
		String accessToken = getAccessToken();
		accessToken = SecureEngine.encrypt(accessToken, getAD_Client_ID());
		DB.executeUpdateEx(script.toString(), new Object[] {
				accessToken, 
				getAccessTokenTimestamp(), 
				getExpireInSeconds(),
				getAD_AuthorizationAccount_ID(),
				getEMail(), 
				getAD_AuthorizationCredential_ID()
		},
				get_TrxName());
	}

	/**
	 * Refresh access token ( if has expire )
	 * @throws GeneralSecurityException
	 * @throws IOException
	 */
	public synchronized void refresh() throws GeneralSecurityException, IOException {
		Timestamp ts = getAccessTokenTimestamp();
		long seconds = getExpireInSeconds().longValue();
		long expire = ts.getTime() + (seconds * 1000);
		if (System.currentTimeMillis() >= expire) {
			ts = new Timestamp(System.currentTimeMillis());
			I_AD_AuthorizationCredential credential = getAD_AuthorizationCredential();
			GoogleRefreshTokenRequest request = new GoogleRefreshTokenRequest(GoogleNetHttpTransport.newTrustedTransport(), 
					GsonFactory.getDefaultInstance(), getRefreshToken(), credential.getAuthorizationClientId(), 
					credential.getAuthorizationClientSecret());
			GoogleTokenResponse response = request.execute();
			setAccessToken(response.getAccessToken());
			setAccessTokenTimestamp(ts);
			setExpireInSeconds(new BigDecimal(response.getExpiresInSeconds()));
			saveEx();
		}
	}

	/**
	 * Get a valid account from this email
	 * @param email
	 * @return
	 */
	public static MAuthorizationAccount getEMailAccount(String email) {
		String where = "EMail=? AND AD_AuthorizationScope=? AND AD_Client_ID IN (0,?) AND IsAccessRevoked='N' AND IsAuthorized='Y'";
		MAuthorizationAccount account = new Query(Env.getCtx(), Table_Name, where, null)
				.setOnlyActiveRecords(true)
				.setParameters(email, AD_AUTHORIZATIONSCOPE_EMail, Env.getAD_Client_ID(Env.getCtx()))
				.setOrderBy("AD_Client_ID DESC, Updated DESC")
				.first();
		return account;
	}

} // MAuthorizationAccount
