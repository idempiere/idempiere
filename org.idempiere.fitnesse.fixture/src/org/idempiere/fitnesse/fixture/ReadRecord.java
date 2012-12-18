/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Carlos Ruiz                                           *
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
***********************************************************************/

package org.idempiere.fitnesse.fixture;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.util.DB;
import org.compiere.util.Env;

import fitnesse.fixtures.TableFixture;

/**
 *	iDempiere Read Record fixture for use with fitnesse framework testing
 *
 *  @author Carlos Ruiz - globalqss
 */
public class ReadRecord extends TableFixture {
	private volatile static Instance adempiereInstance = null;

	@Override
	protected void doStaticTable(int rows) {
		if (adempiereInstance == null) {
			adempiereInstance = Static_iDempiereInstance.getInstance();
		}
		if (adempiereInstance.getAdempiereService() == null || ! adempiereInstance.getAdempiereService().isLoggedIn()) {
			wrong(rows-1, 1);
			getCell(rows-1, 1).addToBody("not logged in");
			return;
		}
		Properties ctx = adempiereInstance.getAdempiereService().getCtx();
		int windowNo = adempiereInstance.getAdempiereService().getWindowNo();

		PO gpo = null;
		String tableName  = new String("");
		boolean tableOK = false;
		MTable table = null;
		POInfo poinfo = null;
		boolean alreadyread = false;
		String whereclause = new String("");
		for (int i = 0; i < rows; i++) {
			String cell_title = getText(i, 0);
			String cell_value = getText(i, 1);
			if (cell_title.equalsIgnoreCase("*Table*")) {
				if (i > 0) {
					exception(getCell(i, 1), new Exception("*Table* must be defined in first row"));
					return;
				}
				tableName = cell_value;
				table = MTable.get(ctx, tableName);
				if (table == null || table.get_ID() <= 0) {
					wrong(i, 1);
					tableOK = false;
				} else {
					tableOK = true;
				}
		    	poinfo = POInfo.getPOInfo(ctx, table!=null ? table.getAD_Table_ID() : 0);
			} else if (cell_title.equalsIgnoreCase("*Where*")) {
				if (i != 1) {
					exception(getCell(i, 1), new Exception("*Where* must be defined in second row"));
					return;
				}
				whereclause = cell_value;
			} else if (cell_title.equalsIgnoreCase("*Read*")) {
				if (! tableOK) {
					getCell(i, 1).addToBody("Table " + tableName + " does not exist");
					wrong(i, 1);
					return;
				} 
				if (whereclause.length() == 0) {
					getCell(i, 1).addToBody("No where clause");
					wrong(i, 1);
					return;
				}
				String sql = "SELECT * FROM " + tableName + " WHERE " + whereclause;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try
				{
					pstmt = DB.prepareStatement(sql, null);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						gpo = table.getPO(rs, null);
					} else {
						getCell(i, 1).addToBody("No record found: " + sql);
						wrong(i, 1);
						return;
					}
					if (rs.next()) {
						getCell(i, 1).addToBody("More than one record found: " + sql);
						wrong(i, 1);
						return;
					}
				}
				catch (SQLException e)
				{
					exception(getCell(i, 1), e);
					return;
				}
				finally
				{
					DB.close(rs, pstmt);
					rs = null;
					pstmt = null;
				}
				right(i, 1);
				getCell(i, 1).addToBody(gpo.toString());
				// read - set context variables
				for (int idx = 0; idx < poinfo.getColumnCount(); idx++) {
					String colname = poinfo.getColumnName(idx);
					Object result = gpo.get_Value(colname);
					if (result != null)
						Env.setContext(ctx, windowNo, poinfo.getTableName().toLowerCase() + "." + colname.toLowerCase(), result.toString());
				}
				alreadyread = true;
			} else {
				// columns
				if (tableOK) {
					if (! alreadyread) {
						// not read yet - add value to where clause
						String value_evaluated = Util.evaluate(ctx, windowNo, cell_value, getCell(i, 1));
						if (whereclause.length() > 0)
							whereclause = whereclause + " AND ";
						whereclause = whereclause + cell_title + "=" + value_evaluated;
					} else {
						// already read, show the value of context variable
						Object result = gpo.get_Value(cell_title);
						if (result != null)
							getCell(i, 1).addToBody(result.toString());
					}
				}
			}
		}
	} // doStaticTable

} // AdempiereReadRecord
