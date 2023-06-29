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
import org.adempiere.webui.util.ZKUpdateUtil;
import org.compiere.model.MSysConfig;
import org.compiere.util.Env;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Comboitem;
import org.zkoss.zul.Div;

/**
 * Composite component of {@link Combobox} and {@link Button}.
 * For Payment Rule editor.
 * @author Elaine
 */
public class Paymentbox extends Div {
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 1807586169091171780L;
	protected PropertyChangeSupport m_propertyChangeListeners = new PropertyChangeSupport(this);
	/** List of payment rules */
	protected Combobox combo;
	/** Button to open payment form */
	protected Button btn;
	
	/**
	 * Default constructor
	 */
	public Paymentbox() {
		initComponents();
	}
	
	/**
	 * @param comboitem
	 */
	public Paymentbox(Comboitem comboitem) {
		initComponents();
		setSelectedComboItem(comboitem);
	}
	
	/**
	 * Set image URL of button
	 * @param imageSrc
	 */
	public void setButtonImage(String imageSrc) {
		btn.setImage(imageSrc);
	}
	
	/**
	 * Layout component
	 */
	private void initComponents() {
		combo = new Combobox();
		appendChild(combo);
		ZKUpdateUtil.setHflex(combo, "0");

		btn = new Button();
		btn.setTabindex(-1);
		btn.setSclass("editor-button");
		ZKUpdateUtil.setHflex(btn, "0");
		appendChild(btn);

		LayoutUtils.addSclass("payment-rule-editor", this);
	}
	
	/**
	 * @return Combobox 
	 */
	public Combobox getCombobox() {
		return combo;
	}
	
	/**
	 * Set selected Combo Item
	 * @param comboitem
	 */
	public void setSelectedComboItem(Comboitem comboitem) {
		combo.setSelectedItem(comboitem);
	}
	
	/**
	 * @return selected Comboitem  
	 */
	public Comboitem getSelectedComboItem() {
		return combo.getSelectedItem();
	}
	
	/**
	 * Set enable/disable. Hide button if disable.
	 * @param isComboEnabled
	 * @param isBtnEnabled
	 */
	public void setEnabled(boolean isComboEnabled, boolean isBtnEnabled) {
		if (! MSysConfig.getBooleanValue(MSysConfig.ENABLE_PAYMENTBOX_BUTTON, true, Env.getAD_Client_ID(Env.getCtx())))
			isBtnEnabled = false;
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
	
	/**
	 * @return true if enable, false otherwise
	 */
	public boolean isEnabled() {
		return combo.isEnabled();
	}
	
	/**
	 * If evtnm is ON_CLICK, add listener to {@link #btn}.
	 * Otherwise add listener to {@link #combo}.
	 * @param evtnm
	 * @param listener
	 * @return true if listener added to Button or Combobox
	 */
	public boolean addEventListener(String evtnm, EventListener<?> listener) {
		if (Events.ON_CLICK.equals(evtnm)) {
			return btn.addEventListener(evtnm, listener);
		} else {
			return combo.addEventListener(evtnm, listener);
		}
	}
	
	/**
	 * @param l PropertyChangeListener
	 */
	public synchronized void addPropertyChangeListener(PropertyChangeListener l) {
		m_propertyChangeListeners.addPropertyChangeListener(l);
	}
	
	/**
	 * @return Button
	 */
	public Button getButton() {
		return btn;
	}	
}
