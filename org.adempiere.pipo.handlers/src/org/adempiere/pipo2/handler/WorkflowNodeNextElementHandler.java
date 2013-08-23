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
import org.compiere.model.I_AD_WF_NodeNext;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_WF_NodeNext;
import org.compiere.util.Env;
import org.compiere.wf.MWFNodeNext;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class WorkflowNodeNextElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(MWFNodeNext.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			/*if (isParentSkip(element, null)) {
				element.skip = true;
				return;
			}*/

			MWFNodeNext mWFNodeNext = findPO(ctx, element);
			if (mWFNodeNext == null) {
				mWFNodeNext = new MWFNodeNext(ctx.ctx, 0, getTrxName(ctx));
			}

			PoFiller filler = new PoFiller(ctx, mWFNodeNext, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			if (mWFNodeNext.is_new() || mWFNodeNext.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_WF_NodeNext.Table_Name,
						X_AD_WF_NodeNext.Table_ID);
				String action = null;
				if (!mWFNodeNext.is_new()){
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_WF_NodeNext.Table_Name,mWFNodeNext);
					action = "Update";
				} else{
					action = "New";
				}
				if (mWFNodeNext.save(getTrxName(ctx)) == true){
					log.info("m_WFNodeNext save success");
					logImportDetail (ctx, impDetail, 1, String.valueOf(mWFNodeNext.get_ID()),mWFNodeNext.get_ID(), action);
				} else{
					log.info("m_WFNodeNext save failure");
					logImportDetail (ctx, impDetail, 0, String.valueOf(mWFNodeNext.get_ID()), mWFNodeNext.get_ID(), action);
					throw new POSaveFailedException("Failed to save WorkflowNodeNext");
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
		int ad_wf_nodenext_id = Env.getContextAsInt(ctx.ctx, "AD_WF_NodeNext_ID");
		if (ctx.packOut.isExported("AD_WF_NodeNext_ID"+"|"+ad_wf_nodenext_id))
			return;

		MWFNodeNext m_WF_NodeNext = new MWFNodeNext(
				ctx.ctx, ad_wf_nodenext_id, null);
		if (ctx.packOut.getFromDate() != null) {
			if (m_WF_NodeNext.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}
		verifyPackOutRequirement(m_WF_NodeNext);
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_WF_NodeNext.Table_Name, atts);
		createWorkflowNodeNextBinding(ctx, document, m_WF_NodeNext);
		document.endElement("", "", I_AD_WF_NodeNext.Table_Name);

	}

	private void createWorkflowNodeNextBinding(PIPOContext ctx, TransformerHandler document,
			MWFNodeNext m_WF_NodeNext)
	{

		PoExporter filler = new PoExporter(ctx, document, m_WF_NodeNext);
		List<String> excludes = defaultExcludeList(X_AD_WF_NodeNext.Table_Name);

		if (m_WF_NodeNext.getAD_WF_NodeNext_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_WF_NodeNext_ID", new AttributesImpl());

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_WF_NodeNext.COLUMNNAME_AD_WF_NodeNext_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_WF_NodeNext.COLUMNNAME_AD_WF_NodeNext_ID);
	}
}
