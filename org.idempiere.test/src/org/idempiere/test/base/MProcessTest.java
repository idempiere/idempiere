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
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.UUID;

import org.compiere.model.MOrder;
import org.compiere.model.MPInstance;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.model.PO;
import org.compiere.model.SystemIDs;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Trx;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.idempiere.test.LoginDetails;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInfo;
import org.junit.jupiter.api.TestInstance;

/**
 * Comprehensive JUnit 5 tests for {@link MProcess}.
 * 
 * @author etantg
 */
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class MProcessTest extends AbstractTestCase {

	private final Properties ctx = Env.getCtx();
	private final int testProcessId = DictionaryIDs.AD_Process.CACHE_RESET.id;
	private String testProcessUUID;
	private String testProcessValue;

	@Override
	protected LoginDetails newLoginDetails(TestInfo testInfo) {
		// System client, SuperUser and System Administrator role
		return new LoginDetails(0, 0, 0, 0, 0, new Timestamp(System.currentTimeMillis()),
				Language.getLanguage("en_US"));
	}

	/**
	 * Fetch stable AD_Process UUID and Value from DB before running tests.
	 */
	@BeforeAll
	public void beforeAll() {
		testProcessUUID = DB.getSQLValueString(null, "SELECT AD_Process_UU FROM AD_Process WHERE AD_Process_ID=?", testProcessId);
		assertNotNull(testProcessUUID, "AD_Process_UU must be present for the selected process");

		testProcessValue = DB.getSQLValueString(null, "SELECT Value FROM AD_Process WHERE AD_Process_ID=?", testProcessId);
		assertNotNull(testProcessValue, "Value must be present for the selected process");
	}

	/**
	 * Test ID-based constructor: MProcess(Properties ctx, int AD_Process_ID, String trxName)
	 */
	@Test
	public void testConstructor_ByID() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		assertNotNull(p, "MProcess constructed by ID should not be null");
		assertEquals(testProcessId, p.getAD_Process_ID(), "Loaded MProcess must have expected AD_Process_ID");
	}

	/**
	 * Test UUID-based constructor: MProcess(Properties ctx, String AD_Process_UU, String trxName)
	 */
	@Test
	public void testConstructor_ByUUID() {
		MProcess p = new MProcess(ctx, testProcessUUID, getTrxName());
		assertNotNull(p, "MProcess constructed by UUID should not be null");
		assertEquals(testProcessId, p.getAD_Process_ID(), "MProcess loaded by UUID should map to same AD_Process_ID");
		
		p = new MProcess(ctx, PO.UUID_NEW_RECORD, getTrxName());
		assertNotNull(p, "MProcess constructed by UUID should not be null");
		assertEquals(0, p.getAD_Process_ID(), "AD_Process_ID should be 0 for new record");
		assertFalse(p.isReport());
		assertEquals(String.valueOf(MProcess.ACCESSLEVEL_ALL), p.getAccessLevel());
		assertEquals(MProcess.ENTITYTYPE_UserMaintained, p.getEntityType());
		assertFalse(p.isBetaFunctionality());
	}

	/**
	 * Test ResultSet-based constructor: MProcess(Properties ctx, ResultSet rs, String trxName)
	 */
	@Test
	public void testConstructor_FromResultSet() throws SQLException {
		String sql = "SELECT * FROM AD_Process WHERE AD_Process_ID=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName());
			pstmt.setInt(1, testProcessId);
			rs = pstmt.executeQuery();
			assertTrue(rs.next(), "ResultSet must contain at least one row for AD_Process");

			MProcess p = new MProcess(ctx, rs, getTrxName());
			assertNotNull(p, "MProcess constructed from ResultSet should not be null");
			assertEquals(testProcessId, p.getAD_Process_ID(), "MProcess(ResultSet) must have expected AD_Process_ID");
		} finally {
			DB.close(rs, pstmt);
		}
	}

	/**
	 * Test copy constructors: MProcess(ctx, copy), MProcess(ctx, copy, trxName) and MProcess(copy).
	 */
	@Test
	public void testConstructor_Copy() {
		MProcess original = new MProcess(ctx, testProcessId, getTrxName());
		MProcess copy1 = new MProcess(ctx, original);
		assertNotNull(copy1, "Copy constructor MProcess(ctx, original) should produce an instance");
		assertEquals(original.getName(), copy1.getName(), "Copied MProcess should keep the same Name");

		MProcess copy2 = new MProcess(ctx, original, getTrxName());
		assertNotNull(copy2, "Copy constructor MProcess(ctx, original, trxName) should produce an instance");
		assertEquals(original.getAD_Process_ID(), copy2.getAD_Process_ID(), "Copied MProcess should keep the same AD_Process_ID when copy constructor preserves it");
		
		MProcess copy3 = new MProcess(original);
		assertNotNull(copy3, "Copy constructor MProcess(original) should produce an instance");
		assertEquals(original.getAD_Process_ID(), copy3.getAD_Process_ID(), "Copied MProcess should keep the same AD_Process_ID when copy constructor preserves it");
		
		MProcess source = null;
        MProcess target = null;
        try {
            source = new MProcess(Env.getCtx(), 0, getTrxName());
            source.setName("SourceProcess");
            source.setAccessLevel("3");
            source.setAD_Form_ID(100);
            source.setAD_PrintFormat_ID(200);
            source.setAD_ReportView_ID(300);
            source.setAD_Workflow_ID(400);
            source.setClassname("org.compiere.process.TestProcess");
            source.setDescription("Source Description");
            source.setHelp("Source Help");
            source.setIsBetaFunctionality(true);
            source.setIsDirectPrint(true);
            source.setIsReport(true);
            source.setJasperReport("SourceJasper");
            source.setProcedureName("proc_source");
            source.setShowHelp(MProcess.SHOWHELP_ShowHelp);
            source.saveEx();

            MProcessPara para1 = new MProcessPara(source);
            para1.setName("Name");
            para1.setColumnName("Name");
            para1.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            para1.setFieldLength(60);
            para1.setSeqNo(10);
            para1.saveEx();

            MProcessPara para2 = new MProcessPara(source);
            para2.setName("Name2");
            para2.setColumnName("Name2");
            para2.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            para2.setFieldLength(60);
            para2.setSeqNo(20);
            para2.saveEx();

            target = new MProcess(Env.getCtx(), source, getTrxName());
            target.setName("TargetProcess");
            target.saveEx();

            assertEquals(source.getAccessLevel(), target.getAccessLevel());
            assertEquals(source.getAD_Form_ID(), target.getAD_Form_ID());
            assertEquals(source.getAD_PrintFormat_ID(), target.getAD_PrintFormat_ID());
            assertEquals(source.getAD_ReportView_ID(), target.getAD_ReportView_ID());
            assertEquals(source.getAD_Workflow_ID(), target.getAD_Workflow_ID());
            assertEquals(source.getClassname(), target.getClassname());
            assertEquals(source.getDescription(), target.getDescription());
            assertEquals(source.getHelp(), target.getHelp());
            assertEquals(source.isBetaFunctionality(), target.isBetaFunctionality());
            assertEquals(source.isDirectPrint(), target.isDirectPrint());
            assertEquals(source.isReport(), target.isReport());
            assertEquals(source.getJasperReport(), target.getJasperReport());
            assertEquals(source.getProcedureName(), target.getProcedureName());
            assertEquals(source.getShowHelp(), target.getShowHelp());

            MProcessPara[] targetParams = target.getParameters();
            assertEquals(2, targetParams.length, "Two parameters should be copied");
            
            MProcessPara targetParam = target.getParameter("Name");
            assertEquals("Name", targetParam.getName());
            assertEquals(10, targetParam.getSeqNo());

            targetParam = target.getParameter("Name2");
            assertEquals("Name2", targetParam.getName());
            assertEquals(20, targetParam.getSeqNo());
        } finally {
            rollback();
        }
	}

	/**
	 * Test isDatabaseProcedure() boolean flag declared in MProcess.
	 */
	@Test
	public void testIsDatabaseProcedure() {
		MProcess p = new MProcess(ctx, DictionaryIDs.AD_Process.DBA_RECOMPILE.id, getTrxName());
		assertTrue(p.isDatabaseProcedure(), "Should be a database procedure");
		
		try {
			MProcess process = new MProcess(ctx, 0, getTrxName());
	        process.setName("TestDBProc");
	        process.saveEx();
	        
	        // Null procedure
	        process.setProcedureName(null);
	        assertFalse(process.isDatabaseProcedure(), "Null procedure name should return false");

	        // Empty string
	        process.setProcedureName("");
	        assertFalse(process.isDatabaseProcedure(), "Empty procedure name should return false");

	        // Whitespace string
	        process.setProcedureName("   ");
	        assertFalse(process.isDatabaseProcedure(), "Whitespace procedure name should return false");
	        
	        // Valid procedure name → true
	        process.setProcedureName("my_proc");
	        assertTrue(process.isDatabaseProcedure(), "Non-empty procedure name should return true");
		} finally {
			rollback();
		}
	}

	/**
	 * Test isForceBackground() boolean flag declared in MProcess.
	 */
	@Test
	public void testIsForceBackground() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		assertFalse(p.isForceBackground(), "Should not be force to run in background");
	}

	/**
	 * Test isForceForeground() boolean flag declared in MProcess.
	 */
	@Test
	public void testIsForceForeground() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		assertFalse(p.isForceForeground(), "Should not be force to run in foreground");
	}

	/**
	 * Test isJavaProcess() boolean flag declared in MProcess.
	 */
	@Test
	public void testIsJavaProcess() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		assertTrue(p.isJavaProcess(), "Should be a Java process");
		
		try {
			MProcess process = new MProcess(ctx, 0, getTrxName());
	        process.setName("TestJavaProc");
	        process.saveEx();

	        // Null classname
	        process.setClassname(null);
	        assertFalse(process.isJavaProcess(), "Null classname should return→ false");

	        // Empty string
	        process.setClassname("");
	        assertFalse(process.isJavaProcess(), "Empty classname should return false");

	        // Whitespace
	        process.setClassname("   ");
	        assertFalse(process.isJavaProcess(), "Whitespace classname should return false");

	        // Valid classname
	        process.setClassname("org.compiere.process.TestProcess");
	        assertTrue(process.isJavaProcess(), "Non-empty classname should return true");
		} finally {
			rollback();
		}
	}

	/**
	 * Test isWorkflow() boolean flag declared in MProcess.
	 */
	@Test
	public void testIsWorkflow() {
		MProcess p = new MProcess(ctx, DictionaryIDs.AD_Process.C_ORDER_PROCESS.id, getTrxName());
		assertTrue(p.isWorkflow(), "Should be a workflow");
		
		try {
			MProcess process = new MProcess(ctx, 0, getTrxName());
	        process.setName("TestJavaProc");
	        process.saveEx();

	        // AD_Workflow_ID = 0
	        process.setAD_Workflow_ID(0);
	        assertFalse(process.isWorkflow(), "Workflow ID = 0 should return false");

	        // AD_Workflow_ID > 0
	        process.setAD_Workflow_ID(p.getAD_Workflow_ID());
	        assertTrue(process.isWorkflow(), "Workflow ID > 0 should return true");
		} finally {
			rollback();
		}
	}

	/**
	 * Test getters, getParameters() and getParameter(name).
	 */
	@Test
	public void testGettersAndParameters() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		assertNotNull(p.getName(), "getName() should return a non-null value");
		MProcessPara[] params = p.getParameters();
		assertNotNull(params, "getParameters() should return non-null array (may be empty)");
		MProcessPara param = p.getParameter("NonExistentParameter");
		assertTrue(param == null, "getParameter for a non-existent name should return null");
	}

	/**
	 * Test toString() method.
	 */
	@Test
	public void testToString() {
		MProcess p = new MProcess(ctx, testProcessId, getTrxName());
		String s = p.toString();
		assertNotNull(s, "toString() must not return null");
		assertTrue(s.length() > 0, "toString() should contain content");
		assertTrue(s.contains(p.getName()), "toString should contain the Name");
	}

	/**
	 * Test static cache behaviour: MProcess.get(ctx, id) and get(id)
	 */
	@Test
	public void testStaticCacheBehavior() {
		MProcess a = MProcess.get(ctx, testProcessId);
		MProcess b = MProcess.get(ctx, testProcessId);
		assertSame(a, b, "MProcess.get(ctx, id) should return the same cached immutable instance");

		MProcess c = MProcess.get(testProcessId);
		assertNotNull(c, "MProcess.get(id) should return an instance");
	}

	/**
	 * Test cases for M_Process.getProcess_ID(value, trxName).
	 */
	@Test
	public void testGetProcessID() {
		int id = MProcess.getProcess_ID(testProcessValue, getTrxName());
		assertEquals(testProcessId, id, "getProcess_ID(value) should return expected AD_Process_ID");

		id = MProcess.getProcess_ID("NonExistentProcess", getTrxName());
		assertTrue(id == 0 || id == -1, "Non-existent process should return 0 or -1");
	}

	/**
	 * Test mandatory validation: saving a new MProcess without mandatory fields should fail.
	 */
	@Test
	public void testMandatoryFieldValidation() {
		MProcess p = new MProcess(ctx, 0, getTrxName());
		assertThrows(Exception.class, () -> {
			p.saveEx();
		}, "Should throw exception when without mandatory fields");
	}

	/**
	 * Test creating a persistent process by copying an existing one, modifying
	 * required fields, saving and cleaning up via delete(true, trxName).
	 */
	@Test
	public void testCreatePersistentObjectByCopyAndCleanup() {
		MProcess editable = MProcess.getCopy(ctx, testProcessId, getTrxName());
		assertNotNull(editable, "getCopy should return an editable MProcess instance");
		String unique = "T_" + System.currentTimeMillis();
		try {
			editable.setName("Test Process " + unique);
			editable.setValue("T_" + unique);
			boolean saved = editable.save();
			assertTrue(saved, "Copied MProcess should save after modifying mandatory fields");
			assertTrue(editable.get_ID() > 0, "Saved MProcess must have an assigned AD_Process_ID");
		} finally {
			try {
				if (editable.get_ID() > 0)
					editable.delete(true, getTrxName());
			} catch (Exception ex) {}
		}
	}
	
	/**
	 * Test cases for MProcess.get(Properties ctx, int AD_Process_ID) and MProcess.get(int AD_Process_ID)
	 */
	@Test
    public void testGetProcessByID() {
		int nonExistingId = -9999999;
        MProcess missing = MProcess.get(ctx, nonExistingId);
        assertNull(missing, "Non-existing ID must return null");

        MProcess viaCtx = MProcess.get(ctx, testProcessId);
        assertNotNull(viaCtx, "Null cache entry should not block DB load");
        assertEquals(testProcessId, viaCtx.getAD_Process_ID());
        
        missing = MProcess.get(nonExistingId);
        assertNull(missing, "Non-existing ID must return null");

        MProcess viaString = MProcess.get(testProcessId);
        assertEquals(viaCtx.getAD_Process_ID(), viaString.getAD_Process_ID(), "AD_Process_ID must be the same");
    }
	
	/**
	 * Test cases for MProcess.get(Properties ctx, String AD_Process_UU) and MProcess.get(String AD_Process_UU)
	 */
	@Test
    public void testGetProcessByUU() {
        String missingUU = UUID.randomUUID().toString();
        MProcess missing = MProcess.get(ctx, missingUU);
        assertNull(missing, "Non-existing UU must return null");

        MProcess viaCtx = MProcess.get(ctx, testProcessUUID);
        assertNotNull(viaCtx, "Null cache entry should not block DB load");
        assertEquals(testProcessUUID, viaCtx.getAD_Process_UU());
        
        missing = MProcess.get(missingUU);
        assertNull(missing, "Non-existing UU must return null");

        MProcess viaString = MProcess.get(testProcessUUID);
        assertEquals(viaCtx.getAD_Process_ID(), viaString.getAD_Process_ID(), "AD_Process_ID must be the same");
        assertEquals(testProcessUUID, viaString.getAD_Process_UU());
    }
	
	/**
     * Test cases for MProcess.getFromMenu(Properties ctx, int AD_Menu_ID)
     */
    @Test
    public void testGetFromMenu() {
        int missingMenuID = -999999;
        MProcess none = MProcess.getFromMenu(Env.getCtx(), missingMenuID);
        assertNull(none, "Non-existing AD_Menu_ID must return null");

        MProcess p = MProcess.getFromMenu(Env.getCtx(), DictionaryIDs.AD_Menu.CACHE_RESET.id);
        assertNotNull(p, "getFromMenu must return process when menu has AD_Process_ID");
        assertEquals(testProcessId, p.getAD_Process_ID(), "AD_Process_ID must match");
        assertEquals(testProcessUUID, p.getAD_Process_UU(), "AD_Process_UU must match");
        
        none = MProcess.getFromMenu(Env.getCtx(), missingMenuID);
        assertNull(none, "Non-existing Menu ID must return null");
    }
    
    /**
     * Test cases for MProcess.copyFrom(MProcess source)
     */
    @Test
    public void testCopyFrom() {
        String trxName = getTrxName();
        MProcess source = null;
        MProcess target = null;

        try {
            source = new MProcess(Env.getCtx(), 0, trxName);
            source.setName("SourceProcess");
            source.setAccessLevel("3");
            source.setAD_Form_ID(100);
            source.setAD_PrintFormat_ID(200);
            source.setAD_ReportView_ID(300);
            source.setAD_Workflow_ID(400);
            source.setClassname("org.compiere.process.TestProcess");
            source.setDescription("Source Description");
            source.setHelp("Source Help");
            source.setIsBetaFunctionality(true);
            source.setIsDirectPrint(true);
            source.setIsReport(true);
            source.setJasperReport("SourceJasper");
            source.setProcedureName("proc_source");
            source.setShowHelp(MProcess.SHOWHELP_ShowHelp);
            source.saveEx();

            MProcessPara para1 = new MProcessPara(source);
            para1.setName("Name");
            para1.setColumnName("Name");
            para1.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            para1.setFieldLength(60);
            para1.setSeqNo(10);
            para1.saveEx();

            MProcessPara para2 = new MProcessPara(source);
            para2.setName("Name2");
            para2.setColumnName("Name2");
            para2.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            para2.setFieldLength(60);
            para2.setSeqNo(20);
            para2.saveEx();

            target = new MProcess(Env.getCtx(), 0, trxName);
            target.setName("TargetProcess");
            target.saveEx();

            target.copyFrom(source);

            assertEquals(source.getAccessLevel(), target.getAccessLevel());
            assertEquals(source.getAD_Form_ID(), target.getAD_Form_ID());
            assertEquals(source.getAD_PrintFormat_ID(), target.getAD_PrintFormat_ID());
            assertEquals(source.getAD_ReportView_ID(), target.getAD_ReportView_ID());
            assertEquals(source.getAD_Workflow_ID(), target.getAD_Workflow_ID());
            assertEquals(source.getClassname(), target.getClassname());
            assertEquals(source.getDescription(), target.getDescription());
            assertEquals(source.getHelp(), target.getHelp());
            assertEquals(source.isBetaFunctionality(), target.isBetaFunctionality());
            assertEquals(source.isDirectPrint(), target.isDirectPrint());
            assertEquals(source.isReport(), target.isReport());
            assertEquals(source.getJasperReport(), target.getJasperReport());
            assertEquals(source.getProcedureName(), target.getProcedureName());
            assertEquals(source.getShowHelp(), target.getShowHelp());

            MProcessPara[] targetParams = target.getParameters();
            assertEquals(2, targetParams.length, "Two parameters should be copied");

            assertEquals("Name", targetParams[0].getName());
            assertEquals(10, targetParams[0].getSeqNo());

            assertEquals("Name2", targetParams[1].getName());
            assertEquals(20, targetParams[1].getSeqNo());
        } finally {
            rollback();
        }
    }
    
    /**
     * Test cases for MProcess.getParameters()
     */
    @Test
    public void testGetParameters() {
    	try {
	    	MProcess process = new MProcess(ctx, 0, getTrxName());
	        process.setName("TestProcessParams");
	        process.setIsActive(true);
	        process.saveEx();
	
	        MProcessPara[] emptyParams = process.getParameters();
	        assertNotNull(emptyParams, "Returned array must not be null");
	        assertEquals(0, emptyParams.length, "No parameters yet → length 0");
	
	        MProcessPara para1 = new MProcessPara(process);
	        para1.setName("Name");
	        para1.setColumnName("Name");
            para1.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            para1.setFieldLength(60);
	        para1.setSeqNo(20);
	        para1.setIsActive(true);
	        para1.saveEx();
	
	        MProcessPara para2 = new MProcessPara(process);
	        para2.setName("Name2");
	        para2.setColumnName("Name2");
            para2.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            para2.setFieldLength(60);
	        para2.setSeqNo(10);
	        para2.setIsActive(true);
	        para2.saveEx();
	
	        MProcessPara para3 = new MProcessPara(process);
	        para3.setName("Transaction Date");
	        para3.setColumnName("DateTrx");
	        para3.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_DATE);
	        para3.setFieldLength(30);
	        para3.setSeqNo(30);
	        para3.setIsActive(false); // inactive, should be ignored
	        para3.saveEx();
	        
	        process = new MProcess(ctx, process.get_ID(), getTrxName());
	        MProcessPara[] params = process.getParameters();
	        assertNotNull(params, "Parameters array must not be null");
	        assertEquals(2, params.length, "Only active parameters returned");
	
	        assertEquals("Name2", params[0].getName(), "First parameter must have lowest SeqNo");
	        assertEquals("Name", params[1].getName(), "Second parameter must have next SeqNo");
	
	        MProcessPara[] cachedParams = process.getParameters();
	        assertSame(params, cachedParams, "Cached array should be returned");
    	} finally {
    		rollback();
    	}
    }
    
    /**
     * Test cases for MProcess.markImmutable()
     */
    @Test
    public void testMarkImmutable() {
        try {
	    	MProcess process = new MProcess(ctx, 0, getTrxName());
	        process.setName("ImmutableTest");
	        process.saveEx();
	        
	        MProcessPara para1 = new MProcessPara(process);
	        para1.setName("Name");
	        para1.setColumnName("Name");
            para1.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            para1.setFieldLength(60);
	        para1.setSeqNo(10);
	        para1.saveEx();
	
	        MProcessPara para2 = new MProcessPara(process);
	        para2.setName("Name2");
	        para2.setColumnName("Name2");
            para2.setAD_Reference_ID(SystemIDs.REFERENCE_DATATYPE_STRING);
            para2.setFieldLength(60);
	        para2.setSeqNo(20);
	        para2.saveEx();
	        
	        process = new MProcess(ctx, process.get_ID(), getTrxName());
	        MProcessPara[] params = process.getParameters();
	        assertNotNull(params, "Parameters array must not be null");
	        assertEquals(2, params.length, "Only active parameters returned");
	        
	        process.markImmutable();
	        MProcess returned = process.markImmutable();
	        assertSame(process, returned, "Should return itself if already immutable");
	        assertTrue(process.is_Immutable(), "Process should be marked immutable");
	    	
	        for (MProcessPara p : params) {
	            assertTrue(p.is_Immutable(), "Parameter should be marked immutable when process is immutable");
	        }
	        MProcessPara[] returnedParams = returned.getParameters();
	        assertSame(params, returnedParams, "Should return itself if already immutable");
        } finally {
        	rollback();
        }
    }
    
    /**
     * Test cases for MProcess.processIt(ProcessInfo pi, Trx trx), MProcess.processIt(ProcessInfo pi, Trx trx, boolean managedTrx)
     * and MProcess.processItWithoutTrxClose(ProcessInfo pi, Trx trx)
     */
    @Test
    public void testProcessIt() {
        // Report process
        Trx trx = Trx.get(getTrxName(), false);
        MProcess process = MProcess.get(ctx, SystemIDs.PROCESS_RPT_C_ORDER);
        MOrder order = new MOrder(Env.getCtx(),  108, getTrxName()); // Garden Order 60000
        MPInstance pinstance = new MPInstance(process, order.get_Table_ID(), order.getC_Order_ID(), order.getC_Order_UU());
        ProcessInfo pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
		pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
		pi.setTable_ID(pinstance.getAD_Table_ID());
		pi.setRecord_ID(pinstance.getRecord_ID());
        boolean ok = process.processIt(pi, trx);
        assertTrue(ok, "Report process must return true");
        
        pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
		pi.setAD_PInstance_ID(0);
		pi.setTable_ID(pinstance.getAD_Table_ID());
		pi.setRecord_ID(pinstance.getRecord_ID());
        ok = process.processItWithoutTrxClose(pi, trx);
        assertTrue(ok, "Report process must return true");

        // Java process
        process = MProcess.get(ctx, DictionaryIDs.AD_Process.CACHE_RESET.id);
        pinstance = new MPInstance(process, 0, 0, null);
        pi = new ProcessInfo(process.getName(), process.getAD_Process_ID());
        pi.setAD_PInstance_ID(pinstance.getAD_PInstance_ID());
		ok = process.processIt(pi, trx, true);
        assertTrue(ok, "Java process should call startClass and return true");
    }
}
