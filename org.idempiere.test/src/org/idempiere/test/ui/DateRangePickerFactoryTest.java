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
 * - Norbert Bede, Cloudempiere                                        *
 **********************************************************************/
package org.idempiere.test.ui;

import static org.junit.jupiter.api.Assertions.assertSame;
import static org.mockito.Mockito.mock;

import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;

import org.adempiere.webui.Extensions;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.factory.IDateRangePickerFactory;
import org.adempiere.webui.window.DateRangePicker;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.FrameworkUtil;
import org.osgi.framework.ServiceRegistration;

/**
 * Test cases for {@link IDateRangePickerFactory} lookup in {@link Extensions#getDateRangePicker(WEditor, WEditor)}
 */
@Isolated
public class DateRangePickerFactoryTest {

	private final List<ServiceRegistration<IDateRangePickerFactory>> registrations = new ArrayList<>();

	@AfterEach
	public void unregister() {
		registrations.forEach(ServiceRegistration::unregister);
		registrations.clear();
	}

	private void register(IDateRangePickerFactory factory, int ranking) {
		BundleContext context = FrameworkUtil.getBundle(DateRangePickerFactoryTest.class).getBundleContext();
		Dictionary<String, Object> properties = new Hashtable<>();
		properties.put(Constants.SERVICE_RANKING, ranking);
		registrations.add(context.registerService(IDateRangePickerFactory.class, factory, properties));
	}

	/** A higher ranked factory supplies the picker instead of the default one. */
	@Test
	public void testHigherRankedFactoryWins() {
		DateRangePicker expected = mock(DateRangePicker.class);
		register((editor, editor2) -> expected, 1000);

		assertSame(expected, Extensions.getDateRangePicker(mock(WEditor.class), mock(WEditor.class)));
	}

	/** A factory returning null is skipped and the next ranked factory decides. */
	@Test
	public void testNullFromFactoryFallsThroughToNext() {
		DateRangePicker expected = mock(DateRangePicker.class);
		register((editor, editor2) -> null, 2000);
		register((editor, editor2) -> expected, 1000);

		assertSame(expected, Extensions.getDateRangePicker(mock(WEditor.class), mock(WEditor.class)));
	}
}
