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
package org.adempiere.webui.apps.form;

import java.util.LinkedList;

import name.fraser.neil.plaintext.diff_match_patch;
import name.fraser.neil.plaintext.diff_match_patch.Diff;

import org.adempiere.webui.adwindow.ADWindow;
import org.adempiere.webui.component.Column;
import org.adempiere.webui.component.Columns;
import org.adempiere.webui.component.ConfirmPanel;
import org.adempiere.webui.component.Grid;
import org.adempiere.webui.component.Label;
import org.adempiere.webui.component.Row;
import org.adempiere.webui.component.Rows;
import org.adempiere.webui.panel.ADForm;
import org.adempiere.webui.session.SessionManager;
import org.compiere.model.GridTab;
import org.compiere.model.MField;
import org.compiere.util.Env;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Event;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zk.ui.event.InputEvent;
import org.zkoss.zul.Cell;
import org.zkoss.zul.Div;
import org.zkoss.zul.Html;
import org.zkoss.zul.Textbox;
import org.zkoss.zul.Timer;
import org.zkoss.zul.Vlayout;

/**
 * Form to compare suggested text from AD_FieldSuggestion with the original text from AD_Field.
 * @author hengsin
 */
@org.idempiere.ui.zk.annotation.Form
public class CompareFieldSuggestion extends ADForm {

	/** Timer attribute to store text value from Textbox onChanging event. */
	private static final String NEW_VALUE_ATTR = "newValue";
	
	/**
	 * generated serial id
	 */
	private static final long serialVersionUID = -100362034024824442L;
	/** Grid layout for content of form */
	private Grid grid;
	private ConfirmPanel confirmPanel;
	/** Cell to show diff between original and changed description */
	private Cell descriptionDiff;
	/** Cell to show diff between original and changed name */
	private Cell nameDiff;
	/** Cell to show diff between original and changed help */
	private Cell helpDiff;
	private Textbox nameTextbox;
	private Textbox descriptionTextbox;
	private Textbox helpTextbox;
	private MField field;
	/** AD Language from calling GridTab */
	private String AD_Language;
	private diff_match_patch diff;
	/** Timer to process onChanging text from {@link #nameTextbox} asynchronously */
	private Timer nameTimer;
	/** Timer to process onChanging text from {@link #descriptionTextbox} asynchronously */
	private Timer descriptionTimer;
	/** Timer to process onChanging text from {@link #helpTextbox} asynchronously */
	private Timer helpTimer;

