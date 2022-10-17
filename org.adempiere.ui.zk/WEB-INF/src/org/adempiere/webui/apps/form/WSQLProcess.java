/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 ComPiere, Inc. All Rights Reserved.                *
 * This program is free software; you can redistribute it and/or modify it    *
 * under the terms version 2 of the GNU General Public License as published   *
 * by the Free Software Foundation. This program is distributed in the hope   *
 * that it will be useful, but WITHOUT ANY WARRANTY; without even the implied *
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.           *
 * See the GNU General Public License for more details.                       *
 * You should have received a copy of the GNU General Public License along    *
 * with this program; if not, write to the Free Software Foundation, Inc.,    *
 * 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.                     *
 * For the text or an alternative of this public license, you may reach us    *
 * ComPiere, Inc., 2620 Augustine Dr. #245, Santa Clara, CA 95054, USA        *
 * or via info@compiere.org or http://www.compiere.org/license.html           *
 *****************************************************************************/

/**
 * 2007, Modified by Posterita Ltd.
 */

package org.adempiere.webui.apps.form;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.StringTokenizer;
import java.util.logging.Level;

import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
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
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;

/**
 * A Custom Form to specify and process SQL statements.
 *
 * The range of statement types that can be performed can be restricted
 * by allowing or disallowing DML statements.
 *
 * @author Andrew Kimball
 *
 */
@org.idempiere.ui.zk.annotation.Form(name = "org.compiere.apps.form.VSQLProcess")
public class WSQLProcess extends ADForm implements EventListener<Event>
{
    /**
	 * 
	 */
	private static final long serialVersionUID = -4661224754061326223L;

	/** Log. */
    private static final CLogger  log = CLogger.getCLogger(WSQLProcess.class);

    /** Grid used to layout components. */
    private Grid m_grdMain = new Grid();
    /** SQL label. */
    private Label m_lblSql = new Label("SQL");
    /** SQL statement field. */
    private Textbox m_txbSqlField = new Textbox();
    /** Process button. */
    private Button m_btnSql = createProcessButton();
    /** Field to hold result of SQL statement execution. */
    private Textbox m_txbResultField = new Textbox();

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
    public WSQLProcess() {
        super();
    }

