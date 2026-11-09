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
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.concurrent.atomic.AtomicBoolean;

import org.compiere.db.AdempiereDatabase;
import org.compiere.db.Database;
import org.compiere.db.ProxyFactory;
import org.compiere.model.MTest;
import org.compiere.util.CPreparedStatement;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;

/**
 * Unit tests for INSERT INTO ... RETURNING * functionality across AdempiereDatabase,
 * DB_PostgreSQL, DB_Oracle, DB, and PO.
 */
public class POInsertReturningTest extends AbstractTestCase {

	@Test
	public void testAdempiereDatabaseDefaultSupport() {
		AdempiereDatabase mockDb = mock(AdempiereDatabase.class, org.mockito.Mockito.CALLS_REAL_METHODS);
		assertFalse(mockDb.isInsertReturningSupported(), "AdempiereDatabase default should return false");
	}


	@Test
	public void testDB_PostgreSQL_Support() throws Exception {
		AdempiereDatabase pg = Database.getDatabase(Database.DB_POSTGRESQL);
		assertNotNull(pg, "Failed to retrieve PostgreSQL DB provider");
		assertTrue(pg.isInsertReturningSupported(), "PostgreSQL should support INSERT RETURNING by default");
	}

	@Test
	public void testDB_Oracle_Support() throws Exception {
		AdempiereDatabase oracle = Database.getDatabase(Database.DB_ORACLE);
		assertNotNull(oracle, "Failed to retrieve Oracle DB provider");
		assertFalse(oracle.isInsertReturningSupported(), "Oracle should NOT support INSERT INTO ... RETURNING *");
	}

	@Test
	public void testDB_isInsertReturningSupported_Delegation() {
		try (MockedStatic<DB> dbMock = mockStatic(DB.class, org.mockito.Mockito.CALLS_REAL_METHODS)) {
			AdempiereDatabase mockPg = mock(AdempiereDatabase.class);
			when(mockPg.isInsertReturningSupported()).thenReturn(true);
			dbMock.when(DB::getDatabase).thenReturn(mockPg);
			assertTrue(DB.isInsertReturningSupported(), "DB.isInsertReturningSupported should return true when database supports it");

			AdempiereDatabase mockOracle = mock(AdempiereDatabase.class);
			when(mockOracle.isInsertReturningSupported()).thenReturn(false);
			dbMock.when(DB::getDatabase).thenReturn(mockOracle);
			assertFalse(DB.isInsertReturningSupported(), "DB.isInsertReturningSupported should return false when database does not support it");

			dbMock.when(DB::getDatabase).thenReturn(null);
			assertFalse(DB.isInsertReturningSupported(), "DB.isInsertReturningSupported should return false when getDatabase is null");
		}
	}

	@Test
	public void testExecuteInsertReturning_Validation() {
		assertThrows(IllegalArgumentException.class, () -> {
			DB.executeInsertReturning(null, (Object[]) null, null, null);
		}, "Null SQL should throw IllegalArgumentException");

		assertThrows(IllegalArgumentException.class, () -> {
			DB.executeInsertReturning("", (Object[]) null, null, null);
		}, "Empty SQL should throw IllegalArgumentException");
	}

	@Test
	public void testExecuteInsertReturning_SuccessWithLoader() throws SQLException {
		try (MockedStatic<ProxyFactory> proxyMock = mockStatic(ProxyFactory.class)) {
			CPreparedStatement mockStmt = mock(CPreparedStatement.class);
			ResultSet mockRs = mock(ResultSet.class);

			proxyMock.when(() -> ProxyFactory.newCPreparedStatement(anyInt(), anyInt(), anyString(), anyString()))
					.thenReturn(mockStmt);

			when(mockStmt.executeQuery()).thenReturn(mockRs);
			when(mockRs.next()).thenReturn(true);

			AtomicBoolean loaderCalled = new AtomicBoolean(false);
			boolean success = DB.executeInsertReturning("INSERT INTO Test (ID) VALUES (?) RETURNING *",
					new Object[] { 100 }, getTrxName(), rs -> {
						loaderCalled.set(true);
						return true;
					});

			assertTrue(success, "executeInsertReturning should return true on success");
			assertTrue(loaderCalled.get(), "Loader should have been invoked");
		}
	}

