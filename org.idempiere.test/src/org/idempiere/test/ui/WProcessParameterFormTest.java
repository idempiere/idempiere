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

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;

import java.lang.reflect.Field;

import org.adempiere.webui.apps.form.WProcessParameter;
import org.adempiere.webui.desktop.IDesktop;
import org.adempiere.webui.panel.WProcessParameterForm;
import org.adempiere.webui.session.SessionManager;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.zkoss.zk.ui.Component;
import org.zkoss.zul.impl.XulElement;

/**
 * Test cases for {@link WProcessParameterForm}
 */
@Isolated
public class WProcessParameterFormTest extends AbstractTestCase {

	private MockedStatic<SessionManager> sessionManagerMock;

	public WProcessParameterFormTest() {
	}

	@BeforeEach
	public void setUpMocks() {
		sessionManagerMock = mockStatic(SessionManager.class);
		IDesktop desktop = mock(IDesktop.class);
		sessionManagerMock.when(SessionManager::getAppDesktop).thenReturn(desktop);
	}

	@AfterEach
	public void tearDownMocks() {
		sessionManagerMock.close();
	}

	/**
	 * IDEMPIERE-7106 - the popup Window shrinks to fit its content (vflex="min"), so its
	 * dialog-content container must not itself ask to flex-grow (vflex="1"). That
	 * combination is an unsatisfiable flex constraint that collapses the parameter panel
	 * to zero height in the browser, leaving the popup blank and unusable.
	 * <p>
	 * This can't verify actual rendered pixels (this project's test suite doesn't drive a
	 * real browser), but it does lock in the fix at the component-tree level, so the
	 * vflex="1" that caused the regression can't silently come back.
	 */
	@Test
	public void testDialogContentDoesNotFightWindowShrinkToFit() throws Exception {
		WProcessParameter controller = new WProcessParameter();
		WProcessParameterForm form = (WProcessParameterForm) controller.getForm();

		Field dialogBodyField = WProcessParameterForm.class.getDeclaredField("dialogBody");
		dialogBodyField.setAccessible(true);
		Component dialogBody = (Component) dialogBodyField.get(form);

		Component dialogContent = dialogBody.getFirstChild();
		assertNotNull(dialogContent, "dialogBody should contain the dialog-content container");
		assertTrue(dialogContent instanceof XulElement, "dialogContent should be a XulElement");

		XulElement dialogContentEl = (XulElement) dialogContent;
		assertTrue("dialog-content".equals(dialogContentEl.getSclass()),
				"Unexpected sclass on what should be the dialog-content container: " + dialogContentEl.getSclass());

		String vflex = dialogContentEl.getVflex();
		assertTrue(!"1".equals(vflex),
				"dialogContent must not flex-grow (vflex=\"1\") while the popup Window shrinks to fit its "
				+ "content (vflex=\"min\") - that combination collapses it to zero height. Was: " + vflex);
	}
}
