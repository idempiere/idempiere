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
 **********************************************************************/
package org.adempiere.webui.info;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.function.Consumer;
import java.util.Properties;
import java.util.TreeMap;
import java.util.logging.Level;

import org.adempiere.base.LookupFactoryHelper;
import org.adempiere.base.upload.IUploadService;
import org.adempiere.exceptions.AdempiereException;
import org.adempiere.impexp.AbstractXLSXExporter;
import org.adempiere.model.IInfoColumn;
import org.adempiere.model.MInfoProcess;
import org.adempiere.model.MInfoRelated;
import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.Extensions;
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
import org.adempiere.webui.component.NumberBox;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Tab;
import org.adempiere.webui.component.Tabbox;
import org.adempiere.webui.component.Tabpanel;
import org.adempiere.webui.component.Tabpanels;
import org.adempiere.webui.component.Tabs;
import org.adempiere.webui.component.WInfoWindowListItemRenderer;
import org.adempiere.webui.component.WListItemRenderer;
import org.adempiere.webui.component.WListbox;
import org.adempiere.webui.component.WTableColumn;
import org.adempiere.webui.component.Window;
import org.adempiere.webui.editor.IEditorConfiguration;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WImageEditor;
import org.adempiere.webui.editor.WImageURLEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WTableDirEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.DialogEvents;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.event.WTableModelEvent;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.grid.AbstractWQuickEntry;
import org.adempiere.webui.panel.InfoPanel;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.DateRangeButton;
import org.adempiere.webui.window.Dialog;
import org.compiere.minigrid.ColumnInfo;
import org.compiere.minigrid.EmbedWinInfo;
import org.compiere.minigrid.IDColumn;
import org.compiere.minigrid.SelectableIDColumn;
import org.compiere.minigrid.UUIDColumn;
import org.compiere.model.AccessSqlParser.TableInfo;
import org.compiere.model.GridField;
import org.compiere.model.GridFieldVO;
import org.compiere.model.GridWindow;
import org.compiere.model.InfoColumnVO;
import org.compiere.model.InfoRelatedVO;
import org.compiere.model.Lookup;
import org.compiere.model.MAttachment;
import org.compiere.model.MAuthorizationAccount;
import org.compiere.model.MInfoColumn;
import org.compiere.model.MInfoWindow;
import org.compiere.model.MLookup;
import org.compiere.model.MLookupFactory;
import org.compiere.model.MLookupInfo;
import org.compiere.model.MProcess;
import org.compiere.model.MReference;
import org.compiere.model.MRole;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.MUserDefInfo;
import org.compiere.model.X_AD_InfoColumn;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.KeyNamePair;
import org.compiere.util.Msg;
import org.compiere.util.Trx;
import org.compiere.util.Util;
import org.compiere.util.ValueNamePair;
import org.idempiere.ui.zk.media.IMediaView;
import org.idempiere.ui.zk.media.Medias;
import org.idempiere.ui.zk.media.WMediaOptions;
import org.zkoss.util.media.AMedia;
import org.zkoss.zk.au.out.AuEcho;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.SelectEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Center;
import org.zkoss.zul.Checkbox;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.ComboitemRenderer;
import org.zkoss.zul.Div;
import org.zkoss.zul.Filedownload;
import org.zkoss.zul.Image;
import org.zkoss.zul.ListModelList;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.ListitemRenderer;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.North;
import org.zkoss.zul.Paging;
import org.zkoss.zul.Separator;
import org.zkoss.zul.South;
import org.zkoss.zul.Space;
import org.zkoss.zul.Vbox;
import org.zkoss.zul.Vlayout;
import org.zkoss.zul.event.ZulEvents;
import org.zkoss.zul.impl.InputElement;

/**
 * AD_InfoWindow implementation
 * @author hengsin
 * @contributor red1 	IDEMPIERE-1711 Process button (reviewed by Hengsin)
 * @contributor xolali 	IDEMPIERE-1045 Sub-Info Tabs  (reviewed by red1)
 */
public class InfoWindow extends InfoPanel implements ValueChangeListener, EventListener<Event> {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 615852605072547785L;

	private static final String ON_QUERY_AFTER_CHANGE = "onQueryAfterChange";
	
	/** Query parameter grid */
	protected Grid parameterGrid;
	private Borderlayout layout;
	private Vbox southBody;
	/** List of WEditors            */
    protected List<WEditor> editors;
    protected ArrayList<WEditor> editors2;
    /** List of editors that will trigger query after changes by user */
    protected List<WEditor> queryAfterChangeEditors;
    protected List<WEditor> identifiers;
    protected Properties infoContext;

    /** embedded Panel (AD_InfoRelated) **/
    protected Tabbox embeddedPane = new Tabbox();
    protected ArrayList <EmbedWinInfo> embeddedWinList = new ArrayList <EmbedWinInfo>();
    protected Map<Integer, RelatedInfoWindow> relatedMap = new HashMap<>();

	/** Max Length of Fields */
    public static final int FIELDLENGTH = 20;
    
    protected ColumnInfo[] columnInfos;
	protected TableInfo[] tableInfos;
	protected InfoColumnVO[] infoColumns;	
	
	protected AbstractWQuickEntry vqe;
	
	//From and to grid fields
	private List<GridField> gridFields;
	private List<GridField> gridFields2;
	/** Selection Column Sequence:[InfoColumnVO, GridField] */
	private TreeMap<Integer, List<Object[]>> parameterTree;
	/** To grid field of {@link #parameterTree} */
	private TreeMap<Integer, List<Object[]>> parameterTree2;
	private Checkbox checkAND;
		
	// F3P: Keep original values: when a row is unselected, restore original values
		
	private boolean hasEditable = false;
	private Map<Object, List<Object>> cacheOriginalValues = new HashMap<>();
	private Map<Object, List<Object>> temporarySelectedData = new HashMap<>(); 	
	private WInfoWindowListItemRenderer infoWindowListItemRenderer = null;
	
	// F3P: export 
	
	private Button exportButton = null;
	
	/**
	 * Popup menu for process
	 */
	protected Menupopup ipMenu;
	
	/** Number of column for {@link #parameterGrid} */
	private int noOfParameterColumn;
	
	/** true to auto collapse parameter panel after execution of query */
	private boolean autoCollapsedParameterPanel = false;
	
	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 */
	public InfoWindow(int WindowNo, String tableName, String keyColumn, String queryValue, 
			boolean multipleSelection, String whereClause, int AD_InfoWindow_ID) {
		this(WindowNo, tableName, keyColumn, queryValue, multipleSelection, whereClause, AD_InfoWindow_ID, true);
	}

	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
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
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 * @param lookup
	 * @param field
	 */
	public InfoWindow(int WindowNo, String tableName, String keyColumn, String queryValue, 
			boolean multipleSelection, String whereClause, int AD_InfoWindow_ID, boolean lookup, GridField field) {
		this(WindowNo, tableName, keyColumn, queryValue, multipleSelection, whereClause, AD_InfoWindow_ID, lookup, field, null);		
	}

	/**
	 * @param WindowNo
	 * @param tableName
	 * @param keyColumn
	 * @param queryValue
	 * @param multipleSelection
	 * @param whereClause
	 * @param AD_InfoWindow_ID
	 * @param lookup
	 * @param field
	 * @param predefinedContextVariables
	 */
	public InfoWindow(int WindowNo, String tableName, String keyColumn, String queryValue, 
			boolean multipleSelection, String whereClause, int AD_InfoWindow_ID, boolean lookup, GridField field, String predefinedContextVariables) {
		super(WindowNo, tableName, keyColumn, multipleSelection, whereClause,
				lookup, AD_InfoWindow_ID, queryValue);		
		this.m_gridfield = field;
		this.autoCollapsedParameterPanel = MSysConfig.getBooleanValue(MSysConfig.ZK_INFO_AUTO_COLLAPSED_PARAMETER_PANEL, false, Env.getAD_Client_ID(Env.getCtx()));

		addEventListener(ON_QUERY_AFTER_CHANGE, e -> postQueryAfterChangeEvent());
		
   		//update related info window tabs
   		contentPanel.addActionListener(new EventListener<Event>() {
   			public void onEvent(Event event) throws Exception {
   				
   				int row = -1;
   				
   				if(event instanceof SelectEvent<?, ?>)
   				{
   					@SuppressWarnings("unchecked")
						SelectEvent<Listitem, List<Object>> selEvent = (SelectEvent<Listitem, List<Object>>)event;
   					
   					if(selEvent.getReference() != null)
   					{
   						row = selEvent.getReference().getIndex();
   					}
   				}
   				   				
   				updateSubcontent(row);
   			}
   		});

   		Env.setPredefinedVariables(Env.getCtx(), getWindowNo(), predefinedContextVariables);
		infoContext = new Properties(Env.getCtx());
		p_loadedOK = loadInfoDefinition(); 
		
		// make process button only in window mode
		if (!m_lookup){
			initInfoProcess();
			// when have a process, force multiple selection mode
			if (haveProcess)
				setMultipleSelection(true);
		}		
						
		if (!isAutoComplete)
			loadInfoRelatedTabs();
		
		if (loadedOK()) {
			if (isLookup()) {
				Env.clearTabContext(Env.getCtx(), p_WindowNo, Env.TAB_INFO);
			}
			
			renderWindow();
			prepareTable();
			contentPanel.repaint();
			
			if (queryValue != null && queryValue.trim().length() > 0)
			{
				prepareTable();
				processQueryValue();
			}	
			
			if (!isLookup() && p_multipleSelection && hasEditable) 
			{
				//use only checkmark for selection of row
				//with the default of select by clicking on any cell, the text selection mouse gesture will de-select a selected row
				//note that this also disable the selection of text within the listbox
				contentPanel.setNonselectableTags("*");
			}
		}
		
		if (ClientInfo.isMobile()) {
			ClientInfo.onClientInfo(this, this::onClientInfo);
		}
		
		// F3P: add export button
		if (!isAutoComplete)
			initExport();
	}
	
	/**
	 * set focus to first parameter editor
	 */
	public void focusToFirstEditor()
	{
		if (editors != null && editors.size() > 0)
		{
			Component component = editors.get(0).getComponent();
			if (component instanceof HtmlBasedComponent)
			{
				((HtmlBasedComponent) component).focus();
			}
		}
	}
	
	/** 
	 * 
	* {@inheritDoc}
	*/
	@Override
	protected void updateSubcontent (int row){ // F3P: For multi-selection info, display for the first selected row
		
		if(row < 0)
			row = contentPanel.getSelectedRow();

		if (row >= 0) {
			for (EmbedWinInfo embed : embeddedWinList) {
				// default link column is key column
				int indexData = 0;
				if (columnDataIndex.containsKey(embed.getParentLinkColumnID())){
					// get index of link column
					indexData = p_layout.length + columnDataIndex.get(embed.getParentLinkColumnID());
				}
				RelatedInfoWindow relatedInfoWindow = relatedMap.get(embed.getInfowin().getAD_InfoWindow_ID());
				relatedInfoWindow.refresh(contentPanel.getValueAt(row,indexData));
			}// refresh for all
		}else{
			for (EmbedWinInfo embed : embeddedWinList) {
				reset(embed);
			}
		}
	}

