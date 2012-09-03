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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.EditorBox;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.GridPanel;
import org.adempiere.webui.component.Group;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.NumberBox;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.component.SimpleTreeModel;
import org.adempiere.webui.editor.IZoomableEditor;
import org.adempiere.webui.editor.WButtonEditor;
import org.adempiere.webui.editor.WEditor;
import org.adempiere.webui.editor.WEditorPopupMenu;
import org.adempiere.webui.editor.WebEditorFactory;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.util.GridTabDataBinder;
import org.adempiere.webui.util.TreeUtils;
import org.adempiere.webui.window.FDialog;
import org.compiere.model.DataStatusEvent;
import org.compiere.model.DataStatusListener;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.GridWindow;
import org.compiere.model.MLookup;
import org.compiere.model.MTree;
import org.compiere.model.MTreeNode;
import org.compiere.model.X_AD_FieldGroup;
import org.compiere.util.CLogger;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Util;
import org.zkoss.zk.au.out.AuFocus;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Borderlayout;
import org.zkoss.zul.Center;
import org.zkoss.zul.DefaultTreeNode;
import org.zkoss.zul.Div;
import org.zkoss.zul.Groupfoot;
import org.zkoss.zul.Separator;
import org.zkoss.zul.Space;
import org.zkoss.zul.Treeitem;
import org.zkoss.zul.West;
import org.zkoss.zul.impl.XulElement;

/**
 *
 * This class is based on org.compiere.grid.GridController written by Jorg Janke.
 * Changes have been brought for UI compatibility.
 *
 * @author Jorg Janke
 *
 * @author <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date Feb 25, 2007
 * @version $Revision: 0.10 $
 *
 * @author Low Heng Sin
 */
