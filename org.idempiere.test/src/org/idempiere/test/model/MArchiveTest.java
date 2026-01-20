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
 * - hengsin                         								   *
 **********************************************************************/
package org.idempiere.test.model;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Properties;

import org.compiere.model.MArchive;
import org.compiere.model.MClientInfo;
import org.compiere.model.MProduct;
import org.compiere.model.MStorageProvider;
import org.compiere.model.Query;
import org.compiere.model.X_AD_StorageProvider;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.idempiere.test.DictionaryIDs;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.parallel.Isolated;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

@Isolated
public class MArchiveTest extends AbstractTestCase {

	public MArchiveTest() {
	}

	@Test
	public void testArchive() {
		int allReportCount = MArchive.getReportCountByTableId(MProduct.Table_ID, getTrxName());
		int[] recordCounts = MArchive.getReportAndDocumentCountByRecordId(MProduct.Table_ID, DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.AZALEA_BUSH.uuid, getTrxName());
		
		MArchive marchive = new MArchive(Env.getCtx(), 0, getTrxName());
		marchive.setAD_Table_ID(MProduct.Table_ID);
		marchive.setIsReport(true);
		marchive.setName(getClass().getName());
		marchive.setRecord_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		marchive.setRecord_UU(DictionaryIDs.M_Product.AZALEA_BUSH.uuid);
		marchive.setBinaryData("test".getBytes());
		marchive.saveEx();
		
		int allReportCount1 = MArchive.getReportCountByTableId(MProduct.Table_ID, getTrxName());
		assertEquals(allReportCount+1, allReportCount1, "Unexpected all archive report counts by table");
		
		int[] recordCounts1 = MArchive.getReportAndDocumentCountByRecordId(MProduct.Table_ID, DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.AZALEA_BUSH.uuid, getTrxName());
		assertEquals(recordCounts[0]+1, recordCounts1[0], "Unexpected archive report counts by table and record id");
		assertEquals(recordCounts[1], recordCounts1[1], "Unexpected archive document counts by table and record id");
		
		marchive = new MArchive(Env.getCtx(), 0, getTrxName());
		marchive.setAD_Table_ID(MProduct.Table_ID);
		marchive.setIsReport(false);
		marchive.setName(getClass().getName());
		marchive.setRecord_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		marchive.setRecord_UU(DictionaryIDs.M_Product.AZALEA_BUSH.uuid);
		marchive.setBinaryData("test1".getBytes());
		marchive.saveEx();
		
		recordCounts1 = MArchive.getReportAndDocumentCountByRecordId(MProduct.Table_ID, DictionaryIDs.M_Product.AZALEA_BUSH.id, DictionaryIDs.M_Product.AZALEA_BUSH.uuid, getTrxName());
		assertEquals(recordCounts[0]+1, recordCounts1[0], "Unexpected archive report counts by table and record id");
		assertEquals(recordCounts[1]+1, recordCounts1[1], "Unexpected archive document counts by table and record id");
	}
	
	@Test
	public void testInputStream() {
		createArchiveFromInputStream();
	}

	private int createArchiveFromInputStream() {
		MArchive marchive = new MArchive(Env.getCtx(), 0, getTrxName());
		marchive.setAD_Table_ID(MProduct.Table_ID);
		marchive.setIsReport(false);
		marchive.setName(getClass().getName());
		marchive.setRecord_ID(DictionaryIDs.M_Product.AZALEA_BUSH.id);
		marchive.setRecord_UU(DictionaryIDs.M_Product.AZALEA_BUSH.uuid);
		marchive.setInputStream(new ByteArrayInputStream(DictionaryIDs.M_Product.AZALEA_BUSH.uuid.getBytes(StandardCharsets.US_ASCII)));
		marchive.saveEx();
		
		marchive = new MArchive(Env.getCtx(),marchive.getAD_Archive_ID(), getTrxName());
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try (InputStream is = marchive.getInputStream()) {
			byte[] buffer = new byte[1024];
			int bytesRead;
			while ((bytesRead = is.read(buffer)) != -1) {
				baos.write(buffer, 0, bytesRead);
			}
		} catch (Exception e) {
			fail("Failed to read archive binary stream: " + e.getMessage());
		}
		
		assertArrayEquals(DictionaryIDs.M_Product.AZALEA_BUSH.uuid.getBytes(StandardCharsets.US_ASCII), baos.toByteArray(), "Unexpected archive binary data");
		
		return marchive.getAD_Archive_ID();
	}
	
