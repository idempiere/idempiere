/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.               *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *                                                                            *
 * Copyright (C)                                                              *
 * 2004 Robert KLEIN. robeklein@hotmail.com                                   *
 * Contributor(s): Low Heng Sin hengsin@avantz.com                            *
 *                 Teo Sarca teo.sarca@arhipac.ro, SC ARHIPAC SERVICE SRL     *
 *****************************************************************************/
package org.adempiere.pipo2;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.sax.SAXTransformerFactory;
import javax.xml.transform.sax.TransformerHandler;
import javax.xml.transform.stream.StreamResult;

import org.compiere.model.MClient;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

import org.adempiere.exceptions.AdempiereException;

/**
 *	Convert AD to XML
 *
 *  @author Robert Klein
 *  @version $Id: PackOut.java,v 1.0
 *
 * Contributor: William G. Heath - Export of workflows and dynamic validations
 *
 * @author Teo Sarca, SC ARHIPAC SERVICE SRL
 * 			<li>BF [ 1819315 ] PackOut: fix xml indentation not working
 * 			<li>BF [ 1819319 ] PackOut: use just active AD_Package_Exp_Detail lines
 */

public class PackOut
{
	/*** 1.0.0 **/
	public final static String PackOutVersion = "100";
	private final static CLogger log = CLogger.getCLogger(PackOut.class);

	private static final String TRX_NAME_CTX_KEY = "TrxName";
	public static final String PACK_OUT_PROCESS_CTX_KEY = "PackOutProcess";

    private Properties localContext = null;
	private String packageDirectory;
	private int blobCount = 0;

	private IHandlerRegistry handlerRegistry = new OSGiHandlerRegistry();
	private PackoutItem packoutItem;
	private String trxName;
	private PackoutDocument packoutDocument;
	private int processedCount;
	private String exportFile;
	private String packoutDirectory;

	public static final int MAX_OFFICIAL_ID = MTable.MAX_OFFICIAL_ID;

	public static void addTextElement(TransformerHandler handler, String qName, String text, AttributesImpl atts) throws SAXException {
		handler.startElement("", "", qName, atts);
		append(handler, text);
		handler.endElement("", "", qName);
	}

	private static void append(TransformerHandler handler, String str) throws SAXException
	{
		char[] contents = str != null ? str.toCharArray() : new char[0];
		handler.characters(contents,0,contents.length);
	}

	/**
	 * Start the transformation to XML
	 * @param packoutDirectory
	 * @param destinationPath
	 * @param packoutDocument
	 * @param packoutItems
	 * @param trxName
	 * @throws java.lang.Exception
	 */
	public void export(String packoutDirectory, String destinationPath, PackoutDocument packoutDocument, List<PackoutItem> packoutItems, String trxName) throws java.lang.Exception
	{
		this.packoutDirectory = packoutDirectory;
		this.packoutDocument = packoutDocument;
		this.trxName = trxName;

		initContext();

		OutputStream  docStream = null;
		OutputStream  packoutStream = null;

		processedCount = 0;
		try {
			packageDirectory = packoutDirectory+ packoutDocument.getPackageName();
			File docDirectoryFile = new File(packageDirectory+File.separator+"doc"+File.separator);
			if (!docDirectoryFile.exists()) {
				boolean success = docDirectoryFile.mkdirs();
				if (!success) {
					throw new AdempiereException("Failed to create directory for pack out. " + packageDirectory+File.separator+"doc"+File.separator);
				}
			}
			String docFileName = packageDirectory+File.separator+"doc"+File.separator+packoutDocument.getPackageName()+"Doc.xml";
			docStream = new FileOutputStream (docFileName, false);
			TransformerHandler docHandler = createDocHandler(docStream);

			String packoutFileName = packageDirectory+File.separator+ "dict"+File.separator+"PackOut.xml";
			packoutStream = new FileOutputStream (packoutFileName, false);
			TransformerHandler packoutHandler = createPackoutHandler(packoutStream);

			for(PackoutItem packoutItem : packoutItems){
				this.packoutItem = packoutItem;
				String type = packoutItem.getType();

				ElementHandler handler = handlerRegistry.getHandler(type);
				if (handler != null)
					handler.packOut(this,packoutHandler,docHandler,packoutItem.getRecordId());
				else
					throw new IllegalArgumentException("Packout handler not found for type " + type);

				processedCount++;
			}

			packoutHandler.endElement("","","adempiereAD");
			packoutHandler.endDocument();
			docHandler.endElement("","","adempiereDocument");
			docHandler.endDocument();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE,e.getLocalizedMessage(), e);
			throw e;
		}
		finally
		{
			// Close streams - teo_sarca [ 1704762 ]
			if (docStream != null)
				try {
					docStream.close();
				} catch (Exception e) {}
			if (packoutStream != null)
				try {
					packoutStream.close();
				} catch (Exception e) {}
		}

