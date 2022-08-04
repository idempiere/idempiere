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
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MTable;
import org.compiere.model.X_Test;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.TimeUtil;
import org.compiere.util.ValueNamePair;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;

/**
 * Test {@link org.compiere.util.DB} class
 * @author Teo Sarca, www.arhipac.ro
 * @author hengsin
 */
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
}
