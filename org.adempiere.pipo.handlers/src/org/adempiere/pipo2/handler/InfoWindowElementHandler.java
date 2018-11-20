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

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_InfoWindow;
import org.compiere.model.I_AD_Process;
import org.compiere.model.I_AD_Reference;
import org.compiere.model.I_AD_Table;
import org.compiere.model.I_AD_Val_Rule;
import org.compiere.model.Query;
import org.compiere.model.X_AD_InfoColumn;
import org.compiere.model.X_AD_InfoProcess;
import org.compiere.model.X_AD_InfoRelated;
import org.compiere.model.X_AD_InfoWindow;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class InfoWindowElementHandler extends AbstractElementHandler {

	private InfoColumnElementHandler infoColumnHandler = new InfoColumnElementHandler();
	private InfoProcessElementHandler infoProcessHandler = new InfoProcessElementHandler();
	private InfoRelatedElementHandler infoRelatedHandler = new InfoRelatedElementHandler();

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			X_AD_InfoWindow mInfoWindow = findPO(ctx, element);
			if (mInfoWindow == null) {
				mInfoWindow = new X_AD_InfoWindow(ctx.ctx, 0, getTrxName(ctx));
			}
			PoFiller filler = new PoFiller(ctx, mInfoWindow, element, this);
			List<String> excludes = defaultExcludeList(X_AD_InfoWindow.Table_Name);

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			element.recordId = mInfoWindow.get_ID();
			if (mInfoWindow.is_new() || mInfoWindow.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_InfoWindow.Table_Name, X_AD_InfoWindow.Table_ID);
				String action = null;
				if (!mInfoWindow.is_new()) {				
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_InfoWindow.Table_Name, mInfoWindow);
					action = "Update";
				} else {
					action = "New";
				}			

				if (mInfoWindow.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mInfoWindow.getName(), mInfoWindow.get_ID(), action);
					element.recordId = mInfoWindow.get_ID();
					element.requireRoleAccessUpdate = true;
				} else {
					logImportDetail(ctx, impDetail, 0, mInfoWindow.getName(), mInfoWindow.get_ID(), action);
					throw new POSaveFailedException("Failed to save InfoWindow " + mInfoWindow.getName());
				}
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		int AD_InfoWindow_ID = Env.getContextAsInt(ctx.ctx, "AD_InfoWindow_ID");
		if (ctx.packOut.isExported("AD_InfoWindow_ID"+"|"+AD_InfoWindow_ID))
			return;

		PackOut packOut = ctx.packOut;

		X_AD_InfoWindow m_InfoWindow = new X_AD_InfoWindow(ctx.ctx, AD_InfoWindow_ID, getTrxName(ctx));

		AttributesImpl atts = new AttributesImpl();

		try {
			if (m_InfoWindow.getAD_Table_ID() > 0) {
				ElementHandler handler = packOut.getHandler(I_AD_Table.Table_Name);
				handler.packOut(packOut,document,null,m_InfoWindow.getAD_Table_ID());
			}

			boolean createElement = isPackOutElement(ctx, m_InfoWindow);

			if (createElement) {
				verifyPackOutRequirement(m_InfoWindow);
				addTypeName(atts, "table");
				document.startElement("", "", I_AD_InfoWindow.Table_Name, atts);
				createInfoWindowBinding(ctx, document, m_InfoWindow);

				packOut.getCtx().ctx.put("Table_Name",I_AD_InfoWindow.Table_Name);
				try {
					new CommonTranslationHandler().packOut(packOut,document,null,m_InfoWindow.get_ID());
				} catch(Exception e) {
					if (log.isLoggable(Level.INFO)) log.info(e.toString());
				}

			}

			Query queryCols = new Query(ctx.ctx, "AD_InfoColumn", "AD_InfoWindow_ID = ?", getTrxName(ctx));
			List<X_AD_InfoColumn> infoColumnlist = queryCols.setParameters(AD_InfoWindow_ID).list();
			for (X_AD_InfoColumn infoColumn : infoColumnlist) {
				if (infoColumn.getAD_Reference_ID()>0)
				{
					ElementHandler handler = packOut.getHandler(I_AD_Reference.Table_Name);
					handler.packOut(packOut,document,null,infoColumn.getAD_Reference_ID());
				}

				if (infoColumn.getAD_Reference_Value_ID()>0)
				{
					ElementHandler handler = packOut.getHandler(I_AD_Reference.Table_Name);
					handler.packOut(packOut,document,null,infoColumn.getAD_Reference_Value_ID());
				}

				if (infoColumn.getAD_Val_Rule_ID() > 0)
				{
					ElementHandler handler = packOut.getHandler(I_AD_Val_Rule.Table_Name);
					handler.packOut(packOut,document,null,infoColumn.getAD_Val_Rule_ID());
				}

				createInfoColumn(ctx, document, infoColumn.getAD_InfoColumn_ID());
			}

			Query queryProc= new Query(ctx.ctx, "AD_InfoProcess", "AD_InfoWindow_ID = ?", getTrxName(ctx));
			List<X_AD_InfoProcess> infoProcesslist = queryProc.setParameters(AD_InfoWindow_ID).list();
			for (X_AD_InfoProcess infoProcess : infoProcesslist) {
				if (infoProcess.getAD_Process_ID()>0)
				{
					ElementHandler handler = packOut.getHandler(I_AD_Process.Table_Name);
					handler.packOut(packOut,document,null,infoProcess.getAD_Process_ID());
				}
				createInfoProcess(ctx, document, infoProcess.getAD_InfoProcess_ID());
			}

			Query queryRel= new Query(ctx.ctx, "AD_InfoRelated", "AD_InfoWindow_ID = ?", getTrxName(ctx));
			List<X_AD_InfoRelated> infoRelatedlist = queryRel.setParameters(AD_InfoWindow_ID).list();
			for (X_AD_InfoRelated infoRelated : infoRelatedlist) {
				createInfoRelated(ctx, document, infoRelated.getAD_InfoRelated_ID());
			}

			if (createElement) {
				document.endElement("", "", X_AD_InfoWindow.Table_Name);
			}
		} catch (Exception e) {
			throw new AdempiereException(e);
		}

	}

	private void createInfoColumn(PIPOContext ctx, TransformerHandler document, int AD_InfoColumn_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_InfoColumn.COLUMNNAME_AD_InfoColumn_ID, AD_InfoColumn_ID);
		infoColumnHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_InfoColumn.COLUMNNAME_AD_InfoColumn_ID);
	}

	private void createInfoProcess(PIPOContext ctx, TransformerHandler document, int AD_InfoProcess_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_InfoProcess.COLUMNNAME_AD_InfoProcess_ID, AD_InfoProcess_ID);
		infoProcessHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_InfoProcess.COLUMNNAME_AD_InfoProcess_ID);
	}

	private void createInfoRelated(PIPOContext ctx, TransformerHandler document, int AD_InfoRelated_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_InfoRelated.COLUMNNAME_AD_InfoRelated_ID, AD_InfoRelated_ID);
		infoRelatedHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_InfoRelated.COLUMNNAME_AD_InfoRelated_ID);
	}

	private void createInfoWindowBinding(PIPOContext ctx, TransformerHandler document, X_AD_InfoWindow m_InfoWindow) {
		PoExporter filler = new PoExporter(ctx, document, m_InfoWindow);
		List<String> excludes = defaultExcludeList(X_AD_InfoWindow.Table_Name);

		if (m_InfoWindow.getAD_InfoWindow_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_InfoWindow_ID", new AttributesImpl());

		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, "AD_InfoWindow_ID", recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove("AD_InfoWindow_ID");
	}
}
