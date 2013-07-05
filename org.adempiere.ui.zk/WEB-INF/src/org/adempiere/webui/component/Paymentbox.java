/******************************************************************************
 * Copyright (C) 2012 Elaine Tan                                              *
 * Copyright (C) 2012 Trek Global
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
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Div;

/**
 * 
 * @author Elaine
 *
 */
public class Paymentbox extends Div {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1807586169091171780L;
	protected PropertyChangeSupport m_propertyChangeListeners = new PropertyChangeSupport(this);
	protected Combobox combo;
	protected Button btn;
	
	public Paymentbox() {
		initComponents();
	}
	
	public Paymentbox(Comboitem comboitem) {
		initComponents();
		setSelectedComboItem(comboitem);
	}
	
	public void setButtonImage(String imageSrc) {
		btn.setImage(imageSrc);
	}
	
	private void initComponents() {
		combo = new Combobox();
		appendChild(combo);
		combo.setHflex("0");

		btn = new Button();
		btn.setTabindex(-1);
		btn.setSclass("editor-button");
		btn.setHflex("0");
		appendChild(btn);

		LayoutUtils.addSclass("payment-rule-editor", this);
	}
	
	public Combobox getCombobox() {
		return combo;
	}
	
	public void setSelectedComboItem(Comboitem comboitem) {
		combo.setSelectedItem(comboitem);
	}
	
	public Comboitem getSelectedComboItem() {
		return combo.getSelectedItem();
	}
	
	public void setEnabled(boolean isComboEnabled, boolean isBtnEnabled) {
		combo.setEnabled(isComboEnabled);
		combo.setButtonVisible(isComboEnabled);
		btn.setEnabled(isBtnEnabled);
		btn.setVisible(isBtnEnabled);
		if (isBtnEnabled) {
			if (btn.getParent() != combo.getParent())
				btn.setParent(combo.getParent());
		} else {
			if (btn.getParent() != null)
				btn.detach();
		}
		if (isComboEnabled) {
			LayoutUtils.removeSclass("editor-input-disd", combo);
		} else {
			LayoutUtils.addSclass("editor-input-disd", combo);
		}
		if (btn.getParent() == null) {
			LayoutUtils.addSclass("no-button", combo);
		} else {
			LayoutUtils.removeSclass("no-button", combo);
		}
	}
	
	public boolean isEnabled() {
		return combo.isEnabled();
	}
	
	public boolean addEventListener(String evtnm, EventListener<?> listener) {
		if (Events.ON_CLICK.equals(evtnm)) {
			return btn.addEventListener(evtnm, listener);
		} else {
			return combo.addEventListener(evtnm, listener);
		}
	}
	
	public synchronized void addPropertyChangeListener(PropertyChangeListener l) {
		m_propertyChangeListeners.addPropertyChangeListener(l);
	}
	
	public Button getButton() {
		return btn;
	}	
}
