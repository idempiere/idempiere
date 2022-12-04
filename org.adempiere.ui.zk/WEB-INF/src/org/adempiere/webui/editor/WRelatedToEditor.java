package org.adempiere.webui.editor;

import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;

import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.ToolBarButton;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.GridTabDataBinder;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.MColumn;
import org.compiere.model.MQuery;
import org.compiere.model.MSysConfig;
import org.compiere.model.MTable;
import org.compiere.model.PO;
import org.compiere.model.Query;
import org.compiere.model.StateChangeEvent;
import org.compiere.model.StateChangeListener;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Div;
import org.zkoss.zul.Vlayout;

public class WRelatedToEditor extends WEditor implements ContextMenuListener, IZoomableEditor, StateChangeListener {

	private static final CLogger log = CLogger.getCLogger(WRelatedToEditor.class);
	
	private boolean m_ReadWrite;
	private Object oldValue;
	private Object value;
	private Object oldTableID;
	private GridTabDataBinder dataBinder;
	
	private GridField tableIDGridField;
	private WEditor tableIDEditor;
	
	private Div wrapperDiv;
	private Combobox recordsCombobox;
	private ToolBarButton okButton;
	private ToolBarButton editButton;
	
	private String editorMode = EDITOR_MODE_EDIT;
	
	protected String selectedTableName = "";
	protected String selectedRecordIdentifyer = "";
	
	private static final String IMAGES_CONTEXT_OK_PNG = "images/Ok16.png";
	private static final String IMAGES_CONTEXT_EDIT_RECORD_PNG = "images/EditRecord16.png";
	
	private static final String EDITOR_MODE_EDIT = "e";
	private static final String EDITOR_MODE_SAVED = "s";

