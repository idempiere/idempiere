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

package org.adempiere.webui.component;

import org.adempiere.webui.LayoutUtils;

/**
 * Extend {@link org.zkoss.zul.Toolbarbutton}
 * @author Sendy Yagambrum
 * @date July, 10 2007
 */
public class ToolBarButton extends org.zkoss.zul.Toolbarbutton
{
    /**
	 * generated serial id
	 */
	private static final long serialVersionUID = -1214319982911389339L;

    private String name;
    
    /** true if using toggle mode and checked */
    private boolean pressed;
    
    /**
     * Default constructor
     */
    public ToolBarButton() {
    	setAutodisable("self");
    }
    
    @Override
	public void setDisabled(boolean disabled) {    	
    	if (disabled && isChecked())
    		setChecked(false);	// uncheck when button is disabled
    	
		super.setDisabled(disabled);
		if (disabled) {
			LayoutUtils.addSclass("disableFilter", this);
			this.setSclass(getSclass().intern());
		} else {
			if (this.getSclass() != null && this.getSclass().indexOf("disableFilter") >= 0)
				this.setSclass(this.getSclass().replace("disableFilter", "").intern());
		}
	}
    
    /**
     * Set to toggle or default mode.
     * @param pressed true for toggle mode.
     */
    public void setPressed(boolean pressed) {
    	this.pressed = pressed; // Elaine 2008/12/09
    	
		if (!isDisabled()) {
			if (pressed) {
				setMode("toggle");
				setChecked(true);
			} else {
				setMode("default");
				setChecked(false);
			}			
		}
    }
    
    /**
     * @return true if toggle mode and checked
     */
    public boolean isPressed()
    {
    	return pressed;
    }

    /**
     * @param name
     */
	public ToolBarButton(String name) {
    	super();
    	this.name = name;
    	setAutodisable("self");
    }
    
	/**
	 * @return name of button
	 */
    public String getName() {
    	return name;
    }
    
    /**
     * Set name of button
     * @param name
     */
    public void setName(String name) {
    	this.name = name;
    }

	@Override
	public void setTooltiptext(String tooltiptext) {
		super.setTooltiptext(tooltiptext != null ? tooltiptext.replaceAll("[&]", "") : null);
	}
}
