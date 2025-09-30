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
import static org.junit.jupiter.api.Assertions.assertNotNull;
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
		assertEquals(test.getTest_UU(), objects.get(1));
		
		objects = DB.getSQLValueObjectsEx(getTrxName(), sql.toString(), TEST_RECORD_ID);
		assertEquals(2, objects.size());
		assertEquals(test.get_ID(), ((Number)objects.get(0)).intValue());
		assertEquals(test.getTest_UU(), objects.get(1));
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
	
}
