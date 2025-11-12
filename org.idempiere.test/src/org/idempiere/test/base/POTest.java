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
 * - teo sarca														   *
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.dbPort.Convert;
import org.compiere.model.I_AD_UserPreference;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MBPGroup;
import org.compiere.model.MBPartner;
import org.compiere.model.MCalendar;
import org.compiere.model.MChangeLog;
import org.compiere.model.MClient;
import org.compiere.model.MClientShare;
import org.compiere.model.MColumn;
import org.compiere.model.MMessage;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProductionLine;
import org.compiere.model.MSession;
import org.compiere.model.MTable;
import org.compiere.model.MTest;
import org.compiere.model.MTestUU;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.Query;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Tests for {@link org.compiere.model.PO} class.
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * @author hengsin
 * 
 * Run Isolated because of migration script file management
 */
@Isolated
public class POTest extends AbstractTestCase
{
	public static class MyTestPO extends MTest
	{
		private static final long serialVersionUID = -6861171283806782985L;
		protected boolean failOnSave = false;


		private MyTestPO m_parent = null;
		private MyTestPO m_dependentRecord = null;

		public static String getName(int Test_ID, String trxName)
		{
			String sql = "SELECT "+COLUMNNAME_Name+" FROM "+Table_Name
			+" WHERE "+COLUMNNAME_Test_ID+"=?";
			return DB.getSQLValueStringEx(trxName, sql, Test_ID);
		}

		public static boolean exists(int Test_ID, String trxName)
		{
			final String sql = "SELECT "+COLUMNNAME_Test_ID+" FROM "+Table_Name
			+" WHERE "+COLUMNNAME_Test_ID+"=?";
			int id = DB.getSQLValueEx(trxName, sql, Test_ID);
			return id > 0 && id == Test_ID;
		}

		public MyTestPO(Properties ctx, boolean failOnSave, String trxName)
		{
			super(ctx, "Test_"+System.currentTimeMillis(), 10, trxName);
			this.setDescription(""+getClass());
			this.failOnSave = failOnSave;
		}
		public MyTestPO(Properties ctx, int id, String trxName)
		{
			super(ctx, id, trxName);
		}
		@Override
		protected boolean afterSave(boolean newRecord, boolean success)
		{
			if (m_parent == null)
			{
				m_dependentRecord = new MyTestPO(getCtx(), false, get_TrxName());
				m_dependentRecord.m_parent = this;
				m_dependentRecord.setName("D_"+this.getName());
				m_dependentRecord.saveEx();
			}

			if (this.failOnSave)
				throw new RuntimeException("Never save this object [trxName="+get_TrxName()+", success="+success+"]");
			return true;
		}

		public int getDependent_ID()
		{
			return (m_dependentRecord != null ? m_dependentRecord.get_ID() : -1);
		}
	};

	/**
	 * Tests the following methods:
	 * <ul> 
	 * <li>{@link org.compiere.model.PO#is_Changed()}
	 * <li>{@link org.compiere.model.PO#is_ValueChanged(String)}
	 * </ul> 
	 * Applies to following bugs:
	 * <ul>
	 * <li>[ 1704828 ] PO.is_Changed() and PO.is_ValueChanged are not consistent
	 * </ul>
	 */
	@Test
	public void test_Changed() 
	{
		String[] testStrings = new String[] {
				"a",
				"test",
		};
		// Create the test PO and save
		MTest testPO = new MTest(Env.getCtx(), getClass().getName(), 1, getTrxName());

		for (String str : testStrings)
		{
			testPO.setHelp(str);
			testPO.saveEx();
			String originalString = testPO.getHelp();
			String info = "testString=[" + str + "]" + ", originalString=[" + originalString + "]";

			// Initial asserts (nothing changed)
			assertFalse(testPO.is_ValueChanged(MTest.COLUMNNAME_Help), info);	
			assertFalse(testPO.is_Changed(), info);
			// Set the same name
			testPO.setHelp(originalString);
			assertFalse(testPO.is_ValueChanged(MTest.COLUMNNAME_Help), info);
			assertFalse(testPO.is_Changed(), info);
			// Set a new name
			testPO.setHelp(originalString+"-changed");
			assertTrue(testPO.is_ValueChanged(MTest.COLUMNNAME_Help), info);
			assertTrue(testPO.is_Changed(), info);
			// Set the original name back
			testPO.setHelp(originalString);
			assertFalse(testPO.is_ValueChanged(MTest.COLUMNNAME_Help), info);
			assertFalse(testPO.is_Changed(), info);
		}

		// Finally, delete the testPO
		testPO.delete(true, getTrxName());
		assertFalse(testPO.is_ValueChanged(-1));
		assertFalse(testPO.is_ValueChanged(Integer.MAX_VALUE));
		assertFalse(testPO.is_ValueChanged("NonExistentColumn") );
	}


