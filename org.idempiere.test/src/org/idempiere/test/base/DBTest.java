/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2008 SC ARHIPAC SERVICE SRL. All Rights Reserved.            *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNotSame;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.PatternSyntaxException;

import org.adempiere.exceptions.DBException;
import org.compiere.Adempiere;
import org.compiere.apps.form.TreeMaintenance;
import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MBPartner;
import org.compiere.model.MColumn;
import org.compiere.model.MOrder;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.MUser;
import org.compiere.model.PO;
import org.compiere.model.X_Test;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Language;
import org.compiere.util.TimeUtil;
import org.compiere.util.Trx;
import org.compiere.util.ValueNamePair;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.parallel.Execution;
import org.junit.jupiter.api.parallel.ExecutionMode;
import org.junit.jupiter.api.parallel.Isolated;

/**
 * Test {@link org.compiere.util.DB} class
 * @author Teo Sarca, www.arhipac.ro
 * @author hengsin
 */
@Isolated
@Execution(ExecutionMode.SAME_THREAD)
public class DBTest extends AbstractTestCase
{
	private static final int TEST_RECORD_ID = 103;

	@Test
	public void test_getSQLValueEx() throws Exception
	{
		int result = DB.getSQLValueEx(null, "SELECT 10 FROM DUAL");
		assertEquals(10, result);
		//
		result = DB.getSQLValue(null, "SELECT 10 FROM AD_SYSTEM WHERE 1=2");
		assertEquals(-1, result, "No value should be returned");
		//
		assertThrows(DBException.class, () -> {
			DB.getSQLValueEx(null, "SELECT 10 FROM INEXISTENT_TABLE");
		});
		
		int t_integer = DB.getSQLValueEx(null, "select t_integer from test where test_id=?", TEST_RECORD_ID);
		assertThrows(DBException.class, () -> {
			DB.getSQLValueEx(null, "update test set t_integer=1 where test_id=?", TEST_RECORD_ID);
		});
		int t_integer1 = DB.getSQLValueEx(null, "select t_integer from test where test_id=?", TEST_RECORD_ID);
		assertEquals(t_integer, t_integer1, "test.t_integer wrongly updated");
		
		assertThrows(DBException.class, () -> {
			DB.getSQLValueEx(getTrxName(), "update test set t_integer=1 where test_id=?;select t_integer from test where test_id=?", TEST_RECORD_ID);
		});
		rollback();
		t_integer1 = DB.getSQLValueEx(null, "select t_integer from test where test_id=?", TEST_RECORD_ID);
		assertEquals(t_integer, t_integer1, "test.t_integer wrongly updated");
	}
	
	@Test
	public void test_getSQLValue() throws Exception
	{
		int result = DB.getSQLValue(null, "SELECT 10 FROM DUAL");
		assertEquals(10, result);
		//
		result = DB.getSQLValue(null, "SELECT 10 FROM AD_SYSTEM WHERE 1=2");
		assertEquals(-1, result, "No value should be returned");
		//
		result = DB.getSQLValue(null, "SELECT 10 FROM INEXISTENT_TABLE");
		assertEquals(-1, result, "Error should be signaled");
	}
	
	@Test
	public void test_getSQLValueBDEx() throws Exception
	{
		BigDecimal result = DB.getSQLValueBDEx(null, "SELECT 10 FROM DUAL");
		assertEquals(BigDecimal.TEN, result);
		//
		result = DB.getSQLValueBD(null, "SELECT 10 FROM AD_SYSTEM WHERE 1=2");
		assertNull(result, "No value should be returned");
		//
		assertThrows(DBException.class, () -> {
			DB.getSQLValueBDEx(null, "SELECT 10 FROM INEXISTENT_TABLE");
		});
	}

	@Test
	public void test_getSQLValueBD() throws Exception
	{
		BigDecimal result = DB.getSQLValueBD(null, "SELECT 10 FROM DUAL");
		assertEquals(BigDecimal.TEN, result);
		//
		result = DB.getSQLValueBD(null, "SELECT 10 FROM AD_SYSTEM WHERE 1=2");
		assertNull(result, "No value should be returned");
		//
		result = DB.getSQLValueBD(null, "SELECT 10 FROM INEXISTENT_TABLE");
		assertNull(result, "Error should be signaled");
	}
	
	@Test
	public void test_getSQLValueStringEx() throws Exception
	{
		String result = DB.getSQLValueStringEx(null, "SELECT 'string' FROM DUAL");
		assertEquals("string", result);
		//
		result = DB.getSQLValueStringEx(null, "SELECT 10 FROM AD_SYSTEM WHERE 1=2");
		assertNull(result, "No value should be returned");
		//
		assertThrows(DBException.class, () -> {
			DB.getSQLValueStringEx(null, "SELECT 'string' FROM INEXISTENT_TABLE");
		});
	}
	
	@Test
	public void test_getSQLValueString() throws Exception
	{
		String result = DB.getSQLValueString(null, "SELECT 'string' FROM DUAL");
		assertEquals("string", result);
		//
		result = DB.getSQLValueString(null, "SELECT 'string' FROM AD_SYSTEM WHERE 1=2");
		assertNull(result, "No value should be returned");
		//
		result = DB.getSQLValueString(null, "SELECT 'string' FROM INEXISTENT_TABLE");
		assertNull(result, "Error should be signaled");
	}

	@Test
	public void test_getSQLValueTSEx() throws Exception
	{
		final Timestamp target = TimeUtil.getDay(2008, 01, 01);
		//
		Timestamp result = DB.getSQLValueTSEx(null, "SELECT TO_DATE('2008-01-01','YYYY-MM-DD') FROM AD_SYSTEM");
		assertEquals(target, result);
		//
		result = DB.getSQLValueTSEx(null, "SELECT TO_DATE('2008-01-01','YYYY-MM-DD') FROM AD_SYSTEM WHERE 1=2");
		assertNull(result, "No value should be returned");
		//
		assertThrows(DBException.class, () -> {
			DB.getSQLValueTSEx(null, "SELECT TO_DATE('2008-01-01','YYYY-MM-DD') FROM INEXISTENT_TABLE");
		});
	}
	
	@Test
	public void test_getSQLValueTS() throws Exception
	{
		final Timestamp target = TimeUtil.getDay(2008, 01, 01);
		//
		Timestamp result = DB.getSQLValueTS(null, "SELECT TO_DATE('2008-01-01','YYYY-MM-DD') FROM DUAL");
		assertEquals(target, result);
		//
		result = DB.getSQLValueTS(null, "SELECT TO_DATE('2008-01-01','YYYY-MM-DD') FROM AD_SYSTEM WHERE 1=2");
		assertNull(result, "No value should be returned");
		//
		result = DB.getSQLValueTS(null, "SELECT TO_DATE('2008-01-01','YYYY-MM-DD') FROM INEXISTENT_TABLE");
		assertNull(result, "Error should be signaled");
	}
	
