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
import org.compiere.model.M_Element;
import org.compiere.model.X_AD_Element;
import org.compiere.model.X_AD_Package_Imp_Detail;

import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class AdElementHandler extends AbstractElementHandler {

	private List<Integer> processedElements = new ArrayList<Integer>();

	private static final String AD_ELEMENT = "AD_Element";


	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		String action = null;

		String entitytype = getStringValue(element, "EntityType");
		String ColumnName = getStringValue(element, "ColumnName");

		if (isProcessElement(ctx.ctx, entitytype)) {

			M_Element mElement = findPO(ctx, element);
			if (mElement == null) {
				int id = 0;
				if (!hasUUIDKey(ctx, element)) {
					id = findIdByColumn(ctx, X_AD_Element.Table_Name, X_AD_Element.COLUMNNAME_ColumnName, ColumnName, /*ignorecase=*/true);
				}
				mElement = new M_Element(ctx.ctx, id, getTrxName(ctx));
			}
			List<String> excludes = defaultExcludeList(X_AD_Element.Table_Name);
			if (mElement.getAD_Element_ID() == 0 && isOfficialId(element, "AD_Element_ID"))
				mElement.setAD_Element_ID(getIntValue(element, "AD_Element_ID"));
			
			if (processedElements.contains(mElement.getAD_Element_ID())) {
				element.skip = true;
				return;
			}

			PoFiller pf = new PoFiller(ctx, mElement, element, this);
			List<String> notfounds = pf.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			if (mElement.is_new() || mElement.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Element.Table_Name, X_AD_Element.Table_ID);
				if (!mElement.is_new()) {				
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), AD_ELEMENT, mElement);
					action = "Update";
				} else {
					action = "New";
				}
	
				if (mElement.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mElement.getName(),
							mElement.get_ID(), action);
	
					processedElements.add(mElement.getAD_Element_ID());
	
				} else {
					logImportDetail(ctx, impDetail, 0, mElement.getName(),
							mElement.get_ID(), action);
					throw new POSaveFailedException("Failed to save Element " + mElement.getName());
				}
			}
			element.recordId = mElement.getAD_Element_ID();	
		} else {
			element.skip = true;
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	protected void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {


		int adElement_id = Env.getContextAsInt(ctx.ctx,
				X_AD_Element.COLUMNNAME_AD_Element_ID);
		if (ctx.packOut.isExported(X_AD_Element.COLUMNNAME_AD_Element_ID+"|"+adElement_id))
			return;

		X_AD_Element mAdElement = new X_AD_Element(ctx.ctx, adElement_id, null);
		if (ctx.packOut.getFromDate() != null) {
			if (mAdElement.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", "AD_Element", atts);
		createAdElementBinding(ctx, document, mAdElement);

		PackOut packOut = ctx.packOut;
		packOut.getCtx().ctx.put("Table_Name",X_AD_Element.Table_Name);
		try {
			new CommonTranslationHandler().packOut(packOut,document,null,mAdElement.get_ID());
		} catch(Exception e) {
			if (log.isLoggable(Level.INFO)) log.info(e.toString());
		}

		document.endElement("", "", "AD_Element");
	}


	private void createAdElementBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_Element m_AdElement) {

		PoExporter filler = new PoExporter(ctx, document, m_AdElement);
		if (m_AdElement.getAD_Element_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add(X_AD_Element.COLUMNNAME_AD_Element_ID, new AttributesImpl());

		List<String> excludes = defaultExcludeList(X_AD_Element.Table_Name);
		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Element.COLUMNNAME_AD_Element_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Element.COLUMNNAME_AD_Element_ID);
	}
}
