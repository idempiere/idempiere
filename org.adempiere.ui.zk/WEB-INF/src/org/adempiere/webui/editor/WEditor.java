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

package org.adempiere.webui.editor;

import java.awt.Color;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.util.ArrayList;
import java.util.Properties;

import org.adempiere.webui.AdempiereWebUI;
import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.adwindow.IFieldEditorContainer;
import org.adempiere.webui.component.Bandbox;
import org.adempiere.webui.component.Button;
import org.adempiere.webui.component.ComboEditorBox;
import org.adempiere.webui.component.Datebox;
import org.adempiere.webui.component.DatetimeBox;
import org.adempiere.webui.component.EditorBox;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.NumberBox;
import org.adempiere.webui.component.Paymentbox;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.event.ValueChangeListener;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.model.GridTab;
import org.compiere.model.MRole;
import org.compiere.model.MStyle;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.Executions;
import org.zkoss.zk.ui.HtmlBasedComponent;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Combobox;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Timebox;
import org.zkoss.zul.impl.InputElement;
import org.zkoss.zul.impl.XulElement;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Mar 11, 2007
 * @version $Revision: 0.10 $
 */
public abstract class WEditor implements EventListener<Event>, PropertyChangeListener, IInputValidator
{
    private static final String[] lISTENER_EVENTS = {};

    public static final int MAX_DISPLAY_LENGTH = 35;

    public static final String INIT_EDIT_EVENT = "onInitEdit";
    
    protected GridField gridField;

    protected GridTab gridTab;

    protected Label label;

    protected Component component;

    protected boolean mandatory;

    protected ArrayList<ValueChangeListener> listeners = new ArrayList<ValueChangeListener>();

    private String strLabel;

    private String description;

    protected boolean readOnly;

    private String columnName;

	protected WEditorPopupMenu popupMenu;

	protected boolean tableEditor;
	
	private boolean isProcessParameter;
	
	private String sValidInput;

	/**
	 * call to show context menu of this field.
	 * must call after append component of this field to parent
	 */
	public void showMenu() {		
		if (popupMenu == null)
			return;
		
		// handle standard menu item (log, preference) reply to data type of this field.
		if (ContextMenuListener.class.isInstance(this))
			popupMenu.addMenuListener((ContextMenuListener)this);
		
		//popupMenu.setId(mField.getColumnName()+"-popup");
		this.component.getParent().appendChild(popupMenu);
		
		// when field have label, add action zoom when click to label, and show menu when right click to label
		if (!readOnly)
		{		
			//long press conflict with text selection gesture on mobile
			if (ClientInfo.isMobile())
			{
				label.addEventListener(Events.ON_CLICK, evt-> popupMenu.open(label, "after_end"));
			}
			else
			{
				if (popupMenu.isZoomEnabled() && this instanceof IZoomableEditor)
				{
					// add action zoom when click to label
					label.addEventListener(Events.ON_CLICK, new EventListener<Event> (){
						public void onEvent(Event event) throws Exception {
							if (Events.ON_CLICK.equals(event.getName())) {
								((IZoomableEditor)WEditor.this).actionZoom();
							}
	
						}
					});
				}
	
				// show menu when right click to label
				popupMenu.addContextElement(label);
				
				if (component instanceof XulElement) 
				{
					popupMenu.addContextElement((XulElement) component);
				}
			}
		}
		
	}
	
	/**
	 * 
	 * @param comp
	 * @param gridField
	 */
    public WEditor(Component comp, GridField gridField) {
    	this(comp, gridField, -1);
	}

    /**
     * 
     * @param comp
     * @param gridField
     * @param tableEditor
     * @param editorConfiguration
     */
    public WEditor(Component comp, GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
    	this(comp, gridField, -1, tableEditor, editorConfiguration);
	}
    
    /**
     * 
     * @param comp
     * @param gridField
     * @param rowIndex
     */
    public WEditor(Component comp, GridField gridField, int rowIndex) {
	   this(comp, gridField, rowIndex, false, null);
    }
   
