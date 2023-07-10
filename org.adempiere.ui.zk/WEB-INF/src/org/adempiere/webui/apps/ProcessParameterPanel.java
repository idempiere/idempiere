/******************************************************************************
 * Product: Adempiere ERP & CRM Smart Business Solution                       *
 * Copyright (C) 1999-2006 Adempiere, Inc. All Rights Reserved.               *
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

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.adempiere.webui.Extensions;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.EditorBox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridFactory;
import org.adempiere.webui.component.Group;
import org.adempiere.webui.component.NumberBox;
import org.adempiere.webui.component.Panel;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.Urlbox;
import org.adempiere.webui.editor.DateRangeEditor;
import org.adempiere.webui.editor.IZoomableEditor;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WEditorPopupMenu;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.factory.ButtonFactory;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.DateRangeButton;
import org.adempiere.webui.window.Dialog;
import org.compiere.apps.IProcessParameter;
import org.compiere.model.GridField;
import org.compiere.model.GridFieldVO;
import org.compiere.model.MClient;
import org.compiere.model.MLookup;
import org.compiere.model.MPInstance;
import org.compiere.model.MPInstancePara;
import org.compiere.model.MProcess;
import org.compiere.model.MProcessPara;
import org.compiere.model.X_AD_FieldGroup;
import org.compiere.process.ProcessInfo;
import org.compiere.process.ProcessInfoParameter;
import org.compiere.util.CLogger;
import org.compiere.util.DB;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.WrongValueException;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Div;
import org.zkoss.zul.Label;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Space;
import org.zkoss.zul.impl.InputElement;
import org.zkoss.zul.impl.XulElement;

/**
 * Process Parameter Panel.
 * Embedded in {@link ProcessDialog} and {@link ProcessModalDialog}.
 * Capture parameters input, validate and save to DB.
 * 
 * @author Low Heng Sin
 * @version 2006-12-01
 */
