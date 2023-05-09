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
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Process;
import org.compiere.model.I_AD_Tab;
import org.compiere.model.I_AD_Window;
import org.compiere.model.MTab;
import org.compiere.model.X_AD_Field;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Tab;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class TabElementHandler extends AbstractElementHandler {

	private FieldElementHandler fieldHandler = new FieldElementHandler();

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_Tab.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			if (isParentDefer(element, I_AD_Window.Table_Name)) {
				element.defer = true;
				return;
			}

			MTab mTab = findPO(ctx, element);
			if (mTab == null) {
				mTab = new MTab(ctx.ctx, 0, getTrxName(ctx));
			}

			PoFiller filler = new PoFiller(ctx, mTab, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			element.recordId = mTab.get_ID();
			if (mTab.is_new() || mTab.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Tab.Table_Name,
						X_AD_Tab.Table_ID);
				String action = null;
				if (!mTab.is_new()){
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Tab.Table_Name,mTab);
					action = "Update";
				}
				else{
					action = "New";
				}
				if (mTab.save(getTrxName(ctx)) == true){
					logImportDetail (ctx, impDetail, 1, mTab.getName(), mTab.get_ID(),action);
					element.recordId = mTab.get_ID();
				} else {
					logImportDetail (ctx, impDetail, 0, mTab.getName(), mTab.get_ID(),action);
					throw new POSaveFailedException("Failed to save Tab " + mTab.getName());
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
		PackOut packOut = ctx.packOut;
		int AD_Tab_ID = Env.getContextAsInt(ctx.ctx, "AD_Tab_ID");
		if (ctx.packOut.isExported("AD_Tab_ID"+"|"+AD_Tab_ID))
			return;

		X_AD_Tab m_Tab = new X_AD_Tab (ctx.ctx, AD_Tab_ID, getTrxName(ctx));
		boolean createElement = isPackOutElement(ctx, m_Tab);
		if (createElement) {
			verifyPackOutRequirement(m_Tab);
			AttributesImpl atts = new AttributesImpl();
			addTypeName(atts, "table");
			document.startElement("","",I_AD_Tab.Table_Name,atts);
			createTabBinding(ctx,document,m_Tab);

			packOut.getCtx().ctx.put("Table_Name",X_AD_Tab.Table_Name);
			try {
				new CommonTranslationHandler().packOut(packOut,document,null,m_Tab.get_ID());
			} catch(Exception e) {
				if (log.isLoggable(Level.INFO)) log.info(e.toString());
			}
		}

		//Fields tags.
		String sql = "SELECT AD_Field_ID FROM AD_FIELD WHERE AD_TAB_ID = " + AD_Tab_ID
			+ " ORDER BY SEQNO asc";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement (sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				createField(ctx, document, rs.getInt("AD_Field_ID"));
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE,e.getLocalizedMessage(), e);
			throw new DatabaseAccessException("Failed to export window tab", e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}

		if (createElement) {
			document.endElement("","",X_AD_Tab.Table_Name);
		}

		if(m_Tab.getAD_Process_ID() > 0 )
		{
			try
			{
				ElementHandler handler = packOut.getHandler(I_AD_Process.Table_Name);
				handler.packOut(packOut,document,null,m_Tab.getAD_Process_ID());
			}
			catch(Exception e)
			{
				throw new AdempiereException(e);
			}
		}

	}

	private void createField(PIPOContext ctx, TransformerHandler document,
			int AD_Field_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Field.COLUMNNAME_AD_Field_ID, AD_Field_ID);
		fieldHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Field.COLUMNNAME_AD_Field_ID);
	}

	private void createTabBinding(PIPOContext ctx, TransformerHandler document, X_AD_Tab m_Tab)
	{
		PoExporter filler = new PoExporter(ctx, document, m_Tab);
		List<String> excludes = defaultExcludeList(X_AD_Tab.Table_Name);

		if (m_Tab.getAD_Tab_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_Tab_ID", new AttributesImpl());

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_Tab.COLUMNNAME_AD_Tab_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_Tab.COLUMNNAME_AD_Tab_ID);
	}
}
