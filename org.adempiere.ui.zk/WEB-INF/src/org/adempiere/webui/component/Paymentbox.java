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
import org.zkoss.zul.Hlayout;

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
		Hlayout hlayout = new Hlayout();
		this.appendChild(hlayout);
		hlayout.setHflex("1");
		combo = new Combobox();
		hlayout.appendChild(combo);
		combo.setHflex("1");

		btn = new Button();
		btn.setTabindex(-1);
		btn.setSclass("editor-button");
		btn.setHflex("0");
		hlayout.appendChild(btn);

		LayoutUtils.addSclass("editor-box", this);
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
		combo.setReadonly(!isComboEnabled);
		btn.setEnabled(isBtnEnabled);
		btn.setVisible(isBtnEnabled);
		if (isBtnEnabled) {
			btn.setSclass("editor-button");
			btn.setParent(this.getFirstChild());
		} else {
			btn.detach();
		}
	}
	
	public boolean isEnabled() {
		return !combo.isReadonly();
	}
	
	public boolean addEventListener(String evtnm, EventListener listener) {
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
