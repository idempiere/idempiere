/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 * Contributors:                                                       *
 * - Diego Ruiz - BX Service GmbH                                      *
 **********************************************************************/
package org.compiere.process;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.util.ProcessUtil;
import org.compiere.model.MColumn;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.model.MTable;
import org.compiere.model.MViewColumn;
import org.compiere.model.MViewComponent;
import org.compiere.model.M_Element;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.model.Query;
import org.compiere.model.SystemIDs;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;

/**
 * Process to create the view definition (AD_ViewComponent and AD_ViewColumn) of a table
 * from the view that exists in the database. It is the opposite of {@link DatabaseViewValidate}.
 */
@org.adempiere.base.annotation.Process
public class DatabaseViewImport extends SvrProcess {

	private int		p_AD_Table_ID = 0;
	/** Delete the existing view components of the table */
	private boolean	p_DeleteOld = false;
	/** Create the dictionary columns that are missing in the table */
	private boolean	p_IsCreateColumns = true;
	/** Remove the PostgreSQL type casts (::type) */
	private boolean	p_IsRemoveCasts = true;

	@Override
	protected void prepare()
	{
		for (ProcessInfoParameter para : getParameter())
		{
			String name = para.getParameterName();
			if (para.getParameter() == null)
				;
			else if (name.equals("DeleteOld"))
				p_DeleteOld = para.getParameterAsBoolean();
			else if (name.equals("IsCreateColumns"))
				p_IsCreateColumns = para.getParameterAsBoolean();
			else if (name.equals("IsRemoveCasts"))
				p_IsRemoveCasts = para.getParameterAsBoolean();
			else
				MProcessPara.validateUnknownParameter(getProcessInfo().getAD_Process_ID(), para);
		}
		p_AD_Table_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception
	{
		MTable table = new MTable(getCtx(), p_AD_Table_ID, get_TrxName());
		if (!table.isView() || !table.isActive())
			throw new AdempiereException(Msg.getMsg(getCtx(), "NotActiveDatabaseView"));

		return importDatabaseView(getCtx(), table, p_DeleteOld, p_IsCreateColumns, p_IsRemoveCasts, get_TrxName(), getProcessInfo());
	}

	/**
	 * Create AD_ViewComponent and AD_ViewColumn records from the definition of the view in the database.<br/>
	 * The view is searched in the database by the table name of the table (case insensitive).
	 * @param ctx
	 * @param table table that is a view
	 * @param deleteOld true to delete the existing view components of the table, false to fail if the table has view components
	 * @param createColumns true to also create the dictionary columns (AD_Column) that are missing in the table
	 * @param removeCasts true to remove the PostgreSQL type casts (::type), so the definition can be used in Oracle,
	 * the process log lists where they were removed; false to keep the definition as the database returns it
	 * @param trxName
	 * @param pi optional process info to add log
	 * @return info message
	 * @throws Exception if the view doesn't exist in the database or its definition can't be represented as view components
	 */
	public static String importDatabaseView(Properties ctx, MTable table, boolean deleteOld, boolean createColumns, boolean removeCasts, String trxName, ProcessInfo pi) throws Exception
	{
		Trx trx = Trx.get(trxName, true);
		DatabaseMetaData md = trx.getConnection().getMetaData();
		String tableName = table.getTableName();
		if (md.storesUpperCaseIdentifiers())
			tableName = tableName.toUpperCase();
		else if (md.storesLowerCaseIdentifiers())
			tableName = tableName.toLowerCase();

		// find the view and its columns in the database
		String dbSchema = null;
		String dbViewName = null;
		List<String> dbColumnNames = new ArrayList<String>();
		List<Integer> dbColumnTypes = new ArrayList<Integer>();
		ResultSet rs = null;
		ResultSet rs2 = null;
		try 
		{
			String catalog = DB.getDatabase().getCatalog();
			String schema = DB.getDatabase().getSchema();
			rs = md.getTables(catalog, schema, tableName, new String[] {"VIEW"});
			while (rs.next())
			{
				String name = rs.getString("TABLE_NAME");
				if (name == null || !table.getTableName().equalsIgnoreCase(name))
					continue;
				dbViewName = name;
				dbSchema = rs.getString("TABLE_SCHEM");
				rs2 = md.getColumns(rs.getString("TABLE_CAT"), dbSchema, dbViewName, null);
				while (rs2.next())
				{
					// the name is a pattern, it can match other tables
					if (!dbViewName.equals(rs2.getString("TABLE_NAME")))
						continue;
					dbColumnNames.add(rs2.getString("COLUMN_NAME"));
					dbColumnTypes.add(rs2.getInt("DATA_TYPE"));
				}
				break;
			}
		}
		finally
		{
			DB.close(rs2);
			DB.close(rs);
		}
		if (dbViewName == null)
			throw new AdempiereException(Msg.getMsg(ctx, "ViewNotFoundInDB", new Object[] {table.getTableName()}));

		String viewSQL = getViewDefinition(ctx, dbSchema, dbViewName, trxName);
		if (Util.isEmpty(viewSQL, true))
			throw new AdempiereException(Msg.getMsg(ctx, "ViewNotFoundInDB", new Object[] {table.getTableName()}));

		List<ViewDefinitionParser.Component> components;
		try
		{
			components = ViewDefinitionParser.parse(viewSQL);
		}
		catch (AdempiereException e)
		{
			throw new AdempiereException(Msg.getMsg(ctx, "ViewDefinitionNotSupported", new Object[] {e.getMessage()}), e);
		}
		for (ViewDefinitionParser.Component component : components)
		{
			if (component.getItems().size() != dbColumnNames.size())
				throw new AdempiereException(Msg.getMsg(ctx, "ViewDefinitionNotSupported",
						new Object[] {component.getItems().size() + " <> " + dbColumnNames.size() + " " + Msg.getElement(ctx, "AD_ViewColumn_ID")}));
		}

		// existing view components
		List<MViewComponent> oldComponents = new Query(ctx, MViewComponent.Table_Name, MViewComponent.COLUMNNAME_AD_Table_ID + "=?", trxName)
				.setParameters(table.getAD_Table_ID())
				.list();
		if (!oldComponents.isEmpty())
		{
			if (!deleteOld)
				throw new AdempiereException(Msg.getMsg(ctx, "ErrorCopyView"));
			for (MViewComponent oldComponent : oldComponents)
			{
				List<MViewColumn> oldColumns = new Query(ctx, MViewColumn.Table_Name, MViewColumn.COLUMNNAME_AD_ViewComponent_ID + "=?", trxName)
						.setParameters(oldComponent.getAD_ViewComponent_ID())
						.list();
				for (MViewColumn oldColumn : oldColumns)
					oldColumn.deleteEx(true);
				oldComponent.deleteEx(true);
			}
		}

		// column names, the same for all the components
		String[] columnNames = new String[dbColumnNames.size()];
		List<ViewDefinitionParser.SelectItem> firstItems = components.get(0).getItems();
		for (int i = 0; i < columnNames.length; i++)
			columnNames[i] = getColumnName(ctx, table, dbColumnNames.get(i), firstItems.get(i).getAlias(), trxName);

		int columnCount = 0;
		for (int i = 0; i < components.size(); i++)
		{
			ViewDefinitionParser.Component component = components.get(i);
			int seqNo = (i + 1) * 10;
			MViewComponent vc = new MViewComponent(table);
			vc.set_TrxName(trxName);
			vc.setEntityType(table.getEntityType());
			vc.setSeqNo(seqNo);
			setValue(ctx, vc, MViewComponent.COLUMNNAME_Name, table.getTableName() + "-" + String.format("%03d", seqNo));
			vc.setIsDistinct(component.isDistinct());
			vc.setIsUnionAll(component.isUnionAll());
			List<String> castsRemoved = new ArrayList<String>();
			setValue(ctx, vc, MViewComponent.COLUMNNAME_FromClause, getSQL(ctx, component.getFromClause(), removeCasts, MViewComponent.COLUMNNAME_FromClause, castsRemoved));
			setValue(ctx, vc, MViewComponent.COLUMNNAME_WhereClause, getSQL(ctx, component.getWhereClause(), removeCasts, MViewComponent.COLUMNNAME_WhereClause, castsRemoved));
			setValue(ctx, vc, MViewComponent.COLUMNNAME_OtherClause, getSQL(ctx, component.getOtherClause(), removeCasts, MViewComponent.COLUMNNAME_OtherClause, castsRemoved));
			vc.saveEx();

			for (int j = 0; j < columnNames.length; j++)
			{
				ViewDefinitionParser.SelectItem item = component.getItems().get(j);
				MViewColumn vcol = new MViewColumn(vc);
				vcol.setEntityType(table.getEntityType());
				vcol.setSeqNo((j + 1) * 10);
				setValue(ctx, vcol, MViewColumn.COLUMNNAME_ColumnName, columnNames[j]);
				String dbDataType = removeCasts && item.isNullLiteral() ? getDBDataType(dbColumnTypes.get(j)) : null;
				if (dbDataType != null)
				{
					// MViewComponent.getSelect creates a NULL of the data type that works in all databases
					vcol.setColumnSQL("NULL");
					vcol.setDBDataType(dbDataType);
				}
				else
				{
					String columnSQL = removeCasts ? ViewDefinitionParser.removeCasts(item.getExpression()) : item.getExpression();
					if (!columnSQL.equals(item.getExpression()) && !item.isNullLiteral())
						castsRemoved.add(columnNames[j]);
					setValue(ctx, vcol, MViewColumn.COLUMNNAME_ColumnSQL, columnSQL);
				}
				vcol.saveEx();
				columnCount++;
			}
			if (pi != null)
			{
				pi.addLog(0, null, null, vc.getName(), MViewComponent.Table_ID, vc.getAD_ViewComponent_ID());
				if (!castsRemoved.isEmpty())
					pi.addLog(0, null, null, vc.getName() + ": " + Msg.getMsg(ctx, "ViewCastsRemoved", new Object[] {String.join(", ", castsRemoved)}),
							MViewComponent.Table_ID, vc.getAD_ViewComponent_ID());
			}
		}

		StringBuilder msg = new StringBuilder("@Created@ @AD_ViewComponent_ID@ #").append(components.size())
				.append(", @AD_ViewColumn_ID@ #").append(columnCount);
		if (createColumns)
			msg.append(", @AD_Column_ID@ ").append(createColumns(ctx, table, trx, pi));
		return Msg.parseTranslation(ctx, msg.toString());
	}

	/**
	 * Get the SQL text of a view from the database
	 * @param ctx
	 * @param schema schema of the view
	 * @param viewName name of the view, as stored in the database
	 * @param trxName
	 * @return select statement of the view, null if not found
	 */
	private static String getViewDefinition(Properties ctx, String schema, String viewName, String trxName)
	{
		if (DB.isPostgreSQL())
		{
			return DB.getSQLValueStringEx(trxName,
					"SELECT pg_get_viewdef(c.oid, true) FROM pg_class c JOIN pg_namespace n ON (n.oid=c.relnamespace) "
					+ "WHERE c.relkind='v' AND n.nspname=? AND c.relname=?", schema, viewName);
		}
		else if (DB.isOracle())
		{
			return DB.getSQLValueStringEx(trxName, "SELECT text FROM all_views WHERE owner=? AND view_name=?", schema, viewName);
		}
		throw new AdempiereException(Msg.getMsg(ctx, "ViewDefinitionNotSupported", new Object[] {DB.getDatabase().getName()}));
	}

	/**
	 * Get the name of a view column, using the case of the dictionary when the column is known
	 * @param ctx
	 * @param table
	 * @param dbColumnName name of the column in the database
	 * @param alias optional column alias from the view definition
	 * @param trxName
	 * @return column name
	 */
	private static String getColumnName(Properties ctx, MTable table, String dbColumnName, String alias, String trxName)
	{
		MColumn column = table.getColumn(dbColumnName);
		if (column != null)
			return column.getColumnName();
		M_Element element = M_Element.get(ctx, dbColumnName, trxName);
		if (element != null)
			return element.getColumnName();
		if (alias != null && alias.equalsIgnoreCase(dbColumnName))
			return alias;
		return dbColumnName;
	}

	/**
	 * Get the SQL of a clause, without the PostgreSQL type casts if requested
	 * @param ctx
	 * @param sql clause
	 * @param removeCasts true to remove the ::type casts
	 * @param columnName column of the clause
	 * @param castsRemoved list where the name of the clause is added when casts were removed
	 * @return sql
	 */
	private static String getSQL(Properties ctx, String sql, boolean removeCasts, String columnName, List<String> castsRemoved)
	{
		if (!removeCasts || sql == null)
			return sql;
		String result = ViewDefinitionParser.removeCasts(sql);
		if (!result.equals(sql))
			castsRemoved.add(Msg.getElement(ctx, columnName));
		return result;
	}

	/**
	 * Get the view column data type for a JDBC type
	 * @param sqlType type from java.sql.Types
	 * @return AD_ViewColumn.DBDataType, null if MViewComponent.getSelect can't create a NULL of that type
	 */
	private static String getDBDataType(int sqlType)
	{
		switch (sqlType)
		{
			case Types.CHAR:
			case Types.NCHAR:
				return MViewColumn.DBDATATYPE_CharacterFixed;
			case Types.VARCHAR:
			case Types.NVARCHAR:
			case Types.LONGVARCHAR:
				return MViewColumn.DBDATATYPE_CharacterVariable;
			case Types.INTEGER:
			case Types.SMALLINT:
			case Types.BIGINT:
				return MViewColumn.DBDATATYPE_Integer;
			case Types.NUMERIC:
			case Types.DECIMAL:
				return MViewColumn.DBDATATYPE_Number;
			default:
				return null;
		}
	}

	/**
	 * Set a text value, failing if it doesn't fit in the column instead of saving a truncated SQL
	 * @param ctx
	 * @param po
	 * @param columnName
	 * @param value
	 */
	private static void setValue(Properties ctx, PO po, String columnName, String value)
	{
		int length = POInfo.getPOInfo(ctx, po.get_Table_ID()).getFieldLength(columnName);
		if (value != null && length > 0 && value.length() > length)
			throw new AdempiereException(Msg.getMsg(ctx, "ViewDefinitionNotSupported",
					new Object[] {Msg.getElement(ctx, columnName) + " > " + length}));
		po.set_ValueOfColumn(columnName, value);
	}

	/**
	 * Run the process that creates the dictionary columns of the table that exist in the database
	 * @param ctx
	 * @param table
	 * @param trx
	 * @param pi optional process info to add log
	 * @return summary of the process
	 */
	private static String createColumns(Properties ctx, MTable table, Trx trx, ProcessInfo pi)
	{
		MProcess process = MProcess.get(ctx, SystemIDs.PROCESS_AD_TABLE_CREATECOLUMNS);
		ProcessInfo columnsPI = new ProcessInfo(process.getName(), process.getAD_Process_ID(), MTable.Table_ID, table.getAD_Table_ID());
		columnsPI.setClassName(process.getClassname());
		columnsPI.setAD_Client_ID(Env.getAD_Client_ID(ctx));
		columnsPI.setAD_User_ID(Env.getAD_User_ID(ctx));
		columnsPI.setParameter(new ProcessInfoParameter[] {
				new ProcessInfoParameter("EntityType", table.getEntityType(), null, null, null),
				new ProcessInfoParameter("AllTables", "N", null, null, null)
		});

		// the called process removes the process info of the caller from the context
		Object callerPI = ctx.get(PROCESS_INFO_CTX_KEY);
		boolean success;
		try
		{
			success = ProcessUtil.startJavaProcess(ctx, columnsPI, trx, false);
		}
		finally
		{
			if (callerPI != null)
				ctx.put(PROCESS_INFO_CTX_KEY, callerPI);
		}
		if (!success || columnsPI.isError())
			throw new AdempiereException(process.getName() + ": " + columnsPI.getSummary());

		ProcessInfoLog[] logs = columnsPI.getLogs();
		if (pi != null && logs != null)
		{
			for (ProcessInfoLog entry : logs)
				pi.addLog(0, null, null, entry.getP_Msg());
		}
		return columnsPI.getSummary();
	}
}
