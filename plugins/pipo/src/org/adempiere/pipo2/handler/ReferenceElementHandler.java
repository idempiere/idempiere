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
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Ref_List;
import org.compiere.model.X_AD_Ref_Table;
import org.compiere.model.X_AD_Reference;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ReferenceElementHandler extends AbstractElementHandler implements IPackOutHandler{

	private ReferenceListElementHandler listHandler = new ReferenceListElementHandler();
	private ReferenceTableElementHandler tableHandler = new ReferenceTableElementHandler();

	private List<Integer> references = new ArrayList<Integer>();

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		String Object_Status = null;

		String entitytype = getStringValue(element, "EntityType");
		String name = getStringValue(element, "Name");

		if (isProcessElement(ctx, entitytype)) {

			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Reference.Table_Name,
					X_AD_Reference.Table_ID);

			int id = findIdByName(ctx, "AD_Reference", name);

			X_AD_Reference m_Reference = new X_AD_Reference(ctx, id, getTrxName(ctx));
			List<String> excludes = defaultExcludeList(X_AD_Reference.Table_Name);
			if (id <= 0 && isOfficialId(element, "AD_Reference_ID"))
				m_Reference.setAD_Reference_ID(getIntValue(element, "AD_Reference_ID"));
			if (id > 0) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_ID(), X_AD_Reference.Table_Name, m_Reference);
				Object_Status = "Update";
				if (references.contains(id)) {
					element.skip = true;
					return;
				}
			} else {
				Object_Status = "New";
			}

			PoFiller filler = new PoFiller(ctx, m_Reference, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}
			if (m_Reference.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, m_Reference.getName(),
						m_Reference.get_ID(), Object_Status);
				references.add(m_Reference.getAD_Reference_ID());
				element.recordId = m_Reference.getAD_Reference_ID();
			} else {
				logImportDetail(ctx, impDetail, 0, m_Reference.getName(),
						m_Reference.get_ID(), Object_Status);
				throw new POSaveFailedException("Reference");
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		int Reference_id = Env.getContextAsInt(ctx,
				X_AD_Reference.COLUMNNAME_AD_Reference_ID);

		if (references.contains(Reference_id))
			return;

		references.add(Reference_id);
		AttributesImpl atts = new AttributesImpl();

		X_AD_Reference m_Reference = new X_AD_Reference(ctx, Reference_id, getTrxName(ctx));

		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.reference");
		document.startElement("", "", "reference", atts);
		createReferenceBinding(ctx, document, m_Reference);

		if (m_Reference.getValidationType().compareTo("L") == 0) {
			String sql1 = "SELECT AD_REF_LIST_ID FROM AD_Ref_List WHERE AD_Reference_ID= "
					+ Reference_id;

			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				pstmt = DB.prepareStatement(sql1, getTrxName(ctx));
				rs = pstmt.executeQuery();

				while (rs.next()) {
					createReferenceList(ctx, document, rs.getInt("AD_REF_LIST_ID"));
				}
			}
			catch (Exception e) {
				log.log(Level.SEVERE, e.getLocalizedMessage(), e);
				if (e instanceof SAXException)
					throw (SAXException) e;
				else if (e instanceof SQLException)
					throw new DatabaseAccessException("Failed to export Reference.", e);
				else if (e instanceof RuntimeException)
					throw (RuntimeException) e;
				else
					throw new RuntimeException("Failed to export Reference.", e);
			} finally {
				DB.close(rs, pstmt);
			}

		} else if (m_Reference.getValidationType().compareTo("T") == 0) {
			createReferenceTable(ctx, document, Reference_id);
		}
		document.endElement("", "", "reference");

	}

	private void createReferenceTable(Properties ctx, TransformerHandler document,
			int reference_id) throws SAXException {
		Env.setContext(ctx, X_AD_Ref_Table.COLUMNNAME_AD_Reference_ID, reference_id);
		tableHandler.create(ctx, document);
		ctx.remove(X_AD_Ref_Table.COLUMNNAME_AD_Reference_ID);
	}

	private void createReferenceList(Properties ctx,
			TransformerHandler document, int AD_Ref_List_ID)
			throws SAXException {
		Env.setContext(ctx, X_AD_Ref_List.COLUMNNAME_AD_Ref_List_ID,
				AD_Ref_List_ID);
		listHandler.create(ctx, document);
		ctx.remove(X_AD_Ref_List.COLUMNNAME_AD_Ref_List_ID);
	}

	private void createReferenceBinding(Properties ctx, TransformerHandler document,
			X_AD_Reference m_Reference) {
		List<String> excludes = defaultExcludeList(X_AD_Reference.Table_Name);
		PoExporter filler = new PoExporter(ctx, document, m_Reference);
		if (m_Reference.getAD_Reference_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_Reference_ID", new AttributesImpl());

		filler.export(excludes);
	}

	public void packOut(PackOut packout, MPackageExp header, MPackageExpDetail detail,TransformerHandler packOutDocument,TransformerHandler packageDocument,int recordId) throws Exception
	{
		if(recordId <= 0)
			recordId = detail.getAD_Reference_ID();

		Env.setContext(packout.getCtx(), X_AD_Package_Exp_Detail.COLUMNNAME_AD_Reference_ID, recordId);
		this.create(packout.getCtx(), packOutDocument);
		packout.getCtx().remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Reference_ID);
	}
}
