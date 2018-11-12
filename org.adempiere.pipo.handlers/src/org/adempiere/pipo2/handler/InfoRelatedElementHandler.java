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
import org.compiere.model.I_AD_InfoRelated;
import org.compiere.model.I_AD_InfoWindow;
import org.compiere.model.X_AD_InfoRelated;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class InfoRelatedElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_InfoRelated.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			if (isParentDefer(element, I_AD_InfoWindow.Table_Name)) {
				element.defer = true;
				return;
			}

			X_AD_InfoRelated mInfoRelated = findPO(ctx, element);
			if (mInfoRelated == null) {
				mInfoRelated = new X_AD_InfoRelated(ctx.ctx, 0, getTrxName(ctx));
			}
			PoFiller filler = new PoFiller(ctx, mInfoRelated, element, this);

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			element.recordId = mInfoRelated.get_ID();
			if (mInfoRelated.is_new() || mInfoRelated.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_InfoRelated.Table_Name, X_AD_InfoRelated.Table_ID);
				String action = null;
				if (!mInfoRelated.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_InfoRelated.Table_Name, mInfoRelated);
					action = "Update";
				} else {
					action = "New";
				}
				if (mInfoRelated.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mInfoRelated.toString(), mInfoRelated.get_ID(), action);
					element.recordId = mInfoRelated.get_ID();
				} else {
					logImportDetail(ctx, impDetail, 0, mInfoRelated.toString(), mInfoRelated.get_ID(), action);
					throw new POSaveFailedException("Failed to save InfoRelated " + mInfoRelated.toString());
				}
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		int AD_InfoRelated_ID = Env.getContextAsInt(ctx.ctx, X_AD_InfoRelated.COLUMNNAME_AD_InfoRelated_ID);
		if (ctx.packOut.isExported(X_AD_InfoRelated.COLUMNNAME_AD_InfoRelated_ID+"|"+AD_InfoRelated_ID))
			return;

		X_AD_InfoRelated m_InfoRelated = new X_AD_InfoRelated(ctx.ctx, AD_InfoRelated_ID, getTrxName(ctx));

		if (!isPackOutElement(ctx, m_InfoRelated))
			return;

		verifyPackOutRequirement(m_InfoRelated);

		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_InfoRelated.Table_Name, atts);
		createInfoRelatedBinding(ctx, document, m_InfoRelated);

		PackOut packOut = ctx.packOut;
		packOut.getCtx().ctx.put("Table_Name",I_AD_InfoRelated.Table_Name);
		try {
			new CommonTranslationHandler().packOut(packOut,document,null,m_InfoRelated.get_ID());
		} catch(Exception e) {
			if (log.isLoggable(Level.INFO)) log.info(e.toString());
		}

		document.endElement("", "", I_AD_InfoRelated.Table_Name);
	}

	private void createInfoRelatedBinding(PIPOContext ctx, TransformerHandler document, X_AD_InfoRelated m_InfoRelated) {

		PoExporter filler = new PoExporter(ctx, document, m_InfoRelated);
		List<String> excludes = defaultExcludeList(X_AD_InfoRelated.Table_Name);

		if (m_InfoRelated.getAD_InfoRelated_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_InfoRelated_ID", new AttributesImpl());
		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_InfoRelated.COLUMNNAME_AD_InfoRelated_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_InfoRelated.COLUMNNAME_AD_InfoRelated_ID);
	}
}
