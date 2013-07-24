/******************************************************************************
 * Product: Compiere ERP & CRM Smart Business Solution                        *
 * Copyright (C) 1999-2007 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software, you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY, without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program, if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 3600 Bridge Parkway #102, Redwood City, CA 94065, USA      *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.process;

import java.math.BigDecimal;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MTable;
import org.compiere.model.MViewColumn;
import org.compiere.model.MViewComponent;
import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

public class DatabaseViewValidate extends SvrProcess {

	private int		p_AD_Table_ID = 0; 
	
	@Override
	protected void prepare() 
	{
		p_AD_Table_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception 
	{
		MTable table = new MTable(getCtx(), p_AD_Table_ID, get_TrxName());
		log.info(table.toString());
		if (!table.isView() || !table.isActive())
			throw new AdempiereException(Msg.getMsg(getCtx(), "NotActiveDatabaseView"));
		
		return validateDatabaseView(getCtx(), table, get_TrxName(), getProcessInfo());
	}
	
	public static String validateDatabaseView(Properties ctx, MTable table, String trxName, ProcessInfo pi) throws Exception 
	{		
		Trx trx = Trx.get(trxName, true);
		DatabaseMetaData md = trx.getConnection().getMetaData();
		String tableName = table.getTableName();
		if (md.storesUpperCaseIdentifiers())
			tableName = tableName.toUpperCase();
		else if (md.storesLowerCaseIdentifiers())
			tableName = tableName.toLowerCase();
		
		String catalog = null;
		String schema = null;
		String[] types = {"VIEW"};
		boolean found = false;
		ArrayList<String> viewColumnNames = new ArrayList<String>();
		
		ResultSet rs = md.getTables(catalog, schema, tableName, types);
		while (rs.next())
		{
			String dbViewName = rs.getString("TABLE_NAME");			
			if (dbViewName == null)
				continue;
			if (table.getTableName().equalsIgnoreCase(dbViewName))
			{
				found = true;
				viewColumnNames.clear();
				
				ResultSet rs2 = md.getColumns(rs.getString("TABLE_CAT"), rs.getString("TABLE_SCHEM"), dbViewName, null);
				while (rs2.next())
					viewColumnNames.add(rs2.getString("COLUMN_NAME"));
				rs2.close();
			}
		}
		rs.close();

		StringBuilder sb = new StringBuilder("CREATE OR REPLACE VIEW ").append(table.getTableName());
		//
		MViewComponent[] m_vcs = table.getViewComponent(true);
		if (m_vcs == null || m_vcs.length == 0)
			throw new AdempiereException(Msg.getMsg(ctx, "NoViewComponentsSpecified"));

		boolean modified = false;
		MViewColumn[] vCols = null;
		for (int i = 0; i < m_vcs.length; i++)
		{
			MViewComponent vc = m_vcs[i];
			if (i > 0)
				sb.append(" UNION ");
			else
			{
				vCols = vc.getColumns(true);
				if (vCols == null || vCols.length == 0)
					throw new AdempiereException(Msg.getMsg(ctx, "NoViewColumnsSpecified"));
				
				if (viewColumnNames.size() > vCols.length)
					modified = true;
				
				boolean right = false;
				for (int j = 0; j < vCols.length; j++)
				{
					if (vCols[j].getColumnName().equals("*"))
					{
						modified = true;
						break;
					}
					if (j == 0)
					{
						sb.append("(");
						right = true;
					}
					else
						sb.append(", ");
					sb.append(vCols[j].getColumnName());
					
					if (!modified && j < viewColumnNames.size())
					{
						if (!viewColumnNames.get(j).equalsIgnoreCase(vCols[j].getColumnName()))
							modified = true;
					}
				}

				if (right)
					sb.append(")");
				sb.append(" AS ");
			}

			sb.append(vc.getSelect(false, vCols));
		}

		if (found && modified)
		{
			String sql = "DROP VIEW " + table.getTableName();
			int rvalue = DB.executeUpdate(sql, (Object[]) null, true, trxName);
			if (pi != null)
				pi.addLog(0, null, new BigDecimal(rvalue), sql);
		}
		String sql = sb.toString();
		int rvalue = DB.executeUpdate(sql, (Object[]) null, true, trxName);
		if (pi != null)
			pi.addLog(0, null, new BigDecimal(rvalue), sql);
		if(rvalue == -1)
			throw new AdempiereException(Msg.getMsg(ctx, "FailedCreateOrReplaceView"));
		else
			return Msg.getMsg(ctx, "CreatedOrReplacedViewSuccess");
	}
}
