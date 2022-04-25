/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.install;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.adempiere.base.Core;
import org.compiere.Adempiere;
import org.compiere.model.MLanguage;
import org.compiere.model.MPInstance;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.process.ProcessCall;
import org.compiere.process.ProcessInfo;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.eclipse.equinox.app.IApplication;
import org.eclipse.equinox.app.IApplicationContext;
import org.w3c.dom.Document;
import org.w3c.dom.Element;


/**
 *	Translation Table Import + Export
 *
 * 	@author 	Jorg Janke
 * 	@version 	$Id: Translation.java,v 1.3 2006/07/30 00:51:28 jjanke Exp $
 */
public class Translation implements IApplication
{
	/**
	 * 	Translation
	 *	@param ctx context
	 */
	public Translation (Properties ctx)
	{
		m_ctx = ctx;
	}	//	Translation

	/**
	 * Do not use this Constructor in normal calls. It is used e.g. by the
	 * headless call for an only-translation batch script call.
	 * 
	 * author tbayen - IDEMPIERE-1554
	 */
	public Translation(){
		m_ctx=Env.getCtx();
	}
	
	/**	DTD						*/
	public static final String DTD = "<!DOCTYPE idempiereTrl PUBLIC \"-//ComPiere, Inc.//DTD iDempiere Translation 1.0//EN\" \"http://www.idempiere.com/dtd/idempiereTrl.dtd\">";
	/**	XML Element Tag			*/
	public static final String	XML_TAG = "idempiereTrl";
	public static final String	XML_TAG2 = "adempiereTrl";
	public static final String	XML_TAG3 = "compiereTrl";
	/**	XML Attribute Table			*/
	public static final String	XML_ATTRIBUTE_TABLE = "table";
	/** XML Attribute Language		*/
	public static final String	XML_ATTRIBUTE_LANGUAGE = "language";

	/**	XML Row Tag					*/
	public static final String	XML_ROW_TAG = "row";
	/** XML Row Attribute ID		*/
	public static final String	XML_ROW_ATTRIBUTE_ID = "id";
	/** XML Row Attribute UUID		*/
	public static final String	XML_ROW_ATTRIBUTE_UUID = "uuid";
	/** XML Row Attribute Translated	*/
	public static final String	XML_ROW_ATTRIBUTE_TRANSLATED = "trl";

	/**	XML Value Tag				*/
	public static final String	XML_VALUE_TAG = "value";
	/** XML Value Column			*/
	public static final String	XML_VALUE_ATTRIBUTE_COLUMN = "column";
	/** XML Value Original			*/
	public static final String	XML_VALUE_ATTRIBUTE_ORIGINAL = "original";

	/**	Table is centrally maintained	*/
	private boolean			m_IsCentrallyMaintained = false;
	/**	Logger						*/
	private static final CLogger	log = CLogger.getCLogger(Translation.class);
	/** Properties					*/
	private Properties		m_ctx = null;

	/**
	 * 	Import Translation.
	 * 	Uses TranslationHandler to update translation
	 *	@param directory file directory
	 * 	@param AD_Client_ID only certain client if id &gt;= 0
	 * 	@param AD_Language language
	 * 	@param Trl_Table table
	 * 	@return status message
	 */
	public String importTrl (String directory, int AD_Client_ID, String AD_Language, String Trl_Table)
	{
		return importTrl(directory, AD_Client_ID, AD_Language, Trl_Table, null);
	}

