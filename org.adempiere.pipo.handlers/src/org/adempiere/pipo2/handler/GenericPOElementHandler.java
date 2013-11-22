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
import java.util.List;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.GenericPO;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.DataElementParameters;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PackoutItem;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.compiere.model.MColumn;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

/**
 *
 * @author Robert Klein.
 * @author Low Heng Sin
 *
 */
public class GenericPOElementHandler extends AbstractElementHandler {

	private String tableName;

	public GenericPOElementHandler() {
	}
	
	public GenericPOElementHandler(String tableName) {
		this.tableName = tableName;
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
		po.saveEx();
		element.recordId = po.get_ID();
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
		Statement stmt = null;
		ResultSet rs = null;
		try {
			sql = MRole.getDefault().addAccessSQL(sql, tableName, true, true);
			stmt = DB.createStatement();
			rs = stmt.executeQuery(sql);
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
					if (po.get_KeyColumns() != null && po.get_KeyColumns().length == 1 && po.get_ID() > 0) {
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
					exportDetail(ctx, document, po, 0, tables);
				}

				if (createElement) {
					document.endElement("","",tableName);
				}
			}
		} catch (Exception e)	{
			throw new AdempiereException(e);
		} finally {
			DB.close(rs, stmt);
		}
	}

	private void exportDetail(PIPOContext ctx, TransformerHandler document, GenericPO parent, int index, String[] tables) {
		AttributesImpl atts = new AttributesImpl();
		tables[index] = tables[index].trim();
		String sql = "SELECT * FROM " + tables[index] + " WHERE " + parent.get_TableName() + "_ID = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			sql = MRole.getDefault().addAccessSQL(sql, tables[index], true, true);
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, parent.get_ID());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				GenericPO po = new GenericPO(tables[index], ctx.ctx, rs, getTrxName(ctx));
				int AD_Client_ID = po.getAD_Client_ID();
				if (AD_Client_ID != Env.getAD_Client_ID(ctx.ctx))
					continue;

				boolean createElement = isPackOutElement(ctx, po);
				if (createElement) {
					if (po.get_ID() > 0) {
						ElementHandler handler = ctx.packOut.getHandler(po.get_TableName());
						if (handler != null && !handler.getClass().equals(this.getClass()) ) {
							handler.packOut(ctx.packOut, document, ctx.logDocument, po.get_ID());
							createElement = false;
						}
					}
					if (createElement) {
						verifyPackOutRequirement(po);
						List<String> excludes = defaultExcludeList(tables[index]);
						addTypeName(atts, "table");
						document.startElement("", "", tables[index], atts);
						PoExporter filler = new PoExporter(ctx, document, po);
						filler.export(excludes, true);
					}
				}
				for (int i=index+1; i<tables.length; i++) {
					exportDetail(ctx, document, po, 0, new String[] {tables[i]});
				}
				if (createElement) {
					document.endElement("","",tables[index]);
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
		}
		else
		{
			tableId = MTable.get(packout.getCtx().ctx, tableName).getAD_Table_ID();
			sql = "SELECT * FROM " + tableName + " WHERE " + tableName + "_ID=" + recordId;
		}
		packout.getCtx().ctx.put(DataElementParameters.AD_TABLE_ID, Integer.toString(tableId));
		packout.getCtx().ctx.put(DataElementParameters.SQL_STATEMENT, sql);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(DataElementParameters.AD_TABLE_ID);
		packout.getCtx().ctx.remove(DataElementParameters.SQL_STATEMENT);
	}
}