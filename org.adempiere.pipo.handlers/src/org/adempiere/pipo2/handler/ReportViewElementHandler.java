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
import java.sql.SQLException;
import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.exceptions.DBException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_PrintFormat;
import org.compiere.model.I_AD_ReportView;
import org.compiere.model.I_AD_Table;
import org.compiere.model.MReportView;
import org.compiere.model.Query;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_ReportView_Col;
import org.compiere.model.X_AD_ReportView_Column;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ReportViewElementHandler extends AbstractElementHandler {

	private ReportViewColElementHandler columnHandler = new ReportViewColElementHandler();
	private ReportViewColumnElementHandler columnSelHandler = new ReportViewColumnElementHandler();

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		
		List<String> excludes = defaultExcludeList(MReportView.Table_Name);
		
		MReportView mReportview = findPO(ctx, element);
		if (mReportview == null) {
			mReportview = new MReportView(ctx.ctx, 0, getTrxName(ctx));
		}
		PoFiller filler = new PoFiller(ctx, mReportview, element, this);
		List<String> notfound = filler.autoFill(excludes);
		if (notfound.size() > 0) {
			element.defer = true;
			element.unresolved = notfound.toString();
			return;
		}
		
		if (mReportview.is_new() || mReportview.is_Changed()) {
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, MReportView.Table_Name,
					MReportView.Table_ID);
			String action = null;
			if (!mReportview.is_new()) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), MReportView.Table_Name, mReportview);
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
				throw new POSaveFailedException("Failed to save ReportView " + mReportview.getName());
			}
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		PackOut packOut = ctx.packOut;
		int AD_ReportView_ID = Env.getContextAsInt(ctx.ctx, "AD_ReportView_ID");
		if (ctx.packOut.isExported("AD_ReportView_ID"+"|"+AD_ReportView_ID))
			return;

		AttributesImpl atts = new AttributesImpl();
		MReportView m_Reportview = new MReportView(ctx.ctx, AD_ReportView_ID, getTrxName(ctx));

		// Export Table if neccessary
		ElementHandler tableHandler = packOut.getHandler(I_AD_Table.Table_Name);
		try {
			tableHandler.packOut(packOut, document, null, m_Reportview.getAD_Table_ID());
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		boolean createElement = isPackOutElement(ctx, m_Reportview);

		if (createElement) {
			verifyPackOutRequirement(m_Reportview);
			addTypeName(atts, "table");
			document.startElement("", "", I_AD_ReportView.Table_Name, atts);
			createReportViewBinding(ctx, document, m_Reportview);
		}

		String sql = "SELECT AD_ReportView_Col_ID FROM AD_ReportView_Col WHERE AD_Reportview_ID= "
				+ AD_ReportView_ID;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createReportViewCol(ctx, document, rs.getInt("AD_ReportView_Col_ID"));
			}
		} catch (SQLException e) {
			throw new DBException(e);
		} finally {
			DB.close(rs, pstmt);
		}

		sql = "SELECT AD_Column_ID FROM AD_ReportView_Column WHERE AD_Reportview_ID= "
				+ AD_ReportView_ID;
		pstmt = null;
		rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createReportViewColumn(ctx, document, AD_ReportView_ID, rs.getInt("AD_Column_ID"));
			}
		} catch (SQLException e) {
			throw new DBException(e);
		} finally {
			DB.close(rs, pstmt);
		}

		if (createElement) {
			document.endElement("", "", MReportView.Table_Name);
		}
		
		sql = "SELECT AD_PrintFormat_ID FROM AD_PrintFormat WHERE AD_ReportView_ID="
					+ AD_ReportView_ID + " AND AD_Client_ID=" + Env.getAD_Client_ID(ctx.ctx);
		pstmt = null;
		rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ElementHandler pftHandler = packOut.getHandler(I_AD_PrintFormat.Table_Name);
				pftHandler.packOut(packOut, document, null, rs.getInt(1));
			}
		} catch (Exception e) {
			throw new AdempiereException(e);
		} finally {
			DB.close(rs, pstmt);
		}
	}

	private void createReportViewCol(PIPOContext ctx,
			TransformerHandler document, int AD_ReportView_Col_ID)
			throws SAXException {
		Env.setContext(ctx.ctx,
				X_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID,
				AD_ReportView_Col_ID);
		columnHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_ReportView_Col.COLUMNNAME_AD_ReportView_Col_ID);
	}

	private void createReportViewColumn(PIPOContext ctx,
			TransformerHandler document, int AD_ReportView_ID, int AD_Column_ID)
					throws SAXException {

		Query query = new Query(ctx.ctx, "AD_ReportView_Column", "AD_ReportView_ID=? AND AD_Column_ID=?", getTrxName(ctx));
		X_AD_ReportView_Column po = query.setParameters(new Object[]{AD_ReportView_ID, AD_Column_ID}).first();

		ctx.ctx.put("po", po);
		columnSelHandler.create(ctx, document);
		ctx.ctx.remove("po");
	}

	private void createReportViewBinding(PIPOContext ctx, TransformerHandler document,
			MReportView m_Reportview) {

		PoExporter filler = new PoExporter(ctx, document, m_Reportview);
		List<String> excludes = defaultExcludeList(MReportView.Table_Name);
		if (m_Reportview.getAD_ReportView_ID() <= PackOut.MAX_OFFICIAL_ID)
	        filler.add("AD_ReportView_ID", new AttributesImpl());
		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_ReportView_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_ReportView_ID);
	}
}