	@Test
	public void test_getValueNamePairs() throws Exception
	{
		ArrayList<Object> params = new ArrayList<Object>();
		params.add(MTable.ACCESSLEVEL_AD_Reference_ID);
		final String sql = "SELECT Value, Name FROM AD_Ref_List WHERE AD_Reference_ID=? ORDER BY Value";
		// Get (with optional item)
		ValueNamePair[] arr = DB.getValueNamePairs(sql, true, params);
		assertEquals(6+1, arr.length, "Invalid size");
		assertSame(ValueNamePair.EMPTY, arr[0], "First value should be EMPTY");
		assertEquals(arr[1].getValue(), "1");
		assertEquals(arr[2].getValue(), "2");
		assertEquals(arr[3].getValue(), "3");
		assertEquals(arr[4].getValue(), "4");
		assertEquals(arr[5].getValue(), "6");
		assertEquals(arr[6].getValue(), "7");
		// Get (NO optional item)
		arr = DB.getValueNamePairs(sql, false, params);
		assertEquals(6, arr.length, "Invalid size");
		assertEquals(arr[0].getValue(), "1");
		assertEquals(arr[1].getValue(), "2");
		assertEquals(arr[2].getValue(), "3");
		assertEquals(arr[3].getValue(), "4");
		assertEquals(arr[4].getValue(), "6");
		assertEquals(arr[5].getValue(), "7");
	}
	
	@Test
	public void test_getKeyNamePairs() throws Exception
	{
		ArrayList<Object> params = new ArrayList<Object>();
		params.add(MTable.ACCESSLEVEL_AD_Reference_ID);
		final String sql = "SELECT AD_Ref_List_ID, Value FROM AD_Ref_List WHERE AD_Reference_ID=? ORDER BY Value";
		// Get (with optional item)
		KeyNamePair[] arr = DB.getKeyNamePairs(sql, true, params);
		assertEquals(6+1, arr.length, "Invalid size");
		assertSame(KeyNamePair.EMPTY, arr[0], "First value should be EMPTY");
		assertEquals(arr[1].getName(), "1");
		assertEquals(arr[2].getName(), "2");
		assertEquals(arr[3].getName(), "3");
		assertEquals(arr[4].getName(), "4");
		assertEquals(arr[5].getName(), "6");
		assertEquals(arr[6].getName(), "7");
		// Get (NO optional item)
		arr = DB.getKeyNamePairs(sql, false, params);
		assertEquals(6, arr.length, "Invalid size");
		assertEquals(arr[0].getName(), "1");
		assertEquals(arr[1].getName(), "2");
		assertEquals(arr[2].getName(), "3");
		assertEquals(arr[3].getName(), "4");
		assertEquals(arr[4].getName(), "6");
		assertEquals(arr[5].getName(), "7");
	}

