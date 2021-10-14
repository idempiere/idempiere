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
import org.compiere.model.MClient;
import org.compiere.model.MRefTable;
import org.compiere.model.MSequence;
import org.compiere.model.MTab;
import org.compiere.model.MTable;
import org.compiere.model.M_Element;
import org.compiere.model.Query;
import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Util;

@org.adempiere.base.annotation.Process
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
		String oldTableName = table.getTableName();
		log.info(table.toString());
		if (   Util.isEmpty(p_NewTableName, true)
			|| p_NewTableName.toLowerCase().equals(oldTableName.toLowerCase())) {
			throw new AdempiereException(Util.cleanAmp(Msg.parseTranslation(getCtx(), "@NotValid@: @NewTableName@")));
		}
		int cnt = DB.getSQLValueEx(get_TrxName(),
				"SELECT COUNT(*) FROM AD_Table WHERE LOWER(TableName)=?",
				p_NewTableName.toLowerCase());
		if (cnt > 0) {
			throw new AdempiereException(Util.cleanAmp(Msg.parseTranslation(getCtx(), "@AlreadyExists@: @TableName@ = " + p_NewTableName)));
		}

		String regex = "(?i)\\b" + oldTableName + "\\.";
		String fullregex = ".*" + regex + ".*";

		// Rename table in WhereClause and OrderByClause in AD_Tab
		List<MTab> tabs = new Query(getCtx(), MTab.Table_Name, "AD_Table_ID=? AND (WhereClause IS NOT NULL OR OrderByClause IS NOT NULL)", get_TrxName())
				.setParameters(p_AD_Table_ID)
				.list();
		for (MTab tab : tabs) {
			boolean changed = false;
			String whereClause = tab.getWhereClause();
			if (whereClause != null && whereClause.matches(fullregex)) {
				whereClause = whereClause.replaceAll(regex, p_NewTableName + ".");
				tab.setWhereClause(whereClause);
				changed = true;
			}
			String orderByClause = tab.getOrderByClause();
			if (orderByClause != null && orderByClause.matches(fullregex)) {
				orderByClause = orderByClause.replaceAll(regex, p_NewTableName + ".");
				tab.setOrderByClause(orderByClause);
				changed = true;
			}
			if (changed) {
				tab.saveEx();
				addLog(0, null, null, "@Updated@ @AD_Tab_ID@ " + tab.getName(), MTab.Table_ID, tab.getAD_Tab_ID());
			}
		}

		// Rename table in WhereClause and OrderByClause in AD_Ref_Table
		List<MRefTable> refts = new Query(getCtx(), MRefTable.Table_Name, "AD_Table_ID=? AND (WhereClause IS NOT NULL OR OrderByClause IS NOT NULL)", get_TrxName())
				.setParameters(p_AD_Table_ID)
				.list();
		for (MRefTable reft : refts) {
			boolean changed = false;
			String whereClause = reft.getWhereClause();
			if (whereClause != null && whereClause.matches(fullregex)) {
				whereClause = whereClause.replaceAll(regex, p_NewTableName + ".");
				reft.setWhereClause(whereClause);
				changed = true;
			}
			String orderByClause = reft.getOrderByClause();
			if (orderByClause != null && orderByClause.matches(fullregex)) {
				orderByClause = orderByClause.replaceAll(regex, p_NewTableName + ".");
				reft.setOrderByClause(orderByClause);
				changed = true;
			}
			if (changed) {
				reft.saveEx();
				addLog(0, null, null, "@Updated@ @AD_Reference_ID@ " + reft.getAD_Reference().getName(), MRefTable.Table_ID, reft.getAD_Reference_ID());
			}
		}
		
		// Rename table in sequences
		String whereSeq = "(Name=? AND Description=? AND IsTableID='Y') OR (Name=? AND Description=? AND IsTableID='N')";
		List<MSequence> seqs = new Query(getCtx(), MSequence.Table_Name, whereSeq, get_TrxName())
				.setParameters(
						oldTableName,
						"Table "+oldTableName,
						"DocumentNo_"+oldTableName,
						"DocumentNo/Value for Table "+oldTableName
				)
				.list();
		for (MSequence seq : seqs) {
			if (seq.isTableID()) {
				seq.setName(p_NewTableName);
				seq.setDescription("Table "+p_NewTableName);
			} else {
				seq.setName("DocumentNo_"+p_NewTableName);
				seq.setDescription("DocumentNo/Value for Table "+p_NewTableName);
			}
			seq.saveEx();
			if (seq.getAD_Client_ID() == 0) {
				addLog(0, null, null, "@Updated@ @AD_Sequence_ID@ " + seq.getName(), MSequence.Table_ID, seq.getAD_Sequence_ID());
			} else {
				addLog(0, null, null, "@Updated@ @AD_Sequence_ID@ " + seq.getName() + ", @AD_Client_ID@ " + MClient.get(seq.getAD_Client_ID()).getName());
			}
		}
		
		String colPrefix = oldTableName.toLowerCase();
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
		
		String sql = "ALTER TABLE " + oldTableName + " RENAME TO " + p_NewTableName;
		int rvalue = DB.executeUpdateEx(sql, get_TrxName());
		addLog(rvalue + " - " + sql);

		table.setTableName(p_NewTableName);
		table.saveEx();
		
		return "@OK@";
	}
} // DatabaseTableRename
