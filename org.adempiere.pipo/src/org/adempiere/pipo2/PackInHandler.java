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
 * Copyright (C) 2004 Marco LOMBARDO. lombardo@mayking.com                    *
 * Contributor: Robert KLEIN. robeklein@hotmail.com                           *
 * Contributor: Tim Heath                                                     *
 * Contributor: Low Heng Sin  hengsin@avantz.com                              *
 *****************************************************************************/

package org.adempiere.pipo2;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.Stack;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.compiere.model.MColumn;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Imp;
import org.compiere.model.X_AD_Package_Imp_Inst;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;
import org.xml.sax.helpers.DefaultHandler;

/**
 * SAX Handler for parsing XML description of the GUI.
 *
 * @author Marco LOMBARDO, lombardo@mayking.com
 * @author Robert KLEIN, robeklein@hotmailo
 *
 * Contributor: William G. Heath - Import of workflows and dynamic validations
 */
public class PackInHandler extends DefaultHandler {

	/**
     * 	PackInHandler Handler
     */
    public PackInHandler () {
    	setupHandlers();
    }   // PackInHandler

    /** Set this if you want to update Dictionary  */
    private boolean m_updateDictionary = false;
    private String packageDirectory = null;
    private int AD_Package_Imp_ID=0;
	private int AD_Package_Imp_Inst_ID=0;
    private static final CLogger log = CLogger.getCLogger(PackInHandler.class);
	private boolean isInit = false;
	private String packageStatus = "Installing";
	private PIPOContext m_ctx = null;

	private IHandlerRegistry handlerRegistry = null;
	private List<DeferEntry> defer = new ArrayList<DeferEntry>();
	private List<Integer> deferFK = new ArrayList<Integer>();
	private Stack<Element> stack = new Stack<Element>();
	private PackIn packIn;
	private int elementProcessed = 0;
	private boolean isUpdateRoleAccess = false;

	private void init() throws SAXException {

		packageDirectory = packIn.getPackageDirectory();
		m_updateDictionary = packIn.isUpdateDictionary();

		if (m_ctx == null)
			m_ctx = new PIPOContext();
		if (m_ctx.trx == null)
			m_ctx.trx = Trx.get("PackIn", true);

		isInit=true;
	}

	private void setupHandlers() {
		handlerRegistry = new OSGiHandlerRegistry();
	}

