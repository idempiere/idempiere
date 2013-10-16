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
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_PrintFormatItem;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_PrintFormatItem;
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
			mPrintFormatItem = new X_AD_PrintFormatItem(ctx.ctx, 0, getTrxName(ctx));
		}
		PoFiller filler = new PoFiller(ctx, mPrintFormatItem, element, this);
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

		if (!isPackOutElement(ctx, m_PrintFormatItem))
			return;

		verifyPackOutRequirement(m_PrintFormatItem);
		
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
