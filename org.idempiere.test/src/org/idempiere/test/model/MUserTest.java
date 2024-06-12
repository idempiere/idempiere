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

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.MUser;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

public class MUserTest extends AbstractTestCase {

	public MUserTest() {
	}

	@Test
	public void testIsEmailValid() {
		MUser user = new MUser(MUser.get(getAD_User_ID()));
		user.setEMail(null);
		
		assertFalse(user.isEMailValid(), "IsEmailValid=true for null email");
		
		user.setEMail("admin @ idempiere.org");
		assertFalse(user.isEMailValid(), "IsEmailValid=true for email=admin @ idempiere.org");
		
		user.setEMail("admin@idempiere.org");
		assertTrue(user.isEMailValid(), "IsEmailValid=false for email=admin@idempiere.org");
		
		user.setEMail("admin");
		assertFalse(user.isEMailValid(), "IsEmailValid=true for email=admin");
	}
}
