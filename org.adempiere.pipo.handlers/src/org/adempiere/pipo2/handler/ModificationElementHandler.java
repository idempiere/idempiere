/******************************************************************************
 * Copyright (C) 2013 Jan Thielemann - jan.thielemann@evenos-consulting.de    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.pipo2.handler;

import java.util.ArrayList;
import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.X_AD_Modification;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

/**
 * @author Jan Thielemann - jan.thielemann@evenos-consulting.de
 * @author evenos Consulting GmbH - www.evenos.org
 */

public class ModificationElementHandler extends AbstractElementHandler{

	private List<Integer>modifications = new ArrayList<Integer>();
	
	@Override
	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {

		String action = null;

		String entitytype = getStringValue(element, "EntityType");

		if (isProcessElement(ctx.ctx, entitytype)) {

			X_AD_Modification modification = findPO(ctx, element);
			if (modification == null) {
				modification = new X_AD_Modification(ctx.ctx, 0, getTrxName(ctx));
			}
			List<String> excludes = defaultExcludeList(X_AD_Modification.Table_Name);
			if (modifications.contains(modification.getAD_Modification_ID())) {
				element.skip = true;
				return;
			}

			PoFiller pf = new PoFiller(ctx, modification, element, this);
			List<String> notfounds = pf.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			
			if (modification.is_new() || modification.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Modification.Table_Name, X_AD_Modification.Table_ID);
				if (!modification.is_new()) {				
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Modification.Table_Name, modification);
					action = "Update";
				} else {
					action = "New";
				}
	
				if (modification.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, modification.getName(),
							modification.get_ID(), action);
	
					element.recordId = modification.getAD_Modification_ID();
	
					modifications.add(modification.getAD_Modification_ID());
	
				} else {
					logImportDetail(ctx, impDetail, 0, modification.getName(),
							modification.get_ID(), action);
					throw new POSaveFailedException("Failed to save Model Validator " + modification.getName());
				}
			}
		} else {
			element.skip = true;
		}
	}

	@Override
	public void endElement(PIPOContext ctx, Element element)
			throws SAXException {
		
	}
	
	
	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		int ad_modification_id = Env.getContextAsInt(ctx.ctx, X_AD_Modification.COLUMNNAME_AD_Modification_ID);
		if (ctx.packOut.isExported(X_AD_Modification.COLUMNNAME_AD_Modification_ID+"|"+ad_modification_id))
			return;

		X_AD_Modification modification = new X_AD_Modification(ctx.ctx, ad_modification_id, null);
		
		if (!isPackOutElement(ctx, modification))
			return;

		verifyPackOutRequirement(modification);
		
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", X_AD_Modification.Table_Name, atts);
		createADModificationBinding(ctx, document, modification);

		document.endElement("", "", X_AD_Modification.Table_Name);
	}

	private void createADModificationBinding(PIPOContext ctx, TransformerHandler document, X_AD_Modification modification) {
		PoExporter filler = new PoExporter(ctx, document, modification);
		if (modification.getAD_Modification_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add(X_AD_Modification.COLUMNNAME_AD_Modification_ID, new AttributesImpl());
		List<String> excludes = defaultExcludeList(X_AD_Modification.Table_Name);
		filler.export(excludes);		
	}
	
	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler, int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, X_AD_Modification.COLUMNNAME_AD_Modification_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Modification.COLUMNNAME_AD_Modification_ID);
	}

}