	@Test
	public void testExecuteInsertReturning_ZeroRowsReturned() throws SQLException {
		try (MockedStatic<ProxyFactory> proxyMock = mockStatic(ProxyFactory.class)) {
			CPreparedStatement mockStmt = mock(CPreparedStatement.class);
			ResultSet mockRs = mock(ResultSet.class);

			proxyMock.when(() -> ProxyFactory.newCPreparedStatement(anyInt(), anyInt(), anyString(), anyString()))
					.thenReturn(mockStmt);

			when(mockStmt.executeQuery()).thenReturn(mockRs);
			when(mockRs.next()).thenReturn(false);

			AtomicBoolean loaderCalled = new AtomicBoolean(false);
			boolean success = DB.executeInsertReturning("INSERT INTO Test (ID) VALUES (?) RETURNING *",
					new Object[] { 100 }, getTrxName(), rs -> {
						loaderCalled.set(true);
						return true;
					});

			assertFalse(success, "executeInsertReturning should return false when no row is returned");
			assertFalse(loaderCalled.get(), "Loader should not be invoked when rs.next() is false");
			verify(mockRs, times(1)).close();
			verify(mockStmt, times(1)).close();
		}
	}

	@Test
	public void testExecuteInsertReturning_SQLExceptionHandling() throws SQLException {
		try (MockedStatic<ProxyFactory> proxyMock = mockStatic(ProxyFactory.class)) {
			CPreparedStatement mockStmt = mock(CPreparedStatement.class);

			proxyMock.when(() -> ProxyFactory.newCPreparedStatement(anyInt(), anyInt(), anyString(), anyString()))
					.thenReturn(mockStmt);

			when(mockStmt.executeQuery()).thenThrow(new SQLException("Unique constraint violation", "23505"));

			boolean success = DB.executeInsertReturning("INSERT INTO Test (ID) VALUES (?) RETURNING *",
					new Object[] { 100 }, getTrxName(), rs -> true);

			assertFalse(success, "executeInsertReturning should catch SQLException and return false");
			verify(mockStmt, times(1)).close();
		}
	}

	@Test
	public void testExecuteInsertReturning_LoaderFailure() throws SQLException {
		try (MockedStatic<ProxyFactory> proxyMock = mockStatic(ProxyFactory.class)) {
			CPreparedStatement mockStmt = mock(CPreparedStatement.class);
			ResultSet mockRs = mock(ResultSet.class);

			proxyMock.when(() -> ProxyFactory.newCPreparedStatement(anyInt(), anyInt(), anyString(), anyString()))
					.thenReturn(mockStmt);

			when(mockStmt.executeQuery()).thenReturn(mockRs);
			when(mockRs.next()).thenReturn(true);

			boolean success = DB.executeInsertReturning("INSERT INTO Test (ID) VALUES (?) RETURNING *",
					new Object[] { 100 }, getTrxName(), rs -> false);

			assertFalse(success, "executeInsertReturning should return false when loader returns false");
			verify(mockRs, times(1)).close();
			verify(mockStmt, times(1)).close();
		}
	}

	@Test
	public void testExecuteInsertReturning_WithTimeout() throws SQLException {
		try (MockedStatic<ProxyFactory> proxyMock = mockStatic(ProxyFactory.class)) {
			CPreparedStatement mockStmt = mock(CPreparedStatement.class);
			ResultSet mockRs = mock(ResultSet.class);

			proxyMock.when(() -> ProxyFactory.newCPreparedStatement(anyInt(), anyInt(), anyString(), anyString()))
					.thenReturn(mockStmt);

			when(mockStmt.executeQuery()).thenReturn(mockRs);
			when(mockRs.next()).thenReturn(true);

			boolean success = DB.executeInsertReturning("INSERT INTO Test (ID) VALUES (?) RETURNING *",
					new Object[] { 100 }, getTrxName(), rs -> true, 30);

			assertTrue(success);
			verify(mockStmt, times(1)).setQueryTimeout(30);
		}
	}

	@Test
	public void testExecuteInsertReturning_ExceptionInStatementCreation() {
		try (MockedStatic<ProxyFactory> proxyMock = mockStatic(ProxyFactory.class)) {
			proxyMock.when(() -> ProxyFactory.newCPreparedStatement(anyInt(), anyInt(), anyString(), anyString()))
					.thenThrow(new RuntimeException("Failed to create statement"));

			assertThrows(RuntimeException.class, () -> {
				DB.executeInsertReturning("INSERT INTO Test (ID) VALUES (?) RETURNING *",
						new Object[] { 100 }, getTrxName(), rs -> true);
			});
		}
	}

