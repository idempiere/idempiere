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
 *                 Teo Sarca, SC ARHIPAC SERVICE SRL
 *****************************************************************************/
package org.adempiere.pipo2.handler;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.DBException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_PrintFormat;
import org.compiere.model.I_AD_PrintPaper;
import org.compiere.model.I_AD_Table;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_PrintFormat;
import org.compiere.model.X_AD_PrintFormatItem;
import org.compiere.print.MPrintFormat;
import org.compiere.print.MPrintFormatItem;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class PrintFormatElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		
		X_AD_PrintFormat mPrintFormat = findPO(ctx, element);
		if (mPrintFormat == null) {
			mPrintFormat = new X_AD_PrintFormat(ctx.ctx, 0, getTrxName(ctx));
		}
		PoFiller filler = new PoFiller(ctx, mPrintFormat, element, this);
		List<String> excludes = defaultExcludeList(X_AD_PrintFormat.Table_Name);
		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			element.unresolved = notfounds.toString();
			return;
		}

		if (mPrintFormat.is_new() || mPrintFormat.is_Changed()) {
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_PrintFormat.Table_Name,
					X_AD_PrintFormat.Table_ID);		
			String action = null;
			if (!mPrintFormat.is_new()) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_PrintFormat.Table_Name, mPrintFormat);
				action = "Update";
			} else {
				action = "New";
			}
			if (mPrintFormat.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, mPrintFormat.getName(),
						mPrintFormat.get_ID(), action);
				element.recordId = mPrintFormat.getAD_PrintFormat_ID();
			} else {
				logImportDetail(ctx, impDetail, 0, mPrintFormat.getName(),
						mPrintFormat.get_ID(), action);
				throw new POSaveFailedException("Failed to save Print Format " + mPrintFormat.getName());
			}
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int AD_PrintFormat_ID = Env.getContextAsInt(ctx.ctx,
				X_AD_Package_Exp_Detail.COLUMNNAME_AD_PrintFormat_ID);
		if (ctx.packOut.isExported(X_AD_Package_Exp_Detail.COLUMNNAME_AD_PrintFormat_ID+"|"+AD_PrintFormat_ID))
			return;

		AttributesImpl atts = new AttributesImpl();

		MPrintFormat m_Printformat = new MPrintFormat(ctx.ctx, AD_PrintFormat_ID, null);
		if (m_Printformat.getAD_PrintPaper_ID() > 0) {
			try {
				ctx.packOut.getHandler(I_AD_PrintPaper.Table_Name).packOut(ctx.packOut, document, ctx.logDocument, m_Printformat.getAD_PrintPaper_ID());
			} catch (Exception e) {
				throw new SAXException(e);
			}
		}

		if (m_Printformat.getAD_Client_ID() == 0 && m_Printformat.getAD_Table_ID() > 0) {
			try {
				ctx.packOut.getHandler(I_AD_Table.Table_Name).packOut(ctx.packOut, document, ctx.logDocument, m_Printformat.getAD_Table_ID());
			} catch (Exception e) {
				throw new SAXException(e);
			}
		}
		
		boolean createElement = isPackOutElement(ctx, m_Printformat);

		int size = m_Printformat.getItemCount();
		for(int i = 0; i < size; i++) {
			MPrintFormatItem item = m_Printformat.getItem(i);
			if (item.getAD_PrintFormatChild_ID() > 0)
			{
				try {
					this.packOut(ctx.packOut, document, null, item.getAD_PrintFormatChild_ID());
				} catch (Exception e) {
					throw new SAXException(e);
				}
			}
		}
		
		if (createElement) {
			verifyPackOutRequirement(m_Printformat);
			addTypeName(atts, "table");
			document.startElement("", "", I_AD_PrintFormat.Table_Name, atts);
			createPrintFormatBinding(ctx, document, m_Printformat);
		}

		String sql = "SELECT AD_PrintFormatItem_ID FROM AD_PrintFormatItem WHERE AD_PrintFormat_ID= "
				+ m_Printformat.getAD_PrintFormat_ID()
				+ " ORDER BY "+X_AD_PrintFormatItem.COLUMNNAME_SeqNo;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createItem(ctx, document, rs.getInt("AD_PrintFormatItem_ID"));
			}
		} catch (Exception e) {
			throw new DBException(e);
		} finally {
			DB.close(rs, pstmt);
		}

		if (createElement) {
			document.endElement("", "", X_AD_PrintFormat.Table_Name);
		}
	}

	private void createItem(PIPOContext ctx, TransformerHandler document,
			int AD_PrintFormatItem_ID) throws SAXException {
		try {
			ctx.packOut.getHandler(X_AD_PrintFormatItem.Table_Name).packOut(ctx.packOut, document, ctx.logDocument, AD_PrintFormatItem_ID);
		} catch (Exception e) {
			throw new SAXException(e);
		}
	}

	private void createPrintFormatBinding(PIPOContext ctx, TransformerHandler document,
			MPrintFormat m_Printformat) {

		PoExporter filler = new PoExporter(ctx, document, m_Printformat);
		List<String> excludes = defaultExcludeList(X_AD_PrintFormat.Table_Name);
		if (m_Printformat.getAD_PrintFormat_ID() <= PackOut.MAX_OFFICIAL_ID) {
			filler.add("AD_PrintFormat_ID", new AttributesImpl());
		}

		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_PrintFormat_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_PrintFormat_ID);
	}
}

