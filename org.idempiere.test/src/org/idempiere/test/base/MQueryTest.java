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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Properties;

import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.model.MQuery;
import org.compiere.model.PO;
import org.compiere.model.MBPartner;
import org.compiere.model.MClient;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.junit.jupiter.api.Test;
import org.idempiere.db.util.SQLFragment;
import org.idempiere.test.AbstractTestCase;

public class MQueryTest extends AbstractTestCase {
	
	@Test
	void testGetZoomColumnName() {
		assertEquals("AD_User_ID", MQuery.getZoomColumnName("SalesRep_ID"));
		assertEquals("C_DocType_ID", MQuery.getZoomColumnName("C_DocTypeTarget_ID"));
		assertEquals("C_BPartner_ID", MQuery.getZoomColumnName("Bill_BPartner_ID"));
		assertEquals("C_BPartner_Location_ID", MQuery.getZoomColumnName("Bill_Location_ID"));
		assertEquals("C_BPartner_Location_ID", MQuery.getZoomColumnName("BillTo_ID"));
		assertEquals("C_ElementValue_ID", MQuery.getZoomColumnName("Account_ID"));
		assertEquals("C_Location_ID", MQuery.getZoomColumnName("C_LocFrom_ID"));
		assertEquals("C_Location_ID", MQuery.getZoomColumnName("C_LocTo_ID"));
		assertEquals("C_Location_ID", MQuery.getZoomColumnName("BP_Location_ID"));
		assertEquals("C_UOM_ID", MQuery.getZoomColumnName("C_UOM_To_ID"));
		assertEquals("M_AttributeSetInstance_ID", MQuery.getZoomColumnName("M_AttributeSetInstanceTo_ID"));
		assertEquals("M_Locator_ID", MQuery.getZoomColumnName("M_LocatorTo_ID"));
		assertEquals("AD_Org_ID", MQuery.getZoomColumnName("AD_OrgBP_ID"));
		assertEquals("AD_Org_ID", MQuery.getZoomColumnName("AD_OrgTrx_ID"));
		assertEquals("AD_Org_ID", MQuery.getZoomColumnName("AD_OrgTo_ID"));
		assertEquals("C_BPartner_ID", MQuery.getZoomColumnName("C_BPartner_ID"));
		assertNull(MQuery.getZoomColumnName(null));
	}

	@Test
	void testGetZoomTableName() {
		assertEquals("C_BPartner", MQuery.getZoomTableName("C_BPartner_ID"));
		assertEquals("AD_User", MQuery.getZoomTableName("SalesRep_ID"));
		assertEquals("Test", MQuery.getZoomTableName("Test_UU"));
		assertEquals("Test", MQuery.getZoomTableName("Test"));
	}

	@Test
	void testGetEqualQuery() {
		MQuery q = MQuery.getEqualQuery("C_BPartner_ID", 100);
		assertEquals("C_BPartner", q.getTableName());
		assertEquals(1, q.getRestrictionCount());
		assertEquals("C_BPartner_ID", q.getColumnName(0));
		assertEquals(MQuery.EQUAL, q.getOperator(0));
		assertEquals(100, q.getCode(0));
		
		q = MQuery.getEqualQuery("Name", "Test");
		assertEquals("", q.getTableName());
		assertEquals(1, q.getRestrictionCount());
		assertEquals("Name", q.getColumnName(0));
		assertEquals(MQuery.EQUAL, q.getOperator(0));
		assertEquals("Test", q.getCode(0));
	}

	@Test
	void testGetNoRecordQuery() {
		MQuery q = MQuery.getNoRecordQuery("C_BPartner", true);
		assertEquals("C_BPartner", q.getTableName());
		assertTrue(q.isNewRecordQuery());
		assertEquals(0, q.getRecordCount());
		
		q = MQuery.getNoRecordQuery("C_BPartner", false);
		assertEquals("C_BPartner", q.getTableName());
		assertFalse(q.isNewRecordQuery());
		assertEquals(0, q.getRecordCount());
	}
	
