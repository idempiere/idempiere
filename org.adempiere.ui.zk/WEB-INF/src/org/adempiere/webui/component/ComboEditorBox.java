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
 * - hengsin                         								   *
 **********************************************************************/
package org.adempiere.webui.component;

import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;

import org.adempiere.webui.LayoutUtils;
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.util.ValueNamePair;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.ComboitemRenderer;
import org.zkoss.zul.Div;

/**
 * @author Low Heng Sin
 */
public class ComboEditorBox extends Div {	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4187563277424346012L;
	protected PropertyChangeSupport m_propertyChangeListeners = new PropertyChangeSupport(
			this);
	protected Combobox txt;
	protected Button btn;

	public ComboEditorBox() {
		initComponents();
	}

	/**
	 * @param text
	 */
	public ComboEditorBox(String text) {
		initComponents();
		setText(text);
	}

	/**
	 * @param imageSrc
	 */
	public void setButtonImage(String imageSrc) {
		btn.setImage(imageSrc);
	}

	private void initComponents() {
		txt = new Combobox();
		txt.setButtonVisible(false);
		txt.setSclass("editor-input");
		txt.setAutocomplete(true);
		txt.setAutodrop(true);
		txt.setSubmitByEnter(true);
		txt.setInstantSelect(false);
		ZKUpdateUtil.setHflex(txt, "0");
		appendChild(txt);
		btn = new Button();
		btn.setTabindex(-1);
		ZKUpdateUtil.setHflex(btn, "0");
		btn.setSclass("editor-button");
		appendChild(btn);
		
		LayoutUtils.addSclass("editor-box", this);
		setTableEditorMode(false);
		
		txt.setItemRenderer(new ComboitemRenderer<ValueNamePair>() {		
			public void render(Comboitem item, ValueNamePair data, int index){
				item.setValue(data);
				item.setLabel(data.getName());
			}
		});
	}

	/**
	 * @return combobox component
	 */
	public Combobox getCombobox() {
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

	/**
	 * @param enabled
	 */
	public void setEnabled(boolean enabled) {
		txt.setReadonly(!enabled);
		btn.setEnabled(enabled);
		btn.setVisible(enabled);
		if (enabled) {
			if (btn.getParent() != txt.getParent())
				btn.setParent(txt.getParent());
		} else {
			if (btn.getParent() != null)
				btn.detach();
		}
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
		return btn.isEnabled();
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
}
