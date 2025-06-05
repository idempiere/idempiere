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

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.zip.Deflater;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.w3c.dom.*;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

/**
 * DB backed implementation of {@link IAttachmentStore}
 */
public class AttachmentDBSystem implements IAttachmentStore 
{	
	/** Indicator for zip data  */
	public static final String 	ZIP = MAttachment.ZIP;
	private static final CLogger log = CLogger.getCLogger(AttachmentDBSystem.class);

	@Override
	public boolean loadLOBData(MAttachment attach, MStorageProvider prov) {
		//	Reset
		attach.m_items = new ArrayList<MAttachmentEntry>();
        //
        byte[] data = attach.getBinaryData();
        if (data == null || data.length == 0)
            return true;
        if (log.isLoggable(Level.FINE)) log.fine("ZipSize=" + data.length);

        if (ZIP.equals(attach.getTitle()))
            return loadZip(attach, data);
        else if (MAttachment.XML.equals(attach.getTitle()))
            return loadXML(attach, data);
        else
        //	Old Format - single file
        {
            attach.m_items.add (new MAttachmentEntry(attach.getTitle(), data, 1));
            return true;
        }
    }

    /**
     * Load attachment entries from zip content
     * @param attach
     * @param data
     * @return true if succss, false otherwise
     */
    private boolean loadZip(MAttachment attach, byte[] data) {
        try
        {
            ByteArrayInputStream in = new ByteArrayInputStream(data);
            ZipInputStream zip = new ZipInputStream (in);
            ZipEntry entry = zip.getNextEntry();
            while (entry != null)
            {
                String name = entry.getName();
                ByteArrayOutputStream out = new ByteArrayOutputStream();
                byte[] buffer = new byte[2048];
                int length = zip.read(buffer);
                while (length != -1)
                {
                    out.write(buffer, 0, length);
                    length = zip.read(buffer);
                }
                //
                byte[] dataEntry = out.toByteArray();
                if (log.isLoggable(Level.FINE)) log.fine(name
                    + " - size=" + dataEntry.length + " - zip="
                    + entry.getCompressedSize() + "(" + entry.getSize() + ") "
                    + (entry.getCompressedSize()*100/entry.getSize())+ "%");
                //
                attach.m_items.add (new MAttachmentEntry (name, dataEntry, attach.m_items.size()+1));
                entry = zip.getNextEntry();
            }
        }
        catch (Exception e)
        {
            log.log(Level.SEVERE, "loadLOBData", e);
            attach.m_items = null;
            return false;
        }
        return true;
    }

    /**
     * Load attachment entries from XML
     * @param attach
     * @param data
     * @return true if success, false otherwise
     */
    private boolean loadXML(MAttachment attach, byte[] data) {
        NodeList entries = getEntriesFromXML(data);
        for (int i = 0; i < entries.getLength(); i++) {
            final Node entryNode = entries.item(i);
            final NamedNodeMap attributes = entryNode.getAttributes();
            final Node nameNode = attributes.getNamedItem("name");
            if(nameNode==null){
                log.severe("No filename for entry " + i);
                attach.m_items = null;
                return false;
            }
            if (log.isLoggable(Level.FINE)) log.fine("name: " + nameNode.getNodeValue());
            IAttachmentLazyDataSource ds = new AttachmentDBLazyDataSource(attach.getAD_Attachment_ID(), i, nameNode.getNodeValue());
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

        if (attach.m_items == null || attach.m_items.size() == 0) {
            if (beforeSave)
                attach.setBinaryData(null);
            return true;
        }

        if (MAttachment.ZIP.equals(attach.getTitle()) && beforeSave) {
            if (saveAsZip(attach)) {
                return true;
            } else {
                attach.setBinaryData(null);
                return false;
            }
        } else {
            return saveAsXML(attach, beforeSave);
        }
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
                    File entryFile = attach.m_items.get(i).getFile();
                    if (entryFile == null) {
                        throw new AdempiereException("Attachment file not found: " + attach.getEntryName(i));
                    }

                    insertOrReplace(attach, i, entryFile);
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

    /**
     * Insert or update attachment entry (ad_attachment_entry)
     * @param attach
     * @param index entry index
     * @param entryFile
     */
    private void insertOrReplace(MAttachment attach, int index, File entryFile) {
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
                }
                throw new AdempiereException("Error setting auto commit to false", e);
            }
        }

