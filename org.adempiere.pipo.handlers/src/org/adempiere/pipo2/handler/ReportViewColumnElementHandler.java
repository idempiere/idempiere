/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - Nicolas Micoud (TGI)											   *
 **********************************************************************/
package org.adempiere.pipo2.handler;

import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_ReportView_Column;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

/**
 * Report View Column (AD_ReportView_Column) element handler
 * @author Nicolas Micoud (TGI)
 */
public class ReportViewColumnElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_ReportView_Column.Table_Name);

		String entitytype = getStringValue(element,"EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			excludes.add("AD_Table_ID");
			X_AD_ReportView_Column mReportviewColumn = findPO(ctx, element);
			if (mReportviewColumn == null) {
				mReportviewColumn = new X_AD_ReportView_Column(ctx.ctx, 0, getTrxName(ctx));
			}

			PoFiller filler = new PoFiller(ctx, mReportviewColumn, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			if (mReportviewColumn.is_new() || mReportviewColumn.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_ReportView_Column.Table_Name,
						X_AD_ReportView_Column.Table_ID);
				String action = null;
				if (!mReportviewColumn.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_ReportView_Column.Table_Name,
							mReportviewColumn);
					action = "Update";
				} else {
					action = "New";
				}
				if (mReportviewColumn.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, "" + mReportviewColumn.getAD_ReportView_ID(),
							mReportviewColumn.get_ID(), action);
				} else {
					logImportDetail(ctx, impDetail, 0, "" + mReportviewColumn.getAD_ReportView_ID(),
							mReportviewColumn.get_ID(),action);
					throw new POSaveFailedException("Failed to save ReportViewColumn");
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

		X_AD_ReportView_Column po = (X_AD_ReportView_Column) ctx.ctx.get("po");

		if (po != null) {

			if (!isPackOutElement(ctx, po))
				return;
			
			verifyPackOutRequirement(po);
			
			AttributesImpl atts = new AttributesImpl();
			addTypeName(atts, "table");
			document.startElement("", "", X_AD_ReportView_Column.Table_Name, atts);
			createReportViewColumnBinding(ctx, document, po);
			document.endElement("", "", X_AD_ReportView_Column.Table_Name);
		}
	}

	private void createReportViewColumnBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_ReportView_Column m_Reportview_Column) {

		PoExporter filler = new PoExporter(ctx, document, m_Reportview_Column);
		List<String> excludes = defaultExcludeList(X_AD_ReportView_Column.Table_Name);
		filler.add("AD_ReportView_Column_UU", new AttributesImpl());
		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId)
			throws Exception {
		throw new AdempiereException("X_AD_ReportView_Column doesn't have ID, use method with UUID");
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId, String uuid) throws Exception {
		X_AD_ReportView_Column po = new Query(packout.getCtx().ctx, X_AD_ReportView_Column.Table_Name, "X_AD_ReportView_Column_UU=?", getTrxName(packout.getCtx()))
				.setParameters(uuid)
				.first();
		
		if (po != null) {
			packout.getCtx().ctx.put("po", po);
			this.create(packout.getCtx(), packoutHandler);
			packout.getCtx().ctx.remove("po", po);
		} else {
			throw new AdempiereException("AD_Process_Access_UU not found = " + uuid);
		}
	}
}