    @Override
    protected void initForm() {
        Row rwTop = new Row();
        Row rwBottom = new Row();
        Rows rows = new Rows();
        final int noColumns = 60;
        final int maxStatementLength = 9000;
        final int noStatementRows = 3;
        final int noResultRows = 20;

        ZKUpdateUtil.setWidth(m_grdMain, "80%");

        // create the top row of components
        m_txbSqlField.setMultiline(true);
        m_txbSqlField.setMaxlength(maxStatementLength);
        m_txbSqlField.setRows(noStatementRows);
        ZKUpdateUtil.setHflex(m_txbSqlField, "1");
        m_txbSqlField.setCols(noColumns);
        m_txbSqlField.setReadonly(false);

        m_btnSql.addEventListener(Events.ON_CLICK, this);

        rwTop.appendChild(m_lblSql);
        rwTop.appendChild(m_txbSqlField);
        rwTop.appendChild(m_btnSql);

        rows.appendChild(rwTop);

        // create the bottom row of components
        m_txbResultField.setCols(noColumns);
        m_txbResultField.setRows(noResultRows);
        ZKUpdateUtil.setHflex(m_txbResultField, "1");
        m_txbResultField.setReadonly(true);

        rwBottom.appendCellChild(m_txbResultField, 3);
        rwBottom.setAlign("center");

        rows.appendChild(rwBottom);

        // put it all together
        m_grdMain.appendChild(rows);

        Borderlayout contentPane = new Borderlayout();
		this.appendChild(contentPane);
		ZKUpdateUtil.setWidth(contentPane, "99%");
		ZKUpdateUtil.setHeight(contentPane, "100%");
		Center center = new Center();
		center.setStyle("border: none");
		contentPane.appendChild(center);
		ZKUpdateUtil.setHflex(m_grdMain, "true");
		ZKUpdateUtil.setVflex(m_grdMain, "true");
		center.appendChild(m_grdMain);

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
     *  Process a semicolon delimited list of SQL Statements.
     *
     *  @param sqlStatements    one or more statements separated by a semicolon (';')
     *  @return a string summarizing the results
     */
    public static String processStatements (String sqlStatements) {
    	if (sqlStatements == null || sqlStatements.length() == 0)
			return "";
		StringBuilder result = new StringBuilder();
		//
		// TODO: known issue - the command cannot contain semicolon within quotes
		StringTokenizer st = new StringTokenizer(sqlStatements, ";", false);
		while (st.hasMoreTokens()) {
			result.append(processStatement(st.nextToken()));
			result.append(Env.NL);
		}
		//
		return result.toString();
    }

    /**
     *  Process SQL Statements.
     *
     *  @param sqlStatement a single SQL statement
     *  @return a string summarizing the results
     */
    public static String processStatement (String sqlStatement) {
    	if (sqlStatement == null)
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
		String sql = sb.toString();
		if (sql.trim().length() == 0)
			return "";
		//
		if (!sql.contains(" ")) // command is a single word (f.e. ANALYZE), add space at the end
			sql += " ";
		StringBuilder result = new StringBuilder("SQL> ")
				.append(sql)
				.append(Env.NL);
		String SQL = sql.toUpperCase();
		String cleanSQL = SQL
				.replaceAll(REGEX_REMOVE_COMMENTS, "")
				.replaceAll(REGEX_REMOVE_QUOTED_STRINGS, "")
				.replaceFirst(REGEX_REMOVE_LEADING_SPACES, "");

		String[] allowedKeywords = MSysConfig.getValue(MSysConfig.FORM_SQL_PROCESS_ALLOWED_KEYWORDS, "ALTER,ANALYZE,COMMENT,CREATE,DELETE,DROP,GRANT,INSERT,REINDEX,REVOKE,SET,UPDATE,TRUNCATE,VACUUM").split(",");
		boolean error = true;
		for (int i = 0; i < allowedKeywords.length; i++) {
			if (cleanSQL.startsWith(allowedKeywords[i] + " ")) {
				error = false;
				break;
			}
		}
		if (error) {
			result.append("===> ERROR: Not Allowed Command")
			.append(Env.NL);
			return result.toString();
		}
		
		//	Process
		Connection conn = DB.createConnection(true, Connection.TRANSACTION_READ_COMMITTED);
		Statement stmt = null;
		try {
			stmt = conn.createStatement(); 
        	long start = System.currentTimeMillis();
			stmt.execute(sql);
        	long end = System.currentTimeMillis();
            BigDecimal durationSeconds = BigDecimal.valueOf(end).subtract(BigDecimal.valueOf(start)).divide(BigDecimal.valueOf(1000.0));
			int count = stmt.getUpdateCount();
			if (count == -1) {
				result.append("---> ResultSet");
			}
			else
				result.append("---> Result=").append(count);
			MIssue issue = new MIssue(Env.getCtx(), 0, null);
			issue.setIssueSummary("SQL executed on SQL Process form");
			issue.setStackTrace(sql);
			issue.setResponseText(result.toString().replace("SQL> " + sql + Env.NL, ""));
			issue.setIssueSource(MIssue.ISSUESOURCE_Form);
			issue.setUserName(Env.getContext(Env.getCtx(), Env.AD_USER_NAME));
			issue.setAD_Form_ID(SystemIDs.FORM_SQL_PROCESS);
			issue.setProcessed(true);
			issue.setComments("Duration : " + durationSeconds + " seconds");
			issue.saveEx();
		} catch (SQLException e) {
			String exception = e.toString();
			log.log(Level.SEVERE, "process statement: " + sql + " - " + exception);
			result.append("===> ").append(exception);
		} finally {
			DB.close(stmt);
			stmt = null;
			try {
				conn.close();
			} catch (SQLException e2) {
				log.log(Level.SEVERE, "processStatement - close connection", e2);
			}
			conn = null;
		}
		//
		result.append(Env.NL);
		return result.toString();
    }

    /**
     *  Process the events for this form
     *  @param event
     */
    public void onEvent(Event event) throws Exception {
    	if (event.getTarget() == m_btnSql)
    		m_txbResultField.setText(processStatements (m_txbSqlField.getText()));
		super.onEvent(event);
    }

}
