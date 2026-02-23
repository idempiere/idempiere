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

import static org.assertj.core.api.Assertions.fail;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNotSame;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.doReturn;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.spy;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Savepoint;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.util.DB;
import org.compiere.util.Trx;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * Comprehensive JUnit 5 tests for {@link Trx}.
 * 
 * @author etantg
 */
@Isolated
public class TrxTest extends AbstractTestCase {
	
	/**
	 * Test cases for Trx.createTrxName methods
	 */
	@Test
	public void testCreateTrxNameMethods() {
		Trx defaultTrx = null;
		Trx prefixedTrx = null;
		try {
		    String trxNameDefault = Trx.createTrxName();
		    assertNotNull(trxNameDefault, "Transaction name should not be null");
		    assertTrue(trxNameDefault.startsWith("Trx_"), "Default transaction name should start with 'Trx_'");
	
		    String[] defaultParts = trxNameDefault.split("_", 2);
		    assertEquals(2, defaultParts.length, "Default transaction name should contain prefix and UUID");
	
		    defaultTrx = Trx.get(trxNameDefault, false);
		    assertNotNull(defaultTrx, "Trx instance should be created for default transaction name");
	
		    String prefix = "JUnitTest";
		    String trxNamePrefixed = Trx.createTrxName(prefix);
	
		    assertNotNull(trxNamePrefixed, "Prefixed transaction name should not be null");
		    assertTrue(trxNamePrefixed.startsWith(prefix + "_"), "Prefixed transaction name should start with provided prefix");
	
		    String[] prefixedParts = trxNamePrefixed.split("_", 2);
		    assertEquals(2, prefixedParts.length, "Prefixed transaction name should contain prefix and UUID");
	
		    prefixedTrx = Trx.get(trxNamePrefixed, false);
		    assertNotNull(prefixedTrx, "Trx instance should be created for prefixed transaction name");
		} finally {
			if (defaultTrx != null)
				defaultTrx.close();
			if (prefixedTrx != null)
				prefixedTrx.close();
		}
	}
	
	/**
	 * Test cases for Trx.get(String, boolean)
	 */
	@Test
	public void testGet() {
		Trx noCreateTrx = null;
		Trx createdTrx = null;
		Trx cachedTrx = null;
		Trx cachedTrxCreateNew = null;
		try {
		    // invalid trx name
		    assertThrows(IllegalArgumentException.class, () -> Trx.get(null, true), "Null transaction name should throw exception");
		    assertThrows(IllegalArgumentException.class, () -> Trx.get("", true), "Empty transaction name should throw exception");
	
		    // not existing, createNew = false
		    String trxNameNoCreate = "JUnit_NoCreate";
		    noCreateTrx = Trx.get(trxNameNoCreate, false);
		    assertNull(noCreateTrx, "Should return null when transaction does not exist and createNew=false");
	
		    // not existing, createNew = true
		    String trxNameCreate = "JUnit_Create";
		    createdTrx = Trx.get(trxNameCreate, true);
		    assertNotNull(createdTrx, "Should create and return transaction when createNew=true");
		    assertEquals(trxNameCreate, createdTrx.getTrxName(), "Transaction name should match input");
	
		    // existing trx, createNew = false
		    cachedTrx = Trx.get(trxNameCreate, false);
		    assertNotNull(cachedTrx, "Should return cached transaction");
		    assertSame(createdTrx, cachedTrx, "Cached transaction instance should be returned");
	
		    // existing trx, createNew = true
		    cachedTrxCreateNew = Trx.get(trxNameCreate, true);
		    assertSame(createdTrx, cachedTrxCreateNew, "Should not create a new instance when transaction already exists");
		} finally {
			if (createdTrx != null)
				createdTrx.close();
		}
	}

