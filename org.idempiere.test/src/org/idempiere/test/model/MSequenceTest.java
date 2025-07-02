package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MBPartner;
import org.compiere.model.MDocType;
import org.compiere.model.MOrder;
import org.compiere.model.MSequence;
import org.compiere.process.DocAction;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Tests for {@link org.compiere.model.MSequence} class.
 * Specifically testing document number generation using AD_Sequence
 * with new context variable keys feature (/K flag).
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
}
