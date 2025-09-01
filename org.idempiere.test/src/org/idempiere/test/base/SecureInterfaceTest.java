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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;

import org.compiere.util.SecureEngine;
import org.compiere.util.SecureInterface;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.osgi.framework.ServiceRegistration;

public class SecureInterfaceTest {

	@Test
	public void testLoadingOSGIService() {
		ServiceRegistration<?> registration = null;
		try {
			registration = TestActivator.context.registerService(new String[] {SecureInterface.class.getName(), MySecure.class.getName()}, new MySecure(), null);
			//use reflection to access private SecureEngine constructor
			Constructor<SecureEngine> constructor = SecureEngine.class.getDeclaredConstructor(String.class);
		    assertTrue(Modifier.isPrivate(constructor.getModifiers()));
		    constructor.setAccessible(true);
		    // test osgi service loading
		    SecureEngine se = constructor.newInstance(MySecure.class.getName());
		    // use reflection to access private SecureEngine.implementation field
		    Field field = SecureEngine.class.getDeclaredField("implementation");
		    field.setAccessible(true);
		    assertEquals(MySecure.class.getName(), field.get(se).getClass().getName());
		    // test fallback to default class
		    se = constructor.newInstance((String)null);
		    assertEquals(SecureInterface.ADEMPIERE_SECURE_DEFAULT, field.get(se).getClass().getName());
		} catch (Exception e) {
			fail(e);
		} finally {
			if (registration != null) {
				registration.unregister();
			}
		}
	}	
}