	/**
	 * Test cases for Trx.getOpenTransactions()
	 */
	@Test
	public void testGetOpenTransactions() {
		Trx trx1 = null;
		Trx trx2 = null;
		try {
		    Trx[] initial = Trx.getOpenTransactions();
		    assertNotNull(initial, "Returned array must not be null");
	
		    // create first transaction
		    String trxName1 = "JUnit_OpenTrx_1";
		    trx1 = Trx.get(trxName1, true);
		    assertNotNull(trx1, "First transaction should be created");
	
		    Trx[] afterFirst = Trx.getOpenTransactions();
		    assertTrue(Arrays.stream(afterFirst).anyMatch(t -> trxName1.equals(t.getTrxName())), "Created transaction should be present in open transactions");
	
		    // create second transaction
		    String trxName2 = "JUnit_OpenTrx_2";
		    trx2 = Trx.get(trxName2, true);
		    assertNotNull(trx2, "Second transaction should be created");
	
		    Trx[] afterSecond = Trx.getOpenTransactions();
		    assertTrue(Arrays.stream(afterSecond).anyMatch(t -> trxName2.equals(t.getTrxName())), "Second transaction should be present in open transactions");
	
		    // ensure same instances are returned
		    List<Trx> list = Arrays.asList(afterSecond);
		    assertTrue(list.contains(trx1), "Returned array should contain the same trx1 instance");
		    assertTrue(list.contains(trx2), "Returned array should contain the same trx2 instance");
		} finally {
			if (trx1 != null)
				trx1.close();
			if (trx2 != null)
				trx2.close();
		}
	}
	
	/**
	 * Test cases for Trx.registerNullTrx()
	 */
	@Test
	public void testRegisterNullTrx() {
		Trx nullTrx = null;
		try {
		    String nullTrxName = Trx.registerNullTrx();
		    
		    // returned name checks
		    assertNotNull(nullTrxName, "Returned transaction name must not be null");
		    assertTrue(nullTrxName.startsWith("NullTrx_"), "Transaction name must start with 'NullTrx_'");
	
		    // verify transaction is cached
		    nullTrx = Trx.get(nullTrxName, false);
		    assertNotNull(nullTrx, "Transaction must be retrievable from cache");
	
		    // displayName checks (public API)
		    String displayName = nullTrx.getDisplayName();
		    if (displayName != null) {
		        assertFalse(displayName.isEmpty(), "Display name must not be empty if set");
		    }
	
		    // verify new transaction is in the open transactions
		    Trx[] after = Trx.getOpenTransactions();
		    boolean found = false;
		    for (Trx t : after) {
		        if (t == nullTrx) {
		            found = true;
		            break;
		        }
		    }
		    assertTrue(found, "Registered transaction must appear in open transactions");
		} finally {
			if (nullTrx != null)
				nullTrx.close();
		}
	}
	
	/**
	 * Test cases for Trx.run methods
	 */
	@Test
	public void testRunMethods() {
		Trx t1 = null;
		try {
		    int openBefore = Trx.getOpenTransactions().length;
	
		    // normal execution with provided trxName
		    String trxName = Trx.createTrxName("TestRun");
		    final boolean[] ran = {false};
		    Trx.run(trxName, name -> {
		        ran[0] = true;
		        assertEquals(trxName, name, "TrxRunnable should receive correct trxName");
		    });
		    assertTrue(ran[0], "TrxRunnable must have executed");
	
		    // verify transaction exists and is open
		    t1 = Trx.get(trxName, false);
		    assertNotNull(t1, "Transaction must be in cache");
	
		    // normal execution without trxName (auto-created localTrx)
		    final boolean[] ranLocal = {false};
		    Trx.run(trx -> {
		        ranLocal[0] = true;
		        assertNotNull(trx, "TrxRunnable should receive non-null trxName even for localTrx");
		    });
		    assertTrue(ranLocal[0], "Local TrxRunnable must have executed");
	
		    // exception handling: runtime exception
		    RuntimeException rex = assertThrows(RuntimeException.class, () ->
		        Trx.run(name -> {
		            throw new RuntimeException("Test RuntimeException");
		        })
		    );
		    assertEquals("Test RuntimeException", rex.getMessage());
	
		    // exception handling: checked exception wrapped in AdempiereException
		    AdempiereException aex = assertThrows(AdempiereException.class, () ->
		        Trx.run(name -> {
		            throw new AdempiereException("Test CheckedException");
		        })
		    );
		    assertTrue(aex.getMessage().contains("Test CheckedException"));
	
		    // verify open transactions count did not decrease unexpectedly
		    int openAfter = Trx.getOpenTransactions().length;
		    assertTrue(openAfter >= openBefore, "Open transactions should not decrease");
		} finally {
			if (t1 != null)
				t1.close();
		}
	}

