/******************************************************************************
 * Copyright (C) 2008 Low Heng Sin                                            *
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
package org.adempiere.webui.adwindow;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import org.adempiere.util.GridRowCtx;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.EditorBox;
import org.adempiere.webui.component.NumberBox;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Urlbox;
import org.adempiere.webui.editor.IEditorConfiguration;
import org.adempiere.webui.editor.WButtonEditor;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WEditorPopupMenu;
import org.adempiere.webui.editor.WImageEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.ActionEvent;
import org.adempiere.webui.event.ActionListener;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.panel.HelpController;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.GridTabDataBinder;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MStyle;
import org.compiere.model.MSysConfig;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.AbstractComponent;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.sys.ComponentCtrl;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Grid;
import org.zkoss.zul.Html;
import org.zkoss.zul.Label;
import org.zkoss.zul.Paging;
import org.zkoss.zul.RendererCtrl;
import org.zkoss.zul.Row;
import org.zkoss.zul.RowRenderer;
import org.zkoss.zul.RowRendererExt;
import org.zkoss.zul.impl.XulElement;

/**
 * Row renderer for GridTab grid.
 * @author hengsin
 * 
 * @author Teo Sarca, teo.sarca@gmail.com
 * 		<li>BF [ 2996608 ] GridPanel is not displaying time
 * 			https://sourceforge.net/p/adempiere/zk-web-client/420/
 */
public class GridTabRowRenderer implements RowRenderer<Object[]>, RowRendererExt, RendererCtrl, EventListener<Event> {

	/** Cell div component attribute to hold field column name value **/
	protected static final String COLUMN_NAME_ATTR = "columnName";

	/** Cell div component attribute to hold reference to editor component use to create display text for field **/
	private static final String DISPLAY_COMPONENT_ATTR = "display.component";

	/** Boolean execution attribute to indicate execution is handling the "Select" checkbox's ON_CHECK event **/
	private static final String GRID_VIEW_ON_SELECT_ROW_ATTR = "gridView.onSelectRow";

	/** Editor component attribute to store row index (absolute) **/
	public static final String GRID_ROW_INDEX_ATTR = "grid.row.index";
	
	//styles for grid cell
	private static final String CELL_DIV_STYLE = "height: 100%; cursor: pointer; ";
	private static final String CELL_DIV_STYLE_ALIGN_CENTER = CELL_DIV_STYLE + "text-align:center; ";
	private static final String CELL_DIV_STYLE_ALIGN_RIGHT = CELL_DIV_STYLE + "text-align:right; ";
	
	/** default max length for display text for field **/
	private static final int MAX_TEXT_LENGTH_DEFAULT = 60;
	private GridTab gridTab;
	private int windowNo;
	/** Sync field editor changes to GridField **/
	private GridTabDataBinder dataBinder;
	/** field editors **/
	private Map<GridField, WEditor> editors = new LinkedHashMap<GridField, WEditor>();
	/** readonly field editors to get display text for field value **/
	private Map<GridField, WEditor> readOnlyEditors = new LinkedHashMap<GridField, WEditor>();
	private Paging paging;

	/** internal listener for row event **/
	private RowListener rowListener;

	/** Grid that own this renderer **/
	private Grid grid = null;
	/** GridView that uses this renderer **/
	private GridView gridPanel = null;
	/** current focus row **/ 
	private Row currentRow;
	/** values of current row. updated in {@link #render(Row, Object[], int)}. **/
	private Object[] currentValues;
	/** true if currrent row is in edit mode **/
	private boolean editing = false;
	/** index of current row **/
	private int currentRowIndex = -1;
	/** AD window content part that own this renderer **/
	private AbstractADWindowContent m_windowPanel;
	/** internal listener for button ActionEvent **/
	private ActionListener buttonListener;
	/**
	 * Flag detect this view has customized column or not
	 * value is set at {@link #render(Row, Object[], int)}
	 */
	private boolean isGridViewCustomized = false;
	/** DefaultFocusField		*/
	private WEditor	defaultFocusField = null;

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
	
	/**
	 *
	 * @param gridTab
	 * @param windowNo
	 */
	public GridTabRowRenderer(GridTab gridTab, int windowNo) {
		this.gridTab = gridTab;
		this.windowNo = windowNo;
		this.dataBinder = new GridTabDataBinder(gridTab);
	}

