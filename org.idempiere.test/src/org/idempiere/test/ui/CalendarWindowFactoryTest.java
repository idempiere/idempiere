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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;

import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;

import org.adempiere.base.IServiceReferenceHolder;
import org.adempiere.base.Service;
import org.adempiere.webui.Extensions;
import org.adempiere.webui.factory.DefaultCalendarWindowFactory;
import org.adempiere.webui.factory.ICalendarWindowFactory;
import org.idempiere.test.TestActivator;
import org.junit.jupiter.api.Test;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceRegistration;
import org.zkoss.calendar.impl.SimpleCalendarModel;

/**
 * Test that the calendar window of the calendar dashboard gadget can be replaced through
 * {@link ICalendarWindowFactory}.
 */
public class CalendarWindowFactoryTest {

	@Test
	public void testDefaultFactoryIsRegisteredAsFallback() {
		List<IServiceReferenceHolder<ICalendarWindowFactory>> references = Service.locator()
				.list(ICalendarWindowFactory.class).getServiceReferences();
		IServiceReferenceHolder<ICalendarWindowFactory> defaultReference = references.stream()
				.filter(reference -> reference.getService() instanceof DefaultCalendarWindowFactory)
				.findFirst()
				.orElseThrow();

		assertEquals(0, defaultReference.getServiceReference().getProperty(Constants.SERVICE_RANKING));
	}

	@Test
	public void testHigherRankingFactoryReplacesDefault() {
		SimpleCalendarModel scm = new SimpleCalendarModel();
		SimpleCalendarModel[] received = new SimpleCalendarModel[1];
		ICalendarWindowFactory custom = model -> received[0] = model;

		Dictionary<String, Object> properties = new Hashtable<>();
		// highest possible ranking so that no other registered factory can win or tie
		properties.put(Constants.SERVICE_RANKING, Integer.MAX_VALUE);
		ServiceRegistration<ICalendarWindowFactory> registration = TestActivator.context
				.registerService(ICalendarWindowFactory.class, custom, properties);
		try {
			assertSame(custom, Service.locator().locate(ICalendarWindowFactory.class).getService(),
					"Highest ranking ICalendarWindowFactory must be selected");
			Extensions.openCalendarWindow(scm);
			assertSame(scm, received[0]);
		} finally {
			registration.unregister();
		}
	}
}
