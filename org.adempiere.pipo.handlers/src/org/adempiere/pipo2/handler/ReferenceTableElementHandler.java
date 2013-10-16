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
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.compiere.model.I_AD_Ref_Table;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Ref_Table;
import org.compiere.model.X_AD_Reference;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ReferenceTableElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {

		List<String > excludes = defaultExcludeList(X_AD_Ref_Table.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			if (isParentSkip(element, null)) {
				element.skip = true;
				return;
			}

			X_AD_Ref_Table refTable = findPO(ctx, element);
			if (refTable == null) {
				refTable = new X_AD_Ref_Table(ctx.ctx, 0, getTrxName(ctx));
			}
			String action = refTable.is_new() ? "New" : "Update";
			PoFiller filler = new PoFiller(ctx, refTable, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			Element displayElement = element.properties.get("AD_Display");
			int displayColumnId = ReferenceUtils.resolveReference(ctx.ctx, displayElement, getTrxName(ctx));
			refTable.setAD_Display(displayColumnId);


			Element keyElement = element.properties.get("AD_Key");
			int keyColumnId = ReferenceUtils.resolveReference(ctx.ctx, keyElement, getTrxName(ctx));
			refTable.setAD_Key(keyColumnId);

			if (refTable.is_new() || refTable.is_Changed()) {
				refTable.saveEx();

				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Ref_Table.Table_Name,
						X_AD_Ref_Table.Table_ID);

				int AD_Reference_ID = refTable.getAD_Reference_ID();
				X_AD_Reference adReference = new X_AD_Reference(ctx.ctx, AD_Reference_ID, getTrxName(ctx));
				logImportDetail(ctx, impDetail, 1, adReference.getName(), refTable.getAD_Reference_ID(), action);
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int Reference_id = Env.getContextAsInt(ctx.ctx, "AD_Reference_ID");
		createReferenceTableBinding(ctx, document, Reference_id);
	}

	private void createReferenceTableBinding(PIPOContext ctx,
			TransformerHandler document, int reference_ID) {

		String sql = "SELECT * FROM AD_Ref_Table WHERE AD_Reference_ID= "
				+ reference_ID;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			if (rs.next()) {
				X_AD_Ref_Table refTable = new X_AD_Ref_Table(ctx.ctx, rs, getTrxName(ctx));
				if (!isPackOutElement(ctx, refTable))
					return;

				verifyPackOutRequirement(refTable);
				
				AttributesImpl atts = new AttributesImpl();
				addTypeName(atts, "table");
				document.startElement("", "", X_AD_Ref_Table.Table_Name, atts);

				if (reference_ID <= PackOut.MAX_OFFICIAL_ID)
				{
					PoExporter filler = new PoExporter(ctx,document,null);
					filler.addString("AD_Reference_ID", Integer.toString(reference_ID), new AttributesImpl());
				}

				PoExporter filler = new PoExporter(ctx,document,refTable);
				List<String > excludes = defaultExcludeList(X_AD_Ref_Table.Table_Name);
				excludes.add("ad_display");
				excludes.add("ad_key");
				filler.export(excludes);
				filler.addTableReference("AD_Display", "AD_Column", new AttributesImpl());
				filler.addTableReference("AD_Key", "AD_Column", new AttributesImpl());
				
				document.endElement("", "", X_AD_Ref_Table.Table_Name);
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			throw new DatabaseAccessException("Failed to export Reference Table", e);
		} finally {
			DB.close(rs, pstmt);
		}
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_Ref_Table.COLUMNNAME_AD_Reference_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_Ref_Table.COLUMNNAME_AD_Reference_ID);
	}
}
