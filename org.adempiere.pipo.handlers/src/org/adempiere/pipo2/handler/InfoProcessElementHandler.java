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
 * - Carlos Ruiz (globalqss) - sponsored by FH                         *
 **********************************************************************/

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
import org.compiere.model.I_AD_InfoProcess;
import org.compiere.model.I_AD_InfoWindow;
import org.compiere.model.X_AD_InfoProcess;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class InfoProcessElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_InfoProcess.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			if (isParentDefer(element, I_AD_InfoWindow.Table_Name)) {
				element.defer = true;
				return;
			}

			X_AD_InfoProcess mInfoProcess = findPO(ctx, element);
			if (mInfoProcess == null) {
				mInfoProcess = new X_AD_InfoProcess(ctx.ctx, 0, getTrxName(ctx));
			}
			PoFiller filler = new PoFiller(ctx, mInfoProcess, element, this);

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			element.recordId = mInfoProcess.get_ID();
			if (mInfoProcess.is_new() || mInfoProcess.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_InfoProcess.Table_Name, X_AD_InfoProcess.Table_ID);
				String action = null;
				if (!mInfoProcess.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_InfoProcess.Table_Name, mInfoProcess);
					action = "Update";
				} else {
					action = "New";
				}
				if (mInfoProcess.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mInfoProcess.toString(), mInfoProcess.get_ID(), action);
					element.recordId = mInfoProcess.get_ID();
				} else {
					logImportDetail(ctx, impDetail, 0, mInfoProcess.toString(), mInfoProcess.get_ID(), action);
					throw new POSaveFailedException("Failed to save InfoProcess " + mInfoProcess.toString());
				}
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		int AD_InfoProcess_ID = Env.getContextAsInt(ctx.ctx, X_AD_InfoProcess.COLUMNNAME_AD_InfoProcess_ID);
		if (ctx.packOut.isExported(X_AD_InfoProcess.COLUMNNAME_AD_InfoProcess_ID+"|"+AD_InfoProcess_ID))
			return;

		X_AD_InfoProcess m_InfoProcess = new X_AD_InfoProcess(ctx.ctx, AD_InfoProcess_ID, getTrxName(ctx));

		if (!isPackOutElement(ctx, m_InfoProcess))
			return;

		verifyPackOutRequirement(m_InfoProcess);

		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_InfoProcess.Table_Name, atts);
		createInfoProcessBinding(ctx, document, m_InfoProcess);

		PackOut packOut = ctx.packOut;
		packOut.getCtx().ctx.put("Table_Name",I_AD_InfoProcess.Table_Name);
		try {
			new CommonTranslationHandler().packOut(packOut,document,null,m_InfoProcess.get_ID());
		} catch(Exception e) {
			if (log.isLoggable(Level.INFO)) log.info(e.toString());
		}

		document.endElement("", "", I_AD_InfoProcess.Table_Name);
	}

	private void createInfoProcessBinding(PIPOContext ctx, TransformerHandler document, X_AD_InfoProcess m_InfoProcess) {

		PoExporter filler = new PoExporter(ctx, document, m_InfoProcess);
		List<String> excludes = defaultExcludeList(X_AD_InfoProcess.Table_Name);

		if (m_InfoProcess.getAD_InfoProcess_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_InfoProcess_ID", new AttributesImpl());
		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_InfoProcess.COLUMNNAME_AD_InfoProcess_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_InfoProcess.COLUMNNAME_AD_InfoProcess_ID);
	}
}
