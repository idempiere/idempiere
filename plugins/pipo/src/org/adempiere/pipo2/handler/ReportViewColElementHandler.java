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
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_ReportView_Col;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ReportViewColElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		String action = null;
		List<String> excludes = defaultExcludeList(X_AD_ReportView_Col.Table_Name);

		String entitytype = getStringValue(element,"EntityType");
		if (isProcessElement(ctx, entitytype)) {
			String name = getStringValue(element, "AD_ReportView.Name", excludes);
			int AD_ReportView_ID = 0;
			if (getParentId(element, "reportview") > 0) {
				AD_ReportView_ID = getParentId(element, "reportview");
			} else {
				AD_ReportView_ID = findIdByColumn(ctx, "AD_ReportView", "Name", name);
			}
			if (AD_ReportView_ID <= 0) {
				element.defer = true;
				return;
			}

			name = getStringValue(element, "AD_Column.ColumnName", excludes);
			int AD_Column_ID = 0;
			if (name != null && name.trim().length() > 0) {
				AD_Column_ID = findIdByColumn(ctx, "AD_Column", "Name", name);
				if (AD_Column_ID <= 0) {
					element.defer = true;
					return;
				}
			}

			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_ReportView_Col.Table_Name,
					X_AD_ReportView_Col.Table_ID);

			String functionColumn = getStringValue(element, "FunctionColumn", excludes);
			StringBuffer sql = new StringBuffer("SELECT AD_Reportview_Col_ID FROM AD_Reportview_Col ")
				.append(" WHERE AD_Column_ID ");
			if (AD_Column_ID > 0)
				sql.append(" = " + AD_Column_ID);
			else
				sql.append(" IS NULL ");
			sql.append(" AND FunctionColumn = ?");
			sql.append(" AND AD_ReportView_ID = ?");

			int id = DB.getSQLValue(getTrxName(ctx), sql.toString(), functionColumn, AD_ReportView_ID);
			if (id < 0) id = 0;
			X_AD_ReportView_Col mReportviewCol = new X_AD_ReportView_Col(ctx,
					id, getTrxName(ctx));
			if (id <= 0 && isOfficialId(element, "AD_ReportView_Col_ID"))
				mReportviewCol.setAD_ReportView_Col_ID(getIntValue(element, "AD_ReportView_Col_ID"));
			if (id > 0) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_ReportView_Col.Table_Name,
						mReportviewCol);
				action = "Update";
			} else {
				action = "New";
			}

			mReportviewCol.setAD_ReportView_ID(AD_ReportView_ID);
			if (AD_Column_ID > 0) {
				mReportviewCol.setAD_Column_ID(id);
			}
			mReportviewCol.setFunctionColumn(functionColumn);

			PoFiller filler = new PoFiller(ctx, mReportviewCol, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}

			if (mReportviewCol.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, "" + mReportviewCol.getAD_ReportView_ID(),
						mReportviewCol.get_ID(), action);
			} else {
				logImportDetail(ctx, impDetail, 0, "" + mReportviewCol.getAD_ReportView_ID(),
						mReportviewCol.get_ID(),action);
				throw new POSaveFailedException("ReportViewCol");
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int AD_ReportView_Col_ID = Env.getContextAsInt(ctx,
				X_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID);
		X_AD_ReportView_Col m_Reportview_Col = new X_AD_ReportView_Col(ctx,
				AD_ReportView_Col_ID, getTrxName(ctx));
		AttributesImpl atts = new AttributesImpl();
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.report-view.column");
		document.startElement("", "", "reportviewcol", atts);
		createReportViewColBinding(ctx, document, m_Reportview_Col);
		document.endElement("", "", "reportviewcol");
	}

	private void createReportViewColBinding(Properties ctx, TransformerHandler document,
			X_AD_ReportView_Col m_Reportview_Col) {

		PoExporter filler = new PoExporter(ctx, document, m_Reportview_Col);
		List<String> excludes = defaultExcludeList(X_AD_ReportView_Col.Table_Name);
		if (m_Reportview_Col.getAD_ReportView_Col_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_ReportView_Col_ID", new AttributesImpl());

		filler.addTableReference("AD_Column_ID", "AD_Column", "ColumnName", new AttributesImpl());
		excludes.add("AD_Column_ID");
		filler.export(excludes);
	}
}
