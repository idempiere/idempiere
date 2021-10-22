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

import org.adempiere.exceptions.AdempiereException;
import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.Msg;
import org.compiere.util.Util;

@org.adempiere.base.annotation.Process
public class DatabaseConstraintDrop extends SvrProcess {

	private int p_AD_Column_ID = 0;

	@Override
	protected void prepare() {
		p_AD_Column_ID = getRecord_ID();
	}

	@Override
	protected String doIt() throws Exception {
		MColumn column = new MColumn(getCtx(), p_AD_Column_ID, get_TrxName());
		log.info(column.toString());
		if (Util.isEmpty(column.getFKConstraintName(), true)) {
			throw new AdempiereException(Msg.parseTranslation(getCtx(), "@NotValid@: @FKConstraintName@"));
		}

		MTable table = new MTable(getCtx(), column.getAD_Table_ID(), get_TrxName());

		String sql = "ALTER TABLE " + table.getTableName() + " DROP CONSTRAINT " + column.getFKConstraintName();
		int rvalue = DB.executeUpdateEx(sql, get_TrxName());

		return rvalue + " - " + sql;
	}
} // DatabaseConstraintDrop
