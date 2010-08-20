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

import org.compiere.model.I_AD_Form;
import org.compiere.model.I_AD_ImpFormat;
import org.compiere.model.I_AD_Menu;
import org.compiere.model.I_AD_Message;
import org.compiere.model.I_AD_PrintFormat;
import org.compiere.model.I_AD_Process;
import org.compiere.model.I_AD_Reference;
import org.compiere.model.I_AD_ReportView;
import org.compiere.model.I_AD_Role;
import org.compiere.model.I_AD_Table;
import org.compiere.model.I_AD_Val_Rule;
import org.compiere.model.I_AD_Window;
import org.compiere.model.I_AD_Workflow;
import org.compiere.model.MClient;
import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.process.SvrProcess;
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

public class PackOut extends SvrProcess
{
	private static final String TRX_NAME_CTX_KEY = "TrxName";
	public static final String PACK_OUT_PROCESS_CTX_KEY = "PackOutProcess";
	/** Record ID				*/
	private int p_PackOut_ID = 0;
	private String PackOutVer = "005";

    private Properties localContext = null;
	private MPackageExp packageExp;
	private MPackageExpDetail packageExpDetail;
	private String packOutDir;
	private String packageDir;
	private int blobCount = 0;

	private IHandlerRegistry handlerRegistry = null;
	
	public static final int MAX_OFFICIAL_ID = MTable.MAX_OFFICIAL_ID;
	
    /**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		p_PackOut_ID = getRecord_ID();
	}	//	prepare

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
	 * 	Start the transformation to XML
	 *	@return info
	 *	@throws Exception
	 */

	protected String doIt() throws java.lang.Exception
	{
		initContext();

		handlerRegistry = new OSGiHandlerRegistry();

		OutputStream  packageDocStream = null;
		OutputStream  packOutDocStream = null;
		log.info("doIt - AD_PACKAGE_EXP_ID=" + p_PackOut_ID);

		if (p_PackOut_ID == 0)
			throw new IllegalArgumentException("No Record");

		int processedCount = 0;
		try {

			packageExp = new MPackageExp(getCtx(), p_PackOut_ID, get_TrxName());

			if (packageExp.getAD_Package_Exp_ID() == p_PackOut_ID){
				//Create the package documentation
				packOutDir = packageExp.getFile_Directory().trim();
				if (!packOutDir.endsWith("/") && !packOutDir.endsWith("\\"))
					packOutDir+= File.separator;
				packageDir = packOutDir+ packageExp.getName();
				File packageDocDirFile = new File(packageDir+File.separator+"doc"+File.separator);
				if (!packageDocDirFile.exists()) {
					boolean success = packageDocDirFile.mkdirs();
					if (!success) {
						throw new AdempiereException("Failed to create directory for pack out. " + packageDir+File.separator+"doc"+File.separator);
					}
				}
				String docFileName = packageDir+File.separator+"doc"+File.separator+packageExp.getName()+"Doc.xml";
				packageDocStream = new FileOutputStream (docFileName, false);
				TransformerHandler packageDocument = createPackageDoc(packageExp, packageDocStream);

				String packOutFileName = packageDir+File.separator+ "dict"+File.separator+"PackOut.xml";
				packOutDocStream = new FileOutputStream (packOutFileName, false);
				TransformerHandler packOutDocument = createPackOutDoc(packageExp, packOutDocStream);

				Query query = new Query(getCtx(), MTable.get(getCtx(), X_AD_Package_Exp_Detail.Table_ID), "AD_Package_Exp_ID = ?", get_TrxName());
				List<MPackageExpDetail> packageExpDetails = query.setOnlyActiveRecords(true)
																 .setOrderBy("Line")
																 .setParameters(new Object[]{p_PackOut_ID})
																 .list();
				for(MPackageExpDetail dtl : packageExpDetails){
					packageExpDetail = dtl;
					String type = packageExpDetail.getType();
					log.info(Integer.toString(packageExpDetail.getLine()));

					ElementHandler handler = handlerRegistry.getHandler(getTypeName(type));
					if (handler != null)
						handler.packOut(this,packOutDocument,packageDocument,dtl.getExpRecordId());
					else
						throw new IllegalArgumentException("Packout handler not found for type " + type);

					processedCount++;
				}

				packOutDocument.endElement("","","adempiereAD");
				packOutDocument.endDocument();
				packageDocument.endElement("","","adempiereDocument");
				packageDocument.endDocument();

			}
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE,e.getLocalizedMessage(), e);
			throw e;
		}
		finally
		{
			// Close streams - teo_sarca [ 1704762 ]
			if (packageDocStream != null)
				try {
					packageDocStream.close();
				} catch (Exception e) {}
			if (packOutDocStream != null)
				try {
					packOutDocStream.close();
				} catch (Exception e) {}
		}

