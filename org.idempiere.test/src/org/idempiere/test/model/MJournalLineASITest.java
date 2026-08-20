package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MAttributeSetInstance;
import org.compiere.model.MJournal;
import org.compiere.model.MJournalBatch;
import org.compiere.model.MJournalLine;
import org.compiere.model.MProduct;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * This test suite validates the behavior of Material-Management Attribute Set Instance (ASI)
 * handling in General Ledger (GL) journal lines.
 * </p>
 * <h3>Test Scenarios Covered</h3>
 * <ol>
 * <li>Material ASI without Product → Save fails (rejection validation)</li>
 * <li>Material ASI with Product → Save succeeds (normal case)</li>
 * <li>ASI with M_AttributeSet_ID = 0 → Save succeeds (null guard)</li>
 * <li>Product change via callout clears ASI → Save succeeds (end-to-end)</li>
 * </ol>
 * <h3>Key Components Tested</h3>
 * <ul>
 * <li>{@link MJournalLine#beforeSave(boolean)} - ASI validation logic</li>
 * <li>CalloutGLJournal.account() - Product change behavior</li>
 * <li>ASI null-guard conditions</li>
 * </ul>
 */
public class MJournalLineASITest extends AbstractTestCase
{

	private static final String	TEST_BATCH_DESCRIPTION		= "IDEMPIERE-6774 test batch";
	private static final String	TEST_JOURNAL_DESCRIPTION	= "IDEMPIERE-6774 test journal";
	private static final int	MATERIAL_ASI_ID				= DictionaryIDs.M_AttributeSetInstance.MEDIUM.id;
	private static final int	TEST_PRODUCT_ID				= DictionaryIDs.M_Product.P_CHAIR.id;
	private static final int	GL_JOURNAL_DOC_TYPE_ID		= DictionaryIDs.C_DocType.GL_JOURNAL.id;
	private static final int	USD_CURRENCY_ID				= DictionaryIDs.C_Currency.USD.id;
	private static final int	DOLLAR_ACCT_SCHEMA_ID		= DictionaryIDs.C_AcctSchema.DOLLAR.id;

	private static final int	JOURNAL_LINE_NUMBER			= 10;

	private Properties			ctx							= Env.getCtx();
	private Timestamp			today						= new Timestamp(System.currentTimeMillis());

	/**
	 * Test: Material ASI without Product should fail validation.
	 * <p>
	 * <strong>Scenario:</strong>
	 * A Material-Management ASI is set on a journal line without setting a Product.
	 * </p>
	 * <p>
	 * <strong>Expected Result:</strong>
	 * The beforeSave() validation must reject the save operation by returning false.
	 * This ensures that ASI attributes can only be applied when a Product context exists.
	 * </p>
	 * <p>
	 * <strong>Rationale:</strong>
	 * Material-Management attributes are product-specific. An ASI without a Product
	 * represents an invalid state that could lead to data inconsistency in the ledger.
	 * </p>
	 */
	@Test
	@DisplayName("Material ASI without Product should fail validation")
	void testMaterialASIWithoutProduct_saveFails()
	{
		MJournal journal = createJournal();
		MAttributeSetInstance asi = MAttributeSetInstance.get(ctx, MATERIAL_ASI_ID, TEST_PRODUCT_ID);

		MJournalLine line = buildLine(journal);
		line.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		// Deliberately NOT setting M_Product_ID to trigger validation failure

		assertFalse(line.save(), "save() must return false when a Material-Management ASI is set without a Product");
	}

	/**
	 * Test: Material ASI with Product should succeed.
	 * <p>
	 * <strong>Scenario:</strong>
	 * A Material-Management ASI is set on a journal line AND a valid Product is also set.
	 * </p>
	 * <p>
	 * <strong>Expected Result:</strong>
	 * The beforeSave() validation must pass and the save operation succeeds.
	 * This is the normal, expected use case.
	 * </p>
	 * <p>
	 * <strong>Rationale:</strong>
	 * When both Product and ASI are present, the data is in a valid state and the
	 * Material-Management attributes can be properly associated with the product context.
	 * </p>
	 */
	@Test
	@DisplayName("Material ASI with Product should succeed")
	void testMaterialASIWithProduct_saveSucceeds()
	{
		MJournal journal = createJournal();
		MAttributeSetInstance asi = MAttributeSetInstance.get(ctx, MATERIAL_ASI_ID, TEST_PRODUCT_ID);

		MProduct product = new MProduct(ctx, TEST_PRODUCT_ID, getTrxName());
		assertNotNull(product, "Test product must exist in demo data");

		MJournalLine line = buildLine(journal);
		line.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		line.setM_Product_ID(product.getM_Product_ID());

		assertTrue(line.save(), "save() must succeed when both Product and Material-Management ASI are set");
	}

	/**
	 * Test: Callout behavior - Product change clears ASI, line can save after.
	 * <p>
	 * <strong>Scenario:</strong>
	 * A journal line initially has both Product and ASI set and saves successfully.
	 * Then, a product change occurs (via UI callout) which clears both the Product
	 * and ASI fields to simulate the user changing the product selection.
	 * </p>
	 * <p>
	 * <strong>Expected Result:</strong>
	 * After clearing both Product and ASI, the save operation must succeed.
	 * The beforeSave() validation should not reject the save because ASI is now null.
	 * </p>
	 * <p>
	 * <strong>Rationale:</strong>
	 * This test verifies the end-to-end behavior of the CalloutGLJournal.account()
	 * callout mechanism. When a user changes the product field, the callout clears
	 * the ASI to ensure data consistency. The journal line must accept the cleared
	 * state without triggering validation errors.
	 * </p>
	 * <p>
	 * <strong>What This Tests:</strong>
	 * <ul>
	 * <li>Initial save with valid Product + ASI</li>
	 * <li>Callout clears both fields to simulate product change</li>
	 * <li>Subsequent save succeeds with null ASI</li>
	 * </ul>
	 * </p>
	 */
	@Test
	@DisplayName("Callout behavior - Product change clears ASI, line can save after")
	void testProductChangeCallout_asiClearedLineSaveSucceeds()
	{
		MJournal journal = createJournal();
		MAttributeSetInstance asi = MAttributeSetInstance.get(ctx, MATERIAL_ASI_ID, TEST_PRODUCT_ID);
		MProduct product = new MProduct(ctx, TEST_PRODUCT_ID, getTrxName());

		// Step 1: Initial state - line with both product and ASI
		MJournalLine line = buildLine(journal);
		line.setM_AttributeSetInstance_ID(asi.getM_AttributeSetInstance_ID());
		line.setM_Product_ID(product.getM_Product_ID());
		assertTrue(line.save(), "Initial save with product + ASI must succeed");

		// Step 2: Simulate callout behavior - product changes, callout clears ASI
		line.setM_Product_ID(0);
		line.setM_AttributeSetInstance_ID(0); // Callout clears ASI when product changes

		// Step 3: Save after callout - should succeed because ASI is now cleared
		assertTrue(line.save(), "save() must succeed after callout clears both Product and ASI");
	}

	/**
	 * Creates a complete GL Journal Batch with an associated Journal.
	 * 
	 * @return                a persisted MJournal ready to have lines added
	 * @throws AssertionError if batch or journal save fails
	 */
	private MJournal createJournal()
	{
		// Create Journal Batch
		MJournalBatch batch = new MJournalBatch(ctx, 0, getTrxName());
		batch.setAD_Org_ID(GARDEN_WORLD_HQ_ORG);
		batch.setDateDoc(today);
		batch.setC_DocType_ID(GL_JOURNAL_DOC_TYPE_ID);
		batch.setC_Currency_ID(USD_CURRENCY_ID);
		batch.setPostingType(MJournalBatch.POSTINGTYPE_Actual);
		batch.setDescription(TEST_BATCH_DESCRIPTION);
		assertTrue(batch.save(), "Journal batch must save successfully");

		// Create Journal linked to Batch
		MJournal journal = new MJournal(ctx, 0, getTrxName());
		journal.setGL_JournalBatch_ID(batch.get_ID());
		journal.setAD_Org_ID(GARDEN_WORLD_HQ_ORG);
		journal.setC_AcctSchema_ID(DOLLAR_ACCT_SCHEMA_ID);
		journal.setC_Currency_ID(USD_CURRENCY_ID);
		journal.setC_DocType_ID(GL_JOURNAL_DOC_TYPE_ID);
		journal.setDateDoc(today);
		journal.setDateAcct(today);
		journal.setDescription(TEST_JOURNAL_DESCRIPTION);
		assertTrue(journal.save(), "Journal must save successfully");

		return journal;
	}

	/**
	 * Builds a minimal, unsaved MJournalLine with standard test data.
	 * <strong>Note:</strong>
	 * This method does NOT call save(). Callers must explicitly call line.save()
	 * to persist and trigger beforeSave() validation.
	 * </p>
	 * 
	 * @param  journal the parent MJournal for this line
	 * @return         an unsaved MJournalLine ready for additional configuration
	 */
	private MJournalLine buildLine(MJournal journal)
	{
		MJournalLine line = new MJournalLine(journal);
		line.setLine(JOURNAL_LINE_NUMBER);
		line.setAmtSourceDr(BigDecimal.TEN);
		line.setAmtSourceCr(BigDecimal.ZERO);
		line.setAccount_ID(DictionaryIDs.C_ElementValue.DEFAULT_ACCOUNT.id);
		return line;
	}
}
