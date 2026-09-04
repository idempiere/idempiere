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
 * - Logilite Techonologies                         				   *
 **********************************************************************/
package org.idempiere.test.adwindow;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Properties;

import org.compiere.model.GridField;
import org.compiere.model.GridFieldVO;
import org.compiere.model.GridTab;
import org.compiere.model.GridTable;
import org.compiere.model.MInvoice;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.idempiere.db.util.SQLFragment;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * @author Logilite Technologies
 */
public class GridTableTest extends AbstractTestCase
{

	public GridTableTest()
	{
	}

	@Test
	public void testVirtualColumnContextValueIsRefreshedOnRequery()
	{
		int windowNo = 3;
		Properties ctx = Env.getCtx();
		Env.setContext(ctx, windowNo, "#AD_User_ID", "100");

		GridTable table = new GridTable(ctx, MInvoice.Table_ID, MInvoice.Table_Name, windowNo, 0, false);

		GridFieldVO vo = GridFieldVO.createParameter(	ctx, windowNo, 0, 0, 0, "IsEligibleForAccess", "IsEligibleForAccess",
														DisplayType.YesNo, 0, false, false, null);
		vo.ColumnSQL = "(CASE WHEN @#AD_User_ID@ = 123 THEN 'Y' ELSE 'N' END)";

		GridField field = new GridField(vo);
		table.addField(field);
		assertEquals(1, table.getColumnCount(), "Field was not added - check column access");

		assertTrue(table.open(0), "table.open(0) failed for " + MInvoice.Table_Name);

		String sql1 = Env.getContext(ctx, windowNo, 0, GridTab.CTX_SQL);
		assertNotNull(sql1, "CTX_SQL is null after open() - createSelectSql() returned early");
		assertTrue(sql1.contains("WHEN 100 = 123"), "Context value '100' not substituted into virtual column. SQL: " + sql1);
		assertFalse(sql1.contains("WHEN 111 = 123"), "SELECT already has '111' before context change - stale context. SQL: " + sql1);

		Env.setContext(ctx, windowNo, "#AD_User_ID", "111");

		assertTrue(table.dataRequery(new SQLFragment("2=3"), false, 1), "failed to requery");

		String sql2 = Env.getContext(ctx, windowNo, 0, GridTab.CTX_SQL);
		assertNotNull(sql2, "CTX_SQL is null after requery - createSelectSql() returned early");
		assertTrue(sql2.contains("WHEN 111 = 123"), "Context value '111' not substituted into virtual column after requery. SQL: " + sql2);
		assertFalse(sql2.contains("WHEN 100 = 123"), "Requeried SELECT still has stale value '100' - context not refreshed. SQL: " + sql2);

		table.close(true);
	} // testVirtualColumnContextValueIsRefreshedOnRequery
}
