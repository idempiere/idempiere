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

package org.compiere.model;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.osgi.service.component.annotations.Component;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 * DB LOB implementation of {@link IAttachmentStore}
 */
@Component(immediate = true, service = {IAttachmentStore.class}, property = {"method=DB_LOB"})
public class AttachmentDBLOB implements IAttachmentStore
{
    private static final CLogger log = CLogger.getCLogger(AttachmentDBLOB.class);

    @Override
    public boolean loadLOBData(MAttachment attach, MStorageProvider prov) {
        //	Reset
        attach.m_items = new ArrayList<>();
        //
        byte[] data = attach.getBinaryData();
        if (data == null || data.length == 0)
            return true;

        return loadXML(attach, data);
    }

    /**
     * Load attachment entries from XML
     * @param attach attachment record
     * @param data xml meta data
     * @return true if success, false otherwise
     */
    private boolean loadXML(MAttachment attach, byte[] data) {
        NodeList entries = getEntriesFromXML(data);
        for (int i = 0; i < entries.getLength(); i++) {
            final Node entryNode = entries.item(i);
            final NamedNodeMap attributes = entryNode.getAttributes();
            final Node nameNode = attributes.getNamedItem("name");
            final Node sizeNode = attributes.getNamedItem("size");
            if(nameNode==null) {
                log.severe("No filename for entry " + i);
                attach.m_items = null;
                return false;
            }
            IAttachmentLazyDataSource ds = new AttachmentDBLazyDataSource(attach.getAD_Attachment_ID(), i, nameNode.getNodeValue(), sizeNode.getNodeValue());
            final MAttachmentEntry entry = new MAttachmentEntry(nameNode.getNodeValue(), attach.m_items.size() + 1, ds);
            attach.m_items.add(entry);
        }
        return true;
    }

    @Override
    public boolean save(MAttachment attach, MStorageProvider prov) {
        return save(attach, prov, true);
    }

    @Override
    public boolean save(MAttachment attach, MStorageProvider prov, boolean beforeSave) {

        if (attach.m_items == null || attach.m_items.isEmpty()) {
            if (beforeSave)
                attach.setBinaryData(null);
            return true;
        }

        return saveAsXML(attach, beforeSave);
    }

    /**
     * Save attachment entries as XML and store the actual binary data to ad_attachment_entry
     * @param attach attachment record
     * @param beforeSave true if calling from beforeSave of attachment record, false if calling from afterSave
     * @return true if success, false otherwise
     */
    private boolean saveAsXML(MAttachment attach, boolean beforeSave) {
        if (beforeSave) {
            final DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            try {
                final DocumentBuilder builder = factory.newDocumentBuilder();
                final Document document = builder.newDocument();
                final Element root = document.createElement("attachments");
                document.appendChild(root);
                document.setXmlStandalone(true);
                // create xml entries
                for (int i = 0; i < attach.m_items.size(); i++) {
                    if (log.isLoggable(Level.FINE)) log.fine(attach.m_items.get(i).toString());

                    final Element entry = document.createElement("entry");
                    entry.setAttribute("name", attach.getEntryName(i));
                    entry.setAttribute("size", Long.toString(attach.getEntry(i).getSize()));
                    root.appendChild(entry);
                }

                final Source source = new DOMSource(document);
                final ByteArrayOutputStream bos = new ByteArrayOutputStream();
                final Result result = new StreamResult(bos);
                final Transformer xformer = TransformerFactory.newInstance().newTransformer();
                xformer.transform(source, result);
                final byte[] xmlData = bos.toByteArray();
                if (log.isLoggable(Level.FINE)) log.fine(bos.toString());
                attach.setBinaryData(xmlData);
                attach.setTitle(MAttachment.XML);
                return true;
            } catch (Exception e) {
                log.log(Level.SEVERE, "saveLOBData", e);
            }
            attach.setBinaryData(null);
            return false;
        } else {
            try {
                for (int i = 0; i < attach.m_items.size(); i++) {
                    insertOrReplace(attach, i);
                }
            } catch (Exception e) {
                log.log(Level.SEVERE, e.getMessage(), e);
                return false;
            }
            return true;
        }
    }

    private static final String AD_ATTACHMENT_ENTRY_GET = "SELECT BinaryData FROM AD_Attachment_Entry WHERE AD_Attachment_ID=? AND SeqNo=?";

    private static final String AD_ATTACHMENT_ENTRY_INSERT = "INSERT INTO AD_Attachment_Entry(AD_Attachment_ID, SeqNo, BinaryData) Values (?, ?, ?)";

    private static final String AD_ATTACHMENT_ENTRY_DELETE = "DELETE FROM AD_Attachment_Entry WHERE AD_Attachment_ID=? AND SeqNo=?";

    private static final String AD_ATTACHMENT_ENTRIES_DELETE = "DELETE FROM AD_Attachment_Entry WHERE AD_Attachment_ID=?";

    private static final String AD_ATTACHMENT_AFTER_ENTRY_DELETE = "UPDATE AD_Attachment_Entry SET SeqNo=SeqNo-1 WHERE AD_Attachment_ID=? AND SeqNo > ?";

