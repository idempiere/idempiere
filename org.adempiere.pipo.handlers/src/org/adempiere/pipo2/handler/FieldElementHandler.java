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
import java.util.Properties;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.ElementHandler;
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
import org.compiere.model.I_AD_Val_Rule;
import org.compiere.model.MField;
import org.compiere.model.X_AD_Field;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class FieldElementHandler extends AbstractElementHandler {

	public void startElement(Properties ctx, Element element)
			throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx, entitytype)) {
			if (isParentDefer(element, I_AD_Tab.Table_Name)) {
				element.defer = true;
				return;
			}
			
			List<String>excludes = defaultExcludeList(X_AD_Field.Table_Name);

			int tabid = getParentId(element, I_AD_Tab.Table_Name) ;
			if (tabid <= 0) {
				element.defer = true;
				return;
			}

			MField mField = findPO(ctx, element);
			if (mField == null)
			{
				int AD_Table_ID = ReferenceUtils.resolveReference(ctx, element.parent.properties.get("AD_Table_ID"));
				Element columnElement = element.parent.properties.get("AD_Column_ID");
				int AD_Column_ID = 0;
				if (ReferenceUtils.isIDLookup(columnElement) || ReferenceUtils.isUUIDLookup(columnElement))
				{
					AD_Column_ID = ReferenceUtils.resolveReference(ctx, columnElement);
				}
				else
				{
					String colname = getStringValue(element, "AD_Column_ID", excludes);
					AD_Column_ID = findIdByColumnAndParentId(ctx, "AD_Column", "ColumnName", colname, "AD_Table", AD_Table_ID);
				}
				 
				
				StringBuffer sqlB = new StringBuffer(
						"select AD_Field_ID from AD_Field where AD_Column_ID = ")
						.append(AD_Column_ID)
						.append(" and AD_Tab_ID = ?");
				int id = DB.getSQLValue(getTrxName(ctx), sqlB.toString(), tabid);
				mField = new MField(ctx, id > 0 ? id : 0, getTrxName(ctx));
				if (mField.is_new()) {
					mField.setAD_Column_ID(AD_Column_ID);
					mField.setAD_Tab_ID(tabid);
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
					throw new POSaveFailedException("Failed to save field definition.");
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
		int AD_Field_ID = Env.getContextAsInt(ctx,
				X_AD_Field.COLUMNNAME_AD_Field_ID);
		X_AD_Field m_Field = new X_AD_Field(ctx, AD_Field_ID, null);
		AttributesImpl atts = new AttributesImpl();
		addTypeName(atts, "table");
		document.startElement("", "", I_AD_Field.Table_Name, atts);
		createFieldBinding(ctx, document, m_Field);

		PackOut packOut = (PackOut)ctx.get("PackOutProcess");

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

			if (m_Field.getAD_Reference_Value_ID()>0)
			{
				ElementHandler handler = packOut.getHandler(I_AD_Reference.Table_Name);
				handler.packOut(packOut,document,null,m_Field.getAD_Reference_Value_ID());
			}

			if (m_Field.getAD_Val_Rule_ID()>0)
			{
				ElementHandler handler = packOut.getHandler(I_AD_Val_Rule.Table_Name);
				handler.packOut(packOut,document,null,m_Field.getAD_Val_Rule_ID());
			}
		}
		catch(Exception e)
		{
			log.info(e.toString());
		}

		document.endElement("", "", I_AD_Field.Table_Name);
	}

	private void createFieldBinding(Properties ctx, TransformerHandler document,
			X_AD_Field m_Field) {

		List<String> excludes = defaultExcludeList(X_AD_Field.Table_Name);
		PoExporter filler = new PoExporter(ctx, document, m_Field);
		if (m_Field.getAD_Field_ID() <= PackOut.MAX_OFFICIAL_ID) {
			filler.add("AD_Field_ID", new AttributesImpl());
		}

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx(), I_AD_Field.COLUMNNAME_AD_Field_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().remove(I_AD_Field.COLUMNNAME_AD_Field_ID);
	}
}
