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

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.compiere.db.Database;
import org.compiere.model.MTest;
import org.compiere.model.MUser;
import org.compiere.model.MImage;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_ChangeLog;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Unit tests for PO.toInsertSQL() and PO.buildInsertSQL() methods
 * Uses MTest as the concrete PO implementation for testing
 */
class POInsertSQLTest extends AbstractTestCase {


	@Test
	void testToInsertSQL_BasicColumns() {
		MTest test = new MTest(Env.getCtx(), "TestSQL", 1, getTrxName());
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		assertTrue(sql.startsWith("INSERT INTO Test"));
		assertTrue(sql.contains("Name"));
		assertTrue(sql.contains("TestSQL_1"));
	}
	
	@Test
	void testToInsertSQL_WithStringColumn() {
		MTest test = new MTest(Env.getCtx(), "TestString", 100, getTrxName());
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		assertTrue(sql.contains("TestString_100"));
		assertTrue(sql.contains("INSERT INTO Test"));
	}
	
	@Test
	void testToInsertSQL_WithBooleanColumn() {
		MTest test = new MTest(Env.getCtx(), "TestBoolean", 2, getTrxName());
		test.setIsActive(true);
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		assertTrue(sql.contains("'Y'"));
	}
	
	@Test
	void testToInsertSQL_WithTimestampColumn() {
		MTest test = new MTest(Env.getCtx(), "TestTimestamp", 3, getTrxName());
		Timestamp now = new Timestamp(System.currentTimeMillis());
		test.setT_DateTime(now);
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		assertTrue(sql.contains("T_DateTime"));
	}
	
	@Test
	void testToInsertSQL_WithIntegerColumn() {
		MTest test = new MTest(Env.getCtx(), "TestInteger", 42, getTrxName());
		test.setT_Integer(42);
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		assertTrue(sql.contains("42"));
		assertTrue(sql.contains("T_Integer"));
	}
	
	@Test
	void testToInsertSQL_WithBigDecimalColumn() {
		MTest test = new MTest(Env.getCtx(), "TestDecimal", 5, getTrxName());
		test.setT_Number(new BigDecimal("123.45"));
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		assertTrue(sql.contains("123.45"));
		assertTrue(sql.contains("T_Number"));
	}
	
	@Test
	void testToInsertSQL_PostgreSQL() {
		MTest test = new MTest(Env.getCtx(), "TestPostgreSQL", 6, getTrxName());
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		assertTrue(sql.startsWith("INSERT INTO"));
	}
	
	@Test
	void testToInsertSQL_Oracle() {
		MTest test = new MTest(Env.getCtx(), "TestOracle", 7, getTrxName());
		
		String sql = test.toInsertSQL(Database.DB_ORACLE);
		
		assertNotNull(sql);
		assertTrue(sql.startsWith("INSERT INTO"));
	}
	
	@Test
	void testToInsertSQL_WithNullValues() {
		MTest test = new MTest(Env.getCtx(), 0, getTrxName());
		test.setName("TestNull");
		// Leave other fields as null
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		assertTrue(sql.contains("Name"));
	}
	
	@Test
	void testToInsertSQL_MultipleColumns() {
		MTest test = new MTest(Env.getCtx(), "TestMulti", 10, getTrxName());
		test.setT_Integer(100);
		test.setT_Number(new BigDecimal("999.99"));
		test.setIsActive(true);
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		assertTrue(sql.contains("T_Integer"));
		assertTrue(sql.contains("T_Number"));
		assertTrue(sql.contains("IsActive"));
		assertTrue(sql.contains("100"));
		assertTrue(sql.contains("999.99"));
		assertTrue(sql.contains("'Y'"));
	}
	
	@Test
	void testToInsertSQL_SpecialCharacters() {
		MTest test = new MTest(Env.getCtx(), 0, getTrxName());
		test.setName("Test'Quote");
		test.setDescription("Test with \"quotes\" and 'apostrophes'");
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		// Verify the SQL is generated (proper escaping is handled by DB.TO_STRING)
		assertTrue(sql.contains("Name"));
	}
	
