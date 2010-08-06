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
import java.util.Properties;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.adempiere.pipo2.exception.POSaveFailedException;
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

	public void startElement(Properties ctx, Element element) throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_Tab.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx, entitytype)) {
			if (isParentDefer(element, I_AD_Window.Table_Name)) {
				element.defer = true;
				return;
			}
			
			MTab mTab = findPO(ctx, element);
			if (mTab == null) {
				String name = getStringValue(element, "Name", excludes);
	
				int windowId = 0;
				if (getParentId(element, I_AD_Window.Table_Name) > 0) {
					windowId = getParentId(element, I_AD_Window.Table_Name);
				} else {
					Element windowElement = element.properties.get(I_AD_Tab.COLUMNNAME_AD_Window_ID);
					windowId = ReferenceUtils.resolveReference(ctx, windowElement);
				}
				if (windowId <= 0) {
					element.defer = true;
					return;
				}
	
				Element tableElement = element.properties.get(I_AD_Tab.COLUMNNAME_AD_Table_ID);
				int tableId = ReferenceUtils.resolveReference(ctx, tableElement);
				if (tableId <= 0) {
					element.defer = true;
					return;
				}
	
				String sql = "SELECT AD_Tab_ID FROM AD_Tab where AD_Window_ID = ? "
						+ " AND Name = ?"
						+ " AND AD_Table_ID = ?";
	
				int id = DB.getSQLValue(getTrxName(ctx), sql, windowId, name, tableId);
				mTab = new MTab(ctx, id > 0 ? id : 0, getTrxName(ctx));
				mTab.setAD_Table_ID(tableId);
				mTab.setName(name);
				mTab.setAD_Window_ID(windowId);
			}
						
			PoFiller filler = new PoFiller(ctx, mTab, element, this);
			if (mTab.getAD_Tab_ID() == 0 && isOfficialId(element, "AD_Tab_ID"))
				mTab.setAD_Tab_ID(getIntValue(element, "AD_Tab_ID"));
			
			Element columnElement = element.properties.get(I_AD_Tab.COLUMNNAME_AD_Column_ID);
			int AD_Column_ID = 0;
			if (ReferenceUtils.isIDLookup(columnElement) || ReferenceUtils.isUUIDLookup(columnElement)) {
				AD_Column_ID = ReferenceUtils.resolveReference(ctx, columnElement);
			} else if (columnElement.contents != null && columnElement.contents.length() > 0){
				AD_Column_ID = findIdByColumnAndParentId (ctx, "AD_Column","ColumnName", columnElement.contents.toString(), 
						"AD_Table", mTab.getAD_Table_ID());				
			}
			mTab.setAD_Column_ID(AD_Column_ID);

			columnElement = element.properties.get(I_AD_Tab.COLUMNNAME_AD_ColumnSortOrder_ID);
			AD_Column_ID = 0;
			if (ReferenceUtils.isIDLookup(columnElement) || ReferenceUtils.isUUIDLookup(columnElement)) {
				AD_Column_ID = ReferenceUtils.resolveReference(ctx, columnElement);
			} else if (columnElement.contents != null && columnElement.contents.length() > 0){
				AD_Column_ID = findIdByColumnAndParentId (ctx, "AD_Column","ColumnName", columnElement.contents.toString(), 
						"AD_Table", mTab.getAD_Table_ID());
			}
			mTab.setAD_ColumnSortOrder_ID(AD_Column_ID);
			
			columnElement = element.properties.get(I_AD_Tab.COLUMNNAME_AD_ColumnSortYesNo_ID);
			AD_Column_ID = 0;
			if (ReferenceUtils.isIDLookup(columnElement) || ReferenceUtils.isUUIDLookup(columnElement)) {
				AD_Column_ID = ReferenceUtils.resolveReference(ctx, columnElement);
			} else if (columnElement.contents != null && columnElement.contents.length() > 0){
				AD_Column_ID = findIdByColumnAndParentId (ctx, "AD_Column","ColumnName", columnElement.contents.toString(), 
						"AD_Table", mTab.getAD_Table_ID());
			}
			mTab.setAD_ColumnSortYesNo_ID(AD_Column_ID);

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
			}
			
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
					element.recordId = mTab.getAD_Tab_ID();
				} else {
					logImportDetail (ctx, impDetail, 0, mTab.getName(), mTab.get_ID(),action);
					throw new POSaveFailedException("Tab");
				}
			}
		} else {
			element.skip = true;
		}

	}

	public void endElement(Properties ctx, Element element) throws SAXException {
	}

	public void create(Properties ctx, TransformerHandler document)
			throws SAXException {
		PackOut packOut = getPackOutProcess(ctx);
		int AD_Tab_ID = Env.getContextAsInt(ctx, X_AD_Tab.COLUMNNAME_AD_Tab_ID);
		X_AD_Tab m_Tab = new X_AD_Tab (ctx, AD_Tab_ID, getTrxName(ctx));
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("","",I_AD_Tab.Table_Name,atts);
		createTabBinding(ctx,document,m_Tab);
		//Fields tags.
		String sql = "SELECT AD_Field_ID FROM AD_FIELD WHERE AD_TAB_ID = " + AD_Tab_ID
			+ "ORDER BY SEQNO asc";
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
		catch (Exception e)
		{
			log.log(Level.SEVERE,e.getLocalizedMessage(), e);
			throw new DatabaseAccessException("Failed to export window tab", e);
		}
		finally
		{
			DB.close(rs, pstmt);
		}
		document.endElement("","",I_AD_Tab.Table_Name);

		if(m_Tab.getAD_Process_ID() > 0 )
		{
			try
			{
				ElementHandler handler = packOut.getHandler("P");
				handler.packOut(packOut,document,null,m_Tab.getAD_Process_ID());
			}
			catch(Exception e)
			{
				throw new AdempiereException(e);
			}
		}

	}

	private void createField(Properties ctx, TransformerHandler document,
			int AD_Field_ID) throws SAXException {
		Env.setContext(ctx, X_AD_Field.COLUMNNAME_AD_Field_ID, AD_Field_ID);
		fieldHandler.create(ctx, document);
		ctx.remove(X_AD_Field.COLUMNNAME_AD_Field_ID);
	}

	private void createTabBinding(Properties ctx, TransformerHandler document, X_AD_Tab m_Tab)
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
		// TODO Auto-generated method stub
		
	}
}
