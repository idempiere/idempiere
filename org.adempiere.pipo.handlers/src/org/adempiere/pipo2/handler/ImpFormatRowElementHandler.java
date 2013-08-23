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
import org.compiere.model.I_AD_ImpFormat;
import org.compiere.model.I_AD_ImpFormat_Row;
import org.compiere.model.X_AD_ImpFormat_Row;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ImpFormatRowElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element) throws SAXException {

		String action = null;
		List<String> excludes = defaultExcludeList(X_AD_ImpFormat_Row.Table_Name);

		if (isParentDefer(element, I_AD_ImpFormat.Table_Name)) {
			element.defer = true;
			return;
		}

		X_AD_ImpFormat_Row mImpFormatRow = findPO(ctx, element);
		if (mImpFormatRow == null) {
			mImpFormatRow = new X_AD_ImpFormat_Row(ctx.ctx, 0, getTrxName(ctx));
		}
		PoFiller filler = new PoFiller(ctx, mImpFormatRow, element, this);
		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			element.unresolved = notfounds.toString();
			return;
		}

		if (mImpFormatRow.is_new() || mImpFormatRow.is_Changed()) {
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_ImpFormat_Row.Table_Name,
					X_AD_ImpFormat_Row.Table_ID);
			if (!mImpFormatRow.is_new()){
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_ImpFormat_Row.Table_Name, mImpFormatRow);
				action = "Update";
			}
			else{
				action = "New";
			}
			if (mImpFormatRow.save(getTrxName(ctx)) == true){
				logImportDetail (ctx, impDetail, 1, mImpFormatRow.getName(), mImpFormatRow.get_ID(),action);
			}
			else{
				logImportDetail (ctx, impDetail, 0, mImpFormatRow.getName(), mImpFormatRow.get_ID(),action);
				throw new POSaveFailedException("Failed to save Import Format Row " + mImpFormatRow.getName());
			}
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int AD_ImpFormat_Row_ID = Env.getContextAsInt(ctx.ctx, X_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID);
		if (ctx.packOut.isExported(X_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID+"|"+AD_ImpFormat_Row_ID))
			return;

		X_AD_ImpFormat_Row m_ImpFormat_Row = new X_AD_ImpFormat_Row (ctx.ctx, AD_ImpFormat_Row_ID, getTrxName(ctx));
		
		if (ctx.packOut.getFromDate() != null) {
			if (m_ImpFormat_Row.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}
		
		verifyPackOutRequirement(m_ImpFormat_Row);
		
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("","",I_AD_ImpFormat_Row.Table_Name,atts);
		createImpFormatRowBinding(ctx,document,m_ImpFormat_Row);
		document.endElement("","",I_AD_ImpFormat_Row.Table_Name);
	}

	private void createImpFormatRowBinding(PIPOContext ctx, TransformerHandler document, X_AD_ImpFormat_Row m_ImpFormat_Row)
	{
		PoExporter filler = new PoExporter(ctx, document, m_ImpFormat_Row);
		List<String> excludes = defaultExcludeList(X_AD_ImpFormat_Row.Table_Name);

		if (m_ImpFormat_Row.getAD_ImpFormat_Row_ID() <= PackOut.MAX_OFFICIAL_ID)
		{
			filler.add("AD_ImpFormat_Row_ID", new AttributesImpl());
		}

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID);
	}
}