	/**
	 * Test cases for Trx.unregisterNullTrx(String)
	 * @throws Exception
	 */
	@Test
	public void testUnregisterNullTrx() throws Exception {
		Trx nullTrx = null;
		Trx removed = null;
		try {
		    String nullTrxName = Trx.registerNullTrx();
		    assertNotNull(nullTrxName, "registerNullTrx should return a non-null name");
	
		    nullTrx = Trx.get(nullTrxName, false);
		    assertNotNull(nullTrx, "Null transaction should exist in cache");
		    assertNotNull(nullTrx.getDisplayName(), "DisplayName should be set");
	
		    // check protected trace field via reflection
		    Field traceField = Trx.class.getDeclaredField("trace");
		    traceField.setAccessible(true);
		    Object traceValue = traceField.get(nullTrx);
		    assertNotNull(traceValue, "Trace should be set for nullTrx");
	
		    // unregister the null transaction
		    Trx.unregisterNullTrx(nullTrxName);
	
		    // verify removed from cache
		    removed = Trx.get(nullTrxName, false);
		    assertNull(removed, "Null transaction should be removed from cache");
	
		    // trace should be null
		    Object traceAfter = traceField.get(nullTrx);
		    assertNull(traceAfter, "Trace should be null after unregister");
		} finally {
			if (nullTrx != null)
				nullTrx.close();
			if (removed != null)
				removed.close();
		}
	}

	/**
	 * Test cases for Trx.close();
	 * @throws Exception
	 */
	@Test
	public void testClose() throws Exception {
	    String trxName = Trx.createTrxName("TestClose");
	    Trx trx = null;
	    Trx cached = null;
	    try {
		    trx = Trx.get(trxName, true);
		    assertNotNull(trx, "Transaction should exist");
	
		    // set private m_connection via reflection
		    Connection mockConn = mock(Connection.class);
		    Field connField = Trx.class.getDeclaredField("m_connection");
		    connField.setAccessible(true);
		    connField.set(trx, mockConn);
	
		    // set trace (protected) via reflection
		    Field traceField = Trx.class.getDeclaredField("trace");
		    traceField.setAccessible(true);
		    traceField.set(trx, new Exception());
	
		    // simulate active transaction
		    Field activeField = Trx.class.getDeclaredField("m_active");
		    activeField.setAccessible(true);
		    activeField.set(trx, true);
	
		    // simulate connection not read-only
		    when(mockConn.isReadOnly()).thenReturn(false);
	
		    // call close
		    boolean result = trx.close();
		    assertTrue(result, "Close should return true");
	
		    // verify commit called
		    verify(mockConn).setAutoCommit(true);
		    verify(mockConn).close();
	
		    // verify cache removed
		    cached = Trx.get(trxName, false);
		    assertNull(cached, "Transaction should be removed from cache");
	
		    // verify internal fields cleared
		    Object traceValue = traceField.get(trx);
		    assertNull(traceValue, "Trace should be null after close");
		    Connection connValue = (Connection) connField.get(trx);
		    assertNull(connValue, "m_connection should be null after close");
		    boolean activeValue = (boolean) activeField.get(trx);
		    assertFalse(activeValue, "m_active should be false after close");
	    } finally {
	    	if (trx != null)
	    		trx.close();
	    	if (cached != null)
	    		cached.close();
	    }
	}