	/**
	 * default constructor
	 */
	public CompareFieldSuggestion() {
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.panel.ADForm#initForm()
	 */
	@Override
	protected void initForm() {
		setWidth("70%");
		setHeight("500px");
		setSizable(true);
		Vlayout layout = new Vlayout();
		layout.setHflex("1");
		layout.setVflex("1");
		appendChild(layout);
		
		grid = new Grid();
		grid.setVflex(true);
		grid.setHflex("1");
		layout.appendChild(grid);
		
		Div div = new Div();
		div.setSclass("dialog-footer");
		confirmPanel = new ConfirmPanel(true);
		confirmPanel.setStyle("padding: 8px 16px;");
		confirmPanel.setHflex("1");
		confirmPanel.setVflex("min");
		div.appendChild(confirmPanel);
		layout.appendChild(div);
		confirmPanel.addActionListener(this);
		
		diff = new diff_match_patch();
		
		nameTimer = new Timer();
		nameTimer.setDelay(1000);
		nameTimer.setRepeats(false);
		appendChild(nameTimer);
		nameTimer.stop();
		nameTimer.addEventListener(Events.ON_TIMER, this);
		
		descriptionTimer = new Timer();
		descriptionTimer.setDelay(1000);
		descriptionTimer.setRepeats(false);
		appendChild(descriptionTimer);
		descriptionTimer.stop();
		descriptionTimer.addEventListener(Events.ON_TIMER, this);
		
		helpTimer = new Timer();
		helpTimer.setDelay(1000);
		helpTimer.setRepeats(false);		
		appendChild(helpTimer);
		helpTimer.stop();
		helpTimer.addEventListener(Events.ON_TIMER, this);
		
		renderGrid();
	}

	/**
	 * Render content grid.
	 */
	private void renderGrid() {
		Component c = SessionManager.getAppDesktop().getActiveWindow();
		ADWindow adwindow = ADWindow.findADWindow(c);
		GridTab gridTab = adwindow.getADWindowContent().getActiveGridTab();
		int AD_Field_ID = (Integer) gridTab.getValue("AD_Field_ID");
		field = new MField(Env.getCtx(), AD_Field_ID, null);
		AD_Language = (String) gridTab.getValue("AD_Language");		
		
		Columns columns = new Columns();
		grid.appendChild(columns);
		Column column = new Column();
		column.setWidth("100px");
		column.setLabel("");
		columns.appendChild(column);
		
		column = new Column();
		column.setLabel("Original Text");
		column.setValign("top");
		columns.appendChild(column);
		
		column = new Column();
		column.setLabel("Changed Text");
		column.setValign("top");
		columns.appendChild(column);
		
		column = new Column();
		column.setLabel("Difference");
		column.setValign("top");
		columns.appendChild(column);
		
		Rows rows = grid.newRows();
		Row row = rows.newRow();
		row.appendCellChild(new Label("Name"));
		
		String original = field.get_Translation("Name", AD_Language);
		row.appendCellChild(new Label(original));
		//suggested text from AD_FieldSuggestion
		String changed = (String) gridTab.getValue("Name");
		nameTextbox = new Textbox(changed);
		row.appendCellChild(nameTextbox);
		nameTextbox.addEventListener(Events.ON_CHANGE, this);
		nameTextbox.addEventListener(Events.ON_CHANGING, this);
		nameTextbox.setMaxlength(60);
		nameTextbox.setHflex("1");
		
		Html html = diff(original, changed);
		nameDiff = new Cell();
		nameDiff.appendChild(html);
		row.appendChild(nameDiff);
		
		row = rows.newRow();
		row.appendCellChild(new Label("Description"));
		
		original = field.get_Translation("Description", AD_Language);
		row.appendCellChild(new Label(original));
		//suggested text from AD_FieldSuggestion
		changed = (String) gridTab.getValue("Description");
		descriptionTextbox = new Textbox(changed);
		descriptionTextbox.setRows(4);		
		row.appendCellChild(descriptionTextbox);
		descriptionTextbox.addEventListener(Events.ON_CHANGE, this);
		descriptionTextbox.addEventListener(Events.ON_CHANGING, this);
		descriptionTextbox.setMaxlength(255);
		descriptionTextbox.setMultiline(true);
		descriptionTextbox.setHflex("1");
		
		html = diff(original, changed);
		descriptionDiff = new Cell();
		descriptionDiff.appendChild(html);
		row.appendChild(descriptionDiff);
		
		row = rows.newRow();
		row.appendCellChild(new Label("Help"));
		
		original = field.get_Translation("Help", AD_Language);
		row.appendCellChild(new Label(original));
		//suggested text from AD_FieldSuggestion
		changed = (String) gridTab.getValue("Help");
		helpTextbox = new Textbox(changed);
		helpTextbox.setRows(8);
		row.appendCellChild(helpTextbox);
		helpTextbox.addEventListener(Events.ON_CHANGE, this);
		helpTextbox.addEventListener(Events.ON_CHANGING, this);
		helpTextbox.setMaxlength(2000);
		helpTextbox.setMultiline(true);
		helpTextbox.setHflex("1");
		
		html = diff(original, changed);
		helpDiff = new Cell();
		helpDiff.appendChild(html);
		row.appendChild(helpDiff);
		
		this.addEventListener(Events.ON_OK, this);
	}

	/**
	 * @param original
	 * @param changed
	 * @return difference between original and changed
	 */
	private Html diff(String original, String changed) {
		if (original == null) original = "";
		if (changed == null) changed = "";
		LinkedList<Diff> diffs = diff.diff_main(original, changed);
		diff.diff_cleanupSemantic(diffs);
		Html html = new Html(diff.diff_prettyHtml(diffs));
		return html;
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.panel.ADForm#onEvent(org.zkoss.zk.ui.event.Event)
	 */
	@Override
	public void onEvent(Event event) throws Exception {
		if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_CANCEL)) {
			this.detach();
		} else if (event.getTarget() == confirmPanel.getButton(ConfirmPanel.A_OK)) {
			applyChanges();
			this.detach();
		} else if (event.getTarget() == nameTextbox) {	
			if (event.getName().equals(Events.ON_CHANGING)) {
				InputEvent inputEvent = (InputEvent) event;
				nameTimer.setAttribute(NEW_VALUE_ATTR, inputEvent.getValue());
				if (nameTimer.isRunning()) {
					return;
				} else {
					nameTimer.start();
				}
			} else {
				onNameChanged(nameTextbox.getText());
				if (nameTimer.isRunning())
					nameTimer.stop();
			}
		} else if (event.getTarget() == descriptionTextbox) {
			if (event.getName().equals(Events.ON_CHANGING)) {
				InputEvent inputEvent = (InputEvent) event;
				descriptionTimer.setAttribute(NEW_VALUE_ATTR, inputEvent.getValue());
				if (descriptionTimer.isRunning()) {
					return;
				} else {
					descriptionTimer.start();
				}
			} else {
				onDescriptionChanged(descriptionTextbox.getText());
				if (descriptionTimer.isRunning())
					descriptionTimer.stop();
			}
		} else if (event.getTarget() == helpTextbox) {
			if (event.getName().equals(Events.ON_CHANGING)) {
				InputEvent inputEvent = (InputEvent) event;
				helpTimer.setAttribute(NEW_VALUE_ATTR, inputEvent.getValue());
				if (helpTimer.isRunning()) {
					return;
				} else {
					helpTimer.start();
				}
			} else {
				onHelpChanged(helpTextbox.getText());
				if (helpTimer.isRunning())
					helpTimer.stop();
			}
		} else if (event.getTarget() == nameTimer) {
			onNameChanged((String) nameTimer.removeAttribute(NEW_VALUE_ATTR));
		} else if (event.getTarget() == descriptionTimer) {
			onDescriptionChanged((String) descriptionTimer.removeAttribute(NEW_VALUE_ATTR));
		} else if (event.getTarget() == helpTimer) {
			onHelpChanged((String) helpTimer.removeAttribute(NEW_VALUE_ATTR));
		} else {
			super.onEvent(event);
		}
	}

