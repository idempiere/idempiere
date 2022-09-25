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

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;

import org.adempiere.webui.ClientInfo;
import org.adempiere.webui.ValuePreference;
import org.adempiere.webui.apps.AEnv;
import org.adempiere.webui.component.NumberBox;
import org.adempiere.webui.event.ContextMenuEvent;
import org.adempiere.webui.event.ContextMenuListener;
import org.adempiere.webui.event.ValueChangeEvent;
import org.adempiere.webui.window.WFieldRecordInfo;
import org.compiere.model.GridField;
import org.compiere.util.DisplayType;
import org.compiere.util.Env;
import org.compiere.util.Language;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;

/**
 *
 * @author  <a href="mailto:agramdass@gmail.com">Ashley G Ramdass</a>
 * @date    Mar 11, 2007
 * @version $Revision: 0.10 $
 *
 * @author Low Heng Sin
 * @author Cristina Ghita, www.arhipac.ro
 *  	   <li> BF [3058780] WNumberEditor allow only BigDecimal
 *  	   @see https://sourceforge.net/p/adempiere/zk-web-client/433/
 */
public class WNumberEditor extends WEditor implements ContextMenuListener
{
    public static final String[] LISTENER_EVENTS = {Events.ON_CHANGE, Events.ON_OK};

    public static final int MAX_DISPLAY_LENGTH = 35;
    public static final int MIN_DISPLAY_LENGTH = 11;

    private Object oldValue;

	private int displayType;

	private String originalStyle;

    public WNumberEditor()
    {
    	this("Number", false, false, true, DisplayType.Number, "");
    }

    /**
    *
    * @param gridField
    */
    public WNumberEditor(GridField gridField)
    {
    	this(gridField, false, null);
    }
   
    /**
     * 
     * @param gridField
     * @param tableEditor
     * @param editorConfiguration
     */
    public WNumberEditor(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration)
    {
        super(newNumberBox(gridField, tableEditor, editorConfiguration), 
                gridField, tableEditor, editorConfiguration);
        this.displayType = gridField.getDisplayType();
        if (editorConfiguration != null && editorConfiguration instanceof INumberEditorConfiguration) {
        	INumberEditorConfiguration config = (INumberEditorConfiguration) editorConfiguration;
			if (config.getIntegral() != null) {
				if (config.getIntegral())
					this.displayType = DisplayType.Integer;
				else 
					this.displayType = DisplayType.Number;
			}
        }
        init();
    }

	protected static NumberBox newNumberBox(GridField gridField, boolean tableEditor, IEditorConfiguration editorConfiguration) {
		if (editorConfiguration != null && editorConfiguration instanceof INumberEditorConfiguration) {
			INumberEditorConfiguration config = (INumberEditorConfiguration) editorConfiguration;
			if (config.getIntegral() != null)
				return new NumberBox(config.getIntegral(), tableEditor);
		}
		return new NumberBox(gridField.getDisplayType() == DisplayType.Integer, tableEditor);
	}

    /**
     *
     * @param gridField
     * @param integral
     */
    public WNumberEditor(GridField gridField, boolean integral)
    {
        this(gridField, false, new INumberEditorConfiguration() {
        	@Override
        	public Boolean getIntegral() {
        		return Boolean.valueOf(integral);
        	}
		});        
    }

    /**
     *
     * @param columnName
     * @param mandatory
     * @param readonly
     * @param updateable
     * @param displayType
     * @param title
     */
    public WNumberEditor(String columnName, boolean mandatory, boolean readonly, boolean updateable,
			int displayType, String title)
    {
		super(new NumberBox(displayType == DisplayType.Integer), columnName, title, null, mandatory,
				readonly, updateable);
		this.displayType = displayType;
		init();
	}

	private void init()
    {
		setChangeEventWhenEditing (true);
		if (gridField != null)
		{
			getComponent().setTooltiptext(gridField.getDescription());
	        int displayLength = gridField.getDisplayLength();
	        if (displayLength > MAX_DISPLAY_LENGTH)
	            displayLength = MAX_DISPLAY_LENGTH;
	        else if (displayLength <= 0 || displayLength < MIN_DISPLAY_LENGTH)
	        	displayLength = MIN_DISPLAY_LENGTH;
	        if (!tableEditor)
	        	getComponent().getDecimalbox().setCols(displayLength);
//	        else
//	        	getComponent().getDecimalbox().setCols(0);
		}

		if (DisplayType.isID(displayType)) 
			displayType = DisplayType.Integer;
		else if (!DisplayType.isNumeric(displayType))
			displayType = DisplayType.Number;
		// IDEMPIERE-989
		Language lang = AEnv.getLanguage(Env.getCtx());
		DecimalFormat format = DisplayType.getNumberFormat(displayType, lang);
		if (gridField != null && gridField.getFormatPattern() != null)
			getComponent().getDecimalbox().setFormat(gridField.getFormatPattern());
		else
			getComponent().getDecimalbox().setFormat(format.toPattern());
		getComponent().getDecimalbox().setLocale(lang.getLocale());
		getComponent().setFormat(format);
		
		popupMenu = new WEditorPopupMenu(false, false, isShowPreference());
    	addChangeLogMenu(popupMenu);
    	
    	originalStyle = getComponent().getDecimalbox().getStyle();
    	if (ClientInfo.isMobile())
    		getComponent().getButton().setVisible(false);

    	if (gridField != null)
    		getComponent().getDecimalbox().setPlaceholder(gridField.getPlaceholder());
    }
	