public class ADTabpanel extends Div implements Evaluatee, EventListener<Event>,
DataStatusListener, IADTabpanel
{
	private static final String ON_DEFER_SET_SELECTED_NODE = "onDeferSetSelectedNode";

	/**
	 * generated serial version ID
	 */
	private static final long serialVersionUID = 6945934489328360251L;

	private static final CLogger logger;

    static
    {
        logger = CLogger.getCLogger(ADTabpanel.class);
    }

    private GridTab           gridTab;

    @SuppressWarnings("unused")
	private GridWindow        gridWindow;

    private AbstractADWindowPanel      windowPanel;

    private int               windowNo;

    private Grid              grid;

    private ArrayList<WEditor> editors = new ArrayList<WEditor>();
    
    private ArrayList<Component> editorComps = new ArrayList<Component>();

    private boolean			  uiCreated = false;

    private GridPanel		  listPanel;

    private Map<String, List<Row>> fieldGroupContents = new HashMap<String, List<Row>>();

    private Map<String, List<org.zkoss.zul.Row>> fieldGroupHeaders = new HashMap<String, List<org.zkoss.zul.Row>>();

	private ArrayList<Row> rowList;

	private Component formComponent = null;

	private ADTreePanel treePanel = null;

	private GridTabDataBinder dataBinder;

	private Map<Integer, Group> includedTab = new HashMap<Integer, Group>();
	private Map<Integer, Groupfoot> includedTabFooter = new HashMap<Integer, Groupfoot>();

	private List<EmbeddedPanel> includedPanel = new ArrayList<EmbeddedPanel>();

	private boolean active = false;

	private Group currentGroup;

	public ADTabpanel()
	{
        init();
    }

    private void init()
    {
        initComponents();
        addEventListener(ON_DEFER_SET_SELECTED_NODE, this);
    }

    private void initComponents()
    {
    	LayoutUtils.addSclass("adtab-content", this);

        grid = new Grid();
        //have problem moving the following out as css class
        grid.setHflex("1");
        grid.setHeight("100%");
        grid.setVflex(true);
        grid.setSclass("grid-layout");
        
        listPanel = new GridPanel();
        listPanel.getListbox().addEventListener(Events.ON_DOUBLE_CLICK, this);
    }

    /**
     *
     * @param winPanel
     * @param windowNo
     * @param gridTab
     * @param gridWindow
     */
    public void init(AbstractADWindowPanel winPanel, int windowNo, GridTab gridTab,
            GridWindow gridWindow)
    {
        this.windowNo = windowNo;
        this.gridWindow = gridWindow;
        this.gridTab = gridTab;
        this.windowPanel = winPanel;
        gridTab.addDataStatusListener(this);
        this.dataBinder = new GridTabDataBinder(gridTab);

        this.getChildren().clear();

        int AD_Tree_ID = 0;
		if (gridTab.isTreeTab())
			AD_Tree_ID = MTree.getDefaultAD_Tree_ID (
				Env.getAD_Client_ID(Env.getCtx()), gridTab.getKeyColumnName());
		if (gridTab.isTreeTab() && AD_Tree_ID != 0)
		{
			Borderlayout layout = new Borderlayout();
			layout.setParent(this);
			layout.setSclass("adtab-tree-layout");
			
			treePanel = new ADTreePanel(windowNo, gridTab.getTabNo());
			West west = new West();
			west.appendChild(treePanel);
			west.setWidth("300px");
			west.setCollapsible(true);
			west.setSplittable(true);
			west.setAutoscroll(true);
			layout.appendChild(west);

			Center center = new Center();
			center.setFlex(true);
			center.appendChild(grid);
			center.setSclass("adtab-form");
			layout.appendChild(center);

			formComponent = layout;
			treePanel.getTree().addEventListener(Events.ON_SELECT, this);
			
			if (AEnv.isTablet()) 
			{
				LayoutUtils.addSclass("tablet-scrolling", west);
				LayoutUtils.addSclass("tablet-scrolling", center);
			}
		}
		else
		{
			Div div = new Div();
			div.setSclass("adtab-form");
			div.appendChild(grid);
			this.appendChild(div);
			formComponent = div;
			
			if (AEnv.isTablet()) 
			{
				LayoutUtils.addSclass("tablet-scrolling", div);
			}
		}
        this.appendChild(listPanel);
        listPanel.setVisible(false);
        listPanel.setWindowNo(windowNo);
        listPanel.setADWindowPanel(winPanel);

    }

    /**
     * Create UI components if not already created
     */
    public void createUI()
    {
    	if (uiCreated) return;

    	uiCreated = true;
    	
    	int numCols=gridTab.getColumns();
    	if (numCols <= 0) {
    		numCols=4;
    	}

    	// set size in percentage per column leaving a MARGIN on right
    	Columns columns = new Columns();
    	grid.appendChild(columns);
		String numColsS=String.valueOf(numCols);
    	int equalWidth = 98 / numCols;

    	for (int h=0;h<numCols;h++){
    		Column col = new Column();
    		col.setWidth(equalWidth + "%");
    		columns.appendChild(col);
    	}

    	Rows rows = grid.newRows();
        GridField fields[] = gridTab.getFields();
        Row row = new Row();
        int actualxpos = 0;

        String currentFieldGroup = null;
        for (int i = 0; i < fields.length; i++)
        {
        	GridField field = fields[i];
        	if (!field.isDisplayed())
        		continue;

        	//included tab
        	if (field.getIncluded_Tab_ID() > 0)
        	{
        		// NOT CHANGING INCLUDED TAB AS THIS IS BEING REDESIGNED WITH
        		// IDEMPIERE-369 Master Detail layout improvements
        		if (row.getChildren().size() == 2)
        		{
        			row.appendChild(createSpacer());
        			row.appendChild(createSpacer());
        			row.appendChild(createSpacer());
        			rows.appendChild(row);
        			if (rowList != null)
        				rowList.add(row);
        		} else if (row.getChildren().size() > 0)
        		{
        			rows.appendChild(row);
        			if (rowList != null)
        				rowList.add(row);
        		}

        		//end current field group
        		if (currentGroup != null) {
        			Groupfoot rowg = new Groupfoot();
        			rows.appendChild(rowg);
        			currentGroup = null;
        			currentFieldGroup = null;
        		}

        		row = new Row();
        		row.setSpans("5");
        		row.appendChild(new Separator());
        		rows.appendChild(row);

        		Group rowg = new Group();
        		rowg.setSpans("2,3");
        		rows.appendChild(rowg);
        		includedTab.put(field.getIncluded_Tab_ID(), (Group)rowg);
        		Groupfoot rowgf = new Groupfoot();
        		rows.appendChild(rowgf);
        		includedTabFooter.put(field.getIncluded_Tab_ID(), (Groupfoot)rowgf);

        		row = new Row();
        		row.setSpans("5");
        		row.appendChild(new Separator());
        		rows.appendChild(row);

        		for (EmbeddedPanel ep : includedPanel) {
        			if (ep.adTabId == field.getIncluded_Tab_ID()) {
        				ep.group = includedTab.get(ep.adTabId);
        				createEmbeddedPanelUI(ep, field.getDisplayLength());
        				break;
        			}
        		}

        		row = new Row();
        		continue;
        	}
        	// field group
        	String fieldGroup = field.getFieldGroup();
        	if (!Util.isEmpty(fieldGroup) && !fieldGroup.equals(currentFieldGroup)) // group changed
        	{
        		currentFieldGroup = fieldGroup;
        		
        		if (numCols - actualxpos > 0)
        			row.appendCellChild(createSpacer(), numCols - actualxpos);
        		rows.appendChild(row);
                if (rowList != null)
        			rowList.add(row);

       			row = new Row();
       			actualxpos = 0;

        		List<org.zkoss.zul.Row> headerRows = new ArrayList<org.zkoss.zul.Row>();
        		fieldGroupHeaders.put(fieldGroup, headerRows);

        		row.appendCellChild(new Separator(), numCols);
        		rows.appendChild(row);
        		headerRows.add(row);

        		rowList = new ArrayList<Row>();
        		fieldGroupContents.put(fieldGroup, rowList);

        		if (X_AD_FieldGroup.FIELDGROUPTYPE_Label.equals(field.getFieldGroupType()))
        		{
        			row = new Row();
        			Label groupLabel = new Label(fieldGroup);
        			row.appendCellChild(groupLabel, numCols);
        			rows.appendChild(row);
        			headerRows.add(row);

        			row = new Row();
        			Separator separator = new Separator();
        			separator.setBar(true);
        			row.appendCellChild(separator, numCols);
        			rows.appendChild(row);
        			headerRows.add(row);
        		}
        		else
        		{
        			Group rowg = new Group(fieldGroup);
        			rowg.setSpans(numColsS);
        			if (X_AD_FieldGroup.FIELDGROUPTYPE_Tab.equals(field.getFieldGroupType()) || field.getIsCollapsedByDefault())
        			{
        				rowg.setOpen(false);
        			}
        			currentGroup = rowg;
        			rows.appendChild(rowg);
        			headerRows.add(rowg);
        		}

        		row = new Row();
        		actualxpos = 0;
        	}

			//normal field
        	if (field.getXPosition() <= actualxpos) {
        		// Fill right part of the row with spacers until number of columns
        		if (numCols - actualxpos + 1 > 0)
        			row.appendCellChild(createSpacer(), numCols - actualxpos + 1);
        		rows.appendChild(row);
        		row=new Row();
        		actualxpos = 0;
        	}
    		// Fill left part of the field
        	if (field.getXPosition()-1 - actualxpos > 0)
        		row.appendCellChild(createSpacer(), field.getXPosition()-1 - actualxpos);
        	boolean paintLabel = ! (field.getDisplayType() == DisplayType.Button || field.getDisplayType() == DisplayType.YesNo || field.isFieldOnly()); 
        	if (field.isHeading())
        		actualxpos = field.getXPosition();
        	else
        		actualxpos = field.getXPosition() + field.getColumnSpan()-1 + (paintLabel ? 1 : 0);

        	if (! field.isHeading()) {

        		WEditor editor = WebEditorFactory.getEditor(gridTab, field, false);

        		if (editor != null) // Not heading
        		{
        			editor.setGridTab(this.getGridTab());
        			field.addPropertyChangeListener(editor);
        			editors.add(editor);
        			editorComps.add(editor.getComponent());
        			if (paintLabel) {
        				Div div = new Div();
        				div.setAlign("right");
        				Label label = editor.getLabel();
        				div.appendChild(label);
        				if (label.getDecorator() != null)
        					div.appendChild(label.getDecorator());
        				row.appendCellChild(div,1);
        			}
        			row.appendCellChild(editor.getComponent(), field.getColumnSpan());
        			
        			/*
        			if (field.isLongField()) {
        				row.setSpans("1,3,1");
        				row.appendCellChild(createSpacer());
        				rows.appendChild(row);
        				if (rowList != null)
        					rowList.add(row);
        				//row = new Row();
        			}
        			*/

        			if (editor instanceof WButtonEditor)
        			{
        				if (windowPanel != null)
        					((WButtonEditor)editor).addActionListener(windowPanel);
        			}
        			else
        			{
        				editor.addValueChangeListener(dataBinder);
        			}

        			//stretch component to fill grid cell
        			editor.fillHorizontal();

        			//setup editor context menu
        			WEditorPopupMenu popupMenu = editor.getPopupMenu();
        			if (popupMenu != null)
        			{
        				popupMenu.addMenuListener((ContextMenuListener)editor);
        				this.appendChild(popupMenu);
        				if (!field.isFieldOnly())
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
        		}
        	}
        	else // just heading
        	{
        		//display just a label if we are "heading only"
        		Label label = new Label(field.getHeader());
        		Div div = new Div();
        		div.setAlign("center");
        		row.appendCellChild(createSpacer());
        		div.appendChild(label);
        		row.appendCellChild(div);
        	}
        }
		if (numCols - actualxpos + 1 > 0)
			row.appendCellChild(createSpacer(), numCols - actualxpos + 1);
		rows.appendChild(row);
        if (rowList != null)
			rowList.add(row);

        //create tree
        if (gridTab.isTreeTab() && treePanel != null) {
			int AD_Tree_ID = MTree.getDefaultAD_Tree_ID (
				Env.getAD_Client_ID(Env.getCtx()), gridTab.getKeyColumnName());
			treePanel.initTree(AD_Tree_ID, windowNo);
        }

        if (!gridTab.isSingleRow() && !isGridView())
        	switchRowPresentation();                
    }

	private Component createSpacer() {
		return new Space();
	}

	/**
	 * Validate display properties of fields of current row
	 * @param col
	 */
    public void dynamicDisplay (int col)
    {
        if (!gridTab.isOpen())
        {
            return;
        }

        for (WEditor comp : editors)
        {
        	comp.updateLabelStyle();
        }
        
        //  Selective
        if (col > 0)
        {
            GridField changedField = gridTab.getField(col);
            String columnName = changedField.getColumnName();
            ArrayList<?> dependants = gridTab.getDependantFields(columnName);
            logger.config("(" + gridTab.toString() + ") "
                + columnName + " - Dependents=" + dependants.size());
            if (dependants.size() == 0 && changedField.getCallout().length() > 0)
            {
                return;
            }
        }

        boolean noData = gridTab.getRowCount() == 0;
        logger.config(gridTab.toString() + " - Rows=" + gridTab.getRowCount());
        for (WEditor comp : editors)
        {
            GridField mField = comp.getGridField();
            if (mField != null && mField.getIncluded_Tab_ID() <= 0)
            {
                if (mField.isDisplayed(true))       //  check context
                {
                    if (!comp.isVisible())
                    {
                        comp.setVisible(true);      //  visibility
                    }
                    if (noData)
                    {
                        comp.setReadWrite(false);
                    }
                    else
                    {
                    	comp.dynamicDisplay();
                        boolean rw = mField.isEditable(true);   //  r/w - check Context
                        comp.setReadWrite(rw);
                        comp.setMandatory(mField.isMandatory(true));    //  check context
                    }
                }
                else if (comp.isVisible())
                {
                    comp.setVisible(false);
                }
            }
        }   //  all components

        //hide row if all editor within the row is invisible
        List<?> rows = grid.getRows().getChildren();
        for(int i = 0; i < rows.size(); i++)
        {
        	org.zkoss.zul.Row row = (org.zkoss.zul.Row) rows.get(i);
        	List<?> components = row.getChildren();
        	boolean visible = false;
        	boolean editorRow = false;
        	for (int j = 0; j < components.size(); j++)
        	{
        		Component cellComponent = (Component) components.get(j);
        		Component component = cellComponent.getFirstChild();
        		if (editorComps.contains(component))
        		{
        			editorRow = true;
        			if (component.isVisible())
        			{
        				visible = true;
        				break;
        			}
        		}
        	}
        	if (editorRow && (row.isVisible() != visible))
        	{
        		row.setAttribute(Group.GROUP_ROW_VISIBLE_KEY, visible ? "true" : "false");
        		row.setVisible(visible);
        	}
        }

        //hide fieldgroup if all editor row within the fieldgroup is invisible
        for(Iterator<Entry<String, List<org.zkoss.zul.Row>>> i = fieldGroupHeaders.entrySet().iterator(); i.hasNext();)
        {
        	Map.Entry<String, List<org.zkoss.zul.Row>> entry = i.next();
        	List<Row> contents = fieldGroupContents.get(entry.getKey());
        	boolean visible = false;
        	for (Row row : contents)
        	{
        		if (row.isVisible())
        		{
        			visible = true;
        			break;
        		}
        	}
        	List<org.zkoss.zul.Row> headers = entry.getValue();
        	for(org.zkoss.zul.Row row : headers)
        	{
        		if (row.isVisible() != visible)
        			row.setVisible(visible);
        	}
        }

        logger.config(gridTab.toString() + " - fini - " + (col<=0 ? "complete" : "seletive"));
    }   //  dynamicDisplay

    /**
     * @return String
     */
    public String getDisplayLogic()
    {
        return gridTab.getDisplayLogic();
    }

    /**
     * @return String
     */
    public String getTitle()
    {
        return gridTab.getName();
    } // getTitle

    /**
     * @param variableName
     */
    public String get_ValueAsString(String variableName)
    {
        return Env.getContext(Env.getCtx(), windowNo, variableName);
    } // get_ValueAsString

    /**
     * @return The tab level of this Tabpanel
     */
    public int getTabLevel()
    {
        return gridTab.getTabLevel();
    }

    /**
     * Is panel need refresh
     * @return boolean
     */
    public boolean isCurrent()
    {
        return gridTab != null ? gridTab.isCurrent() : false;
    }

    /**
     *
     * @return windowNo
     */
    public int getWindowNo()
    {
        return windowNo;
    }

    /**
     * Retrieve from db
     */
    public void query()
    {
    	boolean open = gridTab.isOpen();
        gridTab.query(false);
        if (listPanel.isVisible() && !open)
        	gridTab.getTableModel().fireTableDataChanged();
    }

    /**
     * Retrieve from db
     * @param onlyCurrentRows
     * @param onlyCurrentDays
     * @param maxRows
     */
    public void query (boolean onlyCurrentRows, int onlyCurrentDays, int maxRows)
    {
    	boolean open = gridTab.isOpen();
        gridTab.query(onlyCurrentRows, onlyCurrentDays, maxRows);
        if (listPanel.isVisible() && !open)
        	gridTab.getTableModel().fireTableDataChanged();
    }

    /**
     * @return GridTab
     */
    public GridTab getGridTab()
    {
        return gridTab;
    }

    /**
     * Refresh current row
     */
    public void refresh()
    {
        gridTab.dataRefresh();
    }

    /**
     * Activate/deactivate panel
     * @param activate
     */
    public void activate(boolean activate)
    {
    	active = activate;
        if (listPanel.isVisible()) {
        	if (activate)
        		listPanel.activate(gridTab);
        	else
        		listPanel.deactivate();
        } else {
        	if (activate) {
        		formComponent.setVisible(activate);
        		setFocusToField();
        	}
        }

        //activate embedded panel
        for(EmbeddedPanel ep : includedPanel)
        {
        	activateChild(activate, ep);
        }
        
        if (gridTab.getRecord_ID() > 0 && gridTab.isTreeTab() && treePanel != null) {
        	setSelectedNode(gridTab.getRecord_ID());
        }
    }

	private void activateChild(boolean activate, EmbeddedPanel panel) {
		if (activate)
		{
			panel.windowPanel.getADTab().evaluate(null);
			panel.windowPanel.getADTab().setSelectedIndex(0);
			panel.tabPanel.query(false, 0, 0);
		}
		panel.tabPanel.activate(activate);
	}

	/**
	 * set focus to first active editor
	 */
	private void setFocusToField() {
		WEditor toFocus = null;
		for (WEditor editor : editors) {
			if (editor.isHasFocus() && editor.isVisible() && editor.getComponent().getParent() != null) {
				toFocus = editor;
				break;
			}

			if (toFocus == null) {
				if (editor.isVisible() && editor.isReadWrite() && editor.getComponent().getParent() != null) {
					toFocus = editor;
				}
			}
		}
		if (toFocus != null) {
			Component c = toFocus.getComponent();
			if (c instanceof EditorBox) {
				c = ((EditorBox)c).getTextbox();
			} else if (c instanceof NumberBox) {
				c = ((NumberBox)c).getDecimalbox();
            }

			Clients.response(new AuFocus(c));
		}
	}

    /**
     * @param event
     * @see EventListener#onEvent(Event)
     */
    public void onEvent(Event event)
    {
    	if (event.getTarget() == listPanel.getListbox())
    	{    		
    		if (windowPanel != null) {
    			windowPanel.onToggle();
    		} else {
    			this.switchRowPresentation();
    		}
    	}
    	else if (event.getTarget() == treePanel.getTree()) {
    		Treeitem item =  treePanel.getTree().getSelectedItem();
    		navigateTo((DefaultTreeNode)item.getValue());
    	}
    	else if (ON_DEFER_SET_SELECTED_NODE.equals(event.getName())) {
    		if (gridTab.getRecord_ID() > 0 && gridTab.isTreeTab() && treePanel != null) {
            	setSelectedNode(gridTab.getRecord_ID());
            }
    	}
    }

    private void navigateTo(DefaultTreeNode value) {
    	MTreeNode treeNode = (MTreeNode) value.getData();
    	//  We Have a TreeNode
		int nodeID = treeNode.getNode_ID();
		//  root of tree selected - ignore
		//if (nodeID == 0)
			//return;

		//  Search all rows for mode id
		int size = gridTab.getRowCount();
		int row = -1;
		for (int i = 0; i < size; i++)
		{
			if (gridTab.getKeyID(i) == nodeID)
			{
				row = i;
				break;
			}
		}
		if (row == -1)
		{
			if (nodeID > 0)
				logger.log(Level.WARNING, "Tab does not have ID with Node_ID=" + nodeID);
			return;
		}

		//  Navigate to node row
		gridTab.navigate(row);
	}

    /**
     * @param e
     * @see DataStatusListener#dataStatusChanged(DataStatusEvent)
     */
	public void dataStatusChanged(DataStatusEvent e)
    {
    	//ignore background event
    	if (Executions.getCurrent() == null) return;

        int col = e.getChangedColumn();
        logger.config("(" + gridTab + ") Col=" + col + ": " + e.toString());

        //  Process Callout
        GridField mField = gridTab.getField(col);
        if (mField != null
            && (mField.getCallout().length() > 0 || gridTab.hasDependants(mField.getColumnName())))
        {
            String msg = gridTab.processFieldChange(mField);     //  Dependencies & Callout
            if (msg.length() > 0)
            {
                FDialog.error(windowNo, this, msg);
            }

            // Refresh the list on dependant fields
    		ArrayList<GridField> list = gridTab.getDependantFields(mField.getColumnName());
    		for (int i = 0; i < list.size(); i++)
    		{
    			GridField dependentField = (GridField)list.get(i);
    		//	log.trace(log.l5_DData, "Dependent Field", dependentField==null ? "null" : dependentField.getColumnName());
    			//  if the field has a lookup
    			if (dependentField != null && dependentField.getLookup() instanceof MLookup)
    			{
    				MLookup mLookup = (MLookup)dependentField.getLookup();
    				//  if the lookup is dynamic (i.e. contains this columnName as variable)
    				if (mLookup.getValidation().indexOf("@"+mField.getColumnName()+"@") != -1)
    				{
    					mLookup.refresh();
    				}
    			}
    		}   //  for all dependent fields

        }
        //if (col >= 0)
        if (!uiCreated)
        	createUI();
        dynamicDisplay(col);

        //sync tree
        if (treePanel != null) {
        	if ("Deleted".equalsIgnoreCase(e.getAD_Message()))
        		if (e.Record_ID != null
        				&& e.Record_ID instanceof Integer
        				&& ((Integer)e.Record_ID != gridTab.getRecord_ID()))
        			deleteNode((Integer)e.Record_ID);
        		else
        			setSelectedNode(gridTab.getRecord_ID());
        	else
        		setSelectedNode(gridTab.getRecord_ID());
        }

        if (listPanel.isVisible()) {
        	listPanel.updateListIndex();
        	listPanel.dynamicDisplay(col);
        }

        if (!includedPanel.isEmpty() && e.getChangedColumn() == -1) {
        	ArrayList<String> parentColumnNames = new ArrayList<String>();
        	GridField[] parentFields = gridTab.getFields();
        	for (GridField parentField : parentFields)
        		parentColumnNames.add(parentField.getColumnName());        	
        	
        	for (EmbeddedPanel panel : includedPanel)
        	{
        		GridTab tab = panel.tabPanel.getGridTab();
        		GridField[] fields = tab.getFields();
        		for (GridField field : fields)
        		{
        			if (!parentColumnNames.contains(field.getColumnName()))
        				Env.setContext(Env.getCtx(), field.getWindowNo(), field.getColumnName(), "");
        		}
        		panel.tabPanel.query(false, 0, 0);
        	}

        	parentColumnNames = null;
        }
    }

    private void deleteNode(int recordId) {
		if (recordId <= 0) return;

		SimpleTreeModel model = (SimpleTreeModel) treePanel.getTree().getModel();

		if (treePanel.getTree().getSelectedItem() != null) {
			DefaultTreeNode treeNode = (DefaultTreeNode) treePanel.getTree().getSelectedItem().getValue();
			MTreeNode data = (MTreeNode) treeNode.getData();
			if (data.getNode_ID() == recordId) {
				model.removeNode(treeNode);
				return;
			}
		}

		DefaultTreeNode treeNode = model.find(null, recordId);
		if (treeNode != null) {
			model.removeNode(treeNode);
		}
	}

	private void addNewNode() {
    	if (gridTab.getRecord_ID() > 0) {
	    	String name = (String)gridTab.getValue("Name");
			String description = (String)gridTab.getValue("Description");
			boolean summary = gridTab.getValueAsBoolean("IsSummary");
			String imageIndicator = (String)gridTab.getValue("Action");  //  Menu - Action
			//
			SimpleTreeModel model = (SimpleTreeModel) treePanel.getTree().getModel();
			DefaultTreeNode treeNode = model.getRoot();
			MTreeNode root = (MTreeNode) treeNode.getData();
			MTreeNode node = new MTreeNode (gridTab.getRecord_ID(), 0, name, description,
					root.getNode_ID(), summary, imageIndicator, false, null);
			DefaultTreeNode newNode = new DefaultTreeNode(node);
			model.addNode(newNode);			
			int[] path = model.getPath(newNode);
			Treeitem ti = treePanel.getTree().renderItemByPath(path);
			treePanel.getTree().setSelectedItem(ti);			
    	}
	}

	private void setSelectedNode(int recordId) {
		if (recordId <= 0) return;
		
		//force on init render
		if (TreeUtils.isOnInitRenderPosted(treePanel.getTree()) || treePanel.getTree().getTreechildren() == null) {
			treePanel.getTree().onInitRender();
		}

		SimpleTreeModel model = (SimpleTreeModel) treePanel.getTree().getModel();
		if (treePanel.getTree().getSelectedItem() != null) {
			DefaultTreeNode treeNode = (DefaultTreeNode) treePanel.getTree().getSelectedItem().getValue();
			MTreeNode data = (MTreeNode) treeNode.getData();
			if (data.getNode_ID() == recordId) {
				int[] path = model.getPath(treeNode);
				Treeitem ti = treePanel.getTree().renderItemByPath(path);
				if (ti.getPage() == null) {
					Events.echoEvent(ON_DEFER_SET_SELECTED_NODE, this, null);
				}
				return;
			}
		}
		
		DefaultTreeNode treeNode = model.find(null, recordId);
		if (treeNode != null) {
			int[] path = model.getPath(treeNode);
			Treeitem ti = treePanel.getTree().renderItemByPath(path);
			treePanel.getTree().selectItem(ti);
		} else {
			addNewNode();
		}
	}

	/**
	 * Toggle between form and grid view
	 */
	public void switchRowPresentation() {
		if (formComponent.isVisible()) {
			formComponent.setVisible(false);
			//de-activate embedded panel
	        for(EmbeddedPanel ep : includedPanel)
	        {
	        	activateChild(false, ep);
	        }
		} else {
			formComponent.setVisible(true);
			//activate embedded panel
	        for(EmbeddedPanel ep : includedPanel)
	        {
	        	activateChild(true, ep);
	        }
	        formComponent.getParent().invalidate();
		}
		listPanel.setVisible(!formComponent.isVisible());
		if (listPanel.isVisible()) {
			listPanel.refresh(gridTab);
			listPanel.scrollToCurrentRow();
		} else {
			listPanel.deactivate();
		}
	}

	class ZoomListener implements EventListener {

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
	 * Embed detail tab
	 * @param ctx
	 * @param windowNo
	 * @param gridWindow
	 * @param adTabId
	 * @param tabIndex
	 * @param tabPanel
	 */
	public void embed(Properties ctx, int windowNo, GridWindow gridWindow,
			int adTabId, int tabIndex, IADTabpanel tabPanel) {
		embed(ctx, windowNo, gridWindow, adTabId, tabIndex, tabPanel, 0);
	}
	
	/**
	 * Embed detail tab
	 * @param ctx
	 * @param windowNo
	 * @param gridWindow
	 * @param adTabId
	 * @param tabIndex
	 * @param tabPanel
	 */
	public void embed(Properties ctx, int windowNo, GridWindow gridWindow,
			int adTabId, int tabIndex, IADTabpanel tabPanel, int height) {
		EmbeddedPanel ep = new EmbeddedPanel();
		ep.tabPanel = tabPanel;
		ep.adTabId = adTabId;
		ep.tabIndex = tabIndex;
		ep.gridWindow = gridWindow;
		includedPanel.add(ep);
		Group group = includedTab.get(adTabId);
		ep.group = group;
		if (tabPanel instanceof ADTabpanel) {
			ADTabpanel atp = (ADTabpanel) tabPanel;
			atp.listPanel.setPageSize(-1);
		}
		ADWindowPanel panel = new ADWindowPanel(ctx, windowNo, gridWindow, tabIndex, tabPanel);
		ep.windowPanel = panel;

		if (group != null) {
			createEmbeddedPanelUI(ep, height);
			if (active)
				activateChild(true, ep);
		}
	}

	class EmbeddedPanel {
		Group group;
		GridWindow gridWindow;
		int tabIndex;
		ADWindowPanel windowPanel;
		IADTabpanel tabPanel;
		int adTabId;
	}

	/**
	 * @see IADTabpanel#afterSave(boolean)
	 */
	public void afterSave(boolean onSaveEvent) {
		if (!includedPanel.isEmpty()) {
        	for (EmbeddedPanel panel : includedPanel)
        		panel.tabPanel.query(false, 0, 0);
        }
	}

	private void createEmbeddedPanelUI(EmbeddedPanel ep, int height) {
		Row row = new Row();
		row.setSpans("5");
		grid.getRows().insertBefore(row, includedTabFooter.get(ep.adTabId));
		ep.windowPanel.createPart(row);
		ep.windowPanel.getComponent().setWidth("100%");
		ep.windowPanel.getComponent().setStyle("position: relative;");
		//for backward compatibility, only treat display length > 50 as height for the embedded panel
		if (height > 50)
			ep.windowPanel.getComponent().setHeight(height + "px");
		else
			ep.windowPanel.getComponent().setHeight("400px");

		Label title = new Label(ep.gridWindow.getTab(ep.tabIndex).getName());
		ep.group.appendChild(title);
		ep.group.appendChild(ep.windowPanel.getToolbar());
		ep.windowPanel.initPanel(-1, null);
	}

	@Override
	public void focus() {
		if (formComponent.isVisible())
			this.setFocusToField();
		else
			listPanel.focus();
	}

	public void setFocusToField(String columnName) {
		if (formComponent.isVisible()) {
			boolean found = false;
			for (WEditor editor : editors) {
				if (found)
					editor.setHasFocus(false);
				else if (columnName.equals(editor.getColumnName())) {
					editor.setHasFocus(true);
					Clients.response(new AuFocus(editor.getComponent()));
					found = true;
				}
			}
		} else {
			listPanel.setFocusToField(columnName);
		}
	}

	/**
	 * @see IADTabpanel#onEnterKey()
	 */
	public boolean onEnterKey() {
		if (listPanel.isVisible()) {
			return listPanel.onEnterKey();
		}
		return false;
	}

	/**
	 * @return boolean
	 */
	public boolean isGridView() {
		return listPanel.isVisible();
	}

	/**
	 * @param gTab
	 * @return embedded panel or null if not found
	 */
	public IADTabpanel findEmbeddedPanel(GridTab gTab) {
		IADTabpanel panel = null;
		for(EmbeddedPanel ep : includedPanel) {
			if (ep.tabPanel.getGridTab().equals(gTab)) {
				return ep.tabPanel;
			}
		}
		return panel;
	}

	/**
	 *
	 * @return GridPanel
	 */
	public GridPanel getGridView() {
		return listPanel;
	}
}

