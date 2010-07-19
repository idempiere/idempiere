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

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.IPackOutHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Process;
import org.compiere.model.X_AD_Process_Para;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ProcessElementHandler extends AbstractElementHandler implements IPackOutHandler{

	private ProcessParaElementHandler paraHandler = new ProcessParaElementHandler();

	private List<Integer> processes = new ArrayList<Integer>();

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		int id = 0;
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx, entitytype)) {

			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Process.Table_Name,
					X_AD_Process.Table_ID);

			String value = getStringValue(element, "Value");

			// Get New process.
			id = findIdByColumn(ctx, "AD_Process", "Value", value);

			X_AD_Process mProcess = null;
			String action = null;
			if (id > 0) {
				mProcess = new X_AD_Process(ctx, id, getTrxName(ctx));
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Process.Table_Name, mProcess);
				action = "Update";
			} else {
				mProcess = new X_AD_Process(ctx, id, getTrxName(ctx));
				action = "New";
			}
			if (id <= 0 && isOfficialId(element, "AD_Process_ID"))
				mProcess.setAD_Process_ID(Integer.parseInt(getStringValue(element, "AD_Process_ID")));

			PoFiller filler = new PoFiller(ctx, mProcess, element, this);
			List<String> excludes = defaultExcludeList(X_AD_Process.Table_Name);

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}

			if (mProcess.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, mProcess.getName(), mProcess
						.get_ID(), action);
				element.recordId = mProcess.getAD_Process_ID();
			} else {
				logImportDetail(ctx, impDetail, 0, mProcess.getName(), mProcess
						.get_ID(), action);
				throw new POSaveFailedException("Process");
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_Process_ID = Env.getContextAsInt(ctx, "AD_Process_ID");
		if (processes.contains(AD_Process_ID))
			return;
		processes.add(AD_Process_ID);
		PackOut packOut = getPackOutProcess(ctx);

		X_AD_Process m_Process = new X_AD_Process(ctx, AD_Process_ID, getTrxName(ctx));

		AttributesImpl atts = new AttributesImpl();

		try {
			if (m_Process.isReport() && m_Process.getAD_ReportView_ID() > 0)
			{
				IPackOutHandler handler = packOut.getHandler("R");
				handler.packOut(packOut,null,null,document,null,m_Process.getAD_ReportView_ID());

			}
			if (m_Process.isReport() && m_Process.getAD_PrintFormat_ID() > 0)
			{
				IPackOutHandler handler = packOut.getHandler("PFT");
				handler.packOut(packOut,null,null,document,null,m_Process.getAD_PrintFormat_ID());
			}
			if (m_Process.getAD_Workflow_ID() > 0) {
				IPackOutHandler handler = packOut.getHandler("F");
				handler.packOut(packOut,null,null,document,null,m_Process.getAD_Workflow_ID());
			}
			atts.addAttribute("", "", "type", "CDATA", "object");
			atts.addAttribute("", "", "type-name", "CDATA", "ad.process");
			document.startElement("", "", "process", atts);
			createProcessBinding(ctx, document, m_Process);

			Query query = new Query(ctx, "AD_Process_PARA", "AD_Process_ID = ?", getTrxName(ctx));
			List<X_AD_Process_Para> paralist = query.setParameters(new Object[]{AD_Process_ID}).list();
			for (X_AD_Process_Para para : paralist) {
				if (para.getAD_Reference_ID()>0)
				{
					IPackOutHandler handler = packOut.getHandler("REF");
					handler.packOut(packOut,null,null,document,null,para.getAD_Reference_ID());
				}

				if (para.getAD_Reference_Value_ID()>0)
				{
					IPackOutHandler handler = packOut.getHandler("REF");
					handler.packOut(packOut,null,null,document,null,para.getAD_Reference_Value_ID());
				}

				if (para.getAD_Val_Rule_ID() > 0)
				{
					IPackOutHandler handler = packOut.getHandler("V");
					handler.packOut(packOut,null,null,document,null,para.getAD_Val_Rule_ID());
				}

				createProcessPara(ctx, document, para.getAD_Process_Para_ID());
			}


			document.endElement("", "", "process");
		} catch (Exception e) {
			throw new AdempiereException(e);
		}

	}

	private void createProcessPara(Properties ctx, TransformerHandler document,
			int AD_Process_Para_ID) throws SAXException {
		Env.setContext(ctx, X_AD_Process_Para.COLUMNNAME_AD_Process_Para_ID,
				AD_Process_Para_ID);
		paraHandler.create(ctx, document);
		ctx.remove(X_AD_Process_Para.COLUMNNAME_AD_Process_Para_ID);
	}

	private void createProcessBinding(Properties ctx, TransformerHandler document,
			X_AD_Process m_Process) {
		PoExporter filler = new PoExporter(ctx, document, m_Process);
		List<String> excludes = defaultExcludeList(X_AD_Process.Table_Name);

		if (m_Process.getAD_Process_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_Process_ID", new AttributesImpl());

		filler.export(excludes);
	}

	public void packOut(PackOut packout, MPackageExp header, MPackageExpDetail detail,TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception
	{
		if(recordId <= 0)
			recordId = detail.getAD_Process_ID();

		Env.setContext(packout.getCtx(), X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID, recordId);

		this.create(packout.getCtx(), packOutDocument);
		packout.getCtx().remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID);
	}
}
