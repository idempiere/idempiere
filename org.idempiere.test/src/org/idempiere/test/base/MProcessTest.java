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
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.TestInstance;

/**
 * Comprehensive JUnit 5 tests for {@link MProcess}.
 * 
 * @author etantg
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class MProcessTest extends AbstractTestCase {

	private final Properties ctx = Env.getCtx();
	private final int testProcessId = DictionaryIDs.AD_Process.CACHE_RESET.id;
	private String testProcessUUID;
	private String testProcessValue;

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		// System client, SuperUser and System Administrator role
		return new LoginDetails(0, 0, 0, 0, 0, new Timestamp(System.currentTimeMillis()),
				Language.getLanguage("en_US"));
	}

	/**
	 * Fetch stable AD_Process UUID and Value from DB before running tests.
	 */
	@BeforeAll
	public void beforeAll() {
		testProcessUUID = DB.getSQLValueString(null, "SELECT AD_Process_UU FROM AD_Process WHERE AD_Process_ID=?", testProcessId);
		assertNotNull(testProcessUUID, "AD_Process_UU must be present for the selected process");

		testProcessValue = DB.getSQLValueString(null, "SELECT Value FROM AD_Process WHERE AD_Process_ID=?", testProcessId);
		assertNotNull(testProcessValue, "Value must be present for the selected process");
	}

	/**
	 * Test ID-based constructor: MProcess(Properties ctx, int AD_Process_ID, String
	 * trxName)
	 */
	@Test
	public void testConstructor_ByID() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		assertNotNull(p, "MProcess constructed by ID should not be null");
		assertEquals(testProcessId, p.getAD_Process_ID(), "Loaded MProcess must have expected AD_Process_ID");
	}

	/**
	 * Test UUID-based constructor: MProcess(Properties ctx, String AD_Process_UU,
	 * String trxName)
	 */
	@Test
	public void testConstructor_ByUUID() {
		MProcess p = new MProcess(ctx, testProcessUUID, getTrxName());
		assertNotNull(p, "MProcess constructed by UUID should not be null");
		assertEquals(testProcessId, p.getAD_Process_ID(), "MProcess loaded by UUID should map to same AD_Process_ID");
	}

	/**
	 * Test ResultSet-based constructor: MProcess(Properties ctx, ResultSet rs,
	 * String trxName)
	 */
	@Test
	public void testConstructor_FromResultSet() throws SQLException {
		String sql = "SELECT * FROM AD_Process WHERE AD_Process_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName());
			pstmt.setInt(1, testProcessId);
			rs = pstmt.executeQuery();
			assertTrue(rs.next(), "ResultSet must contain at least one row for AD_Process");

			MProcess p = new MProcess(ctx, rs, getTrxName());
			assertNotNull(p, "MProcess constructed from ResultSet should not be null");
			assertEquals(testProcessId, p.getAD_Process_ID(), "MProcess(ResultSet) must have expected AD_Process_ID");
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ignored) {}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ignored) {}
		}
	}

	/**
	 * Test copy constructors: MProcess(ctx, copy) and MProcess(ctx, copy, trxName).
	 */
	@Test
	public void testConstructor_Copy() {
		MProcess original = new MProcess(ctx, testProcessId, getTrxName());
		MProcess copy1 = new MProcess(ctx, original);
		assertNotNull(copy1, "Copy constructor MProcess(ctx, original) should produce an instance");
		assertEquals(original.getName(), copy1.getName(), "Copied MProcess should keep the same Name");

		MProcess copy2 = new MProcess(ctx, original, getTrxName());
		assertNotNull(copy2, "Copy constructor MProcess(ctx, original, trxName) should produce an instance");
		assertEquals(original.getAD_Process_ID(), copy2.getAD_Process_ID(), "Copied MProcess should keep the same AD_Process_ID when copy constructor preserves it");
	}

	/**
	 * Test isDatabaseProcedure() boolean flag declared in MProcess.
	 */
	@Test
	public void testIsDatabaseProcedure() {
		MProcess p = new MProcess(ctx, DictionaryIDs.AD_Process.DBA_RECOMPILE.id, getTrxName());
		assertTrue(p.isDatabaseProcedure(), "Should be a database procedure");
	}

	/**
	 * Test isForceBackground() boolean flag declared in MProcess.
	 */
	@Test
	public void testIsForceBackground() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		assertFalse(p.isForceBackground(), "Should not be force to run in background");
	}

	/**
	 * Test isForceForeground() boolean flag declared in MProcess.
	 */
	@Test
	public void testIsForceForeground() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		assertFalse(p.isForceForeground(), "Should not be force to run in foreground");
	}

	/**
	 * Test isJavaProcess() boolean flag declared in MProcess.
	 */
	@Test
	public void testIsJavaProcess() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		assertTrue(p.isJavaProcess(), "Should be a Java process");
	}

	/**
	 * Test isWorkflow() boolean flag declared in MProcess.
	 */
	@Test
	public void testIsWorkflow() {
		MProcess p = new MProcess(ctx, DictionaryIDs.AD_Process.C_ORDER_PROCESS.id, getTrxName());
		assertTrue(p.isWorkflow(), "Should be a workflow");
	}

	/**
	 * Test getters, getParameters() and getParameter(name).
	 */
	@Test
	public void testGettersAndParameters() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		assertNotNull(p.getName(), "getName() should return a non-null value");
		MProcessPara[] params = p.getParameters();
		assertNotNull(params, "getParameters() should return non-null array (may be empty)");
		MProcessPara param = p.getParameter("NonExistentParameter");
		assertTrue(param == null, "getParameter for a non-existent name should return null");
	}

	/**
	 * Test toString() method.
	 */
	@Test
	public void testToString() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		String s = p.toString();
		assertNotNull(s, "toString() must not return null");
		assertTrue(s.length() > 0, "toString() should contain content");
		assertTrue(s.contains(p.getName()), "toString should contain the Name");
	}

	/**
	 * Test static cache behaviour: MProcess.get(ctx, id) and get(id) should return
	 * cached instance.
	 */
	@Test
	public void testStaticCacheBehavior() {
		MProcess a = MProcess.get(ctx, testProcessId);
		MProcess b = MProcess.get(ctx, testProcessId);
		assertSame(a, b, "MProcess.get(ctx, id) should return the same cached immutable instance");

		MProcess c = MProcess.get(testProcessId);
		assertNotNull(c, "MProcess.get(id) should return an instance");
	}

	/**
	 * Test getProcess_ID(value, trxName) helper.
	 */
	@Test
	public void testGetProcessIDHelper() {
		int id = MProcess.getProcess_ID(testProcessValue, getTrxName());
		assertEquals(testProcessId, id, "getProcess_ID(value) should return expected AD_Process_ID");

		id = MProcess.getProcess_ID("NonExistentProcess", getTrxName());
		assertTrue(id == 0 || id == -1, "Non-existent process should return 0 or -1");
	}

	/**
	 * Test mandatory validation: saving a new MProcess without mandatory fields
	 * should fail.
	 */
	@Test
	public void testMandatoryFieldValidation() {
		MProcess p = new MProcess(ctx, 0, getTrxName());
		assertThrows(Exception.class, () -> {
			p.saveEx();
		}, "Should throw exception when without mandatory fields");
	}

	/**
	 * Test creating a persistent process by copying an existing one, modifying
	 * required fields, saving and cleaning up via delete(true, trxName).
	 */
	@Test
	public void testCreatePersistentObjectByCopyAndCleanup() {
		MProcess editable = MProcess.getCopy(ctx, testProcessId, getTrxName());
		assertNotNull(editable, "getCopy should return an editable MProcess instance");
		String unique = "T_TEST_PROCESS_" + System.currentTimeMillis();
		try {
			editable.setName("Test Process " + unique);
			editable.setValue("T_TEST_PROC_" + unique);
			boolean saved = editable.save();
			assertTrue(saved, "Copied MProcess should save after modifying mandatory fields");
			assertTrue(editable.get_ID() > 0, "Saved MProcess must have an assigned AD_Process_ID");
		} finally {
			try {
				if (editable.get_ID() > 0)
					editable.delete(true, getTrxName());
			} catch (Exception ex) {}
		}
	}

}
