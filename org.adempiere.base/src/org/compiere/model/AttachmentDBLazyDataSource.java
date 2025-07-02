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
package org.compiere.model;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Util;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.logging.Level;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/**
 * Lazy loading data source for {@link AttachmentDBLOB}
 */
public class AttachmentDBLazyDataSource implements IAttachmentLazyDataSource {

    private static final org.compiere.util.CLogger log = CLogger.getCLogger(AttachmentDBLazyDataSource.class);

    private final int AD_Attachment_ID;
    private int index;
    private final String fileName;
    private final AtomicBoolean dataLoaded = new AtomicBoolean(false);
    private File file;
    private byte[] data;
    private long size = -1;

    /**
     * @param AD_Attachment_ID attachment record id
     * @param index attachment entry index (start from 0)
     * @param fileName attachment entry file name
     * @param sizeValue attachment entry uncompress size
     */
    public AttachmentDBLazyDataSource(int AD_Attachment_ID, int index, String fileName, String sizeValue) {
        this.AD_Attachment_ID = AD_Attachment_ID;
        this.index = index;
        this.fileName = fileName;
        if (!Util.isEmpty(sizeValue, true)) {
            try {
                this.size = Long.parseLong(sizeValue);
            } catch (NumberFormatException e) {
                log.log(Level.WARNING, e.getMessage(), e);
            }
        }
    }

    @Override
    public byte[] getData() {
        if (!dataLoaded.get()) {
            loadEntry(false);
        }
        if (file == null && data == null)
            return  null;

        if (file != null) {
            if (file.length() > Integer.MAX_VALUE) {
                throw new IllegalStateException("File too large to load into a byte array");
            }
            try (FileInputStream inputStream = new FileInputStream(file)) {
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                int length;
                byte[] buffer = new byte[2048];
                while ((length = inputStream.read(buffer)) != -1)
                    baos.write(buffer, 0, length);
                return baos.toByteArray();
            } catch (IOException e) {
                throw new AdempiereException(e);
            }
        } else {
            return data;
        }
    }

    @Override
    public InputStream getInputStream() {
        if (!dataLoaded.get()) {
            loadEntry(false);
        }
        if (file == null && data == null)
            return  null;
        try {
            return file != null ? new FileInputStream(file) : new ByteArrayInputStream(data);
        } catch (FileNotFoundException e) {
            throw new AdempiereException(e);
        }
    }

    @Override
    public File getFile() {
        if (!dataLoaded.get()) {
            loadEntry(false);
        }
        if (file == null && data != null) {
            Path tempDir = null;
            try {
                tempDir = Files.createTempDirectory("attachment_");
            } catch (IOException e) {
                throw new AdempiereException(e);
            }
            Path tempFile = tempDir.resolve(fileName);
            try {
                Files.copy(new ByteArrayInputStream(data), tempFile, StandardCopyOption.REPLACE_EXISTING);
            } catch (IOException e) {
                throw new AdempiereException(e);
            }
            file = tempFile.toFile();
        }
        return file;
    }

    @Override
    public void cleanUp() {
        if (file != null && file.exists()) {
            if (!file.delete())
                file.deleteOnExit();
            file = null;
        }
        if (data != null)
            data = null;
        dataLoaded.set(false);
    }

    @Override
    public long getSize() {
        if (size == -1) {
            loadEntry(true);
        }
        return size;
    }

    protected void afterDelete(int deletedIndex) {
        if (index > deletedIndex)
            index--;
    }

    private static final String AD_ATTACHMENT_ENTRY_GET = "SELECT BinaryData FROM AD_Attachment_Entry WHERE AD_Attachment_ID=? AND SeqNo=?";

    /**
     * Load attachment entry content from ad_attachment_entry table
     */
    private void loadEntry(boolean getSize) {
        if (!getSize)
            if (!dataLoaded.compareAndSet(false, true))
                return;

        Connection conn = null;
        // With Postgresql, you need to keep transaction open to access blob
        if (DB.isPostgreSQL()) {
            conn = DB.createConnection(true, Connection.TRANSACTION_READ_COMMITTED);
            try {
                conn.setAutoCommit(false);
            } catch (SQLException e) {
                try {
                    conn.close();
                } catch (SQLException e1) {
                    log.log(Level.WARNING, e1.getMessage(), e1);
                }
                throw new AdempiereException("Error setting auto commit to false", e);
            }
        }
        String sql = AD_ATTACHMENT_ENTRY_GET;
        try (PreparedStatement pstmt = conn != null
                ? DB.prepareStatement(conn, sql)
                : DB.prepareStatement(sql, null)) {
            pstmt.setInt(1, AD_Attachment_ID);
            pstmt.setInt(2, index);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Blob blob = rs.getBlob(1);
                    if (blob != null) {
                        try (InputStream inputStream = blob.getBinaryStream();
                             ZipInputStream zis = new ZipInputStream(inputStream)) {
                            ZipEntry entry = zis.getNextEntry();
                            assert entry != null;
                            if (getSize || size == -1)
                                size = entry.getSize();
                            // always load data if size is less than 2mb
                            if (size < (1024 * 1024 * 2) && size > 0) {
                                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                                int length;
                                byte[] buffer = new byte[2048];
                                while ((length = zis.read(buffer)) != -1)
                                    baos.write(buffer, 0, length);
                                data = baos.toByteArray();
                                if (getSize)
                                    dataLoaded.set(true);
                            } else if (!getSize || size == -1) { // delay loading of data for getSize call if temp file is needed
                                Path tempDir = Files.createTempDirectory("attachment_");
                                Path tempFile = tempDir.resolve(fileName);
                                Files.copy(zis, tempFile, StandardCopyOption.REPLACE_EXISTING);
                                file = tempFile.toFile();
                                // make sure size is correct
                                size = file.length();
                                if (getSize)
                                    dataLoaded.set(true);
                            }
                        } catch (SQLException e) {
                            throw new DBException("Error reading blob data", e);
                        } finally {
                            try {
                                blob.free();
                            } catch (SQLException e) {
                                log.log(Level.WARNING, e.getMessage(), e);
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            log.log(Level.SEVERE, e.getMessage(), e);
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException e1) {
                    log.log(Level.WARNING, e1.getMessage(), e1);
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.commit();
                } catch (SQLException e) {
                    log.log(Level.WARNING, e.getMessage(), e);
                }
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException e) {
                    log.log(Level.WARNING, e.getMessage(), e);
                }
                try {
                    conn.close();
                } catch (SQLException e) {
                    log.log(Level.WARNING, e.getMessage(), e);
                }
            }
        }
    }
}
