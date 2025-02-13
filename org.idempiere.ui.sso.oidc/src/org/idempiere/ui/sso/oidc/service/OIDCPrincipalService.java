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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.ui.sso.oidc.service;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.adempiere.base.sso.ISSOPrincipalService;
import org.adempiere.base.sso.SSOUtils;
import org.compiere.model.I_SSO_PrincipalConfig;
import org.compiere.model.MSysConfig;
import org.compiere.util.Language;
import org.compiere.util.Util;

import com.nimbusds.oauth2.sdk.AuthorizationCode;
import com.nimbusds.oauth2.sdk.AuthorizationCodeGrant;
import com.nimbusds.oauth2.sdk.AuthorizationGrant;
import com.nimbusds.oauth2.sdk.GeneralException;
import com.nimbusds.oauth2.sdk.ResponseType;
import com.nimbusds.oauth2.sdk.Scope;
import com.nimbusds.oauth2.sdk.TokenErrorResponse;
import com.nimbusds.oauth2.sdk.TokenRequest;
import com.nimbusds.oauth2.sdk.TokenResponse;
import com.nimbusds.oauth2.sdk.auth.ClientAuthentication;
import com.nimbusds.oauth2.sdk.auth.ClientSecretBasic;
import com.nimbusds.oauth2.sdk.auth.Secret;
import com.nimbusds.oauth2.sdk.http.HTTPResponse;
import com.nimbusds.oauth2.sdk.id.ClientID;
import com.nimbusds.oauth2.sdk.id.Issuer;
import com.nimbusds.oauth2.sdk.id.State;
import com.nimbusds.oauth2.sdk.token.AccessToken;
import com.nimbusds.oauth2.sdk.token.BearerAccessToken;
import com.nimbusds.openid.connect.sdk.AuthenticationErrorResponse;
import com.nimbusds.openid.connect.sdk.AuthenticationRequest;
import com.nimbusds.openid.connect.sdk.AuthenticationResponse;
import com.nimbusds.openid.connect.sdk.AuthenticationResponseParser;
import com.nimbusds.openid.connect.sdk.AuthenticationSuccessResponse;
import com.nimbusds.openid.connect.sdk.Nonce;
import com.nimbusds.openid.connect.sdk.OIDCTokenResponse;
import com.nimbusds.openid.connect.sdk.OIDCTokenResponseParser;
import com.nimbusds.openid.connect.sdk.Prompt;
import com.nimbusds.openid.connect.sdk.UserInfoRequest;
import com.nimbusds.openid.connect.sdk.UserInfoResponse;
import com.nimbusds.openid.connect.sdk.claims.UserInfo;
import com.nimbusds.openid.connect.sdk.op.OIDCProviderMetadata;

/**
 * Implement SSO principal provider service for OIDC
 * @author hengsin
 */
public class OIDCPrincipalService implements ISSOPrincipalService {
	
	/** code parameter from OIDC */
	private static final String AUTHENTICATION_CODE_PARAMETER = "code";
	
	private static final String OIDC_STATE = "oidc.state";
	
	private I_SSO_PrincipalConfig principalConfig;
	
	private OIDCProviderMetadata metaData = null;
	
	/**
	 * Default constructor
	 * @param principleConfig
	 */
	public OIDCPrincipalService(I_SSO_PrincipalConfig principleConfig) {		
		this.principalConfig = principleConfig;				
	}