	@Test
	void testToInsertSQL_LongDescription() {
		MTest test = new MTest(Env.getCtx(), 0, getTrxName());
		test.setName("TestLongDesc");
		StringBuilder longDesc = new StringBuilder();
		for (int i = 0; i < 100; i++) {
			longDesc.append("Long description text. ");
		}
		test.setDescription(longDesc.toString());
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		assertTrue(sql.contains("Description"));
	}
	
	@Test
	void testToInsertSQL_AllMandatoryFields() {
		MTest test = new MTest(Env.getCtx(), "TestMandatory", 20, getTrxName());
		// MTest constructor sets mandatory fields
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		assertNotNull(sql);
		assertFalse(sql.isEmpty());
		assertTrue(sql.contains("INSERT INTO"));
		assertTrue(sql.contains("VALUES"));
	}
	
	@Test
	void testToInsertSQL_GenerateScriptMode() {
		// Test that toInsertSQL with database parameter uses generateScriptOnly=true
		// This should skip encrypted, secure, and Password columns
		MTest test = new MTest(Env.getCtx(), "TestScript", 21, getTrxName());
		test.setT_Integer(999);
		test.setT_Number(new BigDecimal("777.88"));
		
		// Generate SQL for PostgreSQL (generateScriptOnly=true)
		String sqlPostgres = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		// Verify SQL is generated correctly for script export
		assertNotNull(sqlPostgres);
		assertTrue(sqlPostgres.startsWith("INSERT INTO Test"));
		assertTrue(sqlPostgres.contains("Name"));
		assertTrue(sqlPostgres.contains("TestScript_21"));
		assertTrue(sqlPostgres.contains("999"));
		assertTrue(sqlPostgres.contains("777.88"));
		
		// Generate SQL for Oracle (generateScriptOnly=true)
		String sqlOracle = test.toInsertSQL(Database.DB_ORACLE);
		
		assertNotNull(sqlOracle);
		assertTrue(sqlOracle.startsWith("INSERT INTO Test"));
		assertTrue(sqlOracle.contains("TestScript_21"));
	}
	
	@Test
	void testToInsertSQL_CustomColumns() {
	
		MTest test = new MTest(Env.getCtx(), "TestPassword", 22, getTrxName());
		test.setT_Integer(888);
		
		test.set_CustomColumn("Password", "secret123");
		test.set_CustomColumn("NormalColumn", "normalValue");
		
		String sql = test.toInsertSQL(Database.DB_POSTGRESQL);
		
		// Verify the SQL is generated
		assertNotNull(sql);
		assertTrue(sql.startsWith("INSERT INTO Test"));
		
		// Custom column should appear
		assertTrue(sql.contains("secret123"), "Password value should not be in SQL for script generation");
		assertTrue(sql.contains("NormalColumn"), "Normal custom columns should be included");
		assertTrue(sql.contains("normalValue"), "Normal custom column values should be included");
		
		// Regular columns should still appear
		assertTrue(sql.contains("888"));
		assertTrue(sql.contains("TestPassword_22"));
	}
	
	@Test
	void testToInsertSQL_SkipsPasswordColumnInGenerateScriptMode() {
		MUser user = new MUser(Env.getCtx(), 0, getTrxName());
		user.setName("TestUser");
		user.setValue("testuser");
		user.setPassword("SecretPassword123!");  // This should NOT appear in generated SQL
		user.setEMail("test@example.com");
		user.setDescription("Test user for password filtering");
		
		// Generate SQL in script mode (generateScriptOnly=true)
		String sql = user.toInsertSQL(Database.DB_POSTGRESQL);
		
		// Verify the SQL is generated
		assertNotNull(sql);
		assertTrue(sql.startsWith("INSERT INTO AD_User"));
		
		// Regular columns should appear
		assertTrue(sql.contains("Name"));
		assertTrue(sql.contains("TestUser"));
		assertTrue(sql.contains("testuser"));
		assertTrue(sql.contains("test@example.com"));
		assertTrue(sql.contains("Test user for password filtering"));
		
		// The Password column and its value should NOT appear in the SQL 
		assertFalse(sql.contains("SecretPassword123!"), "Password value should NOT be in SQL for script generation");
	}
	
