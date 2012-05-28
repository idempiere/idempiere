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

import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.ReferenceUtils;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Field;
import org.compiere.model.I_AD_FieldGroup;
import org.compiere.model.I_AD_Reference;
import org.compiere.model.I_AD_Tab;
import org.compiere.model.MField;
import org.compiere.model.X_AD_Field;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class FieldElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			if (isParentDefer(element, I_AD_Tab.Table_Name)) {
				element.defer = true;
				return;
			}

			List<String>excludes = defaultExcludeList(X_AD_Field.Table_Name);
			excludes.add("AD_Window_ID");
			excludes.add("AD_Tab_ID");

			int tabid = getParentId(element, I_AD_Tab.Table_Name) ;
			if (tabid <= 0) {
				Element tabElement = element.properties.get("AD_Tab_ID");
				if (ReferenceUtils.isIDLookup(tabElement) || ReferenceUtils.isUUIDLookup(tabElement)) {
					tabid = ReferenceUtils.resolveReference(ctx.ctx, tabElement, getTrxName(ctx));
				} else {
					String tabName = getStringValue(element, "AD_Tab_ID");
					int AD_Window_ID = ReferenceUtils.resolveReference(ctx.ctx, element.properties.get("AD_Window_ID"), getTrxName(ctx));
					if (AD_Window_ID > 0) {
						tabid = findIdByNameAndParentId(ctx, "AD_Tab", tabName, "AD_Window", AD_Window_ID);
					}
				}
			}
			if (tabid <= 0) {
				element.defer = true;
				element.unresolved = "AD_Tab_ID";
				return;
			}

			excludes.add("AD_Table_ID");
			excludes.add("AD_Column_ID");

			int AD_Table_ID = ReferenceUtils.resolveReference(ctx.ctx, element.properties.get("AD_Table_ID"), getTrxName(ctx));
				Element columnElement = element.properties.get("AD_Column_ID");
				int AD_Column_ID = 0;
				if (ReferenceUtils.isIDLookup(columnElement) || ReferenceUtils.isUUIDLookup(columnElement))
				{
				AD_Column_ID = ReferenceUtils.resolveReference(ctx.ctx, columnElement, getTrxName(ctx));
				}
				else
				{
					String colname = getStringValue(element, "AD_Column_ID", excludes);
					AD_Column_ID = findIdByColumnAndParentId(ctx, "AD_Column", "ColumnName", colname, "AD_Table", AD_Table_ID);
				}

				if (AD_Column_ID == 0) {
					element.defer = true;
				element.unresolved = "AD_Column_ID";
					return;
				}

			MField mField = findPO(ctx, element);
			if (mField == null)
			{
				StringBuffer sqlB = new StringBuffer(
						"select AD_Field_ID from AD_Field where AD_Column_ID = ")
						.append(AD_Column_ID)
						.append(" and AD_Tab_ID = ?");
				int id = DB.getSQLValue(getTrxName(ctx), sqlB.toString(), tabid);
				mField = new MField(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
				if (mField.is_new()) {
					mField.setAD_Column_ID(AD_Column_ID);
					mField.setAD_Tab_ID(tabid);
				}
			} else {
				if (mField.getAD_Tab_ID() != tabid) {
					mField.setAD_Tab_ID(tabid);
			}
				if (mField.getAD_Column_ID() != AD_Column_ID) {
					mField.setAD_Column_ID(AD_Column_ID);
				}
			}
			
			PoFiller filler = new PoFiller(ctx, mField, element, this);
			if (mField.getAD_Field_ID() == 0 && isOfficialId(element, "AD_Field_ID"))
			{
				filler.setInteger("AD_Field_ID");
			}

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			if (mField.is_new() || mField.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Field.Table_Name,
						X_AD_Field.Table_ID);
				String action = null;
				if (!mField.is_new()){
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), I_AD_Field.Table_Name, mField);
					action = "Update";
				}
				else{
					action = "New";
				}

				if (mField.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mField.getName(), mField
							.get_ID(), action);
					element.recordId = mField.getAD_Field_ID();
				} else {
					logImportDetail(ctx, impDetail, 0, mField.getName(), mField
							.get_ID(), action);
					throw new POSaveFailedException("Failed to save field definition " + mField.getName());
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
		int AD_Field_ID = Env.getContextAsInt(ctx.ctx,
				X_AD_Field.COLUMNNAME_AD_Field_ID);
		X_AD_Field m_Field = new X_AD_Field(ctx.ctx, AD_Field_ID, null);

		PackOut packOut = ctx.packOut;

		try
		{
			if(m_Field.getAD_FieldGroup_ID() > 0)
			{
				ElementHandler handler = packOut.getHandler(I_AD_FieldGroup.Table_Name);
				handler.packOut(packOut,document,null,m_Field.getAD_FieldGroup_ID());
			}

			if (m_Field.getAD_Reference_ID()>0)
			{
				ElementHandler handler = packOut.getHandler(I_AD_Reference.Table_Name);
				handler.packOut(packOut,document,null,m_Field.getAD_Reference_ID());
			}
		}
		catch(Exception e)
			{
			throw new SAXException(e);
			}

		if (ctx.packOut.getFromDate() != null) {
			if (m_Field.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", X_AD_Field.Table_Name, atts);
		createFieldBinding(ctx, document, m_Field);
		document.endElement("", "", X_AD_Field.Table_Name);
	}

	private void createFieldBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_Field m_Field) {

		List<String> excludes = defaultExcludeList(X_AD_Field.Table_Name);
		PoExporter filler = new PoExporter(ctx, document, m_Field);
		if (m_Field.getAD_Field_ID() <= PackOut.MAX_OFFICIAL_ID) {
			filler.add("AD_Field_ID", new AttributesImpl());
		}

		int AD_Table_ID = DB.getSQLValue(getTrxName(ctx), "SELECT AD_Table_ID FROM AD_Column WHERE AD_Column_ID=?", m_Field.getAD_Column_ID());
		if (AD_Table_ID > 0) {
			AttributesImpl atts = new AttributesImpl();
			filler.addTableReference("AD_Table_ID", "AD_Table", "TableName", AD_Table_ID, atts);
		}

		excludes.add("AD_Tab_ID");
		AttributesImpl atts = new AttributesImpl();
		filler.addTableReference("AD_Tab_ID", "AD_Tab", "Name", m_Field.getAD_Tab_ID(), atts);		
		if (atts.getValue("reference").equals("table")) {
			int AD_Window_ID = DB.getSQLValue(getTrxName(ctx), "SELECT AD_Window_ID FROM AD_Tab WHERE AD_Tab_ID=?", m_Field.getAD_Tab_ID());
			filler.addTableReference("AD_Window_ID", "AD_Window", "Name", AD_Window_ID, new AttributesImpl());
		}
		
		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_Field.COLUMNNAME_AD_Field_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_Field.COLUMNNAME_AD_Field_ID);
	}
}
