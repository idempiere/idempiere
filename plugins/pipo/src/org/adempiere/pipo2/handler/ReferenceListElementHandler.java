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
import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Ref_List;
import org.compiere.model.I_AD_Reference;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Ref_List;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ReferenceListElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx, entitytype)) {
			if (isParentSkip(element, null)) {
				element.skip = true;
				return;
			}

			X_AD_Ref_List mRefList = findPO(ctx, element);
			if (mRefList == null) {
				String value = getStringValue(element, "Value");
				int AD_Reference_ID = 0;
				if (getParentId(element, I_AD_Reference.Table_Name) > 0) {
					AD_Reference_ID = getParentId(element, I_AD_Reference.Table_Name);
				} else {
					Element referenceElement = element.properties.get(I_AD_Ref_List.COLUMNNAME_AD_Reference_ID);
					AD_Reference_ID = ReferenceUtils.resolveReference(ctx, referenceElement);
				}
	
				int AD_Ref_List_ID = findIdByColumnAndParentId(ctx, "AD_Ref_List", "Value", value, "AD_Reference", AD_Reference_ID);
				mRefList = new X_AD_Ref_List(ctx, AD_Ref_List_ID, getTrxName(ctx));
			}
			
			if (mRefList.getAD_Ref_List_ID() == 0 && isOfficialId(element, "AD_Ref_List_ID"))
				mRefList.setAD_Ref_List_ID(getIntValue(element, "AD_Ref_List_ID"));
			
			PoFiller filler = new PoFiller(ctx, mRefList, element, this);
			List<String> excludes = defaultExcludeList(X_AD_Ref_List.Table_Name);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}

			if (mRefList.is_new() || mRefList.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Ref_List.Table_Name,
						X_AD_Ref_List.Table_ID);
				String action = null;
				if (!mRefList.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Ref_List.Table_Name, mRefList);
					action = "Update";
				} else {
					action = "New";
				}
				if (mRefList.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mRefList.getName(),
							mRefList.get_ID(), action);
				} else {
					logImportDetail(ctx, impDetail, 0, mRefList.getName(),
							mRefList.get_ID(), action);
					throw new POSaveFailedException("ReferenceList");
				}
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_Ref_List_ID = Env.getContextAsInt(ctx,
				X_AD_Ref_List.COLUMNNAME_AD_Ref_List_ID);
		X_AD_Ref_List m_Ref_List = new X_AD_Ref_List(ctx, AD_Ref_List_ID,
				getTrxName(ctx));
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_Ref_List.Table_Name, atts);
		createRefListBinding(ctx, document, m_Ref_List);
		document.endElement("", "", I_AD_Ref_List.Table_Name);
	}

	private void createRefListBinding(Properties ctx, TransformerHandler document,
			X_AD_Ref_List m_Ref_List) {
		List<String> excludes = defaultExcludeList(X_AD_Ref_List.Table_Name);
		PoExporter filler = new PoExporter(ctx, document, m_Ref_List);
		if (m_Ref_List.getAD_Ref_List_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_Ref_List_ID", new AttributesImpl());

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx(), I_AD_Ref_List.COLUMNNAME_AD_Ref_List_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().remove(I_AD_Ref_List.COLUMNNAME_AD_Ref_List_ID);
	}
}
