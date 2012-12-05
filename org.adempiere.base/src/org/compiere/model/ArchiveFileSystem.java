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

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.logging.Level;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Source;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.Result;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;

import org.compiere.util.CLogger;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import org.w3c.dom.Element;

/**
 * @author juliana
 *
 */
public class ArchiveFileSystem implements IArchiveStore {
	
	private  String ARCHIVE_FOLDER_PLACEHOLDER = "%ARCHIVE_FOLDER%";
	
	private final CLogger log = CLogger.getCLogger(getClass());


	/* (non-Javadoc)
	 * @see org.compiere.model.IArchiveStore#loadLOBData(org.compiere.model.MArchive, org.compiere.model.MStorageProvider)
	 */
	@Override
	public byte[] loadLOBData(MArchive archive, MStorageProvider prov) {
		if ("".equals(archive.m_archivePathRoot)) {
			throw new IllegalArgumentException("no attachmentPath defined");
		}
		byte[] data = archive.getByteData();
		archive.m_deflated = null; 
		archive.m_inflated = null;
		if (data == null) {
			return null;
		}

		final DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

		try {
			final DocumentBuilder builder = factory.newDocumentBuilder();
			final Document document = builder.parse(new ByteArrayInputStream(data));
			final NodeList entries = document.getElementsByTagName("entry");
			if(entries.getLength()!=1){
				log.severe("no archive entry found");
			}
				final Node entryNode = entries.item(0);
				final NamedNodeMap attributes = entryNode.getAttributes();
				final Node	 fileNode = attributes.getNamedItem("file");
				if(fileNode==null ){
					log.severe("no filename for entry");
					return null;
				}
				String filePath = fileNode.getNodeValue();
				log.fine("filePath: " + filePath);
				if(filePath!=null){
					filePath = filePath.replaceFirst(ARCHIVE_FOLDER_PLACEHOLDER, archive.m_archivePathRoot.replaceAll("\\\\","\\\\\\\\"));
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
					return dataEntry;
				} else {
					log.severe("file not found: " + file.getAbsolutePath());
					return null;
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
		
		return null;
	}

	/* (non-Javadoc)
	 * @see org.compiere.model.IArchiveStore#save(org.compiere.model.MArchive, org.compiere.model.MStorageProvider)
	 */
	@Override
	public void  save(MArchive archive, MStorageProvider prov,byte[] inflatedData) {
		if ("".equals(archive.m_archivePathRoot)) {
			throw new IllegalArgumentException("no attachmentPath defined");
		}
		if (inflatedData == null || inflatedData.length == 0) {
			throw new IllegalArgumentException("InflatedData is NULL");
		}
		if(archive.get_ID()==0){
			//set binary data otherwise save will fail
			archive.setByteData(new byte[]{'0'});
			if(!archive.save()) {
				throw new IllegalArgumentException("unable to save MArchive");
			}
		}
		final DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		BufferedOutputStream out = null;
		try {
			// create destination folder
			StringBuilder msgfile = new StringBuilder().append(archive.m_archivePathRoot).append(File.separator)
					.append(archive.getArchivePathSnippet());
			final File destFolder = new File(msgfile.toString());
			if (!destFolder.exists()) {
				if (!destFolder.mkdirs()) {
					log.warning("unable to create folder: " + destFolder.getPath());
				}
			}
			// write to pdf
			msgfile = new StringBuilder().append(archive.m_archivePathRoot).append(File.separator)
					.append(archive.getArchivePathSnippet()).append(archive.get_ID()).append(".pdf");
			final File destFile = new File(msgfile.toString());

			out = new BufferedOutputStream(new FileOutputStream(destFile));
			out.write(inflatedData);
			out.flush();

			//create xml entry
			final DocumentBuilder builder = factory.newDocumentBuilder();
			final Document document = builder.newDocument();
			final Element root = document.createElement("archive");
			document.appendChild(root);
			document.setXmlStandalone(true);
			final Element entry = document.createElement("entry");
			StringBuilder msgsat = new StringBuilder(ARCHIVE_FOLDER_PLACEHOLDER).append(archive.getArchivePathSnippet()).append(archive.get_ID()).append(".pdf");
			entry.setAttribute("file", msgsat.toString());
			root.appendChild(entry);
			final Source source = new DOMSource(document);
			final ByteArrayOutputStream bos = new ByteArrayOutputStream();
			final Result result = new StreamResult(bos);
			final Transformer xformer = TransformerFactory.newInstance().newTransformer();
			xformer.transform(source, result);
			final byte[] xmlData = bos.toByteArray();
			log.fine(bos.toString());
			//store xml in db
			archive.setByteData(xmlData);

		} catch (Exception e) {
			log.log(Level.SEVERE, "saveLOBData", e);
			archive.m_deflated = null;
			archive.setByteData(null);
		} finally {
			if(out != null){
				try {
					out.close();
				} catch (Exception e) {	}
			}
		}

	}

}
