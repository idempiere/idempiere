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
 *                                                                     *
 * Contributors:                                                       *
 * - Carlos Ruiz - globalqss - bxservice                               *
 **********************************************************************/

package org.adempiere.webui.component;

import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.theme.ThemeManager;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.util.Clients;
import org.zkoss.zul.Div;

/**
 * Textbox with a Copy button
 * @author Carlos Ruiz - globalqss - bxservice
 */
public class TextboxWithCopy extends Div 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5493978668402134644L;
	
	protected PropertyChangeSupport m_propertyChangeListeners = new PropertyChangeSupport(this);
	protected Textbox txt;
    protected Button btn;
	
	public TextboxWithCopy()
    {
		initComponents();
    }

    /**
     * @param text
     */
    public TextboxWithCopy(String text)
    {
    	initComponents();
        setText(text);
    }
    
    private void initComponents() {
		txt = new Textbox();
		appendChild(txt);
		ZKUpdateUtil.setHflex(txt, "0");
		txt.setSclass("editor-input");

		btn = new Button();
		if (ThemeManager.isUseFontIconForImage())
			btn.setIconSclass("z-icon-Copy");
		else
			btn.setImage(ThemeManager.getThemeResource("images/Copy16.png"));
		btn.setTabindex(-1);
		btn.setZclass("z-button-os");
		ZKUpdateUtil.setHflex(btn, "0");
		LayoutUtils.addSclass("editor-button", btn);
		appendChild(btn);
		btn.addEventListener(Events.ON_CLICK, new EventListener<Event>() {
			@Override
			public void onEvent(Event event) throws Exception {
				if (!Util.isEmpty(getText())) {
					StringBuffer sb = new StringBuffer("navigator.clipboard.writeText(\"")
							.append(getText())
							.append("\");");
						Clients.evalJavaScript(sb.toString());
				}
			}
		});

		LayoutUtils.addSclass("editor-box", this);
		setTableEditorMode(false);
	}
    
    /**
	 * @param imageSrc
	 */
	public void setButtonImage(String imageSrc) {
		btn.setImage(imageSrc);
	}
	
    /**
	 * @return textbox component
	 */
	public Textbox getTextbox() {
		return txt;
	}

	/**
	 * @param value
	 */
	public void setText(String value) {
		txt.setText(value);
	}

	/**
	 * @return text
	 */
	public String getText() {
		return txt.getText();
	}
	
	public void setEnabled(boolean enabled) {
    	txt.setReadonly(!enabled);
    	if (enabled) {
			LayoutUtils.removeSclass("editor-input-disd", txt);
		} else {
			LayoutUtils.addSclass("editor-input-disd", txt);
		}
	}
	
	/**
	 * @return boolean
	 */
	public boolean isEnabled() {
		return !txt.isReadonly();
	}

	/**
	 * @param evtnm
	 * @param listener
	 */
	public boolean addEventListener(String evtnm, EventListener<?> listener) {
		if (Events.ON_CLICK.equals(evtnm)) {
			return btn.addEventListener(evtnm, listener);
		} else {
			return txt.addEventListener(evtnm, listener);
		}
	}
	
	/**
	 * @param l
	 */
	public synchronized void addPropertyChangeListener(PropertyChangeListener l) {
		m_propertyChangeListeners.addPropertyChangeListener(l);
	}

	/**
	 * @param tooltiptext
	 */
	public void setToolTipText(String tooltiptext) {
		txt.setTooltiptext(tooltiptext);
	}
	
	/**
	 * @return Button
	 */
	public Button getButton() {
		return btn;
	}
	
	public void setTableEditorMode(boolean flag) {
		if (flag) {
			ZKUpdateUtil.setHflex(this, "0");
			LayoutUtils.addSclass("grid-editor-input", txt);
			LayoutUtils.addSclass("grid-editor-button", btn);
		} else {
			ZKUpdateUtil.setHflex(this, "1");
			LayoutUtils.removeSclass("grid-editor-input", txt);
			LayoutUtils.removeSclass("grid-editor-button", btn);
		}
			
	}

	@Override
	public void focus() {
		txt.focus();
	}
}