	@Test
	public void test_getSQLValueObjectsEx()
	{
		StringBuilder sql = new StringBuilder("SELECT ")
				.append(X_Test.COLUMNNAME_Test_ID)
				.append(", ")
				.append(X_Test.COLUMNNAME_Test_UU)
				.append(" FROM Test WHERE Test_ID=?");
		List<Object> objects = DB.getSQLValueObjectsEx(null, sql.toString(), TEST_RECORD_ID);
		assertEquals(2, objects.size());
		X_Test test = new X_Test(Env.getCtx(), TEST_RECORD_ID, getTrxName());
		assertEquals(test.get_ID(), ((Number)objects.get(0)).intValue());
		assertEquals(test.getTest_UU().toString(), objects.get(1).toString());
		
		objects = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(), TEST_RECORD_ID);
		assertEquals(2, objects.size());
		assertEquals(test.get_ID(), ((Number)objects.get(0)).intValue());
		assertEquals(test.getTest_UU().toString(), objects.get(1).toString());
	}
	
	@Test
	public void test_getSQLArrayObjectsEx()
	{
		String sql = "SELECT M_Product_ID, Name FROM M_Product WHERE M_Product_ID IN (?, ?, ?)";
		List<List<Object>> rows = DB.getSQLArrayObjectsEx(null, sql, DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.MULCH.id, DictionaryIDs.M_Product.FERTILIZER_50.id);
		assertEquals(3, rows.size());
		int match = 0;
		for(List<Object> row : rows) {
			assertEquals(2, row.size());
			Number id = (Number)row.get(0);
			if (id.intValue() == DictionaryIDs.M_Product.AZALEA_BUSH.id || 
				id.intValue() == DictionaryIDs.M_Product.MULCH.id || 
				id.intValue() == DictionaryIDs.M_Product.FERTILIZER_50.id)
				match++;
		}
		assertEquals(3, match);
		
		rows = DB.getSQLArrayObjectsEx(getTrxName(), sql, DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.MULCH.id, DictionaryIDs.M_Product.FERTILIZER_50.id);
		assertEquals(3, rows.size());
		match = 0;
		for(List<Object> row : rows) {
			assertEquals(2, row.size());
			Number id = (Number)row.get(0);
			if (id.intValue() == DictionaryIDs.M_Product.AZALEA_BUSH.id || 
				id.intValue() == DictionaryIDs.M_Product.MULCH.id || 
				id.intValue() == DictionaryIDs.M_Product.FERTILIZER_50.id)
				match++;
		}
		assertEquals(3, match);
	}

	@Test
	public void test_NVL() throws Exception
	{
		// multi datatype NVL
		// numeric, integer
		BigDecimal result = DB.getSQLValueBDEx(null, "SELECT NVL(GrandTotal, 0) FROM C_Order WHERE C_Order_ID=100");
		assertTrue(result != null);
		// integer, numeric
		result = DB.getSQLValueBDEx(null, "SELECT NVL(10, C_Order_ID) FROM C_Order WHERE C_Order_ID=100");
		assertTrue(result != null);
		// Varchar, Text
		String resultStr = DB.getSQLValueStringEx(null, "SELECT NVL(Description, C_Charge_ID||' ') FROM C_Charge WHERE C_Charge_ID=101");
		assertTrue(resultStr != null);
	}
	
	@Test
	public void testForUpdateAndForeignKey() 
	{
		try {
			MBPartner bp = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, getTrxName());
			DB.getDatabase().forUpdate(bp, 0);
			
			SQLException sqlException = null;
			Trx trx2 = Trx.get(Trx.createTrxName(), true);
			MOrder order = null;
			try {
				order = new MOrder(Env.getCtx(), 0, trx2.getTrxName());
				order.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.STANDARD_ORDER.id);
				order.setC_BPartner_ID(bp.get_ID());
				order.setDateOrdered(getLoginDate());
				Thread thread = new Thread (() -> { 
					try {
						Thread.sleep(15 * 1000);
					} catch (InterruptedException e) {
					}
					if (trx2.isActive()) trx2.rollbackAndCloseOnTimeout();
				});
				thread.start();
				order.saveEx();		
				trx2.commit(true);
			} catch (SQLException e) {
				sqlException = e;
				order = null;
			} finally {
				trx2.close();
			}
			assertNull(sqlException, "Failed to save and commit order: " + (sqlException != null ? sqlException.getMessage() : ""));
			if (order != null && order.get_ID() > 0) {
				order.set_TrxName(null);
				order.deleteEx(true);
			}
		} finally {
			rollback();
		}				
	}

	@Test
	public void testPostgreSQLSyncColumn() {
		if (!DB.isPostgreSQL() || !DB.getDatabase().isNativeMode())
			return;
		
		MTable table = MTable.get(MOrder.Table_ID);
		MColumn column = table.getColumn("Description");
		MColumn description = new MColumn(Env.getCtx(), column.getAD_Column_ID(), getTrxName());
		description.setFieldLength(description.getFieldLength()+1);
		description.saveEx();
		
		String error = null;
		String sql = description.getSQLModify(table, false);
		try {
			DB.executeUpdateEx(sql, getTrxName());
		} catch (Exception ex) {
			error = ex.getMessage();
		}
		assertNull(error, error);
	}

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		if (testInfo.getTestMethod().get().getName().equals("testPostgreSQLSyncColumn")) {
			return new LoginDetails(DictionaryIDs.AD_Client.SYSTEM.id, 0, DictionaryIDs.AD_User.SUPER_USER.id, DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id, 
					DictionaryIDs.AD_Role.SYSTEM_ADMINISTRATOR.id, new Timestamp(System.currentTimeMillis()), Language.getLanguage("en_US"));
		} else {
			return super.newLoginDetails(testInfo);
		}
	}

	@Test
	public void testTrxTimeout() 
	{
		try {
			MBPartner bp = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, getTrxName());
			DB.getDatabase().forUpdate(bp, 0);
			
			Exception exception = null;
			Trx trx2 = Trx.get(Trx.createTrxName(), true);
			MBPartner bp2 = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.JOE_BLOCK.id, trx2.getTrxName());
			try {
				Thread thread = new Thread (() -> { 
					try {
						Thread.sleep(5 * 1000);
					} catch (InterruptedException e) {
					}
					if (trx2.isActive()) trx2.rollbackAndCloseOnTimeout();
				});
				thread.start();
				DB.getDatabase().forUpdate(bp2, 10);
			} catch (Exception e) {
				exception = e;
			} finally {
				trx2.close();
			}
			assertNotNull(exception, "Exception not happens as expected");
			assertTrue(exception instanceof DBException, "Exception not instanceof DBException");
		} finally {
			rollback();
		}				
	}

	public static Pattern REG_ACTIVE_CONNECT = Pattern.compile("# Busy Connections:\\s*(\\d+)\\s*,", Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE);
	
	public static int getNumConnectPerStatus (String poolStatus, Pattern patternStatus) {
		int numActiveConn = -1;
		try {
			
			Matcher regexMatcher = patternStatus.matcher(poolStatus);
			if (regexMatcher.find()) {
				String activeConnectionStr = regexMatcher.group(1);
				numActiveConn = Integer.parseInt(activeConnectionStr);
			}
		} catch (PatternSyntaxException ex) {
			// Syntax error in the regular expression
		}
		return numActiveConn;
	}
	
	/**
	 * test case to simulate transaction timeouts and ensure no open connections remain afterwards
	 */
	@Test
	public void testTrxTimeout2() {
		//initial delay to give connection pool time to release active connections
		try {
			Thread.sleep(3000);
		} catch (InterruptedException e) {
		}
		
		//create a short duration monitor for testing
		Trx.TrxMonitor monitor = new Trx.TrxMonitor();
		ScheduledFuture<?> future = Adempiere.getThreadPoolExecutor().scheduleWithFixedDelay(monitor, 0, 6, TimeUnit.SECONDS);
		int beforeActiveConnection = getNumConnectPerStatus(DB.getDatabase().getStatus(), REG_ACTIVE_CONNECT);
		
		Trx trx2 = Trx.get(Trx.createTrxName(), true);
		trx2.setTimeout(3);// timeout after 3s
		
		DB.getSQLValueEx(trx2.getTrxName(), "SELECT 1 FROM DUAL");// to make transaction start
		
		try {
			Thread.sleep(8000);//Wait for the transaction monitor to complete its task
			
			int afterActiveConnection = getNumConnectPerStatus(DB.getDatabase().getStatus(), REG_ACTIVE_CONNECT);
			assertEquals(beforeActiveConnection, afterActiveConnection);
		} catch (InterruptedException e) {
			e.printStackTrace();
		} finally {
			future.cancel(true);
		}
	}

	/**
	 * Test max length of UUID column name and its index
	 */
	@Test
	public void testUUIDColumnName() {
		assertEquals(PO.getUUIDColumnName   ("MyTable"                                                      ), "MyTable_UU"                                                     );
		assertEquals(PO.getUUIDColumnName   ("XCUSTOM_ThisIsAVeryLongTableNameWithSixtyCharactersOnTheName" ), "XCUSTOM_ThisIsAVeryLongTableNameWithSixtyCharactersOnTheName_UU");
		assertEquals(PO.getUUIDColumnName   ("CUSTOM_AVeryLongTableNameWithMoreThanSixtyCharactersOnTheName"), "CUSTOM_AVeryLongTableNameWithMoreThanSixtyCharactersOnTheNam_UU");
		assertEquals(MTable.getUUIDIndexName("MyTable"                                                      ), "MyTable_UU_idx"                                                 );
		assertEquals(MTable.getUUIDIndexName("XCUSTOM_ThisIsAVeryLongTableNameWithSixtyCharactersOnTheName" ), "XCUSTOM_ThisIsAVeryLongTableNameWithSixtyCharactersOnTheNauuidx");
		assertEquals(MTable.getUUIDIndexName("CUSTOM_AVeryLongTableNameWithMoreThanSixtyCharactersOnTheName"), "CUSTOM_AVeryLongTableNameWithMoreThanSixtyCharactersOnTheNuuidx");
		assertEquals(MTable.getUUIDIndexName("XYCUSTOM_ThisIsAVeryLongTableNameWith55CharactersOnName"      ), "XYCUSTOM_ThisIsAVeryLongTableNameWith55CharactersOnName_UU_idx" );
		assertEquals(MTable.getUUIDIndexName("XYZCUSTOM_ThisIsAVeryLongTableNameWith56CharactersOnName"     ), "XYZCUSTOM_ThisIsAVeryLongTableNameWith56CharactersOnName_UU_idx");
		assertEquals(MTable.getUUIDIndexName("XYZACUSTOM_ThisIsAVeryLongTableNameWith57CharactersOnName"    ), "XYZACUSTOM_ThisIsAVeryLongTableNameWith57CharactersOnName_uuidx");
	}
	
	@Test
	public void testGetKeyNamePairs() {
		TreeMaintenance tm = new TreeMaintenance();
		KeyNamePair[] treeKeyNamePairs = tm.getTreeData();
		assertTrue(treeKeyNamePairs.length > 0, "Failed to retrieve tree records");
		Optional<KeyNamePair> optional = Arrays.stream(treeKeyNamePairs).filter(e -> e.getKey() == DictionaryIDs.AD_Tree.GARDENWORLD_ORGANIZATION.id).findFirst();
		assertTrue(optional.isPresent(), "Failed to find Garden World Organization tree");
		
		KeyNamePair[] wfKeyNamePairs = MWorkflow.getWorkflowKeyNamePairs(false);
		assertTrue(wfKeyNamePairs.length > 0, "Failed to retrieve workflow records");
		optional = Arrays.stream(wfKeyNamePairs).filter(e -> e.getKey() == DictionaryIDs.AD_Workflow.PROCESS_ORDER.id).findFirst();
		assertTrue(optional.isPresent(), "Failed to find Process Order workflow");
		
		KeyNamePair[] asiKeyNamePairs = MAttributeSetInstance.getWithProductAttributeKeyNamePairs(DictionaryIDs.M_AttributeSet.PATIO_CHAIR.id, false);
		assertTrue(asiKeyNamePairs.length > 0, "Failed to retrieve Attribute Set Instance records");
		optional = Arrays.stream(asiKeyNamePairs).filter(e -> e.getKey() == DictionaryIDs.M_AttributeSetInstance.MEDIUM.id).findFirst();
		assertTrue(optional.isPresent(), "Failed to find Medium Patio Chair Attribute Set Instance record");
		asiKeyNamePairs = MAttributeSetInstance.getWithProductAttributeKeyNamePairs(DictionaryIDs.M_AttributeSet.PATIO_CHAIR.id, true);
		assertTrue(asiKeyNamePairs.length > 0, "Failed to retrieve Attribute Set Instance records");
		assertTrue(asiKeyNamePairs[0].getKey()==-1, "First element of return array is not en empty element as expected");
		asiKeyNamePairs = MAttributeSetInstance.getWithProductAttributeKeyNamePairs(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id, false);
		assertTrue(asiKeyNamePairs.length == 0, "Unexpected number of Attribute Set Instance records");
		
		KeyNamePair[] roleKeyNamePairs = MRole.getRoleKeyNamePairs();
		assertTrue(roleKeyNamePairs.length > 0, "Failed to retrieve Role records");
		optional = Arrays.stream(roleKeyNamePairs).filter(e -> e.getKey() == DictionaryIDs.AD_Role.GARDEN_WORLD_USER.id).findFirst();
		assertTrue(optional.isPresent(), "Failed to find Garden World User role record");
		
		KeyNamePair[] tableKeyNamePairs = MTable.getWithWindowAccessKeyNamePairs(false, null);
		assertTrue(tableKeyNamePairs.length > 0, "Failed to retrieve Table records");
		optional = Arrays.stream(tableKeyNamePairs).filter(e -> e.getKey() == MOrder.Table_ID).findFirst();
		assertTrue(optional.isPresent(), "Failed to find C_Order table record");
		
		KeyNamePair[] userKeyNamePairs = MUser.getWithRoleKeyNamePairs(false, null);
		assertTrue(userKeyNamePairs.length > 0, "Failed to retrieve User records");
		optional = Arrays.stream(userKeyNamePairs).filter(e -> e.getKey() == DictionaryIDs.AD_User.GARDEN_USER.id).findFirst();
		assertTrue(optional.isPresent(), "Failed to find Garden_User user record");
	}
	
	/**
	 * Test DB.createConnection with autoCommit true and READ_COMMITTED isolation level
	 * Tests that autoCommit=true automatically commits changes without explicit commit
	 */
	@Test
	public void testCreateConnectionAutoCommitTrue() throws Exception {
		java.sql.Connection conn = null;
		try {
			conn = DB.createConnection(true, java.sql.Connection.TRANSACTION_READ_COMMITTED);
			
			assertNotNull(conn, "Connection should not be null");
			assertTrue(conn.getAutoCommit(), "AutoCommit should be true");
			assertEquals(java.sql.Connection.TRANSACTION_READ_COMMITTED, conn.getTransactionIsolation(), 
					"Transaction isolation level should be READ_COMMITTED");
			
			// Verify connection is usable
			assertTrue(conn.isValid(5), "Connection should be valid");
			
			// Get initial value
			int initialValue = DB.getSQLValueEx(null, "SELECT t_integer FROM test WHERE test_id=?", TEST_RECORD_ID);
			
			// Update value using the connection with autoCommit=true
			String updateSql = "UPDATE test SET t_integer=? WHERE test_id=?";
			int newValue = initialValue + 777;
			try (java.sql.PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
				pstmt.setInt(1, newValue);
				pstmt.setInt(2, TEST_RECORD_ID);
				int rowsUpdated = pstmt.executeUpdate();
				assertEquals(1, rowsUpdated, "Should update 1 row");
			}
			// No explicit commit needed - autoCommit=true should have committed automatically
			
			// Verify the update is visible from a DIFFERENT connection immediately
			// This proves autoCommit=true worked (change was committed automatically)
			int valueFromOtherConnection = DB.getSQLValueEx(null, "SELECT t_integer FROM test WHERE test_id=?", TEST_RECORD_ID);
			assertEquals(newValue, valueFromOtherConnection, 
					"Value should be immediately visible from another connection (autoCommit worked)");
			
			// Restore original value
			try (java.sql.PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
				pstmt.setInt(1, initialValue);
				pstmt.setInt(2, TEST_RECORD_ID);
				pstmt.executeUpdate();
			}
			
			// Verify restoration
			int restoredValue = DB.getSQLValueEx(null, "SELECT t_integer FROM test WHERE test_id=?", TEST_RECORD_ID);
			assertEquals(initialValue, restoredValue, "Value should be restored to original");
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
	}
	
	/**
	 * Test DB.createConnection with autoCommit false and READ_COMMITTED isolation level
	 */
	@Test
	public void testCreateConnectionAutoCommitFalse() throws Exception {
		java.sql.Connection conn = null;
		try {
			conn = DB.createConnection(false, java.sql.Connection.TRANSACTION_READ_COMMITTED);
			
			assertNotNull(conn, "Connection should not be null");
			assertFalse(conn.getAutoCommit(), "AutoCommit should be false");
			assertEquals(java.sql.Connection.TRANSACTION_READ_COMMITTED, conn.getTransactionIsolation(), 
					"Transaction isolation level should be READ_COMMITTED");
			
			// Verify connection is usable
			assertTrue(conn.isValid(5), "Connection should be valid");
			
			// With autocommit false, we need to rollback or commit
			try (java.sql.PreparedStatement pstmt = conn.prepareStatement("SELECT 1 FROM DUAL")) {
				try (java.sql.ResultSet rs = pstmt.executeQuery()) {
					assertTrue(rs.next(), "Should have a result");
					assertEquals(1, rs.getInt(1), "Simple query should return 1");
				}
			}
			conn.rollback();
		} finally {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (Exception e) {}
				conn.close();
			}
		}
	}
	
	/**
	 * Test DB.createConnection with READ_UNCOMMITTED isolation level
	 */
	@Test
	public void testCreateConnectionReadUncommitted() throws Exception {
		if (DB.isOracle())
			return; // Oracle does not support READ_UNCOMMITTED
		
		java.sql.Connection conn = null;
		try {
			conn = DB.createConnection(true, java.sql.Connection.TRANSACTION_READ_UNCOMMITTED);
			
			assertNotNull(conn, "Connection should not be null");
			int isolationLevel = conn.getTransactionIsolation();
			assertTrue(isolationLevel == java.sql.Connection.TRANSACTION_READ_UNCOMMITTED,
					"Transaction isolation level should be READ_UNCOMMITTED");
			assertTrue(conn.isValid(5), "Connection should be valid");
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
	}
	
	/**
	 * Test DB.createConnection with REPEATABLE_READ isolation level
	 */
	@Test
	public void testCreateConnectionRepeatableRead() throws Exception {
		if (DB.isOracle())
			return; // Oracle does not support REPEATABLE_READ
		
		java.sql.Connection conn = null;
		try {
			conn = DB.createConnection(false, java.sql.Connection.TRANSACTION_REPEATABLE_READ);
			
			assertNotNull(conn, "Connection should not be null");
			// Note: Some databases may not support REPEATABLE_READ
			int isolationLevel = conn.getTransactionIsolation();
			assertTrue(isolationLevel >= java.sql.Connection.TRANSACTION_READ_COMMITTED,
					"Transaction isolation level should be at least READ_COMMITTED");
			assertTrue(conn.isValid(5), "Connection should be valid");
		} finally {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (Exception e) {}
				conn.close();
			}
		}
	}
	
	/**
	 * Test DB.createConnection with SERIALIZABLE isolation level
	 */
	@Test
	public void testCreateConnectionSerializable() throws Exception {
		java.sql.Connection conn = null;
		try {
			conn = DB.createConnection(true, java.sql.Connection.TRANSACTION_SERIALIZABLE);
			
			assertNotNull(conn, "Connection should not be null");
			int isolationLevel = conn.getTransactionIsolation();
			assertEquals(isolationLevel, java.sql.Connection.TRANSACTION_SERIALIZABLE,
					"Transaction isolation level should be Serializable");
			assertTrue(conn.isValid(5), "Connection should be valid");
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
	}
	
	/**
	 * Test that multiple connections created are independent
	 */
	@Test
	public void testCreateConnectionMultipleIndependent() throws Exception {
		java.sql.Connection conn1 = null;
		java.sql.Connection conn2 = null;
		try {
			conn1 = DB.createConnection(true, java.sql.Connection.TRANSACTION_READ_COMMITTED);
			// TRANSACTION_REPEATABLE_READ not supported by Oracle
			conn2 = DB.isOracle() ? DB.createConnection(false, java.sql.Connection.TRANSACTION_SERIALIZABLE) : DB.createConnection(false, java.sql.Connection.TRANSACTION_REPEATABLE_READ);
			
			assertNotNull(conn1, "Connection 1 should not be null");
			assertNotNull(conn2, "Connection 2 should not be null");
			
			// Verify they are different connection instances
			assertNotSame(conn1, conn2, "Connections should be different instances");
			
			// Verify each has its own properties
			assertTrue(conn1.getAutoCommit(), "Connection 1 should have autoCommit=true");
			assertFalse(conn2.getAutoCommit(), "Connection 2 should have autoCommit=false");
			
			// Both should be valid and usable
			assertTrue(conn1.isValid(5), "Connection 1 should be valid");
			assertTrue(conn2.isValid(5), "Connection 2 should be valid");
		} finally {
			if (conn1 != null) {
				conn1.close();
			}
			if (conn2 != null) {
				try {
					conn2.rollback();
				} catch (Exception e) {}
				conn2.close();
			}
		}
	}
	
	/**
	 * Test DB.getConnection convenience method
	 */
	@Test
	public void testGetConnection() throws Exception {
		java.sql.Connection conn = null;
		try {
			// Test with autoCommit=true
			conn = DB.getConnection(true);
			assertNotNull(conn, "Connection should not be null");
			assertTrue(conn.getAutoCommit(), "AutoCommit should be true");
			assertEquals(java.sql.Connection.TRANSACTION_READ_COMMITTED, conn.getTransactionIsolation(),
					"Default isolation level should be READ_COMMITTED");
			conn.close();
			
			// Test with autoCommit=false
			conn = DB.getConnection(false);
			assertNotNull(conn, "Connection should not be null");
			assertFalse(conn.getAutoCommit(), "AutoCommit should be false");
			assertEquals(java.sql.Connection.TRANSACTION_READ_COMMITTED, conn.getTransactionIsolation(),
					"Default isolation level should be READ_COMMITTED");
		} finally {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (Exception e) {}
				conn.close();
			}
		}
	}
	
	/**
	 * Test that connection can execute queries properly
	 */
	@Test
	public void testCreateConnectionExecuteQuery() throws Exception {
		java.sql.Connection conn = null;
		try {
			conn = DB.createConnection(true, java.sql.Connection.TRANSACTION_READ_COMMITTED);
			assertNotNull(conn, "Connection should not be null");
			
			// Execute a query using the connection
			String sql = "SELECT AD_Client_ID, Name FROM AD_Client WHERE AD_Client_ID=?";
			try (java.sql.PreparedStatement pstmt = conn.prepareStatement(sql)) {
				pstmt.setInt(1, DictionaryIDs.AD_Client.GARDEN_WORLD.id);
				try (java.sql.ResultSet rs = pstmt.executeQuery()) {
					assertTrue(rs.next(), "Should have at least one result");
					assertEquals(DictionaryIDs.AD_Client.GARDEN_WORLD.id, rs.getInt(1), "AD_Client_ID should be 11");
					assertNotNull(rs.getString(2), "Name should not be null");
				}
			}
		} finally {
			if (conn != null) {
				conn.close();
			}
		}
	}
	
	/**
	 * Test that connection properly handles transactions with autoCommit=false
	 */
	@Test
	public void testCreateConnectionTransactionRollback() throws Exception {
		java.sql.Connection conn = null;
		try {
			conn = DB.createConnection(false, java.sql.Connection.TRANSACTION_READ_COMMITTED);
			assertNotNull(conn, "Connection should not be null");
			assertFalse(conn.getAutoCommit(), "AutoCommit should be false");
			
			// Get initial value
			int initialValue = DB.getSQLValueEx(null, "SELECT t_integer FROM test WHERE test_id=?", TEST_RECORD_ID);
			
			// Update value using the connection (but don't commit)
			String updateSql = "UPDATE test SET t_integer=? WHERE test_id=?";
			try (java.sql.PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
				pstmt.setInt(1, initialValue + 999);
				pstmt.setInt(2, TEST_RECORD_ID);
				pstmt.executeUpdate();
			}
			
	        // Verify the update using the SAME connection
	        String selectSql = "SELECT t_integer FROM test WHERE test_id=?";
	        try (java.sql.PreparedStatement pstmt = conn.prepareStatement(selectSql)) {
	            pstmt.setInt(1, TEST_RECORD_ID);
	            try (java.sql.ResultSet rs = pstmt.executeQuery()) {
	                assertTrue(rs.next(), "Should have a result");
	                int updatedValue = rs.getInt(1);
	                assertEquals(initialValue + 999, updatedValue, "Value should be updated within transaction");
	            }
	        }

			// Rollback the transaction
			conn.rollback();
			
			// Verify value is unchanged
			int afterRollback = DB.getSQLValueEx(null, "SELECT t_integer FROM test WHERE test_id=?", TEST_RECORD_ID);
			assertEquals(initialValue, afterRollback, "Value should be unchanged after rollback");
		} finally {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (Exception e) {}
				conn.close();
			}
		}
	}
	
	/**
	 * Test DB.isSelectStatement with valid SELECT statements
	 */
	@Test
	public void testIsSelectStatementValid() {
		// Simple SELECT
		assertTrue(DB.isSelectStatement("SELECT * FROM AD_Client"), 
				"Simple SELECT should be valid");
		
		// SELECT with WHERE clause
		assertTrue(DB.isSelectStatement("SELECT AD_Client_ID, Name FROM AD_Client WHERE AD_Client_ID=11"), 
				"SELECT with WHERE should be valid");
		
		// SELECT with JOIN
		assertTrue(DB.isSelectStatement("SELECT c.AD_Client_ID, c.Name FROM AD_Client c JOIN AD_Org o ON c.AD_Client_ID=o.AD_Client_ID"), 
				"SELECT with JOIN should be valid");
		
		// SELECT with ORDER BY
		assertTrue(DB.isSelectStatement("SELECT Name FROM AD_Client ORDER BY Name"), 
				"SELECT with ORDER BY should be valid");
		
		// SELECT with GROUP BY
		assertTrue(DB.isSelectStatement("SELECT AD_Client_ID, COUNT(*) FROM AD_User GROUP BY AD_Client_ID"), 
				"SELECT with GROUP BY should be valid");
		
		// Uppercase SELECT
		assertTrue(DB.isSelectStatement("SELECT Name FROM AD_Client"), 
				"Uppercase SELECT should be valid");
		
		// Lowercase SELECT
		assertTrue(DB.isSelectStatement("select name from ad_client"), 
				"Lowercase SELECT should be valid");
		
		// Mixed case SELECT
		assertTrue(DB.isSelectStatement("SeLeCt NaMe FrOm AD_Client"), 
				"Mixed case SELECT should be valid");
	}
	
	/**
	 * Test DB.isSelectStatement with leading whitespace
	 */
	@Test
	public void testIsSelectStatementWithWhitespace() {
		// Leading spaces
		assertTrue(DB.isSelectStatement("   SELECT * FROM AD_Client"), 
				"SELECT with leading spaces should be valid");
		
		// Leading tabs
		assertTrue(DB.isSelectStatement("\t\tSELECT * FROM AD_Client"), 
				"SELECT with leading tabs should be valid");
		
		// Leading newlines
		assertTrue(DB.isSelectStatement("\n\nSELECT * FROM AD_Client"), 
				"SELECT with leading newlines should be valid");
		
		// Mixed leading whitespace
		assertTrue(DB.isSelectStatement("  \t\n  SELECT * FROM AD_Client"), 
				"SELECT with mixed leading whitespace should be valid");
	}
	
	/**
	 * Test DB.isSelectStatement with comments
	 */
	@Test
	public void testIsSelectStatementWithComments() {
		// Comment before SELECT
		assertTrue(DB.isSelectStatement("/* This is a comment */ SELECT * FROM AD_Client"), 
				"SELECT with comment before should be valid");
		
		// Comment after SELECT
		assertTrue(DB.isSelectStatement("SELECT /* inline comment */ * FROM AD_Client"), 
				"SELECT with inline comment should be valid");
		
		// Multi-line comment
		assertTrue(DB.isSelectStatement("/* This is a\nmulti-line\ncomment */ SELECT * FROM AD_Client"), 
				"SELECT with multi-line comment should be valid");
		
		// Multiple comments
		assertTrue(DB.isSelectStatement("/* Comment 1 */ SELECT /* Comment 2 */ * FROM AD_Client"), 
				"SELECT with multiple comments should be valid");
	}
	
	/**
	 * Test DB.isSelectStatement with quoted strings
	 */
	@Test
	public void testIsSelectStatementWithQuotedStrings() {
		// String in WHERE clause
		assertTrue(DB.isSelectStatement("SELECT * FROM AD_Client WHERE Name='GardenWorld'"), 
				"SELECT with quoted string should be valid");
		
		// String containing SELECT keyword
		assertTrue(DB.isSelectStatement("SELECT * FROM AD_Client WHERE Description='This SELECT is in a string'"), 
				"SELECT with 'SELECT' in quoted string should be valid");
		
		// String with newlines
		assertTrue(DB.isSelectStatement("SELECT * FROM AD_Client WHERE Name='Garden\nWorld'"), 
				"SELECT with newline in quoted string should be valid");
		
		// Multiple quoted strings
		assertTrue(DB.isSelectStatement("SELECT * FROM AD_Client WHERE Name='Test' OR Value='TEST'"), 
				"SELECT with multiple quoted strings should be valid");
	}
	
	/**
	 * Test DB.isSelectStatement with invalid statements (non-SELECT)
	 */
	@Test
	public void testIsSelectStatementInvalid() {
		// UPDATE statement
		assertFalse(DB.isSelectStatement("UPDATE AD_Client SET Name='Test' WHERE AD_Client_ID=11"), 
				"UPDATE should not be valid");
		
		// INSERT statement
		assertFalse(DB.isSelectStatement("INSERT INTO AD_Client (AD_Client_ID, Name) VALUES (999, 'Test')"), 
				"INSERT should not be valid");
		
		// DELETE statement
		assertFalse(DB.isSelectStatement("DELETE FROM AD_Client WHERE AD_Client_ID=999"), 
				"DELETE should not be valid");
		
		// CREATE statement
		assertFalse(DB.isSelectStatement("CREATE TABLE Test (ID INT)"), 
				"CREATE should not be valid");
		
		// DROP statement
		assertFalse(DB.isSelectStatement("DROP TABLE Test"), 
				"DROP should not be valid");
		
		// ALTER statement
		assertFalse(DB.isSelectStatement("ALTER TABLE AD_Client ADD COLUMN Test VARCHAR(60)"), 
				"ALTER should not be valid");
		
		// TRUNCATE statement
		assertFalse(DB.isSelectStatement("TRUNCATE TABLE Test"), 
				"TRUNCATE should not be valid");
		
		// Empty string
		assertFalse(DB.isSelectStatement(""), 
				"Empty string should not be valid");
		
		// Just whitespace
		assertFalse(DB.isSelectStatement("   "), 
				"Whitespace only should not be valid");
	}
	
	/**
	 * Test DB.isSelectStatement with semicolons (should be invalid)
	 */
	@Test
	public void testIsSelectStatementWithSemicolon() {
		// SELECT with semicolon at end
		assertFalse(DB.isSelectStatement("SELECT * FROM AD_Client;"), 
				"SELECT with semicolon should not be valid");
		
		// SELECT with semicolon in middle (SQL injection attempt)
		assertFalse(DB.isSelectStatement("SELECT * FROM AD_Client; DROP TABLE AD_Client"), 
				"SELECT with semicolon and additional statement should not be valid");
		
		// Multiple statements
		assertFalse(DB.isSelectStatement("SELECT * FROM AD_Client; SELECT * FROM AD_Org"), 
				"Multiple statements should not be valid");
	}
	
	/**
	 * Test DB.isSelectStatement with complex queries
	 */
	@Test
	public void testIsSelectStatementComplex() {
		// Subquery
		assertTrue(DB.isSelectStatement("SELECT * FROM AD_Client WHERE AD_Client_ID IN (SELECT AD_Client_ID FROM AD_Org WHERE IsActive='Y')"), 
				"SELECT with subquery should be valid");
		
		// UNION (single SELECT from perspective of the method)
		assertTrue(DB.isSelectStatement("SELECT Name FROM AD_Client UNION SELECT Name FROM AD_Org"), 
				"SELECT with UNION should be valid");
		
		// Complex joins with multiple conditions
		assertTrue(DB.isSelectStatement("SELECT c.Name, o.Name FROM AD_Client c LEFT JOIN AD_Org o ON c.AD_Client_ID=o.AD_Client_ID AND o.IsActive='Y' WHERE c.AD_Client_ID > 0"), 
				"SELECT with complex joins should be valid");
	}
	
	/**
	 * Test DB.isSelectStatement edge cases
	 */
	@Test
	public void testIsSelectStatementEdgeCases() {
		// SELECT as part of word should fail
		assertFalse(DB.isSelectStatement("SELECTFROM AD_Client"), 
				"SELECT without space after should not be valid");
		
		// Comment containing non-SELECT keyword
		assertTrue(DB.isSelectStatement("/* UPDATE */ SELECT * FROM AD_Client"), 
				"Comment with non-SELECT keyword should still be valid if SELECT follows");
		
		// Quoted string at start (not SELECT)
		assertFalse(DB.isSelectStatement("'SELECT' is a keyword"), 
				"Quoted SELECT at start should not be valid");
		
		// SELECT in quoted string but UPDATE as actual statement
		assertFalse(DB.isSelectStatement("UPDATE AD_Client SET Description='SELECT * FROM' WHERE AD_Client_ID=1"), 
				"UPDATE with SELECT in string should not be valid");
		
		// SELECT with DUAL (Oracle specific)
		assertTrue(DB.isSelectStatement("SELECT 1 FROM DUAL"), 
				"SELECT from DUAL should be valid");
	}
	
	/**
	 * Test DB.inClauseForCSV with ID columns (numeric)
	 */
	@Test
	public void testInClauseForCSV_IDColumns() {
		// Single ID
		String result = DB.inClauseForCSV("AD_Client_ID", "11");
		assertEquals("AD_Client_ID IN (11)", result, 
				"Single ID should create simple IN clause");
		
		// Multiple IDs
		result = DB.inClauseForCSV("AD_Client_ID", "11,0,1000");
		assertEquals("AD_Client_ID IN (11,0,1000)", result, 
				"Multiple IDs should be comma-separated without quotes");
		
		// ID with spaces after commas (spaces are preserved in split)
		result = DB.inClauseForCSV("AD_Client_ID", "11, 0, 1000");
		assertEquals("AD_Client_ID IN (11, 0, 1000)", result, 
				"Spaces after commas in CSV should be preserved for IDs");
		
		// Large list of IDs
		result = DB.inClauseForCSV("M_Product_ID", "100,101,102,103,104,105");
		assertEquals("M_Product_ID IN (100,101,102,103,104,105)", result, 
				"Large list of IDs should work correctly");
	}
	
	/**
	 * Test DB.inClauseForCSV with string columns
	 */
	@Test
	public void testInClauseForCSV_StringColumns() {
		// Single string value
		String result = DB.inClauseForCSV("Name", "Test");
		assertEquals("Name IN ('Test')", result, 
				"Single string should be quoted");
		
		// Multiple string values
		result = DB.inClauseForCSV("Name", "Test1,Test2,Test3");
		assertEquals("Name IN ('Test1','Test2','Test3')", result, 
				"Multiple strings should be quoted and comma-separated");
		
		// String values containing spaces
		result = DB.inClauseForCSV("Value", "Garden World,Joe Block,Standard");
		assertEquals("Value IN ('Garden World','Joe Block','Standard')", result, 
				"String values containing spaces should be properly quoted");
		
		// Empty string in CSV - TO_STRING converts empty strings to NULL
		result = DB.inClauseForCSV("Status", "Active,,Inactive");
		assertEquals("Status IN ('Active',NULL,'Inactive')", result, 
				"Empty values should be converted to NULL by TO_STRING");
	}
	
	/**
	 * Test DB.inClauseForCSV with quoted strings in CSV
	 */
	@Test
	public void testInClauseForCSV_QuotedStrings() {
		// Double-quoted strings should have quotes removed
		String result = DB.inClauseForCSV("Name", "\"Test1\",\"Test2\"");
		assertEquals("Name IN ('Test1','Test2')", result, 
				"Double quotes in CSV should be removed before adding SQL quotes");
		
		// Mix of quoted and unquoted
		result = DB.inClauseForCSV("Value", "\"Garden World\",Standard,\"Joe Block\"");
		assertEquals("Value IN ('Garden World','Standard','Joe Block')", result, 
				"Mix of quoted and unquoted should work correctly");
		
		// String with comma inside quotes - NOTE: quotes don't protect from split
		// The method splits by comma first, so "Test, with comma" becomes two values
		result = DB.inClauseForCSV("Description", "\"Test\",\"with comma\"");
		assertEquals("Description IN ('Test','with comma')", result, 
				"Double-quoted strings should have quotes removed");
	}
	
	/**
	 * Test DB.inClauseForCSV with NOT IN clause
	 */
	@Test
	public void testInClauseForCSV_NotInClause() {
		// NOT IN with IDs
		String result = DB.inClauseForCSV("AD_Client_ID", "11,0", true);
		assertEquals("AD_Client_ID NOT  IN (11,0)", result, 
				"NOT IN clause should include NOT keyword for IDs");
		
		// NOT IN with strings
		result = DB.inClauseForCSV("Status", "Draft,Invalid", true);
		assertEquals("Status NOT  IN ('Draft','Invalid')", result, 
				"NOT IN clause should include NOT keyword for strings");
		
		// NOT IN with single value
		result = DB.inClauseForCSV("DocStatus", "VO", true);
		assertEquals("DocStatus NOT  IN ('VO')", result, 
				"NOT IN with single value should work");
		
		// Regular IN (false parameter)
		result = DB.inClauseForCSV("AD_Org_ID", "100,200", false);
		assertEquals("AD_Org_ID IN (100,200)", result, 
				"false parameter should create regular IN clause");
	}
	
	/**
	 * Test DB.inClauseForCSV with convenience method (no isNotClause parameter)
	 */
	@Test
	public void testInClauseForCSV_ConvenienceMethod() {
		// Should default to regular IN clause (not NOT IN)
		String result = DB.inClauseForCSV("AD_Table_ID", "100,200,300");
		assertEquals("AD_Table_ID IN (100,200,300)", result, 
				"Convenience method should create regular IN clause");
		
		result = DB.inClauseForCSV("EntityType", "D,U");
		assertEquals("EntityType IN ('D','U')", result, 
				"Convenience method with strings should work");
	}
	
	/**
	 * Test DB.inClauseForCSV with edge cases
	 */
	@Test
	public void testInClauseForCSV_EdgeCases() {
		// Single value
		String result = DB.inClauseForCSV("AD_Client_ID", "11");
		assertEquals("AD_Client_ID IN (11)", result, 
				"Single value should work");
		
		// Value with leading/trailing spaces in column name
		result = DB.inClauseForCSV("AD_User_ID", "100");
		assertEquals("AD_User_ID IN (100)", result, 
				"Column name should be used as-is");
		
		// Numeric strings for non-ID column
		result = DB.inClauseForCSV("Code", "123,456");
		assertEquals("Code IN ('123','456')", result, 
				"Numeric values for non-ID columns should be quoted");
		
		// Special characters in string values - single quotes are escaped by doubling
		result = DB.inClauseForCSV("Value", "Test's,Another");
		assertEquals("Value IN ('Test''s','Another')", result, 
				"Single quotes should be escaped by doubling them");
	}
	
	/**
	 * Test DB.inClauseForCSV with different column name patterns
	 */
	@Test
	public void testInClauseForCSV_ColumnNamePatterns() {
		// Columns ending with _ID
		String result = DB.inClauseForCSV("C_BPartner_ID", "100,200");
		assertEquals("C_BPartner_ID IN (100,200)", result, 
				"Column ending with _ID should not quote values");
		
		result = DB.inClauseForCSV("Record_ID", "1,2,3");
		assertEquals("Record_ID IN (1,2,3)", result, 
				"Any column ending with _ID should treat values as numeric");
		
		// Columns NOT ending with _ID
		result = DB.inClauseForCSV("Name", "100,200");
		assertEquals("Name IN ('100','200')", result, 
				"Column not ending with _ID should quote values");
		
		result = DB.inClauseForCSV("Value", "Test");
		assertEquals("Value IN ('Test')", result, 
				"String column should quote values");
		
		// Column with ID in the middle (not at end)
		result = DB.inClauseForCSV("ID_Column", "100");
		assertEquals("ID_Column IN ('100')", result, 
				"Column with _ID not at end should quote values");
	}
	
	/**
	 * Test DB.inClauseForCSV with real-world scenarios
	 */
	@Test
	public void testInClauseForCSV_RealWorldScenarios() {
		// Client IDs
		String result = DB.inClauseForCSV("AD_Client_ID", "0,11");
		assertEquals("AD_Client_ID IN (0,11)", result, 
				"System and GardenWorld client IDs");
		
		// Document statuses
		result = DB.inClauseForCSV("DocStatus", "CO,CL");
		assertEquals("DocStatus IN ('CO','CL')", result, 
				"Completed and Closed document statuses");
		
		// Entity types
		result = DB.inClauseForCSV("EntityType", "D,U");
		assertEquals("EntityType IN ('D','U')", result, 
				"Dictionary and User entity types");
		
		// Product IDs
		result = DB.inClauseForCSV("M_Product_ID", "123,124,125,126,127");
		assertEquals("M_Product_ID IN (123,124,125,126,127)", result, 
				"Multiple product IDs");
		
		// NOT IN for excluding certain values
		result = DB.inClauseForCSV("DocStatus", "VO,RE,IN", true);
		assertEquals("DocStatus NOT  IN ('VO','RE','IN')", result, 
				"Exclude voided, reversed, and invalid statuses");
		
		// Table names with mixed case
		result = DB.inClauseForCSV("TableName", "AD_Client,AD_Org,C_BPartner");
		assertEquals("TableName IN ('AD_Client','AD_Org','C_BPartner')", result, 
				"Table names should be quoted");
	}
	
	/**
	 * Test DB.inClauseForCSV verifying actual SQL usage
	 */
	@Test
	public void testInClauseForCSV_ActualSQLUsage() {
		// Build a WHERE clause using inClauseForCSV and execute it
		String inClause = DB.inClauseForCSV("AD_Client_ID", "0,11");
		String sql = "SELECT COUNT(*) FROM AD_Client WHERE " + inClause;
		
		int count = DB.getSQLValue(null, sql);
		assertTrue(count >= 2, "Should find at least System and GardenWorld clients");
		
		// Test with string column
		inClause = DB.inClauseForCSV("EntityType", "D");
		sql = "SELECT COUNT(*) FROM AD_Table WHERE " + inClause;
		
		count = DB.getSQLValue(null, sql);
		assertTrue(count > 0, "Should find Dictionary tables");
		
		// Test NOT IN clause
		inClause = DB.inClauseForCSV("AD_Client_ID", "999999", true);
		sql = "SELECT COUNT(*) FROM AD_Client WHERE " + inClause;
		
		count = DB.getSQLValue(null, sql);
		assertTrue(count >= 2, "NOT IN with non-existent ID should return all clients");
	}
	
}
