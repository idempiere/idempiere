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
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Proxy;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

import javax.servlet.FilterChain;
import javax.servlet.http.Cookie;
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
import org.compiere.model.MUserRoles;
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
		when(session.getId()).thenReturn("test-session-id");
		when(session.getAttribute(anyString())).thenAnswer(inv -> attrs.get(inv.getArgument(0, String.class)));
		doAnswer(inv -> {
			Object value = inv.getArgument(1);
			if (value == null)
				attrs.remove(inv.getArgument(0, String.class));
			else
				attrs.put(inv.getArgument(0, String.class), value);
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
		assertNull(SSOUtils.getValidatedSessionToken(session, GARDEN_WORLD_PROVIDER_UU));

		// Unbound raw attributes without atomic SSOSessionToken binding must fail closed
		session.setAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, "user-info");
		assertFalse(SSOUtils.isTokenValidForProvider(session, GARDEN_WORLD_PROVIDER_UU));
		session.setAttribute(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
		assertFalse(SSOUtils.isTokenValidForProvider(session, GARDEN_WORLD_PROVIDER_UU));
		assertNull(SSOUtils.getValidatedSessionToken(session, GARDEN_WORLD_PROVIDER_UU));

		// Wrapped request atomically binds legacy setAttribute(SSO_PRINCIPAL_SESSION_TOKEN, ...) writes at the write site
		HttpServletRequest rawReq = createIndexRequest(session, TENANT_A_PREFIX, TENANT_A_PROVIDER_UU, "code");
		HttpServletRequest wrappedReq = SSOUtils.wrapRequestForTokenBinding(rawReq, TENANT_A_PROVIDER_UU);
		HttpSession wrappedSession1 = wrappedReq.getSession();
		HttpSession wrappedSession2 = wrappedReq.getSession();
		assertEquals(wrappedSession1, wrappedSession2);
		assertEquals(wrappedSession1.hashCode(), wrappedSession2.hashCode());
		assertFalse(wrappedSession1.equals(session), "Wrapper equality must remain symmetric with raw session");
		assertFalse(session.equals(wrappedSession1), "Raw session does not equal wrapper");
		wrappedSession1.setAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, "legacy-user-info");
		assertEquals("legacy-user-info", SSOUtils.getValidatedSessionToken(session, TENANT_A_PROVIDER_UU));
		assertFalse(SSOUtils.isTokenValidForProvider(session, GARDEN_WORLD_PROVIDER_UU));

		// Removing SSO_PRINCIPAL_SESSION_TOKEN through wrapped session clears the atomic binding too
		wrappedReq.getSession().removeAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN);
		assertNull(SSOUtils.getSSOSessionToken(session));

		// Atomic setSSOSessionToken through a wrapped session unwraps and uses the service's provider UUID
		SSOUtils.setSSOSessionToken(wrappedReq.getSession(), "gw-user-info", " " + GARDEN_WORLD_PROVIDER_UU + " ");
		assertTrue(SSOUtils.isTokenValidForProvider(session, GARDEN_WORLD_PROVIDER_UU));
		assertEquals("gw-user-info", SSOUtils.getValidatedSessionToken(session, GARDEN_WORLD_PROVIDER_UU));
		assertNull(SSOUtils.getValidatedSessionToken(session, TENANT_A_PROVIDER_UU));
		assertEquals("gw-user-info", attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
		assertEquals(GARDEN_WORLD_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));

		// clearSSOSessionToken removes bound token, raw token, and provider attribute
		SSOUtils.clearSSOSessionToken(session);
		assertNull(SSOUtils.getSSOSessionToken(session));
		assertNull(attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
		assertNull(attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
		assertFalse(SSOUtils.isTokenValidForProvider(session, GARDEN_WORLD_PROVIDER_UU));
	}

	@Test
	void testConcurrentSetAndReadNeverCrossPairsTokenAndProvider() throws Exception {
		Map<String, Object> attrs = new ConcurrentHashMap<>();
		HttpSession session = (HttpSession) Proxy.newProxyInstance(
				HttpSession.class.getClassLoader(),
				new Class<?>[] { HttpSession.class },
				(proxy, method, args) -> switch (method.getName()) {
					case "getId" -> "concurrent-session-id";
					case "getAttribute" -> attrs.get(args[0]);
					case "setAttribute" -> {
						if (args[1] == null)
							attrs.remove(args[0]);
						else
							attrs.put((String) args[0], args[1]);
						yield null;
					}
					case "removeAttribute" -> {
						attrs.remove(args[0]);
						yield null;
					}
					default -> null;
				});

		HttpServletRequest baseReq = (HttpServletRequest) Proxy.newProxyInstance(
				HttpServletRequest.class.getClassLoader(),
				new Class<?>[] { HttpServletRequest.class },
				(proxy, method, args) -> "getSession".equals(method.getName()) ? session : null);
		HttpServletRequest wrappedReqA = SSOUtils.wrapRequestForTokenBinding(baseReq, TENANT_A_PROVIDER_UU);

		int iterations = 2000;
		AtomicReference<Throwable> failure = new AtomicReference<>();
		CountDownLatch writerAPublished = new CountDownLatch(1);
		CountDownLatch readerObservedA = new CountDownLatch(1);
		CountDownLatch writerGWPublished = new CountDownLatch(1);
		CountDownLatch readerObservedGW = new CountDownLatch(1);
		CountDownLatch readerEnteredStress = new CountDownLatch(1);
		CountDownLatch writersDone = new CountDownLatch(2);
		AtomicInteger checks = new AtomicInteger(0);
		AtomicInteger nonNullObservations = new AtomicInteger(0);
		ExecutorService pool = Executors.newFixedThreadPool(3);
		try {
			pool.submit(() -> {
				try {
					wrappedReqA.getSession().setAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, "token-A-0");
					writerAPublished.countDown();
					assertTrue(readerObservedA.await(10, TimeUnit.SECONDS), "Timed out waiting for reader to observe TenantA token");
					assertTrue(readerObservedGW.await(10, TimeUnit.SECONDS), "Timed out waiting for reader to observe GW token");
					for (int i = 1; i < iterations; i++) {
						if (i == iterations / 2)
							assertTrue(readerEnteredStress.await(10, TimeUnit.SECONDS), "Timed out waiting for reader stress check");
						// Legacy write via wrapRequestForTokenBinding racing with atomic OIDC writes
						wrappedReqA.getSession().setAttribute(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN, "token-A-" + i);
					}
				} catch (Throwable t) {
					failure.compareAndSet(null, t);
				} finally {
					writerAPublished.countDown();
					writersDone.countDown();
				}
			});
			pool.submit(() -> {
				try {
					assertTrue(readerObservedA.await(10, TimeUnit.SECONDS), "Timed out waiting for TenantA observation");
					SSOUtils.setSSOSessionToken(session, "token-GW-0", GARDEN_WORLD_PROVIDER_UU);
					writerGWPublished.countDown();
					assertTrue(readerObservedGW.await(10, TimeUnit.SECONDS), "Timed out waiting for reader to observe GW token");
					for (int i = 1; i < iterations; i++) {
						if (i == iterations / 2)
							assertTrue(readerEnteredStress.await(10, TimeUnit.SECONDS), "Timed out waiting for reader stress check");
						SSOUtils.setSSOSessionToken(session, "token-GW-" + i, GARDEN_WORLD_PROVIDER_UU);
						if ((i & 7) == 0)
							SSOUtils.clearSSOSessionToken(session);
					}
				} catch (Throwable t) {
					failure.compareAndSet(null, t);
				} finally {
					writerGWPublished.countDown();
					writersDone.countDown();
				}
			});
			pool.submit(() -> {
				try {
					assertTrue(writerAPublished.await(10, TimeUnit.SECONDS), "Timed out waiting for TenantA publication");
					assertEquals("token-A-0", SSOUtils.getValidatedSessionToken(session, TENANT_A_PROVIDER_UU));
					assertNull(SSOUtils.getValidatedSessionToken(session, GARDEN_WORLD_PROVIDER_UU));
					checks.incrementAndGet();
					nonNullObservations.incrementAndGet();
					readerObservedA.countDown();

					assertTrue(writerGWPublished.await(10, TimeUnit.SECONDS), "Timed out waiting for GW publication");
					assertEquals("token-GW-0", SSOUtils.getValidatedSessionToken(session, GARDEN_WORLD_PROVIDER_UU));
					assertNull(SSOUtils.getValidatedSessionToken(session, TENANT_A_PROVIDER_UU));
					checks.incrementAndGet();
					nonNullObservations.incrementAndGet();
					readerObservedGW.countDown();

					do {
						Object gwToken = SSOUtils.getValidatedSessionToken(session, GARDEN_WORLD_PROVIDER_UU);
						if (gwToken != null && !gwToken.toString().startsWith("token-GW-")) {
							throw new AssertionError("Cross-paired token for GW: " + gwToken);
						}
						Object aToken = SSOUtils.getValidatedSessionToken(session, TENANT_A_PROVIDER_UU);
						if (aToken != null && !aToken.toString().startsWith("token-A-")) {
							throw new AssertionError("Cross-paired token for TenantA: " + aToken);
						}
						SSOUtils.SSOSessionToken bound = SSOUtils.getSSOSessionToken(session);
						if (bound != null) {
							nonNullObservations.incrementAndGet();
							String expectedPrefix = GARDEN_WORLD_PROVIDER_UU.equals(bound.providerUU()) ? "token-GW-" : "token-A-";
							if (!bound.token().toString().startsWith(expectedPrefix)) {
								throw new AssertionError("Mismatched binding: " + bound);
							}
						}
						checks.incrementAndGet();
						readerEnteredStress.countDown();
					} while (writersDone.getCount() > 0);
				} catch (Throwable t) {
					failure.compareAndSet(null, t);
				} finally {
					readerObservedA.countDown();
					readerObservedGW.countDown();
					readerEnteredStress.countDown();
				}
			});

			pool.shutdown();
			assertTrue(pool.awaitTermination(30, TimeUnit.SECONDS));
			assertNull(failure.get(), () -> "Unexpected concurrency failure: " + failure.get());
			assertTrue(checks.get() >= 3, "Reader must observe initial publications and concurrent stress checks");
			assertTrue(nonNullObservations.get() >= 2, "Reader must observe published tokens");
		} finally {
			pool.shutdownNow();
		}
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
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgA)).thenReturn(svcA);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW)).thenReturn(svcGW);

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
		HttpSession session = createMapBackedSession(attrs);
		SSOUtils.setSSOSessionToken(session, "token-for-" + TENANT_A_PROVIDER_UU, TENANT_A_PROVIDER_UU);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(SYSTEM_PROVIDER_UU, null)).thenReturn(cfgSys);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgSys)).thenReturn(svcSys);

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
		HttpSession session = createMapBackedSession(attrs);
		SSOUtils.setSSOSessionToken(session, "token-for-" + TENANT_A_PROVIDER_UU, TENANT_A_PROVIDER_UU);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(null, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig("", GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW)).thenReturn(svcGW);

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
		HttpSession session = createMapBackedSession(attrs);
		SSOUtils.setSSOSessionToken(session, "token-for-" + GARDEN_WORLD_PROVIDER_UU, GARDEN_WORLD_PROVIDER_UU);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER2_UU, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW2);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW2)).thenReturn(svcGW2);

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
		HttpSession session = createMapBackedSession(attrs);
		SSOUtils.setSSOSessionToken(session, "token-for-" + TENANT_A_PROVIDER_UU, TENANT_A_PROVIDER_UU);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW)).thenReturn(svcGW);

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
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW)).thenReturn(svcGW);

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
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW)).thenReturn(svcGW);

			filter.doFilter(cbReq, cbResp, cbChain);

			verify(cbChain, never()).doFilter(any(), any());
			assertEquals(GARDEN_WORLD_PREFIX, attrs.get(SSOWebUIFilter.TENANT_PREFIX_PARAMETER));
			assertEquals("token-for-" + GARDEN_WORLD_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
			assertEquals(GARDEN_WORLD_PROVIDER_UU, attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
			verify(cbResp).sendRedirect("http://127.0.0.1:8080/webui/?tenant=gardenworld");
		}
	}

	@Test
	void testIndexZulCallbackWithoutTenantParamPreservesTenantAndCompletesSSO() throws Throwable {
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService svcGW = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER_UU);
		MSSOPrincipalConfig cfgA = mockConfig(TENANT_A_PROVIDER_UU, 1000000);
		ISSOPrincipalService svcA = createLegacyBehaviorPrincipalService(TENANT_A_PROVIDER_UU);

		Map<String, Object> attrs = new HashMap<>();
		attrs.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, GARDEN_WORLD_PREFIX);
		attrs.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
		attrs.put(ISSOPrincipalService.SSO_QUERY_STRING, SSOWebUIFilter.TENANT_PREFIX_PARAMETER + "=" + GARDEN_WORLD_PREFIX + "&view=orders");
		HttpSession session = createMapBackedSession(attrs);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(null, null)).thenReturn(null);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW)).thenReturn(svcGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(null, TENANT_A_PREFIX)).thenReturn(cfgA);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(TENANT_A_PROVIDER_UU, TENANT_A_PREFIX)).thenReturn(cfgA);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgA)).thenReturn(svcA);

			// 1. Callback to /webui/index.zul without tenant parameter preserves pending tenant and saved query
			HttpServletRequest cbReq = createIndexRequest(session, null, null, "auth-code-gw");
			HttpServletResponse cbResp = mock(HttpServletResponse.class);
			FilterChain cbChain = mock(FilterChain.class);
			filter.doFilter(cbReq, cbResp, cbChain);

			verify(cbChain, never()).doFilter(any(), any());
			assertEquals(GARDEN_WORLD_PREFIX, attrs.get(SSOWebUIFilter.TENANT_PREFIX_PARAMETER));
			assertEquals("token-for-" + GARDEN_WORLD_PROVIDER_UU, SSOUtils.getValidatedSessionToken(session, GARDEN_WORLD_PROVIDER_UU));
			assertNull(attrs.get(ISSOPrincipalService.SSO_QUERY_STRING), "Callback must consume SSO_QUERY_STRING");
			verify(cbResp).sendRedirect("http://127.0.0.1:8080/webui/index.zul?tenant=gardenworld&view=orders");

			// 2. Callback to /webui/index.zul without tenant parameter and without SSO_QUERY_STRING synthesizes tenant query parameter
			SSOUtils.clearSSOSessionToken(session);
			HttpServletRequest cbReqNoQuery = createIndexRequest(session, null, null, "auth-code-gw-2");
			HttpServletResponse cbRespNoQuery = mock(HttpServletResponse.class);
			FilterChain cbChainNoQuery = mock(FilterChain.class);
			filter.doFilter(cbReqNoQuery, cbRespNoQuery, cbChainNoQuery);

			verify(cbChainNoQuery, never()).doFilter(any(), any());
			assertEquals(GARDEN_WORLD_PREFIX, attrs.get(SSOWebUIFilter.TENANT_PREFIX_PARAMETER));
			assertEquals("token-for-" + GARDEN_WORLD_PROVIDER_UU, SSOUtils.getValidatedSessionToken(session, GARDEN_WORLD_PROVIDER_UU));
			verify(cbRespNoQuery).sendRedirect("http://127.0.0.1:8080/webui/index.zul?tenant=gardenworld");

			// 3. Explicit tenant switch on /webui/index.zul?tenant=tenanta clears prior GardenWorld session state
			HttpServletRequest switchReq = createIndexRequest(session, TENANT_A_PREFIX, null, null);
			HttpServletResponse switchResp = mock(HttpServletResponse.class);
			FilterChain switchChain = mock(FilterChain.class);
			filter.doFilter(switchReq, switchResp, switchChain);

			verify(switchChain, never()).doFilter(any(), any());
			assertEquals(TENANT_A_PREFIX, attrs.get(SSOWebUIFilter.TENANT_PREFIX_PARAMETER));
			assertNull(SSOUtils.getSSOSessionToken(session));
			verify(switchResp).sendRedirect("https://idp.example/" + TENANT_A_PROVIDER_UU + "/authorize");

			// 4. Plain /webui/index.zul navigation without code clears pending tenant state
			HttpServletRequest plainReq = createIndexRequest(session, null, null, null);
			HttpServletResponse plainResp = mock(HttpServletResponse.class);
			FilterChain plainChain = mock(FilterChain.class);
			filter.doFilter(plainReq, plainResp, plainChain);

			verify(plainChain, times(1)).doFilter(plainReq, plainResp);
			verify(plainResp, never()).sendRedirect(anyString());
			assertNull(attrs.get(SSOWebUIFilter.TENANT_PREFIX_PARAMETER));
			assertNull(attrs.get(ISSOPrincipalService.SSO_SELECTED_PROVIDER));
			assertNull(SSOUtils.getSSOSessionToken(session));
		}
	}

	@Test
	void testPendingCallbackDetectionExceptionHandledBySSOErrorHandler() throws Throwable {
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService failingSvc = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER_UU);
		doThrow(new RuntimeException("callback check failed")).when(failingSvc).hasAuthenticationCode(any(), any());

		Map<String, Object> attrs = new HashMap<>();
		attrs.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, GARDEN_WORLD_PREFIX);
		attrs.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
		HttpSession session = createMapBackedSession(attrs);
		SSOUtils.setSSOSessionToken(session, "prior-token", GARDEN_WORLD_PROVIDER_UU);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		StringWriter body = new StringWriter();
		HttpServletRequest req = createIndexRequest(session, null, null, "auth-code-gw");
		HttpServletResponse resp = mock(HttpServletResponse.class);
		when(resp.getWriter()).thenReturn(new PrintWriter(body));
		FilterChain chain = mock(FilterChain.class);

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW)).thenReturn(failingSvc);

			filter.doFilter(req, resp, chain);

			verify(chain, never()).doFilter(any(), any());
			verify(resp).setStatus(500);
			assertTrue(body.toString().contains("callback check failed"));
			assertNull(SSOUtils.getSSOSessionToken(session));
			assertNull(attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
		}
	}

	@Test
	void testStaleProviderCookieRecoversSingleTenantProviderEvenWhenShowLoginPageEnabled() throws Throwable {
		MClient gardenWorld = MClient.get(Env.getCtx(), DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService svcGW = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER_UU);

		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MClient> clientMock = Mockito.mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MSSOPrincipalConfig> ssoCfgMock = Mockito.mockStatic(MSSOPrincipalConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.SSO_SHOW_LOGINPAGE, false)).thenReturn(true);
			clientMock.when(() -> MClient.getByLoginPrefix(GARDEN_WORLD_PREFIX)).thenReturn(gardenWorld);
			ssoCfgMock.when(() -> MSSOPrincipalConfig.getSSOPrincipalConfig("stale-cookie-uu")).thenReturn(null);
			ssoCfgMock.when(() -> MSSOPrincipalConfig.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU)).thenReturn(cfgGW);
			ssoCfgMock.when(() -> MSSOPrincipalConfig.getSSOPrincipalConfigByClient(DictionaryIDs.AD_Client.GARDEN_WORLD.id))
					.thenReturn(Collections.singletonList(cfgGW));
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW)).thenReturn(svcGW);

			// 1. Stale provider cookie falls back to tenant's single provider even when SSO_SHOW_LOGINPAGE=true
			Map<String, Object> cookieAttrs = new HashMap<>();
			HttpSession cookieSession = createMapBackedSession(cookieAttrs);
			HttpServletRequest cookieReq = createIndexRequest(cookieSession, GARDEN_WORLD_PREFIX, null, null);
			when(cookieReq.getCookies()).thenReturn(new Cookie[] { new Cookie(ISSOPrincipalService.SSO_SELECTED_PROVIDER, "stale-cookie-uu") });
			HttpServletResponse cookieResp = mock(HttpServletResponse.class);
			FilterChain cookieChain = mock(FilterChain.class);
			filter.doFilter(cookieReq, cookieResp, cookieChain);

			verify(cookieChain, never()).doFilter(any(), any());
			verify(cookieResp).sendRedirect("https://idp.example/" + GARDEN_WORLD_PROVIDER_UU + "/authorize");
			assertEquals(GARDEN_WORLD_PROVIDER_UU, cookieAttrs.get(ISSOPrincipalService.SSO_SELECTED_PROVIDER));

			// 2. Without a cookie, SSO_SHOW_LOGINPAGE=true continues to show the login page
			Map<String, Object> noCookieAttrs = new HashMap<>();
			HttpSession noCookieSession = createMapBackedSession(noCookieAttrs);
			HttpServletRequest noCookieReq = createIndexRequest(noCookieSession, GARDEN_WORLD_PREFIX, null, null);
			HttpServletResponse noCookieResp = mock(HttpServletResponse.class);
			FilterChain noCookieChain = mock(FilterChain.class);
			filter.doFilter(noCookieReq, noCookieResp, noCookieChain);

			verify(noCookieChain, times(1)).doFilter(noCookieReq, noCookieResp);
			verify(noCookieResp, never()).sendRedirect(anyString());
			assertNull(noCookieAttrs.get(ISSOPrincipalService.SSO_SELECTED_PROVIDER));
		}
	}

	@Test
	void testSavedQueryTenantParameterParsingAppendsWhenAbsentAndPreservesEncoded() throws Throwable {
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService svcGW = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER_UU);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW)).thenReturn(svcGW);

			// Saved query containing "tenant=" only inside a parameter value must still append tenant=gardenworld
			Map<String, Object> attrs1 = new HashMap<>();
			attrs1.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, GARDEN_WORLD_PREFIX);
			attrs1.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
			attrs1.put(ISSOPrincipalService.SSO_QUERY_STRING, "view=tenant=details");
			HttpSession session1 = createMapBackedSession(attrs1);

			HttpServletRequest req1 = createIndexRequest(session1, null, null, "auth-code-1");
			HttpServletResponse resp1 = mock(HttpServletResponse.class);
			filter.doFilter(req1, resp1, mock(FilterChain.class));
			verify(resp1).sendRedirect("http://127.0.0.1:8080/webui/index.zul?view=tenant=details&tenant=gardenworld");

			// Existing encoded tenant parameter name with non-empty value is preserved as-is
			Map<String, Object> attrs2 = new HashMap<>();
			attrs2.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, GARDEN_WORLD_PREFIX);
			attrs2.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
			attrs2.put(ISSOPrincipalService.SSO_QUERY_STRING, "%74enant=gardenworld&view=orders");
			HttpSession session2 = createMapBackedSession(attrs2);

			HttpServletRequest req2 = createIndexRequest(session2, null, null, "auth-code-2");
			HttpServletResponse resp2 = mock(HttpServletResponse.class);
			filter.doFilter(req2, resp2, mock(FilterChain.class));
			verify(resp2).sendRedirect("http://127.0.0.1:8080/webui/index.zul?%74enant=gardenworld&view=orders");

			// Duplicate empty tenant parameter preceding valid tenant parameter must be removed
			Map<String, Object> attrs3 = new HashMap<>();
			attrs3.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, GARDEN_WORLD_PREFIX);
			attrs3.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
			attrs3.put(ISSOPrincipalService.SSO_QUERY_STRING, "tenant=&tenant=gardenworld&view=orders");
			HttpSession session3 = createMapBackedSession(attrs3);

			HttpServletRequest req3 = createIndexRequest(session3, null, null, "auth-code-3");
			HttpServletResponse resp3 = mock(HttpServletResponse.class);
			filter.doFilter(req3, resp3, mock(FilterChain.class));
			verify(resp3).sendRedirect("http://127.0.0.1:8080/webui/index.zul?tenant=gardenworld&view=orders");

			// Empty tenant entries around a valid encoded tenant entry are stripped while preserving encoded entry and unrelated params
			Map<String, Object> attrs4 = new HashMap<>();
			attrs4.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, GARDEN_WORLD_PREFIX);
			attrs4.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
			attrs4.put(ISSOPrincipalService.SSO_QUERY_STRING, "tenant=&%74enant=gardenworld&tenant=%20&view=orders");
			HttpSession session4 = createMapBackedSession(attrs4);

			HttpServletRequest req4 = createIndexRequest(session4, null, null, "auth-code-4");
			HttpServletResponse resp4 = mock(HttpServletResponse.class);
			filter.doFilter(req4, resp4, mock(FilterChain.class));
			verify(resp4).sendRedirect("http://127.0.0.1:8080/webui/index.zul?%74enant=gardenworld&view=orders");
		}
	}

	@Test
	void testProviderCleanupExceptionStillClearsCoreBindingAndWritesErrorResponse() throws Throwable {
		MSSOPrincipalConfig cfgGW = mockConfig(GARDEN_WORLD_PROVIDER_UU, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		ISSOPrincipalService svcGW = createLegacyBehaviorPrincipalService(GARDEN_WORLD_PROVIDER_UU);
		doReturn(false).when(svcGW).isAuthenticated(any(), any());
		doThrow(new RuntimeException("provider cleanup failed")).when(svcGW).removePrincipalFromSession(any());

		Map<String, Object> attrs = new HashMap<>();
		attrs.put(SSOWebUIFilter.TENANT_PREFIX_PARAMETER, GARDEN_WORLD_PREFIX);
		attrs.put(ISSOPrincipalService.SSO_SELECTED_PROVIDER, GARDEN_WORLD_PROVIDER_UU);
		HttpSession session = createMapBackedSession(attrs);
		SSOUtils.setSSOSessionToken(session, "expired-token", GARDEN_WORLD_PROVIDER_UU);
		SSOWebUIFilter filter = new SSOWebUIFilter();

		StringWriter body = new StringWriter();
		HttpServletRequest req = createIndexRequest(session, GARDEN_WORLD_PREFIX, null, null);
		HttpServletResponse resp = mock(HttpServletResponse.class);
		when(resp.getWriter()).thenReturn(new PrintWriter(body));
		FilterChain chain = mock(FilterChain.class);

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<SSOUtils> ssoUtilsMock = Mockito.mockStatic(SSOUtils.class, Mockito.CALLS_REAL_METHODS)) {

			sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalConfig(GARDEN_WORLD_PROVIDER_UU, GARDEN_WORLD_PREFIX)).thenReturn(cfgGW);
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW)).thenReturn(svcGW);

			filter.doFilter(req, resp, chain);

			verify(chain, never()).doFilter(any(), any());
			verify(resp).setStatus(500);
			assertTrue(body.toString().contains("provider cleanup failed"));
			assertNull(SSOUtils.getSSOSessionToken(session));
			assertNull(attrs.get(ISSOPrincipalService.SSO_PRINCIPAL_SESSION_TOKEN));
			assertNull(attrs.get(ISSOPrincipalService.SSO_AUTHENTICATED_PROVIDER));
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
			ssoUtilsMock.when(() -> SSOUtils.getSSOPrincipalServiceForConfig(cfgGW)).thenReturn(svcGW);

			filter.doFilter(req, resp, chain);

			verify(chain, times(1)).doFilter(req, resp);
			verify(resp, never()).sendRedirect(anyString());
			assertEquals(GARDEN_WORLD_PREFIX, attrs.get(SSOWebUIFilter.TENANT_PREFIX_PARAMETER));
		}
	}

	private record DedicatedSSOUser(MUser user, int clientId, int roleContextId, List<MUserRoles> userRoles) {}

	private DedicatedSSOUser createDedicatedSSOUser(int clientId, int roleContextId, String namePrefix, int[][] clientAndRolePairs) {
		String uniqueName = namePrefix + "_" + UUID.randomUUID().toString().replace("-", "").substring(0, 12);
		Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, clientId);
		Env.setContext(Env.getCtx(), Env.AD_ORG_ID, DictionaryIDs.AD_Org.GLOBAL.id);
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, roleContextId);

		MUser user = null;
		List<MUserRoles> roles = new ArrayList<>();
		try {
			user = new MUser(Env.getCtx(), 0, null);
			user.setAD_Org_ID(DictionaryIDs.AD_Org.GLOBAL.id);
			user.setName(uniqueName);
			user.setPassword("SsoTest#9aB1!z");
			user.setAuthenticationType(MUser.AUTHENTICATIONTYPE_ApplicationAndSSO);
			user.setIsActive(true);
			user.saveEx();

			for (int[] pair : clientAndRolePairs) {
				int urClientId = pair[0];
				int urRoleId = pair[1];
				Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, urClientId);
				Env.setContext(Env.getCtx(), Env.AD_ORG_ID, DictionaryIDs.AD_Org.GLOBAL.id);
				Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, urRoleId);

				MUserRoles ur = new MUserRoles(Env.getCtx(), user.getAD_User_ID(), urRoleId, null);
				ur.setAD_Org_ID(DictionaryIDs.AD_Org.GLOBAL.id);
				ur.setIsActive(true);
				ur.saveEx();
				roles.add(ur);
			}
			return new DedicatedSSOUser(user, clientId, roleContextId, roles);
		} catch (Throwable t) {
			if (user != null && user.getAD_User_ID() > 0) {
				try {
					deleteDedicatedSSOUser(new DedicatedSSOUser(user, clientId, roleContextId, roles));
				} catch (Throwable cleanupEx) {
					t.addSuppressed(cleanupEx);
				}
			}
			throw t;
		}
	}

	private void deleteDedicatedSSOUser(DedicatedSSOUser dedicated) {
		if (dedicated == null || dedicated.user() == null || dedicated.user().getAD_User_ID() <= 0)
			return;
		int userId = dedicated.user().getAD_User_ID();
		for (MUserRoles ur : dedicated.userRoles()) {
			if (ur != null) {
				Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, ur.getAD_Client_ID());
				Env.setContext(Env.getCtx(), Env.AD_ORG_ID, DictionaryIDs.AD_Org.GLOBAL.id);
				Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, ur.getAD_Role_ID());
				ur.deleteEx(true);
			}
		}
		DB.executeUpdateEx("DELETE FROM AD_Password_History WHERE AD_User_ID=?", new Object[] { userId }, null);
		Env.setContext(Env.getCtx(), Env.AD_CLIENT_ID, dedicated.clientId());
		Env.setContext(Env.getCtx(), Env.AD_ORG_ID, DictionaryIDs.AD_Org.GLOBAL.id);
		Env.setContext(Env.getCtx(), Env.AD_ROLE_ID, dedicated.roleContextId());
		MUser freshUser = new MUser(Env.getCtx(), userId, null);
		if (freshUser.getAD_User_ID() > 0)
			freshUser.deleteEx(true);
		CacheMgt.get().reset(MUser.Table_Name, userId);
	}

	private void mockLoginAccountPolicySysConfig(MockedStatic<MSysConfig> sysConfigMock) {
		sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.ENABLE_SSO, false)).thenReturn(true);
		sysConfigMock.when(() -> MSysConfig.getBooleanValue(MSysConfig.USE_EMAIL_FOR_LOGIN, false)).thenReturn(false);
		sysConfigMock.when(() -> MSysConfig.getIntValue(MSysConfig.USER_LOCKING_MAX_ACCOUNT_LOCK_MINUTES, 0)).thenReturn(0);
		sysConfigMock.when(() -> MSysConfig.getIntValue(MSysConfig.USER_LOCKING_MAX_INACTIVE_PERIOD_DAY, 0)).thenReturn(0);
		sysConfigMock.when(() -> MSysConfig.getIntValue(MSysConfig.USER_LOCKING_MAX_PASSWORD_AGE_DAY, 0)).thenReturn(0);
	}

	@Test
	void testTenantSSORejectsSystemUserSuperUser() {
		MClient gardenWorld = MClient.get(Env.getCtx(), DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		Properties ctxSnapshot = new Properties();
		ctxSnapshot.putAll(Env.getCtx());
		DedicatedSSOUser systemUser = null;

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MClient> clientMock = Mockito.mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS)) {

			mockLoginAccountPolicySysConfig(sysConfigMock);
			clientMock.when(() -> MClient.getByLoginPrefix(GARDEN_WORLD_PREFIX)).thenReturn(gardenWorld);

			systemUser = createDedicatedSSOUser(
					DictionaryIDs.AD_Client.SYSTEM.id,
					DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id,
					"SSOTestSysReject",
					new int[][] {
						{ DictionaryIDs.AD_Client.SYSTEM.id, DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id },
						{ DictionaryIDs.AD_Client.GARDEN_WORLD.id, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id }
					});

			Env.getCtx().clear();
			Env.getCtx().putAll(ctxSnapshot);

			Login login = new Login(Env.getCtx());
			KeyNamePair[] clients = login.getClients(systemUser.user().getName(), null, null, new Object(), GARDEN_WORLD_PREFIX);
			assertNull(clients, "Tenant-scoped SSO must not authenticate AD_Client_ID=0 user");
		} finally {
			try {
				deleteDedicatedSSOUser(systemUser);
			} finally {
				Env.getCtx().clear();
				Env.getCtx().putAll(ctxSnapshot);
			}
		}
	}

	@Test
	void testTenantSSOAllowsTenantUserAndSystemSSOAllowsSuperUser() {
		MClient gardenWorld = MClient.get(Env.getCtx(), DictionaryIDs.AD_Client.GARDEN_WORLD.id);
		Properties ctxSnapshot = new Properties();
		ctxSnapshot.putAll(Env.getCtx());
		DedicatedSSOUser tenantUser = null;
		DedicatedSSOUser systemUser = null;

		try (MockedStatic<MSysConfig> sysConfigMock = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS);
			 MockedStatic<MClient> clientMock = Mockito.mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS)) {

			mockLoginAccountPolicySysConfig(sysConfigMock);
			clientMock.when(() -> MClient.getByLoginPrefix(GARDEN_WORLD_PREFIX)).thenReturn(gardenWorld);

			tenantUser = createDedicatedSSOUser(
					DictionaryIDs.AD_Client.GARDEN_WORLD.id,
					DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id,
					"SSOTestGW",
					new int[][] {
						{ DictionaryIDs.AD_Client.GARDEN_WORLD.id, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id }
					});
			systemUser = createDedicatedSSOUser(
					DictionaryIDs.AD_Client.SYSTEM.id,
					DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id,
					"SSOTestSys",
					new int[][] {
						{ DictionaryIDs.AD_Client.SYSTEM.id, DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id },
						{ DictionaryIDs.AD_Client.GARDEN_WORLD.id, DictionaryIDs.AD_Role.GARDEN_WORLD_ADMIN.id }
					});

			Env.getCtx().clear();
			Env.getCtx().putAll(ctxSnapshot);

			Login tenantLogin = new Login(Env.getCtx());
			KeyNamePair[] tenantClients = tenantLogin.getClients(tenantUser.user().getName(), null, null, new Object(), GARDEN_WORLD_PREFIX);
			assertNotNull(tenantClients);
			assertEquals(1, tenantClients.length);
			assertEquals(DictionaryIDs.AD_Client.GARDEN_WORLD.id, tenantClients[0].getKey());

			Login systemLogin = new Login(Env.getCtx());
			KeyNamePair[] systemClients = systemLogin.getClients(systemUser.user().getName(), null, null, new Object(), null);
			assertNotNull(systemClients);
			List<Integer> clientIds = Arrays.stream(systemClients).map(KeyNamePair::getKey).toList();
			assertTrue(clientIds.contains(DictionaryIDs.AD_Client.SYSTEM.id));
			assertTrue(clientIds.contains(DictionaryIDs.AD_Client.GARDEN_WORLD.id));
		} finally {
			try {
				deleteDedicatedSSOUser(tenantUser);
			} finally {
				try {
					deleteDedicatedSSOUser(systemUser);
				} finally {
					Env.getCtx().clear();
					Env.getCtx().putAll(ctxSnapshot);
				}
			}
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
