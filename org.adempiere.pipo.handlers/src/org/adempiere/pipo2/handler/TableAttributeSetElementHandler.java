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
import java.util.logging.Level;

import javax.xml.transform.sax.TransformerHandler;

import org.adempiere.exceptions.AdempiereException;
import org.adempiere.pipo2.DataElementParameters;
import org.adempiere.pipo2.PIPOContext;
import org.adempiere.pipo2.PackOut;
import org.adempiere.pipo2.PoExporter;
import org.compiere.model.MColumn;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.MTableAttributeSet;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.AttributesImpl;

public class TableAttributeSetElementHandler extends GenericPOElementHandler {

	@SuppressWarnings("resource")
	@Override
	public void create(PIPOContext ctx, TransformerHandler document) throws SAXException
	{
		AttributesImpl atts = new AttributesImpl();
		String sql = Env.getContext(ctx.ctx, DataElementParameters.SQL_STATEMENT);
		String tableName = MTableAttributeSet.Table_Name;
		int tableId = MTable.getTable_ID(MTableAttributeSet.Table_Name);
		List<String> excludes = defaultExcludeList(tableName);
		Statement stmt = null;
		ResultSet rs = null;
		try
		{
			sql = MRole.getDefault().addAccessSQL(sql, tableName, true, true);
			stmt = DB.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next())
			{
				MTableAttributeSet mTableAttributeSet = new MTableAttributeSet(ctx.ctx, rs, getTrxName(ctx));
				int AD_Client_ID = mTableAttributeSet.getAD_Client_ID();
				if (AD_Client_ID != Env.getAD_Client_ID(ctx.ctx))
					continue;

				boolean createElement = isPackOutElement(ctx, mTableAttributeSet);

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

				for (String keycol : mTableAttributeSet.get_KeyColumns())
				{
					if (excludes.contains(keycol.toLowerCase()))
					{
						throw new Exception("SQL Statement must include key columns");
					}
				}

				if (mTableAttributeSet.getM_AttributeSet_ID() > 0)
				{
					try
					{
						new AttributeSetElementHandler().packOut(ctx.packOut, document, null, mTableAttributeSet.getM_AttributeSet_ID());
					}
					catch (Exception e)
					{
						if (log.isLoggable(Level.INFO))
							log.info(e.toString());
					}
				}

				if (createElement)
				{
					verifyPackOutRequirement(mTableAttributeSet);
					addTypeName(atts, "table");
					document.startElement("", "", tableName, atts);
					PoExporter filler = new PoExporter(ctx, document, mTableAttributeSet);
					filler.export(excludes, ctx.packOut.isIncludeOrganizationId());
					document.endElement("", "", tableName);
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
	public void packOut(PackOut packout, TransformerHandler packoutHandler, TransformerHandler docHandler, int recordId, String uuid) throws Exception
	{
		StringBuilder sql = new StringBuilder("SELECT * FROM AD_TableAttributeSet WHERE AD_TableAttributeSet_UU = '").append(uuid).append("'");
		packout.getCtx().ctx.put(DataElementParameters.SQL_STATEMENT, sql.toString());
		this.create(packout.getCtx(), packoutHandler);
		packout.getCtx().ctx.remove(DataElementParameters.SQL_STATEMENT);
	}

}
