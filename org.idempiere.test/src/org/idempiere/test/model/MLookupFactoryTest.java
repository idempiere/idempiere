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
 * - Norbert Bede - CloudEmpiere                                       *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.compiere.model.MBPartner;
import org.compiere.model.MColumn;
import org.compiere.model.MLandedCost;
import org.compiere.model.MLandedCostAllocation;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * Tests for {@link MLookupFactory} on tables without an IsActive column.<br/>
 * The Record ID editor shows a record's identifier through a Search lookup on the table's key column.
 * For C_LandedCost and C_LandedCostAllocation that lookup must not select a non-existent IsActive column.
 */
public class MLookupFactoryTest extends AbstractTestCase {

	public MLookupFactoryTest() {
	}

	@Test
	public void testLookupOnLandedCost() {
		assertNull(MColumn.get(Env.getCtx(), MLandedCost.Table_Name, "IsActive"), "C_LandedCost is expected to have no IsActive column");
		MLookupInfo info = getKeyLookupInfo(MLandedCost.Table_Name);
		assertFalse(info.QueryDirect.contains(MLandedCost.Table_Name + ".IsActive"), info.QueryDirect);
		// the direct query must run; an unknown key returns no row
		assertNull(DB.getSQLValueStringEx(getTrxName(), info.QueryDirect, -1));
	}

	@Test
	public void testLookupOnLandedCostAllocation() {
		assertNull(MColumn.get(Env.getCtx(), MLandedCostAllocation.Table_Name, "IsActive"), "C_LandedCostAllocation is expected to have no IsActive column");
		MLookupInfo info = getKeyLookupInfo(MLandedCostAllocation.Table_Name);
		assertFalse(info.QueryDirect.contains(MLandedCostAllocation.Table_Name + ".IsActive"), info.QueryDirect);
		assertNull(DB.getSQLValueStringEx(getTrxName(), info.QueryDirect, -1));
	}

	@Test
	public void testLookupOnTableWithIsActive() {
		MLookupInfo info = getKeyLookupInfo(MBPartner.Table_Name);
		assertTrue(info.QueryDirect.contains(MBPartner.Table_Name + ".IsActive"), info.QueryDirect);
	}

	/**
	 * Get the lookup built by the Record ID editor: Search on the table's key column
	 * @param tableName
	 * @return lookup info
	 */
	private MLookupInfo getKeyLookupInfo(String tableName) {
		MColumn key = MColumn.get(Env.getCtx(), tableName, tableName + "_ID");
		assertNotNull(key, tableName + "_ID");
		MLookupInfo info = MLookupFactory.getLookupInfo(Env.getCtx(), 0, 0, key.getAD_Column_ID(), DisplayType.Search);
		assertNotNull(info, tableName);
		return info;
	}
}
