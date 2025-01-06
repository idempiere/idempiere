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
package org.adempiere.webui.adwindow;

import java.util.List;

import org.adempiere.util.Callback;
import org.adempiere.webui.adwindow.validator.WindowValidatorEvent;
import org.adempiere.webui.adwindow.validator.WindowValidatorEventType;
import org.adempiere.webui.adwindow.validator.WindowValidatorManager;
import org.adempiere.webui.component.Menupopup;
import org.adempiere.webui.editor.IProcessButton;
import org.adempiere.webui.editor.WButtonEditor;
import org.adempiere.webui.panel.WDocActionPanel;
import org.compiere.model.GridTab;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.compiere.util.Util;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.EventListener;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Button;
import org.zkoss.zul.Listitem;
import org.zkoss.zul.Menu;
import org.zkoss.zul.Menuitem;
import org.zkoss.zul.Menuseparator;

/**
 * Popup menu for process buttons and document actions
 * @author hengsin
 */
public class ProcessButtonPopup extends Menupopup implements EventListener<Event> {
	
	/** sclass for document action menu items **/
	private static final String DOCUMENT_ACTION_MENUITEM_SCLASS = "document-action-menuitem";
	/** Menupopup attribute to store reference to WDocActionPanel **/
	private static final String DOC_ACTION_PANEL_ATTRIBUTE = "doc-action-panel";
	/** Menupopup/Menuitem attribute to store reference to Button **/
	private static final String BUTTON_ATTRIBUTE = "button";
	/** Button yes/no attribute (Y/N) to store whether button is pressed **/
	public static final String BUTTON_ATTRIBUTE_PRESSED = "buttonPressed";

	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = 304878472233552113L;

	/**
	 * Render buttons as menu items.<br/>
	 * Special treatment for DocAction - render each available document action as a sub menu item.
	 * @param buttons
	 */
	public void render(List<Button> buttons) {
		this.setSclass("z-menu-noimage");
		
		//process button
		Button docActionBtn = null;
		for(Button button : buttons) {
			if (button.getPage() != null) {
				button.detach();
			}
			if ("DocAction".equals(button.getId())) {
				docActionBtn = button;				
				continue;
			}			
			Menuitem mi = new Menuitem(button.getLabel());
			appendChild(mi);
			mi.setAttribute(BUTTON_ATTRIBUTE, button);
			//
			String pressed = (String) button.getAttribute(BUTTON_ATTRIBUTE_PRESSED);
			if (!Util.isEmpty(pressed, true)) {
				if (pressed.trim().equalsIgnoreCase("Y")) {
					mi.setSclass("z-toolbarbutton-checked");
				} else {
					mi.removeSclass("z-toolbarbutton-checked");
				}
			}
			mi.addEventListener(Events.ON_CLICK, this);
			if (button.isDisabled())
				mi.setDisabled(true);
		}
		
		//document actions
		if (docActionBtn != null) {
			IProcessButton processButton = (IProcessButton) docActionBtn.getAttribute(WButtonEditor.EDITOR_ATTRIBUTE);
			WDocActionPanel actionPanel = new WDocActionPanel(processButton.getADTabpanel().getGridTab(), true);
			List<Listitem> actions = actionPanel.getDocActionItems();
			if (actions.size() > 0) {
				if (this.getChildren().size() > 0)
					appendChild(new Menuseparator());
				Menu menu = new Menu(Msg.getElement(Env.getCtx(), "DocAction"));
				if (docActionBtn.isDisabled())
					menu.setDisabled(true);
				appendChild(menu);
				Menupopup popup = new Menupopup();
				popup.setAttribute(BUTTON_ATTRIBUTE, docActionBtn);
				popup.setAttribute(DOC_ACTION_PANEL_ATTRIBUTE, actionPanel);
				popup.setSclass("z-menu-noimage");
				menu.appendChild(popup);
				menu.setSclass("z-menu-noimage");
				for(Listitem action : actions) {
					Menuitem mi = new Menuitem(action.getLabel());
					mi.setValue((String)action.getValue());
					mi.setSclass(DOCUMENT_ACTION_MENUITEM_SCLASS);
					mi.addEventListener(Events.ON_CLICK, this);
					popup.appendChild(mi);
				}
			}
		}
	}

	@Override
	public void onEvent(Event event) throws Exception {
		Menuitem mi = (Menuitem) event.getTarget();
		if (DOCUMENT_ACTION_MENUITEM_SCLASS.equals(mi.getSclass())) {
			final Button button = (Button) mi.getParent().getAttribute(BUTTON_ATTRIBUTE);
			WDocActionPanel panel = (WDocActionPanel) mi.getParent().getAttribute(DOC_ACTION_PANEL_ATTRIBUTE);
			panel.setSelectedItem(mi.getValue());
			panel.onOk(new Callback<Boolean>() {				
				@Override
				public void onCallback(Boolean result) {
					if (result) {
						IProcessButton pb = (IProcessButton) button.getAttribute(WButtonEditor.EDITOR_ATTRIBUTE);
						GridTab gridTab = pb.getADTabpanel().getGridTab();
						ADWindow adwindow = ADWindow.get(gridTab.getWindowNo());
						ADWindowContent windowContent = adwindow.getADWindowContent();
						
						final Callback<Boolean> postCallback = new Callback<Boolean>() {
							@Override
							public void onCallback(Boolean result) {
								if (result) {
									WindowValidatorEvent event = new WindowValidatorEvent(adwindow, WindowValidatorEventType.AFTER_DOC_ACTION.getName());
							    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(event, null);
								}
							}
						};
				    	Callback<Boolean> preCallback = new Callback<Boolean>() {
							@Override
							public void onCallback(Boolean result) {
								if (result) {
									windowContent.executeButtonProcess(pb, true, gridTab.getAD_Table_ID(), gridTab.getRecord_ID(), true, postCallback);
								}
							}
						};
						
						WindowValidatorEvent validatorEvent = new WindowValidatorEvent(adwindow, WindowValidatorEventType.BEFORE_DOC_ACTION.getName(), pb);
				    	WindowValidatorManager.getInstance().fireWindowValidatorEvent(validatorEvent, preCallback);				    							
					}
				}
			});
			
		} else {
			Button button = (Button) mi.getAttribute(BUTTON_ATTRIBUTE);
			Events.sendEvent(Events.ON_CLICK, button, null);
		}
	}
}