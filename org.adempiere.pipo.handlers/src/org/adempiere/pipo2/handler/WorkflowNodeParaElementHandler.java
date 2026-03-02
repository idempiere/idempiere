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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

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
import org.compiere.model.I_AD_WF_Node_Para;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_WF_Node_Para;
import org.compiere.util.Env;
import org.compiere.wf.MWFNodePara;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class WorkflowNodeParaElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(MWFNodePara.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {

			MWFNodePara mWFNodePara = findPO(ctx, element);
			if (mWFNodePara == null) {
				mWFNodePara = new MWFNodePara(ctx.ctx, 0, getTrxName(ctx));
			}

			PoFiller filler = new PoFiller(ctx, mWFNodePara, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			if (mWFNodePara.is_new() || mWFNodePara.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_WF_Node_Para.Table_Name,
						X_AD_WF_Node_Para.Table_ID);
				String action = null;
				if (!mWFNodePara.is_new()){
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_WF_Node_Para.Table_Name,mWFNodePara);
					action = "Update";
				} else{
					action = "New";
				}
				if (mWFNodePara.save(getTrxName(ctx))){
					log.info("m_WFNodePara save success");
					logImportDetail (ctx, impDetail, 1, String.valueOf(mWFNodePara.get_ID()),mWFNodePara.get_ID(), action);
				} else{
					log.info("m_WFNodePara save failure");
					logImportDetail (ctx, impDetail, 0, String.valueOf(mWFNodePara.get_ID()), mWFNodePara.get_ID(), action);
					throw new POSaveFailedException("Failed to save WorkflowNodePara");
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
		int AD_WF_Node_Para_id = Env.getContextAsInt(ctx.ctx, "AD_WF_Node_Para_ID");
		if (ctx.packOut.isExported("AD_WF_Node_Para_ID"+"|"+AD_WF_Node_Para_id))
			return;

		MWFNodePara m_WF_NodePara = new MWFNodePara(
				ctx.ctx, AD_WF_Node_Para_id, null);
		if (!isPackOutElement(ctx, m_WF_NodePara))
			return;
		verifyPackOutRequirement(m_WF_NodePara);
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_WF_Node_Para.Table_Name, atts);
		createWorkflowNodeParaBinding(ctx, document, m_WF_NodePara);
		document.endElement("", "", I_AD_WF_Node_Para.Table_Name);

	}

	private void createWorkflowNodeParaBinding(PIPOContext ctx, TransformerHandler document,
			MWFNodePara m_WF_NodePara)
	{

		PoExporter filler = new PoExporter(ctx, document, m_WF_NodePara);
		List<String> excludes = defaultExcludeList(X_AD_WF_Node_Para.Table_Name);

		if (m_WF_NodePara.getAD_WF_Node_Para_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_WF_Node_Para_ID", new AttributesImpl());

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_WF_Node_Para.COLUMNNAME_AD_WF_Node_Para_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_WF_Node_Para.COLUMNNAME_AD_WF_Node_Para_ID);
	}
}
