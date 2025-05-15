/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP * This program is free software;
 * you can redistribute it and/or modify it * under the terms version 2 of the
 * GNU General Public License as published * by the Free Software Foundation.
 * This program is distributed in the hope * that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied * warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. * See the GNU General Public License for
 * more details. * You should have received a copy of the GNU General Public
 * License along * with this program; if not, write to the Free Software
 * Foundation, Inc., * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA. *
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
import org.compiere.model.I_AD_WF_Node_Var;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_WF_Node_Var;
import org.compiere.util.Env;
import org.compiere.wf.MWFNodeNext;
import org.compiere.wf.MWFNodeVar;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class WorkflowNodeVariableHandler extends AbstractElementHandler
{

	@Override
	public void startElement(PIPOContext ctx, Element element) throws SAXException
	{
		List<String> excludes = defaultExcludeList(MWFNodeNext.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype))
		{
			MWFNodeVar mWFNodeVar = findPO(ctx, element);
			if (mWFNodeVar == null)
			{
				mWFNodeVar = new MWFNodeVar(ctx.ctx, 0, getTrxName(ctx));
			}

			PoFiller filler = new PoFiller(ctx, mWFNodeVar, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0)
			{
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			if (mWFNodeVar.is_new() || mWFNodeVar.is_Changed())
			{
				X_AD_Package_Imp_Detail impDetail = createImportDetail(	ctx, element.qName, X_AD_WF_Node_Var.Table_Name,
																		X_AD_WF_Node_Var.Table_ID);
				String action = null;
				if (!mWFNodeVar.is_new())
				{
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_WF_Node_Var.Table_Name, mWFNodeVar);
					action = "Update";
				}
				else
				{
					action = "New";
				}
				if (mWFNodeVar.save(getTrxName(ctx)) == true)
				{
					log.info("m_WFNodeVar save success");
					logImportDetail(ctx, impDetail, 1, String.valueOf(mWFNodeVar.get_ID()), mWFNodeVar.get_ID(), action);
				}
				else
				{
					log.info("m_WFNodeVar save failure");
					logImportDetail(ctx, impDetail, 0, String.valueOf(mWFNodeVar.get_ID()), mWFNodeVar.get_ID(), action);
					throw new POSaveFailedException("Failed to save WorkflowNodeVariable");
				}
			}
		}
		else
		{
			element.skip = true;
		}
	}

	@Override
	public void endElement(PIPOContext ctx, Element element) throws SAXException
	{

	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, I_AD_WF_Node_Var.COLUMNNAME_AD_WF_Node_Var_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_WF_Node_Var.COLUMNNAME_AD_WF_Node_Var_ID);
	}

	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException
	{
		int AD_WF_Node_Var_ID = Env.getContextAsInt(ctx.ctx, MWFNodeVar.COLUMNNAME_AD_WF_Node_Var_ID);
		if (ctx.packOut.isExported(MWFNodeVar.COLUMNNAME_AD_WF_Node_Var_ID + "|" + AD_WF_Node_Var_ID))
			return;

		MWFNodeVar m_WF_NodeVar = new MWFNodeVar(ctx.ctx, AD_WF_Node_Var_ID, null);
		if (!isPackOutElement(ctx, m_WF_NodeVar))
			return;
		verifyPackOutRequirement(m_WF_NodeVar);
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", MWFNodeVar.Table_Name, atts);
		createWorkflowNodeNextBinding(ctx, document, m_WF_NodeVar);
		document.endElement("", "", MWFNodeVar.Table_Name);
	}

	private void createWorkflowNodeNextBinding(PIPOContext ctx, TransformerHandler document, MWFNodeVar m_WF_NodeVar)
	{
		PoExporter filler = new PoExporter(ctx, document, m_WF_NodeVar);
		List<String> excludes = defaultExcludeList(MWFNodeVar.Table_Name);

		if (m_WF_NodeVar.getAD_WF_Node_Var_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add(MWFNodeVar.COLUMNNAME_AD_WF_Node_Var_ID, new AttributesImpl());

		filler.export(excludes);
	}

}
