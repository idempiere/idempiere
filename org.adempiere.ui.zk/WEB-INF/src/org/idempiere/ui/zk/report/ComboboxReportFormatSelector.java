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
 **********************************************************************/
package org.idempiere.ui.zk.report;

import java.util.List;

import org.adempiere.webui.component.Combobox;
import org.compiere.util.Env;
import org.compiere.util.Msg;
import org.zkoss.zk.ui.Component;
import org.zkoss.zk.ui.event.Events;
import org.zkoss.zul.Comboitem;

/**
 * Default report format selector, a combo box of the print format names.
 */
public class ComboboxReportFormatSelector implements IReportFormatSelector {

	private final Combobox combobox = new Combobox();
	private Runnable selectionListener;
	private int selectedKey = ReportFormatEntry.KEY_NONE;

	/**
	 * Create the combo box
	 */
	public ComboboxReportFormatSelector() {
		combobox.setAutocomplete(true);
		combobox.setAutodrop(true);
		combobox.setTooltiptext(Msg.translate(Env.getCtx(), "AD_PrintFormat_ID"));
		combobox.addEventListener(Events.ON_SELECT, event -> {
			Comboitem item = combobox.getSelectedItem();
			if (item != null && item.getValue() != null)
				selectedKey = (Integer) item.getValue();
			if (selectionListener != null)
				selectionListener.run();
		});
		combobox.addEventListener(Events.ON_CHANGE, event -> onTextChanged());
	}

	/**
	 * The user typed a text. Select the print format with that name, or put back the current selection
	 * if there is none, so the box never shows a name the viewer is not displaying.
	 * Does nothing if the text is the name of the selected item, for example after the item was picked from
	 * the list. That is reported by the select event, and notifying here as well would reload the report twice.
	 */
	private void onTextChanged() {
		String trimmed = combobox.getValue() != null ? combobox.getValue().trim() : "";
		Comboitem currentSelected = combobox.getSelectedItem();
		// checked first, the name is not unique: a system and a tenant print format can share it
		if (currentSelected != null && currentSelected.getValue() != null
				&& currentSelected.getLabel().equalsIgnoreCase(trimmed))
			return;
		Comboitem match = null;
		for (Comboitem item : combobox.getItems()) {
			if (item.getValue() != null && item.getLabel().equalsIgnoreCase(trimmed)) {
				match = item;
				break;
			}
		}
		if (match == null) {
			setSelectedKey(selectedKey);
		} else {
			combobox.setSelectedItem(match);
			selectedKey = (Integer) match.getValue();
			if (selectionListener != null)
				selectionListener.run();
		}
	}

	@Override
	public Component getComponent() {
		return combobox;
	}

	@Override
	public void setFormats(List<ReportFormatEntry> entries, int selectedKey) {
		combobox.removeAllItems();
		for (ReportFormatEntry entry : entries)
			combobox.appendItem(entry.name(), entry.key());
		setSelectedKey(selectedKey);
	}

	@Override
	public int getSelectedKey() {
		return selectedKey;
	}

	@Override
	public void setSelectedKey(int key) {
		Comboitem selected = null;
		for (Comboitem item : combobox.getItems()) {
			if (item.getValue() != null && ((Integer) item.getValue()).intValue() == key) {
				selected = item;
				break;
			}
		}
		combobox.setSelectedItem(selected);
		selectedKey = selected != null ? (Integer) selected.getValue() : ReportFormatEntry.KEY_NONE;
		// setSelectedItem does not reset the text when the item is already selected
		combobox.setValue(selected != null ? selected.getLabel() : "");
	}

	@Override
	public void setSelectionListener(Runnable listener) {
		selectionListener = listener;
	}
}
