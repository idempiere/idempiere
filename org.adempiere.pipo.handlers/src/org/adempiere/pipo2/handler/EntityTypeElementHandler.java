/******************************************************************************
 * Copyright (C) 2013 Jan Thielemann - jan.thielemann@evenos-consulting.de    *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
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
import org.compiere.model.X_AD_EntityType;
import org.compiere.model.X_AD_Modification;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

/**
 * @author Jan Thielemann - jan.thielemann@evenos-consulting.de
 * @author evenos Consulting GmbH - www.evenos.org
 */

public class EntityTypeElementHandler extends AbstractElementHandler{

	private ModificationElementHandler modificationHandler = new ModificationElementHandler();
	
	private List<Integer> entityTypes = new ArrayList<Integer>();
	
	@Override
	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		List<String> excludes = defaultExcludeList(X_AD_EntityType.Table_Name);
		
		String entitytype = getStringValue(element, "EntityType");
		String name = getStringValue(element, "Name");
		String action = null;
		if (isProcessElement(ctx.ctx, entitytype)) {
			X_AD_EntityType m_EntityType = findPO(ctx, element);
			
			if (m_EntityType == null) {
				int id = findIdByColumn(ctx, X_AD_EntityType.Table_Name, X_AD_EntityType.COLUMNNAME_Name, name, /*ignorecase=*/true);
				m_EntityType = new X_AD_EntityType(ctx.ctx, id, getTrxName(ctx));
			}
			
			if (m_EntityType.getAD_EntityType_ID() == 0 && isOfficialId(element, "AD_EntityType_ID"))
				m_EntityType.setAD_EntityType_ID(getIntValue(element, "AD_EntityType_ID"));
			
			if (entityTypes.contains(m_EntityType.getAD_EntityType_ID())) {
				element.skip = true;
				return;
			}

			PoFiller pf = new PoFiller(ctx, m_EntityType, element, this);
			List<String> notfounds = pf.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			
			if (m_EntityType.is_new() || m_EntityType.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_EntityType.Table_Name, X_AD_EntityType.Table_ID);
				if (!m_EntityType.is_new()) {				
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_EntityType.Table_Name, m_EntityType);
					action = "Update";
				} else {
					action = "New";
				}
	
				if (m_EntityType.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, m_EntityType.getName(),
							m_EntityType.get_ID(), action);
	
					element.recordId = m_EntityType.getAD_EntityType_ID();
	
					entityTypes.add(m_EntityType.getAD_EntityType_ID());
	
				} else {
					logImportDetail(ctx, impDetail, 0, m_EntityType.getName(),
							m_EntityType.get_ID(), action);
					throw new POSaveFailedException("Failed to save Model Validator " + m_EntityType.getName());
				}
			}
			
		}else {
			element.skip = true;
		}
	}

	@Override
	public void endElement(PIPOContext ctx, Element element)
			throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		int AD_ElementType_ID = Env.getContextAsInt(ctx.ctx, X_AD_EntityType.COLUMNNAME_AD_EntityType_ID);
		
		if(entityTypes.contains(AD_ElementType_ID))
			return;
		entityTypes.add(AD_ElementType_ID);
		
		
		PackOut packOut = ctx.packOut;
		
		boolean createElement = true;
		X_AD_EntityType m_EntityType = new X_AD_EntityType(ctx.ctx, AD_ElementType_ID, null);
		if(ctx.packOut.getFromDate() != null){
			if(m_EntityType.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0){
				createElement = false;
			}
		}
		
		if(createElement){
			AttributesImpl atts = new AttributesImpl();
			addTypeName(atts, "table");
			document.startElement("", "", X_AD_EntityType.Table_Name, atts);
			createEntityTypeBinding(ctx, document, m_EntityType);
		}
		
		String sql = "SELECT AD_Modification_ID FROM AD_Modification WHERE entitytype = ?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, getTrxName(ctx));
			pstmt.setString(1, m_EntityType.getEntityType());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ElementHandler handler = packOut.getHandler("AD_Modification");
				handler.packOut(packOut,document,null,rs.getInt("AD_Modification_ID"));

				createModificaiton(ctx, document, rs.getInt("AD_Modification_ID"));
			}
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			if (e instanceof SAXException)
				throw (SAXException) e;
			else if (e instanceof SQLException)
				throw new DatabaseAccessException("Failed to export EntityType.", e);
			else if (e instanceof RuntimeException)
				throw (RuntimeException) e;
			else
				throw new RuntimeException("Failed to export EntityType.", e);
		} finally {
			DB.close(rs, pstmt);
		}
		
		
		if (createElement) {
			document.endElement("", "", X_AD_EntityType.Table_Name);
		}
	}
	
	private void createModificaiton(PIPOContext ctx, TransformerHandler document,
			int AD_Modification_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Modification.COLUMNNAME_AD_Modification_ID, AD_Modification_ID);
		modificationHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Modification.COLUMNNAME_AD_Modification_ID);
	}
	
	private void createEntityTypeBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_EntityType m_EntityType) {
		PoExporter filler = new PoExporter(ctx, document, m_EntityType);
		List<String> excludes = defaultExcludeList(X_AD_EntityType.Table_Name);

		if (m_EntityType.getAD_EntityType_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add(X_AD_EntityType.COLUMNNAME_AD_EntityType_ID, new AttributesImpl());

		filler.export(excludes);
	}
	
	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler, int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, X_AD_EntityType.COLUMNNAME_AD_EntityType_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_EntityType.COLUMNNAME_AD_EntityType_ID);
	}

}
