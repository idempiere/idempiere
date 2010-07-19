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
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MTable;
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

		if (isParentDefer(element, "impformat")) {
			element.defer = true;
			return;
		}

		int impFormatId = 0;
		String impFormatName = getStringValue(element, "AD_ImpFormat.Name", excludes);
		if (getParentId(element, "impformat") > 0) {
			impFormatId = getParentId(element, "impformat");
		} else {
			impFormatId = findIdByName(ctx, "AD_ImpFormat", impFormatName);
		}

		if (impFormatId <= 0) {
			element.defer = true;
			return;
		}

		String tableName = getStringValue(element, "AD_Table.TableName", excludes);
		int tableId = 0;
		if (tableName != null && tableName.trim().length() > 0) {
			tableId = findIdByColumn(ctx, "AD_Table", "TableName", tableName);
			if (tableId <= 0) {
				element.defer = true;
				return;
			}

		}

		String columnName = getStringValue(element, "AD_Column.ColumnName", excludes);
		int columnId = 0;
		if (columnName != null && columnName.trim().length() > 0) {
			columnId  = findIdByColumnAndParentId (ctx, "AD_Column","ColumnName", columnName, "AD_Table", tableId);
			if (columnId <= 0) {
				element.defer = true;
				return;
			}
		}

		X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_ImpFormat_Row.Table_Name,
				X_AD_ImpFormat_Row.Table_ID);
		StringBuffer sqlB = new StringBuffer ("SELECT AD_ImpFormat_Row_ID FROM AD_ImpFormat_Row WHERE AD_Column_ID=? AND AD_ImpFormat_ID=?");
		int id = DB.getSQLValue(getTrxName(ctx),sqlB.toString(),columnId,impFormatId);
		X_AD_ImpFormat_Row mImpFormatRow = new X_AD_ImpFormat_Row(ctx, id, getTrxName(ctx));
		PoFiller filler = new PoFiller(ctx, mImpFormatRow, element, this);
		if (id <= 0 && isOfficialId(element, "AD_ImpFormat_Row_ID"))
		{
			filler.setInteger("AD_ImpFormat_Row_ID");
		}

		if (id > 0){
			backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_ImpFormat_Row.Table_Name, mImpFormatRow);
			action = "Update";
		}
		else{
			action = "New";
		}
		mImpFormatRow.setAD_Column_ID(columnId);
		mImpFormatRow.setAD_ImpFormat_ID(impFormatId);

		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			return;
		}
		if (mImpFormatRow.save(getTrxName(ctx)) == true){
			logImportDetail (ctx, impDetail, 1, mImpFormatRow.getName(), mImpFormatRow.get_ID(),action);
		}
		else{
			logImportDetail (ctx, impDetail, 0, mImpFormatRow.getName(), mImpFormatRow.get_ID(),action);
			throw new POSaveFailedException("Failed to import Import Format Row.");
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_ImpFormat_Row_ID = Env.getContextAsInt(ctx, X_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID);
		X_AD_ImpFormat_Row m_ImpFormat_Row = new X_AD_ImpFormat_Row (ctx, AD_ImpFormat_Row_ID, getTrxName(ctx));
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.import-format.row");
		document.startElement("","","impformatrow",atts);
		createImpFormatRowBinding(ctx,document,m_ImpFormat_Row);
		document.endElement("","","impformatrow");
	}

	private void createImpFormatRowBinding(Properties ctx, TransformerHandler document, X_AD_ImpFormat_Row m_ImpFormat_Row)
	{
		PoExporter filler = new PoExporter(ctx, document, m_ImpFormat_Row);
		List<String> excludes = defaultExcludeList(X_AD_ImpFormat_Row.Table_Name);

		String sql = null;

		excludes.add("AD_Column_ID");
		sql = "SELECT ColumnName FROM AD_Column WHERE AD_Column_ID=?";
		String columnName = DB.getSQLValueString(null,sql,m_ImpFormat_Row.getAD_Column_ID());
		filler.addString("AD_Column.ColumnName", columnName, new AttributesImpl());

		sql = "SELECT AD_Table_ID FROM AD_Column WHERE AD_Column_ID=?";
		int tableId = DB.getSQLValue(null, sql,m_ImpFormat_Row.getAD_Column_ID());
		String tableName = MTable.getTableName(Env.getCtx(), tableId);
		filler.addString("AD_Table.TableName", tableName, new AttributesImpl());

		if (m_ImpFormat_Row.getAD_ImpFormat_Row_ID() <= PackOut.MAX_OFFICIAL_ID)
		{
			filler.add("AD_ImpFormat_Row_ID", new AttributesImpl());
		}

		filler.export(excludes);
	}
}
