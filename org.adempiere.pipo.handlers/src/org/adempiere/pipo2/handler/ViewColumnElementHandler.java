/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
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

import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MViewColumn;
import org.compiere.model.MViewComponent;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

/**
 * View column (AD_ViewColumn) element handler
 * @author Elaine
 *
 */
public class ViewColumnElementHandler extends AbstractElementHandler {

	@Override
	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			if (isParentDefer(element, MViewComponent.Table_Name)) {
				element.defer = true;
				return;
			}

			List<String> excludes = defaultExcludeList(MViewColumn.Table_Name);

			MViewColumn mViewColumn = findPO(ctx, element);
			if (mViewColumn == null) {
				int parentId = 0;
				if (getParentId(element, MViewComponent.Table_Name) > 0) {
					parentId = getParentId(element, MViewComponent.Table_Name);
				} else {
					Element pfElement = element.properties.get(MViewColumn.COLUMNNAME_AD_ViewComponent_ID);
					parentId = ReferenceUtils.resolveReference(ctx.ctx, pfElement, getTrxName(ctx));
				}
				if (parentId <= 0) {
					element.defer = true;
					element.unresolved = "AD_ViewComponent_ID";
					return;
				}
				
				mViewColumn = new MViewColumn(ctx.ctx, 0, getTrxName(ctx));
				mViewColumn.setAD_ViewComponent_ID(parentId);
				excludes.add(MViewColumn.COLUMNNAME_AD_ViewComponent_ID);
			}

			PoFiller filler = new PoFiller(ctx, mViewColumn, element, this);

			if (mViewColumn.getAD_ViewColumn_ID() == 0 && isOfficialId(element, "AD_ViewColumn_ID"))
				filler.setInteger("AD_ViewColumn_ID");

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			if (mViewColumn.is_new() || mViewColumn.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, MViewColumn.Table_Name, MViewColumn.Table_ID);
				String action = null;
				if (!mViewColumn.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), MViewColumn.Table_Name, mViewColumn);
					action = "Update";
				} else {
					action = "New";
				}
				if (mViewColumn.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mViewColumn.toString(), mViewColumn.get_ID(), action);
				} else {
					logImportDetail(ctx, impDetail, 0, mViewColumn.toString(), mViewColumn.get_ID(), action);
					throw new POSaveFailedException("Failed to save AD_ViewColumn " + mViewColumn.toString());
				}
			}
		} else {
			element.skip = true;
		}
		
	}

	@Override
	public void endElement(PIPOContext ctx, Element element) throws SAXException {		
	}
	
	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		int AD_ViewColumn_ID = Env.getContextAsInt(ctx.ctx, MViewColumn.COLUMNNAME_AD_ViewColumn_ID);
		MViewColumn m_ViewColumn = new MViewColumn(ctx.ctx, AD_ViewColumn_ID, getTrxName(ctx));

		if (ctx.packOut.getFromDate() != null) {
			if (m_ViewColumn.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", MViewColumn.Table_Name, atts);
		createViewColumnBinding(ctx, document, m_ViewColumn);
		document.endElement("", "", MViewColumn.Table_Name);
	}

	private void createViewColumnBinding(PIPOContext ctx, TransformerHandler document, MViewColumn m_ViewColumn) {
		PoExporter filler = new PoExporter(ctx, document, m_ViewColumn);
		List<String>excludes = defaultExcludeList(MViewColumn.Table_Name);

		if (m_ViewColumn.getAD_ViewColumn_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_ViewColumn_ID", new AttributesImpl());

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, MViewColumn.COLUMNNAME_AD_ViewColumn_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(MViewColumn.COLUMNNAME_AD_ViewColumn_ID);
	}

}