	/**
	 * <li>BF [ 1990856 ] PO.set_Value* : truncate string more than needed
	 */
	@Test
	public void testTruncatedStrings() {
		//
		// Creating a huge string for testing:
		StringBuilder sb = new StringBuilder();
		for (int i = 1; i <= 1000; i++) {
			sb.append("0123456789");
		}
		String bigString = sb.toString();
		//
		// Create the test PO:
		MTest testPO = new MTest(Env.getCtx(), getClass().getName(), 1, getTrxName());
		//
		// Getting Max Length:
		POInfo info = POInfo.getPOInfo(Env.getCtx(), MTest.Table_ID);
		int maxLength = info.getFieldLength(info.getColumnIndex(MTest.COLUMNNAME_Name));
		//
		// Test with a string that has less then maxLength
		{
			testPO.set_ValueOfColumn(MTest.COLUMNNAME_Name, bigString.substring(0, maxLength - 1));
			String resultString = (String) testPO.get_Value(MTest.COLUMNNAME_Name);
			assertEquals(maxLength - 1, resultString.length(), "String was not truncated correctly (1)");
			//
			testPO.setName(bigString.substring(0, maxLength - 1));
			assertEquals(maxLength - 1, testPO.getName().length(), "String was not truncated correctly (2)");
		}
		//
		// Test with a string that has maxLength
		{
			testPO.set_ValueOfColumn(MTest.COLUMNNAME_Name, bigString.substring(0, maxLength));
			String resultString = (String) testPO.get_Value(MTest.COLUMNNAME_Name);
			assertEquals(maxLength, resultString.length(), "String was not truncated correctly (3)");
			//
			testPO.setName(bigString.substring(0, maxLength));
			assertEquals(maxLength, testPO.getName().length(), "String was not truncated correctly (4)");
		}
		//
		// Test with a string that has more than maxLength 
		{
			testPO.set_ValueOfColumn(MTest.COLUMNNAME_Name, bigString);
			String resultString = (String) testPO.get_Value(MTest.COLUMNNAME_Name);
			assertEquals(maxLength, resultString.length(), "String was not truncated correctly (5)");
			//
			testPO.setName(bigString);
			assertEquals(maxLength, testPO.getName().length(), "String was not truncated correctly (6)");
		}
	}

	/**
	 * Object should NOT be saved if afterSave fails EVEN if is outside transaction (trxName=null)
	 */
	@Test
	public void testAfterSaveError()
	{
		//
		// Test for new objects
		{
			MyTestPO test = new MyTestPO(Env.getCtx(), true, null);
			assertFalse(test.save(), "Object should not be saved -- "+test);
			assertFalse(test.get_ID() <= 0, "Object should not be saved -- "+test);
			assertFalse(MyTestPO.exists(test.get_ID(), null), "Object should not be saved(2) -- "+test);
		}
		//
		// Test for old objects
		MyTestPO test = null;
		try
		{
			test = new MyTestPO(Env.getCtx(), false, null);
			assertTrue(test.save(), "Object *should* be saved -- "+test);
			//
			MyTestPO test2 = new MyTestPO(Env.getCtx(), test.get_ID(), null);
			assertEquals(test2.get_ID(), test.get_ID(), "Object not found");
			test2.failOnSave = true;
			test2.setName(test2.getName()+"_2");
			assertFalse(test2.save(), "Object should not be saved -- "+test2);
			//
			String name = MyTestPO.getName(test2.get_ID(), null);
			assertEquals(test.getName(), name, "Object should not be modified(2) -- id="+test2);
		}
		finally
		{
			// cleanup
			if (test != null)
			{
				if (test.getDependent_ID() > 0)
				{
					MyTestPO testDependent = new MyTestPO(Env.getCtx(), test.getDependent_ID(), null);
					testDependent.deleteEx(true);
				}
				test.deleteEx(true);
			}
		}
	}