	/**
	 * 
	 * @param comp
	 * @param gridField
	 * @param rowIndex
	 * @param tableEditor editor for Grid
	 * @param editorConfiguration
	 */
    public WEditor(Component comp, GridField gridField, int rowIndex, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        if (comp == null)
        {
            throw new IllegalArgumentException("Component cannot be null");
        }

        if (gridField == null)
        {
            throw new IllegalArgumentException("Grid field cannot be null");
        }

        this.setComponent(comp);        
        this.gridField = gridField;
        if (gridField.getGridTab() != null) {
        	comp.setClientAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, gridField.getGridTab().getTableName()+"0"+gridField.getColumnName());
        	this.gridTab = gridField.getGridTab();
        } else {
        	comp.setClientAttribute(AdempiereWebUI.WIDGET_INSTANCE_NAME, gridField.getColumnName());
        }
        if (editorConfiguration != null && editorConfiguration.getMandatory() != null)
        	this.setMandatory(editorConfiguration.getMandatory());
        else
        	this.setMandatory(gridField.isMandatory(true));
        this.tableEditor = tableEditor;
        if (editorConfiguration != null && editorConfiguration.getReadonly() != null)
        	this.readOnly = editorConfiguration.getReadonly();
        else
        	this.readOnly = gridField.isReadOnly();
        this.description = gridField.getDescription();
        this.columnName = gridField.getColumnName();
        this.strLabel = gridField.getHeader();
        init();
    }
    
    /**
     * Normal zk component just fire onChange event when user loss focus
     * call this method with true value let component fire event when user type first character
     * 
     * remark: editor set true for this method also need handle INIT_EDIT_EVENT to take effect, 
     * can refer implement at {@link WStringEditor#onEvent(Event)}
     * @param isChangeEventWhenEditing
     */
    public void setChangeEventWhenEditing (boolean isChangeEventWhenEditing){
    	this.component.setWidgetOverride("isChangeEventWhenEditing", String.valueOf(isChangeEventWhenEditing));
    }
    

    /**
     * Method is used to distinguish between 2 similar WSearchEditors
     *
     */
    public String getDescription()
    {
    	return description;

    }

	/**
	 * Constructor for use if a grid field is unavailable
	 *
	 * @param comp			The editor's component
	 * @param label			column name (not displayed)
	 * @param description	description of component
	 * @param mandatory		whether a selection must be made
	 * @param readonly		whether or not the editor is read only
	 * @param updateable	whether the editor contents can be changed
	 */
    public WEditor(Component comp, String label, String description, boolean mandatory, boolean readonly, boolean updateable)
    {
    	if (comp == null)
        {
            throw new IllegalArgumentException("Component cannot be null");
        }

    	this.setComponent(comp);
    	this.setMandatory(mandatory);
        this.readOnly = readonly;
        this.description = description;
        this.strLabel = label;
        init();
    }

    /**
	 * Constructor for use if a grid field is unavailable
	 *
	 * @param comp			The editor's component
	 * @param label			column name (not displayed)
	 * @param description	description of component
	 * @param mandatory		whether a selection must be made
	 * @param readonly		whether or not the editor is read only
	 * @param updateable	whether the editor contents can be changed
	 */
    public WEditor(Component comp, String columnName, String label, String description, boolean mandatory, boolean readonly, boolean updateable)
    {
    	if (comp == null)
        {
            throw new IllegalArgumentException("Component cannot be null");
        }

    	this.setComponent(comp);
    	this.setMandatory(mandatory);
        this.readOnly = readonly;
        this.description = description;
        this.strLabel = label;
        this.columnName = columnName;
        init();
    }


    /**
     * Set the editor component.
     * @param comp the editor component
     */
    protected void setComponent(Component comp)
    {
        this.component = comp;
    }

    private void init()
    {
        label = new Label("");
        label.setValue(strLabel);
        label.setTooltiptext(description);
        label.setMandatory(mandatory);
        
        this.setMandatory (mandatory);
        this.setReadWrite(!readOnly);

        ((HtmlBasedComponent)component).setTooltiptext(description);
        label.setTooltiptext(description);

        //init listeners
        for (String event : this.getEvents())
        {
            component.addEventListener(event, this);
        }
        
        component.addEventListener(INIT_EDIT_EVENT, this);
        component.setAttribute("idempiere.editor", this);
        
        component.addEventListener(Events.ON_FOCUS, e -> {
        	ADWindow adwindow = ADWindow.findADWindow(component);
        	if (adwindow != null) {
        		adwindow.getADWindowContent().setLastFocusEditor(component);
        	}
        });
    }

    /**
     *
     * @return grid field for this editor ( can be null )
     */
    public GridField getGridField()
    {
        return gridField;
    }

    /**
     *
     * @return columnNames
     */
    public String getColumnName()
    {
        return columnName;
    }

    /**
     * Remove the table qualifier from the supplied column name.
     *
     * The column name may be prefixed with the table name
     * i.e. <code>[table name].[column name]</code>.
     * The function returns
     *
     * @param originalColumnName	The column name to clean
     * @return 	the column name with any table qualifier removed
     * 			i.e. <code>[column name]</code>
     */
    protected String cleanColumnName(String originalColumnName)
	{
		String cleanColumnName;
		/*
		 *  The regular expression to use to find the table qualifier.
		 *  Matches "<table name>."
		 */
		final String regexTablePrefix = ".*\\.";

		cleanColumnName = originalColumnName.replaceAll(regexTablePrefix, "");

		return cleanColumnName;
	}

    protected void setColumnName(String columnName)
    {
    	String cleanColumnName = cleanColumnName(columnName);
    	this.columnName = cleanColumnName;
    }

    /**
     *
     * @return Component
     */
    public Component getComponent()
    {
        return component;
    }

    /**
     * @param gridTab
     */
    public void setGridTab(GridTab gridTab)
    {
    	this.gridTab = gridTab;
    }

    /**
     *
     * @return popup menu instance ( if available )
     */
    public WEditorPopupMenu getPopupMenu()
    {
        return popupMenu;
    }

    /**
     * @param evt
     */
    public void propertyChange(final PropertyChangeEvent evt)
    {
        if (evt.getPropertyName().equals(org.compiere.model.GridField.PROPERTY))
        {
        	if (Executions.getCurrent() == null) {
        		Executions.schedule(this.getComponent().getDesktop(), new EventListener<Event>() {
					@Override
					public void onEvent(Event event) throws Exception {
						setValue((evt.getNewValue()));
					}
				}, new Event("onPropertyChange"));
        	} else {
        		setValue((evt.getNewValue()));
        	}
        }
    }

    /**
     * @param listener
     */
    public void addValueChangeListener(ValueChangeListener listener)
    {
    	if (listener == null)
        {
            return;
        }

    	if (!listeners.contains(listener))
    		listeners.add(listener);
    }

    public boolean removeValuechangeListener(ValueChangeListener listener)
    {
    	return listeners.remove(listener);
    }

    protected void fireValueChange(ValueChangeEvent event)
    {
    	//copy to array to avoid concurrent modification exception
    	ValueChangeListener[] vcl = new ValueChangeListener[listeners.size()];
    	listeners.toArray(vcl);
        for (ValueChangeListener listener : vcl)
        {
            listener.valueChange(event);
        }
    }

    /**
     *
     * @return Label
     */
    public Label getLabel()
    {
        return label;
    }

    /**
     *
     * @param readWrite
     */
    public abstract void setReadWrite(boolean readWrite);

    /**
     *
     * @return editable
     */
    public abstract boolean isReadWrite();

    /**
     *
     * @param visible
     */
    public void setVisible(boolean visible)
    {
        label.setVisible(visible);
        component.setVisible(visible);
    }

    /**
     *
     * @return is visible
     */
    public boolean isVisible()
    {
        return component.isVisible();
    }

    /**
     * Indicating error with changing the style.
     * @param error
     */
    public void setBackground(boolean error)
    {

    }

    public void setBackground(Color color)
    {

    }

    public String toString()
    {
        StringBuilder sb = new StringBuilder(30);
        sb.append(this.getClass().getName());
        sb.append("[").append(this.getColumnName());
        sb.append("=");
        sb.append(this.getValue()).append("]");
        return sb.toString();
    }

    /**
     *
     * @param value
     */
    abstract public void setValue(Object value);

    /**
     *
     * @return Object
     */
    abstract public Object getValue();

    /**
     *
     * @return display text
     */
    abstract public String getDisplay();
    
    public String getDisplayTextForGridView(Object value) {
    	this.setValue(value);
    	String s = getDisplay();
    	if ("<0>".equals(s)) {
    		s = "";
    	}
    	return s;
    }

    /**
     *
     * @return list of events
     */
    public String[] getEvents()
    {
        return WEditor.lISTENER_EVENTS;
    }

    /**
     * Set whether the editor represents a mandatory field.
     * @param mandatory whether the field is mandatory
     */
    public void setMandatory (boolean mandatory)
    {
    	if (this.mandatory != mandatory)
    	{
	        this.mandatory = mandatory;
	        if (label != null)
	        {
	        	label.setMandatory(mandatory);
	        }
    	}
    }

    /**
     *
     * @return boolean
     */
    public boolean isMandatory()
    {
        return this.mandatory;
    }

    public void dynamicDisplay()
    {
    	dynamicDisplay(gridField != null ? gridField.getVO().ctx : Env.getCtx());
    }
    
    /**
     * allow subclass to perform dynamic loading of data
     */
    public void dynamicDisplay(Properties ctx)
    {
    	if (gridField != null)
    	{
    		updateStyle();
    	}
    }

	public void updateStyle(boolean applyDictionaryStyle) {
		applyLabelStyles(applyDictionaryStyle);
		applyFieldStyles(applyDictionaryStyle);
	}

	public void updateStyle() {
		applyLabelStyles(true);
		applyFieldStyles(true);
	}

	protected void applyLabelStyles(boolean applyDictionaryStyle) {
		if (label != null) {
			boolean zoomable = isZoomable();
			LayoutUtils.addSclass(CLASS_NORMAL_LABEL, label);
			if (zoomable)
				LayoutUtils.addSclass(CLASS_ZOOMABLE_LABEL, label);
			if (isMandatoryStyle())
				LayoutUtils.addSclass(CLASS_EMPTY_MANDATORY_LABEL, label);
			else 
				LayoutUtils.removeSclass(CLASS_EMPTY_MANDATORY_LABEL, label);
			
			String style = "";
			if (ClientInfo.isMobile()) {
				if (!zoomable && popupMenu != null) {
					style = style + STYLE_MOBILE_ZOOMABLE;
				}
			}
			if (applyDictionaryStyle && gridField.getAD_LabelStyle_ID() > 0) 
			{
				String s = buildStyle(gridField.getAD_LabelStyle_ID());
				if (!Util.isEmpty(s)) {
					style = style + s;
				}
				setLabelStyle(style);
			}
			else
			{
				setLabelStyle(style);
			}
		}
	}
	
	protected void setLabelStyle(String style) {
		if (label != null) {
			if (style != null && style.toLowerCase().startsWith(MStyle.SCLASS_PREFIX)) {
				String sclass = style.substring(MStyle.SCLASS_PREFIX.length());
				label.setSclass(sclass);
			} else if (style != null && style.toLowerCase().startsWith(MStyle.ZCLASS_PREFIX)) {
				String zclass = style.substring(MStyle.ZCLASS_PREFIX.length());
				label.setZclass(zclass);
			} else {
				label.setStyle(style);
			}
//			if (this instanceof WRadioGroupEditor)
//				System.out.println(getComponent().getUuid() + " label stype="+label.getStyle());
		}
	}

	protected void applyFieldStyles(boolean applyDictionaryStyle) {
		String style = null;
		if (applyDictionaryStyle && gridField.getAD_FieldStyle_ID() > 0) 
		{
			style = buildStyle(gridField.getAD_FieldStyle_ID());
		}
		setFieldStyle(style);
		setFieldMandatoryStyle(applyDictionaryStyle);
	}
	
	private void setFieldMandatoryStyle(boolean applyStyle) {
		HtmlBasedComponent component = (HtmlBasedComponent) getComponent();
		if (component != null) {
			if (isMandatoryStyle() && applyStyle)
				LayoutUtils.addSclass(CLASS_MANDATORY_FIELD, component);
			else 
				LayoutUtils.removeSclass(CLASS_MANDATORY_FIELD, component);
		}
	}

	protected void setFieldStyle(String style) {
		HtmlBasedComponent component = (HtmlBasedComponent) getComponent();
		if (style != null && style.startsWith(MStyle.SCLASS_PREFIX)) {
			String sclass = style.substring(MStyle.SCLASS_PREFIX.length());
			if (component instanceof EditorBox)
				((EditorBox)component).getTextbox().setSclass(sclass);
			else if (component instanceof ComboEditorBox)
				((ComboEditorBox)component).getCombobox().setSclass(sclass);
			else
				component.setSclass(sclass);
		} else if (style != null && style.startsWith(MStyle.ZCLASS_PREFIX)) {
			String zclass = style.substring(MStyle.ZCLASS_PREFIX.length());
			if (component instanceof EditorBox)
				((EditorBox)component).getTextbox().setZclass(zclass);
			else if (component instanceof ComboEditorBox)
				((ComboEditorBox)component).getCombobox().setZclass(zclass);
			else
				component.setZclass(zclass);
		} else {
			if (component instanceof EditorBox)
				((EditorBox)component).getTextbox().setStyle(style);
			else if (component instanceof ComboEditorBox)
				((ComboEditorBox)component).getCombobox().setStyle(style);
			else
				component.setStyle(style);
		}
	}
	
	/**
	 * @return true if usable in find window, false otherwise
	 */
	public boolean isSearchable() {
		return true;
	}

	protected String buildStyle(int AD_Style_ID) {
		MStyle style = MStyle.get(Env.getCtx(), AD_Style_ID);
		return style.buildStyle(ThemeManager.getTheme(), getStyleEvaluatee());
	}
	
    /**
     * Stretch editor component to fill container
     */
    public void fillHorizontal() {
    	//stretch component to fill grid cell
        if (getComponent() instanceof HtmlBasedComponent) {
        	//can't stretch bandbox & datebox
        	if (!(getComponent() instanceof Bandbox) &&
        		!(getComponent() instanceof Datebox) &&
        		!(getComponent() instanceof DatetimeBox) &&
        		!(getComponent() instanceof Timebox)) {
        		String width = tableEditor ? "96%" : "100%";
        		if (getComponent() instanceof Button) {
        			if (!tableEditor) {
	        			Button btn = (Button) getComponent();
	        			String zclass = btn.getZclass();
	        			if (gridField.getDisplayType() == DisplayType.Image) {
	        				if (!zclass.contains("image-button-field ")) {
	            				btn.setZclass("image-button-field " + zclass);
	        				}
	        			} else if (!zclass.contains("form-button ")) {
	        				btn.setZclass("form-button " + zclass);
	        			}
        			}
        		} else {
        			if (!tableEditor) {
	        			if (getComponent() instanceof InputElement) {
	        				ZKUpdateUtil.setHflex((InputElement)getComponent(), "1");
	        			} else {
	        				ZKUpdateUtil.setWidth((HtmlBasedComponent)getComponent(), width);
	        			}
        			} else {
        				if (getComponent() instanceof Combobox) {
        					LayoutUtils.addSclass("grid-combobox-editor", (HtmlBasedComponent)getComponent());
	        			} else {
	        				ZKUpdateUtil.setWidth((HtmlBasedComponent)getComponent(), width);
	        			}
        					
        			}
        			
        			if (getComponent() instanceof Textbox && tableEditor) {
        				Textbox textbox = (Textbox) getComponent();
        				if (textbox.isMultiline()) {
        					textbox.setRows(1);
        				}
        			}
        		}
        	}
        }
        
        if (gridField != null) {
        	updateStyle();
        }
    }

    /**
     * @deprecated
     */
	public void updateLabelStyle() {				
		updateStyle();
	}
	
	public boolean isMandatoryStyle() {
		return mandatory && !readOnly && (isProcessParameter || getGridField().isEditable(true)) && isNullOrEmpty();
	}

	public boolean isNullOrEmpty() {
		Object value = getValue();
		return value == null || value.toString().trim().length() == 0;
	}
	
	public boolean isZoomable() {
		WEditorPopupMenu menu = getPopupMenu();
		if (menu != null && menu.isZoomEnabled() && this instanceof IZoomableEditor) {
			return true;
		} else {
			return false;
		}
	}

	public void setTableEditor(boolean b) {
		tableEditor = b;
	}

	/**
	 * @return boolean
	 */
	protected boolean isShowPreference() {
		return MRole.getDefault().isShowPreference() && gridField != null && !gridField.isEncrypted() && !gridField.isEncryptedColumn() && !gridField.isVirtualColumn();
	}

	/**
	 * @param popupMenu
	 */
    protected void addChangeLogMenu(WEditorPopupMenu popupMenu) {
		if (popupMenu != null && gridField != null && gridField.getGridTab() != null && !gridField.isVirtualColumn())
		{
			WFieldRecordInfo.addMenu(popupMenu);
		}
	}

    /**
     * @param popupMenu
     */
	protected void addTextEditorMenu(WEditorPopupMenu popupMenu) {
		Menuitem editor = new Menuitem();
		editor.setAttribute("EVENT", WEditorPopupMenu.EDITOR_EVENT);
		editor.setLabel(Util.cleanAmp(Msg.getMsg(Env.getCtx(), "Editor")).intern());
        if (ThemeManager.isUseFontIconForImage())
        	editor.setIconSclass("z-icon-Edit");
        else
        	editor.setImage(ThemeManager.getThemeResource("images/Editor16.png"));
        editor.addEventListener(Events.ON_CLICK, popupMenu);
		popupMenu.appendChild(editor);
	}
	
	public boolean isComponentOfEditor(Component comp) {
		if (comp == getComponent())
			return true;
		if (getComponent() instanceof EditorBox)
		{
			EditorBox component = (EditorBox) getComponent();
			if (comp == component.getTextbox())
				return true;
			if (comp == component.getButton())
				return true;
		}
		else if (getComponent() instanceof DatetimeBox)
		{
			DatetimeBox component = (DatetimeBox) getComponent();
			if (comp == component.getDatebox())
				return true;
			if (comp == component.getTimebox())
				return true;
		}
		else if (getComponent() instanceof NumberBox)
		{
			NumberBox component = (NumberBox) getComponent();
			if (comp == component.getDecimalbox())
				return true;
			if (comp == component.getButton())
				return true;
		}
		else if (getComponent() instanceof Paymentbox)
		{
			Paymentbox component = (Paymentbox) getComponent();
			if (comp == component.getCombobox())
				return true;
			if (comp == component.getButton())
				return true;
		}		
		return false;
	}
	
	public boolean isProcessParameter() {
		return isProcessParameter;
	}

	public void setProcessParameter(boolean isProcessParameter) {
		this.isProcessParameter = isProcessParameter;
	}

	/**
	 * return component use for display value in grid view mode in non edit status
	 * if return null, a label will replace.
	 * because each row must has one instance of this component, don't cache it. just create new instance
	 * @return
	 */
	public Component getDisplayComponent() {
		return null;
	}

	protected void focusNext() {
		Component comp = getComponent();
		Component parent = comp.getParent();
		while (parent != null) {
			if (parent instanceof IFieldEditorContainer) {
				((IFieldEditorContainer) parent).focusToNextEditor(this);
				break;
			}
			parent = parent.getParent();
		}
	}

	protected Evaluatee getStyleEvaluatee() {
		return new EvaluateeWrapper(this, gridField, tableEditor);
	}

	private static final String CLASS_MANDATORY_FIELD = "idempiere-mandatory";
	private static final String CLASS_ZOOMABLE_LABEL = "idempiere-zoomable-label";
	private static final String CLASS_NORMAL_LABEL = "idempiere-label";
	private static final String CLASS_EMPTY_MANDATORY_LABEL = "idempiere-mandatory-label";
	private static final String STYLE_MOBILE_ZOOMABLE = "cursor: pointer;";
	
	private static class EvaluateeWrapper implements Evaluatee {
		
		private GridField gridField;
		private boolean tableEditor;
		private WEditor editor;

		private EvaluateeWrapper(WEditor editor, GridField gridField, boolean tableEditor) {
			this.editor = editor;
			this.gridField = gridField;
			this.tableEditor = tableEditor;
		}
		
		@Override
		public String get_ValueAsString(String variableName) {
			if ("_Editor_IsGridView".equals(variableName))
				return tableEditor ? "Y" : "N";
			else if ("_Editor_IsReadOnly".equals(variableName))
				return editor.isReadWrite() ? "N" : "Y";
			else if ("_Editor_IsZoomable".equals(variableName))
				return editor.isZoomable() ? "Y" : "N";
			else if ("_Editor_IsMandatory".equals(variableName))
				return editor.isMandatory() ? "Y" : "N";
			
			return gridField.get_ValueAsString(variableName);
		}
		
	}
	
	@Override
	public String getValidInput() {
		return this.sValidInput;
	}
	
	@Override
	public void setValidInput(String validInput) {
		this.sValidInput = validInput;
	}
	
	@Override
	public boolean isValid(String input) {
		return Util.isEmpty(sValidInput) ? true : sValidInput.equals(input);
	}
}