	@Test
	void testConstructors() {
		MQuery q = new MQuery();
		assertEquals("", q.getTableName());
		
		q = new MQuery("C_BPartner");
		assertEquals("C_BPartner", q.getTableName());
		
		q = new MQuery(MClient.Table_ID); // AD_Table_ID for AD_Client
		assertEquals("AD_Client", q.getTableName());
	}
	
	@Test
	void testSetGet() {
		MQuery q = new MQuery("C_BPartner");
		q.setRecordCount(10);
		assertEquals(10, q.getRecordCount());
		
		q.setZoomWindowID(123);
		assertEquals(123, q.getZoomWindowID());
		
		q.setZoomTableName("MyZoomTable");
		assertEquals("MyZoomTable", q.getZoomTableName());
		
		q.setZoomColumnName("MyZoomColumn");
		assertEquals("MyZoomColumn", q.getZoomColumnName());
		
		q.setZoomValue(456);
		assertEquals(456, q.getZoomValue());
		
		MQuery reportQuery = new MQuery("ReportQuery");
		q.setReportProcessQuery(reportQuery);
		assertEquals(reportQuery, q.getReportProcessQuery());
	}
	
	@Test
	void testAddRestriction() {
		MQuery q = new MQuery("C_BPartner");
		q.addRestriction("Name", MQuery.LIKE, "Test%");
		assertEquals(1, q.getRestrictionCount());
		assertEquals("Name", q.getColumnName(0));
		assertEquals(MQuery.LIKE, q.getOperator(0));
		assertEquals("Test%", q.getCode(0));
		assertTrue(q.isActive());
		
		q.addRestriction("C_BPartner_ID", MQuery.EQUAL, 100);
		assertEquals(2, q.getRestrictionCount());
		assertEquals("C_BPartner_ID", q.getColumnName(1));
		assertEquals(MQuery.EQUAL, q.getOperator(1));
		assertEquals(100, q.getCode(1));
	}
	
	@Test
	void testAddRangeRestriction() {
		MQuery q = new MQuery("C_Order");
		q.addRangeRestriction("DateOrdered", new java.util.Date(), new java.util.Date());
		assertEquals(1, q.getRestrictionCount());
		assertEquals("DateOrdered", q.getColumnName(0));
		assertEquals(MQuery.BETWEEN, q.getOperator(0));
		assertNotNull(q.getCode(0));
		assertNotNull(q.getCode_to(0));
	}
	
	@Test
	void testGetWhereClause() {
		MQuery q = new MQuery("C_BPartner");
		q.addRestriction("Name", MQuery.EQUAL, "Test");
		q.addRestriction("IsActive", MQuery.EQUAL, "Y");
		String where = q.getSQLFilter(true).sqlClause();
		assertEquals("(C_BPartner.Name=? AND C_BPartner.IsActive=?)", where);
		
		MQuery q2 = new MQuery("C_BPartner");
		q2.addRestriction("Name", MQuery.EQUAL, "Test", "Name", "Test", true, 0);
		q2.addRestriction("Value", MQuery.EQUAL, "TestValue", "Value", "TestValue", false, 1);
		where = q2.getSQLFilter(true).sqlClause();
		assertEquals("(C_BPartner.Name=? OR (C_BPartner.Value=?))", where);
	}
	
	@Test
	void testGetInfo() {
		MQuery q = new MQuery("C_BPartner");
		q.addRestriction("Name", MQuery.EQUAL, "Test", "Business Partner Name", "Test");
		String info = q.getInfo();
		assertEquals("C_BPartner: Business Partner Name"
				+ Msg.getMsg(Env.getCtx(), MQuery.MSG_EQUAL)
				+ "Test", info);
	}
	
