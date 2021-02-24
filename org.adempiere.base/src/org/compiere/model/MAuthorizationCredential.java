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
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.message.BasicNameValuePair;
import org.compiere.util.Env;
import org.compiere.util.Msg;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestFactory;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

/**
 * Authorization Credential
 */
public class MAuthorizationCredential extends X_AD_AuthorizationCredential {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8807239748093615430L;

	/**
	 * Create empty Authorization Credential
	 * 
	 * @param ctx              context
	 * @param AD_AuthorizationCredential_ID ID
	 * @param trxName          transaction
	 */
	public MAuthorizationCredential(Properties ctx, int AD_AuthorizationCredential_ID, String trxName) {
		super(ctx, AD_AuthorizationCredential_ID, trxName);
	} // MAuthorizationCredential

	/**
	 * Create Authorization Credential from current row in ResultSet
	 * 
	 * @param ctx     context
	 * @param rs      ResultSet
	 * @param trxName transaction
	 */
	public MAuthorizationCredential(Properties ctx, ResultSet rs, String trxName) {
		super(ctx, rs, trxName);
	} // MAuthorizationCredential

	/**
	 * Create or Update an Account based on the token received
	 * @param code
	 * @param appUrl
	 * @return
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	public String processToken(String code, String appUrl) throws IOException, GeneralSecurityException {
		String msg = null;
		String clientSecret = getAuthorizationClientSecret();
		String clientId = getAuthorizationClientId();
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		GoogleAuthorizationCodeTokenRequest request = new GoogleAuthorizationCodeTokenRequest(new NetHttpTransport(), 
				GsonFactory.getDefaultInstance(), clientId, clientSecret, code, getAuthorizationRedirectURL_Parsed(appUrl));
		request.setGrantType("authorization_code");
		GoogleTokenResponse tokenResponse = request.execute();
		GoogleIdToken idToken = tokenResponse.parseIdToken();
		GoogleIdToken.Payload payload = idToken.getPayload();
		String email = payload.getEmail();
		
		boolean newAccount = false;
		MAuthorizationAccount account = null;
		Query query = new Query(Env.getCtx(), MAuthorizationAccount.Table_Name, "AD_Client_ID=? AND AD_User_ID=? AND EMail=? AND AD_AuthorizationCredential_ID=?", get_TrxName());
		query.setParameters(Env.getAD_Client_ID(Env.getCtx()), Env.getAD_User_ID(Env.getCtx()), email, getAD_AuthorizationCredential_ID());
		account = query.first();
		if (account == null) {
			account = new MAuthorizationAccount(Env.getCtx(), 0, get_TrxName());
			account.setEMail(email);
			account.setAD_AuthorizationCredential_ID(getAD_AuthorizationCredential_ID());
			account.setAD_User_ID(Env.getAD_User_ID(Env.getCtx()));
			newAccount = true;
		}
		
		if (tokenResponse.getRefreshToken() == null && account.getRefreshToken() == null) {
			String refreshToken = account.findRefreshToken();
			if (refreshToken != null) {
				account.setRefreshToken(refreshToken);
			}
		}
		
		if (tokenResponse.getRefreshToken() == null && account.getRefreshToken() == null) {
			//revoke access and ask for retry
			HttpRequestFactory factory = GoogleNetHttpTransport.newTrustedTransport().createRequestFactory();
			MAuthorizationProvider provider = new MAuthorizationProvider(getCtx(), getAD_AuthorizationProvider_ID(), get_TrxName());
			String revokeEndPoint = provider.getRevokeEndpoint();
			GenericUrl url = new GenericUrl(revokeEndPoint + "?token="+account.getAccessToken());
			HttpRequest revokeRequest = factory.buildGetRequest(url);
			revokeRequest.execute();
			throw new AdempiereException("Request Failed. Please try again");
		}
		
		account.setAccessToken(tokenResponse.getAccessToken());
		account.setAccessTokenTimestamp(ts);
		account.setExpireInSeconds(BigDecimal.valueOf(tokenResponse.getExpiresInSeconds()));
		account.setAD_AuthorizationScope(MAuthorizationAccount.AD_AUTHORIZATIONSCOPE_EMail);
		account.setIsAuthorized(true);
		account.setIsActive(true);
		if (tokenResponse.getRefreshToken() != null) {				
			account.setRefreshToken(tokenResponse.getRefreshToken());																
		}
		account.saveEx();
		account.syncOthers();

		if (newAccount)
			msg = Msg.getMsg(getCtx(), "Authorization_Access_OK", new Object[] {account.getEMail()});
		else
			msg = Msg.getMsg(getCtx(), "Authorization_Access_Previous", new Object[] {account.getEMail()});
		return msg;
	}

	/**
	 * get the AuthorizationRedirectURL replacing the @SERVER@ placeholder with the appUrl received
	 * @param appUrl
	 * @return
	 */
	public String getAuthorizationRedirectURL_Parsed(String appUrl) {
		String url = getAuthorizationRedirectURL();
		if (url.contains("@SERVER@")) {
			String serverUrl = appUrl.replaceAll("/webui/index.zul", "");
			url = url.replaceAll("@SERVER@", serverUrl);
		}
		return url;
	}