	/**
	 * 	Import Translation.
	 * 	Uses TranslationHandler to update translation
	 *	@param directory file directory
	 * 	@param AD_Client_ID only certain client if id &gt;= 0
	 * 	@param AD_Language language
	 * 	@param Trl_Table table
	 *  @param trxName Transaction
	 * 	@return status message
	 */
	public String importTrl (String directory, int AD_Client_ID, String AD_Language, String Trl_Table, String trxName)
	{
		String fileName = directory + File.separator + Trl_Table + "_" + AD_Language + ".xml";
		log.info(fileName);
		File in = new File (fileName);
		if (!in.exists())
		{
			String msg = "File does not exist: " + fileName;
			log.log(Level.SEVERE, msg);
			return msg;
		}

		try
		{
			TranslationHandler handler = new TranslationHandler(AD_Client_ID, trxName);
			SAXParserFactory factory = SAXParserFactory.newInstance();
		//	factory.setValidating(true);
			SAXParser parser = factory.newSAXParser();
			parser.parse(in, handler);
			if (log.isLoggable(Level.INFO)) log.info("Updated=" + handler.getUpdateCount());
			MLanguage langCached = MLanguage.get(m_ctx, AD_Language);
			MLanguage lang = new MLanguage(m_ctx, langCached.getAD_Language_ID(), null);
			if (! lang.isLoginLocale()) {
				lang.setIsLoginLocale(true);
				lang.saveEx();
			}
			return Msg.getMsg(m_ctx, "Updated") + "=" + handler.getUpdateCount();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "importTrl", e);
			return e.toString();
		}
	}	//	importTrl

	
	/**************************************************************************
	 * 	Import Translation
	 *	@param directory file directory
	 * 	@param AD_Client_ID only certain client if id &gt;= 0
	 * 	@param AD_Language language
	 * 	@param Trl_Table translation table _Trl
	 * 	@return status message
	 */
	public String exportTrl (String directory, int AD_Client_ID, String AD_Language, String Trl_Table, boolean onlyCentralized)
	{
		String fileName = directory + File.separator + Trl_Table + "_" + AD_Language + ".xml";
		log.info(fileName);
		File out = new File(fileName);

		boolean isBaseLanguage = Language.isBaseLanguage(AD_Language);
		String tableName = Trl_Table;
		int pos = tableName.indexOf("_Trl");
		String Base_Table = Trl_Table.substring(0, pos);
		if (isBaseLanguage)
			tableName =  Base_Table;

		if (onlyCentralized) {
			if (MTable.get(m_ctx, tableName).getAD_Table_ID() > MTable.MAX_OFFICIAL_ID)
				return "";
		}

		String keyColumn = Base_Table + "_ID";
		String uuidColumn = MTable.getUUIDColumnName(Base_Table);
		String[] trlColumns = getTrlColumns (Base_Table);
		//
		StringBuilder sql = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			//	System.out.println(factory.getClass().getName());
			DocumentBuilder builder = factory.newDocumentBuilder();
			//	<!DOCTYPE idempiereTrl SYSTEM "http://www.idempiere.org/dtd/idempiereTrl.dtd">
			//	<!DOCTYPE idempiereTrl PUBLIC "-//ComPiere, Inc.//DTD iDempiere Translation 1.0//EN" "http://www.idempiere.com/dtd/idempiereTrl.dtd">
			Document document = builder.newDocument();
			document.appendChild(document.createComment(Adempiere.getSummaryAscii()));
			document.appendChild(document.createComment(DTD));

			//	Root
			Element root = document.createElement(XML_TAG);
			root.setAttribute(XML_ATTRIBUTE_LANGUAGE, AD_Language);
			root.setAttribute(XML_ATTRIBUTE_TABLE, Base_Table);
			document.appendChild(root);
			//
			sql = new StringBuilder ("SELECT ");
			if (isBaseLanguage)
				sql.append("'Y',");							//	1
			else
				sql.append("t.IsTranslated,");
			sql.append("t.").append(keyColumn);				//	2
			sql.append(", o.").append(uuidColumn);			//	3
			//
			for (int i = 0; i < trlColumns.length; i++)
				sql.append(", t.").append(trlColumns[i])
					.append(",o.").append(trlColumns[i]).append(" AS ").append(trlColumns[i]).append("O");
			//
			sql.append(" FROM ").append(tableName).append(" t")
				.append(" INNER JOIN ").append(Base_Table)
				.append(" o ON (t.").append(keyColumn).append("=o.").append(keyColumn).append(")");
			boolean haveWhere = false;
			if (!isBaseLanguage)
			{
				sql.append(" WHERE t.AD_Language=?");
				haveWhere = true;
			}
			if (m_IsCentrallyMaintained)
			{
				sql.append (haveWhere ? " AND " : " WHERE ").append ("o.IsCentrallyMaintained='N'");
				haveWhere = true;
			}
			if (AD_Client_ID >= 0)
				sql.append(haveWhere ? " AND " : " WHERE ").append("o.AD_Client_ID=").append(AD_Client_ID);

			if (onlyCentralized)
				sql.append(haveWhere ? " AND " : " WHERE ").append(" o.").append(keyColumn).append("<=").append(MTable.MAX_OFFICIAL_ID).append(" AND o.IsActive = 'Y'");

			sql.append(" ORDER BY t.").append(keyColumn);
			//
			pstmt = DB.prepareStatement(sql.toString(), null);
			if (!isBaseLanguage)
				pstmt.setString(1, AD_Language);
			rs = pstmt.executeQuery();
			int rows = 0;
			while (rs.next())
			{
				Element row = document.createElement (XML_ROW_TAG);
				int keyid = rs.getInt(2);
				String uuid = rs.getString(3);
				if (keyid <= MTable.MAX_OFFICIAL_ID || Util.isEmpty(uuid)) {
					row.setAttribute(XML_ROW_ATTRIBUTE_ID, String.valueOf(keyid));	//	KeyColumn
				} else {
					row.setAttribute(XML_ROW_ATTRIBUTE_UUID, String.valueOf(uuid));	//	UUIDColumn
				}
				row.setAttribute(XML_ROW_ATTRIBUTE_TRANSLATED, rs.getString(1));		//	IsTranslated
				for (int i = 0; i < trlColumns.length; i++)
				{
					Element value = document.createElement (XML_VALUE_TAG);
					value.setAttribute(XML_VALUE_ATTRIBUTE_COLUMN, trlColumns[i]);
					String origString = rs.getString(trlColumns[i] + "O");			//	Original Value
					if (origString == null)
						origString = "";
					String valueString = rs.getString(trlColumns[i]);				//	Value
					if (valueString == null)
						valueString = "";
					value.setAttribute(XML_VALUE_ATTRIBUTE_ORIGINAL, origString);
					if (valueString.indexOf("<") != -1 || valueString.indexOf(">") != -1 || valueString.indexOf("&") != -1) {
						value.setAttributeNS(XMLConstants.XML_NS_URI, "space", "preserve");
						value.appendChild(document.createCDATASection(valueString));
					} else {
						value.appendChild(document.createTextNode(valueString));
					}
					row.appendChild(value);
				}
				root.appendChild(row);
				rows++;
			}
			if (log.isLoggable(Level.INFO)) log.info("Records=" + rows 
				+ ", DTD=" + document.getDoctype()
				+ " - " + Trl_Table);
			//
			DOMSource source = new DOMSource(document);
			TransformerFactory tFactory = TransformerFactory.newInstance();
			tFactory.setAttribute("indent-number", Integer.valueOf(1)); // teo_sarca [ 1705883 ]
			Transformer transformer = tFactory.newTransformer();
			transformer.setOutputProperty(OutputKeys.INDENT, "yes"); // teo_sarca [ 1705883 ]
			//	Output, wrapped with a writer - teo_sarca [ 1705883 ]
			out.createNewFile();
			Writer writer = new OutputStreamWriter(new FileOutputStream(out), "utf-8"); 
			StreamResult result = new StreamResult(writer);
			//	Transform
			transformer.transform (source, result);
			// Close writer - teo_sarca [ 1705883 ] 
			writer.close();
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql.toString(), e);
			return e.toString();
		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, "", e);
			return e.toString();
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		return "";
	}	//	exportTrl

	
	/**
	 * 	Get Columns for Table
	 * 	@param Base_Table table
	 * 	@return array of translated columns
	 */
	private String[] getTrlColumns (String Base_Table)
	{
		m_IsCentrallyMaintained = false;
		String sql = "SELECT TableName FROM AD_Table t"
			+ " INNER JOIN AD_Column c ON (c.AD_Table_ID=t.AD_Table_ID AND c.ColumnName='IsCentrallyMaintained') "
			+ "WHERE t.TableName=? AND c.IsActive='Y'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setString(1, Base_Table);
			rs = pstmt.executeQuery();
			if (rs.next())
				m_IsCentrallyMaintained = true;
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		sql = "SELECT ColumnName "
			+ "FROM AD_Column c"
			+ " INNER JOIN AD_Table t ON (c.AD_Table_ID=t.AD_Table_ID) "
			+ "WHERE t.TableName=?"
			+ " AND c.ColumnName NOT LIKE ? "
			+ " AND c.AD_Reference_ID IN (10,14,36) "
			+ "ORDER BY IsMandatory DESC, ColumnName";
		ArrayList<String> list = new ArrayList<String>();
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setString(1, Base_Table + "_Trl");
			pstmt.setString(2, PO.getUUIDColumnName(Base_Table + "_Trl"));
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				String s = rs.getString(1);
			//	System.out.println(s); 
				list.add(s);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		//	Convert to Array
		String[] retValue = new String[list.size()];
		list.toArray(retValue);
		return retValue;
	}	//	getTrlColumns

	/**
	 * Validate Language.
	 *  - Check if AD_Language record exists
	 *  - Check Trl table records
	 * 	@param p_AD_Language language
	 * 	@return "" if validated - or error message
	 */
	public String validateLanguage(String p_AD_Language) {
		return validateLanguage(p_AD_Language, null);
	}

	/**************************************************************************
	 * 	Validate Language.
	 *  - Check if AD_Language record exists
	 *  - Check Trl table records
	 * 	@param AD_Language language
	 *  @param trxName transaction
	 * 	@return "" if validated - or error message
	 */
	public String validateLanguage (String AD_Language, String trxName)
	{
		MLanguage language = new Query(m_ctx, MLanguage.Table_Name, "AD_Language=?", trxName)
				.setParameters(AD_Language)
				.first();

		//	No AD_Language Record
		if (language == null)
		{
			log.log(Level.SEVERE, "Language does not exist: " + AD_Language);
			return "Language does not exist: " + AD_Language;
		}
		//	Language exists
		if (language.isActive())
		{
			if (language.isBaseLanguage())
				return "";
		}
		else
		{
			log.log(Level.SEVERE, "Language not active or not system language: " + AD_Language);
			return "Language not active or not system language: " + AD_Language;
		}
		
		//	Validate Translation
		if (log.isLoggable(Level.INFO)) log.info("Start Validating ... " + language);
		language.maintain(true);
		return "";
	}	//	validateLanguage

	
	/**
	 * 	Process
	 * 	@param directory directory
	 * 	@param AD_Language language
	 * 	@param mode mode
	 */
	public void process (String directory, String AD_Language, String mode)
	{
		String 	sql = "SELECT Name, TableName "
			+ "FROM AD_Table "
			+ "WHERE TableName LIKE '%_Trl' "
			+ "ORDER BY Name";
		ArrayList<String> trlTables = new ArrayList<String>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			rs = pstmt.executeQuery();
			while (rs.next())
				trlTables.add(rs.getString(2));
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		for (int i = 0; i < trlTables.size(); i++)
		{
			String table = (String)trlTables.get(i);
			File dir = new File(directory);
			if (mode.equals("import")) {
				if (!dir.exists() || !dir.isDirectory())
				{
					System.out.println("The language cannot be imported from " + directory +" as this directory does not exist.");
					System.exit(1);
				}
				importTrl(directory, -1, AD_Language, table);
			}
			else if (mode.equals("export")) {
				if (!dir.exists())
					dir.mkdir();
				dir = new File(directory);
				if (!dir.exists())
				{
					System.out.println("Cannot create directory " + directory + " to export the language to it.");
					System.exit(1);
				}
				exportTrl(directory, -1, AD_Language, table, true);
			} else
				System.out.println("Just import and export are supported as modes.");
		}
	}	//	process

	/**************************************************************************
	 * OSGi Batch Interface
	 * 
	 * @author tbayen - IDEMPIERE-1554
	 */

	/**
	 * Launch method of the OSGi application.
	 * 
	 * In pre-OSGi times commandline launching was done by a run of the main()
	 * method of {@link Translation}. This is the OSGized launch method. This
	 * class has to be mentioned in META-INF/MANIFEST.MF as an
	 * "org.eclipse.core.runtime.applications" extension. Because of that it can
	 * be called from the commandline.
	 * 
	 * You should take care that the org.eclipse.equinox.event bundle is active
	 * if you run this to send events in the case something goes wrong (like a
	 * missing file etc.)
	 */
	@Override
	public Object start(IApplicationContext context) throws Exception {
		Adempiere.startup(false);
		Map<?, ?> args = context.getArguments();
		String commandlineArgs[] = (String[]) args.get("application.args");
		if (commandlineArgs.length == 3
				&& ("import".equals(commandlineArgs[0]) || "export".equals(commandlineArgs[0]))) {
			String command = commandlineArgs[0];
			String directory = commandlineArgs[1];
			String countrycode = commandlineArgs[2];
			Properties ctx = Env.getCtx();
			Translation translation = new Translation(ctx);
			String msg = translation.validateLanguage (countrycode);
			if (msg.length() > 0)
				System.err.println(msg);
			translation.process(directory, countrycode, command);
		} else if (commandlineArgs.length == 1 && "sync".equals(commandlineArgs[0])) {
			ProcessInfo pi = new ProcessInfo("Synchronize Terminology", 172);
			pi.setAD_Client_ID(0);
			pi.setAD_User_ID(100);
			MPInstance instance = new MPInstance(Env.getCtx(), 172, 0);
			instance.saveEx();
			pi.setAD_PInstance_ID(instance.getAD_PInstance_ID());
			/*
			 * I do not call this direct because I did not want the
			 * org.adempiere.process plugin become a dependency of
			 * org.adempier.ui only for this commandline sync command.
			 */
			ProcessCall process = Core.getProcess("org.compiere.process.SynchronizeTerminology");
			process.startProcess(Env.getCtx(), pi, null);
			StringBuilder msgout = new StringBuilder("Process=").append(pi.getTitle())
					.append(" Error=").append(pi.isError()).append(" Summary=")
					.append(pi.getSummary());
			System.out.println(msgout.toString());
		} else {
			System.out.println("translation OSGi plugin commandline usage:");
			System.out.println("Translation.sh import translation/data de_DE");
			System.out.println("Translation.sh export translation/data de_DE");
		}
		return IApplication.EXIT_OK;
	}

	@Override
	public void stop() {
		// IApplication implementation method - (only start method used)
	}

}	//	Translation