	@Test
	public void testDBLOBProviderForArchive() {
		MStorageProvider provider = new MStorageProvider(Env.getCtx(), 0, getTrxName());
        provider.setName("DB LOB Provider");
        provider.setMethod(X_AD_StorageProvider.METHOD_DatabaseWithLargeObjectSupport);
        provider.saveEx();
        
        MClientInfo clientInfo = new Query(Env.getCtx(), MClientInfo.Table_Name, "AD_Client_ID=?", null)
				.setParameters(getAD_Client_ID())
				.firstOnly();
        clientInfo = new MClientInfo(clientInfo);
        clientInfo.setStorageArchive_ID(provider.getAD_StorageProvider_ID());
        try (MockedStatic<MStorageProvider> storageProviderMock = Mockito.mockStatic(MStorageProvider.class, Mockito.CALLS_REAL_METHODS);
             MockedStatic<MClientInfo> clientInfoMock = Mockito.mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS)) {
            storageProviderMock.when(() -> MStorageProvider.get(any(Properties.class), eq(provider.get_ID()))).thenReturn(provider);
            clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(getAD_Client_ID()))).thenReturn(clientInfo);
            
            int id = createArchiveFromInputStream();
            int count = DB.getSQLValueEx(getTrxName(), "SELECT COUNT(*) FROM AD_Archive_Blob WHERE AD_Archive_ID=?", id);
            assertTrue(count > 0, "No archive blob found for ID: " + id);
        }
	}
	
	@Test
	public void testDBProviderForArchive() {
		MStorageProvider provider = new MStorageProvider(Env.getCtx(), 0, getTrxName());
        provider.setName("DB Provider");
        provider.setMethod(X_AD_StorageProvider.METHOD_Database);
        provider.saveEx();
        
        MClientInfo clientInfo = new Query(Env.getCtx(), MClientInfo.Table_Name, "AD_Client_ID=?", getTrxName())
				.setParameters(getAD_Client_ID())
				.firstOnly();
        clientInfo = new MClientInfo(clientInfo);
        clientInfo.setStorageArchive_ID(provider.getAD_StorageProvider_ID());
        try (MockedStatic<MStorageProvider> storageProviderMock = Mockito.mockStatic(MStorageProvider.class, Mockito.CALLS_REAL_METHODS);
             MockedStatic<MClientInfo> clientInfoMock = Mockito.mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS)) {
            storageProviderMock.when(() -> MStorageProvider.get(any(Properties.class), eq(provider.get_ID()))).thenReturn(provider);
            clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(getAD_Client_ID()))).thenReturn(clientInfo);
            
            int id = createArchiveFromInputStream();
            int providerId = DB.getSQLValueEx(getTrxName(), "SELECT AD_StorageProvider_ID FROM AD_Archive WHERE AD_Archive_ID=?", id);
            assertEquals(provider.getAD_StorageProvider_ID(), providerId, "Unexpected storage provider ID for archive blob");
        }
	}
	
	@Test
	public void testFileSystemProviderForArchive() throws IOException {
		MStorageProvider provider = new MStorageProvider(Env.getCtx(), 0, getTrxName());
        provider.setName("File System Provider");
        provider.setMethod(X_AD_StorageProvider.METHOD_FileSystem);
        Path tempDir = Files.createTempDirectory("root_");
        provider.setFolder(tempDir.toFile().getAbsolutePath());
        provider.saveEx();
        
        MClientInfo clientInfo = new Query(Env.getCtx(), MClientInfo.Table_Name, "AD_Client_ID=?", getTrxName())
				.setParameters(getAD_Client_ID())
				.firstOnly();
        clientInfo = new MClientInfo(clientInfo);
        clientInfo.setStorageArchive_ID(provider.getAD_StorageProvider_ID());
        try (MockedStatic<MStorageProvider> storageProviderMock = Mockito.mockStatic(MStorageProvider.class, Mockito.CALLS_REAL_METHODS);
             MockedStatic<MClientInfo> clientInfoMock = Mockito.mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS)) {
            storageProviderMock.when(() -> MStorageProvider.get(any(Properties.class), eq(provider.get_ID()))).thenReturn(provider);
            clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(getAD_Client_ID()))).thenReturn(clientInfo);
            
            int id = createArchiveFromInputStream();
            int providerId = DB.getSQLValueEx(getTrxName(), "SELECT AD_StorageProvider_ID FROM AD_Archive WHERE AD_Archive_ID=?", id);
            assertEquals(provider.getAD_StorageProvider_ID(), providerId, "Unexpected storage provider ID for archive blob");
        }
	}
}