    /**
     * 	Receive notification of the start of an element.
     *
     * 	@param uri namespace
     * 	@param localName simple name
     * 	@param qName qualified name
     * 	@param atts attributes
     * 	@throws org.xml.sax.SAXException
     */
	public void startElement (String uri, String localName, String qName, Attributes atts)
	throws org.xml.sax.SAXException {

		// Initialize the handler
		if (isInit == false){
			init();
		}

		// idempiere
		if (qName.equals("idempiere"))
		{
			String updateDictionary = atts.getValue("UpdateDictionary");
			if (updateDictionary != null && updateDictionary.equalsIgnoreCase("true"))
			{
				m_updateDictionary = true;
			}
			if (log.isLoggable(Level.INFO)) log.info("idempiere updateMode="+m_updateDictionary);

			//check client
			String clientAttribute = atts.getValue("Client");
			String[] clientComponent = clientAttribute.split("[-]");
			int clientId = Integer.parseInt(clientComponent[0]);
			if (clientId == 0 && Env.getAD_Client_ID(m_ctx.ctx) > 0) {
				throw new RuntimeException("Package is created for System, not Tenant");
			} else if (clientId > 0 && Env.getAD_Client_ID(m_ctx.ctx) == 0) {
				throw new RuntimeException("Package is created for Tenant, not System");
			}

			// Update Summary Package History Table
			int PK_preInstalled=0;

			String packageName = packIn.getPackageName();
			if (packageName == null || packageName.trim().length() == 0)
			{
				packageName = atts.getValue("Name");
			}
			String packageVersion = packIn.getPackageVersion();
			if (packageVersion == null || packageVersion.trim().length() == 0)
			{
				packageVersion = atts.getValue("Version");
			}

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = DB.prepareStatement("SELECT AD_PACKAGE_IMP_INST_ID FROM AD_PACKAGE_IMP_INST WHERE NAME =? AND PK_VERSION =?", null);
				pstmt.setString(1,packageName);
				pstmt.setString(2,packageVersion);
				rs = pstmt.executeQuery();

				if (rs.next())
				{
					PK_preInstalled = rs.getInt(1);
				}
			} catch (Exception e) {
				throw new DatabaseAccessException(e);
			} finally {
				DB.close(rs, pstmt);
			}

			X_AD_Package_Imp packageImp = new X_AD_Package_Imp(m_ctx.ctx, 0, null);
			packageImp.setAD_Org_ID(Env.getAD_Org_ID(m_ctx.ctx));
			packageImp.setReleaseNo(atts.getValue("CompVer"));
			packageImp.setPK_Version(packageVersion);
			packageImp.setVersion(atts.getValue("DataBase"));
			packageImp.setDescription(atts.getValue("Description").replaceAll("'","''"));
			packageImp.setName(packageName);
			packageImp.setCreator(atts.getValue("Creator"));
			packageImp.setCreatorContact(atts.getValue("CreatorContact"));
			packageImp.setPK_Status(packageStatus);
			packageImp.setAD_Package_Imp_Proc_ID(packIn.getAD_Package_Imp_Proc().getAD_Package_Imp_Proc_ID());

			packageImp.saveEx();
			AD_Package_Imp_ID = packageImp.getAD_Package_Imp_ID();

			if ( PK_preInstalled <= 0){
				//Insert Package into package install log

				X_AD_Package_Imp_Inst packageInst = new X_AD_Package_Imp_Inst(m_ctx.ctx, 0, null);
				packageInst.setAD_Org_ID(Env.getAD_Org_ID(m_ctx.ctx));
				packageInst.setReleaseNo(atts.getValue("CompVer"));
				packageInst.setPK_Version(atts.getValue("Version"));
				packageInst.setVersion(atts.getValue("DataBase"));
				packageInst.setDescription(atts.getValue("Description").replaceAll("'","''"));
				packageInst.setName(atts.getValue("Name"));
				packageInst.setCreator(atts.getValue("Creator"));
				packageInst.setCreatorContact(atts.getValue("CreatorContact"));
				packageInst.setPK_Status(packageStatus);
				packageInst.saveEx();
				AD_Package_Imp_Inst_ID = packageInst.get_ID();
			} else {
				//Update package list with package status
				AD_Package_Imp_Inst_ID = PK_preInstalled;

				X_AD_Package_Imp_Inst packageInst = new X_AD_Package_Imp_Inst(m_ctx.ctx, AD_Package_Imp_Inst_ID, null);
				packageInst.setPK_Status(packageStatus);
				packageInst.saveEx();
			}

			Env.setContext(m_ctx.ctx, "AD_Package_Imp_ID", String.valueOf(AD_Package_Imp_ID));
			Env.setContext(m_ctx.ctx, "UpdateMode", m_updateDictionary);
			Env.setContext(m_ctx.ctx, "PackageDirectory", packageDirectory);
			m_ctx.packIn = packIn;
		} else {
			Element e = new Element(uri, localName, qName, new AttributesImpl(atts));
			if (stack.size() > 0)
			{
				e.parent = stack.peek();
				String reference = atts.getValue("type");
				if (reference == null || reference.equals(IHandlerRegistry.ELEMENT_TYPE_PROPERTIES))
				{
					e.parent.properties.put(qName, e);
				}
				else
				{
					e.parent.childrens.add(e);
				}
			}
			stack.push(e);
		}
	}   // startElement

	private void processElement(Element element) throws SAXException
	{
		ElementHandler handler = handlerRegistry.getHandler(element);
		if (handler != null)
			handler.startElement(m_ctx, element);
		if (element.defer)
		{
			defer.add(new DeferEntry(element, true));
		}
		if (element.deferFKColumnID > 0)
		{
			if (! deferFK.contains(element.deferFKColumnID))
				deferFK.add(element.deferFKColumnID);
		}
		if (element.requireRoleAccessUpdate) {
			isUpdateRoleAccess = true;
		}

		for (Element childElement : element.childrens)
		{
			processElement(childElement);
		}

		if (element.defer) {
			defer.add(new DeferEntry(element, false));
		} else {
    		if (handler != null)
    			handler.endElement(m_ctx, element);
    		if (element.defer || element.deferEnd)
				defer.add(new DeferEntry(element, false));
    		else if (!element.skip) {
    			if (log.isLoggable(Level.INFO))
    				log.info("Processed: " + element.getElementValue() + " - " + element.attributes.getValue(0));
    			elementProcessed++;
    		}
		}
	}

	/**
	 * @see org.xml.sax.helpers.DefaultHandler#characters(char[], int, int)
	 */
	@Override
	public void characters(char[] ch, int start, int length)
			throws SAXException {
		if (stack.size() > 0 && length > 0)
		{
			Element e = stack.peek();
			e.contents.append(ch, start, length);
		}
	}

    /**
     *	Receive notification of the end of an element.
     * 	@param uri namespace
     * 	@param localName simple name
     * 	@param qName qualified name
     * 	@throws SAXException
     */
    public void endElement (String uri, String localName, String qName) throws SAXException {
    	// Check namespace.

    	String elementValue = null;
    	if ("".equals (uri))
    		elementValue = qName;
    	else
    		elementValue = uri + localName;

    	if (elementValue.equals("idempiere")){
    		processDeferElements();

    		processDeferFKElements();
    		
    		updateRoleAccess();

    		if (getUnresolvedCount() > 0) {
    			packageStatus = "Completed - unresolved";
    		} else {
    			packageStatus = "Completed successfully";
    			packIn.setSuccess(true);
    		}
    		packIn.getNotifier().addStatusLine(packageStatus);

    		updPackageImp(m_ctx.trx.getTrxName()); // do not set success until commit on PackInProcess, still can fail
    		updPackageImpInst(m_ctx.trx.getTrxName());

    		//reset
    		setupHandlers();
    	} else {
    		Element e = stack.pop();
    		if (stack.isEmpty())
    		{
    			try {
    				processElement(e);
    			} catch (RuntimeException re) {
    				packageStatus = "Import Failed";
    				packIn.getNotifier().addStatusLine(packageStatus);
    	    		updPackageImp(null);
    	    		throw re;
    			} catch (SAXException se) {
    				packageStatus = "Import Failed";
    				packIn.getNotifier().addStatusLine(packageStatus);
    	    		updPackageImp(null);
    	    		throw se;
    			}
    		}
    	}
    }   // endElement

    private void updPackageImp(String trxName) {
    	// NOTE: Updating out of model to avoid change log insert that can cause locks
		//Update package history log with package status
    	DB.executeUpdateEx("UPDATE AD_Package_Imp SET Processed=?, PK_Status=?, UpdatedBy=?, Updated=getDate() WHERE AD_Package_Imp_ID=?",
    			new Object[] {"Y", packageStatus, Env.getAD_User_ID(m_ctx.ctx), AD_Package_Imp_ID},
    			trxName);
	}

    private void updPackageImpInst(String trxName) {
    	// NOTE: Updating out of model to avoid change log insert that can cause locks
    	DB.executeUpdateEx("UPDATE AD_Package_Imp_Inst SET PK_Status=?, UpdatedBy=?, Updated=getDate() WHERE AD_Package_Imp_Inst_ID=?",
    			new Object[] {packageStatus, Env.getAD_User_ID(m_ctx.ctx), AD_Package_Imp_Inst_ID},
    			trxName);
	}

	private void processDeferElements() throws SAXException {

    	if (defer.isEmpty()) return;

    	do {
    		int startSize = defer.size();
    		List<DeferEntry> tmp = new ArrayList<DeferEntry>(defer);
    		defer.clear();
    		for (DeferEntry d : tmp) {
    			if (d.startElement) {
	    			d.element.defer = false;
	    			d.element.unresolved = "";
	    			d.element.pass++;
    			} else {
    				if (d.element.deferEnd) {
    					d.element.deferEnd = false;
    	    			d.element.unresolved = "";
    				}
    			}
    			if (log.isLoggable(Level.INFO)) {
    				log.info("Processing Element: " + d.element.getElementValue() + " - "
						+ d.element.attributes.getValue(0));
    			}
    			ElementHandler handler = handlerRegistry.getHandler(d.element);
    			if (handler != null) {
    				if (d.startElement)
    					handler.startElement(m_ctx, d.element);
    				else
    					handler.endElement(m_ctx, d.element);
    			}
    			if (d.element.defer)
    				defer.add(d);
    			else if (!d.startElement) {
    				if (d.element.deferEnd)
    					defer.add(d);
    				else {
	    				if (log.isLoggable(Level.INFO))
	    					log.info("Imported Defer Element: " + d.element.getElementValue() + " - "
	    							+ d.element.attributes.getValue(0));
	    				elementProcessed++;
    				}
    			}
    		}
    		int endSize = defer.size();
    		if (startSize == endSize) break;
    	} while (defer.size() > 0);
    }

    private void processDeferFKElements() throws SAXException {

    	if (deferFK.isEmpty())
    		return;

    	for (int columnID : deferFK) {
    		MColumn column = new MColumn(m_ctx.ctx, columnID, m_ctx.trx.getTrxName());
    		try {
    			Connection conn = m_ctx.trx.getConnection();
    			DatabaseMetaData md = conn.getMetaData();
    			String catalog = DB.getDatabase().getCatalog();
    			String schema = DB.getDatabase().getSchema();
    			MTable table = MTable.get(m_ctx.ctx, column.getAD_Table_ID(), m_ctx.trx.getTrxName());
    			if (table.get_ID() != column.getAD_Table_ID()) {
    				// table not found
    				log.warning("Table " + column.getAD_Table_ID() + " not found");
    				continue;
    			}
    			if (table.isView()) {
    				continue;
    			}
    			String tableName = table.getTableName();

        		String fkConstraintSql = MColumn.getForeignKeyConstraintSql(md, catalog, schema, tableName, table, column, false);
        		if (! Util.isEmpty(fkConstraintSql)) {
        			if (fkConstraintSql.toLowerCase().contains(" ad_sequence(ad_sequence_id)"))
        				fkConstraintSql = fkConstraintSql + "; COMMIT";
        			if (fkConstraintSql.indexOf(DB.SQLSTATEMENT_SEPARATOR) == -1) {
        				DB.executeUpdate(fkConstraintSql, false, m_ctx.trx.getTrxName());
        			} else {
        				String statements[] = fkConstraintSql.split(DB.SQLSTATEMENT_SEPARATOR);
        				for (int i = 0; i < statements.length; i++) {
        					if (Util.isEmpty(statements[i], true))
        						continue;
        					DB.executeUpdateEx(statements[i], m_ctx.trx.getTrxName());
        				}
        			}
        		}
    		} catch (Exception e) {
    			throw new AdempiereException(e);
    		}
    	}
    }

	public void setCtx(PIPOContext ctx) {
		m_ctx = ctx;
	}

	/**
	 * @param packIn
	 */
	public void setProcess(PackIn packIn) {
		this.packIn = packIn;
	}

	/**
	 * @return number of elements that processed successfully
	 */
	public int getElementsProcessed() {
		return elementProcessed;
	}

	/**
	 * @return number of unresolved elements
	 */
	public int getUnresolvedCount() {
		int count = 0;
		if (defer != null && !defer.isEmpty()) {
			for(DeferEntry entry : defer) {
				if (!entry.startElement)
					count++;
			}
		}
		return count;
	}
	
	public void dumpUnresolvedElements() {
		if (defer != null && !defer.isEmpty()) {
			for(DeferEntry entry : defer) {
				if (!entry.startElement)
				{
					Element e = entry.element;
					StringBuilder s = new StringBuilder(e.qName);
					s.append(" [");
					Set<String> keys = e.properties.keySet();
					int i = 0;
					for(String key : keys) 
					{
						Element value = e.properties.get(key);
						if (i > 0)
							s.append(", ");
						s.append(key).append("=");
						if (value.contents != null)
							s.append(value.contents);
						i++;
					}
					s.append("]");
					if (e.unresolved != null && e.unresolved.length() > 0)
						s.append(" unresolved ").append(e.unresolved);
					log.warning(s.toString());
					packIn.getNotifier().addFailureLine(s.toString());
				}
			}
		}
	}

	static class DeferEntry {
		Element element;
		boolean startElement = false;

		DeferEntry(Element e, boolean b) {
			element = e;
			startElement = b;
		}
	}

    private void updateRoleAccess() {
    	if (!isUpdateRoleAccess)
    		return;

    	int AD_Client_ID=Env.getAD_Client_ID(Env.getCtx());
    	
    	List<MRole> roles = new Query(m_ctx.ctx, MRole.Table_Name, "IsManual='N' AND (?=0 OR AD_Client_ID=?)", m_ctx.trx.getTrxName())
			.setOnlyActiveRecords(true)
			.setOrderBy("AD_Client_ID, Name")
			.setParameters(AD_Client_ID, AD_Client_ID)
			.list();
    	for (MRole role : roles) {
        	role.updateAccessRecords(false);
    	}
	}

}   // PackInHandler
