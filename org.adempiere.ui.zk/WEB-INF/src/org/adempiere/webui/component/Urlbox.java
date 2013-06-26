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
package org.adempiere.webui.component;

import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;

import org.adempiere.webui.LayoutUtils;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.A;
import org.zkoss.zul.Div;

/**
 * URL Box
 * @author Low Heng Sin
 */
public class Urlbox extends Div 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5493978668402134644L;
	
	protected PropertyChangeSupport m_propertyChangeListeners = new PropertyChangeSupport(this);
	protected Textbox txt;
	protected A btn;
	
	public Urlbox()
    {
		initComponents();
    }

    /**
     * @param url
     */
    public Urlbox(String url)
    {
    	initComponents();
        setText(url);
    }
    
    private void initComponents() {
		txt = new Textbox();
		appendChild(txt);
		txt.setHflex("0");
		txt.setSclass("editor-input");

		btn = new A();
		btn.setTarget("_blank");
		btn.setTabindex(-1);
		btn.setSclass("editor-button");
		btn.setZclass("z-button-os");
		btn.setHflex("0");
		appendChild(btn);

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
		String url = null;
		if (value == null) {
			url = "about:blank";
		} else {
			url = value.trim();
			if (url.length() == 0) {
				url = "about:blank";
			} else if (url.indexOf("://") < 0) {
				url = "http://"+url;
			}
		}
		btn.setHref(url);
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
	 * @return A
	 */
	public A getButton() {
		return btn;
	}
	
	public void setTableEditorMode(boolean flag) {
		if (flag) {
			setHflex("0");
			LayoutUtils.addSclass("grid-editor-input", txt);
			LayoutUtils.addSclass("grid-editor-button", btn);
		} else {
			setHflex("1");
			LayoutUtils.removeSclass("grid-editor-input", txt);
			LayoutUtils.removeSclass("grid-editor-button", btn);
		}
			
	}
}