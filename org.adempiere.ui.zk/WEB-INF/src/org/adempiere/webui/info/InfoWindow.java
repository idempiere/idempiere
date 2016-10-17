/**
 * 
 */
package org.adempiere.webui.info;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.TreeMap;
import java.util.logging.Level;

import org.adempiere.model.IInfoColumn;
import org.adempiere.model.MInfoProcess;
import org.adempiere.model.MInfoRelated;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ISupportMask;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Borderlayout;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.EditorBox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.ListModelTable;
import org.adempiere.webui.component.Menupopup;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.grid.WQuickEntry;
import org.adempiere.webui.panel.InfoPanel;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.FDialog;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.EmbedWinInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.model.AccessSqlParser;
import org.compiere.model.AccessSqlParser.TableInfo;
import org.compiere.model.GridField;
import org.compiere.model.GridFieldVO;
import org.compiere.model.GridWindow;
import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MProcess;
import org.compiere.model.MRole;
import org.compiere.model.MTable;
import org.compiere.model.X_AD_InfoColumn;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.au.out.AuEcho;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.SwipeEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Center;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.ComboitemRenderer;
import org.zkoss.zul.Div;
import org.zkoss.zul.ListModelList;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.North;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vbox;

/**
 * AD_InfoWindow implementation
 * @author hengsin
 * @contributor red1 	IDEMPIERE-1711 Process button (reviewed by Hengsin)
 * @contributor xolali 	IDEMPIERE-1045 Sub-Info Tabs  (reviewed by red1)
 */
public class InfoWindow extends InfoPanel implements ValueChangeListener, EventListener<Event> {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8358292103127594383L;
	protected Grid parameterGrid;
	private Borderlayout layout;
	private Vbox southBody;
	/** List of WEditors            */
    protected List<WEditor> editors;
    protected List<WEditor> identifiers;
    protected Properties infoContext;

    /** embedded Panel **/
    Tabbox embeddedPane = new Tabbox();
    ArrayList <EmbedWinInfo> embeddedWinList = new ArrayList <EmbedWinInfo>();

	/** Max Length of Fields */
    public static final int FIELDLENGTH = 20;
    
    protected ColumnInfo[] columnInfos;
	protected TableInfo[] tableInfos;
	protected MInfoColumn[] infoColumns;	
	protected String queryValue;
	protected WQuickEntry vqe;
	
	private List<GridField> gridFields;
	private Checkbox checkAND;
	
