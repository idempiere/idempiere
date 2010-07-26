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
import org.adempiere.pipo2.ReferenceUtils;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.compiere.model.I_AD_Ref_Table;
import org.compiere.model.I_AD_Reference;
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
		if (isProcessElement(ctx, entitytype)) {
			if (isParentSkip(element, null)) {
				element.skip = true;
				return;
			}

			X_AD_Ref_Table refTable = findPO(ctx, element);
			if (refTable == null) {
				int AD_Reference_ID = 0;
				if (getParentId(element, I_AD_Reference.Table_Name) > 0) {
					AD_Reference_ID = getParentId(element, I_AD_Reference.Table_Name);
				} else {
					Element referenceElement = element.properties.get(I_AD_Ref_Table.COLUMNNAME_AD_Reference_ID);
					AD_Reference_ID = ReferenceUtils.resolveReference(ctx, referenceElement);
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
					if (rs.next()) {
						refTable = new X_AD_Ref_Table(ctx, rs, getTrxName(ctx));
					} else {
						refTable = new X_AD_Ref_Table(ctx, 0, getTrxName(ctx));
					}					
				} catch (Exception e) {
					throw new DatabaseAccessException(e.getLocalizedMessage(), e);
				} finally {
					DB.close(rs, pstmt);
				}
			}
			String action = refTable.is_new() ? "New" : "Update";
			PoFiller filler = new PoFiller(ctx, refTable, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}
			int tableId = refTable.getAD_Table_ID();
			Element displayElement = element.properties.get("AD_Display");
			int displayColumnId = 0;
			if (ReferenceUtils.isIDLookup(displayElement) || ReferenceUtils.isUUIDLookup(displayElement)) {
				displayColumnId = ReferenceUtils.resolveReference(ctx, displayElement);
			} else {
				displayColumnId = findIdByColumnAndParentId(ctx, "AD_Column", "ColumnName", displayElement.contents.toString(), "AD_Table", tableId);
			}				
			refTable.setAD_Display(displayColumnId);
			
			
			Element keyElement = element.properties.get("AD_Key");
			int keyColumnId = 0;
			if (ReferenceUtils.isIDLookup(keyElement) || ReferenceUtils.isUUIDLookup(keyElement)) {
				keyColumnId = ReferenceUtils.resolveReference(ctx, keyElement);
			} else {
				keyColumnId = findIdByColumnAndParentId(ctx, "AD_Column", "ColumnName", keyElement.contents.toString(), "AD_Table", tableId);
			}				
			refTable.setAD_Key(keyColumnId);
			
			if (refTable.is_new() || refTable.is_Changed()) {
				refTable.saveEx();
	
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Ref_Table.Table_Name,
						X_AD_Ref_Table.Table_ID);
	
				logImportDetail(ctx, impDetail, 1, refTable.getAD_Reference().getName(), refTable.getAD_Reference_ID(), action);
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
		addTypeName(atts, "ad.reference.table");
		document.startElement("", "", I_AD_Ref_Table.Table_Name, atts);
		createReferenceTableBinding(ctx, document, Reference_id);
		document.endElement("", "", I_AD_Ref_Table.Table_Name);
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
