/******************************************************************************
 * Copyright (C) 2016 Logilite Technologies LLP								  *
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

import org.adempiere.util.GridRowCtx;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.Checkbox;
import org.adempiere.webui.component.Combinationbox;
import org.adempiere.webui.component.Combobox;
import org.adempiere.webui.component.Datebox;
import org.adempiere.webui.component.DatetimeBox;
import org.adempiere.webui.component.EditorBox;
import org.adempiere.webui.component.FilenameBox;
import org.adempiere.webui.component.Locationbox;
import org.adempiere.webui.component.NumberBox;
import org.adempiere.webui.component.PAttributebox;
import org.adempiere.webui.component.Paymentbox;
import org.adempiere.webui.component.Searchbox;
import org.adempiere.webui.component.Textbox;
import org.adempiere.webui.component.Urlbox;
import org.adempiere.webui.editor.WButtonEditor;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WNumberEditor;
import org.adempiere.webui.editor.WPAttributeEditor;
import org.adempiere.webui.editor.WSearchEditor;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.ActionEvent;
import org.adempiere.webui.event.ActionListener;
import org.adempiere.webui.session.SessionManager;
import org.adempiere.webui.util.GridTabDataBinder;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.au.out.AuScript;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.KeyEvent;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Column;
import org.zkoss.zul.Grid;
import org.zkoss.zul.Paging;
import org.zkoss.zul.RendererCtrl;
import org.zkoss.zul.Row;
import org.zkoss.zul.RowRenderer;
import org.zkoss.zul.RowRendererExt;
import org.zkoss.zul.Timebox;

/**
 * Row renderer for Quick GridTab grid.
 * 
 * @author Logilite Technologies
 * @since Nov 03, 2017
 */
