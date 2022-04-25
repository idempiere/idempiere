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
 * Copyright (C) 2005 Robert Klein. robeklein@hotmail.com                     *
 * Contributor(s): Low Heng Sin hengsin@avantz.com                            *
 *****************************************************************************/
package org.adempiere.pipo2.handler;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.GenericPO;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.DataElementParameters;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.IHandlerRegistry;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PackoutItem;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.compiere.model.I_AD_Form;
import org.compiere.model.I_AD_InfoWindow;
import org.compiere.model.I_AD_Process;
import org.compiere.model.I_AD_Role;
import org.compiere.model.I_AD_Window;
import org.compiere.model.I_C_DocType;
import org.compiere.model.MColumn;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

/**
 *
 * @author Robert Klein.
 * @author Low Heng Sin
 *
 */
public class GenericPOElementHandler extends AbstractElementHandler {

	private String m_tableName;

	public GenericPOElementHandler() {
	}
	
	public GenericPOElementHandler(String tableName) {
		this.m_tableName = tableName;
	}

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		String tableName = element.getElementValue();

		PO po = findPO(ctx, element);
		if (po == null) {
    		MTable table = MTable.get(ctx.ctx, tableName);
			po = table.getPO(0, getTrxName(ctx));
		}
		PoFiller filler = new PoFiller(ctx, po, element, this);
		List<String> excludes = defaultExcludeList(tableName);
		List<String> notfounds = filler.autoFill(excludes);
		/* Verify if the table has entitytype and check dictionary maintenance */
		int idxet = po.get_ColumnIndex("EntityType");
		if (idxet >= 0) {
			String entityType = (String) po.get_Value(idxet);
			if (! isProcessElement(ctx.ctx, entityType)) {
				if (log.isLoggable(Level.INFO)) log.info("Generic PO not processed as it's official " + po.toString());
				element.skip = true;
				return;
			}
		}
			
		if (notfounds.size() > 0) {
			element.defer = true;
			element.unresolved = notfounds.toString();
			return;
		}
		String action = po.is_new() ? "New" : "Update";
		po.saveEx();
		element.recordId = po.get_ID();

