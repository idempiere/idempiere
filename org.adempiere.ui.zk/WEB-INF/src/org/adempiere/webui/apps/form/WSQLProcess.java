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
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;

/**
 * A Custom Form to specify and process SQL statements.
 *
 * The range of statement types that can be performed can be restricted
 * by allowing or disallowing DML statements.
 *
 * @author Andrew Kimball
 *
 */
public class WSQLProcess extends ADForm implements EventListener<Event>
{
    /**
	 * 
	 */
	private static final long serialVersionUID = -2038792517003449189L;
	
	/** Log. */
    private static CLogger  log = CLogger.getCLogger(WSQLProcess.class);

    /** DML Statement		*/
	private static final String[] DML_KEYWORDS = new String[]{
		"SELECT", "UPDATE", "DELETE", "TRUNCATE"
	};
	
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
     * Default constructor.
     */
    public WSQLProcess()
    {
        super();
    }

    @Override
    protected void initForm()
    {
        Row rwTop = new Row();
        Row rwBottom = new Row();
        Rows rows = new Rows();
        final int noColumns = 60;
        final int maxStatementLength = 9000;
        final int noStatementRows = 3;
        final int noResultRows = 20;

        m_grdMain.setWidth("80%");

        // create the top row of components
        m_txbSqlField.setMultiline(true);
        m_txbSqlField.setMaxlength(maxStatementLength);
        m_txbSqlField.setRows(noStatementRows);
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
        m_txbResultField.setReadonly(true);

        rwBottom.appendCellChild(m_txbResultField, 3);
        rwBottom.setAlign("center");

        rows.appendChild(rwBottom);

        // put it all together
        m_grdMain.appendChild(rows);

        this.appendChild(m_grdMain);

        return;
    }

    /**
     *  Create Process Button.
     *  @return button
     */
    public static final Button createProcessButton()
    {
        Button btnProcess = new Button();

        btnProcess.setImage("/images/Process24.png");
        btnProcess.setName(Msg.getMsg(Env.getCtx(), "Process"));

        return btnProcess;
    }   //  createProcessButton

    /**
     *  Process a semicolon delimitted list of SQL Statements.
     *
     *  @param sqlStatements    one or more statements separated by a semicolon (';')
     *  @param allowDML         whether to allow DML statements
     *  @return a string summarising the results
     */
    public static String processStatements (String sqlStatements, boolean allowDML)
    {
    	if (sqlStatements == null || sqlStatements.length() == 0)
			return "";
		StringBuilder result = new StringBuilder();
		//
		StringTokenizer st = new StringTokenizer(sqlStatements, ";", false);
		while (st.hasMoreTokens())
		{
			result.append(processStatement(st.nextToken(), allowDML));
			result.append(Env.NL);
		}
		//
		return result.toString();
    }

    /**
     *  Process SQL Statements.
     *
     *  @param sqlStatement a single SQL statement
     *  @param allowDML     whether to allow DML statements
     *  @return a string summarising the results
     */
    public static String processStatement (String sqlStatement, boolean allowDML)
    {
    	if (sqlStatement == null)
			return "";
		StringBuilder sb = new StringBuilder();
		char[] chars = sqlStatement.toCharArray();
		for (int i = 0; i < chars.length; i++)
		{
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
		StringBuffer result = new StringBuffer("SQL> ")
			.append(sql)
			.append(Env.NL);
		if (!allowDML)
		{
			boolean error = false;
			String SQL = sql.toUpperCase();
			for (int i = 0; i < DML_KEYWORDS.length; i++)
			{
				if (SQL.startsWith(DML_KEYWORDS[i] + " ") 
					|| SQL.indexOf(" " + DML_KEYWORDS[i] + " ") != -1
					|| SQL.indexOf("(" + DML_KEYWORDS[i] + " ") != -1)
				{
					result.append("===> ERROR: Not Allowed Keyword ")
						.append(DML_KEYWORDS[i])
						.append(Env.NL);
					error = true;	
				}
			}
			if (error)
				return result.toString();
		}	//	!allowDML
		
		//	Process
		Connection conn = DB.createConnection(true, Connection.TRANSACTION_READ_COMMITTED);
		Statement stmt = null;
		try
		{
			stmt = conn.createStatement(); 
			@SuppressWarnings("unused")
			boolean OK = stmt.execute(sql);
			int count = stmt.getUpdateCount();
			if (count == -1)
			{
				result.append("---> ResultSet");
			}
			else
				result.append("---> Result=").append(count);
		}
		catch (SQLException e)
		{
			String exception = e.toString();
			log.log(Level.SEVERE, "process statement: " + sql + " - " + exception);
			result.append("===> ").append(exception);
		}
		
		//	Clean up
		try
		{
			stmt.close();
		}
		catch (SQLException e1)
		{
			log.log(Level.SEVERE, "processStatement - close statement", e1);
		}
		stmt = null;
		try
		{
			conn.close();
		}
		catch (SQLException e2)
		{
			log.log(Level.SEVERE, "processStatement - close connection", e2);
		}
		conn = null;
		//
		result.append(Env.NL);
		return result.toString();
    }


    /*
     * (non-Javadoc)
     * @see org.adempiere.webui.panel.ADForm#onEvent(org.zkoss.zk.ui.event.Event)
     */
    public void onEvent(Event event) throws Exception
    {
        m_txbResultField.setText(processStatements (m_txbSqlField.getText(), false));
		super.onEvent(event);
    }
}