	/**
	 * Get editor for GridField.
	 * @param gridField
	 * @return {@link WEditor}
	 */
	private WEditor getEditorCell(GridField gridField) {
		WEditor editor = editors.get(gridField);
		if (editor != null)  {
			prepareFieldEditor(gridField, editor);
			editor.addValueChangeListener(dataBinder);
			gridField.removePropertyChangeListener(editor);
			gridField.addPropertyChangeListener(editor);
			editor.setValue(gridField.getValue());
		}
		return editor;
	}

	/**
	 * Setup field editor
	 * @param gridField
	 * @param editor
	 */
	private void prepareFieldEditor(GridField gridField, WEditor editor) {
			if (editor instanceof WButtonEditor)
            {
				if (buttonListener != null)
				{
					((WButtonEditor)editor).addActionListener(buttonListener);	
				}
				else
				{
					Object window = SessionManager.getAppDesktop().findWindow(windowNo);
	            	if (window != null && window instanceof ADWindow)
	            	{
	            		AbstractADWindowContent windowPanel = ((ADWindow)window).getADWindowContent();
	            		((WButtonEditor)editor).addActionListener(windowPanel);
	            	}
				}
            }

            //streach component to fill grid cell
			if (editor.getComponent() instanceof HtmlBasedComponent) {
            	editor.fillHorizontal();
		}
	}

	/**
	 * @param field
	 * @return column index for field, -1 if not found
	 */
	public int getColumnIndex(GridField field) {
		GridField[] fields = gridPanel.getFields();
		for(int i = 0; i < fields.length; i++) {
			if (fields[i] == field)
				return i;
		}
		return -1;
	}

	/**
	 * @param value
	 * @return readonly checkbox component
	 */
	private Component createReadonlyCheckbox(Object value) {
		Checkbox checkBox = new Checkbox();
		if (value != null && "true".equalsIgnoreCase(value.toString()))
			checkBox.setChecked(true);
		else
			checkBox.setChecked(false);
		checkBox.setDisabled(true);
		return checkBox;
	}

	/**
	 * Create invisible component for GridField with IsHeading=Y.
	 * To fill up space allocated for field component.
	 * @return invisible text box component
	 */
	private Component createInvisibleComponent() {
		Textbox textBox = new Textbox();
		textBox.setDisabled(true);
		textBox.setVisible(false);
		return textBox;
	}

	/**
	 * Check existence of readonly editor and return display text
	 * @param value
	 * @param gridField
	 * @param rowIndex
	 * @return display text
	 */
	protected String getDisplayTextWithEditorCheck(Object value, GridField gridField, int rowIndex) {
		WEditor readOnlyEditor = readOnlyEditors.get(gridField);
		if (readOnlyEditor == null) {
			readOnlyEditor = WebEditorFactory.getEditor(gridField, true, readOnlyEditorConfiguration);
			if (readOnlyEditor != null) {
				readOnlyEditors.put(gridField, readOnlyEditor);
			}
		}
		return getDisplayText(value, gridField, rowIndex);
	}
	
	/**
	 * call {@link #getDisplayText(Object, GridField, int, boolean)} with isForceGetValue = false
	 * @param value
	 * @param gridField
	 * @param rowIndex
	 * @return display text
	 */
	public String getDisplayText(Object value, GridField gridField, int rowIndex){
		return getDisplayText(value, gridField, rowIndex, false);
	}
	
	/**
	 * Get display text of a field. when field have isDisplay = false always return empty string, except isForceGetValue = true
	 * @param value
	 * @param gridField
	 * @param rowIndex
	 * @param isForceGetValue true to return text for field value even if IsDisplay return false. This is to allow Grid customization
	 * to override IsDisplay result.
	 * @return display text
	 */
	private String getDisplayText(Object value, GridField gridField, int rowIndex, boolean isForceGetValue)
	{
		if (value == null)
			return "";

		GridRowCtx gridRowCtx = new GridRowCtx(Env.getCtx(), gridTab, rowIndex);
		if (rowIndex >= 0) {
			if (!isForceGetValue && !gridField.isDisplayed(gridRowCtx, true)) {
				return "";
			}
		}
		
		if (gridField.isEncryptedField())
		{
			return "********";
		}		
		else if (readOnlyEditors.get(gridField) != null) 
		{
			WEditor editor = readOnlyEditors.get(gridField);			
			return editor.getDisplayTextForGridView(gridRowCtx, value);
		}
    	else
    		return value.toString();
	}
	
