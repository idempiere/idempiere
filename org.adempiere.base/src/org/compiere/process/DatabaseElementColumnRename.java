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
import org.compiere.model.M_Element;
import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Util;

@org.adempiere.base.annotation.Process
public class DatabaseElementColumnRename extends SvrProcess {

	private int p_AD_Element_ID = 0;
	// New Column Name
	private String p_NewColumnName;

	@Override
	protected void prepare() {
		for (ProcessInfoParameter para : getParameter()) {
			String name = para.getParameterName();
			if ("NewColumnName".equals(name)) {
				p_NewColumnName = para.getParameterAsString();
			} else {
				if (log.isLoggable(Level.INFO))
					log.log(Level.INFO, "Custom Parameter: " + name + "=" + para.getInfo());
			}
		}
		p_AD_Element_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception {
		M_Element element = new M_Element(getCtx(), p_AD_Element_ID, get_TrxName());
		log.info(element.toString());
		if (   Util.isEmpty(p_NewColumnName, true)
			|| p_NewColumnName.toLowerCase().equals(element.getColumnName().toLowerCase())) {
			throw new AdempiereException(Util.cleanAmp(Msg.parseTranslation(getCtx(), "@NotValid@: @NewColumnName@")));
		}
		// Validate there is not another element with new column name
		int cnt = DB.getSQLValueEx(get_TrxName(),
				"SELECT COUNT(*) FROM AD_Element WHERE UPPER(ColumnName)=UPPER(?)",
				p_NewColumnName);
		if (cnt > 0) {
			throw new AdempiereException(Util.cleanAmp(Msg.parseTranslation(getCtx(), "@AlreadyExists@: @ColumnName@ = " + p_NewColumnName)));
		}
		// Validate there are not columns with this element in views
		cnt = DB.getSQLValueEx(get_TrxName(),
				"SELECT COUNT(*) FROM AD_Column c JOIN AD_Table t ON (t.AD_Table_ID=c.AD_Table_ID) WHERE c.AD_Element_ID=? AND t.IsView='Y'",
				p_AD_Element_ID);
		if (cnt > 0) {
			throw new AdempiereException(Util.cleanAmp(Msg.parseTranslation(getCtx(), "Not implemented yet - cannot change column in view")));
		}

		element.renameDBColumn(p_NewColumnName, getProcessInfo());
		element.saveEx();
		
		return "@OK@";
	}
} // DatabaseElementColumnRename
