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
import org.compiere.model.X_AD_FieldGroup;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class FieldGroupElementHandler extends AbstractElementHandler  implements IPackOutHandler{


	private List<Integer> processedFieldGroups = new ArrayList<Integer>();


	public void startElement(Properties ctx, Element element)
			throws SAXException {
		String elementValue = element.getElementValue();
		String action = null;

		log.info(elementValue + " " + getStringValue(element, "Name"));

		String entitytype = getStringValue(element, "EntityType");
		String name = getStringValue(element, "Name");

		if (isProcessElement(ctx, entitytype)) {

			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_FieldGroup.Table_Name,
					X_AD_FieldGroup.Table_ID);
			int id = findIdByColumn(ctx, X_AD_FieldGroup.Table_Name, X_AD_FieldGroup.COLUMNNAME_Name, name);

			X_AD_FieldGroup fieldGroup = new X_AD_FieldGroup(ctx, id,
					getTrxName(ctx));
			PoFiller pf = new PoFiller(ctx, fieldGroup, element, this);
			List<String> excludes = defaultExcludeList(X_AD_FieldGroup.Table_Name);
			if (id <= 0 && isOfficialId(element, "AD_FieldGroup_ID"))
			{
				pf.setInteger("AD_FieldGroup_ID");
			}

			if (id > 0) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_FieldGroup.Table_Name, fieldGroup);
				action = "Update";
				if (processedFieldGroups.contains(id)) {
					element.skip = true;
					return;
				}
			} else {
				action = "New";
			}

			List<String> notfounds = pf.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}

			if (fieldGroup.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, fieldGroup.getName(),
						fieldGroup.get_ID(), action);

				element.recordId = fieldGroup.getAD_FieldGroup_ID();

				processedFieldGroups.add(fieldGroup.getAD_FieldGroup_ID());

			} else {
				logImportDetail(ctx, impDetail, 0, fieldGroup.getName(),
						fieldGroup.get_ID(), action);
				throw new POSaveFailedException("Reference");
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	protected void create(Properties ctx, TransformerHandler document)
			throws SAXException {


		int fieldGroup_id = Env.getContextAsInt(ctx,
				X_AD_FieldGroup.COLUMNNAME_AD_FieldGroup_ID);

		if (processedFieldGroups.contains(fieldGroup_id))
			return;

		processedFieldGroups.add(fieldGroup_id);

		X_AD_FieldGroup fieldGroup = new X_AD_FieldGroup(ctx, fieldGroup_id, null);

		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.field-group");
		document.startElement("", "", "fieldgroup", atts);

		createAdElementBinding(ctx, document, fieldGroup);

		PackOut packOut = (PackOut)ctx.get("PackOutProcess");

		try{
			new CommonTranslationHandler().packOut(packOut,null,null,document,null,fieldGroup.get_ID());
		}
		catch(Exception e)
		{
			log.info(e.toString());
		}
		document.endElement("", "", "fieldgroup");
	}


	private void createAdElementBinding(Properties ctx, TransformerHandler document,
			X_AD_FieldGroup fieldGroup) {

		PoExporter filler = new PoExporter(ctx, document, fieldGroup);
		List<String> excludes = defaultExcludeList(X_AD_FieldGroup.Table_Name);
		if (fieldGroup.getAD_FieldGroup_ID() <= PackOut.MAX_OFFICIAL_ID) {
			filler.add(X_AD_FieldGroup.COLUMNNAME_AD_FieldGroup_ID, new AttributesImpl());
		}

		filler.export(excludes);
	}

	public void packOut(PackOut packout, MPackageExp header, MPackageExpDetail detail,TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx(), X_AD_FieldGroup.COLUMNNAME_AD_FieldGroup_ID, recordId);

		this.create(packout.getCtx(), packOutDocument);
		packout.getCtx().remove(X_AD_FieldGroup.COLUMNNAME_AD_FieldGroup_ID);
	}
}