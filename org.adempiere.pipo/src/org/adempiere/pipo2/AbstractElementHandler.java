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
 * Copyright (C) 2005 Robert Klein. robeklein@hotmail.com                     *
 * Contributor(s): Low Heng Sin hengsin@avantz.com                            *
 *****************************************************************************/
package org.adempiere.pipo2;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Imp_Backup;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

import java.sql.ResultSet;
import java.sql.PreparedStatement;

import org.adempiere.pipo2.exception.DatabaseAccessException;

/**
 *
 * @author hengsin
 *
 */
public abstract class AbstractElementHandler implements ElementHandler {

	protected CLogger log = CLogger.getCLogger(getClass());

	/**
	 * Get ID from Name for a table.
	 *
	 * @param tableName
	 * @param name
	 *
	 */
	public int findIdByName (Properties ctx, String tableName, String name) {
		return IDFinder.findIdByName(tableName, name, getClientId(ctx), getTrxName(ctx));
	}

	/**
	 * Get ID from column value for a table.
	 *
	 * @param tableName
	 * @param columName
	 * @param name
	 */
	public int findIdByColumn (Properties ctx, String tableName, String columnName, Object value) {
		int id = 0;
		if ("AD_Table".equals(tableName) && "TableName".equals(columnName) && value != null) {
			id = getPackIn(ctx).getTableId(value.toString());
			if (id <= 0) {
				id = IDFinder.findIdByColumn(tableName, columnName, value, getClientId(ctx), getTrxName(ctx));
				if (id > 0) {
					getPackIn(ctx).addTable(value.toString(), id);
				}
			}
		} else {
			id = IDFinder.findIdByColumn(tableName, columnName, value, getClientId(ctx), getTrxName(ctx));
		}
		return id;
	}

	/**
	 * @param ctx
	 * @param type
	 * @param tableName
	 * @param tableId
	 * @return X_AD_Package_Imp_Detail
	 */
	public X_AD_Package_Imp_Detail createImportDetail(Properties ctx, String type, String tableName, int tableId) {
		X_AD_Package_Imp_Detail impDetail = new X_AD_Package_Imp_Detail(ctx, 0, getTrxName(ctx));
		impDetail.setAD_Package_Imp_ID(getPackageImpId(ctx));
		impDetail.setAD_Org_ID(Env.getAD_Org_ID(ctx) );
		impDetail.setType(type);
		impDetail.setName("");
		impDetail.setAction("");
		impDetail.setAD_Original_ID(1);
		impDetail.setTableName(tableName);
		impDetail.setAD_Table_ID(tableId);
		impDetail.saveEx(getTrxName(ctx));

		return impDetail;
	}

	/**
     *	Write results to log and records in history table
     *
     *		@param ctx
     *      @param success
     *      @param detail
     *      @param objectName
     *      @param objectID
     *      @param action
     * 		@throws SAXException
     *
     */
    public void logImportDetail (Properties ctx, X_AD_Package_Imp_Detail detail, int success, String objectName, int objectID,
    		String action) throws SAXException{
    	StringBuffer recordLayout = new StringBuffer();
    	TransformerHandler hd_document = getLogDocument(ctx);
		AttributesImpl attsOut = new AttributesImpl();
		String result = success == 1 ? "Success" : "Failure";

		//hd_documemt.startElement("","","Successful",attsOut);
		recordLayout.append("Type:")
			.append(detail.getType())
			.append("  -   Name:")
			.append(objectName)
			.append("  -  ID:")
			.append(objectID)
			.append("  -  Action:")
			.append(action)
			.append("  -  " + result);

		hd_document.startElement("","",result,attsOut);
		hd_document.characters(recordLayout.toString().toCharArray(),0,recordLayout.length());
		hd_document.endElement("","",result);

		detail.setName(objectName);
		detail.setAction(action);
		detail.setSuccess(result);
		detail.setAD_Original_ID(objectID);
		detail.saveEx(getTrxName(ctx));
    }

