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
package org.idempiere.test.print;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.contains;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;

import org.compiere.util.Msg;
import org.idempiere.zk.datatable.DataTableOptions;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Test that {@link DataTableOptions} reads its messages with the AD_Language (e.g. sk_SK)
 * and not with the BCP 47 language tag (e.g. sk-SK) used for the datatables i18n resource.
 * Does not need a database: {@link Msg} is mocked.
 */
public class DataTableOptionsTest {

	private static final String SK_ALL = "Všetko";

	private String renderWithMockedMsg(DataTableOptions options, MockedStatic<Msg> msg) {
		msg.when(() -> Msg.getMsg(anyString(), eq("All"))).thenReturn("All");
		msg.when(() -> Msg.getMsg(eq("sk_SK"), eq("All"))).thenReturn(SK_ALL);
		return options.getDataTableOptions();
	}

	@Test
	public void testAllLabelUsesADLanguage() {
		try (MockedStatic<Msg> msg = Mockito.mockStatic(Msg.class, Mockito.CALLS_REAL_METHODS)) {
			String json = renderWithMockedMsg(new DataTableOptions("sk-SK", "sk_SK"), msg);
			assertTrue(json.contains("\"" + SK_ALL + "\""), "lengthMenu must show the sk_SK translation of All: " + json);
			msg.verify(() -> Msg.getMsg(contains("-"), anyString()), never());
		}
	}

	@Test
	public void testAllLabelWithLanguageTagOnly() {
		try (MockedStatic<Msg> msg = Mockito.mockStatic(Msg.class, Mockito.CALLS_REAL_METHODS)) {
			String json = renderWithMockedMsg(new DataTableOptions("sk-SK"), msg);
			assertTrue(json.contains("\"" + SK_ALL + "\""), "lengthMenu must show the sk_SK translation of All: " + json);
			msg.verify(() -> Msg.getMsg(contains("-"), anyString()), never());
		}
	}
}
