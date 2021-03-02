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

import com.google.api.client.auth.oauth2.AuthorizationCodeTokenRequest;
import com.google.api.client.auth.oauth2.ClientParametersAuthentication;
import com.google.api.client.auth.oauth2.TokenResponse;
import com.google.api.client.auth.openidconnect.IdToken;
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
	private static final long serialVersionUID = 1469616595459196518L;

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
	 * @return String message indicating success
	 * @throws IOException
	 * @throws GeneralSecurityException
	 */
	public String processToken(String code) throws IOException, GeneralSecurityException {
		String msg = null;
		String clientId = getAuthorizationClientId();
		String clientSecret = getAuthorizationClientSecret();
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		MAuthorizationProvider ap = new MAuthorizationProvider(getCtx(), getAD_AuthorizationProvider_ID(), get_TrxName());
		AuthorizationCodeTokenRequest request = new AuthorizationCodeTokenRequest(new NetHttpTransport(), 
				GsonFactory.getDefaultInstance(),
				new GenericUrl(ap.getTokenEndpoint()), code);
		request.setRedirectUri(getAuthorizationRedirectURL());
		request.setClientAuthentication(new ClientParametersAuthentication(clientId, clientSecret));
		TokenResponse tokenResponse = request.execute();
		Object id_token = tokenResponse.get("id_token");
		String email = null;
		if (id_token != null && id_token instanceof String) {
			IdToken idtoken = IdToken.parse(tokenResponse.getFactory(), (String) tokenResponse.get("id_token"));
			email = (String) idtoken.getPayload().get("email");
		}
		if (email == null) {
			throw new AdempiereException("Could not get the email from the response");
		}

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
			MAuthorizationProvider provider = new MAuthorizationProvider(getCtx(), getAD_AuthorizationProvider_ID(), get_TrxName());
			String revokeEndPoint = provider.getRevokeEndpoint();
			if (revokeEndPoint != null) {
				HttpRequestFactory factory = new NetHttpTransport().createRequestFactory();
				GenericUrl url = new GenericUrl(revokeEndPoint + "?token="+account.getAccessToken());
				HttpRequest revokeRequest = factory.buildGetRequest(url);
				revokeRequest.execute();
			}
			throw new AdempiereException("No refresh token.  Request Failed. Please try again");
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
	 * Get a complete Authorization end point URL with all the parameters required
	 * @param scope
	 * @param state 
	 * @return
	 */
	public String getFullAuthorizationEndpoint(String scope, String state) {
		String scopeUrl = findScopeUrl(scope);
		if (scopeUrl == null)
			throw new AdempiereException("Could not find scope " + scope + " for provider " + getAD_AuthorizationProvider_ID());
		MAuthorizationProvider provider = new MAuthorizationProvider(getCtx(), getAD_AuthorizationProvider_ID(), get_TrxName());
		String authEndPoint = provider.getAuthorizationEndpoint();
		StringBuilder url = new StringBuilder(authEndPoint).append("?");
		List<NameValuePair> nameValuePairs = new ArrayList<>();
		nameValuePairs.add(new BasicNameValuePair("scope", scopeUrl));
		nameValuePairs.add(new BasicNameValuePair("redirect_uri", getAuthorizationRedirectURL()));
		nameValuePairs.add(new BasicNameValuePair("access_type", "offline")); // required by google
		nameValuePairs.add(new BasicNameValuePair("response_type", "code"));
		nameValuePairs.add(new BasicNameValuePair("client_id", getAuthorizationClientId()));
		nameValuePairs.add(new BasicNameValuePair("state", state));
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

} // MAuthorizationCredential
