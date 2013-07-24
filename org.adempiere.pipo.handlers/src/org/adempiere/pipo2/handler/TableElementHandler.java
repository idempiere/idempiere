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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.AbstractElementHandler;
import org.adempiere.pipo2.Element;
import org.adempiere.pipo2.ElementHandler;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackIn;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.adempiere.pipo2.PoFiller;
import org.adempiere.pipo2.exception.DatabaseAccessException;
import org.adempiere.pipo2.exception.POSaveFailedException;
import org.compiere.model.I_AD_Table;
import org.compiere.model.MTable;
import org.compiere.model.MTableIndex;
import org.compiere.model.MViewComponent;
import org.compiere.model.X_AD_Column;
import org.compiere.model.X_AD_Package_Exp_Detail;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.model.X_AD_Table;
import org.compiere.process.DatabaseViewValidate;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class TableElementHandler extends AbstractElementHandler {
	private ColumnElementHandler columnHandler = new ColumnElementHandler();
	private TableIndexElementHandler tableIndexHandler = new TableIndexElementHandler();
	private ViewComponentElementHandler viewComponentHandler = new ViewComponentElementHandler();

	private List<Integer>tables = new ArrayList<Integer>();

	public void startElement(PIPOContext ctx, Element element) throws SAXException {
		PackIn packIn = ctx.packIn;
		List<String> excludes = defaultExcludeList(X_AD_Table.Table_Name);

		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {

			MTable mTable = findPO(ctx, element);
			if (mTable == null) {
				int id = 0;
				String tableName = getStringValue(element, "TableName", excludes);
				if (!hasUUIDKey(ctx, element)) {
					id = packIn.getTableId(tableName);
					if (id <= 0) {
						id = findIdByColumn(ctx, "AD_Table", "TableName", tableName);
						if (id > 0)
							packIn.addTable(tableName, id);
					}
					if (id > 0 && isTableProcess(ctx, id)) {
						return;
					}
				}

				mTable = new MTable(ctx.ctx, id > 0 ? id : 0, getTrxName(ctx));
				mTable.setTableName(tableName);
			}
						
			if (mTable.getAD_Table_ID() == 0 && isOfficialId(element, "AD_Table_ID"))
			{
				mTable.setAD_Table_ID(getIntValue(element, "AD_Table_ID"));
			}
			
			PoFiller filler = new PoFiller(ctx, mTable, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}
			
			if (mTable.is_new() || mTable.is_Changed()) {
				X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Table.Table_Name,
						X_AD_Table.Table_ID);
				String action = null;
				if (!mTable.is_new()){
					backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(),X_AD_Table.Table_Name,mTable);
					action = "Update";
				}
				else{
					action = "New";				
				}
				if (mTable.save(getTrxName(ctx)) == true){
					logImportDetail (ctx, impDetail, 1, mTable.getName(),mTable.get_ID(),action);
					tables.add(mTable.getAD_Table_ID());
					packIn.addTable(mTable.getTableName(), mTable.getAD_Table_ID());
					element.recordId = mTable.getAD_Table_ID();
				}
				else{
					logImportDetail (ctx, impDetail, 0, mTable.getName(), mTable.get_ID(),action);
					throw new POSaveFailedException("Failed to save Table " + mTable.getName());
				}
			}
		} else {
			element.skip = true;
		}
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
		MTable mTable = findPO(ctx, element);
		boolean isValidateView = false;
		MViewComponent[] m_vcs = mTable.getViewComponent(true);
		if (m_vcs != null && m_vcs.length > 0)
			isValidateView = true;
		
		if (mTable.isView() && isValidateView) {
			int success = validateDatabaseView(ctx, mTable);
			X_AD_Package_Imp_Detail dbDetail = createImportDetail(ctx, "dbView", MTable.Table_Name, MTable.Table_ID);
			if (success == 1) {
				logImportDetail(ctx, dbDetail, 1, mTable.getName(), mTable.get_ID(), "Validate");
			} else {
				logImportDetail(ctx, dbDetail, 0, mTable.getName(), mTable.get_ID(), "Validate");
				throw new DatabaseAccessException("Failed to validate view for " + mTable.getName());
			}
		}
	}
	
	private int validateDatabaseView(PIPOContext ctx, MTable table) 
	{
		Trx trx = Trx.get(getTrxName(ctx), true);
		if (!trx.commit())
			return 0;

		try {
			DatabaseViewValidate.validateDatabaseView(ctx.ctx, table, trx.getTrxName(), null);
			trx.commit(true);
		} catch (Exception e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			trx.rollback();
			return 0;
		}

		return 1;
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {

		int AD_Table_ID = Env.getContextAsInt(ctx.ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Table_ID);
		PackOut packOut = ctx.packOut;
		boolean exported = isTableProcess(ctx, AD_Table_ID);
		AttributesImpl atts = new AttributesImpl();
		//Export table if not already done so
		if (!exported){
			boolean createElement = true;
			X_AD_Table m_Table = new X_AD_Table (ctx.ctx, AD_Table_ID, null);
			if (ctx.packOut.getFromDate() != null) {
				if (m_Table.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
					createElement = false;
				}
			}
			if (createElement) {
				addTypeName(atts, "table");
				document.startElement("","",I_AD_Table.Table_Name,atts);
				createTableBinding(ctx,document,m_Table);
			}

			String sql = "SELECT * FROM AD_Column WHERE AD_Table_ID = ? "
				+ " ORDER BY IsKey DESC, AD_Column_ID";  // Export key column as the first one

			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {
				pstmt = DB.prepareStatement (sql, getTrxName(ctx));
				pstmt.setInt(1, AD_Table_ID);
				rs = pstmt.executeQuery();

				while (rs.next()){
					ElementHandler handler = packOut.getHandler("AD_Element");
					handler.packOut(packOut,document,null,rs.getInt(X_AD_Column.COLUMNNAME_AD_Element_ID));

					if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Reference_ID)>0)
					{
						handler = packOut.getHandler("AD_Reference");
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Reference_ID));
					}

					if (rs.getInt("AD_Reference_Value_ID")>0)
					{
						handler = packOut.getHandler("AD_Reference");
						handler.packOut(packOut,document,null,rs.getInt("AD_Reference_Value_ID"));
					}

					if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID)>0)
					{
						handler = packOut.getHandler("AD_Process");
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Process_ID));
					}

					if (rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Val_Rule_ID)>0)
					{
						handler = packOut.getHandler("AD_Val_Rule");
						handler.packOut(packOut,document,null,rs.getInt(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Val_Rule_ID));
					}

					createColumn(ctx, document, rs.getInt("AD_Column_ID"));
				}
			} catch (Exception e)	{
				throw new AdempiereException(e);
			} finally	{
				DB.close(rs, pstmt);
			}
			
			sql = "SELECT * FROM AD_TableIndex WHERE AD_Table_ID = ? ORDER BY AD_TableIndex_ID";
			pstmt = null;
			rs = null;
			try {
				pstmt = DB.prepareStatement (sql, getTrxName(ctx));
				pstmt.setInt(1, AD_Table_ID);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					createTableIndex(ctx, document, rs.getInt(MTableIndex.COLUMNNAME_AD_TableIndex_ID));
				}
			} catch (Exception e)	{
				throw new AdempiereException(e);
			} finally	{
				DB.close(rs, pstmt);
			}
			
			sql = "SELECT * FROM AD_ViewComponent WHERE AD_Table_ID = ? ORDER BY SeqNo, AD_ViewComponent_ID";
			pstmt = null;
			rs = null;
			try {
				pstmt = DB.prepareStatement (sql, getTrxName(ctx));
				pstmt.setInt(1, AD_Table_ID);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					createViewComponent(ctx, document, rs.getInt(MViewComponent.COLUMNNAME_AD_ViewComponent_ID));
				}
			} catch (Exception e)	{
				throw new AdempiereException(e);
			} finally	{
				DB.close(rs, pstmt);
			}
			
			if (createElement) {
				document.endElement("","",X_AD_Table.Table_Name);
			}
		}

	}

	private void createColumn(PIPOContext ctx, TransformerHandler document, int AD_Column_ID) throws SAXException {
		Env.setContext(ctx.ctx, X_AD_Column.COLUMNNAME_AD_Column_ID, AD_Column_ID);
		columnHandler.create(ctx, document);
		ctx.ctx.remove(X_AD_Column.COLUMNNAME_AD_Column_ID);
	}
	
	private void createTableIndex(PIPOContext ctx, TransformerHandler document, int AD_TableIndex_ID) throws SAXException {
		Env.setContext(ctx.ctx, MTableIndex.COLUMNNAME_AD_TableIndex_ID, AD_TableIndex_ID);
		tableIndexHandler.create(ctx, document);
		ctx.ctx.remove(MTableIndex.COLUMNNAME_AD_TableIndex_ID);
	}
	
	private void createViewComponent(PIPOContext ctx, TransformerHandler document, int AD_ViewComponent_ID) throws SAXException {
		Env.setContext(ctx.ctx, MViewComponent.COLUMNNAME_AD_ViewComponent_ID, AD_ViewComponent_ID);
		viewComponentHandler.create(ctx, document);
		ctx.ctx.remove(MViewComponent.COLUMNNAME_AD_ViewComponent_ID);
	}

	private boolean isTableProcess(PIPOContext ctx, int AD_Table_ID) {
		if (tables.contains(AD_Table_ID))
			return true;
		else {
			tables.add(AD_Table_ID);
			return false;
		}
	}

	private void createTableBinding(PIPOContext ctx, TransformerHandler document, X_AD_Table m_Table)
	{
		PoExporter filler = new PoExporter(ctx, document, m_Table);
		if (m_Table.getAD_Table_ID() <= PackOut.MAX_OFFICIAL_ID)
		{
			filler.add("AD_Table_ID", new AttributesImpl());
		}

		List<String> excludes = defaultExcludeList(X_AD_Table.Table_Name);		
		filler.export(excludes);
	}

	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler,int recordId) throws Exception
	{
		Env.setContext(packout.getCtx().ctx, X_AD_Package_Exp_Detail.COLUMNNAME_AD_Table_ID, recordId);
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(X_AD_Package_Exp_Detail.COLUMNNAME_AD_Table_ID);
	}
}