    /**
	 * Get ID from Name for a table with a parent name reference.
	 *
	 * @param tableName
	 * @param name
	 * @param tableNameMaster
	 * @param nameMaster
	 */
	public int findIdByNameAndParentName (Properties ctx, String tableName, String name, String tableNameMaster, String nameMaster) {
		return IDFinder.findIdByNameAndParentName(tableName, name, tableNameMaster, nameMaster, getTrxName(ctx));
	}

    /**
     * Get ID from column value for a table with a parent id reference.
     *
     * @param tableName
     * @param name
     * @param tableNameMaster
     * @param nameMaster
     */

	public int findIdByColumnAndParentId (Properties ctx, String tableName, String columnName, String name, String tableNameMaster, int masterID) {
		return IDFinder.findIdByColumnAndParentId(tableName, columnName, name, tableNameMaster, masterID,
				getTrxName(ctx));
	}

	/**
	 * Get ID from Name for a table with a parent reference ID.
	 *
	 * @param tableName
	 * @param name
	 * @param tableNameMaster
	 * @param masterID
	 */
	public int findIdByNameAndParentId (Properties ctx, String tableName, String name, String tableNameMaster, int masterID) {
		return IDFinder.findIdByNameAndParentId(tableName, name, tableNameMaster, masterID, getTrxName(ctx));
	}

    /**
     *	Make backup copy of record.
     *
     *      @param tablename
     *
     *
     *
     */

	public void backupRecord(Properties ctx, int AD_Package_Imp_Detail_ID, String tableName,PO from){

    	// Create new record
    	int tableID = findIdByColumn(ctx, "AD_Table", "TableName", tableName);
		POInfo poInfo = POInfo.getPOInfo(ctx, tableID, getTrxName(ctx));

		PreparedStatement pstmtReferenceId = DB.prepareStatement("SELECT AD_Reference_ID FROM AD_COLUMN WHERE AD_Column_ID = ?", getTrxName(ctx));
		ResultSet rs=null;

	    try{
			for (int i = 0; i < poInfo.getColumnCount(); i++){

				int columnID =findIdByColumnAndParentId (ctx, "AD_Column", "ColumnName", poInfo.getColumnName(i), "AD_Table", tableID);

				int referenceID=0;

				pstmtReferenceId.setInt(1,columnID);
				rs = pstmtReferenceId.executeQuery();

				if (rs.next())
					referenceID = rs.getInt(1);

	    		X_AD_Package_Imp_Backup backup = new X_AD_Package_Imp_Backup(ctx, 0, getTrxName(ctx));
	    		backup.setAD_Org_ID(Env.getAD_Org_ID(ctx));
	    		backup.setAD_Package_Imp_ID(getPackageImpId(ctx));
	    		backup.setAD_Package_Imp_Detail_ID(AD_Package_Imp_Detail_ID);
	    		backup.setAD_Table_ID(tableID);

	    		backup.setAD_Column_ID(columnID);
	    		backup.setAD_Reference_ID(referenceID);
	    		Object value = from.get_ValueOld(i);
				backup.setColValue(value != null ? value.toString() : null);

				backup.saveEx(getTrxName(ctx));
		    }
		}
	    catch(Exception e)
		{
			throw new DatabaseAccessException(e);
		}
	    finally
	    {
	    	DB.close(rs, pstmtReferenceId);
	    }
    }

	/**
     *	Open input file for processing
     *
     * 	@param String file with path
     *
     */
    public FileInputStream OpenInputfile (String filePath) {

    	FileInputStream fileTarget = null;

    	try {
    		fileTarget = new FileInputStream(filePath);
    	}
    	catch (FileNotFoundException e ) {
    		System.out.println("File not found: " + filePath);

    		return null;
    	}
    	return fileTarget;
    }

    /**
     *	Open output file for processing
     *
     * 	@param String file with path
     *
     */
    public OutputStream OpenOutputfile (String filePath) {

    	OutputStream fileTarget = null;

    	try {
    		fileTarget = new FileOutputStream(filePath);
    	}
    	catch (FileNotFoundException e ) {
    		System.out.println("File not found: " + filePath);

    		return null;
    	}
    	return fileTarget;
    }

