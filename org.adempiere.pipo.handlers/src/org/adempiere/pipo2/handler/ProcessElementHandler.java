/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.               *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *                                                                            *
 * Copyright (C) 2005 Robert Klein. robeklein@hotmail.com                     *
 * Contributor(s): Low Heng Sin hengsin@avantz.com                            *
 *****************************************************************************/
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
import org.compiere.model.I_AD_PrintFormat;
import org.compiere.model.I_AD_Process;
import org.compiere.model.I_AD_Reference;
import org.compiere.model.I_AD_ReportView;
import org.compiere.model.I_AD_Val_Rule;
import org.compiere.model.I_AD_Workflow;
import org.compiere.model.MAttachment;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Attachment;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Process;
import org.compiere.model.X_AD_Process_Para;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ProcessElementHandler extends AbstractElementHandler {

	private ProcessParaElementHandler paraHandler = new ProcessParaElementHandler();

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			X_AD_Process mProcess = findPO(ctx, element);
			if (mProcess == null) {
				mProcess = new X_AD_Process(ctx.ctx, 0, getTrxName(ctx));
			}
			PoFiller filler = new PoFiller(ctx, mProcess, element, this);
			List<String> excludes = defaultExcludeList(X_AD_Process.Table_Name);

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			element.recordId = mProcess.get_ID();
			if (mProcess.is_new() || mProcess.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Process.Table_Name,
						X_AD_Process.Table_ID);
				String action = null;
				if (!mProcess.is_new()) {				
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Process.Table_Name, mProcess);
					action = "Update";
				} else {
					action = "New";
				}			
			
				if (mProcess.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mProcess.getName(), mProcess
							.get_ID(), action);
					element.recordId = mProcess.get_ID();
				} else {
					logImportDetail(ctx, impDetail, 0, mProcess.getName(), mProcess
							.get_ID(), action);
					throw new POSaveFailedException("Failed to save Process " + mProcess.getName());
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
		int AD_Process_ID = Env.getContextAsInt(ctx.ctx, "AD_Process_ID");
		if (ctx.packOut.isExported("AD_Process_ID"+"|"+AD_Process_ID))
			return;

		PackOut packOut = ctx.packOut;

		X_AD_Process m_Process = new X_AD_Process(ctx.ctx, AD_Process_ID, getTrxName(ctx));

		AttributesImpl atts = new AttributesImpl();

		try {
			// Export attachment if necessary
			MAttachment attachment = m_Process.getAttachment();
			if (attachment != null && attachment.get_ID() > 0) {
				ElementHandler handler = ctx.packOut.getHandler(X_AD_Attachment.Table_Name);
				try {
					handler.packOut(ctx.packOut, document, null, attachment.getAD_Attachment_ID());
				} catch (Exception e) {
					throw new SAXException(e);
				}
			}

			if (m_Process.isReport() && m_Process.getAD_ReportView_ID() > 0)
			{
				ElementHandler handler = packOut.getHandler(I_AD_ReportView.Table_Name);
				handler.packOut(packOut,document,null,m_Process.getAD_ReportView_ID());
			}
			if (m_Process.isReport() && m_Process.getAD_PrintFormat_ID() > 0)
			{
				ElementHandler handler = packOut.getHandler(I_AD_PrintFormat.Table_Name);
				handler.packOut(packOut,document,null,m_Process.getAD_PrintFormat_ID());
			}
			if (m_Process.getAD_Workflow_ID() > 0) {
				ElementHandler handler = packOut.getHandler(I_AD_Workflow.Table_Name);
				handler.packOut(packOut,document,null,m_Process.getAD_Workflow_ID());
			}

			boolean createElement = isPackOutElement(ctx, m_Process);

			if (createElement) {
				verifyPackOutRequirement(m_Process);
				addTypeName(atts, "table");
				document.startElement("", "", I_AD_Process.Table_Name, atts);
				createProcessBinding(ctx, document, m_Process);

				packOut.getCtx().ctx.put("Table_Name",I_AD_Process.Table_Name);
				try {
					new CommonTranslationHandler().packOut(packOut,document,null,m_Process.get_ID());
				} catch(Exception e) {
					if (log.isLoggable(Level.INFO)) log.info(e.toString());
				}

			}

			Query query = new Query(ctx.ctx, "AD_Process_PARA", "AD_Process_ID = ?", getTrxName(ctx));
			List<X_AD_Process_Para> paralist = query.setParameters(new Object[]{AD_Process_ID}).list();
			for (X_AD_Process_Para para : paralist) {
				if (para.getAD_Reference_ID()>0)
				{
					ElementHandler handler = packOut.getHandler(I_AD_Reference.Table_Name);
					handler.packOut(packOut,document,null,para.getAD_Reference_ID());
				}

				if (para.getAD_Reference_Value_ID()>0)
				{
					ElementHandler handler = packOut.getHandler(I_AD_Reference.Table_Name);
					handler.packOut(packOut,document,null,para.getAD_Reference_Value_ID());
				}

				if (para.getAD_Val_Rule_ID() > 0)
				{
					ElementHandler handler = packOut.getHandler(I_AD_Val_Rule.Table_Name);
					handler.packOut(packOut,document,null,para.getAD_Val_Rule_ID());
				}

				createProcessPara(ctx, document, para.getAD_Process_Para_ID());
			}

			if (createElement) {
				document.endElement("", "", X_AD_Process.Table_Name);
			}
		} catch (Exception e) {
			throw new AdempiereException(e);
		}

	}

	private void createProcessPara(PIPOContext ctx, TransformerHandler document,
			int AD_Process_Para_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Process_Para.COLUMNNAME_AD_Process_Para_ID,
				AD_Process_Para_ID);
		paraHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Process_Para.COLUMNNAME_AD_Process_Para_ID);
	}

	private void createProcessBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_Process m_Process) {
		PoExporter filler = new PoExporter(ctx, document, m_Process);
		List<String> excludes = defaultExcludeList(X_AD_Process.Table_Name);

		if (m_Process.getAD_Process_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_Process_ID", new AttributesImpl());

		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID);
	}
}
