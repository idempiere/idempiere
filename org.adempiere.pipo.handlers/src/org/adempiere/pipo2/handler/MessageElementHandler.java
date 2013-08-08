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

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Message;
import org.compiere.model.MMessage;
import org.compiere.model.X_AD_Message;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class MessageElementHandler extends AbstractElementHandler {

	private List<Integer> messages = new ArrayList<Integer>();

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {			
			MMessage mMessage = findPO(ctx, element);
			if (mMessage == null) {				
				int id = 0;
				if (!hasUUIDKey(ctx, element)) {
					String value = getStringValue(element, "Value");
					id = findIdByColumn(ctx, "AD_Message", "value", value);
				}
				mMessage = new MMessage(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
			}
			PoFiller filler = new PoFiller(ctx, mMessage, element, this);
			List<String> excludes = defaultExcludeList(X_AD_Message.Table_Name);

			if (messages.contains(mMessage.getAD_Message_ID())) {
				element.skip = true;
				return;
			}
						
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			element.recordId = mMessage.getAD_Message_ID();
			if (mMessage.is_new() || mMessage.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Message.Table_Name,
						X_AD_Message.Table_ID);
				String action = null;
				if (mMessage.getAD_Message_ID() == 0 && isOfficialId(element, "AD_Message_ID"))
					filler.setInteger("AD_Message_ID");
	
				if (!mMessage.is_new()){
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Message.Table_Name, mMessage);
					action = "Update";
				}
				else{
					action = "New";
				}
				if (mMessage.save(getTrxName(ctx)) == true){
					logImportDetail (ctx, impDetail, 1, mMessage.getValue(), mMessage.get_ID(),action);
					messages.add(mMessage.getAD_Message_ID());
					element.recordId = mMessage.getAD_Message_ID();
				}
				else{
					logImportDetail (ctx, impDetail, 0, mMessage.getValue(), mMessage.get_ID(),action);
					throw new POSaveFailedException("Failed to save message " + mMessage.getValue());
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
		int AD_Message_ID = Env.getContextAsInt(ctx.ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Message_ID);
		if (ctx.packOut.isExported(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Message_ID+"|"+AD_Message_ID))
			return;

		AttributesImpl atts = new AttributesImpl();
		X_AD_Message m_Message = new X_AD_Message (ctx.ctx, AD_Message_ID, null);
		if (ctx.packOut.getFromDate() != null) {
			if (m_Message.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		addTypeName(atts, "table");
		document.startElement("","",I_AD_Message.Table_Name,atts);
		createMessageBinding(ctx,document,m_Message);

		PackOut packOut = ctx.packOut;
		packOut.getCtx().ctx.put("Table_Name",X_AD_Message.Table_Name);
		try {
			new CommonTranslationHandler().packOut(packOut,document,null,m_Message.get_ID());
		} catch(Exception e) {
			if (log.isLoggable(Level.INFO)) log.info(e.toString());
		}

		document.endElement("","",I_AD_Message.Table_Name);
	}

	private void createMessageBinding(PIPOContext ctx, TransformerHandler document, X_AD_Message m_Message)
	{
		PoExporter filler = new PoExporter(ctx, document, m_Message);
		if (m_Message.getAD_Message_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_Message_ID", new AttributesImpl());

		List<String> excludes = defaultExcludeList(X_AD_Message.Table_Name);
		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Message_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Message_ID);
	}
}
