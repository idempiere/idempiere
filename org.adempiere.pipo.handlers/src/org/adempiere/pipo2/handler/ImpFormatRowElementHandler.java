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
import org.compiere.model.I_AD_ImpFormat;
import org.compiere.model.I_AD_ImpFormat_Row;
import org.compiere.model.X_AD_ImpFormat_Row;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ImpFormatRowElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element) throws SAXException {

		String action = null;
		List<String> excludes = defaultExcludeList(X_AD_ImpFormat_Row.Table_Name);

		if (isParentDefer(element, I_AD_ImpFormat.Table_Name)) {
			element.defer = true;
			return;
		}

		X_AD_ImpFormat_Row mImpFormatRow = findPO(ctx, element);
		if (mImpFormatRow == null) {
			int impFormatId = 0;
			if (getParentId(element, I_AD_ImpFormat.Table_Name) > 0) {
				impFormatId = getParentId(element, I_AD_ImpFormat.Table_Name);
			} else {
				Element e = element.properties.get(I_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_ID);
				if (ReferenceUtils.isIDLookup(e) || ReferenceUtils.isUUIDLookup(e))
					impFormatId = ReferenceUtils.resolveReference(ctx, e, getTrxName(ctx));
				else
					impFormatId = findIdByName(ctx, "AD_ImpFormat", e.contents.toString());
			}

			if (impFormatId <= 0) {
				element.defer = true;
				return;
			}

			Element tableElement = element.properties.get(I_AD_ImpFormat.COLUMNNAME_AD_Table_ID);
			int tableId = 0;
			if (ReferenceUtils.isIDLookup(tableElement) || ReferenceUtils.isUUIDLookup(tableElement)) {
				tableId = ReferenceUtils.resolveReference(ctx, tableElement, getTrxName(ctx));
			} else {
				String tableName = getStringValue(element, I_AD_ImpFormat.COLUMNNAME_AD_Table_ID, excludes);

				if (tableName != null && tableName.trim().length() > 0) {
					tableId = findIdByColumn(ctx, "AD_Table", "TableName", tableName);
				}
				if (tableId <= 0) {
					element.defer = true;
					return;
				}
			}

			Element columnElement = element.properties.get(I_AD_ImpFormat_Row.COLUMNNAME_AD_Column_ID);
			int columnId = 0;
			if (ReferenceUtils.isIDLookup(columnElement) || ReferenceUtils.isUUIDLookup(columnElement)) {
				columnId = ReferenceUtils.resolveReference(ctx, columnElement, getTrxName(ctx));
			} else {
				String columnName = getStringValue(element, I_AD_ImpFormat_Row.COLUMNNAME_AD_Column_ID, excludes);

				if (columnName != null && columnName.trim().length() > 0) {
					columnId  = findIdByColumnAndParentId (ctx, "AD_Column","ColumnName", columnName, "AD_Table", tableId);
				}
				if (columnId <= 0) {
					element.defer = true;
					return;
				}
			}

			StringBuffer sqlB = new StringBuffer ("SELECT AD_ImpFormat_Row_ID FROM AD_ImpFormat_Row WHERE AD_Column_ID=? AND AD_ImpFormat_ID=?");
			int id = DB.getSQLValue(getTrxName(ctx),sqlB.toString(),columnId,impFormatId);
			mImpFormatRow = new X_AD_ImpFormat_Row(ctx, id > 0 ? id : 0, getTrxName(ctx));

			mImpFormatRow.setAD_Column_ID(columnId);
			mImpFormatRow.setAD_ImpFormat_ID(impFormatId);
		}
		PoFiller filler = new PoFiller(ctx, mImpFormatRow, element, this);
		if (mImpFormatRow.getAD_ImpFormat_Row_ID() == 0 && isOfficialId(element, "AD_ImpFormat_Row_ID"))
		{
			filler.setInteger("AD_ImpFormat_Row_ID");
		}

		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
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
				throw new POSaveFailedException("Failed to import Import Format Row.");
			}
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_ImpFormat_Row_ID = Env.getContextAsInt(ctx, X_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID);
		X_AD_ImpFormat_Row m_ImpFormat_Row = new X_AD_ImpFormat_Row (ctx, AD_ImpFormat_Row_ID, getTrxName(ctx));
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("","",I_AD_ImpFormat_Row.Table_Name,atts);
		createImpFormatRowBinding(ctx,document,m_ImpFormat_Row);
		document.endElement("","",I_AD_ImpFormat_Row.Table_Name);
	}

	private void createImpFormatRowBinding(Properties ctx, TransformerHandler document, X_AD_ImpFormat_Row m_ImpFormat_Row)
	{
		PoExporter filler = new PoExporter(ctx, document, m_ImpFormat_Row);
		List<String> excludes = defaultExcludeList(X_AD_ImpFormat_Row.Table_Name);

		String sql = null;

		int tableId = DB.getSQLValue(null, sql,m_ImpFormat_Row.getAD_Column_ID());
		filler.addTableReference("AD_Table_ID", "AD_Table", "TableName", tableId, new AttributesImpl());

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
		Env.setContext(packout.getCtx(), I_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().remove(I_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID);
	}
}
