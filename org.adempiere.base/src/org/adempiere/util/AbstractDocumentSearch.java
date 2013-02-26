/**********************************************************************
* This file is part of Adempiere ERP Bazaar                           *
* http://www.adempiere.org                                            *
*                                                                     *
* Copyright (C) Jan Roessler - Schaeffer                              *
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
* - Jan Roessler                                                      *
* - Heng Sin Low                                                      *
*                                                                     *
* Sponsors:                                                           *
* - Schaeffer                                                         *
**********************************************************************/
package org.adempiere.util;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Vector;
import java.util.logging.Level;

import org.compiere.model.MColumn;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MSearchDefinition;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Util;

/**
 * Executes search and opens windows for defined transaction codes
 *
 * @author Jan Roessler, jr@schaeffer-ag.de
 *
 */
public abstract class AbstractDocumentSearch {

	/** the logger */
	static CLogger log = CLogger.getCLogger(AbstractDocumentSearch.class);
	protected boolean windowOpened = false;

	/**
	 * @param searchString
	 */
	public boolean openDocumentsByDocumentNo(String searchString) {
		windowOpened = false;
		StringBuilder msglog = new StringBuilder();
				
		msglog.append("Search started with String: ").append(searchString);
		if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());

		// Check if / how many transaction-codes are used
		if (! Util.isEmpty(searchString)) {
			String[] codes = searchString.trim().replaceAll("  ", " ").split(" ");

			List<String> codeList = new ArrayList<String>();
			boolean codeSearch = true;
			StringBuilder search = new StringBuilder();

			// Analyze String to separate transactionCodes from searchString
			for (int i = 0; i < codes.length; i++) {
				try {
					String s = codes[i];
					if (MSearchDefinition.isValidTransactionCode(s) && codeSearch) {
						codeList.add(s);
					} else {
						// Build the searchString with eventually appearing
						// whitespaces
						codeSearch = false;
						search.append(s);
						if (i != (codes.length - 1)) {
							search.append(" ");
						}
					}
				} catch (SQLException e) {
					log.severe(e.toString());
					e.printStackTrace();
				}
			}

			// Start the search for every single code
			if (codeList.size() > 0) {
				for (int i = 0; i < codeList.size(); i++) {
						msglog = new StringBuilder("Search with Transaction: '");
						msglog.append(codeList.get(i)).append("' for: '")
							  .append(search.toString()).append("'");								
					if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
					getID(codeList.get(i), search.toString());
				}
			} else {
				msglog = new StringBuilder("Search without Transaction: ").append(search.toString());
				if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
				getID(null, search.toString());
			}
		} else {
			log.fine("Search String is invalid");
		}
		return windowOpened;
	}

	/**
	 * search for id's that fit the searchString
	 *
	 * @param transactionCode
	 * @param searchString
	 */
	private void getID(String transactionCode, String searchString) {

		ResultSet rsSO = null;
		ResultSet rsPO = null;
		PreparedStatement pstmtSO = null;
		PreparedStatement pstmtPO = null;
		StringBuilder sqlSO = null;
		StringBuilder sqlPO = null;
		StringBuilder msglog = null;
		

		final Properties ctx = Env.getCtx();
		final MRole role = MRole.get(ctx, Env.getAD_Role_ID(ctx), Env.getAD_User_ID(ctx), true);

		try {
			for (MSearchDefinition msd : MSearchDefinition.getForCode(transactionCode)) {

				MTable table = new MTable(Env.getCtx(), msd.getAD_Table_ID(), null);
				// SearchDefinition with a given table and column
				if (msd.getSearchType().equals(MSearchDefinition.SEARCHTYPE_TABLE)) {
					MColumn column = new MColumn(Env.getCtx(), msd.getAD_Column_ID(), null);
					sqlSO = new StringBuilder("SELECT ").append(table.getTableName()).append("_ID FROM ").append(table.getTableName())
							.append(" ");
					// search for an Integer
					if (msd.getDataType().equals(MSearchDefinition.DATATYPE_INTEGER)) {
						sqlSO.append("WHERE ").append(column.getColumnName()).append("=?");
						// search for a String
					} else {
						sqlSO.append("WHERE UPPER(").append(column.getColumnName()).append(") LIKE UPPER(?)");
					}

					if (msd.getPO_Window_ID() != 0) {
						sqlPO = new StringBuilder(sqlSO.toString()).append(" AND IsSOTrx='N'");
						sqlSO.append(" AND IsSOTrx='Y'");
					}
					pstmtSO = DB.prepareStatement(sqlSO.toString(), null);
					pstmtPO = DB.prepareStatement(sqlPO.toString(), null);
					// search for a Integer
					if (msd.getDataType().equals(MSearchDefinition.DATATYPE_INTEGER)) {
						pstmtSO.setInt(1, Integer.valueOf(searchString.replaceAll("\\D", "")));
						if (msd.getPO_Window_ID() != 0) {
							pstmtPO.setInt(1, Integer.valueOf(searchString.replaceAll("\\D", "")));
						}
						// search for a String
					} else if (msd.getDataType().equals(MSearchDefinition.DATATYPE_STRING)) {
						pstmtSO.setString(1, searchString);
						if (msd.getPO_Window_ID() != 0) {
							pstmtPO.setString(1, searchString);
						}
					}
					// SearchDefinition with a special query
				} else if (msd.getSearchType().equals(MSearchDefinition.SEARCHTYPE_QUERY)) {
					sqlSO = new StringBuilder().append(msd.getQuery());
					pstmtSO = DB.prepareStatement(sqlSO.toString(), null);
					// count '?' in statement
					int count = 1;
					for (char c : sqlSO.toString().toCharArray()) {
						if (c == '?') {
							count++;
						}
					}
					for (int i = 1; i < count; i++) {
						if (msd.getDataType().equals(MSearchDefinition.DATATYPE_INTEGER)) {
							pstmtSO.setInt(i, Integer.valueOf(searchString.replaceAll("\\D", "")));
						} else if (msd.getDataType().equals(MSearchDefinition.DATATYPE_STRING)) {
							pstmtSO.setString(i, searchString);
						}
					}
				}
				if (pstmtSO != null) {
					msglog = new StringBuilder("SQL Sales: ").append(sqlSO.toString());
					if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
					rsSO = pstmtSO.executeQuery();
					Vector<Integer> idSO = new Vector<Integer>();
					while (rsSO.next()) {
						idSO.add(new Integer(rsSO.getInt(1)));
					}
					if (role.getWindowAccess(msd.getAD_Window_ID()) != null) {
						msglog = new StringBuilder("Open Window: ").append(msd.getAD_Window_ID()).append(" / Table: ")
									.append(table.getTableName()).append(" / Number of Results: ").append(idSO.size());
						if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());

						if (idSO.size() == 0 && (searchString == null || searchString.trim().length() == 0)) {
							// No search string - open the window with new record
							idSO.add(new Integer(0));
						}

						openWindow(idSO, table.getTableName(), msd.getAD_Window_ID());
					} else {
						log.warning("Role is not allowed to view this window");
					}
				}
				if (pstmtPO != null) {
					msglog = new StringBuilder("SQL Purchase: ").append(sqlPO);
					if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
					rsPO = pstmtPO.executeQuery();
					Vector<Integer> idPO = new Vector<Integer>();
					while (rsPO.next()) {
						idPO.add(new Integer(rsPO.getInt(1)));
					}
					if (role.getWindowAccess(msd.getPO_Window_ID()) != null) {
						msglog = new StringBuilder("Open Window: ").append(msd.getPO_Window_ID()).append(" / Table: ")
								.append(table.getTableName()).append(" / Number of Results: ").append(idPO.size());						
						if (log.isLoggable(Level.FINE)) log.fine(msglog.toString());
						openWindow(idPO, table.getTableName(), msd.getPO_Window_ID());
					} else {
						log.warning("Role is not allowed to view this window");
					}
				}
				DB.close(rsSO, pstmtSO);
				DB.close(rsPO, pstmtPO);
				pstmtSO = null;
				pstmtPO = null;
				rsSO = null;
				rsPO = null;
			}
		} catch (Exception e) {
			log.severe(e.toString());
			e.printStackTrace();
		} finally {
			DB.close(rsSO, pstmtSO);
			DB.close(rsPO, pstmtPO);
			rsSO = null;
			rsPO = null;
			pstmtSO = null;
			pstmtPO = null;
		}
	}

	/**
	 * opens window with the given documents
	 *
	 * @param ids
	 *            - document id's
	 * @param tableName
	 * @param windowId
	 */
	private void openWindow(Vector<Integer> ids, String tableName, int windowId) {
		if (ids == null || ids.size() == 0) {
			return;
		}
		StringBuilder whereString = new StringBuilder(" ").append(tableName).append("_ID");
		// create query string
		if (ids.size() == 1) {
			if (ids.get(0).intValue() == 0) {
				whereString = null;
			} else {
				whereString.append("=").append(ids.get(0).intValue());
			}
		} else {
			whereString.append(" IN (");
			for (int i = 0; i < ids.size(); i++) {
				whereString.append(ids.get(i).intValue());
				if (i < ids.size() - 1) {
					whereString.append(",");
				} else {
					whereString.append(") ");
				}
			}
		}

		final MQuery query = new MQuery(tableName);
		if (whereString != null) {
			if (log.isLoggable(Level.FINE)) log.fine(whereString.toString());
			query.addRestriction(whereString.toString());
		}
		final boolean ok = openWindow(windowId, query);
		if (!ok) {
			StringBuilder msglog = new StringBuilder("Unable to open window: ").append(whereString.toString());			
			log.severe(msglog.toString());
		}
		if (!windowOpened && ok)
			windowOpened = true;
	}

	/**
	 * @param windowId
	 * @param query
	 * @return true if windowId open successfully
	 */
	protected abstract boolean openWindow(int windowId, MQuery query);
}
