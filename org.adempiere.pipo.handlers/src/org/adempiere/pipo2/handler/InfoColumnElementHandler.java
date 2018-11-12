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
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Element;
import org.compiere.model.I_AD_InfoColumn;
import org.compiere.model.I_AD_InfoWindow;
import org.compiere.model.X_AD_InfoColumn;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class InfoColumnElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_InfoColumn.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			if (isParentDefer(element, I_AD_InfoWindow.Table_Name)) {
				element.defer = true;
				return;
			}

			X_AD_InfoColumn mInfoColumn = findPO(ctx, element);
			if (mInfoColumn == null) {
				mInfoColumn = new X_AD_InfoColumn(ctx.ctx, 0, getTrxName(ctx));
			}
			PoFiller filler = new PoFiller(ctx, mInfoColumn, element, this);

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			element.recordId = mInfoColumn.get_ID();
			if (mInfoColumn.is_new() || mInfoColumn.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_InfoColumn.Table_Name, X_AD_InfoColumn.Table_ID);
				String action = null;
				if (!mInfoColumn.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_InfoColumn.Table_Name, mInfoColumn);
					action = "Update";
				} else {
					action = "New";
				}
				if (mInfoColumn.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mInfoColumn.getColumnName(), mInfoColumn.get_ID(), action);
					element.recordId = mInfoColumn.get_ID();
				} else {
					logImportDetail(ctx, impDetail, 0, mInfoColumn.getColumnName(), mInfoColumn.get_ID(), action);
					throw new POSaveFailedException("Failed to save InfoColumn " + mInfoColumn.getColumnName());
				}
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		int AD_InfoColumn_ID = Env.getContextAsInt(ctx.ctx, X_AD_InfoColumn.COLUMNNAME_AD_InfoColumn_ID);
		if (ctx.packOut.isExported(X_AD_InfoColumn.COLUMNNAME_AD_InfoColumn_ID+"|"+AD_InfoColumn_ID))
			return;

		X_AD_InfoColumn m_InfoColumn = new X_AD_InfoColumn(ctx.ctx, AD_InfoColumn_ID, getTrxName(ctx));

		if (m_InfoColumn.getAD_Element_ID() > 0) {
			PackOut packOut = ctx.packOut;
			ElementHandler handler = packOut.getHandler(I_AD_Element.Table_Name);
			try {
				handler.packOut(packOut,document,null,m_InfoColumn.getAD_Element_ID());
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}

		if (!isPackOutElement(ctx, m_InfoColumn))
			return;

		verifyPackOutRequirement(m_InfoColumn);

		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_InfoColumn.Table_Name, atts);
		createInfoColumnBinding(ctx, document, m_InfoColumn);

		PackOut packOut = ctx.packOut;
		packOut.getCtx().ctx.put("Table_Name",I_AD_InfoColumn.Table_Name);
		try {
			new CommonTranslationHandler().packOut(packOut,document,null,m_InfoColumn.get_ID());
		} catch(Exception e) {
			if (log.isLoggable(Level.INFO)) log.info(e.toString());
		}

		document.endElement("", "", I_AD_InfoColumn.Table_Name);
	}

	private void createInfoColumnBinding(PIPOContext ctx, TransformerHandler document, X_AD_InfoColumn m_InfoColumn) {

		PoExporter filler = new PoExporter(ctx, document, m_InfoColumn);
		List<String> excludes = defaultExcludeList(X_AD_InfoColumn.Table_Name);

		if (m_InfoColumn.getAD_InfoColumn_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_InfoColumn_ID", new AttributesImpl());
		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_InfoColumn.COLUMNNAME_AD_InfoColumn_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_InfoColumn.COLUMNNAME_AD_InfoColumn_ID);
	}
}