        // try to find existing blob
        String sql = AD_ATTACHMENT_ENTRY_GET;
        boolean updateBlob = false;
        try (PreparedStatement pstmt = conn != null
                ? DB.prepareStatement(conn, sql)
                : DB.prepareStatement(sql, attach.get_TrxName())) {
            pstmt.setInt(1, attach.getAD_Attachment_ID());
            pstmt.setInt(2, index);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    updateBlob = true;
                    Blob blob = rs.getBlob(1);
                    try (OutputStream os = blob.setBinaryStream(1);
                         InputStream inputStream = new FileInputStream(entryFile)) {
                        byte[] buffer = new byte[2048];
                        int length = 0;
                        while ((length = inputStream.read(buffer)) != -1) {
                            os.write(buffer, 0, length);
                        }
                    } finally {
                        blob.free();
                    }
                    return;
                }
            }
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                }
            }
            throw new AdempiereException(e);
        } finally {
            if (updateBlob && conn != null)
            {
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

        // no existing blob found, create a new one
        sql = AD_ATTACHMENT_ENTRY_INSERT;
        try {
            try (PreparedStatement pstmt = conn != null
                    ? DB.prepareStatement(conn, sql)
                    : DB.prepareStatement(sql, attach.get_TrxName())) {
                pstmt.setInt(1, attach.getAD_Attachment_ID());
                pstmt.setInt(2, index);
                try (FileInputStream inputStream = new FileInputStream(entryFile)) {
                    pstmt.setBlob(3, inputStream);
                    pstmt.executeUpdate();
                }
            } catch (Exception e) {
                if (conn != null) {
                    try {
                        conn.rollback();
                    } catch (SQLException ex) {
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
                }
                try {
                    conn.close();
                } catch (SQLException e) {
                }
            }
        }
    }

    /**
     * Get the entries from the XML
     * @param data
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
            x.printStackTrace();
            log.severe(x.getMessage());

        } catch (ParserConfigurationException pce) {
            // Parser with specified options can't be built
            pce.printStackTrace();
            log.severe(pce.getMessage());

        } catch (IOException ioe) {
            // I/O error
            ioe.printStackTrace();
            log.severe(ioe.getMessage());
        }
        return entries;
    }

    /**
     * Save attachment entries as single zip file
     * @param attach
     * @return true if success, false otherwise
     */
    private boolean saveAsZip(MAttachment attach) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        ZipOutputStream zip = new ZipOutputStream(out);
        zip.setMethod(ZipOutputStream.DEFLATED);
        zip.setLevel(Deflater.BEST_COMPRESSION);
        zip.setComment("iDempiere");
        //
        try
        {
            for (int i = 0; i < attach.m_items.size(); i++)
            {
                MAttachmentEntry item = attach.getEntry(i);
                ZipEntry entry = new ZipEntry(item.getName());
                entry.setTime(System.currentTimeMillis());
                entry.setMethod(ZipEntry.DEFLATED);
                zip.putNextEntry(entry);
                byte[] data = item.getData();
                zip.write (data, 0, data.length);
                zip.closeEntry();
                if (log.isLoggable(Level.FINE)) log.fine(entry.getName() + " - "
                    + entry.getCompressedSize() + " (" + entry.getSize() + ") "
                    + (entry.getCompressedSize()*100/entry.getSize())+ "%");
            }
            zip.close();
            byte[] zipData = out.toByteArray();
            if (log.isLoggable(Level.FINE)) log.fine("Length=" +  zipData.length);
            attach.setBinaryData(zipData);
            attach.setTitle(MAttachment.ZIP);
            return true;
        }
        catch (Exception e)
        {
            log.log(Level.SEVERE, "saveLOBData", e);
        }
        return false;
    }

    @Override
	public boolean delete(MAttachment attach, MStorageProvider prov) {
		if (MAttachment.XML.equals(attach.getTitle())) {
            DB.executeUpdateEx(AD_ATTACHMENT_ENTRIES_DELETE, new Object[] {attach.getAD_Attachment_ID()}, attach.get_TrxName());
        }
		return true;
	}

	@Override
	public boolean deleteEntry(MAttachment attach, MStorageProvider provider, int index) {
        if (MAttachment.XML.equals(attach.getTitle())) {
            DB.executeUpdateEx(AD_ATTACHMENT_ENTRY_DELETE, new Object[] {attach.getAD_Attachment_ID(), index}, attach.get_TrxName());
        }
		attach.m_items.remove(index);
		return true;
	}
	
}