public class ProcessParameterPanel extends Panel implements
		ValueChangeListener, IProcessParameter, EventListener<Event>, Evaluatee {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -8847249274740131848L;

	/** Event post from {@link #valueChange(ValueChangeEvent)} **/
	private static final String ON_POST_EDITOR_VALUE_CHANGE_EVENT = "onPostEditorValueChange";
	
	/**
	 * Dynamic generated Parameter panel.
	 * 
	 * @param WindowNo register window number
	 * @param pi process info
	 */
	public ProcessParameterPanel(int WindowNo, ProcessInfo pi) {
		this(WindowNo, 0, pi);
	}

	/**
	 * Dynamic generated Parameter panel.
	 * 
	 * @param WindowNo register window number
	 * @param tabNo tabNo
	 * @param pi process info
	 */
	public ProcessParameterPanel(int WindowNo,int tabNo, ProcessInfo pi) {
		//
		m_WindowNo = WindowNo;
		m_TabNo = tabNo;
		m_processInfo = pi;
		m_AD_Window_ID = AEnv.getADWindowID (WindowNo);		
		this.m_InfoWindowID = pi.getAD_InfoWindow_ID();
		//
		initComponent();
		addEventListener("onDynamicDisplay", this);
		addEventListener(ON_POST_EDITOR_VALUE_CHANGE_EVENT, this);
	} // ProcessParameterPanel
	
	/**
	 * Layout UI
	 */
	private void initComponent() {
		centerPanel = GridFactory.newGridLayout();
		this.appendChild(centerPanel);

		// setup columns
		Columns columns = new Columns();
		centerPanel.appendChild(columns);
		Column col = new Column();
		ZKUpdateUtil.setWidth(col, "30%");
		columns.appendChild(col);
		col = new Column();
		ZKUpdateUtil.setWidth(col, "70%");
		columns.appendChild(col);
	}

	private int m_WindowNo;
	private int m_TabNo;
	private ProcessInfo m_processInfo;
	/** AD_Window_ID if process dialog is launch by AD_Window **/
	private int			m_AD_Window_ID = 0;	
	/** Info_Window_ID if process dialog is launch by Info Window **/
	private int 		m_InfoWindowID = 0;
	/** Logger */
	private static final CLogger log = CLogger
			.getCLogger(ProcessParameterPanel.class);
	
	/** parameter editor list **/
	private ArrayList<WEditor> m_wEditors = new ArrayList<WEditor>();
	/** to parameter editor list for range parameter **/
	private ArrayList<WEditor> m_wEditors2 = new ArrayList<WEditor>();
	/** parameter field list **/
	private ArrayList<GridField> m_mFields = new ArrayList<GridField>();
	/** to parameter field list for range parameter **/
	private ArrayList<GridField> m_mFields2 = new ArrayList<GridField>();
	/** list of separators **/
	private ArrayList<Space> m_separators = new ArrayList<Space>();
	/** all rows of {@link #centerPanel} **/
	private ArrayList<Row> m_Rows = new ArrayList<Row>();
	/** list of all date range editors **/
	private ArrayList<DateRangeEditor> m_dateRangeEditors = new ArrayList<DateRangeEditor>();
	//
	/** layout grid for parameter fields **/
	private Grid centerPanel = null;
	/** Group Name:Rows for parameter field **/
	private Map<String, List<Row>> fieldGroupContents = new HashMap<String, List<Row>>();
	/** Group Name:Rows for group header **/
    private Map<String, List<org.zkoss.zul.Row>> fieldGroupHeaders = new HashMap<String, List<org.zkoss.zul.Row>>();
    /** rows of current rendering group **/
	private ArrayList<Row> rowList;
	/** all groups of field type collapsible or tab **/
	private List<Group> allCollapsibleGroups = new ArrayList<Group>();
	/** current rendering group **/
	private Group currentGroup;

	/**
	 * Dispose
	 */
	public void dispose() {
		m_wEditors.clear();
		m_wEditors2.clear();
		m_mFields.clear();
		m_mFields2.clear();

	} // dispose

	/**
	 * Render all visible fields
	 * 
	 * @return true if loaded OK
	 */
	public boolean init() {
		if (log.isLoggable(Level.CONFIG)) log.config("");

		// ASP
		MClient client = MClient.get(Env.getCtx());
		String ASPFilter = "";
		if (client.isUseASP())
			ASPFilter = "   AND (   p.AD_Process_Para_ID not IN ( "
					// Just ASP subscribed process parameters for client "
					+ "              SELECT pp.AD_Process_Para_ID "
					+ "                FROM ASP_Process_Para pp, ASP_Process p, ASP_Level l, ASP_ClientLevel cl "
					+ "               WHERE p.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND cl.AD_Client_ID = "
					+ client.getAD_Client_ID()
					+ "                 AND cl.ASP_Level_ID = l.ASP_Level_ID "
					+ "                 AND pp.ASP_Process_ID = p.ASP_Process_ID "
					+ "                 AND pp.IsActive = 'Y' "
					+ "                 AND p.IsActive = 'Y' "
					+ "                 AND l.IsActive = 'Y' "
					+ "                 AND cl.IsActive = 'Y' "
					+ "					AND p.ad_process_ID="+m_processInfo.getAD_Process_ID()
					+ "                 AND pp.ASP_Status = 'H' " // Show
					+"					AND pp.AD_Process_Para_ID not in ("
					+" 					SELECT AD_Process_Para_ID"             
					+" 					FROM ASP_ClientException ce"            
					+" 					WHERE ce.AD_Client_ID ="+ client.getAD_Client_ID()    
					+" 					AND ce.IsActive = 'Y'"              
					+" 					AND ce.AD_Process_Para_ID IS NOT NULL"
					+" 					AND ce.AD_Tab_ID IS NULL"              
					+" 					AND ce.AD_Field_ID IS NULL"              
					+" 					AND ce.ASP_Status in('S','U') )  "
					+ "  UNION ALL "
					// minus hide ASP exceptions for client
					+ "          SELECT AD_Process_Para_ID "
					+ "            FROM ASP_ClientException ce "
					+ "           WHERE ce.AD_Client_ID = "
					+ client.getAD_Client_ID()
					+ "             AND ce.IsActive = 'Y' "
					+ "             AND ce.AD_Process_Para_ID IS NOT NULL "
					+ "             AND ce.AD_Tab_ID IS NULL "
					+ "				AND ce.AD_Process_Para_ID="+m_processInfo.getAD_Process_ID()
					+ "             AND ce.AD_Field_ID IS NULL "
					+ "             AND ce.ASP_Status = 'H'))"; // Hide
		//
		String sql = null;
		if (Env.isBaseLanguage(Env.getCtx(), "AD_Process_Para"))
			sql = "SELECT p.Name, p.Description, p.Help, "
					+ "p.AD_Reference_ID, p.AD_Process_Para_ID, "
					+ "p.FieldLength, p.IsMandatory, p.IsRange, p.dateRangeOption, p.ColumnName, "
					+ "p.DefaultValue, p.DefaultValue2, p.VFormat, p.ValueMin, p.ValueMax, "
					+ "p.SeqNo, p.AD_Reference_Value_ID, vr.Code AS ValidationCode, "
					+ "p.ReadOnlyLogic, p.DisplayLogic, p.IsEncrypted, NULL AS FormatPattern, p.MandatoryLogic, p.Placeholder, p.Placeholder2, p.isAutoComplete, "
					+ "'' AS ValidationCodeLookup, "
					+ "fg.Name AS FieldGroup, fg.FieldGroupType, fg.IsCollapsedByDefault, p.IsShowNegateButton "
					+ "FROM AD_Process_Para p"
					+ " LEFT OUTER JOIN AD_Val_Rule vr ON (p.AD_Val_Rule_ID=vr.AD_Val_Rule_ID) "
					+ " LEFT OUTER JOIN AD_FieldGroup fg ON (p.AD_FieldGroup_ID=fg.AD_FieldGroup_ID) "
					+ "WHERE p.AD_Process_ID=?" // 1
					+ " AND p.IsActive='Y' " + ASPFilter + " ORDER BY SeqNo";
		else
			sql = "SELECT t.Name, t.Description, t.Help, "
					+ "p.AD_Reference_ID, p.AD_Process_Para_ID, "
					+ "p.FieldLength, p.IsMandatory, p.IsRange, p.dateRangeOption, p.ColumnName, "
					+ "p.DefaultValue, p.DefaultValue2, p.VFormat, p.ValueMin, p.ValueMax, "
					+ "p.SeqNo, p.AD_Reference_Value_ID, vr.Code AS ValidationCode, "
					+ "p.ReadOnlyLogic, p.DisplayLogic, p.IsEncrypted, NULL AS FormatPattern,p.MandatoryLogic, t.Placeholder, t.Placeholder2, p.isAutoComplete, "
					+ "'' AS ValidationCodeLookup, "
					+ "fgt.Name AS FieldGroup, fg.FieldGroupType, fg.IsCollapsedByDefault, p.IsShowNegateButton "
					+ "FROM AD_Process_Para p"
					+ " INNER JOIN AD_Process_Para_Trl t ON (p.AD_Process_Para_ID=t.AD_Process_Para_ID)"
					+ " LEFT OUTER JOIN AD_Val_Rule vr ON (p.AD_Val_Rule_ID=vr.AD_Val_Rule_ID) "
					+ " LEFT OUTER JOIN AD_FieldGroup fg ON (p.AD_FieldGroup_ID=fg.AD_FieldGroup_ID) "
					+ " LEFT OUTER JOIN AD_FieldGroup_Trl fgt ON (p.AD_FieldGroup_ID=fgt.AD_FieldGroup_ID AND fgt.AD_Language='" + Env.getAD_Language(Env.getCtx()) + "') "
					+ "WHERE p.AD_Process_ID=?" // 1
					+ " AND t.AD_Language='" + Env.getAD_Language(Env.getCtx())
					+ "'" + " AND p.IsActive='Y' " + ASPFilter
					+ " ORDER BY SeqNo";

		// Create Fields
		boolean hasFields = false;
		String currentFieldGroup = null;
		Rows rows = new Rows();
		Row row = new Row();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB.prepareStatement(sql, null);
			pstmt.setInt(1, m_processInfo.getAD_Process_ID());
			rs = pstmt.executeQuery();
			ArrayList<GridFieldVO> listVO = new ArrayList<GridFieldVO>();
			List<Group>toCollapsed = new ArrayList<Group>();
			while (rs.next()) {
				hasFields = true;

				// Create Field
				GridFieldVO voF = GridFieldVO.createParameter(Env.getCtx(), m_WindowNo, m_TabNo, m_processInfo.getAD_Process_ID(), m_AD_Window_ID, m_InfoWindowID,rs);
				listVO.add(voF);
			}
			Collections.sort(listVO, new GridFieldVO.SeqNoComparator());

			for (int i = 0; i < listVO.size(); i++)
			{
				GridFieldVO voF = listVO.get(i);
				GridField field = new GridField(voF);
				m_mFields.add(field); // add to Fields
				field.setParentEvaluatee(this);
				
				String fieldGroup = field.getFieldGroup();
	        	if (!Util.isEmpty(fieldGroup) && !fieldGroup.equals(currentFieldGroup)
	        		&& !X_AD_FieldGroup.FIELDGROUPTYPE_DoNothing.equals(field.getFieldGroupType())) // group changed
	        	{
	        		currentFieldGroup = fieldGroup;
	        		
	        		row.setGroup(currentGroup);
	        		rows.appendChild(row);
	                if (rowList != null)
	        			rowList.add(row);

	        		List<org.zkoss.zul.Row> headerRows = new ArrayList<org.zkoss.zul.Row>();
	        		fieldGroupHeaders.put(fieldGroup, headerRows);

	        		rowList = new ArrayList<Row>();
	        		fieldGroupContents.put(fieldGroup, rowList);

	        		if (X_AD_FieldGroup.FIELDGROUPTYPE_Label.equals(field.getFieldGroupType()))
	        		{
	        			row = new Row();
	        			Label groupLabel = new Label(fieldGroup);
	        			row.appendCellChild(groupLabel, 3);
	        			rows.appendChild(row);
	        			headerRows.add(row);

	        			row = new Row();
	        			Separator separator = new Separator();
	        			separator.setBar(true);
	        			row.appendCellChild(separator, 3);
	        			rows.appendChild(row);
	        			headerRows.add(row);
	        			currentGroup = null;
	        		}
	        		else
	        		{
	        			Group rowg = new Group(fieldGroup);
	        			Cell cell = (Cell) rowg.getFirstChild();
	        			cell.setSclass("z-group-inner");
	        			cell.setColspan(3);
	        			
	    				allCollapsibleGroups.add(rowg);
	        			if (X_AD_FieldGroup.FIELDGROUPTYPE_Tab.equals(field.getFieldGroupType()) || field.getIsCollapsedByDefault())
	        			{
	        				toCollapsed.add(rowg);	        				
	        			}
	        			currentGroup = rowg;
	        			rows.appendChild(rowg);
	        			headerRows.add(rowg);
	        		}
	        		row = new Row();
	        	}
				
        		row = new Row();
				createField(voF, field, row);
				
				row.setGroup(currentGroup);
        		rows.appendChild(row);
        		m_Rows.add(row);
                if (rowList != null)
        			rowList.add(row);
				if (log.isLoggable(Level.INFO)) log.info(listVO.get(i).ColumnName + listVO.get(i).SeqNo);
			}
			if (toCollapsed.size() > 0)
				toCollapsed.stream().forEach(g -> g.setOpen(false));

		} catch (SQLException e) {
			log.log(Level.SEVERE, sql, e);
		}
		finally{
			DB.close(rs,pstmt);
			rs = null;
			pstmt = null;
		}

		// both vectors the same?
		if (m_mFields.size() != m_mFields2.size()
				|| m_mFields.size() != m_wEditors.size()
				|| m_mFields2.size() != m_wEditors2.size())
			log.log(Level.SEVERE, "View & Model vector size is different");

		// clean up
		if (hasFields) {
			centerPanel.appendChild(rows);
			dynamicDisplay();
		} else
			dispose();
		return hasFields;
	} // initDialog

	/**
	 * Create editor and adds it to {@link #m_wEditors}.
	 * <br/>
	 * For range type field, create the to field and add it to {@link #m_mFields2} and
	 * create the to editor and adds it to {@link #m_wEditors2}.
	 * <p>
	 * mField is used for default value and mandatory checking and editor is
	 * used to capture input value from user (no data binding).
	 * 
	 * @param voF GridFieldVO
	 * @param mField
	 * @param row
	 */
	private void createField(GridFieldVO voF, GridField mField, Row row) {
		// The Editor
		WEditor editor = WebEditorFactory.getEditor(mField, false);
		editor.setProcessParameter(true);
		editor.getComponent().addEventListener(Events.ON_FOCUS, this);
		editor.addValueChangeListener(this);
		editor.dynamicDisplay();
		// MField => editor - New Field value to be updated to editor
		mField.addPropertyChangeListener(editor);
		// Set Default
		Object defaultObject = mField.getDefaultForPanel();
		mField.setValue(defaultObject, true);
		// streach component to fill grid cell
		editor.fillHorizontal();
		// setup editor context menu
		WEditorPopupMenu popupMenu = editor.getPopupMenu();
		if (popupMenu != null)
		{
			popupMenu.addMenuListener((ContextMenuListener)editor);
			popupMenu.setId(mField.getColumnName()+"-popup");
			this.appendChild(popupMenu);
			if (!mField.isFieldOnly())
			{
				Label label = editor.getLabel();
				if (popupMenu.isZoomEnabled() && editor instanceof IZoomableEditor)
				{
					label.addEventListener(Events.ON_CLICK, new ZoomListener((IZoomableEditor) editor));
				}

				popupMenu.addContextElement(label);
				if (editor.getComponent() instanceof XulElement) 
				{
					popupMenu.addContextElement((XulElement) editor.getComponent());
				}
			}        				        				
		}
		//
		m_wEditors.add(editor); // add to Editors

    	Div div = new Div();
        div.setStyle("text-align: right;");
        org.adempiere.webui.component.Label label = editor.getLabel();
        div.appendChild(label);
        if (label.getDecorator() != null)
        	div.appendChild(label.getDecorator());
        row.appendChild(div);
		//
        Div box = new Div();
		box.setStyle("display: flex; align-items: center;");
		ZKUpdateUtil.setWidth(box, "100%");
		//create to field and editor
		if (voF.isRange) {
			box.appendChild(editor.getComponent());
			ZKUpdateUtil.setWidth((HtmlBasedComponent) editor.getComponent(), "49%");
			//
			GridFieldVO voF2 = GridFieldVO.createParameter(voF);
			GridField mField2 = new GridField(voF2);
			m_mFields2.add(mField2);
			// The Editor
			WEditor editor2 = WebEditorFactory.getEditor(mField2, false);
			editor2.setProcessParameter(true);
			//override attribute
			editor2.getComponent().setClientAttribute("columnName", mField2.getColumnName()+"_To");
			editor2.getComponent().addEventListener(Events.ON_FOCUS, this);
			// New Field value to be updated to editor
			mField2.addPropertyChangeListener(editor2);
			editor2.addValueChangeListener(this);
			editor2.dynamicDisplay();
			ZKUpdateUtil.setWidth((HtmlBasedComponent) editor2.getComponent(), "49%");
			setEditorPlaceHolder(editor2, mField2.getPlaceholder2());
			// setup editor context menu
			popupMenu = editor2.getPopupMenu();
			if (popupMenu != null) {
				popupMenu.addMenuListener((ContextMenuListener) editor2);
				this.appendChild(popupMenu);
			}
			// Set Default
			Object defaultObject2 = mField2.getDefaultForPanel();
			mField2.setValue(defaultObject2, true);
			//
			m_wEditors2.add(editor2);
			Space separator = new Space();
			separator.setStyle("margin:0; width: 2%;");
			m_separators.add(separator);
			box.appendChild(separator);
			box.appendChild(editor2.getComponent());
			row.appendChild(box);
			if (((mField.getDisplayType() == DisplayType.Date) || (mField.getDisplayType() == DisplayType.DateTime)) 
					&& ((mField2.getDisplayType() == DisplayType.Date) || (mField2.getDisplayType() == DisplayType.DateTime))) {
				if(MProcessPara.DATERANGEOPTION_TextAndRangePicker.equalsIgnoreCase(mField.getDateRangeOption())) {
					editor.setVisible(false, true);
					editor2.setVisible(false, true);
					DateRangeEditor dateRangeEditor = new DateRangeEditor(editor, editor2);
					box.appendChild(dateRangeEditor);
					dateRangeEditor.setVisible(mField.isDisplayed(true));
					label.setVisible(dateRangeEditor.isVisible());
					dateRangeEditor.setReadOnly(!(editor.isReadWrite() && editor2.isReadWrite()));
					m_dateRangeEditors.add(dateRangeEditor);
				}
				else {
					DateRangeButton dateRangeButton = new DateRangeButton(editor, editor2);
					box.appendChild(dateRangeButton);
					m_dateRangeEditors.add(null);
				}
			}
			else {
				m_dateRangeEditors.add(null);
			}
		} else {
			box.appendChild(editor.getComponent());
			m_mFields2.add(null);
			m_wEditors2.add(null);
			m_separators.add(null);
			m_dateRangeEditors.add(null);
			//add not in support for multi selection field
			if(DisplayType.isChosenMultipleSelection(mField.getDisplayType()) && voF.IsShowNegateButton) {
				Button bNegate = ButtonFactory.createButton("", null, null);
				bNegate.setTooltiptext(Msg.translate(Env.getCtx(), "IncludeSelectedValues"));
				bNegate.setIconSclass("z-icon-IncludeSelected");
				bNegate.setSclass("btn-negate btn-negate-include");
				bNegate.setAttribute("isSelected", false);
				bNegate.setVisible(false);
				bNegate.addActionListener(this);
				box.appendChild(bNegate);
				editor.getComponent().setAttribute("isNotClause", bNegate);
			}
		}
		row.appendChild(box);
	} // createField

	/**
	 * set place holder message
	 * @param editor
	 * @param msg
	 */
	private void setEditorPlaceHolder(WEditor editor, String msg) {
		Component c = editor.getComponent();
		if (c instanceof InputElement) {
			((InputElement) c).setPlaceholder(msg);
		} else {
			for (Component e : c.getChildren()) {
				if (e instanceof InputElement) {
					((InputElement) e).setPlaceholder(msg);
					break;
				}
			}
		}
		
	}

	/**
	 * Validate Parameter values
	 * 
	 * @return true if parameters are valid
	 */
	public boolean validateParameters() {
		if (log.isLoggable(Level.CONFIG)) log.config("");

		//mandatory fields validation
		int size = m_mFields.size();
		for (int i = 0; i < size; i++) {
			GridField field = (GridField) m_mFields.get(i);
			GridField field2 = (GridField) m_mFields2.get(i);
			WEditor wEditor = (WEditor) m_wEditors.get(i);
			WEditor wEditor2 = (WEditor) m_wEditors2.get(i);
			Object data = wEditor.getValue();
			String msg = validate(data, field.getValueMin(), field.getValueMax(), field.isMandatory(true), field.getDisplayType());
			if (msg != null) {
				field.setInserting(true); // set editable (i.e. updateable) otherwise deadlock
				field.setError(true);
				throw new WrongValueException(wEditor.getComponent(), msg);
			}
			if (m_wEditors2.get(i) != null) { // is a range
				data = wEditor2.getValue();
				msg = validate(data, field.getValueMin(), field.getValueMax(), field.isMandatory(true), field.getDisplayType());
				if (msg != null) {
					field2.setInserting(true); // set editable (i.e. updateable) otherwise deadlock
					field2.setError(true);
					throw new WrongValueException(wEditor2.getComponent(), msg);
				}
			}

		} // field loop

		/** call {@link IProcessParameterListener} validate(ProcessParameterPanel) **/
		if (m_processInfo.getAD_Process_ID() > 0) {
			String className = MProcess.get(Env.getCtx(), m_processInfo.getAD_Process_ID()).getClassname();
			List<IProcessParameterListener> listeners = Extensions.getProcessParameterListeners(className, null);
			for(IProcessParameterListener listener : listeners) {
				String error = listener.validate(this);
				if (!Util.isEmpty(error)) {
					Dialog.error(m_WindowNo, error);
					return false;
				}
			}
		}
		
		return true;
	}	//	validateParameters
	
	/**
	 * Validate mandatory and min/max value
	 * @param value
	 * @param valueMin
	 * @param valueMax
	 * @param isMandatory
	 * @param fieldType
	 * @return null if OK, any message if not OK
	 */
	public static String validate(Object value, String valueMin, String valueMax, boolean isMandatory, int fieldType) {

		if (isMandatory) {
			if (value == null || value.toString().length() == 0) {
				return Msg.getMsg(Env.getCtx(), "FillMandatory");
			}
		}

		BigDecimal value_BD = null;
		BigDecimal valueMin_BD = null;
		BigDecimal valueMax_BD = null;
		Timestamp value_TS = null;
		Timestamp valueMin_TS = null;
		Timestamp valueMax_TS = null;

		if (fieldType == DisplayType.Date) {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd");
			if (value != null) {
				try { value_TS = new Timestamp(dateFormat.parse(value.toString()).getTime()); } catch (Exception ex){}
			}
			if (valueMin != null) {
				try { valueMin_TS = new Timestamp(dateFormat.parse(valueMin).getTime()); } catch (Exception ex){}
			}
			if (valueMax != null) {
				try { valueMax_TS = new Timestamp(dateFormat.parse(valueMax).getTime()); } catch (Exception ex){}
			}
		} else if (DisplayType.isNumeric(fieldType)) {
			if (value != null) {
				try { value_BD = new BigDecimal(value.toString()); } catch (Exception ex){}
			}
			if (valueMin != null) {
				try { valueMin_BD = new BigDecimal(valueMin); } catch (Exception ex){}
			}
			if (valueMax != null) {
				try { valueMax_BD = new BigDecimal(valueMax); } catch (Exception ex){}
			}
		}

		if (   (value_TS != null && valueMin_TS != null && value_TS.before(valueMin_TS))
			|| (value_BD != null && valueMin_BD != null && valueMin_BD.compareTo(value_BD) > 0)
			|| (value != null && valueMin != null && valueMin.compareTo(value.toString()) > 0)
		   )
			return Msg.getMsg(Env.getCtx(), "LessThanMinValue", new Object[] {valueMin});

		if (   (value_TS != null && valueMax_TS != null && value_TS.after(valueMax_TS))
			|| (value_BD != null && valueMax_BD != null && valueMax_BD.compareTo(value_BD) < 0)
			|| (value != null && valueMax != null && valueMax.compareTo(value.toString()) < 0)
		   )
			return Msg.getMsg(Env.getCtx(), "MoreThanMaxValue", new Object[] {valueMax});

		return null;
	}

	/** 
	 * load parameters from saved instance
	 * @param instance
	 */
	public boolean loadParameters(MPInstance instance)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("");

		MPInstancePara[] params = instance.getParameters();
		for (int j = 0; j < m_mFields.size(); j++)
		{
			GridField mField = (GridField)m_mFields.get(j);

			if (!mField.isEditablePara(true))
				continue; // Saved parameters must not change read-only parameters

			//	Get Values
			WEditor editor = (WEditor)m_wEditors.get(j);
			WEditor editor2 = (WEditor)m_wEditors2.get(j);

			editor.setValue(null);
			if (editor2 != null)
				editor2.setValue(null);

			for ( int i = 0; i<params.length; i++)
			{
				MPInstancePara para = params[i];
				if ( mField.getColumnName().equals(para.getParameterName()) )
				{
					Button bNegate = null;
					if(editor.getComponent() != null)
						bNegate = (Button) editor.getComponent().getAttribute("isNotClause");
					
					if (para.getP_Date() != null || para.getP_Date_To() != null )
					{
						editor.setValue(para.getP_Date());
						if (editor2 != null )
							editor2.setValue(para.getP_Date_To());
					}
					//	String
					else if ( para.getP_String() != null || para.getP_String_To() != null )
					{
						editor.setValue(para.getP_String());
						if (editor2 != null)
							editor2.setValue(para.getP_String_To());
					}
					else if ( !Env.ZERO.equals(para.getP_Number()) || !Env.ZERO.equals(para.getP_Number_To()) )
					{
						if (DisplayType.isID(para.getDisplayType())) {
							editor.setValue(para.getP_Number().intValue());
							if (editor2 != null)
								editor2.setValue(para.getP_Number_To().intValue());
						} else {
							editor.setValue(para.getP_Number());
							if (editor2 != null)
								editor2.setValue(para.getP_Number_To());
						}
					}
					if (editor.getValue() != null) {
	            		ValueChangeEvent changeEvent = new ValueChangeEvent(editor, editor.getColumnName(), null, editor.getValue());
	            		valueChange(changeEvent);
					}
					if (editor2 != null && editor2.getValue() != null) {
					    ValueChangeEvent changeEvent = new ValueChangeEvent(editor2, editor2.getColumnName(), null, editor2.getValue());
					    valueChange(changeEvent);
					}

					if(bNegate != null) {
						if(para.isNotClause()) {
							bNegate.setTooltiptext(Msg.translate(Env.getCtx(), "ExcludeSelectedValues"));
							bNegate.setIconSclass("z-icon-ExcludeSelected");
							bNegate.setSclass("btn-negate btn-negate-exclude");
							bNegate.setAttribute("isSelected", true);
						} 
						else {
							bNegate.setTooltiptext(Msg.translate(Env.getCtx(), "IncludeSelectedValues"));
							bNegate.setIconSclass("z-icon-IncludeSelected");
							bNegate.setSclass("btn-negate btn-negate-include");
							bNegate.setAttribute("isSelected", false);
						}
						
						if(editor.getValue() != null)
							bNegate.setVisible(true);
					}
					log.fine(para.toString());
					break;
				}
			} // for every saved parameter

		}	//	for every field

		//TODO: consider also call processDependencies per each time set value for field to validate, call callout,...
		dynamicDisplay();
		
		return true;
	}	//	loadParameters

	/**
	 * Load parameters from Process Info
	 * @param pi
	 */
	public boolean loadParametersFromProcessInfo(ProcessInfo pi)
	{
		if (log.isLoggable(Level.CONFIG)) log.config("");

		ProcessInfoParameter[] params = pi.getParameter();
		for (int j = 0; j < m_mFields.size(); j++)
		{
			GridField mField = (GridField)m_mFields.get(j);

			if (!mField.isEditablePara(true))
				continue;

			//	Get Values
			WEditor editor = (WEditor)m_wEditors.get(j);
			WEditor editor2 = (WEditor)m_wEditors2.get(j);

			editor.setValue(null);
			if (editor2 != null)
				editor2.setValue(null);

			for ( int i = 0; i<params.length; i++)
			{
				ProcessInfoParameter para = params[i];
				if ( mField.getColumnName().equals(para.getParameterName()) )
				{
					editor.setValue(para.getParameter());
					if (editor2 != null)
						editor2.setValue(para.getParameter_To());

					if (editor.getValue() != null) {
				ValueChangeEvent changeEvent = new ValueChangeEvent(editor, editor.getColumnName(), null, editor.getValue());
				valueChange(changeEvent);
					}
					if (editor2 != null && editor2.getValue() != null) {
					    ValueChangeEvent changeEvent = new ValueChangeEvent(editor2, editor2.getColumnName(), null, editor2.getValue());
					    valueChange(changeEvent);
					}

					log.fine(para.toString());
					break;
				}
			} // for every parameter

		}	//	for every field

		dynamicDisplay();

		return true;
	}	//	loadParameters

	/**
	 * Save parameter values to {@link MPInstancePara}.
	 * 
	 * @return true if parameters saved
	 */
	public boolean saveParameters() {
		if (log.isLoggable(Level.CONFIG)) log.config("");

		if (!validateParameters())
			return false;

		/**********************************************************************
		 * Save Now
		 */
		for (int i = 0; i < m_mFields.size(); i++) {
			// Get Values
			WEditor editor = (WEditor) m_wEditors.get(i);
			WEditor editor2 = (WEditor) m_wEditors2.get(i);
			Object result = editor.getValue();
			Object result2 = null;
			if (editor2 != null)
				result2 = editor2.getValue();
			//Save only parameters which are set
			if((result == null) && (result2 == null))
				continue;
			if(result instanceof String) { 
				if (Util.isEmpty((String)result) && (result2 == null || Util.isEmpty((String)result2))) 
					continue;
			}

			// Create Parameter
			MPInstancePara para = MPInstancePara.getOrCreate(Env.getCtx(),
					m_processInfo.getAD_PInstance_ID(), i);
			GridField mField = (GridField) m_mFields.get(i);
			para.setParameterName(mField.getColumnName());			

			Button bNegate = null;
			if(editor.getComponent() != null)
				bNegate = (Button)editor.getComponent().getAttribute("isNotClause");
			
			if(bNegate != null) {
				para.setIsNotClause((boolean)bNegate.getAttribute("isSelected"));
			}
			
			// Date
			if (result instanceof Timestamp || result2 instanceof Timestamp) {
				if (result instanceof Timestamp)
					para.setP_Date((Timestamp) result);
				if (editor2 != null && result2 != null && result2 instanceof Timestamp)
					para.setP_Date_To((Timestamp) result2);
			}
			// Integer
			else if (result instanceof Integer || result2 instanceof Integer) {
				if (result != null && result instanceof Integer) {
					Integer ii = (Integer) result;
					para.setP_Number(ii.intValue());
				}
				if (editor2 != null && result2 != null && result2 instanceof Integer) {
					Integer ii = (Integer) result2;
					para.setP_Number_To(ii.intValue());
				}
			}
			// BigDecimal
			else if (result instanceof BigDecimal
					|| result2 instanceof BigDecimal) {
				if (result instanceof BigDecimal)
					para.setP_Number((BigDecimal) result);
				if (editor2 != null && result2 != null && result2 instanceof BigDecimal)
					para.setP_Number_To((BigDecimal) result2);
			}
			// Boolean
			else if (result instanceof Boolean) {
				Boolean bb = (Boolean) result;
				String value = bb.booleanValue() ? "Y" : "N";
				para.setP_String(value);
				// to does not make sense
			}
			// String
			else {
				if (result != null)
					para.setP_String(result.toString());
				if (editor2 != null && result2 != null)
					para.setP_String_To(result2.toString());
			}

			// Info
			para.setInfo(editor.getDisplay());
			if (editor2 != null)
				para.setInfo_To(editor2.getDisplay());
			//
			para.saveEx();
			if (log.isLoggable(Level.FINE)) log.fine(para.toString());
		} // for every parameter

		return true;
	} // saveParameters

	/**
	 * Get parameter values from editors without saving to DB.
	 * 
	 * @return MPInstancePara[], list of parameter values.
	 */
	public MPInstancePara[] getParameters() {
		if (log.isLoggable(Level.CONFIG)) log.config("");

		if (!validateParameters())
			return new MPInstancePara[0];

		List<MPInstancePara> paras = new ArrayList<MPInstancePara>();
		
		/** create MPInstancePara from editors and add to paras (without saving MPInstancePara to DB) **/
		for (int i = 0; i < m_mFields.size(); i++) {
			// Get Values
			WEditor editor = (WEditor) m_wEditors.get(i);
			WEditor editor2 = (WEditor) m_wEditors2.get(i);
			Object result = editor.getValue();
			Object result2 = null;
			if (editor2 != null)
				result2 = editor2.getValue();

			// Create Parameter
			MPInstancePara para = new MPInstancePara(Env.getCtx(), 0, i);
			GridField mField = (GridField) m_mFields.get(i);
			para.setParameterName(mField.getColumnName());
			para.setP_Date(null);
			para.setP_Date_To(null);
			para.setP_Number((BigDecimal)null);
			para.setP_Number_To((BigDecimal)null);
			para.setP_String(null);
			para.setP_String_To(null);
			
			// Date
			if (result instanceof Timestamp || result2 instanceof Timestamp) {
				if (result instanceof Timestamp)
					para.setP_Date((Timestamp) result);
				if (editor2 != null && result2 != null && result2 instanceof Timestamp)
					para.setP_Date_To((Timestamp) result2);
			}
			// Integer
			else if (result instanceof Integer || result2 instanceof Integer) {
				if (result != null && result instanceof Integer) {
					Integer ii = (Integer) result;
					para.setP_Number(ii.intValue());
				}
				if (editor2 != null && result2 != null && result2 instanceof Integer) {
					Integer ii = (Integer) result2;
					para.setP_Number_To(ii.intValue());
				}
			}
			// BigDecimal
			else if (result instanceof BigDecimal
					|| result2 instanceof BigDecimal) {
				if (result instanceof BigDecimal)
					para.setP_Number((BigDecimal) result);
				if (editor2 != null && result2 != null && result2 instanceof BigDecimal)
					para.setP_Number_To((BigDecimal) result2);
			}
			// Boolean
			else if (result instanceof Boolean) {
				Boolean bb = (Boolean) result;
				String value = bb.booleanValue() ? "Y" : "N";
				para.setP_String(value);
				// to does not make sense
			}
			// String
			else {
				if (result != null)
					para.setP_String(result.toString());
				if (editor2 != null && result2 != null)
					para.setP_String_To(result2.toString());
			}

			// Info
			para.setInfo(editor.getDisplay());
			if (editor2 != null)
				para.setInfo_To(editor2.getDisplay());
			//
			paras.add(para);
		} // for every parameter

		return paras.toArray(new MPInstancePara[0]);
	} // saveParameters

	
	/**
	 * Editor value change listener.
	 * 
	 * @param evt ValueChangeEvent
	 */
	public void valueChange(ValueChangeEvent evt) {
		String propName = evt.getPropertyName();
		if (evt.getSource() instanceof WEditor) {
			WEditor editor = (WEditor) evt.getSource();
			if (m_wEditors2.contains(editor)) {
				// is a _To editor for ranges
				propName += "_2";  // same as web services
			}
			GridField changedField = editor.getGridField();
			if (changedField != null) {
				processDependencies (changedField);
				// future processCallout (changedField);
			}
			Events.postEvent(ON_POST_EDITOR_VALUE_CHANGE_EVENT, this, evt.getSource());
		}
		processNewValue(evt.getNewValue(), propName);
	}
	
	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getName().equals(Events.ON_FOCUS)) {
			//update tooltip text inside desktop help panel.
    		for (WEditor editor : m_wEditors)
    		{
    			if (editor.isComponentOfEditor(event.getTarget()))
    			{
        			SessionManager.getAppDesktop().updateHelpTooltip(editor.getGridField());
        			return;
    			}
    		}
    		
    		for (WEditor editor : m_wEditors2)
    		{
    			if (editor != null && editor.getComponent() != null && editor.isComponentOfEditor(event.getTarget()))
    			{
        			SessionManager.getAppDesktop().updateHelpTooltip(editor.getGridField());
        			return;
    			}
    		}
    	}
    	else if (event.getName().equals("onDynamicDisplay")) {
    		dynamicDisplay();
    	}
    	else if (event.getName().equals(ON_POST_EDITOR_VALUE_CHANGE_EVENT)) {
    		WEditor editor = (WEditor)event.getData();
    		onPostEditorValueChange(editor);
    		if(editor.getComponent() != null) {
				Button bNegate = (Button) editor.getComponent().getAttribute("isNotClause");
				if (bNegate != null) {
					if (editor.getValue() != null) {
						bNegate.setVisible(true);
					} else {
						bNegate.setVisible(false);
						bNegate.setAttribute("isSelected", false);
						bNegate.setTooltiptext(Msg.translate(Env.getCtx(), "IncludeSelectedValues"));
	    				bNegate.setIconSclass("z-icon-IncludeSelected");
	    				bNegate.setSclass("btn-negate btn-negate-include");
					}
				}
    		}
    	}
    	else if (event.getName().equals(Events.ON_CLICK)) {
    		if(event.getTarget() instanceof Button) {
    			//from not in button of multi selection field
    			Button bNegate = (Button)event.getTarget();
    			boolean isSelected = !(boolean)bNegate.getAttribute("isSelected");
    			if(isSelected) {
    				bNegate.setTooltiptext(Msg.translate(Env.getCtx(), "ExcludeSelectedValues"));
    				bNegate.setIconSclass("z-icon-ExcludeSelected");
    				bNegate.setSclass("btn-negate btn-negate-exclude");
    			} 
    			else {
    				bNegate.setTooltiptext(Msg.translate(Env.getCtx(), "IncludeSelectedValues"));
    				bNegate.setIconSclass("z-icon-IncludeSelected");
    				bNegate.setSclass("btn-negate btn-negate-include");
    			}
    			bNegate.setAttribute("isSelected", isSelected);
    		}
    	}
	}

	/**
	 * Handle ON_POST_EDITOR_VALUE_CHANGE_EVENT event.
	 * <br/>
	 * Call {@link IProcessParameterListener#validate(ProcessParameterPanel)}.
	 * @param editor
	 */
	private void onPostEditorValueChange(WEditor editor) {
		if (m_processInfo.getAD_Process_ID() > 0) {
			String className = MProcess.get(Env.getCtx(), m_processInfo.getAD_Process_ID()).getClassname();
			String colName = editor.getColumnName();
			if (m_wEditors2.contains(editor)) {
				// is a _To editor for ranges
				colName += "_2";  // same as web services
			}
			List<IProcessParameterListener> listeners = Extensions.getProcessParameterListeners(className, colName);
			for(IProcessParameterListener listener : listeners) {
				listener.onChange(this, colName, editor);
			}
		}
	}
	
	/**
	 *  Notify dependent fields.
	 *  @param changedField changed field
	 */
	private void processDependencies (GridField changedField)
	{
		String columnName = changedField.getColumnName();

		for (GridField field : m_mFields) {
			if (field == null || field == changedField)
				continue;
			verifyChangedField(field, columnName);
		}
		for (GridField field : m_mFields2) {
			if (field == null || field == changedField)
				continue;
			verifyChangedField(field, columnName);
		}
	}   //  processDependencies

	/**
	 * Reset field value to null if field depends on columnName.
	 * @param field
	 * @param columnName column name of changed field
	 */
	private void verifyChangedField(GridField field, String columnName) {
		ArrayList<String> list = field.getDependentOn();
		if (list.contains(columnName)) {
			if (field.getLookup() instanceof MLookup)
			{
				MLookup mLookup = (MLookup)field.getLookup();
				//  if the lookup is dynamic (i.e. contains this columnName as variable)
				if (mLookup.getValidation().indexOf("@"+columnName+"@") != -1)
				{
					if (log.isLoggable(Level.FINE)) log.fine(columnName + " changed - "
						+ field.getColumnName() + " set to null");
					//  invalidate current selection
					field.setValue(null, true);
				}
			}
		}
	}
	
	/**
	 * Process new value from {@link #valueChange(ValueChangeEvent)}.
	 * @param value
	 * @param name
	 */
	private void processNewValue(Object value, String name) {
		if (value == null)
			value = new String("");

		if (value instanceof String)
			Env.setContext(Env.getCtx(), m_WindowNo, name, (String) value);
		else if (value instanceof Integer)
			Env.setContext(Env.getCtx(), m_WindowNo, name,
					((Integer) value).intValue());
		else if (value instanceof Boolean)
			Env.setContext(Env.getCtx(), m_WindowNo, name,
					((Boolean) value).booleanValue());
		else if (value instanceof Timestamp)
			Env.setContext(Env.getCtx(), m_WindowNo, name, (Timestamp) value);
		else
			Env.setContext(Env.getCtx(), m_WindowNo, name, value.toString());

		Events.postEvent("onDynamicDisplay", this, (Object)null);
	}

	/**
	 * Dynamic update the UI state and properties of all fields.
	 */
	private void dynamicDisplay() {
		for (int i = 0; i < m_wEditors.size(); i++) {
			WEditor editor = m_wEditors.get(i);
			GridField mField = editor.getGridField();
			GridField mField2 = null;
			if (mField.getVO().isRange) {
				mField2 = m_wEditors2.get(i).getGridField();
			}
			if (mField.isDisplayed(true)) {
				if (!editor.isVisible()) {
					editor.setVisible(true);
					m_Rows.get(i).setVisible(true);
					m_Rows.get(i).setAttribute(Group.GROUP_ROW_VISIBLE_KEY, "true");
					
					if (mField.getVO().isRange) {
						m_separators.get(i).setVisible(true);
						m_wEditors2.get(i).setVisible(true);
					}
					
					Button bNegate = null;
					if(editor.getComponent() != null)
						bNegate = (Button) editor.getComponent().getAttribute("isNotClause");
					if(bNegate != null) {
						bNegate.setVisible(true);
					}
				}
				boolean rw = mField.isEditablePara(true); // r/w - check if field is Editable
				editor.setReadWrite(rw);
				editor.dynamicDisplay();
				if (mField.getVO().isRange) {
					m_wEditors2.get(i).setReadWrite(rw);
					m_wEditors2.get(i).dynamicDisplay();
				}
			} else if (editor.isVisible()) {
				editor.setVisible(false);
				m_Rows.get(i).setVisible(false);
				m_Rows.get(i).setAttribute(Group.GROUP_ROW_VISIBLE_KEY, "false");
				
				if (mField.getVO().isRange) {
					m_separators.get(i).setVisible(false);
					m_wEditors2.get(i).setVisible(false);
				}
				
				Button bNegate = null;
				if(editor.getComponent() != null)
					bNegate = (Button) editor.getComponent().getAttribute("isNotClause");
				if(bNegate != null) {
					bNegate.setVisible(false);
				}
			}
			editor.setMandatory(mField.isMandatory(true));
        	editor.updateStyle();
			if (mField.getVO().isRange) {
				m_wEditors2.get(i).setMandatory(mField.isMandatory(true));
				m_wEditors2.get(i).updateStyle();
				// Add mandatory style on label when Parameter To is still blank
				if (editor.isMandatory() && editor.getLabel() != null && m_wEditors2.get(i).isNullOrEmpty()) {
					LayoutUtils.addSclass("idempiere-mandatory-label", editor.getLabel());
				}
			}
			// Handle Dynamic Display for Date Range Picker
			if (((mField.getDisplayType() == DisplayType.Date) || (mField.getDisplayType() == DisplayType.DateTime))
					&& mField2 != null
					&& ((mField2.getDisplayType() == DisplayType.Date) || (mField2.getDisplayType() == DisplayType.DateTime))
					&& MProcessPara.DATERANGEOPTION_TextAndRangePicker.equalsIgnoreCase(mField.getDateRangeOption())) {
				DateRangeEditor dateRangeEditor = m_dateRangeEditors.get(i);
				if(dateRangeEditor != null) {
					dateRangeEditor.setVisible(editor.isVisible());
					m_Rows.get(i).setVisible(editor.isVisible());
					m_Rows.get(i).setAttribute(Group.GROUP_ROW_VISIBLE_KEY, editor.isVisible());
					editor.setVisible(false, true);
					if (mField.getVO().isRange) {
						m_separators.get(i).setVisible(false);
						m_wEditors2.get(i).setVisible(false ,true);
					}
					dateRangeEditor.setFieldMandatoryStyle();
					dateRangeEditor.setReadOnly(!(editor.isReadWrite() && m_wEditors2.get(i).isReadWrite()));
				}
			}
		}
		if (getParent() != null) {
			getParent().invalidate();
		}
	}

	/**
	 * Restore window context.
	 * 
	 * author teo_sarca [ 1699826 ]
	 * @see org.compiere.model.GridField#restoreValue()
	 */
	protected void restoreContext() {
		for (GridField f : m_mFields) {
			if (f != null)
				f.restoreValue();
		}
		for (GridField f : m_mFields2) {
			if (f != null)
				f.restoreValue();
		}
	}

	/**
	 * @param processInfo
	 */
	public void setProcessInfo(ProcessInfo processInfo) {
		m_processInfo = processInfo;
	}
	
	/**
	 * focus to first visible field editor.
	 * @return true if there is at least one visible field editor.
	 */
	public boolean focusToFirstEditor() {
		if (m_wEditors.isEmpty())
			return false;
		for(WEditor editor : m_wEditors) {
			if (editor.isVisible()) {
				focusToEditor(editor);
				return true;
			}
		}
		return false;
	}

	/**
	 * @param toFocus
	 */
	private void focusToEditor(WEditor toFocus) {
		Component c = toFocus.getComponent();
		if (c instanceof EditorBox) {
			c = ((EditorBox)c).getTextbox();
		} else if (c instanceof NumberBox) {
			c = ((NumberBox)c).getDecimalbox();
		} else if (c instanceof Urlbox) {
			c = ((Urlbox)c).getTextbox();
		}
		((HtmlBasedComponent)c).focus();		
	}
	
	/**
	 * Get parameter field editor by column name
	 * @param columnName
	 * @return editor
	 */
	public WEditor getEditor(String columnName) {
		for(int i = 0; i < m_mFields.size(); i++) {
			if (m_mFields.get(i).getColumnName().equals(columnName)) {
				return m_wEditors.get(i);
			}
		}
		return null;
	}

	/**
	 * Get parameter field to editor by column name
	 * @param columnName
	 * @return editor
	 */
	public WEditor getEditorTo(String columnName) {
		for(int i = 0; i < m_mFields.size(); i++) {
			if (m_mFields.get(i).getColumnName().equals(columnName)) {
				return m_wEditors2.get(i);
			}
		}
		return null;
	}
	
	/**
	 * @return true if editor is showing dialog awaiting user action (usually info window).
	 */
	public boolean isWaitingForDialog() {
		for (int i = 0; i < m_mFields.size(); i++) {
			// Get Values
			WEditor editor = (WEditor) m_wEditors.get(i);
			WEditor editor2 = (WEditor) m_wEditors2.get(i);
			if (editor != null && editor instanceof WSearchEditor) {
				if (((WSearchEditor)editor).isShowingDialog())
					return true;
			} else if (editor2 != null && editor2 instanceof WSearchEditor) {
				if (((WSearchEditor)editor2).isShowingDialog())
					return true;
			}
		}
		
		return false;
	}
	
	/**
	 * Field label ON_CLICK listener for {@link IZoomableEditor}.
	 */
	static class ZoomListener implements EventListener<Event> {

		private IZoomableEditor searchEditor;

		ZoomListener(IZoomableEditor editor) {
			searchEditor = editor;
		}

		public void onEvent(Event event) throws Exception {
			if (Events.ON_CLICK.equals(event.getName())) {
				searchEditor.actionZoom();
			}

		}

	}

	/**
	 * @return register window number.
	 */
	public int getWindowNo() {
		return m_WindowNo;
	}

	@Override
	public String get_ValueAsString(String variableName) {
		for(WEditor editor : m_wEditors) {
			if (editor.getGridField().getColumnName().equals(variableName)) {
				//base on code in GridField.updateContext() method
				int displayType = editor.getGridField().getVO().displayType;	
				if (displayType == DisplayType.Text 
					|| displayType == DisplayType.Memo
					|| displayType == DisplayType.TextLong
					|| displayType == DisplayType.Binary
					|| displayType == DisplayType.RowID
					|| editor.getGridField().isEncrypted())
					return ""; //	ignore
				
				Object value = editor.getValue();
				if (value == null)
					return "";
				else if (value instanceof Boolean)
				{
					return (((Boolean)value) ? "Y" : "N");
				}
				else if (value instanceof Timestamp)
				{
					String stringValue = null;
					if (value != null && !value.toString().equals("")) {
						Calendar c1 = Calendar.getInstance();
						c1.setTime((Date) value);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						stringValue = sdf.format(c1.getTime());
					}
					return stringValue;
				}
				else
				{
					return value.toString();
				}
			}
		}
		return null;
	}

} // ProcessParameterPanel
