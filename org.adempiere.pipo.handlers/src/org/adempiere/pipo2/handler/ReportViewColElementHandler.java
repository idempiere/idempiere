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

import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_ReportView_Col;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_ReportView_Col;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ReportViewColElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_ReportView_Col.Table_Name);

		String entitytype = getStringValue(element,"EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			excludes.add("AD_Table_ID");
			X_AD_ReportView_Col mReportviewCol = findPO(ctx, element);
			if (mReportviewCol == null) {
				mReportviewCol = new X_AD_ReportView_Col(ctx.ctx, 0, getTrxName(ctx));
			}

			PoFiller filler = new PoFiller(ctx, mReportviewCol, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			if (mReportviewCol.is_new() || mReportviewCol.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_ReportView_Col.Table_Name,
						X_AD_ReportView_Col.Table_ID);
				String action = null;
				if (!mReportviewCol.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_ReportView_Col.Table_Name,
							mReportviewCol);
					action = "Update";
				} else {
					action = "New";
				}
				if (mReportviewCol.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, "" + mReportviewCol.getAD_ReportView_ID(),
							mReportviewCol.get_ID(), action);
				} else {
					logImportDetail(ctx, impDetail, 0, "" + mReportviewCol.getAD_ReportView_ID(),
							mReportviewCol.get_ID(),action);
					throw new POSaveFailedException("Failed to save ReportViewCol");
				}
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int AD_ReportView_Col_ID = Env.getContextAsInt(ctx.ctx,
				X_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID);
		if (ctx.packOut.isExported(X_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID+"|"+AD_ReportView_Col_ID))
			return;

		X_AD_ReportView_Col m_Reportview_Col = new X_AD_ReportView_Col(ctx.ctx,
				AD_ReportView_Col_ID, getTrxName(ctx));
		
		if (!isPackOutElement(ctx, m_Reportview_Col))
			return;
		
		verifyPackOutRequirement(m_Reportview_Col);
		
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", X_AD_ReportView_Col.Table_Name, atts);
		createReportViewColBinding(ctx, document, m_Reportview_Col);
		document.endElement("", "", X_AD_ReportView_Col.Table_Name);
	}

	private void createReportViewColBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_ReportView_Col m_Reportview_Col) {

		PoExporter filler = new PoExporter(ctx, document, m_Reportview_Col);
		List<String> excludes = defaultExcludeList(X_AD_ReportView_Col.Table_Name);
		if (m_Reportview_Col.getAD_ReportView_Col_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_ReportView_Col_ID", new AttributesImpl());

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID);
	}
}