    /**
     *	Copyfile
     *
     * 	@param String file with path
     *
     */
    public int copyFile (InputStream source,OutputStream target) {

    	 int byteCount = 0;
    	 int success = 0;
	        try {
	           while (true) {
	              int data = source.read();
	              if (data < 0)
	                 break;
	              target.write(data);
	              byteCount++;
	           }
	           source.close();
	           target.close();
	           //System.out.println("Successfully copied " + byteCount + " bytes.");
	        }
	        catch (Exception e) {
	           log.log(Level.SEVERE, e.getLocalizedMessage(), e);
	           success = -1;
	        }
	    return success;
    }

    /**
     * Get client id
     * @param ctx
     * @return int
     */
    protected int getClientId(Properties ctx) {
    	return Env.getContextAsInt(ctx, "AD_Client_ID");
    }

    /**
     * Get AD_Package_Imp_ID
     * @param ctx
     * @return int
     */
    protected int getPackageImpId(Properties ctx) {
    	return Env.getContextAsInt(ctx, "AD_Package_Imp_ID");
    }

    /**
     * Get update system maintained dictionary flag
     * @param ctx
     * @return update mode
     */
    protected String getUpdateMode(Properties ctx) {
    	return Env.getContext(ctx, "UpdateMode");
    }

    /**
     * Get current transaction name
     * @param ctx
     * @return transaction name
     */
    protected String getTrxName(Properties ctx) {
    	String trxName = Env.getContext(ctx, "TrxName");
    	if (trxName != null && trxName.trim().length() > 0)
    		return trxName;
    	else
    		return null;
    }

    /**
     * Get share document
     * @param ctx
     * @return TransformerHandler
     */
    protected TransformerHandler getLogDocument(Properties ctx) {
    	return (TransformerHandler)ctx.get("LogDocument");
    }

    /**
     * @param ctx
     * @return package directory
     */
    protected String getPackageDirectory(Properties ctx) {
    	return Env.getContext(ctx, "PackageDirectory");
    }

    /**
     * Process element by entity type and user setting.
     * @param ctx
     * @param entityType
     * @return boolean
     */
    protected boolean isProcessElement(Properties ctx, String entityType) {
    	if ("D".equals(entityType) || "C".equals(entityType)) {
    		return "true".equalsIgnoreCase(getUpdateMode(ctx));
    	} else {
    		return true;
    	}
    }

    /**
     * return null for empty string ("").
     * @param element
     * @param qName
     * @return string value
     */
    protected String getStringValue(Element element, String qName) {
    	return getStringValue(element, qName, null);
    }

    /**
     * return null for empty string ("").
     * @param element
     * @param qName
     * @return string value
     */
    protected String getStringValue(Element element, String qName, List<String> excludes) {
    	String name = qName;
    	String s = element.properties.get(qName).contents.toString();

    	if (s != null && s.trim().length() > 0 && excludes != null) {
    		excludes.add(name);
    	}
    	return ((s == null || s.trim().length() == 0) ? null : s.trim());
    }

    /**
     * @param element
     * @param qName
     * @param defaultValue
     * @return boolean
     */
    protected boolean getBooleanValue(Element element, String qName, boolean defaultValue) {
    	String value = element.properties.get(qName).contents.toString();
    	return value != null ? Boolean.valueOf(value).booleanValue() : defaultValue;
    }

    /**
     * @param element
     * @param qName
     * @return BigDecimal
     */
    protected BigDecimal getBigDecimal(Element element, String qName) {
    	String value = element.properties.get(qName).contents.toString();
    	return value != null ? new BigDecimal(value) : null;
    }

    /**
     * @param element
     * @param qName
     * @return int
     */
    protected int getIntValue(Element element, String qName) {
    	Element pe = element.properties.get(qName);
    	String value = pe != null ? pe.contents.toString() : null;
    	return value != null ? Integer.parseInt(value) : 0;
    }

    /**
     * Returns option - Is export-import of AD translations is needed
     * @param ctx
     * @param entityType
     * @return boolean
     */
    protected boolean isHandleTranslations(Properties ctx) {

    	return "true".equalsIgnoreCase(Env.getContext(ctx, "isHandleTranslations"));
    }

