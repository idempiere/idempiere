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
 * Contributor(s): Igor G. - progerpro@gmail.com
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
import org.compiere.model.I_AD_FieldGroup;
import org.compiere.model.X_AD_FieldGroup;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class FieldGroupElementHandler extends AbstractElementHandler {


	private List<Integer> processedFieldGroups = new ArrayList<Integer>();


	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		String elementValue = element.getElementValue();
		String action = null;

		if (log.isLoggable(Level.INFO)) log.info(elementValue + " " + getStringValue(element, "Name"));

		String entitytype = getStringValue(element, "EntityType");
		String name = getStringValue(element, "Name");

		if (isProcessElement(ctx.ctx, entitytype)) {

			X_AD_FieldGroup fieldGroup = findPO(ctx, element);
			if (fieldGroup == null)
			{
				int id = 0;
				if (!hasUUIDKey(ctx, element)) {
					id = findIdByColumn(ctx, X_AD_FieldGroup.Table_Name, X_AD_FieldGroup.COLUMNNAME_Name, name);
				}
				fieldGroup = new X_AD_FieldGroup(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
			}
			PoFiller pf = new PoFiller(ctx, fieldGroup, element, this);
			List<String> excludes = defaultExcludeList(X_AD_FieldGroup.Table_Name);
			if (fieldGroup.getAD_FieldGroup_ID() == 0 && isOfficialId(element, "AD_FieldGroup_ID"))
			{
				pf.setInteger("AD_FieldGroup_ID");
			}

			if (processedFieldGroups.contains(fieldGroup.getAD_FieldGroup_ID())) {
				element.skip = true;
				return;
			}
			
			List<String> notfounds = pf.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			element.recordId = fieldGroup.getAD_FieldGroup_ID();

			if (fieldGroup.is_new() || fieldGroup.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_FieldGroup.Table_Name,
						X_AD_FieldGroup.Table_ID);
				if (!fieldGroup.is_new()) {				
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_FieldGroup.Table_Name, fieldGroup);
					action = "Update";				
				} else {
					action = "New";
				}
				
				if (fieldGroup.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, fieldGroup.getName(),
							fieldGroup.get_ID(), action);
					processedFieldGroups.add(fieldGroup.getAD_FieldGroup_ID());
	
				} else {
					logImportDetail(ctx, impDetail, 0, fieldGroup.getName(),
							fieldGroup.get_ID(), action);
					throw new POSaveFailedException("Failed to save Field Group " + fieldGroup.getName());
				}
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	protected void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {


		int fieldGroup_id = Env.getContextAsInt(ctx.ctx,
				X_AD_FieldGroup.COLUMNNAME_AD_FieldGroup_ID);

		if (processedFieldGroups.contains(fieldGroup_id))
			return;

		processedFieldGroups.add(fieldGroup_id);

		X_AD_FieldGroup fieldGroup = new X_AD_FieldGroup(ctx.ctx, fieldGroup_id, null);

		if (ctx.packOut.getFromDate() != null) {
			if (fieldGroup.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_FieldGroup.Table_Name, atts);
		createAdElementBinding(ctx, document, fieldGroup);

		PackOut packOut = ctx.packOut;
		packOut.getCtx().ctx.put("Table_Name",X_AD_FieldGroup.Table_Name);
		try {
			new CommonTranslationHandler().packOut(packOut,document,null,fieldGroup.get_ID());
		} catch(Exception e) {
			if (log.isLoggable(Level.INFO)) log.info(e.toString());
		}
		document.endElement("", "", I_AD_FieldGroup.Table_Name);
	}


	private void createAdElementBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_FieldGroup fieldGroup) {

		PoExporter filler = new PoExporter(ctx, document, fieldGroup);
		List<String> excludes = defaultExcludeList(X_AD_FieldGroup.Table_Name);
		if (fieldGroup.getAD_FieldGroup_ID() <= PackOut.MAX_OFFICIAL_ID) {
			filler.add(X_AD_FieldGroup.COLUMNNAME_AD_FieldGroup_ID, new AttributesImpl());
		}

		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_FieldGroup.COLUMNNAME_AD_FieldGroup_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_FieldGroup.COLUMNNAME_AD_FieldGroup_ID);
	}
}