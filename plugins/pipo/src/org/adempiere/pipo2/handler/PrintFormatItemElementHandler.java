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
import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.IPackOutHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_PrintFormatItem;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class PrintFormatItemElementHandler extends AbstractElementHandler implements IPackOutHandler {

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		String action = null;
		List<String> excludes = defaultExcludeList(X_AD_PrintFormatItem.Table_Name);

		if (isParentDefer(element, "printformat")) {
			element.defer = true;
			return;
		}

		X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_PrintFormatItem.Table_Name,
				X_AD_PrintFormatItem.Table_ID);

		String printformatName = getStringValue(element, "AD_PrintFormat.Name", excludes);
		int parentId = 0;
		if (getParentId(element, "printformat") > 0) {
			parentId = getParentId(element, "printformat");
		} else {
			parentId = findIdByColumn(ctx, "AD_PrintFormat", "Name", printformatName);
		}
		if (parentId <= 0) {
			element.defer = true;
			return;
		}

		String name = getStringValue(element, "Name");
		int id = findIdByNameAndParentId(ctx, "AD_PrintFormatItem", name, "AD_PrintFormat", parentId);

		X_AD_PrintFormatItem mPrintFormatItem = new X_AD_PrintFormatItem(ctx,
				id, getTrxName(ctx));
		PoFiller filler = new PoFiller(ctx, mPrintFormatItem, element, this);

		if (id <= 0 && isOfficialId(element, "AD_PrintFormatItem_ID"))
			filler.setInteger("AD_PrintFormatItem_ID");
		if (id > 0) {
			backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_PrintFormatItem.Table_Name, mPrintFormatItem);
			action = "Update";
		} else {
			action = "New";
		}
		mPrintFormatItem.setAD_PrintFormat_ID(parentId);
		String tableName = getStringValue(element, "AD_Table.TableName", excludes);
		int tableId = findIdByColumn(ctx, "AD_Table", "TableName", tableName);
		String columnName = getStringValue(element, "AD_Column.ColumnName", excludes);
		int columnId = findIdByColumnAndParentId(ctx, "AD_Column", "ColumnName", columnName,
				"AD_Table", tableId);
		if (columnId > 0)
			mPrintFormatItem.setAD_Column_ID(columnId);

		String pftChildName = getStringValue(element, "AD_PrintFormatChild_ID.AD_PrintFormat.Name", excludes);
		if (pftChildName != null && pftChildName.trim().length() > 0) {
			id = findIdByColumn(ctx, "AD_PrintFormat", "Name", pftChildName);
			if (id <= 0) {
				element.defer = true;
				element.unresolved = "AD_PrintFormat: " + pftChildName;
				return;
			}
			mPrintFormatItem.setAD_PrintFormatChild_ID(id);
		}

		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			return;
		}

		if (mPrintFormatItem.save(getTrxName(ctx)) == true) {
			logImportDetail(ctx, impDetail, 1, mPrintFormatItem.getName(),
					mPrintFormatItem.get_ID(), action);
		} else {
			logImportDetail(ctx, impDetail, 0, mPrintFormatItem.getName(),
					mPrintFormatItem.get_ID(), action);
			throw new POSaveFailedException("PrintFormatItem");
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_PrintFormatItem_ID = Env.getContextAsInt(ctx,
				X_AD_PrintFormatItem.COLUMNNAME_AD_PrintFormatItem_ID);
		X_AD_PrintFormatItem m_PrintFormatItem = new X_AD_PrintFormatItem(ctx,
				AD_PrintFormatItem_ID, null);
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.print-format.item");
		document.startElement("", "", "printformatitem", atts);
		createPrintFormatItemBinding(ctx, document, m_PrintFormatItem);
		document.endElement("", "", "printformatitem");
	}

	private void createPrintFormatItemBinding(Properties ctx, TransformerHandler document,
			X_AD_PrintFormatItem m_PrintformatItem) {

		PoExporter filler = new PoExporter(ctx, document, m_PrintformatItem);
		List<String> excludes = defaultExcludeList(X_AD_PrintFormatItem.Table_Name);

		if (m_PrintformatItem.getAD_PrintFormatItem_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_PrintFormatItem_ID", new AttributesImpl());

		if (m_PrintformatItem.getAD_Column_ID() > 0) {
			String sql = "SELECT AD_Table_ID FROM AD_Column WHERE AD_Column_ID=?";
			int tableID = DB.getSQLValue(null, sql, m_PrintformatItem
					.getAD_Column_ID());
			sql = "SELECT TableName FROM AD_Table WHERE AD_Table_ID=?";
			String name = DB.getSQLValueString(null, sql, tableID);
			filler.addString("AD_Table.TableName", name, new AttributesImpl());
		}

		filler.export(excludes);
	}

	public void packOut(PackOut packout, MPackageExp packageExp,
			MPackageExpDetail packageExpDetail,
			TransformerHandler packOutDocument,
			TransformerHandler packageDocument, int recordId) throws Exception {

		Env.setContext(packout.getCtx(), X_AD_PrintFormatItem.COLUMNNAME_AD_PrintFormatItem_ID, recordId);

		this.create(packout.getCtx(), packOutDocument);
		packout.getCtx().remove(X_AD_PrintFormatItem.COLUMNNAME_AD_PrintFormatItem_ID);
	}
}
