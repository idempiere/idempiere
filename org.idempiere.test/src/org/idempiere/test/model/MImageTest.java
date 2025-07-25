/******************************************************************************
 * Product: iDempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 2012 Trek Global                                             *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
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
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Properties;

import org.compiere.model.MClientInfo;
import org.compiere.model.MImage;
import org.compiere.model.MStorageProvider;
import org.compiere.model.Query;
import org.compiere.model.X_AD_StorageProvider;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

public class MImageTest extends AbstractTestCase {

	private int createImageFromInputStream(byte[] imageData, String imageName) {
		MImage mimage = new MImage(Env.getCtx(), 0, getTrxName());
		mimage.setName(imageName);
		mimage.setImageURL(imageName);
		mimage.setInputStream(new ByteArrayInputStream(imageData));
		mimage.saveEx();
		
		mimage = new MImage(Env.getCtx(),mimage.get_ID(), getTrxName());
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try (InputStream is = mimage.getInputStream()) {
			byte[] buffer = new byte[1024];
			int bytesRead;
			while ((bytesRead = is.read(buffer)) != -1) {
				baos.write(buffer, 0, bytesRead);
			}
		} catch (Exception e) {
			fail("Failed to read image binary stream: " + e.getMessage());
		}
		
		assertArrayEquals(imageData, baos.toByteArray(), "Unexpected image binary data");
		
		return mimage.get_ID();
	}

	@Test
	public void testDBLOBProviderForImage() throws IOException {
		MStorageProvider provider = new MStorageProvider(Env.getCtx(), 0, getTrxName());
        provider.setName("DB LOB Provider");
        provider.setMethod(X_AD_StorageProvider.METHOD_DatabaseWithLargeObjectSupport);
        provider.saveEx();
        
        MClientInfo clientInfo = new Query(Env.getCtx(), MClientInfo.Table_Name, "AD_Client_ID=?", null)
				.setParameters(getAD_Client_ID())
				.firstOnly();
        clientInfo = new MClientInfo(clientInfo);
        clientInfo.setStorageImage_ID(provider.getAD_StorageProvider_ID());
        try (MockedStatic<MStorageProvider> storageProviderMock = Mockito.mockStatic(MStorageProvider.class, Mockito.CALLS_REAL_METHODS);
             MockedStatic<MClientInfo> clientInfoMock = Mockito.mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS)) {
            storageProviderMock.when(() -> MStorageProvider.get(any(Properties.class), eq(provider.get_ID()))).thenReturn(provider);
            clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(getAD_Client_ID()))).thenReturn(clientInfo);
            
            byte[] imageData = null;
            try (InputStream is = getClass().getResourceAsStream("/org/idempiere/test/model/idempiere_logo.png")) {
            	imageData = is.readAllBytes();
            }
            assertTrue(imageData != null && imageData.length > 0, "Image data should not be null or empty");
            int id = createImageFromInputStream(imageData, "idempiere_logo.png");
            int count = DB.getSQLValueEx(getTrxName(), "SELECT COUNT(*) FROM AD_Image_Blob WHERE AD_Image_ID=?", id);
            assertTrue(count > 0, "No image blob found for ID: " + id);
        }
	}
	
	@Test
	public void testDBProviderForImage() throws IOException {
		MStorageProvider provider = new MStorageProvider(Env.getCtx(), 0, getTrxName());
        provider.setName("DB Provider");
        provider.setMethod(X_AD_StorageProvider.METHOD_Database);
        provider.saveEx();
        
        MClientInfo clientInfo = new Query(Env.getCtx(), MClientInfo.Table_Name, "AD_Client_ID=?", getTrxName())
				.setParameters(getAD_Client_ID())
				.firstOnly();
        clientInfo = new MClientInfo(clientInfo);
        clientInfo.setStorageImage_ID(provider.getAD_StorageProvider_ID());
        try (MockedStatic<MStorageProvider> storageProviderMock = Mockito.mockStatic(MStorageProvider.class, Mockito.CALLS_REAL_METHODS);
             MockedStatic<MClientInfo> clientInfoMock = Mockito.mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS)) {
            storageProviderMock.when(() -> MStorageProvider.get(any(Properties.class), eq(provider.get_ID()))).thenReturn(provider);
            clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(getAD_Client_ID()))).thenReturn(clientInfo);
            
            byte[] imageData = null;
            try (InputStream is = getClass().getResourceAsStream("/org/idempiere/test/model/idempiere_logo.png")) {
            	imageData = is.readAllBytes();
            }
            assertTrue(imageData != null && imageData.length > 0, "Image data should not be null or empty");
            int id = createImageFromInputStream(imageData, "idempiere_logo.png");
            int providerId = DB.getSQLValueEx(getTrxName(), "SELECT AD_StorageProvider_ID FROM AD_Image WHERE AD_Image_ID=?", id);
            assertEquals(provider.getAD_StorageProvider_ID(), providerId, "Unexpected storage provider ID for image blob");
        }
	}
	
	@Test
	public void testFileSystemProviderForImage() throws IOException {
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
        clientInfo.setStorageImage_ID(provider.getAD_StorageProvider_ID());
        try (MockedStatic<MStorageProvider> storageProviderMock = Mockito.mockStatic(MStorageProvider.class, Mockito.CALLS_REAL_METHODS);
             MockedStatic<MClientInfo> clientInfoMock = Mockito.mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS)) {
            storageProviderMock.when(() -> MStorageProvider.get(any(Properties.class), eq(provider.get_ID()))).thenReturn(provider);
            clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(getAD_Client_ID()))).thenReturn(clientInfo);
            
            byte[] imageData = null;
            try (InputStream is = getClass().getResourceAsStream("/org/idempiere/test/model/idempiere_logo.png")) {
            	imageData = is.readAllBytes();
            }
            assertTrue(imageData != null && imageData.length > 0, "Image data should not be null or empty");
            int id = createImageFromInputStream(imageData, "idempiere_logo.png");
            int providerId = DB.getSQLValueEx(getTrxName(), "SELECT AD_StorageProvider_ID FROM AD_Image WHERE AD_Image_ID=?", id);
            assertEquals(provider.getAD_StorageProvider_ID(), providerId, "Unexpected storage provider ID for image blob");
        }
	}
}
