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
 * - Carlos Ruiz - globalqss                                           *
 **********************************************************************/

package org.compiere.process;

import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MTable;
import org.compiere.model.M_Element;
import org.compiere.model.Query;
import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Util;

public class DatabaseTableRename extends SvrProcess {

	private int p_AD_Table_ID = 0;
	// New Column Name
	private String p_NewTableName;

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			if ("NewTableName".equals(name)) {
				p_NewTableName = para.getParameterAsString();
			} else {
				if (log.isLoggable(Level.INFO))
					log.log(Level.INFO, "Custom Parameter: " + name + "=" + para.getInfo());
			}
		}
		p_AD_Table_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception {
		MTable table = new MTable(getCtx(), p_AD_Table_ID, get_TrxName());
		log.info(table.toString());
		if (   Util.isEmpty(p_NewTableName, true)
			|| p_NewTableName.toLowerCase().equals(table.getTableName().toLowerCase())) {
			throw new AdempiereException(Util.cleanAmp(Msg.parseTranslation(getCtx(), "@NotValid@: @NewTableName@")));
		}
		int cnt = DB.getSQLValueEx(get_TrxName(),
				"SELECT COUNT(*) FROM AD_Table WHERE LOWER(TableName)=?",
				p_NewTableName.toLowerCase());
		if (cnt > 0) {
			throw new AdempiereException(Util.cleanAmp(Msg.parseTranslation(getCtx(), "@AlreadyExists@: @TableName@ = " + p_NewTableName)));
		}

		String colPrefix = table.getTableName().toLowerCase();
		List<M_Element> elements = new Query(getCtx(), M_Element.Table_Name, "LOWER(ColumnName) IN (?, ?)", get_TrxName())
				.setParameters(colPrefix+"_id", colPrefix+"_uu")
				.setOrderBy("AD_Element_ID")
				.list();
		for (M_Element element : elements) {
			String newColumnName;
			if (element.getColumnName().toLowerCase().endsWith("_id")) {
				newColumnName = p_NewTableName + "_ID";
			} else {
				newColumnName = p_NewTableName + "_UU";
			}
			element.renameDBColumn(newColumnName, getProcessInfo());
			element.saveEx();
		}
		
		String sql = "ALTER TABLE " + table.getTableName() + " RENAME TO " + p_NewTableName;
		int rvalue = DB.executeUpdateEx(sql, get_TrxName());
		addLog(rvalue + " - " + sql);

		table.setTableName(p_NewTableName);
		table.saveEx();
		
		return "@OK@";
	}
} // DatabaseTableRename
