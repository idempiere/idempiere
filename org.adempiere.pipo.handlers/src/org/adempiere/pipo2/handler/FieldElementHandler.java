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
import org.compiere.model.I_AD_Field;
import org.compiere.model.I_AD_FieldGroup;
import org.compiere.model.I_AD_Reference;
import org.compiere.model.I_AD_Tab;
import org.compiere.model.MField;
import org.compiere.model.X_AD_Field;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class FieldElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			if (isParentDefer(element, I_AD_Tab.Table_Name)) {
				element.defer = true;
				return;
			}

			List<String>excludes = defaultExcludeList(X_AD_Field.Table_Name);

			MField mField = findPO(ctx, element);
			if (mField == null)
			{
				mField = new MField(ctx.ctx, 0, getTrxName(ctx));
			} 
			
			PoFiller filler = new PoFiller(ctx, mField, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			element.recordId = mField.getAD_Field_ID();
			if (mField.is_new() || mField.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Field.Table_Name,
						X_AD_Field.Table_ID);
				String action = null;
				if (!mField.is_new()){
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), I_AD_Field.Table_Name, mField);
					action = "Update";
				}
				else{
					action = "New";
				}

				if (mField.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mField.getName(), mField
							.get_ID(), action);
					element.recordId = mField.getAD_Field_ID();
				} else {
					logImportDetail(ctx, impDetail, 0, mField.getName(), mField
							.get_ID(), action);
					throw new POSaveFailedException("Failed to save field definition " + mField.getName());
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
		int AD_Field_ID = Env.getContextAsInt(ctx.ctx,
				X_AD_Field.COLUMNNAME_AD_Field_ID);
		if (ctx.packOut.isExported(X_AD_Field.COLUMNNAME_AD_Field_ID+"|"+AD_Field_ID))
			return;

		X_AD_Field m_Field = new X_AD_Field(ctx.ctx, AD_Field_ID, null);

		PackOut packOut = ctx.packOut;
		try
		{
			if(m_Field.getAD_FieldGroup_ID() > 0)
			{
				ElementHandler handler = packOut.getHandler(I_AD_FieldGroup.Table_Name);
				handler.packOut(packOut,document,null,m_Field.getAD_FieldGroup_ID());
			}

			if (m_Field.getAD_Reference_ID()>0)
			{
				ElementHandler handler = packOut.getHandler(I_AD_Reference.Table_Name);
				handler.packOut(packOut,document,null,m_Field.getAD_Reference_ID());
			}
		}
		catch(Exception e)
		{
			throw new SAXException(e);
		}

		if (ctx.packOut.getFromDate() != null) {
			if (m_Field.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		verifyPackOutRequirement(m_Field);
		
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", X_AD_Field.Table_Name, atts);
		createFieldBinding(ctx, document, m_Field);
		packOut.getCtx().ctx.put("Table_Name",X_AD_Field.Table_Name);
		try {
			new CommonTranslationHandler().packOut(packOut,document,null,m_Field.get_ID());
		} catch(Exception e) {
			if (log.isLoggable(Level.INFO)) log.info(e.toString());
		}

		document.endElement("", "", X_AD_Field.Table_Name);
	}

	private void createFieldBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_Field m_Field) {

		List<String> excludes = defaultExcludeList(X_AD_Field.Table_Name);
		PoExporter filler = new PoExporter(ctx, document, m_Field);
		if (m_Field.getAD_Field_ID() <= PackOut.MAX_OFFICIAL_ID) {
			filler.add("AD_Field_ID", new AttributesImpl());
		}

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_Field.COLUMNNAME_AD_Field_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_Field.COLUMNNAME_AD_Field_ID);
	}
}
