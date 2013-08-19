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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.logging.Level;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.compiere.model.MSysConfig;
import org.compiere.model.PO;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.CLogger;
import org.compiere.util.Trx;

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
	
	private List<X_AD_Package_Imp_Detail> importDetails;

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
		if (log.isLoggable(Level.INFO)) log.info("importXML:" + fileName);
		File in = new File(fileName);
		if (!in.exists()) {
			String msg = "File does not exist: " + fileName;
			if (log.isLoggable(Level.INFO)) log.info("importXML:" + msg);
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

	public void addImportDetail(X_AD_Package_Imp_Detail importDetail) {
		importDetails.add(importDetail);
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
			importDetails = new ArrayList<X_AD_Package_Imp_Detail>();

			PackInHandler handler = new PackInHandler();
			PIPOContext context = new PIPOContext();
			context.trx = Trx.get(trxName, true);
			context.packIn = this;
			context.ctx = ctx;
			context.ctx.setProperty("isHandleTranslations", MSysConfig.getValue(MSysConfig.TWOPACK_HANDLE_TRANSLATIONS));
			handler.setCtx(context);
			handler.setProcess(this);
			SAXParserFactory factory = SAXParserFactory.newInstance();
			SAXParser parser = factory.newSAXParser();
			String msg = "Start Parser";
			log.info(msg);
			parser.parse(input, handler);
			for (PO importDetail : importDetails) {
				importDetail.saveEx();
			}
			msg = "End Parser";
			log.info(msg);
			if (handler.getUnresolvedCount() > 0)
				handler.dumpUnresolvedElements();
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
		BufferedInputStream bis = null;
		try {
			fis = new FileInputStream(file);
			bis = new BufferedInputStream(fis);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			while (true) {
				int b = bis.read();
				if (b == -1)
					break;
				else
					baos.write(b);
			}
			data = baos.toByteArray();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {}
			}
			if (bis != null) {
				try {
					bis.close();
				} catch (Exception e) {}
				bis = null;
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