	/**
	 * IDEMPIERE-1334<br/>
	 * Load info processes by layout type.<br/>
	 * Create buttons, drop down list and popup menu.<br/>
	 * Set status of haveProcess flag.<br/> 
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
   			btProcess.setAttribute(PROCESS_ID_KEY, Integer.valueOf(infoProcess.getAD_Process_ID()));
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
   						if (MAttachment.isAttachmentURLPath(data.getImageURL()))
   						{
							item.setImage(MAttachment.getImageAttachmentURLFromPath(null, data.getImageURL()));
   						}
   						else if (data.getImageURL().indexOf("://") > 0)
   						{
   							item.setImage(data.getImageURL());
   						}
   						else if (ThemeManager.isUseFontIconForImage())
   		   	   				item.setIconSclass(ThemeManager.getIconSclass(data.getImageURL()));
   						else
   							item.setImage(ThemeManager.getThemeResource("images/" + data.getImageURL()));
   		   	   		}
   				}
			});
   			
   		    // update tooltip hepl when select a item
   			cbbProcess.addEventListener(Events.ON_SELECT, this);
   			
   			confirmPanel.addComponentsCenter(cbbProcess);

   			btCbbProcess = confirmPanel.addButton(Msg.getMsg(Env.getCtx(), ConfirmPanel.A_PROCESS), null);
   			
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
   				btMenuProcess = confirmPanel.addButton("ProcessMenu", null);
   				btMenuProcess.addEventListener(Events.ON_CLICK, e -> {
   					ipMenu.open(btMenuProcess, "before_start");
   				});
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
	 * Evaluate display logic of process info button and set visibility of button. <br/>
	 */
	protected void bindInfoProcessBt (){
		if (infoProcessBtList == null){
			return;
		}
				
		// display process in button style		
		for (MInfoProcess infoProcessBt : infoProcessBtList){
			// evaluate display logic
			for (Button evlBt: btProcessList){
				Integer processId = (Integer)evlBt.getAttribute(PROCESS_ID_KEY);
				if (processId.intValue() == infoProcessBt.getAD_Process_ID()){
					// display or hide button
					evlBt.setVisible(infoProcessBt.isDisplayed(infoContext, p_WindowNo));
					break;
				}
			}
		}
	}
	
	/**
	 * Create drop down list (Combobox) of process
	 */
	protected void bindInfoProcessDropDown (){
		if (infoProcessDropList == null || infoProcessDropList.size() == 0){
			return;
		}				
				
		// list info process after evaluation of display logic
		List<MInfoProcess> infoProcessDropListTmp = new ArrayList<MInfoProcess> (); 
		
		// filter item not display
		for (MInfoProcess infoProcessDropDown : infoProcessDropList){
			if (infoProcessDropDown.isDisplayed(infoContext, p_WindowNo)){
				infoProcessDropListTmp.add(infoProcessDropDown);
			}
		}
		
		// When all item is hidden. don't show combobox
		cbbProcess.setVisible(infoProcessDropListTmp.size() > 0);
		btCbbProcess.setVisible(infoProcessDropListTmp.size() > 0);
		if (infoProcessDropListTmp.size() > 0){			
			ListModelList<MInfoProcess> infoProccessModel = new ListModelList<MInfoProcess>(infoProcessDropListTmp);
			cbbProcess.setModel(infoProccessModel);
		}
				
	}
	
	/**
	 * Create popup of menu for processes
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
   			// Create menu item for each info process
   	   		Menuitem ipMenuItem = new Menuitem();
   	   		ipMenuItem.setLabel(process.get_Translation(MProcess.COLUMNNAME_Name));
   	   		if (!Util.isEmpty(infoProcess.getImageURL(), true)) {
   	   			if (infoProcess.getImageURL().indexOf("://") > 0)
   	   			{
   	   				if (MAttachment.isAttachmentURLPath(infoProcess.getImageURL()))
   	   					ipMenuItem.setImage(MAttachment.getImageAttachmentURLFromPath(null, infoProcess.getImageURL()));
   	   				else
   	   					ipMenuItem.setImage(infoProcess.getImageURL());
   	   			}
   	   			else if (ThemeManager.isUseFontIconForImage())
   	   				ipMenuItem.setIconSclass(ThemeManager.getIconSclass(infoProcess.getImageURL()));
   	   			else
   	   				ipMenuItem.setImage(ThemeManager.getThemeResource("images/" + infoProcess.getImageURL()));
   	   		}   	   		
   	   		ipMenuItem.setAttribute(PROCESS_ID_KEY, infoProcess.getAD_Process_ID());
   	   		ipMenuItem.addEventListener(Events.ON_CLICK, this);
   	   		ipMenu.appendChild(ipMenuItem);
   		}
   		
		//hide menu button if no visible process
		btMenuProcess.setVisible(ipMenu.getChildren().size() > 0);
	}

	/**
	 * Move process buttons from left of centre panel to the front of right panel
	 */
	public void moveProcessButtonsToBeforeRight() {
		if (btProcessList == null || btProcessList.isEmpty())
			return;
		
		for(Button btn : btProcessList) {
			confirmPanel.addComponentsBeforeRight(btn);
		}
	}
	
