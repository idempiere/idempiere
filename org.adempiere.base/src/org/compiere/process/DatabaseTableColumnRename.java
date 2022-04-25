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

import java.util.logging.Level;

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MColumn;
import org.compiere.model.M_Element;
import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Util;

@org.adempiere.base.annotation.Process
public class DatabaseTableColumnRename extends SvrProcess {

	// New Element
	private int p_AD_Element_ID = 0;
	// This Column
	private int p_AD_Column_ID = 0;

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			if ("AD_Element_ID".equals(name)) {
				p_AD_Element_ID = para.getParameterAsInt();
			} else {
				if (log.isLoggable(Level.INFO))
					log.log(Level.INFO, "Custom Parameter: " + name + "=" + para.getInfo());
			}
		}
		p_AD_Column_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception {
		MColumn column = new MColumn(getCtx(), p_AD_Column_ID, get_TrxName());
		M_Element element = new M_Element(getCtx(), p_AD_Element_ID, get_TrxName());
		if (column.getAD_Element_ID() == p_AD_Element_ID || element.getAD_Element_ID() <= 0) {
			throw new AdempiereException(Util.cleanAmp(Msg.parseTranslation(getCtx(), "@NotValid@: @AD_Element_ID@")));
		}
		String newColumnName = element.getColumnName();
		// Validate there is not another element with new column name
		int cnt = DB.getSQLValueEx(get_TrxName(),
				"SELECT COUNT(*) FROM AD_Column WHERE AD_Table_ID=? AND UPPER(ColumnName)=UPPER(?)",
				column.getAD_Table_ID(), newColumnName);
		if (cnt > 0) {
			throw new AdempiereException(Util.cleanAmp(Msg.parseTranslation(getCtx(), "@AlreadyExists@: @ColumnName@ = " + newColumnName)));
		}

		column.setAD_Element_ID(p_AD_Element_ID);
		column.setName(element.getName());
		column.setDescription(element.getDescription());
		column.setHelp(element.getHelp());
		column.setPlaceholder(element.getPlaceholder());
		String msg = column.renameDBColumn(newColumnName);
		column.saveEx();
		addLog(msg);

		return "@OK@";
	}
} // DatabaseTableColumnRename
