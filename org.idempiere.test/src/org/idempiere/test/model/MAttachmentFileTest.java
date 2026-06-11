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
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Properties;

import org.compiere.model.MAttachment;
import org.compiere.model.MAttachmentFile;
import org.compiere.model.MClientInfo;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageProvider;
import org.compiere.model.Query;
import org.compiere.model.X_AD_StorageProvider;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

/**
 * Test class for AD_AttachmentFile table functionality
 * 
 * @author Carlos Ruiz - globalqss - bxservice
 */
@Isolated
public class MAttachmentFileTest extends AbstractTestCase {

	public MAttachmentFileTest() {
	}

	@Test
	public void testAttachmentFilesWithDBLOB() {
		// Create a storage provider for DB_LOB
		MStorageProvider provider = new MStorageProvider(Env.getCtx(), 0, getTrxName());
		provider.setName("DB LOB Provider for Attachment Test");
		provider.setMethod(X_AD_StorageProvider.METHOD_DatabaseWithLargeObjectSupport);
		provider.saveEx();

		// Get current client info to mock the attachment storage provider
		MClientInfo clientInfo = new Query(Env.getCtx(), MClientInfo.Table_Name, "AD_Client_ID=?", null)
				.setParameters(getAD_Client_ID())
				.firstOnly();
		clientInfo = new MClientInfo(clientInfo);
		clientInfo.setAD_StorageProvider_ID(provider.getAD_StorageProvider_ID());

		try (MockedStatic<MStorageProvider> storageProviderMock = Mockito.mockStatic(MStorageProvider.class, Mockito.CALLS_REAL_METHODS);
				MockedStatic<MClientInfo> clientInfoMock = Mockito.mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS)) {
			storageProviderMock.when(() -> MStorageProvider.get(any(Properties.class), eq(provider.get_ID()))).thenReturn(provider);
			clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(getAD_Client_ID()))).thenReturn(clientInfo);

			// Create an attachment for a product
			MAttachment attachment = new MAttachment(Env.getCtx(), MProduct.Table_ID, 
					DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.AZALEA_BUSH.uuid, getTrxName());

			// Attach 5 files to the attachment
			for (int i = 1; i <= 5; i++) {
				String fileName = "testfile" + i + ".txt";
				String content = "Content of file " + i;
				attachment.addEntry(fileName, content.getBytes(StandardCharsets.UTF_8));
			}
			attachment.saveEx();

			// Verify the records in AD_AttachmentFile are correct (5 files)
			List<MAttachmentFile> attachmentFiles = attachment.getAttachmentFiles();
			assertEquals(5, attachmentFiles.size(), "Expected 5 attachment files");

			// Verify the file names and sequence
			for (int i = 0; i < 5; i++) {
				MAttachmentFile af = attachmentFiles.get(i);
				assertEquals("testfile" + (i + 1) + ".txt", af.getFileName(), "Unexpected file name at index " + i);
				assertEquals(i + 1, af.getSeqNo(), "Unexpected sequence number at index " + i);
				assertNotNull(af.getAD_AttachmentFile_UU(), "Attachment file UUID should not be null");
			}

			// Verify the entry count
			assertEquals(5, attachment.getEntryCount(), "Expected 5 entries in the attachment");

			// Delete the 3rd file in the attachment (index 2)
			assertTrue(attachment.deleteEntry(2), "Failed to delete entry at index 2");
			attachment.saveEx();
			attachment.close();

			// Reload attachment to verify changes
			attachment = MAttachment.get(Env.getCtx(), MProduct.Table_ID, 
					DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.AZALEA_BUSH.uuid, getTrxName());

			// Verify the records in AD_AttachmentFile are correct (4 files remaining)
			attachmentFiles = attachment.getAttachmentFiles();
			assertEquals(4, attachmentFiles.size(), "Expected 4 attachment files after deleting 3rd file");
			assertEquals(4, attachment.getEntryCount(), "Expected 4 entries in the attachment after deleting 3rd file");

			// Verify the remaining files: file1, file2, file4, file5
			assertEquals("testfile1.txt", attachmentFiles.get(0).getFileName(), "Expected testfile1.txt at index 0");
			assertEquals("testfile2.txt", attachmentFiles.get(1).getFileName(), "Expected testfile2.txt at index 1");
			assertEquals("testfile4.txt", attachmentFiles.get(2).getFileName(), "Expected testfile4.txt at index 2");
			assertEquals("testfile5.txt", attachmentFiles.get(3).getFileName(), "Expected testfile5.txt at index 3");

			// Delete the 1st file in the attachment (index 0)
			assertTrue(attachment.deleteEntry(0), "Failed to delete entry at index 0");
			attachment.saveEx();
			attachment.close();

			// Reload attachment to verify changes
			attachment = MAttachment.get(Env.getCtx(), MProduct.Table_ID, 
					DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.AZALEA_BUSH.uuid, getTrxName());

			// Verify the records in AD_AttachmentFile are correct (3 files remaining)
			attachmentFiles = attachment.getAttachmentFiles();
			assertEquals(3, attachmentFiles.size(), "Expected 3 attachment files after deleting 1st file");
			assertEquals(3, attachment.getEntryCount(), "Expected 3 entries in the attachment after deleting 1st file");

			// Verify the remaining files: file2, file4, file5
			assertEquals("testfile2.txt", attachmentFiles.get(0).getFileName(), "Expected testfile2.txt at index 0");
			assertEquals("testfile4.txt", attachmentFiles.get(1).getFileName(), "Expected testfile4.txt at index 1");
			assertEquals("testfile5.txt", attachmentFiles.get(2).getFileName(), "Expected testfile5.txt at index 2");

			// Delete the last file in the attachment (index 2, which is the last one)
			assertTrue(attachment.deleteEntry(2), "Failed to delete entry at index 2 (last file)");
			attachment.saveEx();
			attachment.close();

			// Reload attachment to verify changes
			attachment = MAttachment.get(Env.getCtx(), MProduct.Table_ID, 
					DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.AZALEA_BUSH.uuid, getTrxName());

			// Verify the records in AD_AttachmentFile are correct (2 files remaining)
			attachmentFiles = attachment.getAttachmentFiles();
			assertEquals(2, attachmentFiles.size(), "Expected 2 attachment files after deleting last file");
			assertEquals(2, attachment.getEntryCount(), "Expected 2 entries in the attachment after deleting last file");

			// Verify the remaining files: file2, file4
			assertEquals("testfile2.txt", attachmentFiles.get(0).getFileName(), "Expected testfile2.txt at index 0");
			assertEquals("testfile4.txt", attachmentFiles.get(1).getFileName(), "Expected testfile4.txt at index 1");
			attachment.close();
		}
	}

}