	/**
	 * Process query value from input element
	 */
	protected void processQueryValue() {
		isQueryByUser = true;
		boolean splitValue = false;
		
		if (isAutoComplete) {
			testQueryForAutoComplete();
		}else {
			String separator = MSysConfig.getValue(MSysConfig.IDENTIFIER_SEPARATOR, "_", Env.getAD_Client_ID(Env.getCtx()));
			String[] values = queryValue.split("[" + separator.trim()+"]");

			if (values.length > 1) {
				splitValue = true;
				testQueryForSplit(values);
			} 

			if (m_count <= 0) {
				testQueryForEachIdentifier();
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

	protected void testQueryForAutoComplete() {
		WEditor autocompleteEditor = null;
		
		if (Util.isEmpty(autoCompleteSearchColumn) && identifiers.size() > 0) {
			autocompleteEditor = identifiers.get(0);
		}else if (!Util.isEmpty(autoCompleteSearchColumn) && identifiers.size() > 0) {
			autocompleteEditor = identifiers.stream()
					.filter(editor -> editor.getColumnName().equals(autoCompleteSearchColumn))
					.findFirst().orElse(null);
		}
		
		
		if (autocompleteEditor != null) {
			try{
				autocompleteEditor.setValue(queryValue);
				testCount(false);

			}catch(Exception ex){
				// => don't run test in case not success set value
				log.log(Level.SEVERE, "error", ex.getCause());
			}
		}else {
			// => don't run test in case not found auto complete column
			if(!Util.isEmpty(autoCompleteSearchColumn)) {

				if (m_gridfield != null) {
					log.log(Level.SEVERE, String.format("Auto complete search column (%s) not found for field %s (field id %s). ",
							autoCompleteSearchColumn, m_gridfield.getColumnName(), m_gridfield.getAD_Column_ID()));
				} else {
					log.log(Level.SEVERE, String.format("Auto complete search column (%s) not found for Info Window %s. ",
							autoCompleteSearchColumn, this.infoWindow.getName()));
				}
				
			} else if (identifiers.size() == 0)
				log.log(Level.SEVERE, String.format("Info window (%s) has no identifier columns", this.infoWindow.getName()));
		}
	}
	
	protected void testQueryForEachIdentifier() {
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
	}
	
	protected void testQueryForSplit(String [] values) {
		// store identifiers on info window, sort to follow identifier on m_table
		List<WEditor> fillIdentifiers = new ArrayList<>();
		// store query value, ignore value for identifier not exists on info window
		// this list is sync with fillIdentifiers (size and order)
		List<String> fillValues = new ArrayList<>();
		
		List<String> tableIdentifiers = null;
		if (m_gridfield != null && m_gridfield.getLookup() != null 
				&& m_gridfield.getLookup() instanceof MLookup) {
			
			MLookup mLookup = (MLookup)m_gridfield.getLookup();
			if (mLookup.getLookupInfo().lookupDisplayColumnNames.size() > 0)
				tableIdentifiers = mLookup.getLookupInfo().lookupDisplayColumnNames;
		}
		
		if (tableIdentifiers != null) {
			for (int i = 0; i < tableIdentifiers.size(); i++) {
				// final local variable to access inside lambda expression
				int indexFinal = i;
				List<String> tableIdentifiersFinal = tableIdentifiers;
				
				// sort identifiers of info window to follow m_table
				// ignore identifiers exists on m_table but not exists on info window
				identifiers.forEach((Consumer<WEditor>)(identifierEditor) -> {
					if (identifierEditor.getColumnName().equals(tableIdentifiersFinal.get(indexFinal))) {
						fillIdentifiers.add(identifierEditor);
						fillValues.add(values[indexFinal]);
					}
				});
			}
		}
		
		// case not exists mLookup.getLookupInfo().lookupDisplayColumnNames
		// or no identifiers on info window exists on m_table
		// fall back to old logic and just set values to identifiers
		if (fillIdentifiers.size() == 0) {
			for(int i = 0; i < values.length && i < identifiers.size(); i++) {
				fillIdentifiers.add(identifiers.get(i));
				fillValues.add(values[i]);
			}
		}
		


		// do fill value to editor (for both corrected order and fall back)
		for(int i = 0; i < fillIdentifiers.size(); i++) {
			WEditor editor = fillIdentifiers.get(i);
			editor.setValue(fillValues.get(i).trim());
		}
		testCount(false);

	}
	
	@Override
	protected void loadInfoWindowData (){
		if (m_infoWindowID > 0) {
			infoWindow = MInfoWindow.getInfoWindow(m_infoWindowID);
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
	
	/**
	 * load info window definition
	 * @return true if loaded ok
	 */
	protected boolean loadInfoDefinition() {
		if (infoWindow != null) {
			String tableName = null;
				tableName = MTable.getTableName(Env.getCtx(), infoWindow.getAD_Table_ID());
			
			tableInfos = infoWindow.getTableInfos();
			if (tableInfos[0].getSynonym() != null && tableInfos[0].getSynonym().trim().length() > 0) {
				p_tableName = tableInfos[0].getSynonym().trim();
				if (p_whereClause != null && p_whereClause.trim().length() > 0) {
					p_whereClause = p_whereClause.replace(tableName+".", p_tableName+".");
				}					
			}
			
			MInfoColumn[] p_infoColumns = infoWindow.getInfoColumns(tableInfos);
			infoColumns = InfoColumnVO.create(Env.getCtx(), p_infoColumns);
		
			gridFields = new ArrayList<GridField>();
			parameterTree = new TreeMap<Integer, List<Object[]>>();
			gridFields2 = new ArrayList<GridField>();
			parameterTree2 = new TreeMap<Integer, List<Object[]>>();
			
			for(InfoColumnVO infoColumn : infoColumns) {
				if (infoColumn.isKey())
					keyColumnOfView = infoColumn.getAD_InfoColumn();
				String columnName = infoColumn.getColumnName();
				/*!m_lookup && infoColumn.isMandatory():apply Mandatory only case open as window and only for criteria field*/
				boolean isMandatory = !m_lookup && infoColumn.isMandatory() && infoColumn.isQueryCriteria();
				GridFieldVO vo = GridFieldVO.createParameter(infoContext, p_WindowNo, AEnv.getADWindowID(p_WindowNo), infoWindow.getAD_InfoWindow_ID(), 0,
						columnName, infoColumn.getNameTrl(), infoColumn.getAD_Reference_ID(), 
						infoColumn.getAD_Reference_Value_ID(), isMandatory, false, infoColumn.getPlaceHolderTrl(), infoColumn.getEntityType());
				
				if (infoColumn.getAD_Val_Rule_ID() > 0) {
					vo.ValidationCode = infoColumn.getValidationCode();
					if (vo.lookupInfo != null) {
						vo.lookupInfo.ValidationCode = vo.ValidationCode;
						vo.lookupInfo.IsValidated = false;
					}
				}
				if (infoColumn.getDisplayLogic() != null)					
					vo.DisplayLogic =  infoColumn.getDisplayLogic();
				if (infoColumn.isQueryCriteria() && infoColumn.getDefaultValue() != null)
					vo.DefaultValue = infoColumn.getDefaultValue();
				if (infoColumn.isQueryCriteria() && infoColumn.getDefaultValue2() != null)
					vo.DefaultValue2 = infoColumn.getDefaultValue2();
				if (infoColumn.isQueryCriteria() && infoColumn.getPlaceholder() != null)
					vo.Placeholder = infoColumn.getPlaceholder();
				if (infoColumn.isQueryCriteria() && infoColumn.getPlaceholder2() != null)
					vo.Placeholder2 = infoColumn.getPlaceholder2();
				
				String desc = infoColumn.getDescriptionTrl();
				vo.Description = desc != null ? desc : "";
				String help = infoColumn.getHelpTrl();
				vo.Help = help != null ? help : "";
				vo.AD_FieldStyle_ID = infoColumn.getAD_FieldStyle_ID();
				vo.IsAutocomplete = infoColumn.isAutocomplete();
				vo.IsReadOnly = infoColumn.isReadOnly();
				GridField gridField = new GridField(vo);
				gridFields.add(gridField);
				
				GridFieldVO vo2 = null;
				GridField gridField2 = null;
				if(infoColumn.isRange()) {
					vo2 = GridFieldVO.createParameter(vo);
					gridField2 = new GridField(vo2);
				}
				gridFields2.add(gridField2);
				//IDEMPIERE-4485 Clone new Grid fields with IsReadOnly = false
				if(infoColumn.isQueryCriteria()) {
					vo = vo.clone(infoContext, p_WindowNo, 0, vo.AD_Window_ID, 0, false);
					vo.IsReadOnly = false;
					vo.TabNo = Env.TAB_INFO;					
					gridField = new GridField(vo);
					List<Object[]> list = parameterTree.get(infoColumn.getSeqNoSelection());
					List<Object[]> list2 = parameterTree2.get(infoColumn.getSeqNoSelection());
					if (list == null) {
						list = new ArrayList<Object[]>();
						parameterTree.put(infoColumn.getSeqNoSelection(), list);
					}
					if (list2 == null) {
						list2 = new ArrayList<Object[]>();
						parameterTree2.put(infoColumn.getSeqNoSelection(), list2);
					}
					
					list.add(new Object[]{infoColumn, gridField});
					list2.add(new Object[]{infoColumn, gridField2});
				}
			}
			
			// If we have a process and at least one editable field, listen for table change event
			
			int processCount = 0;
			
			if(infoWindow != null)
			{
				MInfoProcess processes[] = infoWindow.getInfoProcess(false);
				processCount = processes.length;
			}
			
			if(processCount > 0)
			{
				for(InfoColumnVO infoColumn:infoColumns)
				{
					if(infoColumn.isReadOnly() == false)
					{
						hasEditable = true;
						break;
					}
				}
				
			}

			infoWindowListItemRenderer = new WInfoWindowListItemRenderer(this);
			contentPanel.setItemRenderer(infoWindowListItemRenderer);
			if(hasEditable)
			{
				contentPanel.setAllowIDColumnForReadWrite(true);
				infoWindowListItemRenderer.addTableValueChangeListener(contentPanel); // Replicated from WListbox constructor
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
				builder.append("(");
				builder.append(infoWhereClause);
				builder.append(")");
				p_whereClause = builder.toString();
			}
			
			return true;
		} else {
			return false;
		}
	}

	/**
	 * load related info
	 * @return true if loaded ok
	 */
	protected boolean loadInfoRelatedTabs() {
		if (infoWindow == null)
			return false;

		MInfoRelated[] infoRelatedList = infoWindow.getInfoRelated(true);
		//Init Info Related VO
		relatedInfoList = InfoRelatedVO.getInfoRelatedVOList(Env.getCtx(), infoRelatedList, p_WindowNo);
		
		Tabpanels tabPanels = new Tabpanels();
		Tabs tabs = new Tabs();

		for (InfoRelatedVO relatedInfo:relatedInfoList) {
			
			if(!relatedInfo.isDisplayed(infoContext)) {
				continue;
			}

			String tableName = null;		
			int infoRelatedID = relatedInfo.getRelatedInfo_ID(); 

			MInfoWindow embedInfo = new MInfoWindow(Env.getCtx(), infoRelatedID, null);

			TableInfo[] tableInfos = embedInfo.getTableInfos();
			if (tableInfos[0].getSynonym() != null && tableInfos[0].getSynonym().trim().length() > 0){
				tableName = tableInfos[0].getSynonym().trim();
			}

			WListbox embeddedTbl = new WListbox();
			String m_sqlEmbedded;

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
				String infoWhere = embedInfo.getWhereClause(); 
				if(!Util.isEmpty(infoWhere))
					s_sqlWhere += " AND (" + infoWhere + ")";
				String s_sqlCount = "SELECT COUNT(*) FROM " + s_sqlFrom + " WHERE " + s_sqlWhere;
				m_sqlEmbedded = embeddedTbl.prepareTable(s_layoutEmbedded, s_sqlFrom, s_sqlWhere, false, tableName);

				embeddedTbl.setMultiSelection(false);

				embeddedTbl.getModel().addTableModelListener(this);
				ZKUpdateUtil.setVflex(embeddedTbl, "1");

				Paging embeddedPaging = new Paging();
				embeddedPaging.setPageSize(pageSize);
				embeddedPaging.setTotalSize(0);
				ZKUpdateUtil.setHflex(embeddedPaging, "1");
				embeddedPaging.setMold("os");
				embeddedPaging.setVisible(false);
				embeddedPaging.setSclass("infowindow-related-paging");

				//Xolali - add embeddedTbl to list, add m_sqlembedded to list
				EmbedWinInfo ewinInfo = new EmbedWinInfo(embedInfo, embeddedTbl, m_sqlEmbedded, relatedInfo.getLinkColumnName(), relatedInfo.getLinkInfoColumn(), relatedInfo.getParentRelatedColumn_ID());
				embeddedWinList.add(ewinInfo);
				RelatedInfoWindow relatedInfoWindow = new RelatedInfoWindow(ewinInfo, this, embeddedPaging, s_sqlCount, s_layoutEmbedded, editorMap);
				relatedMap.put(embedInfo.getAD_InfoWindow_ID(), relatedInfoWindow);

				String tabTitle = relatedInfo.getName();
				Tab tab = new Tab(tabTitle);
				tabs.appendChild(tab);
				Tabpanel desktopTabPanel = new Tabpanel();
				ZKUpdateUtil.setHeight(desktopTabPanel, "100%");
				Vlayout vlayout = new Vlayout();
				ZKUpdateUtil.setVflex(vlayout, "1");
				desktopTabPanel.appendChild(vlayout);
				vlayout.appendChild(embeddedPaging);
				vlayout.appendChild(embeddedTbl);				
				tabPanels.appendChild(desktopTabPanel);
			}

		}
		
		if (relatedInfoList.length > 0) { // setup the panel
			ZKUpdateUtil.setHeight(embeddedPane, "100%");
			embeddedPane.appendChild(tabPanels);
			embeddedPane.appendChild(tabs);

		}

		return true;
	}

	/**
	 * Setup list box and construct SQL query clause
	 */
	protected void prepareTable() {		
		List<ColumnInfo> list = new ArrayList<ColumnInfo>();
		String keyTableAlias = tableInfos[0].getSynonym() != null && tableInfos[0].getSynonym().trim().length() > 0 
				? tableInfos[0].getSynonym()
				: tableInfos[0].getTableName();
					
		String keySelectClause = keyTableAlias+"."+p_keyColumn;
		if (p_keyColumn.endsWith("_UU"))
			list.add(new ColumnInfo(" ", keySelectClause, UUIDColumn.class, true, false, null, p_keyColumn));
		else
			list.add(new ColumnInfo(" ", keySelectClause, IDColumn.class, true, false, null, p_keyColumn));
		
		List<InfoColumnVO> gridDisplayedIC = new ArrayList<>();				
		gridDisplayedIC.add(null); // First column does not have any matching info column		
		
		boolean haveNotProcess = !haveProcess; // A field is editabile only if is not readonly and theres a process
				
		int i = 0;
		for(InfoColumnVO infoColumn : infoColumns) 
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
					
					columnInfo = new ColumnInfo(infoColumn.getNameTrl(), colSQL, DisplayType.getClass(infoColumn.getAD_Reference_ID(), true), infoColumn.isReadOnly() || haveNotProcess);
				}
				else if (LookupFactoryHelper.isLookup(infoColumn))
				{
					if (infoColumn.getAD_Reference_ID() == DisplayType.List)
					{
						WEditor editor = null;
						editor = WebEditorFactory.getEditor(gridFields.get(i), true);
				        editor.setMandatory(false);
				        editor.setReadWrite(false);
				        editorMap.put(colSQL, editor);
						columnInfo = new ColumnInfo(infoColumn.getNameTrl(), colSQL, ValueNamePair.class, (String)null, infoColumn.isReadOnly() || haveNotProcess);
					}
					else
					{
						columnInfo = createLookupColumnInfo(tableInfos, gridFields.get(i), infoColumn);
					}					
				}
				else  
				{
					columnInfo = new ColumnInfo(infoColumn.getNameTrl(), colSQL, DisplayType.getClass(infoColumn.getAD_Reference_ID(), true), infoColumn.isReadOnly() || haveNotProcess);
				}
				columnInfo.setColDescription(infoColumn.getNameTrl());
				columnInfo.setAD_Reference_ID(infoColumn.getAD_Reference_ID());
				columnInfo.setAD_Reference_Value_ID(infoColumn.getAD_Reference_Value_ID());
				columnInfo.setGridField(gridFields.get(i));
				columnInfo.setColumnName(infoColumn.getColumnName());
				list.add(columnInfo);
				gridDisplayedIC.add(infoColumn);
				
				if (keyColumnOfView == infoColumn.getAD_InfoColumn()){
					if (columnInfo.getColClass().equals(IDColumn.class) || columnInfo.getColClass().equals(UUIDColumn.class)) 
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
		InfoColumnVO gridDisplayedInfoColumns[] = gridDisplayedIC.toArray(new InfoColumnVO[gridDisplayedIC.size()]);
		
		if(infoWindowListItemRenderer != null)
			infoWindowListItemRenderer.setGridDisplaydInfoColumns(gridDisplayedInfoColumns,columnInfos);
		
		prepareTable(columnInfos, infoWindow.getFromClause(), p_whereClause, infoWindow.getOrderByClause());		
	}

	/**
	 * 
	 * @param tableInfos
	 * @param gridField
	 * @param infoColumn
	 * @return {@link ColumnInfo}
	 */
	protected ColumnInfo createLookupColumnInfo(TableInfo[] tableInfos,
			GridField gridField, InfoColumnVO infoColumn) {
		String columnName = gridField.getColumnName();
		String validationCode = "";
		MLookupInfo lookupInfo = MLookupFactory.getLookupInfo(Env.getCtx(), p_WindowNo, 0, infoColumn.getAD_Reference_ID(), Env.getLanguage(Env.getCtx()), columnName, infoColumn.getAD_Reference_Value_ID(), false, validationCode);
		String displayColumn = lookupInfo.DisplayColumn;
		
		boolean haveNotProcess = !haveProcess; // A field is editable only if is not readonly and there is a process;
				
		int index = infoColumn.getSelectClause().indexOf(".");
		if (index >= 0 && index == infoColumn.getSelectClause().lastIndexOf("."))
		{
			String synonym = infoColumn.getSelectClause().substring(0, index);
			for(TableInfo tableInfo : tableInfos)
			{
				if (tableInfo.getSynonym() != null && tableInfo.getSynonym().equals(synonym)) 
				{
					if (tableInfo.getTableName().equalsIgnoreCase(lookupInfo.TableName))
					{
						displayColumn = displayColumn.replace(lookupInfo.TableName+".", tableInfo.getSynonym()+".");
						ColumnInfo columnInfo = new ColumnInfo(infoColumn.getNameTrl(), displayColumn, KeyNamePair.class, infoColumn.getSelectClause(), infoColumn.isReadOnly() || haveNotProcess, displayColumn, infoColumn.getSelectClause());
						return columnInfo;
					}
					else
					{
				        displayColumn = parseAliases(displayColumn, lookupInfo.TableName);
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
        Class<?> colClass = columnName.endsWith("_ID") || columnName.equals("CreatedBy") || columnName.equals("UpdatedBy") ? KeyNamePair.class : String.class;
        ColumnInfo columnInfo = new ColumnInfo(infoColumn.getNameTrl(), colSQL, colClass, (String)null, infoColumn.isReadOnly() || haveNotProcess, displayColumn, infoColumn.getSelectClause());
		return columnInfo;
	}

	/**
	 * Check and parse the correct aliases of the display SQL
	 * @param displayColumn
	 * @return parsed displayColumn
	 */
	private String parseAliases(String displayColumn, String tableName) {
		if(Util.isEmpty(displayColumn))
			return null;
		String tabelNameTrl = tableName + "_Trl";
		String alias = getAlias(tableName);

		if(displayColumn.contains(tabelNameTrl+".")) {
			if(displayColumn.contains(tableName+".") && !tableName.equalsIgnoreCase(alias)) {
				return displayColumn.replace(tableName+".", alias+".");
			}
			return displayColumn;
		}

		if(displayColumn.contains(alias+".")){
			return displayColumn;
		}
		else if(displayColumn.contains(tableName+".") && !tableName.equalsIgnoreCase(alias)) {
			return displayColumn.replace(tableName+".", alias+".");
		}
		else if(!displayColumn.matches("\\w{1,}\\s{0,}\\((.*?)\\)")) {	// {function name}({*column name*})
			displayColumn = (alias+"."+displayColumn);
		}
		else {
			return null;
		}

		return displayColumn;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.panel.InfoPanel#getSQLWhere()
	 */
	@Override
	protected String getSQLWhere() {
		/**
		 * when query not by click re-query button, reuse previous where clause
		 * IDEMPIERE-1979  
		 */
		if (!isQueryByUser && prevWhereClause != null){
			return prevWhereClause;
		}
		
		StringBuilder builder = new StringBuilder();
		MTable table = MTable.get(Env.getCtx(), infoWindow.getAD_Table_ID());
		MReference ref = m_gridfield != null && m_gridfield.getAD_Reference_Value_ID() > 0 ? MReference.get(Env.getCtx(), m_gridfield.getAD_Reference_Value_ID()) : null;
		boolean onlyActive = ref == null || !ref.isShowInactiveRecords();
		if (!hasIsActiveEditor() && table.get_ColumnIndex("IsActive") >= 0 && onlyActive) {
			if (p_whereClause != null && p_whereClause.trim().length() > 0) {
				builder.append(" AND ");
			}
			String qualifiedTable = tableInfos[0].getSynonym();
			if (Util.isEmpty(qualifiedTable))
				qualifiedTable = tableInfos[0].getTableName();
			builder.append(qualifiedTable).append(".IsActive='Y'");
		}
		int count = 0;
		int idx = 0;
		for(WEditor editor : editors) {
			if (!editor.isVisible()) {
				idx++;
				continue;
			}
			WEditor editor2 = editors2.get(idx);
			boolean isRange = false;
			if(editor2 != null)
				isRange = true;
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
			} else if (editor.getGridField() != null && (editor.getValue() != null && editor.getValue().toString().trim().length() > 0)
					|| (isRange && editor2.getValue() != null && editor2.getValue().toString().trim().length() > 0)) {
				InfoColumnVO InfoColumnVO = findInfoColumnParameter(editor.getGridField());
				if (InfoColumnVO == null || InfoColumnVO.getSelectClause().equals("0")) {
					continue;
				}
				String columnName = InfoColumnVO.getSelectClause();
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
								
				if (InfoColumnVO.getAD_Reference_ID() == DisplayType.ChosenMultipleSelectionList)
				{
					String pString = editor.getValue().toString();
					String column = columnName;
					if (column.indexOf(".") > 0)
						column = column.substring(column.indexOf(".")+1);
					int cnt = DB.getSQLValueEx(null, "SELECT Count(*) From AD_Column WHERE IsActive='Y' AND AD_Client_ID=0 AND Upper(ColumnName)=? AND AD_Reference_ID=?", column.toUpperCase(), DisplayType.ChosenMultipleSelectionList);
					if (cnt > 0)
						builder.append(DB.intersectClauseForCSV(columnName, pString));
					else
						builder.append(DB.inClauseForCSV(columnName, pString));
				} 
				else if (InfoColumnVO.getAD_Reference_ID() == DisplayType.ChosenMultipleSelectionTable || InfoColumnVO.getAD_Reference_ID() == DisplayType.ChosenMultipleSelectionSearch)
				{
					String pString = editor.getValue().toString();
					if (columnName.endsWith("_ID"))
					{						
						builder.append(DB.inClauseForCSV(columnName, pString));
					}
					else
					{
						builder.append(DB.intersectClauseForCSV(columnName, pString));
					}
				}
				else
				{
					String columnClause = null;
					if (InfoColumnVO.getQueryFunction() != null && InfoColumnVO.getQueryFunction().trim().length() > 0) {
						String function = InfoColumnVO.getQueryFunction();
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
					if(!isRange) {
						builder.append(columnClause)
							   .append(" ")
							   .append(InfoColumnVO.getQueryOperator());
						if (columnClause.toUpperCase().startsWith("UPPER(")) {
							builder.append(" UPPER(?)");
						} else {
							builder.append(" ?");
						}
					}
					else {
						if(editor.getValue() != null && editor.getValue().toString().trim().length() > 0) {
							builder.append(columnClause)
							.append(" ")
							.append(X_AD_InfoColumn.QUERYOPERATOR_GtEq);
							if (columnClause.toUpperCase().startsWith("UPPER(")) {
								builder.append(" UPPER(?)");
							} else {
								builder.append(" ?");
							}
						}
						if(editor2.getValue() != null && editor2.getValue().toString().trim().length() > 0) {
							if(editor.getValue() != null && editor.getValue().toString().trim().length() > 0) {
								builder.append(" AND ");
							}
							builder.append(columnClause)
							.append(" ")
							.append(X_AD_InfoColumn.QUERYOPERATOR_LeEq);
							if (columnClause.toUpperCase().startsWith("UPPER(")) {
								builder.append(" UPPER(?)");
							} else {
								builder.append(" ?");
							}
						}
					}
				}
			}
			idx++;
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

	/**
	 * 
	 * @param gridField
	 * @return {@link InfoColumnVO} if found, null otherwise
	 */
	protected InfoColumnVO findInfoColumn(GridField gridField) {
		for(int i = 0; i < gridFields.size(); i++) {
			if (gridFields.get(i) == gridField) {
				return infoColumns[i];
			}
		}
		return null;
	}

	/**
	 * 
	 * @param gridField
	 * @return {@link InfoColumnVO} if found, null otherwise
	 */
	protected InfoColumnVO findInfoColumnParameter(GridField gridField) {
		for (Integer i : parameterTree.keySet()) {
			List<Object[]> list = parameterTree.get(i);
			for(Object[] value : list) {
				if (gridField == value[1]) {
					return (InfoColumnVO) value[0];
				}
			}
		}
		return null;
	}

	/**
	 * Check if parameter value has change
	 * @return true if at least one parameter value has change or this is the first search by user
	 */
	protected boolean isParameteChangeValue (){
		if (prevParameterValues == null){
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
				InfoColumnVO InfoColumnVO = findInfoColumnParameter(editor.getGridField());
				if (InfoColumnVO == null || InfoColumnVO.getSelectClause().equals("0")) {
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
		int idx = 0;
		for(WEditor editor : editors) {
			InfoColumnVO infoColumnVO = findInfoColumnParameter(editor.getGridField());
			parameterIndex = setParameter(editor, infoColumnVO, pstmt, parameterIndex);
			parameterIndex = setParameter(editors2.get(idx), infoColumnVO, pstmt, parameterIndex);
			idx++;
		}

	}
	
	/**
	 * 
	 * @param editor
	 * @param infoColumnVO
	 * @param pstmt
	 * @param parameterIndex current parameter index
	 * @return current parameter index
	 * @throws SQLException
	 */
	protected int setParameter(WEditor editor, InfoColumnVO infoColumnVO, PreparedStatement pstmt, int parameterIndex) throws SQLException {
		if(editor == null)
			return parameterIndex;
		
		if (!editor.isVisible()) 
			return parameterIndex;
		
		if (editor.getGridField() != null && editor.getValue() != null && editor.getValue().toString().trim().length() > 0) {
			if (infoColumnVO == null || infoColumnVO.getSelectClause().equals("0")) {
				return parameterIndex;
			}
			if (infoColumnVO.getAD_Reference_ID()==DisplayType.ChosenMultipleSelectionList || infoColumnVO.getAD_Reference_ID()==DisplayType.ChosenMultipleSelectionSearch
				|| infoColumnVO.getAD_Reference_ID()==DisplayType.ChosenMultipleSelectionTable) {
				return parameterIndex;
			}
			Object value = editor.getValue();
			parameterIndex++;
			prevParameterValues.add(value);
			prevQueryOperators.add(infoColumnVO.getQueryOperator());
			prevRefParmeterEditor.add(editor);
			setParameter (pstmt, parameterIndex, value, infoColumnVO.getQueryOperator());
		}
		return parameterIndex;
	}
	
	/**
	 * Set parameters for prepared statement.<br/> 
	 * Does not need null check for value.
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
			StringBuilder valueStr = new StringBuilder(value.toString());
			if (queryOperator.equals(X_AD_InfoColumn.QUERYOPERATOR_Like)) {
				if (!valueStr.toString().endsWith("%"))
					valueStr.append("%");
			} else if (queryOperator.equals(X_AD_InfoColumn.QUERYOPERATOR_FullLike)) {
				if (!valueStr.toString().startsWith("%"))
					valueStr.insert(0, "%");
				if (!valueStr.toString().endsWith("%"))
					valueStr.append("%");
			}
			pstmt.setString(parameterIndex, valueStr.toString());
		} else {
			pstmt.setObject(parameterIndex, value);
		}
	}

	/** editor configuration for readonly field editor **/
	private final static IEditorConfiguration readOnlyEditorConfiguration = new IEditorConfiguration() {
		@Override
		public Boolean getReadonly() {
			return Boolean.TRUE;
		}

		@Override
		public Boolean getMandatory() {
			return Boolean.FALSE;
		}
	};
	
	@Override
	protected void prepareTable(ColumnInfo[] layout, String from, String where,
			String orderBy) {
		super.prepareTable(layout, from, where, orderBy);

		ListitemRenderer<?> renderer = contentPanel.getItemRenderer();
		if (renderer instanceof WListItemRenderer lir) {
			int columns = lir.getNoColumns();
			for(int i = 0; i < columns; i++) {
				WTableColumn column = lir.getColumn(i);
				if (column.getAD_Reference_ID() == DisplayType.ImageURL) {
					column.setEditorProvider(t -> {
						GridField gridField = layout[t.columnIndex].getGridField();
						WImageURLEditor editor = new WImageURLEditor(gridField, true, readOnlyEditorConfiguration);
						editor.setValue(t.value);
						return editor;
					});
				} else if (column.getAD_Reference_ID() == DisplayType.Image) {
					column.setEditorProvider(t -> {
						GridField gridField = layout[t.columnIndex].getGridField();
						WImageEditor editor = new WImageEditor(gridField, true, readOnlyEditorConfiguration);
						editor.setValue(t.value);
						Image image = editor.getComponent();
						if (image.getContent() != null) {
							image.setWidth(MSysConfig.getIntValue(MSysConfig.ZK_THUMBNAIL_IMAGE_WIDTH, 100, Env.getAD_Client_ID(Env.getCtx()))+"px");
							image.setHeight(MSysConfig.getIntValue(MSysConfig.ZK_THUMBNAIL_IMAGE_HEIGHT, 100, Env.getAD_Client_ID(Env.getCtx()))+"px");
							image.setClientAttribute("onmouseenter", "idempiere.showFullSizeImage(event)");
							image.setClientAttribute("onmouseleave", "idempiere.hideFullSizeImage(event)");
						}
						if (t.value == null)
							LayoutUtils.addSclass("no-image", editor.getComponent());
						return editor;
					});
				}
			}
		}
		
		addViewIDToQuery();
		addKeyViewToQuery();

		if (m_sqlMain.indexOf("@") >= 0) {
			String sql = Env.parseContext(infoContext, p_WindowNo, m_sqlMain, true);
			if (sql == null || sql.length() == 0) {
				log.severe("Failed to parsed sql. sql=" + m_sqlMain);
			} else {
				m_sqlMain = sql;
			}
		}

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
	 * Add all ViewID in each MInfoProcess to query.<br/>
	 * If main query have subquery in SELECT, it will beak or incorrect
	 */
	protected void addViewIDToQuery () {
		m_sqlMain = addMoreColumnToQuery (m_sqlMain, infoProcessList);
	}
	
	/**
	 * If {@link #keyColumnOfView} not null and not display, add {@link #keyColumnOfView} to query
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
	 * Info window load infoColumns with isDisplay = true to construct the main query. <br/>
	 * Some function uses data from hidden column as viewID in infoProcess
	 * or as parentLink of infoRelateWindow. This function is use to append the hidden column to main query.
	 * <p/>
	 * Append info window column to query.
	 * @param sqlMain main SQL to append column
	 * @param listInfoColumn list of info column to add to query
	 * @return SQL after append column
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

			MInfoColumn p_infocol = (MInfoColumn) infoProcess.getAD_InfoColumn();
			InfoColumnVO infocol = new InfoColumnVO(Env.getCtx(), p_infocol);
			
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
	
	/**
	 * layout window UI elements
	 */
	protected void renderWindow()
	{	
		// Load User Def
		MUserDefInfo userDef = MUserDefInfo.getBestMatch(Env.getCtx(), infoWindow.getAD_InfoWindow_ID());
		if(userDef != null && !Util.isEmpty(userDef.getName())) {
			setTitle(userDef.getName());
		} else {
			setTitle(infoWindow.get_Translation("Name"));
		}
		layout = new Borderlayout();
		ZKUpdateUtil.setWidth(layout, "100%");
		ZKUpdateUtil.setHeight(layout, "100%");
        this.appendChild(layout);
		
        if (isLookup())
        	ZKUpdateUtil.setWidth(contentPanel, "99%");
        else
        	contentPanel.setStyle("width: 99%; margin: 0px auto;");
        ZKUpdateUtil.setVflex(contentPanel, true);
        contentPanel.setSizedByContent(true);
        contentPanel.setSpan(true);
        
        North north = new North();
        north.setCollapsible(true);
        north.setSplittable(true);
        north.setAutoscroll(true);                
        LayoutUtils.addSlideSclass(north);
        ZKUpdateUtil.setVflex(north, "min");
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
		
		paging = new Paging();
		paging.setPageSize(pageSize);
		paging.setTotalSize(0);
		paging.setDetailed(true);
		paging.addEventListener(ZulEvents.ON_PAGING, this);
		paging.setActivePage(0);
		pageNo = 0;
		insertPagingComponent();
		paging.setVisible(false);
	}

	/**
	 * layout footer
	 * @param south
	 */
	protected void renderFooter(South south) {		
		southBody = new Vbox();
		ZKUpdateUtil.setHflex(southBody, "1");
		southBody.setClass("info");
		south.appendChild(southBody);
		southBody.appendChild(new Separator());
		southBody.appendChild(confirmPanel);
		southBody.appendChild(statusBar);
	}

	@Override
	protected void insertPagingComponent() {
		southBody.insertBefore(paging, southBody.getFirstChild());
		layout.invalidate();
	}
	
	/**
	 * layout center content pane
	 * @param center
	 */
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
		inner.setStyle("border: none; position: relative; ");
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
			south.setSclass("south-collapsible-with-title");
			south.setAutoscroll(true);
			inner.appendChild(south);
			embeddedPane.setSclass("info-product-tabbedpane");
			ZKUpdateUtil.setVflex(embeddedPane, "1");
			ZKUpdateUtil.setHflex(embeddedPane, "1");

			south.appendChild(embeddedPane);
		}// render embedded

		center.appendChild(inner);
	}

	/**
	 * layout query parameter pane
	 * @param north
	 */
	protected void renderParameterPane(North north) {
		createParameterPanel();        
		north.appendChild(parameterGrid);
	}

	/**
	 * create query parameter panel
	 */
	protected void createParameterPanel() {
		layoutParameterGrid(false);
	}
	
	/**
	 * layout query parameter panel
	 * @param update
	 */
	protected void layoutParameterGrid(boolean update) {
		if (!update) {
			parameterGrid = GridFactory.newGridLayout();
			parameterGrid.setClientAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, "infoParameterPanel");
			parameterGrid.setStyle("width: 95%; margin: auto !important;");
		}
		if (parameterGrid.getColumns() != null)
			parameterGrid.getColumns().detach();
		Columns columns = new Columns();
		parameterGrid.appendChild(columns);
		noOfParameterColumn = getNoOfParameterColumns();
		String labelWidth = ( 100 / ( 3 * ( getNoOfParameterColumns() / 2 ) ) ) + "%";
		String fieldWidth = ( 100 * 2 / ( 3 * ( getNoOfParameterColumns() / 2 ) ) ) + "%";
		for(int i = 0; i < noOfParameterColumn; i++) {
			Column column = new Column();
			if (i%2 == 0)
				column.setWidth(labelWidth);
			else
				column.setWidth(fieldWidth);
			columns.appendChild(column);
		}
		
		if (parameterGrid.getRows() != null)
			parameterGrid.getRows().detach();
		Rows rows = new Rows();
		parameterGrid.appendChild(rows);
		
		if (!update) {
			editors = new ArrayList<WEditor>();
			editors2 = new ArrayList<WEditor>();
			queryAfterChangeEditors = new ArrayList<>();
			identifiers = new ArrayList<WEditor>();
		}

		for (Integer i : parameterTree.keySet()) {
			List<Object[]> list = parameterTree.get(i);
			List<Object[]> list2 = parameterTree2.get(i);
			int j = 0;
			for(Object[] value : list) {
				Object[] value2 = list2.get(j);
				if (update) {
					int idx = 0;
					for (WEditor editor : editors) {
						if (editor.getGridField() == value[1]) {
							WEditor editor2 = null;
							if(editors2.get(idx) != null)
								editor2 = editors2.get(idx);
							addSearchParameter(editor, editor2);
							break;
						}
						idx++;
					}
				} else {
					addSelectionColumn((InfoColumnVO)value[0], (GridField)value[1], (GridField)value2[1]);
				}
				j++;
			}
		}
		
		if (checkAND == null) {
			if (parameterGrid.getRows() != null && parameterGrid.getRows().getFirstChild() != null) {
				Row row = (Row) parameterGrid.getRows().getLastChild();
				int col = getRowSize(row);
				if (col == getNoOfParameterColumns()) {
					row = new Row();
					parameterGrid.getRows().appendChild(row);
					col = 0;
				}
				while (col < getNoOfParameterColumns()-1) {
					row.appendChild(new Space());
					col++;
				}
				createAndCheckbox();
				row.appendChild(checkAND);
			}
		}
		evalDisplayLogic();
		if (!update)
			initParameters();
		
		for (WEditor editor : editors) {
			if (editor.getGridField() != null && DisplayType.isDate(editor.getGridField().getDisplayType())) {
				InfoColumnVO vo = findInfoColumnParameter(editor.getGridField());
				if (vo == null) continue;
				if (X_AD_InfoColumn.QUERYOPERATOR_LeEq.equals(vo.getQueryOperator())) {
					for (WEditor editor1 : editors) {
						if (editor1 == editor || editor1.getGridField() == null)
							continue;
						InfoColumnVO vo1 = findInfoColumnParameter(editor1.getGridField());
						if (vo1 == null) continue;
						if (X_AD_InfoColumn.QUERYOPERATOR_GtEq.equals(vo1.getQueryOperator()) && editor1.getGridField().getColumnName().equals(editor.getGridField().getColumnName())) {
							DateRangeButton drb = new DateRangeButton(editor1, editor);
							editor.getComponent().getParent().appendChild(drb);
							break;
						}
					}
				}
			}
		}
		
		if (!isAutoComplete)
			dynamicDisplay(null);
	}

	/**
	 * Get number of children from the row except Menupopup
	 * @param row
	 * @return
	 */
	private int getRowSize(Row row) {
		int cnt = 0;
		for (Component comp : row.getChildren()) {
			if (! (comp instanceof Menupopup || comp instanceof DateRangeButton) )
				cnt++;
		}
		return cnt;
	}

	/**
	 * evaluate display logic for input parameters
	 */
	protected void evalDisplayLogic() {
		int idx = 0;
		for(WEditor editor : editors) {
			WEditor editor2 = editors2.get(idx);
        	if (editor.getGridField() != null && !editor.getGridField().isDisplayed(true)) {        		
        		editor.getComponent().setVisible(false);
        		if(editor2 != null)
        			editor2.getComponent().setVisible(false);
        		if (editor.getLabel() != null)
        			editor.getLabel().setVisible(false);
        	}
        	else if (!editor.getComponent().isVisible()) {
        		editor.getComponent().setVisible(true);
        		if(editor2 != null)
        			editor2.getComponent().setVisible(true);
        		if (editor.getLabel() != null)
        			editor.getLabel().setVisible(true);
        	}
        	idx++;
        }
		
	}
	
	/**
     *  Add Selection Column to first Tab
	 *  @param infoColumn 
     *  @param mField field
     */
    protected void addSelectionColumn(InfoColumnVO infoColumn, GridField mField, GridField mField2)
    {
        int displayLength = mField.getDisplayLength();
        if (displayLength <= 0 || displayLength > FIELDLENGTH)
            mField.setDisplayLength(FIELDLENGTH);
        else
            displayLength = 0;

        //  Editor
        WEditor editor = null;
        WEditor editor2 = null;
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
	        ZKUpdateUtil.setWidth((HtmlBasedComponent) editor.getComponent(), "100%");
	        if (editor instanceof WTableDirEditor)
	        {
	        	((WTableDirEditor) editor).setRetainSelectedValueAfterRefresh(false);
	        }
	        if(infoColumn.isRange()) {
	        	editor2 = WebEditorFactory.getEditor(mField2, false);
		        editor2.setReadWrite(true);
		        editor2.dynamicDisplay();
		        editor2.addValueChangeListener(this);
		        editor2.fillHorizontal();
		        if (DisplayType.isDate(mField.getDisplayType())) {
		        	// give space for the Date Range button
			        ZKUpdateUtil.setWidth((HtmlBasedComponent) editor.getComponent(), "44%");
			        ZKUpdateUtil.setWidth((HtmlBasedComponent) editor2.getComponent(), "44%");
		        } else {
			        ZKUpdateUtil.setWidth((HtmlBasedComponent) editor.getComponent(), "50%");
			        ZKUpdateUtil.setWidth((HtmlBasedComponent) editor2.getComponent(), "50%");
		        }
	        }
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

        addSearchParameter(editor, editor2);
        
        editors.add(editor);
        editors2.add(editor2);
        if (infoColumn.isQueryAfterChange()) {
        	queryAfterChangeEditors.add(editor);
        }
        
        editor.showMenu();
        
        if (infoColumn.isIdentifier()) {
        	identifiers.add(editor);
        }

        fieldEditor.addEventListener(Events.ON_OK, this);		

        mField.addPropertyChangeListener(editor);
        mField.setValue(mField.getDefaultForPanel(), true);
        editor.fireValueChange(new ValueChangeEvent(editor, mField.getColumnName(), mField.getOldValue(), mField.getValue()));
        
        if(infoColumn.isRange()) {
        	mField2.addPropertyChangeListener(editor2);
        	mField2.setValue(mField2.getDefaultForPanel(), true);
        	editor2.fireValueChange(new ValueChangeEvent(editor2, mField2.getColumnName(), mField2.getOldValue(), mField2.getValue()));
        }

    }   // addSelectionColumn

    /**
     * add search parameter
     * @param editor
     * @param editor2
     */
	protected void addSearchParameter(WEditor editor, WEditor editor2) {
		Label label = editor.getLabel();
		Component fieldEditor = editor.getComponent();
		Component fieldEditor2 = null;
		
		if(editor2 != null)
			fieldEditor2 = editor2.getComponent();
		
		Row panel = null;
        if (parameterGrid.getRows().getChildren().isEmpty())
        {
        	panel = new Row();
        	parameterGrid.getRows().appendChild(panel);
        }
        else
        {
        	panel = (Row) parameterGrid.getRows().getLastChild();
        	if (getRowSize(panel) == getNoOfParameterColumns())
        	{
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
        outerParent.setStyle("display: flex;");
        outerParent.appendChild(fieldEditor);
        if(fieldEditor2 != null) {
            outerParent.setStyle("display: flex; flex-wrap: wrap;");
        	outerParent.appendChild(fieldEditor2);
        	if(editor.getGridField() != null && DisplayType.isDate(editor.getGridField().getDisplayType())) {
        		DateRangeButton drb = (new DateRangeButton(editor, editor2));
        		outerParent.appendChild(drb);
        	}
        	if (fieldEditor instanceof InputElement && fieldEditor2 instanceof InputElement) {
        		((InputElement)fieldEditor).setPlaceholder(Msg.getMsg(Env.getCtx(), "From"));
        		((InputElement)fieldEditor2).setPlaceholder(Msg.getMsg(Env.getCtx(), "To"));
        	} else if (fieldEditor instanceof NumberBox && fieldEditor2 instanceof NumberBox) {
        		((NumberBox)fieldEditor).getDecimalbox().setPlaceholder(Msg.getMsg(Env.getCtx(), "From"));
        		((NumberBox)fieldEditor2).getDecimalbox().setPlaceholder(Msg.getMsg(Env.getCtx(), "To"));
        	}
        }
        panel.appendChild(outerParent);
	}

	/**
	 * 
	 * @return number of columns for parameter grid
	 */
	protected int getNoOfParameterColumns() {
		if (ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1))
			return 2;
		else if (ClientInfo.maxWidth(ClientInfo.MEDIUM_WIDTH-1))
			return 4;
		else
			return 6;
	}

	/**
	 * create checkbox for AND
	 */
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
	
	/**
	 * 
	 * @param columnName
	 * @return column index, -1 if not found
	 */
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
		String orderClause = getUserOrderClause();
        StringBuilder sql = new StringBuilder (m_sqlMain);
        
        // add dynamic WHERE clause
        if (dynWhere.length() > 0)
            sql.append(dynWhere);   //  includes first AND
        
        // trim trailing WHERE statement
        if (sql.toString().trim().endsWith("WHERE")) {
        	int index = sql.lastIndexOf(" WHERE");
        	sql.delete(index, sql.length());
        }
        dataSql = Msg.parseTranslation(Env.getCtx(), sql.toString());    //  Variables
        dataSql = MRole.getDefault().addAccessSQL(dataSql, getTableName(),
            MRole.SQL_FULLYQUALIFIED, MRole.SQL_RO);
        
        // add other SQL clause
        String otherClause = getOtherClauseParsed();
        if (otherClause.length() > 0) {
        	dataSql = dataSql + " " + otherClause;
        }
        // add ORDER BY clause
        dataSql = dataSql + orderClause;

        // for SELECT DISTINCT, ORDER BY expressions must appear in select list - applies for lookup columns and multiselection columns
        if(dataSql.startsWith("SELECT DISTINCT") && indexOrderColumn > 0) {
        	ColumnInfo orderColumnInfo = p_layout[indexOrderColumn];
        	if (DisplayType.isLookup(orderColumnInfo.getAD_Reference_ID()) || DisplayType.isChosenMultipleSelection(orderColumnInfo.getAD_Reference_ID())) {
        		dataSql = appendOrderByToSelectList(dataSql, orderClause);
        	}
        }

        if (end > start && isUseDatabasePaging() && DB.getDatabase().isPagingSupported())
        {
        	dataSql = DB.getDatabase().addPagingSQL(dataSql, getCacheStart(), getCacheEnd());
        }
		return dataSql;
	}

    /**
     * Append ORDER BY expressions into the select list
     * @param sql
     * @param orderBy
     * @return sql with order by
     */
    private String appendOrderByToSelectList(String sql, String orderBy) {
    	if(Util.isEmpty(orderBy))
    		return sql;
		int idxFrom = getIdxFrom(sql);
		if(idxFrom < 0)
			return sql;
	
		String select = sql.substring(0, idxFrom);
		select += ", " + orderBy.replaceFirst("\\s+ORDER BY\\s+", "").replaceAll("\\s+ASC\\s+", "").replaceAll("\\s+DESC\\s+", "");	// \s+ stands for one or more whitespace character
		return select + sql.substring(idxFrom);
    }

    /**
     * Get the index of the FROM keyword
     * @param sql
     * @return index of the FROM keyword
     */
    private int getIdxFrom(String sql) {
		int parenthesisLevel = 0;
		int idxSelect = sql.indexOf("SELECT DISTINCT");
		sql = sql.substring(idxSelect);
	
		for(int i = 0; i < sql.length(); i++) {
			// identify and ignore sub-query
			char c = sql.charAt(i);
				if (c == ')')
					parenthesisLevel--;
				else if (c == '(')
					parenthesisLevel++;
	
				// RegEx ^(\s+FROM)(\s) checks for <whitespace>FROM<whitespace> pattern
				if(sql.substring(i, i+6).toUpperCase().matches("^(\\s+FROM)(\\s)") && parenthesisLevel == 0)
					return i;
		}
	
		return -1;
    }

    private String getOtherClauseParsed() {
    	String otherClause = "";
        if (infoWindow != null && infoWindow.getOtherClause() != null && infoWindow.getOtherClause().trim().length() > 0) {
        	otherClause = infoWindow.getOtherClause();
        	if (otherClause.indexOf("@") >= 0) {
        		String s = Env.parseContext(infoContext, p_WindowNo, otherClause, true, false);
        		if (s.length() == 0) {
        			log.severe("Failed to parse other clause. " + otherClause);
        		} else {
        			otherClause = s;
        		}
        	}
        }
    	return otherClause;
	}

	@Override
    protected void executeQuery() {
    	if (!isRequeryByRunSuccessProcess)
    		prepareTable();
    	super.executeQuery();
    	cacheOriginalValues.clear(); // F3P: Clear original values
    	if (ClientInfo.maxHeight(ClientInfo.SMALL_HEIGHT-1) ||
    		ClientInfo.maxWidth(ClientInfo.SMALL_WIDTH-1)) {
    		layout.getNorth().setOpen(false);
    		LayoutUtils.addSclass("slide", layout.getNorth());
    	}
    	if (autoCollapsedParameterPanel && m_count > 0) {
    		layout.getNorth().setOpen(false);
    	}
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
            	paraCtxValues.put(editor.getColumnName(), "");
            } else if (evt.getNewValue() instanceof Boolean) {
            	Env.setContext(infoContext, p_WindowNo, editor.getColumnName(), (Boolean)evt.getNewValue());
            	Env.setContext(infoContext, p_WindowNo, Env.TAB_INFO, editor.getColumnName(), (Boolean)evt.getNewValue());
            	paraCtxValues.put(editor.getColumnName(), (Boolean)evt.getNewValue());
            } else if (evt.getNewValue() instanceof Timestamp) {
            	Env.setContext(infoContext, p_WindowNo, editor.getColumnName(), (Timestamp)evt.getNewValue());
            	Env.setContext(infoContext, p_WindowNo, Env.TAB_INFO+"|"+editor.getColumnName(), (Timestamp)evt.getNewValue());
            	paraCtxValues.put(editor.getColumnName(), (Timestamp)evt.getNewValue());
            } else {
            	Env.setContext(infoContext, p_WindowNo, editor.getColumnName(), evt.getNewValue().toString());
            	Env.setContext(infoContext, p_WindowNo, Env.TAB_INFO, editor.getColumnName(), evt.getNewValue().toString());
            	paraCtxValues.put(editor.getColumnName(), evt.getNewValue().toString());
            }
            dynamicDisplay(editor);
            
            if (queryAfterChangeEditors != null && queryAfterChangeEditors.contains(editor)) {            	
            	Events.postEvent(ON_QUERY_AFTER_CHANGE, this, null);
            }
        }
		
	}

	/**
	 * Post query event if all editor with IsQueryAfterChange=True have been populated
	 */
	protected void postQueryAfterChangeEvent() {
		if (Executions.getCurrent().getAttribute(ON_USER_QUERY_ATTR) != null)
    		return;
		
		for (WEditor editor : queryAfterChangeEditors) {
			if (!editor.isVisible())
				continue;
			
			if (editor.getValue() == null) {
				Executions.getCurrent().setAttribute(ON_USER_QUERY_ATTR, Boolean.TRUE);
				onQueryCallback(null);
				return;
			}
		}
		
		onUserQuery();
	}

	/**
	 * @param editor
	 */
	protected void dynamicDisplay(WEditor editor) {
		validateField(editor);
		evalDisplayLogic();
		
		// if attribute set changed (from any value to any value) clear the attribute set instance m_pAttributeWhere
		boolean asiChanged = false;
		if (editor != null && editor instanceof WTableDirEditor && editor.getColumnName().equals("M_AttributeSet_ID"))
			asiChanged = true;
		
		int idx = 0;
		for(WEditor otherEditor : editors)
		{
			if(editors2.get(idx) != null) {
				if(editors2.get(idx) == editor) {
					idx++;
					continue;
				}	
				editors2.get(idx).dynamicDisplay();
			}
			idx++;
			if (otherEditor == editor) 
				continue;
			
			// reset value of WInfoPAttributeEditor to null when change M_AttributeSet_ID
			if (asiChanged && otherEditor instanceof WInfoPAttributeEditor)
				((WInfoPAttributeEditor)otherEditor).clearWhereClause();

			if (otherEditor.getGridField() != null)
				otherEditor.setMandatory(otherEditor.getGridField().isMandatory(true));

			otherEditor.dynamicDisplay();
		}
	}

	@Override
	public void onEvent(Event event)
    {
		if (event.getName().equals(Events.ON_FOCUS) && event.getTarget() != null && 
				event.getTarget().getAttribute(ATT_INFO_PROCESS_KEY) != null){
			
			MProcess process = (MProcess)event.getTarget().getAttribute(ATT_INFO_PROCESS_KEY);
			SessionManager.getAppDesktop().updateHelpTooltip(process.get_Translation(MProcess.COLUMNNAME_Name), process.get_Translation(MProcess.COLUMNNAME_Description), process.get_Translation(MProcess.COLUMNNAME_Help), null, process.getEntityType());
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
    			
        		SessionManager.getAppDesktop().updateHelpTooltip(selectedValue.get_Translation(MProcess.COLUMNNAME_Name), selectedValue.get_Translation(MProcess.COLUMNNAME_Description), selectedValue.get_Translation(MProcess.COLUMNNAME_Help), null, null);
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
    		
    	} else if (event.getTarget().equals(confirmPanel.getButton(ConfirmPanel.A_REFRESH))) {
    		setMandatoryFieldsConstraint();
    		super.onEvent(event);
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
		int idx = 0;
		for (WEditor editor : editors) {
			resetParameters(editor);
			resetParameters(editors2.get(idx));
			idx++;
		}

		// init again parameter
		initParameters();

		// filter dynamic value
		dynamicDisplay(null);
		
		onQueryCallback (null);
		
		layout.invalidate();
	}
	
	/**
	 * 
	 * @param editor
	 */
	protected void resetParameters(WEditor editor) {
		if(editor == null)
			return;
		
		GridField gField = editor.getGridField();
		if (gField == null || !gField.isDisplayed()) {
			return;
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
	 * handle on client info event
	 */
	protected void onClientInfo() {
		int t = getNoOfParameterColumns();
		if (t > 0 && noOfParameterColumn > 0 && t != noOfParameterColumn) {
			layoutParameterGrid(true);
			this.invalidate();
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
		if (useQueryTimeoutFromSysConfig)
			queryTimeout = MSysConfig.getIntValue(MSysConfig.ZK_INFO_QUERY_TIME_OUT, 0, Env.getAD_Client_ID(Env.getCtx()));
		
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
		// IDEMPIERE-3521
		String otherClause = getOtherClauseParsed();
        if (otherClause.length() > 0) {
    		countSql = countSql + " " + otherClause;
        }
		
		countSql = "SELECT COUNT(*) FROM ( " + countSql + " ) a";			
		
		if (log.isLoggable(Level.FINER))
			log.finer(countSql);
		m_count = -1;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try
		{
			pstmt = DB.prepareStatement(countSql, null);
			if (queryTimeout > 0)
				pstmt.setQueryTimeout(queryTimeout);
			setParameters (pstmt, true);
			rs = pstmt.executeQuery();

			if (rs.next())
				m_count = rs.getInt(1);

		}
		catch (Exception e)
		{
			if (e instanceof SQLException && DB.getDatabase().isQueryTimeout((SQLException) e))
			{
				if (log.isLoggable(Level.INFO))
					log.log(Level.INFO, countSql, e);
				Dialog.error(p_WindowNo, INFO_QUERY_TIME_OUT_ERROR);
			}
			else
			{
				log.log(Level.SEVERE, countSql, e);
				Dialog.error(p_WindowNo, "DBExecuteError", e.getMessage());
			}
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
				Dialog.error(getWindowNo(), "InfoFindOverMax",
		                m_count + " > " + infoWindow.getMaxQueryRecords());
			}
	        m_count = 0;
		}

		return true;
	}	//	testCount

	/** 
	 * @return true if there is an 'IsActive' criteria 
	 */
	protected boolean hasIsActiveEditor() {
		for (WEditor editor : editors) {
			if (editor.getGridField() != null && "IsActive".equals(editor.getGridField().getColumnName())) {
				return true;
			}
		}
		return false;
	}

	/**
	 * author xolali IDEMPIERE-1045
	 * getInfoColumnslayout(MInfoWindow info)
	 * @param info
	 * @return list of {@link ColumnInfo}
	 */
	public ArrayList<ColumnInfo> getInfoColumnslayout(MInfoWindow info){

		TableInfo[] tableInfos = info.getTableInfos();

		MInfoColumn[] p_infoColumns = info.getInfoColumns(tableInfos);
		InfoColumnVO[] infoColumns = InfoColumnVO.create(Env.getCtx(), p_infoColumns);
		
		ArrayList<ColumnInfo> list = new ArrayList<ColumnInfo>();
		String keyTableAlias = tableInfos[0].getSynonym() != null && tableInfos[0].getSynonym().trim().length() > 0
				? tableInfos[0].getSynonym()
						: tableInfos[0].getTableName();

		String keySelectClause = keyTableAlias + "." + p_keyColumn;

		for (InfoColumnVO infoColumn : infoColumns)
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

					columnInfo = new ColumnInfo(infoColumn.getNameTrl(), colSQL, DisplayType.getClass(infoColumn.getAD_Reference_ID(), true));
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
						columnInfo = new ColumnInfo(infoColumn.getNameTrl(), colSQL, ValueNamePair.class, (String)null);
					}
					else
					{
						GridField field = getGridField(infoColumn);
						columnInfo = createLookupColumnInfo(tableInfos, field, infoColumn);
					}
				}
				else
				{
					columnInfo = new ColumnInfo(infoColumn.getNameTrl(), colSQL, DisplayType.getClass(infoColumn.getAD_Reference_ID(), true));
				}
				columnInfo.setColDescription(infoColumn.getDescriptionTrl());
				columnInfo.setGridField(getGridField(infoColumn));
				columnInfo.setAD_Reference_ID(infoColumn.getAD_Reference_ID());
				columnInfo.setAD_Reference_Value_ID(infoColumn.getAD_Reference_Value_ID());
				list.add(columnInfo);
			}

		}

		return   list;
	}

	/**
	 * reset to empty
	 * @param relatedInfo
	 */
	protected void reset(EmbedWinInfo relatedInfo){
		if (relatedInfo.getInfoTbl() != null){
			if (((WListbox)relatedInfo.getInfoTbl()).getModel() != null)
				((WListbox)relatedInfo.getInfoTbl()).getModel().clear();
			else
				((WListbox)relatedInfo.getInfoTbl()).clear();
		}
	}

	/**
	 * author xolali IDEMPIERE-1045
	 * GridField getGridField(InfoColumnVO infoColumn)
	 * @param infoColumn
	 * @return GridField
	 */
	protected GridField getGridField(InfoColumnVO infoColumn){
		String columnName = infoColumn.getColumnName();
		GridFieldVO vo = GridFieldVO.createParameter(infoContext, p_WindowNo, AEnv.getADWindowID(p_WindowNo), m_infoWindowID, 0,
				columnName, infoColumn.getNameTrl(), infoColumn.getAD_Reference_ID(),
				infoColumn.getAD_Reference_Value_ID(), false, false, infoColumn.getPlaceHolderTrl());
		if (infoColumn.getAD_Val_Rule_ID() > 0) {
			vo.ValidationCode = infoColumn.getValidationCode();
			if (vo.lookupInfo != null) {
				vo.lookupInfo.ValidationCode = vo.ValidationCode;
				vo.lookupInfo.IsValidated = false;
			}
		}
		vo.DisplayLogic = infoColumn.getDisplayLogic() != null ? infoColumn.getDisplayLogic() : "";
		String desc = infoColumn.getDescriptionTrl();
		vo.Description = desc != null ? desc : "";
		String help = infoColumn.getHelpTrl();
		vo.Help = help != null ? help : "";
		vo.AD_FieldStyle_ID = infoColumn.getAD_FieldStyle_ID();
		GridField gridField = new GridField(vo);

		return gridField;
	}

	
	/**
	 * {@inheritDoc}
	 * eval input value of mandatory field, if null show field in red color
	 */
	@Override
	public boolean validateParameters() {
		boolean isValid = true;
		
		for (int i = 0; i < editors.size(); i++){
			WEditor wEditor = editors.get(i);
			WEditor wEditor2 = editors2.get(i);
			// cancel editor not display
			if (wEditor == null || !wEditor.isVisible() || wEditor.getGridField() == null){
				continue;
			}
			
			isValid = isValid & validateField (wEditor);
			if(wEditor2 != null)
				isValid = isValid & validateField(wEditor2);
		}
		
		return isValid;
	}
	
	/**
	 * Validate mandatory fields.<br/>
	 * Display red color when a mandatory field is not fill.
	 * @param wEditor
	 * @return true if pass mandatory validation, false otherwise
	 */
	protected boolean validateField (WEditor wEditor){
		if (wEditor == null || !wEditor.isVisible() || wEditor.getGridField() == null){
			return true;
		}
		
		GridField validateGrid = wEditor.getGridField();
		// eval only mandatory field
		if (validateGrid.isMandatory(true)){
			// update color of field
			wEditor.updateStyle();
			Object data = wEditor.getValue();
			if (data == null || data.toString().length() == 0) {				
				return false;
			}
		}
		
		return true;		
	}
	
	@Override
	protected boolean hasNew() {
		if (isAutoComplete)
			return false;
		
		boolean hasNew = getADWindowID () > 0;
		if (hasNew && vqe == null && hasRightQuickEntry){
			GridWindow gridwindow = GridWindow.get(Env.getCtx(), -1, getADWindowID());
			hasRightQuickEntry = gridwindow != null;
			if (hasRightQuickEntry) {
				vqe = Extensions.getQuickEntry(p_WindowNo, 0, getADWindowID());
				if (vqe != null) {
					int windowNo = SessionManager.getAppDesktop().findWindowNo(vqe);
					if (windowNo > 0 && windowNo != p_WindowNo) {
						SessionManager.getAppDesktop().unregisterWindow(windowNo);
					}
				}
			}
			//clear gridWindow context
			if (gridwindow != null)
				Env.clearWinContext(-1);
		}
			
		return hasNew && vqe != null && vqe.isAvailableQuickEdit();
	}
	
	/**	
	 * Get id of window link with main table of this info window
	 * @return AD_Window_ID
	 */
	protected int getADWindowID() {
		if(infoWindow == null)
			return 0;
		String isSOTrx = Env.getContext(Env.getCtx(), p_WindowNo, "IsSOTrx");
		if (!isLookup() && Util.isEmpty(isSOTrx)) {
			isSOTrx = "Y";
		}

		if (infoWindow != null) {

			MUserDefInfo userDef = MUserDefInfo.getBestMatch(Env.getCtx(), infoWindow.getAD_InfoWindow_ID());

			if (userDef != null) {
				if (isSOTrx.equals("N") && userDef.getPO_Window_ID() > 0)
					return userDef.getPO_Window_ID();
				if (userDef.getAD_Window_ID() > 0)
					return userDef.getAD_Window_ID();
			}

			if (isSOTrx.equals("N") && infoWindow.getPO_Window_ID() > 0)
				return infoWindow.getPO_Window_ID();
			if (infoWindow.getAD_Window_ID() > 0)
				return infoWindow.getAD_Window_ID();
		}

		return super.getAD_Window_ID(MTable.getTableName(Env.getCtx(), infoWindow.getAD_Table_ID()), isSOTrx.equalsIgnoreCase("Y"));
	}
	
	@Override
	protected void newRecordAction() {
		// each time close WQuickEntry dialog, 
		// window is  un-registry, variable environment of this window as _QUICK_ENTRY_MODE_ is removed
		// so if reuse WQuickEntry will let some field in child tab init at read only state
		AbstractWQuickEntry vqe = Extensions.getQuickEntry(0, 0, getADWindowID());
		
		vqe.loadRecord (0);								
		
		final ISupportMask parent = LayoutUtils.showWindowWithMask(vqe, this, LayoutUtils.OVERLAP_SELF);
		
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

	/** 
	 * Allow to show or hide the sub panel (detail) programmatically
	 * @param visible 
	 */
	protected void setSouthVisible(boolean visible) {
		Component comp = layout.getCenter();
		for (Component c : comp.getChildren()) {
			if (c instanceof Borderlayout) {
				for (Component c1 : c.getChildren()) {
					if (c1 instanceof South) {
						c1.setVisible(visible);
						break;
					}
				}
			}
		}
	}
	
	// Edit Callback method and original values management
	/**
	 * 
	 * @param row
	 * @param editingColumn
	 * @param editingValue
	 * @return {@link Properties}
	 */
	public Properties getRowaAsCtx(int row, int editingColumn, Object editingValue)
	{
		ListModelTable model = contentPanel.getModel();
		Properties ctx = new Properties(Env.getCtx()); // Allow session values
		
		// Parameter editors
		
		for(WEditor e:editors)
		{
			Object val = e.getValue();
			String column = e.getColumnName();
			
			if(val != null)
			{
				if(val instanceof Integer)
					Env.setContext(ctx, 0, column, (Integer)val);
				else if(val instanceof Timestamp)
					Env.setContext(ctx, 0, column, (Timestamp)val);
				else if(val instanceof Boolean)
					Env.setContext(ctx, 0, column, (Boolean)val);
				else
					Env.setContext(ctx, 0, column, val.toString());
			}
		}
		
		for(int i=0; i < p_layout.length; i++)			
		{			
			String column = p_layout[i].getColumnName();
					
			Object val = null;
			
			if(i != editingColumn)
				val = model.getValueAt(row, i);
			else
				val = editingValue;
			
			// Get id from 'complex' types
			
			if(val != null)
			{				
				if(val instanceof IDColumn)
				{
					IDColumn idc = (IDColumn)val;
					val = idc.getRecord_ID();
				}
				else if(val instanceof UUIDColumn)
				{
					UUIDColumn idc = (UUIDColumn)val;
					val = idc.getRecord_UU();
				}
				else if(val instanceof KeyNamePair)
				{
					KeyNamePair knp = (KeyNamePair)val;
					val = knp.getKey();
				}
								
				if(val instanceof Integer)
					Env.setContext(ctx, 0, column, (Integer)val);
				else if(val instanceof Timestamp)
					Env.setContext(ctx, 0, column, (Timestamp)val);
				else if(val instanceof Boolean)
					Env.setContext(ctx, 0, column, (Boolean)val);
				else
					Env.setContext(ctx, 0, column, val.toString());
			}				
		}
		
		return ctx;
	}
	
	/**
	 * 
	 * @param event
	 * @param rowIndex
	 * @param colIndex
	 * @param editor
	 * @param field
	 */
	public void onCellEditCallback(ValueChangeEvent event, int rowIndex, int colIndex, WEditor editor, GridField field)
	{		
		Object val = event.getNewValue();
	
		if(val != null && columnInfos[colIndex].getColClass().equals(KeyNamePair.class))
		{
			Integer iVal = (Integer)val;
			String 	display = editor.getDisplay();
			
			KeyNamePair kdc = new KeyNamePair(iVal, display);
			val = kdc;
		}
		
		InfoColumnVO infoColumn = infoColumns[colIndex - 1];
		boolean changeIsValid = true;
		String validationSQL = null;
		
		if(!Util.isEmpty(infoColumn.getInputFieldValidation(), true)) // Run validation
		{
			changeIsValid = false;
			
			Properties ctx = getRowaAsCtx(rowIndex, colIndex, val);
			
			String rawSQL = infoColumn.getInputFieldValidation(); 
			validationSQL = Env.parseContext(ctx, 0, rawSQL, false);
			
			try
			{
				List<List<Object>> errors = DB.getSQLArrayObjectsEx(null, validationSQL);
			
				if(errors != null && errors.size() > 0)
				{
					StringBuilder sbError = new StringBuilder();

					for(List<Object> line:errors)
					{
						if(line.size() > 0)
						{
							if(sbError.length() > 0)
								sbError.append('\n');
							
							sbError.append(line.get(0));
						}
					}
					
					String msg = Msg.translate(ctx, sbError.toString());
					Dialog.error(0, "ValidationError", msg);
				}
				else	
					changeIsValid = true;
			}
			catch(Exception e)
			{
				log.log(Level.SEVERE, "Error executing validation SQL: " + validationSQL, e);
				
				Dialog.error(0, "Error", validationSQL);
				changeIsValid = false;
			}
		}
		
		if(changeIsValid)
		{		
			// Editing a row delesects it, make sure it stays selected
			
			ListModelTable model = contentPanel.getModel();
			Object row = model.get(rowIndex);
			
			// Since the row object is a collection, we can update it safely, but the hash code will be different from the one stored
			// in the selection. So we need to remove and re-add the row after to keep the selection in sync
			
			model.removeFromSelection(row);
			contentPanel.setValueAt(val, rowIndex, colIndex);		
			model.addToSelection(row);
			
			Clients.resize(contentPanel);
		}
		else
		{
			editor.setValue(event.getOldValue());
		}
	}
	
	/**
	 * 
	 * @param rowIndex
	 */
	protected void restoreOriginalValues(int rowIndex)
	{
		Object viewIdKey = getColumnValue(rowIndex);
		
		if(cacheOriginalValues.containsKey(viewIdKey)) // Only cache if not cached to avoid caching subsequent modifications
		{
			int 				 colCount = contentPanel.getColumnCount();
			List<Object> row = cacheOriginalValues.get(viewIdKey);
			
			for(int i=1; i < colCount; i++) // Skip first row (selection)
			{
				Object val = row.get(i-1);
				contentPanel.setValueAt(val, rowIndex, i);
			}
		}
	}
	
	/**
	 * 
	 * @param rowIndex
	 */
	protected void cacheOriginalValues(int rowIndex)
	{
		Object viewIdKey = getColumnValue(rowIndex);
		
		if(cacheOriginalValues.containsKey(viewIdKey) == false) // Only cache if not cached to avoid caching subsequent modifications
		{
			int colCount = contentPanel.getColumnCount();
			List<Object> row = new ArrayList<>();
			
			for(int i=1; i < colCount; i++) // Skip first row (selection)
			{
				Object val = contentPanel.getValueAt(rowIndex, i);
				row.add(val);
			}
			
			cacheOriginalValues.put(viewIdKey, row);
		}
	}
		
	@Override
	public void tableChanged(WTableModelEvent event)
	{
		// Manage cache of values
		
		if(hasEditable && event.getColumn() == 0)
		{
			for(int row=event.getFirstRow(); row <= event.getLastRow(); row++)
			{
				Object col0 = contentPanel.getValueAt(row, 0);
				
				if(col0 instanceof SelectableIDColumn)
				{
					SelectableIDColumn idc = (SelectableIDColumn)col0;

					if(idc.isSelected())
					{
						cacheOriginalValues(row);
					}
					else
					{
						restoreOriginalValues(row);
					}
				}
			}
			
			Clients.resize(contentPanel);
		}

		super.tableChanged(event);
	}
	
	@Override
	public void onQueryCallback(Event event)
	{
		super.onQueryCallback(event);
		
		enableExportButton();
	}
		
	
	@Override
	protected void updateListSelected()
	{
		if(hasEditable)
		{
			temporarySelectedData = new HashMap<>();
			
			// The list contents (rows) will be cleared during query, so we need a backup to restore the in-edit data
			
			ListModelTable model = contentPanel.getModel();
			
			for(int rowIndex:contentPanel.getSelectedIndices())
			{
				Object keyViewValue = getColumnValue(rowIndex);
				@SuppressWarnings("unchecked")
				List<Object> row = (List<Object>)model.get(rowIndex);
				
				ArrayList<Object> clonedRow = new ArrayList<>(row);				
				temporarySelectedData.put(keyViewValue, clonedRow);
			}
			
			for(Entry<Object, List<Object>> entry: recordSelectedData.entrySet())
			{
				ArrayList<Object> clonedRow = new ArrayList<>(entry.getValue());				
				temporarySelectedData.put(entry.getKey(), clonedRow);
			}						
		}		

		super.updateListSelected();
	}

	@Override
	protected void restoreSelectedInPage()
	{
		super.restoreSelectedInPage();
		
		if(temporarySelectedData != null)
		{
			temporarySelectedData.clear();
			temporarySelectedData = null;
		}		
	}


	@Override
	public boolean onRestoreSelectedItemIndexInPage(Object keyViewValue, int rowIndex, Object oRow)
	{
		if(hasEditable && temporarySelectedData != null)
		{
			
			cacheOriginalValues(rowIndex);
			
			@SuppressWarnings("unchecked")
			List<Object> row = (List<Object>)oRow;
			List<Object> originalSelectedRow = temporarySelectedData.get(keyViewValue);
			ListModelTable model = contentPanel.getModel();
			
			// While restoring values we don't want to trigger listeners
			model.removeTableModelListener(this);
			
			if (originalSelectedRow != null)
			{
				for(int i=0; i < columnInfos.length; i++)
				{
					if(columnInfos[i].isReadOnly() == false) // Only replace editable column, in case some other data changed on db
					{
						Object obj = originalSelectedRow.get(i);
						model.setValueAt( obj, rowIndex, i);
					}
				}
			}
			
			// Restore isSelected status on IDColumn
			Object id = row.get(0);
			if(id instanceof IDColumn)
			{
				IDColumn idc = (IDColumn)id;
				idc.setSelected(true);
			}
			else if (id instanceof UUIDColumn)
			{
				UUIDColumn idc = (UUIDColumn)id;
				idc.setSelected(true);
			}
			
			// Restore listeners
			model.addTableModelListener(this);
		}

		return super.onRestoreSelectedItemIndexInPage(keyViewValue, rowIndex, oRow);
	}
	
	// F3P: Export function
	/**
	 * init export button
	 */
	protected void initExport()
	{
	    exportButton = ButtonFactory.createNamedButton("Export", false, true);        
	    exportButton.setId("Export");
	    exportButton.setEnabled(false);       
	    exportButton.addEventListener(Events.ON_CLICK, new XlsxExportAction());
	
	    confirmPanel.addComponentsLeft(exportButton);
	}

	/**
	 * enable/disable export button
	 */
	protected void enableExportButton()
	{
		if(exportButton == null)
			return;
		
		exportButton.setEnabled(contentPanel.getRowCount() > 0);		
	}

	/**
	 * Return (if exists) the editor with the name
	 * @param columnName
	 * @return editor
	 */
	public WEditor getEditor(String columnName) {
		for (WEditor editor : editors) {
			if (editor.getGridField() != null && editor.getGridField().getColumnName().equals(columnName))
				return editor;
		}
		return null;
	}

	/**
	 * Return (if exists) the index of the column in the grid
	 * @param columnName
	 * @return index of the column
	 */
	public int getColumnIndex(String columnName) {
		for (int i = 0; i < contentPanel.getColumnCount(); i++) {
			if (p_layout[i].getGridField() != null && p_layout[i].getGridField().getColumnName().equals(columnName))
				return i;
		}
		return -1;
	}

	private class XlsxExportAction implements EventListener<Event>
	{		
		@Override
		public void onEvent(Event evt) throws Exception
		{
			if(evt.getTarget() == exportButton)
			{
				XlsxExporter exporter = new XlsxExporter();
				
				exporter.doExport();
			}
		}
	}
	
	private class XlsxExporter extends AbstractXLSXExporter
	{
		private ResultSet m_rs = null;
		private int rowCount = -1;
		private int currentRow = -1;
		
		public void doExport() throws Exception
		{
			int originalCount = m_count;
			
			String dataSql = buildDataSQL(0, 0);
			
			File file = File.createTempFile(infoWindow.get_Translation("Name")+"_", ".xlsx");
			
			testCount();
			
			rowCount = m_count;
			m_count = originalCount;				
			
			if(rowCount > 0)
			{
				PreparedStatement pstmt = null;
				Trx trx = null;
				
				try
				{
					String trxName = Trx.createTrxName("InfoPanelLoad:");
					trx  = Trx.get(trxName, true);
					trx.setDisplayName(getClass().getName()+"_exportXlsx");
					pstmt = DB.prepareStatement(dataSql, trxName);
					setParameters (pstmt, false);	//	no count

					pstmt.setFetchSize(100);
					m_rs = pstmt.executeQuery();

					export(file, null);
				}
				catch(SQLException e)
				{
					log.log(Level.SEVERE, dataSql, e);
				}
				finally
				{
					DB.close(m_rs, pstmt);
					trx.close();
					
					m_rs = null;
					currentRow = -1;
				}
				
				AMedia media = new AMedia(file.getName(), null, Medias.EXCEL_XML_MIME_TYPE, file, true);
				IMediaView view = Extensions.getMediaView(Medias.EXCEL_XML_MIME_TYPE, Medias.EXCEL_XML_FILE_EXT, ClientInfo.isMobile());
				Map<MAuthorizationAccount, IUploadService> uploadServicesMap = MAuthorizationAccount.getUserUploadServices();
				if (view != null || uploadServicesMap.size() > 0) {				
					WMediaOptions options = new WMediaOptions(media, view != null ? () -> {
						Window viewWindow = new Window();
						viewWindow.setWidth("100%");
						viewWindow.setHeight("100%");
						viewWindow.setTitle(media.getName());
						viewWindow.setAttribute(Window.MODE_KEY, Mode.EMBEDDED);
						AEnv.showWindow(viewWindow);
						view.renderMediaView(viewWindow, media, false);
					} : null, uploadServicesMap);
					options.setPage(getPage());
					options.doHighlighted();
				} else {
					Filedownload.save(media);
				}
			}			
		}

		@Override
		public boolean isFunctionRow()
		{
			return false;
		}

		@Override
		public int getColumnCount()
		{			
			return columnInfos.length;
		}

		@Override
		public int getRowCount()
		{
			return rowCount;
		}

		@Override
		protected void setCurrentRow(int row)
		{
			if(row > currentRow)
			{
				try
				{
					m_rs.next();
					currentRow = row;
				}
				catch(SQLException e)
				{
					throw new AdempiereException(e);
				}
			}
		}

		@Override
		protected int getCurrentRow()
		{
			return currentRow;
		}

		@Override
		public boolean isColumnPrinted(int col)
		{
			return (columnInfos[col].getGridField() != null);
		}

		@Override
		public String getHeaderName(int col)
		{			
			return columnInfos[col].getColHeader();
		}

		@Override
		public int getDisplayType(int row, int col)
		{
			int displayType = -1;
			GridField gridField = columnInfos[col].getGridField();
			displayType = gridField.getDisplayType();
						
			return displayType;
		}

		@Override
		public Object getValueAt(int row, int col)
		{
			Object val = null;

			int columnIndex = 1;
			int colFound = 0;
			for (int idx = 0; idx < getColumnCount(); idx++) {
				if (isColumnPrinted(idx)) {
					columnIndex++;
					colFound++;
					if (colFound >= col) {
						break;
					}
					if (columnInfos[idx].isKeyPairCol()) {
						columnIndex++;
					}
				}
			}

			try
			{
				val = m_rs.getObject(columnIndex);
				if (columnInfos[col].isKeyPairCol()) {
					m_rs.getObject(columnIndex+1);
					if (m_rs.wasNull()) {
						val = null;
					}
				}
			}
			catch(SQLException e)
			{
				throw new AdempiereException(e);
			}
			
			if(val != null && !columnInfos[col].isKeyPairCol() 
					&& columnInfos[col].getGridField().getLookup() != null)
			{
				Lookup lookup = columnInfos[col].getGridField().getLookup();
				if (lookup != null)
				{
					val = lookup.getDisplay(val);
				}
			} 
			
			return val; 
		}

		@Override
		public boolean isPageBreak(int row, int col)
		{
			return false;
		}

		@Override
		public boolean isDisplayed(int row, int col)
		{
			return true;
		}	
	}

	/**
	 * That method will search at all Editors to validate if it is mandatory and has
	 * to be provided by user.
	 */
	private void setMandatoryFieldsConstraint() {

		int index = 0;
		for (WEditor editorFrom : editors) {
			WEditor editorTo = editors2.get(index++);

			if (editorFrom.isMandatory() && editorFrom.getValue() == null)
				throw new WrongValueException(editorFrom.getComponent(), Msg.getMsg(Env.getCtx(), "Missing required parameters"));

			if (editorTo != null && editorTo.isMandatory() && editorTo.getValue() == null)
				throw new WrongValueException(editorTo.getComponent(), Msg.getMsg(Env.getCtx(), "Missing required parameters"));
				
		}
	}

}
