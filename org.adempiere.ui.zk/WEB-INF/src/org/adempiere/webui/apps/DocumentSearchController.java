/******************************************************************************
 * Copyright (C) 2014 Low Heng Sin                                            *
 * Copyright (C) 2014 Trek Global                                             *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 *****************************************************************************/
package org.adempiere.webui.apps;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.adempiere.webui.component.Label;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.I_AD_SearchDefinition;
import org.compiere.model.MColumn;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MQuery;
import org.compiere.model.MRole;
import org.compiere.model.MSearchDefinition;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MWindow;
import org.compiere.model.Query;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Vlayout;

/**
 * @author hengsin
 *
 */
public class DocumentSearchController implements EventListener<Event>{

	private static final String SEARCH_RESULT = "search.result";
	private static final String ON_SEARCH_DOCUMENTS = "onSearchDocuments";
	private int MAX_RESULTS_PER_SEARCH_IN_DOCUMENT_CONTROLLER = 3;
	private Vlayout layout;
	private ArrayList<SearchResult> list;
	private int selected = -1;

	/**
	 * 
	 */
	public DocumentSearchController() {
		MAX_RESULTS_PER_SEARCH_IN_DOCUMENT_CONTROLLER = MSysConfig.getIntValue(MSysConfig.MAX_RESULTS_PER_SEARCH_IN_DOCUMENT_CONTROLLER, 3, Env.getAD_Client_ID(Env.getCtx()));
	}

	public void create(Component parent) {
		layout = new Vlayout();
		layout.setStyle("padding: 3px; overflow:auto;");
		ZKUpdateUtil.setWidth(layout, "100%");
		ZKUpdateUtil.setVflex(layout, "true");
		
		parent.appendChild(layout);
		
		layout.addEventListener(ON_SEARCH_DOCUMENTS, this);
	}

	public void search(String value) {
		layout.getChildren().clear();
		Events.echoEvent(ON_SEARCH_DOCUMENTS, layout, value);
	}
	
	private void onSearchDocuments(String searchString) {
		list = new ArrayList<SearchResult>();
		if (Util.isEmpty(searchString)) {
			return;
		} 
		
		List<SearchResult> list = doSearch(searchString);
		if (list.size() > 0) {
    		Collections.sort(list, new Comparator<SearchResult>() {
				@Override
				public int compare(SearchResult o1, SearchResult o2) {
					int r = o1.getWindowName().compareTo(o2.getWindowName());
					if (r == 0)
						r = o1.getLabel().compareTo(o2.getLabel());
					return r;
				}
			});
    		String windowName = null;
    		for(SearchResult result : list) {
    			if (windowName == null || !windowName.equals(result.getWindowName())) {
    				windowName = result.getWindowName();
    				Label label = new Label(windowName);
    				label.setStyle("padding: 3px; font-weight: bold; display: inline-block;");
    				layout.appendChild(label);
    			}
    			A a = new A();
    			a.setAttribute(SEARCH_RESULT, result);
    			a.setLabel(result.getLabel());
    			layout.appendChild(a);
    			a.setStyle("padding-left: 3px; display: inline-block;");
    			a.addEventListener(Events.ON_CLICK, this);
    		}
    		layout.invalidate();
		}
	}
	
