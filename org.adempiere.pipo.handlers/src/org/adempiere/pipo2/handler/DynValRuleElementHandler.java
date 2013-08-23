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

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Val_Rule;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Val_Rule;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class DynValRuleElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			X_AD_Val_Rule mValRule = findPO(ctx, element);
			if (mValRule == null)
			{
				mValRule = new X_AD_Val_Rule(ctx.ctx, 0, getTrxName(ctx));
			}

			List<String> excludes = defaultExcludeList(X_AD_Val_Rule.Table_Name);

			PoFiller filler = new PoFiller(ctx, mValRule, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			
			if (mValRule.is_new() || mValRule.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Val_Rule.Table_Name,
						X_AD_Val_Rule.Table_ID);
				String action = null;
				if (!mValRule.is_new()){
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Val_Rule.Table_Name, mValRule);
					action = "Update";
				}
				else{
					action = "New";
				}
	
				if (mValRule.save(getTrxName(ctx)) == true){
					logImportDetail (ctx, impDetail, 1, mValRule.getName(), mValRule.get_ID(),action);
				}
				else{
					logImportDetail (ctx, impDetail, 0, mValRule.getName(), mValRule.get_ID(),action);
					throw new POSaveFailedException("Failed to save dynamic validation rule " + mValRule.getName());
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
		int AD_Val_Rule_ID = Env.getContextAsInt(ctx.ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Val_Rule_ID);
		if (ctx.packOut.isExported(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Val_Rule_ID+"|"+AD_Val_Rule_ID))
			return;
		X_AD_Val_Rule m_ValRule = new X_AD_Val_Rule (ctx.ctx, AD_Val_Rule_ID, null);

		if (ctx.packOut.getFromDate() != null) {
			if (m_ValRule.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		verifyPackOutRequirement(m_ValRule);
		
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("","",I_AD_Val_Rule.Table_Name, atts);
		createDynamicValidationRuleBinding(ctx,document,m_ValRule);
		document.endElement("","",I_AD_Val_Rule.Table_Name);

	}

	private void createDynamicValidationRuleBinding(PIPOContext ctx, TransformerHandler document, X_AD_Val_Rule m_ValRule)
	{
		PoExporter filler = new PoExporter(ctx, document, m_ValRule);
		List<String>excludes = defaultExcludeList(X_AD_Val_Rule.Table_Name);

		if (m_ValRule.getAD_Val_Rule_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_Val_Rule_ID", new AttributesImpl());

		filler.export(excludes);
	}


	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{

		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Val_Rule_ID, recordId);

		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Val_Rule_ID);
	}
}