	@Test
	void testToInsertSQL_RecordID_WithOfficialID() {
		// Test Record_ID handling when the ID is <= MAX_OFFICIAL_ID (1000000)
		// In this case, the ID should be used directly without using subquery
		
		X_AD_ChangeLog changeLog = new X_AD_ChangeLog(Env.getCtx(), 0, getTrxName());
		changeLog.setAD_Session_ID(1);
		changeLog.setAD_Table_ID(MTable.getTable_ID("AD_User")); // Reference to AD_User table
		changeLog.setRecord_ID(100); // Official ID (< MAX_OFFICIAL_ID)
		changeLog.setAD_Column_ID(1);
		
		// Generate SQL for script export
		String sql = changeLog.toInsertSQL(Database.DB_POSTGRESQL);
		
		// Verify the SQL is generated
		assertNotNull(sql);
		assertTrue(sql.startsWith("INSERT INTO AD_ChangeLog"));
		
		// When Record_ID <= MAX_OFFICIAL_ID, it should appear as-is (not using subquery with uuid column)
		assertTrue(sql.contains("100"), "Official Record_ID should be included directly");
		assertFalse(sql.contains("(SELECT"), "Subquery should NOT be used for official IDs");
	}
	
	@Test
	void testToInsertSQL_RecordID_WithNonOfficialID() {
		// Test Record_ID handling when the ID is > MAX_OFFICIAL_ID (1000000)
		// In this case, the ID should be converted using subquery
		// which looks up the UUID and uses (select TableName_ID from 'TableName' WHERE TableName_UU = 'UUID')
		
		// First, create a test user to reference (this will have an ID > MAX_OFFICIAL_ID in most cases)
		MUser testUser = new MUser(Env.getCtx(), 0, getTrxName());
		testUser.setName("TestUserForRecordID");
		testUser.setValue("recordid_test_user");
		testUser.setEMail("recordid@test.com");
		testUser.saveEx();
		
		int userId = testUser.getAD_User_ID();
		String userUUID = testUser.getAD_User_UU();
		
		// Only run this part if the user ID is > MAX_OFFICIAL_ID
		if (userId > MTable.MAX_OFFICIAL_ID) {
			X_AD_ChangeLog changeLog = new X_AD_ChangeLog(Env.getCtx(), 0, getTrxName());
			changeLog.setAD_Session_ID(1);
			changeLog.setAD_Table_ID(MTable.getTable_ID("AD_User")); // Reference to AD_User table
			changeLog.setRecord_ID(userId); // Non-official ID (> MAX_OFFICIAL_ID)
			changeLog.setAD_Column_ID(1);
			
			// Generate SQL for script export
			String sql = changeLog.toInsertSQL(Database.DB_POSTGRESQL);
			
			// Verify the SQL is generated
			assertNotNull(sql);
			assertTrue(sql.startsWith("INSERT INTO AD_ChangeLog"));
			
			// When Record_ID > MAX_OFFICIAL_ID and AD_Table_ID is set,
			// it should use subquery with the table name and UUID
			assertTrue(sql.contains("(SELECT "), "(SELECT subquery should be used for non-official IDs");
			assertTrue(sql.contains("AD_User"), "Table name should be in AD_User subquery");
			assertTrue(sql.contains(userUUID), "UUID should be in AD_User subquery");
			
			// The raw ID should NOT appear in the SQL
			assertFalse(sql.matches(".*[^a-zA-Z0-9_]" + userId + "[^a-zA-Z0-9_].*"), 
					"Raw non-official Record_ID should NOT appear directly in SQL");
		}
	}
	