	@Override
	public String getUserName(Object principalObject) throws ParseException {
		if (principalObject != null && principalObject instanceof UserInfo)
		{
			boolean isEmailLogin = MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false);
			UserInfo userInfo = (UserInfo) principalObject;
			if (isEmailLogin)
				return (String) userInfo.getEmailAddress();
			else
				return (String) userInfo.getName();
		}
		return null;
	}

	@Override
	public Language getLanguage(Object principalObject) throws ParseException {
		return Language.getBaseLanguage();
	}

	@Override
	public boolean hasAuthenticationCode(HttpServletRequest request, HttpServletResponse response) {
		String code = request.getParameter(AUTHENTICATION_CODE_PARAMETER);
		return !Util.isEmpty(code, true);
	}

	@Override
	public void getAuthenticationToken(HttpServletRequest request, HttpServletResponse response, String redirectMode)
			throws Throwable {
		String url = request.getRequestURL().toString();
        String query = request.getQueryString();
        if (query != null) {
            url += "?" + query;
        }
        AuthenticationResponse authResponse = AuthenticationResponseParser.parse(new URI(url));

		// Check the returned state parameter, must match the original
        State state = (State) request.getSession().getAttribute(OIDC_STATE);
        if (state != null && !state.equals(authResponse.getState())) {
        	// Unexpected or tampered response, stop!!!
        	request.getSession().removeAttribute(OIDC_STATE);
        	response.sendRedirect(getRedirectURL(principalConfig, redirectMode));
		    return;
        } else if (state == null) {
        	request.getSession().setAttribute(OIDC_STATE, authResponse.getState());
        }

		if (!authResponse.indicatesSuccess()) {
		    // The request was denied or some error occurred
		    AuthenticationErrorResponse errorResponse = authResponse.toErrorResponse();
		    throw new RuntimeException(errorResponse.toString());
		}

		AuthenticationSuccessResponse successResponse = authResponse.toSuccessResponse();

		// Retrieve the authorization code, to be used later to exchange the code for
		// an access token at the token endpoint of the server
		AuthorizationCode authorizationCode = successResponse.getAuthorizationCode();
		URI redirectURI = new URI(getRedirectURL(principalConfig, redirectMode));
		AuthorizationGrant authorizationGrant = new AuthorizationCodeGrant(authorizationCode, redirectURI);

		TokenResponse tokenResponse = issueTokenRequest(authorizationGrant);

		processTokenResponse(request, tokenResponse, true);
	}

	/**
	 * @param principalConfig
	 * @param clientType SSO_MODE_WEBUI, SSO_MODE_MONITOR or SSO_MODE_OSGI (webui, server monitor, osgi console)
	 * @return redirect url for clientType
	 */
	private String getRedirectURL(I_SSO_PrincipalConfig principalConfig, String clientType) {
		if (SSOUtils.SSO_MODE_WEBUI.equals(clientType))
			return principalConfig.getSSO_ApplicationRedirectURIs();
		else if (SSOUtils.SSO_MODE_MONITOR.equals(clientType))
			return principalConfig.getSSO_IDempMonitorRedirectURIs();
		else if (SSOUtils.SSO_MODE_OSGI.equals(clientType))
			return principalConfig.getSSO_OSGIRedirectURIs();
		else
			return null;
	}
	
	/**
	 * Process token response from keycloak server
	 * @param request
	 * @param tokenResponse
	 * @param getUserInfo true to get UserInfo from userinfo endpoint
	 * @throws URISyntaxException
	 * @throws IOException
	 * @throws GeneralException 
	 */
	private void processTokenResponse(HttpServletRequest request, TokenResponse tokenResponse, boolean getUserInfo)
			throws URISyntaxException, IOException, GeneralException {
		if (!tokenResponse.indicatesSuccess()) {
		    // We got an error response...
		    TokenErrorResponse errorResponse = tokenResponse.toErrorResponse();
		    throw new RuntimeException(errorResponse.toJSONObject().toJSONString());
		}

		OIDCTokenResponse oidcTokenResponse = (OIDCTokenResponse) tokenResponse.toSuccessResponse();

		// Get the access token
		AccessToken accessToken = oidcTokenResponse.getOIDCTokens().getAccessToken();

		if (getUserInfo) {
			String userInfoURL = getMetaData().getUserInfoEndpointURI().toString();
			URI userInfoEndpoint = new URI(userInfoURL);
			BearerAccessToken bearerAccessToken = new BearerAccessToken(accessToken.getValue()); // The access token
	
			// Make the request
			HTTPResponse httpResponse = new UserInfoRequest(userInfoEndpoint, bearerAccessToken)
			    .toHTTPRequest()
			    .send();
	
			// Parse the response
			UserInfoResponse userInfoResponse = UserInfoResponse.parse(httpResponse);
	
			if (!userInfoResponse.indicatesSuccess()) {
			    // The request failed, e.g. due to invalid or expired token
			    throw new RuntimeException(userInfoResponse.toErrorResponse().toString());
			}
	
			// Extract the claims
			UserInfo userInfo = userInfoResponse.toSuccessResponse().getUserInfo();
			setAuthenticationResult(request.getSession(), userInfo);
		}		
	}

	private OIDCProviderMetadata getMetaData() throws GeneralException, IOException {
		if (metaData == null) {
			String discoveryURI = principalConfig.getSSO_ApplicationDiscoveryURI();
			Issuer issuer = new Issuer(discoveryURI.substring(0, discoveryURI.indexOf("/.well-known/openid-configuration")));			
			metaData = OIDCProviderMetadata.resolve(issuer);
		}
		return metaData;
	}

	/**
	 * Send Token request to oidc token endpoint
	 * @param authorizationGrant
	 * @return TokenResponse
	 * @throws URISyntaxException
	 * @throws IOException
	 * @throws GeneralException 
	 */
	private TokenResponse issueTokenRequest(AuthorizationGrant authorizationGrant) throws URISyntaxException, 
		IOException, GeneralException {
		// The credentials to authenticate the client at the token endpoint
		ClientID clientID = new ClientID(principalConfig.getSSO_ApplicationClientID());
		Secret clientSecret = new Secret(principalConfig.getSSO_ApplicationSecretKey());
		ClientAuthentication clientAuth = new ClientSecretBasic(clientID, clientSecret);

		// The token endpoint
		String tokenEndpointURL = getMetaData().getTokenEndpointURI().toString();
		URI tokenEndpoint = new URI(tokenEndpointURL);

		// Make the token request
		TokenRequest tokenRequest = new TokenRequest(tokenEndpoint, clientAuth, authorizationGrant);
		
		return OIDCTokenResponseParser.parse(tokenRequest.toHTTPRequest().send());
	}

	/**
	 * Store UserInfo as session token
	 * @param session
	 * @param userInfo
	 */
	private void setAuthenticationResult(HttpSession session, UserInfo userInfo) {
		session.setAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, userInfo);
	}

	@Override
	public boolean isAuthenticated(HttpServletRequest request, HttpServletResponse response) {
		return request.getSession().getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN) != null;
	}

	@Override
	public void redirectForAuthentication(HttpServletRequest request, HttpServletResponse response, String redirectMode)
			throws IOException {		
		AuthenticationRequest authRequest = null;
		try {
			authRequest = new AuthenticationRequest.Builder(
					new ResponseType(AUTHENTICATION_CODE_PARAMETER),		      
					new Scope("openid", "profile", "email"),
					new ClientID(principalConfig.getSSO_ApplicationClientID()),
					new URI(getRedirectURL(principalConfig, redirectMode))) 
			    .state(new State())
			    .nonce(new Nonce())
			    .prompt(new Prompt(Prompt.Type.LOGIN)) 
			    .endpointURI(getMetaData().getAuthorizationEndpointURI())
			    .build();
		} catch (URISyntaxException e) {
			throw new RuntimeException(e);
		} catch (GeneralException e) {
			throw new RuntimeException(e);
		}

		//store state for response verification
		request.getSession().setAttribute(OIDC_STATE, authRequest.getState());
		URI redirectURI = authRequest.toURI(); 
		
		response.sendRedirect(redirectURI.toString());
	}

	@Override
	public void removePrincipalFromSession(HttpServletRequest httpRequest) {
		httpRequest.getSession().removeAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN);
		httpRequest.getSession().removeAttribute(OIDC_STATE);
	}
		
	@Override
	public String getLogoutURL() {
		if (metaData != null) {
			if (metaData.getEndSessionEndpointURI() != null) {
				
				StringBuilder url = new StringBuilder(metaData.getEndSessionEndpointURI().toString());			
				url.append("?response_type=code")
				   .append("&client_id=")
				   .append(principalConfig.getSSO_ApplicationClientID());
				//redirect url: the oidc spec say post_logout_redirect_uri but amazon cognito is using redirect_uri
				if (url.indexOf("amazonaws.com") >= 0 || url.indexOf("amazoncognito.com") >= 0)
				   url.append("&redirect_uri=").append(principalConfig.getSSO_ApplicationRedirectURIs());
				else
				   url.append("&post_logout_redirect_uri=").append(principalConfig.getSSO_ApplicationRedirectURIs());			
				return url.toString();
			} else {
				//For provider that doesn’t support end_session_endpoint (for e.g Google Identity), 
				//We fall back to authorization_endpoint with SELECT_ACCOUNT prompt type
				try {
					AuthenticationRequest authRequest = new AuthenticationRequest.Builder(
							new ResponseType(AUTHENTICATION_CODE_PARAMETER),		      
							new Scope("openid", "profile", "email"),
							new ClientID(principalConfig.getSSO_ApplicationClientID()),
							new URI(getRedirectURL(principalConfig, SSOUtils.SSO_MODE_WEBUI))) 
					    .prompt(new Prompt(Prompt.Type.SELECT_ACCOUNT)) 
					    .endpointURI(metaData.getAuthorizationEndpointURI())
					    .state(new State())
					    .build();
					return authRequest.toURI().toString();
				} catch (URISyntaxException e) {
					e.printStackTrace();
				}
			}
		}
		
		return null;
	}
}