	@Test
	void testDeepCopy() {
		MQuery q1 = new MQuery("C_BPartner");
		q1.addRestriction("Name", MQuery.EQUAL, "Test");
		MQuery q2 = q1.deepCopy();
		
		assertNotEquals(q1, q2);
		assertEquals(q1.getTableName(), q2.getTableName());
		assertEquals(q1.getRestrictionCount(), q2.getRestrictionCount());
		assertEquals(q1.getColumnName(0), q2.getColumnName(0));
		
		q2.addRestriction("IsActive", MQuery.EQUAL, "Y");
		assertNotEquals(q1.getRestrictionCount(), q2.getRestrictionCount());
	}
	
	@Test
	void testClone() {
		MQuery q1 = new MQuery("C_BPartner");
		q1.addRestriction("Name", MQuery.EQUAL, "Test");
		MQuery q2 = q1.clone();
		
		assertNotEquals(q1, q2);
		assertEquals(q1.getTableName(), q2.getTableName());
		assertEquals(q1.getRestrictionCount(), q2.getRestrictionCount());
		assertEquals(q1.getColumnName(0), q2.getColumnName(0));
		
		q2.addRestriction("IsActive", MQuery.EQUAL, "Y");
		assertNotEquals(q1.getRestrictionCount(), q2.getRestrictionCount());
	}

	@Test
	void testGetDisplayName() {
		MQuery q = new MQuery("C_BPartner");
		Properties ctx = Env.getCtx();
		String displayName = q.getDisplayName(ctx);
		assertEquals("Business Partner", displayName);
	}

	@Test
	void testSetTableName() {
		MQuery q = new MQuery();
		q.setTableName("C_Order");
		assertEquals("C_Order", q.getTableName());
	}

	@Test
	void testRestrictionGetters() {
		MQuery q = new MQuery("C_BPartner");
		q.addRestriction("Name", MQuery.EQUAL, "Test", "BP Name", "Test Display");
		q.addRangeRestriction("Value", "A", "B", "BP Value", "A Display", "B Display");

		assertEquals("BP Name", q.getInfoName(0));
		assertEquals(Msg.getMsg(Env.getCtx(), MQuery.MSG_EQUAL), q.getInfoOperator(0));
		assertEquals("Test Display", q.getInfoDisplay(0));
		assertEquals("Test Display", q.getInfoDisplayAll(0));
		assertNull(q.getInfoDisplay_to(0));

		assertEquals("BP Value", q.getInfoName(1));
		assertEquals(Msg.getMsg(Env.getCtx(), MQuery.MSG_BETWEEN), q.getInfoOperator(1));
		assertEquals("A Display", q.getInfoDisplay(1));
		assertEquals("B Display", q.getInfoDisplay_to(1));
		assertEquals("A Display - B Display", q.getInfoDisplayAll(1));
	}

	@Test
	void testGetSqlFilterByIndex() {
		MQuery q = new MQuery("C_BPartner");
		q.addRestriction("Name", MQuery.EQUAL, "Test");
		SQLFragment filter = q.getSQLFilter(0);
		assertNotNull(filter);
		assertEquals("Name=?", filter.sqlClause());
		assertEquals(1, filter.parameters().size());
		assertEquals("Test", filter.parameters().get(0));
	}

	@Test
	void testToString() {
		MQuery q = new MQuery("C_BPartner");
		q.addRestriction("Name", MQuery.EQUAL, "Test");
		String toString = q.toString();
		assertEquals("SQLFragment[sqlClause=(C_BPartner.Name=?), parameters=[Test]]", toString);

		MQuery qEmpty = new MQuery("C_Order");
		assertEquals("MQuery[C_Order,Restrictions=0]", qEmpty.toString());
	}
	