	/**
	 * Event handler
	 * @param event
	 */
    public void onEvent(Event event)
    {
    	if (Events.ON_CHANGE.equalsIgnoreCase(event.getName()) || Events.ON_OK.equalsIgnoreCase(event.getName()))
    	{
	        Object newValue = getComponent().getValue();
	        if (oldValue == null && newValue == null) {
	        	return;
	        }
	        
	        if (displayType == DisplayType.Integer) {
		        if (newValue != null && newValue instanceof BigDecimal) {
		        	newValue = Integer.valueOf(((BigDecimal)newValue).intValue());
		        }
		        if (oldValue != null && oldValue instanceof BigDecimal) {
		        	oldValue = Integer.valueOf(((BigDecimal)oldValue).intValue());
		        }
	        }
	        
	        if (oldValue != null && newValue != null && oldValue.equals(newValue)) 
	        {
	    	    return;
	    	}
	        
	        //IDEMPIERE-2553 - Enter amounts without decimal separator
	        if(displayType == DisplayType.Amount || displayType == DisplayType.CostPrice){
	        	if (newValue != null && newValue instanceof BigDecimal) {
	        		newValue = addDecimalPlaces((BigDecimal)newValue);
		        }	        
	        }
	        
	        ValueChangeEvent changeEvent = new ValueChangeEvent(this, this.getColumnName(), oldValue, newValue);
	        super.fireValueChange(changeEvent);
	        oldValue = getComponent().getValue(); // IDEMPIERE-963 - check again the value could be changed by callout
    	}
    }
    
    /**
     * IDEMPIERE-2553 - Enter amounts without decimal separator
     * @param oldValue
     * @return
     */
    public BigDecimal addDecimalPlaces(BigDecimal oldValue){
    	if(oldValue.toString().contains("."))
    		return oldValue;
    	
    	int decimalPlaces = Env.getContextAsInt(Env.getCtx(), "AutomaticDecimalPlacesForAmoun");
    	if(decimalPlaces <= 0)
    		return oldValue;

    	BigDecimal divisor;
    	if (decimalPlaces == 2) // most common case
    		divisor = Env.ONEHUNDRED;
    	else if (decimalPlaces == 1)
    		divisor = BigDecimal.TEN;
    	else
    		divisor = BigDecimal.TEN.pow(decimalPlaces);
    	BigDecimal newValue = oldValue.divide(divisor, decimalPlaces, RoundingMode.HALF_UP);
    	return newValue;
    } //getAddDecimalPlaces

    @Override
	public NumberBox getComponent() {
		return (NumberBox) component;
	}

	@Override
	public boolean isReadWrite() {
		return getComponent().isEnabled();
	}

	@Override
	public void setReadWrite(boolean readWrite) {
		getComponent().setEnabled(readWrite);
	}

	@Override
    public String getDisplay()
    {
        return getComponent().getText();
    }

    @Override
    public BigDecimal getValue()
    {
        return getComponent().getValue();
    }

    @Override
    public void setValue(Object value)
    {
    	if (value == null)
    		oldValue = null;
    	else if (value instanceof BigDecimal)
    		oldValue = (BigDecimal) value;
    	else if (value instanceof Number)
    		oldValue = BigDecimal.valueOf(((Number)value).doubleValue());
    	else
    		oldValue = new BigDecimal(value.toString());
    	getComponent().setValue(oldValue);
    }

    @Override
    public String[] getEvents()
    {
        return LISTENER_EVENTS;
    }

    /**
     * Handle context menu events
     * @param evt
     */
    public void onMenu(ContextMenuEvent evt)
	{
	 	if (WEditorPopupMenu.PREFERENCE_EVENT.equals(evt.getContextEvent()))
		{
			if (isShowPreference())
				ValuePreference.start (getComponent(), this.getGridField(), getValue());
			return;
		}
	 	else if (WEditorPopupMenu.CHANGE_LOG_EVENT.equals(evt.getContextEvent()))
		{
			WFieldRecordInfo.start(gridField);
		}
	}

	@Override
	public void setTableEditor(boolean b) {
		super.setTableEditor(b);
		getComponent().setTableEditorMode(b);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.editor.WEditor#setFieldStyle(java.lang.String)
	 */
	@Override
	protected void setFieldStyle(String style) {
		StringBuilder s = new StringBuilder(originalStyle);
		if (!(s.charAt(s.length()-1)==';'))
			s.append(";");
		if (!Util.isEmpty(style))
			s.append(style);
		getComponent().getDecimalbox().setStyle(s.toString());
	}     
}
