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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MColumn;
import org.compiere.model.MStyle;
import org.compiere.model.MStyleLine;
import org.compiere.model.MTest;
import org.compiere.util.CacheMgt;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 *
 * @author Carlos Ruiz - globalqss - bxservice
 *
 */
@Isolated
public class ModelForeignKeyTest extends AbstractTestCase {

	public ModelForeignKeyTest() {
	}

	@Test
	public void testModelCascadeRecordId() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		// set model cascade on Test.Record_ID
		MColumn col_test_record_id = new MColumn(ctx, MColumn.getColumn_ID(MTest.Table_Name, MTest.COLUMNNAME_Record_ID), trxName);
		col_test_record_id.setFKConstraintType(MColumn.FKCONSTRAINTTYPE_ModelCascade);
		col_test_record_id.saveCrossTenantSafeEx();

		MTest test1 = new MTest(ctx, 0, trxName);
		test1.setName("Test 1");
		test1.saveEx();
		MTest test2 = new MTest(ctx, 0, trxName);
		test2.setName("Test 2");
		test2.saveEx();
		test1.setAD_Table_ID(MTest.Table_ID);
		test1.setRecord_ID(test2.getTest_ID());
		test1.saveEx();

		CacheMgt.get().reset();
		test2.deleteEx(true);
		test1.load(trxName);
		assertTrue(test1.get_ID() == 0);
	}

	@Test
	public void testModelSetNullRecordId() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		// set model cascade on Test.Record_ID
		MColumn col_test_record_id = new MColumn(ctx, MColumn.getColumn_ID(MTest.Table_Name, MTest.COLUMNNAME_Record_ID), trxName);
		col_test_record_id.setFKConstraintType(MColumn.FKCONSTRAINTTYPE_ModelSetNull);
		col_test_record_id.saveCrossTenantSafeEx();
		CacheMgt.get().reset();

		MTest test1 = new MTest(ctx, 0, trxName);
		test1.setName("Test 1");
		test1.saveEx();
		MTest test2 = new MTest(ctx, 0, trxName);
		test2.setName("Test 2");
		test2.saveEx();
		test1.setAD_Table_ID(MTest.Table_ID);
		test1.setRecord_ID(test2.getTest_ID());
		test1.saveEx();

		test2.deleteEx(true);
		test1.load(trxName);
		assertTrue(test1.get_ID() > 0);
		assertTrue(test1.getRecord_ID() == 0);
	}

	@Test
	public void testModelNoActionRecordId() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		// set model cascade on Test.Record_ID
		MColumn col_test_record_id = new MColumn(ctx, MColumn.getColumn_ID(MTest.Table_Name, MTest.COLUMNNAME_Record_ID), trxName);
		col_test_record_id.setFKConstraintType(MColumn.FKCONSTRAINTTYPE_ModelNoAction_ForbidDeletion);
		col_test_record_id.saveCrossTenantSafeEx();
		CacheMgt.get().reset();

		MTest test1 = new MTest(ctx, 0, trxName);
		test1.setName("Test 1");
		test1.saveEx();
		MTest test2 = new MTest(ctx, 0, trxName);
		test2.setName("Test 2");
		test2.saveEx();
		test1.setAD_Table_ID(MTest.Table_ID);
		test1.setRecord_ID(test2.getTest_ID());
		test1.saveEx();

		assertThrows(AdempiereException.class, () -> {
			test2.deleteEx(true);
		});
	}

	@Test
	public void testDBNoAction() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		// set model cascade on Test.Record_ID
		CacheMgt.get().reset();
		MColumn col_styleline_style = new MColumn(ctx, MColumn.getColumn_ID(MStyleLine.Table_Name, MStyleLine.COLUMNNAME_AD_Style_ID), trxName);
		// this is the default already set in database
		assertTrue(MColumn.FKCONSTRAINTTYPE_NoAction_ForbidDeletion.equals(col_styleline_style.getFKConstraintType()));

		MStyle style = new MStyle(ctx, 0, trxName);
		style.setName("Test");
		style.saveEx();
		MStyleLine styleLine = new MStyleLine(ctx, 0, trxName);
		styleLine.setAD_Style_ID(style.getAD_Style_ID());
		styleLine.setLine(10);
		styleLine.setInlineStyle("Test");
		styleLine.saveEx();
		style.deleteEx(true);

		assertThrows(
				Exception.class,
				() ->  Trx.get(trxName, false).commit(true),
				"Expected Trx.commit to throw Exception, but it didn't"
				);
	}

	@Test
	public void testModelNoAction() {
		Properties ctx = Env.getCtx();
		String trxName = getTrxName();

		// set model cascade on Test.Record_ID
		MColumn col_styleline_style = new MColumn(ctx, MColumn.getColumn_ID(MStyleLine.Table_Name, MStyleLine.COLUMNNAME_AD_Style_ID), trxName);
		col_styleline_style.setFKConstraintType(MColumn.FKCONSTRAINTTYPE_ModelCascade);
		col_styleline_style.saveCrossTenantSafeEx();
		CacheMgt.get().reset();

		MStyle style = new MStyle(ctx, 0, trxName);
		style.setName("Test");
		style.saveEx();
		MStyleLine styleLine = new MStyleLine(ctx, 0, trxName);
		styleLine.setAD_Style_ID(style.getAD_Style_ID());
		styleLine.setLine(10);
		styleLine.setInlineStyle("Test");
		styleLine.saveEx();

		style.deleteEx(true);
		styleLine.load(trxName);
		assertTrue(styleLine.get_ID() == 0);
	}

}
