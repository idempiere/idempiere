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
 * Copyright (C) 2005 Robert Klein. robeklein@hotmail.com
 * Contributor(s): Low Heng Sin hengsin@avantz.com
 *****************************************************************************/
package org.adempiere.pipo2.handler;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Ref_Table;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ReferenceTableElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element)
			throws SAXException {

		List<String > excludes = defaultExcludeList(X_AD_Ref_Table.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		String name = getStringValue(element, "AD_Reference_ID", excludes);
		if (isProcessElement(ctx, entitytype)) {
			if (isParentSkip(element, null)) {
				element.skip = true;
				return;
			}

			int AD_Reference_ID = 0;
			if (getParentId(element, "reference") > 0) {
				AD_Reference_ID = getParentId(element, "reference");
			} else {
				AD_Reference_ID = DB.getSQLValue(getTrxName(ctx), "SELECT AD_Reference_ID FROM AD_Reference WHERE Name = ? AND AD_Client_ID = ?", name, Env.getAD_Client_ID(ctx));
			}
			if (AD_Reference_ID <= 0 && isOfficialId(element, "AD_Reference_ID"))
				AD_Reference_ID = getIntValue(element, "AD_Reference_ID");

			String sql = "SELECT * FROM AD_Ref_Table WHERE AD_Reference_ID = ?";
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				pstmt = DB.prepareStatement(sql, getTrxName(ctx));
				pstmt.setInt(1, AD_Reference_ID);
				rs = pstmt.executeQuery();
				X_AD_Ref_Table refTable = null;
				String action = null;
				if (rs.next()) {
					refTable = new X_AD_Ref_Table(ctx, rs, getTrxName(ctx));
					action = "Update";
				} else {
					refTable = new X_AD_Ref_Table(ctx, 0, getTrxName(ctx));
					action = "New";
				}
				PoFiller filler = new PoFiller(ctx, refTable, element, this);
				List<String> notfounds = filler.autoFill(excludes);
				if (notfounds.size() > 0) {
					element.defer = true;
					return;
				}
				int tableId = refTable.getAD_Table_ID();
				String columnName = getStringValue(element, "AD_Display", excludes);
				int columnId = findIdByColumnAndParentId(ctx, "AD_Column", "ColumnName", columnName, "AD_Table", tableId);
				refTable.setAD_Display(columnId);
				columnName = getStringValue(element, "AD_Key", excludes);
				columnId = findIdByColumnAndParentId(ctx, "AD_Column", "ColumnName", columnName, "AD_Table", tableId);
				refTable.setAD_Key(columnId);
				refTable.saveEx();

				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Ref_Table.Table_Name,
						X_AD_Ref_Table.Table_ID);

				logImportDetail(ctx, impDetail, 1, name, AD_Reference_ID, action);
			} catch (Exception e) {
				throw new DatabaseAccessException(e.getLocalizedMessage(), e);
			} finally {
				DB.close(rs, pstmt);
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int Reference_id = Env.getContextAsInt(ctx,
				X_AD_Ref_Table.COLUMNNAME_AD_Reference_ID);
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.reference.table");
		document.startElement("", "", "referencetable", atts);
		createReferenceTableBinding(ctx, document, Reference_id);
		document.endElement("", "", "referencetable");
	}

	private void createReferenceTableBinding(Properties ctx,
			TransformerHandler document, int reference_ID) {

		if (reference_ID <= PackOut.MAX_OFFICIAL_ID)
		{
			PoExporter filler = new PoExporter(ctx,document,null);
			filler.addString("AD_Reference_ID", Integer.toString(reference_ID), new AttributesImpl());
		}
		String sql = "SELECT * FROM AD_Ref_Table WHERE AD_Reference_ID= "
				+ reference_ID;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			if (rs.next()) {
				X_AD_Ref_Table refTable = new X_AD_Ref_Table(ctx, rs, getTrxName(ctx));
				PoExporter filler = new PoExporter(ctx,document,refTable);
				List<String > excludes = defaultExcludeList(X_AD_Ref_Table.Table_Name);
				excludes.add("ad_display");
				excludes.add("ad_key");
				filler.export(excludes);
				filler.addTableReference("AD_Display", "AD_Column", "ColumnName", new AttributesImpl());
				filler.addTableReference("AD_Key", "AD_Column", "ColumnName", new AttributesImpl());
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			throw new DatabaseAccessException("Failed to export Reference Table", e);
		} finally {
			DB.close(rs, pstmt);
		}
	}
}
