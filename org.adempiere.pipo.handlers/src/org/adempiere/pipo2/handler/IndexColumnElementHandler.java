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
import org.compiere.model.MIndexColumn;
import org.compiere.model.MTableIndex;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

/**
 * Index column (AD_IndexColumn) element handler
 * @author Elaine
 *
 */
public class IndexColumnElementHandler extends AbstractElementHandler {

	@Override
	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			if (isParentDefer(element, MTableIndex.Table_Name)) {
				element.defer = true;
				return;
			}

			List<String> excludes = defaultExcludeList(MIndexColumn.Table_Name);

			MIndexColumn mIndexColumn = findPO(ctx, element);
			if (mIndexColumn == null) {
				int parentId = 0;
				if (getParentId(element, MTableIndex.Table_Name) > 0) {
					parentId = getParentId(element, MTableIndex.Table_Name);
				} else {
					Element pfElement = element.properties.get(MIndexColumn.COLUMNNAME_AD_TableIndex_ID);
					parentId = ReferenceUtils.resolveReference(ctx.ctx, pfElement, getTrxName(ctx));
				}
				if (parentId <= 0) {
					element.defer = true;
					element.unresolved = "AD_TableIndex_ID";
					return;
				}
				
				mIndexColumn = new MIndexColumn(ctx.ctx, 0, getTrxName(ctx));
				mIndexColumn.setAD_TableIndex_ID(parentId);
				excludes.add(MIndexColumn.COLUMNNAME_AD_TableIndex_ID);
			}

			PoFiller filler = new PoFiller(ctx, mIndexColumn, element, this);

			if (mIndexColumn.getAD_IndexColumn_ID() == 0 && isOfficialId(element, "AD_IndexColumn_ID"))
				filler.setInteger("AD_IndexColumn_ID");

			excludes.add("AD_Column_ID");
			int columnId = 0;
			Element columnElement = element.properties.get("AD_Column_ID");
			if (ReferenceUtils.isIDLookup(columnElement) || ReferenceUtils.isUUIDLookup(columnElement)) {
				columnId = ReferenceUtils.resolveReference(ctx.ctx, columnElement, getTrxName(ctx));
			}
			if (columnId > 0)
				mIndexColumn.setAD_Column_ID(columnId);

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			if (mIndexColumn.is_new() || mIndexColumn.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, MIndexColumn.Table_Name, MIndexColumn.Table_ID);
				String action = null;
				if (!mIndexColumn.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), MIndexColumn.Table_Name, mIndexColumn);
					action = "Update";
				} else {
					action = "New";
				}
				if (mIndexColumn.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mIndexColumn.toString(), mIndexColumn.get_ID(), action);
				} else {
					logImportDetail(ctx, impDetail, 0, mIndexColumn.toString(), mIndexColumn.get_ID(), action);
					throw new POSaveFailedException("Failed to save AD_IndexColumn " + mIndexColumn.toString());
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
		int AD_IndexColumn_ID = Env.getContextAsInt(ctx.ctx, MIndexColumn.COLUMNNAME_AD_IndexColumn_ID);
		MIndexColumn m_IndexColumn = new MIndexColumn(ctx.ctx, AD_IndexColumn_ID, getTrxName(ctx));

		if (ctx.packOut.getFromDate() != null) {
			if (m_IndexColumn.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", MIndexColumn.Table_Name, atts);
		createIndexColumnBinding(ctx, document, m_IndexColumn);
		document.endElement("", "", MIndexColumn.Table_Name);
	}

	private void createIndexColumnBinding(PIPOContext ctx, TransformerHandler document, MIndexColumn m_IndexColumn) {
		PoExporter filler = new PoExporter(ctx, document, m_IndexColumn);
		List<String>excludes = defaultExcludeList(MIndexColumn.Table_Name);

		if (m_IndexColumn.getAD_IndexColumn_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_IndexColumn_ID", new AttributesImpl());

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, MIndexColumn.COLUMNNAME_AD_IndexColumn_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(MIndexColumn.COLUMNNAME_AD_IndexColumn_ID);
	}

}
