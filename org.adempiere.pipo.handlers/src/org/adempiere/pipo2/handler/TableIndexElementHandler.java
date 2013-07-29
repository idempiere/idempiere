/******************************************************************************
 * Copyright (C) 2013 Elaine Tan                                              *
 * Copyright (C) 2013 Trek Global
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

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.MIndexColumn;
import org.compiere.model.MMessage;
import org.compiere.model.MTableIndex;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.process.TableIndexValidate;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

/**
 * Table index (AD_TableIndex) element handler
 * @author Elaine
 *
 */
public class TableIndexElementHandler extends AbstractElementHandler {

	private List<Integer> tableIndexes = new ArrayList<Integer>();
	
	@Override
	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {			
			MTableIndex mTableIndex = findPO(ctx, element);
			if (mTableIndex == null) {
				int id = 0;
				if (!hasUUIDKey(ctx, element)) {
					String name = getStringValue(element, "Name");
					id = findIdByColumn(ctx, "AD_TableIndex_ID", "Name", name, true);
				}
				mTableIndex = new MTableIndex(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
			}
			PoFiller filler = new PoFiller(ctx, mTableIndex, element, this);
			List<String> excludes = defaultExcludeList(MTableIndex.Table_Name);
			if (mTableIndex.getAD_TableIndex_ID() == 0 && isOfficialId(element, "AD_TableIndex_ID"))
				mTableIndex.setAD_TableIndex_ID(getIntValue(element, "AD_TableIndex_ID"));
			
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
	
			if (mTableIndex.is_new() || mTableIndex.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, MTableIndex.Table_Name, MTableIndex.Table_ID);		
				String action = null;
				if (!mTableIndex.is_new()) {
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), MTableIndex.Table_Name, mTableIndex);
					action = "Update";
				} else {
					action = "New";
				}
				if (mTableIndex.save(getTrxName(ctx)) == true) {
					logImportDetail(ctx, impDetail, 1, mTableIndex.getName(), mTableIndex.get_ID(), action);
					element.recordId = mTableIndex.getAD_TableIndex_ID();
				} else {
					logImportDetail(ctx, impDetail, 0, mTableIndex.getName(), mTableIndex.get_ID(), action);
					throw new POSaveFailedException("Failed to save AD_TableIndex " + mTableIndex.getName());
				}
			}
		} else {
			element.skip = true;
		}
	}
	
	@Override
	public void endElement(PIPOContext ctx, Element element) throws SAXException {
		MTableIndex mTableIndex = findPO(ctx, element);
		int success = validateTableIndex(ctx, mTableIndex);
		X_AD_Package_Imp_Detail dbDetail = createImportDetail(ctx, "dbIndex", MTableIndex.Table_Name, MTableIndex.Table_ID);
		if (success == 1) {
			logImportDetail(ctx, dbDetail, 1, mTableIndex.getName(), mTableIndex.get_ID(), "Validate");
		} else {
			logImportDetail(ctx, dbDetail, 0, mTableIndex.getName(), mTableIndex.get_ID(), "Validate");
			throw new DatabaseAccessException("Failed to validate AD_TableIndex for " + mTableIndex.getName());
		}
	}
	
	private int validateTableIndex(PIPOContext ctx, MTableIndex tableIndex) 
	{
		Trx trx = Trx.get(getTrxName(ctx), true);
		if (!trx.commit())
			return 0;

		try {
			TableIndexValidate.validateTableIndex(ctx.ctx, tableIndex, trx.getTrxName(), null);
			trx.commit(true);
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			trx.rollback();
			return 0;
		}

		return 1;
	}
	
	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException {
		int AD_TableIndex_ID = Env.getContextAsInt(ctx.ctx, MTableIndex.COLUMNNAME_AD_TableIndex_ID);
		
		if (tableIndexes.contains(AD_TableIndex_ID))
			return;
		tableIndexes.add(AD_TableIndex_ID);
		AttributesImpl atts = new AttributesImpl();

		MTableIndex m_TableIndex = new MTableIndex(ctx.ctx, AD_TableIndex_ID, null);
		
		boolean createElement = true;
		if (ctx.packOut.getFromDate() != null) {
			if (m_TableIndex.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				createElement = false;
			}
		}
		
		if (createElement) {
			if (m_TableIndex.getAD_Message_ID() > 0) {
				try {
					ctx.packOut.getHandler(MMessage.Table_Name).packOut(ctx.packOut, document, ctx.logDocument, m_TableIndex.getAD_Message_ID());
				} catch (Exception e) {
					throw new SAXException(e);
				}
			}
			
			addTypeName(atts, "table");
			document.startElement("", "", MTableIndex.Table_Name, atts);
			createTableIndexBinding(ctx, document, m_TableIndex);
		}
		
		MIndexColumn[] indexColumns = m_TableIndex.getColumns(true);
		for (MIndexColumn indexColumn : indexColumns) {
			createIndexColumn(ctx, document, indexColumn.getAD_IndexColumn_ID());
		}

		if (createElement) {
			document.endElement("", "", MTableIndex.Table_Name);
		}
	}
	
	private void createIndexColumn(PIPOContext ctx, TransformerHandler document, int AD_IndexColumn_ID) throws SAXException {
		try {
			ctx.packOut.getHandler(MIndexColumn.Table_Name).packOut(ctx.packOut, document, ctx.logDocument, AD_IndexColumn_ID);
		} catch (Exception e) {
			throw new SAXException(e);
		}
	}

	private void createTableIndexBinding(PIPOContext ctx, TransformerHandler document, MTableIndex m_TableIndex) {
		PoExporter filler = new PoExporter(ctx, document, m_TableIndex);
		List<String>excludes = defaultExcludeList(MTableIndex.Table_Name);

		if (m_TableIndex.getAD_TableIndex_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_TableIndex_ID", new AttributesImpl());

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, MTableIndex.COLUMNNAME_AD_TableIndex_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(MTableIndex.COLUMNNAME_AD_TableIndex_ID);	
	}

}
