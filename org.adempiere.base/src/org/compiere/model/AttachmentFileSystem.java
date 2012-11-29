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
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.logging.Level;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.compiere.util.CLogger;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 * @author juliana
 *
 */
public class AttachmentFileSystem implements IAttachmentStore {
	
	private final CLogger log = CLogger.getCLogger(getClass());
	
	public String m_attachmentPathRoot;

	@Override
	public boolean save(MAttachment attach,MStorageProvider prov) {
		
		/*if(File.separatorChar == '\\'){
			m_attachmentPathRoot = prov.getWi;
		} else {
			m_attachmentPathRoot = prov.getUnixAttachmentPath();
		}*/
		m_attachmentPathRoot=prov.getFolder();
		if("".equals(m_attachmentPathRoot)){
			log.severe("no attachmentPath defined");
		} else if (!m_attachmentPathRoot.endsWith(File.separator)){
			m_attachmentPathRoot = m_attachmentPathRoot + File.separator;
			log.fine(m_attachmentPathRoot);
		}

		if (attach.m_items == null || attach.m_items.size() == 0) {
			attach.setBinaryData(null);
			return true;
		}
		final DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		try {
			final DocumentBuilder builder = factory.newDocumentBuilder();
			final Document document = builder.newDocument();
			final Element root = document.createElement("attachments");
			document.appendChild(root);
			document.setXmlStandalone(true);
			// create xml entries
			for (int i = 0; i < attach.m_items.size(); i++) {
				log.fine(attach.m_items.get(i).toString());
				File entryFile = attach.m_items.get(i).getFile();
				final String path = entryFile.getAbsolutePath();
				// if local file - copy to central attachment folder
				log.fine(path + " - " + attach.m_attachmentPathRoot);
				if (!path.startsWith(attach.m_attachmentPathRoot)) {
					log.fine("move file: " + path);
					FileChannel in = null;
					FileChannel out = null;
					try {
						//create destination folder
						StringBuilder msgfile = new StringBuilder().append(attach.m_attachmentPathRoot).append(File.separator).append(getAttachmentPathSnippet(attach));
						final File destFolder = new File(msgfile.toString());
						if(!destFolder.exists()){
							if(!destFolder.mkdirs()){
								log.warning("unable to create folder: " + destFolder.getPath());
							}
						}
						msgfile = new StringBuilder().append(attach.m_attachmentPathRoot).append(File.separator)
								.append(getAttachmentPathSnippet(attach)).append(File.separator).append(entryFile.getName());
						final File destFile = new File(msgfile.toString());
						in = new FileInputStream(entryFile).getChannel();
						out = new FileOutputStream(destFile).getChannel();
						in.transferTo(0, in.size(), out);
						in.close();
						out.close();
						if(entryFile.exists()){
							if(!entryFile.delete()){
								entryFile.deleteOnExit();
							}
						}
						entryFile = destFile;

					} catch (IOException e) {
						e.printStackTrace();
						log.severe("unable to copy file " + entryFile.getAbsolutePath() + " to "
								+ attach.m_attachmentPathRoot + File.separator + 
								getAttachmentPathSnippet(attach) + File.separator + entryFile.getName());
					} finally {
						if (in != null && in.isOpen()) {
							in.close();
						}
						if (out != null && out.isOpen()) {
							out.close();
						}
					}
				}
				final Element entry = document.createElement("entry");
				//entry.setAttribute("name", m_items.get(i).getName());
				entry.setAttribute("name", attach.getEntryName(i));
				String filePathToStore = entryFile.getAbsolutePath();
				filePathToStore = filePathToStore.replaceFirst(attach.m_attachmentPathRoot.replaceAll("\\\\","\\\\\\\\"), attach.ATTACHMENT_FOLDER_PLACEHOLDER);
				log.fine(filePathToStore);
				entry.setAttribute("file", filePathToStore);
				root.appendChild(entry);
			}

			final Source source = new DOMSource(document);
			final ByteArrayOutputStream bos = new ByteArrayOutputStream();
			final Result result = new StreamResult(bos);
			final Transformer xformer = TransformerFactory.newInstance().newTransformer();
			xformer.transform(source, result);
			final byte[] xmlData = bos.toByteArray();
			log.fine(bos.toString());
			attach.setBinaryData(xmlData);
			attach.setTitle(MAttachment.XML);
			return true;
		} catch (Exception e) {
			log.log(Level.SEVERE, "saveLOBData", e);
		}
		attach.setBinaryData(null);
		return false;

	}
	