	@Test
	public void testPOSave_UsesInsertReturning() {
		Assumptions.assumeTrue(DB.isInsertReturningSupported(), "Database does not support INSERT INTO ... RETURNING *");
		String name = "RET_" + System.nanoTime();
		int testId;
		try (MockedStatic<DB> dbMock = mockStatic(DB.class, org.mockito.Mockito.CALLS_REAL_METHODS)) {
			MTest test = new MTest(Env.getCtx(), 0, getTrxName());
			test.setName(name);
			test.setT_Integer(42);
			assertTrue(test.save(), "PO.save should succeed");

			dbMock.verify(() -> DB.executeInsertReturning(anyString(), any(), any(), any()));

			testId = test.getTest_ID();
			assertEquals(name, test.getName(), "RETURNING should load the inserted values");
			assertEquals(42, test.getT_Integer(), "RETURNING should load the inserted values");
		}
		assertTrue(testId > 0, "Inserted record should have a generated key");

		MTest loaded = new MTest(Env.getCtx(), testId, getTrxName());
		assertEquals(name, loaded.getName(), "Saved record should be readable from the database");
		assertEquals(42, loaded.getT_Integer());
	}

	@Test
	public void testPOSave_InsertReturning_ReloadsLob() {
		Assumptions.assumeTrue(DB.isInsertReturningSupported(), "Database does not support INSERT INTO ... RETURNING *");
		byte[] data = new byte[] { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
		String name = "RET_LOB_" + System.nanoTime();
		int testId;
		try (MockedStatic<DB> dbMock = mockStatic(DB.class, org.mockito.Mockito.CALLS_REAL_METHODS)) {
			MTest test = new MTest(Env.getCtx(), name, 43, getTrxName());
			test.setBinaryData(data);
			assertTrue(test.save(), "PO.save with a LOB column should succeed");

			dbMock.verify(() -> DB.executeInsertReturning(anyString(), any(), any(), any()));

			testId = test.getTest_ID();
			assertArrayEquals(data, test.getBinaryData(), "LOB should be saved and reloaded");
		}

		MTest loaded = new MTest(Env.getCtx(), testId, getTrxName());
		assertArrayEquals(data, loaded.getBinaryData(), "LOB should be readable from the database");
	}

	@Test
	public void testPOSave_FallsBackWhenInsertReturningUnsupported() {
		String name = "NORET_" + System.nanoTime();
		int testId;
		try (MockedStatic<DB> dbMock = mockStatic(DB.class, org.mockito.Mockito.CALLS_REAL_METHODS)) {
			dbMock.when(DB::isInsertReturningSupported).thenReturn(false);

			MTest test = new MTest(Env.getCtx(), 0, getTrxName());
			test.setName(name);
			assertTrue(test.save(), "PO.save should succeed without INSERT ... RETURNING support");

			dbMock.verify(() -> DB.executeInsertReturning(anyString(), any(), any(), any()), never());

			testId = test.getTest_ID();
			assertEquals(name, test.getName());
		}
		assertTrue(testId > 0, "Inserted record should have a generated key");

		MTest loaded = new MTest(Env.getCtx(), testId, getTrxName());
		assertEquals(name, loaded.getName(), "Saved record should be readable from the database");
	}

	@Test
	public void testPOSave_UpdateAfterInsert() {
		String name = "UPD_" + System.nanoTime();
		MTest test = new MTest(Env.getCtx(), name, 45, getTrxName());
		assertTrue(test.save(), "PO.save should succeed");
		int testId = test.getTest_ID();
		assertTrue(testId > 0, "Inserted record should have a generated key");

		String description = "Updated " + name;
		test.setDescription(description);
		assertTrue(test.save(), "PO.save should update the existing record");

		assertEquals(testId, test.getTest_ID(), "Update should not change the key");
		MTest loaded = new MTest(Env.getCtx(), testId, getTrxName());
		assertEquals(description, loaded.getDescription(), "Updated value should be readable from the database");
	}
}
