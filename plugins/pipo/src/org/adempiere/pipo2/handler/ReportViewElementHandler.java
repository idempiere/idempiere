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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.IPackOutHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_ReportView;
import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_ReportView;
import org.compiere.model.X_AD_ReportView_Col;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ReportViewElementHandler extends AbstractElementHandler implements IPackOutHandler{

	private ReportViewColElementHandler columnHandler = new ReportViewColElementHandler();

	private List<Integer> views = new ArrayList<Integer>();

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		
		List<String> excludes = defaultExcludeList(X_AD_ReportView.Table_Name);
		
		X_AD_ReportView mReportview = findPO(ctx, element);
		if (mReportview == null) {
			String name = getStringValue(element, "Name");
			int id = findIdByName(ctx, "AD_ReportView", name);
			mReportview = new X_AD_ReportView(ctx, id, getTrxName(ctx));
		}
		PoFiller filler = new PoFiller(ctx, mReportview, element, this);
		if (mReportview.getAD_ReportView_ID() == 0 && isOfficialId(element, "AD_ReportView_ID"))
			mReportview.setAD_ReportView_ID(getIntValue(element, "AD_ReportView_ID"));
		
		List<String> notfound = filler.autoFill(excludes);
		if (notfound.size() > 0) {
			element.defer = true;
			return;
		}
		
		if (mReportview.is_new() || mReportview.is_Changed()) {
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_ReportView.Table_Name,
					X_AD_ReportView.Table_ID);
			String action = null;
			if (!mReportview.is_new()) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_ReportView.Table_Name, mReportview);
				action = "Update";
			} else {
				action = "New";
			}
			if (mReportview.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, mReportview.getName(),
						mReportview.get_ID(), action);
				element.recordId = mReportview.getAD_ReportView_ID();
			} else {
				logImportDetail(ctx, impDetail, 0, mReportview.getName(),
						mReportview.get_ID(), action);
				throw new POSaveFailedException("ReportView");
			}
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		PackOut packOut = getPackOutProcess(ctx);
		int AD_ReportView_ID = Env.getContextAsInt(ctx, "AD_ReportView_ID");
		if (views.contains(AD_ReportView_ID))
			return;

		views.add(AD_ReportView_ID);
		AttributesImpl atts = new AttributesImpl();
		X_AD_ReportView m_Reportview = new X_AD_ReportView(ctx, AD_ReportView_ID, getTrxName(ctx));

		// Export Table if neccessary
		IPackOutHandler tableHandler = packOut.getHandler("T");
		try {
			tableHandler.packOut(packOut, null, null, document, null,m_Reportview.getAD_Table_ID());
		} catch (Exception e) {
			throw new AdempiereException(e);
		}

		addTypeName(atts, "ad.report-view");
		document.startElement("", "", I_AD_ReportView.Table_Name, atts);
		createReportViewBinding(ctx, document, m_Reportview);
		document.endElement("", "", I_AD_ReportView.Table_Name);

		String sql = "SELECT AD_PrintFormat_ID FROM AD_PrintFormat WHERE AD_ReportView_ID= "
				+ AD_ReportView_ID;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				IPackOutHandler pftHandler = packOut.getHandler("PFT");
				pftHandler.packOut(packOut, null, null, document, null, rs.getInt(1));

			}
		} catch (Exception e) {
			throw new AdempiereException(e);
		} finally {
			DB.close(rs, pstmt);
		}

		sql = "SELECT AD_ReportView_Col_ID FROM AD_ReportView_Col WHERE AD_Reportview_ID= "
					+ AD_ReportView_ID;
		pstmt = null;
		rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createReportViewCol(ctx, document, rs.getInt("AD_ReportView_Col_ID"));
			}
		} catch (Exception e) {
			throw new AdempiereException(e);
		} finally {
			DB.close(rs, pstmt);
		}
	}

	private void createReportViewCol(Properties ctx,
			TransformerHandler document, int AD_ReportView_Col_ID)
			throws SAXException {
		Env.setContext(ctx,
				X_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID,
				AD_ReportView_Col_ID);
		columnHandler.create(ctx, document);
		ctx.remove(X_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID);
	}

	private void createReportViewBinding(Properties ctx, TransformerHandler document,
			X_AD_ReportView m_Reportview) {

		PoExporter filler = new PoExporter(ctx, document, m_Reportview);
		List<String> excludes = defaultExcludeList(X_AD_ReportView.Table_Name);
		if (m_Reportview.getAD_ReportView_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_ReportView_ID", new AttributesImpl());
		filler.export(excludes);
	}

	public void packOut(PackOut packout, MPackageExp header, MPackageExpDetail detail,TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception
	{
		if(recordId <= 0)
			recordId = detail.getAD_ReportView_ID();

		Env.setContext(packout.getCtx(), X_AD_Package_Exp_Detail.COLUMNNAME_AD_ReportView_ID, recordId);

		this.create(packout.getCtx(), packOutDocument);
		packout.getCtx().remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_ReportView_ID);
	}
}
