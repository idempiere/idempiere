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

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
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
import org.compiere.model.I_AD_Column;
import org.compiere.model.I_AD_Table;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_Column;
import org.compiere.model.X_AD_Element;
import org.compiere.model.X_AD_Package_Imp_Detail;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Trx;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class ColumnElementHandler extends AbstractElementHandler {

	public void startElement(PIPOContext ctx, Element element)
			throws SAXException {
		int success = 0;
		String entitytype = getStringValue(element, "EntityType");
		if (isProcessElement(ctx.ctx, entitytype)) {
			if (isParentDefer(element, I_AD_Table.Table_Name)) {
				element.defer = true;
				return;
			}

			List<String> excludes = defaultExcludeList(X_AD_Column.Table_Name);
			String columnName = getStringValue(element, "ColumnName", excludes);

			MColumn mColumn = findPO(ctx, element);
			if (mColumn == null) {
				int tableid = 0;
				if (getParentId(element, I_AD_Table.Table_Name) > 0) {
					tableid = getParentId(element, I_AD_Table.Table_Name);
				} else {
					mColumn = new MColumn(ctx.ctx, 0, getTrxName(ctx));
					PoFiller filler = new PoFiller(ctx, mColumn, element, this);
					filler.setTableReference("AD_Table_ID");
					tableid = mColumn.getAD_Table_ID();
				}
				int AD_Column_ID = 0;
				if (!hasUUIDKey(ctx, element)) {
					AD_Column_ID = findIdByColumnAndParentId(ctx, "AD_Column", "ColumnName", columnName, "AD_Table", tableid, /*ignorecase=*/true);
				}
				mColumn = new MColumn(ctx.ctx, AD_Column_ID > 0 ? AD_Column_ID : 0, getTrxName(ctx));
				if (mColumn.getAD_Column_ID() == 0 && isOfficialId(element, "AD_Column_ID")) {
					mColumn.setAD_Column_ID(getIntValue(element, "AD_Column_ID"));
				}
			}

			mColumn.setColumnName(columnName);
			mColumn.setIsSyncDatabase(getStringValue(element, "IsSyncDatabase", excludes));

			PoFiller filler = new PoFiller(ctx, mColumn, element, this);
			List<String> notfounds = filler.autoFill(excludes);
			if (notfounds.size() > 0) {
				element.defer = true;
				element.unresolved = notfounds.toString();
				return;
			}

			if (!mColumn.is_new() && !mColumn.is_Changed())
				return;

			X_AD_Package_Imp_Detail impDetail = createImportDetail(ctx, element.qName, X_AD_Column.Table_Name, X_AD_Column.Table_ID);
			String action = null;
			if (!mColumn.is_new()) {
				backupRecord(ctx, impDetail.getAD_Package_Imp_Detail_ID(), "AD_Column", mColumn);
				action = "Update";
			} else {
				action = "New";
			}

			// Setup Element.
			if (mColumn.getAD_Element_ID() == 0) {
				X_AD_Element adElement = new X_AD_Element(ctx.ctx, 0, getTrxName(ctx));
				adElement.setColumnName(mColumn.getColumnName());
				adElement.setEntityType(mColumn.getEntityType());
				adElement.setPrintName(mColumn.getColumnName());
				adElement.setName(mColumn.getColumnName());
				adElement.saveEx();
				X_AD_Package_Imp_Detail eleDetail = createImportDetail(ctx, "Element", X_AD_Element.Table_Name,
						X_AD_Element.Table_ID);
				logImportDetail(ctx, eleDetail, 1, mColumn.getColumnName(), adElement
						.getAD_Element_ID(), "New");
				mColumn.setAD_Element_ID(adElement.getAD_Element_ID());
			}

			boolean recreateColumn = (mColumn.is_new()
					|| mColumn.is_ValueChanged("AD_Reference_ID")
					|| mColumn.is_ValueChanged("FieldLength")
					|| mColumn.is_ValueChanged("ColumnName") || mColumn
					.is_ValueChanged("IsMandatory"));

			//ignore fieldlength change for clob and lob
			if (!mColumn.is_ValueChanged("AD_Reference_ID") && mColumn.is_ValueChanged("FieldLength")) {
				if (DisplayType.isLOB(mColumn.getAD_Reference_ID())) {
					recreateColumn = false;
				}
			}

			// changed default ??
			// m_Column.is_ValueChanged("DefaultValue") doesn't work well with
			// nulls
			if (!recreateColumn) {
				String oldDefault = (String) mColumn
						.get_ValueOld("DefaultValue");
				String newDefault = mColumn.getDefaultValue();
				if (oldDefault != null && oldDefault.length() == 0)
					oldDefault = null;
				if (newDefault != null && newDefault.length() == 0)
					newDefault = null;
				if ((oldDefault == null && newDefault != null)
						|| (oldDefault != null && newDefault == null)) {
					recreateColumn = true;
				} else if (oldDefault != null && newDefault != null) {
					if (!oldDefault.equals(newDefault))
						recreateColumn = true;
				}
			}

			// Don't create database column for virtual columns
			boolean syncDatabase = "Y".equalsIgnoreCase(getStringValue(element, "IsSyncDatabase"));
			if (recreateColumn) {
				if (mColumn.isVirtualColumn() || !syncDatabase)
					recreateColumn = false;
			}

			if (mColumn.save(getTrxName(ctx)) == true) {
				logImportDetail(ctx, impDetail, 1, mColumn.getName(), mColumn
						.get_ID(), action);
				element.recordId = mColumn.getAD_Column_ID();
			} else {
				logImportDetail(ctx, impDetail, 0, mColumn.getName(), mColumn
						.get_ID(), action);
				throw new POSaveFailedException("Failed to save column " + mColumn.getName());
			}

			if (recreateColumn || syncDatabase) {
				MTable table = new MTable(ctx.ctx, mColumn.getAD_Table_ID(), getTrxName(ctx));
				if (!table.isView() && !mColumn.isVirtualColumn()) {
					success = createColumn(ctx, table, mColumn, recreateColumn);

					X_AD_Package_Imp_Detail  dbDetail = createImportDetail(ctx, "dbColumn", X_AD_Column.Table_Name, X_AD_Column.Table_ID);
					if (success == 1) {
						logImportDetail(ctx, dbDetail, 1, mColumn.getColumnName(),
								mColumn.get_ID(), action);
					} else {
						logImportDetail(ctx, dbDetail, 0, mColumn.getColumnName(),
								mColumn.get_ID(), action);
						throw new DatabaseAccessException("Failed to create column or related constraint for " + mColumn.getColumnName());
					}
				}
			}
		} else {
			element.skip = true;
		}
	}

	/**
	 * Check if column exists in database and modify. If not create column.
	 *
	 * @param tablename
	 * @param columnname
	 * @param v_AD_Reference_ID
	 * @param v_FieldLength
	 * @param v_DefaultValue
	 * @param v_IsMandatory
	 *
	 */
	private int createColumn(PIPOContext ctx, MTable table, MColumn column, boolean doAlter) {

		int no = 0;

		String sql = null;
		ResultSet rst = null;
		ResultSet rsc = null;
		Connection conn = null;
		Trx trx = Trx.get(getTrxName(ctx), true);
		if (!trx.commit())
			return 0;

		try {
			// Find Column in Database
			conn = trx.getConnection();
			DatabaseMetaData md = conn.getMetaData();
			String catalog = DB.getDatabase().getCatalog();
			String schema = DB.getDatabase().getSchema();
			String tableName = table.getTableName();
			String columnName = column.getColumnName();
			if (DB.isOracle()) {
				tableName = tableName.toUpperCase();
				columnName = columnName.toUpperCase();
			} else if (DB.isPostgreSQL()) {
				tableName = tableName.toLowerCase();
				columnName = columnName.toLowerCase();
			}

			rst = md.getTables(catalog, schema, tableName,
					new String[] { "TABLE" });
			if (!rst.next()) {
				// table doesn't exist
				sql = table.getSQLCreate();
			} else {
				//
				rsc = md.getColumns(catalog, schema, tableName, columnName);
				if (rsc.next()) {
					if (doAlter) {
						// update existing column
						boolean notNull = DatabaseMetaData.columnNoNulls == rsc
								.getInt("NULLABLE");
						sql = column.getSQLModify(table,
								column.isMandatory() != notNull);
					}
				} else {
					// No existing column
					sql = column.getSQLAdd(table);
				}
			}

			//execute modify or add if needed
			if (sql != null && sql.trim().length() > 0) {
				log.info(sql);

				if (sql.indexOf(DB.SQLSTATEMENT_SEPARATOR) == -1) {
					no = DB.executeUpdate(sql, false, trx.getTrxName());
					if (no == -1)
						return 0;
				} else {
					String statements[] = sql.split(DB.SQLSTATEMENT_SEPARATOR);
					for (int i = 0; i < statements.length; i++) {
						int count = DB.executeUpdate(statements[i], false,
								trx.getTrxName());
						if (count == -1) {
							return 0;
						}
						no += count;
					}
				}
			}
			trx.commit(true);
		} catch (SQLException e) {
			log.log(Level.SEVERE, e.getLocalizedMessage(), e);
			trx.rollback();
			return 0;
		}
		finally
		{
			DB.close(rsc);
			rsc = null;
			DB.close(rst);
			rst = null;
		}

		return 1;
	}

	public void endElement(PIPOContext ctx, Element element) throws SAXException {
	}

	public void create(PIPOContext ctx, TransformerHandler document)
			throws SAXException {
		int AD_Column_ID = Env.getContextAsInt(ctx.ctx,
				X_AD_Column.COLUMNNAME_AD_Column_ID);
		AttributesImpl atts = new AttributesImpl();
		X_AD_Column m_Column = new X_AD_Column(ctx.ctx, AD_Column_ID,
				getTrxName(ctx));

		if (ctx.packOut.getFromDate() != null) {
			if (m_Column.getUpdated().compareTo(ctx.packOut.getFromDate()) < 0) {
				return;
			}
		}

		addTypeName(atts, "table");
		document.startElement("", "", I_AD_Column.Table_Name, atts);
		createColumnBinding(ctx, document, m_Column);
		document.endElement("", "", I_AD_Column.Table_Name);
	}

	private void createColumnBinding(PIPOContext ctx, TransformerHandler document,
			X_AD_Column m_Column) {

		PoExporter filler = new PoExporter(ctx, document, m_Column);
		List<String>excludes = defaultExcludeList(X_AD_Column.Table_Name);

		if (m_Column.getAD_Column_ID() <= PackOut.MAX_OFFICIAL_ID)
			filler.add("AD_Column_ID", new AttributesImpl());

		filler.addString("IsSyncDatabase", "Y", new AttributesImpl());
		filler.addTableReference("AD_Table", "TableName", new AttributesImpl());
		filler.addTableReference("AD_Reference_Value_ID", "AD_Reference", "Name", new AttributesImpl());

		excludes.add("IsSyncDatabase");
		excludes.add("AD_Table_ID");
		excludes.add("AD_Reference_Value_ID");

		filler.export(excludes);
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler,
			TransformerHandler docHandler,
			int recordId) throws Exception {
		Env.setContext(packout.getCtx().ctx, I_AD_Column.COLUMNNAME_AD_Column_ID, recordId);
		create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(I_AD_Column.COLUMNNAME_AD_Column_ID);
	}
}
