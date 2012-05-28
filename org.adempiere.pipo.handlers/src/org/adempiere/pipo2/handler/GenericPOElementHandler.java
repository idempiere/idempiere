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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.GenericPO;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.DataElementParameters;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackoutItem;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.compiere.model.MColumn;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.Query;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
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
	    	String uuidColumn = PO.getUUIDColumnName(tableName);
	    	String idColumn = tableName + "_ID";
    		MTable table = MTable.get(ctx.ctx, tableName);
	    	if ((!element.properties.containsKey(uuidColumn) || element.properties.get(uuidColumn).contents == null || element.properties.get(uuidColumn).contents.toString().trim().length() > 0) 
	    		&& (!element.properties.containsKey(idColumn) || element.properties.get(idColumn).contents == null || element.properties.get(idColumn).contents.toString().trim().length() > 0)) {
				POInfo info = POInfo.getPOInfo(ctx.ctx, table.getAD_Table_ID());
				MColumn columns[] = table.getColumns(false);
				StringBuffer whereClause = new StringBuffer();
				List<Object> parameters = new ArrayList<Object>();
				boolean search = true;
				for(int i = 0; i < columns.length; i++) {
					MColumn column = columns[i];
					if (column.isParent()) {
						int parentId = 0;
						String parentTableName = null;
						if (column.getAD_Reference_ID() == DisplayType.TableDir) {
							parentTableName = column.getColumnName().substring(0, column.getColumnName().length() - 3);
						} else {
							String searchColumn = info.getColumnLookup(i).getColumnName();
							parentTableName = searchColumn.substring(0, searchColumn.indexOf("."));
						}
		
						Element parent = element.parent;
						while (parent != null) {
							if (parent.getElementValue().equalsIgnoreCase(parentTableName)) {
								parentId = parent.recordId;
								break;
							}
							parent = parent.parent;
						}
								
						if (parentId == 0) {
							Element parentElement = element.properties.get(column.getColumnName());
							if (parentElement != null) {
								parentId = ReferenceUtils.resolveReference(ctx.ctx, parentElement, getTrxName(ctx));
							}
						}
						if (parentId > 0) {
							if (whereClause.length() > 0)
								whereClause.append(" AND ");
							whereClause.append(column.getColumnName()).append(" = ?");
							parameters.add(parentId);
						} else {
							search = false;
							break;
						}
					} else if (column.isIdentifier()) {
						if (whereClause.length() > 0)
							whereClause.append(" AND ");
						whereClause.append(column.getColumnName()).append(" = ? ");
						
						String refTableName = null;
						if (column.getAD_Reference_ID() == DisplayType.TableDir) {
							refTableName = column.getColumnName().substring(0, column.getColumnName().length() - 3);
						} else if (column.getAD_Reference_ID() == DisplayType.Table ||
								column.getAD_Reference_ID() == DisplayType.Search) {
							String searchColumn = info.getColumnLookup(i).getColumnName();
							refTableName = searchColumn.substring(0, searchColumn.indexOf("."));
						}
							
						if (refTableName == null) {
							parameters.add(getStringValue(element, column.getColumnName()));
						} else {
							int refId = 0;
							Element parent = element.parent;
							while (parent != null) {
								if (parent.getElementValue().equalsIgnoreCase(refTableName)) {
									refId = parent.recordId;
									break;
								}
								parent = parent.parent;
							}
									
							if (refId == 0) {
								Element refElement = element.properties.get(column.getColumnName());
								if (refElement != null) {
									refId = ReferenceUtils.resolveReference(ctx.ctx, refElement, getTrxName(ctx));
								}
							}
							if (refId > 0) {
								parameters.add(refId);
							} else {
								search = false;
								break;
							}
						}
					}
				}
				if (whereClause.length() > 0 && search) {
					Query query = new Query(ctx.ctx, table, whereClause.toString(), getTrxName(ctx));
					po = query.setParameters(parameters).setApplyAccessFilter(true).first();
				}
	    	}
			if (po == null) {
				po = table.getPO(0, getTrxName(ctx));
			}
		}
		PoFiller filler = new PoFiller(ctx, po, element, this);
		List<String> excludes = defaultExcludeList(tableName);
		if (po.get_ID() == 0) {
			Element idElement = element.properties.get(tableName + "_ID");
			if (idElement != null && idElement.contents != null && idElement.contents.length() > 0) {
				int id = 0;
				try {
					id = Integer.parseInt(idElement.contents.toString());
					if (id > 0 && id <= PackOut.MAX_OFFICIAL_ID) {
						po.set_ValueNoCheck(tableName + "_ID", id);
					}
				} catch (Exception e) {}
			}
		}
		List<String> notfounds = filler.autoFill(excludes);
		/* Verify if the table has entitytype and check dictionary maintenance */
		int idxet = po.get_ColumnIndex("EntityType");
		if (idxet >= 0) {
			String entityType = (String) po.get_Value(idxet);
			if (! isProcessElement(ctx.ctx, entityType)) {
				log.info("Generic PO not processed as it's official " + po.toString());
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
				
				boolean createElement = true;
				if (ctx.packOut.getFromDate() != null) {
					if (po.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
						createElement = false;
					}
				}

				if (createElement) {
					if (po.get_ID() > 0) {
						ElementHandler handler = ctx.packOut.getHandler(po.get_TableName());
						if (handler != null && !handler.getClass().equals(this.getClass()) ) {
							handler.packOut(ctx.packOut, document, ctx.logDocument, po.get_ID());
							createElement = false;
						}
					}
					if (createElement) {
						addTypeName(atts, "table");
						document.startElement("","", tableName, atts);
						PoExporter filler = new PoExporter(ctx, document, po);
						filler.export(excludes, true);
						if (po.get_ID() > 0 && po.get_ID() < 1000000) {
							filler.add(tableName+"_ID", new AttributesImpl());
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

				boolean createElement = true;
				if (ctx.packOut.getFromDate() != null) {
					if (po.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
						createElement = false;
					}
				}
				if (createElement) {
					if (po.get_ID() > 0) {
						ElementHandler handler = ctx.packOut.getHandler(po.get_TableName());
						if (handler != null && !handler.getClass().equals(this.getClass()) ) {
							handler.packOut(ctx.packOut, document, ctx.logDocument, po.get_ID());
							createElement = false;
						}
					}
					if (createElement) {
						List<String> excludes = defaultExcludeList(tables[index]);
						addTypeName(atts, "table");
						document.startElement("", "", tables[index], atts);
						PoExporter filler = new PoExporter(ctx, document, po);
						filler.export(excludes, true);
					}
				}
				if (index + 1 < tables.length) {
					exportDetail(ctx, document, po, index+1, tables);
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