		//create compressed packages
		//set the files
		File srcFolder = new File(packoutDirectory);
		File destZipFile = null;
		if (destinationPath != null && destinationPath.trim().length() > 0)
		{
			destZipFile = new File(destinationPath);
		} else {
			destZipFile = new File(packageDirectory+".zip");
		}
		//delete the old packages if necessary
		destZipFile.delete();

		//create the compressed packages
		String includesdir = packoutDocument.getPackageName() + File.separator +"**";
		Zipper.zipFolder(srcFolder, destZipFile, includesdir);
		exportFile = destZipFile.getAbsolutePath();
	}	//	doIt

	private TransformerHandler createPackoutHandler(
			OutputStream packoutStream) throws UnsupportedEncodingException, TransformerConfigurationException, SAXException {
		StreamResult packoutStreamResult = new StreamResult(new OutputStreamWriter(packoutStream,"UTF-8"));
		SAXTransformerFactory packoutFactory = (SAXTransformerFactory) SAXTransformerFactory.newInstance();
		packoutFactory.setAttribute("indent-number", new Integer(4));
		TransformerHandler packoutHandler = packoutFactory.newTransformerHandler();
		Transformer packoutTransformer = packoutHandler.getTransformer();
		packoutTransformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
		packoutTransformer.setOutputProperty(OutputKeys.INDENT,"yes");
		packoutHandler.setResult(packoutStreamResult);
		packoutHandler.startDocument();
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("","","Name","CDATA",packoutDocument.getPackageName());
		atts.addAttribute("","","Version","CDATA",packoutDocument.getPackageVersion());
		atts.addAttribute("","","AdempiereVersion","CDATA",packoutDocument.getAdempiereVersion());
		atts.addAttribute("","","DataBaseVersion","CDATA",packoutDocument.getDatabaseVersion());
		atts.addAttribute("","","Description","CDATA",emptyIfNull(packoutDocument.getDescription()));
		atts.addAttribute("","","Author","CDATA",packoutDocument.getAuthor());
		atts.addAttribute("","","AuthorEmail","CDATA",emptyIfNull(packoutDocument.getAuthorEmail()));
		atts.addAttribute("","","CreatedDate","CDATA",packoutDocument.getCreated().toString());
		atts.addAttribute("","","UpdatedDate","CDATA",packoutDocument.getUpdated().toString());
		atts.addAttribute("","","PackOutVersion","CDATA",PackOutVersion);

		MClient client = MClient.get(localContext);
		StringBuffer sb = new StringBuffer ()
			.append(client.get_ID())
			.append("-")
			.append(client.getValue())
			.append("-")
			.append(client.getName());
		atts.addAttribute("", "", "Client", "CDATA", sb.toString());

		packoutHandler.startElement("","","adempiereAD",atts);
		return packoutHandler;
	}

	private String emptyIfNull(String input) {
		return input != null ? input : "";
	}

	private TransformerHandler createDocHandler(OutputStream docStream) throws UnsupportedEncodingException, TransformerConfigurationException, SAXException {
		StreamResult docStreamResult = new StreamResult(new OutputStreamWriter(docStream,"UTF-8"));
		SAXTransformerFactory transformerFactory = (SAXTransformerFactory) SAXTransformerFactory.newInstance();
		transformerFactory.setAttribute("indent-number", new Integer(4));
		TransformerHandler docHandler = transformerFactory.newTransformerHandler();
		Transformer transformer = docHandler.getTransformer();
		transformer.setOutputProperty(OutputKeys.ENCODING,"UTF-8");
		transformer.setOutputProperty(OutputKeys.INDENT,"yes");
		docHandler.setResult(docStreamResult);
		docHandler.startDocument();
		docHandler.processingInstruction("xml-stylesheet","type=\"text/css\" href=\"adempiereDocument.css\"");
		AttributesImpl atts = new AttributesImpl();
		docHandler.startElement("","","adempiereDocument",atts);
		addTextElement(docHandler, "header", packoutDocument.getPackageName()+" Package Description", atts);
		addTextElement(docHandler, "H1", "Package Name:", atts);
		addTextElement(docHandler, "packagename", packoutDocument.getPackageName(), atts);
		addTextElement(docHandler, "H1", "Author:", atts);
		addTextElement(docHandler, "Name:", packoutDocument.getAuthor(), atts);
		addTextElement(docHandler, "H1", "Email Address:", atts);
		addTextElement(docHandler, "Email", packoutDocument.getAuthorEmail(), atts);
		addTextElement(docHandler, "H1", "Created:", atts);
		addTextElement(docHandler, "Date", packoutDocument.getCreated().toString(), atts);
		addTextElement(docHandler, "H1", "Updated:", atts);
		addTextElement(docHandler, "Date", packoutDocument.getUpdated().toString(), atts);
		addTextElement(docHandler, "H1", "Description:", atts);
		addTextElement(docHandler, "description", packoutDocument.getDescription(), atts);
		addTextElement(docHandler, "H1", "Instructions:", atts);
		addTextElement(docHandler, "instructions", packoutDocument.getInstructions(), atts);
		addTextElement(docHandler, "H1", "Files in Package:", atts);
		addTextElement(docHandler, "file", "File: PackOut.xml", atts);
		addTextElement(docHandler, "filedirectory", "Directory: \\dict\\", atts);
		addTextElement(docHandler, "filenotes", "Notes: Contains all application/object settings for package", atts);

		MClient client = MClient.get(localContext);
		StringBuffer sb = new StringBuffer ()
			.append(client.get_ID())
			.append("-")
			.append(client.getValue())
			.append("-")
			.append(client.getName());
		addTextElement(docHandler, "H1", "Client:", atts);
		addTextElement(docHandler, "Client", sb.toString(), atts);

		File packageDictDirFile = new File(packageDirectory+File.separator+ "dict"+File.separator);
		if (!packageDictDirFile.exists()) {
			boolean success = packageDictDirFile.mkdirs();
			if (!success)
				throw new AdempiereException("Failed to create directory. " + packageDirectory+File.separator+ "dict"+File.separator);
		}
		return docHandler;
	}

	private void initContext() {
		Properties tmp = new Properties();
		if (getCtx() != null)
			tmp.putAll(getCtx());
		if (trxName != null)
			tmp.put(TRX_NAME_CTX_KEY, trxName);
		tmp.put(PACK_OUT_PROCESS_CTX_KEY, this);
		localContext = tmp;
	}

	/**
	 * @param sourceName
	 * @param destName
	 */
	public void copyFile (String sourceName, String destName ) {
		InputStream source = null;  // Stream for reading from the source file.
		OutputStream copy= null;   // Stream for writing the copy.
		boolean force;  // This is set to true if the "-f" option
		//    is specified on the command line.
		int byteCount;  // Number of bytes copied from the source file.

		force = true;
		try {
			source = new FileInputStream(sourceName);
		} catch (FileNotFoundException e) {
			System.out.println("Can't find file \"" + sourceName + "\".");
			return;
		}

		try {
			File file = new File(destName);
			if (file.exists() && force == false) {
				System.out.println("Output file exists. Use the -f option to replace it.");
				return;
			}
			try {
				copy = new FileOutputStream(destName, false);
			} catch (IOException e) {
				System.out.println("Can't open output file \""
						+ destName + "\".");
				return;
			}
			byteCount = 0;
			try {
				while (true) {
					int data = source.read();
					if (data < 0)
						break;
					copy.write(data);
					byteCount++;
				}
				source.close();
				copy.close();
				System.out.println("Successfully copied " + byteCount + " bytes.");
			} catch (Exception e) {
				System.out.println("Error occurred while copying.  "+ byteCount + " bytes copied.");
				System.out.println(e.toString());
			}
		} finally {
			if (source != null) {
				try {
					source.close();
				} catch (IOException e) {}
			}
			if (copy != null) {
				try {
					copy.close();
				} catch (IOException e) {}
			}
		}
	}

	public Properties getCtx() {
		return localContext != null ? localContext : Env.getCtx();
	}

	/**
	 * @param data
	 * @return
	 * @throws IOException
	 */
	public String writeBlob(byte[] data) throws IOException {
		blobCount++;
		String fileName = blobCount + ".dat";
		File path = new File(packageDirectory+File.separator+"blobs"+File.separator);
		path.mkdirs();
		File file = new File(path, fileName);
		FileOutputStream os = null;
		try {
			os = new FileOutputStream(file);
			os.write(data);
			os.flush();
		} finally {
			if (os != null) {
				try {
					os.close();
				} catch (IOException e) {}
			}
		}
		return fileName;
	}

	/**
	 * @return MPackageExpDetail
	 */
	public PackoutItem getCurrentPackoutItem() {
		return packoutItem;
	}

	/**
	 *
	 * @return PackoutDocument
	 */
	public PackoutDocument getPackoutDocument() {
		return packoutDocument;
	}

	public String getPackoutDirectory() {
		return packoutDirectory;
	}

	/**
	 * @param name
	 * @return ElementHandler
	 */
	public ElementHandler getHandler(String name) {
		return handlerRegistry.getHandler(name);
	}

	/**
	 * @return number of records exported
	 */
	public int getExportCount() {
		return processedCount;
	}

	/**
	 * @return absolute path for export file
	 */
	public String getExportFile() {
		return exportFile;
	}
}	//	PackOut
