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
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.adempiere.webui.apps.form;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;

import org.adempiere.exceptions.DBException;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.WListItemRenderer;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MIssue;
import org.compiere.model.MSysConfig;
import org.compiere.model.SystemIDs;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.Frozen;
import org.zkoss.zul.North;
import org.zkoss.zul.South;

/**
 * A Custom Form to process SQL queries.
 *
 * The statement to be executed can be restricted using SysConfig
 */
@org.idempiere.ui.zk.annotation.Form
public class WSQLQuery extends ADForm implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6641250848300700313L;

	/** Log. */
	private static final CLogger  log = CLogger.getCLogger(WSQLQuery.class);

	/** Grid used to layout components. */
	private Borderlayout layout = new Borderlayout();
	/** SQL label. */
	private Label m_lblSql = new Label("SQL");
	/** SQL statement field. */
	private Textbox m_txbSqlField = new Textbox();
	/** Process button. */
	private Button m_btnSql = createProcessButton();
	/** Field to hold result of SQL statement execution. */
	private Textbox m_txbResultField = new Textbox();
	/** Grid to show the result data. */
	private ListModelTable model = null;
	private WListbox listbox = new WListbox();

	/**
	 * REGEX_REMOVE_COMMENTS
	 */
	private static final String REGEX_REMOVE_COMMENTS = "/\\*(?:.|[\\n\\r])*?\\*/";

	/**
	 * REGEX_REMOVE_QUOTED_STRINGS
	 */
	private static final String REGEX_REMOVE_QUOTED_STRINGS = "'(?:.|[\\n\\r])*?'";

	/**
	 * REGEX_REMOVE_LEADING_SPACES
	 */
	private static final String REGEX_REMOVE_LEADING_SPACES = "^\\s+";

	/**
	 * Default constructor.
	 */
	public WSQLQuery() {
		super();
	}

	@Override
	protected void initForm() {
		North north = new North();
		Center center = new Center();
		South south = new South();
		final int maxStatementLength = 10000;
		final int noStatementRows = 3;
		final int noResultRows = 2;

		ZKUpdateUtil.setWidth(layout, "100%");
		ZKUpdateUtil.setHeight(layout, "100%");
		layout.setStyle("background-color: transparent; position: relative;");

		Div div = new Div();
		// create the top row of components
		m_txbSqlField.setMultiline(true);
		m_txbSqlField.setMaxlength(maxStatementLength);
		m_txbSqlField.setRows(noStatementRows);
		ZKUpdateUtil.setHflex(m_txbSqlField, "1");
		m_txbSqlField.setReadonly(false);

		m_btnSql.addEventListener(Events.ON_CLICK, this);

		div.appendChild(m_lblSql);
		div.appendChild(m_txbSqlField);
		div.appendChild(m_btnSql);
		north.appendChild(div);
		layout.appendChild(north);

		// create the bottom row of components
		m_txbResultField.setRows(noResultRows);
		ZKUpdateUtil.setHflex(m_txbResultField, "1");
		m_txbResultField.setReadonly(true);

		center.appendChild(listbox);
		ZKUpdateUtil.setVflex(listbox, "1");
		ZKUpdateUtil.setHflex(listbox, "1");

		layout.appendChild(center);

		south.appendChild(m_txbResultField);
		layout.appendChild(south);

		this.appendChild(layout);

		return;
	}

	/**
	 *  Create Process Button.
	 *  @return button
	 */
	public static final Button createProcessButton() {
		Button btnProcess = new Button();
		if(ThemeManager.isUseFontIconForImage())
			btnProcess.setIconSclass("z-icon-Process");
		else
			btnProcess.setImage(ThemeManager.getThemeResource("images/Process24.png"));
		btnProcess.setName(Msg.getMsg(Env.getCtx(), "Process"));

		return btnProcess;
	}   //  createProcessButton

	/**
	 *  Process SQL Statements.
	 *
	 *  @param sqlStatement a single SQL statement
	 *  @param allowDML     whether to allow DML statements
	 *  @return a string summarizing the results
	 */
	public String processStatement (String sqlStatement) {
		m_txbResultField.setText(null);
		listbox.clear();

		if (sqlStatement == null || sqlStatement.length() == 0)
			return "";
		StringBuilder sb = new StringBuilder();
		char[] chars = sqlStatement.toCharArray();
		for (int i = 0; i < chars.length; i++) {
			char c = chars[i];
			if (Character.isWhitespace(c))
				sb.append(' ');
			else
				sb.append(c);
		}
		String sql = sb.toString().trim();
		if (sql.length() == 0)
			return "";
		//
		StringBuilder result = new StringBuilder();
		String SQL = sql.toUpperCase();
		String cleanSQL = SQL
				.replaceAll(REGEX_REMOVE_COMMENTS, "")
				.replaceAll(REGEX_REMOVE_QUOTED_STRINGS, "")
				.replaceFirst(REGEX_REMOVE_LEADING_SPACES, "");

		if (cleanSQL.contains(";")) {
			result.append("ERROR: Multiple Commands Not Allowed");
			return result.toString();
		}

		int timeout = MSysConfig.getIntValue(MSysConfig.FORM_SQL_QUERY_TIMEOUT_IN_SECONDS, 120);
		int maxRecords = MSysConfig.getIntValue(MSysConfig.FORM_SQL_QUERY_MAX_RECORDS, 500);

		String[] allowedKeywords = MSysConfig.getValue(MSysConfig.FORM_SQL_QUERY_ALLOWED_KEYWORDS, "SELECT,WITH,SHOW").split(",");
		boolean isError = true;
		for (int i = 0; i < allowedKeywords.length; i++) {
			if (cleanSQL.startsWith(allowedKeywords[i] + " ")) {
				isError = false;	
				break;
			}
		}
		if (isError) {
			result.append("ERROR: Not Allowed Command");
			return result.toString();
		}

		List<String> header = new ArrayList<String>();
		header.add("#");
		model = new ListModelTable();
		Frozen frozen = new Frozen();
		frozen.setColumns(1);
		listbox.appendChild(frozen);

		Trx trx = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			long start = System.currentTimeMillis();

			String trxName = Trx.createTrxName("WSQLQuery");
			trx = Trx.get(trxName, false);
			trx.setDisplayName(getClass().getName()+"_processStatement");
			trx.getConnection().setReadOnly(true);

			pstmt = DB.prepareNormalReadReplicaStatement(sql, trxName);
			pstmt.setQueryTimeout(timeout);
			rs = pstmt.executeQuery();
			
			ResultSetMetaData meta = rs.getMetaData();
			int count = 0;
			for (int col = 1; col <= meta.getColumnCount(); col++) {
				String columnName = meta.getColumnLabel(col);
				header.add(columnName);
			}

			while (rs.next ()) {
				if (count >= maxRecords) {
					result.append("Maximum of " + maxRecords + " records reached.  ");
					break;
				}
				List<Object> row = new ArrayList<Object>();
				row.add(++count);
				for (int col = 1; col <= meta.getColumnCount(); col++) {
					String colName = header.get(col).toLowerCase();
					if (rs.getObject(col) instanceof BigDecimal
						&& (colName.endsWith("_id") || colName.equals("createdby") || colName.equals("updatedby")))
						row.add(rs.getInt(col));
					else
						row.add(rs.getObject(col));
				}	//	for all columns
				model.add(row);
			}
			long end = System.currentTimeMillis();
			BigDecimal durationSeconds = BigDecimal.valueOf(end).subtract(BigDecimal.valueOf(start)).divide(BigDecimal.valueOf(1000.0));
			result.append("Count = ").append(count);
			if (MSysConfig.getBooleanValue(MSysConfig.FORM_SQL_QUERY_LOG_ISSUE, true)) {
				MIssue issue = new MIssue(Env.getCtx(), 0, null);
				issue.setIssueSummary("SQL executed on SQL Query form");
				issue.setStackTrace(sql);
				issue.setResponseText(result.toString());
				issue.setIssueSource(MIssue.ISSUESOURCE_Form);
				issue.setUserName(Env.getContext(Env.getCtx(), Env.AD_USER_NAME));
				issue.setAD_Form_ID(SystemIDs.FORM_SQL_QUERY);
				issue.setProcessed(true);
				issue.setComments("Duration : " + durationSeconds + " seconds");
				issue.saveEx();
			}

			// Show the result in WListbox
			WListItemRenderer renderer = new WListItemRenderer(header);
			model.setNoColumns(header.size());
			listbox.setModel(model);
			listbox.setItemRenderer(renderer);
			listbox.initialiseHeader();
			listbox.setSizedByContent(true);

		} catch (Exception e) {
			if (trx != null) {
				trx.rollback();
			}
			if (DBException.isTimeout(e)) {
				result.append("Maximum of " + timeout + " seconds reached, query cancelled.");
			} else {
				e.printStackTrace();
				String exception = e.toString();
				log.log(Level.SEVERE, "process statement: " + sql + " - " + exception);
				result.append("Exception => ").append(exception);
			}
		} finally {
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
			if (trx != null) {
				trx.close();
				trx = null;
			}
		}

		return result.toString();
	}

    /**
     *  Process the events for this form
     *  @param event
     */
	public void onEvent(Event event) throws Exception {
		if (event.getTarget() == m_btnSql)
			m_txbResultField.setText(processStatement(m_txbSqlField.getText()));
		super.onEvent(event);
	}
}
