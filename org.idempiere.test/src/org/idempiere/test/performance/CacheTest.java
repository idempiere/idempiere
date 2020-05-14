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
package org.idempiere.test.performance;

import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.MOrder;
import org.compiere.model.MZoomCondition;
import org.compiere.util.CacheMgt;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * 
 * @author hengsin
 *
 */
public class CacheTest extends AbstractTestCase {

	public CacheTest() {
	}
	
	@Test
	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-2698
	 */
	public void testZoomConditionCache() {
		MZoomCondition[] conditions1 = MZoomCondition.getConditions(MOrder.Table_ID);
		assertTrue(conditions1 != null && conditions1.length > 0);
		MZoomCondition[] conditions2 = MZoomCondition.getConditions(MOrder.Table_ID);
		assertTrue(conditions2 != null && conditions2.length > 0);
		assertTrue(conditions1 == conditions2);
		CacheMgt.get().reset();
		MZoomCondition[] conditions3 = MZoomCondition.getConditions(MOrder.Table_ID);
		assertTrue(conditions3 != null && conditions3.length == conditions1.length);
		assertTrue(conditions1 != conditions3);
	}
}