public class QuickGridTabRowRenderer
		implements RowRenderer<Object[]>, RowRendererExt, RendererCtrl, EventListener<Event> {

	public static final String	IS_QUICK_FORM_COMPONENT	= "IS_QUICK_FORM_COMPONENT";
	public static final String GRID_ROW_INDEX_ATTR = "grid.row.index";
	private static final String CELL_DIV_STYLE = "height: 100%; cursor: pointer; ";
	private static final String CELL_DIV_STYLE_ALIGN_CENTER = CELL_DIV_STYLE + "text-align:center; ";
	private static final String CELL_DIV_STYLE_ALIGN_RIGHT = CELL_DIV_STYLE + "text-align:right; ";
	public static final String CURRENT_ROW_STYLE = "border-top: 2px solid #6f97d2; border-bottom: 2px solid #6f97d2";
	// CSS for Disabled component to visible text properly.
	public static final String CSS_READ_ONLY_COMPONENT = "quickform-readonly ";

	private GridTab gridTab;
	private int windowNo;
	private GridTabDataBinder dataBinder;
	private Paging paging;

	private RowListener rowListener;

	private Grid grid = null;
	private QuickGridView gridPanel = null;
	private Row currentRow;
	private Object[] currentValues;
	private boolean editing = false;
	public int currentRowIndex = -1;
	private AbstractADWindowContent m_windowPanel;
	private ActionListener buttonListener;
	// Row-wise Editors Map
	public Map<Row, ArrayList<WEditor>>	editorsListMap					= new LinkedHashMap<Row, ArrayList<WEditor>>();
	// Row-wise read-only Editors Map
	public Map<Row, ArrayList<WEditor>>	readOnlyEditorsListMap			= new LinkedHashMap<Row, ArrayList<WEditor>>();
	/**
	 * Flag detect this view has customized column or not
	 * value is set at {@link #render(Row, Object[], int)}
	 */
	private boolean						isGridViewCustomized		= false;
	// Keep track of shorted column in Quick form.
	private Column						sortedColumn				= null;
	// Keep track of sorting order of column in Quick form. for e.g Ascending, Descending and Natural
	private String						sortOrder;

	/**
	 *
	 * @param gridTab
	 * @param windowNo
	 */
	public QuickGridTabRowRenderer(GridTab gridTab, int windowNo) {
		this.gridTab = gridTab;
		this.windowNo = windowNo;
		this.dataBinder = new GridTabDataBinder(gridTab);
	}

	private WEditor getEditorCell(GridField gridField, Object object) {
		WEditor editor = WebEditorFactory.getEditor(gridField, true);
		if (editor != null) {
			prepareFieldEditor(gridField, editor);
			editor.setValue(object);
		}
		return editor;
	}

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

            //Stretch component to fill grid cell
			if (editor.getComponent() instanceof HtmlBasedComponent) {
            	editor.fillHorizontal();
		}
	}

	public int getColumnIndex(GridField field) {
		GridField[] fields = gridPanel.getFields();
		for(int i = 0; i < fields.length; i++) {
			if (fields[i] == field)
				return i;
		}
		return 0;
	}

	/**
	 * @param paging
	 */
	public void setPaging(Paging paging) {
		this.paging = paging;
	}

	/**
	 * @param row
	 * @param data
	 * @param index
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
					gridTabFields[i].setValue(data[i], !gridPanel.isNewLineSaved);
					if (gridField.getAD_Field_ID() == gridTabFields[i].getAD_Field_ID()) {
						// Update value of gridField for Context Parsing.
						gridField.setValue(data[i], !gridPanel.isNewLineSaved);
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
		
		Boolean isActive = null;
		int colIndex = -1;
		// Editors List of Current Rendered Row
		ArrayList<WEditor> editorsList = new ArrayList<WEditor>();
		// Read-only editors List of Current Rendered Row
		ArrayList<WEditor> readOnlyEditorsList = new ArrayList<WEditor>();
		for (int i = 0; i < columnCount; i++) {
			if (!gridPanelFields[i].isQuickForm()){
				continue;
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
				WEditor componentEditor = getEditorCell(gridPanelFields[i], currentValues[i]);
				editorsList.add(componentEditor);
				componentEditor.getComponent().addEventListener(Events.ON_FOCUS, gridPanel);
				Component component = componentEditor.getComponent();
				component.setAttribute(IS_QUICK_FORM_COMPONENT, true);
				div.appendChild(component);
				div.setAttribute("display.component", component);
				if (componentEditor instanceof WPAttributeEditor)
				{
					((WPAttributeEditor) componentEditor).getComponent().getButton().addEventListener(Events.ON_FOCUS, gridPanel);
				}
				else if (componentEditor instanceof WSearchEditor)
				{
					((WSearchEditor) componentEditor).getComponent().getButton().addEventListener(Events.ON_FOCUS, gridPanel);
				}
				else if (componentEditor instanceof WNumberEditor)
				{
					((WNumberEditor) componentEditor).getComponent().getButton().addEventListener(Events.ON_FOCUS, gridPanel);
				}
				if (gridPanelFields[i].isHeading()) {
					component.setVisible(false);
				}

				if (DisplayType.YesNo == gridPanelFields[i].getDisplayType() || DisplayType.Image == gridPanelFields[i].getDisplayType())
				{
					divStyle = CELL_DIV_STYLE_ALIGN_CENTER;
				}
				else if (DisplayType.isNumeric(gridPanelFields[i].getDisplayType()))
				{
					divStyle = CELL_DIV_STYLE_ALIGN_RIGHT;
				}
				if (isDisableReadonlyComponent(component, true))
				{
					readOnlyEditorsList.add(componentEditor);
				}
				
				GridRowCtx ctx = new GridRowCtx(Env.getCtx(), gridTab, rowIndex);
				// Enable or Disable Component
				componentEditor.setReadWrite(gridPanelFields[i].isEditable(ctx, true, false));
				if (!gridPanelFields[i].isDisplayed(ctx, true)){
					// IDEMPIERE-2253 
					component.setVisible(false);
				}
			}
			div.setStyle(divStyle);
			ZKUpdateUtil.setWidth(div, "100%");
			div.setAttribute("columnName", gridPanelFields[i].getColumnName());
			div.addEventListener(Events.ON_CLICK, rowListener);
			div.addEventListener(Events.ON_DOUBLE_CLICK, rowListener);						
			editing = true;
			GridTableListModel model = (GridTableListModel) grid.getModel();
			model.setEditing(true);
			row.appendChild(div);
		}

		editorsListMap.put(row, editorsList);
		readOnlyEditorsListMap.put(row, readOnlyEditorsList);

		if (rowIndex == gridTab.getCurrentRow()) {
			setCurrentRow(row);
		}
		
		row.setStyle("cursor:pointer");
		row.addEventListener(Events.ON_CLICK, rowListener);
		row.addEventListener(Events.ON_OK, rowListener);
		row.setTooltiptext("Row " + (rowIndex+1));
		
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
		if (gridTab.isNew())
			gridPanel.isNewLineSaved = false;
		// Set focus to first editable cell of the last record if multiple
		// records inserted
		if (gridPanel.paging.getTotalSize() != gridTab.getRowCount())
		{
			gridPanel.updateListIndex();
			if (!gridPanel.isNewLineSaved)
			{
			        gridPanel.isNewLineSaved = true;
				paging.setActivePage(
						paging.getActivePage() + (paging.getActivePage() == (paging.getPageCount() - 1) ? 0 : 1));
				gridPanel.listModel.setPage(paging.getActivePage());
				gridPanel.updateModelIndex(0);
				setCurrentCell(gridTab.getRowCount() - 1 % paging.getPageSize()
						- (paging.getActivePage() * paging.getPageSize()), 1, KeyEvent.RIGHT);
			}
			Events.echoEvent(QuickGridView.EVENT_ON_SET_FOCUS_TO_FIRST_CELL, gridPanel, null);
		}

		// When shorting is done all rows are rendered and focus is lost.
		// If record are shorting then set focus to the first row of the current page.
		Column column = gridPanel.findCurrentSortColumn();
		if (column != null && gridPanel.isNewLineSaved && (sortedColumn == null || sortedColumn != column
				|| (sortedColumn == column && sortOrder != column.getSortDirection())))
		{
			sortedColumn = column;
			sortOrder = column.getSortDirection();
			Events.echoEvent(QuickGridView.EVENT_ON_PAGE_NAVIGATE, gridPanel, null);
		}
	}

	/**
	 * Disable Read-only components for while pressing tab button focus goes to
	 * read-only component.
	 * Enable Read-only component before display Logic update.
	 * Add/Remove CSS Class from read-only component
	 * 
	 * @param component
	 * @param isDisable
	 * @return
	 */
	public boolean isDisableReadonlyComponent(Component component, boolean isDisable)
	{
		boolean isReadonly = false;
		if (component instanceof NumberBox)
		{
			NumberBox comp = ((NumberBox) component);
			if (comp.getDecimalbox().isReadonly())
			{
				comp.getDecimalbox().setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		else if (component instanceof Textbox)
		{
			Textbox comp = ((Textbox) component);
			if (comp.isReadonly())
			{
				comp.setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		else if (component instanceof Datebox)
		{
			Datebox comp = ((Datebox) component);
			if (comp.isReadonly())
			{
				comp.setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		else if (component instanceof DatetimeBox)
		{
			DatetimeBox comp = ((DatetimeBox) component);
			if (comp.getTimebox().isReadonly())
			{
				comp.getTimebox().setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
			if (comp.getDatebox().isReadonly())
			{
				comp.getDatebox().setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		else if (component instanceof Searchbox)
		{
			Searchbox comp = ((Searchbox) component);
			if (comp.getTextbox().isReadonly())
			{
				comp.getTextbox().setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		else if (component instanceof Combinationbox)
		{
			Combinationbox comp = ((Combinationbox) component);
			if (comp.getTextbox().isReadonly())
			{
				comp.getTextbox().setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		else if (component instanceof EditorBox)
		{
			EditorBox comp = ((EditorBox) component);
			if (comp.getTextbox().isReadonly())
			{
				comp.getTextbox().setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		else if (component instanceof Urlbox)
		{
			Urlbox comp = ((Urlbox) component);
			if (comp.getTextbox().isReadonly())
			{
				comp.getTextbox().setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		else if (component instanceof FilenameBox)
		{
			FilenameBox comp = ((FilenameBox) component);
			if (comp.getTextbox().isReadonly())
			{
				comp.getTextbox().setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		else if (component instanceof Timebox)
		{
			Timebox comp = ((Timebox) component);
			if (comp.isReadonly())
			{
				comp.setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		else if (component instanceof Paymentbox)
		{
			Paymentbox comp = ((Paymentbox) component);
			if (comp.getCombobox().isReadonly())
			{
				comp.getCombobox().setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		else if (component instanceof PAttributebox)
		{
			PAttributebox comp = ((PAttributebox) component);
			if (comp.getTextbox().isReadonly())
			{
				comp.getTextbox().setDisabled(isDisable);
				comp.setZclass(addOrRemoveCssClass(comp.getZclass(), isDisable));
				isReadonly = true;
			}
		}
		return isReadonly;
	}

	/**
	 * Add/Remove CSS class from Read-only Component
	 * 
	 * @param zclass
	 * @param isDisable
	 * @return
	 */
	private String addOrRemoveCssClass(String zclass, boolean isDisable)
	{
		if (zclass == null)
			zclass = "";
		if (isDisable)
		{
			zclass += CSS_READ_ONLY_COMPONENT;
		}
		else
		{
			if (zclass.contains(CSS_READ_ONLY_COMPONENT))
				zclass.replaceAll(CSS_READ_ONLY_COMPONENT, "");
		}
		return zclass;
	}

	private Cell currentCell = null;

	public Cell getCurrentCell() {
		return currentCell;
	}

	public void setCurrentCell(Cell currentCell) {
		this.currentCell = currentCell;
	}

	public void setCurrentCell(int row, int col, int code) {
		if (col < 0 || row < 0)
			return;
		int currentCol = col;
		boolean isLastCell = false;
		while (!isEditable(row, col))
		{
			if (!(code == KeyEvent.RIGHT || code == KeyEvent.LEFT || code == KeyEvent.DOWN || code == KeyEvent.UP
					|| code == QuickGridView.NAVIGATE_CODE))
			{
				break;
			}
			else if (code == KeyEvent.RIGHT || code == QuickGridView.NAVIGATE_CODE)
			{
				++col;
			}
			else if (code == KeyEvent.LEFT)
			{
				--col;
			}
			// on UP/DOWN go to next editable field if move field is not
			// editable
			else if (code == KeyEvent.DOWN || code == KeyEvent.UP)
			{
				if (isLastCell)
				{
					col--;

				}
				else
				{
					col++;
					if (col > gridPanel.getGridField().length)
					{
						col = currentCol;
						isLastCell = true;
					}

				}
			}

			if (col < 0 && !isLastCell)
			{
				setFocusOnCurrentCell();
				return;
			}
		}
		if (isAddRemoveListener(code))
		{
			// Remove current row property change listener
			addRemovePropertyChangeListener(false, col);
		}

		int pgIndex = row >= 0 ? row % paging.getPageSize() : 0;
		if (row != currentRowIndex || pgIndex != currentRowIndex) {
			if (currentRow != null)
				currentRow.setStyle(null);
			if (grid.getRows().getChildren().size() <= 0) {
				currentCell = null;
				return;
			}
			gridTab.setCurrentRow(pgIndex + paging.getActivePage() * paging.getPageSize());
			currentRow = ((Row) grid.getRows().getChildren().get(pgIndex));
			currentRowIndex = gridTab.getCurrentRow();
			currentRow.setStyle(CURRENT_ROW_STYLE);
		}
		
		setCurrentRow(currentRow);
		
		if (isAddRemoveListener(code))
		{
			// Add property change listener to new current row
			addRemovePropertyChangeListener(true, col);
		}

		if (grid.getCell(pgIndex, col) instanceof Cell) {
			currentCell = (Cell) grid.getCell(pgIndex, col);
		}
		if (currentCell != null && code != QuickGridView.FOCUS_CODE) {
			setFocusOnCurrentCell();
		} 
	}

	/**
	 * Set Property change listener of editor field
	 * 
	 * @param editorsList
	 */
	private void addEditorPropertyChangeListener(ArrayList<WEditor> editorsList)
	{
		GridField[] fields = gridPanel.getFields();
		for (int i = 0; i < editorsList.size(); i++)
		{
			editorsList.get(i).addValueChangeListener(dataBinder);
			fields[i].removePropertyChangeListener(editorsList.get(i));
			fields[i].addPropertyChangeListener(editorsList.get(i));
		}
	}

	/**
	 * Remove Property change listener of editor field
	 * 
	 * @param editorsList
	 */
	private void removeEditorPropertyChangeListener(ArrayList<WEditor> editorsList)
	{
		GridField[] fields = gridPanel.getFields();
		for (int i = 0; i < editorsList.size(); i++)
		{
			fields[i].removePropertyChangeListener(editorsList.get(i));
			editorsList.get(i).removeValuechangeListener(dataBinder);
		}
	}
	
	/**
	 * If true add Property Change Listener, a false Remove Property Change Listener
	 * 
	 * @param isAddListener
	 * @param col 
	 */
	public void addRemovePropertyChangeListener(boolean isAddListener, int col)
	{
		ArrayList<WEditor> editorsList = editorsListMap.get(getCurrentRow());
		if (editorsList != null)
		{
			if (isAddListener)
			{
				addEditorPropertyChangeListener(editorsList);
				gridPanel.dynamicDisplay(col);
			}
			else
			{
				removeEditorPropertyChangeListener(editorsList);
			}
		}
	} // addRemovePropertyChangeListener
	
	/**
	 * @param code
	 * @return
	 */
	public Boolean isAddRemoveListener(int code)
	{
		if (code == KeyEvent.DOWN || code == KeyEvent.UP || code == QuickGridView.FOCUS_CODE
				|| code == QuickGridView.NAVIGATE_CODE || code == KeyEvent.HOME)
			return true;
		return false;
	} // isAddRemoveListener
	
	/**
	 * @param row
	 */
	public void setRowTo(int row)
	{
		int pgIndex = row >= 0 ? row % paging.getPageSize() : 0;
		currentRow = ((Row) grid.getRows().getChildren().get(pgIndex));
		currentRow.setStyle(QuickGridTabRowRenderer.CURRENT_ROW_STYLE);
		setCurrentRow(currentRow);
	}

	private boolean isEditable(int row, int col)
	{
		Cell cell = null;

		if (col > getCurrentRow().getChildren().size())
			return true;

		if (grid.getCell(row, col) instanceof Cell)
			cell = (Cell) grid.getCell(row, col);
		else
			return true;

		if (cell == null)
			return true;
		if (cell.getChildren().size() <= 0)
			return false;
		// get component of cell
		Component component = cell.getChildren().get(0);
		if (component instanceof NumberBox && (!((NumberBox) component).getDecimalbox().isDisabled() && !((NumberBox) component).getDecimalbox().isReadonly() && ((NumberBox) component).getDecimalbox().isVisible()))
			return true;
		else if (component instanceof Checkbox && (((Checkbox) component).isEnabled() && ((Checkbox) component).isVisible()))
			return true;
		else if (component instanceof Combobox && (!((Combobox) component).isReadonly() && ((Combobox) component).isEnabled() && ((Combobox) component).isVisible()))
			return true;
		else if (component instanceof Textbox && (!((Textbox) component).isDisabled() && !((Textbox) component).isReadonly() && ((Textbox) component).isVisible()))
			return true;
		else if (component instanceof Datebox && (!((Datebox) component).isReadonly() && ((Datebox) component).isEnabled() && ((Datebox) component).isVisible()))
			return true;
		else if (component instanceof DatetimeBox && (((DatetimeBox) component).isEnabled() && ((DatetimeBox) component).isVisible()))
			return true;
		else if (component instanceof Locationbox && (((Locationbox) component).isEnabled() && ((Locationbox) component).isVisible()))
			return true;
		else if (component instanceof Searchbox && (!((Searchbox) component).getTextbox().isDisabled() && !((Searchbox) component).getTextbox().isReadonly() && ((Searchbox) component).getTextbox().isVisible()))
			return true;
		else if (component instanceof Button && (((Button) component).isEnabled() && ((Button) component).isVisible()))
			return true;
		else if (component instanceof Combinationbox && (!((Combinationbox) component).getTextbox().isReadonly() && ((Combinationbox) component).isEnabled() && ((Combinationbox) component).isVisible()))
			return true;
		else if (component instanceof EditorBox && (!((EditorBox) component).getTextbox().isReadonly() && ((EditorBox) component).isEnabled() && ((EditorBox) component).isVisible()))
			return true;
		else if (component instanceof Urlbox && (((Urlbox) component).isEnabled() && ((Urlbox) component).isVisible()))
			return true;
		else if (component instanceof FilenameBox && (!((FilenameBox) component).getTextbox().isReadonly() && ((FilenameBox) component).isEnabled() && ((FilenameBox) component).isVisible()))
			return true;
		else if (component instanceof Timebox && !((Timebox) component).isReadonly() && ((Timebox) component).isVisible())
			return true;
		else if (component instanceof Paymentbox && (((Paymentbox) component).isEnabled() && ((Paymentbox) component).isVisible()))
			return true;
		else if (component instanceof PAttributebox && !((PAttributebox) component).getTextbox().isReadonly() && (((PAttributebox) component).isEnabled() && ((PAttributebox) component).isVisible()))
			return true;
		else
			return false;
	}

	public void setFocusOnCurrentCell() {
		if (currentCell == null || currentCell.getChildren().size() <= 0) {
			return;
		}

		Component component = currentCell.getChildren().get(0);
		if (component instanceof NumberBox)
		{
			((NumberBox) component).focus();
			((NumberBox) component).getDecimalbox().select();
		}
		else if (component instanceof Checkbox)
			((Checkbox) component).focus();
		else if (component instanceof Combobox)
			((Combobox) component).focus();
		else if (component instanceof Textbox)
		{
			((Textbox) component).focus();
			((Textbox) component).select();
		}
		else if (component instanceof Datebox)
			((Datebox) component).focus();
		else if (component instanceof DatetimeBox)
			((DatetimeBox) component).focus();
		else if (component instanceof Locationbox)
			((Locationbox) component).focus();
		else if (component instanceof Combinationbox)
		{
			((Combinationbox) component).getTextbox().focus();
			((Combinationbox) component).getTextbox().select();
		}
		else if (component instanceof Searchbox)
		{
			((Searchbox) component).getTextbox().focus();
			((Searchbox) component).getTextbox().select();
		}
		else if (component instanceof Button)
			((Button) component).focus();
		else if (component instanceof EditorBox)
			((EditorBox) component).focus();
		else if (component instanceof Urlbox)
			((Urlbox) component).focus();
		else if (component instanceof FilenameBox)
			((FilenameBox) component).focus();
		else if (component instanceof Timebox)
			((Timebox) component).focus();
		else if (component instanceof Paymentbox)
			((Paymentbox) component).focus();
		else if (component instanceof PAttributebox)
			((PAttributebox) component).focus();
		else
			((HtmlBasedComponent) currentCell).focus();
	} // setFocusOnCurrentCell

	/**
	 * @param row
	 */
	public void setCurrentRow(Row row)
	{
		currentRow = row;

		String script = "jq('#" + row.getUuid() + "').addClass('highlight').siblings().removeClass('highlight')";

		if (!gridTab.getValueAsBoolean("IsActive"))
		{
			script = "jq('#" + row.getUuid() + "').addClass('grid-inactive-row').siblings().removeClass('highlight')";
		}

		Clients.response(new AuScript(script));
	}

	/**
	 * @return Row
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
	 * Enter edit mode
	 */
	public void editCurrentRow() {
		if (currentRow != null && currentRow.getParent() != null && currentRow.isVisible() && grid != null
				&& grid.isVisible() && grid.getParent() != null && grid.getParent().isVisible()) {
		
			editing = true;

			GridTableListModel model = (GridTableListModel) grid.getModel();
			model.setEditing(true);
		}
	}

	/**
	 * @see RowRendererExt#getControls()
	 */
	public int getControls() {
		return DETACH_ON_RENDER;
	}

	/**
	 * @see RowRendererExt#newCell(Row)
	 */
	public Component newCell(Row row) {
		return null;
	}

	/**
	 * @see RowRendererExt#newRow(Grid)
	 */
	public Row newRow(Grid grid) {
		return null;
	}

	/**
	 * @see RendererCtrl#doCatch(Throwable)
	 */
	public void doCatch(Throwable ex) throws Throwable {
	}

	/**
	 * @see RendererCtrl#doFinally()
	 */
	public void doFinally() {
	}

	/**
	 * @see RendererCtrl#doTry()
	 */
	public void doTry() {
	}

	/**
	 *
	 * @param gridPanel
	 */
	public void setGridPanel(QuickGridView gridPanel) {
		this.gridPanel = gridPanel;
	}

	static class RowListener implements EventListener<Event> {

		private Grid _grid;

		public RowListener(Grid grid) {
			_grid = grid;
		}

		public void onEvent(Event event) throws Exception {
			if (Events.ON_CLICK.equals(event.getName())) {
				if (Executions.getCurrent().getAttribute("gridView.onSelectRow") != null)
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
	 * @return boolean
	 */
	public boolean isEditing() {
		return editing;
	}

	/**
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
			else
				Events.sendEvent(event.getTarget().getParent(), event);
		} else if (event.getTarget() instanceof Checkbox) {
			Executions.getCurrent().setAttribute("gridView.onSelectRow", Boolean.TRUE);
			Checkbox checkBox = (Checkbox) event.getTarget();
			Events.sendEvent(gridPanel, new Event("onSelectRow", gridPanel, checkBox));
		}
	}

	/**
	 * Clear editorsListmap on page change and dispose.
	 */
	public void clearMaps()
	{
		editorsListMap.clear();
		readOnlyEditorsListMap.clear();
	}
}
