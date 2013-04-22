/**********************************************************************
* This file is part of iDempiere ERP Bazaar                           *
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
**********************************************************************/

package org.idempiere.fitnesse.fixture;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.util.DB;

import fitnesse.fixtures.TableFixture;

/**
 * @author juliana
 *
 */
public class DeleteRecord extends TableFixture {

	/* (non-Javadoc)
	 * @see fitnesse.fixtures.TableFixture#doStaticTable(int)
	 */

	private volatile static Instance adempiereInstance = null;
	
	
	@Override
	protected void doStaticTable(int rows) {
		adempiereInstance = Static_iDempiereInstance.getInstance();
		
		if (adempiereInstance.getAdempiereService() == null
				|| !adempiereInstance.getAdempiereService().isLoggedIn()) {
			wrong(rows - 1, 1);
			getCell(rows - 1, 1).addToBody("not logged in");
			return;
		}
		Properties ctx = adempiereInstance.getAdempiereService().getCtx();
		int windowNo = adempiereInstance.getAdempiereService().getWindowNo();

		PO gpo = null;
		String tableName = new String("");
		boolean tableOK = false;
		MTable table = null;

		boolean alreadyread = false;
		StringBuilder whereclause = new StringBuilder("");
		boolean isErrorExpected = false;
		String msgerror = null;
		
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
			
			} else if (cell_title.equalsIgnoreCase("*Where*")) {
				if (i != 1) {
					exception(getCell(i, 1), new Exception("*Where* must be defined in second row"));
					return;
				}
				whereclause.append(cell_value);
			} else if (cell_title.equalsIgnoreCase("*Delete*") || cell_title.equalsIgnoreCase("*Delete*Error*")) {
				isErrorExpected = "*Delete*Error*".equalsIgnoreCase(cell_title);
				msgerror = cell_value;
				if (!tableOK) {
					getCell(i, 1).addToBody("Table " + tableName + " does not exist");
					wrong(i, 1);
					return;
				}
				if (whereclause.length() == 0) {
					getCell(i, 1).addToBody("No where clause");
					wrong(i, 1);
					return;
				}
				String sql = "SELECT * FROM " + tableName + " WHERE "+ whereclause;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try {
					pstmt = DB.prepareStatement(sql, null);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						gpo = table.getPO(rs, null);
					} else {
						getCell(i, 1).addToBody("No record found: " + sql);
						boolean ok = Util.evaluateError("No record found: ",cell_value, isErrorExpected);
						if (ok) {
							right(i, 1);
						} else {
							wrong(i, 1);
						}
						return;
					}
					if (rs.next()) {
						getCell(i, 1).addToBody("More than one record found: " + sql);
						boolean ok = Util.evaluateError("More than one record found: ", cell_value,isErrorExpected);
						if (ok) {
							right(i, 1);
						} else {
							wrong(i, 1);
						}
						return;
					}
					
					if (gpo != null) {
						gpo.deleteEx(true);
					}
							
				} catch (Exception e) {
					boolean ok = Util.evaluateError(e.getMessage(), msgerror, isErrorExpected);
					if (ok) {
						right(getCell(i, 1));
					} else {
						exception(getCell(i, 1), e);
					}
					return;
				} finally {
					DB.close(rs, pstmt);
					rs = null;
					pstmt = null;
				}
				right(i, 1);				
				alreadyread = true;
			} else {
				// columns
				if (tableOK) {
					String value_evaluated = Util.evaluate(ctx, windowNo,cell_value, getCell(i, 1));
					if (!alreadyread) {
						// not read yet - add value to where clause						
						if (whereclause.length() > 0)
							whereclause.append(" AND ");
						whereclause.append(cell_title).append("=").append(value_evaluated);
					}
				}
			}
		}//end while

	}

}
