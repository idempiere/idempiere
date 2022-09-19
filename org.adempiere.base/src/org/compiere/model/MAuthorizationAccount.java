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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.adempiere.base.Core;
import org.adempiere.base.upload.IUploadService;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.SecureEngine;

import com.google.api.client.auth.oauth2.ClientParametersAuthentication;
import com.google.api.client.auth.oauth2.RefreshTokenRequest;
import com.google.api.client.auth.oauth2.TokenResponse;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

/**
 * Authorization Account
 */
public class MAuthorizationAccount extends X_AD_AuthorizationAccount {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6808970904951033494L;

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
		final String clientSql =
				"SELECT DISTINCT AD_Client_ID "
				+ "FROM AD_AuthorizationAccount "
				+ "WHERE AD_AuthorizationAccount_ID!=? "
				+ "AND EMail=? "
				+ "AND AD_AuthorizationCredential_ID=? "
				+ "AND IsAuthorized='Y' "
				+ "AND RefreshToken IS NOT NULL";
		int[] clientIds = DB.getIDsEx(get_TrxName(), clientSql,
				getAD_AuthorizationAccount_ID(),
				getEMail(),
				getAD_AuthorizationCredential_ID());
		if (clientIds.length > 0) {
			final String script = "UPDATE AD_AuthorizationAccount "
					+ "SET AccessToken=?, AccessTokenTimestamp=?, ExpireInSeconds=? "
					+ "WHERE AD_AuthorizationAccount_ID!=? "
					+ "AND EMail=? "
					+ "AND AD_AuthorizationCredential_ID=? "
					+ "AND IsAuthorized='Y' "
					+ "AND RefreshToken IS NOT NULL "
					+ "AND AD_Client_ID=?";
			MColumn column = MColumn.get(getCtx(), Table_Name, COLUMNNAME_AccessToken);
			for (int clientId : clientIds) {
				String accessToken = getAccessToken();
				if (column.isEncrypted())
					accessToken = SecureEngine.encrypt(accessToken, clientId);
				DB.executeUpdateEx(script.toString(), new Object[] {
							accessToken,
							getAccessTokenTimestamp(),
							getExpireInSeconds(),
							getAD_AuthorizationAccount_ID(),
							getEMail(),
							getAD_AuthorizationCredential_ID(),
							clientId
						},
						get_TrxName());
			}
		}
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
			MAuthorizationCredential credential = new MAuthorizationCredential(getCtx(), getAD_AuthorizationCredential_ID(), get_TrxName());
			MAuthorizationProvider provider = new MAuthorizationProvider(getCtx(), credential.getAD_AuthorizationProvider_ID(), get_TrxName());
			GenericUrl url = new GenericUrl(provider.getTokenEndpoint());
			RefreshTokenRequest request = new RefreshTokenRequest(new NetHttpTransport(),
					GsonFactory.getDefaultInstance(),
					url,
					getRefreshToken());
			String clientId = credential.getAuthorizationClientId();
			String clientSecret = credential.getAuthorizationClientSecret();
			request.setClientAuthentication(new ClientParametersAuthentication(clientId, clientSecret));
			TokenResponse response = request.execute();
			if (response.getRefreshToken() != null) {
				// OAuth2 Spec -> The authorization server MAY issue a new refresh token, in which case
				//   the client MUST discard the old refresh token and replace it with the
				//   new refresh token
				setRefreshToken(response.getRefreshToken());
			}
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
		String where = "EMail=? AND IsIntersectCSV(AD_AuthorizationScopes,"+DB.TO_STRING(AD_AUTHORIZATIONSCOPES_EMail)+")='Y' AND AD_Client_ID IN (0,?) AND IsAccessRevoked='N' AND IsAuthorized='Y'";
		MAuthorizationAccount account = new Query(Env.getCtx(), Table_Name, where, null)
				.setOnlyActiveRecords(true)
				.setParameters(email, Env.getAD_Client_ID(Env.getCtx()))
				.setOrderBy("AD_Client_ID DESC, Updated DESC")
				.first();
		return account;
	}

	/**
	 * 
	 * @param AD_User_ID
	 * @param scopes
	 * @return list of {@link MAuthorizationAccount}
	 */
	public static List<MAuthorizationAccount> getAuthorizedAccouts(int AD_User_ID, String scopes) {
		String where = "AD_User_ID=? AND IsIntersectCSV(AD_AuthorizationScopes,"+DB.TO_STRING(scopes)+")='Y' AND AD_Client_ID IN (0,?) AND IsAccessRevoked='N' AND IsAuthorized='Y'";
		List<MAuthorizationAccount> accounts = new Query(Env.getCtx(), Table_Name, where, null)
				.setOnlyActiveRecords(true)
				.setParameters(AD_User_ID, Env.getAD_Client_ID(Env.getCtx()))
				.setOrderBy("AD_Client_ID DESC, Updated DESC")
				.list();
		return accounts;
	}
	
	/**
	 * Get an authorization token - refresh it if expired
	 * @return AuthorizationToken
	 * @throws GeneralSecurityException
	 * @throws IOException
	 */
	public String refreshAndGetAccessToken() throws GeneralSecurityException, IOException {
		refresh();
		return getAccessToken();
	}
	
	/**
	 * 
	 * @return map of {@link MAuthorizationAccount} and {@link IUploadService}
	 */
	public static Map<MAuthorizationAccount, IUploadService> getUserUploadServices() {
		Map<MAuthorizationAccount, IUploadService> uploadServicesMap = new HashMap<>();
		List<MAuthorizationAccount> accounts = MAuthorizationAccount.getAuthorizedAccouts(Env.getAD_User_ID(Env.getCtx()), MAuthorizationAccount.AD_AUTHORIZATIONSCOPES_Document);
		for (MAuthorizationAccount account : accounts) {
			IUploadService service = Core.getUploadService(account);
			if (service != null) {
				uploadServicesMap.put(account, service);
			}
		}
		return uploadServicesMap;
	}

} // MAuthorizationAccount
