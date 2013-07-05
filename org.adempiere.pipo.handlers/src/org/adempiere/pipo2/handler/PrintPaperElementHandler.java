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

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_PrintPaper;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_PrintPaper;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class PrintPaperElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		
		List<String> excludes = defaultExcludeList(X_AD_PrintPaper.Table_Name);
		
		X_AD_PrintPaper printPaper = findPO(ctx, element);

		if (printPaper == null) {
			String printPaperName = getStringValue(element, "Name", excludes);
			int id = 0;
			if (!hasUUIDKey(ctx, element)) {
				id = findIdByName(ctx, "AD_PrintPaper", printPaperName);
			}
			printPaper = new X_AD_PrintPaper(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
			printPaper.setName(printPaperName);
		}
		PoFiller filler = new PoFiller(ctx, printPaper, element, this);

		if (printPaper.getAD_PrintPaper_ID() == 0 && isOfficialId(element, "AD_PrintPaper_ID"))
			filler.setInteger("AD_PrintPaper_ID");		

		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			element.unresolved = notfounds.toString();
			return;
		}

		if (printPaper.is_new() || printPaper.is_Changed()) {
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_PrintPaper.Table_Name, X_AD_PrintPaper.Table_ID);
			String action = null;
			if (!printPaper.is_new()) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), "AD_PrintPaper", printPaper);
				action = "Update";
			} else {
				action = "New";
			}
			if (printPaper.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, printPaper.getName(),
						printPaper.get_ID(), action);
			} else {
				logImportDetail(ctx, impDetail, 0, printPaper.getName(),
						printPaper.get_ID(), action);
				throw new POSaveFailedException("Failed to save PrintPaper " + printPaper.getName());
			}
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int AD_PrintPaper_ID = Env.getContextAsInt(ctx.ctx,
				X_AD_PrintPaper.COLUMNNAME_AD_PrintPaper_ID);
		X_AD_PrintPaper printPaper = new X_AD_PrintPaper(ctx.ctx,
				AD_PrintPaper_ID, null);

		if (ctx.packOut.getFromDate() != null) {
			if (printPaper.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_PrintPaper.Table_Name, atts);
		createPrintPaperBinding(ctx, document, printPaper);
		document.endElement("", "", I_AD_PrintPaper.Table_Name);
	}

	private void createPrintPaperBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_PrintPaper printPaper) {

		PoExporter filler = new PoExporter(ctx, document, printPaper);
		List<String> excludes = defaultExcludeList(X_AD_PrintPaper.Table_Name);

		if (printPaper.getAD_PrintPaper_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_PrintPaper_ID", new AttributesImpl());

		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, X_AD_PrintPaper.COLUMNNAME_AD_PrintPaper_ID, recordId);

		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_PrintPaper.COLUMNNAME_AD_PrintPaper_ID);
	}
}