	public WRelatedToEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
		super(new Vlayout(), gridField, tableEditor, editorConfiguration);
		init();
	}
	
	private void init() {
		log.warning("----------");

		wrapperDiv = new Div();
		wrapperDiv.setStyle("display: flex;");
		wrapperDiv.setParent(this.getComponent());

		if(gridTab != null) {
			gridTab.addStateChangeListener(this);
			tableIDGridField = gridTab.getField("AD_Table_ID");
			tableIDEditor = WebEditorFactory.getEditor(tableIDGridField, true);
			if(tableIDGridField.getValue() != null)
				tableIDEditor.setValue(tableIDGridField.getValue());
			
			tableIDGridField.addPropertyChangeListener(tableIDEditor);
			this.dataBinder = new GridTabDataBinder(gridTab);
			tableIDEditor.addValueChangeListener(dataBinder);
			tableIDGridField.addPropertyChangeListener(new PropertyChangeListener() {
	
				@Override
				public void propertyChange(PropertyChangeEvent evt) {
					if(evt.getNewValue() != oldTableID) {
						oldTableID = evt.getNewValue();
						initRecords();
						recordsCombobox.setValue(value);
					}
				}
			});
			tableIDEditor.getComponent().addEventListener(Events.ON_SELECT, this);
			wrapperDiv.appendChild(tableIDEditor.getComponent());
			oldTableID = tableIDGridField.getValue();
		}
		
		
		recordsCombobox = new Combobox();
		recordsCombobox.setAutocomplete(true);
		recordsCombobox.setAutodrop(true);
		recordsCombobox.setParent(wrapperDiv);
		recordsCombobox.addEventListener(Events.ON_SELECT, this);
		initRecords();
		
		okButton = new ToolBarButton();
		if (ThemeManager.isUseFontIconForImage())
			okButton.setIconSclass("z-icon-Ok");
		else
			okButton.setImage(ThemeManager.getThemeResource(IMAGES_CONTEXT_OK_PNG));
		okButton.setParent(wrapperDiv);
		okButton.addEventListener(Events.ON_CLICK, this);
		
		editButton = new ToolBarButton();
		if (ThemeManager.isUseFontIconForImage())
			editButton.setIconSclass("z-icon-Edit");
		else
			editButton.setImage(ThemeManager.getThemeResource(IMAGES_CONTEXT_EDIT_RECORD_PNG));
		editButton.setParent(wrapperDiv);
		editButton.addEventListener(Events.ON_CLICK, this);
		
		if (gridField != null) 
        {
        	popupMenu = new WEditorPopupMenu(true, true, isShowPreference());
        	popupMenu.addMenuListener(this);
        	addChangeLogMenu(popupMenu);
        }
		updateUI(EDITOR_MODE_SAVED);
		setMandatory();
	}
	
	private void updateUI(String displayMode) {
		if(editorMode.equalsIgnoreCase(displayMode))
			return;
		if(tableIDEditor == null)
			displayMode = EDITOR_MODE_SAVED;
		
		if(displayMode.equalsIgnoreCase(EDITOR_MODE_SAVED)) {
			if(tableIDEditor != null)
				tableIDEditor.setVisible(false);
			recordsCombobox.setWidth("100%");
			recordsCombobox.setReadonly(true);
			recordsCombobox.setButtonVisible(false);
			okButton.setVisible(false);
			editButton.setVisible(true);
		}
		else if(displayMode.equalsIgnoreCase(EDITOR_MODE_EDIT)) {
			tableIDEditor.setVisible(true);
			recordsCombobox.setWidth("60%");
			recordsCombobox.setReadonly(false);
			recordsCombobox.setButtonVisible(true);
			okButton.setVisible(true);
			editButton.setVisible(false);
		}
		editorMode = displayMode;
	}
	
	public void actionRefresh(Object value)
    {    	
		log.warning("----------");
		setValue(value);
    }
	
	@Override
	public void actionZoom()
	{
		log.warning("----------");
    	MTable savedTable = new MTable(Env.getCtx(), (Integer) tableIDGridField.getValue(), null);
    	
    	String[] keyColumns = savedTable.getKeyColumns();
    	String keyColumn = null;
    	if(keyColumns.length > 0) {
    		keyColumn = keyColumns[0];	//	guess
    	}
    	
    	String where = keyColumn + "=" + gridTab.getValue("Record_ID");
    	PO po = new Query(Env.getCtx(), savedTable, where, null).first();
    	int AD_Window_ID = savedTable.getAD_Window_ID();
    	
		if (AD_Window_ID > 0) {	
	    	if(!Util.isEmpty(keyColumn)) {
				MQuery zoomQuery = new MQuery();
				zoomQuery.addRestriction(keyColumn, MQuery.EQUAL, (Integer)po.get_Value(keyColumn));
				zoomQuery.setRecordCount(1);	//	guess
				
		    	AEnv.zoom(AD_Window_ID, zoomQuery);
	    	}
		}
	}
	
	@Override
	public void onMenu(ContextMenuEvent evt) 
	{
		log.warning("----------");
		if (WEditorPopupMenu.REQUERY_EVENT.equals(evt.getContextEvent()))
		{
			actionRefresh(oldValue);
		}
		else if (WEditorPopupMenu.ZOOM_EVENT.equals(evt.getContextEvent()))
		{
			actionZoom();
		}
		else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		} 
		else if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()))
		{
			if (isShowPreference())
				ValuePreference.start (getComponent(), gridField, getValue());
		}
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		log.warning("----------");
		m_ReadWrite = readWrite;
		if (gridField != null && gridTab != null && recordsCombobox != null) {
			for (Comboitem item : recordsCombobox.getItems()) {
				item.setDisabled(!readWrite);
			}
		}
	}

	@Override
	public boolean isReadWrite() {
		log.warning("----------");
		return m_ReadWrite;
	}

	public  void propertyChange(PropertyChangeEvent evt)
	{
		if ("FieldValue".equals(evt.getPropertyName()))
		{
			setValue(evt.getNewValue());
		}
	}
	
	@Override
	public void setValue(Object value) {
		log.warning("----------");
		this.value = value;
		if (value == null || value.toString().trim().length() == 0)
    	{
    		oldValue = null;
    		value = null;
    		recordsCombobox.setValue(null);
    	}
		else {
			if(oldTableID != tableIDGridField.getValue()) {
				initRecords();
				oldTableID = tableIDGridField.getValue();
			}
			recordsCombobox.setValue(value);
			if(!recordsCombobox.isSelected(value)) {
				recordsCombobox.setValue(null);
			}
		}

			ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, value);
	        super.fireValueChange(changeEvent);
			oldValue = value;
