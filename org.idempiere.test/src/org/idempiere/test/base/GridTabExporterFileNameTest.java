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
 * - Norbert Bede                                                      *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.adempiere.base.IGridTabExporter;
import org.adempiere.impexp.GridTabExcelExporter;
import org.adempiere.impexp.GridTabSQLInsertExporter;
import org.adempiere.impexp.GridTabXLSXExporter;
import org.adempiere.pipo2.GridTab2PackExporter;
import org.compiere.model.GridTab;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * IDEMPIERE-7200: the suggested export file name must be safe in a download URL.
 * A "/" in a tab name made the server reject the download.
 */
public class GridTabExporterFileNameTest extends AbstractTestCase {

	private static GridTab tab(String name) {
		GridTab gridTab = mock(GridTab.class);
		when(gridTab.getName()).thenReturn(name);
		when(gridTab.getTableName()).thenReturn("C_OrderLine");
		return gridTab;
	}

	private static void assertName(IGridTabExporter exporter, String tabName, String expectedPrefix) {
		assertEquals(expectedPrefix + "." + exporter.getFileExtension(), exporter.getSuggestedFileName(tab(tabName)));
	}

	@Test
	public void testSlashInTabName() {
		assertName(new GridTabExcelExporter(), "Print Header/Footer", "Print_Header_Footer");
		assertName(new GridTabXLSXExporter(), "Print Header/Footer", "Print_Header_Footer");
		assertName(new GridTabSQLInsertExporter(), "Print Header/Footer", "Print_Header_Footer");
		assertName(new GridTab2PackExporter(), "Print Header/Footer", "Print_Header_Footer");
	}

	@Test
	public void testNonLatinTabNameUsesTableName() {
		assertName(new GridTabExcelExporter(), "\u8ba2\u5355\u884c", "C_OrderLine");
		assertName(new GridTabXLSXExporter(), "\u0421\u0442\u0440\u043e\u043a\u0430 \u0437\u0430\u043a\u0430\u0437\u0430", "C_OrderLine");
	}

	@Test
	public void testAccentsAndSpaces() {
		assertName(new GridTabXLSXExporter(), "Řádek Nákupní Objednávky", "Radek_Nakupni_Objednavky");
		assertName(new GridTabExcelExporter(), "PO Line", "PO_Line");
	}
}