	/**
	 * get component to display value of a field.
	 * when display is boolean or button, return correspond component
	 * other return a label with text get from {@link #getDisplayText(Object, GridField, int, boolean)} 
	 * @param rowIndex
	 * @param value
	 * @param gridField
	 * @param isForceGetValue true to return Component with value even if IsDisplay return false. This is to allow Grid customization 
	 * preference to override IsDisplay result.
	 * @return {@link Component}
	 */
	private Component getDisplayComponent(int rowIndex, Object value, GridField gridField, boolean isForceGetValue) {
		Component component;
		if (gridField.getDisplayType() == DisplayType.YesNo) {
			component = createReadonlyCheckbox(value);
		} else if (gridField.isHeading()) {
			component = createInvisibleComponent();
		} else if (gridField.getDisplayType() == DisplayType.Button) {
			// Each row renderer --- ctx per row wise
			GridRowCtx gridRowCtx = new GridRowCtx(Env.getCtx(), gridTab, rowIndex);
			WButtonEditor editor = new WButtonEditor(gridField, rowIndex);
			editor.setValue(gridTab.getValue(rowIndex, gridField.getColumnName()));
			editor.setReadWrite(gridField.isEditable(gridRowCtx, true,true));
			editor.getComponent().setAttribute(GRID_ROW_INDEX_ATTR, rowIndex);
			editor.addActionListener(buttonListener);
			component = editor.getComponent();
		} else {
			String text = getDisplayText(value, gridField, rowIndex, isForceGetValue);
			WEditor editor = getEditorCell(gridField);
			if (editor.getDisplayComponent() == null){
				Label label = new Label();
				setLabelText(text, label);
				component = label;
			}else{
				component = editor.getDisplayComponent();
				if (component instanceof Html){
					((Html)component).setContent(text);
				}else{
					throw new UnsupportedOperationException("neet a componet has setvalue function");
				}
			}
		}
		applyFieldStyle(gridField, rowIndex, (HtmlBasedComponent) component);
		return component;
	}

	/**
	 * Apply AD_Style to field.
	 * @param gridField
	 * @param rowIndex
	 * @param component
	 */
	private void applyFieldStyle(GridField gridField, int rowIndex,
			HtmlBasedComponent component) {
		int AD_Style_ID = gridField.getAD_FieldStyle_ID();
		if (AD_Style_ID <= 0)
			return;
		
		GridRowCtx gridRowCtx = new GridRowCtx(Env.getCtx(), gridTab, rowIndex);
		MStyle style = MStyle.get(Env.getCtx(), AD_Style_ID);
		setComponentStyle(component, style.buildStyle(ThemeManager.getTheme(), gridRowCtx));
	}

	/**
	 * Set component's style, sclass or zclass property
	 * @param component
	 * @param style "@sclass=" for sclass for "@zclass=" for zclass. default to style if there's no prefix. 
	 */
	protected  void setComponentStyle(HtmlBasedComponent component, String style) {
		if (style != null && style.startsWith(MStyle.SCLASS_PREFIX)) {
			String sclass = style.substring(MStyle.SCLASS_PREFIX.length());
			if (component instanceof EditorBox)
				((EditorBox)component).getTextbox().setSclass(sclass);
			else
				component.setSclass(sclass);
		} else if (style != null && style.startsWith(MStyle.ZCLASS_PREFIX)) {
			String zclass = style.substring(MStyle.ZCLASS_PREFIX.length());
			if (component instanceof EditorBox)
				((EditorBox)component).getTextbox().setZclass(zclass);
			else
				component.setZclass(zclass);
		} else {
			if (component instanceof EditorBox)
				((EditorBox)component).getTextbox().setStyle(style);
			else
				component.setStyle(style);
		}
	}

	/**
	 * set label text, shorten text if length exceed define max length.
	 * @param text
	 * @param label
	 */
	private void setLabelText(String text, Label label) {
		String display = text;
		final int MAX_TEXT_LENGTH = MSysConfig.getIntValue(MSysConfig.MAX_TEXT_LENGTH_ON_GRID_VIEW,MAX_TEXT_LENGTH_DEFAULT,Env.getAD_Client_ID(Env.getCtx()));
		if (text != null && text.length() > MAX_TEXT_LENGTH)
			display = text.substring(0, MAX_TEXT_LENGTH - 3) + "...";
		label.setValue(display);
		if (text != null && text.length() > MAX_TEXT_LENGTH)
			label.setTooltiptext(text);
	}

	/**
	 * @return field editor list
	 */
	public List<WEditor> getEditors() {
		List<WEditor> editorList = new ArrayList<WEditor>();
		if (!editors.isEmpty())
			editorList.addAll(editors.values());

		return editorList;
	}
	
