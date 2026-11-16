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
package org.idempiere.test.ui;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.when;
import static org.mockito.Mockito.withSettings;

import java.util.UUID;

import org.mockito.MockedStatic;
import org.zkoss.zk.ui.WebApp;
import org.zkoss.zk.ui.WebApps;
import org.zkoss.zk.ui.sys.IdGenerator;
import org.zkoss.zk.ui.sys.WebAppCtrl;
import org.zkoss.zk.ui.util.Configuration;

/**
 * Provides the {@link WebApp} that ZK components need when they are created outside of a web request.
 */
final class ZkWebAppMock {

	private ZkWebAppMock() {
	}

	/**
	 * Make {@link WebApps#getCurrent()} return a mock web app. Close the result after the test.
	 * @return the static mock
	 */
	static MockedStatic<WebApps> install() {
		MockedStatic<WebApps> webApps = mockStatic(WebApps.class);
		WebApp webApp = mock(WebApp.class, withSettings().extraInterfaces(WebAppCtrl.class));
		when(webApp.getConfiguration()).thenReturn(mock(Configuration.class));
		IdGenerator idGenerator = mock(IdGenerator.class);
		when(idGenerator.nextAnonymousComponentUuid(any(), any())).thenAnswer(invocation -> UUID.randomUUID().toString());
		when(((WebAppCtrl) webApp).getIdGenerator()).thenReturn(idGenerator);
		webApps.when(() -> WebApps.getCurrent()).thenReturn(webApp);
		return webApps;
	}
}
