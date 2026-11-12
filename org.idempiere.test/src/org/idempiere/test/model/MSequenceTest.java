package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

import org.compiere.model.MAllocationHdr;
import org.compiere.model.MBPartner;
import org.compiere.model.MChangeLog;
import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MDocType;
import org.compiere.model.MInOut;
import org.compiere.model.MInOutLine;
import org.compiere.model.MInvoice;
import org.compiere.model.MInvoiceLine;
import org.compiere.model.MOrder;
import org.compiere.model.MOrderLine;
import org.compiere.model.MPayment;
import org.compiere.model.MProduct;
import org.compiere.model.MSequence;
import org.compiere.model.MSession;
import org.compiere.model.MStorageReservationLog;
import org.compiere.model.MSysConfig;
import org.compiere.model.MUser;
import org.compiere.model.MWarehouse;
import org.compiere.model.Query;
import org.compiere.process.DocAction;
import org.compiere.process.ProcessInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.TimeUtil;
import org.compiere.util.Trx;
import org.compiere.wf.MWFActivity;
import org.compiere.wf.MWFEventAudit;
import org.compiere.wf.MWFProcess;
import org.compiere.wf.MWorkflow;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Tests for {@link org.compiere.model.MSequence} class.
 * Testing document number generation using AD_Sequence:
 * context variable keys feature (/K flag), UUID sequences,
 * sequences allowing gaps and decimal patterns.
 */
@Isolated
public class MSequenceTest extends AbstractTestCase {

    private static final String TEST_PREFIX = "TestSeq-";
    private static final String TEST_SUFFIX = "-End";
    private static final String TEST_DATE = "2025-06-13 10:00:00";
    private static final String TEST_DATE_yyyyMM = "202506";

    @Test
    public void testDocumentNoWithContextVariableKey() {
        Properties ctx = Env.getCtx();
        String trxName = getTrxName();

        // Create test sequence
        MSequence seq = new MSequence(ctx, 0, trxName);
        seq.setName("Test Sequence with Context Key");
        seq.setDescription("Test sequence for document numbers with context variable key");
        seq.setPrefix(TEST_PREFIX + "@DateOrdered<yyyyMM>/K@"); // /K flag indicates context variable use
        seq.setSuffix("@AD_Org_ID/K@" + TEST_SUFFIX);
        seq.setStartNo(1000);
        seq.setCurrentNext(1000);
        seq.setIncrementNo(1);
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setStartNewYear(false);
        seq.setStartNewMonth(false);
        seq.saveEx();

        // Create test document type
        MDocType docType = new MDocType(ctx, 0, trxName);
        docType.setName("Test Document Type");
        docType.setPrintName("Test Document");
        docType.setDocNoSequence_ID(seq.get_ID());
        docType.setIsActive(true);
        docType.setDocBaseType("SOO"); // Sales Order
        docType.setGL_Category_ID(); // Set default GL category
        docType.setIsDocNoControlled(true);
        docType.saveEx();

        try (MockedStatic<MDocType> mockedStatic = Mockito.mockStatic(MDocType.class)) {
        	mockedStatic.when(() -> MDocType.get(ctx, docType.getC_DocType_ID()))
				.thenReturn(docType);
	        // Generate document number through sales order creation
	        Timestamp testDate = Timestamp.valueOf(TEST_DATE);
	        Env.setContext(ctx, "#Date", testDate);
	        int testOrgID = 11; // Example organization ID
	        Env.setContext(ctx, "#AD_Org_ID", testOrgID);

	        // Create and save a sales order
	        MOrder order = new MOrder(ctx, 0, trxName);
	        order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id));
	        order.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
	        order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
	        order.setDocStatus(DocAction.STATUS_Drafted);
	        order.setDocAction(DocAction.ACTION_Complete);
	        order.setDateOrdered(testDate);
	        order.setDatePromised(testDate);
	        order.saveEx();

	        String docNo = order.getDocumentNo();
	        assertNotNull(docNo, "Document number should not be null");

	        // The document number should follow pattern: TestSeq-202506{seq}11-End
	        assertTrue(docNo.startsWith(TEST_PREFIX + TEST_DATE_yyyyMM),
	        		"Document number should start with prefix and date key: "+docNo);
	        assertTrue(docNo.endsWith(testOrgID + TEST_SUFFIX),
	        		"Document number should end with org ID key and suffix: "+docNo);

	        // Check sequence number part
	        String seqPart = docNo.substring((TEST_PREFIX + TEST_DATE_yyyyMM).length(),
	                docNo.length() - (String.valueOf(testOrgID) + TEST_SUFFIX).length());
	        assertEquals("1000", seqPart, "Sequence number should be 1000");

