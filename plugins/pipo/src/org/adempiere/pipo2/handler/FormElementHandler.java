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
import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.IPackOutHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MForm;
import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.X_AD_Form;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class FormElementHandler extends AbstractElementHandler implements IPackOutHandler {

	private List<Integer> forms = new ArrayList<Integer>();

	public void startElement(Properties ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_Form.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx, entitytype)) {
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Form.Table_Name,
					X_AD_Form.Table_ID);
			String name = getStringValue(element, "Name");
			int id = findIdByName(ctx, "AD_Form", name);
			MForm mForm = new MForm(ctx, id, getTrxName(ctx));
			PoFiller filler = new PoFiller(ctx, mForm, element, this);

			String action = null;
			if (id <= 0 && isOfficialId(element, "AD_Form_ID"))
			{
				filler.setInteger("AD_Form_ID");
			}
			if (id > 0){
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Form.Table_Name, mForm);
				action = "Update";
			}
			else{
				action = "New";
			}
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}

			if (mForm.save(getTrxName(ctx)) == true){
				logImportDetail (ctx, impDetail, 1, mForm.getName(), mForm.get_ID(), action);
			}
			else{
				logImportDetail (ctx, impDetail, 0, mForm.getName(), mForm.get_ID(), action);
				throw new POSaveFailedException("Failed to save form definition");
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	protected void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_Form_ID = Env.getContextAsInt(ctx, "AD_Form_ID");
		if (forms.contains(AD_Form_ID)) return;

		forms.add(AD_Form_ID);
		X_AD_Form m_Form = new X_AD_Form (ctx, AD_Form_ID, null);
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.form");
		document.startElement("","","form",atts);
		createFormBinding(ctx, document, m_Form);
		document.endElement("","","form");
	}

	private void createFormBinding(Properties ctx, TransformerHandler document, X_AD_Form m_Form)
	{
		PoExporter filler = new PoExporter(ctx, document, m_Form);
		List<String> excludes = defaultExcludeList(X_AD_Form.Table_Name);
		if (m_Form.getAD_Form_ID() <= PackOut.MAX_OFFICIAL_ID) {
			filler.add("AD_Form_ID", new AttributesImpl());
		}
		filler.export(excludes);
	}


	public void packOut(PackOut packout, MPackageExp header, MPackageExpDetail detail,TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception
	{
		if(recordId <= 0)
			recordId = detail.getAD_Form_ID();

		Env.setContext(packout.getCtx(), X_AD_Package_Exp_Detail.COLUMNNAME_AD_Form_ID, recordId);

		this.create(packout.getCtx(), packOutDocument);
		packout.getCtx().remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Form_ID);
	}
}
