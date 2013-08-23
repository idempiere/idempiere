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
import java.util.List;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_ImpFormat;
import org.compiere.model.X_AD_ImpFormat;
import org.compiere.model.X_AD_ImpFormat_Row;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ImpFormatElementHandler extends AbstractElementHandler {

	private ImpFormatRowElementHandler rowHandler = new ImpFormatRowElementHandler();

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		
		List<String> excludes = defaultExcludeList(X_AD_ImpFormat.Table_Name);

		X_AD_ImpFormat mImpFormat = findPO(ctx, element);
		if (mImpFormat == null) {
			mImpFormat = new X_AD_ImpFormat(ctx.ctx, 0, getTrxName(ctx));
		}
		PoFiller filler = new PoFiller(ctx, mImpFormat, element, this);
		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			element.unresolved = notfounds.toString();
			return;
		}
		
		if (mImpFormat.is_new() || mImpFormat.is_Changed()) {
			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_ImpFormat.Table_Name,
					X_AD_ImpFormat.Table_ID);
			String action = null;
			if (!mImpFormat.is_new()) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_ImpFormat.Table_Name, mImpFormat);
				action = "Update";
			} else {
				action = "New";
			}
			if (mImpFormat.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, mImpFormat.getName(), mImpFormat
						.get_ID(), action);
			} else {
				logImportDetail(ctx, impDetail, 0, mImpFormat.getName(), mImpFormat
						.get_ID(), action);
				throw new POSaveFailedException("Failed to save Import Format " + mImpFormat.getName());
			}
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	protected void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int import_id = Env.getContextAsInt(ctx.ctx,
				X_AD_Package_Exp_Detail.COLUMNNAME_AD_ImpFormat_ID);
		if (ctx.packOut.isExported(X_AD_Package_Exp_Detail.COLUMNNAME_AD_ImpFormat_ID+"|"+import_id))
			return;

		AttributesImpl atts = new AttributesImpl();
		X_AD_ImpFormat m_ImpFormat = new X_AD_ImpFormat(ctx.ctx, import_id, null);

		boolean createElement = true;
		if (ctx.packOut.getFromDate() != null) {
			if (m_ImpFormat.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				createElement = false;
			}
		}

		if (createElement) {
			verifyPackOutRequirement(m_ImpFormat);
			addTypeName(atts, "table");
			document.startElement("", "", I_AD_ImpFormat.Table_Name, atts);
			createImpFormatBinding(ctx, document, m_ImpFormat);
		}

		String sql = "SELECT * FROM AD_ImpFormat_Row WHERE AD_ImpFormat_ID= "
				+ import_id;

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createImpFormatRow(ctx, document, rs
						.getInt("AD_ImpFormat_Row_ID"));
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, "ImpFormat", e);
			throw new DatabaseAccessException("Failed to export Import Format.", e);
		} finally {
			DB.close(rs, pstmt);
		}
		
		if (createElement) {
			document.endElement("", "", I_AD_ImpFormat.Table_Name);
		}

	}

	private void createImpFormatRow(PIPOContext ctx,
			TransformerHandler document, int AD_ImpFormat_Row_ID)
			throws SAXException {
		Env.setContext(ctx.ctx, X_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID,
				AD_ImpFormat_Row_ID);
		rowHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID);
	}

	private void createImpFormatBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_ImpFormat m_ImpFormat) {
		PoExporter filler = new PoExporter(ctx, document, m_ImpFormat);
		List<String> excludes = defaultExcludeList(X_AD_ImpFormat.Table_Name);
		if (m_ImpFormat.getAD_ImpFormat_ID() <= PackOut.MAX_OFFICIAL_ID)
		{
			filler.add("AD_ImpFormat_ID", new AttributesImpl());
		}
		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_ImpFormat_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_ImpFormat_ID);
	}
}