	@Test
	void testToInsertSQL_RecordID_WithoutTableID() {
		// Test Record_ID handling when AD_Table_ID is not set or is 0
		// In this case, even if Record_ID > MAX_OFFICIAL_ID, it should use the value directly
		
		X_AD_ChangeLog changeLog = new X_AD_ChangeLog(Env.getCtx(), 0, getTrxName());
		changeLog.setAD_Session_ID(1);
		// Do NOT set AD_Table_ID (or set to 0)
		changeLog.setRecord_ID(5000000); // Non-official ID but no table reference
		changeLog.setAD_Column_ID(1);
		
		// Generate SQL for script export
		String sql = changeLog.toInsertSQL(Database.DB_POSTGRESQL);
		
		// Verify the SQL is generated
		assertNotNull(sql);
		assertTrue(sql.startsWith("INSERT INTO AD_ChangeLog"));
		
		// When AD_Table_ID is not set, Record_ID should be used directly even if > MAX_OFFICIAL_ID
		assertTrue(sql.contains("5000000"), "Record_ID should be included directly when AD_Table_ID not set");
		assertFalse(sql.contains("toRecordId"), "toRecordId function should NOT be used when AD_Table_ID not set");
	}
	
	@Test
	void testToInsertSQLAndExecute() throws IOException {
		MTest testPO = new MTest(Env.getCtx(), 0, getTrxName());
		testPO.setName("InsertSQLTest0");
		testPO.setT_Integer(100);
		testPO.saveEx();
		
		MTest testPO1 = new MTest(Env.getCtx(), 0, getTrxName());
		testPO1.setName("InsertSQLTest1");
		testPO1.setT_Integer(100);
		testPO1.setAD_Table_ID(MTest.Table_ID);
		testPO1.setRecord_ID(testPO.get_ID());
		testPO1.saveEx();
		
		String insertSQL = testPO1.toInsertSQL(DB.getDatabase().getName());
		assertNotNull(insertSQL);
		assertTrue(insertSQL.startsWith("INSERT INTO "));
		assertTrue(insertSQL.contains(MTest.Table_Name));
		assertTrue(insertSQL.contains(MTest.COLUMNNAME_Name));
		assertTrue(insertSQL.contains(MTest.COLUMNNAME_T_Integer));
		
		testPO1.deleteEx(true);
		
		DB.executeUpdateEx(insertSQL, getTrxName());
		
		// test for binary data
		try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
			mocked.when(() -> MSysConfig.getBooleanValue(MSysConfig.EXPORT_BLOB_COLUMN_FOR_INSERT, true, Env.getAD_Client_ID(Env.getCtx())))
				.thenReturn(true);
			byte[] imageData = null;
	        try (InputStream is = getClass().getResourceAsStream("/org/idempiere/test/model/idempiere_logo.png")) {
	        	imageData = is.readAllBytes();
	        }
	        assertTrue(imageData != null && imageData.length > 0, "Image data should not be null or empty");        
	        MImage image = new MImage(Env.getCtx(), 0, getTrxName());
	        image.setName("idempiere_logo.png");
	        image.setBinaryData(imageData);
			image.saveEx();
			
			insertSQL = image.toInsertSQL(DB.getDatabase().getName());
			image.deleteEx(true);
			// Oracle has plsql block for inserting blob and that need special handling for jdbc
			if (DB.isOracle()) {
				int idx = insertSQL.indexOf(";");
				if (idx == -1) {
					fail("Unexpected insert SQL for Oracle not containing semicolon:\n" + insertSQL);
				}
				// split the insert part and plsql part
				String insertPart = insertSQL.substring(0, idx);
				String plsqlPart = insertSQL.substring(idx + 1);
				DB.executeUpdateEx(insertPart, getTrxName());				
				plsqlPart = plsqlPart.trim();
				if (plsqlPart.endsWith("/"))
					plsqlPart = plsqlPart.substring(0,  plsqlPart.length() - 1); // remove /
				try (var pstmt = DB.prepareStatement(plsqlPart, getTrxName())) {
					pstmt.execute();
				} catch (SQLException e) {
					e.printStackTrace();
					fail("Failed to execute PL/SQL part of insert SQL for Oracle:\n" + plsqlPart);
				}
			} else {
				DB.executeUpdateEx(insertSQL, getTrxName());
			}
		}
	}
}
