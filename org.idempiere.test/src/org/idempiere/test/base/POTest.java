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
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Properties;

import org.adempiere.exceptions.DBException;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MMessage;
import org.compiere.model.MTest;
import org.compiere.model.POInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

/**
 * Tests for {@link org.compiere.model.PO} class.
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * @author hengsin
 */
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
			super(ctx, "Test_"+System.currentTimeMillis(), 10);
			this.set_TrxName(trxName);
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
		MTest testPO = new MTest(Env.getCtx(), getClass().getName(), 1);
		testPO.set_TrxName(getTrxName());

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
		MTest testPO = new MTest(Env.getCtx(), getClass().getName(), 1);
		testPO.set_TrxName(getTrxName());
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
		{
			MyTestPO test = new MyTestPO(Env.getCtx(), false, null);
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
		MTest testPo = new MTest(Env.getCtx(), getClass().getName(), 1);
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

}