	/**
	 * Handle changes from {@link #helpTextbox}.
	 * @param text
	 */
	private void onHelpChanged(String text) {
		helpDiff.getChildren().clear();
		Html html = diff(field.get_Translation("Help", AD_Language), text);
		helpDiff.appendChild(html);
	}

	/**
	 * Handle changes from {@link #descriptionTextbox}.
	 * @param text
	 */
	private void onDescriptionChanged(String text) {
		descriptionDiff.getChildren().clear();
		Html html = diff(field.get_Translation("Description", AD_Language), text);
		descriptionDiff.appendChild(html);
	}

	/**
	 * Handle changes from {@link #nameTextbox}.
	 * @param text
	 */
	private void onNameChanged(String text) {
		nameDiff.getChildren().clear();
		Html html = diff(field.get_Translation("Name", AD_Language), text);
		nameDiff.appendChild(html);
	}

	/**
	 * Apply changes to calling GridTab (AD_FieldSuggestion).
	 */
	private void applyChanges() {
		Component c = SessionManager.getAppDesktop().getActiveWindow();
		ADWindow adwindow = ADWindow.findADWindow(c);
		GridTab gridTab = adwindow.getADWindowContent().getActiveGridTab();
		String name = nameTextbox.getText();
		gridTab.setValue("Name", name);
		String description = descriptionTextbox.getText();
		gridTab.setValue("Description", description);
		String help = helpTextbox.getText();
		gridTab.setValue("Help", help);
		gridTab.dataSave(false);
	}

	/* (non-Javadoc)
	 * @see org.adempiere.webui.panel.ADForm#getWindowMode()
	 */
	@Override
	public Mode getWindowMode() {
		return Mode.HIGHLIGHTED;
	}

}
