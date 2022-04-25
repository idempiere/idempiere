/**********************************************************************
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
* - Deepak Pansheriya - Logilite                                      *
**********************************************************************/
package org.idempiere.test.base;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.Arrays;

import org.compiere.model.MDocumentStatus;
import org.compiere.model.MDocumentStatusAccess;
import org.compiere.model.MEntityType;
import org.compiere.model.MInvoice;
import org.compiere.model.MOrder;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
/**
 * Unit test cases for document status indicator
 * @author Deepak Pansheriya
 *
 */
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
	private static final int WINDOW_ID_NOTICE = 193;
	private static final int WINDOW_ID_REQUEST = 201;
	private static final int WINDOW_ID_WF_ACTIVITIES = 298;

	/**
	 * https://idempiere.atlassian.net/browse/IDEMPIERE-4836
	 * Unit testing for Document access test as per DocumentStatusAccess
	 */
	@Test
	public void testDocumentStatusVisibility() {

		/* Document Status with specific role and user access */
		MDocumentStatus invoiceDS = new MDocumentStatus(Env.getCtx(), 0, getTrxName());
		invoiceDS.setName("Invoice Document Status Unit Test");
		invoiceDS.setEntityType(MEntityType.ENTITYTYPE_Dictionary);
		invoiceDS.setAD_Table_ID(MInvoice.Table_ID);
		invoiceDS.setAD_Window_ID(WINDOW_ID_INVOICE_CUSTOMER);
		invoiceDS.setSeqNo(10);
		invoiceDS.saveEx();

		MDocumentStatusAccess invoiceDSAccess = new MDocumentStatusAccess(Env.getCtx(),0, getTrxName());
		invoiceDSAccess.setPA_DocumentStatus_ID(invoiceDS.get_ID());
		invoiceDSAccess.setAD_User_ID(USER_GARDENADMIN);
		invoiceDSAccess.setAD_Role_ID(ROLE_GARDENWORLDADMIN);
		invoiceDSAccess.saveEx();


		/* Document Status with no user or role access, visible to all */
		MDocumentStatus noticeDS = new MDocumentStatus(Env.getCtx(), 0,	getTrxName());
		noticeDS.setName("Notice Document Status Unit Test");
		noticeDS.setEntityType(MEntityType.ENTITYTYPE_Dictionary);
		noticeDS.setAD_Table_ID(MOrder.Table_ID);
		noticeDS.setAD_Window_ID(WINDOW_ID_NOTICE);
		noticeDS.setSeqNo(20);
		noticeDS.saveEx();

		/* Document Status with specific user access */
		MDocumentStatus requestDS = new MDocumentStatus(Env.getCtx(), 0, getTrxName());
		requestDS.setName("Request Document Status Unit Test");
		requestDS.setEntityType(MEntityType.ENTITYTYPE_Dictionary);
		requestDS.setAD_Table_ID(MInvoice.Table_ID);
		requestDS.setAD_Window_ID(WINDOW_ID_REQUEST);
		requestDS.setSeqNo(30);
		requestDS.saveEx();

		MDocumentStatusAccess requestDSAccess = new MDocumentStatusAccess(Env.getCtx(),0, getTrxName());
		requestDSAccess.setPA_DocumentStatus_ID(requestDS.get_ID());
		requestDSAccess.setAD_Role_ID( ROLE_GARDENWORLDUSER);
		requestDSAccess.saveEx();

		/* Document Status with specific role access */
		MDocumentStatus WorkflowActivitiesDS = new MDocumentStatus(Env.getCtx(), 0, getTrxName());
		WorkflowActivitiesDS.setName("Workflow Activities Document Status Unit Test");
		WorkflowActivitiesDS.setEntityType(MEntityType.ENTITYTYPE_Dictionary);
		WorkflowActivitiesDS.setAD_Table_ID(MInvoice.Table_ID);
		WorkflowActivitiesDS.setAD_Window_ID(WINDOW_ID_WF_ACTIVITIES);
		WorkflowActivitiesDS.setSeqNo(40);
		WorkflowActivitiesDS.saveEx();

		MDocumentStatusAccess WorkflowActivitiesDSAccess = new MDocumentStatusAccess(Env.getCtx(),0, getTrxName());
		WorkflowActivitiesDSAccess.setPA_DocumentStatus_ID(WorkflowActivitiesDS.get_ID());
		WorkflowActivitiesDSAccess.setAD_User_ID(USER_GARDENADMIN);
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

	}
}
