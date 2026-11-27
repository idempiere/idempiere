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
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyBoolean;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.Mockito.atLeast;
import static org.mockito.Mockito.doThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.compiere.db.AdempiereDatabase;
import org.compiere.db.CConnection;
import org.compiere.util.DB;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Execution;
import org.junit.jupiter.api.parallel.ExecutionMode;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * Regression tests for the verification of the transaction isolation level and the auto commit mode
 * when a connection is taken from the pool.<br/>
 * With PostgreSQL every Connection.getTransactionIsolation() is a round trip to the database
 * (SHOW TRANSACTION ISOLATION LEVEL), so the verification must be done once per checkout, in
 * {@link CConnection#getConnection(boolean, int)}, and not again by the database provider.
 * <ul>
 * <li>CConnection tests: the provider is a mock, they define what CConnection does with the connection it gets.</li>
 * <li>Provider test: the pool is a mock, it fails if the provider verifies the connection itself again.</li>
 * <li>Pool default tests: the one time check that the pool of a provider delivers READ_COMMITTED connections, so that
 * the level is not asked from the database on every checkout.</li>
 * <li>Checkout tests: real pool, they check the level and auto commit mode the caller receives and that a
 * non default level does not leak into the next checkout.</li>
 * </ul>
 */
@Isolated
@Execution(ExecutionMode.SAME_THREAD)
class CConnectionIsolationTest extends AbstractTestCase {

	private static final int READ_COMMITTED = Connection.TRANSACTION_READ_COMMITTED;

	/**
	 * @param db provider returned by the CConnection under test
	 * @return a new CConnection (not the shared one) that uses the given provider
	 */
	private CConnection connectionUsing(AdempiereDatabase db) throws Exception {
		CConnection cc = new CConnection(null);
		// CConnection.getDatabase() drops a provider whose name differs from the connection type
		when(db.getName()).thenReturn(cc.getType());
		Field field = CConnection.class.getDeclaredField("m_db");
		field.setAccessible(true);
		field.set(cc, db);
		return cc;
	}

	private Connection pooledConnection(int isolation, boolean autoCommit) throws SQLException {
		Connection conn = mock(Connection.class);
		when(conn.getTransactionIsolation()).thenReturn(isolation);
		when(conn.getAutoCommit()).thenReturn(autoCommit);
		return conn;
	}

	private AdempiereDatabase providerReturning(Connection conn) throws Exception {
		AdempiereDatabase db = mock(AdempiereDatabase.class);
		when(db.getCachedConnection(any(CConnection.class), anyBoolean(), anyInt())).thenReturn(conn);
		return db;
	}

	// ---- CConnection.applyConnectionSettings: no provider needed ----

	@Test
	void testApplyConnectionSettingsNothingToApply() throws Exception {
		Connection conn = pooledConnection(READ_COMMITTED, true);

		new CConnection(null).applyConnectionSettings(conn, true, READ_COMMITTED);

		verify(conn, never()).setTransactionIsolation(anyInt());
		verify(conn, never()).setAutoCommit(anyBoolean());
		verify(conn, never()).close();
	}

	@Test
	void testApplyConnectionSettingsAppliesIsolationAndAutoCommit() throws Exception {
		Connection conn = pooledConnection(Connection.TRANSACTION_SERIALIZABLE, true);

		new CConnection(null).applyConnectionSettings(conn, false, READ_COMMITTED);

		verify(conn, times(1)).setTransactionIsolation(READ_COMMITTED);
		verify(conn, times(1)).setAutoCommit(false);
	}

	@Test
	void testApplyConnectionSettingsAsksTrustedPoolOnlyOnce() throws Exception {
		Connection conn = pooledConnection(READ_COMMITTED, true);
		CConnection cc = new CConnection(null);

		for (int i = 0; i < 4; i++)
			cc.applyConnectionSettings(conn, true, READ_COMMITTED);

		verify(conn, times(1)).getTransactionIsolation();
	}

	@Test
	void testApplyConnectionSettingsPropagatesFailureAndLeavesTheConnectionOpen() throws Exception {
		Connection conn = pooledConnection(Connection.TRANSACTION_SERIALIZABLE, true);
		SQLException failure = new SQLException("cannot change isolation level");
		doThrow(failure).when(conn).setTransactionIsolation(READ_COMMITTED);

		SQLException thrown = assertThrows(SQLException.class,
				() -> new CConnection(null).applyConnectionSettings(conn, true, READ_COMMITTED));

		assertSame(failure, thrown);
		// closing is the job of getConnection, not of this method
		verify(conn, never()).close();
	}

	// ---- CConnection.getConnection with a mocked provider ----

	@Test
	void testGetConnectionNoChangeNeeded() throws Exception {
		Connection conn = pooledConnection(READ_COMMITTED, true);
		CConnection cc = connectionUsing(providerReturning(conn));

		Connection result = cc.getConnection(true, READ_COMMITTED);

		assertSame(conn, result);
		assertNull(cc.getDatabaseException());
		// asked once, not twice, and nothing to apply
		verify(conn, times(1)).getTransactionIsolation();
		verify(conn, never()).setTransactionIsolation(anyInt());
		verify(conn, never()).setAutoCommit(anyBoolean());
		verify(conn, never()).close();
	}

	@Test
	void testGetConnectionAppliesDifferentIsolation() throws Exception {
		Connection conn = pooledConnection(Connection.TRANSACTION_SERIALIZABLE, true);
		CConnection cc = connectionUsing(providerReturning(conn));

		Connection result = cc.getConnection(true, READ_COMMITTED);

		assertSame(conn, result);
		verify(conn, times(1)).setTransactionIsolation(READ_COMMITTED);
		verify(conn, never()).close();
	}

	@Test
	void testGetConnectionKeepsRequestedNonDefaultIsolation() throws Exception {
		Connection conn = pooledConnection(Connection.TRANSACTION_REPEATABLE_READ, true);
		CConnection cc = connectionUsing(providerReturning(conn));

		Connection result = cc.getConnection(true, Connection.TRANSACTION_REPEATABLE_READ);

		assertSame(conn, result);
		verify(conn, never()).setTransactionIsolation(anyInt());
	}

	@Test
	void testGetConnectionAppliesAutoCommit() throws Exception {
		Connection conn = pooledConnection(READ_COMMITTED, true);
		CConnection cc = connectionUsing(providerReturning(conn));

		Connection result = cc.getConnection(false, READ_COMMITTED);

		assertSame(conn, result);
		verify(conn, times(1)).setAutoCommit(false);
		verify(conn, never()).setTransactionIsolation(anyInt());
	}

	@Test
	void testGetConnectionSetIsolationFailureReturnsNullAndClosesConnection() throws Exception {
		Connection conn = pooledConnection(Connection.TRANSACTION_SERIALIZABLE, true);
		SQLException failure = new SQLException("cannot change isolation level");
		doThrow(failure).when(conn).setTransactionIsolation(READ_COMMITTED);
		CConnection cc = connectionUsing(providerReturning(conn));

		Connection result = cc.getConnection(true, READ_COMMITTED);

		// a connection in an unknown state must not be handed to the caller, and must go back to the pool
		assertNull(result, "connection with unknown isolation level must not be returned");
		verify(conn, times(1)).close();
		assertSame(failure, cc.getDatabaseException());
	}

	@Test
	void testGetConnectionGetIsolationFailureReturnsNullAndClosesConnection() throws Exception {
		Connection conn = mock(Connection.class);
		SQLException failure = new SQLException("connection is broken");
		when(conn.getTransactionIsolation()).thenThrow(failure);
		CConnection cc = connectionUsing(providerReturning(conn));

		Connection result = cc.getConnection(true, READ_COMMITTED);

		assertNull(result);
		verify(conn, times(1)).close();
		assertSame(failure, cc.getDatabaseException());
	}

	@Test
	void testGetConnectionSetAutoCommitFailureReturnsNullAndClosesConnection() throws Exception {
		Connection conn = pooledConnection(READ_COMMITTED, true);
		SQLException failure = new SQLException("cannot change auto commit");
		doThrow(failure).when(conn).setAutoCommit(false);
		CConnection cc = connectionUsing(providerReturning(conn));

		Connection result = cc.getConnection(false, READ_COMMITTED);

		assertNull(result);
		verify(conn, times(1)).close();
		assertSame(failure, cc.getDatabaseException());
	}

	@Test
	void testGetConnectionCloseFailureAfterErrorIsIgnored() throws Exception {
		Connection conn = pooledConnection(Connection.TRANSACTION_SERIALIZABLE, true);
		SQLException failure = new SQLException("cannot change isolation level");
		doThrow(failure).when(conn).setTransactionIsolation(READ_COMMITTED);
		doThrow(new SQLException("close failed")).when(conn).close();
		CConnection cc = connectionUsing(providerReturning(conn));

		Connection result = cc.getConnection(true, READ_COMMITTED);

		assertNull(result);
		// the exception of the first failure is kept, not the one of close()
		assertSame(failure, cc.getDatabaseException());
	}

	@Test
	void testGetConnectionProviderReturnsNoConnection() throws Exception {
		CConnection cc = connectionUsing(providerReturning(null));

		Connection result = cc.getConnection(true, READ_COMMITTED);

		assertNull(result);
	}

	@Test
	void testGetConnectionProviderThrowsException() throws Exception {
		AdempiereDatabase db = mock(AdempiereDatabase.class);
		IllegalStateException failure = new IllegalStateException("pool is closed");
		when(db.getCachedConnection(any(CConnection.class), anyBoolean(), anyInt())).thenThrow(failure);
		CConnection cc = connectionUsing(db);

		Connection result = cc.getConnection(true, READ_COMMITTED);

		assertNull(result);
		assertSame(failure, cc.getDatabaseException());
	}

	@Test
	void testGetConnectionProviderThrowsSQLException() throws Exception {
		AdempiereDatabase db = mock(AdempiereDatabase.class);
		SQLException failure = new SQLException("no connection available");
		when(db.getCachedConnection(any(CConnection.class), anyBoolean(), anyInt())).thenThrow(failure);
		CConnection cc = connectionUsing(db);

		// no connection exists yet, so there is nothing to close
		Connection result = cc.getConnection(true, READ_COMMITTED);

		assertNull(result);
		assertSame(failure, cc.getDatabaseException());
	}

	// ---- pool delivers READ_COMMITTED: the level is not asked from the database on every checkout ----

	@Test
	void testPoolDeliveringReadCommittedIsCheckedOnlyOnce() throws Exception {
		Connection conn = pooledConnection(READ_COMMITTED, true);
		CConnection cc = connectionUsing(providerReturning(conn));

		for (int i = 0; i < 5; i++)
			assertSame(conn, cc.getConnection(true, READ_COMMITTED), "checkout " + i);

		// one question to the database for 5 checkouts (the one time check of the pool), nothing applied
		verify(conn, times(1)).getTransactionIsolation();
		verify(conn, never()).setTransactionIsolation(anyInt());
	}

	@Test
	void testPoolCheckBelongsToTheProviderThatOwnsThePool() throws Exception {
		// pool A delivers READ_COMMITTED and is trusted
		Connection fromPoolA = pooledConnection(READ_COMMITTED, true);
		CConnection cc = connectionUsing(providerReturning(fromPoolA));
		cc.getConnection(true, READ_COMMITTED);
		cc.getConnection(true, READ_COMMITTED);
		verify(fromPoolA, times(1)).getTransactionIsolation();

		// the provider is replaced by one whose pool delivers another level: the trust of pool A must not be reused
		Connection fromPoolB = pooledConnection(Connection.TRANSACTION_SERIALIZABLE, true);
		AdempiereDatabase providerB = providerReturning(fromPoolB);
		when(providerB.getName()).thenReturn(cc.getType());
		Field field = CConnection.class.getDeclaredField("m_db");
		field.setAccessible(true);
		field.set(cc, providerB);

		assertSame(fromPoolB, cc.getConnection(true, READ_COMMITTED));
		verify(fromPoolB, times(1)).setTransactionIsolation(READ_COMMITTED);
		// and it is checked every time, because pool B does not deliver READ_COMMITTED
		cc.getConnection(true, READ_COMMITTED);
		verify(fromPoolB, times(2)).setTransactionIsolation(READ_COMMITTED);
	}

	@Test
	void testEachConnectionDescriptorChecksItsOwnPool() throws Exception {
		Connection first = pooledConnection(READ_COMMITTED, true);
		Connection second = pooledConnection(READ_COMMITTED, true);

		connectionUsing(providerReturning(first)).getConnection(true, READ_COMMITTED);
		connectionUsing(providerReturning(second)).getConnection(true, READ_COMMITTED);

		verify(first, times(1)).getTransactionIsolation();
		verify(second, times(1)).getTransactionIsolation();
	}

	@Test
	void testPoolNotDeliveringReadCommittedKeepsTheCheckOnEveryCheckout() throws Exception {
		// a pool configured with another level: still READ_COMMITTED for the caller, checked and applied every time
		Connection conn = pooledConnection(Connection.TRANSACTION_REPEATABLE_READ, true);
		CConnection cc = connectionUsing(providerReturning(conn));

		for (int i = 0; i < 3; i++)
			assertSame(conn, cc.getConnection(true, READ_COMMITTED), "checkout " + i);

		verify(conn, times(3)).setTransactionIsolation(READ_COMMITTED);
		verify(conn, atLeast(3)).getTransactionIsolation();
	}

	@Test
	void testNonDefaultRequestIsStillVerifiedWithTrustedPool() throws Exception {
		Connection conn = pooledConnection(READ_COMMITTED, true);
		CConnection cc = connectionUsing(providerReturning(conn));
		cc.getConnection(true, READ_COMMITTED); // the pool is now trusted for READ_COMMITTED, by this descriptor

		// same descriptor: a request for another level is still verified and applied
		Connection result = cc.getConnection(true, Connection.TRANSACTION_SERIALIZABLE);

		assertSame(conn, result);
		verify(conn, times(1)).setTransactionIsolation(Connection.TRANSACTION_SERIALIZABLE);
	}

	@Test
	void testFailedPoolCheckIsRepeatedAtTheNextCheckout() throws Exception {
		Connection broken = mock(Connection.class);
		when(broken.getTransactionIsolation()).thenThrow(new SQLException("connection is broken"));
		Connection good = pooledConnection(READ_COMMITTED, true);
		AdempiereDatabase db = mock(AdempiereDatabase.class);
		// one descriptor and one provider: the first checkout gets the broken connection, the next ones the good one
		when(db.getCachedConnection(any(CConnection.class), anyBoolean(), anyInt())).thenReturn(broken, good);
		CConnection cc = connectionUsing(db);

		assertNull(cc.getConnection(true, READ_COMMITTED));
		verify(broken, times(1)).close();

		// the failure must not be remembered as "pool not trusted": the next checkout checks again, once
		assertSame(good, cc.getConnection(true, READ_COMMITTED));
		assertSame(good, cc.getConnection(true, READ_COMMITTED));
		verify(good, times(1)).getTransactionIsolation();
		verify(good, never()).setTransactionIsolation(anyInt());
	}

	/** the PostgreSQL pool is created with READ_COMMITTED as default level, unless the administrator configured another one */
	@Test
	void testPostgreSQLPoolDefaultsToReadCommitted() throws Exception {
		if (!DB.isPostgreSQL())
			return;
		AdempiereDatabase provider = DB.getDatabase();
		Method poolProperties = provider.getClass().getDeclaredMethod("getPoolProperties");
		poolProperties.setAccessible(true);
		Properties configured = (Properties) poolProperties.invoke(provider);
		if (configured.containsKey("transactionIsolation"))
			return; // configured in hikaricp.properties of this installation
		Field poolField = provider.getClass().getDeclaredField("m_ds");
		poolField.setAccessible(true);
		Object pool = poolField.get(provider);
		assertNotNull(pool, "pool is created");
		assertEquals("TRANSACTION_READ_COMMITTED", pool.getClass().getMethod("getTransactionIsolation").invoke(pool));
	}

	// ---- database provider with a mocked pool ----

	/**
	 * The provider must hand out the pooled connection untouched: isolation level and auto commit are
	 * verified and applied by CConnection.getConnection, doing it here as well costs a round trip to the database
	 * (getTransactionIsolation) on every checkout.
	 */
	@Test
	void testPostgreSQLProviderDoesNotRepeatTheCheck() throws Exception {
		if (!DB.isPostgreSQL())
			return; // the PostgreSQL provider is only available on PostgreSQL
		// a new instance of the provider class (it is not exported API), the shared one is not touched
		Class<?> providerClass = DB.getDatabase().getClass();
		AdempiereDatabase provider = (AdempiereDatabase) providerClass.getDeclaredConstructor().newInstance();
		Field poolField = providerClass.getDeclaredField("m_ds");
		poolField.setAccessible(true);
		DataSource pool = assertInstanceOf(DataSource.class, mock(poolField.getType()));
		Connection conn = mock(Connection.class);
		when(pool.getConnection()).thenReturn(conn);
		poolField.set(provider, pool);

		Connection result = provider.getCachedConnection(new CConnection(null), true, READ_COMMITTED);
		assertSame(conn, result);
		verifyNoInteractions(conn);

		// also for other requests: still handed out untouched
		result = provider.getCachedConnection(new CConnection(null), false, Connection.TRANSACTION_SERIALIZABLE);
		assertSame(conn, result);
		verifyNoInteractions(conn);
	}

	// ---- real checkouts ----

	@Test
	void testCheckoutDeliversRequestedIsolationAndAutoCommit() throws Exception {
		for (boolean autoCommit : new boolean[] { true, false }) {
			Connection conn = DB.createConnection(autoCommit, READ_COMMITTED);
			try {
				assertNotNull(conn);
				assertEquals(READ_COMMITTED, conn.getTransactionIsolation(), "isolation level, autoCommit=" + autoCommit);
				assertEquals(autoCommit, conn.getAutoCommit(), "auto commit");
			} finally {
				closeQuietly(conn);
			}
		}
	}

	@Test
	void testNonDefaultIsolationDoesNotLeakIntoNextCheckout() throws Exception {
		int[] levels = DB.isOracle()
				? new int[] { Connection.TRANSACTION_SERIALIZABLE }
				: new int[] { Connection.TRANSACTION_REPEATABLE_READ, Connection.TRANSACTION_SERIALIZABLE };
		for (int level : levels) {
			Connection conn = DB.createConnection(false, level);
			try {
				assertEquals(level, conn.getTransactionIsolation(), "requested level");
			} finally {
				closeQuietly(conn);
			}
			// the pool may hand out the same physical connection again: it must be READ_COMMITTED
			for (int i = 0; i < 5; i++) {
				Connection next = DB.createConnection(true, READ_COMMITTED);
				try {
					assertEquals(READ_COMMITTED, next.getTransactionIsolation(), "level after " + level + ", checkout " + i);
					assertTrue(next.getAutoCommit());
				} finally {
					closeQuietly(next);
				}
			}
		}
	}

	@Test
	void testAutoCommitFalseDoesNotLeakIntoNextCheckout() throws Exception {
		Connection conn = DB.createConnection(false, READ_COMMITTED);
		try {
			assertFalse(conn.getAutoCommit());
		} finally {
			closeQuietly(conn);
		}
		for (int i = 0; i < 5; i++) {
			Connection next = DB.createConnection(true, READ_COMMITTED);
			try {
				assertTrue(next.getAutoCommit(), "auto commit, checkout " + i);
			} finally {
				closeQuietly(next);
			}
		}
	}

	private void closeQuietly(Connection conn) {
		if (conn == null)
			return;
		try {
			if (!conn.getAutoCommit())
				conn.rollback();
		} catch (SQLException e) {
			// ignore
		}
		try {
			conn.close();
		} catch (SQLException e) {
			// ignore
		}
	}
}