    /**
     *
     * @param tableName
     * @return list of column to exclude from processing
     */
    protected List<String> defaultExcludeList(String tableName) {
    	List<String> excludes = new ArrayList<String>();
    	excludes.add("ad_client_id");
    	excludes.add("ad_org_id");
    	excludes.add("created");
    	excludes.add("createdby");
    	excludes.add("updated");
    	excludes.add("updatedby");
    	excludes.add(tableName + "_ID");
    	return excludes;
    }

    /**
     *
     * @param ctx
     * @return PackIn instance
     */
    protected PackIn getPackIn(Properties ctx) {
    	return (PackIn)ctx.get(PackInHandler.PACK_IN_PROCESS_CTX_KEY);
    }

    /**
     *
     * @param ctx
     * @return PackOut instance
     */
    protected PackOut getPackOut(Properties ctx) {
    	return (PackOut) ctx.get(PackOut.PACK_OUT_PROCESS_CTX_KEY);
    }

    /**
     *
     * @param element
     * @param expectedName
     * @return Parent element record id
     */
    protected int getParentId(Element element, String expectedName) {
    	if (element.parent != null && element.parent.getElementValue().equals(expectedName) &&
    			element.parent.recordId > 0)
    		return element.parent.recordId;
    	else
    		return 0;
    }

    /**
     *
     * @param element
     * @param expectedName
     * @return true if parent element is defer for next round of processing
     */
    protected boolean isParentDefer(Element element, String expectedName) {
    	if (element.parent != null
    		&& (expectedName == null || element.parent.getElementValue().equals(expectedName))
    		&& element.parent.defer)
    		return true;
    	else
    		return false;
    }

    /**
     *
     * @param element
     * @param expectedName
     * @return true if parent element is being ignore
     */
    protected boolean isParentSkip(Element element, String expectedName) {
    	if (element.parent != null
    		&& (expectedName == null || element.parent.getElementValue().equals(expectedName))
    		&& element.parent.skip)
    		return true;
    	else
    		return false;
    }

    /**
     *
     * @param element
     * @param columnName
     * @return true if value of columnName is office id.
     */
    protected boolean isOfficialId(Element element, String columnName) {
    	int value = getIntValue(element, columnName);
    	if (value > 0 && value <= PackOut.MAX_OFFICIAL_ID)
    		return true;
    	else
    		return false;
    }

    /**
     *
     * @param handler
     * @param qName
     * @param text
     * @throws SAXException
     */
    protected void addTextProperty(TransformerHandler handler, String qName, String text) throws SAXException {
    	AttributesImpl atts = new AttributesImpl();
    	atts.addAttribute("", "", qName, "reference", "property");
		handler.startElement("", "", qName, atts);
		append(handler, text);
		handler.endElement("", "", qName);
	}

    /**
     *
     * @param document
     * @param str
     * @throws SAXException
     */
    protected void append(TransformerHandler document, String str) throws SAXException
	{
		char[] contents = str != null ? str.toCharArray() : new char[0];
		document.characters(contents,0,contents.length);
	}

    /**
     * Find po by uuid or id
     * @param <T>
     * @param ctx
     * @param element
     * @return T
     */
    protected <T extends PO> T findPO(Properties ctx, Element element) {
    	T po = null;
    	String tableName = element.getElementValue();
    	String uuidColumn = PO.getUUIDColumnName(tableName);
    	String idColumn = tableName + "_ID";
    	if (element.properties.containsKey(uuidColumn)) {
    		String uuid = element.properties.get(uuidColumn).contents.toString();
    		if (uuid != null && uuid.trim().length() == 36) {
    			Query query = new Query(ctx, tableName, uuidColumn+"=?", getTrxName(ctx));
    			po = query.setParameters(uuid.trim()).firstOnly();
    		}
    	} else if (element.properties.containsKey(idColumn)) {
    		String id = element.properties.get(idColumn).contents.toString();
    		if (id != null && id.trim().length() > 0) {
    			Query query = new Query(ctx, tableName, idColumn+"=?", getTrxName(ctx));
    			po = query.setParameters(id.trim()).firstOnly();
    		}
    	}
    	return po;
    }

    /**
     *
     * @param atts
     * @param typeName
     */
    protected void addTypeName(AttributesImpl atts, String typeName) {
    	atts.addAttribute("", "", "type", "CDATA", typeName);
    }
}