//		}
		
	}

	@Override
	public Object getValue() {
		log.warning("----------");
		Object retVal = null;
        Comboitem selItem = recordsCombobox.getSelectedItem();
        if (selItem != null)
        {
            retVal = selItem.getValue();
            if ((retVal instanceof Integer) && (Integer)retVal == -1)
            	retVal = null;
            else if ((retVal instanceof String) && "".equals(retVal))
            	retVal = null;
        }
        return retVal;
	}

	@Override
	public String getDisplay() {
		log.warning("----------");
		if(((Integer) tableIDGridField.getValue() != null) && ((Integer) gridField.getValue() != null))
			return getIdentifierColumns((Integer) tableIDGridField.getValue(), (Integer) gridField.getValue());
		else
			return "";
	}
	
	@Override
    public String getDisplayTextForGridView(Object value) {
		String s = "";
		if(gridField.getValue().equals(value)) {
			this.setValue(value);
			s = getDisplay();
			if ("<0>".equals(s)) {
	    		s = "";
	    	}
		}
		else {
			this.setValue(value);
			s = "<"+value+">";
		}
    	return s;
    }

	@Override
	public void onEvent(Event event) throws Exception {
		log.warning("----------");
		if(event.getName().equalsIgnoreCase(Events.ON_SELECT)) {
			if (event.getTarget().equals(tableIDEditor.getComponent())) {
				initRecords();
				this.setValue(null);
			}
			else if (event.getTarget().equals(recordsCombobox)) {
				
				Comboitem selectedItem = recordsCombobox.getSelectedItem();
				if(selectedItem != null)
					setValue(selectedItem.getValue());
			}
		}
		if(event.getName().equalsIgnoreCase(Events.ON_CLICK)) {
			if(event.getTarget().equals(okButton)) {
				
				if(recordsCombobox.getSelectedItem() == null) {
					recordsCombobox.setStyle("color:red;");
					recordsCombobox.setPlaceholder("Select Record");
				}
				else {
					updateUI(EDITOR_MODE_SAVED);
				}
			}
			else if(event.getTarget().equals(editButton)) {
				updateUI(EDITOR_MODE_EDIT);
			}
		}
	}
	
	private void setMandatory() {
		log.warning("----------");
		
		if(tableIDGridField != null) {
			boolean isTableIdMandatory = ((Integer) tableIDGridField.getValue() == null) || ((Integer) tableIDGridField.getValue() <= 0);
			tableIDGridField.setMandatory(isTableIdMandatory);
			tableIDEditor.setMandatory(tableIDGridField.isMandatory(false));
		}
		boolean isRecordIdMandatory = ((Integer) gridField.getValue() == null) || ((Integer) gridField.getValue() <= 0);
		gridField.setMandatory(isRecordIdMandatory);
		this.setMandatory(gridField.isMandatory(false));
	}
    
    protected void initRecords() {
    	log.warning("----------");
    	recordsCombobox.removeAllItems();
    	if(tableIDGridField == null || tableIDGridField.getValue() == null)
    		return;
    	MTable mTable = MTable.get(Env.getCtx(), (int)tableIDGridField.getValue(), null);
    	String[] keyColumns = mTable.getKeyColumns();
    	
    	if(keyColumns.length > 0) {
	    	String keyColumn = keyColumns[0];
	    	
	    	String sql = "SELECT " + keyColumn
	    			+ " FROM " + mTable.getTableName();
	    	
	    	PreparedStatement pstmt = null;
			ResultSet rs = null;
			try
			{
				pstmt = DB.prepareStatement(sql, null);
				rs = pstmt.executeQuery();
				
				while (rs.next()){
					String identifier = getIdentifierColumns((int)tableIDGridField.getValue(), rs.getInt(1));
					recordsCombobox.appendItem(identifier, rs.getInt(1));
				}
			}
			catch (SQLException ex)
			{
				log.log(Level.SEVERE, sql, ex);
			}
			finally
			{
				DB.close(rs, pstmt);
				rs = null;
				pstmt = null;
			}
    	}
//    	for(Comboitem item : recordsCombobox.getItems()) {
//    		if(item.getValue() != null && item.getValue().equals((Integer) gridField.getValue())) {
//    			recordsCombobox.setSelectedItem(item);
//    			break;
//    		}
//    	}
    	
    }
    
    protected String getIdentifierColumns(int tableID, int recordID) {
    	log.warning("----------");
    	String value = String.valueOf(tableID);
    	if ((tableID > 0) && (recordID > 0)) {
			MTable mTable = MTable.get(Env.getCtx(), tableID);
			String tableName = mTable.getTableName();
			
			ArrayList<MColumn> list = new ArrayList<MColumn>();
			for (String idColumnName : mTable.getIdentifierColumns()) {
				MColumn column = mTable.getColumn(idColumnName);
				list.add (column);
			}
			if(list.size() > 0) {
				StringBuilder displayColumn = new StringBuilder();
				String separator = MSysConfig.getValue(MSysConfig.IDENTIFIER_SEPARATOR, "_", Env.getAD_Client_ID(Env.getCtx()));
				
				for(int i = 0; i < list.size(); i++) {
					MColumn identifierColumn = list.get(i);
					if(i > 0)
						displayColumn.append("||'").append(separator).append("'||");
					
					displayColumn.append("NVL(")
								.append(DB.TO_CHAR(identifierColumn.getColumnName(), 
													identifierColumn.getAD_Reference_ID(), 
													Env.getAD_Language(Env.getCtx())))
								.append(",'')");
				}
				StringBuilder sql = new StringBuilder("SELECT ");
				sql.append(displayColumn.toString());
				sql.append(" FROM ").append(tableName);
				sql.append(" WHERE ")
					.append(tableName).append(".").append(tableName).append("_ID=?");
				
				value = DB.getSQLValueStringEx(null, sql.toString(), recordID);
			}
		}
    	return value;
    }

	@Override
	public void stateChange(StateChangeEvent event) {
		log.warning(event.toString());
		if(event.getEventType() == StateChangeEvent.DATA_NEW) {
			updateUI(EDITOR_MODE_EDIT);
		}
		else {
			updateUI(EDITOR_MODE_SAVED);
		}
	}
}