	@Test
	void testGetProcessQuery() {
		List<PO> created = new ArrayList<>();
		
		try {
			// 1. Create a process
			MProcess process = new MProcess(Env.getCtx(), 0, null);
			process.setValue("TestProcess_" + System.currentTimeMillis());
			process.setName("Test Process");
			process.setProcedureName("org.compiere.process.Noop");
			process.saveCrossTenantSafeEx();
			created.add(process);
			int AD_Process_ID = process.getAD_Process_ID();
	
			// 2. Create process parameters
			MProcessPara para1 = new MProcessPara(Env.getCtx(), 0, null);
			para1.setAD_Process_ID(AD_Process_ID);
			para1.setColumnName("Name");
			para1.setName("Name");
			para1.setEntityType("U");
			para1.setAD_Reference_ID(DisplayType.String);
			para1.setSeqNo(10);
			para1.saveEx();
			created.add(para1);
	
			MProcessPara para2 = new MProcessPara(Env.getCtx(), 0, null);
			para2.setAD_Process_ID(AD_Process_ID);
			para2.setColumnName("Value");
			para2.setName("Value");
			para2.setEntityType("U");
			para2.setAD_Reference_ID(DisplayType.String);
			para2.setSeqNo(20);
			para2.setIsRange(true);
			para2.saveEx();
			created.add(para2);
			
			MProcessPara para3 = new MProcessPara(Env.getCtx(), 0, null);
			para3.setAD_Process_ID(AD_Process_ID);
			para3.setColumnName("C_BP_Group_ID");
			para3.setName("BP Group");
			para3.setEntityType("U");
			para3.setAD_Reference_ID(DisplayType.TableDir);
			para3.setSeqNo(30);
			para3.saveEx();
			created.add(para3);
			
			MProcessPara para4 = new MProcessPara(Env.getCtx(), 0, null);
			para4.setAD_Process_ID(AD_Process_ID);
			para4.setColumnName(MBPartner.COLUMNNAME_DocumentCopies);
			para4.setName("Document Copies");
			para4.setEntityType("U");
			para4.setAD_Reference_ID(DisplayType.Integer);
			para4.setSeqNo(40);
			para4.setIsRange(true);
			para4.saveEx();
			created.add(para4);
			
			MProcessPara para5 = new MProcessPara(Env.getCtx(), 0, null);
			para5.setAD_Process_ID(AD_Process_ID);
			para5.setColumnName("Description");
			para5.setName("Description");
			para5.setEntityType("U");
			para5.setAD_Reference_ID(DisplayType.String);
			para5.setSeqNo(50);
			para5.saveEx();
			created.add(para5);
			
			MProcessPara para6 = new MProcessPara(Env.getCtx(), 0, null);
			para6.setAD_Process_ID(AD_Process_ID);
			para6.setColumnName("Created");
			para6.setName("Created");
			para6.setEntityType("U");
			para6.setAD_Reference_ID(DisplayType.Date);
			para6.setSeqNo(60);
			para6.saveEx();
			created.add(para6);
			
			MProcessPara para7 = new MProcessPara(Env.getCtx(), 0, null);
			para7.setAD_Process_ID(AD_Process_ID);
			para7.setColumnName("Updated");
			para7.setName("Updated");
			para7.setEntityType("U");
			para7.setAD_Reference_ID(DisplayType.Date);
			para7.setSeqNo(70);
			para7.setIsRange(true);
			para7.saveEx();
			created.add(para7);
			
			MProcessPara para8 = new MProcessPara(Env.getCtx(), 0, null);
			para8.setAD_Process_ID(AD_Process_ID);
			para8.setColumnName("AD_Language");
			para8.setName("Language");
			para8.setEntityType("U");
			para8.setAD_Reference_ID(DisplayType.ChosenMultipleSelectionList);
			para8.setSeqNo(80);
			para8.saveEx();
			created.add(para8);
			
			MProcessPara para9 = new MProcessPara(Env.getCtx(), 0, null);
			para9.setAD_Process_ID(AD_Process_ID);
			para9.setColumnName(MBPartner.COLUMNNAME_C_PaymentTerm_ID);
			para9.setName("Payment Term");
			para9.setEntityType("U");
			para9.setAD_Reference_ID(DisplayType.ChosenMultipleSelectionTable);
			para9.setSeqNo(90);
			para9.saveEx();
			created.add(para9);
			
			MProcessPara para10 = new MProcessPara(Env.getCtx(), 0, null);
			para10.setAD_Process_ID(AD_Process_ID);
			para10.setColumnName(MBPartner.COLUMNNAME_ReferenceNo);
			para10.setName("Reference No");
			para10.setEntityType("U");
			para10.setAD_Reference_ID(DisplayType.String);
			para10.setSeqNo(100);
			para10.setQuery("C_BPartner.Name LIKE @Name@");
			para10.saveEx();
			created.add(para10);
	
			// 3. Create a process instance
			MPInstance pinstance = new MPInstance(Env.getCtx(), AD_Process_ID, 0, 0, "");
			pinstance.saveEx();
			created.add(pinstance);
			int AD_PInstance_ID = pinstance.getAD_PInstance_ID();
	
			// 4. Set parameter values for the instance
			MPInstancePara ipara1 = new MPInstancePara(Env.getCtx(), AD_PInstance_ID, 10);
			ipara1.setParameterName("Name");
			ipara1.setP_String("Test%");
			ipara1.saveEx();
			created.add(ipara1);
	
			MPInstancePara ipara2 = new MPInstancePara(Env.getCtx(), AD_PInstance_ID, 20);
			ipara2.setParameterName("Value");
			ipara2.setP_String("A");
			ipara2.setP_String_To("B");
			ipara2.saveEx();
			created.add(ipara2);
			
			MPInstancePara ipara3 = new MPInstancePara(Env.getCtx(), AD_PInstance_ID, 30);
			ipara3.setParameterName("C_BP_Group_ID");
			ipara3.setP_Number(100);
			ipara3.saveEx();
			created.add(ipara3);
			
			MPInstancePara ipara4 = new MPInstancePara(Env.getCtx(), AD_PInstance_ID, 40);
			ipara4.setParameterName(MBPartner.COLUMNNAME_DocumentCopies);
			ipara4.setP_Number(10);
			ipara4.setP_Number_To(20);
			ipara4.saveEx();
			created.add(ipara4);
			
			MPInstancePara ipara5 = new MPInstancePara(Env.getCtx(), AD_PInstance_ID, 50);
			ipara5.setParameterName("Description");
			ipara5.setP_String("No");
			ipara5.saveEx();
			created.add(ipara5);
			
			java.util.Date date = new java.util.Date();
			MPInstancePara ipara6 = new MPInstancePara(Env.getCtx(), AD_PInstance_ID, 60);
			ipara6.setParameterName("Created");
			ipara6.setP_Date(new java.sql.Timestamp(date.getTime()));
			ipara6.saveEx();
			created.add(ipara6);
			
			MPInstancePara ipara7 = new MPInstancePara(Env.getCtx(), AD_PInstance_ID, 70);
			ipara7.setParameterName("Updated");
			ipara7.setP_Date(new java.sql.Timestamp(date.getTime()));
			ipara7.setP_Date_To(new java.sql.Timestamp(date.getTime() + 100000));
			ipara7.saveEx();
			created.add(ipara7);
			
			MPInstancePara ipara8 = new MPInstancePara(Env.getCtx(), AD_PInstance_ID, 80);
			ipara8.setParameterName("AD_Language");
			ipara8.setP_String("en_US,en_GB");
			ipara8.saveEx();
			created.add(ipara8);
			
			MPInstancePara ipara9 = new MPInstancePara(Env.getCtx(), AD_PInstance_ID, 90);
			ipara9.setParameterName(MBPartner.COLUMNNAME_C_PaymentTerm_ID);
			ipara9.setP_String("100,101");
			ipara9.saveEx();
			created.add(ipara9);
			
			MPInstancePara ipara10 = new MPInstancePara(Env.getCtx(), AD_PInstance_ID, 100);
			ipara10.setParameterName(MBPartner.COLUMNNAME_ReferenceNo);
			ipara10.setP_String("12345");
			ipara10.saveEx();
			created.add(ipara10);
	
			// 5. Call MQuery.get()
			MQuery q = MQuery.get(Env.getCtx(), AD_PInstance_ID, "C_BPartner");
	
			// 6. Assertions
			assertNotNull(q);
			assertEquals(10, q.getRestrictionCount());
			assertTrue(q.isActive());
	
			assertEquals("Name", q.getColumnName(0));
			assertEquals(MQuery.LIKE, q.getOperator(0));
			assertEquals("Test%", q.getCode(0));
			SQLFragment sqlFilter = q.getSQLFilter(0, true);
			assertEquals("C_BPartner.Name LIKE ?", sqlFilter.sqlClause());
			assertTrue(Objects.equals(sqlFilter.parameters(), List.of(q.getCode(0))));
	
			assertEquals("Value", q.getColumnName(1));
			assertEquals(MQuery.BETWEEN, q.getOperator(1));
			assertEquals("A", q.getCode(1));
			assertEquals("B", q.getCode_to(1));
			sqlFilter = q.getSQLFilter(1, true);
			assertEquals("C_BPartner.Value BETWEEN ? AND ?", sqlFilter.sqlClause());
			assertTrue(Objects.equals(sqlFilter.parameters(), List.of(q.getCode(1), q.getCode_to(1))));
			
			assertEquals("C_BP_Group_ID", q.getColumnName(2));
			assertEquals(MQuery.EQUAL, q.getOperator(2));
			assertEquals(100, ((Number)q.getCode(2)).intValue());
			sqlFilter = q.getSQLFilter(2, true);
			assertEquals("C_BPartner.C_BP_Group_ID=?", sqlFilter.sqlClause());
			assertTrue(Objects.equals(sqlFilter.parameters(), List.of(q.getCode(2))));
			
			assertEquals(MBPartner.COLUMNNAME_DocumentCopies, q.getColumnName(3));
			assertEquals(MQuery.BETWEEN, q.getOperator(3));
			assertEquals(10, ((Number)q.getCode(3)).intValue());
			assertEquals(20, ((Number)q.getCode_to(3)).intValue());
			sqlFilter = q.getSQLFilter(3, true);
			assertEquals("C_BPartner.DocumentCopies BETWEEN ? AND ?", sqlFilter.sqlClause());
			assertTrue(Objects.equals(sqlFilter.parameters(), List.of(q.getCode(3), q.getCode_to(3))));
			
			String where = q.getSQLFilter(true).sqlClause();
			assertTrue(where.contains("Description=?"), where);
			
			assertEquals("TRUNC(Created)", q.getColumnName(5));
			assertEquals(MQuery.EQUAL, q.getOperator(5));
			assertNotNull(q.getCode(5));
			sqlFilter = q.getSQLFilter(5, true);
			assertEquals("TRUNC(C_BPartner.Created)=?", sqlFilter.sqlClause());
			assertTrue(Objects.equals(sqlFilter.parameters(), List.of(q.getCode(5))));

			assertEquals("TRUNC(Updated)", q.getColumnName(6));
			assertEquals(MQuery.BETWEEN, q.getOperator(6));
			assertNotNull(q.getCode(6));
			assertNotNull(q.getCode_to(6));
			sqlFilter = q.getSQLFilter(6, true);
			assertEquals("TRUNC(C_BPartner.Updated) BETWEEN ? AND ?", sqlFilter.sqlClause());
			assertTrue(Objects.equals(sqlFilter.parameters(), List.of(q.getCode(6), q.getCode_to(6))));
			
			assertTrue(q.getSQLFilter(true).sqlClause().contains("C_BPartner.AD_Language IN (?,?)"), q.getSQLFilter(true).sqlClause());
			
			assertTrue(q.getSQLFilter(true).sqlClause().contains("C_BPartner.C_PaymentTerm_ID IN (?,?)"), q.getSQLFilter(true).sqlClause());
			
			assertTrue(q.getSQLFilter(true).sqlClause().contains("C_BPartner.Name LIKE ?"), q.getSQLFilter(true).sqlClause());
			
		} finally {
			rollback();
			Collections.reverse(created);
			for (PO po : created) {
				po.deleteEx(true);
			}
		}
	}
}