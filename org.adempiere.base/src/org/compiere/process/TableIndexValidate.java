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

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MIndexColumn;
import org.compiere.model.MTableIndex;
import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Trx;

public class TableIndexValidate extends SvrProcess {

	private int		p_AD_TableIndex_ID = 0; 
	
	@Override
	protected void prepare() 
	{
		p_AD_TableIndex_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception 
	{
		MTableIndex index = new MTableIndex(getCtx(), p_AD_TableIndex_ID, get_TrxName());
		log.info(index.toString());
		
		Trx trx = Trx.get(get_TrxName(), true);
		DatabaseMetaData md = trx.getConnection().getMetaData();
		String tableName = index.getTableName();
		if (md.storesUpperCaseIdentifiers())
			tableName = tableName.toUpperCase();
		else if (md.storesLowerCaseIdentifiers())
			tableName = tableName.toLowerCase();
		
		String catalog = "REFERENCE";
		String schema = null;
		String[] indexColsFromDB = new String[30];
		int numIndexColsFromDB = 0;
		boolean indexNUniqueInDB = true;
		boolean found = false;
		
		ResultSet rs = md.getIndexInfo(catalog, schema, tableName, false, true);
		while (rs.next())
		{
			String dbIndexName = rs.getString("INDEX_NAME");			
			if (dbIndexName == null)
				continue;
			if (index.getName().equalsIgnoreCase(dbIndexName))
			{
				found = true;
				String columnName = rs.getString("COLUMN_NAME");
				int pos = (rs.getShort("ORDINAL_POSITION"));				
				if (pos > 0)
					indexColsFromDB[pos-1] = columnName;
				indexNUniqueInDB = rs.getBoolean("NON_UNIQUE");
			}
		}
		rs.close();
		trx.close();
		
		MIndexColumn[] indexCols = index.getColumns(true);
		boolean modified = false;
		
		if (indexCols.length <= 0)
			throw new AdempiereException(Msg.getMsg(getCtx(), "NoIndexColumnsSpecified"));
		else if (!found)
		{
			int rvalue = DB.executeUpdate(index.getDDL(), (Object[]) null, true, get_TrxName());
			if (rvalue == -1)
				throw new AdempiereException(Msg.getMsg(getCtx(), "Failed to create index"));
			else
				return Msg.getMsg(getCtx(), "CreatedIndexSuccess");			
		}
		else
		{
			//Found the index in DB
			for (int i = 0; i < 30; i++)
			{
				if (indexColsFromDB[i] != null)
					numIndexColsFromDB++;
				else
					break;
			}
			
			if (numIndexColsFromDB != indexCols.length)
				modified = true;
			else if (!indexNUniqueInDB != index.isUnique())
				modified = true;
			else
			{
				for (int j = 0; j < indexCols.length; j++)
				{
					/*what if they are returned in a diff sequence ?*/
					if (indexCols[j].getColumnName().equalsIgnoreCase(indexColsFromDB[j]))						
						continue;					
					else if ((indexColsFromDB[j].startsWith("\"")) && (indexColsFromDB[j].endsWith("\"")))
					{
						/* EDB returns varchar index columns wrapped with double quotes, hence comparing
						 * after stripping the quotes
						 */
						String cname = indexColsFromDB[j].substring(1, indexColsFromDB[j].length() - 1);
						if (cname.equalsIgnoreCase(indexCols[j].getColumnName()))
							continue;
						else
						{
							modified = true;
							break;
						}						
					}
					else
					{
						modified = true;
						break;
					}				
				}
			}
			
			if (modified)
			{
				int rvalue = DB.executeUpdate("DROP INDEX " + index.getName(), (Object[]) null, true, get_TrxName());							
				rvalue = DB.executeUpdate(index.getDDL(), (Object[]) null, true, get_TrxName());
				if(rvalue == -1)
					throw new AdempiereException(Msg.getMsg(getCtx(), "FailedModifyIndex"));
				else
					return Msg.getMsg(getCtx(), "ModifiedIndexSuccess");
			}
			else
				return Msg.getMsg(getCtx(), "NoChangesToIndex");
		}
	}
}