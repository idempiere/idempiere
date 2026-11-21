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
 * - hengsin                                                           *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.FilterChain;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.adempiere.base.sso.ISSOPrincipalService;
import org.adempiere.base.sso.SSOUtils;
import org.adempiere.webui.sso.filter.SSOWebUIFilter;
import org.compiere.model.MClient;
import org.compiere.model.MSSOPrincipalConfig;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Login;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Security tests for SSO token provider/tenant binding and tenant user isolation (GHSA-8vh9-8966-58xc).
 */
class SSOTokenSecurityTest extends AbstractTestCase {

	private static final String TENANT_A_PREFIX = "tenanta";
	private static final String GARDEN_WORLD_PREFIX = "gardenworld";
	private static final String TENANT_A_PROVIDER_UU = "aaaaaaaa-5500-4000-8000-00000000000a";
	private static final String GARDEN_WORLD_PROVIDER_UU = "bbbbbbbb-5500-4000-8000-00000000000b";
	private static final String GARDEN_WORLD_PROVIDER2_UU = "cccccccc-5500-4000-8000-00000000000c";
	private static final String SYSTEM_PROVIDER_UU = "00000000-5500-4000-8000-000000000000";

	private HttpSession createMapBackedSession(Map<String, Object> attrs) {
		HttpSession session = mock(HttpSession.class);
		when(session.getAttribute(anyString())).thenAnswer(inv -> attrs.get(inv.getArgument(0, String.class)));
		doAnswer(inv -> {
			attrs.put(inv.getArgument(0, String.class), inv.getArgument(1));
			return null;
		}).when(session).setAttribute(anyString(), any());
		doAnswer(inv -> {
			attrs.remove(inv.getArgument(0, String.class));
			return null;
		}).when(session).removeAttribute(anyString());
		return session;
	}

	private HttpServletRequest createIndexRequest(HttpSession session, String tenant, String provider, String code) {
		HttpServletRequest req = mock(HttpServletRequest.class);
		when(req.getSession()).thenReturn(session);
		when(req.getSession(false)).thenReturn(session);
		when(req.getServletPath()).thenReturn("/index.zul");
		when(req.getRequestURI()).thenReturn("/webui/index.zul");
		when(req.getRequestURL()).thenReturn(new StringBuffer("http://127.0.0.1:8080/webui/index.zul"));
		when(req.getContextPath()).thenReturn("/webui");
		when(req.getParameter(SSOWebUIFilter.TENANT_PREFIX_PARAMETER)).thenReturn(tenant);
		when(req.getParameter(ISSOPrincipalService.SSO_SELECTED_PROVIDER)).thenReturn(provider);
		when(req.getParameter("code")).thenReturn(code);
		return req;
	}