	/**
	 * Get a complete Authorization Endpoint URL with all the parameters required
	 * @param appUrl
	 * @param scope
	 * @return
	 */
	public String getAuthorizationRedirectURL_Full(String appUrl, String scope) {
		String scopeUrl = findScopeUrl(scope);
		if (scopeUrl == null)
			throw new AdempiereException("Could not find scope " + scope + " for provider " + getAD_AuthorizationProvider_ID());
		MAuthorizationProvider provider = new MAuthorizationProvider(getCtx(), getAD_AuthorizationProvider_ID(), get_TrxName());
		String authEndPoint = provider.getAuthorizationEndpoint();
		StringBuilder url = new StringBuilder(authEndPoint).append("?");
		List<NameValuePair> nameValuePairs = new ArrayList<>();
		nameValuePairs.add(new BasicNameValuePair("scope", scopeUrl));
		nameValuePairs.add(new BasicNameValuePair("redirect_uri", getAuthorizationRedirectURL_Parsed(appUrl)));
		nameValuePairs.add(new BasicNameValuePair("access_type", "offline"));
		nameValuePairs.add(new BasicNameValuePair("response_type", "code"));
		nameValuePairs.add(new BasicNameValuePair("client_id", getAuthorizationClientId()));
		url.append(URLEncodedUtils.format(nameValuePairs, "UTF-8"));
		return url.toString();
	}

	/**
	 * Get the scope URL for the authorization provider
	 * @param scope
	 * @return
	 */
	private String findScopeUrl(String scope) {
		String scopeUrl = null;
		MAuthorizationScopeProv scpr = new Query(Env.getCtx(), MAuthorizationScopeProv.Table_Name, "AD_AuthorizationProvider_ID=? AND AD_AuthorizationScope=?", get_TrxName())
				.setOnlyActiveRecords(true)
				.setParameters(getAD_AuthorizationProvider_ID(), scope)
				.first();
		if (scpr != null)
			scopeUrl = scpr.getScopeURL();
		return scopeUrl;
	}

	/**
	 * Get credentials for a scope type
	 * @return
	 */
	public static List<MAuthorizationCredential> getCredentialsOfScope(String scope) {
		int clientId = Env.getAD_Client_ID(Env.getCtx());
		final String where =
				  "AD_AuthorizationCredential.AD_Client_ID IN (0,?) AND "
				+ "AD_AuthorizationCredential.IsActive='Y' AND "
				+ "AD_AuthorizationCredential.AD_AuthorizationScopeList LIKE '%'||?||'%' AND "
				+ "EXISTS ( "
				+ "  SELECT 1 "
				+ "  FROM AD_AuthorizationScopeProv asp "
				+ "    JOIN AD_AuthorizationProvider ap ON (asp.AD_AuthorizationProvider_ID=ap.AD_AuthorizationProvider_ID  "
				+ "      AND ap.IsActive='Y'  "
				+ "      AND ap.AD_Client_ID IN (0,?)) "
				+ "  WHERE asp.AD_AuthorizationProvider_ID=AD_AuthorizationCredential.AD_AuthorizationProvider_ID "
				+ "    AND asp.AD_AuthorizationScope=? "
				+ "    AND asp.IsActive='Y' "
				+ "    AND asp.AD_Client_ID IN (0,?))";
		List<MAuthorizationCredential> credentialList = new Query(Env.getCtx(), MAuthorizationCredential.Table_Name, where, null)
				.setParameters(clientId, scope, clientId, scope, clientId)
				.list();
		return credentialList;
	}

} // MAuthorizationCredential
