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
import org.compiere.util.Util;
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
	
	@Override
	public boolean save(MAttachment attach,MStorageProvider prov) {
		String attachmentPathRoot = getAttachmentPathRoot(prov);
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
				if (log.isLoggable(Level.FINE)) log.fine(attach.m_items.get(i).toString());
				File entryFile = attach.m_items.get(i).getFile();
				final String path = entryFile.getAbsolutePath();
				// if local file - copy to central attachment folder
				if (log.isLoggable(Level.FINE)) log.fine(path + " - " + attachmentPathRoot);
				if (!path.startsWith(attachmentPathRoot)) {
					if (log.isLoggable(Level.FINE)) log.fine("move file: " + path);
					FileChannel in = null;
					FileChannel out = null;
					FileInputStream fis = null;
					FileOutputStream fos = null;
					try {
						//create destination folder
						StringBuilder msgfile = new StringBuilder().append(attachmentPathRoot).append(File.separator).append(getAttachmentPathSnippet(attach));
						final File destFolder = new File(msgfile.toString());
						if(!destFolder.exists()){
							if(!destFolder.mkdirs()){
								log.warning("unable to create folder: " + destFolder.getPath());
							}
						}
						msgfile = new StringBuilder().append(attachmentPathRoot).append(File.separator)
								.append(getAttachmentPathSnippet(attach)).append(File.separator).append(entryFile.getName());
						final File destFile = new File(msgfile.toString());
						fis = new FileInputStream(entryFile);
						in = fis.getChannel();
						fos = new FileOutputStream(destFile);
						out = fos.getChannel();
						in.transferTo(0, in.size(), out);
						/* IDEMPIERE-2864
						if(entryFile.exists()){
							if(!entryFile.delete()){
								entryFile.deleteOnExit();
							}
						}*/
						entryFile = destFile;

					} catch (IOException e) {
						e.printStackTrace();
						log.severe("unable to copy file " + entryFile.getAbsolutePath() + " to "
								+ attachmentPathRoot + File.separator + 
								getAttachmentPathSnippet(attach) + File.separator + entryFile.getName());
					} finally {
						if (fis != null) {
							try{
								fis.close();
							}catch(Exception e) {
								//do nothing
							}
						}
						if (fos != null) {
							try{
								fos.close();
							}catch(Exception e) {
								//do nothing
							}
						}
					}
				}
				final Element entry = document.createElement("entry");
				//entry.setAttribute("name", m_items.get(i).getName());
				entry.setAttribute("name", attach.getEntryName(i));
				String filePathToStore = entryFile.getAbsolutePath();
				filePathToStore = filePathToStore.replaceFirst(attachmentPathRoot.replaceAll("\\\\","\\\\\\\\"), attach.ATTACHMENT_FOLDER_PLACEHOLDER);
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
			if (log.isLoggable(Level.FINE)) log.fine(bos.toString());
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
		String attachmentPathRoot = getAttachmentPathRoot(prov);
		if (Util.isEmpty(attachmentPathRoot)) {
			log.severe("no attachmentPath defined");
			return false;
		}
		// Reset
		attach.m_items = new ArrayList<MAttachmentEntry>();
		//
		byte[] data = attach.getBinaryData();
		if (data == null)
			return true;
		if (log.isLoggable(Level.FINE)) log.fine("TextFileSize=" + data.length);
		if (data.length == 0)
			return true;

		try {
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
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
				if (log.isLoggable(Level.FINE)) log.fine("name: " + nameNode.getNodeValue());
				String filePath = fileNode.getNodeValue();
				if (log.isLoggable(Level.FINE)) log.fine("filePath: " + filePath);
				if(filePath!=null){
					filePath = filePath.replaceFirst(attach.ATTACHMENT_FOLDER_PLACEHOLDER, attachmentPathRoot.replaceAll("\\\\","\\\\\\\\"));
					//just to be shure...
					String replaceSeparator = File.separator;
					if(!replaceSeparator.equals("/")){
						replaceSeparator = "\\\\";
					}
					filePath = filePath.replaceAll("/", replaceSeparator);
					filePath = filePath.replaceAll("\\\\", replaceSeparator);
				}
				if (log.isLoggable(Level.FINE)) log.fine("filePath: " + filePath);
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
					final MAttachmentEntry entry = new MAttachmentEntry(file.getName(),
							dataEntry, attach.m_items.size() + 1);
					attach.m_items.add(entry);
				} else {
					log.severe("file not found: " + file.getAbsolutePath());
					attach.m_items.add(new MAttachmentEntry("~" + file.getName()  + "~", "".getBytes(), attach.m_items.size() + 1));
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
	public boolean delete(MAttachment attach, MStorageProvider provider) {
		String attachmentPathRoot = getAttachmentPathRoot(provider);
		final File folder = new File(attachmentPathRoot + getAttachmentPathSnippet(attach));
		//delete all attachment files and folder
		while (attach.m_items.size() > 0) {
			deleteEntry(attach, provider, attach.m_items.size()-1);
		}
		if (folder.exists()) {
			if (!folder.delete()) {
				log.warning("unable to delete " + folder.getAbsolutePath());
			}
		}
		return true;
	}

	@Override
	public boolean deleteEntry(MAttachment attach, MStorageProvider provider, int index) {
		String attachmentPathRoot = getAttachmentPathRoot(provider);
		final File folder = new File(attachmentPathRoot + getAttachmentPathSnippet(attach));
		//remove files
		final MAttachmentEntry entry = attach.m_items.get(index);
		final File file = new File(folder, entry.getName());
		if (log.isLoggable(Level.FINE)) log.fine("delete: " + file.getAbsolutePath());
		if (file != null && file.exists()) {
			if (!file.delete()) {
				log.warning("unable to delete " + file.getAbsolutePath());
			}
		}
		attach.m_items.remove(index);
		if (attach.get_ID() > 0) // the attachment has not been deleted
			attach.saveEx(); // must save here as the operation cannot be rolled back on filesystem
		if (log.isLoggable(Level.CONFIG)) log.config("Index=" + index + " - NewSize=" + attach.m_items.size());
		return true;
	}

	private String getAttachmentPathRoot(MStorageProvider prov) {
		String attachmentPathRoot = prov.getFolder();
		if (attachmentPathRoot == null)
			attachmentPathRoot = "";
		if (Util.isEmpty(attachmentPathRoot)) {
			log.severe("no attachmentPath defined");
		} else if (!attachmentPathRoot.endsWith(File.separator)){
			attachmentPathRoot = attachmentPathRoot + File.separator;
			log.fine(attachmentPathRoot);
		}
		return attachmentPathRoot;
	}

}
