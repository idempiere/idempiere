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
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;

import java.util.Properties;

import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

public class POFindParameterTest {

	@ParameterizedTest
	@ValueSource(strings = { "Großformat", "Straße", "Änderung", "Österreich", "İstanbul", "Standard" })
	void testPreservesCaseAndAddsWildcard(String searchValue) {
		assertEquals(searchValue + "%", FindParameterPO.getFindParameterForTest(searchValue));
	}

	@Test
	void testPreservesExistingWildcard() {
		assertEquals("Großformat%", FindParameterPO.getFindParameterForTest("Großformat%"));
	}

	@Test
	void testIgnoresEmptySearchValues() {
		assertNull(FindParameterPO.getFindParameterForTest(null));
		assertNull(FindParameterPO.getFindParameterForTest(""));
		assertNull(FindParameterPO.getFindParameterForTest("%"));
	}

	private static final class FindParameterPO extends PO {

		private static final long serialVersionUID = 1L;

		private FindParameterPO() {
			super(new Properties());
		}

		private static String getFindParameterForTest(String query) {
			return getFindParameter(query);
		}

		@Override
		protected POInfo initPO(Properties ctx) {
			return null;
		}

		@Override
		protected int get_AccessLevel() {
			return 0;
		}
	}
}