	/**
	 * Test cases for Trx.commit methods
	 * @throws Exception
	 */
	@Test
	public void testCommitMethods() throws Exception {
	    String trxName = Trx.createTrxName("TestCommit");
	    Trx trx = null;
	    try {
		    trx = Trx.get(trxName, true);
		    assertNotNull(trx);
	
		    // set private m_connection via reflection
		    Connection mockConn = mock(Connection.class);
		    Field connField = Trx.class.getDeclaredField("m_connection");
		    connField.setAccessible(true);
		    connField.set(trx, mockConn);
	
		    // set protected m_active via reflection
		    Field activeField = Trx.class.getDeclaredField("m_active");
		    activeField.setAccessible(true);
		    activeField.set(trx, true);
	
		    // normal commit without exception
		    boolean result = trx.commit();
		    assertTrue(result, "commit() should return true");
		    verify(mockConn).commit();
		    assertFalse((boolean) activeField.get(trx), "m_active should be false after commit");
	    } finally {
	    	if (trx != null)
	    		trx.close();
	    }
	}

	/**
	 * Test cases for Trx.getLastWFSavepoint() and Trx.setLastWFSavepoint(Savepoint)
	 * @throws Exception
	 */
	@Test
	public void testLastWFSavepoint() throws Exception {
		Trx trx = null;
		Trx spyTrx = null;
	    Field connField = null;
		try {
		    trx = Trx.get(Trx.createTrxName("TestLastWFSavepoint"), true);
	
		    // Initially, last WF savepoint should be null
		    assertNull(trx.getLastWFSavepoint(), "Initially, last WF savepoint should be null");
	
		    // Create a mock Savepoint
		    Savepoint mockSavepoint = mock(Savepoint.class);
	
		    // Set the last WF savepoint
		    trx.setLastWFSavepoint(mockSavepoint);
	
		    // Verify getter returns the same savepoint
		    assertEquals(mockSavepoint, trx.getLastWFSavepoint(), "Getter should return the savepoint set by setter");
	
		    // Spy trx to stub behavior
		    spyTrx = spy(trx);
	
		    // Create a mock Connection
		    Connection mockConn = mock(Connection.class);
	
		    // Inject the mock Connection into the private m_connection field using reflection
		    connField = Trx.class.getDeclaredField("m_connection");
		    connField.setAccessible(true);
		    connField.set(spyTrx, mockConn);
	
		    // Simulate rollback using the savepoint
		    spyTrx.setLastWFSavepoint(mockSavepoint);
		    doNothing().when(mockConn).rollback(mockSavepoint);
	
		    boolean rollbackResult = spyTrx.rollback(mockSavepoint);
		    assertTrue(rollbackResult, "rollback(Savepoint) should return true when m_connection is set, even if it's a mock");
		    assertEquals(mockSavepoint, spyTrx.getLastWFSavepoint(), "Savepoint should remain after rollback attempt");
		} finally {
			if (connField != null && spyTrx != null)
	            connField.set(spyTrx, null);
			if (trx != null)
	    		trx.close();
		}
	}

	/**
	 * Test cases for Trx.getStartTime()
	 * @throws Exception
	 */
	@Test
	public void testGetStartTime() throws Exception {
	    String trxName = Trx.createTrxName("TestStartTime");
	    Trx trx = null;
	    try {
		    trx = Trx.get(trxName, true);
		    assertNotNull(trx);
	
		    // Set m_startTime via reflection
		    long currentTime = System.currentTimeMillis();
		    Field startTimeField = Trx.class.getDeclaredField("m_startTime");
		    startTimeField.setAccessible(true);
		    startTimeField.setLong(trx, currentTime);
	
		    // Verify getStartTime() returns the correct Date
		    Date startTime = trx.getStartTime();
		    assertNotNull(startTime);
		    assertEquals(currentTime, startTime.getTime(), "Start time should match the value set in m_startTime");
	
		    // Ensure that a new Date object is returned (not the same reference)
		    Date startTime2 = trx.getStartTime();
		    assertNotSame(startTime, startTime2, "getStartTime should return a new Date object each call");
	    } finally {
	    	if (trx != null)
	    		trx.close();
	    }
	}