	private List<SearchResult> doSearch(String searchString) {
		final MRole role = MRole.get(Env.getCtx(), Env.getAD_Role_ID(Env.getCtx()), Env.getAD_User_ID(Env.getCtx()), true);
				
		selected = -1;
		Query query = new Query(Env.getCtx(), I_AD_SearchDefinition.Table_Name, "TransactionCode IS NULL", null);
		List<MSearchDefinition> definitions = query.setOnlyActiveRecords(true).list();		
		for(MSearchDefinition msd : definitions) {
			MTable table = new MTable(Env.getCtx(), msd.getAD_Table_ID(), null);
			StringBuilder sql = null;
			MWindow window = msd.getAD_Window_ID() > 0 && role.getWindowAccess(msd.getAD_Window_ID()) != null ? MWindow.get(Env.getCtx(), msd.getAD_Window_ID()) : null;
			MWindow powindow = msd.getPO_Window_ID() > 0 && role.getWindowAccess(msd.getPO_Window_ID()) != null ? MWindow.get(Env.getCtx(), msd.getPO_Window_ID()) : null;
			if (window == null && powindow == null)
				continue;
			List<Object> params = new ArrayList<Object>();
			// SearchDefinition with a given table and column
			if (msd.getSearchType().equals(MSearchDefinition.SEARCHTYPE_TABLE)) {
				MColumn column = new MColumn(Env.getCtx(), msd.getAD_Column_ID(), null);
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
				sql.append(" AND AD_Client_ID=@#AD_Client_ID@  ");

				// search for a Integer
				if (msd.getDataType().equals(MSearchDefinition.DATATYPE_INTEGER)) {
					params.add(Integer.valueOf(searchString.replaceAll("\\D", "")));
					// search for a String
				} else if (msd.getDataType().equals(MSearchDefinition.DATATYPE_STRING)) {
					if (searchString.endsWith("%"))
						params.add(searchString);
					else
						params.add(searchString+"%");
				}
				// SearchDefinition with a special query
			} else if (msd.getSearchType().equals(MSearchDefinition.SEARCHTYPE_QUERY)) {
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
						params.add(Integer.valueOf(searchString.replaceAll("\\D", "")));
					} else if (msd.getDataType().equals(MSearchDefinition.DATATYPE_STRING)) {
						if (searchString.endsWith("%"))
							params.add(searchString);
						else
							params.add(searchString+"%");
					}
				}
			}
			MLookupInfo lookupInfo = MLookupFactory.getLookupInfo(Env.getCtx(), -1, -1, DisplayType.Search, Env.getLanguage(Env.getCtx()), table.getTableName() + "_ID", 0, false, null);
			MLookup lookup = new MLookup(lookupInfo, -1);
			
