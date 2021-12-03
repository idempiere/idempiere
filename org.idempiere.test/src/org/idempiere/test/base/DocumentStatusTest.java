package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Arrays;

import org.compiere.model.MDocumentStatus;
import org.compiere.model.MEntityType;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;

public class DocumentStatusTest extends AbstractTestCase {

	public DocumentStatusTest() {
	}

	private static final int USER_GARDENADMIN = 101;
	private static final int USER_GARDENUSER = 102;
	private static final int USER_SUPERUSER = 100;

	private static final int ROLE_GARDENWORLDADMIN = 102;
	private static final int ROLE_GARDENWORLDUSER = 103;
	private static final int ROLE_GARDENWORLD_ADMIN_NOT_ADVANCED = 200001;

	private static final int WINDOW_ID_INVOICE_CUSTOMER = 167;
	private static final int WINDOW_ID_SALES_ORDER = 143;
	private static final String TABLENAME_PA_DOCUMENTSTATUSACCESS = "PA_DOCUMENTSTATUSACCESS";

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4836
	 */
	@Test
	public void testDocumentStatusVisibility() {
		int documentSeqID = DB.getNextID(Env.getAD_Client_ID(Env.getCtx()), MDocumentStatus.Table_Name, getTrxName());

		/* Document Status with specific role and user access */
		MDocumentStatus invoiceDS = (MDocumentStatus) MTable.get(Env.getCtx(), MDocumentStatus.Table_ID).getPO(0,
				getTrxName());
		invoiceDS.setName("Invoice Document Status Unit Test");
		invoiceDS.setEntityType(MEntityType.ENTITYTYPE_Dictionary);
		invoiceDS.setAD_Table_ID(MInvoice.Table_ID);
		invoiceDS.setAD_Window_ID(WINDOW_ID_INVOICE_CUSTOMER);
		invoiceDS.setSeqNo(documentSeqID);
		invoiceDS.saveEx();

		MTable table = MTable.get(Env.getCtx(), TABLENAME_PA_DOCUMENTSTATUSACCESS);
		PO invoiceDSAccess = table.getPO(0, getTrxName());
		invoiceDSAccess.set_ValueOfColumn("PA_DocumentStatus_ID", invoiceDS.get_ID());
		invoiceDSAccess.set_ValueOfColumn("AD_User_ID", USER_GARDENADMIN);
		invoiceDSAccess.set_ValueOfColumn("AD_Role_ID", ROLE_GARDENWORLDADMIN);
		invoiceDSAccess.saveEx();


		/* Document Status with no user or role access, visible to all */
		MDocumentStatus noticeDS = (MDocumentStatus) MTable.get(Env.getCtx(), MDocumentStatus.Table_ID).getPO(0,
				getTrxName());
		noticeDS.setName("order Document Status Unit Test");
		noticeDS.setEntityType(MEntityType.ENTITYTYPE_Dictionary);
		noticeDS.setAD_Table_ID(MOrder.Table_ID);
		noticeDS.setAD_Window_ID(WINDOW_ID_SALES_ORDER);
		noticeDS.setSeqNo(++documentSeqID);
		noticeDS.saveEx();

		/* Document Status with specific user access */
		MDocumentStatus requestDS = (MDocumentStatus) MTable.get(Env.getCtx(), MDocumentStatus.Table_ID).getPO(0,
				getTrxName());
		requestDS.setName("Notice Document Status Unit Test");
		requestDS.setEntityType(MEntityType.ENTITYTYPE_Dictionary);
		requestDS.setAD_Table_ID(MInvoice.Table_ID);
		requestDS.setAD_Window_ID(WINDOW_ID_INVOICE_CUSTOMER);
		requestDS.setSeqNo(documentSeqID);
		requestDS.saveEx();

		PO requestDSAccess = table.getPO(0, getTrxName());
		requestDSAccess.set_ValueOfColumn("PA_DocumentStatus_ID", requestDS.get_ID());
		requestDSAccess.set_ValueOfColumn("AD_Role_ID", ROLE_GARDENWORLDUSER);
		requestDSAccess.saveEx();

		/* Document Status with specific role access */
		MDocumentStatus WorkflowActivitiesDS = (MDocumentStatus) MTable.get(Env.getCtx(), MDocumentStatus.Table_ID)
				.getPO(0, getTrxName());
		WorkflowActivitiesDS.setName("Workflow Activities Document Status Unit Test");
		WorkflowActivitiesDS.setEntityType(MEntityType.ENTITYTYPE_Dictionary);
		WorkflowActivitiesDS.setAD_Table_ID(MInvoice.Table_ID);
		WorkflowActivitiesDS.setAD_Window_ID(WINDOW_ID_INVOICE_CUSTOMER);
		WorkflowActivitiesDS.setSeqNo(documentSeqID);
		WorkflowActivitiesDS.saveEx();

		PO WorkflowActivitiesDSAccess = table.getPO(0, getTrxName());
		WorkflowActivitiesDSAccess.set_ValueOfColumn("PA_DocumentStatus_ID", WorkflowActivitiesDS.get_ID());
		WorkflowActivitiesDSAccess.set_ValueOfColumn("AD_User_ID", USER_GARDENADMIN);
		WorkflowActivitiesDSAccess.saveEx();

		// check document status accessibility with user- GardenAdmin and role- GardenWorld Admin
		MDocumentStatus[] documentStatusIndicators = MDocumentStatus.getDocumentStatusIndicators(Env.getCtx(),
				USER_GARDENADMIN, ROLE_GARDENWORLDADMIN, getTrxName());
		assertTrue(Arrays.asList(documentStatusIndicators).contains(invoiceDS), "Either User or Role Assignment matching");
		assertTrue(Arrays.asList(documentStatusIndicators).contains(noticeDS), "No permission assigned, should visible to every one");
		assertFalse(Arrays.asList(documentStatusIndicators).contains(requestDS),
				"When Role not matching, Should not Visible");
		assertTrue(Arrays.asList(documentStatusIndicators).contains(WorkflowActivitiesDS),
				"User is assigned, Should Visible");

		// check document status accessibility with user- GardenAdmin and role- GardenWorld User
		documentStatusIndicators = MDocumentStatus.getDocumentStatusIndicators(Env.getCtx(), USER_GARDENADMIN,
				ROLE_GARDENWORLDUSER, getTrxName());
		assertFalse(Arrays.asList(documentStatusIndicators).contains(invoiceDS),
				"User Assignment Match but role do not");
		assertTrue(Arrays.asList(documentStatusIndicators).contains(noticeDS), "No permission assigned, should visible to every one");
		assertTrue(Arrays.asList(documentStatusIndicators).contains(requestDS), "When Role matching, Should  Visible");
		assertTrue(Arrays.asList(documentStatusIndicators).contains(WorkflowActivitiesDS),
				"User is assigned, Should Visible");

		// check document status accessibility with user- GardenUser and role- GardenWorld User
		documentStatusIndicators = MDocumentStatus.getDocumentStatusIndicators(Env.getCtx(), USER_GARDENUSER,
				ROLE_GARDENWORLDUSER, getTrxName());
		assertFalse(Arrays.asList(documentStatusIndicators).contains(invoiceDS),
				"Invoice Document Status Not Visible For User Garden Admin and Role GardenWorld User");
		assertTrue(Arrays.asList(documentStatusIndicators).contains(noticeDS), "No permission assigned, should visible to every one");
		assertTrue(Arrays.asList(documentStatusIndicators).contains(requestDS), "When Role not matching, Should not Visible");
		assertFalse(Arrays.asList(documentStatusIndicators).contains(WorkflowActivitiesDS),
				"User is assigned, Should not Visible");

		// check document status accessibility with user- SuperUser and role- GardenWorld Admin Not Advanced
		documentStatusIndicators = MDocumentStatus.getDocumentStatusIndicators(Env.getCtx(), USER_SUPERUSER,
				ROLE_GARDENWORLD_ADMIN_NOT_ADVANCED, getTrxName());
		assertFalse(Arrays.asList(documentStatusIndicators).contains(invoiceDS),
				"Niether User or Role Assignment match, Should not visible");
		assertTrue(Arrays.asList(documentStatusIndicators).contains(noticeDS), "No permission assigned, should visible to every one");
		assertFalse(Arrays.asList(documentStatusIndicators).contains(requestDS),
				"Role assignment not matching, Should not visible");
		assertFalse(Arrays.asList(documentStatusIndicators).contains(WorkflowActivitiesDS),
				"User assignment not visible, Should not Visible");

		rollback();
	}
}
