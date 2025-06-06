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

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.logging.Level;

public class AttachmentDBLazyDataSource implements IAttachmentLazyDataSource {

    private static final org.compiere.util.CLogger log = CLogger.getCLogger(AttachmentDBLazyDataSource.class);

    private final int AD_Attachment_ID;
    private final int index;
    private final String fileName;
    private AtomicBoolean sizeLoaded = new AtomicBoolean(false);
    private AtomicBoolean dataLoaded = new AtomicBoolean(false);
    private File file;
    private byte[] data;
    private long size = 0;

    public AttachmentDBLazyDataSource(int AD_Attachment_ID, int index, String fileName) {
        this.AD_Attachment_ID = AD_Attachment_ID;
        this.index = index;
        this.fileName = fileName;
    }

    @Override
    public byte[] getData() {
        if (!dataLoaded.get()) {
            loadEntry(false);
        }
        if (file == null && data == null)
            return  null;

        if (file != null) {
            try (FileInputStream inputStream = new FileInputStream(file)) {
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                int length = 0;
                byte[] buffer = new byte[2048];
                while ((length = inputStream.read(buffer)) != -1)
                    baos.write(buffer, 0, length);
                return baos.toByteArray();
            } catch (FileNotFoundException e) {
                throw new AdempiereException(e);
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
    public long getSize() {
        if (!sizeLoaded.get() && !dataLoaded.get()) {
            loadEntry(true);
        }
        return size;
    }

    private static final String AD_ATTACHMENT_ENTRY_GET = "SELECT BinaryData FROM AD_Attachment_Entry WHERE AD_Attachment_ID=? AND SeqNo=?";

    /**
     * Load attachment entry content from ad_attachment_entry table
     * @return attachment entry file or null
     */
    private void loadEntry(boolean getSize) {
        if (getSize) {
            if (!sizeLoaded.compareAndSet(false, true))
                return;
        } else {
            if (!dataLoaded.compareAndSet(false, true))
                return;
        }

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
                        size = blob.length();
                        if (!getSize && !sizeLoaded.get())
                            sizeLoaded.set(true);
                        if (dataLoaded.get())
                            return;
                        // always load data if size is less than 2mb
                        if (size < (1024 * 1024 * 2)) {
                            ByteArrayOutputStream baos = new ByteArrayOutputStream();
                            try (InputStream inputStream = blob.getBinaryStream()) {
                                int length = 0;
                                byte[] buffer = new byte[2048];
                                while ((length = inputStream.read(buffer)) != -1)
                                    baos.write(buffer, 0, length);
                                data = baos.toByteArray();
                                if (getSize)
                                    dataLoaded.set(true);
                            } catch (SQLException e) {
                                throw new DBException("Error reading blob data", e);
                            } finally {
                                try {
                                    blob.free();
                                } catch (SQLException e) {
                                }
                            }
                        } else if (!getSize) { // delay loading of data for getSize call if temp file is needed
                            Path tempDir = Files.createTempDirectory("attachment_");
                            try (InputStream inputStream = blob.getBinaryStream()) {
                                Path tempFile = tempDir.resolve(fileName);
                                Files.copy(inputStream, tempFile);
                                file = tempFile.toFile();
                            } catch (SQLException e) {
                                throw new DBException("Error reading blob data", e);
                            } finally {
                                try {
                                    blob.free();
                                } catch (SQLException e) {
                                }
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
                }
            }
        } finally {
            if (conn != null) {
                try {
                    conn.commit();
                } catch (SQLException e) {
                }
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException e) {
                }
                try {
                    conn.close();
                } catch (SQLException e) {
                }
            }
        }
    }
}