		//create compressed packages
		//set the files
		File srcFolder = new File(packOutDir);
		File destZipFile = new File(packageDir+".zip");

		//delete the old packages if necessary
		destZipFile.delete();

		//create the compressed packages
		String includesdir = packageExp.getName() + File.separator +"**";
		Zipper.zipFolder(srcFolder, destZipFile, includesdir);

		return "Exported="+processedCount + " File=" + destZipFile.getAbsolutePath();
	}	//	doIt

	private TransformerHandler createPackOutDoc(MPackageExp packageExp,
			OutputStream packOutDocStream) throws UnsupportedEncodingException, TransformerConfigurationException, SAXException {
		StreamResult packOutStreamResult = new StreamResult(new OutputStreamWriter(packOutDocStream,"utf-8"));
		SAXTransformerFactory packOutFactory = (SAXTransformerFactory) SAXTransformerFactory.newInstance();
		packOutFactory.setAttribute("indent-number", new Integer(4));
		TransformerHandler packOutDocument = packOutFactory.newTransformerHandler();
		Transformer packOutTransformer = packOutDocument.getTransformer();
		packOutTransformer.setOutputProperty(OutputKeys.ENCODING,"ISO-8859-1");
		packOutTransformer.setOutputProperty(OutputKeys.INDENT,"yes");
		packOutDocument.setResult(packOutStreamResult);
		packOutDocument.startDocument();
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("","","Name","CDATA",packageExp.getName());
		atts.addAttribute("","","Version","CDATA",packageExp.getPK_Version());
		atts.addAttribute("","","AdempiereVersion","CDATA",packageExp.getReleaseNo());
		atts.addAttribute("","","DataBase","CDATA",packageExp.getVersion());
		atts.addAttribute("","","Description","CDATA",packageExp.getDescription());
		atts.addAttribute("","","Creator","CDATA",packageExp.getUserName());
		atts.addAttribute("","","CreatorContact","CDATA",packageExp.getEMail());
		atts.addAttribute("","","CreatedDate","CDATA",packageExp.getCreated().toString());
		atts.addAttribute("","","UpdatedDate","CDATA",packageExp.getUpdated().toString());
		atts.addAttribute("","","PackOutVersion","CDATA",PackOutVer);

		MClient client = MClient.get(localContext);
		StringBuffer sb = new StringBuffer ()
			.append(client.get_ID())
			.append("-")
			.append(client.getValue())
			.append("-")
			.append(client.getName());
		atts.addAttribute("", "", "Client", "CDATA", sb.toString());

		packOutDocument.startElement("","","adempiereAD",atts);
		return packOutDocument;
	}

	private TransformerHandler createPackageDoc(MPackageExp packageExp, OutputStream packageDocStream) throws UnsupportedEncodingException, TransformerConfigurationException, SAXException {
		StreamResult docStreamResult = new StreamResult(new OutputStreamWriter(packageDocStream,"utf-8"));
		SAXTransformerFactory transformerFactory = (SAXTransformerFactory) SAXTransformerFactory.newInstance();
		transformerFactory.setAttribute("indent-number", new Integer(4));
		TransformerHandler packageDocument = transformerFactory.newTransformerHandler();
		Transformer transformer = packageDocument.getTransformer();
		transformer.setOutputProperty(OutputKeys.ENCODING,"ISO-8859-1");
		transformer.setOutputProperty(OutputKeys.INDENT,"yes");
		packageDocument.setResult(docStreamResult);
		packageDocument.startDocument();
		packageDocument.processingInstruction("xml-stylesheet","type=\"text/css\" href=\"adempiereDocument.css\"");
		AttributesImpl atts = new AttributesImpl();
		packageDocument.startElement("","","adempiereDocument",atts);
		addTextElement(packageDocument, "header", packageExp.getName()+" Package Description", atts);
		addTextElement(packageDocument, "H1", "Package Name:", atts);
		addTextElement(packageDocument, "packagename", packageExp.getName(), atts);
		addTextElement(packageDocument, "H1", "Author:", atts);
		addTextElement(packageDocument, "creator", packageExp.getUserName(), atts);
		addTextElement(packageDocument, "H1", "Email Address:", atts);
		addTextElement(packageDocument, "creatorcontact", packageExp.getEMail(), atts);
		addTextElement(packageDocument, "H1", "Created:", atts);
		addTextElement(packageDocument, "createddate", packageExp.getCreated().toString(), atts);
		addTextElement(packageDocument, "H1", "Updated:", atts);
		addTextElement(packageDocument, "updateddate", packageExp.getUpdated().toString(), atts);
		addTextElement(packageDocument, "H1", "Description:", atts);
		addTextElement(packageDocument, "description", packageExp.getDescription(), atts);
		addTextElement(packageDocument, "H1", "Instructions:", atts);
		addTextElement(packageDocument, "instructions", packageExp.getInstructions(), atts);
		addTextElement(packageDocument, "H1", "Files in Package:", atts);
		addTextElement(packageDocument, "file", "File: PackOut.xml", atts);
		addTextElement(packageDocument, "filedirectory", "Directory: \\dict\\", atts);
		addTextElement(packageDocument, "filenotes", "Notes: Contains all application/object settings for package", atts);

		MClient client = MClient.get(localContext);
		StringBuffer sb = new StringBuffer ()
			.append(client.get_ID())
			.append("-")
			.append(client.getValue())
			.append("-")
			.append(client.getName());
		addTextElement(packageDocument, "H1", "Client:", atts);
		addTextElement(packageDocument, "Client", sb.toString(), atts);

		File packageDictDirFile = new File(packageDir+File.separator+ "dict"+File.separator);
		if (!packageDictDirFile.exists()) {
			boolean success = packageDictDirFile.mkdirs();
			if (!success)
				throw new AdempiereException("Failed to create directory. " + packageDir+File.separator+ "dict"+File.separator);
		}
		return packageDocument;
	}

	private String getTypeName(String type) {
		if (X_AD_Package_Exp_Detail.TYPE_ApplicationOrModule.equals(type))
			return I_AD_Menu.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_CodeSnipit.equals(type))
			return "Code_Snipit";
		else if (X_AD_Package_Exp_Detail.TYPE_Data.equals(type))
			return IHandlerRegistry.TABLE_GENERIC_HANDLER;
		else if (X_AD_Package_Exp_Detail.TYPE_DynamicValidationRule.equals(type))
			return I_AD_Val_Rule.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_File_CodeOrOther.equals(type))
			return "Dist_File";
		else if (X_AD_Package_Exp_Detail.TYPE_Form.equals(type))
			return I_AD_Form.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_ImportFormat.equals(type))
			return I_AD_ImpFormat.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Message.equals(type))
			return I_AD_Message.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_PrintFormat.equals(type))
			return I_AD_PrintFormat.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_ProcessReport.equals(type))
			return I_AD_Process.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Reference.equals(type))
			return I_AD_Reference.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_ReportView.equals(type))
			return I_AD_ReportView.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Role.equals(type))
			return I_AD_Role.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_SQLStatement.equals(type))
			return "SQL_Statement";
		else if (X_AD_Package_Exp_Detail.TYPE_Table.equals(type))
			return I_AD_Table.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Window.equals(type))
			return I_AD_Window.Table_Name;
		else if (X_AD_Package_Exp_Detail.TYPE_Workflow.equals(type))
			return I_AD_Workflow.Table_Name;

		return type;
	}

	private void initContext() {
		Properties tmp = new Properties();
		if (getCtx() != null)
			tmp.putAll(getCtx());
		tmp.put(TRX_NAME_CTX_KEY, get_TrxName());
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

	@Override
	public Properties getCtx() {
		return localContext != null ? localContext : super.getCtx();
	}

	/**
	 * @param data
	 * @return
	 * @throws IOException
	 */
	public String writeBlob(byte[] data) throws IOException {
		blobCount++;
		String fileName = blobCount + ".dat";
		File path = new File(packageDir+File.separator+"blobs"+File.separator);
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
	 * @return MPackageExp
	 */
	public MPackageExp getPackageExp() {
		return packageExp;
	}

	/**
	 * @return MPackageExpDetail
	 */
	public MPackageExpDetail getPackageExpDetail() {
		return packageExpDetail;
	}

	/**
	 * @param name
	 * @return ElementHandler
	 */
	public ElementHandler getHandler(String name) {
		return handlerRegistry.getHandler(name);
	}
}	//	PackOut
