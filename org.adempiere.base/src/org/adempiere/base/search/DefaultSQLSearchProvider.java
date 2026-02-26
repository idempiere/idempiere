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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.base.search;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MPayment;
import org.compiere.model.MRole;
import org.compiere.model.MSearchDefinition;
import org.compiere.model.MTable;
import org.compiere.model.MWindow;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;

import org.osgi.service.component.annotations.Component;

@Component(service = ISearchProvider.class, immediate = true)
public class DefaultSQLSearchProvider implements ISearchProvider {

	private static final CLogger log = CLogger.getCLogger(DefaultSQLSearchProvider.class);
	
    @Override
    public boolean accept(MSearchDefinition def) {
        return MSearchDefinition.SEARCHTYPE_Table.equals(def.getSearchType())
                || MSearchDefinition.SEARCHTYPE_Query.equals(def.getSearchType());
    }

    @Override
    public List<SearchResult> search(MSearchDefinition msd, String searchString, int pageSize, int pageNo) {
        List<SearchResult> list = new ArrayList<SearchResult>();
        final MRole role = MRole.get(Env.getCtx(), Env.getAD_Role_ID(Env.getCtx()), Env.getAD_User_ID(Env.getCtx()),
                true);

        MTable table = new MTable(Env.getCtx(), msd.getAD_Table_ID(), null);
        StringBuilder sql = null;
        MWindow window = msd.getAD_Window_ID() > 0 && role.getWindowAccess(msd.getAD_Window_ID()) != null
                ? MWindow.get(Env.getCtx(), msd.getAD_Window_ID())
                : null;
        MWindow powindow = msd.getPO_Window_ID() > 0 && role.getWindowAccess(msd.getPO_Window_ID()) != null
                ? MWindow.get(Env.getCtx(), msd.getPO_Window_ID())
                : null;
        if (window == null && powindow == null)
            return list;

        List<Object> params = new ArrayList<Object>();
        // SearchDefinition with a given table and column
        if (msd.getSearchType().equals(MSearchDefinition.SEARCHTYPE_Table)) {
            MColumn column = MColumn.get(Env.getCtx(), msd.getAD_Column_ID());
            sql = new StringBuilder("SELECT ").append(table.getTableName()).append("_ID, ")
                    .append(column.getColumnName());
            sql.append(" FROM ")
                    .append(table.getTableName())
                    .append(" ");
            // search for an Integer
            if (msd.getDataType().equals(MSearchDefinition.DATATYPE_INTEGER)) {
                sql.append("WHERE ").append(column.getColumnName()).append("=?");
                // search for a String
            } else {
                sql.append("WHERE UPPER(").append(column.getColumnName()).append(") LIKE UPPER(?)");
            }
            
            // search for a Integer
            if (msd.getDataType().equals(MSearchDefinition.DATATYPE_INTEGER)) {
                String digitsOnly = searchString.replaceAll("\\D", "");
                if (Util.isEmpty(digitsOnly))
                    return list; // No valid integer to search
                params.add(Integer.valueOf(digitsOnly));
                // search for a String
            } else if (msd.getDataType().equals(MSearchDefinition.DATATYPE_STRING)) {
                if (searchString.endsWith("%"))
                    params.add(searchString);
                else
                    params.add(searchString + "%");
            }
            sql.append(" AND AD_Client_ID=? ");
            params.add(Env.getAD_Client_ID(Env.getCtx()));
            if (!Util.isEmpty(msd.getQuery(), true)) {
            	sql.append(" AND (").append(msd.getQuery()).append(") ");
            }
            // SearchDefinition with a special query
        } else if (msd.getSearchType().equals(MSearchDefinition.SEARCHTYPE_Query)) {
            sql = new StringBuilder().append(msd.getQuery());
            // count '?' in statement
            int count = 1;
            for (char c : sql.toString().toCharArray()) {
                if (c == '?') {
                    count++;
                }
            }
            for (int i = 1; i < count; i++) {
                if (msd.getDataType().equals(MSearchDefinition.DATATYPE_INTEGER)) {
                    String digitsOnly = searchString.replaceAll("\\D", "");
                    if (Util.isEmpty(digitsOnly))
                        return list; // No valid integer to search
                    params.add(Integer.valueOf(digitsOnly));
                } else if (msd.getDataType().equals(MSearchDefinition.DATATYPE_STRING)) {
                    if (searchString.endsWith("%"))
                        params.add(searchString);
                    else
                        params.add(searchString + "%");
                }
            }
        }

        MLookupInfo lookupInfo = MLookupFactory.getLookupInfo(Env.getCtx(), -1, -1, DisplayType.Search,
                Env.getLanguage(Env.getCtx()), table.getTableName() + "_ID", 0, false, null);
        MLookup lookup = new MLookup(lookupInfo, -1);

        if (sql != null) {
            if (powindow != null) {
                String whereCol = null;
                if (table.columnExistsInDictionary("IsSOTrx")) {
                    whereCol = " AND IsSOTrx=";
                } else {
                    if (MPayment.Table_Name.equals(table.getTableName())) {
                        whereCol = " AND IsReceipt=";
                    }
                }
                if (whereCol == null) {
                    doRetrieval(msd, sql, params, lookup, powindow, table.getTableName(), null, list, pageSize);
                } else {
                    if (window != null) {
                        String soWhereTrx = whereCol + "'Y' ";
                        doRetrieval(msd, sql, params, lookup, window, table.getTableName(), soWhereTrx, list, pageSize);
                    }
                    String poWhereTrx = whereCol + "'N' ";
                    doRetrieval(msd, sql, params, lookup, powindow, table.getTableName(), poWhereTrx, list, pageSize);
                }
            } else if (window != null) {
                doRetrieval(msd, sql, params, lookup, window, table.getTableName(), null, list, pageSize);
            }
        }

        return list;
    }

