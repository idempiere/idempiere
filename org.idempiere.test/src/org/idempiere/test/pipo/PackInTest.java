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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/
package org.idempiere.test.pipo;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;

import org.adempiere.pipo2.PackIn;
import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentEntry;
import org.compiere.model.MPackageImp;
import org.compiere.model.MSysConfig;
import org.compiere.model.X_AD_Package_Imp;
import org.compiere.model.X_AD_Package_Imp_Proc;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Verify that a failed pack in sets the PK_Status of AD_Package_Imp (and AD_Package_Imp_Inst)
 * to Import Failed instead of leaving it in Installing, and that the log (with the unresolved
 * elements list on failures) is attached to the AD_Package_Imp record, also on success.
 */
public class PackInTest extends AbstractTestCase {

	@Test
	public void testUnresolvedElements() throws Exception {
		Path file = createPackageFile(
				"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
				+ "<idempiere Name=\"zzzTestPackInUnresolved\" Version=\"1.0.0\" idempiereVersion=\"\" DataBaseVersion=\"\""
				+ " Description=\"Test package with unresolved elements\" Author=\"PackInTest\" AuthorEmail=\"test@example.com\""
				+ " CreatedDate=\"2026-04-13 15:51:18.0\" UpdatedDate=\"2026-04-29 14:51:32.596\" PackOutVersion=\"100\" UpdateDictionary=\"false\""
				+ " Client=\"11-GardenWorld-GardenWorld\" AD_Client_UU=\"3268b9a8-10d8-466d-96e5-aa01166408fa\">\n"
				+ "  <AD_Process>\n"
				+ "    <EntityType>U</EntityType>\n"
				+ "    <Name>zzzTestPackInUnresolved</Name>\n"
				+ "    <Value>zzzTestPackInUnresolved</Value>\n"
				+ "    <AD_Workflow_ID reference=\"uuid\" reference-key=\"AD_Workflow\">00000000-0000-0000-0000-00000000abcd</AD_Workflow_ID>\n"
				+ "  </AD_Process>\n"
				+ "</idempiere>\n");

		PackIn packIn = newPackIn(file, "zzzTestPackInUnresolved");
		try {
			try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
				stubNotifierSettings(mocked);

				// the AD_Workflow_ID reference does not exist, so the AD_Process element stays unresolved
				// and the import must fail with "Unresolved elements"
				RuntimeException ex = assertThrows(RuntimeException.class, () -> packIn.importXML(file.toString(), Env.getCtx(), getTrxName()));
				assertEquals("Unresolved elements", ex.getMessage());

				packIn.getNotifier().notifyRecipient();
			}

			// the import transaction rolled back, the Import Failed status must have been persisted on rollback
			rollback();

			assertImportFailed(packIn, "zzzTestPackInUnresolved");
		} finally {
			rollback();
			cleanup("zzzTestPackInUnresolved", packIn.getAD_Package_Imp_ID());
		}
	}

	@Test
	public void testParseError() throws Exception {
		Path file = createPackageFile(
				"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
				+ "<idempiere Name=\"zzzTestPackInParseError\" Version=\"1.0.0\" idempiereVersion=\"\" DataBaseVersion=\"\""
				+ " Description=\"Test package with a parse error\" Author=\"PackInTest\" AuthorEmail=\"test@example.com\""
				+ " CreatedDate=\"2026-04-13 15:51:18.0\" UpdatedDate=\"2026-04-29 14:51:32.596\" PackOutVersion=\"100\" UpdateDictionary=\"false\""
				+ " Client=\"11-GardenWorld-GardenWorld\" AD_Client_UU=\"3268b9a8-10d8-466d-96e5-aa01166408fa\">\n"
				+ "  <AD_Process>\n"
				+ "</idempiere>\n");

		PackIn packIn = newPackIn(file, "zzzTestPackInParseError");
		try {
			try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
				stubNotifierSettings(mocked);

				// the unclosed AD_Process element makes the parsing fail after the AD_Package_Imp record was created
				assertThrows(RuntimeException.class, () -> packIn.importXML(file.toString(), Env.getCtx(), getTrxName()));

				packIn.getNotifier().notifyRecipient();
			}

			rollback();

			assertImportFailed(packIn, "zzzTestPackInParseError");
		} finally {
			rollback();
			cleanup("zzzTestPackInParseError", packIn.getAD_Package_Imp_ID());
		}
	}

	@Test
	public void testSuccessfulImport() throws Exception {
		Path file = createPackageFile(
				"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
				+ "<idempiere Name=\"zzzTestPackInSuccess\" Version=\"1.0.0\" idempiereVersion=\"\" DataBaseVersion=\"\""
				+ " Description=\"Test package imported successfully\" Author=\"PackInTest\" AuthorEmail=\"test@example.com\""
				+ " CreatedDate=\"2026-04-13 15:51:18.0\" UpdatedDate=\"2026-04-29 14:51:32.596\" PackOutVersion=\"100\" UpdateDictionary=\"false\""
				+ " Client=\"11-GardenWorld-GardenWorld\" AD_Client_UU=\"3268b9a8-10d8-466d-96e5-aa01166408fa\">\n"
				+ "  <AD_Message>\n"
				+ "    <EntityType>U</EntityType>\n"
				+ "    <Value>zzzTestPackInSuccess</Value>\n"
				+ "    <MsgType>I</MsgType>\n"
				+ "    <MsgText>Test message for a successful pack in</MsgText>\n"
				+ "  </AD_Message>\n"
				+ "</idempiere>\n");

		PackIn packIn = newPackIn(file, "zzzTestPackInSuccess");
		try {
			try (MockedStatic<MSysConfig> mocked = Mockito.mockStatic(MSysConfig.class, Mockito.CALLS_REAL_METHODS)) {
				stubNotifierSettings(mocked);

				String msg = packIn.importXML(file.toString(), Env.getCtx(), getTrxName());
				assertTrue(msg.startsWith("Processed="), msg);

				packIn.getNotifier().notifyRecipient();
			}

			// commit the import to persist the Completed status, as the pack in entry points do
			commit();

			MPackageImp packageImp = new MPackageImp(Env.getCtx(), packIn.getAD_Package_Imp_ID(), null);
			assertEquals(MPackageImp.PACKAGE_STATUS_COMPLETED, packageImp.getPK_Status(),
					"PK_Status must be Completed successfully on success");

			MAttachment attachment = MAttachment.get(Env.getCtx(), X_AD_Package_Imp.Table_ID, packIn.getAD_Package_Imp_ID());
			assertNotNull(attachment, "The log must be attached to the AD_Package_Imp record also on success");
			MAttachmentEntry resultLog = findAttachmentEntry(attachment, "result_");
			assertNotNull(resultLog, "The attachment must contain a result_*.log entry on success");
			String content = new String(resultLog.getData(), StandardCharsets.UTF_8);
			assertTrue(content.contains(MPackageImp.PACKAGE_STATUS_COMPLETED),
					"The log must contain the status lines:\n" + content);
			assertTrue(content.contains("AD_Message=zzzTestPackInSuccess"),
					"The log must contain the successful objects list:\n" + content);
		} finally {
			rollback();
			cleanup("zzzTestPackInSuccess", packIn.getAD_Package_Imp_ID());
		}
	}

	private void stubNotifierSettings(MockedStatic<MSysConfig> mocked) {
		mocked.when(() -> MSysConfig.getValue(MSysConfig.EMAIL_NOTIFY_2PACK, "", getAD_Client_ID())).thenReturn("");
		mocked.when(() -> MSysConfig.getValue(MSysConfig.EMAIL_NOTIFY_2PACK, "", 0)).thenReturn("");
		mocked.when(() -> MSysConfig.getBooleanValue(MSysConfig.ATTACH_NOTIFY_2PACK, false, getAD_Client_ID())).thenReturn(true);
	}

	private PackIn newPackIn(Path file, String packageName) {
		X_AD_Package_Imp_Proc proc = new X_AD_Package_Imp_Proc(Env.getCtx(), 0, null);
		proc.setName(packageName);
		proc.setAD_Package_Source_Type(X_AD_Package_Imp_Proc.AD_PACKAGE_SOURCE_TYPE_File);

		PackIn packIn = new PackIn();
		packIn.setAD_Package_Imp_Proc(proc);
		packIn.setPackageName(packageName);
		packIn.setPackageVersion("1.0.0");
		packIn.getNotifier().setFileName(file.getFileName().toString());
		return packIn;
	}

	private void assertImportFailed(PackIn packIn, String packageName) {
		int adPackageImpId = packIn.getAD_Package_Imp_ID();
		assertTrue(adPackageImpId > 0, "The import must have created an AD_Package_Imp record");

		MPackageImp packageImp = new MPackageImp(Env.getCtx(), adPackageImpId, null);
		assertEquals(MPackageImp.PACKAGE_STATUS_IMPORT_FAILED, packageImp.getPK_Status(),
				"PK_Status must be set to Import Failed on failure");

		int adPackageImpInstId = DB.getSQLValueEx(null, "SELECT AD_Package_Imp_Inst_ID FROM AD_Package_Imp_Inst WHERE Name=?", packageName);
		assertTrue(adPackageImpInstId > 0, "The import must have created an AD_Package_Imp_Inst record for " + packageName);
		String pkStatusInst = DB.getSQLValueStringEx(null, "SELECT PK_Status FROM AD_Package_Imp_Inst WHERE AD_Package_Imp_Inst_ID=?", adPackageImpInstId);
		assertEquals(MPackageImp.PACKAGE_STATUS_IMPORT_FAILED, pkStatusInst,
				"PK_Status must be set to Import Failed on failure for AD_Package_Imp_Inst");

		MAttachment attachment = MAttachment.get(Env.getCtx(), X_AD_Package_Imp.Table_ID, adPackageImpId);
		assertNotNull(attachment, "The log must be attached to the AD_Package_Imp record");
		MAttachmentEntry errorLog = findAttachmentEntry(attachment, "error_");
		assertNotNull(errorLog, "The attachment must contain an error_*.log entry on failure");
		String content = new String(errorLog.getData(), StandardCharsets.UTF_8);
		assertTrue(content.contains(MPackageImp.PACKAGE_STATUS_IMPORT_FAILED),
				"The log must contain the failed status:\n" + content);
		if ("zzzTestPackInUnresolved".equals(packageName)) {
			assertTrue(content.contains("Unresolved Elements:"),
					"The log must contain the Unresolved Elements section:\n" + content);
			assertTrue(content.contains("unresolved [AD_Workflow_ID]"),
					"The Unresolved Elements section must contain the full element dump:\n" + content);
			assertTrue(content.contains("Missing AD_Workflow record with AD_Workflow_UU=00000000-0000-0000-0000-00000000abcd"),
					"The Failed Objects section must contain the readable unresolved element:\n" + content);
			assertTrue(content.contains("referenced in AD_Process Name=zzzTestPackInUnresolved"),
					"The log must identify the element holding the unresolved reference:\n" + content);
		}
	}

	private MAttachmentEntry findAttachmentEntry(MAttachment attachment, String prefix) {
		for (MAttachmentEntry entry : attachment.getEntries()) {
			if (entry.getName().startsWith(prefix)) {
				return entry;
			}
		}
		return null;
	}

	private void cleanup(String packageName, int adPackageImpId) {
		// the AD_Package_Imp, AD_Package_Imp_Inst, AD_Package_Imp_Proc records and the
		// attachment are persisted out of transaction, clean them up the same way
		try {
			if (adPackageImpId > 0) {
				MAttachment attachment = MAttachment.get(Env.getCtx(), X_AD_Package_Imp.Table_ID, adPackageImpId);
				if (attachment != null)
					attachment.deleteEx(true);
				DB.executeUpdateEx("DELETE FROM AD_Package_Imp_Detail WHERE AD_Package_Imp_ID=?", new Object[] {adPackageImpId}, null);
				DB.executeUpdateEx("DELETE FROM AD_Package_Imp WHERE AD_Package_Imp_ID=?", new Object[] {adPackageImpId}, null);
				DB.executeUpdateEx("DELETE FROM AD_Message WHERE Value=?", new Object[] {packageName}, null);
			}
			DB.executeUpdateEx("DELETE FROM AD_Package_Imp_Inst WHERE Name=?", new Object[] {packageName}, null);
			DB.executeUpdateEx("DELETE FROM AD_Package_Imp_Proc WHERE Name=?", new Object[] {packageName}, null);
		} catch (Exception e) {
			// don't let the cleanup hide a test failure
			e.printStackTrace();
		}
	}

	private Path createPackageFile(String xml) throws IOException {
		Path file = Files.createTempFile("packin_test_", ".xml");
		Files.write(file, xml.getBytes(StandardCharsets.UTF_8));
		file.toFile().deleteOnExit();
		return file;
	}

}
