/**
 * 
 */
package org.adempiere.webui.info;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.panel.InfoPanel;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.AccessSqlParser;
import org.compiere.model.AccessSqlParser.TableInfo;
import org.compiere.model.GridField;
import org.compiere.model.GridFieldVO;
import org.compiere.model.MColumn;
import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Div;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vbox;

/**
 * AD_InfoWindow implementation
 * @author hengsin
 *
 */
public class InfoWindow extends InfoPanel implements ValueChangeListener {

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -6235804178650786285L;
	protected Grid parameterGrid;
	private Borderlayout layout;
	private Vbox southBody;
	/** List of WEditors            */
    private List<WEditor> editors;
    protected Properties infoContext;

	/** Max Length of Fields */
    public static final int FIELDLENGTH = 20;
    
    protected ColumnInfo[] columnInfos;
	protected MInfoWindow infoWindow;
	protected TableInfo[] tableInfos;
	protected MInfoColumn[] infoColumns;	
	protected String queryValue;
	
	private List<GridField> gridFields;
	private int AD_InfoWindow_ID;
    
	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param multipleSelection
	 * @param whereClause
	 */
	public InfoWindow(int WindowNo, String tableName, String keyColumn, String queryValue, 
			boolean multipleSelection, String whereClause, int AD_InfoWindow_ID) {
		this(WindowNo, tableName, keyColumn, queryValue, multipleSelection, whereClause, AD_InfoWindow_ID, true);
	}

	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param multipleSelection
	 * @param whereClause
	 * @param lookup
	 */
	public InfoWindow(int WindowNo, String tableName, String keyColumn, String queryValue, 
			boolean multipleSelection, String whereClause, int AD_InfoWindow_ID, boolean lookup) {
		super(WindowNo, tableName, keyColumn, multipleSelection, whereClause,
				lookup);
		this.queryValue = queryValue;
		this.AD_InfoWindow_ID = AD_InfoWindow_ID;
		infoContext = new Properties(Env.getCtx());
		p_loadedOK = loadInfoDefinition(); 
		if (loadedOK()) {
			if (isLookup()) {
				Env.clearTabContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO);
			}
			
			renderWindow();
			
			if (queryValue != null && queryValue.trim().length() > 0)
			{
				prepareTable();
				processQueryValue();
			}
		}
	}

	private void processQueryValue() {
		//try first 2 only
		String[] values = queryValue.split("[_]");
		if (values.length == 2) {
			for(int i = 0; i < values.length && i < editors.size(); i++) {
				WEditor editor = editors.get(i);
				editor.setValue(values[i]);
			}
			testCount();
		} else {
			for(int i = 0; i < editors.size() && i < 2; i++) {
				WEditor editor = editors.get(i);
				editor.setValue(queryValue);
				testCount();
				if (m_count > 0) {
					break;
				} else {
					editor.setValue(null);
				}
			}
		}
		
		if (m_count > 0) {
			executeQuery();
			renderItems();
		} else if (editors.size() > 0 && values.length != 2) {
			editors.get(0).setValue(queryValue);
		}
	}

	private boolean loadInfoDefinition() {
		if (AD_InfoWindow_ID > 0) {
			infoWindow = new MInfoWindow(Env.getCtx(), AD_InfoWindow_ID, null);
			String tableName = MTable.getTableName(Env.getCtx(), infoWindow.getAD_Table_ID());
			if (!tableName.equalsIgnoreCase(p_tableName)) {
				throw new IllegalArgumentException("AD_InfoWindow.TableName <> TableName argument. ("+tableName + " <> " + p_tableName+")");
			}
		} else {
			infoWindow = MInfoWindow.get(p_tableName, (String)null);			
		}
		
		if (infoWindow != null) {
			AccessSqlParser sqlParser = new AccessSqlParser("SELECT * FROM " + infoWindow.getFromClause());
			tableInfos = sqlParser.getTableInfo(0);
			if (tableInfos[0].getSynonym() != null && tableInfos[0].getSynonym().trim().length() > 0) {
				p_tableName = tableInfos[0].getSynonym().trim();
				if (p_whereClause != null && p_whereClause.trim().length() > 0) {
					p_whereClause = p_whereClause.replace(tableInfos[0].getTableName()+".", p_tableName+".");
				}					
			}
			
			infoColumns = infoWindow.getInfoColumns(tableInfos);
		
			gridFields = new ArrayList<GridField>();
			for(MInfoColumn infoColumn : infoColumns) {
				String columnName = infoColumn.getColumnName();
				GridFieldVO vo = GridFieldVO.createParameter(infoContext, p_WindowNo, 0, 
						columnName, infoColumn.get_Translation("Name"), infoColumn.getAD_Reference_ID(), 
						infoColumn.getAD_Reference_Value_ID(), false, false);
				if (infoColumn.getAD_Val_Rule_ID() > 0) {
					vo.ValidationCode = infoColumn.getAD_Val_Rule().getCode();
				}
				GridField gridField = new GridField(vo);
				gridFields.add(gridField);
			}
			
			StringBuilder builder = new StringBuilder(p_whereClause != null ? p_whereClause.trim() : "");
			String infoWhereClause = infoWindow.getWhereClause();
			if (infoWhereClause != null && infoWhereClause.indexOf("@") >= 0) {
				infoWhereClause = Env.parseContext(Env.getCtx(), p_WindowNo, infoWhereClause, false, false);
				if (infoWhereClause.length() == 0)
					log.log(Level.SEVERE, "Cannot parse context= " + infoWindow.getWhereClause());
			}
			if (infoWhereClause != null && infoWhereClause.trim().length() > 0) {								
				if (builder.length() > 0) {
					builder.append(" AND ");
				}
				builder.append(infoWhereClause);
				p_whereClause = builder.toString();
			}
			
			return true;
		} else {
			return false;
		}
	}

	private void prepareTable() {		
		List<ColumnInfo> list = new ArrayList<ColumnInfo>();
		String keyTableAlias = tableInfos[0].getSynonym() != null && tableInfos[0].getSynonym().trim().length() > 0 
				? tableInfos[0].getSynonym()
				: tableInfos[0].getTableName();
					
		String keySelectClause = keyTableAlias+"."+p_keyColumn;
		list.add(new ColumnInfo(" ", keySelectClause, IDColumn.class));
		
		int i = 0;
		for(MInfoColumn infoColumn : infoColumns) 
		{						
			if (infoColumn.isDisplayed(infoContext, p_WindowNo)) 
			{
				ColumnInfo columnInfo = null;
				if (infoColumn.getAD_Reference_ID() == DisplayType.ID) 
				{
					if (infoColumn.getSelectClause().equalsIgnoreCase(keySelectClause))
						continue;
					
					columnInfo = new ColumnInfo(infoColumn.getName(), infoColumn.getSelectClause(), DisplayType.getClass(infoColumn.getAD_Reference_ID(), true));
				}
				else if (DisplayType.isLookup(infoColumn.getAD_Reference_ID()))
				{
					if (infoColumn.getAD_Reference_ID() == DisplayType.List)
					{
						columnInfo = new ColumnInfo(infoColumn.getName(), infoColumn.getSelectClause(), ValueNamePair.class, (String)null);
					}
					else
					{
						columnInfo = createLookupColumnInfo(tableInfos, gridFields.get(i), infoColumn);
					}					
				}
				else  
				{
					columnInfo = new ColumnInfo(infoColumn.getName(), infoColumn.getSelectClause(), DisplayType.getClass(infoColumn.getAD_Reference_ID(), true));
				}
				columnInfo.setGridField(gridFields.get(i));
				list.add(columnInfo);				
			}		
			i++;
		}
		
		columnInfos = list.toArray(new ColumnInfo[0]);
		
		prepareTable(columnInfos, infoWindow.getFromClause(), p_whereClause, infoWindow.getOrderByClause());		
	}

	private ColumnInfo createLookupColumnInfo(TableInfo[] tableInfos,
			GridField gridField, MInfoColumn infoColumn) {
		String columnName = gridField.getColumnName();
		int AD_Reference_Value_ID = 0;
		String validationCode = "";
		MLookupInfo lookupInfo = MLookupFactory.getLookupInfo(Env.getCtx(), p_WindowNo, 0, infoColumn.getAD_Reference_ID(), null, columnName, AD_Reference_Value_ID, false, validationCode);
		String displayColumn = lookupInfo.DisplayColumn;
		
		int index = infoColumn.getSelectClause().indexOf(".");
		if (index == infoColumn.getSelectClause().lastIndexOf("."))
		{
			String synonym = infoColumn.getSelectClause().substring(0, index);
			for(TableInfo tableInfo : tableInfos)
			{
				if (tableInfo.getSynonym() != null && tableInfo.getSynonym().equals(synonym)) 
				{
					if (tableInfo.getTableName().equalsIgnoreCase(lookupInfo.TableName))
					{
						displayColumn = displayColumn.replace(lookupInfo.TableName+".", tableInfo.getSynonym()+".");
						ColumnInfo columnInfo = new ColumnInfo(infoColumn.getName(), displayColumn, KeyNamePair.class, infoColumn.getSelectClause());
						return columnInfo;
					}
					break;
				}
			}
		}
		
		WEditor editor = null;
        editor = WebEditorFactory.getEditor(gridField, true);
        editor.setMandatory(false);
        editor.setReadWrite(false);
        editorMap.put(infoColumn.getSelectClause(), editor);
        
		ColumnInfo columnInfo = new ColumnInfo(infoColumn.getName(), infoColumn.getSelectClause(), KeyNamePair.class, (String)null);
		return columnInfo;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.panel.InfoPanel#getSQLWhere()
	 */
	@Override
	protected String getSQLWhere() {
		StringBuilder builder = new StringBuilder();
		MTable table = MTable.get(Env.getCtx(), infoWindow.getAD_Table_ID());
		if (table.get_ColumnIndex("IsActive") >=0 ) {
			if (p_whereClause != null && p_whereClause.trim().length() > 0) {
				builder.append(" AND ");
			}
			builder.append(tableInfos[0].getSynonym()).append(".IsActive='Y'");
		}
		for(WEditor editor : editors) {
			if (editor.getGridField() != null && editor.getValue() != null && editor.getValue().toString().trim().length() > 0) {
				if (builder.length() > 0) {
					builder.append(" AND ");
				} else if (p_whereClause != null && p_whereClause.trim().length() > 0) {
					builder.append(" AND ");
				}
				String columnName = editor.getColumnName();
				for(MInfoColumn infoColumn: infoColumns) {
					if (columnName.equals(infoColumn.getColumnName())) {
						columnName = infoColumn.getSelectClause();
					}
				}
				if (isSearchLike(editor.getGridField())) {
					builder.append("UPPER(")
						   .append(columnName)
						   .append(") LIKE ?");
				} else {
					builder.append(columnName).append("=?");
				}
			}
		}		
		return builder.toString();
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.panel.InfoPanel#setParameters(java.sql.PreparedStatement, boolean)
	 */
	@Override
	protected void setParameters(PreparedStatement pstmt, boolean forCount)
			throws SQLException {
		int parameterIndex = 0;
		for(WEditor editor : editors) {
			Object value = editor.getValue();
			if (value != null && value.toString().trim().length() > 0) {
				parameterIndex++;
				if (value instanceof Boolean) {					
					pstmt.setString(parameterIndex, ((Boolean) value).booleanValue() ? "Y" : "N");
				} else if (value instanceof String) {
					if (isSearchLike(editor.getGridField())) {
						StringBuilder valueStr = new StringBuilder(value.toString().toUpperCase());
	                    if (!valueStr.toString().endsWith("%"))
	                        valueStr.append("%");
	                    pstmt.setString(parameterIndex, valueStr.toString());
					} else {
						pstmt.setString(parameterIndex, (String)value);
					}
				} else {
					pstmt.setObject(parameterIndex, value);
				}
				
			}
		}

	}

	@Override
	protected void prepareTable(ColumnInfo[] layout, String from, String where,
			String orderBy) {
		super.prepareTable(layout, from, where, orderBy);
		if (m_sqlMain.indexOf("@") >= 0) {
			String sql = Env.parseContext(infoContext, p_WindowNo, m_sqlMain, true);
			if (sql == null || sql.length() == 9) {
				log.severe("Failed to parsed sql. sql=" + m_sqlMain);
			} else {
				m_sqlMain = sql;
			}
		}
		
		if (infoWindow.isDistinct()) {
			m_sqlMain = m_sqlMain.substring("SELECT ".length());
			m_sqlMain = "SELECT DISTINCT " + m_sqlMain;
		}	
		
		if (m_sqlOrder != null && m_sqlOrder.indexOf("@") >= 0) {
			String sql = Env.parseContext(infoContext, p_WindowNo, m_sqlOrder, false, false);
			if (sql == null || sql.length() == 9) {
				log.severe("Failed to parsed sql. sql=" + m_sqlOrder);
			} else {
				m_sqlOrder = sql;
			}
		}
	}

	protected void renderWindow()
	{		
		setTitle(infoWindow.get_Translation("Name"));
		layout = new Borderlayout();
        layout.setWidth("100%");
        layout.setHeight("100%");
        if (!isLookup())
        {
        	layout.setStyle("position: absolute");
        }
        this.appendChild(layout);
		
        if (isLookup())
			contentPanel.setWidth("99%");
        else
        	contentPanel.setStyle("width: 99%; margin: 0px auto;");
        contentPanel.setVflex(true);
        
        North north = new North();
        layout.appendChild(north);
        renderParameterPane(north);

        Center center = new Center();
		layout.appendChild(center);
        renderContentPane(center);		

        South south = new South();
		layout.appendChild(south);
		renderFooter(south);		
	}

	protected void renderFooter(South south) {		
		southBody = new Vbox();
		southBody.setHflex("1");
		south.appendChild(southBody);
		southBody.appendChild(new Separator());
		southBody.appendChild(confirmPanel);
		southBody.appendChild(statusBar);
	}

	protected void renderContentPane(Center center) {				
		Div div = new Div();
		div.setStyle("width :100%; height: 100%");
		div.setVflex("1");
		div.setHflex("1");
		div.appendChild(contentPanel);				
		center.appendChild(div);
	}

	protected void renderParameterPane(North north) {
		createParameterPanel();        
		north.appendChild(parameterGrid);
	}

	protected void createParameterPanel() {
		parameterGrid = GridFactory.newGridLayout();
		parameterGrid.setInnerWidth("auto");
		parameterGrid.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "infoParameterPanel");
		
		Rows rows = new Rows();
		parameterGrid.appendChild(rows);
		
		editors = new ArrayList<WEditor>();
		for (int i = 0; i < infoColumns.length; i++)
		{
			if (infoColumns[i].isQueryCriteria())
				addSelectionColumn(gridFields.get(i));
		}
	}
	
	/**
     *  Add Selection Column to first Tab
     *  @param mField field
    **/
    protected void addSelectionColumn(GridField mField)
    {
        int displayLength = mField.getDisplayLength();
        if (displayLength <= 0 || displayLength > FIELDLENGTH)
            mField.setDisplayLength(FIELDLENGTH);
        else
            displayLength = 0;

        //  Editor
        WEditor editor = null;
        editor = WebEditorFactory.getEditor(mField, false);
        editor.setMandatory(false);
        editor.setReadWrite(true);
        editor.dynamicDisplay();
        editor.addValueChangeListener(this);
        editor.fillHorizontal();
        Label label = editor.getLabel();
        Component fieldEditor = editor.getComponent();

        //
        if (displayLength > 0)      //  set it back
            mField.setDisplayLength(displayLength);
        //

        addSearchParameter(label, fieldEditor);
        
        editors.add(editor);

        fieldEditor.addEventListener(Events.ON_OK,this);
    }   // addSelectionColumn

	protected void addSearchParameter(Label label, Component fieldEditor) {
		Row panel = null;
        if (parameterGrid.getRows().getChildren().isEmpty())
        {
        	panel = new Row();
        	parameterGrid.getRows().appendChild(panel);
        }
        else
        {
        	panel = (Row) parameterGrid.getRows().getLastChild();
        	if (panel.getChildren().size() >= 6)
        	{
        		panel = new Row();
            	parameterGrid.getRows().appendChild(panel); 
        	}
        }
        if (!(fieldEditor instanceof Checkbox))
        {
        	panel.appendChild(label.rightAlign());
        } else {
        	panel.appendChild(new Space());
        }
        panel.appendChild(fieldEditor);
	}
    
    /**
     *  Save Selection Details
     *  Get Location/Partner Info
     */
    @Override
    protected void saveSelectionDetail()
    {
        int row = contentPanel.getSelectedRow();
        if (row == -1)
            return;

        int column = 0;
        for(ColumnInfo columnInfo : columnInfos) 
        {        	
        	GridField field = columnInfo.getGridField();
        	if (field == null) continue;
        	
        	String columnName = field.getColumnName();
        	if (columnInfo.getColClass().equals(KeyNamePair.class))
        	{
        		KeyNamePair knp = (KeyNamePair) contentPanel.getValueAt(row, column);
        		Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, columnName, knp == null ? "0" : knp.getID());
        	}
        	else if (columnName.endsWith("_ID")) 
        	{
        		Object id = contentPanel.getValueAt(row, column);
        		Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, columnName, id == null ? "0" : id.toString());
        	}
        	else
        	{
        		Object value = contentPanel.getValueAt(row, column);
        		Env.setContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO, field.getColumnName(), value == null ? "" : value.toString());
        	}
        	column++;
        }
    }   //  saveSelectionDetail
    
    @Override
    protected String buildDataSQL(int start, int end) {
		String dataSql;
		String dynWhere = getSQLWhere();
        StringBuilder sql = new StringBuilder (m_sqlMain);
        if (dynWhere.length() > 0)
            sql.append(dynWhere);   //  includes first AND
        
        if (sql.toString().trim().endsWith("WHERE")) {
        	int index = sql.lastIndexOf(" WHERE");
        	sql.delete(index, sql.length());
        }
        
        dataSql = Msg.parseTranslation(Env.getCtx(), sql.toString());    //  Variables
        dataSql = MRole.getDefault().addAccessSQL(dataSql, getTableName(),
            MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);
        
        if (infoWindow.getOtherClause() != null && infoWindow.getOtherClause().trim().length() > 0) {
        	String otherClause = infoWindow.getOtherClause();
        	if (otherClause.indexOf("@") >= 0) {
        		String s = Env.parseContext(infoContext, p_WindowNo, otherClause, false, false);
        		if (s.length() == 0) {
        			log.severe("Failed to parse other clause. " + otherClause);
        		} else {
        			otherClause = s;
        		}
        	}
        	dataSql = dataSql + " " + otherClause;
        }
        
        if (m_sqlUserOrder != null && m_sqlUserOrder.trim().length() > 0)
        	dataSql = dataSql + m_sqlUserOrder;
        else
        	dataSql = dataSql + m_sqlOrder;
        
        if (end > start && isUseDatabasePaging() && DB.getDatabase().isPagingSupported())
        {
        	dataSql = DB.getDatabase().addPagingSQL(dataSql, getCacheStart(), getCacheEnd());
        }
		return dataSql;
	}
    
    @Override
    protected void executeQuery() {
    	prepareTable();
    	super.executeQuery();
    }
    
    private boolean isSearchLike(GridField field)
	{
		return DisplayType.isText(field.getDisplayType())
		&& MColumn.isSuggestSelectionColumn(field.getColumnName(), true);
	}

	@Override
	public void valueChange(ValueChangeEvent evt) {
		if (evt != null && evt.getSource() instanceof WEditor)
        {
            WEditor editor = (WEditor)evt.getSource();
            if (evt.getNewValue() == null)
            	Env.setContext(infoContext, p_WindowNo, editor.getColumnName(), "");
            else if (evt.getNewValue() instanceof Boolean)
            	Env.setContext(infoContext, p_WindowNo, editor.getColumnName(), (Boolean)evt.getNewValue());
            else if (evt.getNewValue() instanceof Timestamp)
            	Env.setContext(infoContext, p_WindowNo, editor.getColumnName(), (Timestamp)evt.getNewValue());
            else
            	Env.setContext(infoContext, p_WindowNo, editor.getColumnName(), evt.getNewValue().toString());
            
            for(WEditor otherEditor : editors)
            {
            	if (otherEditor == editor) 
            		continue;
            	
            	editor.dynamicDisplay();
            }
        }
		
	}    
}
