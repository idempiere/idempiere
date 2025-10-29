/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.DataElementParameters;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.compiere.model.MColumn;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.MTableAttribute;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class TableAttributeElementHandler extends GenericPOElementHandler
{
	public TableAttributeElementHandler()
	{
	}

	public TableAttributeElementHandler(String tableName)
	{
		super(tableName);
	}
	
	@SuppressWarnings("resource")
	@Override
	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException
	{
		AttributesImpl atts = new AttributesImpl();
		int tableId = MTable.getTable_ID(MTableAttribute.Table_Name);
		String sql = Env.getContext(ctx.ctx, DataElementParameters.SQL_STATEMENT);
		List<String> excludes = defaultExcludeList(MTableAttribute.Table_Name);
		Statement stmt = null;
		ResultSet rs = null;
		try
		{
			sql = MRole.getDefault().addAccessSQL(sql, MTableAttribute.Table_Name, true, true);
			stmt = DB.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
				MTableAttribute mTableAttribute = new MTableAttribute(ctx.ctx, rs, getTrxName(ctx));
				int AD_Client_ID = mTableAttribute.getAD_Client_ID();
				if (AD_Client_ID != Env.getAD_Client_ID(ctx.ctx))
					continue;

				boolean createElement = isPackOutElement(ctx, mTableAttribute);

				MTable table = MTable.get(ctx.ctx, tableId);
				for (MColumn column : table.getColumns(false))
				{
					try
					{
						rs.findColumn(column.getColumnName());
					}
					catch (SQLException e)
					{
						if (column.getColumnName().equals("AD_Client_ID") || column.getColumnName().equals("AD_Org_ID"))
						{
							throw new Exception("SQL Statement must include AD_Client_ID and AD_Org_ID");
						}
						if (!excludes.contains(column.getColumnName().toLowerCase()))
						{
							excludes.add(column.getColumnName().toLowerCase());
						}
					}
				}

				for (String keycol : mTableAttribute.get_KeyColumns())
				{
					if (excludes.contains(keycol.toLowerCase()))
					{
						throw new Exception("SQL Statement must include key columns");
					}
				}

				if (createElement)
				{
					verifyPackOutRequirement(mTableAttribute);
					addTypeName(atts, "table");
					document.startElement("", "", MTableAttribute.Table_Name, atts);
					PoExporter filler = new PoExporter(ctx, document, mTableAttribute);
					filler.export(excludes, ctx.packOut.isIncludeOrganizationId());
					document.endElement("", "", MTableAttribute.Table_Name);
				}
			}
		}
		catch (Exception e)
		{
			throw new AdempiereException(e);
		}
		finally
		{
			DB.close(rs, stmt);
		}
	}

	@Override
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId) throws Exception
	{
		if(m_tableName == null)
			m_tableName = Env.getContext(packout.getCtx().ctx, "Table_Name");
		int tableId = MTable.get(packout.getCtx().ctx, m_tableName).getAD_Table_ID();
		StringBuilder sql = new StringBuilder("SELECT * FROM AD_TableAttribute WHERE AD_Table_ID = ").append(tableId)
				.append(" AND Record_ID = ").append(recordId);
		packout.getCtx().ctx.put(DataElementParameters.SQL_STATEMENT, sql.toString());
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(DataElementParameters.SQL_STATEMENT);
	}
}
