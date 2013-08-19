/******************************************************************************
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

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MAttachment;
import org.compiere.model.PO;
import org.compiere.model.X_AD_Attachment;
import org.compiere.model.X_AD_AttachmentNote;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class AttachmentElementHandler extends AbstractElementHandler {

	private List<Integer> attachments = new ArrayList<Integer>();

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		String action = null;

		MAttachment mAttachment = findPO(ctx, element);
		if (mAttachment == null) {
			int AD_Table_ID = ReferenceUtils.resolveReference(ctx.ctx, element.properties.get("AD_Table_ID"), getTrxName(ctx));
			if (AD_Table_ID <= 0) {
				element.defer = true;
				element.unresolved = "AD_Table_ID";
				return;
			}
			Element recordElement = element.properties.get("Record_ID");
			int Record_ID = ReferenceUtils.resolveReference(ctx.ctx, recordElement, getTrxName(ctx));
			if (Record_ID <= 0) {
				element.defer = true;
				element.unresolved = "Record_ID";
				return;
			}

			int id = 0;
			if (!hasUUIDKey(ctx, element)) {
				DB.getSQLValue(getTrxName(ctx), "SELECT AD_Attachment_ID FROM AD_Attachment WHERE Record_ID="+Record_ID+" AND AD_Table_ID="+AD_Table_ID);
			}
			mAttachment = new MAttachment(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
			if (mAttachment.is_new()) {
				mAttachment.setAD_Table_ID(AD_Table_ID);
				mAttachment.setRecord_ID(Record_ID);
			}
		}
		List<String> excludes = defaultExcludeList(X_AD_Attachment.Table_Name);
		excludes.add("AD_Table_ID");
		excludes.add("Record_ID");
		if (mAttachment.getAD_Attachment_ID() == 0 && isOfficialId(element, "AD_Attachment_ID"))
			mAttachment.setAD_Attachment_ID(getIntValue(element, "AD_Attachment_ID"));

		if (attachments.contains(mAttachment.getAD_Attachment_ID())) {
			element.skip = true;
			return;
		}

		PoFiller pf = new PoFiller(ctx, mAttachment, element, this);
		List<String> notfounds = pf.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			element.unresolved = notfounds.toString();
			return;
		}

		mAttachment.getEntries();
		if (mAttachment.is_new() || mAttachment.is_Changed()) {
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Attachment.Table_Name, X_AD_Attachment.Table_ID);
			if (!mAttachment.is_new()) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Attachment.Table_Name, mAttachment);
				action = "Update";
			} else {
				action = "New";
			}

			if (mAttachment.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, mAttachment.toString(),
						mAttachment.get_ID(), action);

				element.recordId = mAttachment.getAD_Attachment_ID();

				attachments.add(mAttachment.getAD_Attachment_ID());

			} else {
				logImportDetail(ctx, impDetail, 0, mAttachment.toString(),
						mAttachment.get_ID(), action);
				throw new POSaveFailedException("Failed to save Attachment " + mAttachment.toString());
			}
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	protected void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {


		int AD_Attachment_ID = Env.getContextAsInt(ctx.ctx, "AD_Attachment_ID");
		if (ctx.packOut.isExported("AD_Attachment_ID"+"|"+AD_Attachment_ID))
			return;

		MAttachment mAttachment = new MAttachment(ctx.ctx, AD_Attachment_ID, getTrxName(ctx));

		if (ctx.packOut.getFromDate() != null) {
			if (mAttachment.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", "AD_Attachment", atts);
		createAttachmentBinding(ctx, document, mAttachment);

		int[] ids = PO.getAllIDs(X_AD_AttachmentNote.Table_Name, "AD_Attachment_ID="+AD_Attachment_ID, getTrxName(ctx));
		if (ids != null && ids.length > 0) {
			ElementHandler handler = ctx.packOut.getHandler(X_AD_AttachmentNote.Table_Name);
			for (int AD_AttachmentNote_ID : ids ) {
				try {
					handler.packOut(ctx.packOut, document, null, AD_AttachmentNote_ID);
				} catch (Exception e) {
					throw new SAXException(e);
				}
			}
		}
		document.endElement("", "", "AD_Attachment");		
	}


	private void createAttachmentBinding(PIPOContext ctx, TransformerHandler document,
			MAttachment mAttachment) {

		PoExporter filler = new PoExporter(ctx, document, mAttachment);
		if (mAttachment.getAD_Attachment_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_Attachment_ID", new AttributesImpl());

		List<String> excludes = defaultExcludeList(X_AD_Attachment.Table_Name);
		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		packout.getCtx().ctx.put("AD_Attachment_ID", Integer.toString(recordId));
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove("AD_Attachment_ID");
	}
}
