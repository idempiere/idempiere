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

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;

import org.compiere.model.MColumn;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.POInfo;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.ValueNamePair;

import fitnesse.fixtures.TableFixture;

/**
 * 
 * iDempiere Update Record fixture for use with fitnesse framework testing
 * @author juliana
 *
 */
public class UpdateRecord extends TableFixture {

	/* (non-Javadoc)
	 * @see fitnesse.fixtures.TableFixture#doStaticTable(int)
	 */
	
	private volatile static Instance adempiereInstance = null;
	
	@Override
	protected void doStaticTable(int rows) {
		
		if (adempiereInstance == null) {
			adempiereInstance = Static_iDempiereInstance.getInstance();
		}
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
		boolean columnsOK = true;
		MTable table = null;
		POInfo poinfo = null;

		boolean alreadyread = false;
		StringBuilder whereclause = new StringBuilder();
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
		    	poinfo = POInfo.getPOInfo(ctx, table!=null ? table.getAD_Table_ID() : 0);
			
			} else if (cell_title.equalsIgnoreCase("*Where*")) {
				if (i != 1) {
					exception(getCell(i, 1), new Exception("*Where* must be defined in second row"));
					return;
				}
				whereclause.append(cell_value);
			} else if (cell_title.equalsIgnoreCase("*Update*") || cell_title.equalsIgnoreCase("*Update*Error*")) {
				isErrorExpected = "*Update*Error*".equalsIgnoreCase(cell_title);
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
				whereclause = whereclause.append(" AND AD_Client_ID=").append(Env.getAD_Client_ID(ctx));
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
				} catch (SQLException e) {
					boolean ok = Util.evaluateError(e.getMessage(),cell_value, isErrorExpected);
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
				if (gpo != null) {
					getCell(i, 1).addToBody(gpo.toString());
				}
				alreadyread = true;
			} else {
				// columns
				if (tableOK) {
					String value_evaluated = Util.evaluate(ctx, windowNo,cell_value, getCell(i, 1));
					if (!alreadyread) {
						// not read yet - add value to where clause						
						if (whereclause.length() > 0) {
							whereclause.insert(0, "(");
							whereclause.append(") AND ");
						}
						whereclause.append(cell_title).append("=").append(value_evaluated);
					} else {
						if (gpo != null) {
							String columnName = cell_title;
							int idxcol = gpo.get_ColumnIndex(columnName);
							if (idxcol < 0) {
								wrong(i,0);
								// column does not exist in dictionary - anyways try custom column in case it exists in table
								gpo.set_CustomColumnReturningBoolean(columnName, cell_value);
							} else {
								Class<?> columnClass = poinfo.getColumnClass(idxcol);
								// set value according to class
								Object value = null;
								if (org.compiere.util.Util.isEmpty(cell_value)) {
									value = null;
								} else if (org.compiere.util.Util.isEmpty(value_evaluated)) {
									boolean ok = Util.evaluateError("Data not found",msgerror,isErrorExpected);
									if (ok)
										right(i,1);
									else
										wrong(i,1);
									columnsOK = false;
									continue;
								} else if (columnClass == Boolean.class) {
									if ("Y".equalsIgnoreCase(value_evaluated) || "true".equalsIgnoreCase(value_evaluated))
										value = new Boolean(true);
									else if ("N".equalsIgnoreCase(value_evaluated) || "false".equalsIgnoreCase(value_evaluated))
										value = new Boolean(false);
									else {
										exception(getCell(i, 1), new Exception("Wrong value for boolean, allowed Y/N/true/false"));
										continue;
									}
								} else if (columnClass == Integer.class) {
									try {
										Integer intid = Integer.parseInt(value_evaluated);
										MColumn column = table.getColumn(cell_title);
										if (intid > 0 && (DisplayType.isID(column.getAD_Reference_ID()) || column.getAD_Reference_ID() != DisplayType.ID)) {
											// Evaluate the ID is from the actual client or system
											String foreignTable = column.getReferenceTableName();
											if (foreignTable != null) {
												int foreignClient = DB.getSQLValueEx(null,
														"SELECT AD_Client_ID FROM " + foreignTable + " WHERE " + foreignTable + "_ID=?",
														intid);
												if (foreignClient != 0 && foreignClient != Env.getAD_Client_ID(ctx)) {
													boolean ok = Util.evaluateError("Data not found", msgerror, isErrorExpected);
													if (ok)
														right(i, 1);
													else
														wrong(i, 1);
													columnsOK = false;
													continue;
												}
											}									
										}
										value = intid;
									} catch (NumberFormatException e) {
										exception(getCell(i, 1), e);
										continue;
									}
								} else if (columnClass == BigDecimal.class) {
									try {
										value = new BigDecimal(value_evaluated);
									} catch (Exception e) {
										exception(getCell(i, 1), e);
										continue;
									}
								} else if (columnClass == Timestamp.class) {
									try {
										value = Timestamp.valueOf(value_evaluated);
									} catch (Exception e) {
										exception(getCell(i, 1), e);
										continue;
									}
								} else if (columnClass == byte[].class) {
									exception(getCell(i, 1), new Exception("LOB not supported"));
									continue;
								} else  {
									value = value_evaluated;
								}
								try {
									if (!gpo.set_ValueOfColumnReturningBoolean(columnName, value)) {
										columnsOK = false;
										boolean ok = Util.evaluateError("Cannot set value of column", cell_value, isErrorExpected);
										if (ok)
											right(getCell(i, 1));
										else
											exception(getCell(i, 1), new Exception("Cannot set value of column"));
									}
								} catch (Exception e) {
									columnsOK = false;
									boolean ok = Util.evaluateError(e.getMessage(), cell_value, isErrorExpected);
									if (ok)
										right(getCell(i, 1));
									else
										exception(getCell(i, 1), e);
								}
							}
						}						
					}
				}
			}
		} //end for
		if (tableOK && columnsOK && gpo != null) {
			int i = rows-1;
			if (!gpo.save()) {
				StringBuilder msg = new StringBuilder();
				Exception e = (Exception) ctx.get("org.compiere.util.CLogger.lastException");
				if (e != null)
					msg.append("Exception: "+ e.getMessage());
				else {
					ValueNamePair vnp = (ValueNamePair) ctx.get("org.compiere.util.CLogger.lastError");
					if (vnp != null)
						msg.append("Error: " + vnp.getName());
				}
				getCell(i, 1).addToBody(msg.toString());
				boolean ok = Util.evaluateError(msg.toString(),msgerror,isErrorExpected);
				if (ok)
					right(i,1);
				else
					wrong(i,1);
			} else {
				if (isErrorExpected) {
					wrong(i,1);
				} else {
					right(i, 1);
				}
				getCell(i, 1).addToBody(gpo.toString());
				for (int idx = 0; idx < poinfo.getColumnCount(); idx++) {
					String colname = poinfo.getColumnName(idx);
					Object result = gpo.get_Value(colname);
					if (result != null)
						Env.setContext(ctx, windowNo, poinfo.getTableName().toLowerCase() + "." + colname.toLowerCase(), result.toString());
				}
			}
		}
	
	}

}