	/**
	 * Test cases for Trx.getStrackTrace()
	 * @throws Exception
	 */
	@Test
	public void testGetStrackTrace() throws Exception {
	    String trxName = Trx.createTrxName("TestTrace");
	    Trx trx = null;
	    try {
		    trx = Trx.get(trxName, true);
		    assertNotNull(trx);
	
		    // Case 1: trace is null
		    Field traceField = Trx.class.getDeclaredField("trace");
		    traceField.setAccessible(true);
		    traceField.set(trx, null);
	
		    String traceStr = trx.getStrackTrace();
		    assertNotNull(traceStr);
		    assertEquals("", traceStr, "Should return empty string when trace is null");
	
		    // Case 2: trace is set to an exception
		    Exception ex = new Exception("Test Exception");
		    traceField.set(trx, ex);
	
		    traceStr = trx.getStrackTrace();
		    assertNotNull(traceStr);
		    assertTrue(traceStr.contains("Test Exception"), "Returned stack trace should contain the exception message");
		    assertTrue(traceStr.contains("java.lang.Exception"), "Returned stack trace should include exception class");
	    } finally {
	    	if (trx != null)
	    		trx.close();
	    }
	}

	/**
	 * Test cases for Trx.getTimeout() and Trx.setTimeout(int)
	 * @throws Exception
	 */
	@Test
	public void testTimeout() {
		Trx trx = null;
		try {
		    trx = Trx.get(Trx.createTrxName("TestTimeout"), true);
	
		    // Initially, timeout should be 7200
		    assertEquals(7200, trx.getTimeout(), "Initially, timeout should be 7200");
	
		    // Set timeout and verify getter
		    trx.setTimeout(5000);
		    assertEquals(5000, trx.getTimeout(), "Getter should return the timeout set by setter");
	
		    trx.setTimeout(0);
		    assertEquals(0, trx.getTimeout(), "Timeout can be reset to 0");
		} finally {
	    	if (trx != null)
	    		trx.close();
	    }
	}
	
	/**
	 * Test cases for Trx.hasChangesMadeByEventListener() and Trx.setChangesMadeByEventListener(boolean)
	 */
	@Test
	public void testChangesMadeByEventListener() {
		Trx trx = null;
		try {
		    trx = Trx.get(Trx.createTrxName("TestChangesMade"), true);
	
		    // Initially false
		    assertFalse(trx.hasChangesMadeByEventListener(), "Initially, changesMadeByEventListener should be false");
	
		    // Set to true
		    trx.setChangesMadeByEventListener(true);
		    assertTrue(trx.hasChangesMadeByEventListener(), "After setting true, hasChangesMadeByEventListener should return true");
	
		    // Set back to false
		    trx.setChangesMadeByEventListener(false);
		    assertFalse(trx.hasChangesMadeByEventListener(), "After setting false, hasChangesMadeByEventListener should return false");
		} finally {
	    	if (trx != null)
	    		trx.close();
	    }
	}
	