	/**
	 * Menu contail process menu item
	 */
	protected Menupopup ipMenu;
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
		this(WindowNo, tableName, keyColumn, queryValue, multipleSelection, whereClause, AD_InfoWindow_ID, lookup, null);		
	}

	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param multipleSelection
	 * @param whereClause
	 * @param lookup
	 * @param gridfield
	 */
	public InfoWindow(int WindowNo, String tableName, String keyColumn, String queryValue, 
			boolean multipleSelection, String whereClause, int AD_InfoWindow_ID, boolean lookup, GridField field) {
		super(WindowNo, tableName, keyColumn, multipleSelection, whereClause,
				lookup, AD_InfoWindow_ID);
		this.m_gridfield = field;
		this.queryValue = queryValue;

   		//Xolali IDEMPIERE-1045
   		contentPanel.addActionListener(new EventListener<Event>() {
   			public void onEvent(Event event) throws Exception {
   				updateSubcontent();
   			}
   		}); //xolali --end-

		infoContext = new Properties(Env.getCtx());
		p_loadedOK = loadInfoDefinition(); 
		
		// make process button only in windown mode
		if (!m_lookup){
		// IDEMPIERE-1334
			initInfoProcess();
			// when have a process, force multi select mode
			if (haveProcess)
				p_multipleSelection = true;
		}		
				
		loadInfoRelatedTabs();
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
	
	/**
	* {@inheritDoc}
	*/
	@Override
	protected void updateSubcontent (){
		int row = contentPanel.getSelectedRow();
		if (row >= 0) {
			for (EmbedWinInfo embed : embeddedWinList) {
				// default link column is key column
				int indexData = 0;
				if (columnDataIndex.containsKey(embed.getParentLinkColumnID())){
					// get index of link column
					indexData = p_layout.length + columnDataIndex.get(embed.getParentLinkColumnID());
				}
				refresh(contentPanel.getValueAt(row,indexData),embed);
			}// refresh for all
		}else{
			for (EmbedWinInfo embed : embeddedWinList) {
				refresh(embed);
			}
		}
	}

	/**
	 * IDEMPIERE-1334
	 * load info process info
	 * separate by layout type
	 * init drop list and menu control
	 * set status of haveProcess flag 
	 * @return true when have process, false when no process
	 */
	protected void initInfoProcess() {
		if (infoWindow == null){
			return;
		}
		
		infoProcessList = infoWindow.getInfoProcess(false);
		
		if (infoProcessList.length == 0)
			return;
		
		haveProcess = true;

		// ** layout info process flow order (button list, drop down, dialog,...)
		
		// make list process button
   		for (MInfoProcess infoProcess : infoProcessList){
   		    // just add info process have layout is button
   			if (!MInfoProcess.LAYOUTTYPE_Button.equals(infoProcess.getLayoutType()))
   				continue;
   			
   			if (infoProcessBtList == null)
   				infoProcessBtList = new ArrayList<MInfoProcess> ();
   			
   			infoProcessBtList.add(infoProcess);
   			
   			// make process button
			MProcess process = MProcess.get(Env.getCtx(), infoProcess.getAD_Process_ID());
   			Button btProcess = confirmPanel.addProcessButton(process.get_Translation(MProcess.COLUMNNAME_Name), infoProcess.getImageURL());
   			if (Util.isEmpty(infoProcess.getImageURL(), true)) {
   				btProcess.setImage(null);
   				btProcess.setLabel(process.get_Translation(MProcess.COLUMNNAME_Name));
   			}
   			
   			// save process_id, handle event will use
   			btProcess.setAttribute(PROCESS_ID_KEY, new Integer(infoProcess.getAD_Process_ID()));
   			btProcess.addEventListener(Events.ON_CLICK, this);
   			// save info process to use in handle event
   			btProcess.setAttribute(ATT_INFO_PROCESS_KEY, process);
   			// update tooltip hepl when focus
   			btProcess.addEventListener(Events.ON_FOCUS, this);
   			btProcessList.add(btProcess);
   		}
		
   		// make list process for drop down		
   		for (MInfoProcess infoProcess : infoProcessList){
   			if (!MInfoProcess.LAYOUTTYPE_List.equals(infoProcess.getLayoutType()))
   				continue;
   			
   			if (infoProcessDropList == null)
   				infoProcessDropList = new ArrayList<MInfoProcess>();
   			
   			infoProcessDropList.add(infoProcess);
   		}
   		
		// init combobox control
   		if (infoProcessDropList != null && infoProcessDropList.size() > 0){
   			cbbProcess = new Combobox ();

   			// render item, use name to display
   			cbbProcess.setItemRenderer(new ComboitemRenderer<MInfoProcess>() {
   				public void render(Comboitem item, MInfoProcess data, int index){
   					MProcess process = MProcess.get(Env.getCtx(), data.getAD_Process_ID());
   					item.setValue(process);
   					item.setLabel(process.get_Translation(MProcess.COLUMNNAME_Name));
   					if (!Util.isEmpty(data.getImageURL(), true)) {
   		   	   			item.setImage(ThemeManager.getThemeResource("images/" + data.getImageURL()));
   		   	   		}
   				}
			});
   			
   		    // update tooltip hepl when select a item
   			cbbProcess.addEventListener(Events.ON_SELECT, this);
   			
   			confirmPanel.addComponentsCenter(cbbProcess);

   			btCbbProcess = confirmPanel.addProcessButton(Msg.getMsg(Env.getCtx(), ConfirmPanel.A_PROCESS), null);
   			
   			btCbbProcess.addEventListener(Events.ON_CLICK, this);
   		}
   		
   		// make list process for menu
   		for (MInfoProcess infoProcess : infoProcessList){
   			// just add info process have layout is bt_menu
   			if (!MInfoProcess.LAYOUTTYPE_Menu.equals(infoProcess.getLayoutType())){
   				continue;
   			}
   			
   			if (infoProcessMenuList == null)
   				infoProcessMenuList = new ArrayList<MInfoProcess>();
   			
   			infoProcessMenuList.add(infoProcess);
   			
   			// init popup menu
   			if (ipMenu == null){
   				ipMenu = new Menupopup();
   				ipMenu.setId("ipMenu");
   				confirmPanel.appendChild(ipMenu);
   				
   				// init button to show menu
   				btMenuProcess = confirmPanel.addProcessButton("ProcessMenu", null);
   				btMenuProcess.setPopup("ipMenu, before_start");   				
   			}
   		}
	}
   				   			
	/**
	 * {@inheritDoc} 
	 */
	@Override
	protected void bindInfoProcess (){
		bindInfoProcessBt ();
		bindInfoProcessDropDown ();
		bindInfoProcessMenu ();
	}
	
	/**
	 * evel display logic of process info button
	 * set visible of button base in display logic
	 * when two button set for same process, two button can hiden too, or display too.
	 * this is bug of implementor by never have this case
	 */
	protected void bindInfoProcessBt (){
		if (infoProcessBtList == null){
			return;
		}
				
		// display process in button style		
		for (MInfoProcess infoProcessBt : infoProcessBtList){
			// eval display logic
			for (Button evlBt: btProcessList){
				Integer processId = (Integer)evlBt.getAttribute(PROCESS_ID_KEY);
				if (processId.intValue() == infoProcessBt.getAD_Process_ID()){
					// display or hiden button
					evlBt.setVisible(infoProcessBt.isDisplayed(infoContext, p_WindowNo));
					break;
				}
			}
		}
	}
	
	/**
	 * recreate drop down item by recreate model to set hiden, display of drop down item
	 * when all item is hiden, hiden combobox and process button too
	 */
	protected void bindInfoProcessDropDown (){
		if (infoProcessDropList == null || infoProcessDropList.size() == 0){
			return;
		}				
				
		// list info process after eval display logic
		List<MInfoProcess> infoProcessDropListTmp = new ArrayList<MInfoProcess> (); 
		
		// filter item not display
		for (MInfoProcess infoProcessDropDown : infoProcessDropList){
			if (infoProcessDropDown.isDisplayed(infoContext, p_WindowNo)){
				infoProcessDropListTmp.add(infoProcessDropDown);
			}
		}
		
		// when item is filter out all. don't show combobox
		cbbProcess.setVisible(infoProcessDropListTmp.size() > 0);
		btCbbProcess.setVisible(infoProcessDropListTmp.size() > 0);
		if (infoProcessDropListTmp.size() > 0){			
			ListModelList<MInfoProcess> infoProccessModel = new ListModelList<MInfoProcess>(infoProcessDropListTmp);
			cbbProcess.setModel(infoProccessModel);
		}
				
	}
	
	/**
	 * recreate menu item by set hiden, display of menu item
	 * when all menu item is hiden, hiden process menu button too
	 */
	protected void bindInfoProcessMenu (){
		if (infoProcessMenuList == null || infoProcessMenuList == null)
			return;
		
		ipMenu.getChildren().clear();
		for (MInfoProcess infoProcess : infoProcessMenuList){
			if (!infoProcess.isDisplayed(infoContext, p_WindowNo)){
				continue;
			}
			
			MProcess process = MProcess.get(Env.getCtx(), infoProcess.getAD_Process_ID());
   			// make menu item for each info process
   	   		Menuitem ipMenuItem = new Menuitem();
   	   		ipMenuItem.setLabel(process.get_Translation(MProcess.COLUMNNAME_Name));
   	   		if (!Util.isEmpty(infoProcess.getImageURL(), true)) {
   	   			ipMenuItem.setImage(ThemeManager.getThemeResource("images/" + infoProcess.getImageURL()));
   	   		}   	   		
   	   		ipMenuItem.setAttribute(PROCESS_ID_KEY, infoProcess.getAD_Process_ID());
   	   		ipMenuItem.addEventListener(Events.ON_CLICK, this);
   	   		ipMenu.appendChild(ipMenuItem);
   		}
   		
		btMenuProcess.setVisible(ipMenu.getChildren().size() > 0);
	}

	protected void processQueryValue() {
		isQueryByUser = true;
		for (int i = 0; i < identifiers.size(); i++) {
			WEditor editor = identifiers.get(i);
			try{
				editor.setValue(queryValue);
			}catch(Exception ex){
				log.log(Level.SEVERE, "error", ex.getCause());
			}
			
			testCount(false);
			if (m_count > 0) {
				break;
			} else {
				editor.setValue(null);
			}
		}
		
		boolean splitValue = false;
		if (m_count <= 0) {			
			String[] values = queryValue.split("[_]");
			if (values.length == 2) {
				splitValue = true;
				for(int i = 0; i < values.length && i < identifiers.size(); i++) {
					WEditor editor = identifiers.get(i);
					editor.setValue(values[i]);
				}
				testCount(false);
			} 
		}
		
		if (m_count > 0) {
			executeQuery();
			renderItems();
		} else if (!splitValue) {
			editors.get(0).setValue(queryValue);
		}
		isQueryByUser = false;
	}

	@Override
	protected void loadInfoWindowData (){
		if (m_infoWindowID > 0) {
			infoWindow = new MInfoWindow(Env.getCtx(), m_infoWindowID, null);
		}else {
			infoWindow = MInfoWindow.get(p_tableName, (String)null);			
		}
		
		if (infoWindow == null)
			return;
		if (!infoWindow.isValid()) {
			infoWindow = null;
		} else {
			String tableName = MTable.getTableName(Env.getCtx(), infoWindow.getAD_Table_ID());
			if (!tableName.equalsIgnoreCase(p_tableName)) {
				throw new IllegalArgumentException("AD_InfoWindow.TableName <> TableName argument. ("+tableName + " <> " + p_tableName+")");
			}
		}
	}
	
	protected boolean loadInfoDefinition() {
		if (infoWindow != null) {
			String tableName = null;
				tableName = MTable.getTableName(Env.getCtx(), infoWindow.getAD_Table_ID());
			
			AccessSqlParser sqlParser = new AccessSqlParser("SELECT * FROM " + infoWindow.getFromClause());
			tableInfos = sqlParser.getTableInfo(0);
			if (tableInfos[0].getSynonym() != null && tableInfos[0].getSynonym().trim().length() > 0) {
				p_tableName = tableInfos[0].getSynonym().trim();
				if (p_whereClause != null && p_whereClause.trim().length() > 0) {
					p_whereClause = p_whereClause.replace(tableName+".", p_tableName+".");
				}					
			}
			
			infoColumns = infoWindow.getInfoColumns(tableInfos);
		
			gridFields = new ArrayList<GridField>();
			
			for(MInfoColumn infoColumn : infoColumns) {
				if (infoColumn.isKey())
					keyColumnOfView = infoColumn;
				String columnName = infoColumn.getColumnName();
				/*!m_lookup && infoColumn.isMandatory():apply Mandatory only case open as window and only for criteria field*/
				boolean isMandatory = !m_lookup && infoColumn.isMandatory() && infoColumn.isQueryCriteria();
				GridFieldVO vo = GridFieldVO.createParameter(infoContext, p_WindowNo, AEnv.getADWindowID(p_WindowNo), infoWindow.getAD_InfoWindow_ID(), 0,
						columnName, infoColumn.get_Translation("Name"), infoColumn.getAD_Reference_ID(), 
						infoColumn.getAD_Reference_Value_ID(), isMandatory, false);
				if (infoColumn.getAD_Val_Rule_ID() > 0) {
					vo.ValidationCode = infoColumn.getAD_Val_Rule().getCode();
					if (vo.lookupInfo != null) {
						vo.lookupInfo.ValidationCode = vo.ValidationCode;
						vo.lookupInfo.IsValidated = false;
					}
				}
				if (infoColumn.getDisplayLogic() != null)					
					vo.DisplayLogic =  infoColumn.getDisplayLogic();
				if (infoColumn.isQueryCriteria() && infoColumn.getDefaultValue() != null)
					vo.DefaultValue = infoColumn.getDefaultValue();
				String desc = infoColumn.get_Translation("Description");
				vo.Description = desc != null ? desc : "";
				String help = infoColumn.get_Translation("Help");
				vo.Help = help != null ? help : "";
				GridField gridField = new GridField(vo);
				gridFields.add(gridField);
			}
			
			StringBuilder builder = new StringBuilder(p_whereClause != null ? p_whereClause.trim() : "");
			String infoWhereClause = infoWindow.getWhereClause();
			if (infoWhereClause != null && infoWhereClause.indexOf("@") >= 0) {
				infoWhereClause = Env.parseContext(Env.getCtx(), p_WindowNo, infoWhereClause, true, false);
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

	//private MInfoColumn[] topinfoColumns;//infoWindow.getInfoColumns(tableInfos);
	protected boolean loadInfoRelatedTabs() {
		if (infoWindow == null)
			return false;

		// topinfoColumns = infoWindow.getInfoColumns();
		relatedInfoList = infoWindow.getInfoRelated(true);
		Tabpanels tabPanels = new Tabpanels();
		Tabs tabs = new Tabs();

		if (relatedInfoList.length > 0) { // setup the panel

			//embeddedPane.setTitle(Msg.translate(Env.getCtx(), "Related Information"));
			ZKUpdateUtil.setHeight(embeddedPane, "100%");
			//tabPanels = new Tabpanels();
			embeddedPane.appendChild(tabPanels);
			//tabs = new Tabs();
			embeddedPane.appendChild(tabs);

		}

		//	for(int i=0; i <  relatedinfoList.length - 1 ; i++) {
		for (MInfoRelated relatedInfo:relatedInfoList) {

			String tableName = null;		
			int infoRelatedID = relatedInfo.getRelatedInfo_ID(); 

			MInfoWindow embedInfo = new MInfoWindow(Env.getCtx(), infoRelatedID, null);

			AccessSqlParser sqlParser = new AccessSqlParser("SELECT * FROM " + embedInfo.getFromClause());
			TableInfo[] tableInfos = sqlParser.getTableInfo(0);
			if (tableInfos[0].getSynonym() != null && tableInfos[0].getSynonym().trim().length() > 0){
				tableName = tableInfos[0].getSynonym().trim();
			}

			WListbox embeddedTbl = new WListbox();
			String m_sqlEmbedded;

			//MInfoWindow.getInfoWindow(infoRelatedID);

			if (embedInfo != null) {
				ArrayList<ColumnInfo> list = new ArrayList<ColumnInfo>();
				list = getInfoColumnslayout(embedInfo);
				//  Convert ArrayList to Array
				ColumnInfo[] s_layoutEmbedded  = new ColumnInfo[list.size()];
				list.toArray(s_layoutEmbedded);

				/**	From Clause							*/
				String s_sqlFrom = embedInfo.getFromClause();
				/** Where Clause						*/
				String s_sqlWhere = relatedInfo.getLinkColumnName() + "=?";
				m_sqlEmbedded = embeddedTbl.prepareTable(s_layoutEmbedded, s_sqlFrom, s_sqlWhere, false, tableName);

				embeddedTbl.setMultiSelection(false);

				embeddedTbl.autoSize();

				embeddedTbl.getModel().addTableModelListener(this);
				ZKUpdateUtil.setVflex(embeddedTbl, "1");

				
				//Xolali - add embeddedTbl to list, add m_sqlembedded to list
				EmbedWinInfo ewinInfo = new EmbedWinInfo(embedInfo,embeddedTbl,m_sqlEmbedded,relatedInfo.getLinkColumnName(), relatedInfo.getLinkInfoColumn(), relatedInfo.getParentRelatedColumn_ID());
				embeddedWinList.add(ewinInfo);

				MInfoWindow riw = (MInfoWindow) relatedInfo.getRelatedInfo();
				String tabTitle;
				if (riw != null)
					tabTitle = Util.cleanAmp(riw.get_Translation("Name"));
				else
					tabTitle = relatedInfo.getName();
				Tab tab = new Tab(tabTitle);
				tabs.appendChild(tab);
				Tabpanel desktopTabPanel = new Tabpanel();
				//desktopTabPanel.
				ZKUpdateUtil.setHeight(desktopTabPanel, "100%");
				desktopTabPanel.appendChild(embeddedTbl);
				tabPanels.appendChild(desktopTabPanel);
			}

		}

		return true;
	}

	protected void prepareTable() {		
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
				String colSQL = infoColumn.getSelectClause();
				if (! colSQL.toUpperCase().contains(" AS "))
					colSQL += " AS " + infoColumn.getColumnName();
				if (infoColumn.getAD_Reference_ID() == DisplayType.ID) 
				{
					if (infoColumn.getSelectClause().equalsIgnoreCase(keySelectClause))
						continue;
					
					columnInfo = new ColumnInfo(infoColumn.get_Translation("Name"), colSQL, DisplayType.getClass(infoColumn.getAD_Reference_ID(), true));
				}
				else if (DisplayType.isLookup(infoColumn.getAD_Reference_ID()))
				{
					if (infoColumn.getAD_Reference_ID() == DisplayType.List)
					{
						WEditor editor = null;
						editor = WebEditorFactory.getEditor(gridFields.get(i), true);
				        editor.setMandatory(false);
				        editor.setReadWrite(false);
				        editorMap.put(colSQL, editor);
						columnInfo = new ColumnInfo(infoColumn.get_Translation("Name"), colSQL, ValueNamePair.class, (String)null);
					}
					else
					{
						columnInfo = createLookupColumnInfo(tableInfos, gridFields.get(i), infoColumn);
					}					
				}
				else  
				{
					columnInfo = new ColumnInfo(infoColumn.get_Translation("Name"), colSQL, DisplayType.getClass(infoColumn.getAD_Reference_ID(), true));
				}
				columnInfo.setColDescription(infoColumn.get_Translation("Description"));
				columnInfo.setGridField(gridFields.get(i));
				list.add(columnInfo);
				
				if (keyColumnOfView == infoColumn){
					if (columnInfo.getColClass().equals(IDColumn.class)) 
						isIDColumnKeyOfView = true;
					indexKeyOfView = list.size() - 1;
				}
			}		
			i++;
		}
		
		if (keyColumnOfView == null){
			isIDColumnKeyOfView = true;// because use main key
		}
		
		columnInfos = list.toArray(new ColumnInfo[0]);
		
		prepareTable(columnInfos, infoWindow.getFromClause(), p_whereClause, infoWindow.getOrderByClause());		
	}

	protected ColumnInfo createLookupColumnInfo(TableInfo[] tableInfos,
			GridField gridField, MInfoColumn infoColumn) {
		String columnName = gridField.getColumnName();
		String validationCode = "";
		MLookupInfo lookupInfo = MLookupFactory.getLookupInfo(Env.getCtx(), p_WindowNo, 0, infoColumn.getAD_Reference_ID(), Env.getLanguage(Env.getCtx()), columnName, infoColumn.getAD_Reference_Value_ID(), false, validationCode);
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
						ColumnInfo columnInfo = new ColumnInfo(infoColumn.get_Translation("Name"), displayColumn, KeyNamePair.class, infoColumn.getSelectClause());
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

		String colSQL = infoColumn.getSelectClause();
		if (! colSQL.toUpperCase().contains(" AS "))
			colSQL += " AS " + infoColumn.getColumnName();
        editorMap.put(colSQL, editor);
		ColumnInfo columnInfo = new ColumnInfo(infoColumn.get_Translation("Name"), colSQL, KeyNamePair.class, (String)null);
		return columnInfo;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.panel.InfoPanel#getSQLWhere()
	 */
	@Override
	protected String getSQLWhere() {
		/**
		 * when query not by click requery button, reuse prev where clause
		 * IDEMPIERE-1979  
		 */
		if (!isQueryByUser && prevWhereClause != null){
			return prevWhereClause;
		}
		
		StringBuilder builder = new StringBuilder();
		MTable table = MTable.get(Env.getCtx(), infoWindow.getAD_Table_ID());
		if (!hasIsActiveEditor() && table.get_ColumnIndex("IsActive") >=0 ) {
			if (p_whereClause != null && p_whereClause.trim().length() > 0) {
				builder.append(" AND ");
			}
			builder.append(tableInfos[0].getSynonym()).append(".IsActive='Y'");
		}
		int count = 0;
		for(WEditor editor : editors) {
			if (!editor.isVisible())
				continue;
			
			if (editor instanceof IWhereClauseEditor) {
				String whereClause = ((IWhereClauseEditor) editor).getWhereClause();
				if (whereClause != null && whereClause.trim().length() > 0) {
					count++;
					if (count == 1) {
						if (builder.length() > 0) {
							builder.append(" AND ");
							if (!checkAND.isChecked()) builder.append(" ( ");
						} else if (p_whereClause != null && p_whereClause.trim().length() > 0) {
							builder.append(" AND ");
							if (!checkAND.isChecked()) builder.append(" ( ");
						}	
					} else {
						builder.append(checkAND.isChecked() ? " AND " : " OR ");
					}
					builder.append(whereClause);
				}
			} else if (editor.getGridField() != null && editor.getValue() != null && editor.getValue().toString().trim().length() > 0) {
				MInfoColumn mInfoColumn = findInfoColumn(editor.getGridField());
				if (mInfoColumn == null || mInfoColumn.getSelectClause().equals("0")) {
					continue;
				}
				String columnName = mInfoColumn.getSelectClause();
				int asIndex = columnName.toUpperCase().lastIndexOf(" AS ");
				if (asIndex > 0) {
					columnName = columnName.substring(0, asIndex);
				}
				
				count++;
				if (count == 1) {
					if (builder.length() > 0) {
						builder.append(" AND ");
						if (!checkAND.isChecked()) builder.append(" ( ");
					} else if (p_whereClause != null && p_whereClause.trim().length() > 0) {
						builder.append(" AND ");
						if (!checkAND.isChecked()) builder.append(" ( ");
					} else if (hasIsActiveEditor() && !checkAND.isChecked()) {
						builder.append(" ( ");
					}
				} else {
					builder.append(checkAND.isChecked() ? " AND " : " OR ");
				}
				
				String columnClause = null;
				if (mInfoColumn.getQueryFunction() != null && mInfoColumn.getQueryFunction().trim().length() > 0) {
					String function = mInfoColumn.getQueryFunction();
					if (function.indexOf("@") >= 0) {
						String s = Env.parseContext(infoContext, p_WindowNo, function, true, false);
						if (s.length() == 0) {
							log.log(Level.SEVERE, "Failed to parse query function. " + function);
						} else {
							function = s;
						}
					}
					if (function.indexOf("?") >= 0) {
						columnClause = function.replaceFirst("[?]", columnName);
					} else {
						columnClause = function+"("+columnName+")";
					}
				} else {
					columnClause = columnName;
				}
				builder.append(columnClause)
					   .append(" ")
					   .append(mInfoColumn.getQueryOperator())
					   .append(" ?");				
			}
		}	
		if (count > 0 && !checkAND.isChecked()) {
			builder.append(" ) ");
		}
		String sql = builder.toString();
		if (sql.indexOf("@") >= 0) {
			sql = Env.parseContext(infoContext, p_WindowNo, sql, true, true);
		}
		
		// IDEMPIERE-1979
		prevWhereClause = sql;
		
		return sql;
	}

	protected MInfoColumn findInfoColumn(GridField gridField) {
		for(int i = 0; i < gridFields.size(); i++) {
			if (gridFields.get(i) == gridField) {
				return infoColumns[i];
			}
		}
		return null;
	}

	/**
	 * Check has new parameter is change or new input
	 * in case first time search, return true
	 * @return
	 */
	protected boolean isParameteChangeValue (){
		if (prevParameterValues == null){
			// never process query, because consider as changed value to process current search
			return true;
		}
		
		// compare old and new value of parameter input at prev time
		for (int parameterIndex = 0; parameterIndex < prevParameterValues.size(); parameterIndex++){
			Object newValue = prevRefParmeterEditor.get(parameterIndex).getValue();
			if (!prevParameterValues.get(parameterIndex).equals(newValue)){
				return true;
			}
		}

		// in case new field is entered value
		for(WEditor editor : editors) {
			if (!editor.isVisible() || prevRefParmeterEditor.contains(editor))
				continue;
			
			if (editor.getGridField() != null && editor.getValue() != null && editor.getValue().toString().trim().length() > 0) {
				MInfoColumn mInfoColumn = findInfoColumn(editor.getGridField());
				if (mInfoColumn == null || mInfoColumn.getSelectClause().equals("0")) {
					continue;
				}
				return true;
			}
		}
		
		return false;
	}
	
	/* (non-Javadoc)
	 * @see org.adempiere.webui.panel.InfoPanel#setParameters(java.sql.PreparedStatement, boolean)
	 */
	@Override
	protected void setParameters(PreparedStatement pstmt, boolean forCount)
			throws SQLException {
		// when query not by click requery button, reuse parameter value
		if (!isQueryByUser && prevParameterValues != null){
			for (int parameterIndex = 0; parameterIndex < prevParameterValues.size(); parameterIndex++){
				setParameter (pstmt, parameterIndex + 1, prevParameterValues.get(parameterIndex), prevQueryOperators.get(parameterIndex));
			}
			return;
		}
		
		// init collection to save current parameter value 
		if (prevParameterValues == null){
			prevParameterValues = new ArrayList<Object> ();
			prevQueryOperators = new ArrayList<String> ();
			prevRefParmeterEditor = new ArrayList<WEditor>(); 
		}else{
			prevParameterValues.clear();
			prevQueryOperators.clear();
			prevRefParmeterEditor.clear();
		}

		int parameterIndex = 0;
		for(WEditor editor : editors) {
			if (!editor.isVisible())
				continue;
			
			if (editor.getGridField() != null && editor.getValue() != null && editor.getValue().toString().trim().length() > 0) {
				MInfoColumn mInfoColumn = findInfoColumn(editor.getGridField());
				if (mInfoColumn == null || mInfoColumn.getSelectClause().equals("0")) {
					continue;
				}
				Object value = editor.getValue();
				parameterIndex++;
				prevParameterValues.add(value);
				prevQueryOperators.add(mInfoColumn.getQueryOperator());
				prevRefParmeterEditor.add(editor);
				setParameter (pstmt, parameterIndex, value, mInfoColumn.getQueryOperator());
			}
		}

	}
	
	/**
	 * set parameter for statement. 
	 * not need check null for value
	 * @param pstmt
	 * @param parameterIndex
	 * @param value
	 * @param queryOperator
	 * @throws SQLException
	 */
	protected void setParameter (PreparedStatement pstmt, int parameterIndex, Object value, String queryOperator) throws SQLException{
				if (value instanceof Boolean) {					
					pstmt.setString(parameterIndex, ((Boolean) value).booleanValue() ? "Y" : "N");
				} else if (value instanceof String) {
			if (queryOperator.equals(X_AD_InfoColumn.QUERYOPERATOR_Like)) {
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

	@Override
	protected void prepareTable(ColumnInfo[] layout, String from, String where,
			String orderBy) {
		super.prepareTable(layout, from, where, orderBy);
		if (m_sqlMain.indexOf("@") >= 0) {
			String sql = Env.parseContext(infoContext, p_WindowNo, m_sqlMain, true);
			if (sql == null || sql.length() == 0) {
				log.severe("Failed to parsed sql. sql=" + m_sqlMain);
			} else {
				m_sqlMain = sql;
			}
		}
		
		addViewIDToQuery();
		addKeyViewToQuery();
		
		if (m_sqlMain.length() > 0 &&  infoWindow.isDistinct()) {
			m_sqlMain = m_sqlMain.substring("SELECT ".length());
			m_sqlMain = "SELECT DISTINCT " + m_sqlMain;			
		}	
		
		if (m_sqlOrder != null && m_sqlOrder.indexOf("@") >= 0) {
			String sql = Env.parseContext(infoContext, p_WindowNo, m_sqlOrder, true, false);
			if (sql == null || sql.length() == 0) {
				log.severe("Failed to parsed sql. sql=" + m_sqlOrder);
			} else {
				m_sqlOrder = sql;
			}
		}
	}

	/**
	 * add all ViewID in each MInfoProcess to query
	 * if main query have subquery in SELECT, it will beak or incorrect
	 */
	protected void addViewIDToQuery () {
		m_sqlMain = addMoreColumnToQuery (m_sqlMain, infoProcessList);
	}
	
	/**
	 * if {@link #keyColumnOfView} not null and not display, add query to query it's value
	 */
	protected void addKeyViewToQuery () {
		if (isNeedAppendKeyViewData()){
			m_sqlMain = addMoreColumnToQuery (m_sqlMain, new IInfoColumn [] {keyColumnOfView});
		}
	}
	
	@Override
	public boolean isNeedAppendKeyViewData() {
		return (keyColumnOfView != null && !keyColumnOfView.isDisplayed(infoContext, p_WindowNo));
	}
	
	/**
	 * because data of infoColumn have isDisplay = false not load, 
	 * just display column is load to show in List.
	 * Some function receive data from hidden column as viewID in infoProcess
	 * or parentLink of infoRelateWindow.
	 * 
	 * this function just add column name of hidden infoWindow to end of query
	 * @param sqlMain main sql to append column 
	 * @param listInfoColumn list of PO contain infoColumnID, this infoColumnID will add to query
	 * @return sql after append column
	 */
	protected String addMoreColumnToQuery (String sqlMain, IInfoColumn [] listInfoColumn) {
		if (sqlMain == null || sqlMain.length() == 0 || listInfoColumn == null || listInfoColumn.length == 0){
			return sqlMain;
		}
				
		int fromIndex = sqlMain.indexOf("FROM");
		// split Select and from clause
		String selectClause = sqlMain.substring(0, fromIndex);
		String fromClause = sqlMain.substring(fromIndex);
		
		// get alias of main table
		StringBuilder sqlBuilder = new StringBuilder(selectClause);
		StringBuilder sqlColumn = new StringBuilder();
		
		// add View_ID column to select clause
		for (IInfoColumn infoProcess : listInfoColumn) {
			// this process hasn't viewID column, next other infoProcess
			if (infoProcess.getInfoColumnID() <= 0)
				continue;

			MInfoColumn infocol = (MInfoColumn) infoProcess.getAD_InfoColumn();
			
			if (! infocol.isDisplayed()) {
				sqlColumn.append(", ").append(infocol.getSelectClause()).append(" AS ").append(infocol.getColumnName()).append(" ");
				// add column to SELECT clause of main sql, if query is include this viewID column, not need add
				if (!sqlBuilder.toString().contains(sqlColumn)){
					sqlBuilder.append(sqlColumn);
				}
				
				sqlColumn.delete(0, sqlColumn.length());
			}
		}
		
		sqlBuilder.append(fromClause);
		// update main sql 
		return sqlBuilder.toString();
		
	}
	
	protected void renderWindow()
	{		
		setTitle(infoWindow.get_Translation("Name"));
		layout = new Borderlayout();
		ZKUpdateUtil.setWidth(layout, "100%");
		ZKUpdateUtil.setHeight(layout, "100%");
        if (!isLookup())
        {
        	layout.setStyle("position: absolute");
        }
        this.appendChild(layout);
		
        if (isLookup())
        	ZKUpdateUtil.setWidth(contentPanel, "99%");
        else
        	contentPanel.setStyle("width: 99%; margin: 0px auto;");
        ZKUpdateUtil.setVflex(contentPanel, true);
        contentPanel.setSizedByContent(true);
        contentPanel.setSpan(true);
        
        North north = new North();
        layout.appendChild(north);
        renderParameterPane(north);
        

        Center center = new Center();
		layout.appendChild(center);
        renderContentPane(center);		

        South south = new South();
		layout.appendChild(south);
		renderFooter(south);		
		
		confirmPanel.getButton(ConfirmPanel.A_ZOOM).setVisible(hasZoom());
		confirmPanel.getButton(ConfirmPanel.A_ZOOM).setDisabled(true);

		// IDEMPIERE-1334 start when init all button process is disable because nothing record is selected
		
		for (Button btProcess : btProcessList){
			btProcess.setDisabled(true);
		}
		if (btCbbProcess != null){
			btCbbProcess.setDisabled(true);
		}
		
		if (btMenuProcess != null){
			btMenuProcess.setDisabled(true);
		}
		
		if (cbbProcess != null){
			cbbProcess.setDisabled(true);
		}
		// IDEMPIERE-1334 end
	}

	protected void renderFooter(South south) {		
		southBody = new Vbox();
		ZKUpdateUtil.setHflex(southBody, "1");
		south.appendChild(southBody);
		southBody.appendChild(new Separator());
		southBody.appendChild(confirmPanel);
		southBody.appendChild(statusBar);
	}

	protected void insertPagingComponent() {
		southBody.insertBefore(paging, southBody.getFirstChild());
		layout.invalidate();
	}
	
	protected void renderContentPane(Center center) {				
		Div div = new Div();
		div.setStyle("width :100%; height: 100%");
		ZKUpdateUtil.setVflex(div, "1");
		ZKUpdateUtil.setHflex(div, "1");
		div.appendChild(contentPanel);				

		Borderlayout inner = new Borderlayout();
		ZKUpdateUtil.setWidth(inner, "100%");
		ZKUpdateUtil.setHeight(inner, "100%");
		int height = SessionManager.getAppDesktop().getClientInfo().desktopHeight * 90 / 100;
		if (isLookup())
			inner.setStyle("border: none; position: relative; ");
		else
			inner.setStyle("border: none; position: absolute; ");
		inner.appendCenter(div);
		//true will conflict with listbox scrolling
		inner.getCenter().setAutoscroll(false);

		if (embeddedWinList.size() > 0) {
			South south = new South();
			int detailHeight = (height * 25 / 100);
			ZKUpdateUtil.setHeight(south, detailHeight + "px");
			south.setAutoscroll(true);
			south.setCollapsible(true);
			south.setSplittable(true);
			south.setTitle(Msg.translate(Env.getCtx(), "Related Information"));
			south.setTooltiptext(Msg.translate(Env.getCtx(), "Related Information"));

			south.addEventListener(Events.ON_SWIPE, new EventListener<SwipeEvent>() {
				@Override
				public void onEvent(SwipeEvent event) throws Exception {
					South south = (South) event.getTarget();
					if ("down".equals(event.getSwipeDirection())) {
						south.setOpen(false);
					}
				}
			});
			south.setSclass("south-collapsible-with-title");
			south.setAutoscroll(true);
			//south.sets
			inner.appendChild(south);
			embeddedPane.setSclass("info-product-tabbedpane");
			ZKUpdateUtil.setVflex(embeddedPane, "1");
			ZKUpdateUtil.setHflex(embeddedPane, "1");

			south.appendChild(embeddedPane);

		}// render embedded

		center.appendChild(inner);
	}

	protected void renderParameterPane(North north) {
		createParameterPanel();        
		north.appendChild(parameterGrid);
	}

	protected void createParameterPanel() {
		parameterGrid = GridFactory.newGridLayout();
		parameterGrid.setWidgetAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "infoParameterPanel");
		parameterGrid.setStyle("width: 95%; margin: auto !important;");
		Columns columns = new Columns();
		parameterGrid.appendChild(columns);
		for(int i = 0; i < 6; i++)
			columns.appendChild(new Column());
		
		Column column = new Column();
		ZKUpdateUtil.setWidth(column, "100px");
		column.setAlign("right");
		columns.appendChild(column);
		
		Rows rows = new Rows();
		parameterGrid.appendChild(rows);
		
		editors = new ArrayList<WEditor>();
		identifiers = new ArrayList<WEditor>();
		TreeMap<Integer, List<Object[]>> tree = new TreeMap<Integer, List<Object[]>>();
		for (int i = 0; i < infoColumns.length; i++)
		{
			if (infoColumns[i].isQueryCriteria()) {
				List<Object[]> list = tree.get(infoColumns[i].getSeqNoSelection());
				if (list == null) {
					list = new ArrayList<Object[]>();
					tree.put(infoColumns[i].getSeqNoSelection(), list);
				}
				list.add(new Object[]{infoColumns[i], gridFields.get(i)});				
			}
		}
		
		for (Integer i : tree.keySet()) {
			List<Object[]> list = tree.get(i);
			for(Object[] value : list) {
				addSelectionColumn((MInfoColumn)value[0], (GridField)value[1]);
			}
		}
		
		if (checkAND == null) {
			if (parameterGrid.getRows() != null && parameterGrid.getRows().getFirstChild() != null) {
				Row row = (Row) parameterGrid.getRows().getFirstChild();
				int col = row.getChildren().size();
				while (col < 6) {
					row.appendChild(new Space());
					col++;
				}
				createAndCheckbox();
				row.appendChild(checkAND);
			}
		}
		evalDisplayLogic();
		initParameters();
		dynamicDisplay(null);
	}

	protected void evalDisplayLogic() {
		for(WEditor editor : editors) {
        	if (editor.getGridField() != null && !editor.getGridField().isDisplayed(true)) {        		
        		editor.getComponent().setVisible(false);
        		if (editor.getLabel() != null)
        			editor.getLabel().setVisible(false);
        	}
        	else if (!editor.getComponent().isVisible()) {
        		editor.getComponent().setVisible(true);
        		if (editor.getLabel() != null)
        			editor.getLabel().setVisible(true);
        	}
        }
		
	}
	
	/**
     *  Add Selection Column to first Tab
	 * @param infoColumn 
     *  @param mField field
    **/
    protected void addSelectionColumn(MInfoColumn infoColumn, GridField mField)
    {
        int displayLength = mField.getDisplayLength();
        if (displayLength <= 0 || displayLength > FIELDLENGTH)
            mField.setDisplayLength(FIELDLENGTH);
        else
            displayLength = 0;

        //  Editor
        WEditor editor = null;
        if (mField.getDisplayType() == DisplayType.PAttribute) 
        {
        	editor = new WInfoPAttributeEditor(infoContext, p_WindowNo, mField);
	        editor.setReadWrite(true);
        }
        else 
        {
	        editor = WebEditorFactory.getEditor(mField, false);
	        editor.setReadWrite(true);
	        editor.dynamicDisplay();
	        editor.addValueChangeListener(this);
	        editor.fillHorizontal();
        }
        Label label = editor.getLabel();
        Component fieldEditor = editor.getComponent();

        //
        if (displayLength > 0)      //  set it back
            mField.setDisplayLength(displayLength);
        //
        if (label != null) {
        	if (infoColumn.getQueryOperator().equals(X_AD_InfoColumn.QUERYOPERATOR_Gt) ||
        		infoColumn.getQueryOperator().equals(X_AD_InfoColumn.QUERYOPERATOR_GtEq) ||
        		infoColumn.getQueryOperator().equals(X_AD_InfoColumn.QUERYOPERATOR_Le) ||
        		infoColumn.getQueryOperator().equals(X_AD_InfoColumn.QUERYOPERATOR_LeEq) ||
        		infoColumn.getQueryOperator().equals(X_AD_InfoColumn.QUERYOPERATOR_NotEq )) {
        		label.setValue(label.getValue() + " " + infoColumn.getQueryOperator());
        	}
        }

        addSearchParameter(label, fieldEditor);
        
        editors.add(editor);
        
        editor.showMenu();
        
        if (infoColumn.isIdentifier()) {
        	identifiers.add(editor);
        }

        fieldEditor.addEventListener(Events.ON_OK, this);		

        mField.addPropertyChangeListener(editor);
                
        mField.setValue(mField.getDefaultForPanel(), true);

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
        	if (panel.getChildren().size() == 6)
        	{
        		if (parameterGrid.getRows().getChildren().size() == 1) 
        		{
        			createAndCheckbox();
					panel.appendChild(checkAND);
        		}
        		else
        		{
        			panel.appendChild(new Space());
        		}
        		panel = new Row();
            	parameterGrid.getRows().appendChild(panel); 
        	}
        }
        if (!(fieldEditor instanceof Checkbox))
        {
        	Div div = new Div();
        	div.setStyle("text-align: right;");
        	div.appendChild(label);
        	if (label.getDecorator() != null){
        		div.appendChild (label.getDecorator());
        	}
        	panel.appendChild(div);
        } else {
        	panel.appendChild(new Space());
        }
        
        // add out parent to add menu for this field, without outerDiv, a new cell will auto make for menu.
        Div outerParent = new Div();
        outerParent.appendChild(fieldEditor);
        panel.appendChild(outerParent);
	}

	protected void createAndCheckbox() {
		checkAND = new Checkbox();
		checkAND.setLabel(Msg.getMsg(Env.getCtx(), "SearchAND", true));
		String tips = Msg.getMsg(Env.getCtx(), "SearchAND", false);
		if (!Util.isEmpty(tips)) 
		{
			checkAND.setTooltiptext(tips);
		}
		checkAND.setChecked(true);
		checkAND.addEventListener(Events.ON_CHECK, this);
	}
	
	protected int findColumnIndex(String columnName) {
		for(int i = 0; i < columnInfos.length; i++) {
			GridField field = columnInfos[i].getGridField();
			if (field != null && field.getColumnName().equalsIgnoreCase(columnName)) {
				return i;
			}
		}
		return -1;
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

        int column = -1;
        for(ColumnInfo columnInfo : columnInfos) 
        {   
        	column++;
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
        		String s = Env.parseContext(infoContext, p_WindowNo, otherClause, true, false);
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
    
	@Override
	protected boolean hasZoom() {
		return !isLookup() && infoWindow != null && !MTable.get(Env.getCtx(), infoWindow.getAD_Table_ID()).isView();
	}

	@Override
	public void valueChange(ValueChangeEvent evt) {
		if (evt != null && evt.getSource() instanceof WEditor)
        {
            WEditor editor = (WEditor)evt.getSource();            
            if (evt.getNewValue() == null) {
            	Env.setContext(infoContext, p_WindowNo, editor.getColumnName(), "");
            	Env.setContext(infoContext, p_WindowNo, Env.TAB_INFO, editor.getColumnName(), "");
            } else if (evt.getNewValue() instanceof Boolean) {
            	Env.setContext(infoContext, p_WindowNo, editor.getColumnName(), (Boolean)evt.getNewValue());
            	Env.setContext(infoContext, p_WindowNo, Env.TAB_INFO, editor.getColumnName(), (Boolean)evt.getNewValue());
            } else if (evt.getNewValue() instanceof Timestamp) {
            	Env.setContext(infoContext, p_WindowNo, editor.getColumnName(), (Timestamp)evt.getNewValue());
            	Env.setContext(infoContext, p_WindowNo, Env.TAB_INFO+"|"+editor.getColumnName(), (Timestamp)evt.getNewValue());
            } else {
            	Env.setContext(infoContext, p_WindowNo, editor.getColumnName(), evt.getNewValue().toString());
            	Env.setContext(infoContext, p_WindowNo, Env.TAB_INFO, editor.getColumnName(), evt.getNewValue().toString());
            }
            dynamicDisplay(editor);
        }
		
	}

	protected void dynamicDisplay(WEditor editor) {
		validateField(editor);
		// if attribute set changed (from any value to any value) clear the attribute set instance m_pAttributeWhere
		boolean asiChanged = false;
		if (editor != null && editor instanceof WTableDirEditor && editor.getColumnName().equals("M_AttributeSet_ID"))
			asiChanged = true;
		
		for(WEditor otherEditor : editors)
		{
			if (otherEditor == editor) 
				continue;
			
			// reset value of WInfoPAttributeEditor to null when change M_AttributeSet_ID
			if (asiChanged && otherEditor instanceof WInfoPAttributeEditor)
				((WInfoPAttributeEditor)otherEditor).clearWhereClause();
			
			otherEditor.dynamicDisplay();
		}
		
		evalDisplayLogic();
	}
	
	public void onEvent(Event event)
    {
		if (event.getName().equals(Events.ON_FOCUS) && event.getTarget() != null && 
				event.getTarget().getAttribute(ATT_INFO_PROCESS_KEY) != null){
			
			MProcess process = (MProcess)event.getTarget().getAttribute(ATT_INFO_PROCESS_KEY);
			SessionManager.getAppDesktop().updateHelpTooltip(process.get_Translation(MProcess.COLUMNNAME_Name), process.get_Translation(MProcess.COLUMNNAME_Description), process.get_Translation(MProcess.COLUMNNAME_Help), null);
		}
		else if (event.getName().equals(Events.ON_FOCUS)) {
    		for (WEditor editor : editors)
    		{
    			if (editor.isComponentOfEditor(event.getTarget()))
    			{
        			SessionManager.getAppDesktop().updateHelpTooltip(editor.getGridField());
        			return;
    			}
    		}
    	}else if (event.getName().equals(Events.ON_SELECT) && event.getTarget().equals(cbbProcess)){
    		// update help panel when change select item in combobox process
    		Comboitem selectedItem = cbbProcess.getSelectedItem();
    		if (selectedItem != null && selectedItem.getValue() != null){
    			MProcess selectedValue = (MProcess)selectedItem.getValue();
    			
        		SessionManager.getAppDesktop().updateHelpTooltip(selectedValue.get_Translation(MProcess.COLUMNNAME_Name), selectedValue.get_Translation(MProcess.COLUMNNAME_Description), selectedValue.get_Translation(MProcess.COLUMNNAME_Help), null);
    		}
    		    		
    	}else if (event.getName().equals(Events.ON_OK) && event.getTarget() != null){ // event when push enter at parameter
    		Component tagetComponent = event.getTarget();
    		boolean isCacheEvent = false;// when event from parameter component, catch it and process at there
    		for(WEditor editor : editors) {
    			Component editorComponent = editor.getComponent();
    			if (editorComponent instanceof EditorBox){
    				editorComponent = ((EditorBox)editorComponent).getTextbox();
    			}
    			if (editorComponent.equals(tagetComponent)){
    				// IDEMPIERE-2136
        			if (editor instanceof WSearchEditor){
        				if (((WSearchEditor)editor).isShowingDialog()){
    						return;
    					}
        			}
    				isCacheEvent = true;
    				break;
    			}
    		}
    		
    		if (isCacheEvent){
    			boolean isParameterChange = isParameteChangeValue();
        		// when change parameter, also requery
        		if (isParameterChange){
        			if (!isQueryByUser)
        				onUserQuery();
        		}else if (m_lookup && contentPanel.getSelectedIndex() >= 0){
        			// do nothing when parameter not change and at window mode, or at dialog mode but select non record    			
        			onOk();
        		}else {
        			// parameter not change. do nothing.
        		}
    		}else{
    			super.onEvent(event);
    		}
    		
    	}
    	else
    	{
    		super.onEvent(event);
    	}
    }
	
	/**
	 * {@inheritDoc-}
	 */
	@Override
	protected void resetParameters() {
		// reset value of parameter to null, just reset display parameter
		for (WEditor editor : editors) {
			GridField gField = editor.getGridField();
			if (gField == null || !gField.isDisplayed()) {
				continue;
			}

			// just reset to default Field set explicit DefaultValue
			Object resetValue = null;
			if (! Util.isEmpty(gField.getVO().DefaultValue, true)) {
				resetValue = gField.getDefaultForPanel();
			}
			Object oldValue = gField.getValue();
			gField.setValue(resetValue, true);
			
			// call valueChange to update env
			ValueChangeEvent changeEvent = new ValueChangeEvent (editor, "", oldValue, resetValue);
			valueChange (changeEvent);
		}

		// init again parameter
		initParameters();

		// filter dynamic value
		dynamicDisplay(null);
		
		onQueryCallback (null);
		
		if (paging != null)
			paging.setParent(null);
		
		layout.invalidate();
		
		contentPanel.getListHead().detach();
	}
	
	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
		if (newpage != null) {
			for (WEditor editor : editors)
			{
				editor.getComponent().addEventListener(Events.ON_FOCUS, this);
			}
		}
	}
	
	/**
	 * 	Test Row Count
	 *	@return true if display
	 */
	protected boolean testCount()
	{
		return testCount(true);
	}
	
	/**
	 * 	Test Row Count
	 *	@return true if display
	 */
	protected boolean testCount(boolean promptError)
	{
		long start = System.currentTimeMillis();
		String dynWhere = getSQLWhere();
		StringBuilder sql = new StringBuilder (m_sqlMain);

		if (dynWhere.length() > 0)
			sql.append(dynWhere);   //  includes first AND
		
		String countSql = Msg.parseTranslation(Env.getCtx(), sql.toString());	//	Variables
		if (countSql.trim().endsWith("WHERE")) {
			countSql = countSql.trim();
			countSql = countSql.substring(0, countSql.length() - 5);
		}
		countSql = MRole.getDefault().addAccessSQL	(countSql, getTableName(),
													MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);
		
		countSql = "SELECT COUNT(*) FROM ( " + countSql + " ) a";			
		
		if (log.isLoggable(Level.FINER))
			log.finer(countSql);
		m_count = -1;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(countSql, null);
			setParameters (pstmt, true);
			rs = pstmt.executeQuery();

			if (rs.next())
				m_count = rs.getInt(1);

		}
		catch (Exception e)
		{
			log.log(Level.SEVERE, countSql, e);
			m_count = -2;
		}
		finally
		{
			DB.close(rs, pstmt);
		}

		if (log.isLoggable(Level.FINE))
			log.fine("#" + m_count + " - " + (System.currentTimeMillis()-start) + "ms");
		
		if (infoWindow.getMaxQueryRecords() > 0 && m_count > infoWindow.getMaxQueryRecords())
		{
			if (promptError)
			{
				FDialog.error(getWindowNo(), this, "InfoFindOverMax",
		                m_count + " > " + infoWindow.getMaxQueryRecords());
			}
	        m_count = 0;
		}

		return true;
	}	//	testCount

	/** Return true if there is an 'IsActive' criteria */
	boolean hasIsActiveEditor() {
		for (WEditor editor : editors) {
			if (editor.getGridField() != null && "IsActive".equals(editor.getGridField().getColumnName())) {
				return true;
			}
		}
		return false;
	}

	/**
	 * @author xolali IDEMPIERE-1045
	 * getInfoColumnslayout(MInfoWindow info)
	 */
	public ArrayList<ColumnInfo> getInfoColumnslayout(MInfoWindow info){

		AccessSqlParser sqlParser = new AccessSqlParser("SELECT * FROM " + info.getFromClause());
		TableInfo[] tableInfos = sqlParser.getTableInfo(0);

		MInfoColumn[] infoColumns = info.getInfoColumns(tableInfos);
		ArrayList<ColumnInfo> list = new ArrayList<ColumnInfo>();
		String keyTableAlias = tableInfos[0].getSynonym() != null && tableInfos[0].getSynonym().trim().length() > 0
				? tableInfos[0].getSynonym()
						: tableInfos[0].getTableName();

				String keySelectClause = keyTableAlias + "." + p_keyColumn;

				for (MInfoColumn infoColumn : infoColumns)
				{
					if (infoColumn.isDisplayed(infoContext, p_WindowNo))
					{
						ColumnInfo columnInfo = null;
						String colSQL = infoColumn.getSelectClause();
						if (! colSQL.toUpperCase().contains(" AS "))
							colSQL += " AS " + infoColumn.getColumnName();
						if (infoColumn.getAD_Reference_ID() == DisplayType.ID)
						{
							if (infoColumn.getSelectClause().equalsIgnoreCase(keySelectClause))
								continue;

							columnInfo = new ColumnInfo(infoColumn.get_Translation("Name"), colSQL, DisplayType.getClass(infoColumn.getAD_Reference_ID(), true));
						}
						else if (DisplayType.isLookup(infoColumn.getAD_Reference_ID()))
						{
							if (infoColumn.getAD_Reference_ID() == DisplayType.List)
							{
								WEditor editor = null;							
						        editor = WebEditorFactory.getEditor(getGridField(infoColumn), true);
						        editor.setMandatory(false);
						        editor.setReadWrite(false);
						        editorMap.put(colSQL, editor);
								columnInfo = new ColumnInfo(infoColumn.get_Translation("Name"), colSQL, ValueNamePair.class, (String)null);
							}
							else
							{
								GridField field = getGridField(infoColumn);
								columnInfo = createLookupColumnInfo(tableInfos, field, infoColumn);
							}
						}
						else
						{
							columnInfo = new ColumnInfo(infoColumn.get_Translation("Name"), colSQL, DisplayType.getClass(infoColumn.getAD_Reference_ID(), true));
						}
						columnInfo.setColDescription(infoColumn.get_Translation("Description"));
						columnInfo.setGridField(getGridField(infoColumn));
						list.add(columnInfo);
					}

				}

				return   list;
	}

	/**
	 * @author xolali IDEMPIERE-1045
	 * refresh(Object obj, EmbedWinInfo relatedInfo)
	 */
	protected void refresh(Object obj, EmbedWinInfo relatedInfo)
	{
		StringBuilder sql = new StringBuilder();
		sql.append(relatedInfo.getInfoSql()); // delete get sql method from MInfoWindow
		if (log.isLoggable(Level.FINEST))
			log.finest(sql.toString());
		
		Object linkPara = null;
		if (obj != null && obj instanceof IDColumn){
			IDColumn ID = (IDColumn) obj;
			linkPara = ID.getRecord_ID();
		}else if (obj != null){
			linkPara = obj.toString();
		}else {
			//TODO:hard case
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(relatedInfo.getInfoSql(), null);
			//TODO: implicit type conversion. will exception in some case must recheck
			if (relatedInfo.getTypeDataOfLink().equals(String.class)){
				pstmt.setString(1, (String)linkPara);
			}else if (relatedInfo.getTypeDataOfLink().equals(int.class)){				
				pstmt.setInt(1, Integer.parseInt(linkPara.toString()));
				
			}else{
				pstmt.setObject(1, linkPara);
			}
			
			rs = pstmt.executeQuery();
			loadEmbedded(rs, relatedInfo);
		}
		catch (Exception e)
		{
			log.log(Level.WARNING, sql.toString(), e);
		}
		finally
		{
			DB.close(rs, pstmt);
			rs = null; pstmt = null;
		}
	}	//	refresh

	protected void refresh(EmbedWinInfo relatedInfo){
		if (relatedInfo.getInfoTbl() != null){
			if (((WListbox)relatedInfo.getInfoTbl()).getModel() != null)
				((WListbox)relatedInfo.getInfoTbl()).getModel().clear();
			else
				((WListbox)relatedInfo.getInfoTbl()).clear();
		}
	}
	
	/**
	 * @author xolali IDEMPIERE-1045
	 * loadEmbedded(ResultSet rs, EmbedWinInfo info)
	 */
	public void loadEmbedded(ResultSet rs, EmbedWinInfo info) throws SQLException{

		ListModelTable model;
		ArrayList<ColumnInfo> list = new ArrayList<ColumnInfo>();
		list = getInfoColumnslayout(info.getInfowin());

		//  Convert ArrayList to Array
		ColumnInfo[] s_layoutEmbedded  = new ColumnInfo[list.size()];
		list.toArray(s_layoutEmbedded);	
		List<Object> data = new ArrayList<Object>();
		ArrayList<Object> lines =  new ArrayList<Object>();

		while (rs.next())
		{
			try {
				data = readData(rs, s_layoutEmbedded);
			} catch (SQLException e) {
				//Xolali - Auto-generated catch block
				e.printStackTrace();
			}
			lines.add(data);
		}
		model = new ListModelTable(lines);

		WListbox content = (WListbox) info.getInfoTbl();
		content.setData(model, null);
	}

	/**
	 * @author xolali IDEMPIERE-1045
	 * GridField getGridField(MInfoColumn infoColumn)
	 */
	protected GridField getGridField(MInfoColumn infoColumn){
		String columnName = infoColumn.getColumnName();
		GridFieldVO vo = GridFieldVO.createParameter(infoContext, p_WindowNo, AEnv.getADWindowID(p_WindowNo), m_infoWindowID, 0,
				columnName, infoColumn.get_Translation("Name"), infoColumn.getAD_Reference_ID(),
				infoColumn.getAD_Reference_Value_ID(), false, false);
		if (infoColumn.getAD_Val_Rule_ID() > 0) {
			vo.ValidationCode = infoColumn.getAD_Val_Rule().getCode();
			if (vo.lookupInfo != null) {
				vo.lookupInfo.ValidationCode = vo.ValidationCode;
				vo.lookupInfo.IsValidated = false;
			}
		}
		vo.DisplayLogic = infoColumn.getDisplayLogic() != null ? infoColumn.getDisplayLogic() : "";
		String desc = infoColumn.get_Translation("Description");
		vo.Description = desc != null ? desc : "";
		String help = infoColumn.get_Translation("Help");
		vo.Help = help != null ? help : "";
		GridField gridField = new GridField(vo);

		return gridField;
	}

	protected  ArrayList<Object> readData(ResultSet rs, ColumnInfo[] p_layout) throws SQLException {

		int colOffset = 1;  //  columns start with 1
		ArrayList<Object> data = new ArrayList<Object>();
		for (int col = 0; col < p_layout.length; col++)
		{
			Object value = null;
			Class<?> c = p_layout[col].getColClass();
			int colIndex = col + colOffset;
			if (c == IDColumn.class)
			{
				value = new IDColumn(rs.getInt(colIndex));
			}
			else if (c == Boolean.class)
				value = new Boolean("Y".equals(rs.getString(colIndex)));
			else if (c == Timestamp.class)
				value = rs.getTimestamp(colIndex);
			else if (c == BigDecimal.class)
				value = rs.getBigDecimal(colIndex);
			else if (c == Double.class)
				value = new Double(rs.getDouble(colIndex));
			else if (c == Integer.class)
				value = new Integer(rs.getInt(colIndex));
			else if (c == KeyNamePair.class)
			{
				if (p_layout[col].isKeyPairCol())
				{
					String display = rs.getString(colIndex);
					int key = rs.getInt(colIndex+1);
					if (! rs.wasNull()) {
						value = new KeyNamePair(key, display);
					}
					colOffset++;
				}
				else
				{
					int key = rs.getInt(colIndex);
					if (! rs.wasNull()) {
						WEditor editor = editorMap.get(p_layout[col].getColSQL()); // rework this, it will fail
						if (editor != null)
						{
							editor.setValue(key);
							value = new KeyNamePair(key, editor.getDisplayTextForGridView(key));
						}
						else
						{
							value = new KeyNamePair(key, Integer.toString(key));
						}
					}
				}
			}
			else if (c == ValueNamePair.class)
			{
				String key = rs.getString(colIndex);
				WEditor editor = editorMap.get(p_layout[col].getColSQL());
				if (editor != null)
				{
					value = new ValueNamePair(key, editor.getDisplayTextForGridView(key));
				}
				else
				{
					value = new ValueNamePair(key, key);
				}
			}
			else
			{
				value = rs.getString(colIndex);
			}
			data.add(value);
		}

		return data;
	}

	
	/**
	 * {@inheritDoc}
	 * eval input value of mandatory field, if null show field in red color
	 */
	@Override
	public boolean validateParameters() {
		boolean isValid = true;
		
		for (int i = 0; i < editors.size(); i++){
			WEditor wEditor = (WEditor) editors.get(i);
			// cancel editor not display
			if (wEditor == null || !wEditor.isVisible() || wEditor.getGridField() == null){
				continue;
}
			
			isValid = isValid & validateField (wEditor);
		}
		
		return isValid;
	}
	
	/**
	 * valid mandatory of a not null, display field
	 * display red color when a mandatory field is not input
	 * @param wEditor
	 * @return
	 */
	protected boolean validateField (WEditor wEditor){
		if (wEditor == null || !wEditor.isVisible() || wEditor.getGridField() == null){
			return true;
		}
		
		GridField validateGrid = wEditor.getGridField();
		// eval only mandatory field
		if (validateGrid.isMandatory(true)){
			// update color of field
			wEditor.updateLabelStyle();
			Object data = wEditor.getValue();
			if (data == null || data.toString().length() == 0) {				
				return false;
			}
		}
		
		return true;		
	}
	
	@Override
	protected boolean hasNew() {
		boolean hasNew = getADWindowID () > 0;
		if (hasNew && vqe == null && hasRightQuickEntry){
			GridWindow gridwindow = GridWindow.get(Env.getCtx(), 0, getADWindowID());
			hasRightQuickEntry = gridwindow != null;
			if (hasRightQuickEntry)
				vqe = new WQuickEntry (0, getADWindowID());
		}
			
		return hasNew && vqe != null && vqe.isAvailableQuickEdit();
	}
	
	/**	
	 * Get id of window link with main table of this info window
	 * @param tableName
	 * @return
	 */
	protected int getADWindowID() {
		if(infoWindow == null)
			return 0;
		String isSOTrx = Env.getContext(Env.getCtx(), p_WindowNo, "IsSOTrx");
		if (!isLookup() && Util.isEmpty(isSOTrx)) {
			isSOTrx = "Y";
		}
		
		return super.getAD_Window_ID(MTable.getTableName(Env.getCtx(), infoWindow.getAD_Table_ID()), isSOTrx.equalsIgnoreCase("Y"));
	}
	
	@Override
	protected void newRecordAction() {
		// each time close WQuickEntry dialog, 
		// window is  un-registry, variable environment of this window as _QUICK_ENTRY_MODE_ is removed
		// so if reuse WQuickEntry will let some field in child tab init at read only state
		WQuickEntry vqe = new WQuickEntry (0, getADWindowID());
		
		vqe.loadRecord (0);								
		
		final ISupportMask parent = LayoutUtils.showWindowWithMask(vqe, this, LayoutUtils.OVERLAP_TAB_PANEL);
		
		vqe.addEventListener(DialogEvents.ON_WINDOW_CLOSE, new EventListener<Event>() {								
			@Override							
			public void onEvent(Event event) throws Exception {							
				Clients.response(new AuEcho(InfoWindow.this, "onQueryCallback", null));
				if (parent != null)
					parent.hideMask();
			}
		});								
										
		vqe.setVisible(true);								
					
	}

}