	@Override
	public boolean loadLOBData(MAttachment attach,MStorageProvider prov) {
		if("".equals(attach.m_attachmentPathRoot)){
			log.severe("no attachmentPath defined");
			return false;
		}
		// Reset
		attach.m_items = new ArrayList<MAttachmentEntry>();
		//
		byte[] data = attach.getBinaryData();
		if (data == null)
			return true;
		log.fine("TextFileSize=" + data.length);
		if (data.length == 0)
			return true;

		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

		try {
			final DocumentBuilder builder = factory.newDocumentBuilder();
			final Document document = builder.parse(new ByteArrayInputStream(data));
			final NodeList entries = document.getElementsByTagName("entry");
			for (int i = 0; i < entries.getLength(); i++) {
				final Node entryNode = entries.item(i);
				final NamedNodeMap attributes = entryNode.getAttributes();
				final Node fileNode = attributes.getNamedItem("file");
				final Node nameNode = attributes.getNamedItem("name");
				if(fileNode==null || nameNode==null){
					log.severe("no filename for entry " + i);
					attach.m_items = null;
					return false;
				}
				log.fine("name: " + nameNode.getNodeValue());
				String filePath = fileNode.getNodeValue();
				log.fine("filePath: " + filePath);
				if(filePath!=null){
					filePath = filePath.replaceFirst(attach.ATTACHMENT_FOLDER_PLACEHOLDER, attach.m_attachmentPathRoot.replaceAll("\\\\","\\\\\\\\"));
					//just to be shure...
					String replaceSeparator = File.separator;
					if(!replaceSeparator.equals("/")){
						replaceSeparator = "\\\\";
					}
					filePath = filePath.replaceAll("/", replaceSeparator);
					filePath = filePath.replaceAll("\\\\", replaceSeparator);
				}
				log.fine("filePath: " + filePath);
				final File file = new File(filePath);
				if (file.exists()) {
					// read files into byte[]
					final byte[] dataEntry = new byte[(int) file.length()];
					try {
						final FileInputStream fileInputStream = new FileInputStream(file);
						fileInputStream.read(dataEntry);
						fileInputStream.close();
					} catch (FileNotFoundException e) {
						log.severe("File Not Found.");
						e.printStackTrace();
					} catch (IOException e1) {
						log.severe("Error Reading The File.");
						e1.printStackTrace();
					}
					final MAttachmentEntry entry = new MAttachmentEntry(filePath,
							dataEntry, attach.m_items.size() + 1);
					attach.m_items.add(entry);
				} else {
					log.severe("file not found: " + file.getAbsolutePath());
				}
			}

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

		return true;
	}

	/**
	 * Returns a path snippet, containing client, org, table and record id.
	 * @return String
	 */
	private String getAttachmentPathSnippet(MAttachment attach){
		
		StringBuilder msgreturn = new StringBuilder().append(attach.getAD_Client_ID()).append(File.separator)
				.append(attach.getAD_Org_ID()).append(File.separator)
				.append(attach.getAD_Table_ID()).append(File.separator).append(attach.getRecord_ID());
		return msgreturn.toString();
	}

	@Override
	public boolean delete(MAttachment attach, MStorageProvider prov) {
		//delete all attachment files and folder
		for (int i=0; i < attach.m_items.size(); i++) {
			final MAttachmentEntry entry = attach.m_items.get(i);
			final File file = entry.getFile();
			if (file !=null && file.exists()) {
				if (!file.delete()) {
					log.warning("unable to delete " + file.getAbsolutePath());
				}
			}
		}
		final File folder = new File(m_attachmentPathRoot + getAttachmentPathSnippet(attach));
		if (folder.exists()) {
			if (!folder.delete()) {
				log.warning("unable to delete " + folder.getAbsolutePath());
			}
		}
		return true;
	}

	@Override
	public boolean deleteEntry(MAttachment attach, MStorageProvider provider, int index) {
		//remove files
		final MAttachmentEntry entry = attach.m_items.get(index);
		final File file = entry.getFile();
		log.fine("delete: " + file.getAbsolutePath());
		if (file != null && file.exists()) {
			if (!file.delete()) {
				log.warning("unable to delete " + file.getAbsolutePath());
			}
		}
		attach.m_items.remove(index);
		log.config("Index=" + index + " - NewSize=" + attach.m_items.size());
		return true;
	}
	
}
