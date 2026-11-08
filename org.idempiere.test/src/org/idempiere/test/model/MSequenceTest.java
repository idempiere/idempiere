package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Timestamp;
import java.util.Properties;
import java.util.UUID;

import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MOrder;
import org.compiere.model.MSequence;
import org.compiere.process.DocAction;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Tests for {@link org.compiere.model.MSequence} class.
 * Testing document number generation using AD_Sequence:
 * context variable keys feature (/K flag), UUID sequences,
 * sequences allowing gaps and decimal patterns.
 */
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
}
