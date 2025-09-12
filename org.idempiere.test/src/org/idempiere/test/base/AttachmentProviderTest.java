package org.idempiere.test.base;

import org.compiere.model.*;
import org.compiere.util.Env;
import org.idempiere.test.AbstractTestCase;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.mockito.Mockito;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Properties;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;

public class AttachmentProviderTest extends AbstractTestCase {

    @Test
    public void testDBLargeObjectProvider() throws IOException {
        MStorageProvider provider = new MStorageProvider(Env.getCtx(), 0, null);
        provider.setName("DB LOB Provider");
        provider.setMethod(X_AD_StorageProvider.METHOD_DatabaseWithLargeObjectSupport);
        provider.saveEx();

        MTest test = null;
        MAttachment attachment = null;
        MClientInfo clientInfo = MClientInfo.get(Env.getCtx(), getAD_Client_ID());
        clientInfo = new MClientInfo(clientInfo);
        clientInfo.setAD_StorageProvider_ID(provider.getAD_StorageProvider_ID());
        try (MockedStatic<MStorageProvider> storageProviderMock = Mockito.mockStatic(MStorageProvider.class, Mockito.CALLS_REAL_METHODS);
             MockedStatic<MClientInfo> clientInfoMock = Mockito.mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS)) {
            storageProviderMock.when(() -> MStorageProvider.get(any(Properties.class), eq(provider.get_ID()))).thenReturn(provider);
            clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(getAD_Client_ID()))).thenReturn(clientInfo);

            test = new MTest(Env.getCtx(), 0, null);
            test.setName("DB LOB Provider Test");
            test.setDescription(test.getName());
            test.saveEx();

            Path tempDir = Files.createTempDirectory("test_");
            Path dbTest = tempDir.resolve("DBTest.clas");
            try (InputStream is = getClass().getClassLoader().getResourceAsStream("org/idempiere/test/base/DBTest.class")) {
                assert is != null;
                Files.copy(is, dbTest);
            }
            Path amtInWordsTest = tempDir.resolve("AmtInWordsTest.clas");
            try (InputStream is = getClass().getClassLoader().getResourceAsStream("org/idempiere/test/base/AmtInWordsTest.class")) {
                assert is != null;
                Files.copy(is, amtInWordsTest);
            }
            Path envTest = tempDir.resolve("EnvTest.clas");
            try (InputStream is = getClass().getClassLoader().getResourceAsStream("org/idempiere/test/base/EnvTest.class")) {
                assert is != null;
                Files.copy(is, envTest);
            }

            //must create without trx since AttachmentDBLazyDataSource is not using transaction
            attachment = new MAttachment(Env.getCtx(), MTest.Table_ID, test.get_ID(), test.getTest_UU(), null);
            attachment.addEntry("DBTest.class", dbTest.toFile());
            attachment.addEntry("AmtInWordsTest.class", amtInWordsTest.toFile());
            attachment.addEntry("EnvTest.class", envTest.toFile());
            attachment.saveEx();
            attachment.close();

            attachment = MAttachment.get(Env.getCtx(), MTest.Table_ID, test.getTest_ID(), test.getTest_UU(), null);
            assertNotNull(attachment);
            MAttachmentEntry[] entries = attachment.getEntries();
            assertEquals(3, entries.length);
            IAttachmentLazyDataSource lds = entries[0].getLazyDataSource();
            assertNotNull(lds);
            assertInstanceOf(AttachmentDBLazyDataSource.class, lds);

            // Assert that the content of the retrieved file is identical to the original
            File file = entries[0].getFile();
            assertNotNull(file);
            byte[] originalBytes = Files.readAllBytes(dbTest);
            byte[] retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
            file = entries[1].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(amtInWordsTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
            file = entries[2].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(envTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");

            //Test delete
            assertTrue(attachment.deleteEntry(1));
            attachment.saveEx();
            entries = attachment.getEntries();
            assertEquals(2, entries.length);
            file = entries[1].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(envTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
            //Test retrieval after delete
            attachment = MAttachment.get(Env.getCtx(), MTest.Table_ID, test.getTest_ID(), test.getTest_UU(), null);
            assertNotNull(attachment);
            entries = attachment.getEntries();
            assertEquals(2, entries.length);
            file = entries[1].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(envTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
        } finally {
            rollback();
            if (attachment != null && attachment.getAD_Attachment_ID() > 0)
                attachment.deleteEx(true);
            if (test != null && test.getTest_ID() > 0)
                test.deleteEx(true);
            provider.deleteEx(true);
        }
    }

    @Test
    public void testFileSystemProvider() throws IOException {
        Path tempDir = Files.createTempDirectory("root_");
        MStorageProvider provider = new MStorageProvider(Env.getCtx(), 0, null);
        provider.setName("File System Provider");
        provider.setMethod(X_AD_StorageProvider.METHOD_FileSystem);
        provider.setFolder(tempDir.toFile().getAbsolutePath());
        provider.saveEx();

        MTest test = null;
        MAttachment attachment = null;
        MClientInfo clientInfo = MClientInfo.get(Env.getCtx(), getAD_Client_ID());
        clientInfo = new MClientInfo(clientInfo);
        clientInfo.setAD_StorageProvider_ID(provider.getAD_StorageProvider_ID());
        try (MockedStatic<MStorageProvider> storageProviderMock = Mockito.mockStatic(MStorageProvider.class, Mockito.CALLS_REAL_METHODS);
             MockedStatic<MClientInfo> clientInfoMock = Mockito.mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS)) {
            storageProviderMock.when(() -> MStorageProvider.get(any(Properties.class), eq(provider.get_ID()))).thenReturn(provider);
            clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(getAD_Client_ID()))).thenReturn(clientInfo);

            test = new MTest(Env.getCtx(), 0, null);
            test.setName("File System Provider Test");
            test.setDescription(test.getName());
            test.saveEx();

            tempDir = Files.createTempDirectory("test_");
            Path dbTest = tempDir.resolve("DBTest.clas");
            try (InputStream is = getClass().getClassLoader().getResourceAsStream("org/idempiere/test/base/DBTest.class")) {
                assert is != null;
                Files.copy(is, dbTest);
            }
            Path amtInWordsTest = tempDir.resolve("AmtInWordsTest.clas");
            try (InputStream is = getClass().getClassLoader().getResourceAsStream("org/idempiere/test/base/AmtInWordsTest.class")) {
                assert is != null;
                Files.copy(is, amtInWordsTest);
            }
            Path envTest = tempDir.resolve("EnvTest.clas");
            try (InputStream is = getClass().getClassLoader().getResourceAsStream("org/idempiere/test/base/EnvTest.class")) {
                assert is != null;
                Files.copy(is, envTest);
            }

            //must create without trx since AttachmentDBLazyDataSource is not using transaction
            attachment = new MAttachment(Env.getCtx(), MTest.Table_ID, test.get_ID(), test.getTest_UU(), null);
            attachment.addEntry("DBTest.class", dbTest.toFile());
            attachment.addEntry("AmtInWordsTest.class", amtInWordsTest.toFile());
            attachment.addEntry("EnvTest.class", envTest.toFile());
            attachment.saveEx();
            attachment.close();

            attachment = MAttachment.get(Env.getCtx(), MTest.Table_ID, test.getTest_ID(), test.getTest_UU(), null);
            assertNotNull(attachment);
            MAttachmentEntry[] entries = attachment.getEntries();
            assertEquals(3, entries.length);
            IAttachmentLazyDataSource lds = entries[0].getLazyDataSource();
            assertNotNull(lds);
            assertInstanceOf(AttachmentFileLazyDataSource.class, lds);

            // Assert that the content of the retrieved file is identical to the original
            File file = entries[0].getFile();
            assertNotNull(file);
            byte[] originalBytes = Files.readAllBytes(dbTest);
            byte[] retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
            file = entries[1].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(amtInWordsTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
            file = entries[2].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(envTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");

            //Test delete
            assertTrue(attachment.deleteEntry(1));
            attachment.saveEx();
            entries = attachment.getEntries();
            assertEquals(2, entries.length);
            file = entries[1].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(envTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
            //Test retrieval after delete
            attachment = MAttachment.get(Env.getCtx(), MTest.Table_ID, test.getTest_ID(), test.getTest_UU(), null);
            assertNotNull(attachment);
            entries = attachment.getEntries();
            assertEquals(2, entries.length);
            file = entries[1].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(envTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
        } finally {
            rollback();
            if (attachment != null && attachment.getAD_Attachment_ID() > 0)
                attachment.deleteEx(true);
            if (test != null && test.getTest_ID() > 0)
                test.deleteEx(true);
            provider.deleteEx(true);
        }
    }

    @Test
    public void testDBProvider() throws IOException {
        MStorageProvider provider = new MStorageProvider(Env.getCtx(), 0, null);
        provider.setName("Database Provider");
        provider.setMethod(X_AD_StorageProvider.METHOD_Database);
        provider.saveEx();

        MTest test = null;
        MAttachment attachment = null;
        MClientInfo clientInfo = MClientInfo.get(Env.getCtx(), getAD_Client_ID());
        clientInfo = new MClientInfo(clientInfo);
        clientInfo.setAD_StorageProvider_ID(provider.getAD_StorageProvider_ID());
        try (MockedStatic<MStorageProvider> storageProviderMock = Mockito.mockStatic(MStorageProvider.class, Mockito.CALLS_REAL_METHODS);
             MockedStatic<MClientInfo> clientInfoMock = Mockito.mockStatic(MClientInfo.class, Mockito.CALLS_REAL_METHODS)) {
            storageProviderMock.when(() -> MStorageProvider.get(any(Properties.class), eq(provider.get_ID()))).thenReturn(provider);
            clientInfoMock.when(() -> MClientInfo.get(any(Properties.class), eq(getAD_Client_ID()))).thenReturn(clientInfo);

            test = new MTest(Env.getCtx(), 0, null);
            test.setName("Database Provider Test");
            test.setDescription(test.getName());
            test.saveEx();

            Path tempDir = Files.createTempDirectory("test_");
            Path dbTest = tempDir.resolve("DBTest.clas");
            try (InputStream is = getClass().getClassLoader().getResourceAsStream("org/idempiere/test/base/DBTest.class")) {
                assert is != null;
                Files.copy(is, dbTest);
            }
            Path amtInWordsTest = tempDir.resolve("AmtInWordsTest.clas");
            try (InputStream is = getClass().getClassLoader().getResourceAsStream("org/idempiere/test/base/AmtInWordsTest.class")) {
                assert is != null;
                Files.copy(is, amtInWordsTest);
            }
            Path envTest = tempDir.resolve("EnvTest.clas");
            try (InputStream is = getClass().getClassLoader().getResourceAsStream("org/idempiere/test/base/EnvTest.class")) {
                assert is != null;
                Files.copy(is, envTest);
            }

            //must create without trx since AttachmentDBLazyDataSource is not using transaction
            attachment = new MAttachment(Env.getCtx(), MTest.Table_ID, test.get_ID(), test.getTest_UU(), null);
            attachment.addEntry("DBTest.class", dbTest.toFile());
            attachment.addEntry("AmtInWordsTest.class", amtInWordsTest.toFile());
            attachment.addEntry("EnvTest.class", envTest.toFile());
            attachment.saveEx();
            attachment.close();

            attachment = MAttachment.get(Env.getCtx(), MTest.Table_ID, test.getTest_ID(), test.getTest_UU(), null);
            assertNotNull(attachment);
            MAttachmentEntry[] entries = attachment.getEntries();
            assertEquals(3, entries.length);

            // Assert that the content of the retrieved file is identical to the original
            File file = entries[0].getFile();
            assertNotNull(file);
            byte[] originalBytes = Files.readAllBytes(dbTest);
            byte[] retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
            file = entries[1].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(amtInWordsTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
            file = entries[2].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(envTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");

            //Test delete
            assertTrue(attachment.deleteEntry(1));
            attachment.saveEx();
            entries = attachment.getEntries();
            assertEquals(2, entries.length);
            file = entries[1].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(envTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
            //Test retrieval after delete
            attachment = MAttachment.get(Env.getCtx(), MTest.Table_ID, test.getTest_ID(), test.getTest_UU(), null);
            assertNotNull(attachment);
            entries = attachment.getEntries();
            assertEquals(2, entries.length);
            file = entries[1].getFile();
            assertNotNull(file);
            originalBytes = Files.readAllBytes(envTest);
            retrievedBytes = Files.readAllBytes(file.toPath());
            assertArrayEquals(originalBytes, retrievedBytes, "File content from attachment should match the original file");
        } finally {
            rollback();
            if (attachment != null && attachment.getAD_Attachment_ID() > 0)
                attachment.deleteEx(true);
            if (test != null && test.getTest_ID() > 0)
                test.deleteEx(true);
            provider.deleteEx(true);
        }
    }
}
