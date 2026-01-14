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

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Vector;
import java.util.logging.Level;

import org.adempiere.base.Core;
import org.adempiere.base.search.ISearchProvider;
import org.adempiere.base.search.SearchResult;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MSearchDefinition;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.idempiere.db.util.SQLFragment;

/**
 * Executes search and opens windows for defined transaction codes
 *
 * @author Jan Roessler, jr@schaeffer-ag.de
 *
 */
public abstract class AbstractDocumentSearch {

	/** the logger */
	protected static final CLogger log = CLogger.getCLogger(AbstractDocumentSearch.class);
	protected boolean windowOpened = false;

	/**
	 * @param searchString
	 */
	public boolean openDocumentsByDocumentNo(String searchString) {
		windowOpened = false;
		StringBuilder msglog = new StringBuilder();

		msglog.append("Search started with String: ").append(searchString);
		if (log.isLoggable(Level.FINE))
			log.fine(msglog.toString());

		// Check if / transaction-codes are used
		if (!Util.isEmpty(searchString)) {
			String[] codes = searchString.trim().replace("  ", " ").split(" ");

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
					if (log.isLoggable(Level.FINE))
						log.fine(msglog.toString());
					getID(codeList.get(i), search.toString());
				}
			} else {
				msglog = new StringBuilder("Search without Transaction: ").append(search.toString());
				if (log.isLoggable(Level.FINE))
					log.fine(msglog.toString());
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
		final Properties ctx = Env.getCtx();
		final MRole role = MRole.get(ctx, Env.getAD_Role_ID(ctx), Env.getAD_User_ID(ctx), true);

		try {
			List<ISearchProvider> providers = Core.getSearchProviders();
			Map<String, Vector<Integer>> resultsMap = new HashMap<>();

			int pageSize = MSysConfig.getIntValue(
					MSysConfig.MAX_RESULTS_PER_SEARCH_IN_DOCUMENT_CONTROLLER, 3, Env.getAD_Client_ID(Env.getCtx()));

			for (MSearchDefinition msd : MSearchDefinition.getForCode(transactionCode)) {
				boolean foundResults = false;
				for (ISearchProvider provider : providers) {
					if (provider.accept(msd)) {
						List<SearchResult> results = provider.search(msd, searchString, pageSize, 0);
						if (results != null && !results.isEmpty()) {
							for (SearchResult result : results) {
								if (result.getRecordId() < 0)
									continue;

								if (role.getWindowAccess(result.getWindowId()) != null) {
									foundResults = true;
									String key = result.getWindowId() + "|" + result.getTableName();
									Vector<Integer> ids = resultsMap.get(key);
									if (ids == null) {
										ids = new Vector<>();
										resultsMap.put(key, ids);
									}
									if (!ids.contains(result.getRecordId()))
										ids.add(result.getRecordId());
								}
							}
							break;
						}
					}
				}

				if (!foundResults && (searchString == null || searchString.trim().length() == 0)) {
					if (role.getWindowAccess(msd.getAD_Window_ID()) != null) {
						MTable table = new MTable(Env.getCtx(), msd.getAD_Table_ID(), null);
						String key = msd.getAD_Window_ID() + "|" + table.getTableName();
						Vector<Integer> ids = resultsMap.get(key);
						if (ids == null) {
							ids = new Vector<>();
							resultsMap.put(key, ids);
						}
						if (!ids.contains(0))
							ids.add(0);
					}
				}
			}

			for (Map.Entry<String, Vector<Integer>> entry : resultsMap.entrySet()) {
				String[] parts = entry.getKey().split("\\|");
				int windowId = Integer.parseInt(parts[0]);
				String tableName = parts[1];
				Vector<Integer> ids = entry.getValue();

				if (log.isLoggable(Level.FINE)) {
					log.fine("Open Window: " + windowId + " / Table: " + tableName + " / Number of Results: "
							+ ids.size());
				}
				openWindow(ids, tableName, windowId);
			}
		} catch (Exception e) {
			log.severe(e.toString());
			e.printStackTrace();
		}
	}

	/**
	 * opens window with the given documents
	 *
	 * @param ids
	 *                  - document id's
	 * @param tableName
	 * @param windowId
	 */
	private void openWindow(Vector<Integer> ids, String tableName, int windowId) {
		if (ids == null || ids.size() == 0) {
			return;
		}
		StringBuilder whereString = new StringBuilder(" ").append(tableName).append("_ID");
		List<Object> params = new ArrayList<Object>();
		// create query string
		if (ids.size() == 1) {
			if (ids.get(0).intValue() == 0) {
				whereString = null;
			} else {
				whereString.append("=?");
				params.add(ids.get(0).intValue());
			}
		} else {
			whereString.append(" IN (");
			for (int i = 0; i < ids.size(); i++) {
				whereString.append("?");
				params.add(ids.get(i).intValue());
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
			query.addRestriction(new SQLFragment(whereString.toString(), params));
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