	        // Test sequential number generation with another order
	        MOrder order2 = new MOrder(ctx, 0, trxName);
	        order2.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id));
	        order2.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
	        order2.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
	        order2.setDocStatus(DocAction.STATUS_Drafted);
	        order2.setDocAction(DocAction.ACTION_Complete);
	        order2.setDateOrdered(testDate);
	        order2.setDatePromised(testDate);
	        order2.saveEx();

	        String docNo2 = order2.getDocumentNo();
	        String seqPart2 = docNo2.substring((TEST_PREFIX + TEST_DATE_yyyyMM).length(),
	                docNo2.length() - (String.valueOf(testOrgID) + TEST_SUFFIX).length());
	        assertEquals("1001", seqPart2, "Next sequence number should be 1001");

	        // Test with different org ID
	        int newOrgID = 12;
	        Env.setContext(ctx, "#AD_Org_ID", newOrgID);

	        MOrder order3 = new MOrder(ctx, 0, trxName);
	        order3.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id));
	        order3.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
	        order3.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
	        order3.setDocStatus(DocAction.STATUS_Drafted);
	        order3.setDocAction(DocAction.ACTION_Complete);
	        order3.setDateOrdered(testDate);
	        order3.setDatePromised(testDate);
	        order3.saveEx();

	        String docNo3 = order3.getDocumentNo();
	        assertTrue(docNo3.endsWith(newOrgID + TEST_SUFFIX),
	                "Document number should end with new org ID key and suffix");
	        String seqPart3 = docNo3.substring((TEST_PREFIX + TEST_DATE_yyyyMM).length(),
	                docNo3.length() - (String.valueOf(newOrgID) + TEST_SUFFIX).length());
	        assertEquals("1000", seqPart3, "Sequence number should restart at 1000 for new org key");
        }
    }

    @Test
    public void testUUIDSequenceDocumentNo() {
        MSequence seq = new MSequence(Env.getCtx(), 0, getTrxName());
        seq.setName("Test UUID Sequence");
        seq.setPrefix(TEST_PREFIX);
        seq.setSuffix(TEST_SUFFIX);
        seq.setStartNo(1000);
        seq.setCurrentNext(1000);
        seq.setIncrementNo(1);
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setIsAllowSequenceGaps(false); // must be forced to true by beforeSave
        seq.setIsUUIDSeq(true);
        seq.saveEx();

        assertTrue(seq.isAllowSequenceGaps(), "UUID sequences must allow gaps");

        String docNo1 = MSequence.getDocumentNoFromSeq(seq, getTrxName(), null);
        assertNotNull(docNo1, "Document number should not be null");
        assertTrue(docNo1.startsWith(TEST_PREFIX), "Document number should start with prefix: "+docNo1);
        assertTrue(docNo1.endsWith(TEST_SUFFIX), "Document number should end with suffix: "+docNo1);

        String uuidPart = docNo1.substring(TEST_PREFIX.length(), docNo1.length() - TEST_SUFFIX.length());
        UUID uuid = UUID.fromString(uuidPart);
        assertEquals(7, uuid.version(), "Document number must contain a UUIDv7: "+docNo1);

        String docNo2 = MSequence.getDocumentNoFromSeq(seq, getTrxName(), null);
        assertNotEquals(docNo1, docNo2, "Each document must get a different UUID");
    }

    @Test
    public void testUUIDSequenceByTableName() {
        Properties ctx = Env.getCtx();
        String tableName = "TestUUIDDocNoTable";

        MSequence seq = new MSequence(ctx, 0, getTrxName());
        seq.setName("DocumentNo_" + tableName);
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setIsUUIDSeq(true);
        seq.saveEx();

        String docNo = MSequence.getDocumentNo(getAD_Client_ID(), tableName, getTrxName());
        assertNotNull(docNo, "Document number should not be null");
        UUID uuid = UUID.fromString(docNo);
        assertEquals(7, uuid.version(), "Document number must be a UUIDv7: "+docNo);
    }

    @Test
    public void testUUIDSequenceDocumentNoOnOrder() {
        Properties ctx = Env.getCtx();
        String trxName = getTrxName();

        // Create test UUID sequence
        MSequence seq = new MSequence(ctx, 0, trxName);
        seq.setName("Test UUID Sequence for Order");
        seq.setPrefix(TEST_PREFIX);
        seq.setSuffix(TEST_SUFFIX);
        seq.setIsAutoSequence(true);
        seq.setIsUUIDSeq(true);
        seq.saveEx();

        // Create test document type
        MDocType docType = new MDocType(ctx, 0, trxName);
        docType.setName("Test UUID Document Type");
        docType.setPrintName("Test UUID Document");
        docType.setDocNoSequence_ID(seq.get_ID());
        docType.setIsActive(true);
        docType.setDocBaseType("SOO"); // Sales Order
        docType.setGL_Category_ID(); // Set default GL category
        docType.setIsDocNoControlled(true);
        docType.saveEx();

        Timestamp testDate = Timestamp.valueOf(TEST_DATE);

        try (MockedStatic<MDocType> mockedStatic = Mockito.mockStatic(MDocType.class)) {
        	mockedStatic.when(() -> MDocType.get(ctx, docType.getC_DocType_ID()))
				.thenReturn(docType);

	        // Create and save a sales order
	        MOrder order = new MOrder(ctx, 0, trxName);
	        order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id));
	        order.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
	        order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
	        order.setDocStatus(DocAction.STATUS_Drafted);
	        order.setDocAction(DocAction.ACTION_Complete);
	        order.setDateOrdered(testDate);
	        order.setDatePromised(testDate);
	        order.saveEx();

	        String docNo = order.getDocumentNo();
	        assertNotNull(docNo, "Document number should not be null");
	        assertTrue(docNo.startsWith(TEST_PREFIX), "Document number should start with prefix: "+docNo);
	        assertTrue(docNo.endsWith(TEST_SUFFIX), "Document number should end with suffix: "+docNo);

	        String uuidPart = docNo.substring(TEST_PREFIX.length(), docNo.length() - TEST_SUFFIX.length());
	        UUID uuid = UUID.fromString(uuidPart);
	        assertEquals(7, uuid.version(), "Document number must contain a UUIDv7: "+docNo);

	        // A second order gets a different UUID
	        MOrder order2 = new MOrder(ctx, 0, trxName);
	        order2.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.JOE_BLOCK.id));
	        order2.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
	        order2.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
	        order2.setDocStatus(DocAction.STATUS_Drafted);
	        order2.setDocAction(DocAction.ACTION_Complete);
	        order2.setDateOrdered(testDate);
	        order2.setDatePromised(testDate);
	        order2.saveEx();

	        assertNotEquals(docNo, order2.getDocumentNo(), "Each order must get a different UUID document number");
        }
    }

    @Test
    public void testUUIDSequenceClearsIncompatibleFlagsAndIgnoresDecimalPattern() {
        MSequence seq = new MSequence(Env.getCtx(), 0, getTrxName());
        seq.setName("Test UUID Sequence Incompatible Flags");
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setIsUUIDSeq(true);
        // all these flags are incompatible with UUID sequences and must be cleared on save
        seq.setStartNewYear(true);
        seq.setStartNewMonth(true);
        seq.setIsOrgLevelSequence(true);
        seq.setDecimalPattern("00000");
        seq.saveEx();

        assertFalse(seq.isStartNewYear(), "UUID sequences cannot restart each year");
        assertFalse(seq.isStartNewMonth(), "UUID sequences cannot restart each month");
        assertFalse(seq.isOrgLevelSequence(), "UUID sequences cannot be org level");
        assertTrue(seq.isAllowSequenceGaps(), "UUID sequences must allow gaps");

        String docNo = MSequence.getDocumentNoFromSeq(seq, getTrxName(), null);
        assertNotNull(docNo, "Document number should not be null");
        UUID uuid = UUID.fromString(docNo);
        assertEquals(7, uuid.version(), "Decimal pattern must not be applied to UUID sequences: "+docNo);
    }

    @Test
    public void testTableSequenceForcesAllowGapsAndDisallowsUUID() {
        MSequence seq = new MSequence(Env.getCtx(), 0, getTrxName());
        seq.setName("Test Table Sequence Flags");
        seq.setIsAutoSequence(true);
        seq.setIsTableID(true);
        seq.setIsUUIDSeq(true); // incompatible with table id sequences
        seq.setIsAllowSequenceGaps(false); // must be forced to true for table id sequences
        seq.saveEx();

        assertFalse(seq.isUUIDSeq(), "Table id sequences cannot be UUID based");
        assertTrue(seq.isAllowSequenceGaps(), "Table id sequences must allow gaps by default");
    }

    @Test
    public void testInactiveUUIDSequenceReturnsNull() {
        MSequence seq = new MSequence(Env.getCtx(), 0, getTrxName());
        seq.setName("Test UUID Sequence Inactive");
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setIsUUIDSeq(true);
        seq.setIsActive(false);
        seq.saveEx();

        assertNull(MSequence.getDocumentNoFromSeq(seq, getTrxName(), null),
                "Inactive UUID sequence must not return a document number");
    }

    @Test
    public void testInactiveNumericSequenceReturnsNull() {
        MSequence seq = new MSequence(Env.getCtx(), 0, getTrxName());
        seq.setName("Test Numeric Sequence Inactive");
        seq.setStartNo(1000);
        seq.setCurrentNext(1000);
        seq.setIncrementNo(1);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setIsActive(false);
        seq.saveEx();

        assertNull(MSequence.getDocumentNoFromSeq(seq, getTrxName(), null),
                "Inactive sequence must not return a document number");
    }

    @Test
    public void testDecimalPattern() {
        MSequence seq = new MSequence(Env.getCtx(), 0, getTrxName());
        seq.setName("Test Sequence Decimal Pattern");
        seq.setStartNo(1000);
        seq.setCurrentNext(1000);
        seq.setIncrementNo(1);
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setDecimalPattern("00000");
        seq.saveEx();

        assertEquals("01000", MSequence.getDocumentNoFromSeq(seq, getTrxName(), null),
                "Decimal pattern must format the sequence number with leading zeros");
        assertEquals("01001", MSequence.getDocumentNoFromSeq(seq, getTrxName(), null),
                "Next sequence number must be formatted with the decimal pattern");
    }

    @Test
    public void testAllowGapsSequenceConsumesNumberDespiteRollback() {
        Properties ctx = Env.getCtx();

        // Sequences allowing gaps are read and updated on their own connection,
        // so the row must be committed for that connection to see it
        MSequence seq = new MSequence(ctx, 0, getTrxName());
        seq.setName("Test Sequence Allowing Gaps");
        seq.setStartNo(1000);
        seq.setCurrentNext(1000);
        seq.setIncrementNo(1);
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setIsAllowSequenceGaps(true);
        seq.saveEx();
        commit();
        int seqID = seq.getAD_Sequence_ID();

        // Simulate a document transaction that fails after getting the next number
        Trx docTrx = Trx.get(Trx.createTrxName("TestGapDoc_"), true);
        try {
	        MSequence docSeq = new MSequence(ctx, seqID, docTrx.getTrxName());
	        String docNo = MSequence.getDocumentNoFromSeq(docSeq, docTrx.getTrxName(), null);
	        assertEquals("1000", docNo, "First document number must be the start number");
	        docTrx.rollback();
        } finally {
        	docTrx.close();
        }

        // The number was consumed even though the document transaction was rolled back
        int currentNext = DB.getSQLValueEx(null, "SELECT CurrentNext FROM AD_Sequence WHERE AD_Sequence_ID=?", seqID);
        assertEquals(1001, currentNext, "Sequence allowing gaps must consume the number despite rollback");

        // The next document continues after the gap
        Trx docTrx2 = Trx.get(Trx.createTrxName("TestGapDoc2_"), true);
        try {
	        MSequence docSeq2 = new MSequence(ctx, seqID, docTrx2.getTrxName());
	        assertEquals("1001", MSequence.getDocumentNoFromSeq(docSeq2, docTrx2.getTrxName(), null),
	                "Next document number must continue after the gap");
	        docTrx2.rollback();
        } finally {
        	docTrx2.close();
        }

        // Clean up the committed sequence
        DB.executeUpdateEx("DELETE FROM AD_Sequence WHERE AD_Sequence_ID=?", new Object[] {seqID}, getTrxName());
        commit();
    }

    @Test
    public void testNoGapsSequenceRestoresNumberOnRollback() {
        Properties ctx = Env.getCtx();

        MSequence seq = new MSequence(ctx, 0, getTrxName());
        seq.setName("Test Sequence Without Gaps");
        seq.setStartNo(1000);
        seq.setCurrentNext(1000);
        seq.setIncrementNo(1);
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setIsAllowSequenceGaps(false);
        seq.saveEx();
        commit();
        int seqID = seq.getAD_Sequence_ID();

        // Simulate a document transaction that fails after getting the next number
        Trx docTrx = Trx.get(Trx.createTrxName("TestNoGapDoc_"), true);
        try {
	        MSequence docSeq = new MSequence(ctx, seqID, docTrx.getTrxName());
	        assertEquals("1000", MSequence.getDocumentNoFromSeq(docSeq, docTrx.getTrxName(), null),
	                "First document number must be the start number");
	        docTrx.rollback();
        } finally {
        	docTrx.close();
        }

        // The number was not consumed: the sequence update took part in the document transaction
        int currentNext = DB.getSQLValueEx(null, "SELECT CurrentNext FROM AD_Sequence WHERE AD_Sequence_ID=?", seqID);
        assertEquals(1000, currentNext, "Sequence without gaps must not consume the number on rollback");

        // The rolled back number is reused by the next document
        Trx docTrx2 = Trx.get(Trx.createTrxName("TestNoGapDoc2_"), true);
        try {
	        MSequence docSeq2 = new MSequence(ctx, seqID, docTrx2.getTrxName());
	        assertEquals("1000", MSequence.getDocumentNoFromSeq(docSeq2, docTrx2.getTrxName(), null),
	                "Rolled back number must be reused by the next document");
	        docTrx2.rollback();
        } finally {
        	docTrx2.close();
        }

        // Clean up the committed sequence
        DB.executeUpdateEx("DELETE FROM AD_Sequence WHERE AD_Sequence_ID=?", new Object[] {seqID}, getTrxName());
        commit();
    }

    @Test
    public void testAllowGapsStartNewYearPersistsSequenceNoOutsideDocumentTrx() {
        Properties ctx = Env.getCtx();

        MSequence seq = new MSequence(ctx, 0, getTrxName());
        seq.setName("Test Sequence Allowing Gaps New Year");
        seq.setStartNo(1000);
        seq.setCurrentNext(1000);
        seq.setIncrementNo(1);
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setStartNewYear(true);
        seq.setIsAllowSequenceGaps(true);
        seq.saveEx();
        commit();
        int seqID = seq.getAD_Sequence_ID();

        // Simulate a document transaction that fails after getting the first number of the year
        Trx docTrx = Trx.get(Trx.createTrxName("TestGapYearDoc_"), true);
        try {
	        MSequence docSeq = new MSequence(ctx, seqID, docTrx.getTrxName());
	        String docNo = MSequence.getDocumentNoFromSeq(docSeq, docTrx.getTrxName(), null);
	        assertEquals("1000", docNo, "First number of the year must be the start number");
	        docTrx.rollback();
        } finally {
        	docTrx.close();
        }

        // The AD_Sequence_No row for the year must be persisted outside the rolled back document transaction
        int currentNext = DB.getSQLValueEx(null, "SELECT CurrentNext FROM AD_Sequence_No WHERE AD_Sequence_ID=?", seqID);
        assertEquals(1001, currentNext, "AD_Sequence_No must be persisted despite document transaction rollback");

        // The next document of the year continues after the start number
        Trx docTrx2 = Trx.get(Trx.createTrxName("TestGapYearDoc2_"), true);
        try {
	        MSequence docSeq2 = new MSequence(ctx, seqID, docTrx2.getTrxName());
	        assertEquals("1001", MSequence.getDocumentNoFromSeq(docSeq2, docTrx2.getTrxName(), null),
	                "Next document number of the year must continue after the gap");
	        docTrx2.rollback();
        } finally {
        	docTrx2.close();
        }

        // Clean up the committed rows
        DB.executeUpdateEx("DELETE FROM AD_Sequence_No WHERE AD_Sequence_ID=?", new Object[] {seqID}, getTrxName());
        DB.executeUpdateEx("DELETE FROM AD_Sequence WHERE AD_Sequence_ID=?", new Object[] {seqID}, getTrxName());
        commit();
    }

    @Test
    public void testDeferredDocumentNoUpdatesStorageReservationLog() {
        Properties ctx = Env.getCtx();
        String trxName = getTrxName();

        if (MSession.get(ctx) == null)
        	MSession.create(ctx);
        
        MSequence seq = new MSequence(ctx, 0, null);
        seq.setName("Test Lazy DocNo Sequence");
        seq.setPrefix("LAZY-");
        seq.setStartNo(5000);
        seq.setCurrentNext(5000);
        seq.setIncrementNo(1);
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setIsAllowSequenceGaps(false);
        seq.saveEx();

        MDocType docType = new MDocType(ctx, 0, null);
        docType.setName("Test Lazy SO DocType");
        docType.setPrintName("Test Lazy SO");
        docType.setDocNoSequence_ID(seq.get_ID());
        docType.setIsActive(true);
        docType.setDocBaseType(MDocType.DOCBASETYPE_SalesOrder);
        docType.setDocSubTypeSO(MDocType.DOCSUBTYPESO_StandardOrder);
        docType.setGL_Category_ID();
        docType.setIsDocNoControlled(true);
        docType.setIsLazyGenerateDocNo(MDocType.ISLAZYGENERATEDOCNO_Yes);        

        MDocType invDocType = null;
        
        try (MockedStatic<MSysConfig> mockedSysConfig = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
            mockedSysConfig.when(() -> MSysConfig.getValue(MSysConfig.SYSTEM_INSERT_CHANGELOG, "N", getAD_Client_ID()))
                .thenReturn("Y");

            docType.saveEx();
            
            Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
            MOrder order = new MOrder(ctx, 0, trxName);
            order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
            order.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
            order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
            order.setDocStatus(DocAction.STATUS_Drafted);
            order.setDocAction(DocAction.ACTION_Complete);
            order.setDateOrdered(today);
            order.setDatePromised(today);
            order.saveEx();

            assertTrue(order.is_UsingTemporaryDocumentNo(), "Order should hold a temporary DocumentNo after save");
            String tempDocNo = order.get_TemporaryDocumentNo();
            assertNotNull(tempDocNo, "Temporary DocumentNo should not be null");
            assertTrue(MSequence.isTemporaryDocumentNo(tempDocNo), "Should be a temporary DocumentNo: " + tempDocNo);

            int docNoColumnId = MColumn.getColumn_ID(MOrder.Table_Name, MOrder.COLUMNNAME_DocumentNo);
            MChangeLog changeLogBefore = new Query(ctx, MChangeLog.Table_Name, "AD_Table_ID=? AND Record_ID=? AND AD_Column_ID=? AND EventChangeLog=?", trxName)
                    .setParameters(MOrder.Table_ID, order.get_ID(), docNoColumnId, MChangeLog.EVENTCHANGELOG_Insert)
                    .first();
            assertNotNull(changeLogBefore, "Insert MChangeLog for DocumentNo should exist");
            assertEquals(tempDocNo, changeLogBefore.getNewValue(), "Insert MChangeLog should initially hold temporary DocumentNo");

            MOrderLine line1 = new MOrderLine(order);
            line1.setLine(10);
            line1.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.AZALEA_BUSH.id));
            line1.setQty(new BigDecimal("1"));
            line1.setDatePromised(today);
            line1.saveEx();

            MOrderLine line2 = new MOrderLine(order);
            line2.setLine(20);
            line2.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.OAK.id));
            line2.setQty(new BigDecimal("2"));
            line2.setDatePromised(today);
            line2.saveEx();

            ProcessInfo info = MWorkflow.runDocumentActionWorkflow(order, DocAction.ACTION_Complete);
            assertFalse(info.isError(), info.getSummary());
            assertEquals(DocAction.STATUS_Completed, order.getDocStatus());
            assertTrue(order.is_UsingTemporaryDocumentNo(), "Order should still hold a temporary DocumentNo after workflow completion");

            // Reading getDocumentNo() triggers deferred sequence generation and updates M_StorageReservationLog, AD_ChangeLog, and WF records
            String actualDocNo = order.getDocumentNo();
            assertEquals("LAZY-5000", actualDocNo);
            assertFalse(order.is_UsingTemporaryDocumentNo(), "Order should no longer hold a temporary DocumentNo");

            MWFProcess wfProcess = new Query(ctx, MWFProcess.Table_Name, "AD_Table_ID=? AND Record_ID=?", trxName)
                    .setParameters(MOrder.Table_ID, order.get_ID())
                    .first();
            assertNotNull(wfProcess, "MWFProcess should exist for order");
            assertTrue(wfProcess.getTextMsg().contains(actualDocNo), "MWFProcess TextMsg should be updated with actual DocumentNo: " + wfProcess.getTextMsg());
            assertFalse(wfProcess.getTextMsg().contains(tempDocNo), "MWFProcess TextMsg should not contain temporary DocumentNo");

            MWFActivity wfActivity = new Query(ctx, MWFActivity.Table_Name, "AD_WF_Process_ID=? AND TextMsg IS NOT NULL", trxName)
                    .setParameters(wfProcess.getAD_WF_Process_ID())
                    .setOrderBy(MWFActivity.COLUMNNAME_AD_WF_Activity_ID + " DESC")
                    .first();
            assertNotNull(wfActivity, "MWFActivity with TextMsg should exist for order");
            assertTrue(wfActivity.getTextMsg().contains(actualDocNo), "MWFActivity TextMsg should be updated with actual DocumentNo: " + wfActivity.getTextMsg());
            assertFalse(wfActivity.getTextMsg().contains(tempDocNo), "MWFActivity TextMsg should not contain temporary DocumentNo");

            MWFEventAudit wfAudit = new Query(ctx, MWFEventAudit.Table_Name, "AD_WF_Process_ID=? AND AD_WF_Node_ID=?", trxName)
                    .setParameters(wfProcess.getAD_WF_Process_ID(), wfActivity.getAD_WF_Node_ID())
                    .setOrderBy(MWFEventAudit.COLUMNNAME_AD_WF_EventAudit_ID + " DESC")
                    .first();
            assertNotNull(wfAudit, "MWFEventAudit should exist for order activity");
            assertTrue(wfAudit.getTextMsg().contains(actualDocNo), "MWFEventAudit TextMsg should be updated with actual DocumentNo: " + wfAudit.getTextMsg());
            assertFalse(wfAudit.getTextMsg().contains(tempDocNo), "MWFEventAudit TextMsg should not contain temporary DocumentNo");

            MChangeLog changeLogAfter = new Query(ctx, MChangeLog.Table_Name, "AD_Table_ID=? AND Record_ID=? AND AD_Column_ID=? AND EventChangeLog=?", trxName)
                    .setParameters(MOrder.Table_ID, order.get_ID(), docNoColumnId, MChangeLog.EVENTCHANGELOG_Insert)
                    .first();
            assertNotNull(changeLogAfter, "Insert MChangeLog for DocumentNo should exist");
            assertEquals(actualDocNo, changeLogAfter.getNewValue(), "Insert MChangeLog should be updated with actual DocumentNo");

            MStorageReservationLog log1 = new Query(ctx, MStorageReservationLog.Table_Name, "AD_Table_ID=? AND Record_ID=?", trxName)
                    .setParameters(MOrderLine.Table_ID, line1.get_ID())
                    .first();
            assertNotNull(log1, "MStorageReservationLog should exist for line 1");
            assertEquals(actualDocNo, log1.getDocumentNo(), "MStorageReservationLog for line 1 should be updated with actual DocumentNo");

            MStorageReservationLog log2 = new Query(ctx, MStorageReservationLog.Table_Name, "AD_Table_ID=? AND Record_ID=?", trxName)
                    .setParameters(MOrderLine.Table_ID, line2.get_ID())
                    .first();
            assertNotNull(log2, "MStorageReservationLog should exist for line 2");
            assertEquals(actualDocNo, log2.getDocumentNo(), "MStorageReservationLog for line 2 should be updated with actual DocumentNo");

            rollback();
            
            try (MockedStatic<MClient> mockedClient = Mockito.mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS)) {
            	mockedClient.when(() -> MClient.isClientAccountingImmediate())
                    .thenReturn(false);
	            // Also verify MInvoice completion with AD_User_ID keeps DocumentNo deferred and updates MUser.LastResult
	            invDocType = new MDocType(ctx, 0, null);
	            invDocType.setName("Test Lazy ARI DocType");
	            invDocType.setPrintName("Test Lazy ARI");
	            invDocType.setDocNoSequence_ID(seq.get_ID());
	            invDocType.setIsActive(true);
	            invDocType.setDocBaseType(MDocType.DOCBASETYPE_ARInvoice);
	            invDocType.setGL_Category_ID();
	            invDocType.setIsDocNoControlled(true);
	            invDocType.setIsLazyGenerateDocNo(MDocType.ISLAZYGENERATEDOCNO_Yes);
	            invDocType.saveEx();
	
	            MBPartner bp = MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id);
	            MUser[] users = MUser.getOfBPartner(ctx, bp.getC_BPartner_ID(), trxName);
	            assertTrue(users.length > 0, "Joe Block should have at least one user contact");
	            int bpUserId = users[0].getAD_User_ID();
	
	            MInvoice invoice = new MInvoice(ctx, 0, trxName);
	            invoice.setBPartner(bp);
	            invoice.setAD_User_ID(bpUserId);
	            invoice.setC_DocTypeTarget_ID(invDocType.getC_DocType_ID());
	            invoice.setDateInvoiced(today);
	            invoice.setDateAcct(today);
	            invoice.saveEx();
	
	            assertTrue(invoice.is_UsingTemporaryDocumentNo(), "Invoice should hold a temporary DocumentNo after save");
	            String invTempDocNo = invoice.get_TemporaryDocumentNo();
	            assertNotNull(invTempDocNo);
	
	            MInvoiceLine invLine = new MInvoiceLine(invoice);
	            invLine.setLine(10);
	            invLine.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.AZALEA_BUSH.id));
	            invLine.setQty(new BigDecimal("1"));
	            invLine.saveEx();
	
	            assertTrue(invoice.is_UsingTemporaryDocumentNo(), "Invoice should hold a temporary DocumentNo after create of new invoice line");
	            
	            ProcessInfo invInfo = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
	            assertFalse(invInfo.isError(), invInfo.getSummary());
	            assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());
	            assertTrue(invoice.is_UsingTemporaryDocumentNo(), "Invoice should still hold a temporary DocumentNo after workflow completion");
            
	            String invActualDocNo = invoice.getDocumentNo();
	            assertEquals("LAZY-5000", invActualDocNo);
	            assertFalse(invoice.is_UsingTemporaryDocumentNo(), "Invoice should no longer hold a temporary DocumentNo");
	
	            MUser bpUserAfter = new MUser(ctx, bpUserId, trxName);
	            assertNotNull(bpUserAfter.getLastResult(), "User LastResult should be set");
	            assertTrue(bpUserAfter.getLastResult().contains(invActualDocNo), "User LastResult should be updated with actual DocumentNo: " + bpUserAfter.getLastResult());
	            assertFalse(bpUserAfter.getLastResult().contains(invTempDocNo), "User LastResult should not contain temporary DocumentNo");
            }
        } finally {
        	rollback();
        	if (docType.get_ID() > 0)
        		docType.delete(true);
        	if (invDocType != null && invDocType.get_ID() > 0)
        		invDocType.delete(true);
        	if (seq.get_ID() > 0)
        		seq.delete(true);
        }
    }

    @Test
    public void testDeferredDocumentNoOnCommitAndRollback() {
        Properties ctx = Env.getCtx();

        MSequence seq = new MSequence(ctx, 0, null);
        seq.setName("Test Lazy Commit DocNo Sequence");
        seq.setPrefix("COMMIT-");
        seq.setStartNo(6000);
        seq.setCurrentNext(6000);
        seq.setIncrementNo(1);
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setIsAllowSequenceGaps(false);
        seq.saveEx();

        MDocType docType = new MDocType(ctx, 0, null);
        docType.setName("Test Lazy Commit SO DocType");
        docType.setPrintName("Test Lazy Commit SO");
        docType.setDocNoSequence_ID(seq.get_ID());
        docType.setIsActive(true);
        docType.setDocBaseType(MDocType.DOCBASETYPE_SalesOrder);
        docType.setDocSubTypeSO(MDocType.DOCSUBTYPESO_StandardOrder);
        docType.setGL_Category_ID();
        docType.setIsDocNoControlled(true);
        docType.setIsLazyGenerateDocNo(MDocType.ISLAZYGENERATEDOCNO_Yes);
        docType.saveEx();

        int committedOrderId = 0;
        Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

        try {
            // 1. Test rollback discards deferred DocumentNo without consuming sequence number
            Trx rollbackTrx = Trx.get(Trx.createTrxName("TestLazyRollback_"), true);
            MOrder rbOrder;
            try {
                rbOrder = new MOrder(ctx, 0, rollbackTrx.getTrxName());
                rbOrder.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
                rbOrder.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
                rbOrder.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
                rbOrder.setDocStatus(DocAction.STATUS_Drafted);
                rbOrder.setDocAction(DocAction.ACTION_Complete);
                rbOrder.setDateOrdered(today);
                rbOrder.setDatePromised(today);
                rbOrder.saveEx();

                assertTrue(rbOrder.is_UsingTemporaryDocumentNo(), "Order should hold a temporary DocumentNo before rollback");
                assertTrue(MSequence.isUsingTemporaryDocumentNo(rbOrder), "MSequence.isUsingTemporaryDocumentNo should return true");
                int nextBefore = DB.getSQLValueEx(null, "SELECT CurrentNext FROM AD_Sequence WHERE AD_Sequence_ID=?", seq.get_ID());
                assertEquals(6000, nextBefore, "Sequence should not be incremented while deferred");

                rollbackTrx.rollback();

                assertFalse(rbOrder.is_UsingTemporaryDocumentNo(), "Order must not hold temporary DocumentNo after rollback");
                assertNull(rbOrder.get_TemporaryDocumentNo(), "Temporary DocumentNo must be cleared after rollback");
                int nextAfterRollback = DB.getSQLValueEx(null, "SELECT CurrentNext FROM AD_Sequence WHERE AD_Sequence_ID=?", seq.get_ID());
                assertEquals(6000, nextAfterRollback, "Sequence must not be consumed when transaction rolls back");
            } finally {
                rollbackTrx.close();
            }

            // 2. Test commit triggers beforeCommit and persists actual sequence DocumentNo
            Trx commitTrx = Trx.get(Trx.createTrxName("TestLazyCommit_"), true);
            try {
                MOrder order = new MOrder(ctx, 0, commitTrx.getTrxName());
                order.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
                order.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
                order.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
                order.setDocStatus(DocAction.STATUS_Drafted);
                order.setDocAction(DocAction.ACTION_Complete);
                order.setDateOrdered(today);
                order.setDatePromised(today);
                order.saveEx();
                committedOrderId = order.getC_Order_ID();

                String tempDocNo = order.get_TemporaryDocumentNo();
                assertNotNull(tempDocNo, "Order should have a temporary DocumentNo before commit");
                int rawDbWait = DB.getSQLValueEx(null, "SELECT CurrentNext FROM AD_Sequence WHERE AD_Sequence_ID=?", seq.get_ID());
                assertEquals(6000, rawDbWait, "Sequence CurrentNext should still be 6000 before commit");

                assertTrue(commitTrx.commit(), "Transaction commit should succeed and run beforeCommit");

                assertFalse(order.is_UsingTemporaryDocumentNo(), "Order should no longer hold temporary DocumentNo after commit");
                assertEquals("COMMIT-6000", order.getDocumentNo(), "Order should have actual sequence DocumentNo after commit");
                String dbDocNo = DB.getSQLValueStringEx(null, "SELECT DocumentNo FROM C_Order WHERE C_Order_ID=?", committedOrderId);
                assertEquals("COMMIT-6000", dbDocNo, "Committed C_Order row should have actual sequence DocumentNo in DB");
                int nextAfterCommit = DB.getSQLValueEx(null, "SELECT CurrentNext FROM AD_Sequence WHERE AD_Sequence_ID=?", seq.get_ID());
                assertEquals(6001, nextAfterCommit, "Sequence CurrentNext should be incremented to 6001 after commit");
            } finally {
                commitTrx.close();
            }
        } finally {
            rollback();
            if (committedOrderId > 0)
                DB.executeUpdateEx("DELETE FROM C_Order WHERE C_Order_ID=?", new Object[] {committedOrderId}, null);
            if (docType.get_ID() > 0)
                docType.delete(true);
            if (seq.get_ID() > 0)
                seq.delete(true);
        }
    }

    @Test
    public void testDeferredDocumentNoAcrossMultiplePOInstances() {
        Properties ctx = Env.getCtx();
        String trxName = getTrxName();

        MSequence seq = new MSequence(ctx, 0, null);
        seq.setName("Test Lazy Multi PO Sequence");
        seq.setPrefix("MULTI-");
        seq.setStartNo(7000);
        seq.setCurrentNext(7000);
        seq.setIncrementNo(1);
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setIsAllowSequenceGaps(false);
        seq.saveEx();

        MDocType docType = new MDocType(ctx, 0, null);
        docType.setName("Test Lazy Multi PO SO DocType");
        docType.setPrintName("Test Lazy Multi PO SO");
        docType.setDocNoSequence_ID(seq.get_ID());
        docType.setIsActive(true);
        docType.setDocBaseType(MDocType.DOCBASETYPE_SalesOrder);
        docType.setDocSubTypeSO(MDocType.DOCSUBTYPESO_StandardOrder);
        docType.setGL_Category_ID();
        docType.setIsDocNoControlled(true);
        docType.setIsLazyGenerateDocNo(MDocType.ISLAZYGENERATEDOCNO_Yes);
        docType.saveEx();

        try {
            Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
            MOrder order1 = new MOrder(ctx, 0, trxName);
            order1.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
            order1.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
            order1.setDeliveryRule(MOrder.DELIVERYRULE_CompleteOrder);
            order1.setDocStatus(DocAction.STATUS_Drafted);
            order1.setDocAction(DocAction.ACTION_Complete);
            order1.setDateOrdered(today);
            order1.setDatePromised(today);
            order1.saveEx();

            String tempDocNo = order1.get_TemporaryDocumentNo();
            assertNotNull(tempDocNo);

            // Load second and third PO instances for the same record in the same transaction
            MOrder order2 = new MOrder(ctx, order1.getC_Order_ID(), trxName);
            MOrder order3 = new MOrder(ctx, order1.getC_Order_ID(), trxName);

            assertTrue(order2.is_UsingTemporaryDocumentNo(), "Second PO instance should recognize temporary DocumentNo");
            assertEquals(tempDocNo, order2.get_TemporaryDocumentNo(), "Second PO instance should return same temporary DocumentNo");

            AtomicReference<String> callbackTemp = new AtomicReference<>();
            AtomicReference<String> callbackActual = new AtomicReference<>();
            order2.addDeferredDocumentNoCallback((tmp, actual) -> {
                callbackTemp.set(tmp);
                callbackActual.set(actual);
            });

            // Trigger deferred generation from the second PO instance
            assertEquals("MULTI-7000", order2.getDocumentNo(), "Reading DocumentNo on second instance should trigger sequence generation");
            assertFalse(order2.is_UsingTemporaryDocumentNo(), "Second instance should no longer use temporary DocumentNo");
            assertFalse(order1.is_UsingTemporaryDocumentNo(), "Original instance should also be updated");
            assertEquals("MULTI-7000", order1.getDocumentNo(), "Original instance should return generated DocumentNo without incrementing again");
            assertEquals(tempDocNo, callbackTemp.get(), "Callback registered on second instance should receive temporary DocumentNo");
            assertEquals("MULTI-7000", callbackActual.get(), "Callback registered on second instance should receive actual DocumentNo");

            // Third instance had the temporary value loaded in memory before generation; reading it should fetch the updated DB value
            assertFalse(order3.is_UsingTemporaryDocumentNo(), "Third instance should see that temporary DocumentNo is no longer pending");
            assertEquals("MULTI-7000", order3.getDocumentNo(), "Third instance should resolve actual DocumentNo from DB");
        } finally {
            rollback();
            if (docType.get_ID() > 0)
                docType.delete(true);
            if (seq.get_ID() > 0)
                seq.delete(true);
        }
    }

    @Test
    public void testLazyGenerateDocNoConfigurationAndBypassRules() {
        Properties ctx = Env.getCtx();
        String trxName = getTrxName();

        MSequence seq = new MSequence(ctx, 0, null);
        seq.setName("Test Lazy Config Sequence");
        seq.setPrefix("CFG-");
        seq.setStartNo(8000);
        seq.setCurrentNext(8000);
        seq.setIncrementNo(1);
        seq.setIsActive(true);
        seq.setIsAutoSequence(true);
        seq.setIsTableID(false);
        seq.setIsAllowSequenceGaps(false);
        seq.saveEx();

        MDocType docType = new MDocType(ctx, 0, null);
        docType.setName("Test Lazy Config SO DocType");
        docType.setPrintName("Test Lazy Config SO");
        docType.setDocNoSequence_ID(seq.get_ID());
        docType.setDefiniteSequence_ID(seq.get_ID());
        docType.setIsActive(true);
        docType.setDocBaseType(MDocType.DOCBASETYPE_SalesOrder);
        docType.setDocSubTypeSO(MDocType.DOCSUBTYPESO_StandardOrder);
        docType.setGL_Category_ID();
        docType.setIsDocNoControlled(true);
        docType.setIsLazyGenerateDocNo(null);
        docType.saveEx();

        try (MockedStatic<MSysConfig> mockedSysConfig = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
            Timestamp today = TimeUtil.getDay(System.currentTimeMillis());

            // 1. IsLazyGenerateDocNo is null and SysConfig is false -> immediate generation
            mockedSysConfig.when(() -> MSysConfig.getBooleanValue(MSysConfig.LAZY_GENERATE_DOCUMENTNO_FROM_SEQUENCE, false, getAD_Client_ID()))
                    .thenReturn(false);
            assertFalse(docType.isLazyGenerateDocNo(), "Should be false when DocType setting is null and SysConfig is false");

            MOrder orderImmediate = new MOrder(ctx, 0, trxName);
            orderImmediate.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
            orderImmediate.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
            orderImmediate.setDateOrdered(today);
            orderImmediate.setDatePromised(today);
            orderImmediate.saveEx();
            assertFalse(orderImmediate.is_UsingTemporaryDocumentNo(), "Order should generate DocumentNo immediately when lazy is disabled");
            assertEquals("CFG-8000", orderImmediate.getDocumentNo());
            rollback();

            // 2. IsLazyGenerateDocNo is null and SysConfig is true -> lazy generation
            mockedSysConfig.when(() -> MSysConfig.getBooleanValue(MSysConfig.LAZY_GENERATE_DOCUMENTNO_FROM_SEQUENCE, false, getAD_Client_ID()))
                    .thenReturn(true);
            assertTrue(docType.isLazyGenerateDocNo(), "Should be true when DocType setting is null and SysConfig is true");

            MOrder orderFromSysConfig = new MOrder(ctx, 0, trxName);
            orderFromSysConfig.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
            orderFromSysConfig.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
            orderFromSysConfig.setDateOrdered(today);
            orderFromSysConfig.setDatePromised(today);
            orderFromSysConfig.saveEx();
            assertTrue(orderFromSysConfig.is_UsingTemporaryDocumentNo(), "Order should defer DocumentNo when SysConfig is true");
            assertEquals("CFG-8000", orderFromSysConfig.getDocumentNo());
            rollback();

            // 3. IsLazyGenerateDocNo = N overrides SysConfig = true -> immediate generation
            docType.setIsLazyGenerateDocNo(MDocType.ISLAZYGENERATEDOCNO_No);
            docType.saveEx();
            assertFalse(docType.isLazyGenerateDocNo(), "DocType IsLazyGenerateDocNo=N must override SysConfig=true");

            MOrder orderOverrideNo = new MOrder(ctx, 0, trxName);
            orderOverrideNo.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
            orderOverrideNo.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
            orderOverrideNo.setDateOrdered(today);
            orderOverrideNo.setDatePromised(today);
            orderOverrideNo.saveEx();
            assertFalse(orderOverrideNo.is_UsingTemporaryDocumentNo(), "Order should generate DocumentNo immediately when DocType overrides with N");
            assertEquals("CFG-8000", orderOverrideNo.getDocumentNo());
            rollback();

            // 4. Bypass when IsOverwriteSeqOnComplete = true even if IsLazyGenerateDocNo = Y
            docType.setIsLazyGenerateDocNo(MDocType.ISLAZYGENERATEDOCNO_Yes);
            docType.setIsOverwriteSeqOnComplete(true);
            docType.saveEx();

            MOrder orderOverwriteOnComplete = new MOrder(ctx, 0, trxName);
            orderOverwriteOnComplete.setBPartner(MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id));
            orderOverwriteOnComplete.setC_DocTypeTarget_ID(docType.getC_DocType_ID());
            orderOverwriteOnComplete.setDateOrdered(today);
            orderOverwriteOnComplete.setDatePromised(today);
            orderOverwriteOnComplete.saveEx();
            assertFalse(orderOverwriteOnComplete.is_UsingTemporaryDocumentNo(), "DocType with IsOverwriteSeqOnComplete must not defer initial DocumentNo");
            assertEquals("CFG-8000", orderOverwriteOnComplete.getDocumentNo());
            rollback();

            // 5. Table sequence (DocumentNo_<TableName>) deferral when LAZY_GENERATE_DOCUMENTNO_FROM_SEQUENCE = true
            docType.setIsOverwriteSeqOnComplete(false);
            docType.saveEx();
            MOrder dummyOrderForTableSeq = new MOrder(ctx, 0, trxName);
            String deferredTableDocNo = MSequence.getDocumentNo(getAD_Client_ID(), MOrder.Table_Name, trxName, dummyOrderForTableSeq, true);
            assertTrue(MSequence.isTemporaryDocumentNo(deferredTableDocNo), "Table sequence should return temporary DocumentNo when SysConfig is true and deferToPreCommit is true");
            assertTrue(dummyOrderForTableSeq.is_UsingTemporaryDocumentNo(), "PO should be marked as using temporary DocumentNo");
        } finally {
            rollback();
            if (docType.get_ID() > 0)
                docType.delete(true);
            if (seq.get_ID() > 0)
                seq.delete(true);
        }
    }

    @Test
    public void testDeferredDocumentNoOnPaymentAndAllocation() {
        Properties ctx = Env.getCtx();
        String trxName = getTrxName();

        MSequence paySeq = new MSequence(ctx, 0, null);
        paySeq.setName("Test Lazy Payment Sequence");
        paySeq.setPrefix("PAY-");
        paySeq.setStartNo(9000);
        paySeq.setCurrentNext(9000);
        paySeq.setIncrementNo(1);
        paySeq.setIsActive(true);
        paySeq.setIsAutoSequence(true);
        paySeq.setIsTableID(false);
        paySeq.setIsAllowSequenceGaps(false);
        paySeq.saveEx();

        MSequence allocSeq = new MSequence(ctx, 0, null);
        allocSeq.setName("Test Lazy Allocation Sequence");
        allocSeq.setPrefix("ALC-");
        allocSeq.setStartNo(3000);
        allocSeq.setCurrentNext(3000);
        allocSeq.setIncrementNo(1);
        allocSeq.setIsActive(true);
        allocSeq.setIsAutoSequence(true);
        allocSeq.setIsTableID(false);
        allocSeq.setIsAllowSequenceGaps(false);
        allocSeq.saveEx();

        MDocType payDocType = new MDocType(ctx, 0, null);
        payDocType.setName("Test Lazy ARR DocType");
        payDocType.setPrintName("Test Lazy ARR");
        payDocType.setDocNoSequence_ID(paySeq.get_ID());
        payDocType.setIsActive(true);
        payDocType.setDocBaseType(MDocType.DOCBASETYPE_ARReceipt);
        payDocType.setGL_Category_ID();
        payDocType.setIsDocNoControlled(true);
        payDocType.setIsLazyGenerateDocNo(MDocType.ISLAZYGENERATEDOCNO_Yes);
        payDocType.setIsSOTrx();
        payDocType.saveEx();

        MDocType allocDocType = new MDocType(ctx, 0, null);
        allocDocType.setName("Test Lazy CMA DocType");
        allocDocType.setPrintName("Test Lazy CMA");
        allocDocType.setDocNoSequence_ID(allocSeq.get_ID());
        allocDocType.setIsActive(true);
        allocDocType.setDocBaseType(MDocType.DOCBASETYPE_PaymentAllocation);
        allocDocType.setGL_Category_ID();
        allocDocType.setIsDocNoControlled(true);
        allocDocType.setIsLazyGenerateDocNo(MDocType.ISLAZYGENERATEDOCNO_Yes);
        allocDocType.saveEx();

        try (MockedStatic<MClient> mockedClient = Mockito.mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS);
             MockedStatic<MDocType> mockedDocType = Mockito.mockStatic(MDocType.class, Mockito.CALLS_REAL_METHODS)) {
            mockedClient.when(() -> MClient.isClientAccountingImmediate())
                    .thenReturn(false);
            mockedDocType.when(() -> MDocType.getDocType(MDocType.DOCBASETYPE_PaymentAllocation))
                    .thenReturn(allocDocType.getC_DocType_ID());

            Timestamp today = TimeUtil.getDay(System.currentTimeMillis());
            MBPartner bp = MBPartner.get(ctx, DictionaryIDs.C_BPartner.C_AND_W.id);

            // 1. Test MPayment with R_PnRef clears deferred DocumentNo
            MPayment refPayment = new MPayment(ctx, 0, trxName);
            refPayment.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
            refPayment.setC_DocType_ID(payDocType.getC_DocType_ID());
            refPayment.setIsReceipt(true);
            refPayment.setDateTrx(today);
            refPayment.setDateAcct(today);
            refPayment.setC_BPartner_ID(bp.getC_BPartner_ID());
            refPayment.setPayAmt(new BigDecimal("50"));
            refPayment.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
            refPayment.setTenderType(MPayment.TENDERTYPE_DirectDeposit);
            refPayment.saveEx();

            assertTrue(refPayment.is_UsingTemporaryDocumentNo(), "Payment should initially use temporary DocumentNo");
            refPayment.setR_PnRef("EXT-REF-001");
            refPayment.saveEx();
            assertFalse(refPayment.is_UsingTemporaryDocumentNo(), "Setting R_PnRef must clear deferred DocumentNo");
            assertEquals("EXT-REF-001", refPayment.getDocumentNo(), "DocumentNo should match R_PnRef without consuming sequence");

            // 2. Test MPayment allocation against MInvoice updates MAllocationHdr.Description and payment processMsg
            MInvoice invoice = new MInvoice(ctx, 0, trxName);
            invoice.setBPartner(bp);
            invoice.setC_DocTypeTarget_ID(DictionaryIDs.C_DocType.AR_INVOICE.id);
            invoice.setDateInvoiced(today);
            invoice.setDateAcct(today);
            invoice.saveEx();

            MInvoiceLine invLine = new MInvoiceLine(invoice);
            invLine.setLine(10);
            invLine.setProduct(MProduct.get(ctx, DictionaryIDs.M_Product.AZALEA_BUSH.id));
            invLine.setQty(new BigDecimal("1"));
            invLine.setPrice(new BigDecimal("100"));
            invLine.saveEx();

            ProcessInfo invInfo = MWorkflow.runDocumentActionWorkflow(invoice, DocAction.ACTION_Complete);
            assertFalse(invInfo.isError(), invInfo.getSummary());
            invoice.load(trxName);
            assertEquals(DocAction.STATUS_Completed, invoice.getDocStatus());

            MPayment payment = new MPayment(ctx, 0, trxName);
            payment.setC_BankAccount_ID(DictionaryIDs.C_BankAccount.ACCOUNT_1234.id);
            payment.setC_DocType_ID(payDocType.getC_DocType_ID());
            payment.setIsReceipt(true);
            payment.setDateTrx(today);
            payment.setDateAcct(today);
            payment.setC_BPartner_ID(bp.getC_BPartner_ID());
            payment.setC_Invoice_ID(invoice.getC_Invoice_ID());
            payment.setPayAmt(invoice.getGrandTotal());
            payment.setC_Currency_ID(DictionaryIDs.C_Currency.USD.id);
            payment.setTenderType(MPayment.TENDERTYPE_DirectDeposit);
            payment.saveEx();

            assertTrue(payment.is_UsingTemporaryDocumentNo(), "Payment should hold a temporary DocumentNo after save");
            String payTempDocNo = payment.get_TemporaryDocumentNo();
            assertNotNull(payTempDocNo);

            ProcessInfo payInfo = MWorkflow.runDocumentActionWorkflow(payment, DocAction.ACTION_Complete);
            assertFalse(payInfo.isError(), payInfo.getSummary());
            assertEquals(DocAction.STATUS_Completed, payment.getDocStatus());
            assertTrue(payment.is_UsingTemporaryDocumentNo(), "Payment should still hold temporary DocumentNo after workflow completion");

            MAllocationHdr alloc = payment.getJustCreatedAllocInv();
            assertNotNull(alloc, "Allocation header should be created on payment completion");
            assertTrue(alloc.is_UsingTemporaryDocumentNo(), "Allocation header should also hold a temporary DocumentNo");
            String allocTempDocNo = alloc.get_TemporaryDocumentNo();
            assertNotNull(allocTempDocNo);
            assertTrue(alloc.getDescription().contains(payTempDocNo), "Allocation description should initially contain payment temporary DocumentNo");
            assertTrue(payment.getProcessMsg().contains(allocTempDocNo), "Payment processMsg should initially contain allocation temporary DocumentNo");

            // Trigger deferred generation on payment and allocation
            String actualPayDocNo = payment.getDocumentNo();
            assertEquals("PAY-9000", actualPayDocNo);
            String actualAllocDocNo = alloc.getDocumentNo();
            assertEquals("ALC-3000", actualAllocDocNo);

            assertTrue(alloc.getDescription().contains(actualPayDocNo), "Allocation description in memory should be updated with actual payment DocumentNo: " + alloc.getDescription());
            assertFalse(alloc.getDescription().contains(payTempDocNo), "Allocation description should no longer contain temporary DocumentNo");
            String dbAllocDesc = DB.getSQLValueStringEx(trxName, "SELECT Description FROM C_AllocationHdr WHERE C_AllocationHdr_ID=?", alloc.getC_AllocationHdr_ID());
            assertTrue(dbAllocDesc.contains(actualPayDocNo), "Allocation description in DB should be updated with actual payment DocumentNo: " + dbAllocDesc);

            assertTrue(payment.getProcessMsg().contains(actualAllocDocNo), "Payment processMsg should be updated with actual allocation DocumentNo: " + payment.getProcessMsg());
            assertFalse(payment.getProcessMsg().contains(allocTempDocNo), "Payment processMsg should no longer contain temporary allocation DocumentNo");
        } finally {
            rollback();
            if (payDocType.get_ID() > 0)
                payDocType.delete(true);
            if (allocDocType.get_ID() > 0)
                allocDocType.delete(true);
            if (paySeq.get_ID() > 0)
                paySeq.delete(true);
            if (allocSeq.get_ID() > 0)
                allocSeq.delete(true);
        }
    }

    @Test
    public void testDeferredDocumentNoOnInOutReservationLog() {
        Properties ctx = Env.getCtx();
        String trxName = getTrxName();

        MSequence ioSeq = new MSequence(ctx, 0, null);
        ioSeq.setName("Test Lazy InOut Sequence");
        ioSeq.setPrefix("MMR-");
        ioSeq.setStartNo(4000);
        ioSeq.setCurrentNext(4000);
        ioSeq.setIncrementNo(1);
        ioSeq.setIsActive(true);
        ioSeq.setIsAutoSequence(true);
        ioSeq.setIsTableID(false);
        ioSeq.setIsAllowSequenceGaps(false);
        ioSeq.saveEx();

        MDocType receiptDocType = new MDocType(ctx, 0, null);
        receiptDocType.setName("Test Lazy MM Receipt DocType");
        receiptDocType.setPrintName("Test Lazy MM Receipt");
        receiptDocType.setDocNoSequence_ID(ioSeq.get_ID());
        receiptDocType.setIsActive(true);
        receiptDocType.setDocBaseType(MDocType.DOCBASETYPE_MaterialReceipt);
        receiptDocType.setGL_Category_ID();
        receiptDocType.setIsDocNoControlled(true);
        receiptDocType.setIsLazyGenerateDocNo(MDocType.ISLAZYGENERATEDOCNO_Yes);
        receiptDocType.saveEx();

        try (MockedStatic<MClient> mockedClient = Mockito.mockStatic(MClient.class, Mockito.CALLS_REAL_METHODS)) {
            mockedClient.when(() -> MClient.isClientAccountingImmediate())
                    .thenReturn(false);

            MBPartner bpartner = MBPartner.get(ctx, DictionaryIDs.C_BPartner.TREE_FARM.id);
            MProduct product = MProduct.get(ctx, DictionaryIDs.M_Product.AZALEA_BUSH.id);

            MOrder po = new MOrder(ctx, 0, trxName);
            po.setBPartner(bpartner);
            po.setIsSOTrx(false);
            po.setC_DocTypeTarget_ID();
            po.setDocStatus(DocAction.STATUS_Drafted);
            po.setDocAction(DocAction.ACTION_Complete);
            po.saveEx();

            MOrderLine poLine = new MOrderLine(po);
            poLine.setLine(10);
            poLine.setProduct(product);
            poLine.setQty(BigDecimal.ONE);
            poLine.saveEx();

            ProcessInfo poInfo = MWorkflow.runDocumentActionWorkflow(po, DocAction.ACTION_Complete);
            assertFalse(poInfo.isError(), poInfo.getSummary());

            MInOut receipt = new MInOut(po, receiptDocType.getC_DocType_ID(), po.getDateOrdered());
            receipt.saveEx();

            assertTrue(receipt.is_UsingTemporaryDocumentNo(), "Receipt should hold a temporary DocumentNo after save");
            String tempReceiptDocNo = receipt.get_TemporaryDocumentNo();
            assertNotNull(tempReceiptDocNo);

            MWarehouse wh = MWarehouse.get(ctx, receipt.getM_Warehouse_ID());
            int locatorId = wh.getDefaultLocator().getM_Locator_ID();
            MInOutLine receiptLine = new MInOutLine(receipt);
            receiptLine.setC_OrderLine_ID(poLine.getC_OrderLine_ID());
            receiptLine.setLine(10);
            receiptLine.setProduct(product);
            receiptLine.setQty(BigDecimal.ONE);
            receiptLine.setM_Locator_ID(locatorId);
            receiptLine.saveEx();

            ProcessInfo receiptInfo = MWorkflow.runDocumentActionWorkflow(receipt, DocAction.ACTION_Complete);
            assertFalse(receiptInfo.isError(), receiptInfo.getSummary());
            assertEquals(DocAction.STATUS_Completed, receipt.getDocStatus());
            assertTrue(receipt.is_UsingTemporaryDocumentNo(), "Receipt should still hold a temporary DocumentNo after completion");

            MStorageReservationLog logBefore = new Query(ctx, MStorageReservationLog.Table_Name, "AD_Table_ID=? AND Record_ID=?", trxName)
                    .setParameters(MInOutLine.Table_ID, receiptLine.getM_InOutLine_ID())
                    .first();
            assertNotNull(logBefore, "MStorageReservationLog should exist for receipt line");
            assertEquals(tempReceiptDocNo, logBefore.getDocumentNo(), "MStorageReservationLog should initially hold temporary DocumentNo");

            String actualReceiptDocNo = receipt.getDocumentNo();
            assertEquals("MMR-4000", actualReceiptDocNo);
            assertFalse(receipt.is_UsingTemporaryDocumentNo(), "Receipt should no longer hold a temporary DocumentNo");

            MStorageReservationLog logAfter = new Query(ctx, MStorageReservationLog.Table_Name, "AD_Table_ID=? AND Record_ID=?", trxName)
                    .setParameters(MInOutLine.Table_ID, receiptLine.getM_InOutLine_ID())
                    .first();
            assertNotNull(logAfter, "MStorageReservationLog should exist for receipt line");
            assertEquals(actualReceiptDocNo, logAfter.getDocumentNo(), "MStorageReservationLog for receipt line should be updated with actual DocumentNo");
        } finally {
            rollback();
            if (receiptDocType.get_ID() > 0)
                receiptDocType.delete(true);
            if (ioSeq.get_ID() > 0)
                ioSeq.delete(true);
        }
    }
}
