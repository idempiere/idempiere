/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *
 * Copyright (C) 2005 Robert KLEIN.  robeklein@hotmail.com
 *
 *****************************************************************************/

package org.adempiere.pipo2;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.compiere.util.CLogger;

/**
 * IntPackIn Tool.
 *
 * @author: Robert KLEIN. robeklein@hotmail.com
 */
public class PackIn {

	/** Logger */
	private CLogger log = CLogger.getCLogger(getClass());
	//update system maintain dictionary, default to false
	private boolean m_UpdateDictionary = false;
	private String m_packageDirectory = null;

	private Map<String,Integer> tableCache = new HashMap<String,Integer>();
	private Map<String,Integer> columnCache = new HashMap<String,Integer>();
	private String packageName = null;
	private String packageVersion = null;

	public PackIn() {
		super();
	}

	/**
	 * add to table id cache
	 * @param tableName
	 * @param tableId
	 */
	public void addTable(String tableName, int tableId) {
		tableCache.put(tableName, tableId);
	}

	/**
	 * Find table id from cache
	 * @param tableName
	 * @return tableId
	 */
	public int getTableId(String tableName) {
		if (tableCache.containsKey(tableName))
			return tableCache.get(tableName).intValue();
		else
			return 0;
	}

	/**
	 * add to column id cache
	 * @param tableName
	 * @param columnName
	 * @param columnId
	 */
	public void addColumn(String tableName, String columnName, int columnId) {
		columnCache.put(tableName+"."+columnName, columnId);
	}

	/**
	 * find column id from cache
	 * @param tableName
	 * @param columnName
	 * @return column id
	 */
	public int getColumnId(String tableName, String columnName) {
		String key = tableName+"."+columnName;
		if (columnCache.containsKey(key))
			return columnCache.get(key).intValue();
		else
			return 0;
	}

	/**
	 * Uses PackInHandler to update AD.
	 *
	 * @param fileName xml file to read
	 * @return status message
	 */
	public String importXML(String fileName, Properties ctx, String trxName) throws Exception {
		log.info("importXML:" + fileName);
		File in = new File(fileName);
		if (!in.exists()) {
			String msg = "File does not exist: " + fileName;
			log.info("importXML:" + msg);
			return msg;
		}
		try {
			FileInputStream input = new FileInputStream(in);
			return importXML(input, ctx, trxName);
		} catch (Exception e) {
			log.log(Level.SEVERE, "importXML:", e);
			throw e;
		}
	}

	/**
	 *
	 * @param input
	 * @param ctx
	 * @param trxName
	 * @return status message
	 */
	public String importXML(InputStream input, Properties ctx, String trxName) {
		try {
			log.info("starting");
			// clear cache of previous runs
			IDFinder.clearIDCache();

			System.setProperty("javax.xml.parsers.SAXParserFactory",
					"org.apache.xerces.jaxp.SAXParserFactoryImpl");
			PackInHandler handler = new PackInHandler();
			handler.set_TrxName(trxName);
			handler.setCtx(ctx);
			handler.setProcess(this);
			SAXParserFactory factory = SAXParserFactory.newInstance();
			SAXParser parser = factory.newSAXParser();
			String msg = "Start Parser";
			log.info(msg);
			parser.parse(input, handler);
			msg = "End Parser";
			log.info(msg);
			return "Processed="+handler.getElementsProcessed()+" Un-Resolved="+handler.getUnresolvedCount();
		} catch (Exception e) {
			log.log(Level.SEVERE, "importXML:", e);
			throw new RuntimeException(e.getLocalizedMessage(), e);
		}
	}

	public String getPackageDirectory() {
		return m_packageDirectory;
	}

	public void setPackageDirectory(String packageDirectory) {
		m_packageDirectory = packageDirectory;
	}

	public boolean isUpdateDictionary() {
		return m_UpdateDictionary;
	}

	public void setUpdateDictionary(boolean updateDictionary) {
		m_UpdateDictionary = updateDictionary;
	}

	public byte[] readBlob(String fileName) throws IOException {
		byte[] data = null;
		File file = new File(m_packageDirectory+File.separator+"blobs"+File.separator, fileName);
		FileInputStream fis = null;

		try {
			fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			while (true) {
				int b = bis.read();
				if (b == -1)
					break;
				else
					baos.write(b);
			}
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {}
			}
		}
		return data;
	}

	/**
	 * @return package name
	 */
	public String getPackageName() {
		return packageName;
	}

	/**
	 *
	 * @param packageName
	 */
	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	/**
	 * @return package Version
	 */
	public String getPackageVersion() {
		return packageVersion;
	}

	/**
	 *
	 * @param packageVersion
	 */
	public void setPackageVersion(String packageVersion) {
		this.packageVersion = packageVersion;
	}
} // PackIn
