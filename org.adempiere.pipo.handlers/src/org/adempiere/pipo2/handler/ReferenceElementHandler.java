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
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Reference;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Ref_List;
import org.compiere.model.X_AD_Ref_Table;
import org.compiere.model.X_AD_Reference;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ReferenceElementHandler extends AbstractElementHandler {

	private ReferenceListElementHandler listHandler = new ReferenceListElementHandler();
	private ReferenceTableElementHandler tableHandler = new ReferenceTableElementHandler();

	private List<Integer> references = new ArrayList<Integer>();

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		String name = getStringValue(element, "Name");

		if (isProcessElement(ctx.ctx, entitytype)) {

			X_AD_Reference mReference = findPO(ctx, element);
			if (mReference == null) {
				int id = 0;
				if (!hasUUIDKey(ctx, element)) {
					id = findIdByName(ctx, "AD_Reference", name);
				}
				mReference = new X_AD_Reference(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
			}
			List<String> excludes = defaultExcludeList(X_AD_Reference.Table_Name);
			if (mReference.getAD_Reference_ID() == 0 && isOfficialId(element, "AD_Reference_ID"))
				mReference.setAD_Reference_ID(getIntValue(element, "AD_Reference_ID"));
			
			PoFiller filler = new PoFiller(ctx, mReference, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			element.recordId = mReference.getAD_Reference_ID();
			if (mReference.is_new() || mReference.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Reference.Table_Name,
						X_AD_Reference.Table_ID);
				String action = null;
				if (!mReference.is_new()) {
					if (references.contains(mReference.getAD_Reference_ID())) {
						element.skip = true;
						return;
					}
					backupRecord(ctx, impDetail.getAD_Package_Imp_ID(), X_AD_Reference.Table_Name, mReference);
					action = "Update";				
				} else {
					action = "New";
				}
				if (mReference.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mReference.getName(),
							mReference.get_ID(), action);
					references.add(mReference.getAD_Reference_ID());
				} else {
					logImportDetail(ctx, impDetail, 0, mReference.getName(),
							mReference.get_ID(), action);
					throw new POSaveFailedException("Failed to save Reference " + mReference.getName());
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
		int Reference_id = Env.getContextAsInt(ctx.ctx,
				X_AD_Reference.COLUMNNAME_AD_Reference_ID);

		if (references.contains(Reference_id))
			return;

		references.add(Reference_id);
		AttributesImpl atts = new AttributesImpl();

		X_AD_Reference m_Reference = new X_AD_Reference(ctx.ctx, Reference_id, getTrxName(ctx));

		boolean createElement = true;
		if (ctx.packOut.getFromDate() != null) {
			if (m_Reference.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				createElement = false;
			}
		}
		PackOut packOut = ctx.packOut;
		packOut.getCtx().ctx.put("Table_Name",X_AD_Reference.Table_Name);
		if (createElement) {
			addTypeName(atts, "table");
			document.startElement("", "", I_AD_Reference.Table_Name, atts);
			createReferenceBinding(ctx, document, m_Reference);
			try {
				new CommonTranslationHandler().packOut(packOut,document,null,m_Reference.get_ID());
			} catch(Exception e) {
				if (log.isLoggable(Level.INFO)) log.info(e.toString());
			}
		}

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

		if (createElement) {
			document.endElement("", "", X_AD_Reference.Table_Name);
		}
	}

	private void createReferenceTable(PIPOContext ctx, TransformerHandler document,
			int reference_id) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Ref_Table.COLUMNNAME_AD_Reference_ID, reference_id);
		tableHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Ref_Table.COLUMNNAME_AD_Reference_ID);
	}

	private void createReferenceList(PIPOContext ctx,
			TransformerHandler document, int AD_Ref_List_ID)
			throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Ref_List.COLUMNNAME_AD_Ref_List_ID,
				AD_Ref_List_ID);
		listHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Ref_List.COLUMNNAME_AD_Ref_List_ID);
	}

	private void createReferenceBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_Reference m_Reference) {
		List<String> excludes = defaultExcludeList(X_AD_Reference.Table_Name);
		PoExporter filler = new PoExporter(ctx, document, m_Reference);
		if (m_Reference.getAD_Reference_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_Reference_ID", new AttributesImpl());

		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Reference_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Reference_ID);
	}
}
