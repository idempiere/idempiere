/******************************************************************************
 * Project: Trek Global ERP                                                   *                       
 * Copyright (C) 2009-2018 Trek Global Corporation                            *
 *                                                                            *
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
import org.compiere.util.ValueNamePair;
import org.zkoss.addon.chosenbox.Chosenbox;
import org.zkoss.zk.ui.Page;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Div;

/**
 * @author Low Heng Sin
 */
public class ChosenSearchBox extends Div {
	/**
	 *
	 */
	private static final long serialVersionUID = -3152111756471436612L;
	protected PropertyChangeSupport m_propertyChangeListeners = new PropertyChangeSupport(
			this);
	protected Chosenbox<ValueNamePair> chosenbox;
	protected Button btn;

	/**
	 * 
	 * @param chosenbox custom implementation of Chosenbox
	 */
	public ChosenSearchBox(Chosenbox<ValueNamePair> chosenbox) {
		this.chosenbox = chosenbox;
		initComponents();
	}
	
	/**
	 * default constructor
	 */
	public ChosenSearchBox() {
		initComponents();
	}

	/**
	 * @param imageSrc
	 */
	public void setButtonImage(String imageSrc) {
		btn.setImage(imageSrc);
	}

	private void initComponents() {
		if (chosenbox == null) 
			chosenbox = new Chosenbox<>();
		chosenbox.setSclass("editor-input");
		chosenbox.setWidth("100%");
		appendChild(chosenbox);
		btn = new Button();
		btn.setTabindex(-1);
		btn.setHflex("0");
		btn.setSclass("editor-button");
		appendChild(btn);
		
		LayoutUtils.addSclass("editor-box", this);
		setTableEditorMode(false);
	}

	/**
	 * @return chosenbox component
	 */
	public Chosenbox<ValueNamePair> getChosenbox() {
		return chosenbox;
	}

	/**
	 * @param enabled
	 */
	public void setEnabled(boolean enabled) {
		chosenbox.setDisabled(!enabled);
		btn.setEnabled(enabled);
		btn.setVisible(enabled);
		if (enabled) {
			if (btn.getParent() != chosenbox.getParent())
				btn.setParent(chosenbox.getParent());
		} else {
			if (btn.getParent() != null)
				btn.detach();
		}
		if (enabled) {
			LayoutUtils.removeSclass("editor-input-disd", chosenbox);
		} else {
			LayoutUtils.addSclass("editor-input-disd", chosenbox);
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
			return chosenbox.addEventListener(evtnm, listener);
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
		chosenbox.setTooltiptext(tooltiptext);
	}
	
	/**
	 * @return Button
	 */
	public Button getButton() {
		return btn;
	}
	
	public void setTableEditorMode(boolean flag) {
		if (flag) {
			setHflex("0");
			LayoutUtils.addSclass("grid-editor-input", chosenbox);
			LayoutUtils.addSclass("grid-editor-button", btn);
		} else {
			setHflex("1");
			LayoutUtils.removeSclass("grid-editor-input", chosenbox);
			LayoutUtils.removeSclass("grid-editor-button", btn);
		}
			
	}

	@Override
	public void onPageAttached(Page newpage, Page oldpage) {
		super.onPageAttached(newpage, oldpage);
	}
}
