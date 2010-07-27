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
import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.model.GenericPO;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.IPackOutHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.compiere.model.MColumn;
import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Exp_Detail;
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
public class GenericPOElementHandler extends AbstractElementHandler implements IPackOutHandler {

	public GenericPOElementHandler() {
	}

	public void startElement(Properties ctx, Element element) throws SAXException {
		String tableName = element.getElementValue();

		PO po = findPO(ctx, element);
		if (po == null) {
			MTable table = MTable.get(ctx, tableName);
			POInfo info = POInfo.getPOInfo(ctx, table.getAD_Table_ID());
			MColumn columns[] = table.getColumns(false);
			StringBuffer whereClause = new StringBuffer();
			List<Object> parameters = new ArrayList<Object>();
			for(int i = 0; i < columns.length; i++) {
				MColumn column = columns[i];
				if (column.isIdentifier()) {
					if (whereClause.length() > 0)
						whereClause.append(" AND ");
					whereClause.append(column.getColumnName()).append(" = ? ");
					parameters.add(getStringValue(element, column.getColumnName()));
				} else if (column.isParent()) {
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
					if (parentId > 0) {
						if (whereClause.length() > 0)
							whereClause.append(" AND ");
						whereClause.append(column.getColumnName()).append(" = ?");
						parameters.add(parentId);
					}
				}
			}
			Query query = new Query(ctx, table, whereClause.toString(), getTrxName(ctx));
			po = query.setParameters(parameters).first();
			if (po == null) {
				po = new GenericPO(tableName, ctx, 0);
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
						po.set_ValueOfColumn(tableName + "_ID", id);
					}
				} catch (Exception e) {}
			}
		}
		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			return;
		}
		po.saveEx();
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		AttributesImpl atts = new AttributesImpl();

		String sql = Env.getContext(ctx, X_AD_Package_Exp_Detail.COLUMNNAME_SQLStatement);
		String components[] = null;
		if (sql.indexOf(";") > 0) {
			components = sql.split("[;]");
			sql = components[0];
		} else {
			components = new String[]{sql};
		}
		int tableId = Env.getContextAsInt(ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Table_ID);
		String tableName = MTable.getTableName(ctx, tableId);
		List<String> excludes = defaultExcludeList(tableName);
		Statement stmt = null;
		ResultSet rs = null;
		try {
			sql = MRole.getDefault().addAccessSQL(sql, tableName, true, true);
			stmt = DB.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				GenericPO po = new GenericPO(tableName, ctx, rs);
				int AD_Client_ID = po.getAD_Client_ID();
				if (AD_Client_ID != Env.getAD_Client_ID(ctx))
					continue;
				addTypeName(atts, "ad.po.generic");
				document.startElement("","", tableName, atts);
				PoExporter filler = new PoExporter(ctx, document, po);
				filler.export(excludes);

				for (int i = 1; i < components.length; i++) {
					String tables[] = components[i].split("[>]");
					exportDetail(ctx, document, po, 0, tables);
				}
				document.endElement("","",tableName);
			}
		} catch (Exception e)	{
			throw new AdempiereException(e);
		} finally {
			DB.close(rs, stmt);
		}
	}

	private void exportDetail(Properties ctx, TransformerHandler document, GenericPO parent, int index, String[] tables) {
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
				GenericPO po = new GenericPO(tables[index], ctx, rs);
				int AD_Client_ID = po.getAD_Client_ID();
				if (AD_Client_ID != Env.getAD_Client_ID(ctx))
					continue;
				List<String> excludes = defaultExcludeList(tables[index]);
				document.startElement("", "", tables[index], atts);
				PoExporter filler = new PoExporter(ctx, document, po);
				filler.export(excludes);
				if (index + 1 < tables.length) {
					exportDetail(ctx, document, po, index+1, tables);
				}
				document.endElement("","",tables[index]);
			}
		} catch (Exception e)	{
			throw new AdempiereException(e);
		} finally {
			DB.close(rs, pstmt);
		}

	}

	public void packOut(PackOut packout, MPackageExp header, MPackageExpDetail detail,TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx(), X_AD_Package_Exp_Detail.COLUMNNAME_AD_Table_ID, detail.getAD_Table_ID());
		Env.setContext(packout.getCtx(), X_AD_Package_Exp_Detail.COLUMNNAME_SQLStatement, detail.getSQLStatement());
		this.create(packout.getCtx(), packOutDocument);
		packout.getCtx().remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Table_ID);
		packout.getCtx().remove(X_AD_Package_Exp_Detail.COLUMNNAME_SQLStatement);
	}
}