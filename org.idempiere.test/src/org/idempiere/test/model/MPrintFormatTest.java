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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.print.MPrintFormat;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author hengsin
 *
 */
public class MPrintFormatTest extends AbstractTestCase {

	@Test
	public void testCopyConstructor() {
		int orderHeader = 118;
		
		MPrintFormat pf = new MPrintFormat(Env.getCtx(), orderHeader, getTrxName());
		MPrintFormat copy = new MPrintFormat(pf);
		assertFalse(copy.is_new());
		assertFalse(copy.is_Changed());
		assertNull(copy.get_TrxName());
		assertTrue(copy.get_ID() == pf.get_ID());
		assertTrue(pf.equals(copy));
		int count = pf.get_ColumnCount();
		for(int i = 0; i < count; i++)
			assertEquals(pf.get_Value(i), copy.get_Value(i));
		
		copy.set_TrxName(getTrxName());
		String copyDescription = copy.getDescription() + " copy";
		copy.setDescription(copyDescription);
		assertTrue(copy.is_Changed());
		copy.saveEx();
		
		pf.load(getTrxName());
		assertEquals(copyDescription, pf.getDescription());
	}
}