	/**
	 * Test cases for Trx.releaseSavepoint(Savepoint)
	 * @throws Exception
	 */
	@Test
	public void testReleaseSavepoint() throws Exception {
	    Connection realConn = DB.getConnection(false);
	    Trx trx = null;
	    
	    // Prepare reflection Field
	    Field connField = Trx.class.getDeclaredField("m_connection");
	    connField.setAccessible(true);
	    
	    try {
	    	trx = Trx.get(Trx.createTrxName("TestReleaseSP"), true);
	    	
		    // Inject real connection into private m_connection		    
		    connField.set(trx, realConn);

		    // Create a Savepoint
		    Savepoint sp = realConn.setSavepoint("SP1");

		    // Should not throw for normal DB connection
		    try {
		        trx.releaseSavepoint(sp);
		    } catch (Exception e) {
		        fail("releaseSavepoint should succeed with real connection, but threw: " + e);
		    }

		    // Exception path: mock Connection that throws SQLException
		    Connection mockConn = mock(Connection.class);
		    doThrow(new SQLException("Simulated releaseSavepoint error")).when(mockConn).releaseSavepoint(any(Savepoint.class));

		    // Inject mock connection
		    connField.set(trx, mockConn);

		    // Should throw SQLException
		    Savepoint spMock = mock(Savepoint.class);
		    try {
		        trx.releaseSavepoint(spMock);
		        fail("releaseSavepoint should throw SQLException");
		    } catch (SQLException e) {
		        // expected exception, test passes
		    }
	    } finally {
	    	if (trx != null) {
			    connField.set(trx, null);
	    		trx.close();
	    	}
	    	if (realConn != null)
	    		realConn.close();
	    }

	}

	
	/**
	 * Test cases for Trx.rollback methods
	 * @throws Exception
	 */
	@Test
	public void testRollbackMethods() throws Exception {
	    Connection realConn = DB.getConnection(false);
	    Trx trx = null;
	    
	    // Prepare reflection Field
	    Field connField = Trx.class.getDeclaredField("m_connection");
	    connField.setAccessible(true);

	    try {
		    String trxName = Trx.createTrxName("TestRollbackDB");
		    trx = Trx.get(trxName, true);
	
		    // Inject real connection into Trx
		    connField.set(trx, realConn);
	
		    // rollback(boolean throwException) normal path
		    assertTrue(trx.rollback(false), "rollback(false) should succeed with real connection");
		    assertTrue(trx.rollback(true), "rollback(true) should succeed with real connection");
	
		    // rollback() convenience method
		    assertTrue(trx.rollback(), "rollback() should succeed with real connection");
	
		    // rollback(Savepoint savepoint) normal path
		    Savepoint sp = realConn.setSavepoint();
		    assertTrue(trx.rollback(sp), "rollback(savepoint) should succeed with real connection");
	
		    // Mock Connection for SQLException paths
		    Connection mockConn = mock(Connection.class);
		    doThrow(new SQLException("Simulated rollback error")).when(mockConn).rollback();
		    doThrow(new SQLException("Simulated savepoint rollback")).when(mockConn).rollback(any(Savepoint.class));
	
		    // Inject mock connection
		    connField.set(trx, mockConn);
	
		    // rollback(false) should catch SQLException and return false
		    assertFalse(trx.rollback(false), "rollback(false) with exception should return false");
	
		    // rollback() convenience
		    assertFalse(trx.rollback(), "rollback() with exception should return false");
	
		    // rollback(boolean throwException=true) should throw SQLException
		    try {
		        trx.rollback(true);
		        fail("rollback(true) should throw SQLException");
		    } catch (SQLException e) {
		        // Expected exception, test passes
		    }
	
		    // rollback(Savepoint) should throw SQLException
		    Savepoint spMock = mock(Savepoint.class);
		    try {
		        trx.rollback(spMock);
		        fail("rollback(Savepoint) should throw SQLException");
		    } catch (SQLException e) {
		        // Expected exception, test passes
		    }
	    } finally {
	    	if (trx != null) {
	    		connField.set(trx, null);
	    		trx.close();
	    	}
	    	if (realConn != null)
	    		realConn.close();
	    }
	}

