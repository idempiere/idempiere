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
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.IPackOutHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MPackageExp;
import org.compiere.model.MPackageExpDetail;
import org.compiere.model.X_AD_ImpFormat;
import org.compiere.model.X_AD_ImpFormat_Row;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ImpFormatElementHandler extends AbstractElementHandler  implements IPackOutHandler {

	private ImpFormatRowElementHandler rowHandler = new ImpFormatRowElementHandler();

	private List<Integer> formats = new ArrayList<Integer>();

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_ImpFormat.Table_Name,
				X_AD_ImpFormat.Table_ID);

		String action = null;
		List<String> excludes = defaultExcludeList(X_AD_ImpFormat.Table_Name);
		String name = getStringValue(element, "Name");

		int id = findIdByName(ctx, "AD_ImpFormat", name);
		X_AD_ImpFormat mImpFormat = new X_AD_ImpFormat(ctx, id,
				getTrxName(ctx));
		PoFiller filler = new PoFiller(ctx, mImpFormat, element, this);

		if (id <= 0 && isOfficialId(element, "AD_ImpFormat_ID"))
		{
			filler.setInteger("AD_ImpFormat_ID");
		}
		if (id > 0) {
			backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_ImpFormat.Table_Name, mImpFormat);
			action = "Update";
		} else {
			action = "New";
		}

		List<String> notfounds = filler.autoFill(excludes);
		if (notfounds.size() > 0) {
			element.defer = true;
			return;
		}
		if (mImpFormat.save(getTrxName(ctx)) == true) {
			logImportDetail(ctx, impDetail, 1, mImpFormat.getName(), mImpFormat
					.get_ID(), action);
		} else {
			logImportDetail(ctx, impDetail, 0, mImpFormat.getName(), mImpFormat
					.get_ID(), action);
			throw new POSaveFailedException("Failed to save Import Format.");
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	protected void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int import_id = Env.getContextAsInt(ctx,
				X_AD_Package_Exp_Detail.COLUMNNAME_AD_ImpFormat_ID);

		if (formats.contains(import_id))
			return;
		formats.add(import_id);
		AttributesImpl atts = new AttributesImpl();
		X_AD_ImpFormat m_ImpFormat = new X_AD_ImpFormat(ctx, import_id, null);
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.import-format");
		document.startElement("", "", "impformat", atts);
		createImpFormatBinding(ctx, document, m_ImpFormat);

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
		document.endElement("", "", "impformat");

	}

	private void createImpFormatRow(Properties ctx,
			TransformerHandler document, int AD_ImpFormat_Row_ID)
			throws SAXException {
		Env.setContext(ctx, X_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID,
				AD_ImpFormat_Row_ID);
		rowHandler.create(ctx, document);
		ctx.remove(X_AD_ImpFormat_Row.COLUMNNAME_AD_ImpFormat_Row_ID);
	}

	private void createImpFormatBinding(Properties ctx, TransformerHandler document,
			X_AD_ImpFormat m_ImpFormat) {
		PoExporter filler = new PoExporter(ctx, document, m_ImpFormat);
		List<String> excludes = defaultExcludeList(X_AD_ImpFormat.Table_Name);
		if (m_ImpFormat.getAD_ImpFormat_ID() <= PackOut.MAX_OFFICIAL_ID)
		{
			filler.add("AD_ImpFormat_ID", new AttributesImpl());
		}
		filler.export(excludes);
	}

	public void packOut(PackOut packout, MPackageExp header, MPackageExpDetail detail,TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception
	{
		if(recordId <= 0)
			recordId = detail.getAD_ImpFormat_ID();

		Env.setContext(packout.getCtx(), X_AD_Package_Exp_Detail.COLUMNNAME_AD_ImpFormat_ID, recordId);
		this.create(packout.getCtx(), packOutDocument);
		packout.getCtx().remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_ImpFormat_ID);
	}
}
