/******************************************************************************
 * Product: Posterita Ajax UI 												  *
 * Copyright (C) 2007 Posterita Ltd.  All Rights Reserved.                    *
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
 * Posterita Ltd., 3, Draper Avenue, Quatre Bornes, Mauritius                 *
 * or via info@posterita.org or http://www.posterita.org/                     *
 *****************************************************************************/

package org.adempiere.webui.panel;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.Dialog;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.I_C_ElementValue;
import org.compiere.model.MColumn;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Center;
import org.zkoss.zul.Div;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Vbox;

/**
 * Zk Port
 * @author Elaine
 * @version	InfoGeneral.java Adempiere Swing UI 3.4.1
 */
public class InfoGeneralPanel extends InfoPanel implements EventListener<Event>
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 624139753237845647L;

	private Textbox txt1;
	private Textbox txt2;
	private Textbox txt3;
	private Textbox txt4;

	private Label lbl1;
	private Label lbl2;
	private Label lbl3;
	private Label lbl4;

	/** String Array of Column Info */
	private ColumnInfo[] m_generalLayout;
	
	/** list of query columns */
	private ArrayList<String> m_queryColumns = new ArrayList<String>();

	/** list of query columns (SQL) */
	private ArrayList<String> m_queryColumnsSql = new ArrayList<String>();
	private Borderlayout layout;
	private Vbox southBody;

	private int noOfParameterColumn;

	public InfoGeneralPanel(String queryValue, int windowNo,String tableName,String keyColumn, boolean multipleSelection, String whereClause)
	{
		this(queryValue, windowNo, tableName, keyColumn, multipleSelection, whereClause, true);
	}

	public InfoGeneralPanel(String queryValue, int windowNo,String tableName,String keyColumn, boolean multipleSelection, String whereClause, boolean lookup)
	{
		super(windowNo, tableName, keyColumn, multipleSelection, whereClause, lookup, 0, queryValue);

		setTitle(Msg.getMsg(Env.getCtx(), "Info"));

		try
		{
			init();
			initComponents();

			p_loadedOK = initInfo ();
			
			processQueryValue();
		}
		catch (Exception e)
		{
			return;
		}

		// Elaine 2008/12/15
		int no = contentPanel.getRowCount();
		setStatusLine(Integer.toString(no) + " " + Msg.getMsg(Env.getCtx(), "SearchRows_EnterQuery"), false);
		setStatusDB(Integer.toString(no));
		//

		if (queryValue != null && queryValue.length() > 0)
        {
			if (!isAutoComplete)
			{
				MTable table = MTable.get(Env.getCtx(), p_tableName);
				if (   table.getIdentifierColumns().length > 1
					&& !p_tableName.startsWith("AD_"))  // 32 AD tables with identifiers containing _
				{
					String separator = I_C_ElementValue.Table_Name.equalsIgnoreCase(p_tableName) ? "-" : "_";
					if (txt2.isVisible())
					{
						String[] values = queryValue.split("["+separator+"]");
						if (values != null && values.length == 2) 
						{
							txt1.setValue(values[0]);
							txt2.setValue(values[1]);
						}
					}
	
				}			
			}
			
            executeQuery();
            renderItems();
        }
		
		if (ClientInfo.isMobile()) {
			ClientInfo.onClientInfo(this, this::onClientInfo);
		}
	}

	private void processQueryValue() {
		if (queryValue != null && queryValue.length() > 0)
		{				
			Textbox[] txts = new Textbox[] {txt1, txt2, txt3, txt4};
			int i = 0;
			for(Textbox t : txts) 
			{
				if (t != null && t.isVisible())
				{
					if (isAutoComplete)
					{
						if (!Util.isEmpty(autoCompleteSearchColumn))
						{
							if (!autoCompleteSearchColumn.equals(m_queryColumns.get(i)))
								continue;
						}
					}
					t.setValue(queryValue);
					testCount();
					if (m_count <= 0)
						t.setValue(null);
					else
						break;
					
					if (isAutoComplete)
						break;
				}
				i++;
			}
			if (m_count <= 0 && !isAutoComplete)
			{
				txt1.setValue(queryValue);
			}
		}
	}

	private void initComponents()
	{
		Grid grid = GridFactory.newGridLayout();
		ZKUpdateUtil.setWidth(grid, "100%");
		ZKUpdateUtil.setVflex(grid, "min");

		layoutParameterGrid(grid);

		layout = new Borderlayout();
		ZKUpdateUtil.setWidth(layout, "100%");
		ZKUpdateUtil.setHeight(layout, "100%");
        layout.setStyle("position: relative");
        this.appendChild(layout);

        North north = new North();
        layout.appendChild(north);
		north.appendChild(grid);
		ZKUpdateUtil.setVflex(north, "min");

        Center center = new Center();
		layout.appendChild(center);
		Div div = new Div();
		div.appendChild(contentPanel);
		ZKUpdateUtil.setWidth(contentPanel, "100%");
        ZKUpdateUtil.setVflex(contentPanel, true);
        contentPanel.setSizedByContent(true);
		center.appendChild(div);
		ZKUpdateUtil.setVflex(div, "1");
		ZKUpdateUtil.setHflex(div, "1");
		ZKUpdateUtil.setVflex(center, "1");

		South south = new South();
		layout.appendChild(south);
		southBody = new Vbox();
		ZKUpdateUtil.setWidth(southBody, "100%");
		south.appendChild(southBody);
		southBody.appendChild(new Separator());
		southBody.appendChild(confirmPanel);		
		southBody.appendChild(statusBar);
		ZKUpdateUtil.setVflex(south, "min");
	}

	protected void layoutParameterGrid(Grid grid) {
		noOfParameterColumn = getNoOfParameterColumn();
		Rows rows = new Rows();
		grid.appendChild(rows);

		Row row = new Row();
		rows.appendChild(row);
		row.appendChild(lbl1.rightAlign());
		row.appendChild(txt1);
		ZKUpdateUtil.setHflex(txt1, "1");
		if (row.getChildren().size() % noOfParameterColumn == 0)
			row = rows.newRow();
		row.appendChild(lbl2.rightAlign());
		row.appendChild(txt2);		
		ZKUpdateUtil.setHflex(txt2, "1");
		if (row.getChildren().size() % noOfParameterColumn == 0)
			row = rows.newRow();
		Cell cell = new Cell();
		cell.setAlign("right");
		cell.setValign("middle");
		Div ldiv = new Div();
		ldiv.appendChild(lbl3);
		cell.appendChild(ldiv);
		row.appendChild(cell);
		cell = new Cell();
		cell.setValign("middle");
		cell.appendChild(txt3);
		row.appendChild(cell);		
		ZKUpdateUtil.setHflex(txt3, "1");
		if (row.getChildren().size() % noOfParameterColumn == 0)
			row = rows.newRow();
		cell = new Cell();
		cell.setAlign("right");
		cell.setValign("middle");
		ldiv = new Div();
		ldiv.appendChild(lbl4);
		cell.appendChild(ldiv);
		row.appendChild(cell);
		cell = new Cell();
		cell.setValign("middle");
		cell.appendChild(txt4);
		row.appendChild(cell);
		ZKUpdateUtil.setHflex(txt4, "1");
	}

	private int getNoOfParameterColumn() {
		if (ClientInfo.maxWidth(ClientInfo.EXTRA_SMALL_WIDTH-1))
			return 2;
		else if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1))
			return 4;
		else if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1))
			return 6;
		else
			return 8;
	}

	private void init()
	{
		txt1 = new Textbox();
		txt2 = new Textbox();
		txt3 = new Textbox();
		txt4 = new Textbox();
		
		txt1.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "textbox1");
		txt2.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "textbox2");
		txt3.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "textbox3");
		txt4.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "textbox4");

		lbl1 = new Label();
		lbl2 = new Label();
		lbl3 = new Label();
		lbl4 = new Label();
	}

	private boolean initInfo ()
	{
		if (!initInfoTable())
			return false;

		//  Prepare table

		StringBuilder where = new StringBuilder(p_tableName).append(".").append("IsActive='Y'");

		if (p_whereClause.length() > 0)
			where.append(" AND (").append(p_whereClause).append(")");
		prepareTable(m_generalLayout, p_tableName, where.toString(), "2");
		contentPanel.repaint();
		
		//	Set & enable Fields

		lbl1.setValue(Util.cleanAmp(Msg.translate(Env.getCtx(), m_queryColumns.get(0).toString())));

		if (m_queryColumns.size() > 1)
		{
			lbl2.setValue(Msg.translate(Env.getCtx(), m_queryColumns.get(1).toString()));
		}
		else
		{
			lbl2.setVisible(false);
			txt2.setVisible(false);
		}

		if (m_queryColumns.size() > 2)
		{
			lbl3.setValue(Msg.translate(Env.getCtx(), m_queryColumns.get(2).toString()));
		}
		else
		{
			lbl3.setVisible(false);
			txt3.setVisible(false);
			hideCell(lbl3);
			hideCell(txt3);
		}

		if (m_queryColumns.size() > 3)
		{
			lbl4.setValue(Msg.translate(Env.getCtx(), m_queryColumns.get(3).toString()));
		}
		else
		{
			lbl4.setVisible(false);
			txt4.setVisible(false);
			hideCell(lbl4);
			hideCell(txt4);
		}
		return true;
	}

	private void hideCell(Component comp) {
		Component p = comp.getParent();
		while (p != null)
		{
			if (p instanceof Cell)
			{
				p.setVisible(false);
				break;
			}
			p = p.getParent();
		}
	}

	private boolean initInfoTable ()
	{
		//	Get Query Columns

		String sql = "SELECT c.ColumnName, t.AD_Table_ID, t.TableName, c.ColumnSql "
			+ "FROM AD_Table t"
			+ " INNER JOIN AD_Column c ON (t.AD_Table_ID=c.AD_Table_ID)"
			+ "WHERE c.AD_Reference_ID IN (10,14)"
			+ " AND t.TableName=?"	//	#1
			//	Displayed in Window
			+ " AND EXISTS (SELECT * FROM AD_Field f "
				+ "WHERE f.AD_Column_ID=c.AD_Column_ID"
				+ " AND f.IsDisplayed='Y' AND f.IsEncrypted='N' AND f.ObscureType IS NULL) "
			+ "ORDER BY c.IsIdentifier DESC, c.IsSelectionColumn Desc, c.AD_Reference_ID, c.SeqNoSelection, c.SeqNo";

		int AD_Table_ID = 0;
		String tableName = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setString(1, p_tableName);
			rs = pstmt.executeQuery();

			while (rs.next())
			{
				m_queryColumns.add(rs.getString(1));
				String columnSql = rs.getString(4);
				if (columnSql != null && columnSql.length() > 0 && columnSql.contains("@"))
					columnSql = "NULL";
				if (columnSql != null && columnSql.contains("@"))
					columnSql = Env.parseContext(Env.getCtx(), -1, columnSql, false, true);
				String qualified = p_tableName+"."+rs.getString(1);
				if (columnSql != null && columnSql.length() > 0)
					m_queryColumnsSql.add(columnSql);
				else
					m_queryColumnsSql.add(qualified);

				if (AD_Table_ID == 0)
				{
					AD_Table_ID = rs.getInt(2);
					tableName = rs.getString(3);
				}
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return false;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		//	Miminum check
		if (m_queryColumns.size() == 0)
		{
			Dialog.error(p_WindowNo, "Error", Msg.getMsg(Env.getCtx(),"NoQueryColumnsFound"));
			log.log(Level.SEVERE, "No query columns found");
			return false;
		}

		if (log.isLoggable(Level.FINEST)) log.finest("Table " + tableName + ", ID=" + AD_Table_ID
			+ ", QueryColumns #" + m_queryColumns.size());

		//	Only 4 Query Columns
		while (m_queryColumns.size() > 4)
		{
			m_queryColumns.remove(m_queryColumns.size()-1);
			m_queryColumnsSql.remove(m_queryColumnsSql.size()-1);
		}

		//  Set Title
		String title = Msg.translate(Env.getCtx(), tableName + "_ID");  //  best bet

		if (title.endsWith("_ID"))
			title = Msg.translate(Env.getCtx(), tableName);             //  second best bet

		setTitle(getTitle() + " " + title);

		//	Get Display Columns

		ArrayList<ColumnInfo> list = new ArrayList<ColumnInfo>();
		sql = "SELECT c.ColumnName, c.AD_Reference_ID, c.IsKey, f.IsDisplayed, c.AD_Reference_Value_ID, c.ColumnSql, c.AD_Column_ID "
			+ "FROM AD_Column c"
			+ " INNER JOIN AD_Table t ON (c.AD_Table_ID=t.AD_Table_ID)"
			+ " INNER JOIN AD_Tab tab ON (t.AD_Window_ID=tab.AD_Window_ID)"
			+ " INNER JOIN AD_Field f ON (tab.AD_Tab_ID=f.AD_Tab_ID AND f.AD_Column_ID=c.AD_Column_ID) "
			+ "WHERE t.AD_Table_ID=? "
			+ " AND tab.IsSortTab='N'"
			+ " AND tab.Ad_Tab_ID=(SELECT MIN(mt.AD_Tab_ID) FROM AD_tab mt WHERE mt.AD_Window_ID=t.AD_Window_ID AND mt.AD_Table_ID=t.AD_Table_ID AND mt.IsActive='Y')"
			+ " AND (c.IsKey='Y' OR "
				+ " (f.IsEncrypted='N' AND f.ObscureType IS NULL)) "
			+ "ORDER BY c.IsKey DESC, f.SeqNo";

		try
		{
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, AD_Table_ID);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				String columnName = rs.getString(1);
				int displayType = rs.getInt(2);
				boolean isKey = rs.getString(3).equals("Y");
				boolean isDisplayed = rs.getString(4).equals("Y");
				int AD_Reference_Value_ID = rs.getInt(5);
				String columnSql = rs.getString(6);
				if (columnSql != null && columnSql.length() > 0 && (columnSql.startsWith("@SQL=") || columnSql.startsWith("@SQLFIND=")))
					columnSql = "NULL";
				if (columnSql != null && columnSql.contains("@"))
					columnSql = Env.parseContext(Env.getCtx(), -1, columnSql, false, true);
				if (columnSql == null || columnSql.length() == 0)
					columnSql = tableName+"."+columnName;
				int AD_Column_ID = rs.getInt(7);

				//  Default
				StringBuffer colSql = new StringBuffer(columnSql);
				Class<?> colClass = null;

				if (isKey)
					colClass = IDColumn.class;
				else if (!isDisplayed)
					;
				else if (displayType == DisplayType.YesNo)
					colClass = Boolean.class;
				else if (displayType == DisplayType.Amount)
					colClass = BigDecimal.class;
				else if (displayType == DisplayType.Number || displayType == DisplayType.Quantity)
					colClass = Double.class;
				else if (displayType == DisplayType.Integer)
					colClass = Integer.class;
				else if (displayType == DisplayType.String || displayType == DisplayType.Text || displayType == DisplayType.Memo)
					colClass = String.class;
				else if (DisplayType.isDate(displayType))
					colClass = Timestamp.class;
				//  ignore Binary, Button, ID, RowID
				else if (displayType == DisplayType.List)
				{
					if (Env.isBaseLanguage(Env.getCtx(), "AD_Ref_List"))
						colSql = new StringBuffer("(SELECT l.Name FROM AD_Ref_List l WHERE l.AD_Reference_ID=")
							.append(AD_Reference_Value_ID).append(" AND l.Value=").append(columnSql)
							.append(") AS ").append(columnName);
					else
						colSql = new StringBuffer("(SELECT t.Name FROM AD_Ref_List l, AD_Ref_List_Trl t "
							+ "WHERE l.AD_Ref_List_ID=t.AD_Ref_List_ID AND l.AD_Reference_ID=")
							.append(AD_Reference_Value_ID).append(" AND l.Value=").append(columnSql)
							.append(" AND t.AD_Language='").append(Env.getAD_Language(Env.getCtx()))
							.append("') AS ").append(columnName);
					colClass = String.class;
				}

				if (colClass != null)
				{
					list.add(new ColumnInfo(Msg.translate(Env.getCtx(), columnName), colSql.toString(), colClass, true, columnName ));
					if (log.isLoggable(Level.FINEST)) log.finest("Added Column=" + columnName);
				}
				else if (isDisplayed && DisplayType.isLookup(displayType))
				{
					ColumnInfo colInfo = createLookupColumnInfo(Msg.translate(Env.getCtx(), columnName), columnName, displayType, AD_Reference_Value_ID, AD_Column_ID, colSql.toString());
					if (colInfo != null)
					{
						list.add(colInfo);
					}
					else
					{
						if (log.isLoggable(Level.FINEST)) log.finest("Not Added Column=" + columnName);
					}
					
				}
				else
					if (log.isLoggable(Level.FINEST)) log.finest("Not Added Column=" + columnName);
			}
		}
		catch (SQLException e)
		{
			log.log(Level.SEVERE, sql, e);
			return false;
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null;
			pstmt = null;
		}

		if (list.size() == 0)
		{
			Dialog.error(p_WindowNo, "Error", "No Info Columns");
			log.log(Level.SEVERE, "No Info for AD_Table_ID=" + AD_Table_ID + " - " + sql);
			return false;
		}

		if (log.isLoggable(Level.FINEST)) log.finest("InfoColumns #" + list.size());

		//  Convert ArrayList to Array
		m_generalLayout = new ColumnInfo[list.size()];
		list.toArray(m_generalLayout);
		return true;
	}

	@Override
	public String getSQLWhere()
	{
		StringBuffer sql = new StringBuffer();
		addSQLWhere (sql, 0, txt1.getText().toUpperCase());
		addSQLWhere (sql, 1, txt2.getText().toUpperCase());
		addSQLWhere (sql, 2, txt3.getText().toUpperCase());
		addSQLWhere (sql, 3, txt4.getText().toUpperCase());
		return sql.toString();
	}

	private void addSQLWhere(StringBuffer sql, int index, String value)
	{
		if (!(value.equals("")) && index < m_queryColumns.size())
		{
			// Angelo Dabala' (genied) nectosoft: [2893220] avoid to append string parameters directly because of special chars like quote(s)
			sql.append(" AND UPPER(").append(m_queryColumnsSql.get(index).toString()).append(") LIKE ?");
		}
	}

	/**
	 *  Get SQL WHERE parameter
	 *  @param f field
	 *  @return sql part
	 */
	private String getSQLText (Textbox f)
	{
		String s = f.getText().toUpperCase();
		if (!s.endsWith("%"))
			s += "%";
		if (log.isLoggable(Level.FINE)) log.fine( "String=" + s);
		return s;
	}   //  getSQLText

	protected void resetParameters() {
		txt1.setValue("");
		txt2.setValue("");
		txt3.setValue("");
		txt4.setValue("");
	}

	/**
	 *  Set Parameters for Query.
	 *  (as defined in getSQLWhere)
	 * 	@param pstmt statement
	 *  @param forCount for counting records
	 *  @throws SQLException
	 */
	protected void setParameters(PreparedStatement pstmt, boolean forCount) throws SQLException
	{
		int index = 1;
		if (txt1.getText().length() > 0)
			pstmt.setString(index++, getSQLText(txt1));
		if (txt2.getText().length() > 0)
			pstmt.setString(index++, getSQLText(txt2));
		if (txt3.getText().length() > 0)
			pstmt.setString(index++, getSQLText(txt3));
		if (txt4.getText().length() > 0)
			pstmt.setString(index++, getSQLText(txt4));
	}   //  setParameters

    @Override
	protected void insertPagingComponent()
    {
		southBody.insertBefore(paging, southBody.getFirstChild());
		layout.invalidate();
    }
    
	protected void onClientInfo() {
		if (layout != null && layout.getNorth() != null && layout.getNorth().getFirstChild() instanceof Grid) {
			int t = getNoOfParameterColumn();
			if (t > 0 && noOfParameterColumn > 0 && t != noOfParameterColumn) {
				Grid grid = (Grid) layout.getNorth().getFirstChild();
				grid.getRows().detach();
				layoutParameterGrid(grid);
				this.invalidate();
			}
		}
	}
	
	protected ColumnInfo createLookupColumnInfo(String name, String columnName, int AD_Reference_ID, int AD_Reference_Value_ID, int AD_Column_ID, String columnSql) {
//		MLookupInfo lookupInfo = MLookupFactory.getLookupInfo(Env.getCtx(), p_WindowNo, AD_Column_ID, AD_Reference_ID, Env.getLanguage(Env.getCtx()), columnName, 
//				AD_Reference_Value_ID, false, null);
//		String displayColumn = lookupInfo.DisplayColumn;
//		String keyColumn = lookupInfo.KeyColumn;
		
		MTable table = MTable.get(Env.getCtx(), p_tableName);
		MColumn column = table.getColumn(columnName);
		String baseColumn = column.isVirtualColumn() ? columnSql : columnName;

		String embedded = AD_Reference_Value_ID > 0 ? MLookupFactory.getLookup_TableEmbed(Env.getLanguage(Env.getCtx()), columnName, p_tableName, AD_Reference_Value_ID)
				: MLookupFactory.getLookup_TableDirEmbed(Env.getLanguage(Env.getCtx()), columnName, p_tableName, baseColumn);
		embedded = "(" + embedded + ")";
	
		if (embedded.contains("@"))
			embedded = "NULL";
		
		ColumnInfo columnInfo = null;
		if (columnName.endsWith("_ID")  && !column.isVirtualColumn())
			columnInfo = new ColumnInfo(name, embedded, KeyNamePair.class, true, false, p_tableName+"."+columnName, columnName);
		else
			columnInfo = new ColumnInfo(name, embedded, String.class, true, false, null, columnName);
		return columnInfo;
	}
}
