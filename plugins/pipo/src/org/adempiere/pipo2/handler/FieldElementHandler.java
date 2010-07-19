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
import org.adempiere.pipo2.IPackOutHandler;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PackIn;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.POSaveFailedException;
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
		PackIn packIn = getPackInProcess(ctx);
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx, entitytype)) {
			if (isParentDefer(element, "tab")) {
				element.defer = true;
				return;
			}

			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Field.Table_Name,
					X_AD_Field.Table_ID);
			List<String>excludes = defaultExcludeList(X_AD_Field.Table_Name);

			int tabid = getParentId(element, "tab") ;
			if (tabid <= 0) {
				element.defer = true;
				return;
			}

			String tableName = element.parent.properties.get("AD_Table_ID").contents.toString();
			String colname = getStringValue(element, "AD_Column_ID", excludes);
			int columnid = packIn.getColumnId(tableName, colname);
			if (columnid <= 0) {
				int tableid = DB.getSQLValue(getTrxName(ctx), "SELECT AD_Table_ID FROM AD_Tab WHERE AD_Tab_ID = ?", tabid);
				columnid = findIdByColumnAndParentId(ctx, "AD_Column",
					"ColumnName", colname, "AD_Table", tableid);
				if (columnid > 0)
					packIn.addColumn(tableName, colname, columnid);
			}
			if (columnid <= 0) {
				element.defer = true;
				return;
			}

			StringBuffer sqlB = new StringBuffer(
					"select AD_Field_ID from AD_Field where AD_Column_ID = ")
					.append(columnid)
					.append(" and AD_Tab_ID = ?");
			int id = DB.getSQLValue(getTrxName(ctx), sqlB.toString(), tabid);
			MField mField = new MField(ctx, id, getTrxName(ctx));
			PoFiller filler = new PoFiller(ctx, mField, element, this);
			if (id <= 0 && isOfficialId(element, "AD_Field_ID"))
			{
				filler.setInteger("AD_Field_ID");
			}

			String action = null;
			if (id > 0) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), X_AD_Field.Table_Name, mField);
				action = "Update";
			} else {
				action = "New";
			}

			mField.setAD_Column_ID(columnid);
			mField.setAD_Tab_ID(tabid);

			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				return;
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
		atts.addAttribute("", "", "type", "CDATA", "object");
		atts.addAttribute("", "", "type-name", "CDATA", "ad.tab.field");
		document.startElement("", "", "field", atts);
		createFieldBinding(ctx, document, m_Field);

		PackOut packOut = (PackOut)ctx.get("PackOutProcess");

		try
		{
			if(m_Field.getAD_FieldGroup_ID() > 0)
			{
				IPackOutHandler handler = packOut.getHandler("FG");
				handler.packOut(packOut,null,null,document,null,m_Field.getAD_FieldGroup_ID());
			}

			if (m_Field.getAD_Reference_ID()>0)
			{
				IPackOutHandler handler = packOut.getHandler("REF");
				handler.packOut(packOut,null,null,document,null,m_Field.getAD_Reference_ID());
			}

			if (m_Field.getAD_Reference_Value_ID()>0)
			{
				IPackOutHandler handler = packOut.getHandler("REF");
				handler.packOut(packOut,null,null,document,null,m_Field.getAD_Reference_Value_ID());
			}

			if (m_Field.getAD_Val_Rule_ID()>0)
			{
				IPackOutHandler handler = packOut.getHandler("V");
				handler.packOut(packOut,null,null,document,null,m_Field.getAD_Val_Rule_ID());
			}
		}
		catch(Exception e)
		{
			log.info(e.toString());
		}

		document.endElement("", "", "field");
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
}
