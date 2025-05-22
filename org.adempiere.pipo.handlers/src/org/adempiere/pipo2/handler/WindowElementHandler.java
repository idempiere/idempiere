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
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Color;
import org.compiere.model.I_AD_Image;
import org.compiere.model.I_AD_TableAttribute;
import org.compiere.model.I_AD_Window;
import org.compiere.model.MWindow;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Preference;
import org.compiere.model.X_AD_Tab;
import org.compiere.model.X_AD_Window;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class WindowElementHandler extends AbstractElementHandler {

	private TabElementHandler tabHandler = new TabElementHandler();
	private PreferenceElementHandler preferenceHandler = new PreferenceElementHandler();

	private List<Integer> windows = new ArrayList<Integer>();

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_Window.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			MWindow mWindow = findPO(ctx, element);
			if (mWindow == null) {
				mWindow = new MWindow(ctx.ctx, 0, getTrxName(ctx));
			} else {
				if (windows.contains(mWindow.getAD_Window_ID())) {
					return;
				}
			}
						
			PoFiller filler = new PoFiller(ctx, mWindow, element, this);
			
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			element.recordId = mWindow.get_ID();
			if (mWindow.is_new() || mWindow.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Window.Table_Name,
						X_AD_Window.Table_ID);
				String action = null;
				if (!mWindow.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Window.Table_Name, mWindow);
					action = "Update";
				} else {
					action = "New";
				}
				if (mWindow.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mWindow.getName(), mWindow
							.get_ID(), action);
					windows.add(mWindow.getAD_Window_ID());
					element.recordId = mWindow.get_ID();
					element.requireRoleAccessUpdate = true;
				} else {
					logImportDetail(ctx, impDetail, 0, mWindow.getName(), mWindow
							.get_ID(), action);
					throw new POSaveFailedException("Failed to save Window " + mWindow.getName());
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
		int AD_Window_ID = Env.getContextAsInt(ctx.ctx, "AD_Window_ID");
		if (ctx.packOut.isExported("AD_Window_ID"+"|"+AD_Window_ID))
			return;
		PackOut packOut = ctx.packOut;

		X_AD_Window m_Window = new X_AD_Window(ctx.ctx, AD_Window_ID, null);
		boolean createElement = isPackOutElement(ctx, m_Window);

		//export color
		if (m_Window.getAD_Color_ID() > 0) {
			ElementHandler handler = ctx.packOut.getHandler(I_AD_Color.Table_Name);
			if (handler == null) {
				handler = new GenericPOElementHandler(I_AD_Color.Table_Name);
			}
			try {
				handler.packOut(ctx.packOut, document, null, m_Window.getAD_Color_ID());
			} catch (Exception e) {
				throw new SAXException(e);
			}
		}

		//export image
		if (m_Window.getAD_Image_ID() > 0) {
			ElementHandler handler = ctx.packOut.getHandler(I_AD_Image.Table_Name);
			if (handler == null) {
				handler = new GenericPOElementHandler(I_AD_Image.Table_Name);
			}
			try {
				handler.packOut(ctx.packOut, document, null, m_Window.getAD_Image_ID());
			} catch (Exception e) {
				throw new SAXException(e);
			}
		}

		if (createElement) {
			verifyPackOutRequirement(m_Window);
			AttributesImpl atts = new AttributesImpl();
			addTypeName(atts, "table");
			document.startElement("", "", I_AD_Window.Table_Name, atts);
			createWindowBinding(ctx, document, m_Window);
			packOut.getCtx().ctx.put("Table_Name",X_AD_Window.Table_Name);
			try {
				new CommonTranslationHandler().packOut(packOut,document,null,m_Window.get_ID());
			} catch(Exception e) {
				if (log.isLoggable(Level.INFO)) log.info(e.toString());
			}
		}
		
		packOut.getCtx().ctx.put("Table_Name", X_AD_Window.Table_Name);
		try
		{
			ElementHandler handler = packOut.getHandler(I_AD_TableAttribute.Table_Name);
			handler.packOut(packOut, document, null, m_Window.get_ID());
		}
		catch (Exception e)
		{
			if (log.isLoggable(Level.INFO))
				log.info(e.toString());
		}
		
		// Tab Tag
		String sql = "SELECT AD_Tab_ID, AD_Table_ID FROM AD_TAB WHERE AD_WINDOW_ID = "
				+ AD_Window_ID;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ElementHandler handler = packOut.getHandler("AD_Table");
				handler.packOut(packOut,document,null,rs.getInt("AD_Table_ID"));

				createTab(ctx, document, rs.getInt("AD_Tab_ID"));
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			if (e instanceof SAXException)
				throw (SAXException) e;
			else if (e instanceof SQLException)
				throw new DatabaseAccessException("Failed to export window.", e);
			else if (e instanceof RuntimeException)
				throw (RuntimeException) e;
			else
				throw new RuntimeException("Failed to export window.", e);
		} finally {
			DB.close(rs, pstmt);
		}

		if (createElement) {
			document.endElement("", "", X_AD_Window.Table_Name);
		}

		// Preference Tag
		sql = "SELECT AD_Preference_ID FROM AD_PREFERENCE WHERE AD_WINDOW_ID = ? AND AD_CLIENT_ID = ?";
		pstmt = null;
		rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			pstmt.setInt(1, AD_Window_ID);
			pstmt.setInt(2, Env.getAD_Client_ID(ctx.ctx));
			rs = pstmt.executeQuery();
			while (rs.next()) {
				createPreference(ctx, document, rs.getInt("AD_Preference_ID"));
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			if (e instanceof SAXException)
				throw (SAXException) e;
			else if (e instanceof SQLException)
				throw new DatabaseAccessException("Failed to export window preference.", e);
			else if (e instanceof RuntimeException)
				throw (RuntimeException) e;
			else
				throw new RuntimeException("Failed to export window preference.", e);
		} finally {
			DB.close(rs, pstmt);
		}
	}

	private void createPreference(PIPOContext ctx, TransformerHandler document,
			int AD_Preference_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Preference.COLUMNNAME_AD_Preference_ID,
				AD_Preference_ID);
		preferenceHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Preference.COLUMNNAME_AD_Preference_ID);
	}

	private void createTab(PIPOContext ctx, TransformerHandler document,
			int AD_Tab_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Tab.COLUMNNAME_AD_Tab_ID, AD_Tab_ID);
		tabHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Tab.COLUMNNAME_AD_Tab_ID);
	}

	private void createWindowBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_Window m_Window) {
		PoExporter filler = new PoExporter(ctx, document, m_Window);
		List<String> excludes = defaultExcludeList(X_AD_Window.Table_Name);

		if (m_Window.getAD_Window_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_Window_ID", new AttributesImpl());

		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Window_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Window_ID);
	}
}