	/**
	 * @param paging
	 */
	public void setPaging(Paging paging) {
		this.paging = paging;
	}

	/**
	 * Detach all editor and optionally set the current value of the editor as cell label.
	 * @param updateCellLabel
	 */
	public void stopEditing(boolean updateCellLabel) {
		if (!editing) {
			return;
		} else {
			editing = false;
		}
		Row row = null;
		for (Entry<GridField, WEditor> entry : editors.entrySet()) {
			if (entry.getValue().getComponent().getParent() != null) {
				Component child = entry.getValue().getComponent();
				Cell div = null;
				while (div == null && child != null) {
					Component parent = child.getParent();
					if (parent instanceof Cell && parent.getParent() instanceof Row)
						div = (Cell)parent;
					else
						child = parent;
				}
				Component component = div!=null ? (Component) div.getAttribute(DISPLAY_COMPONENT_ATTR) : null;
				if (updateCellLabel) {
					if (component instanceof Label) {
						Label label = (Label)component;
						label.getChildren().clear();
						String text = getDisplayText(entry.getValue().getValue(), entry.getValue().getGridField(), -1);
						setLabelText(text, label);
					} else if (component instanceof Checkbox) {
						Checkbox checkBox = (Checkbox)component;
						Object value = entry.getValue().getValue();
						if (value != null && "true".equalsIgnoreCase(value.toString()))
							checkBox.setChecked(true);
						else
							checkBox.setChecked(false);
					} else if (component instanceof Html){
						((Html)component).setContent(getDisplayText(entry.getValue().getValue(), entry.getValue().getGridField(), -1));
					}
				}
				if (row == null)
					row = ((Row)div.getParent());

				entry.getValue().getComponent().detach();
				entry.getKey().removePropertyChangeListener(entry.getValue());
				entry.getValue().removeValuechangeListener(dataBinder);
				
				if (component.getParent() == null || component.getParent() != div)
					div.appendChild(component);
				else if (!component.isVisible()) {
					component.setVisible(true);
				}
			}
		}

		GridTableListModel model = (GridTableListModel) grid.getModel();
		model.setEditing(false);
	}

