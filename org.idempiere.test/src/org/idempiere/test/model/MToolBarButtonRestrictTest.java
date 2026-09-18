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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.MRole;
import org.compiere.model.MToolBarButtonRestrict;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Test cases for {@link MToolBarButtonRestrict}
 */
public class MToolBarButtonRestrictTest extends AbstractTestCase {

	public MToolBarButtonRestrictTest() {
	}

	/**
	 * IDEMPIERE-6968 - isNewButtonRestricted must not throw NPE when the role has
	 * no AD_Window_Access record for the window, i.e. when
	 * {@link MRole#getWindowAccess(int)} returns null.
	 */
	@Test
	public void testIsNewButtonRestrictedWithoutWindowAccess() {
		MRole role = MRole.getDefault();

		int noAccessWindowId = -9999;
		assertNull(role.getWindowAccess(noAccessWindowId), "Non-existing window ID must return null access");

		//	Before the fix this threw NullPointerException while auto-unboxing the null access
		boolean restricted = MToolBarButtonRestrict.isNewButtonRestricted(noAccessWindowId);
		assertTrue(restricted, "New button must be restricted when the role has no access to the window");
	}

	/**
	 * A window the role can read/write must not fail either - covers the
	 * non-null branch of the same check.
	 */
	@Test
	public void testIsNewButtonRestrictedWithWindowAccess() {
		MRole role = MRole.getDefault();

		int windowId = DictionaryIDs.AD_Window.USER.id;
		assertNotNull(role.getWindowAccess(windowId), "Role is expected to have access to the User window");

		assertDoesNotThrow(() -> {
			MToolBarButtonRestrict.isNewButtonRestricted(windowId);
		}, "isNewButtonRestricted must not throw for an accessible window");
	}
}