		X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, po.get_TableName(), po.get_Table_ID());
		logImportDetail(ctx, impDetail, 1, po.toString(), element.recordId, action);

		if (   I_AD_Window.Table_Name.equals(tableName)
			|| I_AD_Process.Table_Name.equals(tableName)
			|| I_AD_Role.Table_Name.equals(tableName)
			|| I_AD_Form.Table_Name.equals(tableName)
			|| I_C_DocType.Table_Name.equals(tableName)
			|| I_AD_InfoWindow.Table_Name.equals(tableName))
			element.requireRoleAccessUpdate = true;
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		AttributesImpl atts = new AttributesImpl();

		String sql = Env.getContext(ctx.ctx, DataElementParameters.SQL_STATEMENT);
		String components[] = null;
		if (sql.indexOf(";") > 0) {
			components = sql.split("[;]");
			sql = components[0];
		} else {
			components = new String[]{sql};
		}
		int tableId = Env.getContextAsInt(ctx.ctx, DataElementParameters.AD_TABLE_ID);
		String tableName = MTable.getTableName(ctx.ctx, tableId);
		List<String> excludes = defaultExcludeList(tableName);
		boolean checkExcluded = ! sql.toLowerCase().startsWith("select *");				
		try (Statement stmt = DB.createStatement();) {
			sql = MRole.getDefault().addAccessSQL(sql, tableName, true, true);			
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				GenericPO po = new GenericPO(tableName, ctx.ctx, rs, getTrxName(ctx));
				int AD_Client_ID = po.getAD_Client_ID();
				if (AD_Client_ID != Env.getAD_Client_ID(ctx.ctx))
					continue;
				
				boolean createElement = isPackOutElement(ctx, po);

				if (checkExcluded) { // IDEMPIERE-1563
					MTable table = MTable.get(ctx.ctx, tableId);
					for (MColumn column : table.getColumns(false)) {
						try {
							rs.findColumn(column.getColumnName());
						} catch (SQLException e) {
							if (column.getColumnName().equals("AD_Client_ID") || column.getColumnName().equals("AD_Org_ID")) {
								throw new Exception("SQL Statement must include AD_Client_ID and AD_Org_ID");
							}
							if (!excludes.contains(column.getColumnName().toLowerCase())) {
								excludes.add(column.getColumnName().toLowerCase());
							}
						}
					}
					for (String keycol : po.get_KeyColumns()) {
						if (excludes.contains(keycol.toLowerCase())) {
							throw new Exception("SQL Statement must include key columns");
						}
					}
					if (excludes.contains(po.getUUIDColumnName().toLowerCase())) {
						throw new Exception("SQL Statement must include UUID column");
					}
					checkExcluded = false;
				}

				if (createElement) {
					// 
					if (po.get_KeyColumns() != null && po.get_KeyColumns().length == 1 && po.get_ID() > 0
						&& ! IHandlerRegistry.TABLE_GENERIC_SINGLE_HANDLER.equals(ctx.packOut.getCurrentPackoutItem().getType())) {
						ElementHandler handler = ctx.packOut.getHandler(po.get_TableName());
						if (handler != null && !handler.getClass().equals(this.getClass()) ) {
							handler.packOut(ctx.packOut, document, ctx.logDocument, po.get_ID());
							createElement = false;
						}
					}
					if (createElement) {
						verifyPackOutRequirement(po);
						addTypeName(atts, "table");
						document.startElement("","", tableName, atts);
						PoExporter filler = new PoExporter(ctx, document, po);
						if (MColumn.Table_Name.equals(po.get_TableName())) {
							filler.addString("IsSyncDatabase", "Y", new AttributesImpl());
							excludes.add("IsSyncDatabase");
						}
						filler.export(excludes, true);
						ctx.packOut.getCtx().ctx.put("Table_Name",tableName);
						try {
							new CommonTranslationHandler().packOut(ctx.packOut,document,null,po.get_ID());
						} catch(Exception e) {
							if (log.isLoggable(Level.INFO)) log.info(e.toString());
						}
					}
				}

				for (int i = 1; i < components.length; i++) {
					String tables[] = components[i].split("[>]");
					for (int nameIndex = 0; nameIndex < tables.length; nameIndex++) {
						tables [nameIndex] = tables[nameIndex].trim();
					}
					exportDetail(ctx, document, po, tables);
				}

				if (createElement) {
					document.endElement("","",tableName);
				}
			}
		} catch (Exception e)	{
			throw new AdempiereException(e);
		}
	}

	private void exportDetail(PIPOContext ctx, TransformerHandler document, GenericPO parent, String[] tables) {
		String mainTable = tables[0];
		AttributesImpl atts = new AttributesImpl();
		String sql = "SELECT * FROM " + mainTable + " WHERE " + parent.get_TableName() + "_ID = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			sql = MRole.getDefault().addAccessSQL(sql, mainTable, true, true);
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, parent.get_ID());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GenericPO po = new GenericPO(mainTable, ctx.ctx, rs, getTrxName(ctx));
				int AD_Client_ID = po.getAD_Client_ID();
				if (AD_Client_ID != Env.getAD_Client_ID(ctx.ctx))
					continue;

				boolean createElement = isPackOutElement(ctx, po);
				if (createElement) {

					ElementHandler handler = ctx.packOut.getHandler(po.get_TableName());
					if (handler != null && !handler.getClass().equals(this.getClass())) {
						if (po.get_ID() > 0 && po.get_KeyColumns().length==1) {
							handler.packOut(ctx.packOut, document, ctx.logDocument, po.get_ID());
							createElement = false;
						} else {
							String uuid = po.get_ValueAsString(po.getUUIDColumnName());
							if (!Util.isEmpty(uuid, true)) {
								handler.packOut(ctx.packOut, document, ctx.logDocument, -1, uuid);
								createElement = false;
							}
						}
					}

					if (createElement) {
						verifyPackOutRequirement(po);
						List<String> excludes = defaultExcludeList(mainTable);
						addTypeName(atts, "table");
						document.startElement("", "", mainTable, atts);
						PoExporter filler = new PoExporter(ctx, document, po);
						filler.export(excludes, true);
						ctx.packOut.getCtx().ctx.put("Table_Name",mainTable);
						try {
							new CommonTranslationHandler().packOut(ctx.packOut,document,null,po.get_ID());
						} catch(Exception e) {
							if (log.isLoggable(Level.INFO)) log.info(e.toString());
						}
					}
				}
				for (int i=1; i<tables.length; i++) {
					if (tables[i].startsWith("+")) {
						continue;
					}
					List<String> detTablesArr = new ArrayList<String>();
					for (int j=i; j<tables.length; j++) {
						if (j == i) {
							detTablesArr.add(tables[j]);
						} else {
							if (tables[j].startsWith("+")) {
								detTablesArr.add(tables[j].substring(1));
							} else {
								break;
							}
						}
					}
					String[] detTables = detTablesArr.toArray(new String[0]);
					exportDetail(ctx, document, po, detTables);
				}
				if (createElement) {
					document.endElement("","",mainTable);
				}
			}
		} catch (Exception e)	{
			throw new AdempiereException(e);
		} finally {
			DB.close(rs, pstmt);
		}

	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		PackoutItem detail = packout.getCurrentPackoutItem();
		int tableId = 0;
		String sql = null;
		if (detail.getProperty(DataElementParameters.AD_TABLE_ID) != null)
		{
			tableId = (Integer)detail.getProperty(DataElementParameters.AD_TABLE_ID);
			sql = (String)detail.getProperty(DataElementParameters.SQL_STATEMENT);
			if (sql == null){
				m_tableName = MTable.get(packout.getCtx().ctx, tableId).getTableName();
				sql = "SELECT * FROM " + m_tableName;
			}
		}
		else
		{
			tableId = MTable.get(packout.getCtx().ctx, m_tableName).getAD_Table_ID();
			sql = "SELECT * FROM " + m_tableName + " WHERE " + m_tableName + "_ID=" + recordId;
		}
		packout.getCtx().ctx.put(DataElementParameters.AD_TABLE_ID, Integer.toString(tableId));
		packout.getCtx().ctx.put(DataElementParameters.SQL_STATEMENT, sql);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(DataElementParameters.AD_TABLE_ID);
		packout.getCtx().ctx.remove(DataElementParameters.SQL_STATEMENT);
	}
}