/******************************************************************************
. * Product: Adempiere ERP & CRM Smart Business Solution                       *
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


import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.IPackOutHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.MTask;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Task;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class TaskElementHandler extends AbstractElementHandler implements IPackOutHandler{

	private List<Integer> tasks = new ArrayList<Integer>();

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_Task.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx, entitytype)) {

			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Task.Table_Name,
					X_AD_Task.Table_ID);

			String name = getStringValue(element, "Name");
			int id = findIdByName(ctx, "AD_Task", name);
			MTask mTask = new MTask(ctx, id, getTrxName(ctx));
			String action = null;
			if (id <= 0 && isOfficialId(element, "AD_Task_ID"))
				mTask.setAD_Task_ID(getIntValue(element, "AD_Task_ID"));
			if (id > 0) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Task.Table_Name, mTask);
				action = "Update";
			} else {
				action = "New";
			}
			PoFiller filler = new PoFiller(ctx, mTask, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}
			if (mTask.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, mTask.getName(), mTask.get_ID(),
						action);
			} else {
				logImportDetail(ctx, impDetail, 0, mTask.getName(), mTask.get_ID(),
						action);
				throw new POSaveFailedException("Task");
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_Task_ID = Env.getContextAsInt(ctx, "AD_Task_ID");
		if (tasks.contains(AD_Task_ID))
			return;
		tasks.add(AD_Task_ID);
		X_AD_Task m_Task = new X_AD_Task(ctx, AD_Task_ID, null);
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.task");
		document.startElement("", "", "task", atts);
		createTaskBinding(ctx, document, m_Task);
		document.endElement("", "", "task");

	}

	private void createTaskBinding(Properties ctx, TransformerHandler document,
			X_AD_Task m_Task) {
		PoExporter filler = new PoExporter(ctx, document, m_Task);
		List<String> excludes = defaultExcludeList(X_AD_Task.Table_Name);
		if (m_Task.getAD_Task_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_Task_ID", new AttributesImpl());
		filler.export(excludes);
	}

	public void packOut(PackOut packout, MPackageExp header, MPackageExpDetail detail,TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx(), X_AD_Task.COLUMNNAME_AD_Task_ID, recordId);

		this.create(packout.getCtx(), packOutDocument);
		packout.getCtx().remove(X_AD_Task.COLUMNNAME_AD_Task_ID);
	}
}
