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
 *                 Teo Sarca, SC ARHIPAC SERVICE SRL
 *****************************************************************************/
package org.adempiere.pipo2.handler;

import java.util.List;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_PrintFormatItem;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_PrintFormatItem;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class PrintFormatItemElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {

		List<String> excludes = defaultExcludeList(X_AD_PrintFormatItem.Table_Name);

		if (isParentDefer(element, I_AD_PrintFormatItem.Table_Name)) {
			element.defer = true;
			return;
		}

		X_AD_PrintFormatItem mPrintFormatItem = findPO(ctx, element);
		if (mPrintFormatItem == null) {
			int parentId = 0;
			if (getParentId(element, I_AD_PrintFormatItem.Table_Name) > 0) {
				parentId = getParentId(element, I_AD_PrintFormatItem.Table_Name);
			} else {
				Element pfElement = element.properties.get(I_AD_PrintFormatItem.COLUMNNAME_AD_PrintFormat_ID);
				parentId = ReferenceUtils.resolveReference(ctx.ctx, pfElement, getTrxName(ctx));
			}
			if (parentId <= 0) {
				element.defer = true;
				element.unresolved = "AD_PrintFormat_ID";
				return;
			}

			int id = 0;
			if (!hasUUIDKey(ctx, element)) {
				String name = getStringValue(element, "Name");
				id = findIdByNameAndParentId(ctx, "AD_PrintFormatItem", name, "AD_PrintFormat", parentId);
			}
			mPrintFormatItem = new X_AD_PrintFormatItem(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
			mPrintFormatItem.setAD_PrintFormat_ID(parentId);
			excludes.add(I_AD_PrintFormatItem.COLUMNNAME_AD_PrintFormat_ID);
		}
		PoFiller filler = new PoFiller(ctx, mPrintFormatItem, element, this);

		if (mPrintFormatItem.getAD_PrintFormatItem_ID() == 0 && isOfficialId(element, "AD_PrintFormatItem_ID"))
			filler.setInteger("AD_PrintFormatItem_ID");

		excludes.add("AD_Table_ID");
		excludes.add("AD_Column_ID");
		int columnId = 0;
		Element columnElement = element.properties.get("AD_Column_ID");
		if (ReferenceUtils.isIDLookup(columnElement) || ReferenceUtils.isUUIDLookup(columnElement)) {
			columnId = ReferenceUtils.resolveReference(ctx.ctx, columnElement, getTrxName(ctx));
		} else {
			Element tableElement = element.properties.get("AD_Table_ID");
			int tableId = ReferenceUtils.resolveReference(ctx.ctx, tableElement, getTrxName(ctx));
			String columnName = getStringValue(element, "AD_Column_ID");
			columnId = findIdByColumnAndParentId(ctx, "AD_Column", "ColumnName", columnName,
				"AD_Table", tableId);
		}
		if (columnId > 0)
			mPrintFormatItem.setAD_Column_ID(columnId);

		excludes.add("AD_PrintFormatChild_ID");
		Element pfchildElement = element.properties.get(I_AD_PrintFormatItem.COLUMNNAME_AD_PrintFormatChild_ID);
		int AD_PrintFormatChild_ID = ReferenceUtils.resolveReference(ctx.ctx, pfchildElement, getTrxName(ctx));
		if (AD_PrintFormatChild_ID > 0) {
			mPrintFormatItem.setAD_PrintFormatChild_ID(AD_PrintFormatChild_ID);
		} else if (pfchildElement.contents != null && pfchildElement.contents.length() > 0) {
			element.defer = true;
			element.unresolved = "AD_PrintFormat: " + pfchildElement.contents;
			return;

		}

		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			element.unresolved = notfounds.toString();
			return;
		}

		element.recordId = mPrintFormatItem.get_ID();
		if (mPrintFormatItem.is_new() || mPrintFormatItem.is_Changed()) {
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_PrintFormatItem.Table_Name,
					X_AD_PrintFormatItem.Table_ID);
			String action = null;
			if (!mPrintFormatItem.is_new()) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_PrintFormatItem.Table_Name, mPrintFormatItem);
				action = "Update";
			} else {
				action = "New";
			}
			if (mPrintFormatItem.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, mPrintFormatItem.getName(),
						mPrintFormatItem.get_ID(), action);
				element.recordId = mPrintFormatItem.get_ID();
			} else {
				logImportDetail(ctx, impDetail, 0, mPrintFormatItem.getName(),
						mPrintFormatItem.get_ID(), action);
				throw new POSaveFailedException("Failed to save PrintFormatItem " + mPrintFormatItem.getName());
			}
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int AD_PrintFormatItem_ID = Env.getContextAsInt(ctx.ctx,
				X_AD_PrintFormatItem.COLUMNNAME_AD_PrintFormatItem_ID);
		if (ctx.packOut.isExported(X_AD_PrintFormatItem.COLUMNNAME_AD_PrintFormatItem_ID+"|"+AD_PrintFormatItem_ID))
			return;

		X_AD_PrintFormatItem m_PrintFormatItem = new X_AD_PrintFormatItem(ctx.ctx,
				AD_PrintFormatItem_ID, null);

		if (ctx.packOut.getFromDate() != null) {
			if (m_PrintFormatItem.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		PackOut packOut = ctx.packOut;
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_PrintFormatItem.Table_Name, atts);
		createPrintFormatItemBinding(ctx, document, m_PrintFormatItem);

		packOut.getCtx().ctx.put("Table_Name",I_AD_PrintFormatItem.Table_Name);
		try {
			new CommonTranslationHandler().packOut(packOut,document,null,m_PrintFormatItem.get_ID());
		} catch(Exception e) {
			if (log.isLoggable(Level.INFO)) log.info(e.toString());
		}

		document.endElement("", "", I_AD_PrintFormatItem.Table_Name);
	}

	private void createPrintFormatItemBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_PrintFormatItem mPrintformatItem) {

		PoExporter filler = new PoExporter(ctx, document, mPrintformatItem);
		List<String> excludes = defaultExcludeList(X_AD_PrintFormatItem.Table_Name);

		if (mPrintformatItem.getAD_PrintFormatItem_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_PrintFormatItem_ID", new AttributesImpl());

		if (mPrintformatItem.getAD_Client_ID() == 0 && mPrintformatItem.getAD_Column_ID() > 0) {
			String sql = "SELECT AD_Table_ID FROM AD_Column WHERE AD_Column_ID=?";
			int tableID = DB.getSQLValue(null, sql, mPrintformatItem.getAD_Column_ID());
			AttributesImpl referenceAtts = new AttributesImpl();
			filler.addTableReference("AD_Table_ID", "AD_Table", "TableName", tableID, referenceAtts);
		}

		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {

		Env.setContext(packout.getCtx().ctx, X_AD_PrintFormatItem.COLUMNNAME_AD_PrintFormatItem_ID, recordId);

		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_PrintFormatItem.COLUMNNAME_AD_PrintFormatItem_ID);
	}
}
