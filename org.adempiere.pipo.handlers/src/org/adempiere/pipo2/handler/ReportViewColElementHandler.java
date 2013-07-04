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
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_ReportView;
import org.compiere.model.I_AD_ReportView_Col;
import org.compiere.model.MColumn;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_ReportView_Col;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ReportViewColElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_ReportView_Col.Table_Name);

		String entitytype = getStringValue(element,"EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			excludes.add("AD_Table_ID");
			X_AD_ReportView_Col mReportviewCol = findPO(ctx, element);
			if (mReportviewCol == null) {
				int AD_ReportView_ID = 0;
				if (getParentId(element, I_AD_ReportView.Table_Name) > 0) {
					AD_ReportView_ID = getParentId(element, I_AD_ReportView.Table_Name);
				} else {
					Element rvElement = element.properties.get(I_AD_ReportView_Col.COLUMNNAME_AD_ReportView_ID);
					AD_ReportView_ID = ReferenceUtils.resolveReference(ctx.ctx, rvElement, getTrxName(ctx));
				}
				if (AD_ReportView_ID <= 0) {
					element.defer = true;
					element.unresolved = "AD_ReportView_ID";
					return;
				}

				int AD_Column_ID = 0;
				Element columnElement = element.properties.get(I_AD_ReportView_Col.COLUMNNAME_AD_Column_ID);
				if (ReferenceUtils.isIDLookup(columnElement) || ReferenceUtils.isUUIDLookup(columnElement)) {
					AD_Column_ID = ReferenceUtils.resolveReference(ctx.ctx, columnElement, getTrxName(ctx));
				} else {
					if (columnElement.contents != null && columnElement.contents.length() > 0) {
						Element tableElement = element.properties.get("AD_Table_ID");
						int AD_Table_ID = ReferenceUtils.resolveReference(ctx.ctx, tableElement, getTrxName(ctx));
						AD_Column_ID = findIdByColumnAndParentId(ctx, "AD_Column", "ColumnName", columnElement.contents.toString(),
								"AD_Table", AD_Table_ID);
						if (AD_Column_ID <= 0) {
							element.defer = true;
							element.unresolved = "AD_Column_ID";
							return;
						}
					}
				}

				String functionColumn = getStringValue(element, "FunctionColumn");
				StringBuffer sql = new StringBuffer("SELECT AD_Reportview_Col_ID FROM AD_Reportview_Col ")
					.append(" WHERE AD_Column_ID ");
				if (AD_Column_ID > 0)
					sql.append(" = " + AD_Column_ID);
				else
					sql.append(" IS NULL ");
				sql.append(" AND FunctionColumn = ?");
				sql.append(" AND AD_ReportView_ID = ?");

				int id = 0;
				if (!hasUUIDKey(ctx, element)) {
					id = DB.getSQLValue(getTrxName(ctx), sql.toString(), functionColumn, AD_ReportView_ID);
				}
				mReportviewCol = new X_AD_ReportView_Col(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
				mReportviewCol.setAD_ReportView_ID(AD_ReportView_ID);
				if (AD_Column_ID > 0) {
					mReportviewCol.setAD_Column_ID(AD_Column_ID);
				}
				mReportviewCol.setFunctionColumn(functionColumn);
				excludes.add("FunctionColumn");
				excludes.add("AD_ReportView_ID");
				excludes.add("AD_Column_ID");
			}

			if (mReportviewCol.getAD_ReportView_Col_ID() == 0 && isOfficialId(element, "AD_ReportView_Col_ID"))
				mReportviewCol.setAD_ReportView_Col_ID(getIntValue(element, "AD_ReportView_Col_ID"));

			PoFiller filler = new PoFiller(ctx, mReportviewCol, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			if (mReportviewCol.is_new() || mReportviewCol.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_ReportView_Col.Table_Name,
						X_AD_ReportView_Col.Table_ID);
				String action = null;
				if (!mReportviewCol.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_ReportView_Col.Table_Name,
							mReportviewCol);
					action = "Update";
				} else {
					action = "New";
				}
				if (mReportviewCol.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, "" + mReportviewCol.getAD_ReportView_ID(),
							mReportviewCol.get_ID(), action);
				} else {
					logImportDetail(ctx, impDetail, 0, "" + mReportviewCol.getAD_ReportView_ID(),
							mReportviewCol.get_ID(),action);
					throw new POSaveFailedException("Failed to save ReportViewCol");
				}
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int AD_ReportView_Col_ID = Env.getContextAsInt(ctx.ctx,
				X_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID);
		X_AD_ReportView_Col m_Reportview_Col = new X_AD_ReportView_Col(ctx.ctx,
				AD_ReportView_Col_ID, getTrxName(ctx));
		
		if (ctx.packOut.getFromDate() != null) {
			if (m_Reportview_Col.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}
		
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", X_AD_ReportView_Col.Table_Name, atts);
		createReportViewColBinding(ctx, document, m_Reportview_Col);
		document.endElement("", "", X_AD_ReportView_Col.Table_Name);
	}

	private void createReportViewColBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_ReportView_Col m_Reportview_Col) {

		PoExporter filler = new PoExporter(ctx, document, m_Reportview_Col);
		List<String> excludes = defaultExcludeList(X_AD_ReportView_Col.Table_Name);
		if (m_Reportview_Col.getAD_ReportView_Col_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_ReportView_Col_ID", new AttributesImpl());

		if (m_Reportview_Col.getAD_Column_ID() > 0) {
			int AD_Column_ID = m_Reportview_Col.getAD_Column_ID();
			MColumn mColumn = new MColumn(ctx.ctx, AD_Column_ID, getTrxName(ctx));
			int AD_Table_ID = mColumn.getAD_Table_ID();
			AttributesImpl tableAtts = new AttributesImpl();
			String value = ReferenceUtils.getTableReference("AD_Table", "TableName", AD_Table_ID, tableAtts);
			filler.addString("AD_Table_ID", value, tableAtts);
		}

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID);
	}
}