	/**
	 * Render data for row.
	 * @param row
	 * @param data Object[] values for row
	 * @param index row index within current page (i.e if page size is 25, index is one of 0 to 24).
	 */
	@Override
	public void render(Row row, Object[] data, int index) throws Exception {
		//don't render if not visible
		int columnCount = 0;
		GridField[] gridPanelFields = null;
		GridField[] gridTabFields = null;
		
		if (gridPanel != null) {
			if (!gridPanel.isVisible()) {
				return;
			}
			else{
				gridPanelFields = gridPanel.getFields();
				columnCount = gridPanelFields.length;
				gridTabFields = gridTab.getFields();
				isGridViewCustomized = gridTabFields.length != gridPanelFields.length;
			}
			gridPanel.autoHideEmptyColumns();
		}
		
		if (grid == null)
			grid = (Grid) row.getParent().getParent();

		if (rowListener == null)
			rowListener = new RowListener((Grid)row.getParent().getParent());
		
		if (!isGridViewCustomized) {
			for(int i = 0; i < gridTabFields.length; i++) {
				if (gridPanelFields[i].getAD_Field_ID() != gridTabFields[i].getAD_Field_ID()) {
					isGridViewCustomized = true;
					break;
				}
			}
		}
		if (!isGridViewCustomized) {
			currentValues = data;
		} else {
			List<Object> dataList = new ArrayList<Object>();
			for(GridField gridField : gridPanelFields) {
				for(int i = 0; i < gridTabFields.length; i++) {
					if (gridField.getAD_Field_ID() == gridTabFields[i].getAD_Field_ID()) {
						dataList.add(data[i]);
						break;
					}
				}
			}
			currentValues = dataList.toArray(new Object[0]);
		}
		
		
		Grid grid = (Grid) row.getParent().getParent();
		org.zkoss.zul.Columns columns = grid.getColumns();

		int rowIndex = index;
		if (paging != null && paging.getPageSize() > 0) {
			rowIndex = (paging.getActivePage() * paging.getPageSize()) + rowIndex;
		}

		Cell cell = new Cell();
		cell.setTooltiptext(Msg.getMsg(Env.getCtx(), "Select"));
		Checkbox selection = new Checkbox();
		selection.setAttribute(GRID_ROW_INDEX_ATTR, rowIndex);
		selection.setChecked(gridTab.isSelected(rowIndex));
		cell.setStyle("border: none;");
		selection.addEventListener(Events.ON_CHECK, this);
		
		if (!selection.isChecked()) {
			if (gridPanel.selectAll.isChecked()) {
				gridPanel.selectAll.setChecked(false);
			}
		}
		
		cell.appendChild(selection);
		row.appendChild(cell);
		
		if (isShowCurrentRowIndicatorColumn()) {
			cell = new Cell();
			cell.addEventListener(Events.ON_CLICK, this);
			cell.setStyle("border: none;");
			cell.setTooltiptext(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "EditRecord")));
			if (ThemeManager.isUseFontIconForImage()) {
				Label indicatorLabel = new Label();
				cell.appendChild(indicatorLabel);
				final Cell finalCell = cell;
				indicatorLabel.addEventListener(Events.ON_CLICK, evt->Events.postEvent(Events.ON_CLICK, finalCell, indicatorLabel.getSclass()));
			}
			cell.setValign("middle");
			row.appendChild(cell);
		}
		
		Boolean isActive = null;
		int colIndex = -1;
		for (int i = 0; i < columnCount; i++) {
			if (editors.get(gridPanelFields[i]) == null) {
			  WEditor editor = WebEditorFactory.getEditor(gridPanelFields[i], true);
			  if (editor != null) {
				editors.put(gridPanelFields[i], editor);
				if (editor instanceof WButtonEditor) {
					((WButtonEditor)editor).addActionListener(buttonListener);
				}
				
				//readonly for display text
				WEditor readOnlyEditor = WebEditorFactory.getEditor(gridPanelFields[i], true, readOnlyEditorConfiguration);
				if (readOnlyEditor != null) {
					readOnlyEditors.put(gridPanelFields[i], readOnlyEditor);
				}
								    			
    			if (editor.getComponent() instanceof AbstractComponent) {
    				editor.getComponent().setWidgetOverride("fieldHeader", HelpController.escapeJavascriptContent(gridPanelFields[i].getHeader()));
        			editor.getComponent().setWidgetOverride("fieldDescription", HelpController.escapeJavascriptContent(gridPanelFields[i].getDescription()));
        			editor.getComponent().setWidgetOverride("fieldHelp", HelpController.escapeJavascriptContent(gridPanelFields[i].getHelp()));
    				editor.getComponent().setWidgetListener("onFocus", "zWatch.fire('onFieldTooltip', this, null, this.fieldHeader(), this.fieldDescription(), this.fieldHelp());");
    				((AbstractComponent)editor.getComponent()).addCallback(ComponentCtrl.AFTER_PAGE_DETACHED, (t) -> {((AbstractComponent)t).setWidgetListener("onFocus", null);});
    			}
    			
    			//	Default Focus
    			if (defaultFocusField == null && gridPanelFields[i].isDefaultFocus())
    				defaultFocusField = editor;
			  }
			}
			
			if ("IsActive".equals(gridPanelFields[i].getColumnName())) {
				isActive = Boolean.FALSE;
				if (currentValues[i] != null) {
					if ("true".equalsIgnoreCase(currentValues[i].toString())) {
						isActive = Boolean.TRUE;
					}
				}
			}
			
			// IDEMPIERE-2148: when has tab customize, ignore check properties isDisplayedGrid
			if ((!isGridViewCustomized && gridPanelFields[i].isDisplayedGrid()) || gridPanelFields[i].isToolbarOnlyButton()) {
				continue;
			}
			colIndex ++;

			Cell div = new Cell();
			String divStyle = CELL_DIV_STYLE;
			org.zkoss.zul.Column column = (org.zkoss.zul.Column) columns.getChildren().get(colIndex);
			if (column.isVisible()) {
				Component component = getDisplayComponent(rowIndex, currentValues[i], gridPanelFields[i], isGridViewCustomized);
				div.appendChild(component);
				div.setAttribute(DISPLAY_COMPONENT_ATTR, component);
				if (gridPanelFields[i].isHeading()) {
					component.setVisible(false);
				}

				if (DisplayType.YesNo == gridPanelFields[i].getDisplayType() || DisplayType.Image == gridPanelFields[i].getDisplayType()) {
					divStyle = CELL_DIV_STYLE_ALIGN_CENTER;
				}
				else if (DisplayType.isNumeric(gridPanelFields[i].getDisplayType())) {
					divStyle = CELL_DIV_STYLE_ALIGN_RIGHT;
				}
				
				GridRowCtx ctx = new GridRowCtx(Env.getCtx(), gridTab, rowIndex);
				if (!gridPanelFields[i].isDisplayedGrid(ctx, true)){
					// IDEMPIERE-2253 
					component.setVisible(false);
				}
			}
			div.setStyle(divStyle);
			ZKUpdateUtil.setWidth(div, "100%");
			div.setAttribute(COLUMN_NAME_ATTR, gridPanelFields[i].getColumnName());
			div.addEventListener(Events.ON_CLICK, rowListener);
			div.addEventListener(Events.ON_DOUBLE_CLICK, rowListener);						
			row.appendChild(div);
		}

		if (rowIndex == gridTab.getCurrentRow()) {
			setCurrentRow(row);
		}
		
		row.setStyle("cursor:pointer");
		row.addEventListener(Events.ON_CLICK, rowListener);
		row.addEventListener(Events.ON_OK, rowListener);
		row.setTooltiptext(Msg.getMsg(Env.getCtx(), "Row") + " " + (rowIndex+1));
		
		if (isActive == null) {
			Object isActiveValue = gridTab.getValue(rowIndex, "IsActive");
			if (isActiveValue != null) {
				if ("true".equalsIgnoreCase(isActiveValue.toString())) {							
					isActive = Boolean.TRUE;
				} else {
					isActive = Boolean.FALSE;
				}
			}
		}
		if (isActive != null && !isActive.booleanValue()) {
			LayoutUtils.addSclass("grid-inactive-row", row);
		}
		
		//IDEMPIERE-4165 After adding a new row to the list (New or copy) repaint the grid when rendering the last row  
		if (gridTab.isNew() && rowIndex == grid.getRows().getChildren().size()-1) {
			grid.invalidate();
		}

		if (MSysConfig.getBooleanValue(MSysConfig.ZK_GRID_VIEW_USE_DEFER_RENDERING, false, Env.getAD_Client_ID(Env.getCtx())))
			row.setRenderdefer(1);
	}

	/**
	 * @param row
	 */
	public void setCurrentRow(Row row) {
		if (currentRow != null && currentRow.getParent() != null && currentRow != row && isShowCurrentRowIndicatorColumn()) {
			Cell cell = (Cell) currentRow.getChildren().get(1);
			if (cell != null) {
				cell.setSclass("row-indicator");
				if (cell.getFirstChild() != null)
					((Label)cell.getFirstChild()).setSclass("");
			}
		}
		currentRow = row;
		Cell cell = (Cell) currentRow.getChildren().get(1);
		if (cell != null && isShowCurrentRowIndicatorColumn()) {
			if (ThemeManager.isUseFontIconForImage()) 
			{
				Label indicatorLabel = (Label) cell.getFirstChild();
				indicatorLabel.setSclass("row-indicator-selected z-icon-Edit");
			}
			else
				cell.setSclass("row-indicator-selected");
		}
		currentRowIndex = gridTab.getCurrentRow();
		
		if (currentRowIndex == gridTab.getCurrentRow()) {
			if (editing) {
				stopEditing(false);
				editCurrentRow();
			}
		} else {
			currentRowIndex = gridTab.getCurrentRow();
			if (editing) {
				stopEditing(false);
			}
		}
		
		String script = "jq('#"+row.getUuid()+"').addClass('highlight').siblings().removeClass('highlight')";

		Boolean isActive = null;
		Object isActiveValue = gridTab.getValue(currentRowIndex, "IsActive");
		if (isActiveValue != null) {
			if ("true".equalsIgnoreCase(isActiveValue.toString())) {							
				isActive = Boolean.TRUE;
			} else {
				isActive = Boolean.FALSE;
			}
		}
		if (isActive != null && !isActive.booleanValue()) {
			script = "jq('#"+row.getUuid()+"').addClass('grid-inactive-row').siblings().removeClass('highlight')";
		}
		
		Clients.response(new AuScript(script));
	}

	/**
	 * @return current {@link Row}
	 */
	public Row getCurrentRow() {
		return currentRow;
	}

	/**
	 * @return current row index ( absolute )
	 */
	public int getCurrentRowIndex() {
		return currentRowIndex;
	}

	/**
	 * Enter edit mode for current focus row.
	 */
	public void editCurrentRow() {
		if (ClientInfo.isMobile()) {
			if (!MSysConfig.getBooleanValue(MSysConfig.ZK_GRID_MOBILE_EDITABLE, false))
				return;
		}
		if (currentRow != null && currentRow.getParent() != null && currentRow.isVisible()
			&& grid != null && grid.isVisible() && grid.getParent() != null && grid.getParent().isVisible()) {
			GridField[] gridPanelFields = gridPanel.getFields();
			int columnCount = gridPanelFields.length;
			org.zkoss.zul.Columns columns = grid.getColumns();
			//skip selection and indicator column
			int colIndex = isShowCurrentRowIndicatorColumn() ? 1 : 0;
			for (int i = 0; i < columnCount; i++) {
				if ((!isGridViewCustomized && !gridPanelFields[i].isDisplayedGrid()) || gridPanelFields[i].isToolbarOnlyButton()) {
					continue;
				}
				colIndex ++;
				
				if (editors.get(gridPanelFields[i]) == null)
					editors.put(gridPanelFields[i], WebEditorFactory.getEditor(gridPanelFields[i], true));

				org.zkoss.zul.Column column = (org.zkoss.zul.Column) columns.getChildren().get(colIndex);
				if (column.isVisible()) {
					Cell div = (Cell) currentRow.getChildren().get(colIndex);					
					WEditor editor = getEditorCell(gridPanelFields[i]);
					if (div.getChildren().isEmpty() || !(div.getChildren().get(0) instanceof Button))
						div.getChildren().clear();
					else if (!div.getChildren().isEmpty()) {
						div.getChildren().get(0).setVisible(false);
					}
					div.appendChild(editor.getComponent());
					WEditorPopupMenu popupMenu = editor.getPopupMenu();

		            if (popupMenu != null)
		            {
		            	popupMenu.addMenuListener((ContextMenuListener)editor);
		            	div.appendChild(popupMenu);
		            	Component editorComponent = editor.getComponent();
		            	if (editorComponent instanceof XulElement)
		            		popupMenu.addContextElement((XulElement) editorComponent);		            	
		            }		  
		            
		            
		            Properties ctx = isDetailPane() ? new GridRowCtx(Env.getCtx(), gridTab) 
		            	: gridPanelFields[i].getVO().ctx;
		            //check context
					if (!gridPanelFields[i].isDisplayedGrid(ctx, true)){
						// IDEMPIERE-2253 
						editor.getComponent().setVisible(false);
					}
					
					editor.setReadWrite(gridPanelFields[i].isEditableGrid(true));
				}
			}
			editing = true;

			GridTableListModel model = (GridTableListModel) grid.getModel();
			model.setEditing(true);

		}
	}

	/**
	 * @return true if it is own by {@link DetailPane}.
	 */
	private boolean isDetailPane() {
		Component parent = grid.getParent();
		while (parent != null) {
			if (parent instanceof DetailPane) {
				return true;
			} 
			parent = parent.getParent();					
		}
		return false;
	}

	/**
	 * @see RowRendererExt#getControls()
	 */
	@Override
	public int getControls() {
		return DETACH_ON_RENDER;
	}

	/**
	 * @see RowRendererExt#newCell(Row)
	 */
	@Override
	public Component newCell(Row row) {
		return null;
	}

	/**
	 * @see RowRendererExt#newRow(Grid)
	 */
	@Override
	public Row newRow(Grid grid) {
		return null;
	}

	/**
	 * @see RendererCtrl#doCatch(Throwable)
	 */
	@Override
	public void doCatch(Throwable ex) throws Throwable {
	}

	/**
	 * @see RendererCtrl#doFinally()
	 */
	@Override
	public void doFinally() {
	}

	/**
	 * @see RendererCtrl#doTry()
	 */
	@Override
	public void doTry() {
	}

	/**
	 * Set focus to first writable field editor (or default focus field editor if it is writable).
	 * If no field editor is writable, set focus to first visible field editor.
	 */
	public void focusToFirstEditor() {
		if (currentRow != null && currentRow.getParent() != null) {
			WEditor toFocus = null;
			WEditor firstEditor = null;
			if (defaultFocusField != null 
					&& defaultFocusField.isVisible() && defaultFocusField.isReadWrite() && defaultFocusField.getComponent().getParent() != null
					&& !(defaultFocusField instanceof WImageEditor)) {
				toFocus = defaultFocusField;
			}
			else
			{
				for (WEditor editor : getEditors()) {
					if (editor.isVisible() && editor.getComponent().getParent() != null) {
						if (editor.isReadWrite()) {
							toFocus = editor;
							break;
						}
						if (firstEditor == null)
							firstEditor = editor;
					}
				}
			}
			if (toFocus != null) {
				focusToEditor(toFocus);
			} else if (firstEditor != null) {
				focusToEditor(firstEditor);
			}
		}
	}

	/**
	 * @param toFocus
	 */
	protected void focusToEditor(WEditor toFocus) {
		Component c = toFocus.getComponent();
		if (c instanceof EditorBox) {
			c = ((EditorBox)c).getTextbox();
		} else if (c instanceof NumberBox) {
			c = ((NumberBox)c).getDecimalbox();
		} else if (c instanceof Urlbox) {
			c = ((Urlbox) c).getTextbox();
		}
		((HtmlBasedComponent)c).focus();
	}
	
	/**
	 * set focus to next writable editor from ref
	 * @param ref
	 */
	public void focusToNextEditor(WEditor ref) {
		boolean found = false;
		for (WEditor editor : getEditors()) {
			if (editor == ref) {
				found = true;
				continue;
			}
			if (found) {
				if (editor.isVisible() && editor.isReadWrite()) {
					focusToEditor(editor);
					break;
				}
			}
		}
	}

	/**
	 * Set {@link GridView} that own this renderer.
	 * @param gridPanel
	 */
	public void setGridPanel(GridView gridPanel) {
		this.gridPanel = gridPanel;
	}

	/**
	 * Internal listener for row event (ON_CLICK, ON_DOUBLE_CLICK and ON_OK).
	 */
	static class RowListener implements EventListener<Event> {

		private Grid _grid;

		public RowListener(Grid grid) {
			_grid = grid;
		}

		public void onEvent(Event event) throws Exception {
			if (Events.ON_CLICK.equals(event.getName())) {
				if (Executions.getCurrent().getAttribute(GRID_VIEW_ON_SELECT_ROW_ATTR) != null)
					return;
				Event evt = new Event(Events.ON_CLICK, _grid, event.getTarget());
				Events.sendEvent(_grid, evt);
				evt.stopPropagation();
			}
			else if (Events.ON_DOUBLE_CLICK.equals(event.getName())) {
				Event evt = new Event(Events.ON_DOUBLE_CLICK, _grid, _grid);
				Events.sendEvent(_grid, evt);
			}
			else if (Events.ON_OK.equals(event.getName())) {
				Event evt = new Event(Events.ON_OK, _grid, _grid);
				Events.sendEvent(_grid, evt);
			}
		}
	}

	/**
	 * @return true if current row is in edit mode, false otherwise
	 */
	public boolean isEditing() {
		return editing;
	}

	/**
	 * Set AD window content part that own this renderer.
	 * {@link #buttonListener} need this to call {@link AbstractADWindowContent#actionPerformed(ActionEvent)}.
	 * @param windowPanel
	 */
	public void setADWindowPanel(AbstractADWindowContent windowPanel) {
		if (this.m_windowPanel == windowPanel)
			return;
		
		this.m_windowPanel = windowPanel;
		
		buttonListener = new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				WButtonEditor editor = (WButtonEditor) event.getSource();
				Integer rowIndex = (Integer) editor.getComponent().getAttribute(GRID_ROW_INDEX_ATTR);
				if (rowIndex != null) {
					int newRowIndex = gridTab.navigate(rowIndex);
					if (newRowIndex == rowIndex) {
						m_windowPanel.actionPerformed(event);
					}
				} else {
					m_windowPanel.actionPerformed(event);
				}
			}
		};
	}

	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getTarget() instanceof Cell) {
			Cell cell = (Cell) event.getTarget();
			if (cell.getSclass() != null && cell.getSclass().indexOf("row-indicator-selected") >= 0)
				Events.sendEvent(gridPanel, new Event(DetailPane.ON_EDIT_EVENT, gridPanel));
			else if (event.getData() != null && event.getData().toString().indexOf("row-indicator-selected") >= 0)
				Events.sendEvent(gridPanel, new Event(DetailPane.ON_EDIT_EVENT, gridPanel));
			else
				Events.sendEvent(event.getTarget().getParent(), event);
		} else if (event.getTarget() instanceof Checkbox) {
			Executions.getCurrent().setAttribute(GRID_VIEW_ON_SELECT_ROW_ATTR, Boolean.TRUE);
			Checkbox checkBox = (Checkbox) event.getTarget();
			Events.sendEvent(gridPanel, new Event("onSelectRow", gridPanel, checkBox));
		}
	}

	/**
	 * @return {@link GridView#isShowCurrentRowIndicatorColumn}
	 */
	private boolean isShowCurrentRowIndicatorColumn() {
		return gridPanel != null && gridPanel.isShowCurrentRowIndicatorColumn();
	}

}
