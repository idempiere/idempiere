/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/
package org.compiere.process;

import java.math.BigDecimal;
import java.util.List;
import java.util.logging.Level;

import org.compiere.model.MClient;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.util.AdempiereUserError;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Language;


/**
 *	Document Translation Sync 
 *	
 *  @author Jorg Janke
 *  @version $Id: TranslationDocSync.java,v 1.2 2006/07/30 00:51:01 jjanke Exp $
 */
public class TranslationDocSync extends SvrProcess
{
	/**
	 *  Prepare - e.g., get Parameters.
	 */
	protected void prepare()
	{
		ProcessInfoParameter[] para = getParameter();
		for (int i = 0; i < para.length; i++)
		{
			String name = para[i].getParameterName();
			if (para[i].getParameter() == null)
				;
			else
				log.log(Level.SEVERE, "Unknown Parameter: " + name);
		}
	}	//	prepare

	/**
	 *  Perform process.
	 *  @return Message
	 *  @throws Exception
	 */
	protected String doIt() throws Exception
	{
		MClient client = MClient.get(getCtx());
		String baselang = Language.getBaseAD_Language();
		if (client.isMultiLingualDocument() && client.getAD_Language().equals(baselang)) {
			throw new AdempiereUserError("@AD_Client_ID@: @IsMultiLingualDocument@");
		}
		if (log.isLoggable(Level.INFO)) log.info("" + client);
		List<MTable> tables = new Query(getCtx(), "AD_Table", "TableName LIKE '%_Trl' AND TableName NOT LIKE 'AD%'", get_TrxName())
			.setOrderBy("TableName")
			.list();
		for (MTable table : tables) {
			processTable (table, client);
		}

		return "OK";
	}	//	doIt

	/**
	 * 	Process Translation Table
	 *	@param table table
	 */
	private void processTable (MTable table, MClient client)
	{
		StringBuilder columnNames = new StringBuilder();
		MColumn[] columns = table.getColumns(false);
		for (int i = 0; i < columns.length; i++)
		{
			MColumn column = columns[i];
			if (  (!column.getColumnName().equals(PO.getUUIDColumnName(table.getTableName())))
				&& (   column.getAD_Reference_ID() == DisplayType.String 
				    || column.getAD_Reference_ID() == DisplayType.Text))
			{
				String columnName = column.getColumnName();
				if (columnNames.length() != 0)
					columnNames.append(",");
				columnNames.append(columnName);
			}
		}
		String trlTable = table.getTableName();
		String baseTable = trlTable.substring(0, trlTable.length()-4);
		
		if (log.isLoggable(Level.CONFIG)) log.config(baseTable + ": " + columnNames);
		
		if (client.isMultiLingualDocument()) {
			String baselang = Language.getBaseAD_Language();
			if (client.getAD_Language().equals(baselang)) {
				// tenant language = base language
				// nothing to do
			} else {
				// tenant language <> base language
				// auto update translation for tenant language
				StringBuilder sql = new StringBuilder("UPDATE ").append(trlTable).append(" SET (")
						.append(columnNames).append(",IsTranslated) = (SELECT ").append(columnNames)
						.append(",'Y' FROM ").append(baseTable).append(" b WHERE ").append(trlTable).append(".")
						.append(baseTable).append("_ID=b.").append(baseTable).append("_ID) WHERE AD_Client_ID=")
						.append(getAD_Client_ID()).append(" AND AD_Language=").append(DB.TO_STRING(client.getAD_Language()));

				int no = DB.executeUpdate(sql.toString(), get_TrxName());
				addLog(0, null, new BigDecimal(no), baseTable);
			}
		} else {
			// auto update all translations
			StringBuilder sql = new StringBuilder("UPDATE ").append(trlTable).append(" SET (")
					.append(columnNames).append(",IsTranslated) = (SELECT ").append(columnNames)
					.append(",'Y' FROM ").append(baseTable).append(" b WHERE ").append(trlTable).append(".")
					.append(baseTable).append("_ID=b.").append(baseTable).append("_ID) WHERE AD_Client_ID=")
					.append(getAD_Client_ID());

			int no = DB.executeUpdate(sql.toString(), get_TrxName());
			addLog(0, null, new BigDecimal(no), baseTable);
		}
		
	}	//	processTable

}	//	TranslationDocSync