    /**
     * Insert or update attachment entry (ad_attachment_entry)
     * @param attach attachment record
     * @param index entry index
     */
    private void insertOrReplace(MAttachment attach, int index) {
        Connection conn = null;
        // With Postgresql, you need to keep transaction open to access blob
        if (attach.get_TrxName() == null && DB.isPostgreSQL()) {
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

        // try to find existing blob
        String sql = AD_ATTACHMENT_ENTRY_GET;
        //ORA-22920: row containing the LOB value is not locked prior to update
        if (DB.isOracle())
            sql += " FOR UPDATE ";
        boolean updateBlob = false;
        try (PreparedStatement pstmt = conn != null
                ? DB.prepareStatement(conn, sql)
                : DB.prepareStatement(sql, attach.get_TrxName())) {
            pstmt.setInt(1, attach.getAD_Attachment_ID());
            pstmt.setInt(2, index);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    if (attach.m_items.get(index).isUpdated()) {
                        File entryFile = attach.m_items.get(index).getFile();
                        if (entryFile == null) {
                            throw new AdempiereException("Attachment file not found: " + attach.getEntryName(index));
                        }
                        updateBlob = true;
                        Blob blob = rs.getBlob(1);
                        try (ZipOutputStream zos = new ZipOutputStream(blob.setBinaryStream(1));
                             InputStream inputStream = new FileInputStream(entryFile)) {
                            ZipEntry zipEntry = new ZipEntry(entryFile.getName());
                            zipEntry.setSize(entryFile.length());
                            zos.putNextEntry(zipEntry);
                            byte[] buffer = new byte[2048];
                            int length;
                            while ((length = inputStream.read(buffer)) != -1) {
                                zos.write(buffer, 0, length);
                            }
                        } finally {
                            blob.free();
                        }
                    }
                    if (updateBlob && conn != null)
                    {
                        try {
                            conn.commit();
                        } catch (SQLException e) {
                            throw new DBException(e);
                        }
                    }
                    return;
                }
            }
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    log.log(Level.WARNING, ex.getMessage(), ex);
                }
            }
            throw new AdempiereException(e);
        } finally {
            if (conn != null)
            {
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

        // no existing blob found, create a new one
        sql = AD_ATTACHMENT_ENTRY_INSERT;
        File entryFile = attach.m_items.get(index).getFile();
        if (entryFile == null) {
            throw new AdempiereException("Attachment file not found: " + attach.getEntryName(index));
        }

        // compress to temp file
        Path tempFile = null;
        try {
            try {
                Path tempDir = Files.createTempDirectory("attachment_");
                tempFile = tempDir.resolve(entryFile.getName() + ".zip");
                try (ZipOutputStream zos = new ZipOutputStream(Files.newOutputStream(tempFile))) {
                    ZipEntry zipEntry = new ZipEntry(entryFile.getName());
                    zipEntry.setSize(entryFile.length());
                    zos.putNextEntry(zipEntry);
                    byte[] buffer = new byte[2048];
                    int length;
                    try (InputStream inputStream = new FileInputStream(entryFile)) {
                        while ((length = inputStream.read(buffer)) != -1) {
                            zos.write(buffer, 0, length);
                        }
                    }
                }
            } catch (Exception e) {
                throw new AdempiereException(e);
            }
            // insert compress temp file to db
            try (PreparedStatement pstmt = conn != null
                    ? DB.prepareStatement(conn, sql)
                    : DB.prepareStatement(sql, attach.get_TrxName())) {
                pstmt.setInt(1, attach.getAD_Attachment_ID());
                pstmt.setInt(2, index);
                try (FileInputStream inputStream = new FileInputStream(tempFile.toFile())) {
                    pstmt.setBlob(3, inputStream);
                    pstmt.executeUpdate();
                }
            } catch (Exception e) {
                if (conn != null) {
                    try {
                        conn.rollback();
                    } catch (SQLException ex) {
                        log.log(Level.WARNING, ex.getMessage(), ex);
                    }
                }
                throw new AdempiereException(e);
            }
            if (conn != null) {
                try {
                    conn.commit();
                } catch (SQLException e) {
                    throw new DBException(e);
                }
            }
        } finally {
            if (conn != null)
            {
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
            if (tempFile != null) {
                File f = tempFile.toFile();
                if (f.exists()) {
                    if (!f.delete())
                        f.deleteOnExit();
                }
            }
        }
    }

    /**
     * Get the entries from the XML
     * @param data xml meta data
     * @return xml node list
     */
    private NodeList getEntriesFromXML(byte[] data) {
        NodeList entries = null;
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
            final DocumentBuilder builder = factory.newDocumentBuilder();
            final Document document = builder.parse(new ByteArrayInputStream(data));
            entries = document.getElementsByTagName("entry");
        } catch (SAXException sxe) {
            // Error generated during parsing)
            Exception x = sxe;
            if (sxe.getException() != null)
                x = sxe.getException();
            log.log(Level.SEVERE, x.getMessage(), x);

        } catch (ParserConfigurationException pce) {
            // Parser with specified options can't be built
            log.log(Level.SEVERE, pce.getMessage(), pce);

        } catch (IOException ioe) {
            // I/O error
            log.log(Level.SEVERE, ioe.getMessage(), ioe);
        }
        return entries;
    }

    @Override
    public boolean delete(MAttachment attach, MStorageProvider prov) {
        DB.executeUpdateEx(AD_ATTACHMENT_ENTRIES_DELETE, new Object[] {attach.getAD_Attachment_ID()}, attach.get_TrxName());
        return true;
    }

    @Override
    public boolean deleteEntry(MAttachment attach, MStorageProvider provider, int index) {
        DB.executeUpdateEx(AD_ATTACHMENT_ENTRY_DELETE, new Object[] {attach.getAD_Attachment_ID(), index}, attach.get_TrxName());
        DB.executeUpdateEx(AD_ATTACHMENT_AFTER_ENTRY_DELETE, new Object[] {attach.getAD_Attachment_ID(), index}, attach.get_TrxName());
        attach.m_items.remove(index);
        for (MAttachmentEntry entry : attach.m_items) {
            IAttachmentLazyDataSource ds = entry.getLazyDataSource();
            if (ds instanceof AttachmentDBLazyDataSource adds)
                adds.afterDelete(index);
        }
        return true;
    }
}