			if (sql != null) {
				if (powindow != null) {
					if (window != null) {
						doRetrieval(msd, sql, params, lookup, window, table.getTableName(), " AND IsSOTrx='Y' ", list);
					}
					doRetrieval(msd, sql, params, lookup, powindow, table.getTableName(), " AND IsSOTrx='N' ", list);					
				} else if (window != null) {
					doRetrieval(msd, sql, params, lookup, window, table.getTableName(), null, list);
				}
				
			}
		}
		return list;
	}
	
	private void doRetrieval(MSearchDefinition msd, StringBuilder builder, List<Object> params, MLookup lookup, MWindow window, String tableName, 
			String extraWhereClase, List<SearchResult> list) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = builder.toString();
			if (!Util.isEmpty(extraWhereClase))
				sql = sql + extraWhereClase;
			//@@ is full text search operator for postgresql
			boolean hasFullTextOperator = sql.indexOf("@@") >= 0;
			if (hasFullTextOperator)
				sql = sql.replace("@@", "~!#$*");
			sql = Env.parseContext(Env.getCtx(), -1, sql, false, true);
			if (hasFullTextOperator)
				sql = sql.replace("~!#$*", "@@");
			pstmt = DB.prepareStatement(sql, (String)null);
			if (params.size() > 0)
				DB.setParameters(pstmt, params);
			pstmt.setQueryTimeout(1);
			rs = pstmt.executeQuery();
			int count = 0;
			while (rs.next() && count < MAX_RESULTS_PER_SEARCH_IN_DOCUMENT_CONTROLLER) {
				count++;
				int id = rs.getInt(1);
				SearchResult result = new SearchResult();
				result.setLabel(lookup.getDisplay(id));
				result.setRecordId(id);
				result.setWindowName(window.get_Translation("Name"));
				result.setWindowId(window.getAD_Window_ID());
				
				result.setTableName(tableName);
				if (rs.getMetaData().getColumnCount() > 1) {
					result.setName(rs.getString(2));
				}
				list.add(result);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs, pstmt);
		}
		
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (Events.ON_CLICK.equals(event.getName())) {
        	if (event.getTarget() instanceof A) {
    			SearchResult result = (SearchResult) event.getTarget().getAttribute(SEARCH_RESULT);
    			doZoom(result);
    		}
        } else if (event.getName().equals(ON_SEARCH_DOCUMENTS)) {
        	onSearchDocuments((String)event.getData());
        }
	}

	private void doZoom(SearchResult result) {
		MQuery query = new MQuery();
		query.addRestriction(result.getTableName()+"_ID", "=", result.getRecordId());
		AEnv.zoom(result.getWindowId(), query);
	}
	
	public static class SearchResult {
		private String windowName;
		private int windowId;
		private String tableName;
		private int recordId;
		private String label;
		private String name;
				
		/**
		 * @return the windowId
		 */
		public int getWindowId() {
			return windowId;
		}
		/**
		 * @param windowId the windowId to set
		 */
		public void setWindowId(int windowId) {
			this.windowId = windowId;
		}
		/**
		 * @return the tableName
		 */
		public String getTableName() {
			return tableName;
		}
		/**
		 * @param tableName the tableName to set
		 */
		public void setTableName(String tableName) {
			this.tableName = tableName;
		}
				
		/**
		 * @return the windowName
		 */
		public String getWindowName() {
			return windowName;
		}
		/**
		 * @param windowName the windowName to set
		 */
		public void setWindowName(String windowName) {
			this.windowName = windowName;
		}
		/**
		 * @return the recordId
		 */
		public int getRecordId() {
			return recordId;
		}
		/**
		 * @param recordId the recordId to set
		 */
		public void setRecordId(int recordId) {
			this.recordId = recordId;
		}
		/**
		 * @return the label
		 */
		public String getLabel() {
			return label;
		}
		/**
		 * @param label the label to set
		 */
		public void setLabel(String label) {
			this.label = label;
		}
		/**
		 * @return the name
		 */
		public String getName() {
			return name;
		}
		/**
		 * @param name the name to set
		 */
		public void setName(String name) {
			this.name = name;
		}		
	}

	public boolean onOk(Textbox textbox) {
		String text = textbox.getText();
		if (Util.isEmpty(text))
			return false;
		text = text.toLowerCase();
		int size = layout.getChildren().size();
		A firstStart = null;
		A exact = null;
		for(int i = 0; i < size; i++) {
			if (!(layout.getChildren().get(i) instanceof A)) continue;
			A a = (A) layout.getChildren().get(i);
			SearchResult result = (SearchResult) a.getAttribute(SEARCH_RESULT);
			if (result.getLabel().equalsIgnoreCase(text)) {
				exact = a;
				break;
			} else if (text.equalsIgnoreCase(result.getName())) {
				exact = a;
				break;
			} else if (firstStart == null && result.getLabel().toLowerCase().startsWith(text) && text.length() >=3 ) {
				firstStart = a;
			}
		}
		
		SearchResult result = null;
		if (exact != null)
			result = (SearchResult) exact.getAttribute(SEARCH_RESULT);
		else if (firstStart != null)
			result = (SearchResult) firstStart.getAttribute(SEARCH_RESULT);
		if (result != null) {
			doZoom(result);
		}
		
		return false;
	}

	public SearchResult selectPrior() {
		if (selected > 0) {
			selected--;
			SearchResult result = list.get(selected);
			List<Component> links = layout.getChildren();
			for(Component link : links) {
				if (link instanceof A) {
					A a = (A) link;
					if (result.getLabel().equals(a.getLabel())) {
						a.setSclass("document-search-current-link");
					} else if ("document-search-current-link".equals(a.getSclass())) {
						a.setSclass(null);
					}
				}
			}
			return result;
		}
		return null;
	}

	public SearchResult selectNext() {
		if (selected < (list.size()-1)) {
			selected++;
			SearchResult result = list.get(selected);
			List<Component> links = layout.getChildren();
			for(Component link : links) {
				if (link instanceof A) {
					A a = (A) link;
					if (result.getLabel().equals(a.getLabel())) {
						a.setSclass("document-search-current-link");
					} else if ("document-search-current-link".equals(a.getSclass())) {
						a.setSclass(null);
					}
				}
			}
			return result;
		}
		return null;
	}
}