    private void doRetrieval(MSearchDefinition msd, StringBuilder builder, List<Object> params, MLookup lookup,
            MWindow window, String tableName,
            String extraWhereClase, List<SearchResult> list, int pageSize) {
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            String sql = builder.toString();
            if (!Util.isEmpty(extraWhereClase))
                sql = sql + extraWhereClase;
            // @@ is full text search operator for postgresql
            boolean hasFullTextOperator = sql.indexOf("@@") >= 0;
            if (hasFullTextOperator)
                sql = sql.replace("@@", "~!#$*");
            if (sql.contains("@")) {
				if (params.isEmpty()) {
					sql = Env.parseContextForSql(Env.getCtx(), -1, sql, false, true, params);
				} else {
					List<Object> contextParams = new ArrayList<Object>();
					String beforeParseSql = sql;
					sql = Env.parseContextForSql(Env.getCtx(), -1, sql, false, true, contextParams);
					if (contextParams.size() > 0)
						params = Env.mergeParameters(beforeParseSql, sql, params.toArray(), contextParams.toArray());						
				}
			}
            if (hasFullTextOperator)
                sql = sql.replace("~!#$*", "@@");

            sql = DB.getDatabase().addPagingSQL(sql, 0, pageSize);

            pstmt = DB.prepareStatement(sql, (String) null);
            if (params.size() > 0)
                DB.setParameters(pstmt, params);
            pstmt.setQueryTimeout(1);
            rs = pstmt.executeQuery();
            int count = 0;
            ResultSetMetaData metaData = null;
            while (rs.next() && count < pageSize) {
                count++;
                if (metaData == null)
                    metaData = rs.getMetaData();
                int id = rs.getInt(1);
                SearchResult result = new SearchResult();
                result.setLabel(lookup.getDisplay(id));
                result.setRecordId(id);
                result.setWindowName(window.get_Translation("Name"));
                result.setWindowId(window.getAD_Window_ID());

                result.setTableName(tableName);
                if (metaData.getColumnCount() > 1) {
                    result.setName(rs.getString(2));
                }
                Map<String, Object> valueMap = new HashMap<String, Object>();
                valueMap.put(metaData.getColumnName(1), id);
                List<Object> values = new ArrayList<Object>();
                values.add(id);
                if (metaData.getColumnCount() > 1) {
                    for (int i = 2; i <= metaData.getColumnCount(); i++) {
                        Object value = rs.getObject(i);
                        values.add(value);
                        valueMap.put(metaData.getColumnName(i), value);
                    }
                }
                result.setValues(values.toArray());
                result.setValueMap(valueMap);
                if (msd.getSearchType().equals(MSearchDefinition.SEARCHTYPE_Query) && msd.getAD_Message_ID() > 0) {
                    result.setAD_Message_ID(msd.getAD_Message_ID());
                    if (msd.getAD_Style_ID() > 0)
                        result.setAD_Style_ID(msd.getAD_Style_ID());
                }
                list.add(result);
            }
        } catch (SQLException e) {
            SearchResult result = new SearchResult();
            result.setRecordId(-1);
            if (DB.getDatabase().isQueryTimeout(e)) {
                result.setLabel(Msg.getMsg(Env.getCtx(), "Timeout"));
            } else {
                result.setLabel(Msg.getMsg(Env.getCtx(), "DBExecuteError"));
                log.log(Level.WARNING, e.getLocalizedMessage(), e);
            }
            list.add(result);
        } finally {
            DB.close(rs, pstmt);
        }
    }
}
