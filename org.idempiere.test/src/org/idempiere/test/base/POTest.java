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
import static org.junit.jupiter.api.Assertions.assertInstanceOf;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.reset;
import static org.mockito.Mockito.when;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Optional;
import java.util.Properties;

import javax.swing.tree.TreeNode;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.dbPort.Convert;
import org.compiere.model.I_AD_UserPreference;
import org.compiere.model.MAcctSchema;
import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.MBPGroup;
import org.compiere.model.MBPartner;
import org.compiere.model.MBPartnerInfo;
import org.compiere.model.MCalendar;
import org.compiere.model.MChangeLog;
import org.compiere.model.MClient;
import org.compiere.model.MClientShare;
import org.compiere.model.MColumn;
import org.compiere.model.MImage;
import org.compiere.model.MMessage;
import org.compiere.model.MOrder;
import org.compiere.model.MOrgInfo;
import org.compiere.model.MProduct;
import org.compiere.model.MProductCategory;
import org.compiere.model.MProductCategoryAcct;
import org.compiere.model.MProductionLine;
import org.compiere.model.MSession;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MTableIndex;
import org.compiere.model.MTest;
import org.compiere.model.MTestUU;
import org.compiere.model.MTree;
import org.compiere.model.MTreeNode;
import org.compiere.model.MTree_Base;
import org.compiere.model.MTree_NodeBP;
import org.compiere.model.MUOM;
import org.compiere.model.ModelValidationEngine;
import org.compiere.model.ModelValidator;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.PO_Record;
import org.compiere.model.Query;
import org.compiere.model.SystemProperties;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.CLogger;
import org.compiere.util.CacheMgt;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Ini;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

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
		bp2.set_OptimisticLockingColumns(new String[] {"Name","IsActive"});
		String[] olcs = bp2.get_OptimisticLockingColumns();
		assertEquals(2, olcs.length);
		assertEquals("Name", olcs[0]);
		assertEquals("IsActive", olcs[1]);
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
	public void testLogMigrationScript() throws IOException {
		MSession.create(Env.getCtx());
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
		
		try {
			// log migration script for update of lookup fields
			MTest testPO = new MTest(Env.getCtx(), 0, getTrxName());
			testPO.setName("testPO1");
			testPO.setT_Integer(100);
			testPO.saveEx();
			
			MTest testPO1 = new MTest(Env.getCtx(), 0, getTrxName());
			testPO1.setName("testPO2");
			testPO1.setT_Integer(100);
			testPO1.saveEx();
			
			MUOM testUOM = new MUOM(Env.getCtx(), 0, getTrxName());
			testUOM.setName("testUOM1");
			testUOM.setX12DE355("testUOM1");
			testUOM.saveEx();
			testPO1.setAD_Table_ID(MTest.Table_ID);
			testPO1.setRecord_ID(testPO.get_ID());
			testPO1.setC_UOM_ID(testUOM.get_ID());
			testPO1.setIsActive(false);
			testPO1.setT_DateTime(new Timestamp(System.currentTimeMillis()));
			testPO1.setT_Number(BigDecimal.TEN);
			testPO1.saveEx();
			
			testPO1.load(getTrxName());
			assertEquals(testPO1.getRecord_ID(), testPO.get_ID());
			
			// test change log for insert
			try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
				mocked.when(() -> MSysConfig.getValue(MSysConfig.SYSTEM_INSERT_CHANGELOG, "N", getAD_Client_ID()))
					.thenReturn("K");
				MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
				t1.saveEx();
				Query query = new Query(Env.getCtx(), MChangeLog.Table_Name, 
				MChangeLog.COLUMNNAME_AD_Table_ID + "=? AND " + MChangeLog.COLUMNNAME_Record_ID + "=?", getTrxName());
				MChangeLog changeLog = query.setParameters(MTest.Table_ID, t1.get_ID()).first();
				assertNotNull(changeLog, "No change log found for inserted record");
				assertTrue(changeLog.get_ID() > 0, "Change log ID is invalid");
			}
		} finally {	
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
		
		// test change log for insert
		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MSysConfig.getValue(MSysConfig.SYSTEM_INSERT_CHANGELOG, "N", getAD_Client_ID()))
				.thenReturn("K");
			MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
			t1.saveEx();
			Query query = new Query(Env.getCtx(), MChangeLog.Table_Name, 
				MChangeLog.COLUMNNAME_AD_Table_ID + "=? AND " + MChangeLog.COLUMNNAME_Record_ID + "=?", getTrxName());
			MChangeLog changeLog = query.setParameters(MTest.Table_ID, t1.get_ID()).first();
			assertNotNull(changeLog, "No change log found for inserted record");
			assertTrue(changeLog.get_ID() > 0, "Change log ID is invalid");
		}		
		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MSysConfig.getValue(MSysConfig.SYSTEM_INSERT_CHANGELOG, "N", getAD_Client_ID()))
				.thenReturn("N");
			MTest t2 = new MTest(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
			t2.saveEx();
			Query query = new Query(Env.getCtx(), MChangeLog.Table_Name, 
				MChangeLog.COLUMNNAME_AD_Table_ID + "=? AND " + MChangeLog.COLUMNNAME_Record_ID + "=?", getTrxName());
			MChangeLog changeLog = query.setParameters(MTest.Table_ID, t2.get_ID()).first();
			assertNull(changeLog, "Change log found for inserted record");
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
    	assertNull(po);
    	
    	// test new record UU
    	po = table.getPOByUU(PO.UUID_NEW_RECORD, getTrxName());
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
    	
    	// Test orgInfo
    	MOrgInfo orgInfo = MOrgInfo.get(getAD_Org_ID());
		assertTrue(orgInfo.getAD_Org_ID() > 0, "MOrgInfo must have a valid AD_Org_ID");
		String orgInfoUU = orgInfo.getAD_OrgInfo_UU();
		assertTrue(!Util.isEmpty(orgInfoUU, true), "MOrgInfo must have a valid AD_OrgInfo_UU");
		
		MTable orgInfoTable = MTable.get(Env.getCtx(), MOrgInfo.Table_Name);
		po = orgInfoTable.getPOByUU(orgInfoUU, getTrxName());
		assertNotNull(po, "getPOByUU should return a PO instance for valid UUID");
		assertEquals(orgInfo.getAD_Org_ID(), po.get_ID(), "Returned PO must have expected AD_Org_ID");
		assertEquals(orgInfoUU, po.get_ValueAsString("AD_OrgInfo_UU"), "Returned PO must have expected UUID");
		assertTrue(po instanceof MOrgInfo, "Returned PO must be an instance of MOrgInfo");
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
    
    @Test
    void testReadonlySession() {
    	MTest test = new MTest(Env.getCtx(), 0, getTrxName());
    	test.setName("testReadonlySession");
    	assertFalse(Env.isReadOnlySession());
    	assertTrue(test.save());
    	Env.setContext(Env.getCtx(), "IsReadOnlySession", "Y");
    	assertTrue(Env.isReadOnlySession());
    	test.setT_Integer(1);
    	assertFalse(test.save());
    	test = new MTest(Env.getCtx(), 103, getTrxName());
    	assertFalse(test.delete(false));
    }
    
    @Test
    void testGet_Xml() {
    	StringBuffer xml = new StringBuffer();
    	MTest test = new MTest(Env.getCtx(), 0, getTrxName());    	
    	test.setName("testGet_XmlString");
    	test.saveEx();
    	test.get_xmlString(xml);
    	assertTrue(xml.length() > 0);
    	try {
			DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			Document document = builder.parse(new ByteArrayInputStream(xml.toString().getBytes()));
			assertNotNull(document);
			NodeList nodes = document.getElementsByTagName("Name");
			assertNotNull(nodes);
			assertEquals(1, nodes.getLength());
			Node node = nodes.item(0);
			assertNotNull(node);
			assertEquals(test.getName(), node.getTextContent());
		} catch (ParserConfigurationException | SAXException | IOException e) {
			fail(e);
		}
    	
    	Document document = test.get_xmlDocument(true);
    	assertNotNull(document);
		NodeList nodes = document.getElementsByTagName("Name");
		assertNotNull(nodes);
		assertEquals(1, nodes.getLength());
		Node node = nodes.item(0);
		assertNotNull(node);
		assertEquals(test.getName(), node.getTextContent());
    }
    
    @Test
    void testGetFindParameter() {
    	MBPartner bp = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id, getTrxName());
    	MBPartnerInfo[] bpInfos = MBPartnerInfo.find(Env.getCtx(), null, bp.getName().toLowerCase(), "", null, "%", null);
    	assertTrue(bpInfos.length > 0);
    	Optional<MBPartnerInfo> optional = Arrays.stream(bpInfos).filter(e -> e.getName().equals(bp.getName())).findFirst();
    	assertTrue(optional.isPresent());		
    }
    
    @Test
    void testLock() {
    	MBPGroup bpGroup = new MBPGroup(Env.getCtx(), DictionaryIDs.C_BP_Group.STANDARD_CUSTOMERS.id, getTrxName());
    	//lock should fail since bpGroup has no processing column
    	assertFalse(bpGroup.lock());
    	MTest test = null;
    	try {
    		test = new MTest(Env.getCtx(), 0, null);
    		test.setName("testLock");
    		test.setProcessing(false);
    		test.saveEx();
    		assertTrue(test.lock());
    		assertFalse(test.lock());
    		assertTrue(test.isProcessing());
    		assertTrue(test.unlock(null));
    		assertFalse(test.isProcessing());
    	} finally {
    		rollback();
			if (test != null) {
				test.deleteEx(true);
			}
		}
    }
    
    @Test
    void testPdfAttachment() throws IOException {
    	MTest test = new MTest(Env.getCtx(), 0, getTrxName());
		test.setName("testPdfAttachment");
		test.saveEx();
		
		//test pdf attachment
		MAttachment attachment = new MAttachment(Env.getCtx(), test.get_Table_ID(), test.get_ID(), test.get_UUID(), getTrxName());
		attachment.setTextMsg("test pdf");
		
		File pdfFile = File.createTempFile("test", ".pdf");
		pdfFile.deleteOnExit();
		try (FileWriter writer = new FileWriter(pdfFile)) {
			writer.write("dummy pdf content");
		}
		
		try (attachment) {
			MAttachmentEntry entry1 = new MAttachmentEntry(pdfFile.getName(), "dummy pdf content".getBytes(), 0);
			attachment.addEntry(entry1);
			attachment.saveEx();		
			assertTrue(test.isPdfAttachment());
			byte[] attachmentBytes = test.getPdfAttachment();
			assertNotNull(attachmentBytes);
			assertTrue(attachmentBytes.length > 0);
		}		
		
		// test non-pdf attachment
		File txtFile = File.createTempFile("test", ".txt");
		txtFile.deleteOnExit();
		try (FileWriter writer = new FileWriter(txtFile)) {
			writer.write("dummy txt content");
		}
		
		MTest test1 = new MTest(Env.getCtx(), 0, getTrxName());
		test1.setName("testNonPdfAttachment1");
		test1.saveEx();
		MAttachment attachment1 = new MAttachment(Env.getCtx(), test1.get_Table_ID(), test1.get_ID(), test1.get_UUID(), getTrxName());
		attachment1.setTextMsg("test non pdf");
		try (attachment1) {
			MAttachmentEntry entry2 = new MAttachmentEntry(txtFile.getName(), "dummy txt content".getBytes(), 0);
			attachment1.addEntry(entry2);
			attachment1.saveEx();
		}
		assertFalse(test1.isPdfAttachment());
		assertNull(test1.getPdfAttachment());		
    }
    
    @Test
    void testValidateUniqueIndex() {
    	//ad_tableindex: c_bpartner_value | 200361
    	MTableIndex tableIndex = new MTableIndex(Env.getCtx(), 200361, null);
    	int currentMessageId = tableIndex.getAD_Message_ID();
    	int expectedMessageId = currentMessageId;
    	try {
	    	if (currentMessageId == 0) {
	    		//SaveErrorNotUnique | 502
	    		tableIndex.setAD_Message_ID(502);
	    		tableIndex.saveCrossTenantSafeEx();
	    		expectedMessageId = 502;
	    	}
	    	
	    	MMessage expectedMessage = MMessage.get(Env.getCtx(), expectedMessageId);
	    	String expectedMsgText = Msg.getMsg(Env.getCtx(), expectedMessage.getValue());
	    	MBPartner bp = MBPartner.get(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id);
	    	MBPartner bp1 = new MBPartner(Env.getCtx(), 0, getTrxName());
	    	bp1.setValue(bp.getValue());
	    	bp1.setName("Test ValidateUniqueIndex");
	    	assertFalse(bp1.save(), "Save should have failed due to unique index violation");
	    	ValueNamePair ppE = CLogger.retrieveError();
	    	assertNotNull(ppE, "No error message retrieved");
	    	assertTrue(ppE.getName().startsWith(expectedMsgText), "Unexpected error message text");
    	} finally {
    		if (expectedMessageId != currentMessageId) {
				tableIndex.setAD_Message_ID(currentMessageId);
				tableIndex.saveCrossTenantSafeEx();
			}
    	}
    }
    
    @Test
    void testBinaryData() throws IOException {
    	byte[] imageData = null;
        try (InputStream is = getClass().getResourceAsStream("/org/idempiere/test/model/idempiere_logo.png")) {
        	imageData = is.readAllBytes();
        }
        assertTrue(imageData != null && imageData.length > 0, "Image data should not be null or empty");
        
        MImage image = new MImage(Env.getCtx(), 0, getTrxName());
        image.setName("idempiere_logo.png");
        image.setBinaryData(imageData);
		image.saveEx();
        
		image = new MImage(Env.getCtx(), image.get_ID(), getTrxName());
		byte[] binaryData = image.getBinaryData();
		assertTrue(binaryData != null && binaryData.length > 0, "Binary data should not be null or empty");
		assertEquals(imageData.length, binaryData.length, "Binary data does not match the original data");
    }
    
    @Test
    void testTreeDrivenByValue() {
    	// 103 | GardenWorld Bus Partner Tree
    	int GARDENWORLD_BP_TREE_ID = 103;
    	MTree_Base tree = new MTree_Base(Env.getCtx(), GARDENWORLD_BP_TREE_ID, getTrxName());
    	tree.setIsTreeDrivenByValue(true);
    	tree.setIsValueDisplayed(true);
    	tree.saveEx();
    	    	
    	MBPartner parent = new MBPartner(Env.getCtx(), 0, getTrxName());
    	parent.setName("Parent BPartner");
    	parent.setIsSummary(true);
    	parent.saveEx();
    	
    	MBPartner child1 = new MBPartner(Env.getCtx(), 0, getTrxName());
    	child1.setName("Child BPartner 1");
    	child1.setIsSummary(false);
    	child1.saveEx();
    	
    	MBPartner child2 = new MBPartner(Env.getCtx(), 0, getTrxName());
    	child2.setName("Child BPartner 2");
    	child2.setIsSummary(false);
    	child2.saveEx();
    	
    	// create tree nodes
    	MTree_NodeBP parentNode = new Query(Env.getCtx(), MTree_NodeBP.Table_Name, 
			MTree_NodeBP.COLUMNNAME_AD_Tree_ID + "=? AND " + MTree_NodeBP.COLUMNNAME_Node_ID + "=?", getTrxName())
			.setParameters(GARDENWORLD_BP_TREE_ID, parent.get_ID())
			.first();
    	MTree_NodeBP child1Node = new Query(Env.getCtx(), MTree_NodeBP.Table_Name, 
    			MTree_NodeBP.COLUMNNAME_AD_Tree_ID + "=? AND " + MTree_NodeBP.COLUMNNAME_Node_ID + "=?", getTrxName())
    			.setParameters(GARDENWORLD_BP_TREE_ID, child1.get_ID())
    			.first();
    	MTree_NodeBP child2Node = new Query(Env.getCtx(), MTree_NodeBP.Table_Name, 
    			MTree_NodeBP.COLUMNNAME_AD_Tree_ID + "=? AND " + MTree_NodeBP.COLUMNNAME_Node_ID + "=?", getTrxName())
    			.setParameters(GARDENWORLD_BP_TREE_ID, child2.get_ID())
    			.first();
    	child1Node.setParent_ID(parentNode.getNode_ID());
    	child1Node.setSeqNo(10);
    	child1Node.saveEx();
    	child2Node.setParent_ID(parentNode.getNode_ID());
    	child2Node.setSeqNo(20);
    	child2Node.saveEx();
    	
    	// trigger update of sequence by changing value
    	child2.setValue(parent.getValue()+"_01");
    	child2.saveEx();
    	child1.setValue(parent.getValue()+"_02");
    	child1.saveEx();
    	
    	MTree mt = new MTree(Env.getCtx(), GARDENWORLD_BP_TREE_ID, false, false, getTrxName(), null, 0);
    	MTreeNode root = mt.getRoot();
    	assertNotNull(root, "Tree root node is null");
    	MTreeNode pNode = root.findNode(parentNode.getNode_ID());
    	assertNotNull(pNode, "Parent node not found in tree");
    	
    	int childCount = pNode.getChildCount();
    	assertEquals(2, childCount, "Tree child count does not match");
    	for(int i = 0; i < childCount; i++) {
			TreeNode childNode = pNode.getChildAt(i);
			assertTrue(childNode instanceof MTreeNode, "Tree child node is not MTreeNode");
			MTreeNode childNodeCast = (MTreeNode) childNode;
			if (i == 0) {
				//seq no 10
				assertEquals(child2.getValue(), childNodeCast.getName().substring(0, child2.getValue().length()), "Tree child node name does not match");
			} else if (i == 1) {
				//seq no 20
				assertEquals(child1.getValue(), childNodeCast.getName().substring(0, child1.getValue().length()), "Tree child node name does not match");
			}
		}
    	
    	// test toInsertSQL for tree node
    	String sql = child2Node.toInsertSQL(DB.getDatabase().getName());
    	assertNotNull(sql, "toInsertSQL returned null");
    	child2Node.deleteEx(true);
    	DB.executeUpdateEx(sql, getTrxName());
    }
    
    private static final class TestHashMapPO extends MTest {
        private static final long serialVersionUID = 1L;
        public TestHashMapPO(Properties ctx, int ID, String trxName) { super(ctx, ID, trxName); }
        public boolean loadFromHashMap(HashMap<String,String> map) { return super.load(map); }
        public HashMap<String,String> exportHashMap() { return super.get_HashMap(); }
    }

    @Test
    void testLoadAndGetHashMap() {
        MTest original = new TestHashMapPO(Env.getCtx(), 0, getTrxName());
        original.setName("HashMapTest");
        original.setDescription("HashMap Description");
        original.setT_Integer(42);
        original.saveEx();
        assertTrue(original.get_ID() > 0);
        // export to hash map
        TestHashMapPO accessor = (TestHashMapPO) original; // safe cast
        HashMap<String,String> map = accessor.exportHashMap();
        assertNotNull(map);
        assertEquals(original.getName(), map.get(MTest.COLUMNNAME_Name));
        assertEquals(original.getDescription(), map.get(MTest.COLUMNNAME_Description));
        assertEquals(Integer.toString(original.getT_Integer()), map.get(MTest.COLUMNNAME_T_Integer));
        assertEquals("Y", map.get(MTest.COLUMNNAME_IsActive));
        // virtual column should not be present
        assertFalse(map.containsKey(MTest.COLUMNNAME_TestVirtualQty));
        // load into a new instance from hash map
        TestHashMapPO loaded = new TestHashMapPO(Env.getCtx(), 0, getTrxName());
        boolean ok = loaded.loadFromHashMap(map);
        assertTrue(ok);
        // after load, key column newValues reset so object considered new
        assertTrue(loaded.is_new());
        assertEquals(original.getName(), loaded.getName());
        assertEquals(original.getDescription(), loaded.getDescription());
        assertEquals(original.getT_Integer(), loaded.getT_Integer());
        assertTrue(loaded.isActive());
        // ensure virtual column still not loaded
        assertNull(loaded.get_Value(MTest.COLUMNNAME_TestVirtualQty));
    }
    
    // New private test PO that throws in beforeSave to trigger rollback to savepoint
	private static final class ThrowBeforeSavePO extends MTest {
		private static final long serialVersionUID = 1L;
		public ThrowBeforeSavePO(Properties ctx, String name, int someInt, String trxName) {
			super(ctx, name, someInt, trxName);
		}
		public ThrowBeforeSavePO(Properties ctx, int id, String trxName) {
			super(ctx, id, trxName);
		}
		@Override
		protected boolean beforeSave(boolean newRecord) {
			throw new RuntimeException("Simulated beforeSave failure");
		}
	}

	@Test
	void testBeforeSaveExRollbackWithSavepoint()
	{
		// Ensure we have a transaction name (so save() will create a savepoint)
		assertNotNull(getTrxName(), "TrxName should not be null");

		// Create and save a normal MTest within the transaction
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.saveEx();
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should exist after save");

		// Create a PO that fails in beforeSave - this should rollback only to the savepoint
		ThrowBeforeSavePO t2 = new ThrowBeforeSavePO(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
		try {
			t2.saveEx();
			fail("saveEx should have thrown due to beforeSave failure");
		} catch (Exception e) {
			// expected
		}
		// t2 may have been assigned an ID but should not be persisted
		if (t2.get_ID() > 0)
			assertFalse(MyTestPO.exists(t2.get_ID(), getTrxName()), "t2 should NOT exist after failed save");
		// test without trx
		t2 = new ThrowBeforeSavePO(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, null);
		try {
			t2.saveEx();
			fail("saveEx should have thrown due to beforeSave failure");
		} catch (Exception e) {
			// expected
		}
		
		// Now create another normal MTest and save - this must succeed even after the failed save
		MTest t3 = new MTest(Env.getCtx(), "t3_"+System.currentTimeMillis(), 10, getTrxName());
		t3.saveEx();
		assertTrue(MyTestPO.exists(t3.get_ID(), getTrxName()), "t3 should exist after save");

		// Verify t1 still exists (was not rolled back)
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should still exist after t2 failure");
	}
	
	// New private test PO that return false in beforeSave to trigger rollback to savepoint
	private static final class BeforeSaveFalsePO extends MTest {
		private static final long serialVersionUID = 1L;
		public BeforeSaveFalsePO(Properties ctx, String name, int someInt, String trxName) {
			super(ctx, name, someInt, trxName);
		}
		public BeforeSaveFalsePO(Properties ctx, int id, String trxName) {
			super(ctx, id, trxName);
		}
		@Override
		protected boolean beforeSave(boolean newRecord) {
			return false;
		}
	}

	@Test
	void testBeforeSaveFalseRollbackWithSavepoint()
	{
		// Ensure we have a transaction name (so save() will create a savepoint)
		assertNotNull(getTrxName(), "TrxName should not be null");

		// Create and save a normal MTest within the transaction
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.saveEx();
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should exist after save");

		// Create a PO that fails in beforeSave - this should rollback only to the savepoint
		BeforeSaveFalsePO t2 = new BeforeSaveFalsePO(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
		try {
			t2.saveEx();
			fail("saveEx should have thrown due to beforeSave failure");
		} catch (Exception e) {
			// expected
		}
		// t2 may have been assigned an ID but should not be persisted
		if (t2.get_ID() > 0)
			assertFalse(MyTestPO.exists(t2.get_ID(), getTrxName()), "t2 should NOT exist after failed save");
		// test without trx
		t2 = new BeforeSaveFalsePO(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, null);
		try {
			t2.saveEx();
			fail("saveEx should have thrown due to beforeSave failure");
		} catch (Exception e) {
			// expected
		}

		// Now create another normal MTest and save - this must succeed even after the failed save
		MTest t3 = new MTest(Env.getCtx(), "t3_"+System.currentTimeMillis(), 10, getTrxName());
		t3.saveEx();
		assertTrue(MyTestPO.exists(t3.get_ID(), getTrxName()), "t3 should exist after save");

		// Verify t1 still exists (was not rolled back)
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should still exist after t2 failure");
	}

	@Test
	void testBeforeSaveValidatorRollbackWithSavepoint()
	{
		// Ensure we have a transaction name (so save() will create a savepoint)
		assertNotNull(getTrxName(), "TrxName should not be null");

		// Create and save a normal MTest within the transaction
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.saveEx();
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should exist after save");

		// Create a PO that fails in beforeSave - this should rollback only to the savepoint
		MTest t2 = new MTest(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
		//simulate beforeSafe validator failure by mocking ModelValidationEngine
		ModelValidationEngine mockedEngine = Mockito.mock(ModelValidationEngine.class);
		when(mockedEngine.fireModelChange(any(MTest.class), eq(ModelValidator.TYPE_NEW))).thenReturn("TYPE_NEW validation failed");
		when(mockedEngine.fireModelChange(any(MTest.class), eq(ModelValidator.TYPE_CHANGE))).thenReturn("TYPE_CHANGE validation failed");
		try (MockedStatic<ModelValidationEngine> mockedStatic = Mockito.mockStatic(ModelValidationEngine.class, Mockito.CALLS_REAL_METHODS)) {
			mockedStatic.when(() -> ModelValidationEngine.get()).thenReturn(mockedEngine);
			try {
				t2.saveEx();
				fail("saveEx should have thrown due to beforeSave failure");
			} catch (Exception e) {
				// expected
			}
			// t2 may have been assigned an ID but should not be persisted
			if (t2.get_ID() > 0)
				assertFalse(MyTestPO.exists(t2.get_ID(), getTrxName()), "t2 should NOT exist after failed save");
			// test without trx
			t2 = new MTest(Env.getCtx(), 200003, null);
			String name = t2.getName();
			t2.setName("t2_"+System.currentTimeMillis());
			try {
				t2.saveEx();
				fail("saveEx should have thrown due to beforeSave failure");
			} catch (Exception e) {
				// expected
			}
			t2 = new MTest(Env.getCtx(), 200003, null);
			assertEquals(name, t2.getName(), "Name should not have changed after failed save");
		} finally {
			reset(mockedEngine);
		}		
				
		// Now create another normal MTest and save - this must succeed even after the failed save
		MTest t3 = new MTest(Env.getCtx(), "t3_"+System.currentTimeMillis(), 10, getTrxName());
		t3.saveEx();
		assertTrue(MyTestPO.exists(t3.get_ID(), getTrxName()), "t3 should exist after save");

		// Verify t1 still exists (was not rolled back)
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should still exist after t2 failure");
	}
	
	// New private test PO that throws in afterSave to trigger rollback to savepoint
	private static final class ThrowAfterSavePO extends MTest {
		private static final long serialVersionUID = 1L;
		public ThrowAfterSavePO(Properties ctx, String name, int someInt, String trxName) {
			super(ctx, name, someInt, trxName);
		}
		public ThrowAfterSavePO(Properties ctx, int id, String trxName) {
			super(ctx, id, trxName);
		}
		@Override
		protected boolean afterSave(boolean newRecord, boolean success) {
			throw new RuntimeException("Simulated afterSave failure");
		}
	}

	@Test
	void testAfterSaveExRollbackWithSavepoint()
	{
		// Ensure we have a transaction name (so save() will create a savepoint)
		assertNotNull(getTrxName(), "TrxName should not be null");

		// Create and save a normal MTest within the transaction
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.saveEx();
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should exist after save");

		// Create a PO that fails in afterSave - this should rollback only to the savepoint
		ThrowAfterSavePO t2 = new ThrowAfterSavePO(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
		try {
			t2.saveEx();
			fail("saveEx should have thrown due to afterSave failure");
		} catch (Exception e) {
			// expected
		}
		// t2 may have been assigned an ID but should not be persisted
		if (t2.get_ID() > 0)
			assertFalse(MyTestPO.exists(t2.get_ID(), getTrxName()), "t2 should NOT exist after failed save");
		// test without trx
		t2 = new ThrowAfterSavePO(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, null);
		try {
			t2.saveEx();
			fail("saveEx should have thrown due to afterSave failure");
		} catch (Exception e) {
			// expected
		}

		// Now create another normal MTest and save - this must succeed even after the failed save
		MTest t3 = new MTest(Env.getCtx(), "t3_"+System.currentTimeMillis(), 10, getTrxName());
		t3.saveEx();
		assertTrue(MyTestPO.exists(t3.get_ID(), getTrxName()), "t3 should exist after save");

		// Verify t1 still exists (was not rolled back)
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should still exist after t2 failure");
	}
	
	// New private test PO that throws in beforeDelete to trigger rollback to savepoint
	private static final class ThrowBeforeDeletePO extends MTest {
		private static final long serialVersionUID = 1L;
		public ThrowBeforeDeletePO(Properties ctx, String name, int someInt, String trxName) {
			super(ctx, name, someInt, trxName);
		}
		public ThrowBeforeDeletePO(Properties ctx, int id, String trxName) {
			super(ctx, id, trxName);
		}
		@Override
		protected boolean beforeDelete() {
			throw new RuntimeException("Simulated beforeDelete failure");
		}
	}

	@Test
	void testBeforeDeleteExRollbackWithSavepoint()
	{
		// Ensure we have a transaction name (so save() will create a savepoint)
		assertNotNull(getTrxName(), "TrxName should not be null");

		// Create and save a normal MTest within the transaction
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.saveEx();
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should exist after save");

		// Create a PO that fails in beforeDelete - this should rollback only to the savepoint
		ThrowBeforeDeletePO t2 = new ThrowBeforeDeletePO(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
		t2.saveEx();
		try {
			t2.deleteEx(false);
			fail("deleteEx should have thrown due to beforeDelete failure");
		} catch (Exception e) {
			// expected
		}
		// t2 should still exist
		assertTrue(MyTestPO.exists(t2.get_ID(), getTrxName()), "t2 should exist after failed delete");
		// test without trx
		t2 = new ThrowBeforeDeletePO(Env.getCtx(), 200003, null);
		try {
			t2.deleteEx(false);
			fail("deleteEx should have thrown due to beforeDelete failure");
		} catch (Exception e) {
			// expected
		}
		assertEquals(200003, new MTest(Env.getCtx(), 200003, null).get_ID());

		// Now create another normal MTest and save - this must succeed even after the failed delete
		MTest t3 = new MTest(Env.getCtx(), "t3_"+System.currentTimeMillis(), 10, getTrxName());
		t3.saveEx();
		assertTrue(MyTestPO.exists(t3.get_ID(), getTrxName()), "t3 should exist after save");

		// Verify t1 still exists (was not rolled back)
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should still exist after t2 delete failure");
	}
	
	// New private test PO that throws in afterDelete to trigger rollback to savepoint
	private static final class ThrowAfterDeletePO extends MTest {
		private static final long serialVersionUID = 1L;
		public ThrowAfterDeletePO(Properties ctx, String name, int someInt, String trxName) {
			super(ctx, name, someInt, trxName);
		}
		public ThrowAfterDeletePO(Properties ctx, int id, String trxName) {
			super(ctx, id, trxName);
		}
		@Override
		protected boolean afterDelete(boolean success) {
			throw new RuntimeException("Simulated afterDelete failure");
		}
	}

	@Test
	void testAfterDeleteExRollbackWithSavepoint()
	{
		// Ensure we have a transaction name (so save() will create a savepoint)
		assertNotNull(getTrxName(), "TrxName should not be null");

		// Create and save a normal MTest within the transaction
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.saveEx();
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should exist after save");

		// Create a PO that fails in afterDelete - this should rollback only to the savepoint
		ThrowAfterDeletePO t2 = new ThrowAfterDeletePO(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
		t2.saveEx();
		try {
			t2.deleteEx(false);
			fail("deleteEx should have thrown due to afterDelete failure");
		} catch (Exception e) {
			// expected
		}
		// for afterDelete error, t2 doesn't exist in current trx
		if (t2.get_ID() > 0)
			assertFalse(MyTestPO.exists(t2.get_ID(), getTrxName()), "t2 should not exist for afterDelete failure");
		// test without trx
		t2 = new ThrowAfterDeletePO(Env.getCtx(), 200003, null);
		try {
			t2.deleteEx(false);
			fail("deleteEx should have thrown due to afterDelete failure");
		} catch (Exception e) {
			// expected
		}
		assertEquals(200003, new MTest(Env.getCtx(), 200003, null).get_ID());
		
		// Now create another normal MTest and save - this must succeed even after the failed delete
		MTest t3 = new MTest(Env.getCtx(), "t3_"+System.currentTimeMillis(), 10, getTrxName());
		t3.saveEx();
		assertTrue(MyTestPO.exists(t3.get_ID(), getTrxName()), "t3 should exist after save");

		// Verify t1 still exists (was not rolled back)
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should still exist after t2 delete failure");
	}
		
	// New private test PO that return false in beforeDelete to trigger rollback to savepoint
	private static final class BeforeDeleteFalsePO extends MTest {
		private static final long serialVersionUID = 1L;
		public BeforeDeleteFalsePO(Properties ctx, String name, int someInt, String trxName) {
			super(ctx, name, someInt, trxName);
		}
		public BeforeDeleteFalsePO(Properties ctx, int id, String trxName) {
			super(ctx, id, trxName);
		}
		@Override
		protected boolean beforeDelete() {
			return false;
		}
	}

	@Test
	void testBeforeDeleteFalseRollbackWithSavepoint()
	{
		// Ensure we have a transaction name (so save() will create a savepoint)
		assertNotNull(getTrxName(), "TrxName should not be null");

		// Create and save a normal MTest within the transaction
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.saveEx();
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should exist after save");

		// Create a PO that fails in beforeDelete - this should rollback only to the savepoint
		BeforeDeleteFalsePO t2 = new BeforeDeleteFalsePO(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
		t2.saveEx();
		try {
			t2.deleteEx(false);
			fail("deleteEx should have thrown due to beforeDelete failure");
		} catch (Exception e) {
			// expected
		}
		// t2 should still exist
		if (t2.get_ID() > 0)
			assertTrue(MyTestPO.exists(t2.get_ID(), getTrxName()), "t2 should exist after failed delete");
		// test without trx
		t2 = new BeforeDeleteFalsePO(Env.getCtx(), 200003, null);
		try {
			t2.deleteEx(false);
			fail("deleteEx should have thrown due to beforeDelete failure");
		} catch (Exception e) {
			// expected
		}
		assertEquals(200003, new MTest(Env.getCtx(), 200003, null).get_ID());
		
		// Now create another normal MTest and save - this must succeed even after the failed delete
		MTest t3 = new MTest(Env.getCtx(), "t3_"+System.currentTimeMillis(), 10, getTrxName());
		t3.saveEx();
		assertTrue(MyTestPO.exists(t3.get_ID(), getTrxName()), "t3 should exist after save");

		// Verify t1 still exists (was not rolled back)
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should still exist after t2 delete failure");
	}
	
	// New private test PO that return false in afterDelete to trigger rollback to savepoint
	private static final class AfterDeleteFalsePO extends MTest {
		private static final long serialVersionUID = 1L;
		public AfterDeleteFalsePO(Properties ctx, String name, int someInt, String trxName) {
			super(ctx, name, someInt, trxName);
		}
		public AfterDeleteFalsePO(Properties ctx, int id, String trxName) {
			super(ctx, id, trxName);
		}
		@Override
		protected boolean afterDelete(boolean success) {
			return false;
		}
	}

	@Test
	void testAfterDeleteFalseRollbackWithSavepoint()
	{
		// Ensure we have a transaction name (so save() will create a savepoint)
		assertNotNull(getTrxName(), "TrxName should not be null");

		// Create and save a normal MTest within the transaction
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.saveEx();
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should exist after save");

		// Create a PO that fails in beforeDelete - this should rollback only to the savepoint
		AfterDeleteFalsePO t2 = new AfterDeleteFalsePO(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
		t2.saveEx();
		try {
			t2.deleteEx(false);
			fail("deleteEx should have thrown due to afterDelete failure");
		} catch (Exception e) {
			// expected
		}
		// for afterDelete error, t2 doesn't exist in current trx
		if (t2.get_ID() > 0)
			assertFalse(MyTestPO.exists(t2.get_ID(), getTrxName()), "t2 should not exists for afterDelete failure");
		t2 = new AfterDeleteFalsePO(Env.getCtx(), 200003, null);
		try {
			t2.deleteEx(false);
			fail("deleteEx should have thrown due to afterDelete failure");
		} catch (Exception e) {
			// expected
		}
		assertEquals(200003, new MTest(Env.getCtx(), 200003, null).get_ID());
		
		// Now create another normal MTest and save - this must succeed even after the failed delete
		MTest t3 = new MTest(Env.getCtx(), "t3_"+System.currentTimeMillis(), 10, getTrxName());
		t3.saveEx();
		assertTrue(MyTestPO.exists(t3.get_ID(), getTrxName()), "t3 should exist after save");

		// Verify t1 still exists (was not rolled back)
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should still exist after t2 delete failure");
	}
	

	@Test
	void testBeforeDeleteValidatorRollbackWithSavepoint()
	{
		// Ensure we have a transaction name (so save() will create a savepoint)
		assertNotNull(getTrxName(), "TrxName should not be null");

		// Create and save a normal MTest within the transaction
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.saveEx();
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should exist after save");
		
		// Create a PO that fails in beforeDelete - this should rollback only to the savepoint
		MTest t2 = new MTest(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
		t2.saveEx();
		
		//simulate beforeDelete validator failure by mocking ModelValidationEngine
		ModelValidationEngine mockedEngine = Mockito.mock(ModelValidationEngine.class);
		when(mockedEngine.fireModelChange(any(MTest.class), eq(ModelValidator.TYPE_DELETE))).thenReturn("BeforeDelete validation failed");
		try (MockedStatic<ModelValidationEngine> mockedStatic = Mockito.mockStatic(ModelValidationEngine.class, Mockito.CALLS_REAL_METHODS)) {
			mockedStatic.when(() -> ModelValidationEngine.get()).thenReturn(mockedEngine);
			try {
				t2.deleteEx(false);
				fail("deleteEx should have thrown due to beforeDelete failure");
			} catch (Exception e) {
				// expected
			}
			// t2 should still exist
			if (t2.get_ID() > 0)
				assertTrue(MyTestPO.exists(t2.get_ID(), getTrxName()), "t2 should exist after failed delete");
			// test without trx
			t2 = new MTest(Env.getCtx(), 200003, null);
			try {
				t2.deleteEx(false);
				fail("deleteEx should have thrown due to beforeDelete failure");
			} catch (Exception e) {
				// expected
			}
			assertEquals(200003, new MTest(Env.getCtx(), 200003, null).get_ID());
		} finally {
			reset(mockedEngine);
		}						

		// Now create another normal MTest and save - this must succeed even after the failed delete
		MTest t3 = new MTest(Env.getCtx(), "t3_"+System.currentTimeMillis(), 10, getTrxName());
		t3.saveEx();
		assertTrue(MyTestPO.exists(t3.get_ID(), getTrxName()), "t3 should exist after save");

		// Verify t1 still exists (was not rolled back)
		assertTrue(MyTestPO.exists(t1.get_ID(), getTrxName()), "t1 should still exist after t2 delete failure");
	}
	
	@Test
	void testRecord_IDDeleteValidation() {
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.saveEx();
		
		MTest t2 = new MTest(Env.getCtx(), "t2_"+System.currentTimeMillis(), 10, getTrxName());
		t2.setAD_Table_ID(MTest.Table_ID);
		t2.setRecord_ID(t1.get_ID());
		t2.saveEx();
		
		//Test.Record_ID | 215775
		MColumn column = new MColumn(Env.getCtx(), 215775, null);
		String fkct = column.getFKConstraintType();
		try {
			if (!MColumn.FKCONSTRAINTTYPE_ModelNoAction_ForbidDeletion.equals(fkct)) {
				column.setFKConstraintType(MColumn.FKCONSTRAINTTYPE_ModelNoAction_ForbidDeletion);
				column.saveCrossTenantSafeEx();
				CacheMgt.get().reset(MColumn.Table_Name, column.get_ID());
				PO_Record.resetCache();
			}
			
			// Attempt to delete t1 - should fail due to existing t2 referencing it
			try {
				t1.deleteEx(true);
				fail("deleteEx should have thrown due to Record_ID validation");
			} catch (AdempiereException e) {
				// expected
			}
		} finally {
			if (!MColumn.FKCONSTRAINTTYPE_ModelNoAction_ForbidDeletion.equals(fkct)) {
				column.setFKConstraintType(fkct);
				column.saveCrossTenantSafeEx();
				CacheMgt.get().reset(MColumn.Table_Name, column.get_ID());
				CacheMgt.get().reset("PORecordTables");
			}
		}
	}
	
	@Test
	void TestUpdateSetUUID() {
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.saveEx();
		assertNotNull(t1.get_UUID(), "UUID should have been set in create");
		DB.executeUpdateEx("UPDATE " + MTest.Table_Name + " SET Test_UU=NULL WHERE Test_ID=" + t1.get_ID(), getTrxName());
		t1.load(getTrxName());
		assertNull(t1.getTest_UU(), "UUID should have been set to null by update statement");
		assertEquals("", t1.get_UUID(), "get_UUID should return empty string when UUID column is null");
		t1.setT_Integer(1);
		t1.saveEx();
		t1.load(getTrxName());
		assertNotNull(t1.get_UUID(), "UUID should have been set in update");
	}
	
	@Test
	void TestUseTimeoutForUpdate() {
		// Skip for Oracle as it does not provide reliable query timeout support for update statements
		if (DB.isOracle())
			return;
		
		try (MockedStatic<SystemProperties> mocked = Mockito.mockStatic(SystemProperties.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> SystemProperties.isUseTimeoutForUpdate())
				.thenReturn(true);
			MBPartner bp = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id, getTrxName());
			DB.getDatabase().forUpdate(bp, 1);
			
			Trx trx1 = Trx.get(Trx.createTrxName("TestUseTimeoutForUpdate1"), true);
			try {
				MBPartner bp1 = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id, trx1.getTrxName());
				bp1.set_QueryTimeout(1);
				bp1.setName2(trx1.getTrxName());
				try {
					bp1.saveEx();
				} catch (Exception e) {
					Exception cause = e.getCause() != null ? (Exception)e.getCause() : e;
					assertInstanceOf(DBException.class, cause);
					DBException dbEx = (DBException) cause;
					assertNotNull(dbEx.getSQLException(), "SQLException is null");
					assertTrue(DB.getDatabase().isQueryTimeout(dbEx.getSQLException()), "Exception is not a query timeout");
				}
				
				trx1.rollback();
				
				//test delete with timeout
				trx1.start();
				try {
					bp1 = new MBPartner(Env.getCtx(), DictionaryIDs.C_BPartner.C_AND_W.id, trx1.getTrxName());
					bp1.set_QueryTimeout(1);
					bp1.deleteEx(false);
				} catch (Exception e) {
					Exception cause = e.getCause() != null ? (Exception)e.getCause() : e;
					assertInstanceOf(DBException.class, cause);
					DBException dbEx = (DBException) cause;
					assertNotNull(dbEx.getSQLException(), "SQLException is null");
					assertTrue(DB.getDatabase().isQueryTimeout(dbEx.getSQLException()), "Exception is not a query timeout");
				}
				trx1.rollback();
				
				// release lock
				rollback();								
				
				trx1.start();
				bp1.saveEx();
			} finally {
				try {
					trx1.rollback();
				} catch (Exception e) {
					//ignore
				}
				trx1.close();
			}
		}
	}
	
	@Test
	void testUpdateLOB() throws IOException {
		byte[] imageData = null;
        try (InputStream is = getClass().getResourceAsStream("/org/idempiere/test/model/idempiere_logo.png")) {
        	imageData = is.readAllBytes();
        }
        assertTrue(imageData != null && imageData.length > 0, "Image data should not be null or empty");        
        MImage image = new MImage(Env.getCtx(), 0, getTrxName());
        image.setName("idempiere_logo.png");        
		image.saveEx();
		
		image.setBinaryData(imageData);
		image.saveEx();
		
		MImage image1 = new MImage(Env.getCtx(), image.get_ID(), getTrxName());
		byte[] binaryData = image1.getBinaryData();
		assertTrue(binaryData != null && binaryData.length > 0, "Binary data should not be null or empty");
	}
	
	@Test
	void testOverrideTempDocNo() {
		MOrder order = new MOrder(Env.getCtx(), 0, getTrxName());
		order.setC_BPartner_ID(DictionaryIDs.C_BPartner.C_AND_W.id);
		order.setDateOrdered(new Timestamp(System.currentTimeMillis()));
		order.setDateAcct(order.getDateOrdered());
		order.setIsSOTrx(true);
		order.setC_DocTypeTarget_ID();
		String tempDocNo = "<TMP-"+System.currentTimeMillis() + ">";
		// test override on insert
		order.setDocumentNo(tempDocNo);
		order.saveEx();
		order.load(getTrxName());
		assertNotEquals(tempDocNo, order.getDocumentNo(), "DocumentNo should have been overridden");
		// test override on update
		order.setDocumentNo(tempDocNo);
		order.saveEx();
		order.load(getTrxName());
		assertNotEquals(tempDocNo, order.getDocumentNo(), "DocumentNo should have been overridden");
	}
	
	@Test
	void testCustomColumnInsertUpdate() {
		MTable table = MTable.get(Env.getCtx(), MTest.Table_Name);
		MColumn customColumn = new MColumn(table);
		String customColumnName = "Custom_Column_" + System.currentTimeMillis();
		customColumn.setColumnName(customColumnName);
		customColumn.setAD_Reference_ID(DisplayType.String);
		customColumn.setFieldLength(40);
		
		String addColumnSQL = DB.getDatabase().getSQLAdd(table, customColumn);
		DB.executeUpdateEx(addColumnSQL, null);
		
		try {
			MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
			String customColumnValue = "Custom Column Value";
			assertTrue(t1.set_CustomColumnReturningBoolean(customColumnName, customColumnValue), "Setting custom column value failed");
			t1.saveEx();
			
			String valueFromDB = DB.getSQLValueString(getTrxName(), "SELECT " + customColumnName + " FROM " + MTest.Table_Name
					+ " WHERE " + MTest.COLUMNNAME_Test_ID + "=?", t1.get_ID());
			assertEquals(customColumnValue, valueFromDB, "Custom column value from DB does not match");
			
			//test update
			String customColumnValueUpdated = "Updated Custom Column Value";
			assertTrue(t1.set_CustomColumnReturningBoolean(customColumnName, customColumnValueUpdated), "Setting custom column value failed");
			t1.saveEx();
			
			valueFromDB = DB.getSQLValueString(getTrxName(), "SELECT " + customColumnName + " FROM " + MTest.Table_Name
					+ " WHERE " + MTest.COLUMNNAME_Test_ID + "=?", t1.get_ID());
			assertEquals(customColumnValueUpdated, valueFromDB, "Custom column value from DB does not match");
		} finally {
			rollback();
			//drop column sql is the same for Oracle and Postgres
			String dropColumnSQL = "ALTER TABLE " + MTest.Table_Name + " DROP COLUMN " + customColumnName;
			DB.executeUpdateEx(dropColumnSQL, null);
		}
	}
	
	@Test
	void testDeleteProcessedRecord() {
		MTest t1 = new MTest(Env.getCtx(), "t1_"+System.currentTimeMillis(), 10, getTrxName());
		t1.setProcessed(true);
		t1.saveEx();
	
		assertFalse(t1.delete(false), "Deleting processed record should have failed");
	}

	@Test
	void testUpdateIsTranslated() {
		MClient client = MClient.get(Env.getCtx());
		client = new MClient(client);
		client.setIsMultiLingualDocument(true);
		client.setAD_Language("es_CO");
		try (MockedStatic<MClient> mocked = Mockito.mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MClient.get(any())).thenReturn(client);
			MProduct product = new MProduct(Env.getCtx(), 0, getTrxName());
			product.setName("Test Product");
			product.setC_UOM_ID(DictionaryIDs.C_UOM.EACH.id);
			product.setM_Product_Category_ID(DictionaryIDs.M_Product_Category.CHEMICALS.id );
			product.setC_TaxCategory_ID(DictionaryIDs.C_TaxCategory.STANDARD.id);
			product.saveEx();
			
			// client not base language, IsTranslated should be set to 'Y' on update
			product.setName("Test Product Updated");
			product.saveEx();						
			int count = DB.getSQLValueEx(getTrxName(), "SELECT COUNT(*) FROM M_Product_TRL WHERE M_Product_ID=? "
					+ "AND IsTranslated='Y' AND AD_Language=? AND AD_Client_ID=?", product.get_ID(), 
					client.getAD_Language(), client.getAD_Client_ID());
			assertTrue(count > 0, "There should be translated records for " + client.getAD_Language());
			
			// client is base language, IsTranslated should be set to 'N' on update
			client.setAD_Language(Language.getBaseAD_Language());
			product.setName("Test Product Updated1");
			product.saveEx();			
			count = DB.getSQLValueEx(getTrxName(), "SELECT COUNT(*) FROM M_Product_TRL WHERE M_Product_ID=? "
					+ "AND IsTranslated='N' AND AD_Client_ID=?", product.get_ID(), client.getAD_Client_ID());
			assertTrue(count > 0, "There should be non-translated records when client language is base language");
			
		}
	}	
}