	/**
	 * Test cases for Trx.rollbackAndCloseOnTimeout()
	 * @throws Exception
	 */
	@Test
	public void testRollbackAndCloseOnTimeout() throws Exception {
		Trx trx = null;
		Trx spyTrx = null;
		Trx spyTrx2 = null;
		Field connField = null;
		try {
		    trx = Trx.get(Trx.createTrxName("TestRollbackClose"), true);
	
		    // Access private m_connection
		    connField = Trx.class.getDeclaredField("m_connection");
		    connField.setAccessible(true);
	
		    // Mock Connection
		    Connection mockConn = mock(Connection.class);
		    connField.set(trx, mockConn);
	
		    // Normal path: rollback succeeds, close succeeds
		    spyTrx = spy(trx);
	
		    // Stub rollback(boolean) to return true
		    doReturn(true).when(spyTrx).rollback(true);
		    // Stub close() to return true
		    doReturn(true).when(spyTrx).close();
	
		    assertTrue(spyTrx.rollbackAndCloseOnTimeout(), "rollbackAndCloseOnTimeout should return true when rollback and close succeed");
	
		    verify(spyTrx).rollback(true);
		    verify(spyTrx).close();
	
		    // Exception path: rollback throws SQLException
		    spyTrx2 = spy(trx);
	
		    doThrow(new SQLException("Simulated rollback error")).when(spyTrx2).rollback(true);
		    doReturn(true).when(spyTrx2).close();
	
		    // Should not throw, close() still called
		    assertTrue(spyTrx2.rollbackAndCloseOnTimeout(), "rollbackAndCloseOnTimeout should return true even if rollback throws");
	
		    verify(spyTrx2).rollback(true);
		    verify(spyTrx2).close();
	
		    connField.set(trx, null);
		} finally {
			if (connField != null && spyTrx != null)
				connField.set(spyTrx, null);
			if (connField != null && spyTrx2 != null)
				connField.set(spyTrx2, null);
	    	if (trx != null)
	    		trx.close();
	    }
	}
	
	/**
	 * Test cases for Trx.start()
	 * @throws Exception
	 */
	@Test
	public void testStart() throws Exception {
		Trx trx = null;
		try {
		    trx = Trx.get(Trx.createTrxName("TestStart"), true);
	
		    // Initially, should not be active
		    assertFalse(trx.isActive(), "Trx should initially be inactive");
	
		    // First start: should activate trx
		    long beforeStart = System.currentTimeMillis();
		    boolean started = trx.start();
		    long afterStart = System.currentTimeMillis();
	
		    assertTrue(started, "Trx.start() should return true when starting inactive trx");
		    assertTrue(trx.isActive(), "Trx should be active after start");
		    assertFalse(trx.hasChangesMadeByEventListener(), "ChangesMadeByEventListener should be false after start");
	
		    long startTime = trx.getStartTime().getTime();
		    assertTrue(startTime >= beforeStart && startTime <= afterStart, "Start time should be set between beforeStart and afterStart timestamps");
	
		    // Second start: should fail, already active
		    boolean startedAgain = trx.start();
		    assertFalse(startedAgain, "Trx.start() should return false if already active");
		} finally {
	    	if (trx != null)
	    		trx.close();
	    }
	}
	
	/**
	 * Test cases for Trx.toString()
	 * @throws Exception
	 */
	@Test
	public void testToString() throws Exception {
	    String trxName = Trx.createTrxName("TestToString");
	    Trx trx = null;
	    try {
		    trx = Trx.get(trxName, true);
	
		    // Initially, inactive with no display name
		    trx.setDisplayName(null);
		    trx.rollback(); // ensure inactive
		    String str = trx.toString();
		    assertTrue(str.contains("Trx[") && str.contains("Active=false"), "toString should reflect inactive state");
	
		    // Set display name and start
		    trx.setDisplayName("MyDisplayName");
		    trx.start();
		    str = trx.toString();
		    assertTrue(str.contains("Trx[MyDisplayName") && str.contains("Active=true"), "toString should include display name and active state");
	
		    // Set display name to empty string
		    trx.setDisplayName("");
		    str = trx.toString();
		    assertTrue(str.contains("Trx[") && str.contains("Active=true"), "toString should handle empty display name");
	    } finally {
	    	if (trx != null)
	    		trx.close();
	    }
	}

}