	/**
	 * If one object fails on after save we should not revert all transaction.
	 * BF [ 2849122 ] PO.AfterSave is not rollback on error
	 * https://sourceforge.net/p/adempiere/bugs/2073/
	 */
	@Test
	public void testAfterSaveError_BF2849122() 
	{
		assertNotNull(getTrxName(), "TrxName should not be null");

		MyTestPO t1 = new MyTestPO(Env.getCtx(), false, getTrxName());
		t1.saveEx();
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "Object not found(1) - t1="+t1);
		assertTrue(MyTestPO.exists(t1.getDependent_ID(), getTrxName()), "Object not found(1) - t1(dep)="+t1);
		//
		final MyTestPO t2 = new MyTestPO(Env.getCtx(), true, getTrxName());
		try
		{
			t2.saveEx();
		}
		catch (Exception e){}
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "Object not found(2) - t1="+t1);
		assertTrue(MyTestPO.exists(t1.getDependent_ID(), getTrxName()), "Object not found(2) - t1(dep)="+t1);
		assertFalse(MyTestPO.exists(t2.get_ID(), getTrxName()), "Object found(2) - t2="+t2);
		assertFalse(MyTestPO.exists(t2.getDependent_ID(), getTrxName()), "Object found(2) - t2(dep)="+t2);
		//
		final MyTestPO t3 = new MyTestPO(Env.getCtx(), false, getTrxName());
		t3.saveEx();
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "Object not found(3) - t1="+t1);
		assertTrue(MyTestPO.exists(t1.getDependent_ID(), getTrxName()), "Object not found(3) - t1(dep)="+t1);
		assertFalse(MyTestPO.exists(t2.get_ID(), getTrxName()), "Object found(3) - t2="+t2);
		assertFalse(MyTestPO.exists(t2.getDependent_ID(), getTrxName()), "Object found(3) - t2(dep)="+t2);
		assertTrue(MyTestPO.exists(t3.get_ID(), getTrxName()), "Object not found(3) - t3="+t3);
		assertTrue(MyTestPO.exists(t3.getDependent_ID(), getTrxName()), "Object not found(3) - t3(dep)="+t3);
	}

	@Test
	public void testForUpdate()
	{
		MClient client = new MClient(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()), getTrxName());
		assertDoesNotThrow(() -> {
			boolean ok = DB.getDatabase().forUpdate(client, 5);
			assertTrue(ok);
		});
		
		Trx trx2 = Trx.get(Trx.createTrxName(), true);
		try {
			trx2.start();
			MClient client2 = new MClient(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()), trx2.getTrxName());
			assertThrows(DBException.class, () -> {
				DB.getDatabase().forUpdate(client2, 5);
			});
		} finally {
			trx2.close();
		}
		
		String description = client.getDescription();
		client.setDescription(client.getName()+".Description");
		assertDoesNotThrow(() -> {
			client.saveEx();
		});
		rollback();
		client.load(getTrxName());
		assertEquals(description, client.getDescription());
		
		Trx trx3 = Trx.get(Trx.createTrxName(), true);
		try {
			trx3.start();
			MClient client3 = new MClient(Env.getCtx(), Env.getAD_Client_ID(Env.getCtx()), trx3.getTrxName());
			assertDoesNotThrow(() -> {
				boolean ok = DB.getDatabase().forUpdate(client3, 5);
				assertTrue(ok);
			});
		} finally {
			trx3.close();
		}
	}
	
	@Test
	public void testOptimisticLocking() 
	{
		int joeBlock = 118;
		MBPartner bp1 = new MBPartner(Env.getCtx(), joeBlock, getTrxName());
		MBPartner bp2 = new MBPartner(Env.getCtx(), joeBlock, getTrxName());
		
		//normal update without optimistic locking
		bp1.setDescription("bp1");
		boolean updated = bp1.save();
		assertTrue(updated);
		
		bp2.setDescription("bp2");
		updated = bp2.save();
		assertTrue(updated);
		
		//last update ok, description=bp2
		bp1 = new MBPartner(Env.getCtx(), joeBlock, getTrxName());
		bp2 = new MBPartner(Env.getCtx(), joeBlock, getTrxName());
		assertEquals("bp2", bp1.getDescription());
		assertEquals("bp2", bp2.getDescription());
		
		//test update with default optimistic locking using updated timestamp
		bp1.set_UseOptimisticLocking(true);
		bp1.setDescription("bp1");
		if (DB.isOracle()) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
			}
		}
		updated = bp1.save();
		assertTrue(updated);
		
		bp2.set_UseOptimisticLocking(true);
		bp2.setDescription("bp2.1");
		updated = bp2.save();
		assertFalse(updated);
		
		//last update fail, description=bp1
		bp1 = new MBPartner(Env.getCtx(), joeBlock, getTrxName());
		bp2 = new MBPartner(Env.getCtx(), joeBlock, getTrxName());
		assertEquals("bp1", bp1.getDescription());
		assertEquals("bp1", bp2.getDescription());
		
		//test update with custom optimistic locking columns
		bp1.set_UseOptimisticLocking(true);
		bp1.setDescription("bp1.1");
		updated = bp1.save();
		assertTrue(updated);
		
		bp2.set_UseOptimisticLocking(true);
		bp2.set_OptimisticLockingColumns(new String[] {"Name"});
		bp2.setDescription("bp2");
		updated = bp2.save();
		assertTrue(updated);
		
		//last update ok, description=bp2
		bp1 = new MBPartner(Env.getCtx(), joeBlock, getTrxName());
		bp2 = new MBPartner(Env.getCtx(), joeBlock, getTrxName());
		assertEquals("bp2", bp1.getDescription());
		assertEquals("bp2", bp2.getDescription());
		
		//test update with custom multiple column optimistic locking
		bp1.set_UseOptimisticLocking(true);
		bp1.setDescription("bp1");
		updated = bp1.save();
		assertTrue(updated);
		
		bp2.set_UseOptimisticLocking(true);
		bp2.set_OptimisticLockingColumns(new String[] {"Name","Description"});
		bp2.setDescription("bp2.1");
		updated = bp2.save();
		assertFalse(updated);
		
		//last update fail, description=bp1
		bp1 = new MBPartner(Env.getCtx(), joeBlock, getTrxName());
		bp2 = new MBPartner(Env.getCtx(), joeBlock, getTrxName());
		assertEquals("bp1", bp1.getDescription());
		assertEquals("bp1", bp2.getDescription());
		
		MMessage msg1 = new MMessage(Env.getCtx(), 0, getTrxName());
		msg1.setValue("msg1 test");
		msg1.setMsgText("msg1 test");
		msg1.setMsgType(MMessage.MSGTYPE_Information);
		msg1.saveEx();
		
		//test normal delete
		updated = msg1.delete(true);
		assertTrue(updated);
		
		msg1 = new MMessage(Env.getCtx(), 0, getTrxName());
		msg1.setValue("msg1 test");
		msg1.setMsgText("msg1 test");
		msg1.setMsgType(MMessage.MSGTYPE_Information);
		msg1.saveEx();
		
		//test delete with default optimistic locking
		MMessage msg2 = new MMessage(Env.getCtx(), msg1.getAD_Message_ID(), getTrxName());				
		msg1.setMsgText("msg 1.1 test");
		if (DB.isOracle()) {
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
			}
		}
		msg1.saveEx();
		
		msg2.set_UseOptimisticLocking(true);
		updated = msg2.delete(true);
		assertFalse(updated);
		
		//test delete with custom optimistic locking columns
		msg2 = new MMessage(Env.getCtx(), msg1.getAD_Message_ID(), getTrxName());
		assertEquals(msg1.getMsgText(), msg2.getMsgText());		
		msg1.setMsgText("msg1 test");
		msg1.saveEx();
		msg2.set_UseOptimisticLocking(true);
		msg2.set_OptimisticLockingColumns(new String[] {"Value"});
		updated = msg2.delete(true);
		assertTrue(updated);
		
		//test delete with multiple custom optimistic locking columns
		msg1 = new MMessage(Env.getCtx(), 0, getTrxName());
		msg1.setValue("msg1 test");
		msg1.setMsgText("msg1 test");
		msg1.setMsgType(MMessage.MSGTYPE_Information);
		msg1.saveEx();
		msg2 = new MMessage(Env.getCtx(), msg1.getAD_Message_ID(), getTrxName());
		msg1.setMsgText("msg 1.1 test");
		msg1.saveEx();
		msg2.set_UseOptimisticLocking(true);
		msg2.set_OptimisticLockingColumns(new String[] {"Value", "MsgText"});
		updated = msg2.delete(true);
		assertFalse(updated);
		
		msg2 = new MMessage(Env.getCtx(), msg1.getAD_Message_ID(), getTrxName());
		assertEquals(msg1.getMsgText(), msg2.getMsgText());
	}

	@Test
	public void testVirtualColumnLoad() {
		MTest testPo = new MTest(Env.getCtx(), getClass().getName(), 1, getTrxName());
		testPo.save();

		// asynchronous (default) virtual column loading
		assertTrue(null == testPo.get_ValueOld(MTest.COLUMNNAME_TestVirtualQty));
		BigDecimal expected = new BigDecimal("123.45");
		assertEquals(expected, testPo.getTestVirtualQty().setScale(2, RoundingMode.HALF_UP), "Wrong value returned");

		// synchronous virtual column loading
		testPo = new MTest(Env.getCtx(), testPo.get_ID(), getTrxName(), MTest.COLUMNNAME_TestVirtualQty);
		assertTrue(null != testPo.get_ValueOld(MTest.COLUMNNAME_TestVirtualQty));
		assertEquals(expected, testPo.getTestVirtualQty().setScale(2, RoundingMode.HALF_UP), "Wrong value returned");
	}

	@Test
	public void testLogMigrationScript() {
		MClient client = MClient.get(Env.getCtx());
		MAcctSchema as = client.getAcctSchema();
		
		assertFalse(Env.isLogMigrationScript(MProduct.Table_Name), "Unexpected Log Migration Script default for MProduct");
		Env.getCtx().setProperty(Ini.P_LOGMIGRATIONSCRIPT, "Y");
		Env.setContext(Env.getCtx(), I_AD_UserPreference.COLUMNNAME_MigrationScriptComment, "testLogMigrationScript");
		assertTrue(Env.isLogMigrationScript(MProduct.Table_Name), "Unexpected Log Migration Script Y/N value for MProduct");
		
		MProductCategory lotLevel = new MProductCategory(Env.getCtx(), 0, null);
		lotLevel.setName("testLogMigrationScript");
		lotLevel.saveEx();
		MProduct product = null;
		try {
			MProductCategoryAcct lotLevelAcct = MProductCategoryAcct.get(lotLevel.get_ID(), as.get_ID());
			lotLevelAcct = new MProductCategoryAcct(Env.getCtx(), lotLevelAcct);
			lotLevelAcct.setCostingLevel(MAcctSchema.COSTINGLEVEL_BatchLot);
			lotLevelAcct.saveEx();
			
			product = new MProduct(Env.getCtx(), 0, null);
			product.setM_Product_Category_ID(lotLevel.get_ID());
			product.setName("testLogMigrationScript");
			product.setProductType(MProduct.PRODUCTTYPE_Item);
			product.setIsStocked(true);
			product.setIsSold(true);
			product.setIsPurchased(true);
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.setM_AttributeSet_ID(DictionaryIDs.M_AttributeSet.FERTILIZER_LOT.id);
			product.saveEx();
		} finally {
			rollback();
			
			if (product != null) {
				product.set_TrxName(null);
				product.deleteEx(true);
			}
			
			lotLevel.deleteEx(true);
		}
		
		String fileName = Convert.getGeneratedMigrationScriptFileName();
		String folderPg = Convert.getMigrationScriptFolder("postgresql");
		String folderOr = Convert.getMigrationScriptFolder("oracle");
		Convert.closeLogMigrationScript();
		File file = new File(folderPg + fileName);
		assertTrue(file.exists(), "Not found: " + folderPg + fileName);
		file.delete();
		file = new File(folderOr + fileName);
		assertTrue(file.exists(), "Not found: " + folderOr + fileName);
		file.delete();
	}
	
	@Test
	public void testIsVirtualColumnMethods() {
		//column sql with no prefix
		MColumn column = MColumn.get(Env.getCtx(), MTest.Table_Name, MTest.COLUMNNAME_TestVirtualQty);
		assertTrue(column.isVirtualColumn(), "MColumn.isVirtualColumn() not working as expected for ColumnSQL="+column.getColumnSQL());
		assertTrue(column.isVirtualDBColumn(), "MColumn.isVirtualDBColumn() not working as expected for ColumnSQL="+column.getColumnSQL());
		assertFalse(column.isVirtualUIColumn(), "MColumn.isVirtualUIColumn() not working as expected for ColumnSQL="+column.getColumnSQL());
		assertFalse(column.isVirtualSearchColumn(), "MColumn.isVirtualSearchColumn() not working as expected for ColumnSQL="+column.getColumnSQL());

		//column sql with @SQLFIND= prefix
		column = MColumn.get(Env.getCtx(), MProductionLine.Table_Name, "ProductType");
		assertTrue(column.isVirtualColumn(), "MColumn.isVirtualColumn() not working as expected for ColumnSQL="+column.getColumnSQL());
		assertFalse(column.isVirtualDBColumn(), "MColumn.isVirtualDBColumn() not working as expected for ColumnSQL="+column.getColumnSQL());
		assertFalse(column.isVirtualUIColumn(), "MColumn.isVirtualUIColumn() not working as expected for ColumnSQL="+column.getColumnSQL());
		assertTrue(column.isVirtualSearchColumn(), "MColumn.isVirtualSearchColumn() not working as expected for ColumnSQL="+column.getColumnSQL());
		
		//column sql with @SQL= prefix
		column = MColumn.get(Env.getCtx(), MTest.Table_Name, MTest.COLUMNNAME_TestVirtualQty);
		column = new MColumn(column);
		column.setColumnSQL(MColumn.VIRTUAL_UI_COLUMN_PREFIX+column.getColumnSQL());
		assertTrue(column.isVirtualColumn(), "MColumn.isVirtualColumn() not working as expected for ColumnSQL="+column.getColumnSQL());
		assertFalse(column.isVirtualDBColumn(), "MColumn.isVirtualDBColumn() not working as expected for ColumnSQL="+column.getColumnSQL());
		assertTrue(column.isVirtualUIColumn(), "MColumn.isVirtualUIColumn() not working as expected for ColumnSQL="+column.getColumnSQL());
		assertFalse(column.isVirtualSearchColumn(), "MColumn.isVirtualSearchColumn() not working as expected for ColumnSQL="+column.getColumnSQL());
	}
	
	@Test
	public void testChangeLog() {
		MSession.create(Env.getCtx());
		MSession session = MSession.get(Env.getCtx());
		MProduct product = new MProduct(Env.getCtx(), DictionaryIDs.M_Product.AZALEA_BUSH.id, null);
		String description = product.getDescription();
		try {
			product.setDescription(description != null ? description + "+1" : "+1");
			product.saveEx();
			
			Query query = new Query(Env.getCtx(), MChangeLog.Table_Name, "AD_Session_ID=? AND AD_Table_ID=? AND Record_ID=? AND AD_Column_ID=? AND NewValue=?", null);
			MColumn column = MColumn.get(Env.getCtx(), MProduct.Table_Name, MProduct.COLUMNNAME_Description);
			MChangeLog changeLog = query.setParameters(session.get_ID(), MProduct.Table_ID, product.get_ID(), column.get_ID(), product.getDescription()).first();
			assertNotNull(changeLog);
			assertTrue(changeLog.getAD_ChangeLog_ID() > 0);
			
			session.addSkipChangeLogForUpdate(MProduct.Table_Name);
			product.setDescription(description != null ? description + "+2" : "+2");
			product.saveEx();
			
			changeLog = query.setParameters(session.get_ID(), MProduct.Table_ID, product.get_ID(), column.get_ID(), product.getDescription()).first();
			assertNull(changeLog);
			
			session.removeSkipChangeLogForUpdate(MProduct.Table_Name);
			product.setDescription(description != null ? description + "+3" : "+3");
			product.saveEx();
			
			changeLog = query.setParameters(session.get_ID(), MProduct.Table_ID, product.get_ID(), column.get_ID(), product.getDescription()).first();
			assertNotNull(changeLog);
			assertTrue(changeLog.getAD_ChangeLog_ID() > 0);
		} finally {
			product.setDescription(description);
			product.saveEx();
		}
	}
	
	@Test
	public void test_New() 
	{
		MTest testPO = new MTest(Env.getCtx(), 0, getTrxName());
        assertTrue(testPO.is_new());
        
		testPO = new MTest(Env.getCtx(), 103, getTrxName());
        assertFalse(testPO.is_new());
	}
	
    @Test
    void testSetGet_Value() {
		MTest testPO = new MTest(Env.getCtx(), 0, getTrxName());
        testPO.set_ValueNoCheck(MTest.COLUMNNAME_Name, "TestName");
        assertEquals("TestName", testPO.get_Value("Name"));
        
		testPO.set_ValueOfColumn(MTest.COLUMNNAME_Name, "New Name");
        assertEquals("New Name", testPO.get_Value("Name"));
        
		testPO.set_ValueOfColumn(326, "Newest Name");
        assertEquals("Newest Name", testPO.get_Value("Name"));
        assertEquals("Newest Name", testPO.get_ValueOfColumn(326));
        
        assertTrue(testPO.set_ValueOfColumnReturningBoolean("Name", "String name"));
        
        // Test setting boolean value on a String column
        assertFalse(testPO.set_ValueOfColumnReturningBoolean("Name", true));
        assertFalse(testPO.set_ValueOfColumnReturningBoolean(326, true));
        
        // Invalid column index and name
        assertNull(testPO.get_Value(-1));
        assertNull(testPO.get_Value(Integer.MAX_VALUE));
        assertNull(testPO.get_Value("NonExistentColumn"));
        assertNull(testPO.get_ValueOfColumn(-1));
        assertNull(testPO.get_ValueOld(-1));
        assertNull(testPO.get_ValueOld(Integer.MAX_VALUE));
        assertEquals("", testPO.get_ValueAsString("NonExistentColumn"));
        assertEquals(0, testPO.get_ValueAsInt(testPO.get_ColumnIndex(MTest.COLUMNNAME_Name)));
        testPO.set_ValueOfColumn(MTest.COLUMNNAME_Name, "123");
        assertEquals(123, testPO.get_ValueAsInt(testPO.get_ColumnIndex(MTest.COLUMNNAME_Name)));
        assertThrows(AdempiereUserError.class, () -> testPO.set_Value("NonExistentColumn", "1"));
        
        // Test auto convert of string to _ID
        testPO.set_Value(MTest.COLUMNNAME_C_Currency_ID, Integer.toString(DictionaryIDs.C_Currency.JPY.id));
        assertEquals(DictionaryIDs.C_Currency.JPY.id, testPO.getC_Currency_ID());
        
        // Test set virtual column value
        assertFalse(testPO.set_Value(MTest.COLUMNNAME_TestVirtualQty, BigDecimal.TEN));
        
        // Test set mandatory column to null
        assertFalse(testPO.set_Value(MTest.COLUMNNAME_Name, null));
        
        // Test auto convert of string to integer
        assertTrue(testPO.set_Value(MTest.COLUMNNAME_T_Integer, "456"));
        assertFalse(testPO.set_Value(MTest.COLUMNNAME_T_Integer, "456a"));
        
        // Test Validate (Min/Max)
        // C_BP_Group | CreditWatchPercent | 0 | 100
        MBPGroup bpGroup = new MBPGroup(Env.getCtx(), DictionaryIDs.C_BP_Group.STANDARD_CUSTOMERS.id, getTrxName());
        assertTrue(bpGroup.set_Value(MBPGroup.COLUMNNAME_CreditWatchPercent, new BigDecimal("50")));
        assertFalse(bpGroup.set_Value(MBPGroup.COLUMNNAME_CreditWatchPercent, new BigDecimal("-1")));
        assertFalse(bpGroup.set_Value(MBPGroup.COLUMNNAME_CreditWatchPercent, new BigDecimal("500")));
        
        // Test DisplayType.List validation
        MBPartner bp = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id, getTrxName());
        assertFalse(bp.set_Value(MBPartner.COLUMNNAME_InvoiceRule, "NonExistentValue"));
        
        // Test updateable validation
        assertFalse(bp.set_Value(MBPartner.COLUMNNAME_AD_Client_ID, 1000000));
        
        // Test convert bigdecimal to integer
        assertTrue(testPO.set_Value(MTest.COLUMNNAME_T_Integer, new BigDecimal("50")));
        // Test convert Y/N to boolean
        assertTrue(testPO.set_Value(MTest.COLUMNNAME_IsActive, "N"));
        assertFalse(testPO.isActive());
        assertTrue(testPO.set_Value(MTest.COLUMNNAME_IsActive, "Y"));
        assertTrue(testPO.isActive());
    }
    
    @Test
    void testGetValueDifference() {
    	MTest testPO = new MTest(Env.getCtx(), 0, getTrxName());
    	
    	// --- unsupported type ---
    	int nameIndex = testPO.get_ColumnIndex(MTest.COLUMNNAME_Name);
    	testPO.set_Value(nameIndex, "old");
    	testPO.saveEx();
    	testPO.set_Value(nameIndex, "new");
    	Object diff = testPO.get_ValueDifference(nameIndex);
    	assertNull(diff);
    	
    	
    	// --- BigDecimal ---
    	int amtIndex = testPO.get_ColumnIndex(MTest.COLUMNNAME_T_Amount);
    	testPO.set_Value(amtIndex, new BigDecimal("10.0"));
    	testPO.saveEx();
    	testPO.set_Value(amtIndex, new BigDecimal("12.5"));
    	diff = testPO.get_ValueDifference(amtIndex);
    	assertTrue(diff instanceof BigDecimal);
    	assertEquals(new BigDecimal("2.5"), diff);
    	diff = testPO.get_ValueDifference(MTest.COLUMNNAME_T_Amount);
    	assertTrue(diff instanceof BigDecimal);
    	assertEquals(new BigDecimal("2.5"), diff);
    	
    	// --- Integer ---
    	int integerIndex = testPO.get_ColumnIndex(MTest.COLUMNNAME_T_Integer);
    	testPO.set_Value(integerIndex, 10);
    	testPO.saveEx();
    	testPO.set_Value(integerIndex, 15);
    	diff = testPO.get_ValueDifference(integerIndex);
    	assertTrue(diff instanceof Integer);
    	assertEquals(Integer.valueOf("5"), diff);
    	
    	// --- Timestamp ---
    	int dateIndex = testPO.get_ColumnIndex(MTest.COLUMNNAME_T_DateTime);
    	long now = System.currentTimeMillis();
    	java.sql.Timestamp date1 = new java.sql.Timestamp(now);
    	java.sql.Timestamp date2 = new java.sql.Timestamp(now + 10000);
    	testPO.set_Value(dateIndex, date1);
    	testPO.saveEx();
    	testPO.set_Value(dateIndex, date2);
    	diff = testPO.get_ValueDifference(dateIndex);
    	assertTrue(diff instanceof Long);
    	assertEquals(10000L, diff);
    	
    	// --- No change ---
    	testPO.set_Value(integerIndex, 15);
    	testPO.saveEx();
    	testPO.set_Value(integerIndex, 15);
    	diff = testPO.get_ValueDifference(integerIndex);
    	assertEquals(0, diff);
    	
    	// --- null old value ---
    	testPO.set_Value(integerIndex, null);
    	testPO.saveEx();
    	testPO.set_Value(integerIndex, 15);
    	diff = testPO.get_ValueDifference(integerIndex);
    	assertEquals(15, diff);
    	    	
    	// --- null new value ---
    	testPO.set_Value(integerIndex, 15);
    	testPO.saveEx();
    	testPO.set_Value(integerIndex, null);
    	diff = testPO.get_ValueDifference(integerIndex);
    	assertNull(diff);
    	testPO.set_Value(integerIndex, 15);
    	testPO.saveEx();
    	
    	// --- invalid index ---
    	diff = testPO.get_ValueDifference(-1);
    	assertNull(diff);
    	diff = testPO.get_ValueDifference(9999);
    	assertNull(diff);
    	
    	// --- invalid column name ---
    	diff = testPO.get_ValueDifference("NoSuchColumn");
    	assertNull(diff);
    }
        @Test
    void testGet_ValueOld() {
    	
    	//Valid column Name
    	MTest testPO = new MTest(Env.getCtx(), 0, getTrxName());
        testPO.setName("InitialName");
        testPO.setHelp(null);

	    // For new record, old value should be null before save
	    assertNull(testPO.get_ValueOld(MTest.COLUMNNAME_Name));
        
	    // Verify old value is set after save
        testPO.saveEx();
        assertEquals("InitialName", testPO.get_ValueOld(MTest.COLUMNNAME_Name));
        
        // Change the value
        testPO.setName("NewName");
        
        // Old value should still be the initial one
        assertEquals("InitialName", testPO.get_ValueOld(MTest.COLUMNNAME_Name));
        assertEquals("NewName", testPO.get_Value(MTest.COLUMNNAME_Name));
        
        // Old value for null field should be null
        assertNull(testPO.get_ValueOld(MTest.COLUMNNAME_Help));
        testPO.setHelp("NewHelp");
        assertNull(testPO.get_ValueOld(MTest.COLUMNNAME_Help));
        
        testPO.setName("Name2");
        // Old value should still be "InitialName" (from last save)
        assertEquals("InitialName", testPO.get_ValueOld(MTest.COLUMNNAME_Name));
        assertEquals("Name2", testPO.get_Value(MTest.COLUMNNAME_Name));
        assertEquals(0, testPO.get_ValueOldAsInt(MTest.COLUMNNAME_Name));

        // Test with non-existent column
        Object result = testPO.get_ValueOld("NonExistentColumn");
        assertNull(result);
        result = testPO.get_ValueOld(-1);
        assertNull(result);

		// Finally, delete the testPO
		testPO.delete(true, getTrxName());
    }
    
    @Test
    void testColumnExists() {
    	MTest testPO = new MTest(Env.getCtx(), 0, getTrxName());
        assertTrue(testPO.columnExists("Name"));
        assertFalse(testPO.columnExists("NonExistentColumn"));
    }

    @Test
    void testColumnExistsWithException() {
    	MTest testPO = new MTest(Env.getCtx(), 0, getTrxName());
        assertThrows(AdempiereException.class, () -> 
            testPO.columnExists("NonExistentColumn", true)
        );
    }
    
    private static final class NullPOInfoPO extends PO {
		private static final long serialVersionUID = 1L;

		public NullPOInfoPO(Properties ctx, int ID, String trxName, ResultSet rs, String... virtualColumns) {
			super(ctx, ID, trxName, rs, virtualColumns);
		}

		public NullPOInfoPO(Properties ctx, int ID, String trxName, String... virtualColumns) {
			super(ctx, ID, trxName, virtualColumns);
		}

		public NullPOInfoPO(Properties ctx, int ID, String trxName) {
			super(ctx, ID, trxName);
		}

		public NullPOInfoPO(Properties ctx, PO source, int AD_Client_ID, int AD_Org_ID) {
			super(ctx, source, AD_Client_ID, AD_Org_ID);
		}

		public NullPOInfoPO(Properties ctx, ResultSet rs, String trxName) {
			super(ctx, rs, trxName);
		}

		public NullPOInfoPO(Properties ctx, String UUID, String trxName, ResultSet rs, String... virtualColumns) {
			super(ctx, UUID, trxName, rs, virtualColumns);
		}

		public NullPOInfoPO(Properties ctx, String UUID, String trxName, String... virtualColumns) {
			super(ctx, UUID, trxName, virtualColumns);
		}

		public NullPOInfoPO(Properties ctx, String UUID, String trxName) {
			super(ctx, UUID, trxName);
		}

		public NullPOInfoPO(Properties ctx) {
			super(ctx);
		}

		@Override
		protected POInfo initPO(Properties ctx) {
			return null;
		}

		@Override
		protected int get_AccessLevel() {
			return 0;
		}
    }
    
    @Test
    void testNullPOInfoPO() {
		assertThrows(IllegalArgumentException.class, () -> new NullPOInfoPO(Env.getCtx(), 0, getTrxName()));
		assertThrows(IllegalArgumentException.class, () -> new NullPOInfoPO(Env.getCtx(), "", getTrxName()));
	}
    
    private static final class BadPOInfoPO extends PO {
		private static final long serialVersionUID = 1L;

		public BadPOInfoPO(Properties ctx, int ID, String trxName, ResultSet rs, String... virtualColumns) {
			super(ctx, ID, trxName, rs, virtualColumns);
		}

		public BadPOInfoPO(Properties ctx, int ID, String trxName, String... virtualColumns) {
			super(ctx, ID, trxName, virtualColumns);
		}

		public BadPOInfoPO(Properties ctx, int ID, String trxName) {
			super(ctx, ID, trxName);
		}

		public BadPOInfoPO(Properties ctx, PO source, int AD_Client_ID, int AD_Org_ID) {
			super(ctx, source, AD_Client_ID, AD_Org_ID);
		}

		public BadPOInfoPO(Properties ctx, ResultSet rs, String trxName) {
			super(ctx, rs, trxName);
		}

		public BadPOInfoPO(Properties ctx, String UUID, String trxName, ResultSet rs, String... virtualColumns) {
			super(ctx, UUID, trxName, rs, virtualColumns);
		}

		public BadPOInfoPO(Properties ctx, String UUID, String trxName, String... virtualColumns) {
			super(ctx, UUID, trxName, virtualColumns);
		}

		public BadPOInfoPO(Properties ctx, String UUID, String trxName) {
			super(ctx, UUID, trxName);
		}

		public BadPOInfoPO(Properties ctx) {
			super(ctx);
		}

		@Override
		protected POInfo initPO(Properties ctx) {
			return POInfo.getPOInfo(ctx, -9999);
		}

		@Override
		protected int get_AccessLevel() {
			return 0;
		}
    }

    @Test
    void testBadPOInfoPO() {
		assertThrows(IllegalArgumentException.class, () -> new BadPOInfoPO(Env.getCtx(), 0, getTrxName()));
		assertThrows(IllegalArgumentException.class, () -> new BadPOInfoPO(Env.getCtx(), "", getTrxName()));
	}
    
    @Test
    void testGet_DisplayValue() {
    	MBPartner bp = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id, getTrxName());
    	assertEquals(bp.getName(), bp.get_DisplayValue(MBPartner.COLUMNNAME_Name, true));
    	assertEquals("true", bp.get_DisplayValue(MBPartner.COLUMNNAME_IsActive, true));
    	String oldName2 = "name2";
    	bp.setName2(oldName2);
    	bp.saveEx();
    	bp.setName2(null);
    	assertEquals("./.", bp.get_DisplayValue(MBPartner.COLUMNNAME_Name2, true));
    	assertEquals(oldName2, bp.get_DisplayValue(MBPartner.COLUMNNAME_Name2, false));
    	String displayValue = bp.get_DisplayValue(MBPartner.COLUMNNAME_C_BP_Group_ID, true);
    	assertEquals(MBPGroup.get(bp.getC_BP_Group_ID()).getName(), displayValue);
    }
    
    @Test
    void testCopyValues() {
    	// same class
    	MTest source = new MTest(Env.getCtx(), 0, getTrxName());
    	source.setName("Source");
    	source.setT_Integer(1);
    	source.saveEx();
    	MTest target = new MTest(Env.getCtx(), 0, getTrxName());
    	target.setName("Target");
    	target.setT_Integer(2);
    	PO.copyValues(source, target);
    	assertEquals(source.getT_Integer(), target.getT_Integer());
    	
    	//different class
    	MTestUU target2 = new MTestUU(Env.getCtx(), PO.UUID_NEW_RECORD, getTrxName());
    	target2.setName("Target2");
    	target2.setDescription("testuu");
    	source.setDescription("source desc");
    	source.saveEx();
    	PO.copyValues(source, target2);	
    	assertEquals(source.getDescription(), target2.getDescription());
    }
    
    @Test
    void testLoadPOByUU() {
    	MTest test = new MTest(Env.getCtx(), 0, getTrxName());
    	test.setName("TestLoadByUU");
    	test.saveEx();
    	
    	MTable table = MTable.get(Env.getCtx(), MTest.Table_Name);
    	PO po = table.getPOByUU(test.getTest_UU(), getTrxName());
    	assertNotNull(po);
    	assertTrue(po instanceof MTest);
    	assertEquals(test.get_ID(), po.get_ID());
    	
    	//test non existing UU
    	po = table.getPOByUU(test.getTest_UU().replaceFirst(".?", "Z"), getTrxName());
    	assertNotNull(po);
    	assertTrue(po instanceof MTest);
    	assertEquals(0, po.get_ID());
    	assertTrue(po.is_new());
    	rollback();
    	
    	MTestUU testuu = new MTestUU(Env.getCtx(), PO.UUID_NEW_RECORD, getTrxName());
    	testuu.setName("TestUU");
    	testuu.saveEx();
    	table = MTable.get(Env.getCtx(), MTestUU.Table_Name);
    	po = table.getPOByUU(testuu.get_UUID(), getTrxName());
    	assertNotNull(po);
    	assertTrue(po instanceof MTestUU);
    	assertEquals(testuu.get_UUID(), po.get_UUID());    	    	
    }
    
    @Test
    void testImmutable() {
    	MBPartner bp = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id, getTrxName());
    	bp.markImmutable();
		assertTrue(bp.is_Immutable());
		assertThrows(IllegalStateException.class, () -> { bp.setName("New Name"); });
    }
    
    @Test
    void testEquals() {
    	MTest test1 = new MTest(Env.getCtx(), 0, getTrxName());
		test1.setName("TestEquals");
		test1.saveEx();
		
		MTest test2 = new MTest(Env.getCtx(), test1.get_ID(), getTrxName());
		
		assertTrue(test1.equals(test2));
		
		MTest test3 = new MTest(Env.getCtx(), 0, getTrxName());
		test3.setName("TestEquals");
		test3.saveEx();
		
		assertFalse(test1.equals(test3));
		assertFalse(test1.equals(null));
		assertFalse(test1.equals(Boolean.TRUE));
		
		MTest test4 = new MTest(Env.getCtx(), 0, getTrxName());
		test4.setName("TestEquals 4");
		MTest test5 = new MTest(Env.getCtx(), 0, getTrxName());
		test5.setName("TestEquals 5");
		MTest test6 = new MTest(Env.getCtx(), 0, getTrxName());
		test6.setName(test4.getName());
		assertFalse(test4.equals(test5));
		assertFalse(test4.equals(test6));
    }
    
    @Test
    void testSetCustomColumn() {
    	MTest test = new MTest(Env.getCtx(), 0, getTrxName());
		test.setName("testSetCustomColumn");
		test.saveEx();
		
		// Test works for non custom column too
		assertTrue(test.set_CustomColumnReturningBoolean(MTest.COLUMNNAME_Description, "Description"));
		assertEquals("Description", test.getDescription());
		
		assertTrue(test.set_CustomColumnReturningBoolean("CustomNumber", BigDecimal.TEN));
		assertTrue(test.set_CustomColumnReturningBoolean("CustomBoolean", Boolean.TRUE));
		assertTrue(test.set_CustomColumnReturningBoolean("CustomTimestamp", new Timestamp(System.currentTimeMillis())));
		assertTrue(test.set_CustomColumnReturningBoolean("CustomText", "Custom Text"));
    }
    
    @Test
    void testLoadPartialPO () {
    	MTest test = new MTest(Env.getCtx(), 0, getTrxName());
		test.setName("testLoadPartialPO");
		test.setDescription("testLoadPartialPO description");
		test.setT_Integer(1);
		test.saveEx();
		
		Query query = new Query(Env.getCtx(), MTest.Table_Name, MTest.COLUMNNAME_Test_ID+"=?", getTrxName());
		MTest partial = query.selectColumns(MTest.COLUMNNAME_Name).setParameters(test.get_ID()).first();
		assertNotNull(partial);
		assertEquals(test.getName(), partial.getName());
		assertTrue(Util.isEmpty(partial.getDescription()));
		assertEquals(0, partial.getT_Integer());
		// created is always loaded
		assertEquals(test.getCreated(), partial.getCreated());
    }
    
    @Test
    void testOrgReset() {
    	//C_Calendar access level is client only
    	MTable table = MTable.get(Env.getCtx(), MCalendar.Table_Name);
    	assertEquals(MTable.ACCESSLEVEL_ClientOnly, table.getAccessLevel().trim());
    	try (MockedStatic<MClientShare> clientShareMock = Mockito.mockStatic(MClientShare.class, Mockito.CALLS_REAL_METHODS);) {
    		clientShareMock.when(() -> MClientShare.isClientLevelOnly(Mockito.eq(getAD_Client_ID()), 
    			Mockito.eq(MCalendar.Table_ID)))
				.thenReturn(true);
	    	MCalendar calendar = new MCalendar(Env.getCtx(), 0, getTrxName());
	    	calendar.setName("testOrgReset");
	    	calendar.setAD_Org_ID(DictionaryIDs.AD_Org.HQ.id);
	    	calendar.saveEx();
	    	assertEquals(0, calendar.getAD_Org_ID());
    	}
    }
}