	/**
	 * Creates a legacy-style mock {@link ISSOPrincipalService} whose {@code isAuthenticated}
	 * only checks whether {@code SSO_PRINCIPAL_SESSION_TOKEN} is non-null (mimicking an
	 * unmodified third-party SSO plugin).
	 */
	private ISSOPrincipalService createLegacyBehaviorPrincipalService(String providerUU) throws Throwable {
		ISSOPrincipalService service = mock(ISSOPrincipalService.class);
		when(service.hasAuthenticationCode(any(), any())).thenAnswer(inv -> {
			HttpServletRequest r = inv.getArgument(0);
			return r.getParameter("code") != null;
		});
		doAnswer(inv -> {
			HttpServletRequest r = inv.getArgument(0);
			r.getSession().setAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, "token-for-" + providerUU);
			return null;
		}).when(service).getAuthenticationToken(any(), any(), anyString());
		when(service.isAuthenticated(any(), any())).thenAnswer(inv -> {
			HttpServletRequest r = inv.getArgument(0);
			HttpSession s = r.getSession(false);
			return s != null && s.getAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN) != null;
		});
		doAnswer(inv -> {
			HttpServletResponse resp = inv.getArgument(1);
			resp.sendRedirect("https://idp.example/" + providerUU + "/authorize");
			return null;
		}).when(service).redirectForAuthentication(any(), any(), anyString());
		doAnswer(inv -> {
			HttpServletRequest r = inv.getArgument(0);
			HttpSession s = r.getSession(false);
			if (s != null) {
				s.removeAttribute(ISSOPrincipalService.SSO_SELECTED_PROVIDER);
				s.removeAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN);
			}
			return null;
		}).when(service).removePrincipalFromSession(any());
		return service;
	}

	private MSSOPrincipalConfig mockConfig(String uu, int clientId) {
		MSSOPrincipalConfig cfg = mock(MSSOPrincipalConfig.class);
		when(cfg.getSSO_PrincipalConfig_UU()).thenReturn(uu);
		when(cfg.getAD_Client_ID()).thenReturn(clientId);
		return cfg;
	}

	@Test
	void testIsTokenValidForProviderAndClear() {
		Map<String, Object> attrs = new HashMap<>();
		HttpSession session = createMapBackedSession(attrs);

		assertFalse(SSOUtils.isTokenValidForProvider(null, GARDEN_WORLD_PROVIDER_UU));
		assertFalse(SSOUtils.isTokenValidForProvider(session, GARDEN_WORLD_PROVIDER_UU));
		assertFalse(SSOUtils.isTokenValidForProvider(session, "  "));

		// Token without SSO_AUTHENTICATED_PROVIDER must fail closed
		session.setAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, "user-info");
		assertFalse(SSOUtils.isTokenValidForProvider(session, GARDEN_WORLD_PROVIDER_UU));

		// Token with mismatched provider must fail closed
		session.setAttribute(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER, TENANT_A_PROVIDER_UU);
		assertFalse(SSOUtils.isTokenValidForProvider(session, GARDEN_WORLD_PROVIDER_UU));

		// Token with matching provider succeeds
		session.setAttribute(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
		assertTrue(SSOUtils.isTokenValidForProvider(session, GARDEN_WORLD_PROVIDER_UU));

		// clearSSOSessionToken removes both token and provider binding
		SSOUtils.clearSSOSessionToken(session);
		assertNull(attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
		assertNull(attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
		assertFalse(SSOUtils.isTokenValidForProvider(session, GARDEN_WORLD_PROVIDER_UU));
	}

	@Test
	void testGetSSOPrincipalConfigValidatesTenantAndTrimsInput() {
		MClient gardenWorld = MClient.get(Env.getCtx(), DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		MClient tenantAClient = mock(MClient.class);
		when(tenantAClient.getAD_Client_ID()).thenReturn(1000000);

		MSSOPrincipalConfig cfgA = mockConfig(TENANT_A_PROVIDER_UU, 1000000);
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		MSSOPrincipalConfig cfgSys = mockConfig(SYSTEM_PROVIDER_UU, 0);

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MClient> clientMock = Mockito.mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MSSOPrincipalConfig> ssoCfgMock = Mockito.mockStatic(MSSOPrincipalConfig.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.SSO_SHOW_LOGINPAGE, false)).thenReturn(false);

			clientMock.when(() -> MClient.getByLoginPrefix(GARDEN_WORLD_PREFIX)).thenReturn(gardenWorld);
			clientMock.when(() -> MClient.getByLoginPrefix(TENANT_A_PREFIX)).thenReturn(tenantAClient);

			ssoCfgMock.when(() -> MSSOPrincipalConfig.getSSOPrincipalConfig(TENANT_A_PROVIDER_UU)).thenReturn(cfgA);
			ssoCfgMock.when(() -> MSSOPrincipalConfig.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU)).thenReturn(cfgGW);
			ssoCfgMock.when(() -> MSSOPrincipalConfig.getSSOPrincipalConfig(SYSTEM_PROVIDER_UU)).thenReturn(cfgSys);
			ssoCfgMock.when(() -> MSSOPrincipalConfig.getSSOPrincipalConfigByClient(DictionaryIDs.AD_Client.GARDEN_WORLD.id))
					.thenReturn(Collections.singletonList(cfgGW));

			// Whitespace provider UUID resolves to single tenant provider
			assertEquals(cfgGW, SSOUtils.getSSOPrincipalConfig("   ", GARDEN_WORLD_PREFIX));
			// Trimmed explicit provider UUID resolves when tenant matches
			assertEquals(cfgGW, SSOUtils.getSSOPrincipalConfig(" " + GARDEN_WORLD_PROVIDER_UU + " ", " " + GARDEN_WORLD_PREFIX + " "));
			// Cross-tenant config lookup must be rejected
			assertNull(SSOUtils.getSSOPrincipalConfig(TENANT_A_PROVIDER_UU, GARDEN_WORLD_PREFIX));
			// Tenant config without tenant parameter must be rejected
			assertNull(SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU, null));
			// System config allowed without tenant
			assertEquals(cfgSys, SSOUtils.getSSOPrincipalConfig(SYSTEM_PROVIDER_UU, null));
		}
	}

	@Test
	void testCrossTenantProviderSwitchRejected() throws Throwable {
		MSSOPrincipalConfig cfgA = mockConfig(TENANT_A_PROVIDER_UU, 1000000);
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService svcA = createLegacyBehaviorPrincipalService(TENANT_A_PROVIDER_UU);
		ISSOPrincipalService svcGW = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER_UU);

		Map<String, Object> attrs = new HashMap<>();
		HttpSession session = createMapBackedSession(attrs);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(null, TENANT_A_PREFIX)).thenReturn(cfgA);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(TENANT_A_PROVIDER_UU, TENANT_A_PREFIX)).thenReturn(cfgA);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalService(cfgA)).thenReturn(svcA);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalService(cfgGW)).thenReturn(svcGW);

			// Step 1: Attacker completes OIDC callback for TenantA (and does not follow the 302)
			HttpServletRequest cbReq = createIndexRequest(session, TENANT_A_PREFIX, null, "auth-code-a");
			HttpServletResponse cbResp = mock(HttpServletResponse.class);
			FilterChain cbChain = mock(FilterChain.class);
			filter.doFilter(cbReq, cbResp, cbChain);

			assertEquals("token-for-" + TENANT_A_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
			assertEquals(TENANT_A_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
			verify(cbChain, never()).doFilter(any(), any());
			verify(cbResp).sendRedirect("http://127.0.0.1:8080/webui/index.zul?tenant=tenanta");

			// Step 2: Same session switches to GardenWorld + GardenWorld's SSO provider
			HttpServletRequest switchReq = createIndexRequest(session, GARDEN_WORLD_PREFIX, GARDEN_WORLD_PROVIDER_UU, null);
			HttpServletResponse switchResp = mock(HttpServletResponse.class);
			FilterChain switchChain = mock(FilterChain.class);
			filter.doFilter(switchReq, switchResp, switchChain);

			verify(switchChain, never()).doFilter(any(), any());
			verify(switchResp).sendRedirect("https://idp.example/" + GARDEN_WORLD_PROVIDER_UU + "/authorize");
			assertNull(attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
			assertNull(attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
			assertEquals(GARDEN_WORLD_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_SELECTED_PROVIDER));
		}
	}

	@Test
	void testTenantToSystemProviderSwitchRejected() throws Throwable {
		MSSOPrincipalConfig cfgSys = mockConfig(SYSTEM_PROVIDER_UU, 0);
		ISSOPrincipalService svcSys = createLegacyBehaviorPrincipalService(SYSTEM_PROVIDER_UU);

		Map<String, Object> attrs = new HashMap<>();
		attrs.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, TENANT_A_PREFIX);
		attrs.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, TENANT_A_PROVIDER_UU);
		attrs.put(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, "token-for-" + TENANT_A_PROVIDER_UU);
		attrs.put(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER, TENANT_A_PROVIDER_UU);
		HttpSession session = createMapBackedSession(attrs);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(SYSTEM_PROVIDER_UU, null)).thenReturn(cfgSys);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalService(cfgSys)).thenReturn(svcSys);

			HttpServletRequest req = createIndexRequest(session, null, SYSTEM_PROVIDER_UU, null);
			HttpServletResponse resp = mock(HttpServletResponse.class);
			FilterChain chain = mock(FilterChain.class);
			filter.doFilter(req, resp, chain);

			verify(chain, never()).doFilter(any(), any());
			verify(resp).sendRedirect("https://idp.example/" + SYSTEM_PROVIDER_UU + "/authorize");
			assertNull(attrs.get(SSOWebUIFilter.TENANT_PREFIX_PARAMETER));
			assertNull(attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
			assertNull(attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
		}
	}

	@Test
	void testWhitespaceProviderParamDoesNotBypassBinding() throws Throwable {
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService svcGW = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER_UU);

		Map<String, Object> attrs = new HashMap<>();
		attrs.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, TENANT_A_PREFIX);
		attrs.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, TENANT_A_PROVIDER_UU);
		attrs.put(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, "token-for-" + TENANT_A_PROVIDER_UU);
		attrs.put(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER, TENANT_A_PROVIDER_UU);
		HttpSession session = createMapBackedSession(attrs);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(null, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig("", GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalService(cfgGW)).thenReturn(svcGW);

			// Passing whitespace for sso.selected.provider triggers auto-resolution of GW's single provider
			HttpServletRequest req = createIndexRequest(session, GARDEN_WORLD_PREFIX, " ", null);
			HttpServletResponse resp = mock(HttpServletResponse.class);
			FilterChain chain = mock(FilterChain.class);
			filter.doFilter(req, resp, chain);

			verify(chain, never()).doFilter(any(), any());
			verify(resp).sendRedirect("https://idp.example/" + GARDEN_WORLD_PROVIDER_UU + "/authorize");
			assertNull(attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
			assertNull(attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
			assertEquals(GARDEN_WORLD_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_SELECTED_PROVIDER));
		}
	}

	@Test
	void testSameTenantDifferentProviderSwitchRejected() throws Throwable {
		MSSOPrincipalConfig cfgGW2 = mockConfig(GARDEN_WORLD_PROVIDER2_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService svcGW2 = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER2_UU);

		Map<String, Object> attrs = new HashMap<>();
		attrs.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, GARDEN_WORLD_PREFIX);
		attrs.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
		attrs.put(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, "token-for-" + GARDEN_WORLD_PROVIDER_UU);
		attrs.put(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
		HttpSession session = createMapBackedSession(attrs);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER2_UU, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW2);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalService(cfgGW2)).thenReturn(svcGW2);

			HttpServletRequest req = createIndexRequest(session, GARDEN_WORLD_PREFIX, GARDEN_WORLD_PROVIDER2_UU, null);
			HttpServletResponse resp = mock(HttpServletResponse.class);
			FilterChain chain = mock(FilterChain.class);
			filter.doFilter(req, resp, chain);

			verify(chain, never()).doFilter(any(), any());
			verify(resp).sendRedirect("https://idp.example/" + GARDEN_WORLD_PROVIDER2_UU + "/authorize");
			assertNull(attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
			assertNull(attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
			assertEquals(GARDEN_WORLD_PROVIDER2_UU, attrs.get(ISSOPrincipalService.SSO_SELECTED_PROVIDER));
		}
	}

	@Test
	void testPreMutatedSelectedProviderRejected() throws Throwable {
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService svcGW = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER_UU);

		Map<String, Object> attrs = new HashMap<>();
		attrs.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, GARDEN_WORLD_PREFIX);
		attrs.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
		attrs.put(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, "token-for-" + TENANT_A_PROVIDER_UU);
		attrs.put(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER, TENANT_A_PROVIDER_UU);
		HttpSession session = createMapBackedSession(attrs);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalService(cfgGW)).thenReturn(svcGW);

			// Request arrives without sso.selected.provider query param while SSO_SELECTED_PROVIDER != SSO_AUTHENTICATED_PROVIDER
			HttpServletRequest req = createIndexRequest(session, GARDEN_WORLD_PREFIX, null, null);
			HttpServletResponse resp = mock(HttpServletResponse.class);
			FilterChain chain = mock(FilterChain.class);
			filter.doFilter(req, resp, chain);

			verify(chain, never()).doFilter(any(), any());
			verify(resp).sendRedirect("https://idp.example/" + GARDEN_WORLD_PROVIDER_UU + "/authorize");
			assertNull(attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
			assertNull(attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
		}
	}

	@Test
	void testLegitimateSameTenantSameProviderFlowSucceeds() throws Throwable {
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService svcGW = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER_UU);

		Map<String, Object> attrs = new HashMap<>();
		HttpSession session = createMapBackedSession(attrs);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(null, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalService(cfgGW)).thenReturn(svcGW);

			// Callback for GardenWorld
			HttpServletRequest cbReq = createIndexRequest(session, GARDEN_WORLD_PREFIX, null, "auth-code-gw");
			HttpServletResponse cbResp = mock(HttpServletResponse.class);
			FilterChain cbChain = mock(FilterChain.class);
			filter.doFilter(cbReq, cbResp, cbChain);

			assertEquals("token-for-" + GARDEN_WORLD_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
			assertEquals(GARDEN_WORLD_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
			verify(cbResp).sendRedirect("http://127.0.0.1:8080/webui/index.zul?tenant=gardenworld");

			// Follow-up redirect to index.zul?tenant=gardenworld passes through filter
			HttpServletRequest nextReq = createIndexRequest(session, GARDEN_WORLD_PREFIX, null, null);
			HttpServletResponse nextResp = mock(HttpServletResponse.class);
			FilterChain nextChain = mock(FilterChain.class);
			filter.doFilter(nextReq, nextResp, nextChain);

			verify(nextChain, times(1)).doFilter(nextReq, nextResp);
			verify(nextResp, never()).sendRedirect(anyString());
			assertEquals("token-for-" + GARDEN_WORLD_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
			assertEquals(GARDEN_WORLD_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
		}
	}

	@Test
	void testRootCallbackWithoutTenantParamPreservesTenantAndCompletesSSO() throws Throwable {
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService svcGW = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER_UU);

		Map<String, Object> attrs = new HashMap<>();
		attrs.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, GARDEN_WORLD_PREFIX);
		attrs.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
		attrs.put(ISSOPrincipalService.SSO_QUERY_STRING, SSOWebUIFilter.TENANT_PREFIX_PARAMETER + "=" + GARDEN_WORLD_PREFIX);
		HttpSession session = createMapBackedSession(attrs);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		HttpServletRequest cbReq = mock(HttpServletRequest.class);
		when(cbReq.getSession()).thenReturn(session);
		when(cbReq.getSession(false)).thenReturn(session);
		when(cbReq.getServletPath()).thenReturn("/");
		when(cbReq.getRequestURI()).thenReturn("/webui/");
		when(cbReq.getRequestURL()).thenReturn(new StringBuffer("http://127.0.0.1:8080/webui/"));
		when(cbReq.getContextPath()).thenReturn("/webui");
		when(cbReq.getParameter(SSOWebUIFilter.TENANT_PREFIX_PARAMETER)).thenReturn(null);
		when(cbReq.getParameter(ISSOPrincipalService.SSO_SELECTED_PROVIDER)).thenReturn(null);
		when(cbReq.getParameter("code")).thenReturn("auth-code-gw");
		HttpServletResponse cbResp = mock(HttpServletResponse.class);
		FilterChain cbChain = mock(FilterChain.class);

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalService(cfgGW)).thenReturn(svcGW);

			filter.doFilter(cbReq, cbResp, cbChain);

			verify(cbChain, never()).doFilter(any(), any());
			assertEquals(GARDEN_WORLD_PREFIX, attrs.get(SSOWebUIFilter.TENANT_PREFIX_PARAMETER));
			assertEquals("token-for-" + GARDEN_WORLD_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
			assertEquals(GARDEN_WORLD_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
			verify(cbResp).sendRedirect("http://127.0.0.1:8080/webui/?tenant=gardenworld");
		}
	}

	@Test
	void testErrorZulBypassesSSORedirectWhenTokenCleared() throws Throwable {
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService svcGW = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER_UU);

		Map<String, Object> attrs = new HashMap<>();
		attrs.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, GARDEN_WORLD_PREFIX);
		HttpSession session = createMapBackedSession(attrs);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		HttpServletRequest req = mock(HttpServletRequest.class);
		when(req.getSession()).thenReturn(session);
		when(req.getSession(false)).thenReturn(session);
		when(req.getServletPath()).thenReturn(SSOUtils.ERROR_VALIDATION_URL);
		when(req.getRequestURI()).thenReturn("/webui/error.zul");
		HttpServletResponse resp = mock(HttpServletResponse.class);
		FilterChain chain = mock(FilterChain.class);

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(null, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalService(cfgGW)).thenReturn(svcGW);

			filter.doFilter(req, resp, chain);

			verify(chain, times(1)).doFilter(req, resp);
			verify(resp, never()).sendRedirect(anyString());
			assertEquals(GARDEN_WORLD_PREFIX, attrs.get(SSOWebUIFilter.TENANT_PREFIX_PARAMETER));
		}
	}

	@Test
	void testTenantSSORejectsSystemUserSuperUser() {
		MClient gardenWorld = MClient.get(Env.getCtx(), DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		Properties ctxSnapshot = new Properties();
		ctxSnapshot.putAll(Env.getCtx());

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MClient> clientMock = Mockito.mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false)).thenReturn(false);
			clientMock.when(() -> MClient.getByLoginPrefix(GARDEN_WORLD_PREFIX)).thenReturn(gardenWorld);

			Login login = new Login(Env.getCtx());
			KeyNamePair[] clients = login.getClients("SuperUser", null, null, new Object(), GARDEN_WORLD_PREFIX);
			assertNull(clients, "Tenant-scoped SSO must not authenticate AD_Client_ID=0 SuperUser");
		} finally {
			Env.getCtx().clear();
			Env.getCtx().putAll(ctxSnapshot);
		}
	}

	private record UserLoginSnapshot(int userId, Timestamp dateLastLogin, int failedLoginCount,
			Timestamp datePasswordChanged, Timestamp updated, int updatedBy) {}

	private UserLoginSnapshot snapshotUserLogin(int userId) {
		MUser user = MUser.getCopy(Env.getCtx(), userId, null);
		return new UserLoginSnapshot(userId, user.getDateLastLogin(), user.getFailedLoginCount(),
				user.getDatePasswordChanged(), user.getUpdated(), user.getUpdatedBy());
	}

	private void restoreUserLogin(UserLoginSnapshot snap) {
		if (snap == null)
			return;
		String sql = "UPDATE AD_User SET DateLastLogin=?, FailedLoginCount=?, DatePasswordChanged=?, Updated=?, UpdatedBy=? WHERE AD_User_ID=?";
		PreparedStatement pstmt = null;
		try {
			pstmt = DB.prepareStatement(sql, null);
			if (snap.dateLastLogin() != null)
				pstmt.setTimestamp(1, snap.dateLastLogin());
			else
				pstmt.setNull(1, Types.TIMESTAMP);
			pstmt.setInt(2, snap.failedLoginCount());
			if (snap.datePasswordChanged() != null)
				pstmt.setTimestamp(3, snap.datePasswordChanged());
			else
				pstmt.setNull(3, Types.TIMESTAMP);
			pstmt.setTimestamp(4, snap.updated());
			pstmt.setInt(5, snap.updatedBy());
			pstmt.setInt(6, snap.userId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			DB.close(pstmt);
		}
		CacheMgt.get().reset(MUser.Table_Name, snap.userId());
	}

	@Test
	void testTenantSSOAllowsTenantUserAndSystemSSOAllowsSuperUser() {
		MClient gardenWorld = MClient.get(Env.getCtx(), DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		Properties ctxSnapshot = new Properties();
		ctxSnapshot.putAll(Env.getCtx());
		UserLoginSnapshot gardenAdminSnapshot = snapshotUserLogin(DictionaryIDs.AD_User.GARDEN_ADMIN.id);
		UserLoginSnapshot superUserSnapshot = snapshotUserLogin(DictionaryIDs.AD_User.SUPER_USER.id);

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MClient> clientMock = Mockito.mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false)).thenReturn(false);
			clientMock.when(() -> MClient.getByLoginPrefix(GARDEN_WORLD_PREFIX)).thenReturn(gardenWorld);

			Login tenantLogin = new Login(Env.getCtx());
			KeyNamePair[] tenantClients = tenantLogin.getClients("GardenAdmin", null, null, new Object(), GARDEN_WORLD_PREFIX);
			assertNotNull(tenantClients);
			assertEquals(1, tenantClients.length);
			assertEquals(DictionaryIDs.AD_Client.GARDEN_WORLD.id, tenantClients[0].getKey());

			Login systemLogin = new Login(Env.getCtx());
			KeyNamePair[] systemClients = systemLogin.getClients("SuperUser", null, null, new Object(), null);
			assertNotNull(systemClients);
			List<Integer> clientIds = Arrays.stream(systemClients).map(KeyNamePair::getKey).toList();
			assertTrue(clientIds.contains(DictionaryIDs.AD_Client.SYSTEM.id));
			assertTrue(clientIds.contains(DictionaryIDs.AD_Client.GARDEN_WORLD.id));
		} finally {
			restoreUserLogin(gardenAdminSnapshot);
			restoreUserLogin(superUserSnapshot);
			Env.getCtx().clear();
			Env.getCtx().putAll(ctxSnapshot);
		}
	}

	@Test
	void testChangeRoleGetClientsRespectsTenantAndGetRolesRestrictsToClientUser() {
		MClient gardenWorld = MClient.get(Env.getCtx(), DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		Properties ctxSnapshot = new Properties();
		ctxSnapshot.putAll(Env.getCtx());

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MClient> clientMock = Mockito.mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false)).thenReturn(false);
			clientMock.when(() -> MClient.getByLoginPrefix(GARDEN_WORLD_PREFIX)).thenReturn(gardenWorld);

			Env.setContext(Env.getCtx(), Env.AD_USER_ID, DictionaryIDs.AD_User.SUPER_USER.id);
			Login login = new Login(Env.getCtx());

			// Without tenant filter, SuperUser sees both System and GardenWorld
			KeyNamePair[] allClients = login.getClients(null, true);
			assertNotNull(allClients);
			List<Integer> allClientIds = Arrays.stream(allClients).map(KeyNamePair::getKey).toList();
			assertTrue(allClientIds.contains(DictionaryIDs.AD_Client.SYSTEM.id));
			assertTrue(allClientIds.contains(DictionaryIDs.AD_Client.GARDEN_WORLD.id));

			// With tenant filter, change-role client list is restricted to that tenant only
			KeyNamePair[] restrictedClients = login.getClients(GARDEN_WORLD_PREFIX, true);
			assertNotNull(restrictedClients);
			assertEquals(1, restrictedClients.length);
			assertEquals(DictionaryIDs.AD_Client.GARDEN_WORLD.id, restrictedClients[0].getKey());

			// With unknown/renamed tenant prefix, returns empty array and sets login error message
			KeyNamePair[] invalidTenantClients = login.getClients("nonexistent-tenant-prefix", true);
			assertNotNull(invalidTenantClients);
			assertEquals(0, invalidTenantClients.length);
			assertNotNull(login.getLoginErrMsg());

			// With restrictToClientUser=true, GardenWorld cannot resolve AD_Client_ID=0 SuperUser roles
			KeyNamePair gwPair = new KeyNamePair(DictionaryIDs.AD_Client.GARDEN_WORLD.id, "GardenWorld");
			assertNull(login.getRoles("SuperUser", gwPair, null, true));

			// Tenant user GardenAdmin resolves GardenWorld roles normally
			KeyNamePair[] gwRoles = login.getRoles("GardenAdmin", gwPair, null, true);
			assertNotNull(gwRoles);
			assertTrue(gwRoles.length > 0);
		} finally {
			Env.getCtx().clear();
			Env.getCtx().putAll(ctxSnapshot);
		}
	}
}
